
	.equ ST_OBJECT, 8

	.globl reference
	.type reference,@function
reference:
	pushl %ebp
	movl  %esp, %ebp

	movl  ST_OBJECT(%ebp), %eax

	#Null lists aren't referenced
	cmpl  $NULL_LIST, %eax
	jz    reference_end

	incl  REFCOUNT_POSITION(%eax)

reference_end:
	movl  %ebp, %esp
	popl  %ebp
	ret

	.globl dereference
	.type dereference,@function
dereference:
	pushl %ebp
	movl  %esp, %ebp

	movl  ST_OBJECT(%ebp), %eax

	#Don't dereference null list
	cmpl  $NULL_LIST, %eax
	jz    dereference_end

	decl  REFCOUNT_POSITION(%eax)
	
	jnz   dereference_end

	#refcount is 0, must delete

	#deactivate if possible
	cmpl $PAIR_TYPE, TYPE_POSITION(%eax)
	jnz delete_object

	push %eax	
	call pair_destroy
	popl %eax
	
delete_object:
	#FIXME - need to deactivate if not already done
	pushl %eax
	call  deallocate

dereference_end:
	movl  %ebp, %esp
	popl  %ebp
	ret

