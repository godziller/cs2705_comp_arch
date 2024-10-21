.data
	str2float: .float 4
	thousand: .float 1000.0 
	exponentHex: .asciiz "0xZZ "
	mantissaHex: .asciiz "0xYYYYYY\n"
	announce: .asciiz "your name 123411792 is implementing the core assignment\n"
	expStr: .asciiz "\nThe exponent part of the string is:\n"
	fracStr: .asciiz "\nThe fractional part of the string is:\n"
	prompt1: .asciiz "$ Enter a real number [xxx.yyy]:"
	inputStr: .space 16        # give enoungh space
	strReturn: .asciiz "\n\n"
	expOut: .asciiz "The exponent of your number is: \n"
	fracOut: .asciiz "\nThe fraction of your number is: \n"

	exponent_mask: .word 0x7F800000
	mantissa_mask: .word 0x007FFFFF
	nipple_mask: .word 0x0000000F


.text

main:

	#=================== The Input Part of the Project =============================#
	#		Ask for input, store it in a string inputStr			#
	#===============================================================================#
	
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
	# $a0 now has the starting address of the input string populated from user 
	#$a1 has the count of this string this is the character count


	#=================== The Input Parsing part of the Project =====================#
	#		with inputStr filled, we now need to break out the		#
	#		whole and the fractional parts - divided by the '.' char
	#		we set a rule 	- s2 will store the whole part
	#				- s3 will store the fractional part
	#===============================================================================#
	
	# First find where the decimal dot is sitting. And thus we can get the whole
	# part char count - i.e. 1.234 = 1, 12.34 = 2, 123.4 = 3
	# $v0 will have the whole number char count		
	jal find_decimal
	move $s0, $v0	# s0 we use to store the number of xs
	
	
	# Looks like we also need to find the length of the string.
	# Reason is, whatever size we set in .data section, if the user enters less
	# then the OS pads out the remaining space, which caused problems with loop
	# processing later.
	jal str_len	
	move $s1, $v0	# set s1 to the valid number of characters
	
	la $a0, inputStr
	move $a1, $s0
	jal str_to_int
	move $s2, $v0	# use s2 to store the exponent integer
	
	# working on the decimal here
	add $a1, $zero, $s1	# a1 set to the char count of string
	subu $a1, $a1, $s0	# remove the x's
	addi $a1, $a1, -1	# remove the '.' character - NOW a1 should not have the number of ys
	
	la $a0, inputStr		#using this for testing atm.
	addu $a0, $a0, $s0		# index in the no ov xs
	addu $a0, $a0, 1 		#a0 should now point to the start of the fractional string.

	jal str_to_int
	move $s3, $v0	#s2 now has the integer representation of the decimal part of the string.	
	
	#=================== The Input Parsing part Debugging===========================#
	#		going to print out and see if we successfully parsed
	#		the whole and the fractional by printing them seperately
	#		this way we know if we are confident to proceed
	#===============================================================================#	
	
	li $v0, 4
	la $a0, expStr
	syscall
		
	li $v0, 1
	move $a0, $s2
	syscall	
	
	li $v0, 4
	la $a0, fracStr
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
	la $a0, strReturn
	syscall
	
	# AT THIS POINT S2 AND S3 HAVE THE EXPONENT AND FRACTION AS INTEGERS.
	#NEED TO TRANSFER TO FLOATING POINT REGISTERS AND CONVERT
	# This is the 1st part of the CA - store the string value as a float in the .data str2float entry
	
	#=================== Final part of Phase1 - putting result into float register--=#
	#		At this point we have whole(s2) and decimal(s3) at hand
	#		Now we want to move and convert into a floating register
	#		Result should have str2float set to the float eqivalent of
	#			decimal.float
	#===============================================================================#	
	
	mtc1 $s2, $f1        # Move the integer (Exponent) in $s2 to floating-point register $f1
	cvt.s.w $f1, $f1     # Convert the integer in $f1 to single-precision float
	
	mtc1 $s3, $f2        # Move the integer(Fraction) in $s3 to floating-point register $f2
	cvt.s.w $f2, $f2     # Convert the integer in $f2 to single-precision float
	
	lwc1 $f3, thousand    # Load the float value 1000.0 into $f3
	div.s $f5, $f2, $f3  # Divide $f2 by $f3, result in $f5
	
	# Add the two parts
	add.s $f4, $f1, $f5	# add the two float together
	
	# Need to now store this 
	s.s $f4, str2float	
	
	mov.s $f12, $f4 	#print for debug
	
	# Going to throw this out on screen and check against https://www.h-schmidt.net/FloatConverter/IEEE754.html
	# and see how we are going...
	li $v0, 2
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 4
	la $a0, strReturn
	syscall

	
	#=================== PHASE2 - printing the hex representation of str2float====-=#
	#	+---------------------------------------------------------------+
	#	| Sign (1 bit) |  Exponent (8 bits)  |    Mantissa (23 bits)    |
	#	+---------------------------------------------------------------+
	#	|      S       |    EEEEEEEE         | FFFFFFFFFFFFFFFFFFFFFFF  |
	#	+---------------------------------------------------------------+
	#	Borrowed ascii art from the web - this is what we are dealing with
	#	A whole pile of masking and shifting to
	#	a) seperate the exponent and the mantissa
	#	b) with each, we need to mask each nipple and convert to ASCII
	#
	#	Approach - we are going to prime 2 .data variables exponentHex &
	#	mantissaHex. Then use the logic below to calc the hex and dump it into
	#	the correct index of those string mentioned - fingers crossed :-)
	#===============================================================================#
				

	# floats are funky need to
	# 1. load address into a regular register
	# 2. load the value at that reg into a specific floating point register so the FPU works on it.
	# 3. move it from that floating point register into a reuglar register
	# 4. as we are doing bit pattern stuff DO NOT do any conversion functions - keep the bits raw as they are born
	
	
	la $t0, str2float
	l.s $f0, 0($t0)		# get the float outa .data and into a float register
	mfc1 $s0, $f0		# now s0 has the float bit pattern	

	
