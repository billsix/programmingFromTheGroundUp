
.section .data
if_symbol:
	.long SYMBOL_TYPE
	.long 1
	.long NULL
	.long 2
	.ascii "if\0"


.section .text
eval_expression:
	movl current_exp, %eax
	movl TYPE_POSITION(%eax), %ebx
	cmpl $SYMBOL_TYPE, %ebx
	jel  eval_symbol

	cmpl $PAIR_TYPE, %ebx
	jel  eval_procedure

eval_literal:
	movl current_continuation + PROC_POSITION, %eax
	jmpl *%eax

eval_symbol:
	cmpl %eax, $if_symbol
	jel  eval_if

	cmpl %eax, $cond_symbol
	jel  eval_cond

	cmpl %eax, $lambda_symbol
	jel  eval_lambda

	cmpl %eax, $define_symbol
	jel  eval_define

	cmpl %eax, $let_symbol
	jel  eval_let

	cmpl %eax, $letstar_symbol
	jel  eval_letstar

	cmpl %eax, $letrec_symbol
	jel  eval_letrec

	cmpl %eax, $quote_symbol
	jel  eval_quote

	cmpl %eax, %quasiquote_symbol
	jel  eval_quasiquote

eval_nonform_symbol:
	pushl $current_environment
	pushl %eax
	call  lookup_symbol

	movl %eax, %ebx

	movl  current_continuation + PROC_POSITION, %eax
	jmpl  *%eax
