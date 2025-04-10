ENTRY(_start)
SECTIONS {
    . = 0x80200000;    /* Move start address beyond OpenSBI */
    .text : { *(.text) }
    .data : { *(.data) }
    .bss  : { *(.bss) }
}
