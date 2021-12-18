.data
    str: .space 1024
    v: .space 1200

    chDelim: .asciz " "
    formatPrintf: .asciz "%d\n"
    addString: .asciz "add"
    mulString: .asciz "mul"
    subString: .asciz "sub"
    divString: .asciz "div"
    letString: .asciz "let"

.text

.global main

main:
    pushl $str
    call gets
    popl %ebx
    
    movl $v, %edi
    xorl %ecx, %ecx

    pushl $chDelim
    pushl $str
    call strtok
    popl %ebx
    popl %ebx
    
    pushl %eax
    call atoi 
    cmp $0, %eax
    je et_add_var

    popl %ebx 
    pushl %eax
    jmp et_for

et_add_var:
    popl %ebx
    xorl %eax, %eax
    movl (%ebx, %eax, 1), %eax
    and $255, %eax
    movb $1, %ah
    pushl %eax
    jmp et_for
    
et_for:
    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    cmp $0, %eax
    je exit

    pushl %eax
    call atoi
    popl %ebx
   
    cmp $0, %eax
    je operatie

    pushl %eax
    jmp et_for

operatie:
    pushl %ebx
    pushl $addString
    call strcmp
    popl %ebx
         
    cmp $0, %eax
    je et_add
    
    pushl $subString
    call strcmp
    popl %ebx

    cmp $0, %eax
    je et_sub

    pushl $mulString
    call strcmp
    popl %ebx

    cmp $0, %eax
    je et_mul

    pushl $divString
    call strcmp
    popl %ebx

    cmp $0, %eax
    je et_div

    pushl $letString
    call strcmp
    popl %ebx

    cmp $0, %eax
    je et_let
    jmp et_add_var

et_add:
    popl %eax
    popl %eax
    popl %ebx
    
    movl $3, %edx
    cmp $1, %ah
    je substitute_eax_var
    
    cmp $1, %bh
    je substitute_ebx_var

cont_et_add: 
    add %ebx, %eax
    pushl %eax
    jmp et_for

substitute_eax_var:
    movb $0, %ah
    movl (%edi, %eax, 4), %eax
    
    cmp $1, %bh
    je substitute_ebx_var
    
    cmp $3, %edx
    je cont_et_add

    cmp $2, %edx
    je cont_et_sub

    cmp $1, %edx
    je cont_et_mul

    cmp $0, %edx
    je cont_et_div

substitute_ebx_var:
    movb $0, %bh
    movl (%edi, %ebx, 4), %ebx
    
    cmp $3, %edx
    je cont_et_add

    cmp $2, %edx
    je cont_et_sub

    cmp $1, %edx
    je cont_et_mul

    cmp $0, %edx
    je cont_et_div

et_sub:
    popl %eax
    popl %eax
    popl %ebx

    movl $2, %edx
    cmp $1, %ah
    je substitute_eax_var
    
    cmp $1, %bh
    je substitute_ebx_var

cont_et_sub:
    sub %eax, %ebx
    pushl %ebx
    jmp et_for

et_mul:
    popl %eax
    popl %eax
    popl %ebx

    movl $1, %edx
    cmp $1, %ah
    je substitute_eax_var

    cmp $1, %bh
    je substitute_ebx_var

cont_et_mul:
    mul %ebx 
    pushl %eax
    jmp et_for

et_div:
    popl %eax
    xorl %edx, %edx
    popl %ebx
    popl %eax

    cmp $1, %ah
    je substitute_eax_var

    cmp $1, %bh
    je substitute_ebx_var

cont_et_div:
    div %ebx
    pushl %eax
    jmp et_for

et_let:
    popl %eax
    popl %eax
    popl %ebx
    //movl $variableValues, %edi

    and $255, %ebx
    movl %eax, (%edi, %ebx, 4)
    jmp et_for
       
exit:
    pushl $formatPrintf
    call printf
    popl %ebx
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
