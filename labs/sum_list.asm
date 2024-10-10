.data
	array: .word 3,4,5
	array2: .word 6,7,8,9,1
.text
	li $a1, 3
	la $a0, array
	jal sum_list
	move $t0, $v0 
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $a1, 5
	la $a0, array2
	jal sum_list
	move $t0, $v0
	li $v0, 1
	move $a0, $t0
	syscall
	
	j exit
	
	sum_list: 
		
		li $v0, 0
	loop: 
		beqz $a1, done
		lw $t0, 0($a0)
		add $v0, $v0, $t0
		addi $a0, $a0, 4
		subi $a1, $a1, 1
		j loop
	done:
		jr $ra

	exit: 
		li $v0, 10
		syscall