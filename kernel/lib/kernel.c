#include "io.h"
#include "lib.h"
#include "log.h"
#include "mem.h"
#include "mclock.h"
#include "crt_init.h"
#include "interrupts.h"

extern void _nolibc_init(uintptr_t heap_start, size_t heap_size);
extern void caml_startup(char **);
extern int get_el();
static char* args[] = { "gi(l)braltar", NULL };

extern void mmu_on();

void _start_c() {
  uintptr_t heap_start;
  size_t    heap_size;

  crt_init_ssp();

  uart_init();
  mclock_init();

  log(INFO, " _____ _ _ _           _ _           \n");
  log(INFO, "|   __|_| | |_ ___ ___| | |_ ___ ___ \n");
  log(INFO, "|  |  | | | . |  _| .'| |  _| .'|  _|\n");
  log(INFO, "|_____|_|_|___|_| |__,|_|_| |__,|_|  \n");
  log(INFO, "EL:%d\n", get_el());
  irq_init_vectors();
  irq_enable();
  log(INFO, "Interrupts: up\n");
  uart_drain_output_queue();

  mmu_on();
  log(INFO, "MMU: ON\n");


  mem_init();
  mem_lock_heap(&heap_start, &heap_size);

  _nolibc_init(heap_start, heap_size);
  uart_drain_output_queue();

  caml_startup(args);

  for(;;);
}
