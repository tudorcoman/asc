
.data
x: .space 4
formatScanf: .asciz "%d"
formatPrintf: .asciz "%d\n"

.text

f:
pushl %ebp
movl %esp, %ebp

pushl 8(%ebp)
call g
popl %edx

addl %eax, %eax
popl %ebp
ret

g:
pushl %ebp
movl %esp, %ebp
movl 8(%ebp), %eax
incl %eax
popl %ebp
ret

.global main

main:

pushl $x
pushl $formatScanf
call scanf
popl %edx
popl %edx

pushl x
call f
popl %edx

pushl %eax
pushl $formatPrintf
call printf
popl %edx
popl %edx

movl $1, %eax
xorl %ebx, %ebx
int $0x80
