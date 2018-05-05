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
.string7:
	.string "nTemperature in Fahrenheit : \0"
.globl main
main:
	PUSHQ   %rbp

	MOVQ	%rsp, %rbp
	SUBQ	$32, %rsp
	MOVL	%edi, -20(%rbp)
	MOVQ	%rsi, -32(%rbp)
	MOVQ	$25, -8(%rbp)
	MOVQ	$0, -16(%rbp)
				MOVQ 	-8(%rbp), %rax	# celsius
				MOVQ	$1, %rbx
			IMULQ	%rbx
		ADDQ	$32, %rax
	MOVQ	%rax, -16(%rbp)
		MOVL	$.string7, %edi
		MOVL	$0, %eax
	CALL	printf
		MOVQ	-16(%rbp), %rsi
		MOVL	$.FormatInt, %edi
		MOVL	$0, %eax
	CALL	printf

MOVL	$0, %eax
leave
ret


