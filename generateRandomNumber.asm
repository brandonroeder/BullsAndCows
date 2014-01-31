#Name generateRandomNumber
#Author Ahmed Zouari
#This function will generate random hex number
#The Random number will be stored in $v0
.text

generateRandomNumber:
                addi $sp , $sp , -4 #Use stack pointer to save $ra to call another function
                sw   $ra , ($sp)

validateRandomNumber:
               
		li $a1 , 0x0000FFFF #Define upper bound for the number
		li $v0 , 42         #Generate Int and Store in $a0
		syscall
		
		li  $a3 , 1
		jal sameNumberValidation
		beq $v0 , 0 , validateRandomNumber
		
		lw $ra , ($sp)
		addi $sp , $sp , 4
		
		move $v0 , $a0      #Return Random Number in $v0
		jr $ra
		
