.model small
.stack 100h

.data
    newline db 0Dh, 0Ah, '$'    ; Newline characters

.code
main proc
    mov ax, @data        
    mov ds, ax

    ; Initialize starting number
    mov cx, 1             ; Start with number 1

outer_loop:
    ; Call the procedure to print 4 numbers in a row
    call print_numbers_in_row

    ; Print a new line after each set of 4 numbers
    call print_newline

    ; Decrement outer loop counter 
    cmp cx, 9
    jl outer_loop 
            
    ; Exit program
    mov ah, 4ch
    int 21h
main endp

; Procedure to print 4 numbers in a row
print_numbers_in_row proc
    mov bx, 4             ; 4 numbers per row
inner_loop:
    ; Convert the number in CX to ASCII
    mov ax, cx            ; Move current number into AX
    add al, '0'
    
    ; Print the number
    call print_char

    ; Increment the number
    inc cx

    ; Decrement the inner loop counter
    dec bx
    jnz inner_loop        ; Repeat until 4 numbers are printed
    ret
print_numbers_in_row endp

; Procedure to print a single character 
print_char proc
    mov ah, 02h
    mov dl, al
    int 21h
    ret
print_char endp

; Procedure to print a newline
print_newline proc
    mov ah, 09h
    lea dx, newline
    int 21h
    ret
print_newline endp

end main
