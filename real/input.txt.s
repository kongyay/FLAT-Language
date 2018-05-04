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
	.string "Diamond !!\0"
.string29:
	.string " \0"
.string52:
	.string "*\0"
.string87:
	.string " \0"
.string113:
	.string "*\0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$48, %rsp
	MOVL	%edi, -36(%rbp)
	MOVQ	%rsi, -48(%rbp)
	MOVQ	$12, -8(%rbp)
	MOVQ	$0, -16(%rbp)
	MOVQ	$0, -24(%rbp)
		MOVL	$.string3, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
			MOVQ 	-8(%rbp), %rax	# max
		SUBQ	$1, %rax
	MOVQ	%rax, -32(%rbp)
		MOVQ	$1, -16(%rbp)
		.startloop67:
				MOVQ 	-8(%rbp), %rax	# max
				MOVQ	%rax, %rbx
				MOVQ 	-16(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif64
					MOVQ	$1, -24(%rbp)
					.startloop36:
							MOVQ 	-32(%rbp), %rax	# space
							MOVQ	%rax, %rbx
							MOVQ 	-24(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif33
								MOVL	$.string29, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-24(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -24(%rbp)
						JMP	.startloop36
					.endif33:
				.endfor35:
						MOVQ 	-32(%rbp), %rax	# space
					SUBQ	$1, %rax
				MOVQ	%rax, -32(%rbp)
					MOVQ	$1, -24(%rbp)
					.startloop59:
									MOVQ 	-16(%rbp), %rax	# i
									MOVQ	$2, %rbx
								IMULQ	%rbx
							SUBQ	$1, %rax
							MOVQ	%rax, %rbx
							MOVQ 	-24(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif56
								MOVL	$.string52, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-24(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -24(%rbp)
						JMP	.startloop59
					.endif56:
				.endfor58:
					MOVL	$.NewLine, %edi
					MOVL	$0, %eax
				CALL	printf
			
					MOVQ 	-16(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -16(%rbp)
			JMP	.startloop67
		.endif64:
	.endfor66:
	MOVQ	$1, -32(%rbp)
		MOVQ	$1, -16(%rbp)
		.startloop128:
					MOVQ 	-8(%rbp), %rax	# max
				SUBQ	$1, %rax
				MOVQ	%rax, %rbx
				MOVQ 	-16(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif125
					MOVQ	$1, -24(%rbp)
					.startloop94:
							MOVQ 	-32(%rbp), %rax	# space
							MOVQ	%rax, %rbx
							MOVQ 	-24(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif91
								MOVL	$.string87, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-24(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -24(%rbp)
						JMP	.startloop94
					.endif91:
				.endfor93:
						MOVQ 	-32(%rbp), %rax	# space
					ADDQ	$1, %rax
				MOVQ	%rax, -32(%rbp)
					MOVQ	$1, -24(%rbp)
					.startloop120:
										MOVQ 	-16(%rbp), %rax	# i
										MOVQ	%rax, %rbx
										MOVQ 	-8(%rbp), %rax	# max
									SUBQ	%rbx, %rax
									MOVQ	$2, %rbx
								IMULQ	%rbx
							SUBQ	$1, %rax
							MOVQ	%rax, %rbx
							MOVQ 	-24(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif117
								MOVL	$.string113, %edi
								MOVL	$0, %eax
							CALL	printf
						
								MOVQ 	-24(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -24(%rbp)
						JMP	.startloop120
					.endif117:
				.endfor119:
					MOVL	$.NewLine, %edi
					MOVL	$0, %eax
				CALL	printf
			
					MOVQ 	-16(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -16(%rbp)
			JMP	.startloop128
		.endif125:
	.endfor127:
		MOVL	$.Smile, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.Smile, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.Smile, %edi
		MOVL	$0, %eax
	CALL	printf

MOVL	$0, %eax
leave
ret


