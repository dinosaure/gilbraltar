# Kernel & toolchain for RPi4

To be able to cross-compile the caml runtime, we must boostrap a "toolchain"
to include some compilation/link options when we compile it. These scripts come
from [Solo5][] and they are mainly correct about what we expect when we want to
compile a bare-metal kernel for RPi4.
- `-ffreestanding` to assert a freestanding environment
- `-nostdlib` and we will replace it by `nolibc`
- `-nostdinc` and required definitions are available in
  `$prefix/include/aarch64-rpi4-none-static`

The main difference with Solo5 is about required "primitives" to puts text into
the screen. Instead of Solo5, we use our UART (Universal asynchronous
receiver-transmitter).

These _fake_-tools (`cc`, `ld` and `objcopy`) ensures that we pass flags along
our compilation. It's required to correctly cross-compile `ocaml`.

The directory provides 2 ELF files:
- `gilbraltar_rpi4.elf`
- `gilbraltar_stub.elf`

The first ELF file is used to craft the Operating System. It includes the
_bootstrap_ instruction. The second ELF is used to help some `configure.sh`
files to link and **run** some programs.

## What the kernel provide to OCaml?

Several functions/symbols are provided and they are available for OCaml and
MirageOS:
- `tscclock_monotonic`
- `uart_*` functions
- `irq_*` functions
- `_start*` functions
- `__stack_chk_guard`
- `__stack_chk_fail`

### The monotonic clock

The OCaml `./configure` wants to recognize how to get the monotonic clock and
the POSIX block. Indeed, our kernel must provides something to implement:
- `times` (see `man 2 times`)
- `gettimeofday`(see `man 2 gettimeofday`)

Both use `tscclock_monotonic` which is already initialized by our kernel. The
code is available into: `lib/tscclock.c`

That mostly means that we **can not** get the POSIX time at this moment. We are
only able to return the _process time_.

### UART

The OCaml runtime needs to print out some bytes. We initialize and give some
useful functions to print out into UART pins: GPIO 14 & 15. We provides:
- `uart_puts` which writes into our internal buffer, a
  `uart_drain_output_queue` is needed to flush our internal buffer then
- `uart_puts_actual` which **directly** writes into GPIO 14 (Transmit, TXD)
- `uart_load_output_fifo` which flush our internal queue
- `uart_drain_output_queue` which flush our internal queue **as long as**
  it is not empty

They are used directly by OCaml to print out some bytes like:
- `write` (see `man 2 write`)
- `abort` (which uses `uart_puts_actual`)
- or `console_write`, a function used by `stderr` and `stdout`

In other words, `print_endline` or `prerr_endline` write into the destination.

### Interrupts

The kernel gives the ability to play a bit with interrupts and provides:
- `irq_enable` & `irq_disable`
- `irq_init_vectors`
- `irq_yield`
- and `irq_register_handler`

`irq_enable` allows the CPU to receive an interrupt from a device (such as the
clock device). The user must allows by (him/her)self such mode. The kernel only
initialize exception vectors table. Then:
- `irq_yield` enables and waits the next interruption.
- `irq_register_handler` saves one C function which will be called when
  an interruption appears

However, this stuff is currently used by `caml/nolibc/signal.c` and caml
signals are _mapped_ with interruptions. A little example in OCaml exists:
```ocaml
external irq_enable : unit -> unit = "irq_enable"
external setup_interrupt_1 : unit -> unit = "setup_interrupt_1"

let handler _ =
  print_endline "Interruption 1" ;
  acknowledge_interrupt_1 () ;
  irq_enable () ;
;;

let () =
  Sys.(set_signal 1 (Signal_handle handler)) ;
  setup_interrupt_1 () ;
  irq_enable () ;
  while true do ignore @@ Bytes.create 10 end ;
;;
```

### First entry point `_start_c` function

Depending on the linking (bare-metal or stub), a `_start` function is provided.
The stub linking mode exists for the OCaml `./configure` which, at least, tries
to compile some C programs to check the existence of some functions.

Otherwise, on the bare-metal mode, `_start_c` function is the first entry point
of the kernel. the `boot.S` will jump on it at the beginning of the bare-metal
program.

### Stack protection

Finally, a protection on the stack is emitted by the C compiler _via_ the
option `-fstack-protector-strong`. So 2 symbols are required to compile your
program:
- `__stack_chk_guard`
- `__stack_chk_fail`

They are provided by `lib/crt.c`.

[Solo5]: https://github.com/Solo5/solo5
