# Simple divide by zero to take a look at the EPC value

.text

	li $t0, 100
	li $t1, 0
	
	divu $t0, $t1
	mfc0 $t3, $12
	divu $t1, $t0
	mfc0 $t4, $14
	nop
	