DATA SEGMENT
    arr  DB 4 DUP (?) ; array to store input value    
    arr1 DB 4 DUP (?) ; array to store input value
    arr2 DB 4 DUP (?) ; array to store input value
    arr3 DB 4 DUP (?) ; array to store input value
    msg1 DB  0AH, 0DH,'PLACE OBSTACLE IN FRONT : $'
    msg2 DB  0AH, 0DH,'SENSOR DETECTING OBSTACLE IN FRONT OR NOT : $'
    msg_match DB 0AH, 0DH, 'OBSTACLE DETECTED IN FRONT : ', 0AH, 0DH, '$'   
    msg_not_match DB 0AH, 0DH, 'CAN MOVE FORWARD ', 0AH, 0DH, '$'  
    
    left_msg1 DB  0AH, 0DH,'PLACE OBSTACLE IN LEFT :  $' 
    left_msg2 DB  0AH, 0DH,'SENSOR DETECTING OBSTACLE IN LEFT OR NOT :  $'
    left_msg_match DB 0AH, 0DH, 'OBSTACLE DETECTED IN LEFT :', 0AH, 0DH, '$'   
    left_msg_not_match DB 0AH, 0DH, 'CAN MOVE LEFT', 0AH, 0DH, '$'  
    
    right_msg1 DB  0AH, 0DH,'PLACE OBSTACLE IN RIGHT : $'
    right_msg2 DB  0AH, 0DH,'SENSOR DETECTING OBSTACLE IN RIGHT OR NOT : $'
    right_msg_match DB 0AH, 0DH, 'OBSTACLE DETECTED IN RIGHT :', 0AH, 0DH, '$'   
    right_msg_not_match DB 0AH, 0DH, 'CAN MOVE RIGHT ', 0AH, 0DH, '$'  
    
    back_msg1 DB  0AH, 0DH,'PLACE OBSTACLE IN BACK :  $'
    back_msg2 DB  0AH, 0DH,'SENSOR DETECTING OBSTACLE IN BACK OR NOT :  $'
    back_msg_match DB 0AH, 0DH, 'OBSTACLE DETECTED IN BACK :', 0AH, 0DH, '$'   
    back_msg_not_match DB 0AH, 0DH, 'CAN MOVE BACKWARDS ', 0AH, 0DH, '$' 
    
    horiz_line DB 80 DUP ('-') ; horizontal line  
    msg_welcome DB 'Welcome to Obstacle detection system by 20BCE0136', 0AH, 0DH, '$' 
    
    directions DB 00
    clear_msg DB 0DH,0AH,'$'
    fmsg DB 0AH,0DH,'NUMBER OF DIRECTIONS VEHICLE CAN MOVE : $'
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    ; initialize data segment
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, msg_welcome
    INT 21H
    ; print horizontal line
    MOV AH, 9
    LEA DX, horiz_line
    INT 21H

    ; print welcome message
    
