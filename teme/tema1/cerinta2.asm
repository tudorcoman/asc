.data
    str: .space 1024
    chDelim: .asciz " "
    formatPrintf: .asciz "%d\n"
    addString: .asciz "add"
    mulString: .asciz "mul"
    subString: .asciz "sub"
    divString: .asciz "div"

.text

.global main

main:
    pushl $str
    call gets
    popl %ebx

    pushl $chDelim
    pushl $str
    call strtok
    popl %ebx
    popl %ebx
    
    pushl %eax
    call atoi 
    popl %ebx 
    pushl %eax

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

    jmp et_for

et_add:
    popl %eax
    popl %eax
    popl %ebx 
    add %ebx, %eax
    pushl %eax
    jmp et_for

et_sub:
    popl %eax
    popl %eax
    popl %ebx
    sub %eax, %ebx
    pushl %ebx
    jmp et_for

et_mul:
    popl %eax
    popl %eax
    popl %ebx
    mul %ebx 
    pushl %eax
    jmp et_for

et_div:
    popl %eax
    xorl %edx, %edx
    popl %ebx
    popl %eax
    div %ebx
    pushl %eax
    jmp et_for

exit:
    pushl $formatPrintf
    call printf
    popl %ebx
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
