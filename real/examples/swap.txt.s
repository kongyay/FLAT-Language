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
.string3:
	.string "The first number: \0"
.string14:
	.string "The second number: \0"
.string34:
	.string "After Swapping\0"
.string41:
	.string "The first number: \0"
.string52:
	.string "The second number: \0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$48, %rsp
	MOVL	%edi, -36(%rbp)
	MOVQ	%rsi, -48(%rbp)
	MOVQ	$1, -8(%rbp)
	MOVQ	$2, -16(%rbp)
	MOVQ	$0, -24(%rbp)
		MOVL	$.string3, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	-8(%rbp), %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.string14, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	-16(%rbp), %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	-8(%rbp), %rax
	MOVQ	%rax, -24(%rbp)
		MOVQ	-16(%rbp), %rax
	MOVQ	%rax, -8(%rbp)
		MOVQ	-24(%rbp), %rax
	MOVQ	%rax, -16(%rbp)
		MOVL	$.string34, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.string41, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	-8(%rbp), %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.string52, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	-16(%rbp), %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf

MOVL	$0, %eax
leave
ret


