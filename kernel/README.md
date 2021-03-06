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

[Solo5]: https://github.com/Solo5/solo5
