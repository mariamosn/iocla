global runAssemblyCode

extern printf

section .data
    str: db "%d",10,13

section .text
runAssemblyCode:
    push ebp
    mov ebp, esp

    xor edi, edi
    xor esi, esi
    mov eax, [ebp + 8]
    mov ecx, [ebp + 12]

sum:
	add edi, [eax + esi * 4]
	add edi, [eax + (esi + 1) * 4]
	add edi, [eax + (esi + 2) * 4]
	add edi, [eax + (esi + 3) * 4]
	add edi, [eax + (esi + 4) * 4]
	add esi, 5
	cmp esi, ecx
	jl sum

    mov eax, edi
    mov esp, ebp
    pop ebp
    ret
