#include "signal.h"

struct arm_irq_regs_2711 {
    volatile unsigned int irq0_pending_0;
    volatile unsigned int irq0_pending_1;
    volatile unsigned int irq0_pending_2;
    volatile unsigned int res0;
    volatile unsigned int irq0_enable_0;
    volatile unsigned int irq0_enable_1;
    volatile unsigned int irq0_enable_2;
    volatile unsigned int res1;
    volatile unsigned int irq0_disable_0;
    volatile unsigned int irq0_disable_1;
    volatile unsigned int irq0_disable_2;
};

typedef struct arm_irq_regs_2711 arm_irq_regs;

#define PERIPHERAL_BASE 0xFE000000
#define REGS_IRQ ((arm_irq_regs *)(PERIPHERAL_BASE + 0x0000B200))

long handlers = 0;
sig_handler fn_handlers[64];

#include <stdio.h>

sig_handler signal(int sig, sig_handler func) {
    if (sig < 0 ||sig >= 64) {
        return SIG_ERR;
    }

    if (func == SIG_IGN ||func == SIG_DFL) {
        handlers &= ~(1<<sig);
        if (sig <= 32){
            REGS_IRQ->irq0_disable_0 = 1 << sig;
        } else {
            REGS_IRQ->irq0_disable_1 = 1 << (sig - 32);
        }
    } else {
        handlers |= (1<<sig);
        if (sig <= 32){
            REGS_IRQ->irq0_enable_0 = 1 << sig;
        } else {
            REGS_IRQ->irq0_enable_1 = 1 << (sig - 32);
        }
    }

    sig_handler hdl = fn_handlers[sig];
    fn_handlers[sig] = func;
    return hdl;
}


void signal_handler() {
    unsigned int pending_0 = REGS_IRQ->irq0_pending_0 & ((int) handlers);
    unsigned int pending_1 = REGS_IRQ->irq0_pending_1 & ((int)( handlers >> 32));

    for (int i = 0; i < 32; i++) {
        if (pending_0 & (1 << i)) {
            fflush(stdout);
            (*fn_handlers[i])(i);
        }

        if (pending_1 & (1 << i)) {
            fflush(stdout);
            (*fn_handlers[32+i])(32+i);
        }
    }
}

// defined in kernel/interrupts.c
void register_interrupt_handler(void (*fn)());
void irq_enable();

void signal_init() {
    register_interrupt_handler(signal_handler);
    irq_enable();

    for (int i = 0; i < 64; i++){
        fn_handlers[i] = SIG_DFL;
    }
}
