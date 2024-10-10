.data 
	prompt1: .asciiz "Please enter your first integer, two char only: "
	car_ret: .asciiz "\n"
	buffer: .space 3 #Need one extra byte to hold the \n, the OS automatically inserts

.text 
	li $v0, 4	#tell OS we are printing
	la $a0, prompt1 #copies from prompt1 to first of vdu
	syscall		#halt and hand to OS
	
	#this block is to get a string through user input 
	li $v0, 8
	la $a0, buffer
	li $a1, 3
	syscall
	
	#adding line break
	li $v0, 4
	la $a0, car_ret
	syscall
	
	li $v0, 1	#printing an integer
	la $t0, buffer	#loading the buffer into t0
	lb $t1, ($t0)
	sub $t1, $t1, 48	#ascci conversion 
	lb $t2, 1($t0)
	sub $t2, $t2, 48
	
	#joining operation
	mul $t1, $t1, 10	#multiply t1 by 10 
	add $t3, $t2, $t1	#add the two terms together
	

	move $a0, $t3	#copying value from t1 to a0 for print
	syscall
	
	la $v0, 10	#exiting
	syscall
	
	


	
	
	#nb -48