.data
n: .long 7
str1: .asciz "Hello\n"
str2: .space 7

.text
.globl _start

_start:

mov $str1, %esi
mov $str2, %edi

mov n, %ecx

etloop:
mov n, %edx
sub %ecx, %edx
movb (%esi, %edx, 1), %al
movb %al, (%edi, %edx, 1)
loop etloop

label:
mov $4, %eax
mov $1, %ebx
mov $str2, %ecx
mov $7, %edx
int $0x80
jmp exit

exit:
mov $1, %eax
mov $0, %ebx
int $0x80
