ENTRY(_start)

SECTIONS
{
    . = 0x80000;
    __text_start = .;
    .text :
    {
      KEEP(*(.text.boot))
      *(.text)
    }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    __text_end = .;
    .rodata :
    {
      *(.rodata)
    }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    __rodata_end = .;
    .data :
    {
      *(.data)
    }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    __data_end = .;

    __bss_start = .;
    .bss (NOLOAD) : {
        bss = .;
        *(.bss)
    }
    . = ALIGN(CONSTANT(MAXPAGESIZE));
    __bss_end = .;
    __bss_size = (__bss_end - __bss_start);
    __end = .;
}
