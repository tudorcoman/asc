.data
    sirb16: .space 2001
    sirb2: .space 8001
    formatScanf: .asciz "%s"
    formatPrintf: .asciz "%s\n"
    formatCharPrintf: .asciz "%c "
    formatNumberPrintf: .asciz "%d "
    minusString: .asciz "-"
    letString: .asciz "let "
    addString: .asciz "add "
    subString: .asciz "sub "
    mulString: .asciz "mul "
    divString: .asciz "div "
    endOfLine: .asciz "\n"
    indexSb2: .space 4

.text

.global main

main:
    //scanf("%s", sirb8)
    pushl $sirb16
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    movl $sirb16, %edi
    movl $sirb2, %esi
    xorl %ecx, %ecx

et_for:
    movb (%edi, %ecx, 1), %al
    cmp $0, %al
    je parseb2_init

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
    cmp $56, %al
    je cif8
    cmp $57, %al
    je cif9
    cmp $65, %al
    je cifA
    cmp $66, %al
    je cifB
    cmp $67, %al
    je cifC
    cmp $68, %al
    je cifD
    cmp $69, %al
    je cifE
    cmp $70, %al
    je cifF
cont:
    incl %ecx
    jmp et_for

parseb2_init:
    xorl %ecx, %ecx

parseb2:
    movb (%esi, %ecx, 1), %al
    cmp $49, %al
    jne exit # primul bit este intotdeauna egal cu 1

    incl %ecx
    movb (%esi, %ecx, 1), %al
    cmp $49, %al
    je et_operatie

    incl %ecx # avem un numar sau o variabila
    movb (%esi, %ecx, 1), %al
    movl %eax, %edx
    cmp $49, %al
    je et_variabila

    jmp et_numar


et_numar:
    incl %ecx
    movb (%esi, %ecx, 1), %al
    pushl %eax # pastram bitul de semn
    
    incl %ecx

    xorl %ebx, %ebx
    xorl %eax, %eax
    jmp et_binarytodecimal

et_variabila:
    addl $2, %ecx   # am ajuns la ultimii 8 biti care contin codul ascii al variabilei, 
    xorl %ebx, %ebx # pe care il voi decoda in %ebx
    
    xorl %eax, %eax
    jmp et_binarytodecimal

et_binarytodecimal:
   cmp $8, %eax
   je et_jumpsplit

   pushl %eax
   movb (%esi, %ecx, 1), %al
   cmp $49, %al 
   je presentbit
   
   popl %eax
   incl %eax
   incl %ecx
   jmp et_binarytodecimal

presentbit:
   popl %eax
   cmp $0, %eax
   je bit_0
   cmp $1, %eax
   je bit_1
   cmp $2, %eax
   je bit_2
   cmp $3, %eax
   je bit_3
   cmp $4, %eax
   je bit_4
   cmp $5, %eax
   je bit_5
   cmp $6, %eax
   je bit_6
   cmp $7, %eax
   je bit_7

et_jumpsplit:
    cmp $49, %dl
    je cont_variabila
    jmp cont_numar

cont_variabila:
    # avem valoarea caracterului in registrul %ebx
    pushl %ecx
    pushl %ebx
    pushl $formatCharPrintf
    call printf
et_debug:
    popl %ebx
    popl %ebx
    popl %ecx
    jmp parseb2

cont_numar: 
    # avem valoarea numarului in registrul %ebx
    popl %eax
    cmp $49, %al
    je makeEbxNegative

cont_cont_numar:
    pushl %ecx
    pushl %ebx
    pushl $formatNumberPrintf
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    jmp parseb2

makeEbxNegative:
    cmp $0, %ebx
    je et_negativeZero
    movl %ebx, %edx
    subl %edx, %ebx
    subl %edx, %ebx
    jmp cont_cont_numar

et_negativeZero:
    pushl %ecx
    pushl %ebx
    pushl $minusString
    call printf
    popl %eax
    popl %ebx
    popl %ecx
    jmp cont_cont_numar

bit_0:
    addl $128, %ebx
    incl %eax
    incl %ecx
    jmp et_binarytodecimal

bit_1:
    addl $64, %ebx
    incl %eax
    incl %ecx
    jmp et_binarytodecimal

bit_2:
    addl $32, %ebx
    incl %eax
    incl %ecx
    jmp et_binarytodecimal

bit_3:
    addl $16, %ebx
    incl %eax
    incl %ecx
    jmp et_binarytodecimal

bit_4:
    addl $8, %ebx
    incl %eax
    incl %ecx
    jmp et_binarytodecimal

bit_5:
    addl $4, %ebx
    incl %eax
    incl %ecx
    jmp et_binarytodecimal

bit_6:
    addl $2, %ebx
    incl %eax
    incl %ecx
    jmp et_binarytodecimal

bit_7:
    addl $1, %ebx
    incl %eax
    incl %ecx
    jmp et_binarytodecimal
     
et_operatie:
    add $8, %ecx # sar peste bitii neimportanti
    
    movb (%esi, %ecx, 1), %al
    cmp $49, %al
    je printDiv

    incl %ecx
    movb (%esi, %ecx, 1), %al
    cmp $49, %al
    je subOrMul

    incl %ecx
    movb (%esi, %ecx, 1), %al
    cmp $49, %al
    je printAdd

    jmp printLet

subOrMul:
    incl %ecx
    movb (%esi, %ecx, 1), %al
    cmp $49, %al
    je printMul
    jmp printSub

printLet:
    incl %ecx
    pushl %ecx
    pushl $letString
    call printf
    popl %ebx
    popl %ecx
    jmp parseb2

printAdd:
    incl %ecx
    pushl %ecx
    pushl $addString
    call printf
    popl %ebx
    popl %ecx
    jmp parseb2

printSub:
    incl %ecx
    pushl %ecx
    pushl $subString
    call printf
    popl %ebx
    popl %ecx
    jmp parseb2

printMul:
    incl %ecx
    pushl %ecx
    pushl $mulString
    call printf
    popl %ebx
    popl %ecx
    jmp parseb2

printDiv:
    addl $3, %ecx
    pushl %ecx
    pushl $divString
    call printf 
    popl %ebx
    popl %ecx
    jmp parseb2    

cif0:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cif1:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cif2:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cif3:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cif4:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cif5:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cif6:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cif7:
    pushl %ecx
    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cif8:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cif9:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cifA:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cifB:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cifC:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cifD:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cifE:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

cifF:
    pushl %ecx
    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    addl $4, indexSb2
    popl %ecx
    jmp cont

exit:
    pushl $endOfLine
    call printf
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
