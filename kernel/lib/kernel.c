#include "crt_init.h"
#include "interrupts.h"
#include "io.h"
#include "lib.h"
#include "log.h"
#include "mem.h"

extern int tscclock_init(uint64_t tsc_freq);
extern void _nolibc_init(uintptr_t heap_start, size_t heap_size);
extern void caml_startup(char **);
static char *args[] = {"gi(l)braltar", NULL};

static char *output00 = {"uart():     ok\n"};
static char *output01 = {"tscclock(): ok\n"};
static char *output02 = {"irq():      ok\n"};
static char *output03 = {"mmu():      ok\n"};
static char *output04 = {"mem():      ok\n"};
static char *output05 = {"nolibc():   ok\n"};

extern void mmu_on();

void _start_c() {
  uintptr_t heap_start;
  size_t heap_size;

  crt_init_ssp();

  uart_init();
  uart_puts_actual(output00, strlen(output00));

  tscclock_init(-1);
  uart_puts_actual(output01, strlen(output01));

  log(INFO, " _____ _ _ _           _ _           \n");
  log(INFO, "|   __|_| | |_ ___ ___| | |_ ___ ___ \n");
  log(INFO, "|  |  | | | . |  _| .'| |  _| .'|  _|\n");
  log(INFO, "|_____|_|_|___|_| |__,|_|_| |__,|_|  \n");
  uart_drain_output_queue();

  irq_init_vectors();
  uart_puts_actual(output02, strlen(output02));

  mmu_on();
  uart_puts_actual(output03, strlen(output03));

  mem_init();
  uart_puts_actual(output04, strlen(output04));
  mem_lock_heap(&heap_start, &heap_size);

  _nolibc_init(heap_start, heap_size);
  uart_puts_actual(output05, strlen(output05));
  uart_drain_output_queue();

  caml_startup(args);

  for (;;) {
    __asm__("wfi");
  };
}
