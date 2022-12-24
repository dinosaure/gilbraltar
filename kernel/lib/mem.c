/*
 * Copyright (c) 2015-2019 Contributors as noted in the AUTHORS file
 *
 * This file is part of Gilbraltar, a bare-metal OS for RPi4.
 *
 * Permission to use, copy, modify, and/or distribute this software
 * for any purpose with or without fee is hereby granted, provided
 * that the above copyright notice and this permission notice appear
 * in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 * WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 * AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
 * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
 * OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
 * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include "log.h"
#include <stddef.h>
#include <stdint.h>

#define PAGE_SIZE 4096
#define PAGE_SHIFT 12
#define PAGE_MASK ~(0xfff)

extern char __boot_core_stack_end_exclusive[];

#define MEMORY_SIZE __boot_core_stack_end_exclusive

static uint64_t heap_start;

/*
 * Locks the memory layout (by disabling mem_ialloc_pages()). Must be called
 * before passing control to the application via solo5_app_main().
 *
 * Returns the first usable memory address for application heap in (*start)
 * and the size of the heap in (*size).
 */
static int mem_locked = 0;
void mem_lock_heap(uintptr_t *start, size_t *size) {
  mem_locked = 1;
  *start = heap_start;
  *size = ((unsigned long long)MEMORY_SIZE) - heap_start;
}

void mem_init(void) {
  extern char __text_start[], __text_end[], __rodata_end[], __end[];
  uint64_t mem_size;

  mem_size = (unsigned long long)MEMORY_SIZE;
  heap_start = ((uint64_t)&__end + PAGE_SIZE - 1) & PAGE_MASK;

  log(INFO, "RPi4: Memory map: %llu MB addressable:\n",
      (unsigned long long)mem_size >> 20);
  log(INFO, "RPi4:   reserved @ (0x0 - 0x%llx)\n",
      (unsigned long long)__text_start - 1);
  log(INFO, "RPi4:       text @ (0x%llx - 0x%llx)\n",
      (unsigned long long)__text_start, (unsigned long long)__text_end - 1);
  log(INFO, "RPi4:     rodata @ (0x%llx - 0x%llx)\n",
      (unsigned long long)__text_end, (unsigned long long)__rodata_end - 1);
  log(INFO, "RPi4:       data @ (0x%llx - 0x%llx)\n",
      (unsigned long long)__rodata_end, (unsigned long long)__end - 1);
  log(INFO, "RPi4:       heap >= 0x%llx < stack < 0x%llx\n",
      (unsigned long long)heap_start, (unsigned long long)mem_size);
}

/*
 * Allocate pages on the heap.  Should only be called on
 * initialization (before solo5_app_main).
 */
void *mem_ialloc_pages(size_t num) {
  uint64_t prev = heap_start;
  heap_start += num << PAGE_SHIFT;

  return (void *)prev;
}
