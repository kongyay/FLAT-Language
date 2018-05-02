.FormatStr:
        .string "%s\0"
.FormatInt:
        .string "%ld\0"
.FormatHex:
        .string "%x\0"
.NewLine:
        .string "\12\0"
.string18:
        .string " \0"
.globl main
main:
        PUSHQ   %rbp

        MOVQ    %rsp, %rbp
        SUBQ    $32, %rsp
        MOVL    %edi, -20(%rbp)
        MOVQ    %rsi, -32(%rbp)
        MOVQ    $0, -8(%rbp)
        MOVQ    $0, -16(%rbp)
                MOVQ    $16, -8(%rbp)
                .startloop33:
                        CMPQ    $50, -8(%rbp)
                        JGE     .endif30
                                        MOVQ    $0, -16(%rbp)
                                        .startloop25:
                                                        MOVQ    -16(%rbp), %rax
                                                CMPQ    -8(%rbp), %rax
                                                JG      .endif22
                                                                MOVQ    -16(%rbp), %rax
                                                                MOVQ    %rax, %rsi
                                                                MOVL    $.FormatHex, %edi
                                                                MOVL    $0, %eax
                                                        CALL    printf
                                                                MOVL    $.string18, %edi
                                                                MOVL    $0, %eax
                                                        CALL    printf

                                                        ADDQ    $1, -16(%rbp)
                                                        MOVQ    -16(%rbp), %rax
                                                MOVQ    %rax, -16(%rbp)
                                                JMP     .startloop25
                                        .endif22:
                                .endfor24:
                                        MOVL    $.NewLine, %edi
                                        MOVL    $0, %eax
                                CALL    printf

                                ADDQ    $1, -8(%rbp)
                                MOVQ    -8(%rbp), %rax
                        MOVQ    %rax, -8(%rbp)
                        JMP     .startloop33
                .endif30:
        .endfor32:

MOVL    $0, %eax
leave
ret
