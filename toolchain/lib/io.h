#include <stddef.h>

void uart_init();
void uart_write_text(const char *buffer);
void uart_puts(const char *buffer, size_t len);
