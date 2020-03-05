#
# File name	Homework2.asm
# Date		20200202
# Author	Travis Collins
# Email		Travis.Collins@utdallas.edu
# Course	SE 3340.002
# Version	1.0.0
# Copyright	2020, All Rights Reserved
#
# Description
#	The purpose of this program is to prompt a user
#	for their name and 3 arbitrary numbers and echo
#	the user name back with 3 answers to those numbers
#

.data
	# Message prompts
	promptNAME:	.asciiz "What is your name? "
	promptINT:	.asciiz "Please enter an integer between 1-100: "
	promptAnswer:	.asciiz "Your answers are: "
	space:		.asciiz " "
	
	# Users name
	name:	.space 20
	
	# User input values a,b,c
	a:	.word	0
	b:	.word	0
	c:	.word	0
	
	# Output values x,y,z
	x:	.word	0
	y:	.word	0
	z:	.word	0
	
.text
main:	
# Request the users name
	li	$v0, 4
	la	$a0, promptNAME
	syscall
	# Read in and store name in memory
	li $v0, 8
	la $a0, name
	li $a1, 20
	syscall
	
# Request user for first variable
	li	$v0, 4
	la	$a0, promptINT
	syscall
	# Read user variable into memory
	li	$v0, 5
	syscall
	# Store first variable into 'a'
	sw	$v0, a
	
# Request user for second variable
	li	$v0, 4
	la	$a0, promptINT
	syscall
	# Read user variable into memory
	li	$v0, 5
	syscall
	# Store first variable into 'b'
	sw	$v0, b
	
# Request user for third variable
	li	$v0, 4
	la	$a0, promptINT
	syscall
	# Read user variable into memory
	li	$v0, 5
	syscall
	# Store first variable into 'c'
	sw	$v0, c
	
# Maths
	# Load in values
	lw $s0, a($zero)
	lw $s1, b($zero)
	lw $s2, c($zero)
	lw $t0, x($zero)
	lw $t1, y($zero)
	lw $t2, z($zero)
	
# first problem
	# $t3 = 2a = a + a
	add $t3, $s0, $s0
	# $t4 = 2a - b
	sub $t4, $t3, $s1
	# x = 2a - b + 9
	addi $t0, $t4, 9
	# Store $t0 back into x
	sw $t0, x
	# move $a0, $t0    # moves value from $t0 to $a0

# second problem
	# $t3 = c - b
	sub $t3, $s2, $s1
	# $t4 = a - 5
	subi $t4, $s0, 5
	# answer = $t3 + $t4
	add $t1, $t3, $t4
	# Store $t1 back into y
	sw $t1, y
	
# third problem
	# $t3 = a - 3
	subi $t3, $s0, 3
	# $t4 = b + 4
	addi $t4, $s1, 4
	# $t3 = $t3 + $t4 
	add $t3, $t3, $t4
	# $t4 = c + 7
	addi $t4, $s2, 7 
	# z = $t3 - $t4
	sub $t2, $t3, $t4
	# Store $t2 back into z
	sw $t2, z
	
# Display Results	
	# Display user name
	li $v0, 4
	la $a0, name
	syscall
	
	# Display answers
	#li $v0, 4
	la $a0, promptAnswer
	syscall
	# display x
	li $v0, 1
	lw $a0, x
	syscall
	# display space
	li $v0, 4
	la $a0, space
	syscall
	# display y
	li $v0, 1
	lw $a0, y
	syscall
	# display space
	li $v0, 4
	la $a0, space
	syscall
	#display z
	li $v0, 1
	lw $a0, z
	syscall
#exit
	li	$v0, 10
	syscall
# end main