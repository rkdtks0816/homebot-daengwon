#include "FreeRTOS.h"
#include "task.h"
#include "main.h"

// 태스크 함수
void Task1(void *pvParameters) {
    while (1) {
        // LED 깜빡이기
        HAL_GPIO_TogglePin(GPIOC, GPIO_PIN_13);
        vTaskDelay(500);
    }
}

// 메인 함수
int main(void) {
    HAL_Init();
    
    // FreeRTOS 태스크 생성
    xTaskCreate(Task1, "LED_Task", 128, NULL, 1, NULL);
    
    // 스케줄러 실행
    vTaskStartScheduler();
    
    while (1);
}
