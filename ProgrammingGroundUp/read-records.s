	#Program to write records to a file
	.equ LINUX_SYSCALL, 0x80
	.equ SYS_EXIT, 1
	.equ SYS_READ, 3
	.equ SYS_WRITE, 4
	.equ SYS_OPEN, 5
	.equ SYS_CLOSE, 6

	.equ STDOUT, 1

	

	.equ RECORD_FIRSTNAME, 0
	.equ RECORD_LASTNAME, 40
	.equ RECORD_ADDRESS, 80
	.equ RECORD_AGE, 320

	.equ RECORD_SIZE, 324

	.section .data
file_name:
	.ascii "test.txt\0"
	
	.section .bss
	.lcomm record_buffer, RECORD_SIZE
#This code was explained previously
#STACK LOCAL VARIABLES
	.equ ST_READ_BUFFER, 8
	.equ ST_FILEDES, 12
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



#PURPOSE:  Count the characters until a null byte is reached.
#
#INPUT:    The address of the character string
#
#OUTPUT:   Returns the count in %eax
#
#PROCESS:  
#  Registers used:
#    %ecx - character count
#    %al - current character
#    %edx - current character address

	.type count_chars, @function
	.globl count_chars

	.equ DATA_START_ADDRESS, 8
count_chars:
	pushl %ebp
	movl  %esp, %ebp
	
	#Counter starts at zero
	movl  $0, %ecx  

	#Starting address of data
	movl  DATA_START_ADDRESS(%ebp), %edx

count_loop_begin:
	#Grab the current character
	movb  (%edx), %al
	#Is it null?
	cmpb  $0, %al
	#If yes, we're done
	je    count_loop_end
	#Otherwise, increment the counter and the pointer
	incl  %ecx
	incl  %edx
	#Go back to the beginning of the loop
	jmp   count_loop_begin

count_loop_end:
	#We're done.  Move the count into %eax
	#and return.
	movl  %ecx, %eax

	popl  %ebp
	ret

	.globl write_newline
	.type write_newline, @function
	.section .data
newline:
	.ascii "\n"
	.section .text
	.equ ST_FILEDES, 8
write_newline:
	pushl %ebp
	movl  %esp, %ebp

	movl  $SYS_WRITE, %eax
	movl  ST_FILEDES(%ebp), %ebx
	movl  $newline, %ecx
	movl  $1, %edx
	int   $LINUX_SYSCALL

	movl  %ebp, %esp
	popl  %ebp
	ret

	#Main program
	.globl _start
_start:
	.equ INPUT_DESCRIPTOR, -4
	.equ OUTPUT_DESCRIPTOR, -8
	#Copy the stack pointer to %ebp
	movl  %esp, %ebp
	#Allocate space to hold the file descriptors
	subl  $8, %esp

	#Open the file
	movl  $SYS_OPEN, %eax
	movl  $file_name, %ebx
	movl  $0, %ecx    #This says to open read-only
	movl  $0666, %edx
	int   $LINUX_SYSCALL

	#Save file descriptor
	
	movl  %eax, INPUT_DESCRIPTOR(%ebp)

	#Even though it's a constant, we are
	#saving the output file descriptor in
	#a local variable so that if we later
	#decide that it isn't always going to
	#be STDOUT, we can change it easily.
	movl  $STDOUT, OUTPUT_DESCRIPTOR(%ebp)


record_read_loop:	
	pushl INPUT_DESCRIPTOR(%ebp)
	pushl $record_buffer
	call  read_record
	addl  $8, %esp

	#Returns the number of bytes read.
	#If it isn't the same number we
	#requested, then it's either an
	#end-of-file, or an error, so we're
	#quitting
	cmpl  $RECORD_SIZE, %eax
	jne   finished_reading

	#Otherwise, print out the first name
	#but first, we must know it's size
	pushl  $RECORD_FIRSTNAME + record_buffer
	call   count_chars
	addl   $4, %esp

	movl   %eax, %edx
	movl   OUTPUT_DESCRIPTOR(%ebp), %ebx
	movl   $SYS_WRITE, %eax
	movl   $RECORD_FIRSTNAME + record_buffer, %ecx
	int    $LINUX_SYSCALL

	pushl  OUTPUT_DESCRIPTOR(%ebp)
	call   write_newline
	addl   $4, %esp

	jmp    record_read_loop
	
finished_reading:
	movl   $SYS_EXIT, %eax
	movl   $0, %ebx
	int    $LINUX_SYSCALL
