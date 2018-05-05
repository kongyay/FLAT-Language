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
.string2:
	.string "Factors are: \0"
.string25:
	.string " \0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$32, %rsp
	MOVL	%edi, -20(%rbp)
	MOVQ	%rsi, -32(%rbp)
	MOVQ	$20, -8(%rbp)
	MOVQ	$0, -16(%rbp)
		MOVL	$.string2, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	$1, -16(%rbp)
		.startloop34:
				MOVQ 	-8(%rbp), %rax	# number
				MOVQ	%rax, %rbx
				MOVQ 	-16(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif31
							MOVQ 	-16(%rbp), %rax	# i
							MOVQ	%rax, %rbx
							MOVQ 	-8(%rbp), %rax	# number
							CQTO
							IDIVQ	%rbx
						MOVQ	%rdx, %rax
					CMPQ	$0, %rax
					JNE	.endif29
							MOVQ	-16(%rbp), %rsi
							MOVL	$.FormatInt, %edi
							MOVL	$0, %eax
						CALL	printf
							MOVL	$.string25, %edi
							MOVL	$0, %eax
						CALL	printf
					
				.endif29:
			
					MOVQ 	-16(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -16(%rbp)
			JMP	.startloop34
		.endif31:
	.endfor33:
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf

MOVL	$0, %eax
leave
ret


