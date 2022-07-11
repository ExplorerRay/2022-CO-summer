.text
.globl main
main:
#print msg1
		li      $v0, 4		# call system call: print string
		la      $a0, msg1	# load address of string into $a0
		syscall                 # run the syscall

#print array
		la	$t1, array1 	# load address of array
		li	$t0, 0
		jal	printarr
		
#sort
		
#print msg2
		li	$v0, 4
		la	$a0, msg2
		syscall
#print array
		la	$t1, array1 	# load address of array
		li	$t0, 0
		jal	printarr
#exit
		li	$v0, 10
		syscall
		

.data
msg1:	.asciiz "The array before sort : "
msg2:	.asciiz "\nThe array after sort : "
array1:	.word 5, 3, 6, 7, 31, 23, 43, 12, 45, 1

.text
printarr:	# the loop of printing array
		addi	$sp, $sp, -4
		sw	$ra, 0($sp)	#save return address
	# load word from addrs and goes to the next addrs
    		lw      $t2, 0($t1)
    		addi    $t1, $t1, 4
    	# print array int
    		li	$v0, 1		# call system call: print int
    		move	$a0, $t2
    		syscall
	# print space
		li 	$a0, 32		# 32 is ASCII code for space
		li 	$v0, 11		# syscall number for printing character
		syscall
		
    		addi    $t0, $t0, 1	# increase counter
		blt 	$t0, 10, printarr	# determine the end of this printarr loop
	# return to caller
		lw	$ra, 0($sp)
		addi	$sp, $sp, 4
		jr 	$ra
		
bbsort:	#bubble sort
		la	$t2, array1	# load address of array
		li	$t0, 0		# initialize loop counter
outlp: #out loop
		
		addi    $t0, $t0, 1	# increase counter
		blt	$t0, 10, outlp

swap:
