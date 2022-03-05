
.data

.text

.global main

main:
    movl $0xae2b, %eax
    movl %eax, %ecx
    decl %ecx

et_loop:
    cmp $0, %ecx
    jl et_exit
    incl %ecx
    jmp et_loop

et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
