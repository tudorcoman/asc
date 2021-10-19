.data

.text

.globl _start

_start:
    mov $63, %eax
    mov $46, %ebx
    
    mov %eax, %edx
    not %eax
    and %edx, %eax


    mov %ebx, %edx
    not %ebx
    and %edx, %ebx

    or %ebx, %eax

    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
