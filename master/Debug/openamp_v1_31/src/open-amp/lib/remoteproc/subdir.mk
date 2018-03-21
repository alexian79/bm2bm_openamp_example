################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/elf_loader.c \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/remoteproc.c \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/remoteproc_loader.c \
G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/rsc_table_parser.c 

OBJS += \
./openamp_v1_31/src/open-amp/lib/remoteproc/elf_loader.o \
./openamp_v1_31/src/open-amp/lib/remoteproc/remoteproc.o \
./openamp_v1_31/src/open-amp/lib/remoteproc/remoteproc_loader.o \
./openamp_v1_31/src/open-amp/lib/remoteproc/rsc_table_parser.o 

C_DEPS += \
./openamp_v1_31/src/open-amp/lib/remoteproc/elf_loader.d \
./openamp_v1_31/src/open-amp/lib/remoteproc/remoteproc.d \
./openamp_v1_31/src/open-amp/lib/remoteproc/remoteproc_loader.d \
./openamp_v1_31/src/open-amp/lib/remoteproc/rsc_table_parser.d 


# Each subdirectory must supply rules for building sources it contributes
openamp_v1_31/src/open-amp/lib/remoteproc/elf_loader.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/elf_loader.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

openamp_v1_31/src/open-amp/lib/remoteproc/remoteproc.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/remoteproc.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

openamp_v1_31/src/open-amp/lib/remoteproc/remoteproc_loader.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/remoteproc_loader.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

openamp_v1_31/src/open-amp/lib/remoteproc/rsc_table_parser.o: G:/projects_ext/validation_study/openamp/openamp.sdk/openamp_v1_31/src/open-amp/lib/remoteproc/rsc_table_parser.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -D__STDC_NO_ATOMICS__ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../master_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


