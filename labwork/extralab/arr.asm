// se citesc de la tastatura
// n -> dimensiunea array-ului
// si n elemente -> continutul array-ului
// sa se afiseze pe ecran
// suma elementelor pare este: %d\n
// array-ul are cel mult 20 de elemente

// scanf("%d", &n)
// for (ecx = 0; ecx < n; ecx ++) {
//    scanf("%d", v[ecx]);
//    if(v[ecx] % 2 == 0)
//        sum += v[ecx];
// }

.data
    n: .space 4 # long = 4 bytes
    v: .space 80 # 20 x long = 80 bytes
    
    elemCurent: .space 4
    sum: .long 0
    doi: .long 2

    formatScanf: .asciz "%d"
    formatPrintf: .asciz "Suma elementelor pare este %d\n"

.text

.global main

main:
    pushl $n
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx
debuglabel:
    movl $v, %edi # %edi retine adresa lui v
    xorl %ecx, %ecx # %ecx pe post de index

et_for:
    cmp n, %ecx
    je exit
    
    pushl %ecx

    pushl $elemCurent
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx
    
    // in acest moment, registrii %eax, %ecx, %edx sunt alterati
    popl %ecx # am restaurat %ecx

    movl elemCurent, %eax
    movl %eax, (%edi, %ecx, 4)
    
    // verific daca elementul curent este par
    xorl %edx, %edx
    divl doi
    
    cmp $0, %edx
    je este_par

cont:
    incl %ecx
    jmp et_for 
        
este_par:
    movl (%edi, %ecx, 4), %ebx
    addl %ebx, sum
    jmp cont

exit:
    pushl sum
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
