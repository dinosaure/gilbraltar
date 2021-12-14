#include "io.h"
#include "lib.h"
#include "log.h"
#include "mem.h"
#include "mclock.h"
#include "crt_init.h"

extern void _nolibc_init(uintptr_t heap_start, size_t heap_size);
extern void caml_startup(char **);
extern int get_el();
static char* args[] = { "gi(l)braltar", NULL };

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

  mem_init();
  mem_lock_heap(&heap_start, &heap_size);

  _nolibc_init(heap_start, heap_size);
  uart_drain_output_queue();

  caml_startup(args);

  for(;;);
}
