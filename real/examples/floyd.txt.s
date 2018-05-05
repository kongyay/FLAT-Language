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
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$48, %rsp
	MOVL	%edi, -36(%rbp)
	MOVQ	%rsi, -48(%rbp)
	MOVQ	$10, -8(%rbp)
	MOVQ	$0, -16(%rbp)
	MOVQ	$0, -24(%rbp)
	MOVQ	$1, -32(%rbp)
		MOVQ	$1, -16(%rbp)
		.startloop38:
				MOVQ 	-8(%rbp), %rax	# rows
				MOVQ	%rax, %rbx
				MOVQ 	-16(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif35
					MOVQ	$1, -24(%rbp)
					.startloop30:
							MOVQ 	-16(%rbp), %rax	# i
							MOVQ	%rax, %rbx
							MOVQ 	-24(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif27
								MOVQ	-32(%rbp), %rsi
								MOVL	$.FormatInt, %edi
								MOVL	$0, %eax
							CALL	printf
									MOVQ 	-32(%rbp), %rax	# number
								ADDQ	$1, %rax
							MOVQ	%rax, -32(%rbp)
						
								MOVQ 	-24(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -24(%rbp)
						JMP	.startloop30
					.endif27:
				.endfor29:
					MOVL	$.NewLine, %edi
					MOVL	$0, %eax
				CALL	printf
			
					MOVQ 	-16(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -16(%rbp)
			JMP	.startloop38
		.endif35:
	.endfor37:

MOVL	$0, %eax
leave
ret


