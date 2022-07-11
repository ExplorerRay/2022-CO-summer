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
  		move    $a0, $v0        # store input in $a0 (set arugument of procedure fibo)
# jump to procedure fibo
        jal fibo
        move    $t0, $v0		# save return value in t0 (because v0 will be used by system call) 

# exit
        li      $v0, 10
        syscall
.data
msg1:   .asciiz "Please input i : "


.text
fibo:
        addi    $sp, $sp, -8    # 2 items space for stack
        sw      $a0, 0($sp)     # store a0
        sw      $ra, 4($sp)     # store ra

        beq     $a0, 0, if0     # if input_int==0
        beq     $a0, 1, if1     # if input_int==1

        # not yet

        lw      $a0, 0($sp)     # load back a0
        lw      $ra, 4($sp)     # load ra
        addi    $sp, $sp, 8     # pop from stack
        jr $ra                  # return caller
if0:
        addi $v0, $zero, 0	    # return 0
        lw      $a0, 0($sp)     # load back a0
        addi    $sp, $sp, 4     # pop 1 item space from stack
        jr $ra                  # return caller
if1:
        addi $v0, $zero, 1	    # return 1
        lw      $a0, 0($sp)     # load back a0
        addi    $sp, $sp, 4     # pop 1 item space from stack
        jr $ra                  # return caller