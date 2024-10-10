.data 
	array: .word 10, 20, 30, 40
	
.text 
	la $t0, array
	lh $t1, 6($t0)
	la $t0, array+6
	lb $t2, ($t0)