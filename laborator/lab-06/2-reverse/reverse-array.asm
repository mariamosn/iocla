%include "../utils/printf32.asm"

%define ARRAY_LEN 7

section .data

input dd 122, 184, 199, 242, 263, 845, 911
output times ARRAY_LEN dd 0

section .text

extern printf
global main
main:

    ; TODO push the elements of the array on the stack
    push ARRAY_LEN
    xor ecx, ecx
    pop ecx

array:
    push dword [input + (ecx - 1) * 4]
    loop array

    ; TODO retrieve the elements (pop) from the stack into the output array
    xor ecx, ecx
    push ARRAY_LEN
    pop ecx

reverse:
    pop dword [output + (ecx - 1) * 4]
    loop reverse

    PRINTF32 `Reversed array: \n\x0`
    xor ecx, ecx
print_array:
    mov edx, [output + 4 * ecx]
    PRINTF32 `%d\n\x0`, edx
    inc ecx
    cmp ecx, ARRAY_LEN
    jb print_array

    xor eax, eax
    ret
