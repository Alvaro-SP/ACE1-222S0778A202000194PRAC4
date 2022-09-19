
;TODO █░█░█ █▀▀ █░░ █▀▀ █▀█ █▀▄▀█ █▀▀   █▀▄▀█ █▄█   █▀█ █▀█ ▄▀█ █▀▀ ▀█▀ █ █▀▀ █▀▀   █░█
;TODO ▀▄▀▄▀ ██▄ █▄▄ █▄▄ █▄█ █░▀░█ ██▄   █░▀░█ ░█░   █▀▀ █▀▄ █▀█ █▄▄ ░█░ █ █▄▄ ██▄   ▀▀█
.MODEL LARGE
.386
.STACK 64
.DATA

    ;*--------------------------  MIS_DATOS -----------------------------
    tb1             DB   38,'BIENVENIDO A MI CALCULADORA !!!!!!'
    tb2             DB   38,'Universidad de San Carlos de Guatemala'
    tb3             DB   22,'Facultad de Ingenieria'
    tb4             DB   30,'Escuela de Ciencias y Sistemas'
    tb5             DB   9,'Seccion A'
    tb6             DB   27,'ALVARO EMMANUEL SOCOP PEREZ'
    tb7             DB   9,'202000194'
    pressenter      DB   24,'ENTER: Para continuar...'
    ;*--------------------------     MENU    -----------------------------
    tm1             DB   29,'------- MENU PRINCIPAL ------'
    tm2             DB   16,'1. Iniciar Juego'
    tm3             DB   15,'2. Cargar Juego'
    tm4             DB   8,'3. Salir'
    keypress          DB ?
    keypresstempY          DB ?
    keypresstempX          DB ?
    tm1c             DB   '------- MENU PRINCIPAL ------',10, 13, "$"
    tm2c             DB   '         1. Iniciar Juego',10, 13, "$"
    tm3c             DB   '         2. Cargar Juego',10, 13, "$"
    tm4c             DB   '         3. Salir',10, 13, "$"
    ;*--------------------------  COLORES -----------------------------
    BLACK               EQU  00H
    ;*-------------------------- COORDENADAS PARA EL CURSOR --------------------------
    POSX            DB  ?
    POSY            DB  ?
    saltolinea      DB " ",10, 13, "$"
    ;*--------------------------  PARAMETROS DIBUJAR MODO VIDEO-----------------------------
    X1              DW  ?
    X2              DW  ?
    Y1              DW  ?
    Y2              DW  ?
    KEY_PRESSED                     DB  ?
    ;*--------------------------  MENSAJES -----------------------------
    ingpath db "Ingrese la ruta path del archivo:", 10, 13, "$"





    ;* --------------------------  REPORTES -----------------------------
    handlerentrada dw ?
    handlerentrada2 dw ?
    handler   dw ?
    ;* --------------------------  REPORTE XML -----------------------------
    HEADXML     db "<reporte>", 10, 13, 09,"<datos>", 10, 13, 09,09,"<nombre>ALVARO EMMANUEL SOCOP PEREZ</nombre>", 10, 13, 09,09,"<carnet>202000194</carnet>", 10, 13, 09,09,"$"
        HEADXML2     db "<curso>Arquitectura de computadores y ensambladores 1</curso>", 10, 13, 09,09,"<seccion>A</seccion>", 10, 13, 09,"</datos>", 10, 13, 09,"$"
        fechaxml        db "<fecha>", 10, 13, 09,09, "$"
        diaxml          db "<dia>",  "$"
        dia      db "00"
        diacxml          db "</dia>", 10, 13, 09,09, "$"
        mesxml          db "<mes>", "$"
        mes      db "00"
        mescxml          db "</mes>", 10, 13, 09,09, "$"
        anioxml         db "<anio>2022</anio>", 10, 13, 09, "$"
        fechacxml        db "</fecha>", 10, 13, 09, "$"
        ;tiempo
        tiempoxml           db "<tiempo>", 10, 13, 09,09, "$"
        horaxml             db "<hora>",  "$"
        minutoxml           db "<minuto>",  "$"
        segundoxml          db "<segundo>",  "$"
        tiempocxml           db "</tiempo>", 10, 13, 09, "$"
        horacxml            db "</hora>", 10, 13, 09,09, "$"
        minutocxml          db "</minuto>", 10, 13, 09,09, "$"
        segundocxml         db "</segundo>", 10, 13, 09, "$"
        hour        db "00"
        min         db "00"
        sec         db "00"
        ;estadisticos
        estadisticosxml     db "<estadisticos>", 10, 13, 09,09, "$"
        mediaxml            db "<media>",  "$"
        medianaxml          db "<mediana>",  "$"
        modaxml             db "<moda>",  "$"
        fibonaccixml        db "<fibonacci>",  "$"
        lucasxml            db "<lucas>",  "$"
        estadisticoscxml     db "</estadisticos>", 10, 13, 09, "$"
        mediacxml            db "</media>", 10, 13, 09,09,  "$"
        medianacxml          db "</mediana>", 10, 13, 09,09,  "$"
        modacxml             db "</moda>", 10, 13, 09,09,  "$"
        fibonaccicxml        db "</fibonacci>", 10, 13, 09,09,  "$"
        lucascxml            db "</lucas>", 10, 13, 09,  "$"
        ;operaciones
        operacionesxml      db "<operaciones>", 10, 13, 09,09, "$"
        operacionescxml     db "</operaciones>", 10, 13, 09, "$"
        reportecxml         db "</reporte>", 10, 13, 09, "$"
        

   
    SI_SIMULADO             DW ?
    SI_SIMULADO2             DW ?
    buffInfo db 20000 dup('$')
    date      db "dd/mm/2022  "
    time      db "00:00:00"
    h1Time    db '$'
    temp DW  ?
    
    file      db 50 dup('$')
    fileData  db 64 dup('$')
