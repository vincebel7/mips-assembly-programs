#	CPS 250 Assignment 1
#	Vince Belanger
#	2/6/2017
#
#	A is at address 0x2000
#	B is at address 0x2004
#	C is at address 0x2008
#	X is at address 0x200c
#	Y is at address 0x2010
#	Z is at address 0x2014
#
#	Compute
#	X = A+B-C+25 //5
#	Y = A*(B+C)-8*B
#	Z = A+(B^2-44)+C^4/B
#
	.text 				# Text assembler directive
#	Storing variables in easier registers
	lw	$2,0x2000($0)		# Loads A in register $2
	lw	$3,0x2004($0)		# Loads B in register $3
	lw	$4,0x2008($0)		# Loads C in register $4
	
#	Compute X ($5)
	add	$5,$2,$3		# Adding A and B to X
	sub	$5,$5,$4		# Subtracting C from X
	addi	$5,$5,25		# Adding 25 to X
	sw	$5,0x200c($0)		#Stores register $5 in memory
	
#	Compute Y ($6)
	add	$6,$3,$4		# Add B and C to Y
	mul	$6,$6,$2		# Multiply Y by A, store in Y
	addi	$12,$0,8		# Store immediate number 8 into register $12
	mul	$10,$3,$12		# Multiply B and 8, store in register $10
	sub	$6,$6,$10		# Perform Y minus $10, store in Y
	sw	$6,0x2010($0)		#Stores register $6 in memory
	
#	Compute Z ($7)
	mul	$7,$3,$3		# Square B, store in Z
	addi	$14,$0,44		# Store immediate number 44 into register $14
	sub	$7,$7,$14		# Subtracting 44 from B
	add	$7,$7,$2		# Add A to Z
	
	mul	$13,$4,$4		# Squares C, stores in $13
	mul	$13,$13,$13		# Squares C^2
	div	$13,$3			# Divides $11 by B
	mflo 	$15			# Store lo in $15
	add	$7,$7,$15		# Adds $15 (lo) to Z
	sw	$7,0x2014($0)		#Stores register $7 in memory

#	This assembler directive (".data") tells the assembler to place
#	what follows in the "data" section of memory.
	.data
#	The line below (".word directiver) tells the assembler to place
#	the three 32-bit values (25, 12, and -3) in consecutive memory words.
#	Remember, a word of memory is 32 bit (4 bytes).
	.word	25,12,-3		# X=25, Y=12, Z=-3