mant2:
	lw  $t0, mantissa_mask
	and $s0, $s0, $t0		#$s0 now has the mantissa exclusively
	add $a0, $s0, $zero		# moving clean s0 into a0
	
	# setting up variable for the looping part
	la $a1, mantissaHex		# string to store result
	add $a2, $zero, 7	# index in our string we work backwards and replace
	and $t9, $t9, $zero		# use t9 as shifter, incremented by 4 each loop and applied to original s0
	
	# now maks the temporary exponent to pull out the rignt most nipple
	lw $t1, nipple_mask
	and $a0, $a0, $t1		# a0 now has the least significant nipple of the mantissa
	
	# At this point, we have $a0 containing the Left most nipple of a mantissa
	# $a1 a pointer to where to store the conversion to ascii result
	# $a2 set to the index into $a1 where to store the actual conversion
loop3:	beq $a2, 1, break3
	jal print_hex

	and $a0, $s0, $t0		#reestablish a0 so we can shift it
	add $t9, $t9, 4		# move shifter along
	srlv $a0, $a0, $t9
	and $a0, $a0, $t1	# a0 now AGAIN has the least significant NEXT nipple of the mantissa
	sub $a2, $a2, 1		# decriment counter
	j loop3
	
break3:
	

	########### - Exponent Section - pretty much a cut and paste of the Mantissa work with 1 less ascii to worry about -----

	la $t0, str2float	# proxy for a float value to test
	l.s $f0, 0($t0)
	mfc1 $s0, $f0		# now s0 has the float bit pattern

