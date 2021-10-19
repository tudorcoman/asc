.data

.text

.globl _start

_start:
    mov $63, %eax
    mov $46, %ebx
    
    # %eax <- (%eax & ~%ebx) | (%ebx & ~%eax)

    mov %eax, %edx
    
    # %eax <- (%eax & ~%ebx)
    not %ebx
    and %ebx, %eax
    not %ebx

    # %ebx <- %ebx & ~%edx = %ebx & ~eax
    not %edx
    and %edx, %ebx

    or %ebx, %eax
   
    int $0x80
    jmp exit

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
