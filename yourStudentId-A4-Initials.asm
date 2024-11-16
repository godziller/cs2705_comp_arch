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
	
	print_message:
		li $v0, 4
		la $a0, message
		syscall
		
		#reset the counter 
		li $s0, 0 
		
		#jump to start
		j loop
	
	.kdata	
UNHANDLED_EXCEPTION:	.asciiz "===>      Unhandled exception       <===\n\n"
UNHANDLED_INTERRUPT: 	.asciiz "===>      Unhandled interrupt       <===\n\n"
OVERFLOW_EXCEPTION: 	.asciiz "===>      Arithmetic overflow       <===\n\n" 


# Variables for save/restore of registers used in the handler
	save_v0:    .word   0
	save_a0:    .word   0
	save_at:    .word   0
	
	.ktext 0x80000180
	# Save ALL registers modified in this handler, except $k0 and $k1
		#  we can save registers to static variables.
		sw      $v0, save_v0   #save $v0
		sw      $a0, save_a0  #save $a0
		.set    noat     # do not use $at from here 
		sw      $at, save_at  #save $at
		.set    at       # $at can now be used  
		# starting processing the exception
		mfc0 $k0, $13   		# Get value in CAUSE register
		andi $k1, $k0, 0x00007c  	# Mask all but the exception code (bits 2 - 6) to zero.
		srl  $k1, $k1, 2	  		# Shift two bits to the right to get the exception code in $k1
		beqz $k1, __interrupt	# if exception code is zero --> it is  an interrupt



	__exception:          # exceptions are processed here 
    		# Handle overflow exception
    		beq $k1, 10, __overflow_exception 

    		# Default case: Unhandled Exception
    		j __unhandled_exception 
    
		
	check_next_bit:
		#shifting left to next bit
		addi $t1, $t1, 1	#incrementing the interupt number by 1 
		sll $t0, $t0, 1		#shifting left to get the next bit to check 
		bne $t1 33, check_for_interupt		#if not all the bits are checked, go again
		
		#increment the cycle counter 
		addi $s0, $s0, 1
		beq $s0, 500, print_message
		j loop
		
	    
	__unhandled_exception: 
			# It's not really proper doing syscalls in an exception handler,
			# but this handler is just for demonstration and this keeps it short	
		li $v0, 4	  	#  Use the MARS built-in system call 4 (print string) to print error messsage.
		la $a0, UNHANDLED_EXCEPTION
		syscall 
 		j __resume_from_exception
 		
 	__interrupt: 
	#######################################################
	# >>>>>>>>>>>>>>> ASSIGNMENT PART 3 <<<<<<<<<<<<<<<#
	#######################################################
	# ASSIGNMENT TODO 3: 
	# Value of cause register should already be in $k0. 	
	# Check the pending interrupt bits 
	# for every bit  print "Interrupt x is fired", where x is the 
	# bit number 
	# If the fired interrupt is a keyboard interrupt, 
	# execute the code @ __keyboard_interrupt 


	
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
		
	__keyboard_interrupt:     	
 	
	j __resume
	

__resume_from_exception: 	 
	# When an exception or interrupt occurs, the value of the program counter 
	# ($pc) of the user level program is automatically stored in the exception 
	# program counter (ECP), the $14 in Coprocessor 0. 
        # Get value of EPC (Address of instruction causing the exception).   
        mfc0 $k0, $14
        
	#Practice TODO 2: Uncomment the following two instructions to avoid
	# executing  the same instruction causing the current exception again.        
         addi $k0, $k0, 4    # Skip offending instruction by adding 4 to the value stored in EPC    
         mtc0 $k0, $14      # Update EPC in coprocessor 0.
__resume:
		# Restore registers and reset processor state
		lw      $v0, save_v0    # Restore $v0 before returning
		lw      $a0, save_a0    # Restore $a0 before returning	
		.set    noat            # Prevent assembler from modifying $at
		lw      $at, save_at     # Restore $at before returning
		.set    at
		eret # Use the eret (Exception RETurn) instruction to set $PC to $EPC@C0 
	
		

