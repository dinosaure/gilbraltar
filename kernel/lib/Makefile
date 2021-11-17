include ../Makeconf

CC= aarch64-none-elf-gcc
LD= aarch64-none-elf-ld
OBJCOPY= aarch64-none-elf-objcopy

SRC= $(wildcard *.c)
OBJ= $(SRC:.c=.o)
DEP= $(OBJ:.o=.d)

all: gilbraltar_rpi4.elf gilbraltar_stub.elf

CFLAGS=-DPRINTF_INCLUDE_CONFIG_H -std=c11 -ffreestanding -nostdlib -nostartfiles
LDFLAGS=-nostdlib

boot.o: boot.S
	$(CC) $(CFLAGS) -c boot.S -o boot.o

gilbraltar_rpi4.elf: boot.o $(filter-out stub.o,$(OBJ))
	@echo "LD $@"
	$(LD) -r $^ -o $@

kernel8.elf: $(filter-out stub.o,$(OBJ))
	echo "#include <stddef.h>" > caml.c
	echo "#include <stdint.h>" >> caml.c
	echo "void caml_startup(char **argv) { } void _nolibc_init(uintptr_t *x, size_t *y) { }" >> caml.c
	$(CC) $(CFLAGS) -c caml.c -o caml.o
	$(CC) $(CFLAGS) -c boot.S -o boot.o
	$(LD) boot.o $^ caml.o -T rpi4_link.lds -o kernel8.elf
	$(RM) caml.c
	$(RM) caml.o
	$(RM) boot.o

gilbraltar_stub.elf: $(filter-out kernel.o,$(OBJ))
	@echo "LD $@"
	$(LD) -r $^ -o $@
	@echo "OBJCOPY $@"
	$(OBJCOPY) -w -G mclock -G uart_\* -G _start\* $@ $@

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
