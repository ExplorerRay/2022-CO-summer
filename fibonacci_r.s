.text
.globl main
main:
	# print msg1
        	li      $v0, 4		# call system call: print string
		la      $a0, msg1	# load address of string into $a0
		syscall             	# run the syscall
	# read the input integer to $a0
 		li      $v0, 5          # call system call: read integer
  		syscall                 # run the syscall, read the input int to $v0
  		move	$a0, $v0	# store input to $a0 for parameter of fibo
  		move	$t0, $a0	# save $a0 to $t0
  		
  		jal	fibo		# get fibo(n) in $v0
  		
  		move	$s0, $v0	# save fibo(n) to $s0
  	
  	# print result
  		li	$v0, 1		# print int syscall
  		la	$a0, 0($t0)	# 第幾個 (print n out)
  		syscall
  	# print msg2
  		li	$v0, 4		# print string syscall
  		la	$a0, msg2
  		syscall
  		li	$v0, 1
  		la	$a0, 0($s0)	# print fibo(n) out
  		syscall
  		li	$v0, 4
  		la	$a0, end	# 句號及換行
  		syscall
  	# exit
  		li	$v0, 10
  		syscall


.data
msg1:   	.asciiz "Please input i : "
msg2:		.asciiz "th Fibonacci numbers is "
end:		.asciiz ".\n"

.text # procedures
fibo: 
		# callee save convention
		addi	$sp, $sp, -12
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)
		sw	$s1, 8($sp)
		
		move	$s0, $a0	# $s0 = $a0
		beq	$s0, $zero, if0 # if n==0, go to if0
		beq	$s0, 1, if1	# if n==1, go to if1
		addi	$a0, $s0, -1	# $a0 = n - 1 (parameter set to n-1)
		jal	fibo		# call fibo(n-1) and get result in $v0
		move	$s1, $v0	# save the result of fibo(n-1) t0 $s1
		addi	$a0, $s0, -2	# $a0 = n - 2
		jal	fibo		# call fibo(n-2) and get result in $v0
		add	$v0, $s1, $v0	# $v0 = fibo(n-1) + fibo(n-2)
		# callee save convention
		lw	$ra, 0($sp)
		lw	$s0, 4($sp)
		lw	$s1, 8($sp)
		addi	$sp, $sp, 12
		jr	$ra		

if0: # when parameter=0, return 0
		addi	$v0, $zero, 0	# return 0
		# callee save convention
		lw	$ra, 0($sp)
		lw	$s0, 4($sp)
		lw	$s1, 8($sp)
		addi	$sp, $sp, 12
		jr	$ra
if1: # when parameter=1, return 1
		addi	$v0, $zero, 1	# return 1
		# callee save convention
		lw	$ra, 0($sp)
		lw	$s0, 4($sp)
		lw	$s1, 8($sp)
		addi	$sp, $sp, 12
		jr	$ra

