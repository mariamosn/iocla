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
    ; the number will be formed in edx
    xor 	edx, edx

    mov 	ebx, [ebp + 8]

    ; determining the string's length
    pusha
    push 	ebx
    call 	strlen
    mov 	[len], eax
    add 	esp, 4
    popa

    mov 	ecx, [len]

get_num:
    ; determining the current position in the string
    push 	ecx
    mov 	eax, [len]
    sub 	eax, ecx
    mov 	ecx, eax

    ; getting the character from the current position
    xor 	eax, eax
    mov 	al, byte [ebx + ecx]

    ; checking the sign of the number (positive or negative)
    cmp 	ecx, 0
    jne 	continue
    cmp 	al, '-'
    jne 	continue
    mov 	[sign], dword 1
    jmp 	next

continue:
    ; converting the character into the corresponding digit
    sub 	al, '0'

    ; adding the digit on the units position of the number
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

    ; checking if the number should be negative
    mov 	ecx, [sign]
    cmp 	ecx, 0
    je 		done

    ; changes for negative numbers
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

    ; getting the info that needs to be stored in root
    mov 	edx, [ebp + 8]
    push 	delim
    push 	edx
    call 	strtok
    add 	esp, 8
    mov 	ebx, eax
    cmp 	ebx, 0
    je 		end

    ; allocation of memory for the root node
    push 	12
    call 	malloc
    add 	esp, 4
    test 	eax, eax
    jz 		end
    mov 	ecx, eax
    push 	ecx

    ; introducing the info into data
    push 	ebx
    call 	strdup
    add 	esp, 4
    pop 	ecx
    mov 	[ecx], eax

    ; setting left and right child to NULL
    mov 	[ecx + 4], dword 0
    mov 	[ecx + 8], dword 0

    ; storing the address of the root node
    mov 	[root], ecx
    push 	ecx

constr:
    ; getting the info that needs to be stored in the new node
    push 	delim
    push 	0
    call 	strtok
    add 	esp, 8
    mov 	ebx, eax
    cmp 	ebx, 0
    je 		end

    ; allocation of memory for the new node
    push 	12
    call 	malloc
    add 	esp, 4
    test 	eax, eax
    jz 		end
    mov 	ecx, eax
    push 	ecx

    ; introducing the info into data
    push 	ebx
    call 	strdup
    add 	esp, 4
    pop 	ecx
    mov 	[ecx], eax

    ; setting left and right child to NULL
    mov 	[ecx + 4], dword 0
    mov 	[ecx + 8], dword 0

    ; getting the parent
    pop 	edx
    ; checking which child position is empty
    cmp 	[edx + 4], dword 0
    je 		left_free

    ; the current node is the right son
    mov 	[edx + 8], ecx
    jmp 	check

    ; the current node is the left son
left_free:
    mov 	[edx + 4], ecx
    push 	edx

    ; checking the type of data stored in the current node (operator or number)
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
