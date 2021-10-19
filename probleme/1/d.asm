.data

.text

.globl _start

_start:
    mov $63, %eax
    
    mov %eax, %ebx
    sub $1, %ebx
    and %ebx, %eax
   
    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
