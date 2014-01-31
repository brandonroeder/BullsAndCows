#############################################################
###############getUserInput.asm########################
###############Author Ahmed Zouari###########################
###############This function takes a user String and return it in $v0 ############

	
	.text
	
getUserInput:
	la $a0 , userInput     #load address of userInput into $a0
	li $v0 , 4 	       #Print String
	syscall
	
	la $a0 , userString    #address if input buffer
	li $a1 , 6  	       #number of char
	li $v0 , 8             #Read the string
	syscall
	
	la $a0 , userString    #move the content to $a0
	jr $ra
	
