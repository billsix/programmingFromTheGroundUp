	.file	"test.c"
	.version	"01.01"
gcc2_compiled.:
.text
	.align 4
.globl main
	.type	 main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$0, %eax
	popl	%ebp
	ret
.Lfe1:
	.size	 main,.Lfe1-main
	.ident	"GCC: (GNU) 2.96 20000731 (Red Hat Linux 7.1 2.96-98)"
