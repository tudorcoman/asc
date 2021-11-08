.data
n: .long 5
v: .long 1, 2, 3, 4, 5
s: .space 4

.text
.globl _start

_start:

mov $0, %eax
mov $v, %edi
mov n, %ecx

etloop:
mov n, %edx
sub %ecx, %edx
addl (%edi, %edx, 4), %eax
loop etloop

label:
mov %eax, s

mov $1, %eax
mov $0, %ebx
int $0x80
