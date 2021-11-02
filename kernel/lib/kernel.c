#include "io.h"
#include "log.h"
#include "mem.h"
#include "mclock.h"
#include "crt_init.h"

static char *unused_args[] = { "mirage", NULL };
static uintptr_t sp_at_start;

extern void _nolibc_init(uintptr_t heap_start, size_t heap_size);
extern void caml_startup(char **);
extern int errno;

void main() {
  log_set_level(DEBUG);
  crt_init_ssp();

  uintptr_t heap_start;
  size_t    heap_size;

  uart_init();
  mclock_init();

  log(INFO, " _____ _ _ _           _ _           \n");
  log(INFO, "|   __|_| | |_ ___ ___| | |_ ___ ___ \n");
  log(INFO, "|  |  | | | . |  _| .'| |  _| .'|  _|\n");
  log(INFO, "|_____|_|_|___|_| |__,|_|_| |__,|_|  \n");

  mem_init();
  mem_lock_heap(&heap_start, &heap_size);

  sp_at_start = (uintptr_t) &heap_start;
  _nolibc_init(heap_start, heap_size);

  caml_startup(unused_args);
  for(;;);
}
