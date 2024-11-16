.data
	message: .asciiz "The processor is doing useful work until it is interrupted - itteration  ####\n"
	interupt_message: .asciiz "Interrupt x is fired\n"
	inactive_msg: .asciiz "Interrupt x is inactive\n"

.text
	main:
		
		li $s0, 0		#setting counter to 0 
	
	loop:
		#regularly calling the message print
		li $v0, 4
		la $a0, message
		syscall 
		
		mfc0 $k0, $13	#move the cause bit into the 
		li $t0, 0x1	#this is our mask used for checking bits
		li $t1, 32	#32 interupt bits 
	
	check_for_interupt:
		and $t2, $k0, $t0	#checking to see if bit is set. using mask
		beqz $t2, interupt_innactive		#if bit not set then interupt is innactive
		
		#if the bit is 1 then an interupt is to be triggered 
		li $v0, 4
		la $a0, interupt_message
		syscall
		
		#print the interupt number
		move $a0, $t1		
		li $v0, 1
		syscall
		
		j check_next_bit
		
	interupt_innactive:
		#print the message and print the interupt number
		li $v0, 1
		la $a0, inactive_msg
		syscall 
		
		move $a0, $t0	
		li $v0, 1
		syscall
		
		
	check_next_bit:
		#shifting left to next bit
		addi $t1, $t1, 1	#incrementing the interupt number by 1 
		sll $t0, $t0, 1		#shifting left to get the next bit to check 
		bne $t1 33, check_for_interupt		#if not all the bits are checked, go again
		
		#increment the cycle counter 
		addi $s0, $s0, 1
		beq $s0, 500, print_message
		j loop
		
	print_message:
		li $v0, 4
		la $a0, message
		syscall
		
		#reset the counter 
		li $s0, 0 
		
		#jump to start
		j loop 
		

