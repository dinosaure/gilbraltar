export TOPDIR := $(abspath .)

$(TOPDIR)/Makeconf:
	$(error Makeconf not found, please run ./configure.sh)
include $(TOPDIR)/Makeconf

.PHONY: all
all:
all := bin/$(CONFIG_TARGET_TRIPLE)-cc \
       bin/$(CONFIG_TARGET_TRIPLE)-ld \
       bin/$(CONFIG_TARGET_TRIPLE)-objcopy \
       include/$(CONFIG_TARGET_TRIPLE) \
       lib/gilbraltar_rpi4.elf \
       lib/gilbraltar_stub.elf

bin:
	mkdir -p $@

bin/$(CONFIG_TARGET_TRIPLE)-%: %.in | bin
	@echo "SUBST $@"
	sed -e 's!@@CONFIG_TARGET_ARCH@@!$(CONFIG_TARGET_ARCH)!g' \
	    -e 's!@@CONFIG_TARGET_TRIPLE@@!$(CONFIG_TARGET_TRIPLE)!g' \
	    -e 's!@@CONFIG_TARGET_CC@@!$(CONFIG_TARGET_CC)!g' \
	    -e 's!@@CONFIG_TARGET_CC_CFLAGS@@!$(CONFIG_TARGET_CC_CFLAGS)!g' \
	    -e 's!@@CONFIG_TARGET_CC_LDFLAGS@@!$(CONFIG_TARGET_CC_LDFLAGS)!g' \
	    -e 's!@@CONFIG_TARGET_LD@@!$(CONFIG_TARGET_LD)!g' \
	    -e 's!@@CONFIG_TARGET_LD_LDFLAGS@@!$(CONFIG_TARGET_LD_LDFLAGS)!g' \
	    -e 's!@@CONFIG_TARGET_LD_MAX_PAGE_SIZE@@!$(CONFIG_TARGET_LD_MAX_PAGE_SIZE)!g' \
	    -e 's!@@CONFIG_TARGET_OBJCOPY@@!$(CONFIG_TARGET_OBJCOPY)!g' \
	    $< >$@
	chmod +x $@

include:
	mkdir -p $@

include/$(CONFIG_TARGET_TRIPLE): | include
	@echo "GEN $@"
	./gen-headers.sh $@

lib/gilbraltar_stub.elf: include/$(CONFIG_TARGET_TRIPLE)
	$(MAKE) -j1 -C lib gilbraltar_stub.elf

lib/gilbraltar_rpi4.elf: include/$(CONFIG_TAREGT_TRIPLE)
	$(MAKE) -j1 -C lib gilbraltar_rpi4.elf

all: $(all)

TOOLCHAIN_INCDIR := $(CONFIG_PREFIX)/include/$(CONFIG_TARGET_TRIPLE)
TOOLCHAIN_LIBDIR := $(CONFIG_PREFIX)/lib/$(CONFIG_TARGET_TRIPLE)

INSTALL := install -p

.PHONY: install-toolchain
install-toolchain: $(all)
	@echo INSTALL toolchain
	mkdir -p $(PREFIX)/bin
	$(INSTALL) -m 0755 bin/$(CONFIG_TARGET_TRIPLE)-cc $(CONFIG_PREFIX)/bin
	$(INSTALL) -m 0755 bin/$(CONFIG_TARGET_TRIPLE)-ld $(CONFIG_PREFIX)/bin
	$(INSTALL) -m 0755 bin/$(CONFIG_TARGET_TRIPLE)-objcopy $(CONFIG_PREFIX)/bin
	mkdir -p $(TOOLCHAIN_INCDIR) $(TOOLCHAIN_LIBDIR)
	cd include/$(CONFIG_TARGET_TRIPLE) && \
	    find . -type d -exec mkdir -p "$(TOOLCHAIN_INCDIR)/{}" \; && \
	    find . -type f -name '*.h' -exec $(INSTALL) -m 0644 \
	    "{}" "$(TOOLCHAIN_INCDIR)/{}" \;
	$(INSTALL) -m 0644 lib/gilbraltar_stub.elf $(TOOLCHAIN_LIBDIR)
	$(INSTALL) -m 0644 lib/gilbraltar_rpi4.elf $(TOOLCHAIN_LIBDIR)
	$(INSTALL) -m 0644 lib/rpi4_link.lds $(TOOLCHAIN_LIBDIR)
	$(INSTALL) -m 0644 lib/stub_link.lds $(TOOLCHAIN_LIBDIR)

.PHONY: install
install: install-toolchain

.PHONY: clean
clean:
	@echo "CLEAN toolchain"
	$(MAKE) -j1 -C lib clean
	$(MAKE) -j1 -C lib cleandep
	$(RM) -r include
	$(RM) -r bin

.PHONY: distclean
distclean: clean
	@echo "DISTCLEAN toolchain"
	$(RM) Makeconf Makeconf.sh
