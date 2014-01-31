###############This function outputs the secret number in $s0 for debugging############
#################### author: Yunchao Liu ##############################################


.text

showSecNum:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	la $a0 , debugMsg #load address of userInput into $a0
	li $v0 , 4 	             #Print String
	syscall
	
	srl $t1 , $s0, 12 #Extract the first number from the left

	srl $t2 , $s0 , 8 
	andi $t2, 0x0F #Extract the second number from the left
	
	srl $t3 , $s0 , 4
	andi $t3 , 0xF #Extract the third number from the left

	add  $t4 , $zero , $s0
	andi $t4 , 0xF #Extract the fourth number from the left
	
	
	
#print	
print1:
	move $t0, $t1
	blt $t0, 0x0000000a, printInt1 # print inter if it is less then 10
	addi $t0, $t0, 0x00000057
	move $a0, $t0
	li $v0, 11
	syscall	
	j print2
printInt1:
	move $a0, $t0
	li $v0, 1
	syscall

	
	
print2:	
	move $t0, $t2
	blt $t0, 0x0000000a, printInt2 # print inter if it is less then 10
	addi $t0, $t0, 0x00000057
	move $a0, $t0
	li $v0, 11
	syscall		
	j print3
printInt2:
	move $a0, $t0
	li $v0, 1
	syscall
	
			
print3:	
	move $t0, $t3
	blt $t0, 0x0000000a, printInt3 # print inter if it is less then 10
	addi $t0, $t0, 0x00000057
	move $a0, $t0
	li $v0, 11
	syscall
	j print4
printInt3:
	move $a0, $t0
	li $v0, 1
	syscall

print4:		
	move $t0, $t4
	blt $t0, 0x0000000a, printInt4 # print intger if it is less then 10
	addi $t0, $t0, 0x00000057
	move $a0, $t0
	li $v0, 11
	syscall	
	j out
printInt4:			
	move $a0, $t0
	li $v0, 1
	syscall

out:	
	jr $ra

	

	
	
	
