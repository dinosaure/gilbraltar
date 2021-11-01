SECTIONS
{
    . = 0x01000000;     /* Kernel load address for AArch64 + U-boot */
    _stext = .;
    .text : { KEEP(*(.text.boot)) *(.text .text.* .gnu.linkonce.t*) }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    _etext = .;
    .rodata : { *(.rodata .rodata.* .gnu.linkonce.r*) }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    _erodata = .;
    PROVIDE(_data = .);
    .data : { *(.data .data.* .gnu.linkonce.d*) }
    .bss (NOLOAD) : {
        . = ALIGN(16);
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        __bss_end = .;
    }
    _end = .;

   /DISCARD/ : { *(.comment) *(.gnu*) *(.note*) *(.eh_frame*) }
}
__bss_size = (__bss_end - __bss_start)>>3;
