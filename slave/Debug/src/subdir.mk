################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/helper.c \
../src/platform_info.c \
../src/rpc_demo.c \
../src/rsc_table.c 

OBJS += \
./src/helper.o \
./src/platform_info.o \
./src/rpc_demo.o \
./src/rsc_table.o 

C_DEPS += \
./src/helper.d \
./src/platform_info.d \
./src/rpc_demo.d \
./src/rsc_table.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../slave_bsp/ps7_cortexa9_1/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


