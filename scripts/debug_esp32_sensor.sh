#!/bin/bash
set -e  # 오류 발생 시 중단

PROJECT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
ESP_SENSOR_DIR="${PROJECT_DIR}/esp32_sensor_ecu"

echo "📡 [1/1] ESP32 센서 ECU 시리얼 모니터 시작..."
cd ${ESP_SENSOR_DIR}
idf.py monitor
