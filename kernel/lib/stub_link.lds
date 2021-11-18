ENTRY(_start)

SECTIONS
{
    . = 0x0100000;
    __text_start = .;
    .text : { KEEP(*(.text.boot)) *(.text .text.* .gnu.linkonce.t*) }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    __text_end = .;
    .rodata : { *(.rodata .rodata.* .gnu.linkonce.r*) }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    __rodata_end = .;
    PROVIDE(__data_start = .);
    .data : { *(.data .data.* .gnu.linkonce.d*) }
    __data_end = .;
    .bss (NOLOAD) : {
        . = ALIGN(16);
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        __bss_end = .;
        __bss_size = (__bss_end - __bss_start)>>3;
    }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    __end = .;

   /DISCARD/ : { *(.comment) *(.gnu*) *(.note*) *(.eh_frame*) }
}
