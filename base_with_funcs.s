	.file	"base_with_funcs.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"%d "
	.text
	.globl	print_array
	.type	print_array, @function
print_array:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	DWORD PTR -4[rbp], 0
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
	nop
	nop
	leave
	ret
	.size	print_array, .-print_array
	.section	.rodata
.LC1:
	.string	"%d"
	.text
	.globl	insert_A_and_count_B_size
	.type	insert_A_and_count_B_size, @function
insert_A_and_count_B_size:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	DWORD PTR -32[rbp], edx
	mov	DWORD PTR -8[rbp], 0
	mov	DWORD PTR -4[rbp], 0
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
	mov	eax, DWORD PTR -8[rbp]
	leave
	ret
	.size	insert_A_and_count_B_size, .-insert_A_and_count_B_size
	.globl	fill_B
	.type	fill_B, @function
fill_B:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	DWORD PTR -36[rbp], edx
	mov	DWORD PTR -40[rbp], ecx
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
	ret
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
	mov	edx, DWORD PTR -32[rbp]
	mov	ecx, DWORD PTR -36[rbp]
	mov	rax, QWORD PTR -24[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	insert_A_and_count_B_size
	mov	DWORD PTR -28[rbp], eax
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	ecx, DWORD PTR -32[rbp]
	mov	edx, DWORD PTR -36[rbp]
	mov	rsi, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fill_B
	mov	edx, DWORD PTR -28[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	print_array
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
