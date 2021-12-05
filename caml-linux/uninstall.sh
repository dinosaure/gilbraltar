#!/bin/sh -ex

prefix=$1
if [ "$prefix" = "" ]; then
  prefix=`opam config var prefix`
fi

odir=$prefix/lib
rm -f $odir/findlib.conf.d/aarch64_linux.conf
rm -rf $prefix/aarch64-linux-sysroot
