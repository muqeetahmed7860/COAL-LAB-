.MODEL SMALL
.STACK 100h

.DATA
    char_array db 'abcdefgh$'         ; Array of characters from a to h
    input_prompt db 'Enter a character to search: $'
    found_msg db 'Character found.$'
    not_found_msg db 'Character not found.$'
    newline db 0Dh, 0Ah, '$'

.CODE

; Macro to display a message
display_msg macro msg
    mov ah, 09h
    lea dx, msg
    int 21h
endm

; Macro to read a character from user input
read_char macro
    mov ah, 01h
    int 21h
    mov bl, al         ; Store the input character in BL
endm

; Macro to print a newline
print_newline macro
    mov ah, 09h
    lea dx, newline
    int 21h
endm

MAIN PROC
    mov ax, @DATA
    mov ds, ax

    ; Display input prompt
    display_msg input_prompt

    ; Read user input
    read_char

    ; Search for character
    call search_char

    ; Display result based on search
    cmp al, 1
    je found
    display_msg not_found_msg

    jmp end_program

found:
    display_msg found_msg

end_program:
    print_newline

    ; Exit program
    mov ah, 4Ch
    int 21h

MAIN ENDP

; Procedure to search character in array
search_char PROC
    lea si, char_array   
    mov cx, 8            ; Array length is 8 characters 

search_loop:
    mov al, [si]         ; Load the current character from the array
    cmp al, bl           ; Compare it with the user input
    je char_found        ; If equal, jump to char_found label

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

END MAIN
