.data
s: .asciz "Hello world!\n"

.text
.globl _start

_start:
mov $4, %eax
mov $1, %ebx
mov $s, %ecx
mov $14, %edx
int $0x80

mov $1, %eax
mov $0, %ebx
int $0x80
