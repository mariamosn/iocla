
section .data
    delim db " ", 0
    len: dw 1
    nr: db "1234", 0
    sign: db 0
    format: db "%d\n", 0

section .bss
    root resd 1

section .text

extern check_atoi
extern print_tree_inorder
extern print_tree_preorder
extern evaluate_tree
extern strlen
extern malloc
extern strdup
extern strtok

global create_tree
global iocla_atoi

iocla_atoi:
	push ebp
    mov ebp, esp
    push ebx
    xor eax, eax
    mov [sign], byte 0

    mov ebx, [ebp + 8]

    pusha
    push ebx
    call strlen
    mov [len], eax ; lungimea sirului
    add esp, 4
    popa

    mov ecx, [len]
    xor edx, edx

get_num:
    ; determinarea pozitiei curente din string
    push ecx
    mov eax, [len]
    sub eax, ecx
    mov ecx, eax

    ; caracterul de la pozitia curenta
    xor eax, eax
    mov al, byte [ebx + ecx]

    cmp ecx, 0
    jne continua
    cmp al, '-'
    jne continua
    mov [sign], byte 1
    jmp next

continua:
    ; transformarea caracterului in cifra corespunzatoare
    sub al, '0'

    push eax

    xor eax, eax
    mov eax, edx
    xor ecx, ecx
    mov ecx, 10
    mul ecx
    mov edx, eax

    pop eax
    add edx, eax

next:
    pop ecx
    loop get_num

    ; verific daca numarul din string era negativ
    xor ecx, ecx
    mov cl, [sign]
    cmp ecx, 0
    je done

    ; numar negativ
    xor eax, eax
    mov eax, edx
    xor edx, edx
    mov edx, -1
    imul edx
    mov edx, eax

done:
    mov eax, edx

    pop ebx
    leave
    ret


create_tree:
    enter 0, 0
    push ebx
    push edi

    ; obtinerea informatiei din root
    mov edx, [ebp + 8]
    push delim
    push edx
    call strtok
    mov ebx, eax
    add esp, 8
    cmp ebx, 0
    je end

    ; aloc memorie pentru root
    push 12
    ;mov edi, 12
    call malloc
    add esp, 4
    test eax, eax
    jz end
    mov ecx, eax
    push ecx

    ; data
    push ebx
    call strdup
    add esp, 4
    pop ecx
    mov [ecx], eax

    ; left si right
    mov [ecx + 4], dword 0
    mov [ecx + 8], dword 0

    mov [root], ecx
    push ecx

constr:
	; obtinerea informatiei din noul nod
    push delim
    push 0
    call strtok
    mov ebx, eax
    add esp, 8
    cmp ebx, 0
    je end

    ; alocarea memoriei pentru noul nod
    push 12
    ;mov edi, 12
    call malloc
    add esp, 4
    test eax, eax
    jz end
    mov ecx, eax
    push ecx

    ; copierea informatiei in data
    push ebx
    call strdup
    add esp, 4
    pop ecx
    mov [ecx], eax

    ; left si right
    mov [ecx + 4], dword 0
    mov [ecx + 8], dword 0

    ; parintele
    pop edx
    cmp [edx + 4], dword 0
    je left_free

    ; nodul curent este fiu drept
    mov [edx + 8], ecx
    jmp check

left_free:
	mov [edx + 4], ecx
	push edx

check:
	mov dl, byte [ebx]
	cmp dl, '+'
	je op
	cmp dl, '*'
	je op
	cmp dl, '/'
	je op
	cmp dl, '-'
	jne constr
	mov dl, byte [ebx + 1]
	cmp dl, ' '
	je op
	cmp dl, byte 0
	je op
	jmp constr

op:
	push ecx
	jmp constr

end:
	pop edi
	pop ebx
	mov eax, [root]

    leave
    ret
