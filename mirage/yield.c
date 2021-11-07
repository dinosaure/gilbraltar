#include <stdint.h>

extern uint64_t mclock(void); // Provided by [gilbraltar_rpi4.elf]

static void mmio_write(long reg, unsigned int val) { *(volatile unsigned int *)reg = val; }
static unsigned int mmio_read(long reg) { return *(volatile unsigned int *)reg; }

#define PERIPHERAL_BASE 0xFE000000
#define AUX_BASE        (PERIPHERAL_BASE + 0x215000)
#define AUX_MU_LSR_REG  (AUX_BASE + 84)

/* XXX(dinosaure): this implementation is the essential one for [mirage]/[lwt]
 * to be able to schedule concurrently _fibers_. It handles console which has
 * a fixed address into our RPi4.
 *
 * Of course, we should extend this code with "dynamic" _handle_ (which come
 * from devices's [connect]). But the logic is pretty simple, waiting and check
 * if we have something from our serial port.
 */

static void wait_msec(unsigned int n) {
    register unsigned long f, t, r;
    // get the current counter frequency
    asm volatile ("mrs %0, cntfrq_el0" : "=r"(f));
    // read the current counter
    asm volatile ("mrs %0, cntpct_el0" : "=r"(t));
    // calculate expire value for counter
    t += ((f/1000)*n)/1000;
    do { asm volatile ("mrs %0, cntpct_el0" : "=r"(r)); } while(r < t);
}

uint64_t gilbraltar_yield(uint64_t timeout) {
   uint64_t ready_set = 0;

   do {
     ready_set |= ((mmio_read(AUX_MU_LSR_REG) & 0x01) ? 1 : 0) << 0;
     ready_set |= ((mmio_read(AUX_MU_LSR_REG) & 0x20) ? 1 : 0) << 1;
     wait_msec(1);
   } while (mclock() < timeout && ready_set == 0);

   return ready_set;
}
