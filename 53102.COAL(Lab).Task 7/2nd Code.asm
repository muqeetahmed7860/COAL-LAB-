.model small
.stack 100h

.data
    newline db 0Dh, 0Ah, '$'    ; Newline characters

.code

; Macro to print a single character in DL
print_char macro character
    mov dl, character
    mov ah, 02h
    int 21h
endm

; Macro to print 4 numbers in a row starting from CX
print_numbers_in_row macro
    mov bx, 4                  ; Set counter for 4 numbers
inner_loop:
    mov ax, cx                 ; Move current number into AX
    add al, '0'                ; Convert to ASCII

    print_char al              ; Use print_char macro to print the number

    inc cx                     ; Increment number
    dec bx                     ; Decrement inner loop counter
    jnz inner_loop             ; Repeat until 4 numbers are printed
endm

; Macro to print a newline
print_newline macro
    mov ah, 09h
    lea dx, newline
    int 21h
endm

main proc
    mov ax, @data        
    mov ds, ax

    ; Initialize starting number
    mov cx, 1                  ; Start with number 1

outer_loop:
    ; Print 4 numbers in a row using macro
    print_numbers_in_row

    ; Print a new line after each set of 4 numbers
    print_newline

    ; Check if CX has reached 9 to continue the outer loop
    cmp cx, 9
    jl outer_loop
            
    ; Exit program
    mov ah, 4ch
    int 21h
main endp

end main
