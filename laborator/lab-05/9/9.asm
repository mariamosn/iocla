%include "../utils/printf32.asm"

%define ARRAY_SIZE    10

section .data
    ;byte_array db 8, 19, 12, 3, 6, 200, 128, 19, 78, 102
    ;word_array dw 1893, 9773, 892, 891, 3921, 8929, 7299, 720, 2590, 28891
    dword_array dd 1, 2, -3, -4, -5, 100, 100002, 56, 0, -1
    print_format1 db "Numarul de numere negative este: ", 0
    print_format2 db "Numarul de numere pozitive este: ", 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor eax, eax            ; Use eax to store the number of negatives.
    xor ebx, ebx			; number of positives

check:
    mov edx, dword [dword_array + (ecx - 1) * 4]
    cmp edx, 0
    jl neg
    inc ebx
    jmp done

neg:
	inc eax

done:
    loop check ; Decrement ecx, if not zero, check another element.

    PRINTF32 `%s\x0`, print_format1
    PRINTF32 `%u\n\x0`, eax
    PRINTF32 `%s\x0`, print_format2
    PRINTF32 `%u\n\x0`, ebx


    leave
    ret