.MODEL SMALL
.STACK 100H
.DATA       


;DECLARED STRINGS

INTRO DB '*********************WELCOME TO SHOPPING MANAGEMENT SYSTEM**********************$'

; LOGIN PAGE
    L1 DB 13, 10,       "**************************************************$" 
    L2 DB 13, 10,       "**                  LOG IN TO START             **$" 
    L3 DB 13, 10,       "**************************************************$" 

    ASKUSERNAME DB      "ENTER USERNAME: $" 
    ASKPASSWORD DB      "ENTER PASSWORD: $" 

    LOGINSUCCESSMSG DB  "LOGIN SUCCESSFUL! $" 
    LOGINERRORMSG DB    "LOGIN FAILED! (PRESS ANY KEY TO CONTINUE) $"

    USERNAME DB "abdullah" ; SET USERNAME
    PASSWORD DB "sardar" ; SET PASSWORD

    INUSERNAME DB 10 DUP("$") ; SIZE OF INPUT USERNAME (10 CHARACTERS MAX)
    INPASSWORD DB 10 DUP("$") ; SIZE OF INPUT PASSWORD (10 CHARACTERS MAX) 
    
INTRO2 DB '*********************SHOPPING MANAGEMENT SYSTEM**********************$'

ENTER DB 10,13,'PLEASE ENTER THE KEYS WHAT YOU WANT TO BUY: $'

INFO DB 10,13,'KEYS      ITEMS                PRICE$'

S_MALE DB 10,13,' 1    SHIRT(MALE)             500 TAKA $'
                     
P_MALE DB 10,13,' 2    PANT (MALE)             1000 TAKA $'

M_SHOES DB 10,13,' 3    SHOES (MALE)            1500 TAKA $'

S_FEMALE DB 10,13,' 4    SHIRT(FEMALE)           1000 TAKA $'

P_FEMALE DB 10,13,' 5    PANT (FEMALE)           2000 TAKA $'

F_SHOES DB 10,13,' 6    SHOES (FEMALE)          3000 TAKA $'


E_QUANTITY DB 10,13,'ENTER QUANTITY: $'

AGAIN DB 10,13,'DO YOU WANT TO BUY MORE? (1.YES || 2.NO): $'

ER_MSG DB 10,13,'ERROR INPUT$'     

FT DB 10,13,'TOTAL AMOUNT IS TAKA: $'    

R DB 0DH,0AH,'PRESENT AMOUNT IS TAKA: $' 

E_DISCOUNT DB 10,13,'ENTER DISCOUNT(IF NOT AVAILABLE ENTER 0 ): $' 

ERASK DB 10,13,'START FROM THE BEGINNING $'

EN_DIS DB 10,13,'AGAIN ENTER DISCOUNT: $'

A DW ?                           ;DECALRED VARIABLES
B DW ?
S DW 0,'$'
 
.CODE   
    MAIN PROC
  
     MOV AX, @DATA                ; ACCESS .DATA
     MOV DS, AX     
   
                                 
     LEA DX, INTRO                ; PRINT INTRO STRING 
     MOV AH, 9
     INT 21H
     
LOGINSTART:
    ; Display login page header
    LEA DX, L1
    MOV AH, 9
    INT 21H

    LEA DX, L2
    MOV AH, 9
    INT 21H

    LEA DX, L3
    MOV AH, 9
    INT 21H

    ; Print a new line
    CALL NL
    CALL NL 
    
    ; Prompt for username
    LEA DX, ASKUSERNAME
    MOV AH, 9
    INT 21H

    ; Get username input from user
    MOV SI, OFFSET INUSERNAME 
    
INPUTUSERNAME:
    MOV AH, 1 ; Read character
    INT 21H
    MOV [SI], AL ; Store character in buffer
    INC SI
    CMP AL, 13 ; Check for Enter key (carriage return)
    JNE INPUTUSERNAME
    

    ; PROMPT FOR PASSWORD
    CALL NL
    
    MOV AH, 9
    LEA DX, ASKPASSWORD
    INT 21H

    ; GET PASSWORD INPUT FROM USER
    MOV SI, OFFSET INPASSWORD
     
INPUTPASSWORD:
    MOV AH, 1 
    INT 21H
    MOV [SI], AL 
    INC SI
    CMP AL, 13
    JNE INPUTPASSWORD

    ; VALIDATE USERNAME
    MOV SI, OFFSET USERNAME
    MOV DI, OFFSET INUSERNAME
    MOV CX, 5 ; LOOP ITERATION COUNT  
    
