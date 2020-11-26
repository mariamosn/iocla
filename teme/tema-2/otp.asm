; Maria Moșneag 323CA
%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

otp_crypt:
    mov    bl, byte [esi + ecx - 1]    ; bl <- plaintext[i]
    mov    bh, byte [edi + ecx - 1]    ; bh <- key[i]
    xor    bl, bh                      ; bl <- plain[i] ^ key[i]
    mov    byte [edx + ecx - 1], bl    ; cipher[i] <- bl
    loop   otp_crypt                   ; parcurgerea array-urilor se face invers

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY