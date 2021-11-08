.data
n: .long 5
s: .space 4

.text
.globl _start

_start:

mov $0, %ecx
mov $0, %eax

before:
cmp n, %ecx
jae exit
add %ecx, %eax
add $1, %ecx
jmp before

exit:
mov %eax, s
mov $1, %eax
mov $0, %ebx
int $0x80
