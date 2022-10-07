# Gilbraltar, the MirageOS retreat is not so far

```
 _____ _ _ _           _ _           
|   __|_| | |_ ___ ___| | |_ ___ ___ 
|  |  | | | . |  _| .'| |  _| .'|  _|
|_____|_|_|___|_| |__,|_|_| |__,|_|  

```

`gilbraltar` is a version of the OCaml compiler to be able to build a MirageOS
for RaspberryPi 4. It's a work in progress repository to provide a `dune`'s 
toolchain (as `ocaml-freestanding`) specialized for Raspberry Pi 4.

The project is split into 2 packages:
- `kernel` which contains the C kernel
- `caml` which is a copy of [ocaml-freestanding][] for our kernel

The goal of this repository is to bootstrap a caml runtime from nothing. The
caml runtime is linked to `nolibc` and `openlibm` statically. Then, it provides
a new `ocamlfind`/`dune` toolchain to be able to craft a full operating system
with `dune` (as far as your context is `rpi4`).

A full example of an `Hello World` bare-metal OS is available into `test` where
a small ceremony is needed to compile the program for your Raspberry Pi 4 - be
aware that you must take the `rpi4` artifact (and not the `default` one which
is compiled with `kernel/lib/stub.c`).

This project by its conception is mainly inspired by:
- [Solo5][] for the _toolchain_ layout
- [ocaml-freestanding][] for the _caml runtime_
- [rpi4os.com][] for Raspberry Pi stuffs
- and many tutorials and coffee

## How to launch the example

First, you must have `opam` as the OCaml package manager. Then, you need to
install Gilbraltar:
```sh
$ opam pin add git+https://github.com/dinosaure/gilbraltar -y
...
```

Then, with `dune`, you are able to craft a full operating system:
```sh
$ cd test
$ dune build kernel8.img
```

With `qemu` and a [patch][] to be able to simulate a Raspberry Pi 4 system, you
are able to launch the `kernel8.elf` with (Ctrl a + x to terminate):
```sh
$ qemu-system-aarch64 -M raspi4 \
  -nographic -no-reboot \
  -serial null -serial mon:stdio \
  -kernel kernel8.img
 _____ _ _ _           _ _           
|   __|_| | |_ ___ ___| | |_ ___ ___ 
|  |  | | | . |  _| .'| |  _| .'|  _|
|_____|_|_|___|_| |__,|_|_| |__,|_|  
RPi4: Memory map: 768 MB addressable:
RPi4:   reserved @ (0x0 - 0xffffffffffffffff)
RPi4:       text @ (0x0 - 0x3dfff)
RPi4:     rodata @ (0x3e000 - 0x45fff)
RPi4:       data @ (0x46000 - 0x52fff)
RPi4:       heap >= 0x53000 < stack < 0x30000000
Hello World from OCaml!
QEMU: Terminated
```

And voilà!

## And physically?

Gilbraltar use [UART][] to puts some text and if you have an
[USB to Serial TTL][] link, you should be able to see this text if you follow
this [tutorial][].

The main difference between the tutorial and our example is: OCaml! So, as far
as an OCaml library does not link with a _C stubs_, you should be able to use
it in your new RPi4 MirageOS!

## And MirageOS?

The goal of `gilbraltar` is to be a _target_ for MirageOS. For a MirageOS
application, you should be able to compile it to Solo5 (and launch the
operating system into KVM) and Gilbraltar (and launch the OS into your RPi4)
**without any updates**.

We currently try to provide basic packages such as `mirage-gilbraltar` which
will be chosen by `functoria`/`mirage` depending on which target you ask.

[Solo5]: https://github.com/Solo5/solo5
[ocaml-freestanding]: https://github.com/mirage/ocaml-freestanding
[rpi4os.com]: https://www.rpi4os.com/
[UART]: https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter
[USB to Serial TTL]: https://www.google.com/search?hl=en&q=USB%20to%20serial%20TTL
[patch]: https://gitlab.com/philmd/qemu.git#raspi4_wip
[tutorial]: https://www.rpi4os.com/part3-helloworld/#connecting-the-cable
