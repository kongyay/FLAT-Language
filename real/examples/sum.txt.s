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
	.string "Sum From 0 to \0"
.string32:
	.string "Sum = \0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$48, %rsp
	MOVL	%edi, -36(%rbp)
	MOVQ	%rsi, -48(%rbp)
	MOVQ	$16, -8(%rbp)
	MOVQ	$0, -16(%rbp)
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
		MOVQ	$1, -16(%rbp)
		.startloop30:
				MOVQ 	-8(%rbp), %rax	# n
				MOVQ	%rax, %rbx
				MOVQ 	-16(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif27
						MOVQ 	-16(%rbp), %rax	# i
						MOVQ	%rax, %rbx
						MOVQ 	-24(%rbp), %rax	# sum
					ADDQ	%rbx, %rax
				MOVQ	%rax, -24(%rbp)
			
					MOVQ 	-16(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -16(%rbp)
			JMP	.startloop30
		.endif27:
	.endfor29:
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

MOVL	$0, %eax
leave
ret


