include ../Makeconf

CC= aarch64-linux-gnu-gcc
LD= aarch64-linux-gnu-ld
OBJCOPY= aarch64-linux-gnu-objcopy

CFLAGS= -I../include/$(CONFIG_TARGET_TRIPLE) \
	-DPRINTF_INCLUDE_CONFIG_H \
	-DSSP_GUARD_SYMBOL=__stack_chk_guard \
	-DSSP_FAIL_SYMBOL=__stack_chk_fail \
	-std=c11 \
	-ffreestanding -fstack-protector-strong -nostdinc -nostdlib \
	-nostartfiles
LDFLAGS= -L. -nostdlib

%.o: %.c
	@echo "DEP $@"
	$(CC) $(CFLAGS) -c $< -o $@

kernel8.elf: main.o ../lib/gilbraltar_rpi4.elf ../lib/rpi4_link.lds
	$(LD) $(LDFLAGS) main.o ../lib/gilbraltar_rpi4.elf  -T ../lib/rpi4_link.lds -o kernel8.elf
