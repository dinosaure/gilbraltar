#include "sysregs.h"

#define LOCAL_CONTROL   0xff800000
#define LOCAL_PRESCALER 0xff800008
#define OSC_FREQ        54000000

.macro ADR_REL register, symbol
  adrp \register, \symbol
  add  \register, \register, #:lo12:\symbol
.endm

.equ _core_id_mask, 0b11

.section .text._start

_start:
        ldr     x0, =LOCAL_CONTROL   // Sort out the timer
        str     wzr, [x0]
        mov     w1, 0x80000000
        str     w1, [x0, #(LOCAL_PRESCALER - LOCAL_CONTROL)]

        ldr     x0, =OSC_FREQ
        msr     cntfrq_el0, x0
        msr     cntvoff_el2, xzr

        mrs     x1, MPIDR_EL1
        and     x1, x1, _core_id_mask
	mov     x2, #0
	cmp     x1, x2
	b.ne    .L_parking_loop

        mov     x0, #0x33ff
        msr     cptr_el3, x0 	     // Disable coprocessor traps to EL3
        mov     x0, #3 << 20
        msr     cpacr_el1, x0	     // Enable FP/SIMD at EL1

        // Now get ready to switch from EL3 down to EL1

        ldr     x0, =SCTLR_VALUE_MMU_DISABLED
        msr	sctlr_el1, x0		

        ldr     x0, =HCR_VALUE
        msr     hcr_el2, x0

        ldr     x0, =SCR_VALUE
        msr     scr_el3, x0

        ldr     x0, =SPSR_EL3_VALUE
        msr     spsr_el3, x0
        
        adr     x0, el1_entry		
        msr     elr_el3, x0

        eret

el1_entry:
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
        wfi
        b       .L_parking_loop

.size   _start, . - _start
.type   _start, function
.global _start

get_el:
	mrs x0, CurrentEL
	lsr x0, x0, #2
	ret
.size   get_el, . - get_el
.type   get_el, function
.global get_el
