
.data

.text
.globl _start

_start:
    mov $2, %eax
    mov $4, %ebx
    mov $10, %ecx

    add %ebx, %eax
    add %ecx, %eax

    sal $4, %eax
   
    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
