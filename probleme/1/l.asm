.data

.text

.globl _start

_start:
    mov $50, %eax
    mov $10, %ebx
    mov $4, %ecx

    add %eax, %eax
    add %ebx, %eax
    add %eax, %eax
    add %ecx, %eax
    xor %edx, %edx # %edx=0
    mov $2, %ebx
    div %ebx
    mov %eax, %ebx

    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
