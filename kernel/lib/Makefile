export TOPDIR := $(abspath .)

$(TOPDIR)/../Makeconf:
	$(error Makeconf not found, please run ./configure.sh)

include $(TOPDIR)/../Makeconf

CC= aarch64-none-elf-gcc
LD= aarch64-none-elf-ld
OBJCOPY= aarch64-none-elf-objcopy

SRC= $(wildcard *.c)
OBJ= $(SRC:.c=.o)
DEP= $(OBJ:.o=.d)

all: gilbraltar_rpi4.elf gilbraltar_stub.elf

CFLAGS= -I../include/$(CONFIG_TARGET_TRIPLE) \
	-DPRINTF_INCLUDE_CONFIG_H \
	-DSSP_GUARD_SYMBOL=__stack_chk_guard \
	-DSSP_FAIL_SYMBOL=__stack_chk_fail \
	-std=c11 \
	-ffreestanding -fstack-protector-strong -nostdinc -nostdlib \
	-nostartfiles
LDFLAGS= -L. -nostdlib

mmu.S: mmu_map.txt
	python3 ../../tools/arm64-pgtable-tool/generate.py -i mmu_map.txt -o mmu.S -ttb 0x2f000000 -el 1

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

gilbraltar_rpi4.elf: boot.o irqentry.o mmu.o $(filter-out stub.o,$(OBJ))
	@echo "LD $@"
	$(LD) -r $(LDFLAGS) $^ -o $@

gilbraltar_stub.elf: $(filter-out kernel.o,$(OBJ))
	@echo "LD $@"
	$(LD) -r $(LDFLAGS) $^ -o $@
	@echo "OBJCOPY $@"
	$(OBJCOPY) -w -G mclock -G uart_\* -G _start\* \
		-G __stack_chk_guard -G __stack_chk_fail \
		$@ $@

-include $(DEP)

%.d: %.c
	@echo "CC $@"
	$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@

%.o: %.c
	@echo "DEP $@"
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	$(RM) -f $(OBJ) boot.o gilbraltar_stub.elf gilbraltar_rpi4.elf
	$(RM) kernel8.elf

.PHONY: cleandep
cleandep:
	rm -f $(DEP)
