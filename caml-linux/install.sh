#!/bin/sh -ex

prefix=${1:-$PREFIX}
if [ "$prefix" = "" ]; then
    prefix=`opam config var prefix`
fi

DESTINC=${prefix}/aarch64-linux-sysroot/include/nolibc
DESTLIB=${prefix}/aarch64-linux-sysroot/lib/nolibc
SYSROOT=${prefix}/aarch64-linux-sysroot
mkdir -p ${DESTINC} ${DESTLIB} ${SYSROOT}

# OCaml
MAKE=${MAKE:=make}
${MAKE} -C ocaml install

# META: ocamlfind and other build utilities test for existance ${DESTLIB}/META
# when figuring out whether a library is installed
touch ${DESTLIB}/META

# findlib
mkdir -p ${prefix}/lib/findlib.conf.d 
cp aarch64_linux.conf ${prefix}/lib/findlib.conf.d/aarch64_linux.conf

# dummy packages
mkdir -p ${SYSROOT}/lib/threads
touch ${SYSROOT}/lib/threads/META # for ocamlfind
