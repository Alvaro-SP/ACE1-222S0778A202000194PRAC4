;! █▀▀ █ █░░ █▀▀ █▀   ▄▀█ █▄░█ █▀▄   █▀█ █▀▀ █▀█ █▀█ █▀█ ▀█▀ █▀
;! █▀░ █ █▄▄ ██▄ ▄█   █▀█ █░▀█ █▄▀   █▀▄ ██▄ █▀▀ █▄█ █▀▄ ░█░ ▄█
;! ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
; * ☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻  ARCHIVOS  ☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻
     

cleanBuffer macro buffer,numBytes,caracter;?    limpiar un array
; buffer = array de bytes
; numBytes = numero de bytes a limpiar
; caracter = caracter con el que se va a limpiar
    LOCAL repeat 
    mov si,0
    mov cx,0
    mov cx,numBytes
    repeat:
        mov buffer[si],caracter
        inc si
        loop repeat
endm
getChar macro
    mov ah, 01h
    int 21h
endm

openFile macro file,handler
;macro para abrir un fichero
;param file = nombre del archivo
;param &handler = num del archivo
    mov ah,3dh
    mov al,010b
    lea dx,file
    int 21h
    ; jc errorOpening
    mov handler, ax
endm

readFile macro handler,fileData,numBytes
;macro para leer en un fichero
;param handler = num del archivo
;param &fileData = variable donde se almacenara los bytes leidos
;param numBytes = num de bytes a leer
    mov ah,3fh
    mov bx, handler
    mov cx, numBytes
    lea dx, fileData
    int 21h
    ; jc errorReading
endm


writeFile macro handler,array,numBytes
;macro para escribir en un fichero
;param handler = num del archivo 
;param array = bytes a escribir
;param numBytes = num de bytes a escribir
    mov ah,40h
    mov bx,handler
    mov cx,numBytes
    lea dx,array
    int 21h
    ; jc errorWriting
endm

;macro para seguir escribiendo en una de terminada posicion del fichero 
seekEnd macro handler
    mov ah,42h
    mov al, 02h
    mov bx, handler
    mov cx, 0
    mov dx, 0
    int 21h
    ; jc errorAppending
endm
;macro para obtener la ruta dada por un usuario
;similar al de getTexto, la unica diferencia es el fin de cadena
getRuta macro array
LOCAL getCadena, finCadena
    mov si,0    ;xor si,si

    getCadena:
        getChar
        cmp al,0dh
        je finCadena
        mov array[si],al
        inc si
        jmp getCadena
    finCadena:
    mov al,00h
    mov array[si],al
endm



escribir MACRO handler, buff, numbytes
    PUSHA
    MOV ah, 40h
    MOV bx, handler
    MOV cx, numbytes
    lea dx, buff
    int 21h
    POPA
ENDM escribir
cerrar macro handler
    PUSHA
    mov ah,3eh
    mov bx, handler
    int 21h
    mov handler,ax
    POPA
endm
crear macro buffer, handler

    mov ah,3ch ;función para crear fichero
    mov cx,00h ;fichero normal 
    lea dx,buffer ;carga la dirección de la variable buffer a dx
    int 21h
    mov handler, ax ;sino hubo error nos devuelve el handler 

endm

; * ☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻ GENERACION DE REPORTES ☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻
GENERARHTML1_ PROC NEAR
    ; INICIODEJUEGOM
    MOV SI_SIMULADO,0
    MOV SI_SIMULADO2,0
    ; xor si, si
    ; ; cleanBuffer buffInfo, SIZEOF buffInfo, 24h
    ; ; INICIODEJUEGOM
    ; MOV SI_SIMULADO,si
    ; MOV SI_SIMULADO2,si
    ; mov si,0
    ; mov cx,0
    ; mov cx,SIZEOF buffInfo
    ; repeat:
    ;     mov buffer[si],"$"
    ;     inc si
    ;     loop repeat
    getDate
    getTime
    concatenarHTML buffInfo, HEADHTM
    concatenarHTML buffInfo, HEADHTM2
    concatenarHTML buffInfo, LBLJUGADOR1

    concatenarHTML buffInfo, txtfechayhora
    concatenarHTML buffInfo, h1Time
    concatenarHTML buffInfo, date
    concatenarHTML buffInfo, time
    concatenarHTML buffInfo, h1Time2


    
    concatenarHTML buffInfo, TXTLABELTOTALHTM

    CONVERTNUMERO NUMDISPAROTOT1
    concatenarHTML buffInfo,HANDTEMP

    concatenarHTML buffInfo, TXTLABELTEMPORALFALLIDOSHTM
    
    CONVERTNUMERO NUMDISPAROFALL1
    concatenarHTML buffInfo, HANDTEMP

    concatenarHTML buffInfo, TXTLABELTEMPORALACERTADOSHTM
    
    CONVERTNUMERO NUMDISPAROBIEN1
    concatenarHTML buffInfo, HANDTEMP

    concatenarHTML buffInfo, TXTLABELTITULOJUGADOR
    PAINTTABLEROSHOOTS1HTM

    concatenarHTML buffInfo, TXTLABELTITULOBARCOS
    PAINTTABLEROBARCOS1HTM
    
    concatenarHTML buffInfo, ENDT



    concatenarHTML buffInfo, LBLJUGADOR2
     concatenarHTML buffInfo, TXTLABELTOTALHTM

    CONVERTNUMERO NUMDISPAROTOT2
    concatenarHTML buffInfo,HANDTEMP

    concatenarHTML buffInfo, TXTLABELTEMPORALFALLIDOSHTM
    
    CONVERTNUMERO NUMDISPAROFALL2
    concatenarHTML buffInfo, HANDTEMP

    concatenarHTML buffInfo, TXTLABELTEMPORALACERTADOSHTM
    
    CONVERTNUMERO NUMDISPAROBIEN2
    concatenarHTML buffInfo, HANDTEMP

    concatenarHTML buffInfo, TXTLABELTITULOJUGADOR
    PAINTTABLEROSHOOTS2HTM

    concatenarHTML buffInfo, TXTLABELTITULOBARCOS
    PAINTTABLEROBARCOS2HTM
    concatenarHTML buffInfo, FINHTM


    crear Filenamejug1, handlerentrada
    escribir  handlerentrada, buffInfo, SIZEOF buffInfo
    cerrar handlerentrada
    RET
GENERARHTML1_ ENDP

; * ☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻ FECHA Y HORA ☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻
getTime macro
    mov ah, 2ch    ;get the current system time
    int 21h
    ;hour
    mov al, ch
    call convert
    mov time[0],ah
    mov time[1],al
    ;minutes
    mov al,cl
    call convert
    mov time[3],ah
    mov time[4],al
    ;seconds
    mov al, dh
    call convert
    mov time[6],ah
    mov time[7],al
endm

;Macro para obtener la fecha actual del sistema
getDate macro
    mov ah,2ah
    int 21h
    ;day
    mov al, dl 
    call convert
    mov date[0], ah
    mov date[1], al
    ;month
    mov al, dh
    call convert
    mov date[3], ah
    mov date[4], al
    ;year
    ;mov year, cx
endm
