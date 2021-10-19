.data

.text

.globl _start

_start:
    mov $63, %eax
    xor %eax, %eax # rezultatul din %eax va fi mereu 0, deoarece a ^ a = 0, pt orice a
    
    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
