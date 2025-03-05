.global _reset_handler
.global _vectors

.section .vector_table, "a"
_vectors:
    .word _estack       // 초기 스택 포인터
    .word _reset_handler // 리셋 핸들러

.section .text
.syntax unified
.thumb
_reset_handler:
    LDR r0, =_estack   // 스택 포인터 주소 로드
    MOV sp, r0         // SP에 저장

    // .data 섹션 초기화 (플래시 → RAM 복사)
    LDR r0, =_sdata
    LDR r1, =_edata
    LDR r2, =_la_data
data_copy:
    CMP r0, r1
    BCS bss_init
    LDR r3, [r2]      // Auto-increment 제거
    STR r3, [r0]
    ADD r2, r2, #4
    ADD r0, r0, #4
    B data_copy

    // .bss 섹션 초기화 (RAM을 0으로 초기화)
bss_init:
    LDR r0, =_sbss
    LDR r1, =_ebss
    MOVS r2, #0
bss_loop:
    CMP r0, r1
    BCS main
    STR r2, [r0]
    ADD r0, r0, #4
    B bss_loop

    // main() 실행
    BL main
    B .                // 무한 루프

.section .bss
_estack = 0x20020000  // 스택 시작 주소 (128KB RAM)
