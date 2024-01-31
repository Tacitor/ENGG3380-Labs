# Simple input/output in MIIPS assembly


	# Start .text segment (program code)
	.text
	
	.globl	main
main:
	# Print string msg1
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msg1	# load the address of msg
	syscall

	# Get input A from user and save
	li	$v0,5		# read_int syscall code = 5
	syscall	
	move	$t0,$v0		# syscall results returned in $v0

	# Print string msg2
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msg2	# load the address of msg2
	syscall

	# Get input B from user and save
	li	$v0,5		# read_int syscall code = 5
	syscall	
	move	$t1,$v0		# syscall results returned in $v0

	# Math!
	and	$t3, $t0, $t1	# A = A and B
	or	$t2, $t0, $t1	# A = A or B
	add	$t4, $t0, $t1	# A = A + B 

	# Print string msg5
	li	$v0, 4
	la	$a0, msg5
	syscall

	# Print add
	li	$v0,1		# print_int syscall code = 1
	move	$a0, $t4	# int to print must be loaded into $a0
	syscall
	
	# Print \n
	li	$v0,4		# print_string syscall code = 4
	la	$a0, newline
	syscall

	# Print string msg3
	li	$v0, 4
	la	$a0, msg3
	syscall

	# Print and
	li	$v0,1		# print_int syscall code = 1
	move	$a0, $t3	# int to print must be loaded into $a0
	syscall
	
	# Print \n
	li	$v0,4		# print_string syscall code = 4
	la	$a0, newline
	syscall
	
	# Print string msg4
	li	$v0, 4
	la	$a0, msg4
	syscall
	
	# Print or
	li	$v0,1		# print_int syscall code = 1
	move	$a0, $t2	# int to print must be loaded into $a0
	syscall

	# Print \n
	li	$v0,4		# print_string syscall code = 4
	la	$a0, newline
	syscall

	li	$v0,10		# exit
	syscall

	# Start .data segment (data!)
	.data
msg1:	.asciiz	"Enter A:   "
msg2:	.asciiz	"Enter B:   "
msg3:	.asciiz	"A and B = "
msg4:	.asciiz	"A or B = "
msg5:	.asciiz	"A + B = "
newline:   .asciiz	"\n"
