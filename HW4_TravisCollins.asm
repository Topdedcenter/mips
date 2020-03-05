
#
# File name	HW4_TravisCollins.asm
# Date		20200305
# Author	Travis Collins
# Email		Travis.Collins@utdallas.edu
# Course	SE 3340.002
# Version	1.0.0
# Copyright	2020, All Rights Reserved
#
# Description
#
#
#
#

.data
inputin:	.asciiz	"input.txt"
buffer:		.space	128
buffer1:	.asciiz	"\n"
val:		.space	128
newline:	.asciiz	"\n"
ans:		.asciiz	"testing: "


.text

#open file for reading
fileRead:
	li	$v0, 13		#system call for open file
	la	$a0, inputin	#input file name
	li	$a1, 0		#flag for reading
	li	$a2, 0		#mode is ignored
	syscall
	move	$s0, $v0
	
# reading opened file
	li	$v0, 14		#system call for reading from file
	move	$a0, $s0	#file descriptor
	la	$a1, buffer	#address of buffer from which to read
	li	$a2, 11		#hardcoded buffer length
	syscall
	
	li	$v0, 4		#
	la	$a0, buffer	#buffer contains the values
	syscall			# print
	
	lb	$t1, buffer
	
	la	$a0, buffer	#calling opening prompt
	li	$v0, 4
	syscall
	la	$a0, buffer	#initial string
	syscall
	la	$a0, newline	#newline
	syscall
	la	$a0, ans	#initial text for reversed string
	syscall
	li	$t2, 0
	
strLen:		#getting length of string
	lb	$t0, buffer($t2)#loading value
	add	$t2, $t2, 1
	bne	$t0, $zero, strLen
	
	li	$v0, 11		#load immediate - print low-level byte
	
Loop:
	sub	$t2, $t2, 1	#this statement is now before the 'load address'
	la	$t0, buffer($t2)#loading value
	lb	$a0, ($t0)
	syscall
	
	bnez	$t2, Loop
	li	$v0, 10		#program done: terminating
	syscall
	
	#close file
	li	$v0, 16		#syscall for closing file
	move	$a0, $s6	#file descriptor to close
	syscall			#close file


