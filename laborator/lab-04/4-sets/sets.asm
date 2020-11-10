%include "../io.mac"

section .text
    global main
    extern printf

main:
    ;cele doua multimi se gasesc in eax si ebx
    mov eax, 139
    mov ebx, 169
    PRINTF32 `%u\n\x0`, eax ; afiseaza prima multime
    PRINTF32 `%u\n\n\x0`, ebx ; afiseaza cea de-a doua multime

    ; TODO1: reuniunea a doua multimi
    or eax, ebx
    PRINTF32 `Reuniunea este: \x0`
    PRINTF32 `%u\n\n\x0`, eax

    ; TODO2: adaugarea unui element in multime
    PRINTF32 `Multimea inainte de adaugarea elementului 20 este: \x0`
    PRINTF32 `%u\n\x0`, eax
    xor edx, edx
    mov edx, 1
    shl edx, 20 ; adaug elementul 20
    or eax, edx
    PRINTF32 `Multimea dupa modificari este: \x0`
    PRINTF32 `%u\n\n\x0`, eax


    ; TODO3: intersectia a doua multimi
    and eax, ebx
    PRINTF32 `Intersectia este: \x0`
    PRINTF32 `%u\n\n\x0`, eax

    ; TODO4: complementul unei multimi
    mov ecx, eax
    not ecx
   	PRINTF32 `Complementul lui eax este: \x0`
    PRINTF32 `%u\n\n\x0`, ecx

    ; TODO5: eliminarea unui element
    PRINTF32 `Multimea inainte de eliminarea elementului 7 este: \x0`
    PRINTF32 `%u\n\x0`, eax
    xor edx, edx
    mov edx, 1
    shl edx, 7 ; scot elementul 7
    not edx
    and eax, edx
    PRINTF32 `Multimea dupa eliminarea elementului 7 este: \x0`
    PRINTF32 `%u\n\n\x0`, eax


    ; TODO6: diferenta de multimi EAX-EBX
    mov eax, 234
    PRINTF32 `%u\n\x0`, eax ; afiseaza prima multime
    PRINTF32 `%u\n\x0`, ebx ; afiseaza cea de-a doua multime
    mov ecx, eax
    xor ecx, ebx
    and eax, ecx
    PRINTF32 `EAX - EBX = \x0`
    PRINTF32 `%u\n\x0`, eax

    xor eax, eax
    ret
