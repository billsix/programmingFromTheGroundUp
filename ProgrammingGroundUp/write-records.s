	#Program to write records to a file
	.equ LINUX_SYSCALL, 0x80
	.equ SYS_EXIT, 1
	.equ SYS_READ, 3
	.equ SYS_WRITE, 4
	.equ SYS_OPEN, 5
	.equ SYS_CLOSE, 6

	.equ RECORD_FIRSTNAME, 0
	.equ RECORD_LASTNAME, 40
	.equ RECORD_ADDRESS, 80
	.equ RECORD_AGE, 320

	.equ RECORD_SIZE, 324

	.section .data

	#Constant data of the records we want to write
	#Each text data item is padded to the proper
	#length with null (i.e. 0) bytes
record1:	
	.ascii "Fredrick\0"
	.rept 31 #Padding to 40 bytes
	.byte 0
	.endr
	
	.ascii "Bartlett\0"
	.rept 31 #Padding to 40 bytes
	.byte 0
	.endr
	
	.ascii "4242 S Prairie\nTulsa, OK 55555"
	.rept 210 #Padding to 240 bytes
	.byte 0
	.endr
	
	.long 45
	
record2:	
	.ascii "Fredrick\0"
	.rept 31 #Padding to 40 bytes
	.byte 0
	.endr
	
	.ascii "Bartlett\0"
	.rept 31 #Padding to 40 bytes
	.byte 0
	.endr
	
	.ascii "4242 S Prairie\nTulsa, OK 55555"
	.rept 210 #Padding to 240 bytes
	.byte 0
	.endr
	
	.long 45

record3:	
	.ascii "Fredrick\0"
	.rept 31 #Padding to 40 bytes
	.byte 0
	.endr
	
	.ascii "Bartlett\0"
	.rept 31 #Padding to 40 bytes
	.byte 0
	.endr
	
	.ascii "4242 S Prairie\nTulsa, OK 55555"
	.rept 210 #Padding to 240 bytes
	.byte 0
	.endr
	
	.long 45

	#This is the name of the file we will write to
file_name:
	.ascii "test.txt\0"

	.globl _start
	.equ FILE_DESCRIPTOR, -4

#This code was explained previously
#STACK LOCAL VARIABLES
	.equ ST_WRITE_BUFFER, 8
	.equ ST_FILEDES, 16
.section .text 
.globl write_record
.type, @function
write_record:
	pushl %ebp
	movl  %esp, %ebp

	pushl %ebx
	movl  ST_FILEDES(%ebp), %ebx
	movl  ST_WRITE_BUFFER(%ebp), %ecx
	movl  $RECORD_SIZE, %edx
	movl  $SYS_WRITE, %eax
	int   $LINUX_SYSCALL

	popl  %ebx

	movl  %ebp, %esp
	popl  %ebp
	ret

#This code was explained previously
#STACK LOCAL VARIABLES
	.equ ST_READ_BUFFER, 8
	.equ ST_FILEDES, 16
.section .text 
.globl read_record
.type, @function
read_record:
	pushl %ebp
	movl  %esp, %ebp

	pushl %ebx
	movl  ST_FILEDES(%ebp), %ebx
	movl  ST_READ_BUFFER(%ebp), %ecx
	movl  $RECORD_SIZE, %edx
	movl  $SYS_READ, %eax
	int   $LINUX_SYSCALL

	popl  %ebx

	movl  %ebp, %esp
	popl  %ebp
	ret

	
_start:
	#Copy the stack pointer to $ebp
	movl  %esp, %ebp
	#Allocate space to hold the file descriptor
	subl  $4, %esp

	#Open the file
	movl  $SYS_OPEN, %eax
	movl  $file_name, %ebx
	movl  $0101, %ecx #This says to create if it 
	                  #doesn't exist, and open for 
	                  #writing
	movl  $0666, %edx
	int   $LINUX_SYSCALL

	#Store the file descriptor away
	movl  %eax, FILE_DESCRIPTOR(%ebp)

	#Write the first record
	pushl FILE_DESCRIPTOR(%ebp)
	pushl $record1
	call  write_record
	addl  $8, %esp 

	#Write the second record
	pushl FILE_DESCRIPTOR(%ebp)
	pushl $record2
	call  write_record
	addl  $8, %esp 

	#Write the third record
	pushl FILE_DESCRIPTOR(%ebp)
	pushl $record3
	call  write_record
	addl  $8, %esp 

	#Close the file descriptor
	movl  $SYS_CLOSE, %eax
	movl  FILE_DESCRIPTOR(%ebp), %ebx	
	int   $LINUX_SYSCALL

	#Exit the program
	movl  $SYS_EXIT, %eax
	movl  $0, %ebx
	int   $LINUX_SYSCALL
