/* STM32F407VGT6 메모리 정의 */
MEMORY
{
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 1024K
    RAM (rwx)   : ORIGIN = 0x20000000, LENGTH = 128K
}

/* 섹션 배치 */
SECTIONS
{
    .isr_vector :
    {
        . = ALIGN(4);
        KEEP(*(.vector_table)) /* 벡터 테이블 */
        . = ALIGN(4);
    } > FLASH

    .text :
    {
        . = ALIGN(4);
        *(.text*)     /* 코드 */
        *(.rodata*)   /* 읽기 전용 데이터 */
        . = ALIGN(4);
    } > FLASH

    /* .data 섹션 - 플래시에서 RAM으로 복사 */
    .data :
    {
        . = ALIGN(4);
        _sdata = .;         /* 데이터 섹션 시작 */
        *(.data*)           /* 초기화된 전역 변수 */
        . = ALIGN(4);
        _edata = .;         /* 데이터 섹션 끝 */
    } > RAM AT > FLASH

    _la_data = LOADADDR(.data);  /* LMA 설정 */

    /* .bss 섹션 - 초기화되지 않은 전역 변수 */
    .bss :
    {
        . = ALIGN(4);
        _sbss = .;         /* BSS 섹션 시작 */
        *(.bss*)           /* 초기화되지 않은 전역 변수 */
        *(COMMON)          /* COMMON 블록 */
        . = ALIGN(4);
        _ebss = .;         /* BSS 섹션 끝 */
    } > RAM
}