INFINITE_LOOP:
    ; print another horizontal line
    MOV AH, 9
    LEA DX, horiz_line
    INT 21H
    
    ;FORWARD read input value and store in array
    MOV AH, 9
    LEA DX, msg1
    INT 21H
    MOV CX, 4 ; loop counter
    LEA SI, arr ; SI points to first element of array
    READ_LOOP:
        MOV AH, 1 ; read input character
        INT 21H
        MOV BYTE PTR [SI], AL ; store value in array
        INC SI ; point to next element
        LOOP READ_LOOP   
    
    ;BACKWARD read input value and store in array
    MOV AH, 9
    LEA DX, back_msg1
    INT 21H
    MOV CX, 4 ; loop counter
    LEA SI, arr1 ; SI points to first element of array
    READ_LOOP1:
        MOV AH, 1 ; read input character
        INT 21H
        MOV BYTE PTR [SI], AL ; store value in array
        INC SI ; point to next element
        LOOP READ_LOOP1  
        
    ;LEFT read input value and store in array
    MOV AH, 9
    LEA DX, left_msg1
    INT 21H
    MOV CX, 4 ; loop counter
    LEA SI, arr2 ; SI points to first element of array
    READ_LOOP2:
        MOV AH, 1 ; read input character
        INT 21H
        MOV BYTE PTR [SI], AL ; store value in array
        INC SI ; point to next element
        LOOP READ_LOOP2   
    
    ;RIGHT read input value and store in array
    MOV AH, 9
    LEA DX, right_msg1
    INT 21H
    MOV CX, 4 ; loop counter
    LEA SI, arr3 ; SI points to first element of array
    READ_LOOP3:
        MOV AH, 1 ; read input character
        INT 21H
        MOV BYTE PTR [SI], AL ; store value in array
        INC SI ; point to next element
        LOOP READ_LOOP3  
             

    ;FORWARD read second value and compare to array value
    MOV AH, 9
    LEA DX, msg2
    INT 21H
    MOV CX, 4 ; loop counter
    LEA SI, arr ; SI points to first element of array
    CMP_LOOP:
        MOV AH, 1 ; read input character
        INT 21H
        CMP BYTE PTR [SI], AL ; compare input character to array value
        JNE NOT_MATCH ; jump if not a match
        INC SI ; point to next element
        LOOP CMP_LOOP
        ; if we get here, a match was found
        LEA DX, msg_match
        JMP WRITE_MSG
    NOT_MATCH:
        LEA DX, msg_not_match
        INC directions
    WRITE_MSG:
        MOV AH, 9 ; display message to screen
        INT 21H                    
    
    ;BACKWARD read second value and compare to array value    
     MOV AH, 9
    LEA DX, back_msg2
    INT 21H
    MOV CX, 4 ; loop counter
    LEA SI, arr1 ; SI points to first element of array
    CMP_LOOP1:
        MOV AH, 1 ; read input character
        INT 21H
        CMP BYTE PTR [SI], AL ; compare input character to array value
        JNE NOT_MATCH1 ; jump if not a match
        INC SI ; point to next element
        LOOP CMP_LOOP1
        ; if we get here, a match was found
        LEA DX, back_msg_match
        JMP WRITE_MSG1
    NOT_MATCH1:
        LEA DX, back_msg_not_match
        INC directions
    WRITE_MSG1:
        MOV AH, 9 ; display message to screen
        INT 21H
    
    ;LEFT read second value and compare to array value    
     MOV AH, 9
    LEA DX, left_msg2
    INT 21H
    MOV CX, 4 ; loop counter
    LEA SI, arr2 ; SI points to first element of array
    CMP_LOOP2:
        MOV AH, 1 ; read input character
        INT 21H
        CMP BYTE PTR [SI], AL ; compare input character to array value
        JNE NOT_MATCH2 ; jump if not a match
        INC SI ; point to next element
        LOOP CMP_LOOP2
        ; if we get here, a match was found
        LEA DX, left_msg_match
        JMP WRITE_MSG2
    NOT_MATCH2:
        LEA DX, left_msg_not_match
        INC directions
    WRITE_MSG2:
        MOV AH, 9 ; display message to screen
        INT 21H
   
   ;RIGHT read second value and compare to array value     
     MOV AH, 9
    LEA DX, right_msg2
    INT 21H
    MOV CX, 4 ; loop counter
    LEA SI, arr3 ; SI points to first element of array
    CMP_LOOP3:
        MOV AH, 1 ; read input character
        INT 21H
        CMP BYTE PTR [SI], AL ; compare input character to array value
        JNE NOT_MATCH3 ; jump if not a match
        INC SI ; point to next element
        LOOP CMP_LOOP3
        ; if we get here, a match was found
        LEA DX, right_msg_match
        JMP WRITE_MSG3
    NOT_MATCH3:
        LEA DX, right_msg_not_match
        INC directions
    WRITE_MSG3:
        MOV AH, 9 ; display message to screen
        INT 21H            
    
    MOV AH, 9
    LEA DX, fmsg
    INT 21H     
    
    LEA SI,directions
    CALL TOGETFROMPC 
    MOV AH, 9
    LEA DX, clear_msg
    INT 21H  
    
JMP INFINITE_LOOP
    
    ; exit program
    MOV AH, 4CH
    INT 21H
CODE ENDS 


PROC TOGETFROMPC
    PUSH CX     
    MOV AL,[SI]
    AND AL,0F0H
    MOV CL,04H
    ROL AL,CL 
    ADD AL,30H
    CMP AL,39H
    JLE G3
    ADD AL,07H
G3: MOV AH,02H ;to put single character on screen
    MOV DL,AL
    INT 21H     
    
    MOV AL,[SI]
    AND AL,0FH
    ADD AL,30H
    CMP AL,39H
    JLE G4
    ADD AL,07H
G4: MOV AH,02H ;to put single character on screen
    MOV DL,AL
    INT 21H
    
    POP CX
    RET
ENDP TOGETFROMPC
         
END START