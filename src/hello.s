# hello.s
.section .text
.global _start
_start:
    li sp, 0x80010000    # Set stack pointer
    la a0, hello_str     # Load string address
    call sbi_puts        # Print "Hello, World"

    # SBI system reset (modern SBI SRST extension)
    li a7, 8             # SBI call base for extensions (0x08 for SRST)
    li a6, 0             # Function ID: 0 (system reset)
    li a0, 0             # Reset type: 0 (shutdown)
    li a1, 0             # Reset reason: 0 (no reason)
    ecall                # Should shut down QEMU

    # Fallback: infinite loop if shutdown fails
1:  j 1b                 # Hang here if ecall doesn’t terminate

sbi_puts:
    mv t0, a0
1:  lb a0, (t0)
    beqz a0, 2f
    li a7, 1             # SBI console_putc
    ecall
    addi t0, t0, 1
    j 1b
2:  ret

.section .data
hello_str:
    .string "Hello, World\n"
