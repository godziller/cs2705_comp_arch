###############################################################################
# USER TEXT SEGMENT
###############################################################################
	.data
		message: .asciiz "the cpu is doing some important work\n"
		character: .ascii ""

	.globl main
	.text
main:
	li $s0, 0 
	# You can uncomment these lines to test exceptions like overflow or bad address
	# addi $s1, $s0, 1  # Trigger an arithmetic overflow exception. 
	# nop
	# lw $s0, 4($zero) # Trigger a bad data address (on load) exception.
	# nop 			# note that this is a user application trying to load a kernel memory
	# teqi $zero, 0   # Trigger a trap exception. 
	#######################################################
	# >>>>>>>>>>>>>>> ASSIGNMENT PART 2 <<<<<<<<<<<<<<<<#
	#######################################################
	# ASSIGNMENT TODO 2: Enable simulator keyboard interrupts. 	
	# Hint: Get the value of the keyboard "control" register and 
	# set the interrupt enable bit WITHOUT changing other bits

        # Enable keyboard interrupts by setting the appropriate bit in the control register
        li $t0, 0xffff        # Load the value to enable the keyboard interrupt (bit 12)
        lui $t1, 0xffff       # Load the address of the keyboard control register
        sw $t0, 0($t1)        # Store the value into the control register to enable the interrupt

infinite_loop: 		
	#######################################################
	# >>>>>>>>>>>>>>> ASSIGNMENT PART 1 <<<<<<<<<<<<<<<<#
	#######################################################
	# This infinite loop simulates the CPU doing something useful
	# write down the code that would print 
	# a line of your choice every 500 iterations
	addi $s0, $s0, 1
	beq $s0, 500, print_message
	j infinite_loop
	
print_message:
	li $s0, 0	#reset the counter
	li $v0, 4 
	la $a0, message
	syscall 
	j infinite_loop
	
###############################################################################
# KERNEL DATA SEGMENT
###############################################################################
		.kdata

UNHANDLED_INTERRUPT: 	.asciiz "===>      Unhandled interrupt       <===\n\n"
KEYBOARD_INTERRUPT: 	.asciiz "===> Keyboard interrupt fired! Pressed key: \n"
# Variables for save/restore of registers used in the handler
	save_v0:    .word   0
	save_a0:    .word   0
	save_at:    .word   0

###############################################################################
# KERNEL TEXT SEGMENT 
###############################################################################
# The kernel handles all exceptions and interrupts.
# The registers $k0 and $k1 should never be used by user level programs and 
# can be used exclusively by the kernel. 

   		.ktext 0x80000180  # store this code starting at this address in kernel part
   		# Save ALL registers modified in this handler, except $k0 and $k1
		sw      $v0, save_v0   #save $v0
		sw      $a0, save_a0   #save $a0
		.set    noat           # do not use $at from here 
		sw      $at, save_at   #save $at
		.set    at             # $at can now be used  
		# starting processing the exception
		mfc0 $k0, $13   		# Get value in CAUSE register
		andi $k1, $k0, 0x00007c  	# Mask all but the exception code (bits 2 - 6) to zero.
		srl  $k1, $k1, 2	  		# Shift two bits to the right to get the exception code in $k1
		beqz $k1, __interrupt	# if exception code is zero --> it is an interrupt
		
__exception:          # exceptions are processed here 
    # Handle overflow exception
    move $k1, $13 



    
    # Default case: Unhandled Exception
    li $v0, 4
    la $a0, UNHANDLED_INTERRUPT
    syscall 
    j __resume_from_exception



__interrupt: 
	#######################################################
	# >>>>>>>>>>>>>>> ASSIGNMENT PART 3 <<<<<<<<<<<<<<<#
	#######################################################
	# Value of cause register should already be in $k0. 	
	# Check the pending interrupt bits 
	# for every bit, print "Interrupt x is fired", where x is the 
	# bit number 
	# If the fired interrupt is a keyboard interrupt, 
	# execute the code @ __keyboard_interrupt 

    # Check the keyboard interrupt bit (bit 8)
    andi $t0, $k0, 0xffff   # Mask the keyboard interrupt bit (bit 12)
    beqz $t0, __unhandled_interrupt   # If the keyboard interrupt bit is not set, go to unhandled interrupt

    # If keyboard interrupt is fired, jump to keyboard interrupt handler
    j __keyboard_interrupt

__unhandled_interrupt:    
  	#  Use the MARS built-in system call 4 (print string) to print error message.	
	li $v0, 4
	la $a0, UNHANDLED_INTERRUPT
	syscall 
 	j __resume
	
#######################################################
# >>>>>>>>>>>>>>> ASSIGNMENT PART 4 <<<<<<<<<<<<<<<#
#######################################################
# ASSIGNMENT TODO 4: 
# Get the ASCII value of the pressed key from the memory-mapped receiver 
# data register. (MMIO tool). Print char to the STDIO using a proper syscall. 
# Make any unecessary changes in ktext and kdata to perform this task

__keyboard_interrupt: 
	# Get the ASCII value of the pressed key from the keyboard's data register
    lui $t1, 0xffff  # Load the base address for MMIO for keyboard (use the correct address in your setup)
    lw  $t2, 4($t1)  # Load the value of the pressed key into $t2

	
	# Print the newline after the character
	li $v0, 4         # System call for printing a string
	la $a0, KEYBOARD_INTERRUPT
	syscall
	
    # Print the pressed key
	li $v0, 11        # System call for printing a character
	la $a0, ($t2)     # Move the character to $a0
	syscall
	j __resume_from_exception

__resume_from_exception: 	 
	# When an exception or interrupt occurs, the value of the program counter 
	# ($pc) of the user level program is automatically stored in the exception 
	# program counter (ECP), the $14 in Coprocessor 0. 
        # Get value of EPC (Address of instruction causing the exception).   
        mfc0 $k0, $14
        
	# Skip offending instruction by adding 4 to the value stored in EPC    
        addi $k0, $k0, 4      # Increment the EPC by 4 to skip the offending instruction
        mtc0 $k0, $14         # Update EPC in coprocessor 0
	eret                   # Return from exception and continue execution of the program

__resume:
	j __resume_from_exception 
