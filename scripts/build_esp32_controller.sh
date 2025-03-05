#!/bin/bash
set -e  # 오류 발생 시 중단

PROJECT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
ESP_CONTROLLER_DIR="${PROJECT_DIR}/esp32_controller_ecu"

echo "📦 [1/1] ESP32 컨트롤러 ECU 빌드 중..."
cd ${ESP_CONTROLLER_DIR}
idf.py build

echo "✅ 빌드 완료!"
