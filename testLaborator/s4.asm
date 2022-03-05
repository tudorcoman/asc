.data
    x: .long 3
    lindex: .long L0, L1, L2, L3
    n: .long 7
    v: .long 15, 3, 2, 10, 1, 20, 0
    formatPrintf: .asciz "%d\n"
.text
.global main

f:
    pushl %ebp
    pushl %edi
    movl %esp, %ebp
    
    movl $0, %eax
    movl 12(%ebp), %ecx
    cmp $4, %ecx
    jge final
    
    cmp $-1, %ecx
    jle final
    
    movl $lindex, %edi
    movl (%edi, %ecx, 4), %eax 
    
    jmp *%eax

L0:
    movl $1, %eax
    jmp final

L1:
    movl $2, %eax
    jmp final

L2:
    movl $3, %eax
    jmp final

L3:
    movl $4, %eax
    jmp final

final:
    popl %edi
    popl %ebp
    ret

main:
    movl $v, %edi
    movl $0, %ecx

for_main:
    cmp n, %ecx
    jge final_main
    movl (%edi, %ecx, 4), %eax
    pushl %ecx
    pushl %eax
    call f
    popl %ebx
    
    pushl %eax
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx
    popl %ecx

    incl %ecx
    
    jmp for_main

final_main:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