LOGINVALIDATIONUSERNAME:
    MOV BL, [SI] 
    MOV DL, [DI] 
    CMP BL, DL 
    JNE INVALIDLOGIN ; IF MISMATCH, JUMP TO ERROR HANDLING
    INC SI 
    INC DI 
    LOOP LOGINVALIDATIONUSERNAME 

    ; VALIDATE PASSWORD
    MOV SI, OFFSET PASSWORD 
    MOV DI, OFFSET INPASSWORD 
    MOV CX, 5 ; LOOP ITERATION COUNT 
    
LOGINVALIDATIONPASSWORD:
    MOV BL, [SI] 
    MOV DL, [DI] 
    CMP BL, DL 
    JNE INVALIDLOGIN ; IF MISMATCH, JUMP TO ERROR HANDLING
    INC SI 
    INC DI 
    LOOP LOGINVALIDATIONPASSWORD 

    ; DISPLAY SUCCESS MESSAGE
    CALL NL
    
    MOV AH, 9
    LEA DX, LOGINSUCCESSMSG
    INT 21H

    ; GO TO MAIN MENU
    JMP BEGINTOP

INVALIDLOGIN:
    ; DISPLAY ERROR MESSAGE
    CALL NL
    
    MOV AH, 9
    LEA DX, LOGINERRORMSG
    INT 21H

    ; WAIT FOR KEY PRESS
    CALL NL
    
    MOV AH, 1
    INT 21H

   ; RESTART LOGIN PROCESS
    JMP LOGINSTART

 ERROR121:  
                  
     LEA DX,ER_MSG               ;PRINT ERROR MESSAGE 
     MOV AH,9
     INT 21H 
                                 ;IF USER GIVES AN ERROR THEN USER WILL BE ASKED TO INPUT AGAIN
     LEA DX,ERASK
     MOV AH,9
     INT 21H
                   

 BEGINTOP:   
     
     CALL NL
     CALL NL
     
     LEA DX, INTRO2                ; PRINT INTRO STRING 
     MOV AH, 9
     INT 21H
          
     CALL NL                    ; PRINT A NEW LINE
                    
      
     LEA DX, INFO                 ; PRINT INFO STRING
     MOV AH, 9 
     INT 21H                     
     
     CALL NL                    ; PRINT A NEW LINE
        

     LEA DX, S_MALE              ; PRINT SHIRT MALE STRING
     MOV AH, 9
     INT 21H 
     
     CALL NL                    ; PRINT A NEW LINE
     
                   
     LEA DX, P_MALE            ; PRINT PANT MALE STRING
     MOV AH, 9
     INT 21H    
     
     CALL NL                    ; PRINT A NEW LINE
     
                   
     LEA DX, M_SHOES              ; PRINT MALE SHOES STRING
     MOV AH, 9
     INT 21H   
     
     CALL NL                    ; PRINT A NEW LINE
     
                   
     LEA DX, S_FEMALE            ; PRINT CASUAL SHIRT FEMALE STRING
     MOV AH, 9
     INT 21H  
     
     CALL NL                    ; PRINT A NEW LINE
     
                   
     LEA DX, P_FEMALE          ; PRINT PANT FEMALE STRING
     MOV AH, 9
     INT 21H 
     
     CALL NL                    ; PRINT A NEW LINE
     
     LEA DX, F_SHOES              ; PRINT FEMALE SHOES STRING
     MOV AH, 9
     INT 21H    
     
     CALL NL                    ; PRINT A NEW LINE
     
            
     LEA DX, ENTER                ; PRINT ENTER STRING
     MOV AH, 9       
     INT 21H    
        
     
     MOV AH, 1                    ; TAKE AN INPUT & SAVED TO AL
     INT 21H 
     
     
     
     CMP AL,49                   ;IF AL=1 GO TO CS_MALEB LEBEL
     JE S_MALEB     
     
     CMP AL,50                   ;IF AL=2 GO TO PANT_MALEB LEBEL
     JE P_MALEB
     
     CMP AL,51                   ;IF AL=3 GO TO M_SHOESB LEBEL
     JE M_SHOESB
     
     CMP AL,52                   ;IF AL=4 GO TO CS_FEMALEB LEBEL
     JE S_FEMALEB
     
     CMP AL,53                   ;IF AL=5 GO TO PANT_FEMALEB LEBEL
     JE P_FEMALEB
     
     CMP AL,54                   ;IF AL=6 GO TO F_SHOESB LEBEL
     JE F_SHOESB
     
   
     
     JMP ERROR121 
     
     S_MALEB:
                                 
