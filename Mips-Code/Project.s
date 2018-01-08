#variables declarations
.data
array: .space 60     #allocate 60 consecutive bytes
size : .word 14      #create integer variable size=14
#create string message for print
mssg: .asciiz "Enter your Number of List : \n"    
EnterNumberMssg:  .asciiz "-Enter Number: "
numberMssg: .asciiz "\nEnter specific number for calc occurence : "
occurenceMssg: .asciiz"\nit's occurence number is : "
choiceMssg: .asciiz"\nEnter 1 to Enter new number or 2 for new List or other to Terminate : "
TerminatedMssg: .asciiz"\n The Program was Terminated"


#instructions
.text
main:

newList:  #Label for enter new List
#load varaibles
 la $t0,array      # load base of array to t0=array[]
#print mssg
 li $v0,4          # load appropriate system call code 4 into register $v0 for print string
 la $a0,mssg       # move String message to be printed into $a0 = mssg   #print(mssg)
 syscall           # call operating system to perform operation
#send base of array to argument of function $a1=array
 move $a1,$t0           
#call function to read List and store to array
 jal readList         

newNumber:       #Label for enter new number for count occurence for it
#enter specific number
    li $v0,4            # load appropriate system call code 4 into register $v0 for print string
    la $a0,numberMssg   # move String message to be printed into $a0 = numberMssg   #print(numberMssg)
    syscall             # call operating system to perform operation
#get the Float number
    li $v0,6            # load appropriate system call code 6 into register $v0 for reading float number
    syscall             # call operating system to perform operation
#store the number to register
  mov.s $f5,$f0

 
#prepare parameters to function
  add $a2,$zero,$t0         # store Base"address" of array to argument for function
#call getOccurence Function   
  jal getOccurence	           
#get return value from function
  move $s0,$v0            # get return count from function to register $s0 : occurenceNumber=count
#print occurenceMssg
  li $v0,4                #
  la $a0,occurenceMssg    # print("\nit's occurence number is : ")
  syscall                 #
#print occurence Number
  li $v0,1                #
  move $a0,$s0            #print(occurenceNumber)
  syscall                 #
 
newChoice:          #Label for Enter new choice
   li $v0,4             #
   la $a0,choiceMssg    # print("\nEnter 1 to Enter new number or 2 for new List or 3 to end : ")
   syscall              #

    li $v0,5            #  get ChoiceNumber to decide next operation
    syscall             #

  move $s0,$v0          #  put number to register $s0 : choiceNumber = $v0
  
  li $t1,1                     # load 1 to register for choice1
  li $t2,2                     # load 2 to register for choice2


  beq $s0,$t1 ,newNumber       # if choiceNumber == 1 then goto newNumber Label
  beq $s0,$t2 ,newList         # if choiceNumber == 2 then goto newList Label
  beq $s0,$zero ,newChoice     # if choiceNumber == 0 then goto newChoice Label
 
End:
#print TerminatedMssg
    li $v0,4              #
    la $a0,TerminatedMssg #print("\n The Program was Terminated")
    syscall               #
#End program	
 li $v0,10   #End program
 syscall	 #

 
 
###############################################################
#function of read List
readList:
#load variables
 move $s4,$zero   #create iterator =0
 lw $t3,size      #load size of List size=14    
readloop:         # begin readloop
 li $v0,1         #
 move $a0,$s4     # print "index of list" : print (iterator) 
 syscall          #

 li $v0,4                 #
 la $a0,EnterNumberMssg   # print("-Enter Number: ")
 syscall                  #

  li $v0,6       #get the float number from user 
  syscall        #
#store the float number to float Register
  mov.s $f1,$f0        #create variable for Store Number that user will Enter : scanf($f1);
#store number to List
  sll $t5,$s4,2        # iterator=iterator*4
  add $t5,$a1,$t5      # list=list+iterator
  s.s $f1,0($t5)       # store Number $f1 to array list=$f1
#check to end readloop
 beq $t3 ,$s4 , exit   # if iterator== size then go to exit
 add $s4,$s4,1         # iterator=iterator+1
 j readloop            # jump to readloop agian
exit:                  # exit Label
 jr $ra                # return to caller
###############################################################
 #function to getOccurence
 getOccurence:
  move $s2,$zero   #count the occurences : count=0
  move $s3,$zero   #iterator =0 
  lw $t2,size      #size =14
occurenceloop:     
  sll $t3,$s3,2    # iterator=iterator*4
  add $t3,$a2,$t3  # list=list+iterator
  l.s $f0,0($t3)   # load Number from address list to $f0 : $f0=list
  c.eq.s $f0,$f5   # if $f0==Number then code=1
  bc1f continue    # if code==0 then go to continue
  addi $s2,$s2,1   # count=count+1
 continue:
    beq $t2 ,$s3 , exxit   # if iterator== size then go to exit
    add $s3,$s3,1          # iterator=iterator+1
    j occurenceloop        # jump to occurenceloop agian
exxit:
  move $v0,$s2             # return value of count to caller
 jr $ra                    # return to caller