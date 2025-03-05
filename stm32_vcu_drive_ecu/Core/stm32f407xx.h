#ifndef STM32F407XX_H
#define STM32F407XX_H

#include <stdint.h>

/* RCC (리셋 및 클럭 컨트롤) */
#define RCC_BASE        (0x40023800UL)
#define RCC             ((RCC_TypeDef *) RCC_BASE)

typedef struct {
    volatile uint32_t CR;         // 클럭 제어 레지스터
    volatile uint32_t PLLCFGR;    // PLL 설정
    volatile uint32_t CFGR;       // 클럭 설정
    volatile uint32_t CIR;        // 클럭 인터럽트
    volatile uint32_t AHB1ENR;    // AHB1 클럭 활성화
    volatile uint32_t AHB2ENR;    // AHB2 클럭 활성화
    volatile uint32_t AHB3ENR;    // AHB3 클럭 활성화 (미사용 시 패딩)
    uint32_t RESERVED0;           // 패딩
    volatile uint32_t APB1ENR;    // APB1 클럭 활성화
    volatile uint32_t APB2ENR;    // APB2 클럭 활성화
} RCC_TypeDef;

/* GPIOA (LED 제어) */
#define GPIOA_BASE      (0x40020000UL)
#define GPIOA           ((GPIO_TypeDef *) GPIOA_BASE)

typedef struct {
    volatile uint32_t MODER;      // 모드 설정
    volatile uint32_t OTYPER;     // 출력 타입 설정
    volatile uint32_t OSPEEDR;    // 속도 설정
    volatile uint32_t PUPDR;      // 풀업/풀다운 설정
    volatile uint32_t IDR;        // 입력 데이터 레지스터
    volatile uint32_t ODR;        // 출력 데이터 레지스터
    volatile uint32_t BSRR;       // 비트 설정 및 리셋
    volatile uint32_t LCKR;       // GPIO 락 레지스터
    volatile uint32_t AFR[2];     // 대체 기능 레지스터 (AFR[0]: 낮은 핀, AFR[1]: 높은 핀)
} GPIO_TypeDef;

#endif // STM32F407XX_H
