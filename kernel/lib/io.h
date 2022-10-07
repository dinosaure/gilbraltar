#include <stddef.h>

void uart_init();

void uart_puts(const char *buffer, size_t len);
void uart_puts_actual(const char *buffer, size_t len);
void uart_load_output_fifo();
void uart_drain_output_queue();

unsigned char uart_read_byte();
unsigned int uart_is_read_byte_ready();

void uart_write_byte_blocking(unsigned char ch);
