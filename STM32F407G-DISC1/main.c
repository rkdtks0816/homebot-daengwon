#include "stm32f4xx.h"

int main(void) {
    GPIOD->MODER |= (1 << (12 * 2));
    while (1) {
        GPIOD->ODR ^= (1 << 12);
        for (volatile int i = 0; i < 1000000; i++);
    }
}
