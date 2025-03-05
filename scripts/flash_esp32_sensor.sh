#!/bin/bash
set -e  # 오류 발생 시 중단

PROJECT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
ESP_SENSOR_DIR="${PROJECT_DIR}/esp32_sensor_ecu"

echo "🚀 [1/1] ESP32 센서 ECU 플래싱 중..."
cd ${ESP_SENSOR_DIR}
idf.py flash

echo "✅ 플래싱 완료!"
