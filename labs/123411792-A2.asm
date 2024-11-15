 .data
	inputStr: .space 8        # reserve 3 bytes in the memory to be used for taking user input [xxx.yyy]
	str2float: .float 
	thousand: .float 1000.0 
	announce: .asciiz "your name 123411792 is implementing the core assignment\n"
	expStr: .asciiz "\nThe exponent part of the string is: \n"
	fracStr: .asciiz "\nThe fractional part of the string is: \n"
	finalStr: .asciiz "\n Final Added float registers: \n"
	prompt1: .asciiz "$ Enter a real number [xxx.yyy]:"


	testStr: .ascii "123.456"


.text

main:
	#print the announcement string as requested 
	li $v0, 4
	la $a0, announce
	syscall
	
	#prompt the user to enter a real number 
	li $v0, 4
	la $a0, prompt1
	syscall
	
	#call for input --> this will be of string type which we must process
	li $v0, 8
	li $a1, 8
	la $a0, inputStr     		
	syscall
	move $t0, $a0	#this is the starting address of the input string 
	move $t1, $a1	#this is the character count
	
	la $a0, inputStr
	li $a1, 7
	jal find_decimal
	move $s0, $v0	# s0 we use to store the number of xs
	
	la $a0, inputStr
	move $a1, $s0
	jal str_to_int
	move $s1, $v0	# use s1 to store the exponent integer
	
	
	li $a1, 7	# we know our string is 7 ascii chars
	move $t0, $s0	#this will be the number for the length of "x"s .
	sub $a1, $a1, $t0
	subi $a1, $a1, 1	# a1 should not have the number of ys
	add $t0, $t0, 1 	#the index of the start of the fractional part of the string.
	la $a0, inputStr		#using this for testing atm.
	addu $a0, $a0, $t0	#a0 should now point to the start of the decimal string.

	jal str_to_int
	move $s2, $v0	#s2 now has the integer representation of the decimal part of the string.	
	
	
	
	# AT THIS POINT S0 AND S1 HAVE THE EXPONENT AND FRACTION AS INTEGERS.
	#NEED TO TRANSFER TO FLOATING POINT REGISTERS AND CONVERT
	

	mtc1 $s1, $f1        # Move the integer (Exponent) in $s1 to floating-point register $f1
	cvt.s.w $f1, $f1     # Convert the integer in $f1 to single-precision float
	
	mtc1 $s2, $f2        # Move the integer(Fraction) in $s2 to floating-point register $f2
	cvt.s.w $f2, $f2     # Convert the integer in $f2 to single-precision float
	
	li $v0, 4
	la $a0, expStr
	syscall
	mov.s $f12, $f1 	# Move to OS output register
	li $v0, 2
	syscall
	

	lwc1 $f3, thousand    # Load the float value 1000.0 into $f3
	div.s $f2, $f2, $f3  # Divide $f2 by $f3, result in $f2
	mov.s $f12, $f2
	
	li $v0, 4
	la $a0, fracStr
	syscall
	li $v0, 2
	syscall
	
	# Add the two parts
	add.s $f1, $f1, $f2
	mov.s $f12, $f1		# Move to OS output register
	li $v0, 4
	la $a0, finalStr
	syscall
	li $v0, 2
	syscall
	
	# Need to now store this 
	s.s $f12, str2float
	

	
	li $v0, 1
	move $a0, $s1
	syscall
	
finish:
	li $v0, 10
	syscall	
	

	
	
	
	
	#this is a procedure that takes an abstract string, and returns an integer representing -
	#the number of characters that represent the exponent. 
	#using a0 as address of string, using v0 to return the result. 
	find_decimal:
	addi $sp, $sp, -12 # adjust stack for 3 item
	sw $s0, 8($sp)    # save $s0
	sw $s1, 4($sp)    # save $s1
	sw $s2, 0($sp)    # save $s2
	
	add $s0, $zero, $zero # i = 0

	#2E = . 
	li $t0, 0x2E	#using t0 to represent the decimal.
	la $s1, ($a0)	#$s1 now contains the start of our string
	li $t1, 0	#t1 will be our counter.
	li $v0, 0	#going to use v0 as our running value
	
	
	
	find_loop:
	addu $t2, $s1, $t1   	# $t2 = base address in $s1 + offset in $t1
	lbu $t3, 0($t2)		#now using $t2 we can shuffle along one byte at a time in the loop
	beq $t3, $t0, find_exit		#checking if the character is a "." character
	addi $v0, $v0, 1	#increment the position value.
	addi $t1, $t1, 1
	j find_loop 
	
	find_exit:
	lw $s2, 0($sp)    # restore $s2
	lw $s1, 4($sp)    # restore $s1
	lw $s0, 8($sp)    # restore $s0
	addi $sp, $sp, 12 # adjust stack pointer back
	jr $ra
	
	
	#this is a procedure that takes in an address of a string, representing an integer, plus the length 
	#using $a0 for the address of the string, and $a1 for the number of digits to process
	#using $v0 for the integer return value
	str_to_int:
	addi $sp, $sp, -12 # adjust stack for 3 item
	sw $s0, 8($sp)    # save $s0
	sw $s1, 4($sp)    # save $s1
	sw $s2, 0($sp)    # save $s2

	add $s0, $zero, $zero # i = 0
	
	# comvert into integer
	la $s1, ($a0)	#$s1 now contains the start of our string
	move $t0, $a1	#t0 will help us figure out if its 100s, 10s or 1s
	
	add $t3, $zero, 1	#using t3 as our  multiplier
	sub $t0, $t0, 1		#using $t0 as an index into the string
	
	loop:
	addu $t2, $s1, $t0   	# $t2 = base address in $s1 + offset in $t0
	lbu $t1, 0($t2)		#now using $t2 we can shuffle along one byte at a time in the loop
	
	sub $t1, $t1, 48	#converted from asscii to int 
	mul $t1, $t3, $t1
	add $s2, $s2, $t1	#using s2 for running sum 
	
	beqz $t0, exit
	sub $t0, $t0, 1
	mul $t3, $t3, 10
	j loop
	
exit:
	move $v0, $s2	# using a3 to pass result back to caller 
	lw $s2, 0($sp)    # restore $s2
	lw $s1, 4($sp)    # restore $s1
	lw $s0, 8($sp)    # restore $s0
	addi $sp, $sp, 12 # adjust stack pointer back
	jr $ra
	
int_to_ascii_hex_str:

	# need to do some kinda mapping here between the int and ascii table.
	# what we are chasing is 0xFF - so we need to do some mapping to tear out each 4bits and focus on each.
	# with one 4 bits isolated. If its <10 then a simple +48 to get the ASCII rep of that int
	# however if it is 10-16, then we need to get to A-F
	# A = 10 = 65 in ascii - so if our 4 bits are 10 and we add 55 we get A
	# F = 15 = 70 -- so again the add 55 looks like it could work

	
