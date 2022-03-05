.data
    pos: .space 128
    ap: .space 128
    v: .space 512
    N: .space 4
    M: .space 4
    aux: .space 4
    elemCurent: .space 4
    tripleN: .space 4
    formatScanf: .asciz "%d"
    formatPrintf: .asciz "%d "
    newLine: .asciz "\n"
    noSolution: .asciz "-1\n"

.text

afisare:
    pushl %ebp
    pushl %edi
    movl %esp, %ebp
    xorl %ecx, %ecx
    movl $v, %edi
for_afisare:
    cmp tripleN, %ecx
    je for_done

    pushl %ecx
    pushl (%edi, %ecx, 4)
    pushl $formatPrintf
    call printf
    popl %edx
    popl %edx
    popl %ecx

    incl %ecx
    jmp for_afisare
for_done:
    popl %edi
    popl %ebp
    pushl $newLine
    call printf
    popl %ebx
    ret

eval: # (a, b, c)
    pushl %ebp
    movl %esp, %ebp

    xorl %eax, %eax
    movl 8(%ebp), %edx

    cmp $3, %edx
    jge final_eval

    movl 16(%ebp), %edx
    movl 12(%ebp), %ecx
    subl %edx, %ecx
    subl M, %ecx

    movl $1, %eax
    cmp $-1, %edx
    je final_eval

    cmp $0, %ecx
    jg final_eval

    xorl %eax, %eax
final_eval:
    popl %ebp
    ret

pregatire: # (k, i)
    pushl %ebp
    movl %esp, %ebp

    pushl %esi
    pushl %edi

    movl 8(%ebp), %eax
    movl 12(%ebp), %ecx
    movl $v, %edi

    movl $ap, %esi
    movl (%esi, %ecx, 4), %edx
    incl %edx
    movl %edx, (%esi, %ecx, 4)

    movl $pos, %esi
    movl (%esi, %ecx, 4), %edx
    movl %edx, aux
    movl %eax, (%esi, %ecx, 4)

    movl %ecx, (%edi, %eax, 4)

    popl %edi
    popl %esi
    popl %ebp
    ret

rewind: # (k, i)
    pushl %ebp
    movl %esp, %ebp

    pushl %esi
    pushl %edi

    movl 8(%ebp), %eax
    movl 12(%ebp), %ecx
    movl $v, %edi

    movl $ap, %esi
    movl (%esi, %ecx, 4), %edx
    subl $1, %edx
    movl %edx, (%esi, %ecx, 4)

    movl $pos, %esi
    movl aux, %edx
    movl %edx, (%esi, %ecx, 4)

    movl $0, (%edi, %eax, 4)

    popl %edi
    popl %esi
    popl %ebp
    ret

back:
    # functia de backtracking
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %eax

    cmp tripleN, %eax
    je finalPozitiv

    pushl %edi
    pushl %esi
    movl $v, %edi
    movl (%edi, %eax, 4), %edx

    cmp $0, %edx
    jne moveQuick

    movl $1, %ecx

et_for:
    cmp N, %ecx
    jg sfarsit_for

    pushl %ecx

    movl $pos, %esi
    pushl (%esi, %ecx, 4)

    pushl %eax

    movl $ap, %esi
    pushl (%esi, %ecx, 4)

    call eval
    movl %eax, %edx

    popl %eax
    popl %eax

    popl %ecx
    popl %ecx

    cmp $1, %edx
    jne continua_for

    pushl %ecx
    pushl %eax
    call pregatire
    popl %eax
    popl %ecx

    pushl %ecx
    incl %eax
    pushl %eax
    call back
    movl %eax, %edx
    popl %eax
    subl $1, %eax
    popl %ecx

    cmp $1, %edx
    je finalPozitivGolire

    pushl %ecx
    pushl %eax
    call rewind
    popl %eax
    popl %ecx

continua_for:
    incl %ecx
    jmp et_for

sfarsit_for:
    popl %esi
    popl %edi
    popl %ebp
    xorl %eax, %eax
    ret

moveQuick:
    movl $pos, %esi
    movl (%edi, %eax, 4), %ecx
    
    pushl %ebx
    movl %eax, %ebx
    subl M, %ebx

    pushl %eax
    movl (%esi, %ecx, 4), %eax
    cmp $0, %eax
    jl moveQuickContinuare

    cmp %ebx, (%esi, %ecx, 4)
    jge finalProst

moveQuickContinuare:
    popl %eax
    popl %ebx
    movl %eax, (%esi, %ecx, 4)
    incl %eax
    pushl %eax
    call back
    popl %edx
    # subl $1, %edx

    popl %esi
    popl %edi
    popl %ebp
    ret

finalPozitivGolire:
    popl %esi
    popl %edi
finalPozitiv:
    movl $1, %eax
    popl %ebp
    ret
finalProst:
    popl %eax
    popl %ebx
    xorl %eax, %eax
    popl %esi
    popl %edi
    popl %ebp
    ret

.global main

main:
    pushl $N
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    pushl $M
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    xorl %ecx, %ecx
    movl N, %eax
    movl N, %ebx
    addl %eax, %eax
    addl %ebx, %eax
    movl %eax, tripleN

    movl $v, %edi
    movl $ap, %esi

for_citire:
    cmp tripleN, %ecx
    je sfarsit_for_citire

    pushl %ecx

    pushl $elemCurent
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    popl %ecx

    movl elemCurent, %eax
    movl %eax, (%edi, %ecx, 4)

    incl (%esi, %eax, 4)
    incl %ecx
    jmp for_citire

sfarsit_for_citire:
    movl $pos, %esi
    movl $1, %ecx

for_init:
    cmp N, %ecx
    jg sfarsit_for_init

    movl $-1, (%esi, %ecx, 4)
    incl %ecx
    jmp for_init

sfarsit_for_init:
    pushl $0
    call back
    popl %ebx
    cmp $0, %eax
    je no_sol

    call afisare

exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

no_sol:
    pushl $noSolution
    call printf
    popl %ebx
    jmp exit
