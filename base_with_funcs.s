# подробные комментарии к ассемблерному коды были приведены в первой ассемблероной программе
# здесь и далее прокомментированы будут лишь общие комментарии к коду, а также комментарии к новым приемам
	.file	"base_with_funcs.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"%d "
	.text
	.globl	print_array
	.type	print_array, @function


# функция print_array
print_array:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi # по смещению -24 от rbp на стеке зраним переменную vals ( значение передано через регистр rdi )
	mov	DWORD PTR -28[rbp], esi # по смещению -28 от rbp на стеке храним переменную size ( значение передано через регистр esi )
	mov	DWORD PTR -4[rbp], 0 # по смещению -4 от rbp на стеке храним переменную i (итератор цикла)
	jmp	.L2
.L3:
	mov	rax, QWORD PTR -24[rbp]
	lea	rdx, 4[rax]
	mov	QWORD PTR -24[rbp], rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L3
	nop # ничего не делаем
	nop # ничего не делаем
	leave
	ret # функция типа void, возвращаемого значения нет
	.size	print_array, .-print_array
	.section	.rodata
.LC1:
	.string	"%d"
	.text
	.globl	insert_A_and_count_B_size
	.type	insert_A_and_count_B_size, @function


# функция insert_A_and_count_B_size
insert_A_and_count_B_size:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi # по смещению -24 от rbp на стеке храним переменную vals ( значение передано через регистр rdi )
	mov	DWORD PTR -28[rbp], esi # по смещению -28 от rbp на стеке храним переменную size ( значение передано через регистр esi )
	mov	DWORD PTR -32[rbp], edx # по смещению -32 от rbp на стеке храним переменную divider ( значение передано через регистр edx )
	mov	DWORD PTR -8[rbp], 0 # по смещению -8 от rbp на стеке храним переменную answer
	mov	DWORD PTR -4[rbp], 0 # по смещению -4 от rbp на стеке храним переменную i ( итератор цикла )
	jmp	.L5
.L7:
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR -24[rbp]
	lea	rdx, 4[rax]
	mov	QWORD PTR -24[rbp], rdx
	mov	eax, DWORD PTR [rax]
	cdq
	idiv	DWORD PTR -32[rbp]
	mov	eax, edx
	test	eax, eax
	jne	.L6
	add	DWORD PTR -8[rbp], 1
.L6:
	add	DWORD PTR -4[rbp], 1
.L5:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L7
	mov	eax, DWORD PTR -8[rbp] # помещаем возвращаемое значение в регистр eax (через этот регистр передаем возвращаемое значение)
	leave
	ret # выход из функции, возвращаемое значение сохранено на регистре eax
	.size	insert_A_and_count_B_size, .-insert_A_and_count_B_size
	.globl	fill_B
	.type	fill_B, @function



fill_B:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi # по смещению -24 от rbp на стеке храним переменную A ( значение передано через регистр rdi )
	mov	QWORD PTR -32[rbp], rsi # по смещению -32 от rbp на стеке храним переменную B ( значение передано через регистр rsi )
	mov	DWORD PTR -36[rbp], edx # по смещению -36 от rbp на стеке храним переменную size_A ( значение передано через регистр edx )
	mov	DWORD PTR -40[rbp], ecx # по смещению -40 от rbp на стеке храним переменную divider ( значение передано через регистр ecx )
	mov	DWORD PTR -4[rbp], 0
	jmp	.L10
.L12:
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	cdq
	idiv	DWORD PTR -40[rbp]
	mov	eax, edx
	test	eax, eax
	jne	.L11
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, 4[rax]
	mov	QWORD PTR -32[rbp], rdx
	mov	rdx, QWORD PTR -24[rbp]
	mov	edx, DWORD PTR [rdx]
	mov	DWORD PTR [rax], edx
.L11:
	add	QWORD PTR -24[rbp], 4
	add	DWORD PTR -4[rbp], 1
.L10:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -36[rbp]
	jl	.L12
	nop
	nop
	pop	rbp
	ret # функция типа void, ничего не возвращает
	.size	fill_B, .-fill_B
	.section	.rodata
.LC2:
	.string	"%d %d"
	.text
	.globl	main
	.type	main, @function

main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rdx, -32[rbp]
	lea	rax, -36[rbp]
	mov	rsi, rax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	edx, DWORD PTR -32[rbp] # передаем divider
	mov	ecx, DWORD PTR -36[rbp]
	mov	rax, QWORD PTR -24[rbp]
	mov	esi, ecx # передаем n (size)
	mov	rdi, rax # передаем array (vals)
	call	insert_A_and_count_B_size  # вызов функции insert_A_and_count_B_size
	mov	DWORD PTR -28[rbp], eax
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	ecx, DWORD PTR -32[rbp] # передаем divider
	mov	edx, DWORD PTR -36[rbp] # передаем n (size_A)
	mov	rsi, QWORD PTR -16[rbp] # передаем result_array (B)
	mov	rax, QWORD PTR -24[rbp] 
	mov	rdi, rax # передаем array (A)
	call	fill_B                     # вызов функции fill_B
	mov	edx, DWORD PTR -28[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	esi, edx # передаем result_array_len (size)
	mov	rdi, rax # передаем result_array (vals)
	call	print_array                # вызов функции print_array
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L15
	call	__stack_chk_fail@PLT
.L15:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
