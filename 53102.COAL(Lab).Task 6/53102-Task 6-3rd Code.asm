.MODEL SMALL
.STACK 100h

.DATA
    char_array db 'abcdefgh$'          ; Array of characters from a to h
    input_prompt db 'Enter a character to search: $'
    found_msg db 'Character found.$'
    not_found_msg db 'Character not found.$'
    newline db 0Dh, 0Ah, '$'

.CODE
MAIN PROC
    mov ax, @DATA
    mov ds, ax

    ; Display input prompt
    call display_input_prompt

    ; Read user input
    call read_char

    ; Search for character
    call search_char

    ; Display result based on search
    cmp al, 1
    je found
    call display_not_found

    jmp end_program

found:
    call display_found

end_program:
    call newline_proc

    ; Exit program
    mov ah, 4Ch
    int 21h

MAIN ENDP

; Procedure to display input prompt
display_input_prompt PROC
    mov ah, 09h
    lea dx, input_prompt
    int 21h
    ret
display_input_prompt ENDP

; Procedure to read a character from the user
read_char PROC
    mov ah, 01h
    int 21h
    mov bl, al       ; Store the input character in BL
    ret
read_char ENDP

; Procedure to search character in array
search_char PROC
    lea si, char_array   
    mov cx, 8            ; Array length is 8 characters 

search_loop:
    mov al, [si]         ; Load the current character from the array
    cmp al, bl           ; Compare it with the user input
    je char_found        ; If equal jump to char_found label

    ; Move to the next character in the array
    inc si
    loop search_loop     ; Repeat until all characters are checked

    ; If not found, set al to 0 and return
    mov al, 0
    ret

char_found:
    ; If found, set al to 1 and return
    mov al, 1
    ret
search_char ENDP

; Procedure to display "Character found" message
display_found PROC
    mov ah, 09h
    lea dx, found_msg
    int 21h
    ret
display_found ENDP

; Procedure to display "Character not found" message
display_not_found PROC
    mov ah, 09h
    lea dx, not_found_msg
    int 21h
    ret
display_not_found ENDP

; Procedure to print a new line
newline_proc PROC
    mov ah, 09h
    lea dx, newline
    int 21h
    ret
newline_proc ENDP

END MAIN
