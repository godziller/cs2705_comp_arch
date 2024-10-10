.data 
array: .word 5,10,15
.text
.globl main 
main: la $t4, array
	li $t5, 0
	li $t3, 0
	li $t6, 3

loop: lw $t0, 0($t4)
	add $t3, $t3, $t0
	addi $t4, $t4, 4
	addi $t5, $t5, 1
	
	bne $t5, $t3, loop
	move $a0, $t3
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	blt $t0, $t1, loop