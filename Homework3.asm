#
# File name	Homework3.asm
# Date		20200209
# Author	Travis Collins
# Email		Travis.Collins@utdallas.edu
# Course	SE 3340.002
# Version	1.0.0
# Copyright	2020, All Rights Reserved
#
# Description
#	The purpose of this program is to prompt a user
#	for some random string input. The program then
#	counts the words and characters and outputs the
#	info back to the user in console.
#

.data
	prompt:		.asciiz		"Enter some text: "
	exitMSG:	.asciiz		"Program Terminated."
	words:		.asciiz		" words "
	characters:	.asciiz		" characters"
	userInput:	.space		200
	space:		.asciiz		" "
	newLine:	.asciiz		"\n"
	
.text
main:
	loop:	
		jal	promptBox	# Prompt User call
		# Display user input back to console
		li	$v0, 4
		la	$a0, userInput
		syscall	
		# Word count output
		li	$v0, 1
		move	$a0, $t2
		syscall
		# Word text out
		li	$v0, 4
		la	$a0, words
		syscall
		# char count out
		li	$v0, 1
		move	$a0, $t1
		syscall
		# char text out
		li	$v0, 4
		la	$a0, characters
		syscall		
		# Newline
		li	$v0, 4
		la	$a0, newLine
		syscall		
		# Return to top of loop
		j loop
	
	exit:	# End loop
	
	# PROGRAM END MESSAGE
	li	$v0, 59
	la	$a0, exitMSG
	la	$a1, space
	syscall
	
# END MAIN
	li	$v0, 10
	syscall
	
promptBox: #output prompt

	# Storing $ra Return Address on stack
	move	$s1, $ra
	addi	$sp, $sp, -4
	sw	$s1, 0($sp)
	
	# Prompt user via dialog box
	li	$v0, 54
	la	$a0, prompt
	la	$a1, userInput
	li	$a2, 199
	syscall
	
	# Test user input before counting
	li	$t9, -2
	beq	$a1, $t9, exit
	li	$t9, -3
	beq	$a1, $t9, exit
	jal	counter		# jump to counter
	
	# Restore return address from the stack
	lw	$s1, 0($sp)
	addi	$sp, $sp, 4
	move	$ra, $s1
	
	# return to main
	jr	$ra
	
counter:
	li	$t1, 0			# Initializing counter values
	li	$t2, 1			#
	la	$t0, userInput		# Setting $t0 to userinput
	
	charCount:			# Counter Start
		lb	$a0, 0($t0)	# loading 1 byte at a time
		bne  $a0, ' ', wordCount# Checking for spaces used to identify word count
		addi	$t2, $t2, 1	# add 1 to word count
		wordCount:	
		beq	$a0, $zero, charDone# if $a0 = null, break.
		addi	$t0, $t0, 1	# add 1 to address position
		addi	$t1, $t1, 1	# add 1 to char count
		j	charCount	# restart loop
	charDone:
	subi	$t1, $t1, 1		# Subtract 1 from charCount for null char
	jr $ra				# return