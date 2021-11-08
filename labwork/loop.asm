.data
n: .long 5
s: .space 4

.text
.globl _start

_start:

mov $0, %eax
mov n, %ecx
sub $1, %ecx

etloop:
add %ecx, %eax
loop etloop

mov %eax, s

label:

exit:
mov $1, %eax
mov $0, %ebx
int $0x80
