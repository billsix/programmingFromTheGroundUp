	#PURPOSE - Given a number, this program computes the
	#          factorial.  For example, the factorial of
	#          3 is 3 * 2 * 1, or 6.  The factorial of
	#          4 is 4 * 3 * 2 * 1, or 24, and so on.
	#

	#This program shows how to call a function.  You
	#call a function by first pushing all the arguments,
	#then you call the function, and the resulting
	#value is in %eax.  The program can also change the
	#passed parameters if it wants to.

	.section .data

	#This program has no global data

	.section .text

	.globl _start
	.globl factorial    #this is unneeded unless we want to share
	                    #this function among other programs
_start:
	pushl $4            #The factorial takes one argument - the number
	                    #we want a factorial of.  So, it gets pushed
	call  factorial     #run the factorial function
	popl  %ebx          #always remember to pop anything you pushed
	movl  %eax, %ebx    #factorial returns the answer in %eax, but we 
	                    #want it in %ebx to send it as our exit status
	movl  $1, %eax      #call the kernel's exit function
	int   $0x80


	#This is the actual function definition
	.type factorial,@function
factorial:
	pushl %ebp          #standard function stuff - we have to restore
	                    #ebp to its prior state before returning,
	                    #so we have to push it
	movl  %esp, %ebp    #This is because we don't want to modify
	                    #the stack pointer, so we use %ebp instead.
	                    #This is also because %ebp is more flexible

	movl  8(%ebp), %eax #This moves the first argument into %eax
	                    #4(%ebp) holds the return address, and
	                    #8(%ebp) holds the address of the first parameter
	cmpl  $1, %eax      #If the number is 1, that is our base case, and 
	                    #we simply return (1 is already in %eax as the
	                    #return value)
	je end_factorial    
	decl  %eax          #otherwise, decrease the value
	pushl %eax          #push it for our next call to factorial
	call  factorial     #call factorial
	popl  %ebx          #this is the number we called factorial with
	                    #we have to pop it off, but we also need
	                    #it to find the number we were called with
	incl  %ebx          #(which is one more than what we pushed)
	imul  %ebx, %eax    #multiply that by the result of the last
	                    #call to factorial (stored in %eax)
	                    #the answer is stored in %eax, which is 
	                    #good since that's where return values
	                    #go.
end_factorial:
	movl  %ebp, %esp    #standard function return stuff - we
	popl  %ebp          #have to restore %ebp and %esp to where
	                    #they were before the function started
	ret                 #return to the function (this pops the return value, too)
	

