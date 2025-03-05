cmake_minimum_required(VERSION 3.10)

# 프로젝트 설정
project(STM32_BareMetal C ASM)

# CPU 및 컴파일러 설정
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# 툴체인 설정 (GCC ARM)
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)

# 빌드 타입 설정
set(CMAKE_BUILD_TYPE Release)

# 링커 스크립트 설정 (파일 경로 확인)
set(STM32F4_LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/linker.ld)
if(NOT EXISTS ${STM32F4_LINKER_SCRIPT})
    message(FATAL_ERROR "링커 스크립트가 존재하지 않습니다: ${STM32F4_LINKER_SCRIPT}")
endif()

# 소스 파일 추가
file(GLOB SRC_FILES
    ${CMAKE_SOURCE_DIR}/Core/*.c
    ${CMAKE_SOURCE_DIR}/Core/*.s
)

# 실행 파일 생성
add_executable(stm32_project.elf ${SRC_FILES})

# 링커 스크립트 적용 (강제 설정)
target_link_options(stm32_project.elf PRIVATE
    -T${STM32F4_LINKER_SCRIPT}
    -Wl,-Map=output.map
    -Wl,--gc-sections
    -nostartfiles
    -ffreestanding
    -Wl,--oformat=elf32-littlearm
)

# 최적화 및 컴파일 옵션
target_compile_options(stm32_project.elf PRIVATE
    -mcpu=cortex-m4
    -mthumb
    -Wall
    -O2
)

# 인클루드 디렉토리 추가
target_include_directories(stm32_project.elf PRIVATE
    ${CMAKE_SOURCE_DIR}/Core
)
