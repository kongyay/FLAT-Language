.FormatStr:
	.string "%s\0"
.FormatInt:
	.string "%ld\0"
.FormatHex:
	.string "%x\0"
.NewLine:
	.string "\12\0"
.string23:
	.string " \0"
.string46:
	.string "*\0"
.string81:
	.string " \0"
.string107:
	.string "*\0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$64, %rsp
	MOVL	%edi, -52(%rbp)
	MOVQ	%rsi, -64(%rbp)
	MOVQ	$10, -8(%rbp)
	MOVQ	$20, -16(%rbp)
	MOVQ	$0, -24(%rbp)
	MOVQ	$0, -32(%rbp)
			MOVQ 	-8(%rbp), %rax	# max
		SUBQ	$1, %rax
	MOVQ	%rax, -40(%rbp)
		MOVQ	$1, -24(%rbp)
		.startloop61:
				MOVQ 	-8(%rbp), %rax	# max
				MOVQ	%rax, %rbx
				MOVQ 	-24(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif58
					MOVQ	$1, -32(%rbp)
					.startloop30:
							MOVQ 	-40(%rbp), %rax	# space
							MOVQ	%rax, %rbx
							MOVQ 	-32(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif27
							MOVL	$.string23, %edi
							MOVL	$0, %eax
						CALL	printf
								MOVQ 	-32(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -32(%rbp)
						JMP	.startloop30
					.endif27:
				.endfor29:
						MOVQ 	-40(%rbp), %rax	# space
					SUBQ	$1, %rax
				MOVQ	%rax, -40(%rbp)
					MOVQ	$1, -32(%rbp)
					.startloop53:
									MOVQ 	-24(%rbp), %rax	# i
									MOVQ	$2, %rbx
								IMULQ	%rbx
							SUBQ	$1, %rax
							MOVQ	%rax, %rbx
							MOVQ 	-32(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif50
								MOVL	$.string46, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-32(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -32(%rbp)
						JMP	.startloop53
					.endif50:
				.endfor52:
					MOVL	$.NewLine, %edi
					MOVL	$0, %eax
				CALL	printf
			
					MOVQ 	-24(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -24(%rbp)
			JMP	.startloop61
		.endif58:
	.endfor60:
	MOVQ	$1, -40(%rbp)
		MOVQ	$1, -24(%rbp)
		.startloop122:
					MOVQ 	-8(%rbp), %rax	# max
				SUBQ	$1, %rax
				MOVQ	%rax, %rbx
				MOVQ 	-24(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif119
					MOVQ	$1, -32(%rbp)
					.startloop88:
							MOVQ 	-40(%rbp), %rax	# space
							MOVQ	%rax, %rbx
							MOVQ 	-32(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif85
								MOVL	$.string81, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-32(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -32(%rbp)
						JMP	.startloop88
					.endif85:
				.endfor87:
						MOVQ 	-40(%rbp), %rax	# space
					ADDQ	$1, %rax
				MOVQ	%rax, -40(%rbp)
					MOVQ	$1, -32(%rbp)
					.startloop114:
										MOVQ 	-24(%rbp), %rax	# i
										MOVQ	%rax, %rbx
										MOVQ 	-8(%rbp), %rax	# max
									SUBQ	%rbx, %rax
									MOVQ	$2, %rbx
								IMULQ	%rbx
							SUBQ	$1, %rax
							MOVQ	%rax, %rbx
							MOVQ 	-32(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif111
								MOVL	$.string107, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-32(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -32(%rbp)
						JMP	.startloop114
					.endif111:
				.endfor113:
					MOVL	$.NewLine, %edi
					MOVL	$0, %eax
				CALL	printf
			
					MOVQ 	-24(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -24(%rbp)
			JMP	.startloop122
		.endif119:
	.endfor121:

MOVL	$0, %eax
leave
ret


