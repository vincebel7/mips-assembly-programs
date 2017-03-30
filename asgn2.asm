#	CPS 250 Assignment 1
#	Vince Belanger
#	2/23/2017
#
#	User provides a value. Program determines if it is a prime number.
#	int num, ii, rem;
#	output(“Enter a Number: “);
#	input(num);
#	ii = 2;
#	while (ii < num/2)
#	{
#	   rem = num % ii;
#	   if (rem == 0)
#	      ii = num/2;
#	   ii++;
#	}
#	if (rem != 0)
#	   output(“Number is prime!\n”);
#	else
#	   output(“Sorry, number is not prime.\n”);

# aliases
	.eqv	read_int,5
	.eqv	print_int,1
	.eqv	print_string,4
	.eqv	exit,10
	.eqv	num,$s0
	.eqv	ii,$s1
	.eqv	num2,$s2
	.eqv	rm,$s3
	
	.data
	msg0:.asciiz "Enter a Number: "
	msg1:.asciiz "Number is prime!\n"
	msg2:.asciiz "Sorry, number is not prime.\n"
	
	.text
	li	$v0,print_string	#load print_string into $v0
	la	$a0,msg0		#load msg0 into $a0
	syscall

main:	addi	$v0,$0,read_int		#input(a);
	syscall
	add	num,$0,$v0		#store input into saved register num
	addi	ii,$0,2			#define ii	
	addi	$t0,$0,2		#defines 2 to divide with
	div	num2,num,$t0		#prepares num/2	
	li	rm,1			#initialize rm to 1 (in case num <= 3

wh1:	bgt	ii,num2,endwh1		#branch if ii >= num2
	div	num,ii			#num / ii
	mfhi	rm			#moves rm (remainder) into rm
if1:	bne	rm,$0,eif1		#branch rm != 0
	add	ii,$0,num2		#ii = num/2	
eif1:	addi	ii,ii,1			#ii++
	beq	$0,$0,wh1		#loop while
endwh1:	nop
if2:	beq	rm,$0,el2		#branch if rm is 0
	la	$v0,4			#load service number to print string
	la	$a0,msg1		#load argument in $a0
	syscall				#print number is prime
	beq	$0,$0,eif2		#branch to eif2
el2:	la	$v0,4			#load service number to print string
	la	$a0,msg2		#load argument in $a0
	syscall				#print number is not prime
	beq	$0,$0,eif2		#branch to eif2
eif2:	nop
	
	li	$v0,exit		#exit program
	syscall