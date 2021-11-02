#include <stddef.h>

void *memset(void *dest, int c, size_t n);
void *memcpy(void *restrict dest, const void *restrict src, size_t n);
void *memmove(void *dest, const void *src, size_t n);
int memcmp(const void *vl, const void *vr, size_t n);
int strcmp(const char *l, const char *r);
int strncmp(const char *l, const char *r, size_t n);
char *strcpy(char *restrict dest, const char *restrict src);
size_t strlen(const char *s);
int isspace(int c);
