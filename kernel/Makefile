.PHONY: all
all:

include/rpi4.h:
	@echo "GEN $@"
	./gen-headers.sh include

lib/gilbraltar_stub.o: include/rpi4.h
	$(MAKE) -C lib gilbraltar_stub.o

lib/gilbraltar_rpi4.o: include/rpi4.h
	$(MAKE) -C lib gilbraltar_rpi4.o

all: include lib/gilbraltar_stub.o lib/gilbraltar_rpi4.o

.PHONY: clean
clean:
	@echo "CLEAN toolchain"
	$(MAKE) -C lib clean
	$(MAKE) -C lib cleandep
	$(RM) -r include/*
