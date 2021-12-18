.data
n: .space 4
v: .space 100
formatScanf: .asciz "%d"
formatPrintf: .asciz "Exista %d numere perfecte\n"

.text
#bool perfect(long x) {
#	long s = 0;
#	for(long i = 1; i <= x/2; i++)
#		if (x % i == 0) s += i;
#	if(x == s)  return 1;
#	else return 0;
#}

perfect:
pushl %ebp
movl %esp, %ebp
pushl %ebx
pushl $0	#spatiu alocat pentru var locala s

movl $2, %ebx
movl 8(%ebp), %eax
xorl %edx, %edx
divl %ebx

#ebx = x / 2

movl %eax, %ebx
movl $1, %ecx

for_perfect:
cmp %ebx, %ecx
jg final_for_perfect

movl 8(%ebp), %eax
xorl %edx, %edx
divl %ecx

cmp $0, %edx
jne salt_perfect

movl -8(%ebp), %eax
addl %ecx, %eax
movl %eax, -8(%ebp)

salt_perfect:
incl %ecx
jmp for_perfect

final_for_perfect:
popl %eax
movl 8(%ebp), %ebx
cmp %eax, %ebx
je numar_perfect
xorl %eax, %eax
jmp final_perfect

numar_perfect:
movl $1, %eax

final_perfect:
popl %ebx
popl %ebp
ret


.global main
main:
#for(long i = 0; i < n; i++) citire; nr+=perfect(v[i]);

xorl %ebx, %ebx #nr = 0

pushl $n
pushl $formatScanf
call scanf
popl %edx
popl %edx

xorl %ecx, %ecx
movl $v, %edi

for:
cmp n, %ecx
jge final

pushl %ecx
pushl %edi
pushl $formatScanf
call scanf
popl %edx
popl %edx
#popl %ecx

#pushl %ecx
pushl 0(%edi)
call perfect
popl %edx
popl %ecx

addl %eax, %ebx

incl %ecx
addl $4, %edi

jmp for

final:

pushl %ebx
pushl $formatPrintf
call printf
popl %edx
popl %edx

movl $1, %eax
xorl %ebx, %ebx
int $0x80
