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
.string48:
	.string "This is prime number\0"
.string55:
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
		MOVQ	$2, -16(%rbp)
		.startloop44:
					MOVQ 	-8(%rbp), %rax	# n
					MOVQ	$2, %rbx
					CQTO
				IDIVQ	%rbx
				MOVQ	%rax, %rbx
				MOVQ 	-16(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif41
							MOVQ 	-16(%rbp), %rax	# i
							MOVQ	%rax, %rbx
							MOVQ 	-8(%rbp), %rax	# n
							CQTO
							IDIVQ	%rbx
						MOVQ	%rdx, %rax
					CMPQ	$0, %rax
					JNE	.endif39
						MOVQ	$1, -24(%rbp)
							MOVQ	-8(%rbp), %rax
						MOVQ	%rax, -16(%rbp)
					
				.endif39:
			
					MOVQ 	-16(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -16(%rbp)
			JMP	.startloop44
		.endif41:
	.endfor43:
			MOVQ 	-24(%rbp), %rax	# flag
		CMPQ	$0, %rax
		JNE	.else63
				MOVL	$.string48, %edi
				MOVL	$0, %eax
			CALL	printf
				MOVL	$.NewLine, %edi
				MOVL	$0, %eax
			CALL	printf
		
		JMP	.endif62
		.else63:
				MOVL	$.string55, %edi
				MOVL	$0, %eax
			CALL	printf
				MOVL	$.NewLine, %edi
				MOVL	$0, %eax
			CALL	printf
		
	.endif62:

MOVL	$0, %eax
leave
ret


