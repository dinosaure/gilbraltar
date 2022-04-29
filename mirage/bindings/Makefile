.PHONY: all clean
all: libmirage-gilbraltar_bindings.a

CC=ocamlfind -toolchain rpi4 ocamlopt
OBJS= mem.o

libmirage-gilbraltar_bindings.a: $(OBJS)
	$(AR) r $@ $^

clean:
	$(RM) $(OBJS) libmirage-gilbraltar_bindings.a
