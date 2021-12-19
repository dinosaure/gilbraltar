#include <caml/signals.h>

#define PERIPHERAL_BASE 0xFE000000
#define CLOCKHZ 1000000

struct timer_regs {
    volatile unsigned int control_status;
    volatile unsigned int counter_lo;
    volatile unsigned int counter_hi;
    volatile unsigned int compare[4];
};

#define REGS_TIMER ((struct timer_regs *)(PERIPHERAL_BASE + 0x00003000))

void caml_setup_handler_1() {
    unsigned int timer1_val = REGS_TIMER->counter_lo;
    timer1_val += 2000000;
    REGS_TIMER->compare[1] = timer1_val;
}

void caml_setup_handler_3() {
    unsigned int timer1_val = REGS_TIMER->counter_lo;
    timer1_val += 2500000;
    REGS_TIMER->compare[3] = timer1_val;
}

void caml_ack_interrupt_1() {
     REGS_TIMER->control_status = 0b0010;
}

void caml_ack_interrupt_3() {
     REGS_TIMER->control_status = 0b1000;
}

void wfi() {
    __asm__("wfi");
}
