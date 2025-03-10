cmake_minimum_required(VERSION 3.16)
project(STM32F4_VCU C ASM)

# ARM Cross Compiler 설정
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)

# MCU 옵션 설정
set(MCU_FLAGS "-mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Wall -g -nostartfiles -specs=nano.specs")
set(LINKER_SCRIPT "${CMAKE_SOURCE_DIR}/linker/STM32F407VGTX_FLASH.ld")

# 빌드 플래그
set(CMAKE_C_FLAGS "${MCU_FLAGS} -ffunction-sections -fdata-sections -Wl,--gc-sections")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_C_FLAGS} -T ${LINKER_SCRIPT}")

# Include 디렉토리 추가
include_directories(
    Core/Inc
    MCAL
    BSW
    RTE
    APP
    Drivers
    Drivers/CMSIS/Include
    Drivers/CMSIS/Device/ST/STM32F4xx/Include
    Drivers/STM32F4xx_HAL_Driver/Inc
    Middlewares/FreeRTOS/include
    Middlewares/FreeRTOS/portable/GCC/ARM_CM4F
)

# 소스 코드 추가
add_executable(stm32_vcu_drive_ecu
    # Core
    Core/Src/main.c
    Core/Inc
    Core/Inc/stm32f4xx_hal_conf.h
    # Core/Src/can_manager.c
    # Core/Src/motor_control.c
    # Core/Src/servo_control.c
    # Core/Src/sensors.c
    
    # # MCAL (Microcontroller Abstraction Layer)
    # MCAL/pwm_driver.c
    # MCAL/can_driver.c
    # MCAL/gpio_driver.c

    # # BSW (Basic Software)
    # BSW/can_service.c
    # BSW/motor_service.c

    # # RTE (Runtime Environment)
    # RTE/rte_interface.c

    # # APP (Application Layer)
    # APP/vehicle_control.c
    # APP/obstacle_avoidance.c

    # HAL (Hardware Abstraction Layer)
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_uart.c
    Drivers/STM32F4xx_HAL_Driver/Inc

    # FreeRTOS Kernel
    Middlewares/FreeRTOS/Source/event_groups.c
    Middlewares/FreeRTOS/Source/list.c
    Middlewares/FreeRTOS/Source/queue.c
    Middlewares/FreeRTOS/Source/tasks.c
    Middlewares/FreeRTOS/Source/timers.c

    # FreeRTOS 포팅 및 Heap 관리
    Middlewares/FreeRTOS/portable/GCC/ARM_CM4F/port.c
    Middlewares/FreeRTOS/portable/MemMang/heap_4.c
    Middlewares/FreeRTOS/include

    # 스타트업 코드
    startup/startup_stm32f407vgtx.s
)

# 링커 추가
target_link_libraries(stm32_vcu_drive_ecu m c nosys)
