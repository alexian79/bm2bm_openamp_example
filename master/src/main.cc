/*
 * Empty C++ Application
 */

extern "C" {
#include "metal/atomic.h"
#include "openamp/open_amp.h"
#include "openamp/hil.h"
#include "metal/irq.h"
#include "openamp/rpmsg_retarget.h"
}
//#include "openamp/rpmsg.h"
//#include "baremetal.h"
#include "xtime_l.h"

extern "C" const struct firmware_info fw_table[] =
{
	{"slave_echo",
	 0x10000000,
	 631948},
	{"slave_rpc",
	0x10000000,
	 691292}
};

extern "C" const int fw_table_size = sizeof(fw_table)/sizeof(struct firmware_info);

static void rpmsg_channel_created(struct rpmsg_channel *rp_chnl);
static void rpmsg_channel_deleted(struct rpmsg_channel *rp_chnl);
static void rpmsg_read_cb(struct rpmsg_channel *, void *, int, void *,
			  unsigned long);

static void rpc_rpmsg_read_cb(struct rpmsg_channel *, void *, int, void *,
			  unsigned long);

static struct rpmsg_channel *app_rp_chnl = 0;
static struct rpmsg_endpoint *rp_ept = 0;
static struct rpmsg_endpoint *rp_ept_rpc = 0;
static int shutdown_called = 0;

#define SHUTDOWN_MSG	0xEF56A55A

#define APU_CPU_ID 1
#define VRING0_IPI_INTR_VECT              15
#define VRING1_IPI_INTR_VECT              14

#define RPMSG_CHAN_NAME         "rpmsg-openamp-demo-channel"
extern "C" struct hil_platform_ops zynq_a9_proc_ops;
struct hil_proc *platform_create_proc(int proc_index)
{
	(void) proc_index;
	struct hil_proc *proc;
	proc = hil_create_proc(&zynq_a9_proc_ops, APU_CPU_ID, NULL);
	if (!proc)
		return NULL;
	hil_set_vdev_ipi(proc, 0, 0, NULL);
	hil_set_vdev(proc, NULL, NULL);
	hil_set_vring_ipi(proc, 0, VRING0_IPI_INTR_VECT, NULL);
	hil_set_vring_ipi(proc, 1, VRING1_IPI_INTR_VECT, NULL);
	//{RSC_RPROC_MEM, 0x200000, 0x200000, 0x100000, 0},
	hil_set_shm (proc, 0, 0, 0x200000, 0x100000);
	proc->sh_buff.start_addr = (void*)0x200000;
	hil_set_rpmsg_channel(proc, 0, RPMSG_CHAN_NAME);
	return proc;
}

void sleep()
{
	volatile int i;
	for (i = 0; i < 100000; i++) ;
}

extern int init_system(void);

extern void cleanup_system();

extern XScuGic xInterruptController;

static int chnl_is_alive = 0;

static void shutdown_cb(struct rpmsg_channel *rp_chnl)
{
	(void)rp_chnl;
	chnl_is_alive = 0;
}

extern int rpmsg_host_retarget_init(struct rpmsg_channel *rp_chnl, rpc_shutdown_cb cb);

static int received;
int main()
{
	int shutdown_msg = SHUTDOWN_MSG;
	init_system();
	printf("Hello from CPU0\n");

	//XScuGic_SetPriorityTriggerType(&xInterruptController, VRING0_IPI_INTR_VECT, 0xA0, 0x3);
	//XScuGic_InterruptMaptoCpu(&xInterruptController, XSCUGIC_SPI_CPU0_MASK, VRING0_IPI_INTR_VECT);
	//XScuGic_Enable(&xInterruptController, VRING0_IPI_INTR_VECT);
	//Xil_ExceptionEnableMask(XIL_EXCEPTION_IRQ);
	//metal_irq_enable(VRING0_IPI_INTR_VECT);
	//XScuGic_SoftwareIntr(&xInterruptController, VRING0_IPI_INTR_VECT, XSCUGIC_SPI_CPU0_MASK);
	int status;
	struct remote_proc *proc;
#ifdef ECHO_TEST
	char* fw_name = "slave_echo";
#else
	char* fw_name = "slave_rpc";
#endif
	hil_proc* hproc = platform_create_proc(1);
	status =
		    remoteproc_init(fw_name, hproc, rpmsg_channel_created,
				    rpmsg_channel_deleted, rpmsg_read_cb, &proc);
	if (!status) {
		status = remoteproc_boot(proc);
	}
	else
	{
		asm("nop");
	}

	//virtqueue_enable_cb(proc->rdev->rvq);

	while(!app_rp_chnl)
	{
		hil_poll(proc->proc, 1);
	}
#ifdef ECHO_TEST
	static int msg = 0;
    XTime tEnd, tStart;
    XTime_GetTime(&tStart);
    received = 0;
	rpmsg_send(app_rp_chnl, &msg, sizeof(msg));
	while(!received) hil_poll(proc->proc, 0);
	XTime_GetTime(&tEnd);
	volatile double duration = (double)(tEnd - tStart)/COUNTS_PER_SECOND;
	duration = duration;

	/*while (!shutdown_called) {
		static int msg = 0;
		hil_poll(proc->proc, 1);
		if (0 == rpmsg_send(app_rp_chnl, &msg, sizeof(int))) msg++;
	}*/

	/* Send shutdown message to remote */
#else
	chnl_is_alive = 1;
	rpmsg_host_retarget_init(app_rp_chnl, shutdown_cb);
	while(chnl_is_alive)
	{
		hil_poll(proc->proc, 1);
	};
#endif

	rpmsg_send(app_rp_chnl, &shutdown_msg, sizeof(int));

	for (int i = 0; i < 100000; i++) {
		sleep();
	}

	remoteproc_shutdown(proc);

	remoteproc_deinit(proc);

	cleanup_system();
	return 0;
}

static void rpmsg_channel_created(struct rpmsg_channel *rp_chnl)
{
	app_rp_chnl = rp_chnl;
#ifdef ECHO_TEST
	rp_ept = rpmsg_create_ept(rp_chnl, rpmsg_read_cb, RPMSG_NULL,
				  RPMSG_ADDR_ANY);
	rp_ept_rpc = rpmsg_create_ept(rp_chnl, rpc_rpmsg_read_cb, RPMSG_NULL,
			PROXY_ENDPOINT);
#endif
}

static void rpmsg_channel_deleted(struct rpmsg_channel *rp_chnl)
{
	rpmsg_destroy_ept(rp_ept);

}

static void rpmsg_read_cb(struct rpmsg_channel *rp_chnl, void *data, int len,
			  void *priv, unsigned long src)
{

	if ((*(int *)data) == SHUTDOWN_MSG) {
		shutdown_called = 1;
	} else {
		/* Send data back to master */
		//rpmsg_send(rp_chnl, data, len);
	}
	received = 1;
}

static void rpc_rpmsg_read_cb(struct rpmsg_channel *rp_chnl, void *data, int len,
			  void *priv, unsigned long src)
{
	asm("nop");
}
