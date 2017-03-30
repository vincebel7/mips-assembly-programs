# CPS 250 Assignment 3
# Vince Belanger
# Purpose: To reduce a fraction by calculating the GCD and dividing
# the numerator and denominator by it.

# aliases
	.eqv	read_int,5
	.eqv	print_int,1
	.eqv	print_string,4
	.eqv	exit,10
	.eqv	m,$s0
	.eqv	n,$s1
	.data
	msg0:.asciiz "Enter a numerator: "
	msg1:.asciiz "Enter a denominator: "
	msg2:.asciiz "\nReduced fraction is: "
	slash:.asciiz "/"
	gcdmsg:.asciiz "GCD is "

	.text

main:	li	$v0,print_string	# print "Enter a numerator: "
	la	$a0,msg0		
	syscall
	
	addi	$v0,$0,read_int		# input(m)
	syscall
	
	la	m,($v0)			# store input into m ($s0)
	
	li	$v0,print_string	# print "Enter a denominator: "
	la	$a0,msg1		
	syscall
	
	addi	$v0,$0,read_int		# input(n)
	syscall
	
	la	n,($v0)			# store input into n ($s1)
	
	la	$a1,(m)			# load m into $a1 (gcd function parameter)
	la	$a2,(n)			# load n into $a2 (gcd function parameter)
	
	jal	gcd			# gcd function call, returns GCD in $a1
	
	div	m,$a1			# store m / GCD in m (reduce numerator)
	mflo	m
	
	div	n,$a1			# store n / GCD in n (reduce denominator)
	mflo	n
	
	# optional code to print out GCD:
	
	#li	$v0,print_string
	#la	$a0,gcdmsg		# output GCD message for testing	
	#syscall
	
	#li	$v0,print_int		# output GCD for testing
	#la	$a0,($a1)
	#syscall
	
	li	$v0,print_string	# output "Reduced fraction is: "    m / n
	la	$a0,msg2		
	syscall
	
	li	$v0,print_int		# print reduced numerator
	la	$a0,(m)
	syscall
	
	li	$v0,print_string	# print "/"
	la	$a0,slash
	syscall
	
	li	$v0,print_int		# print reduced denominator
	la	$a0,(n)
	syscall
	
	li	$v0,exit		# exit program
	syscall

gcd:	nop				# gcd function begins
if1:	bge	$a1,$a2,eif1		# branch if m < n is false
	la	$t0,($a1)		# swap $a1 and $a2
	la	$a1,($a2)			
	la	$a2,($t0)			
eif1:	nop
wh1:	beq	$a2,$0,endwh1		# loop until $a2 is 0
	div	$a1,$a2			# numerator % denominator in $t1
	mfhi	$t1			
	la	$a1,($a2)		# swap a1 and a2
	la	$a2,($t1)		
	bne	$a2,$0,wh1		# end while if $a2 = 0. If not, keep looping
endwh1:	jr	$ra			# return to main