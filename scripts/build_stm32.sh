#!/bin/bash
set -e  # 오류 발생 시 중단

PROJECT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
BUILD_DIR="${PROJECT_DIR}/stm32_vcu_drive_ecu/Build"

# 기존 Build 폴더가 있다면 삭제
if [ -d "$BUILD_DIR" ]; then
    echo "🗑️  기존 빌드 폴더 삭제 중..."
    rm -rf "$BUILD_DIR"
fi

echo "📦 [1/3] STM32 프로젝트 빌드 시작..."
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

cmake ..
echo "🔨 [2/3] 컴파일 진행 중..."
make -j$(nproc)

echo "✅ [3/3] 빌드 완료! (${BUILD_DIR}/stm32_project.elf)"
cd ${PROJECT_DIR}
