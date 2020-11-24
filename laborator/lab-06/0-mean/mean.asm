%include "../utils/printf32.asm"

%define ARRAY_SIZE 13
%define DECIMAL_PLACES 5

section .data

    num_array dw 76, 12, 65, 19, 781, 671, 431, 761, 782, 12, 91, 25, 9
    decimal_point db ".",0


section .text

extern printf
global main
main:
    xor eax, eax
    mov ecx, ARRAY_SIZE

    ; TODO1 - compute the sum of the vector numbers - store it in eax

sum:
    xor ebx, ebx
    mov bx, word [num_array + (ecx - 1) * 2]
    add eax, ebx
    loop sum

    PRINTF32 `Sum of numbers: %d\n\x0`, eax

    ; TODO2 - compute the quotient of the mean
    mov ebx, eax
    shr ebx, 16
    mov dx, bx
    xor ebx, ebx
    mov bx, ax
    xor eax, eax
    mov ax, bx
    xor ebx, ebx
    mov ebx, ARRAY_SIZE
    div bx

    PRINTF32 `Mean of numbers: %d\x0`, eax
    PRINTF32 `.\x0`

    mov ecx, DECIMAL_PLACES
compute_decimal_place:

    ; TODO3 - compute the current decimal place - store it in ax
    xor eax, eax
    mov ax, dx
    xor edx, edx
    mov edx, 10
    mul dl
    xor edx, edx
    div bx

    PRINTF32 `%d\x0`, eax
    dec ecx
    cmp ecx, 0
    jg compute_decimal_place

    PRINTF32 `\n\x0`
    xor eax, eax
    ret
