.data
a: .word 429496726     # 2^32
b: .word 429496726              # Second operand

.text
.globl main
main:
    # Load the values of 'a' and 'b' into registers
    lw $t0, a        # Load 'a' into $t0 (a = 2^32)
    lw $t1, b        # Load 'b' into $t1 (b = 2)
    
    # Multiply $t0 and $t1
    mult $t0, $t1    # Multiply $t0 by $t1. Result stored in HI (upper 32 bits) and LO (lower 32 bits)
    
    # Access the result:
    mflo $t2         # Move the lower 32 bits of the result from LO into $t2
    mfhi $t3         # Move the upper 32 bits of the result from HI into $t3
    
    # After multiplication:
    # $t2 will hold the lower 32 bits of the result (0 in this case)
    # $t3 will hold the upper 32 bits of the result (2 in this case)
    
    # Exit the program
    li $v0, 10       # Load exit system call code (10)
    syscall          # Make the system call to exit
