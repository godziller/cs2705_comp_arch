.data
	float1: .float 5.25
	
.text
	lw $t0, float1
	mtc1 $t0, $f0 
	
	li $t1, 5
	li $t2, 25
	mtc1 $t1, $f1
	mtc1 $t2, $f2
	
	
	cvt.s.w $f3, $f1
	cvt.s.w $f4, $f2	
	
	li $t3, 100
	mtc1 $t3, $f5
	cvt.s.w $f5, $f5
	
	div.s $f4, $f4, $f5
	add.s $f10, $f3, $f4
	
	mfc1 $t9, $f10