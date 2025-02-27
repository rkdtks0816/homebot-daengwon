MEMORY
{
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 1024K
    RAM (rwx)   : ORIGIN = 0x20000000, LENGTH = 128K
}

SECTIONS
{
    .text :
    {
        *(.isr_vector)
        *(.text*)
        *(.rodata*)
        . = ALIGN(4);
    } > FLASH

    .data :
    {
        *(.data*)
        . = ALIGN(4);
    } > RAM AT> FLASH

    .bss :
    {
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
    } > RAM
}
