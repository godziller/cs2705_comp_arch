.data
	prompt1: .asciiz "Enter number: "
.text
	li $v0, 4
	la $a0, prompt1
	syscall
	
	li $v0, 5	#reading input for int
	syscall
	move $t0, $v0
	
	nor $t0, $t0, $zero 	#to get inverted value of binary
	
	#add everything by 1
	addi $a0, $t0, 1
	
	#shimmy 
	sll $a0, $a0, 1
	srl $a0, $a0, 1
	li $v0, 1
	syscall

	
	li $v0, 10	#exiting the program
	syscall