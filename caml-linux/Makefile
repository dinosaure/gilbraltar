.PHONY: all clean install uninstall distclean ocaml

include Makeconf

all:	ocaml aarch64_linux.conf

TOP=$(abspath .)


# OCAML
ocaml/Makefile:
	cp -r `ocamlfind query ocaml-src` ./ocaml
# Makefile: Disable build of ocamltest (for 4.10)
	sed -i -e 's/$$(MAKE) -C ocamltest all//g' ocaml/Makefile
# runtime/Makefile: Runtime rules: don't build libcamlrun.a and import ocamlrun from the system
	sed -i -e 's/^all: $$(BYTECODE_STATIC_LIBRARIES) $$(BYTECODE_SHARED_LIBRARIES)/all: primitives ld.conf/' ocaml/runtime/Makefile
	sed -i -e 's/^ocamlrun$$(EXE):.*/dummy:/g' ocaml/runtime/Makefile
	sed -i -e 's/^ocamlruni$$(EXE):.*/dummyi:/g' ocaml/runtime/Makefile
	sed -i -e 's/^ocamlrund$$(EXE):.*/dummyd:/g' ocaml/runtime/Makefile
	echo -e "ocamlrun:\n\tcp $(shell which ocamlrun) .\n" >> ocaml/runtime/Makefile
	echo -e "ocamlrund:\n\tcp $(shell which ocamlrund) .\n" >> ocaml/runtime/Makefile
	echo -e "ocamlruni:\n\tcp $(shell which ocamlruni) .\n" >> ocaml/runtime/Makefile
	touch ocaml/runtime/libcamlrun.a ocaml/runtime/libcamlrund.a ocaml/runtime/libcamlruni.a
# yacc/Makefile: import ocamlyacc from the system
	sed -i -e 's/^ocamlyacc$$(EXE):.*/dummy:/g' ocaml/yacc/Makefile
	echo -e "ocamlyacc:\n\tcp $(shell which ocamlyacc) .\n" >> ocaml/yacc/Makefile
# tools/Makefile: stub out objinfo_helper 
	echo -e "objinfo_helper:\n\ttouch objinfo_helper\n" >> ocaml/tools/Makefile

# OCaml >= 4.08.0 uses an autotools-based build system. In this case we
# convince it to think it's using the Solo5 compiler as a cross compiler, and
# let the build system do its work with as little additional changes on our
# side as possible.
#
# Notes:
#
# - CPPFLAGS must be set for configure as well as CC, otherwise it complains
#   about headers due to differences of opinion between the preprocessor and
#   compiler.
# - ARCH must be overridden manually in Makefile.config due to the use of
#   hardcoded combinations in the OCaml configure.
# - We use LIBS with a stubbed out solo5 implementation to override the OCaml 
# 	configure link test
# - We override OCAML_OS_TYPE since configure just hardcodes it to "Unix".
# - We override HAS_SOCKETS because of a bug in the ocaml configure script that
# 	always enables sockets.
ocaml/Makefile.config: ocaml/Makefile
	cd ocaml && \
		CC="$(MAKECONF_CC)" \
		AS="$(MAKECONF_AS)" \
		ASPP="$(MAKECONF_CC) $(OC_CFLAGS) -c" \
		LD="$(MAKECONF_LD)" \
		ac_cv_prog_DIRECT_LD="$(MAKECONF_LD)" \
	  ./configure \
		-host=$(MAKECONF_BUILD_ARCH)-linux-gnu \
		-prefix $(MAKECONF_PREFIX)/aarch64-linux-sysroot \
		-disable-shared\
		-disable-systhreads\
		-disable-instrumented-runtime \
		-enable-debugger=no\
		-disable-ocamldoc\
		$(MAKECONF_OCAML_CONFIGURE_OPTIONS)
	echo "ARCH=$(MAKECONF_OCAML_BUILD_ARCH)" >> ocaml/Makefile.config
	echo 'SAK_CC=cc' >> ocaml/Makefile.config
	echo 'SAK_CFLAGS=' >> ocaml/Makefile.config
	echo 'SAK_LINK=cc $(SAK_CFLAGS) $$(OUTPUTEXE)$$(1) $$(2)' >> ocaml/Makefile.config

ocaml/runtime/caml/version.h: ocaml/Makefile.config
	ocaml/tools/make-version-header.sh > $@

CAMLOPT:=$(shell which ocamlopt)
CAMLRUN:=$(shell which ocamlrun)
CAMLC:=$(shell which ocamlc)

ocaml: ocaml/Makefile.config ocaml/runtime/caml/version.h
	$(MAKE) -C ocaml world
	$(MAKE) -C ocaml opt

aarch64_linux.conf: aarch64_linux.conf.in
	sed -e 's!@@PREFIX@@!$(MAKECONF_PREFIX)!' \
	    aarch64_linux.conf.in > $@

# COMMANDS
install: all
	MAKE=$(MAKE) PREFIX=$(MAKECONF_PREFIX) ./install.sh

uninstall:
	./uninstall.sh

clean:
	$(RM) -r ocaml/
	$(RM) aarch64_linux.conf

distclean: clean
	rm Makeconf
