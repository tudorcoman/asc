.data
a: .long 19
b: .long 5
c: .long 21

str1: .asciz "a este cel mai mic numar\n"
str2: .asciz "b este cel mai mic numar\n"
str3: .asciz "c este cel mai mic numar\n"

.text

.globl _start

_start:
    mov a, %eax
    mov b, %ebx

    cmp %eax, %ebx
    jg b_mai_mare_a

    mov c, %eax
    cmp %eax, %ebx
    jg c_cel_mai_mic
    
    jmp b_cel_mai_mic

b_mai_mare_a:
    mov c, %ebx
    cmp %eax, %ebx
    jg a_cel_mai_mic
    jmp c_cel_mai_mic

a_cel_mai_mic:
    mov $str1, %ecx
    jmp print

b_cel_mai_mic:
    mov $str2, %ecx
    jmp print

c_cel_mai_mic:
    mov $str3, %ecx
    jmp print

print:
    mov $4, %eax
    mov $1, %ebx
    mov $26, %edx
    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
