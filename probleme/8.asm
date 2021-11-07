.data
.text
    palindrom: .asciz "Este palindrom!\n"
    nepalindrom: .asciz "Nu este palindrom!\n"
    s: .long 12321
.globl _start

_start:
    mov s, %eax
    mov s, %ecx

// while %ecx != 0
etloop:
    cmp $0, %ecx
    je lexit

    mov %ecx, %eax

    // construim in %ebx noul numar (invers):
    mov %ebx, %eax
    mov $10, %edx
    mul %edx
    mov %eax, %ebx

    // ultima cifra a lui %ecx (se gaseste in %edx):
    mov %ecx, %eax
    xor %edx, %edx
    mov $10, %ecx
    div %ecx
    add %edx, %ebx

    // punem noul numar in %ecx
    mov %eax, %ecx
    jmp etloop

// afisare ca este palindrom
jpalindrom:
    mov $4, %eax
    mov $1, %ebx
    mov $palindrom, %ecx
    mov $16, %edx
    int $0x80
    jmp exit

// afisare ca nu este palindrom
jnepalindrom:
    mov $4, %eax
    mov $1, %ebx
    mov $nepalindrom, %ecx
    mov $19, %edx
    int $0x80
    jmp exit

// iesire loop
lexit:
    cmp s, %ebx
    je jpalindrom
    jne jnepalindrom

// iesire program
exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
