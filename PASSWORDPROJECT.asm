.MODEL SMALL
.STACK 100H
.DATA 
 MSG DB 10,13,"ENTER YOUR PASSWORD ",10,13,"$"
   INVALID DB 10,13,"INVALID USERNAME OR PASSWORD ",10,13,"$"
   VALID DB 10,13,"LOGIN SUCESSFULLY ",10,13,"$"
   PASSWORD DB "ADMIN",10,13,"$" 
   LB DB 10,13,"$"
   WC DB 10,13,"*********WELCOME TO LOGIN SYSTEM*********",10,13,
   CR DB 10,13,"********PRESS 1 FOR FOR CREATING ACCOUNT********",10,13,
   P2 DB 10,13,"********PRESS 2 TO FOR LOGIN************",10,13,
   P9 DB 10,13,"********PRESS 3  FOR RETURN TO MENU************",10,13,
    P10 DB 10,13,"********PRESS 4  FOR QUIT************",10,13, 
   CHOICE DB 10,13,10,13,"ENTER YOUR CHOICE ",10,13,"$" 
   PROMT DB 10,13,"ENTER YOUR NEW PASSWORD ",10,13,"$" 
   P3 DB 10,13,"PASSWORD SAVED SUCESSFULLY ",10,13,"$"
   P4 DB 10,13,10,13,"ENTER YOUR NEW USERNAME ",10,13,"$" 
    P5 DB 10,13,10,13,"ENTER YOUR USERNAME ",10,13,"$"  
   USERNAME DB "NULL"     
   DO DB 10,13,"PRESS 3 FOR RETRY ",10,13,"$"     
   SC DB 10,13,"PROGRAM EXECTUTED SUCESSFULLY ",10,13,"$"
   FLAG DB 0
     
   
.CODE
  
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  
    AGAIN:
    
    MOV AH,9
    LEA DX,WC
    INT 21H
    
    MOV AH,1
    INT 21H
    CMP AL,"1"
    JE  CREATEPASSWORD 
    CMP AL,"2"
    JE LOGIN
    
    CMP AL,"4"
    JE  EXITPRO
    
    
    LEA DX,MSG
    MOV AH,9
    INT 21H  
    
    CREATEPASSWORD: 
   
            
    MOV AH,9
    LEA DX,P4
    INT 21H        
            
    MOV SI,OFFSET USERNAME
    CALL USERINPUT
                  
                  
     
    MOV AH,9
    LEA DX,PROMT
    INT 21H              
    
    MOV SI,OFFSET PASSWORD 
    CALL USERINPUT 
    
    MOV AH,9
    LEA DX,P3
    INT 21H
    
    JMP EXIT
    
    
    
    LOGIN: 
    
    MOV AH,9
    LEA DX,P5
    INT 21H        
            
            
    MOV BX,OFFSET USERNAME
    CALL USERLOGIN        
    
    
    MOV AH,9
    LEA DX,MSG
    INT 21H 
    
    
    MOV BX,OFFSET PASSWORD 
    
    
    CALL USERLOGIN
    
    CMP FLAG,1
    JE SHOW
    
    SHOW:
    LEA DX,VALID
    MOV AH,9
    INT 21H
    
    EXIT: 
    MOV AH,9
    LEA DX,DO
    INT 21H
    
    MOV AH,1
    INT 21H
    
    CMP AL,"3"
    JE AGAIN  
    CMP AL,"4"
    JE EXITPRO
    
    EXITPRO:
    
    MOV AH,9
    LEA DX,SC
    INT 21H
    
    MOV AH,4CH
    INT 21H 
    
    MAIN ENDP 
USERINPUT PROC
  
  XOR CX,CX 
          
  L1:
  
  MOV AH,1
  INT 21H
 
 
  
              
  CMP AL,13 
  JE QUIT
  
  CMP AL,32
  
  
  MOV [SI],AL  
  INC SI
  INC CX
  
 
  
  JMP L1  
  
  QUIT:
  MOV AH,9
  LEA DX,LB
  INT 21H
   
  RET
       
    
    
USERINPUT ENDP 

USERLOGIN PROC
    PUSH CX
   l:
    MOV AH,1
    INT 21H
    CMP AL,[BX] 
    
    JNE E
    INC BX
    DEC CX
    
    CMP CX,0  
   
    JE RES
    JMP L
    
    RES:
    
    
    JMP QUIT2
    
    E:
    LEA DX,INVALID
    MOV AH,9
    INT 21H 
    MOV FLAG,1 
 
   
    
    QUIT2:
    POP CX
  
    
  RET  
USERLOGIN ENDP    
END MAIN