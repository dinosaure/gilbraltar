#!/bin/sh -ex

prefix=$1
if [ "$prefix" = "" ]; then
  prefix=`opam config var prefix`
fi

odir=$prefix/lib
rm -f $odir/findlib.conf.d/rpi4.conf
rm -rf $prefix/rpi4-sysroot
