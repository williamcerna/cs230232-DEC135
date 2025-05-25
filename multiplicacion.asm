section .data
    num1 db 10      ; Primer número (8 bits)
    num2 db 5       ; Segundo número (8 bits)

section .bss
    result resb 1   ; Reservar espacio para el resultado (8 bits)

section .text
    global _start

_start:
    ; Cargar los números en los registros
    mov al, [num1]  ; AL = num1
    mov bl, [num2]  ; BL = num2

    ; Multiplicar
    mul bl           ; AX = AL * BL (el resultado se guarda en AX)

    ; Guardar el resultado en la variable 'result' (solo 8 bits)
    mov [result], al ; El resultado de la multiplicación está en AL

    ; Terminar el programa
    mov eax, 1       ; syscall número 1 (salir)
    xor ebx, ebx     ; código de salida 0
    int 0x80         ; interrupción de sistema (llama a Linux)
