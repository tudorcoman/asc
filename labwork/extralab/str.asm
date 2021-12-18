// se citeste un sir de caractere format din cifre in b8
// sa se construieasca si sa se afiseze pe ecran
// sirul corespunzator, translatat in b2
// "37201" = "011111010000001"

.data
    sirb8: .space 21
    sirb2: .space 61
    formatScanf: .asciz "%s"
    formatPrintf: .asciz "%s\n"
    
    indexSb2: .space 4

.text

.global main

main:
    //scanf("%s", sirb8)
    pushl $sirb8
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    movl $sirb8, %edi
    movl $sirb2, %esi
    xorl %ecx, %ecx

et_for:
    movb (%edi, %ecx, 1), %al
    cmp $0, %al
    je exit

    cmp $48, %al
    je cif0
    cmp $49, %al
    je cif1
    cmp $50, %al
    je cif2
    cmp $51, %al
    je cif3
    cmp $52, %al
    je cif4
    cmp $53, %al
    je cif5
    cmp $54, %al
    je cif6
    cmp $55, %al
    je cif7
cont:
    incl %ecx
    jmp et_for

cif0:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $3, indexSb2
    popl %ecx    
    jmp cont

cif1:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $3, indexSb2
    popl %ecx
    jmp cont

cif2:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $3, indexSb2
    popl %ecx
    jmp cont

cif3:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $3, indexSb2
    popl %ecx
    jmp cont

cif4:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $3, indexSb2
    popl %ecx
    jmp cont

cif5:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $3, indexSb2
    popl %ecx
    jmp cont

cif6:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $3, indexSb2
    popl %ecx
    jmp cont

cif7:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $3, indexSb2
    popl %ecx
    jmp cont

exit:
    pushl $sirb2
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
