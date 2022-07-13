.text
.globl main
main:
	# print msg1
        	li      $v0, 4		# call system call: print string
		la      $a0, msg1	# load address of string into $a0
		syscall             # run the syscall
	# read the input integer to $a0
 		li      $v0, 5          # call system call: read integer
  		syscall                 # run the syscall
  		move	$a0, $v0	# store input to $a0 because $v0 needs to use for syscall
fibo:	# initialization of fibonacci and determine input=0 or 1 situations
		li	$s0, 0		# set a=0 as in fibonacci f.c
		li	$s1, 1		# set b=1 as in fibonacci f.c
		li	$s2, 1		# set c=1 as in fibonacci f.c
		li	$t0, 1		# initialize counter to 1
		beq	$a0, 0, if0	# if input==0 branch to if0
		beq	$a0, 1, if1	# if input==1 branch to if1
loop:
		add	$s2, $s0, $s1	# c = a + b
		move 	$s0, $s1	# a = b
		move	$s1, $s2	# b = c		
		addi	$t0, $t0, 1	# increase counter
		blt	$t0, $a0, loop	# determine the end of the loop
		j	print_result
		
if0:		li	$s2, 0		# result set to 0
		j	print_result
if1:		li	$s2, 1		# result set to 1
		j	print_result

print_result:
		li	$v0, 1		# print int syscall
		syscall			# syscall directly because nothing changes $a0
	# print msg2
		li	$v0, 4
		la	$a0, msg2
		syscall
	# print answer
		li	$v0, 1
		la	$a0, 0($s2)
		syscall
	# print 句號 and \n
		li	$v0, 4
		la	$a0, end
		syscall
# exit
        	li      $v0, 10
        	syscall
.data
msg1:   	.asciiz "Please input i : "
msg2:		.asciiz "th Fibonacci numbers is "
end:		.asciiz ".\n"

# non procedure