.data
    a: .long 0
    poz: .asciz "a este pozitiv\n"
    z: .asciz "a = 0\n"
    neg: .asciz "a este negativ\n"

.text
.globl _start

_start:
    mov a, %eax
    mov $0, %ebx
    cmp %eax, %ebx
    jl pozitiv

    mov a, %eax
    mov $0, %ebx
    cmp %eax, %ebx
    je zero

    jmp negativ

    int $0x80
    jmp exit

pozitiv:
    mov $4, %eax
    mov $1, %ebx
    mov $poz, %ecx
    mov $15, %edx
    int $0x80
    jmp exit

zero:
    mov $4, %eax
    mov $1, %ebx
    mov $z, %ecx
    mov $6, %edx
    int $0x80
    jmp exit

negativ:
    mov $4, %eax
    mov $1, %ebx
    mov $neg, %ecx
    mov $15, %edx
    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
