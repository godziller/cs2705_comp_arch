.data

.text
	li $t0, 8
	srl $t2, $t0, 2
	la $a0, ($t2) 
	li $v0, 1
	syscall