// defined in irqentry.S

void irq_disable();
void irq_enable();
void irq_init_vectors();
void irq_yield();

void irq_register_handler(void (*fn)());
