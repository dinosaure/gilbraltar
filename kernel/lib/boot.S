.macro ADR_REL register, symbol
  adrp \register, \symbol
  add  \register, \register, #:lo12:\symbol
.endm

.equ _core_id_mask, 0b11

.section .text._start

_start:
        mrs     x1, MPIDR_EL1
        and     x1, x1, _core_id_mask
	mov     x2, #0
	cmp     x1, x2
	b.ne    .L_parking_loop
.L_bss_init_loop:
        ADR_REL x0, __bss_start
        ADR_REL x1, __bss_end_exclusive
.L_bss_loop:
        cmp     x0, x1
        b.eq    .L_prepare_c
        stp     xzr, xzr, [x0], #16
        b       .L_bss_loop
.L_prepare_c:
        ADR_REL x0, __boot_core_stack_end_exclusive
        mov     sp, x0
.L_jump:
        bl      _start_c
	b	.L_parking_loop
.L_parking_loop:
        wfe
        b       .L_parking_loop

.size   _start, . - _start
.type   _start, function
.global _start
