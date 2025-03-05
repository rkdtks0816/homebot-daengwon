#!/bin/bash
set -e  # 오류 발생 시 중단

PROJECT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
BUILD_DIR="${PROJECT_DIR}/stm32_vcu_drive_ecu/Build"

ELF_FILE="${BUILD_DIR}/stm32_project.elf"
BIN_FILE="${BUILD_DIR}/stm32_project.bin"

# ELF 파일이 존재하는지 확인
if [ ! -f "$ELF_FILE" ]; then
    echo "❌ [ERROR] ELF 파일이 존재하지 않습니다: $ELF_FILE"
    exit 1
fi

echo "🚀 [1/2] ELF → BIN 변환 중..."
arm-none-eabi-objcopy -O binary "$ELF_FILE" "$BIN_FILE"

echo "🚀 [2/2] STM32 보드에 펌웨어 플래싱 중..."
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "program $BIN_FILE 0x08000000 verify reset exit"

echo "✅ 플래싱 완료!"
