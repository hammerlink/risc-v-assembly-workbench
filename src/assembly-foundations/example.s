.text 
.globl _start
_start:
      # debug:
      auipc x2, %hi(there)
      addi x2, x2, %lo(there)
      lui x1, %hi(there) # hi = upper 20 bits
      addi x1, x1, %lo(there) # lo = lower 12 bits
      jal x1, there
      addi x10, x0, 7
      addi x10, x0, 7
      bge x10, x0, there
      addi x17, x0, 93 # this triggers the exit syscall
      ecall

.align 5 # address was 0x100d8 after align 4 => 0x100E0, align 5 should be 0x10100
there:
      addi x10, x0, 11
      jal x1, end

end:
    addi x17, x0, 93
    ecall
