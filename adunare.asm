.data
x: .long 5
y: .long 6
z: .long 7

.text
.globl _start
_start:

mov x, %eax
mov y, %ebx
mov z, %ecx

add %eax, %ebx
add %ebx, %ecx

mov $1, %eax
mov $0, %ebx
int $0x80
