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
	.string "Is \0"
.string11:
	.string " a prime number?\0"
.string39:
	.string "This is prime number\0"
.string46:
	.string "This is not a prime number\0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$48, %rsp
	MOVL	%edi, -36(%rbp)
	MOVQ	%rsi, -48(%rbp)
	MOVQ	$11, -8(%rbp)
	MOVQ	$0, -16(%rbp)
	MOVQ	$0, -24(%rbp)
		MOVL	$.string3, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	-8(%rbp), %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.string11, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
			MOVQ 	-24(%rbp), %rax	# flag
		CMPQ	$0, %rax
		JNE	.else54
				MOVL	$.string39, %edi
				MOVL	$0, %eax
			CALL	printf
				MOVL	$.NewLine, %edi
				MOVL	$0, %eax
			CALL	printf
		
		JMP	.endif53
		.else54:
				MOVL	$.string46, %edi
				MOVL	$0, %eax
			CALL	printf
				MOVL	$.NewLine, %edi
				MOVL	$0, %eax
			CALL	printf
		
	.endif53:

MOVL	$0, %eax
leave
ret


