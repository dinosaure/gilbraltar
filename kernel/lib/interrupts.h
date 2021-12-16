// defined in irqentry.S

void irq_disable();
void irq_enable();
void irq_init_vectors();
void yield();

void register_interrupt_handler(void (*fn)());
