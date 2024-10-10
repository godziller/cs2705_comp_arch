.data
	prompt1: .asciiz "PLease enter a NUmber between 0-99:"
	prompt2: .asciiz "The binary representation of your number is:\n"
.text
	li $v0, 4
	la $a0, prompt1
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0	#t0 is the user string
	
	li $v0, 4
	la $a0, prompt2
	syscall

	li $t1, 128	#this is our mask
	li $t3, 8 	#loop counter
	loop:
		
		
		beq $t3, 0, exit	#breaking condition
		
		and $t2, $t1, $t0
		beqz $t2, print_0
		
		print_1:
			li $v0, 1
			li $a0, 1
			syscall
			j end_if
		print_0:
			li $v0, 1
			li $a0, 0
			syscall
		
		end_if:
		srl $t1, $t1, 1
		sub $t3,$t3,1	#decrementing the loop
		j loop
		
	exit:
		li $v0, 10
		syscall
		