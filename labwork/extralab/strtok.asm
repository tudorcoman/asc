.data
    str: .asciz "Sir de caractere"
    chDelim: .asciz " "
    formatPrintf: .asciz "%s\n"
    res: .space 4
.text

.global main

main:
    pushl $chDelim
    pushl $str
    call strtok
    popl %ebx
    popl %ebx
    
    movl %eax, res
    
    pushl res
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx

et_for:
    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    cmp $0, %eax
    je exit

    movl %eax, res

    pushl res
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx

    jmp et_for

exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
