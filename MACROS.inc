
;!                ░█▀▄▀█ ─█▀▀█ ░█▀▀█ ░█▀▀█ ░█▀▀▀█ ░█▀▀▀█
;!                ░█░█░█ ░█▄▄█ ░█─── ░█▄▄▀ ░█──░█ ─▀▀▀▄▄
;!                ░█──░█ ░█─░█ ░█▄▄█ ░█─░█ ░█▄▄▄█ ░█▄▄▄█
;! ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
            ;! ▀▀▀▀▀▀▀▀▀▀  MENU  ▀▀▀▀▀▀▀▀▀▀▀▀▀▀
OPCIONDEMENU MACRO
    PUSHA
    CALL OPCIONDEMENU_
    POPA
ENDM OPCIONDEMENU
PAINTTEXT MACRO MYMESSAGE , LOCATION,COLOR                            ;? ▬▬▬▬▬ IMPRIMIR
    PUSHA
    MOV DX,LOCATION
    MOV BP, OFFSET MYMESSAGE
    MOV SI, COLOR
    CALL  PAINTTEXT_
    POPA
ENDM PAINTTEXT
misdatos MACRO                                                     ;? ▬▬▬▬▬ DATOS
    PUSHA
    CALL misdatos_
    POPA
ENDM misdatos
;*========================= VIDEO ===================================
esperatecla MACRO
    PUSHA
    CALL esperatecla_
    POPA
ENDM  esperatecla

paint	MACRO	CORNER1X, CORNER1Y, CORNER2X, CORNER2Y, COLOR ;? ▬▬▬▬▬ MENU DIBUJAR EN PANTALLA 
    PUSHA
    PUSH AX
    MOV AX, CORNER1X
    MOV X1, AX
    MOV AX, CORNER1Y
    MOV Y1, AX
    MOV AX, CORNER2X
    MOV X2, AX
    MOV AX, CORNER2Y
    MOV Y2, AX
    POP AX
    MOV AL, COLOR
    CALL paint_
    POPA
ENDM	paint
esperaenter MACRO                                                  ;? ▬▬▬▬▬ ENTER
    PUSHA
    mov ax, 00
    mov ah, 01h
    int 21h
    POPA
ENDM esperaenter

enterclick MACRO                                                  ;? ▬▬▬ ENTER
    PUSHA
    CALL enterclick_
    POPA
ENDM enterclick
;*========================= MENU PRINCIPAL ===================================
menu MACRO                                                     ;? ▬▬▬▬▬ MENU
    PUSHA
    CALL menu_
    POPA
ENDM menu

GENERARHTML1 MACRO                                                     ;? ▬▬▬▬▬ MENU
    PUSHA
    CALL GENERARHTML1_
    POPA
ENDM GENERARHTML1
;* ========================= CONSOLA ===================================
limpiar MACRO                                                     ;? ▬▬▬▬▬ LIMPIAR
    mov ah, 00h
    mov al, 03h
    int 10h
ENDM limpiar
readtext MACRO                                            ;? ▬▬▬▬▬ LEER DE CONSOLA
    PUSHA
    CALL readtext_
    POPA
ENDM readtext
print macro texto
    mov ah, 09
    mov dx, offset texto
    int 21h
ENDM print
println macro texto
    mov ah, 09
    mov dx, offset texto
    int 21h
    print saltolinea
ENDM println
; POSICIONAR CURSOR
poscursor MACRO POSXTEMP, POSYTEMP
    ; PUSHA
    MOV AL, POSXTEMP
    MOV POSX, AL
    MOV AL, POSYTEMP
    MOV POSY, AL
    CALL poscursor_
    ; POPA
ENDM poscursor

;! ▀▀▀▀▀▀▀▀▀▀  REPORTES  ▀▀▀▀▀▀▀▀▀▀▀▀▀▀
concatenarHTML macro destino, fuente
    LOCAL LeerCaracter,FinCadena
    PUSHA
    MOV si, SI_SIMULADO
    xor di, di
    LeerCaracter:
        mov al, fuente[di]
        cmp al, 36
            je FinCadena
        mov destino[si], al
        inc si
        
        inc di
        jmp LeerCaracter
    FinCadena:
        MOV SI_SIMULADO, si
    POPA
endm concatenarHTML

;* =======================ARRAYS=======================
RESETNUMSTEMPS MACRO
    MOV num1_fill, 0H       ;!RESETEO FLAGS DE NUMERO DERECHO
    MOV num1_int, 0H
    MOV num1_int_abs, 0H
    MOV num1_dot, 0H
    MOV num1_dot_, 0H
    MOV num1_sign, 1H
    MOV num1_pow, 1H
    MOV num1_dot_detect, 0xFF

    MOV num2_fill, 0H       ;!RESETEO FLAGS DE NUMERO IZQUIERDO
    MOV num2_int, 0H
    MOV num2_int_abs, 0H
    MOV num2_dot, 0H
    MOV num2_dot_, 0H
    MOV num2_sign, 1H
    MOV num2_pow, 1H
    MOV num2_dot_detect, 0xFF  ;! NO fue necesario pero igual lo agrego
    
    MOV res_int, 0H;! Reset  FLAGS DE result
    MOV res_int1, 0H
    MOV res_dot, 0H
    MOV res_pow, 1H
    
    ; Reset operator
    MOV op, 0H   
ENDM

quitarespacios MACRO destino, auxiliar
    LOCAL inicio,concat,SALIR,NOHAYESPACIOBLANCO
    mov si, 0
    mov di, 0
    inicio:
        cmp auxiliar[si], "$"
        JNE concat
        JE SALIR
    concat:
        cmp auxiliar[si],27 ;! osea si hay espacios en blanco no agregar
        JNE NOHAYESPACIOBLANCO
        JE inicio
    NOHAYESPACIOBLANCO:
        MOV AL, auxiliar[si]
        MOV destino[di], AL
        inc di
    SALIR:
ENDM