MOV A,500                        ;PRICE OF CASUAL SHIRT MALE IS MOVED TO A WHERE PRICE IS 150

JMP QUANTITY
 

P_MALEB:

MOV A,1000                        ;PRICE OF PANT MALE IS MOVED TO A WHERE PRICE IS 210

JMP QUANTITY 

M_SHOESB: 

MOV A,1500                        ;PRICE OF MALE SHOES IS MOVED TO A WHERE PRICE IS 350

JMP QUANTITY 

S_FEMALEB: 

MOV A,1000                        ;PRICE OF CASUAL SHIRT FEMALE IS MOVED TO A WHERE PRICE IS 140

JMP QUANTITY 

P_FEMALEB:

MOV A,2000                        ;PRICE OF PANT FEMALE IS MOVED TO A WHERE PRICE IS 220

JMP QUANTITY 

F_SHOESB:   

MOV A,3000                        ;PRICE OF FEMALE SHOES IS MOVED TO A WHERE PRICE IS 310

JMP QUANTITY 


;AFTER MOVING PRICE PROGRAM WILL JUMP TO QUANTITY LEBEL    

QUANTITY:  

 

    LEA DX,E_QUANTITY            ;PRINT ENTER QUANTITY STRING
    MOV AH,9
    INT 21H 
    
    JMP MULTI           ;PROGRAM WILL GO TO MULTI LEBEL WHERE THE PRICE WILL BE MILTIPLIED WITH THE AMOUNT


ASK: 

  
    
    LEA DX,AGAIN                 ;PRINT AGAIN IF USER WANTS TO BUY MORE
    MOV AH,9
    INT 21H 
    
    MOV AH,1                     ;TAKES THE INPUT OF YES OR NO
    INT 21H
    
    CMP AL,49                    ;IF YES, THEN AGAIN GO TO SHOPLIST MENU AND BUY AGAIN
    JE BEGINTOP
    
    CMP AL,50
    JE OUTPUT2                   ;IF NO, PROGRAM WILL GIVE THE TOTAL OUTPUT
    
    LEA DX,ER_MSG
    MOV AH,9                     ;IF ANY WRONG INPUT, PRINT ERROR MESSAGE AND AGAIN ASK TO BUY AGAIN
    INT 21H
    
    JMP ASK                      
    


ERROR:
    
    LEA DX,ER_MSG                ;PRINT ERROR MESSAGE 
    MOV AH,9
    INT 21H
    
    JMP QUANTITY                 ;JUMP TO QUANTITY LEBEL
    
ER_DISCOUNT:   

    LEA DX,ER_MSG                ;DURING DISCOUNT INPUT IF WRONG INPUT IS PRESSES ERROR MESSSAGE WILL SHOW
    MOV AH,9
    INT 21H
    
    LEA DX,NL                    ;PRINT NEW LINE
    MOV AH,9
    INT 21H
    
    LEA DX,EN_DIS                ;PRINT AGAIN INPUT DISCOUNT VALUE 
    MOV AH,9
    INT 21H
    
    JMP INPUT_SUB                ;DIRECLTY JUMP TO INPUT OF DISCOUNT 
    
    
MULTI:         

     

INDEC3 PROC                        ;INDEC3 IS FOR TAKING INPUT FOR MULTIPLY WITH THE GIVEN AMOUNT
    
    PUSH BX                        ;TAKE VALUES INTO STACK 
    PUSH CX
    PUSH DX

    
    
    XOR BX,BX                       ;HOLDS TOTAL
    
    XOR CX,CX                       ;SIGN
                    
    
    MOV AH,1                        ;TAKE CHARACTER IN AL
    INT 21H


    
    REPEAT4: 
                                     
    CMP AL,48                       ;IF AL<0, PRINT ERROR MESSAGE
    JL ERROR
    
    CMP AL,57                       ;IF AL>9, PRINT ERRIR MESSAGE 
    JG ERROR


    AND AX,00FH                     ;CONVERT TO DIGIT
    PUSH AX                         ;SAVE ON STACK
    
    MOV AX,10                       ;GET 10
    MUL BX                          ;AX=TOTAL * 10
    POP BX                          ;GET DIGIT BACK
    ADD BX,AX                       ;TOTAL = TOTAL X 10 +DIGIT
    
    
    MOV AH,1
    INT 21H
    
    CMP AL,0DH                      ;CARRIAGE RETURN
    JNE REPEAT4                     ;IF NO CARRIEGE RETURN THEN MOVE ON
    
    MOV AX,BX                       ;STORE IN AX
    
    
    JMP MUL_
    
    POP DX                          ;RESTORE REGISTERS
    POP CX
    POP BX
    RET                             ;AND RETURN
    
    

