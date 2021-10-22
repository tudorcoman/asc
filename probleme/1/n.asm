
.data

.text
.globl _start

_start:
    mov $32, %eax
    mov $4, %ebx

    sar $4, %eax
    sal $4, %ebx
    mov %eax, %ecx
    add %ebx, %ecx
   
    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
