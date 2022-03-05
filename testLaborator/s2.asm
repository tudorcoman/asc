
.data

.text

.global main

main:
    #movl $100, %esp
    pushl %eax
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
