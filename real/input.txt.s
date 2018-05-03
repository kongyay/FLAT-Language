.FormatStr:
	.string "%s\0"
.FormatInt:
	.string "%ld\0"
.FormatHex:
	.string "%x\0"
.NewLine:
	.string "\12\0"
.string33:
	.string "This is prime number\0"
.string40:
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
MOVQ	$2, -16(%rbp)
.startloop29:
MOVQ 	-8(%rbp), %rax	# n
MOVQ	$2, %rbx
CQTO
IDIVQ	%rbx
MOVQ	%rax, %rbx
MOVQ 	-16(%rbp), %rax	# i
CMPQ	%rbx, %rax
JG 	.endif26
MOVQ 	-16(%rbp), %rax	# i
MOVQ	%rax, %rbx
MOVQ 	-8(%rbp), %rax	# n
CQTO
IDIVQ	%rbx
MOVQ	%rdx, %rax
CMPQ	$0, %rax
JNE	.endif24
MOVQ	$1, -24(%rbp)
MOVQ	-8(%rbp), %rax
MOVQ	%rax, -16(%rbp)

.endif24:

MOVQ 	-16(%rbp), %rax	# i
ADDQ	$1, %rax
MOVQ	%rax, -16(%rbp)
JMP	.startloop29
.endif26:
.endfor28:
MOVQ 	-24(%rbp), %rax	# flag
CMPQ	$0, %rax
JNE	.else48
MOVL	$.string33, %edi
MOVL	$0, %eax
CALL	printf
MOVL	$.NewLine, %edi
MOVL	$0, %eax
CALL	printf

JMP	.endif47
.else48:
MOVL	$.string40, %edi
MOVL	$0, %eax
CALL	printf
MOVL	$.NewLine, %edi
MOVL	$0, %eax
CALL	printf

.endif47:

MOVL	$0, %eax
leave
ret


