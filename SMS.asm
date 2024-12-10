.MODEL SMALL
.STACK 100H
.DATA


    ;DECLARED STRINGS

    INTRO           DB '*********************WELCOME TO SHOPPING MANAGEMENT SYSTEM**********************$'

    ; LOGIN PAGE
    L1              DB 13, 10,       "**************************************************$"
    L2              DB 13, 10,       "**                  LOG IN TO START             **$"
    L3              DB 13, 10,       "**************************************************$"

    ASKUSERNAME     DB "ENTER USERNAME: $"
    ASKPASSWORD     DB "ENTER PASSWORD: $"

    LOGINSUCCESSMSG DB "LOGIN SUCCESSFUL! $"
    LOGINERRORMSG   DB "LOGIN FAILED! (PRESS ANY KEY TO CONTINUE) $"

    USERNAME        DB "abdullah"                                                                             ; SET USERNAME
    PASSWORD        DB "sardar"                                                                               ; SET PASSWORD

    INUSERNAME      DB 10 DUP("$")                                                                            ; SIZE OF INPUT USERNAME (10 CHARACTERS MAX)
    INPASSWORD      DB 10 DUP("$")                                                                            ; SIZE OF INPUT PASSWORD (10 CHARACTERS MAX)
    
    INTRO2          DB '*********************SHOPPING MANAGEMENT SYSTEM**********************$'


    INFO            DB 10,13,'KEYS      ITEMS                PRICE$'

    S_MALE          DB 10,13,' 1    SHIRT(MALE)             500 TAKA $'
                     
    P_MALE          DB 10,13,' 2    PANT (MALE)             1000 TAKA $'

    M_SHOES         DB 10,13,' 3    SHOES (MALE)            1500 TAKA $'

    S_FEMALE        DB 10,13,' 4    SHIRT(FEMALE)           1000 TAKA $'

    P_FEMALE        DB 10,13,' 5    PANT (FEMALE)           2000 TAKA $'

    F_SHOES         DB 10,13,' 6    SHOES (FEMALE)          3000 TAKA $'


    ENTER           DB 10,13,'PLEASE ENTER THE KEYS TO BUY: $'

    ER_MSG          DB 10,13,'ERROR INPUT$'

    ERASK           DB 10,13,'START FROM THE BEGINNING $'

    E_QUANTITY      DB 10,13,'ENTER QUANTITY: $'
    
    R               DB 10,13,'TOTAL AMOUNT IS TAKA = $'
 
    A               DW ?                                                                                      ;DECALRED VARIABLES FOR AMOINT TO BE STORE
 
