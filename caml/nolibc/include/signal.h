#ifndef _SIGNAL_H
#define _SIGNAL_H

#include <stddef.h>

typedef int jmp_buf;
int setjmp(jmp_buf);

typedef void (*sig_handler)(int);
sig_handler signal(int sig, sig_handler func);
#define SIG_DFL (sig_handler) 2
#define SIG_IGN (sig_handler) 1
#define SIG_ERR (sig_handler) NULL
/*
 * The following definitions are not required by the OCaml runtime, but are
 * needed to build the freestanding version of GMP used by Mirage.
 */
#define SIGFPE 1
int raise(int);

#endif
