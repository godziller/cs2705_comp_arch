.data 
myString: .space 40
prompt1: .asciiz "Please enter your String: "
.text 
main:
		li $s0,0  # s0 represents the number of processed characters 
		
		la $a0, prompt1		#load prompt into vdu
		li $v0, 4		#calling for string print
		syscall 
		li $v0, 8
		move $t0, $v0
		syscall
		
repeat: 	
		la $a0, myString     	#sys8 argument 1
		li $a1 30		     	#sys8 argument 2
		jal mysys8			# call sys8 procedure
		la $a0, myString	# use syscall 4 to print the received string 
		li $v0, 4
		syscall 		
		#  The program is finished. Exit.
 		li   $v0, 10          # system call for exit
 		syscall               # Exit!
 # TODO   ==============================================
 		# using IO interfacing (keyboard and display simulator) 
 		# parse user string into the memory address provided in $a0 
 		# and up to the number of characters provided in $a1 
 		
 		# Note that syscall 8 
 		# For specified length n, string can be no longer than n-1. 
 		# If less than that, adds newline to end. 
 		# In either case, then pads with null byte.
 		
 		#  you would need to use parts of "lab 3 - simple IO.asm"
 		# note that sys8 may implement IO operation in a single
 		# procedure. Alternatively, it can be done by calling other
 		# procedures. 
 # =====================================================
  mysys8:
  		# your implementation goes here

 		
 		jr $ra
