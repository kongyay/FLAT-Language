.FormatStr:
	.string "%s\0"
.FormatInt:
	.string "%ld\0"
.FormatHex:
	.string "%x\0"
.NewLine:
	.string "\12\0"
.Smile:
	.string "Have a good day :)\12\0"
.Sad:
	.string "Don't cry :(\12\0"
.string8:
	.string " / \0"
.string32:
	.string "Quotient = \0"
.string43:
	.string "remainder = \0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$48, %rsp
	MOVL	%edi, -36(%rbp)
	MOVQ	%rsi, -48(%rbp)
	MOVQ	$10, -8(%rbp)
	MOVQ	$5, -16(%rbp)
	MOVQ	$0, -24(%rbp)
	MOVQ	$0, -32(%rbp)
		MOVQ	-8(%rbp), %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.string8, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	-16(%rbp), %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
			MOVQ 	-16(%rbp), %rax	# divisor
			MOVQ	%rax, %rbx
			MOVQ 	-8(%rbp), %rax	# dividend
			CQTO
		IDIVQ	%rbx
	MOVQ	%rax, -24(%rbp)
			MOVQ 	-16(%rbp), %rax	# divisor
			MOVQ	%rax, %rbx
			MOVQ 	-8(%rbp), %rax	# dividend
			CQTO
			IDIVQ	%rbx
		MOVQ	%rdx, %rax
	MOVQ	%rax, -32(%rbp)
		MOVL	$.string32, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	-24(%rbp), %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.string43, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	-32(%rbp), %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf

MOVL	$0, %eax
leave
ret


