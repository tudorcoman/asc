.data

.text

.globl _start

_start:
    
    # introduc doua valori distincte in eax si ebx:
    mov $5, %eax
    mov $7, %ebx

    xor %ebx, %eax
    xor %eax, %ebx
    xor %ebx, %eax

    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
