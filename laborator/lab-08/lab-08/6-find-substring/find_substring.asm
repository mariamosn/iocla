%include "../utils/printf32.asm"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
substring: db "BABC", 0
format: db "Substring found at index: %d", 10, 0
len: dw 0

print_format: db "Substring found at index: ", 0

section .text
extern printf
extern strlen
global main
main:
    push ebp
    mov ebp, esp

    ; TODO: Print the start indices for all occurrences of the substring in source_text
    push source_text
    call strlen
    add esp, 4
    mov [len], eax
    xor eax, eax
    xor edx, edx

str:
	mov dword edx, [source_text + eax]
	cmp dword edx, [substring]
	jne next

	push eax
	push format
	call printf
	add esp, 4
	pop eax

next:
	inc eax
	cmp eax, [len]
	jl str

    leave
    ret
