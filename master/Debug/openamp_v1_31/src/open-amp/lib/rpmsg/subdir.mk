################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/rpmsg/remote_device.c \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/rpmsg/rpmsg.c \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/rpmsg/rpmsg_core.c 

OBJS += \
./openamp_v1_31/src/open-amp/lib/rpmsg/remote_device.o \
./openamp_v1_31/src/open-amp/lib/rpmsg/rpmsg.o \
./openamp_v1_31/src/open-amp/lib/rpmsg/rpmsg_core.o 

C_DEPS += \
./openamp_v1_31/src/open-amp/lib/rpmsg/remote_device.d \
./openamp_v1_31/src/open-amp/lib/rpmsg/rpmsg.d \
./openamp_v1_31/src/open-amp/lib/rpmsg/rpmsg_core.d 


# Each subdirectory must supply rules for building sources it contributes
openamp_v1_31/src/open-amp/lib/rpmsg/remote_device.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/rpmsg/remote_device.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

openamp_v1_31/src/open-amp/lib/rpmsg/rpmsg.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/rpmsg/rpmsg.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

openamp_v1_31/src/open-amp/lib/rpmsg/rpmsg_core.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/rpmsg/rpmsg_core.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


