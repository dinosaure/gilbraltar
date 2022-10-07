#include <stdint.h>
#include <stddef.h>

typedef enum {
  ERROR=0,
  WARN,
  INFO,
  DEBUG
} log_level_t;

int log(log_level_t level, const char *fmt, ...)
	__attribute__((format (printf, 2, 3)));

// stub
void _nolibc_init() {

}

extern void uart_drain_output_queue(void);
extern void uart_puts(const char *, size_t);
extern uint64_t tscclock_monotonic(void);
extern size_t strlen(const char *);

void caml_startup() {
  const char title[] = "Gi(l)braltar benchmark.\n" ;
  uart_puts(title, strlen(title));
  uart_drain_output_queue();

  long clock = tscclock_monotonic();

  int data[0x1000000];

  for (int i = 0; i < 0x1000000; i++)
      data[i] = i;

  int sum = 0;

  for (int i = 0; i < 0x1000000; i++)
      if (i % 10000 == 0)
          sum += data[i];

  log(INFO, "> %ld ms.\n", ((tscclock_monotonic() - clock)) / 1000000);
  uart_drain_output_queue();
}
