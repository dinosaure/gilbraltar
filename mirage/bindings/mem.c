#include <caml/memory.h>
#include <stdint.h>

static inline void barrier_dmb(void) { __asm("dmb sy"); }
static inline void unsafe_set_uint64(uint64_t addr, uint64_t v) {
  *(volatile uint64_t *)addr = v;
}
static inline void unsafe_set_uint32(uint64_t addr, uint32_t v) {
  *(volatile uint32_t *)addr = v;
}
static inline uint32_t unsafe_get_uint32(uint64_t addr) {
  return *(volatile uint32_t *)addr;
}

CAMLprim value gilbraltar_barrier_dmb(value __unit()) {
  barrier_dmb();
  return Val_unit;
}

CAMLprim value gilbraltar_unsafe_set_uint64(value addr, value v) {
  unsafe_set_uint64(Nativeint_val(addr), Int64_val(v));
  return Val_unit;
}

CAMLprim value gilbraltar_unsafe_set_unboxed_uint64(intnat addr, uint64_t v) {
  unsafe_set_uint64(addr, v);
  return Val_unit;
}

CAMLprim value gilbraltar_unsafe_set_int32(value addr, value v) {
  unsafe_set_uint32(Nativeint_val(addr), Int32_val(v));
  return Val_unit;
}

CAMLprim value gilbraltar_unsafe_set_unboxed_int32(intnat addr, uint32_t v) {
  unsafe_set_uint32(addr, v);
  return Val_unit;
}

static uint64_t elapsed_us(void) {
  /* See BCM2711, Chapter 10: System timer. */
  uint32_t hi = unsafe_get_uint32(0xfe000000L + 0x003000L + 0x04L);
  uint32_t lo = unsafe_get_uint32(0xfe000000L + 0x003000L + 0x08L);
  return ((hi << 32) | lo);
}

CAMLprim value gilbraltar_elapsed_us(value __unit()) {
  return (caml_copy_int64(elapsed_us()));
}

uint64_t gilbraltar_elapsed_us_unboxed(value __unit()) {
  return (elapsed_us());
}

static void sleep_us(uint64_t n) {
  uint64_t r;
  uint64_t t = elapsed_us() + n;
  do {
    r = elapsed_us();
  } while (r < t);
}
/* XXX(dinosaure): I'm not sure about this function, we
 * surely can use [cntpct_el0] which is ARMv8 register
 * available. But BCM2711 provides a system timer with
 * a free counter. I'm not sure about the accurrency between
 * them... */

CAMLprim value gilbraltar_sleep_us(value n) {
  sleep_us(Int64_val(n));
  return Val_unit;
}

CAMLprim value gilbraltar_sleep_us_unboxed(uint64_t n) {
  sleep_us(n);
  return Val_unit;
}