expo2:
	# Fix up $s0 by masking out the exponent and shifting left 23
	lw  $t0, exponent_mask
	and $s0, $s0, $t0	# mask out exponent
	srl $s0, $s0, 23	# need to push it all the way left 23 now
	add $a0, $s0, $zero	#keeping s0 stable and using a0 to do the modifying as shifting changes original
		
	la $a1, exponentHex	# sthe stored string we want to update
	add $a2, $zero, 3	# index in our string we work backwards and replace -[3] = 'B' in 3($a1)='0xAB'

	lw $t1, nipple_mask
	and $a0, $a0, $t1	# now a0 has a masked out nipple
	
	and $t9, $t9, $zero		# use t9 as shifter, incremented by 4 each loop and applied to original s0

	# At this point, we have $a0 containing the Left most nipple of a mantissa
	# $a1 a pointer to where to store the conversion to ascii result
	# $a2 set to the index into $a1 where to store the actual conversion
loop4:	beq $a2, 1, break4
	jal print_hex

	add $a0, $s0, $zero	#reestablish a0 so we can shift it on next loop correctly
	add $t9, $t9, 4		# move shifter along
	srlv $a0, $a0, $t9	# now push a0 by either 0,4,
	and $a0, $a0, $t1		# a0 now has the least significant nipple of the mantissa
	sub $a2, $a2, 1		# decriment counter
	j loop4
	
break4:


out:	
	li $v0, 4
	la $a0, expOut
	syscall
		
	li $v0, 4
	la $a0, exponentHex
	syscall
	
	li $v0, 4
	la $a0, fracOut
	syscall	
	la $a0, mantissaHex
	syscall
	li $v0, 10

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

	add $s0, $zero, $zero # Because I want to use them here
	add $s1, $zero, $zero # I better zero these out
	add $s2, $zero, $zero # or else I might inherit junk in here from outside
	
	# comvert into integer
	la  $s1, ($a0)	#$s1 now contains the start of our string
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


#	After hours of debug, I figured out that I should have RTFM
#	If the sys call 8 is set to a lentght -$a1- if the user enters shorter
#	then the OS pads out with \n - so the string is essentially always fixed on creation
# 	and we need a procedure to get the actual len of the string entered.
#	let $a0 be the string to measure and return v0 count of _exact_ chars not including \n
#	ASCII for \n =10
str_len:

	li $v0, 0		# setting the counter/return value
count_loop:
        lb    $t0, 0($a0)     # t0 now holds the value of the first char in the string
        beq   $t0, 10, done    # check for newline
        beq   $t0, $zero, done	# think i need to check for null too as i'm in an infinte loop
        addi  $v0, $v0, 1     # valid char - add 1 to count
        addi  $a0, $a0, 1     # bounce along the string
        j     count_loop      

done:
        jr    $ra           

	# Simple procedure that takes in a register and prints the LSB nipple
	# if the nipple <10 then do a simple +48 ascii conversion
	# if the nipple >9 then do a +55 conversion which will give ABMCCDEF for 10->15
	# $a0 is the inbount integer to convert to hex
	# $a1 is the string address to write the ascii hex inot
	# $a2 is the index into the string - this will be 2 or 3 for exponent and 2-4 for mantissa
	

print_hex:
	add $sp, $sp -12
	sw   $a0, 0($sp)       # store the registers we use
	sw   $a1, 4($sp)       # in this procedure
	sw   $a2, 8($sp)       # which are a0->2
	
	add $a1, $a1, $a2	# move to the char position in string to overwrite
	bgeu  $a0, 10, plus_55
	addiu, $a0, $a0, 48
	sb $a0, 0($a1)
	j ph_exit
plus_55:
	addiu $a0, $a0, 55
	sb $a0, 0($a1)	
ph_exit:
	lw   $a0, 0($sp)       # Restore the registers
	lw   $a1, 4($sp)       # we use in this procedure
	lw   $a2, 8($sp)       # which are a0->2
	addu $sp, $sp, 12 
	jr $ra
	


	
