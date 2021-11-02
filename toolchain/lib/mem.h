#include <stddef.h>
#include <stdint.h>

void mem_init(void);
void mem_lock_heap(uintptr_t *start, size_t *size);
