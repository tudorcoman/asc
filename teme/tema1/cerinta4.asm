
.data
    v: .space 40004
    vv: .space 40004
    input: .space 11001
    nr_lin: .space 4
    nr_col: .space 4
    elements: .space 4
    op: .space 4
    i: .space 4
    j: .space 4

    chDelim: .asciz " "
    formatPrintf: .asciz "%d "
    endofline: .asciz "\n"
    addString: .asciz "add"
    mulString: .asciz "mul"
    subString: .asciz "sub"
    divString: .asciz "div"
    letString: .asciz "let"
    rotString: .asciz "rot90d"

.text

.global main

main:
    pushl $input
    call gets
    popl %ebx

    movl $v, %edi
    movl $vv, %esi

    pushl $chDelim
    pushl $input
    call strtok
    popl %ebx
    popl %ebx

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    pushl %eax
    call atoi
    movl %eax, nr_lin

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    pushl %eax
    call atoi
    movl %eax, nr_col

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    xorl %ecx, %ecx
    pushl %ecx

numbers_loop:
    pushl %eax
    pushl $letString
    call strcmp
    popl %ebx
    cmp $0, %eax
    je reading_done # iesim din numbers_loop

    call atoi

    popl %ebx
    popl %ecx
    movl %eax, (%edi, %ecx, 4)
    incl %ecx

    popl %ebx
    pushl %ecx
    pushl $chDelim
    pushl $0 
    call strtok
    popl %ebx
    popl %ebx
    jmp numbers_loop

reading_done:
    popl %ebx
    popl %ecx
    movl %ecx, elements
    // sarim peste let:
    pushl $chDelim
    pushl $0 
    call strtok
    popl %ebx
    popl %ebx

    pushl $rotString
    pushl %eax
    call strcmp
    
    cmp $0, %eax
    je et_rotate

    popl %ebx
    popl %eax
    pushl %ebx
    call atoi
et_debug:
    movl %eax, %ebx
    popl %eax
    cmp $0, %ebx
    jne et_operand

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

et_operand:
    pushl %eax
    call atoi
    popl %ebx

    movl %eax, op

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    xorl %ecx, %ecx

    pushl %eax
    pushl $addString
    call strcmp
    cmp $0, %eax
    je et_add

    popl %ebx
    pushl $subString
    call strcmp
    cmp $0, %eax
    je et_sub

    popl %ebx
    pushl $mulString
    call strcmp
    cmp $0, %eax
    je et_mul

    popl %ebx
    pushl $divString
    call strcmp
    cmp $0, %eax
    je et_div

    jmp exit


et_add:
    cmp %ecx, elements
    je afisare_norm

    movl (%edi, %ecx, 4), %eax
    addl op, %eax
    movl %eax, (%edi, %ecx, 4)
    
    incl %ecx
    jmp et_add
    
et_sub:
    cmp %ecx, elements
    je afisare_norm

    movl (%edi, %ecx, 4), %eax
    subl op, %eax
    movl %eax, (%edi, %ecx, 4)
 
    incl %ecx
    jmp et_sub

et_mul:
    cmp %ecx, elements
    je afisare_norm

    movl (%edi, %ecx, 4), %eax
    mull op
    movl %eax, (%edi, %ecx, 4)
    
    incl %ecx
    jmp et_mul

et_div:
    cmp %ecx, elements
    je afisare_norm

    xorl %edx, %edx
    movl (%edi, %ecx, 4), %eax
    movl op, %ebx
    cdq
    idiv %ebx

    movl %eax, (%edi, %ecx, 4)
    
    incl %ecx
    jmp et_div

et_rotate:
    xorl %eax, %eax
    xorl %ebx, %ebx
    xorl %ecx, %ecx
    xorl %edx, %edx
rotate_loop_mare:
    cmp nr_col, %ebx
    je afisare_rot
    movl $1, %ecx

rotate_loop_mic:
    cmp nr_lin, %ecx
    jg cont_rotate_loop_mare

    movl %ebx, %eax
    mull nr_lin
    addl %ecx, %eax
    subl $1, %eax
    movl %eax, i

    movl nr_lin, %eax
    subl %ecx, %eax
    mull nr_col
    addl %ebx, %eax
    movl %eax, j

    movl i, %eax
    movl j, %edx
    movl (%edi, %edx, 4), %edx
    movl %edx, (%esi, %eax, 4)
    
    incl %ecx
    jmp rotate_loop_mic    

    
cont_rotate_loop_mare:
    incl %ebx
    jmp rotate_loop_mare

afisare_norm:
    pushl nr_lin
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx

    pushl nr_col
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx

    xorl %ecx, %ecx
    pushl %ecx
loop_afisare_norm:
    popl %ecx
    cmp %ecx, elements
    je exit
    pushl %ecx
    pushl (%edi, %ecx, 4)
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    incl %ecx
    pushl %ecx
    jmp loop_afisare_norm

afisare_rot:
    pushl nr_col
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx

    pushl nr_lin
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx

    xorl %ecx, %ecx
    pushl %ecx
loop_afisare_rot:
    popl %ecx
    cmp %ecx, elements
    je exit
    pushl %ecx
    pushl (%esi, %ecx, 4)
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    incl %ecx
    pushl %ecx
    jmp loop_afisare_rot
    
exit:
    pushl $endofline
    call printf
    popl %ebx
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