INDEC3 ENDP                         ;END OF INDEC3 

ADD_: 


    ;SECOND VALUE STORED IN B
    MOV B,AX  
    
   
    
    
    XOR AX,AX                        ;CLEAR AX
    
    MOV AX,B                         ;MOV B TO AX
    ADD A,AX                         ;ADD A WITH AX
    
    
    MOV AX,A                         ;MOV A TO AX
    
    PUSH AX                          ;TAKE AX INTO STACK
    
    
    JMP END

SUB_: 


    ;SECOND VALUE STORED IN B
    MOV B,AX 
    
    LEA DX,R                         ;PRINT PRESENT AMOUNT STRING
    MOV AH,9
    INT 21H
    
    
    XOR AX,AX                        ;CLEAR AX
    
    MOV AX,B                         ;MOV B TO AX
    SUB A,AX                         ;SUBSTRACT AX FROM A
    
    
    MOV AX,A                         ;MOV A TO AX
    
    PUSH AX  
    
    ADD S,AX
    
    JMP OUTPUT

MUL_: 


    ;SECOND VALUE STORED IN B
    MOV B,AX             
    
     
    
    LEA DX,E_DISCOUNT                ;PRINT ENTER DISCOUNT STRING
    MOV AH,9
    INT 21H
    
    XOR AX,AX                        ;CLEAR AX
    
    MOV AX,B
    
    MUL A                            ;MULTIPLY A WITH AX
    
    
    PUSH AX                          ;TAKE AX INTO STACK
    
    MOV A,AX 
   
                                     
    JMP INPUT_SUB                    ;JUMP TO INP1UT_SUB
    
    
    
    JMP OUTPUT 
                                          
INPUT_ADD: 

INDEC1 PROC                          ;INDEC PROC1 IS FOR ADDING THE PRESENT AMOUNTS INTO TOTAL 
    
    PUSH BX                          ;TAKE THE VALUES IN STACK
    PUSH CX
    PUSH DX
    
        
    BEGIN1:
    
    
    XOR BX,BX                        ;HOLDS TOTAL
    
    XOR CX,CX                        ;SIGN
                    
    
    MOV AH,1                         ;TAKE CHARACTER IN AL
    INT 21H

    
    REPEAT2: 
                                     ;IF AL<0, PRINT ERROR MESSAGE
    CMP AL,48
    JL ERROR
    
    CMP AL,57                        ;IF AL>9, PRINT ERROR MESSAGE
    JG ERROR


    AND AX,00FH                      ;CONVERT TO DIGIT
    PUSH AX                          ;SAVE ON STACK
    
    MOV AX,10                        ;GET 10
    MUL BX                           ;AX=TOTAL * 10
    POP BX                           ;GET DIGIT BACK
    ADD BX,AX                        ;TOTAL = TOTAL X 10 +DIGIT
    
    
    MOV AH,1                         ;TAKE VALUE INTO AL
    INT 21H
    
    CMP AL,0DH                       ;CARRIAGE RETURN
    JNE REPEAT2                      ;NO KEEP GOING
    
    MOV AX,BX                        ;STORE IN AX
                         
    
    JMP ADD_                         ;JUMP TO ADD_ TO STORE THE TOTAL VALUE
    
    POP DX                           ;RESTORE REGISTERS
    POP CX
    POP BX
    RET                              ;AND RETURN
    
    

INDEC1 ENDP   

INPUT_SUB: 

