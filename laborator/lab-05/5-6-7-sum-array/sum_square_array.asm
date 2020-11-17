%include "../utils/printf32.asm"

%define ARRAY_SIZE    10

section .data
    dword_array dd 1392, 12544, 7992, 6992, 7202, 27187, 28789, 17897, 12988, 17992
    print_format db "Array sum is ", 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor ebx, ebx            ; Use ebx to store the sum.
    xor edx, edx            ; Store current value in dl; zero entire edx.

; work in progress!!!
add_dword_array_element:
    xor eax, eax
    mov eax, dword [dword_array + (ecx - 1) * 4]
    mul eax
    add ebx, eax
    loop add_dword_array_element

    PRINTF32 `%s\x0`, print_format
    PRINTF32 `%u\n\x0`, ebx


    leave
    ret