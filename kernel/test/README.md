# A simple benchmark to test our unikernel

You can produce a `kernel8.img` with `dune` with:
```sh
$ git clone https://github.com/dinosaure/gilbraltar.git
$ cd gilbraltar
$ opam pin add -yn .
$ opam depext install -y gilbraltar-toolchain gilbraltar
$ dune build
$ cp _build/default/kernel/test/kernel8.img .
```

You can install this image into your SD card (with the BCM27711 firmware) and
launch the operating system. Then, you should have such output:
```
uart():     ok
tscclock(): ok
 _____ _ _ _           _ _           
|   __|_| | |_ ___ ___| | |_ ___ ___ 
|  |  | | | . |  _| .'| |  _| .'|  _|
|_____|_|_|___|_| |__,|_|_| |__,|_|  
irq():      ok
mmu():      ok
mem():      ok
nolibc():   ok
RPi4: Memory map: 752 MB addressable:
RPi4:   reserved @ (0x0 - 0xffffffffffffffff)
RPi4:       text @ (0x0 - 0x45df)
RPi4:     rodata @ (0x45e0 - 0x48f6)
RPi4:       data @ (0x48f7 - 0x100409f)
RPi4:       heap >= 0x1005000 < stack < 0x2f000000
Gi(l)braltar benchmark.
> 671 ms.
```

The time corresponds to how long the RaspBerry Pi 4 B+ takes to modify an array
of `0x1000000` elements and do a sum of all of these elements. To compare, if
the array is allocated _via_ `malloc()` and used as is, on my machine, the
performance is: ~200 ms.
