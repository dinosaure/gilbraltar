CC= aarch64-linux-gnu-gcc
LD= aarch64-linux-gnu-ld
OBJCOPY= aarch64-linux-gnu-objcopy

SRC= $(wildcard *.c)
OBJ= $(SRC:.c=.o)
DEP= $(OBJ:.o=.d)

all: gilbraltar_rpi4.o gilbraltar_stub.o

CFLAGS= -I../include/ \
	-DPRINTF_INCLUDE_CONFIG_H \
	-DSSP_GUARD_SYMBOL=__stack_chk_guard \
	-DSSP_FAIL_SYMBOL=__stack_chk_fail \
	-ffreestanding -nostdinc -nostdlib
LDFLAGS= -L..lib/

gilbraltar_rpi4.o: $(filter-out stub.o,$(OBJ))
	@echo "LD $@"
	$(LD) -r $(LDFLAGS) $^ -o $@
	@echo "OBJCOPY $@"
	$(OBJCOPY) -w -G uart_\* -G rpi4_startup -G _start\* \
		-G __stack_chk_guard -G __stack_chk_fail \
		$@ $@

gilbraltar_stub.o: $(filter-out kernel.o,$(OBJ))
	@echo "LD $@"
	$(LD) -r $(LDFLAGS) $^ -o $@
	@echo "OBJCOPY $@"
	$(OBJCOPY) -w -G uart_\* -G _start\* \
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
	rm -f $(OBJ) gilbraltar_stub.o gilbraltar_rpi4.o

.PHONY: cleandep
cleandep:
	rm -f $(DEP)
