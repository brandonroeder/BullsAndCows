##########################################This function checks the number of bulls and cows#################




.text

# $s0 = secret number
# $s1 = user input
#
# $t0 = result of secret number( $s0 ) XOR user input( $s1 )
# $t1 = 0x0000 0000
# $t2 = number of bulls/cows
# $t3 = result of filtering by the mask 
# $t4 = result of shifting
# $t5 = the 5th least-significant digt after shifting
# $t6 = parameter for loop control, like i in HHL
# $t7 = parameter for loop control
#Subroutine it expect $s0 and $s1
checkForBullsAndCows:
#addi $s0, $zero, 0x0000F12B # $s0 stores the secret number
#addi $s1, $zero, 0x0000F12B # $s1 stores the user input
#addi $s1, $zero, 0x0000B12C # $s1 stores the user input
#addi $s1, $zero, 0x000023BF # $s1 stores the user input

#initialize all registers except $s0 and $s1, $s7
add $t0, $zero, $zero
add $t1, $zero, $zero
add $t2, $zero, $zero
add $t3, $zero, $zero
add $t4, $zero, $zero
add $t5, $zero, $zero
add $t6, $zero, $zero
add $t7, $zero, $zero
#add $s2, $zero, $zero
#add $s3, $zero, $zero
#add $s4, $zero, $zero
#add $s5, $zero, $zero
#add $s6, $zero, $zero
addi $t8, $zero, 1
addi $t9, $zero, 1






# check where there are 4 bulls, which means user wins
xor $t0, $s0, $s1 # $t0 is the result of secret number( $s0 ) XOR user input( $s1 )
beq $t0, $zero, Win # if the result of XOR( $t0 ) equals to $zero, jump to label win


#store the return address
addi $sp, $sp, -4
sw $ra, ($sp)

numBulls:

# check the number of bulls
addi $t2, $zero, 0 # $t2 initialized with 0 will stores the number of bulls
andi $t3, $t0, 0x0000F000 # get the first digit
bne $t3, $t1, ElseIf1
addi $t2, $t2, 1 # add one to the number of bulls( $t2 ) 
ElseIf1:
andi $t3, $t0, 0x00000F00 # get the second digit
bne $t3, $t1, ElseIf2
addi $t2, $t2, 1 # add one to the number of bulls( $t2 ) 
ElseIf2:
andi $t3, $t0, 0x000000F0 # get the third digit
bne $t3, $t1, ElseIf3
addi $t2, $t2, 1 # add one to the number of bulls( $t2 ) 
ElseIf3:
andi $t3, $t0, 0x00000000F # get the second digit
bne $t3, $t1, EndIf1
addi $t2, $t2, 1 # add one to the number of bulls( $t2 ) 

EndIf1:
move $s4,$t2

#print out the number of bulls
la $a0, thereAre
li $v0, 4
syscall # print out " There are "
add $a0, $zero, $t2
li $v0, 1
syscall # print out the number of bulls
la $a0, bullString
li $v0, 4
syscall # print out " bulls."



numCows:

#check the number of cows
addi $t2, $zero, 0 # $t2 initialized with 0 will stores the number of cows
addi $t6, $zero, 0 # initialize i = 0
addi $t7, $zero, 3 # parameter for loop control
add  $t4, $t4, $s1 # initialize result of shifting( $t4 ) = user input( $s1 )


Loop:
jal Shifting #shift left by 1 bit
xor $t0, $s0, $t4 # $t0 is the result of secret number( $s0 ) XOR user input( $s1 )
andi $t3, $t0, 0x0000F000 # get the first digit
bne $t3, $t1, ElseIf4
addi $t2, $t2, 1 # add one to the number of cows( $t2 ) 
ElseIf4:
andi $t3, $t0, 0x00000F00 # get the second digit
bne $t3, $t1, ElseIf5
addi $t2, $t2, 1 # add one to the number of cows( $t2 ) 
ElseIf5:
andi $t3, $t0, 0x000000F0 # get the third digit
bne $t3, $t1, ElseIf6
addi $t2, $t2, 1 # add one to the number of cows( $t2 ) 
ElseIf6:
andi $t3, $t0, 0x00000000F # get the second digit
bne $t3, $t1, EndIf2
addi $t2, $t2, 1 # add one to the number of cows( $t2 ) 

EndIf2:
move $s5,$t2

addi $t6, $t6, 1 # i = i++
bne $t6,$t7, Loop



#print out the number of cows
la $a0, thereAre
li $v0, 4
syscall # print out " There are "
add $a0, $zero, $t2
li $v0, 1
syscall # print out the number of cows

la $a0, cowString
li $v0, 4
syscall # print out " cows."



jal musBulls


#restore return address
lw $ra, ($sp)
addi $sp, $sp, 4
jr $ra


Win:
la $a0, winString
li $v0, 4
syscall # print out " You win! "
la $a0, finalScoreMsg
li $v0, 4
syscall #print out "Your final score is "
move $a0, $s7
li $v0, 1
syscall #print out the score
la $a0, space
li $v0, 4
syscall

addi $s4, $zero, 4
addi $s5, $zero, 0
jal musBulls

li $v0, 10
syscall # exit

Shifting:
sll $t4, $t4, 4 # shift the user input( $s1 ) left by 4 bit. eg. 0x0000 1234 => 0x0001 2340
andi $t5, $t4, 0x000F0000 # get the 5th least-significant digit eg. 0x0001 2340 => 0x0001 0000
srl $t5, $t5, 16 # shift the 5th-significant digit right by 16 digit, which makes it the least-significant digit eg. 0x0000 0001
add $t4, $t4, $t5 # add the result of the left shifting( $t4 ) and right shifting( $t5 ), eg. 0x0001 2340 + 0x0000 2341
andi $t4, $t4, 0x0000FFFF # get the least 4 significant digit eg. 0x 2341
jr $ra


