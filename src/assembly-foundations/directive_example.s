# define exit as 93
.equ exit, 93
# program code
.section .text
# export _start for linker
.globl  _start
_start:
        li      a7, exit
        ecall
# data: init one word (16-bit value) with 1 and read/write
.section .data
counter:
.word 1
# rodata: constant text string
.section .rodata
text_begin:
.asciz  "Text"
text_end:
# current address minus address of text_begin = length of text
.byte .-text_begin
# non initialized block with same size as the text
.section .bss 
# start next part by address aligned to multiple of 2^2 = 4
.align 2
copy_begin:
.zero text_end-text_begin
