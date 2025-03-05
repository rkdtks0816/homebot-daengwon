#!/bin/bash
set -e  # 오류 발생 시 중단

BUILD_DIR="$(dirname "$(dirname "$(realpath "$0")")")/stm32_vcu_drive_ecu/Build"
ELF_FILE="${BUILD_DIR}/my_project.elf"

if [ ! -f "$ELF_FILE" ]; then
    echo "❌ 오류: ELF 파일을 찾을 수 없습니다. 먼저 빌드를 수행하세요!"
    exit 1
fi

echo "🚀 [1/1] STM32 보드에 펌웨어 플래싱 중..."
st-flash write ${ELF_FILE} 0x08000000

echo "✅ 플래싱 완료!"
