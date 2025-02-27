cmake_minimum_required(VERSION 3.13)
project(STM32_BareMetal C ASM)

# ARM GCC Toolchain 설정
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)

# 디버그 빌드 활성화
set(CMAKE_BUILD_TYPE Debug)

# CPU 및 컴파일러 플래그 설정
set(CPU_FLAGS "-mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard")

# 디버그 플래그 추가
set(CMAKE_C_FLAGS_DEBUG "${CPU_FLAGS} -g3 -ggdb -O0 -Wall -Wextra -DSTM32F407xx" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_RELEASE "${CPU_FLAGS} -O2 -Wall -Wextra -DSTM32F407xx" CACHE STRING "" FORCE)

# CMSIS 헤더 파일 포함 (HAL 없음)
include_directories(
    ${CMAKE_SOURCE_DIR}/cmsis_device_f4/Include
    ${CMAKE_SOURCE_DIR}/CMSIS_5/CMSIS/Core/Include   # CMSIS-Core 포함
)

# 실행 파일 추가
add_executable(my_project
    ${CMAKE_SOURCE_DIR}/main.c
    ${CMAKE_SOURCE_DIR}/cmsis_device_f4/Source/Templates/system_stm32f4xx.c
)

# 링커 스크립트 설정
set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/linker.ld)

# 링커 플래그에서 --gc-sections 삭제하여 디버깅 심볼 제거하지 않도록 함
set(CMAKE_EXE_LINKER_FLAGS "-T${LINKER_SCRIPT} -nostartfiles -nodefaultlibs -nostdlib" CACHE STRING "" FORCE)

# ELF 확장자 지정 (선택 사항)
set_target_properties(my_project PROPERTIES OUTPUT_NAME "my_project.elf")
