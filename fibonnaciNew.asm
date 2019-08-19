	# Fibonnaci
        # Written by Anthony Gatte
        
        # A program that will find a number in the fibonnaci sequence by adding up the two previous numbers
        
        # if (n <= 1)
        # return n
        # return fib(n-1) + fib(n-2)
        # jal
        # lw and sw only ones dealing with memory
        # if jal appears in code, anything in s before will be there when you come back
        
        .data
	.align  2
	
fprmpt: .asciiz "Enter a number to get the fibonnaci number for that number in the sequence: "
fanswr: .asciiz "Fib: "

	.text
       	.globl main
       	
       	
# --------------------------------------------

main:	la	$a0, fprmpt	# gets user input, stored in a0 for passing in argument
	li	$v0, 4		# 4 is used to display the value
	syscall
	
	li	$v0, 5		# 5 is to read this value
	syscall
	
# we now have the value stored and need to move it to a register that we can then call on
	
	move 	$a0, $v0	# moves the number the user inputed to a0 (argument)
	jal	fib		# jumps to fib method
	move 	$a1, $v0	# value now stored in a1
	
# --------- prints fanswr ("Fib: ") ---------
	li	$v0, 4
	la	$a0, fanswr
	syscall
	
	li	$v0, 1
	move	$a0, $s0
	syscall

	li	$v0, 10		# exit
	syscall
	
	
# --------- Setting up function ---------
fib:	addi	$sp, $sp, -12	# stack pointer - allocating space for the values
	sw	$ra, 0($sp)	
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	
	move	$s0, $a0	# store n at s0
	li	$t0, 1		# base case return
	
	ble	$s0, 1, done	# checks if n = 1, goes to exit
	
	addi	$a0, $s0, -1	# argument for fib(n-1)
	jal	fib
	move	$s1, $t0	# moves fib(n-1) to s1
	addi	$a0, $s0, -2	# for call of fib(n-2)
	
	jal	fib
	
	add	$a0, $s1, $t0	# add the result of fib(n-1) to a0
	
done:	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	addi	$sp, $sp, 12
	jr	$ra