%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher
    ; in cazul in care key > numarul de litere din alfabet, modific key astfel incat sa nu fie necesar sa se efectueze mai multe rotiri circulare
    xor     eax, eax
    mov     eax, edi
    ; ebx <- numarul de litere din alfabet
    xor     ebx, ebx
    mov     ebx, 'z'
    sub     ebx, 'a'
    inc     ebx
    ; key va fi restul impartirii valorii initiale la numarul de litere din alfabet
    div     bl
    shr     eax, 8
    xor     edi, edi
    mov     edi, eax
    xor     ebx, ebx

caesar_crypt:
    mov     bl, [esi + ecx - 1]     ; bl <- plaintext[i]
    cmp     bl, 'A'
    jb      done
    cmp     bl, 'Z'
    jbe     uppercase_letter
    cmp     bl, 'a'
    jb      done
    cmp     bl, 'z'
    ja      done

    ; lowercase letter
    add     ebx, edi
    cmp     ebx, 'z'
    jbe     done
    sub     ebx, 'z'
    dec     ebx
    add     ebx, 'a'
    jmp     done

uppercase_letter:
    add     ebx, edi
    cmp     ebx, 'Z'
    jbe     done
    sub     ebx, 'Z'
    dec     ebx
    add     ebx, 'A'
    jmp     done

done:
    mov     byte [edx + ecx - 1], bl
    loop    caesar_crypt


    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY