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
.string5:
	.string "Fibonacci Series: \0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$64, %rsp
	MOVL	%edi, -52(%rbp)
	MOVQ	%rsi, -64(%rbp)
	MOVQ	$0, -8(%rbp)
	MOVQ	$10, -16(%rbp)
	MOVQ	$0, -24(%rbp)
	MOVQ	$1, -32(%rbp)
	MOVQ	$0, -40(%rbp)
		MOVL	$.string5, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	$1, -8(%rbp)
		.startloop36:
				MOVQ 	-16(%rbp), %rax	# n
				MOVQ	%rax, %rbx
				MOVQ 	-8(%rbp), %rax	# i
			CMPQ	%rbx, %rax
			JG 	.endif33
					MOVQ	-24(%rbp), %rsi
					MOVL	$.FormatInt, %edi
					MOVL	$0, %eax
				CALL	printf
						MOVQ 	-32(%rbp), %rax	# t2
						MOVQ	%rax, %rbx
						MOVQ 	-24(%rbp), %rax	# t1
					ADDQ	%rbx, %rax
				MOVQ	%rax, -40(%rbp)
					MOVQ	-32(%rbp), %rax
				MOVQ	%rax, -24(%rbp)
					MOVQ	-40(%rbp), %rax
				MOVQ	%rax, -32(%rbp)
					MOVL	$.NewLine, %edi
					MOVL	$0, %eax
				CALL	printf
			
					MOVQ 	-8(%rbp), %rax	# i
				ADDQ	$1, %rax
			MOVQ	%rax, -8(%rbp)
			JMP	.startloop36
		.endif33:
	.endfor35:
		MOVL	$.NewLine, %edi
		MOVL	$0, %eax
	CALL	printf

MOVL	$0, %eax
leave
ret


