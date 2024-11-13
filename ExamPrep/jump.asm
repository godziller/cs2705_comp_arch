.data 
	int1: .word 1
	int2: .word 2
	string1: .ascii "hello world\n"
	int3: .word 3
	float1: .float 3.25
	int4: .word 4
	byte1: .byte 5
	byte2: .byte 6
	byte3: .byte 7

.text
	
	li $s0, 4
	li $v0, 1
	move $a0, $s0
	syscall
	
	jal proq1
	

	li $v0, 1
	move $a0, $s0
	syscall
	#call proq 3 here 
	
	j exit
	#create comments on prossible questions 
	
	proq1: 

		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $s0, 4($sp) 
		li $v0, 1
		li $s0, 3
		move $a0, $s0
		syscall
		jal proq2
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		addi $sp, $sp, 8		
		jr $ra 
		
	proq2: 
		addi $sp, $sp, -4
		sw $s0, ($sp) 
		li $v0, 1
		li $s0, 8
		move $a0, $s0
		syscall
		lw $s0,($sp)
		addi $sp, $sp, 4		
		jal proq3
		jr $ra 
	
	proq3:
		#call it 
		#set a0 to a fixed int(5), print this in a loop. create a count down counter(10) and loop over 10 times and print each time you loop 
		#printing the a0 value
		
		addi $t2, $t2, 1 		#incrememnt the counter
		li $a0, 5
		li $v0, 1
		syscall
		beq $t2, 10, exit
		j proq3		#if counter reaches 10
		
		
		
	exit:
		li $v0, 10
		syscall 