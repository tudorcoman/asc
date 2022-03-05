
.data
    cnt: .long 0
    n: .long 0
    formatScanf: .asciz "%d"
    formatPrintf: .asciz "%d\n"

.text

f:
    pushl %ebp
    pushl %ebx
    movl %esp, %ebp
    movl 12(%ebp), %eax

    cmp $1, %eax
    je final_f

    movl cnt, %ecx
    incl %ecx
    movl %ecx, cnt

    pushl %eax
    xorl %edx, %edx
    movl $2, %ebx
    divl %ebx

    cmp $1, %edx
    je f_impar
 
f_par:
    popl %ebx
    pushl %eax
    call f
    popl %ebx
    jmp final_f

f_impar:
    popl %eax
    movl %eax, %ebx
    addl %eax, %eax
    addl %ebx, %eax
    incl %eax

    pushl %eax
    call f
    popl %ebx
 
final_f:
    popl %ebx
    popl %ebp
    ret

.global main

main:
    pushl $n
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    pushl n
    call f
    popl %ebx

    pushl cnt
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx    

final:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
