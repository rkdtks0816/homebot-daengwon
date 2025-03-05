#include "stm32f407xx.h"

// 간단한 딜레이 함수
void delay(volatile uint32_t count) {
    while (count--);
}

int main(void) {
    // 1. GPIOA 클럭 활성화
    RCC->AHB1ENR |= (1 << 0);

    // 2. PA5를 출력 모드로 설정
    GPIOA->MODER &= ~(3 << (5 * 2));
    GPIOA->MODER |= (1 << (5 * 2)); // Output mode

    while (1) {
        GPIOA->ODR ^= (1 << 5); // PA5(LED) 토글
        delay(1000000);
    }
}
