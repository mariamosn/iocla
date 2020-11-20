%include "io.mac"

section .data
cnt: dd 0
plainlen: dd 0

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher
    xor eax, eax
    mov [plainlen], ecx
    mov [cnt], dword 0

vigenere_crypt:
    push    edx
    mov     edx, [plainlen]
    sub     edx, ecx
    mov     al, [esi + edx]     ; al <- plaintext[i]

    cmp     al, 'A'
    jb      done
    cmp     al, 'Z'
    jbe     uppercase_letter
    cmp     al, 'a'
    jb      done
    cmp     al, 'z'
    ja      done

    ; lowercase letter
    ; [cnt] <- pozitia la care am ajuns in key
    cmp     ebx, [cnt]
    ja      ok1
    mov     [cnt], dword 0
    jmp     ok1

done:
    pop     edx
    push    ebx
    mov     ebx, [plainlen]
    sub     ebx, ecx
    mov     byte [edx + ebx], al
    pop     ebx
    loop    vigenere_crypt
    jmp     end

ok1:
    mov     edx, [cnt]
    add     al, byte [edi + edx]
    inc     edx
    mov     [cnt], edx
    sub     eax, 'A'
    cmp     eax, 'z'
    jbe     done
    sub     eax, 'z'
    dec     eax
    add     eax, 'a'
    jmp     done

uppercase_letter:
    cmp     ebx, [cnt]
    ja      ok2
    mov     [cnt], dword 0

ok2:
    mov     edx, [cnt]
    add     al, byte [edi + edx]
    inc     edx
    mov     [cnt], edx
    sub     eax, 'A'
    cmp     eax, 'Z'
    jbe     done
    sub     eax, 'Z'
    dec     eax
    add     eax, 'A'
    jmp     done

end:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY