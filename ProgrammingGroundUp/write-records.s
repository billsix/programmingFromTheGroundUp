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

file_name:
	.ascii "test.txt\0"

	#Actual code here
	.globl _start
	.equ FILE_DESCRIPTOR, -4

#PURPOSE:   This function writes a record to the file descriptor
#
#INPUT:     The file descriptor and a buffer
#
#OUTPUT:    This function produces a status code
#
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

	#NOTE - %eax has the return value, which we will
	#       give back to our calling program
	popl  %ebx

	movl  %ebp, %esp
	popl  %ebp
	ret



#PURPOSE:   This function reads a record from the file descriptor
#
#INPUT:     The file descriptor and a buffer
#
#OUTPUT:    This function writes the data to the buffer and returns
#           a status code.
#
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

	#NOTE - %eax has the return value, which we will
	#       give back to our calling program
	popl  %ebx

	movl  %ebp, %esp
	popl  %ebp
	ret

	
_start:
	movl  %esp, %ebp
	subl  $4, %esp

	movl  $SYS_OPEN, %eax
	movl  $file_name, %ebx
	movl  $0101, %ecx #This says to create if it 
	                  #doesn't exist, and open for 
	                  #writing
	movl  $0666, %edx
	int   $LINUX_SYSCALL
	
	movl  %eax, FILE_DESCRIPTOR(%ebp)

	pushl %eax
	pushl $record1
	call  write_record
	addl  $8, %esp 

	pushl FILE_DESCRIPTOR(%ebp)
	pushl $record2
	call  write_record
	addl  $8, %esp 

	pushl FILE_DESCRIPTOR(%ebp)
	pushl $record3
	call  write_record
	addl  $8, %esp 

	movl  $SYS_CLOSE, %eax
	movl  FILE_DESCRIPTOR(%ebp), %ebx	
	int   $LINUX_SYSCALL

	movl  $SYS_EXIT, %eax
	movl  $0, %ebx
	int   $LINUX_SYSCALL
