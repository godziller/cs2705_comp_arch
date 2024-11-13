.data
a: .word 19   # 2^33
b: .word 2            # Divisor = 2

.text
.globl main
main:
    # Load the values of 'a' and 'b' into registers
    lw $t0, a        # Load 'a' into $t0 (a = 2^33)
    lw $t1, b        # Load 'b' into $t1 (b = 2)
    
    # Perform the division
    div $t0, $t1     # Divide $t0 by $t1. Result (quotient) goes to LO, remainder goes to HI
    
    # Access the result:
    mflo $t2         # Move the quotient (result) from LO into $t2
    mfhi $t3         # Move the remainder from HI into $t3
    
    # After division:
    # $t2 will hold the quotient (2^32 = 4294967296)
    # $t3 will hold the remainder (0, because 8589934592 % 2 = 0)
    
    # Exit the program
    li $v0, 10       # Load exit system call code (10)
    syscall          # Make the system call to exit