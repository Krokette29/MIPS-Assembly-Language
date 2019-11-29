.data
arrayChar:	.asciiz "Alpha", "Bravo", "China", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliet", "Kilo", "Lima", "Mary", "November" ,"Oscar", "Paper", "Quebec", "Research", "Sierra", "Tango", "Uniform", "Victor", "Whisky", "X-ray", "Yankee", "Zulu"
indexChar:	.word 0, 6, 12, 18, 24, 29, 37, 42, 48, 54, 61, 66, 71, 76, 85, 91, 97, 104, 113, 120, 126, 134, 141, 148, 154, 161
arrayNum:	.asciiz "zero", "First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth"
indexNum:	.word 0, 5, 11, 18, 24, 31, 37, 43, 51, 58

strNewLine:	.asciiz "\n"
strOther:	.asciiz "\n*\n"

.text
main:
	# read the input, put it into $v0
	li $v0, 12
	syscall
	move $t0, $v0

	# if the input is '?', exit
	beq $t0, 63, exit
	
	# decide whether the input is a capital character
	sgt $t1, $t0, 64
	slti $t2, $t0, 91
	and $t3, $t1, $t2
	beq $t3, 1, upperCase
	
	# decide whether the input is a lower character
	sgt $t1, $t0, 96
	slti $t2, $t0, 123
	and $t3, $t1, $t2
	beq $t3, 1, lowerCase
	
	# decide whether the input is a number
	sgt $t1, $t0, 47
	slti $t2, $t0, 58
	and $t3, $t1, $t2
	beq $t3, 1, number
	
	# other character
	j other
	
upperCase:
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall

	# load the string in the arrayChar
	la $t1, indexChar
	la $t2, arrayChar
	sub $t3, $t0, 65
	mul $t3, $t3, 4
	add $a0, $t1, $t3
	lw $a0, ($a0)
	add $a0, $a0, $t2
	li $v0, 4
	syscall
	
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall
	
	j main
	
lowerCase:
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall

	# output the lower character
	li $v0, 11
	move $a0, $t0
	syscall

	# load the string in the arrayChar and display the rest part of the string
	la $t1, indexChar
	la $t2, arrayChar
	sub $t3, $t0, 97
	mul $t3, $t3, 4
	add $a0, $t1, $t3
	lw $a0, ($a0)
	add $a0, $a0, $t2
	add $a0, $a0, 1
	li $v0, 4
	syscall
	
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall
	
	j main
	
number:
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall

	# load the string in the arrayChar
	la $t1, indexNum
	la $t2, arrayNum
	sub $t3, $t0, 48
	mul $t3, $t3, 4
	add $a0, $t1, $t3
	lw $a0, ($a0)
	add $a0, $a0, $t2
	li $v0, 4
	syscall
	
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall
	
	j main
	
other:
	li $v0, 4
	la $a0, strOther
	syscall
	
	j main

exit:
	li $v0, 10
	syscall
