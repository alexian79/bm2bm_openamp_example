################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/drivers/linux_remoteproc.c \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynq_remoteproc_a9.c \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynqmp_remoteproc_a53.c \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynqmp_remoteproc_r5.c 

S_UPPER_SRCS += \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynq_a9_trampoline.S 

OBJS += \
./openamp_v1_31/src/open-amp/lib/remoteproc/drivers/linux_remoteproc.o \
./openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynq_a9_trampoline.o \
./openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynq_remoteproc_a9.o \
./openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynqmp_remoteproc_a53.o \
./openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynqmp_remoteproc_r5.o 

S_UPPER_DEPS += \
./openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynq_a9_trampoline.d 

C_DEPS += \
./openamp_v1_31/src/open-amp/lib/remoteproc/drivers/linux_remoteproc.d \
./openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynq_remoteproc_a9.d \
./openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynqmp_remoteproc_a53.d \
./openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynqmp_remoteproc_r5.d 


# Each subdirectory must supply rules for building sources it contributes
openamp_v1_31/src/open-amp/lib/remoteproc/drivers/linux_remoteproc.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/drivers/linux_remoteproc.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynq_a9_trampoline.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynq_a9_trampoline.S
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynq_remoteproc_a9.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynq_remoteproc_a9.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynqmp_remoteproc_a53.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynqmp_remoteproc_a53.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynqmp_remoteproc_r5.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/drivers/zynqmp_remoteproc_r5.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