.CODE
MAIN PROC
  
                            MOV  AX, @DATA                  ;first we will  ACCESS .DATA
                            MOV  DS, AX
   
                                 
                            LEA  DX, INTRO                  ; PRINT Welcome message STRING on intro variable
                            MOV  AH, 9
                            INT  21H
     
    LOGINSTART:             
    ; Display login page header
                            LEA  DX, L1
                            MOV  AH, 9
                            INT  21H

                            LEA  DX, L2
                            MOV  AH, 9
                            INT  21H

                            LEA  DX, L3
                            MOV  AH, 9
                            INT  21H

    ; Print a new line
                            CALL NL
                            CALL NL
    
    ; Prompt for username
                            LEA  DX, ASKUSERNAME
                            MOV  AH, 9
                            INT  21H

    ; Get username input from user
                            MOV  SI, OFFSET INUSERNAME
    
    INPUTUSERNAME:          
                            MOV  AH, 1                      ; Read character
                            INT  21H
                            MOV  [SI], AL                   ; Store character in buffer
                            INC  SI
                            CMP  AL, 13                     ; Check for Enter key (carriage return)
                            JNE  INPUTUSERNAME              ;this condition if enter key is not enter than it will again call the lable so similarly looping type happen
    

    ; PROMPT FOR PASSWORD
                            CALL NL
    
                            MOV  AH, 9
                            LEA  DX, ASKPASSWORD
                            INT  21H

    ; GET PASSWORD INPUT FROM USER
                            MOV  SI, OFFSET INPASSWORD
     
    INPUTPASSWORD:          
                            MOV  AH, 1
                            INT  21H
                            MOV  [SI], AL
                            INC  SI
                            CMP  AL, 13                     ;compare if enter key(13) enter
                            JNE  INPUTPASSWORD              ;this condition if enter key is not enter than it will again call the lable so similarly looping type happen

    ; VALIDATE USERNAME
                            MOV  SI, OFFSET USERNAME
                            MOV  DI, OFFSET INUSERNAME
                            MOV  CX, 8                      ; LOOP ITERATION COUNT
    
    LOGINVALIDATIONUSERNAME:
                            MOV  BL, [SI]
                            MOV  DL, [DI]
                            CMP  BL, DL
                            JNE  INVALIDLOGIN               ; IF MISMATCH, JUMP TO ERROR HANDLING
                            INC  SI
                            INC  DI
                            LOOP LOGINVALIDATIONUSERNAME

    ; VALIDATE PASSWORD
                            MOV  SI, OFFSET PASSWORD
                            MOV  DI, OFFSET INPASSWORD
                            MOV  CX, 5                      ; LOOP ITERATION COUNT
    
    LOGINVALIDATIONPASSWORD:
                            MOV  BL, [SI]
                            MOV  DL, [DI]
                            CMP  BL, DL
                            JNE  INVALIDLOGIN               ; IF MISMATCH, JUMP TO ERROR HANDLING
                            INC  SI
                            INC  DI
                            LOOP LOGINVALIDATIONPASSWORD

    ; DISPLAY SUCCESS MESSAGE
                            CALL NL
    
                            MOV  AH, 9
                            LEA  DX, LOGINSUCCESSMSG
                            INT  21H

    ; GO TO MAIN MENU
                            JMP  BEGINTOP

    INVALIDLOGIN:           
    ; DISPLAY ERROR MESSAGE
                            CALL NL
    
                            MOV  AH, 9
                            LEA  DX, LOGINERRORMSG
                            INT  21H

    ; WAIT FOR KEY PRESS
                            CALL NL
    
                            MOV  AH, 1
                            INT  21H

    ; RESTART LOGIN PROCESS
                            JMP  LOGINSTART

                   

    BEGINTOP:               
     
                            CALL NL
                            CALL NL
     
                            LEA  DX, INTRO2                 ; PRINT INTRO STRING
                            MOV  AH, 9
                            INT  21H
          
                            CALL NL                         ; PRINT A NEW LINE
                    
      
                            LEA  DX, INFO                   ; PRINT INFO STRING
                            MOV  AH, 9
                            INT  21H
     
                            CALL NL                         ; PRINT A NEW LINE
        

                            LEA  DX, S_MALE                 ; PRINT SHIRT MALE STRING
                            MOV  AH, 9
                            INT  21H
     
                            CALL NL                         ; PRINT A NEW LINE
     
                   
                            LEA  DX, P_MALE                 ; PRINT PANT MALE STRING
                            MOV  AH, 9
                            INT  21H
     
                            CALL NL                         ; PRINT A NEW LINE
     
                   
                            LEA  DX, M_SHOES                ; PRINT MALE SHOES STRING
                            MOV  AH, 9
                            INT  21H
     
                            CALL NL                         ; PRINT A NEW LINE
     
                   
                            LEA  DX, S_FEMALE               ; PRINT CASUAL SHIRT FEMALE STRING
                            MOV  AH, 9
                            INT  21H
     
                            CALL NL                         ; PRINT A NEW LINE
     
                   
                            LEA  DX, P_FEMALE               ; PRINT PANT FEMALE STRING
                            MOV  AH, 9
                            INT  21H
     
                            CALL NL                         ; PRINT A NEW LINE
     
                            LEA  DX, F_SHOES                ; PRINT FEMALE SHOES STRING
                            MOV  AH, 9
                            INT  21H
     
                            CALL NL                         ; PRINT A NEW LINE
     
            
                            LEA  DX, ENTER                  ; PRINT ENTER STRING
                            MOV  AH, 9
                            INT  21H
        
     
                            MOV  AH, 1                      ; TAKE AN INPUT & SAVED TO AL
                            INT  21H
     
     
     
                            CMP  AL,49                      ;IF AL=1 GO TO CS_MALEB LEBEL
                            JE   S_MALEB
     
                            CMP  AL,50                      ;IF AL=2 GO TO PANT_MALEB LEBEL
                            JE   P_MALEB
     
                            CMP  AL,51                      ;IF AL=3 GO TO M_SHOESB LEBEL
                            JE   M_SHOESB
     
                            CMP  AL,52                      ;IF AL=4 GO TO CS_FEMALEB LEBEL
                            JE   S_FEMALEB
     
                            CMP  AL,53                      ;IF AL=5 GO TO PANT_FEMALEB LEBEL
                            JE   P_FEMALEB
     
                            CMP  AL,54                      ;IF AL=6 GO TO F_SHOESB LEBEL
                            JE   F_SHOESB
     
   
                            JMP  ERROR121
    ;if any previous line is not correct then it's an error input eg. 0/7 so print error message by jumbing to that error label
     
    ERROR121:               
                  
                            LEA  DX,ER_MSG                  ;PRINT ERROR MESSAGE if user select erong number like 0/7
                            MOV  AH,9
                            INT  21H
    ;IF USER GIVES AN ERROR THEN USER WILL BE ASKED TO INPUT AGAIN
                            LEA  DX,ERASK
                            MOV  AH,9
                            INT  21H
     
                            JMP  BEGINTOP
     
   
    S_MALEB:                
                                 
                            MOV  A,500                      ;PRICE OF SHIRT MALE IS MOVED TO A WHERE PRICE IS 500

                            JMP  QUANTITY
 

    P_MALEB:                

                            MOV  A,1000                     ;PRICE OF PANT MALE IS MOVED TO A WHERE PRICE IS 1000

                            JMP  QUANTITY
    

    M_SHOESB:               

                            MOV  A,1500                     ;PRICE OF MALE SHOES IS MOVED TO A WHERE PRICE IS 1500

                            JMP  QUANTITY
    

    S_FEMALEB:              

                            MOV  A,1000                     ;PRICE OF CASUAL SHIRT FEMALE IS MOVED TO A WHERE PRICE IS 1000

                            JMP  QUANTITY
     

    P_FEMALEB:              

                            MOV  A,2000                     ;PRICE OF PANT FEMALE IS MOVED TO A WHERE PRICE IS 2000

                            JMP  QUANTITY
    

    F_SHOESB:               

                            MOV  A,3000                     ;PRICE OF FEMALE SHOES IS MOVED TO A WHERE PRICE IS 3000

                            JMP  QUANTITY

                 
                 
    ;AFTER MOVING PRICE PROGRAM WILL JUMP TO QUANTITY LEBEL

    QUANTITY:               

                            CALL NL

                            LEA  DX,E_QUANTITY              ;PRINT ENTER QUANTITY STRING
                            MOV  AH,9
                            INT  21H
    
                            JMP  MULTI                      ;PROGRAM WILL GO TO MULTI LEBEL WHERE THE PRICE WILL BE MILTIPLIED WITH THE AMOUNT




    ERROR:                  
                  
                            LEA  DX,ER_MSG                  ;PRINT ERROR MESSAGE if user select erong number like 0/7
                            MOV  AH,9
                            INT  21H
     
                            JMP  QUANTITY
     

    MULTI:                                                  ;Quantity Number task
     

