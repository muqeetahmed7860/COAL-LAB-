.model small
.stack 100h
.data
    newline db 0dh, 0ah, '$'
.code

print_char macro character
    mov dl, character       ; Load character into DL
    add dl, '0'             ; Convert number to ASCII
    mov ah, 02h             ; DOS function to print character
    int 21h                 ; Interrupt to print character in DL
endm

main proc
    mov ax, @data
    mov ds, ax

    mov cx, 5               ; outer loop counter for rows
    mov bx, 1               ; starting number to print

outer_loop:
    push cx                 ; Save outer loop counter

    mov cx, bx              ; inner loop counter for printing numbers
inner_loop:
    push cx                 ; Save inner loop counter

    print_char bl           ; Macro call to print the number

    pop cx                  ; Restore inner loop counter
    loop inner_loop         ; Repeat inner loop

    lea dx, newline         ; Print newline
    mov ah, 09h             ; DOS function to print string
    int 21h                 ; Interrupt to print newline

    pop cx                  ; Restore outer loop counter
    inc bx                  ; Increment number to print
    loop outer_loop         ; Repeat outer loop

    mov ah, 4ch
    int 21h
main endp

end main
