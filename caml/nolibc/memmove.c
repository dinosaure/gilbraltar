#include <string.h>
#include <stdint.h>
#include <stdio.h>

void *memmove(void *v_dst, const void *v_src, size_t len)
{
  char *dst = v_dst;
  const char *src = v_src;

  if (dst == src) return dst;
  if (src + len <= dst || dst + len <= src) return memcpy(dst, src, len) ;

  if (dst < src)
    for (; len; len--) *dst++ = *src++;
  else
    while (len) len--, dst[len] = src[len];

  return dst;
}
