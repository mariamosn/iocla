; Maria Mosneag 323CA

section .data
    delim:	db		" ", 0

section .bss
    root:	resd	1
    len: 	resd 	1
    sign: 	resd 	1

section .text

extern 	check_atoi
extern 	print_tree_inorder
extern 	print_tree_preorder
extern 	evaluate_tree
extern 	strlen
extern 	malloc
extern 	strdup
extern 	strtok

global 	create_tree
global 	iocla_atoi

iocla_atoi:
    push 	ebp
    mov 	ebp, esp
    push 	ebx
    mov 	[sign], dword 0
    ; in edx se va forma numarul
    xor 	edx, edx

    mov 	ebx, [ebp + 8]

    ; determinarea lungimii sirului de caractere
    pusha
    push 	ebx
    call 	strlen
    mov 	[len], eax
    add 	esp, 4
    popa

    mov 	ecx, [len]

get_num:
    ; determinarea pozitiei curente din string
    push 	ecx
    mov 	eax, [len]
    sub 	eax, ecx
    mov 	ecx, eax

    ; obtinerea caracterului corespunzator pozitiei curente
    xor 	eax, eax
    mov 	al, byte [ebx + ecx]

    cmp 	ecx, 0
    jne 	continue
    cmp 	al, '-'
    jne 	continue
    mov 	[sign], dword 1
    jmp 	next

continue:
    ; transformarea caracterului in cifra corespunzatoare
    sub 	al, '0'

    ; adaugarea cifrei pe pozitia unitatilor a numarului
    push 	eax

    xor 	eax, eax
    mov 	eax, edx
    xor 	ecx, ecx
    mov 	ecx, 10
    mul 	ecx
    mov 	edx, eax

    pop 	eax
    add 	edx, eax

next:
    pop 	ecx
    loop 	get_num

    ; verificarea tipului de numar primit (negativ sau pozitiv)
    mov 	ecx, [sign]
    cmp 	ecx, 0
    je 		done

    ; numar negativ
    xor 	eax, eax
    mov 	eax, edx
    xor 	edx, edx
    mov 	edx, -1
    imul 	edx
    mov 	edx, eax

done:
    mov 	eax, edx

    pop 	ebx
    leave
    ret


create_tree:
    enter 	0, 0
    push 	ebx

    ; obtinerea informatiei din root
    mov 	edx, [ebp + 8]
    push 	delim
    push 	edx
    call 	strtok
    add 	esp, 8
    mov 	ebx, eax
    cmp 	ebx, 0
    je 		end

    ; alocarea memoriei pentru root
    push 	12
    call 	malloc
    add 	esp, 4
    test 	eax, eax
    jz 		end
    mov 	ecx, eax
    push 	ecx

    ; copierea informatiei in data
    push 	ebx
    call 	strdup
    add 	esp, 4
    pop 	ecx
    mov 	[ecx], eax

    ; initializarea left si right cu NULL
    mov 	[ecx + 4], dword 0
    mov 	[ecx + 8], dword 0

    ; memorarea adresei nodului root
    mov 	[root], ecx
    push 	ecx

constr:
    ; obtinerea informatiei din noul nod
    push 	delim
    push 	0
    call 	strtok
    add 	esp, 8
    mov 	ebx, eax
    cmp 	ebx, 0
    je 		end

    ; alocarea memoriei pentru noul nod
    push 	12
    call 	malloc
    add 	esp, 4
    test 	eax, eax
    jz 		end
    mov 	ecx, eax
    push 	ecx

    ; copierea informatiei in data
    push 	ebx
    call 	strdup
    add 	esp, 4
    pop 	ecx
    mov 	[ecx], eax

    ; initializarea left si right cu NULL
    mov 	[ecx + 4], dword 0
    mov 	[ecx + 8], dword 0

    ; parintele
    pop 	edx
    ; verificarea fiilor nuli ai parintelui
    cmp 	[edx + 4], dword 0
    je 		left_free

    ; nodul curent este fiu drept
    mov 	[edx + 8], ecx
    jmp 	check

    ; nodul curent este fiu stang
left_free:
    mov 	[edx + 4], ecx
    push 	edx

     ; verificarea tipului de nod curent (operatie sau numar)
check:
    mov 	dl, byte [ebx]
    cmp 	dl, '+'
    je 		op
    cmp 	dl, '*'
    je 		op
    cmp 	dl, '/'
    je 		op
    cmp 	dl, '-'
    jne 	constr
    mov 	dl, byte [ebx + 1]
    cmp 	dl, ' '
    je 		op
    cmp 	dl, byte 0
    je 		op
    jmp 	constr

op:
    push 	ecx
    jmp 	constr

end:
    pop 	ebx
    mov 	eax, [root]

    leave
    ret
