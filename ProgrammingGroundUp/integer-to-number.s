#PURPOSE: Convert an integer number to a decimal string for display
#
#INPUT:   A buffer large enough to hold the largest possible number
#         An integer to convert
#
#OUTPUT:  The buffer will be overwritten with the decimal string
#
#Variables:
#
#	%ecx will hold the index of the buffer
#       %eax will hold the current value
#
	.equ ST_VALUE, 8
	.equ ST_BUFFER, 12

	.equ TMP_BUFFER, -15 #(-4 - 11)

	.globl integer2number
	.type integer2number, @function
integer2number:
	#Normal function beginning
	pushl %ebp
	movl  %esp, %ebp

	#Allocate space for temporary buffer
	subl  $11, %esp

	#Initialize the counter
	movl  $0, %ecx

	#Move the value into position
	movl  ST_VALUE(%ebp), %eax

	#When we divide by 10, the 10
	#must be in a register or memory location
	movl  $10, %edi

conversion_loop:
	#Division is actually performed on the
	#combined %edx:%eax register, so first
	#clear out %edx
	movl  $0, %edx

	#Divide %edx:%eax (which are implied) by 10.
	#Store the quotient in %eax and the remainder
	#in %edx (both of which are also implied).
	divl  %edi

	#Quotient is in the right place.  %edx has
	#the remainder, which now needs to be converted
	#into a number.  So, %edx has a number that is
	#0 through 9.  You could also interpret this as
	#an index on the ASCII table starting from the
	#character '0'.  The ascii code for '0' plus zero
	#is still the ascii code for '0'.  The ascii code
	#for '0' plus 1 is the ascii code for the character
	#'1'.  Therefore, the following instruction will give
	#us the character for the number stored in %edx
	addl  $'0', %edx

	#Now we just need to move the character into place.
	#Remember, characters are only one byte long, so we
	#don't have to move the entire register, just it's
	#low byte.  In fact, if we do move the whole register,
	#it will cause problems because it will move extra
	#zeroes which will be treated as nulls.
	movb  %dl, TMP_BUFFER(%ebp,%ecx,1)

	#Check to see if %eax is zero yet, go to next step
	#if so.
	cmpl  $0, %eax
	je    end_conversion_loop

	#otherwise, go to the next digit and repeat
	incl  %ecx

	#%eax already has its new value.

	jmp conversion_loop

end_conversion_loop:
	#The string is now in TMP_BUFFER, but backwards.
	#So now, we just have to copy it into the buffer
	#given by ST_BUFFER and reverse it while copying.

	#Get the pointer to the buffer in %edx
	movl  ST_BUFFER(%ebp), %edx
	
copy_reversing_loop:
	movb  TMP_BUFFER(%ebp,%ecx,1), %al
	movb  %al, (%edx)
	cmpl  $0, %ecx
	je    end_copy_reversing_loop
	decl  %ecx
	incl  %edx
	jne   copy_reversing_loop
	

end_copy_reversing_loop:
	#Done copying.  Now just return

	movl  %ebp, %esp
	popl  %ebp
	ret
	
