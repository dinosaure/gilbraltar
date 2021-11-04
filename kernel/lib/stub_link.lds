ENTRY(_start)

SECTIONS
{
    . = 0x0100000;
    _stext = .;
    .text : { KEEP(*(.text.boot)) *(.text .text.* .gnu.linkonce.t*) }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    _etext = .;
    .rodata : { *(.rodata .rodata.* .gnu.linkonce.r*) }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    _erodata = .;
    PROVIDE(_data = .);
    .data : { *(.data .data.* .gnu.linkonce.d*) }
    _edata = .;
    .bss (NOLOAD) : {
        . = ALIGN(16);
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        __bss_end = .;
        __bss_size = (__bss_end - __bss_start)>>3;
    }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    _end = .;

   /DISCARD/ : { *(.comment) *(.gnu*) *(.note*) *(.eh_frame*) }
}
