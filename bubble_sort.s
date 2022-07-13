.text
.globl main
main:
	#print msg1
		li      $v0, 4		# call system call: print string
		la      $a0, msg1	# load address of string into $a0
		syscall                 # run the syscall

	#print array
		la	$t1, array1 	# load address of array
		li	$t0, 0		# initialize the counter to 0 (i=0)
		jal	printarr
		
	#sort		
		la	$a0, array1	# move parameter for calling bbsort ($a0 = v) ($a0 = the address of v)
		addi	$a1, $zero, 10	# $a1 = 10 (n=10)
		jal	bbsort		
	#print msg2 (almost the same as print msg1)
		li	$v0, 4
		la	$a0, msg2
		syscall
	#print array
		la	$t1, array1 	# load address of array
		li	$t0, 0		# initialize the counter to 0 (i=0)
		jal	printarr
	#exit
		li	$v0, 10
		syscall
		

.data
msg1:	.asciiz "The array before sort : "
msg2:	.asciiz "\nThe array after sort : "
array1:	.word 5, 3, 6, 7, 31, 23, 43, 12, 45, 1

.text # procedures
printarr: # the loop of printing array
		addi	$sp, $sp, -4
		sw	$ra, 0($sp)	#save return address
	# load word from address and goes to the next addrs
    		lw      $t2, 0($t1)	# $t2 = data[i]
    		addi    $t1, $t1, 4	# i++
    	# print array int
    		li	$v0, 1		# call system call: print int
    		move	$a0, $t2	# $a0 = data[i-1] (because i addi 4 previously, the index now is actually i-1)
    		syscall
	# print space
		li 	$a0, 32		# 32 is ASCII code for space
		li 	$v0, 11		# syscall number for printing character
		syscall
		
    		addi    $t0, $t0, 1	# increase counter
		blt 	$t0, 10, printarr	# if i<10, keeps printing
	# return to caller
		lw	$ra, 0($sp)
		addi	$sp, $sp, 4
		jr 	$ra		# return
		
bbsort:	#bubble sort
		# callee save convention
		addi	$sp, $sp, -20
		sw	$ra, 16($sp)
		sw	$s3, 12($sp)
		sw	$s2, 8($sp)
		sw	$s1, 4($sp)
		sw	$s0, 0($sp)
		
		move	$s2, $a0	# $s2 means the address of array (v)
		move	$s3, $a1	# $s3 means the number of elements in array (n)
		move	$s0, $zero	# $s0 = 0 means i=0
outlp: #out loop
		slt	$t0, $s0, $s3	# $t0=0 if i>=n
		beq	$t0, $zero, exitout	# if i>=n, exitout
		addi	$s1, $s0, -1	# j=i-1
inlp: #inner loop
		slti	$t0, $s1, 0	# $t0=1 if $s1<0 (j<0)
		bne	$t0, $zero, exitin	# if j<0, exitin
		sll	$t1, $s1, 2	# $t1 = $s1 * 4 (j*4)
		add	$t2, $s2, $t1	# $t2 = the address of v[j]
		lw	$t3, 0($t2)	# $t3 = v[j]
		lw	$t4, 4($t2)	# $t4 = v[j+1]
		slt	$t0, $t3, $t4	# set $t0=1 when $t4 >= $t3
		bne	$t0, $zero, exitin	# if v[j+1]>=v[j], exitin
		move	$a0, $s2	# move parameter for calling swap ($a0 = v)
		move	$a1, $s1	# $a1 = j
		jal	swap		# when j>=0 and v[j]>v[j+1], go to swap
		addi	$s1, $s1, -1	# j--
		j	inlp		# the inner loop keeps going
exitin:	#used for exit inner loop
		addi	$s0, $s0, 1	# i++ , increase the counter
		j	outlp		# exit the inner loop and go to the start of out loop
exitout: #used for exit out loop
		# callee save convention
		lw	$s0,0($sp)
		lw	$s1,4($sp)
		lw	$s2,8($sp)
		lw	$s3,12($sp)
		lw	$ra,16($sp)
		addi	$sp, $sp, 20
		
		jr	$ra		# return

swap: # $a0 is the address of the array, and $a1 represents the index
		sll	$t1, $a1, 2	# $a1 * 4 and save this to $t1
		add 	$t1, $a0, $t1	# $t1 = address of v[k]
		lw	$t0, 0($t1)	# $t0 = v[k]
		lw	$t2, 4($t1)	# $t2 = v[k+1]
		sw	$t2, 0($t1)	# v[k] = $t2
		sw	$t0, 4($t1)	# v[k+1] = $t0
		jr	$ra		# return
		
