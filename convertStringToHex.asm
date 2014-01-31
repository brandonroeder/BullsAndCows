#############################################################
###############convertStringToHex.asm########################
###############Author Ahmed Zouari###########################
###############This function takes a string and it converts it to a hex number################################
###############This function will also validate that a number is between 0 and F##############################
###############This function will take $a0 as an input and will return $v0 = 1 if success and $v0 = 0 if not valid input##########
	
	.text
	

convertStringToHex:

	li $t2 , 4096 #16 ^ 3 = 4096
	li $v1 , 0 #Initialize Number this function will return the hex number in $v1
	
 breakStringbyByte:
	lb $t0 , ($a0) #Break the user input string into bytes
	ble $t0 , 0x00000039, decimal #This label to handle '0' through '9'
	ble $t0 , 0x00000046, hexUpper #This label to handle 'A' through 'F'
	ble $t0 , 0x00000066, hex
	j inputNotInRange

 hex:
	ble   $t0 , 0x00000060 , inputNotInRange
	addi $t0 , $t0 , -0x00000057 #This to handle 'a' through 'f'
	addi $a0 , $a0 , 1 #Next byte
	# Basically ABCD ==> 10 * 16 ^ 3 + 11 * 16 ^ 2 + 12 * 16 + 13 * 16 ^ 0
	mul  $t1 , $t0 , $t2
	add  $v1 , $v1 , $t1
	beq  $t2 , 1 , endConvertStringtoHex
	div  $t2 , $t2 , 16
	j breakStringbyByte
	
	
	
 decimal:
 
	ble   $t0 , 0x0000002F , inputNotInRange
	addi $t0 , $t0 , -0x00000030 #This to handle '0' through '9'
	addi $a0 , $a0 , 1 #Next byte
	# Basically ABCD ==> 10 * 16 ^ 3 + 11 * 16 ^ 2 + 12 * 16 + 13 * 16 ^ 0
	mul  $t1 , $t0 , $t2
	add  $v1 , $v1 , $t1
	beq  $t2 , 1 , endConvertStringtoHex
	div  $t2 , $t2 , 16
	j breakStringbyByte

hexUpper:

	ble   $t0 , 0x00000040 , inputNotInRange
	addi $t0 , $t0 , -0x00000037 #This to handle 'A' through 'F'
	addi $a0 , $a0 , 1 #Next byte
	# Basically ABCD ==> 10 * 16 ^ 3 + 11 * 16 ^ 2 + 12 * 16 + 13 * 16 ^ 0
	mul  $t1 , $t0 , $t2
	add  $v1 , $v1 , $t1
	beq  $t2 , 1 , endConvertStringtoHex
	div  $t2 , $t2 , 16
	j breakStringbyByte
  
	
 endConvertStringtoHex:
 	li $v0 , 1 #$v0 = 1 means success
	jr $ra
	
inputNotInRange:
	la $a0 , notInRange          #load address of userInput into $a0
	li $v0 , 4 	           #Print String
	syscall
	li $v0 , 0   #$v0 = 0 means failure
	jr $ra

