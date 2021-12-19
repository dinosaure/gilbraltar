__rpi_load_addr = 0x00000;

ENTRY(__rpi_load_addr)

PHDRS
{
    segment_rx PT_LOAD FLAGS(5); /* 5 == RX */
    segment_rw PT_LOAD FLAGS(6); /* 6 == RW */
}

SECTIONS
{
    . = __rpi_load_addr;
    __start = .;

    __text_start = .;
    .text :
    {
      KEEP(*(.text._start))
      *(.text._start_c)
      *(.text*)
    } :segment_rx
    __text_end = .;

    __rodata_start = .;
    .rodata : ALIGN(8)
    {
      *(.rodata*)
    } :segment_rx
    __rodata_end = .;

    __got_start = .;
    .got : ALIGN(8)
    {
      *(.got*)
    } :segment_rx
    __got_end = .;

    . = 0x01000000; /* 16M */

    __data_start = .;
    .data :
    {
      *(.data*)
    } :segment_rw
    __data_end = .;

    .bss (NOLOAD) : ALIGN(16)
    {
        __bss_start = .;
        *(.bss*);
	. = ALIGN(16);
	__bss_end_exclusive = .;
    } :NONE

    __end = .;
    __boot_core_stack_end_exclusive = 0x2f000000;
}
