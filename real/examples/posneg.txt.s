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
	.string "This is a positive number\0"
.string7:
	.string "This is a negative number\0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$32, %rsp
	MOVL	%edi, -20(%rbp)
	MOVQ	%rsi, -32(%rbp)
	MOVQ	$-10, -8(%rbp)
			MOVQ 	-8(%rbp), %rax	# number
		CMPQ	$0, %rax
		JL 	.else15
				MOVL	$.string3, %edi
				MOVL	$0, %eax
			CALL	printf
		
		JMP	.endif14
		.else15:
				MOVL	$.string7, %edi
				MOVL	$0, %eax
			CALL	printf
				MOVL	$.NewLine, %edi
				MOVL	$0, %eax
			CALL	printf
		
	.endif14:

MOVL	$0, %eax
leave
ret