INDEC3 PROC                                                 ;INDEC3 IS FOR TAKING INPUT FOR MULTIPLY WITH THE GIVEN AMOUNT
    
     
                            XOR  BX,BX                      ;HOLDS TOTAL QUANTITY
                      
    
                            MOV  AH,1                       ;TAKE CHARACTER IN AL for quantity number
                            INT  21H
    
                            CMP  AL,48                      ;IF AL<0, PRINT ERROR MESSAGE
                            JL   ERROR
    
                            CMP  AL,57
                            JG   ERROR
    
    
                            MOV  BL,AL
                            SUB  BL,48

    
                            MOV  AX,BX                      ;STORE IN AX
    
    
                            JMP  MUL_
    
    
                            RET                             ;AND RETURN
    
    

INDEC3 ENDP                                                 ;END OF INDEC3






    MUL_:                                                   ;Quantity will Multiplied with the amount of A


    
                            MUL  A                          ;MULTIPLY A=Amount WITH AX
                            MOV  BX,AX
    ;moving ax to bx otherwise printing will overwrite ax
                            CALL NL
    ;total amount string print
                            LEA  DX,R
                            MOV  AH,9
                            INT  21H
    
                            MOV  AX, BX
    
                    
   
                                     
                            JMP  OUTPUT
 
 
 
    OUTPUT:                 

    ;OUTDEC PROC IS FOR GIVING THE OUTPUT OF THE TOTAL AMOUNT

OUTDEC PROC
    
   
                            MOV  BX, 10                     ; Base = 10 (decimal)
                            MOV  CX, 0                      ; Clear CX
    PRINT_DECIMAL:          
                            MOV  DX, 0
                            DIV  BX                         ; Divide AX by 10
                            PUSH DX                         ; Remainder (digit) on stack cause it's word not byte
                            INC  CX                         ; Increment digit count
                            CMP  AX, 0
                            JNE  PRINT_DECIMAL
    
    ; Print digits in the correct order
    PRINT_LOOP:             
                            POP  DX
                            ADD  DL, 48                     ; Convert to ASCII
                            MOV  AH, 2                      ; Print character
                            INT  21H
                            LOOP PRINT_LOOP                 ; Loop for all digits
    
OUTDEC ENDP

    END:                    
                            MOV  AH, 4CH
                            INT  21H
  
       
                 
NL PROC                                                     ; FUNCTION  FOR NEW LINE
        
                            MOV  DL, 10
                            MOV  AH, 02H
                            INT  21H
        
                            MOV  DL, 13
                            MOV  AH, 02H
                            INT  21H
        
                            RET
        
NL ENDP
            
END MAIN
