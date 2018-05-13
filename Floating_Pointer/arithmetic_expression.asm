.data

	constant1: .double 5.4
	constant2: .double 12.3
	constant3: .double 18.23
	constant4: .double 8.23

.text

	# Calculates the following expression:
	# 5.4xy - 12.3y + 18.23x - 8.23

	# $f30 => 5.4
	# $f28 => 12.3
	# $f26 => 18.23
	# $f24 => 8.23
	
	l.d $f30, constant1
	l.d $f28, constant2
	l.d $f26, constant3
	l.d $f24, constant4

	# Read the numbers that will represents X and Y
	li $v0, 7
	syscall
	mov.d $f2, $f0 # $f2 => X
	
	syscall
	mov.d $f4, $f0 # $f4 => Y
	
	# $f6 => constant1 * x * y
	# $f8 => constant2 * y
	# $f10 => constant3 * x
	# $f14 => $f6 - $f8 + $f10 - constant4 
	
	mul.d $f6, $f2, $f4
	mul.d $f6, $f6, $f30
	
	mul.d $f8, $f28, $f4

	mul.d $f10, $f26, $f2
	
	sub.d $f14, $f6, $f8
	add.d $f14, $f14, $f10
	sub.d $f14, $f14, $f24
	
	li $v0, 3
	mov.d $f12, $f14
	syscall
