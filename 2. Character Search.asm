.data
inputStr:	.space 1024
strNewLine:	.asciiz "\n"
strSuccessMsg:	.asciiz "Success! Location: "
strFailMsg:	.asciiz "Fail!"

.text
main:
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall

	# read the input string
	li $v0, 8
	la $a0, inputStr
	li $a1, 1024
	syscall
	
	move $t7, $a0
	
searchLoop:
	# read the input character
	li $v0, 12
	syscall
	move $t0, $v0
	
	# if "?", exit
	beq $t0, 63, exit
	
	# initialize the position and the address
	li $t6, 1
	move $t8, $t7
	
loop:
	lb $t1, ($t8)
	
	# if a new line, exit the loop, and fail
	beq $t1, 10, fail
	
	# if match the input character, print the position
	beq $t1, $t0, success
	
	# else, increase the position by one and loop
	add $t6, $t6, 1
	add $t8, $t8, 1
	
	j loop

success:
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall

	li $v0, 4
	la $a0, strSuccessMsg
	syscall
	
	# print the location
	li $v0, 1
	move $a0, $t6
	syscall
	
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall
	
	j searchLoop

fail:
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall

	li $v0, 4
	la $a0, strFailMsg
	syscall
	
	# new line
	li $v0, 4
	la $a0, strNewLine
	syscall
	
	j searchLoop

exit:
	li $v0, 10
	syscall
