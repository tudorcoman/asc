.data

.text

.globl _start

_start:
    mov $50, %eax
    mov $20, %ebx
    mov $60, %ecx

    sub %ecx, %ebx
    add %ebx, %eax
    mov %eax, %ecx

    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
