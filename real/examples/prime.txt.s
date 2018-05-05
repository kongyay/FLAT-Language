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
	.string "All prime numbers between 1 to 100 are: \0"
.string47:
	.string " \0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$48, %rsp
	MOVL	%edi, -36(%rbp)
	MOVQ	%rsi, -48(%rbp)
	MOVQ	$0, -8(%rbp)
	MOVQ	$0, -16(%rbp)
	MOVQ	$0, -24(%rbp)
		MOVL	$.string3, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	$2, -8(%rbp)
		.startloop56:
				MOVQ 	-8(%rbp), %rax	# i
			CMPQ	$100, %rax
			JG 	.endif53
				MOVQ	$1, -24(%rbp)
					MOVQ	$2, -16(%rbp)
					.startloop39:
								MOVQ 	-8(%rbp), %rax	# i
								MOVQ	$2, %rbx
								CQTO
							IDIVQ	%rbx
							MOVQ	%rax, %rbx
							MOVQ 	-16(%rbp), %rax	# j
						CMPQ	%rbx, %rax
						JG 	.endif36
										MOVQ 	-16(%rbp), %rax	# j
										MOVQ	%rax, %rbx
										MOVQ 	-8(%rbp), %rax	# i
										CQTO
										IDIVQ	%rbx
									MOVQ	%rdx, %rax
								CMPQ	$0, %rax
								JNE	.endif34
									MOVQ	$0, -24(%rbp)
									MOVQ	$100, -16(%rbp)
								
							.endif34:
						
								MOVQ 	-16(%rbp), %rax	# j
							ADDQ	$1, %rax
						MOVQ	%rax, -16(%rbp)
						JMP	.startloop39
					.endif36:
				.endfor38:
						MOVQ 	-24(%rbp), %rax	# isPrime
					CMPQ	$1, %rax
					JNE	.endif51
							MOVQ	-8(%rbp), %rsi
							MOVL	$.FormatInt, %edi
							MOVL	$0, %eax
						CALL	printf
							MOVL	$.string47, %edi
							MOVL	$0, %eax
						CALL	printf
					
				.endif51:
			
					MOVQ 	-8(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -8(%rbp)
			JMP	.startloop56
		.endif53:
	.endfor55:
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVL	$.Smile, %edi
		MOVL	$0, %eax
	CALL	printf

MOVL	$0, %eax
leave
ret


