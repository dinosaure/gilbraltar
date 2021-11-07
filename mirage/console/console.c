#include <caml/mlvalues.h>

static void mmio_write(long reg, unsigned int val) { *(volatile unsigned int *)reg = val; }
static unsigned int mmio_read(long reg) { return *(volatile unsigned int *)reg; }

#define PERIPHERAL_BASE 0xFE000000
#define AUX_BASE        (PERIPHERAL_BASE + 0x215000)
#define AUX_MU_LSR_REG  (AUX_BASE + 84)
#define AUX_MU_IO_REG   (AUX_BASE + 64)

#ifndef __unused
#define __unused(x) x __attribute__((unused))
#endif
#define __unit() value __unused(unit)

CAMLprim value
gilbraltar_serial_rd_ready(__unit()) {
  value ret = (mmio_read(AUX_MU_LSR_REG) & 0x01) ? Val_true : Val_false;
  return ret;
}

CAMLprim value
gilbraltar_serial_wr_ready(__unit()) {
  value ret = (mmio_read(AUX_MU_LSR_REG) & 0x20) ? Val_true : Val_false;
  return ret;
}

CAMLprim value
gilbraltar_serial_rd(__unit()) {
  value ret = Val_int ((unsigned char)mmio_read(AUX_MU_IO_REG));
  return ret;
}

CAMLprim value
gilbraltar_serial_wr(value vchr) {
  unsigned int chr = Int_val (vchr);
  mmio_write(AUX_MU_IO_REG, chr);
  return Val_unit;
}
