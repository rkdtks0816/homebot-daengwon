#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include "driver/twai.h"  // ESP-IDF CAN(TWAI) 드라이버

#define VIBRATION_SENSOR_PIN GPIO_NUM_18  // SW-420 진동 센서
#define CAN_TX_PIN GPIO_NUM_21  // CAN 트랜시버 TX
#define CAN_RX_PIN GPIO_NUM_22  // CAN 트랜시버 RX

// CAN 초기화 함수
void can_init() {
    twai_general_config_t g_config = TWAI_GENERAL_CONFIG_DEFAULT(CAN_TX_PIN, CAN_RX_PIN, TWAI_MODE_NORMAL);
    twai_timing_config_t t_config = TWAI_TIMING_CONFIG_500KBITS(); // 500kbps CAN 속도 설정
    twai_filter_config_t f_config = TWAI_FILTER_CONFIG_ACCEPT_ALL(); // 모든 CAN 메시지 수락

    if (twai_driver_install(&g_config, &t_config, &f_config) != ESP_OK) {
        printf("🚨 CAN 드라이버 설치 실패!\n");
        return;
    }
    if (twai_start() != ESP_OK) {
        printf("🚨 CAN 시작 실패!\n");
        return;
    }
    printf("✅ CAN 통신 초기화 완료!\n");
}

// 진동 센서 데이터 수집 및 CAN 송신
void vibration_sensor_task(void *pvParameters) {
    while (1) {
        int sensor_value = gpio_get_level(VIBRATION_SENSOR_PIN);
        printf("📡 진동 센서 상태: %s\n", sensor_value ? "진동 감지됨 (HIGH)" : "진동 없음 (LOW)");

        // CAN 메시지 구성
        twai_message_t message;
        message.identifier = 0x100;  // 메시지 ID 설정
        message.extd = 0;  // 표준 프레임 사용
        message.rtr = 0;  // 데이터 프레임
        message.data_length_code = 1;  // 데이터 길이: 1 바이트
        message.data[0] = sensor_value;  // 진동 센서 값 전송

        // CAN 메시지 송신
        if (twai_transmit(&message, pdMS_TO_TICKS(1000)) == ESP_OK) {
            printf("🚀 CAN 송신 성공! 데이터: %d\n", sensor_value);
        } else {
            printf("⚠️ CAN 송신 실패!\n");
        }

        vTaskDelay(pdMS_TO_TICKS(500));  // 500ms마다 데이터 송신
    }
}

// ESP32-S3의 메인 함수
void app_main() {
    // GPIO 설정
    gpio_set_direction(VIBRATION_SENSOR_PIN, GPIO_MODE_INPUT);
    gpio_set_pull_mode(VIBRATION_SENSOR_PIN, GPIO_PULLDOWN_ONLY);  // 풀다운 저항 활성화

    // CAN 통신 초기화
    can_init();

    // 진동 센서 데이터를 읽고 CAN으로 전송하는 Task 실행
    xTaskCreate(vibration_sensor_task, "vibration_sensor_task", 4096, NULL, 5, NULL);
}
