.data
	in_string: .asciiz "abcd"
	out_string: .asciiz "efgh"
.text
	li $t0, 8
	addi $sp,$sp, -4
	sw $t0, 0($sp)
	
	la $a0, in_string
	la $a1, out_string
	jal strcpy
	j exit
	strcpy: 
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		add $s0, $zero, $zero
	next:
		add $t1, $s0,$a1
		lbu $t2, 0($t1)
		add $t3, $s0, $a0
		sb $t2, 0($t3)
		beq $t2, $zero, exitloop
		addi $s0, $s0, 1
		j next 
	
	exitloop: 
		lw $s0,0($sp)
		addi $sp, $sp, 4
		jr $ra
		
	exit: 
		lw $a0, 0($sp)
		addi $sp, $sp, 4
		li $v0, 1
		syscall
		li $v0, 10
		syscall