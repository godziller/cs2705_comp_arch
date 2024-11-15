.data
	message: .asciiz "The processor is doing useful work until it is interrupted - itteration  ####\n"
.text
	j get_char
	li $s0, 0		#setting counter to 0 
	
	message_print:
		li $v0, 4
		la $a0, message
		syscall 
		subi $s0,$s0, 500
		j get_char
	
		
	get_char:
		lui $t0, 0xffff      	# t0 = address of Keyboard control register  0xffff 0000
		li $t1, 1            	# ready bit MASK (least significant bit) 0x0000 0001
		
	key_wait:
		addi $s0, $s0, 1
		beq $s0, 500, message_print
		lbu $t2, ($t0)      	# Read keyboard control register  at  xffff 0000
		and $t2, $t2, $t1 		# Apply ready bit  mask 
		beqz $t2, key_wait  			# 0 no key press --> busy waiting , 1 a key is pressed	
		lbu $a0, 4($t0)      	# load RECEIVER_DATA to $a0 
		bne $t2, 0, exit

	exit:
		li $v0, 1
		syscall
	