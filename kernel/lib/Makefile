include ../Makeconf

CC= aarch64-linux-gnu-gcc
LD= aarch64-linux-gnu-ld
OBJCOPY= aarch64-linux-gnu-objcopy

SRC= $(wildcard *.c)
OBJ= $(SRC:.c=.o)
DEP= $(OBJ:.o=.d)

all: gilbraltar_rpi4.elf gilbraltar_stub.elf

CFLAGS= -I../include/$(CONFIG_TARGET_TRIPLE) \
	-DPRINTF_INCLUDE_CONFIG_H \
	-DSSP_GUARD_SYMBOL=__stack_chk_guard \
	-DSSP_FAIL_SYMBOL=__stack_chk_fail \
	-std=c11 \
	-ffreestanding -fstack-protector-strong -nostdinc -nostdlib
LDFLAGS= -L. -nostdlib

boot.o: boot.S
	$(CC) $(CFLAGS) -c boot.S -o boot.o

gilbraltar_rpi4.elf: boot.o $(filter-out stub.o,$(OBJ))
	@echo "LD $@"
	$(LD) -r $(LDFLAGS) $^ -o $@

libnolibc.a:
	$(error You must copy this artifact inside the current directory)

kernel8.elf: $(filter-out stub.o,$(OBJ)) libnolibc.a
	echo "void caml_startup(char **argv) { }" > caml.c
	$(CC) $(CFLAGS) -c caml.c -o caml.o
	$(CC) $(CFLAGS) -c boot.S -o boot.o
	$(LD) $(LDFLAGS) boot.o $^ caml.o -L. -lnolibc -T rpi4_link.lds -o kernel8.elf
	$(RM) caml.c
	$(RM) caml.o
	$(RM) boot.o

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
