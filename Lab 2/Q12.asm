	.data
arrayD:	.word	0 : 21
sizeD:	.word	21
	.text	
main:
	addi $s0, $0, 4 #init a = 2
	addi $s1, $0, 6 #init b = 4

	addi $t0, $0, 0 #init i = 0
loop1:	slt $t5, $t0, $s0 #test for i < a
	beq $t5, $0, Done1 #if i >= a jump to Done
	addi $t1, $0, 0 #init j = 0
loop2:	slt $t4, $t1, $s1 #test for j < b
	beq $t4, $0, Done2 #if j >= b jump to Done
	
	#body of loop 2 here
	add $t2, $t0, $t1	#temp2 = i + j
	sll $t3, $t1, 4		#temp3 = 4*j, but shift it by 2 more addresses for another *4 to account for byte addressable memory
	la $t6, arrayD		#load address of arrayD into temp6
	add $t3, $t3, $t6	#add index of temp3 to address of arrayD
	sw $t2, 0($t3)		#write out to D[4*j]
	
	addi $t1, $t1, 1 # j++
	j loop2
Done2:  addi $t0, $t0, 1 # i++
	j loop1
Done1:	# The array numbers are computed and stored in array. Print them.
      	la   $a0, arrayD	# first argument for print (array)
      	la  $a1, sizeD		# second argument for print (size)
      	lw $a1, 0($a1)
      	jal  print		# call print routine. 

	li $v0, 10 	#prep syscal to return from the program
	add $a0, $0, $0	#put a 0 in the return argument
	syscall		#make the syscall
	
###############################################################
# Subroutine to print the numbers on one line.
      .data
space:.asciiz  " "          # space to insert between numbers
head: .asciiz  "The array D is:\n"
      .text
print:add  $t0, $zero, $a0  # starting address of array of data to be printed
      add  $t1, $zero, $a1  # initialize loop counter to array size
      la   $a0, head        # load address of the print heading string
      li   $v0, 4           # specify Print String service
      syscall               # print the heading string
      
out:  lw   $a0, 0($t0)      # load the integer to be printed (the current Fib. number)
      li   $v0, 1           # specify Print Integer service
      syscall               # print fibonacci number
      
      la   $a0, space       # load address of spacer for syscall
      li   $v0, 4           # specify Print String service
      syscall               # print the spacer string
      
      addi $t0, $t0, 4      # increment address of data to be printed
      addi $t1, $t1, -1     # decrement loop counter
      bgtz $t1, out         # repeat while not finished
      
      jr   $ra              # return from subroutine
# End of subroutine to print the numbers on one line
###############################################################
