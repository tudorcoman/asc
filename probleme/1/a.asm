.data

.text

.globl _start

_start:
    mov $63, %eax
    and $1, %eax

    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
