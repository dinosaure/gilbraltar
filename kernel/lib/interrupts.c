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

void irq_register_handler(void (* fn)()) {
    interrupt_handler = fn;
}

void interrupt_handle_el1_irq() {
    uart_drain_output_queue();
    if (interrupt_handler != NULL) {
        (*interrupt_handler)();
    }
}

void irq_yield() {
    irq_enable();
    __asm__("wfi");
}
