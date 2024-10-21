.data
	exponentHex: .asciiz "0xZZ "
	mantissaHex: .asciiz "0xYYYYYY\n"
	
	str2float: .float 5.25	# Good test calculator here https://www.h-schmidt.net/FloatConverter/IEEE754.html
	sign_mask:  .word -1
	exponent_mask: .word 0x7F800000
	mantissa_mask: .word 0x007FFFFF
	nipple_mask: .word 0x0000000F

	
.text

	# floats are funky need to
	# 1. load address into a regular register
	# 2. load the value at that reg into a specific floating point register so the FPU works on it.
	# 3. move it from that floating point register into a reuglar register
	# 4. as we are doing bit pattern stuff DO NOT do any conversion functions - keep the bits raw as they are born
	
	
	la $t0, str2float
	l.s $f0, 0($t0)
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
	la $a0, exponentHex
	syscall
	la $a0, mantissaHex
	syscall
	li $v0, 10

	syscall

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
	j exit
plus_55:
	addiu $a0, $a0, 55
	sb $a0, 0($a1)	
exit:
	lw   $a0, 0($sp)       # Restore the registers
	lw   $a1, 4($sp)       # we use in this procedure
	lw   $a2, 8($sp)       # which are a0->2
	addu $sp, $sp, 12 
	jr $ra
	

	
	

