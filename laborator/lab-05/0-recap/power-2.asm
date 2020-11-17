%include "../utils/printf32.asm"

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 1      ; stores the current power

    ; TODO - print the powers of 2 that generate number stored in EAX
lbl:
	test ebx, eax
	je not
	PRINTF32 `%u\n\x0`, ebx
	sub eax, ebx

not:
	shl ebx, 1
	cmp eax, 0
	jne lbl
	
    leave
    ret
