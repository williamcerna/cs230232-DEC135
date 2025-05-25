section .data
    num1 dw 100        ; Primer número (16-bit)
    num2 dw 25         ; Segundo número (16-bit)
    num3 dw 5          ; Tercer número (16-bit)

section .bss
    result resb 5      ; Reservamos 5 bytes para el resultado (suficiente para números pequeños)

section .text
    global _start      ; Define el punto de entrada del programa

_start:
    ; Cargar el primer número en AX
    mov ax, [num1]     ; AX = num1 (100)

    ; Restar el segundo número (num2) de AX
    sub ax, [num2]     ; AX = AX - num2 (100 - 25)

    ; Restar el tercer número (num3) de AX
    sub ax, [num3]     ; AX = AX - num3 (75 - 5)

    ; Ahora AX contiene el resultado final de la resta: 70

    ; Convertir el valor en AX a una cadena ASCII
    mov bx, 10         ; Usamos 10 como base para dividir
    mov si, result     ; SI apunta al inicio del buffer para el resultado
    add si, 4          ; Empujamos el puntero al final del buffer (espacio para números de 4 dígitos)

    ; Limpiar el buffer
    mov byte [si], 0   ; Establecemos el final de la cadena

convert_loop:
    dec si             ; Mover el puntero hacia atrás
    xor dx, dx         ; Limpiar DX antes de la división
    div bx             ; Dividimos AX entre 10 (resultado en AX, residuo en DL)
    add dl, '0'        ; Convertimos el residuo a su carácter ASCII
    mov [si], dl       ; Guardamos el carácter en la cadena

    test ax, ax        ; Comprobamos si el cociente es 0
    jnz convert_loop   ; Si no es 0, seguimos dividiendo

    ; Ahora tenemos el número en ASCII en la variable result

    ; Imprimir el resultado (usamos la llamada al sistema para imprimir)
    mov edx, 4         ; La longitud de la cadena (max. 4 dígitos)
    mov ecx, si        ; La dirección de la cadena result
    mov ebx, 1         ; El descriptor de archivo (1 = salida estándar)
    mov eax, 4         ; Llamada al sistema para escribir
    int 0x80           ; Interrupción para hacer la llamada

    ; Finalizar el programa correctamente
    mov eax, 1         ; Llamada al sistema para salir (exit)
    xor ebx, ebx       ; Código de salida 0
    int 0x80           ; Interrupción para hacer la llamada


