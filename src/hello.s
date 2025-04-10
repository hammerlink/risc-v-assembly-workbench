# hello.s
.section .text
.global _start
_start:
    # Load "Hello, World" string address into a0
    la a0, hello_str
    # Load string length into a1
    li a1, 13
    # Syscall number for write (64 in RISC-V Linux ABI)
    li a7, 64
    # File descriptor 1 (stdout)
    li a0, 1
    ecall          # Make the syscall

    # Exit program
    li a7, 93      # Syscall number for exit
    li a0, 0       # Exit code 0
    ecall

.section .data
hello_str:
    .string "Hello, World\n"
