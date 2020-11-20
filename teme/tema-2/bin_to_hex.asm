%include "io.mac"

section .data
hex_cnt: dd 0
hex_len: dd 0

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex
    ; determinarea numarului de caractere din output
    mov eax, ecx
    mov bl, 4
    div bl
    xor ebx, ebx
    mov bl, al
    cmp ah, 0
    je no_reminder
    inc ebx

no_reminder:
    mov [hex_cnt], ebx
    mov [hex_len], ebx

convert:
    xor ebx, ebx
    xor eax, eax
    jmp compute

next:
    loop convert
    jmp fin

compute:
    ; bitul 0
    mov al, byte [esi + ecx - 1]
    sub al, '0'
    add ebx, eax
    cmp ecx, 1
    je end

    ; bitul 1
    dec ecx
    mov al, byte [esi + ecx - 1]
    sub al, '0'
    shl eax, 1
    add ebx, eax
    cmp ecx, 1
    je end

    ; bitul 2
    dec ecx
    mov al, byte [esi + ecx - 1]
    sub al, '0'
    shl eax, 2
    add ebx, eax
    cmp ecx, 1
    je end

    ; bitul 3
    dec ecx
    mov al, byte [esi + ecx - 1]
    sub al, '0'
    shl eax, 3
    add ebx, eax

end:
    cmp ebx, 10
    jb digit
    sub ebx, 10
    add ebx, 'A'
    jmp format_done

digit:
    add ebx, '0'

format_done:
    mov eax, [hex_cnt]
    mov byte [edx + eax - 1], bl
    dec eax
    mov [hex_cnt], eax
    jmp next

fin:
    mov eax, [hex_len]
    mov byte [edx + eax], 10
    ;mov byte [edx + eax + 1], '\0'

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY