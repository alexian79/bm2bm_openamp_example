/*
 * retarget_host.cc
 *
 *  Created on: Aug 5, 2017
 *      Author: alexian79
 */
extern "C"
{
#include "openamp/open_amp.h"
#include "openamp/rpmsg_retarget.h"
#include "metal/alloc.h"
}
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#define RPC_CHANNEL_READY_TO_CLOSE "rpc_channel_ready_to_close"

static struct _rpc_data *rpc_data = 0;

int handle_rpc(struct _sys_rpc *rpc);


void rpc_cb(struct rpmsg_channel *rtl_rp_chnl, void *data, int len, void *priv,
	    unsigned long src)
{
	(void)priv;
	(void)src;

	//memcpy(rpc_data->rpc, data, len);

	//atomic_flag_clear(&rpc_data->sync);
	//if (rpc_data->rpc->id == TERM_SYSCALL_ID) {
		/* Application terminate signal is received from the proxy app,
		 * so let the application know of terminate message.
		 */
		//rpc_data->shutdown_cb(rtl_rp_chnl);
	//}
	if (data && len) handle_rpc((_sys_rpc*)data);
}

int rpmsg_host_retarget_init(struct rpmsg_channel *rp_chnl, rpc_shutdown_cb cb)
{
	/* Allocate memory for rpc control block */
	rpc_data = (struct _rpc_data *)metal_allocate_memory(sizeof(struct _rpc_data));

	/* Create a mutex for synchronization */
	metal_mutex_init(&rpc_data->rpc_lock);

	/* Create a mutex for synchronization */
	atomic_store(&rpc_data->sync, 1);

	/* Create a endpoint to handle rpc response from master */
	rpc_data->rpmsg_chnl = rp_chnl;
	rpc_data->rp_ept = rpmsg_create_ept(rpc_data->rpmsg_chnl, rpc_cb,
					    RPMSG_NULL, PROXY_ENDPOINT);
	rpc_data->rpc = (_sys_rpc*)metal_allocate_memory(RPC_BUFF_SIZE);
	rpc_data->rpc_response = (_sys_rpc*)metal_allocate_memory(RPC_BUFF_SIZE);
	rpc_data->shutdown_cb = cb;

	return 0;
}

int rpmsg_host_retarget_deinit(struct rpmsg_channel *rp_chnl)
{
	(void)rp_chnl;

	metal_free_memory(rpc_data->rpc);
	metal_free_memory(rpc_data->rpc_response);
	metal_mutex_deinit(&rpc_data->rpc_lock);
	rpmsg_destroy_ept(rpc_data->rp_ept);
	metal_free_memory(rpc_data);
	rpc_data = NULL;

	return 0;
}

int send_rpc(void *data, int len)
{
	int retval;

	retval = rpmsg_sendto(rpc_data->rpmsg_chnl, data, len, PROXY_ENDPOINT);
	return retval;
}

int handle_open(struct _sys_rpc *rpc)
{
	int fd;

	/* Open remote fd */
	fd = open(rpc->sys_call_args.data, rpc->sys_call_args.int_field1,
			rpc->sys_call_args.int_field2);

	/* Construct rpc response */
	rpc_data->rpc_response->id = OPEN_SYSCALL_ID;
	rpc_data->rpc_response->sys_call_args.int_field1 = fd;
	rpc_data->rpc_response->sys_call_args.int_field2 = 0; /*not used*/
	rpc_data->rpc_response->sys_call_args.data_len = 0; /*not used*/

	return send_rpc((void *)rpc_data->rpc_response, sizeof(struct _sys_rpc));
}

int handle_close(struct _sys_rpc *rpc)
{
	int retval;

	/* Close remote fd */
	retval = close(rpc->sys_call_args.int_field1);

	/* Construct rpc response */
	rpc_data->rpc_response->id = CLOSE_SYSCALL_ID;
	rpc_data->rpc_response->sys_call_args.int_field1 = retval;
	rpc_data->rpc_response->sys_call_args.int_field2 = 0; /*not used*/
	rpc_data->rpc_response->sys_call_args.data_len = 0; /*not used*/

	/* Transmit rpc response */
	return send_rpc((void *)rpc_data->rpc_response, sizeof(struct _sys_rpc));

}

int handle_read(struct _sys_rpc *rpc)
{
	ssize_t bytes_read;
	size_t  payload_size;
	char *buff;

	/* Allocate buffer for requested data size */
	buff = (char*)malloc(rpc->sys_call_args.int_field2);

	if (rpc->sys_call_args.int_field1 == 0)
		/* Perform read from fd for large size since this is a
		STD/I request */
		bytes_read = read(rpc->sys_call_args.int_field1, buff, 512);
	else
		/* Perform read from fd */
		bytes_read = read(rpc->sys_call_args.int_field1, buff,
					rpc->sys_call_args.int_field2);

	/* Construct rpc response */
	rpc_data->rpc_response->id = READ_SYSCALL_ID;
	rpc_data->rpc_response->sys_call_args.int_field1 = bytes_read;
	rpc_data->rpc_response->sys_call_args.int_field2 = 0; /* not used */
	rpc_data->rpc_response->sys_call_args.data_len = bytes_read;
	if (bytes_read > 0)
		memcpy(rpc_data->rpc_response->sys_call_args.data, buff,
			bytes_read);

	payload_size = sizeof(struct _sys_rpc) +
			((bytes_read > 0) ? bytes_read : 0);

	/* Transmit rpc response */
	return send_rpc((void *)rpc_data->rpc_response, payload_size);
}

int handle_write(struct _sys_rpc *rpc)
{
	ssize_t bytes_written;

	/* Write to remote fd */
	bytes_written = write(rpc->sys_call_args.int_field1,
				rpc->sys_call_args.data,
				rpc->sys_call_args.int_field2);

	/* Construct rpc response */
	rpc_data->rpc_response->id = WRITE_SYSCALL_ID;
	rpc_data->rpc_response->sys_call_args.int_field1 = bytes_written;
	rpc_data->rpc_response->sys_call_args.int_field2 = 0; /*not used*/
	rpc_data->rpc_response->sys_call_args.data_len = 0; /*not used*/

	/* Transmit rpc response */
	return send_rpc((void *)rpc_data->rpc_response, sizeof(struct _sys_rpc));
}

int handle_rpc(struct _sys_rpc *rpc)
{
	int retval;
	char *data = (char *)rpc;
	if (!strcmp(data, RPC_CHANNEL_READY_TO_CLOSE)) {
		//proxy->active = 0;
		return 0;
	}

	/* Handle RPC */
	switch ((int)(rpc->id)) {
	case OPEN_SYSCALL_ID:
	{
		retval = handle_open(rpc);
		break;
	}
	case CLOSE_SYSCALL_ID:
	{
		retval = handle_close(rpc);
		break;
	}
	case READ_SYSCALL_ID:
	{
		retval = handle_read(rpc);
		break;
	}
	case WRITE_SYSCALL_ID:
	{
		retval = handle_write(rpc);
		break;
	}
	default:
	{
		printf("\r\nMaster>Err:Invalid RPC sys call ID: %d:%d! \r\n", rpc->id,WRITE_SYSCALL_ID);
		retval = -1;
		break;
	}
	}

	return retval;
}
