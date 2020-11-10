%include "../io.mac"

section .data
    myString: db "Hello, World!", 0
    my2ndString: db "Goodbye, World!", 0

section .text
    global main
    extern printf

main:
    mov ecx, 6                      ; N = valoarea registrului ecx
    ; mov eax, 1
    mov eax, 2
    mov ebx, 1
    cmp eax, ebx
    ; je print                        ; TODO1: eax > ebx?
    jg print
    ret

print:
    PRINTF32 `%s\n\x0`, myString

;looplb:
;    PRINTF32 `%s\n\x0`, myString
;    loop looplb

looplb2:
    PRINTF32 `%s\n\x0`, myString
    cmp ecx, 0
    dec ecx
    jne looplb2

                                    ; TODO2.2: afisati "Hello, World!" de N ori
    PRINTF32 `%s\n\x0`, my2ndString
                                    ; TODO2.1: afisati "Goodbye, World!"

    ret
