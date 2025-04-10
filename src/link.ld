ENTRY(_start)
SECTIONS {
    . = 0x80000000;    /* Start at RAM base */
    .text : { *(.text) }
    .data : { *(.data) }
    .bss  : { *(.bss) }
}
