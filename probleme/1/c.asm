.data

.text

.globl _start

_start:
    mov $63, %eax
    mov $46, %ebx
   
    xor %ebx, %eax
    xor %ebx, %eax

    # rezultatul aflat in %eax va fi intotdeauna valoarea initiala din %eax deoarece (a ^ b) ^ b = a ^ (b ^ b) = a ^ 0 = a, pt orice a si b 
    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
