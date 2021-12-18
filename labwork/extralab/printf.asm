// gcc -m32 printf.o -o printf

.data
    formatPrintf: .asciz "Numarul %d\n"
    formatNoFlush: .asciz "Numarul %d %d"
    x: .long 5
.text

.global main

main:
    pushl x
    pushl $formatPrintf  
    call printf
    popl %ebx
    popl %ebx

    pushl $4
    pushl x
    pushl $formatNoFlush
    call printf
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

et_exit:
    movl $1, %eax # apelul sistem EXIT
    xorl %ebx, %ebx # codul de return (%ebx = 0)
    int $0x80


