%include "../utils/printf32.asm"

%define NUM 5
   
section .text

extern printf
global main
main:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands (use direct addressing of memory. Hint: esp)
    mov ecx, NUM


push_nums:
    ;push ecx
    sub esp, 4
    mov [esp], ecx
    loop push_nums

    ;push 0
    sub esp, 4
    mov [esp], dword 0

    ;push "mere"
    sub esp, 4
    mov [esp], dword "mere"

    ;push "are "
    sub esp, 4
    mov [esp], dword "are "

    ;push "Ana "
    sub esp, 4
    mov [esp], dword "Ana "

    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    ; use PRINTF32 macro - see format above

    xor eax, eax
    mov eax, esp

print:
    PRINTF32 `%p: %hhd\n\x0`, eax, [eax] ; zerourile provin de la modul de reprezentare in memorie a int-urilor (little endian, pe 4 octeti)
    inc eax
    cmp eax, ebp
    jb print

    ; TODO 3: print the string
    xor eax, eax
    mov eax, esp ; primul caracter al sirului se afla in varful stivei
    
print_str:
    PRINTF32 `%c\x0`, [eax]
    inc eax
    cmp dword [eax], 0 ; ne oprim in momentul in care intalnim 0 (caruia i-am dat push inaintea sirului)
    jne print_str
    PRINTF32 `\n\x0`

    ; TODO 4: print the array on the stack, element by element.
    add eax, 4
    
print_array:
    PRINTF32 `%d \x0`, [eax]
    add eax, 4
    cmp eax, ebp ; ne oprim cand ajungem la baza stivei
    jne print_array
    PRINTF32 `\n\x0`

    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