INDEC2 PROC
    
    PUSH BX                          ;SAVE TO STACK 
    PUSH CX
    PUSH DX
    
    
    
    XOR BX,BX                        ;HOLDS TOTAL
    
    XOR CX,CX                        ;SIGN
                    

    MOV AH,1                         ;CHAR IN AL
    INT 21H
    
    
    
    REPEAT3: 
    
    CMP AL,48                        ;IF AL<0, PRINT ERROR MESSAGE 
    JL ER_DISCOUNT
    
    CMP AL,57                        ;IF AL>9, PRINT ERROR MESSAGE 
    JG ER_DISCOUNT


    AND AX,00FH                      ;CONVERT TO DIGIT
    PUSH AX                          ;SAVE ON STACK
    
    MOV AX,10                        ;GET 10
    MUL BX                           ;AX=TOTAL * 10
    POP BX                           ;GET DIGIT BACK
    ADD BX,AX                        ;TOTAL = TOTAL X 10 +DIGIT
    
    
    MOV AH,1
    INT 21H
    
    CMP AL,0DH                       ;CARRIAGE RETURN
    JNE REPEAT3                      ;NO KEEP GOING
    
    MOV AX,BX                        ;STORE IN AX
    
    OR CX,CX                         ;NEG NUM
    
    
    JMP SUB_

    POP DX                           ;RESTORE REGISTERS
    POP CX
    POP BX
    RET                              ;AND RETURN
                            


INDEC2 ENDP 
    
OUTPUT:         

;OUTDEC PROC IS FOR GIVING THE OUTPUT OF THE PRESENT AMOUNT

OUTDEC PROC
    
    
    PUSH AX                          ;SAVE REGISTERS
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR CX,CX                        ;CX COUNTS DIGITS
    MOV BX,10D                       ;BX HAS DIVISOR
    
    REPEAT1:
    
    XOR DX,DX                        ;PREP HIGH WORD
    DIV BX                           ;AX = QUOTIENT, DX=REMAINDER
    
    PUSH DX                          ;SAVE REMAINDER ON STACK
    INC CX                           ;COUNT = COUNT +1
    
    OR AX,AX                         ;QUOTIENT = 0?
    JNE REPEAT1                      ;NO, KEEP GOING
    
    MOV AH,2                         ;PRINT CHAR FUNCTION
    
    PRINT_LOOP:
    
    POP DX                           ;DIGIT IN DL
    OR DL,30H                        ;CONVERT TO CHAR
    INT 21H                          ;PRINT DIGIT
    LOOP PRINT_LOOP                  ;LOOP UNTILL DONE
    
    POP DX
    POP CX                           ;RESTORE REGISTERS
    POP BX
    POP AX 
    
    JMP ASK
    
    RET
    OUTDEC ENDP 

OUTPUT2: 

    LEA DX,FT                        ;PRINT FINAL TOTAL
    MOV AH,9
    INT 21H
    
    XOR AX,AX                        ;CLEAR AX
    
    MOV AX,S                         ;SET AX INTO 0
    
    
    ;OUTDEC2 IS FOR GIVING THE TOTAL OUTPUT OF THE AMOUNT
    
    OUTDEC2 PROC
    
    
    PUSH AX                          ;SAVE REGISTERS
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX,CX                        ;CX COUNTS DIGITS
    MOV BX,10D                       ;BX HAS DIVISOR
    
    REPEAT12:
    
    XOR DX,DX                        ;PREP HIGH WORD
    DIV BX                           ;AX = QUOTIENT, DX=REMAINDER
    
    PUSH DX                          ;SAVE REMAINDER ON STACK
    INC CX                           ;COUNT = COUNT +1
    
    OR AX,AX                         ;QUOTIENT = 0?
    JNE REPEAT12                     ;NO, KEEP GOING
    
    MOV AH,2                         ;PRINT CHAR FUNCTION
    
    PRINT_LOOP2:
    
    POP DX                           ;DIGIT IN DL
    OR DL,30H                        ;CONVERT TO CHAR
    INT 21H                          ;PRINT DIGIT
    LOOP PRINT_LOOP2                 ;LOOP UNTILL DONE
    
    POP DX
    POP CX                           ;RESTORE REGISTERS
    POP BX
    POP AX 
    

    OUTDEC2 ENDP 

    END:
    MOV AH, 4CH                  
    INT 21H  
              
    
    NL PROC               ; FUNCTION  FOR NEW LINE
        
        MOV DL, 10
        MOV AH, 02H
        INT 21H  
        
        MOV DL, 13
        MOV AH, 02H
        INT 21H 
        
        RET
        
        NL ENDP
        
  

     
END MAIN
