; Maria Moșneag 323CA
%include "io.mac"

section .data
haylen: dd 0
needlelen: dd 0

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr

    mov     [haylen], ecx
    mov     [needlelen], edx
    xor     eax, eax

search:
    mov     edx, [haylen]
    sub     edx, ecx
    mov     al, byte [esi + edx] ; al <- haystack[i]
    ; verific daca am gasit un caracter identic cu primul din subsirul cautat
    cmp     al, byte [ebx]
    jne     next
    push    ecx
    mov     ecx, [needlelen]
    push    esi
    add     esi, edx

    ; verific daca am gasit subsirul cautat
check:
    mov     al, byte [esi + ecx - 1]
    cmp     al, byte [ebx + ecx - 1]
    jne     end_check
    loop    check
    jmp     found

    ; subsirul a fost gasit
found:
    pop     esi
    pop     ecx
    mov     [edi], edx
    jmp     end_search

    ; verificarea a esuat - nu am gasit subsirul cautat
end_check:
    pop     esi
    pop     ecx

next:
    loop    search

    mov     edx, [haylen]
    inc     edx
    mov     [edi], edx

end_search:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
