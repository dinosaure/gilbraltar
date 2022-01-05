#include <string.h>
#include <stdint.h>
#include <endian.h>

void *memcpy(void *v_dst, const void *v_src, size_t len)
{
  char *dst = v_dst;
  const char *src = v_src;

  for (; len; len--) *dst++ = *src++;
  return v_dst;
}
