# hello.s
.section .text
.global _start
_start:
    # Set up stack pointer (optional for this example, but good practice)
    li sp, 0x80010000

    # SBI console output: print "Hello, World\n"
    la a0, hello_str     # Load address of string into a0
    call sbi_puts        # Call the subroutine to print it

    # Exit cleanly using SBI system reset
    li a7, 0x5555        # SBI call number for system reset (shutdown)
    li a0, 0             # Argument: shutdown type (0 = shutdown)
    ecall                # Invoke SBI

# Subroutine to print string using SBI console_putc
sbi_puts:
    mv t0, a0            # Save string address in t0
1:  lb a0, (t0)         # Load byte from string
    beqz a0, 2f          # If null terminator, exit loop
    li a7, 1             # SBI call number for console_putc
    ecall                # Print single character
    addi t0, t0, 1       # Move to next character
    j 1b                 # Repeat
2:  ret                  # Return

.section .data
hello_str:
    .string "Hello, World\n"
