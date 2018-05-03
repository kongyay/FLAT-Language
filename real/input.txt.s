.FormatStr:
	.string "%s\0"
.FormatInt:
	.string "%ld\0"
.FormatHex:
	.string "%x\0"
.NewLine:
	.string "\12\0"
.string8:
	.string "Diamond !!\0"
.string34:
	.string " \0"
.string57:
	.string "*\0"
.string92:
	.string " \0"
.string118:
	.string "*\0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$64, %rsp
	MOVL	%edi, -52(%rbp)
	MOVQ	%rsi, -64(%rbp)
	MOVQ	$15, -8(%rbp)
		MOVQ	$291, %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf
	MOVQ	$10, -16(%rbp)
	MOVQ	$0, -24(%rbp)
	MOVQ	$0, -32(%rbp)
		MOVL	$.string8, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
			MOVQ 	-16(%rbp), %rax	# max
		SUBQ	$1, %rax
	MOVQ	%rax, -40(%rbp)
		MOVQ	$1, -24(%rbp)
		.startloop72:
				MOVQ 	-16(%rbp), %rax	# max
				MOVQ	%rax, %rbx
				MOVQ 	-24(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif69
					MOVQ	$1, -32(%rbp)
					.startloop41:
							MOVQ 	-40(%rbp), %rax	# space
							MOVQ	%rax, %rbx
							MOVQ 	-32(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif38
								MOVL	$.string34, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-32(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -32(%rbp)
						JMP	.startloop41
					.endif38:
				.endfor40:
						MOVQ 	-40(%rbp), %rax	# space
					SUBQ	$1, %rax
				MOVQ	%rax, -40(%rbp)
					MOVQ	$1, -32(%rbp)
					.startloop64:
									MOVQ 	-24(%rbp), %rax	# i
									MOVQ	$2, %rbx
								IMULQ	%rbx
							SUBQ	$1, %rax
							MOVQ	%rax, %rbx
							MOVQ 	-32(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif61
								MOVL	$.string57, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-32(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -32(%rbp)
						JMP	.startloop64
					.endif61:
				.endfor63:
					MOVL	$.NewLine, %edi
					MOVL	$0, %eax
				CALL	printf
			
					MOVQ 	-24(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -24(%rbp)
			JMP	.startloop72
		.endif69:
	.endfor71:
	MOVQ	$1, -40(%rbp)
		MOVQ	$1, -24(%rbp)
		.startloop133:
					MOVQ 	-16(%rbp), %rax	# max
				SUBQ	$1, %rax
				MOVQ	%rax, %rbx
				MOVQ 	-24(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif130
					MOVQ	$1, -32(%rbp)
					.startloop99:
							MOVQ 	-40(%rbp), %rax	# space
							MOVQ	%rax, %rbx
							MOVQ 	-32(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif96
								MOVL	$.string92, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-32(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -32(%rbp)
						JMP	.startloop99
					.endif96:
				.endfor98:
						MOVQ 	-40(%rbp), %rax	# space
					ADDQ	$1, %rax
				MOVQ	%rax, -40(%rbp)
					MOVQ	$1, -32(%rbp)
					.startloop125:
										MOVQ 	-24(%rbp), %rax	# i
										MOVQ	%rax, %rbx
										MOVQ 	-16(%rbp), %rax	# max
									SUBQ	%rbx, %rax
									MOVQ	$2, %rbx
								IMULQ	%rbx
							SUBQ	$1, %rax
							MOVQ	%rax, %rbx
							MOVQ 	-32(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif122
								MOVL	$.string118, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-32(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -32(%rbp)
						JMP	.startloop125
					.endif122:
				.endfor124:
					MOVL	$.NewLine, %edi
					MOVL	$0, %eax
				CALL	printf
			
					MOVQ 	-24(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -24(%rbp)
			JMP	.startloop133
		.endif130:
	.endfor132:

MOVL	$0, %eax
leave
ret