;!████████████████████████████ SEGMENTO DE CODIGO ████████████████████████████
.CODE

    main PROC FAR
        MOV AX, @DATA
        MOV DS, AX
        MOV ES, AX
        misdatos
        esperaenter
        paint  0, 0, 800, 600, BLACK ;*LIMPIA TODO MODO VIDEO:V
        menu
        esperaenter
         limpiar
        poscursor 6,22
        print tm1c
        poscursor 8,22
        print tm2c
        poscursor 10,22
        print tm3c
        poscursor 12,22
        print tm4c
        poscursor 16,29
        readtext
        OPCIONDEMENU
        SALIDADEUNA:
            mov ax, 4c00h
            int 21h
            HLT ; para decirle al CPU que se estara ejecutando varias veces (detiene CPU hasta sig interrupcion)
            RET
    main    ENDP

    ;?☻ ===================== OPCIONES DEL MENU ======================= ☻
    OPCIONDEMENU_ PROC NEAR
        CMP keypress,'1'     ; si tecla es 1
        JNE CARGARJUEGOTEMP     ; sino es 1 se va a cargar
        JE INICIARJUEGO     ; SI SI ES SE VA A INICIARJUEGO

        CARGARJUEGOTEMP:
            CMP keypress,'2'  ; si tecla es 2
            JNE SALIR ; sino es 2 se va a SALIR
            JE CARGARJUEGO ; SI SI ES SE VA A CARGARJUEGO

        CARGARJUEGO:
            CARGADEJUEGOM
        INICIARJUEGO:
            INICIODEJUEGOM
        SALIR:
        RET
    OPCIONDEMENU_ ENDP
    ;? ☻ ===================== METODO MOSTRAR DATOS ======================= ☻
    misdatos_     PROC NEAR
        MOV AX,4F02H           ;SETEAMOS EL MODO VIDEO INT 10   800*600
        MOV BX,103H
        INT 10H
        ; imprimo el texto de inicio
        PAINTTEXT tb1 , 0820H , 0FF22H
        PAINTTEXT tb2 , 0F10h , 0FF0FH
        PAINTTEXT tb3 , 1210H , 0FF0FH
        PAINTTEXT tb4 , 1410H , 0FF0FH
        PAINTTEXT tb5 , 1610H , 0FF0FH
        PAINTTEXT tb6 , 1810H , 0FF0FH
        PAINTTEXT tb7 , 1A10H , 0FF0FH
        PAINTTEXT pressenter , 2125H , 0FF30H
        RET
    misdatos_     ENDP
    ;?☻ ===================== METODO MOSTRAR DATOS ======================= ☻
    menu_     PROC NEAR
        PAINTTEXT tm1 , 0820H , 0FF26H
        PAINTTEXT tm2 , 0F10h , 0FF0FH
        PAINTTEXT tm3 , 1210H , 0FF0FH
        PAINTTEXT tm4 , 1410H , 0FF0FH
        RET
    menu_     ENDP
    ;?☻ ===================== METODO IMPRIMIR ======================= ☻
    PAINTTEXT_    PROC NEAR
        MOV AX,1301H
        MOV BX,BP
        MOV CL,[BX]
        MOV CH,00H
        ADD BP,1H
        MOV BX,SI
        INT 10H
        RET
    PAINTTEXT_    ENDP
    ;?☻ ===================== PRESIONAR TECLAS ======================= ☻
    enterclick_    PROC    NEAR
        esperar:
            esperatecla
            MOV AH , keypress
            CMP AH, 1CH
        JNE esperar
        RET
    enterclick_    ENDP

    esperatecla_  PROC   NEAR
        MOV keypress, AH
        RET
    esperatecla_ ENDP

    ;?☻ ===================== DIBUJAR EN PANTALLA ======================= ☻
    paint_   PROC  NEAR
        ;PARAMETERS
        ; X1, Y1, X2, Y2, AL = COLOR
        INC X2
        INC Y2  ;TO STOP AT X2 + 1, Y2 + 1
        MOV DX, Y1
        MOV AH, 0CH   ;AH = 0C FOR INT, AL = COLOR
        DRAW_ALL_RECTANGLE_ROWS:
        MOV CX, X1
            DRAW_RECTANGE_ROW:
                INT 10H
                INC CX
                CMP CX, X2
            JNZ DRAW_RECTANGE_ROW
        INC DX
        CMP DX, Y2
        JNZ DRAW_ALL_RECTANGLE_ROWS
        RET
    paint_ ENDP

    ;?☻ ===================== CONCATENAR TEXTO ENTRADA ======================= ☻
    readtext_ PROC NEAR
        xor di , di
        Leer:
            mov ax, 00
            mov ah, 01h
            int 21h
            cmp al, 13
            jne Concatenar
            je Salir
        Concatenar:
            mov keypress[di], al
            mov keypress[di + 1], "$"
            inc di
            jmp Leer
        Salir:
            ; ! ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░ EN EL JUEGO  ░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
            QUEINGRESO:
                    CMP keypress[0], "S"
                    JNE GUARDAR
                    JE ESS
                ESS:
                    CMP keypress[1], "A"
                    JNE GUARDAR
                    JE ESA
                ESA:
                    CMP keypress[2], "L"
                    JNE GUARDAR
                    JE ESL
                ESL:
                    CMP keypress[3], "I"
                    JNE GUARDAR
                    JE ESIS
                ESIS:
                    CMP keypress[4], "R"
                    JNE GUARDAR
                    JE SALIRAHORAYA
            GUARDAR:
                    CMP keypress[0], "G"
                    JNE SHOWHTM
                    JE ESG2
                ESG2:
                    CMP keypress[1], "U"
                    JNE SHOWHTM
                    JE ESU2
                ESU2:
                    CMP keypress[2], "A"
                    JNE SHOWHTM
                    JE ESA21
                ESA21:
                    CMP keypress[3], "R"
                    JNE SHOWHTM
                    JE ESR21
                ESR21:
                    CMP keypress[4], "D"
                    JNE SHOWHTM
                    JE ESD2
                ESD2:
                    CMP keypress[5], "A"
                    JNE SHOWHTM
                    JE ESA22
                ESA22:
                    CMP keypress[6], "R"
                    JNE SHOWHTM
                    JE NOPASANADAOIGA  ;TODO: VER A DONDE VOY A GUARDAR
            SHOWHTM:
                    CMP keypress[0], "S"
                    JNE NOPASANADAOIGA
                    JE ESS3
                ESS3:
                    CMP keypress[1], "H"
                    JNE NOPASANADAOIGA
                    JE ESH3
                ESH3:
                    CMP keypress[2], "O"
                    JNE NOPASANADAOIGA
                    JE ES03
                ES03:
                    CMP keypress[3], "W"
                    JNE NOPASANADAOIGA
                    JE ESW3
                ESW3:
                    CMP keypress[4], "H"
                    JNE NOPASANADAOIGA
                    JE ESH33
                ESH33:
                    CMP keypress[5], "T"
                    JNE NOPASANADAOIGA
                    JE EST3
                EST3:
                    CMP keypress[6], "M"
                    JNE SHOWHTM
                    JE NOPASANADAOIGA  ;TODO: VER A DONDE VOY A MOSTRAR EL HTML
            SALIRAHORAYA:
                ; JMP SALIDADEUNA
        NOPASANADAOIGA:
        RET
    readtext_ ENDP
    ;?☻ ===================== POSICIONAR EL CURSOR ======================= ☻
    poscursor_ PROC NEAR
        ; FUNCION COLOCAR CURSOR

        mov ah, 02h ; FUNCION PARA COLOCAR EL CURSOR
        mov dh, POSX ; 12 FILA
        mov dl, POSY ; 12 COLUMNA
        INT 10h
        RET
    poscursor_ ENDP


    convert proc
        aam
        add ax, 3030h
        ret
    convert endp

    ; * ☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻ GENERACION DE REPORTES
    GENERARHTML1_ PROC NEAR
        MOV SI_SIMULADO,0
        MOV SI_SIMULADO2,0
        getDate
        getTime
        concatenarHTML buffInfo, HEADXML
        concatenarHTML buffInfo, HEADXML2
        concatenarHTML buffInfo, fechaxml

        concatenarHTML buffInfo, diaxml
        concatenarHTML buffInfo, dia
        concatenarHTML buffInfo, diacxml
        concatenarHTML buffInfo, mes
        concatenarHTML buffInfo, mescxml
        concatenarHTML buffInfo, anioxml
        concatenarHTML buffInfo, fechacxml

        concatenarHTML buffInfo, tiempoxml
        concatenarHTML buffInfo, horaxml
        concatenarHTML buffInfo, hour
        concatenarHTML buffInfo, horacxml
        concatenarHTML buffInfo, minutoxml
        concatenarHTML buffInfo, min
        concatenarHTML buffInfo, minutocxml
        concatenarHTML buffInfo, segundoxml
        concatenarHTML buffInfo, sec
        concatenarHTML buffInfo, segundocxml
        concatenarHTML buffInfo, tiempocxml
        
        concatenarHTML buffInfo, estadisticosxml
        concatenarHTML buffInfo, mediaxml
        concatenarHTML buffInfo, medianaxml
        concatenarHTML buffInfo, modaxml
        concatenarHTML buffInfo, fibonaccixml
        concatenarHTML buffInfo, lucasxml
        concatenarHTML buffInfo, estadisticoscxml
        concatenarHTML buffInfo, mediacxml
        concatenarHTML buffInfo, medianacxml
        concatenarHTML buffInfo, modacxml
        concatenarHTML buffInfo, fibonaccicxml
        concatenarHTML buffInfo, lucascxml
        ; concatenarHTML buffInfo, FINHTM


        crear Filenamejug1, handlerentrada
        escribir  handlerentrada, buffInfo, SIZEOF buffInfo
        cerrar handlerentrada
        RET
    GENERARHTML1_ ENDP

