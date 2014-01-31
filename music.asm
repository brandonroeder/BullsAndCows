.text

#t8= bulls counter
#t9= cows counter
addi $t8, $zero, 1
addi $t9, $zero, 1
musBulls: 
	  
	  beq $s4,$zero, musCows
	  la $t1, 62
	  move $a0, $t1 #pitch
	  li $a1, 500 #time
	  li $a2, 32 #instrument
	  li $a3, 100 #volume
	  li $v0, 33 #beep with pause
	  syscall
	  beq $t8, $s4, musCows #Branch out when the correct number of tones has played
	  addi $t8, $t8, 1 #Increase counter if loop must continue 
	  j musBulls #Continue loop

musCows: 
	 beq $s5,$zero, done
	 la $t1,  69
	 move $a0, $t1 #pitch
	 li $a1, 500 #time
	 li $a2, 32 #instrument
	 li $a3, 100 #volume
	 li $v0, 33 #beep with pause
	 syscall
	 beq $t9, $s5, done #Branch out when the correct number of tones has played
	 addi $t9, $t9, 1 #Increase counter if loop must continue
	 j musCows #Continue loop
	 

j musCows
	 
done: 
	jr $ra
