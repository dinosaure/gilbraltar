#include "interrupts.h"
#include "log.h"
#include "io.h"

void show_invalid_entry_message(int type, int esr_el1, int elr_el1, int sp) {
    log(ERROR, "INTERRUPT: %d\nESR: %016x ELR: %016x SP: %016x\n", type, esr_el1, elr_el1, sp);
    uart_drain_output_queue();

    while(1) {
        __asm__("wfi");
    }
}

void (*interrupt_handler)() = NULL;

void register_interrupt_handler(void (* v_interrupt_handler)()) {
    interrupt_handler = v_interrupt_handler;
}

void interrupt_handle_el1_irq() {
    log(INFO, "IRQ\n");
    uart_drain_output_queue();
    if(interrupt_handler != NULL){
        (*interrupt_handler)();
    }
}

void yield() {
    irq_enable();
    __asm__("wfi");
}
