################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../startup_stm32f407vgtx.s 

C_SRCS += \
../main.c \
../syscalls.c \
../sysmem.c 

OBJS += \
./main.o \
./startup_stm32f407vgtx.o \
./syscalls.o \
./sysmem.o 

S_DEPS += \
./startup_stm32f407vgtx.d 

C_DEPS += \
./main.d \
./syscalls.d \
./sysmem.d 


# Each subdirectory must supply rules for building sources it contributes
%.o %.su %.cyclo: ../%.c subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DSTM32 -DSTM32F4 -DSTM32F407VGTx -c -I../Inc -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
%.o: ../%.s subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean--2e-

clean--2e-:
	-$(RM) ./main.cyclo ./main.d ./main.o ./main.su ./startup_stm32f407vgtx.d ./startup_stm32f407vgtx.o ./syscalls.cyclo ./syscalls.d ./syscalls.o ./syscalls.su ./sysmem.cyclo ./sysmem.d ./sysmem.o ./sysmem.su

.PHONY: clean--2e-

