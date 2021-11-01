#include "io.h"
#include "mem.h"

static char *unused_args[] = { "mirage", NULL };
static uintptr_t sp_at_start;

extern void _nolibc_init(uintptr_t heap_start, size_t heap_size);
extern void caml_startup(char **);

void _start() {
  uintptr_t heap_start;
  size_t    heap_size;

  uart_init();
  mem_init();
  mem_lock_heap(&heap_start, &heap_size);

  sp_at_start = (uintptr_t) &heap_start;
  _nolibc_init(heap_start, heap_size);

  caml_startup(unused_args);
  for(;;);
}
