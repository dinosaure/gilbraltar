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

#include "io.h"
#include <stddef.h>
#include <stdint.h>

/*
 * The stack canary value will be initialised to a pseudo-random value by
 * crt_init_early(), keep an easily recognisable "terminator" value here to
 * flag if that did not happen as expected.
 */
uintptr_t SSP_GUARD_SYMBOL = 0x00deadbeef0d0a00;

/*
 * Called by compiler-generated code when corruption of the canary value is
 * detected. There is very little we can do here safely, so just print a
 * message and abort, taking care to make minimal use of the stack.
 */
static const char stack_chk_fail_message[] =
    "RPi4: ABORT: Stack corruption detected\n";

__attribute__((noreturn)) void SSP_FAIL_SYMBOL(void) {
  uart_puts_actual(stack_chk_fail_message, sizeof stack_chk_fail_message);
  for (;;)
    ;
}
