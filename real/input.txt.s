.FormatStr:
	.string "%s\0"
.FormatInt:
	.string "%ld\0"
.FormatHex:
	.string "%x\0"
.NewLine:
	.string "\12\0"
.string22:
	.string " \0"
.string45:
	.string "*\0"
.string80:
	.string " \0"
.string106:
	.string "*\0"
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
MOVQ 	-8(%rbp), %rax	# max
SUBQ	$1, %rax
MOVQ	%rax, -32(%rbp)
MOVQ	$1, -16(%rbp)
.startloop60:
MOVQ 	-8(%rbp), %rax	# max
MOVQ	%rax, %rbx
MOVQ 	-16(%rbp), %rax	# i
CMPQ	%rbx, %rax
JG 	.endif57
MOVQ	$1, -24(%rbp)
.startloop29:
MOVQ 	-32(%rbp), %rax	# space
MOVQ	%rax, %rbx
MOVQ 	-24(%rbp), %rax	# j
CMPQ	%rbx, %rax
JG 	.endif26
MOVL	$.string22, %edi
MOVL	$0, %eax
CALL	printf
MOVQ 	-24(%rbp), %rax	# j
ADDQ	$1, %rax
MOVQ	%rax, -24(%rbp)
JMP	.startloop29
.endif26:
.endfor28:
MOVQ 	-32(%rbp), %rax	# space
SUBQ	$1, %rax
MOVQ	%rax, -32(%rbp)
MOVQ	$1, -24(%rbp)
.startloop52:
MOVQ 	-16(%rbp), %rax	# i
MOVQ	$2, %rbx
IMULQ	%rbx
SUBQ	$1, %rax
MOVQ	%rax, %rbx
MOVQ 	-24(%rbp), %rax	# j
CMPQ	%rbx, %rax
JG 	.endif49
MOVL	$.string45, %edi
MOVL	$0, %eax
CALL	printf

MOVQ 	-24(%rbp), %rax	# j
ADDQ	$1, %rax
MOVQ	%rax, -24(%rbp)
JMP	.startloop52
.endif49:
.endfor51:
MOVL	$.NewLine, %edi
MOVL	$0, %eax
CALL	printf

MOVQ 	-16(%rbp), %rax	# i
ADDQ	$1, %rax
MOVQ	%rax, -16(%rbp)
JMP	.startloop60
.endif57:
.endfor59:
MOVQ	$1, -32(%rbp)
MOVQ	$1, -16(%rbp)
.startloop121:
MOVQ 	-8(%rbp), %rax	# max
SUBQ	$1, %rax
MOVQ	%rax, %rbx
MOVQ 	-16(%rbp), %rax	# i
CMPQ	%rbx, %rax
JG 	.endif118
MOVQ	$1, -24(%rbp)
.startloop87:
MOVQ 	-32(%rbp), %rax	# space
MOVQ	%rax, %rbx
MOVQ 	-24(%rbp), %rax	# j
CMPQ	%rbx, %rax
JG 	.endif84
MOVL	$.string80, %edi
MOVL	$0, %eax
CALL	printf

MOVQ 	-24(%rbp), %rax	# j
ADDQ	$1, %rax
MOVQ	%rax, -24(%rbp)
JMP	.startloop87
.endif84:
.endfor86:
MOVQ 	-32(%rbp), %rax	# space
ADDQ	$1, %rax
MOVQ	%rax, -32(%rbp)
MOVQ	$1, -24(%rbp)
.startloop113:
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
JG 	.endif110
MOVL	$.string106, %edi
MOVL	$0, %eax
CALL	printf

MOVQ 	-24(%rbp), %rax	# j
ADDQ	$1, %rax
MOVQ	%rax, -24(%rbp)
JMP	.startloop113
.endif110:
.endfor112:
MOVL	$.NewLine, %edi
MOVL	$0, %eax
CALL	printf

MOVQ 	-16(%rbp), %rax	# i
ADDQ	$1, %rax
MOVQ	%rax, -16(%rbp)
JMP	.startloop121
.endif118:
.endfor120:

MOVL	$0, %eax
leave
ret


