section .data
    num1 dd 1000      ; Primer número (dividendo)
    num2 dd 25        ; Segundo número (divisor)

section .bss
    cociente resd 1   ; Reservar espacio para el cociente (32 bits)
    residuo resd 1    ; Reservar espacio para el residuo (32 bits)

section .text
    global _start

_start:
    ; Cargar los números en los registros
    mov eax, [num1]   ; Cargar el dividendo en EAX
    mov edx, 0        ; Limpiar EDX, ya que se usará para la extensión (necesario)
    mov ecx, [num2]   ; Cargar el divisor en ECX

    ; Realizar la división
    div ecx           ; EAX = EAX / ECX (cociente) -> en EAX, residuo -> en EDX

    ; Guardar el cociente y el residuo en las variables
    mov [cociente], eax   ; Guardar el cociente en 'cociente'
    mov [residuo], edx    ; Guardar el residuo en 'residuo'

    ; Terminar el programa
    mov eax, 1            ; syscall número 1 (salir)
    xor ebx, ebx          ; código de salida 0
    int 0x80              ; interrupción de sistema (llama a Linux)
