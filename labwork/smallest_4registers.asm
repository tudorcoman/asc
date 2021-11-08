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
    mov c, %ecx
  
    mov %eax, %edx
    cmp %ebx, %edx
    jg bmaimic
    jmp vc

bmaimic:
    mov %ebx, %edx
    jmp vc

vc:
    cmp %ecx, %edx
    jg cmaimic
    jmp afisare

cmaimic:
    mov %ecx, %edx
    jmp afisare

afisare:
    cmp %eax, %edx
    je aafisare

    cmp %ebx, %edx
    je bafisare

    cmp %ecx, %edx
    je cafisare


aafisare:
    mov $str1, %ecx
    jmp print

bafisare:
    mov $str2, %ecx
    jmp print

cafisare:
    mov $str3, %ecx
    jmp print

print:
    mov $4, %eax
    mov $1, %ebx
    mov $25, %edx
    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
