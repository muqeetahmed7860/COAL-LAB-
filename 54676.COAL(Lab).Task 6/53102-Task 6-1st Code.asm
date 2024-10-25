.model small
.stack 100h
.data
    newline db 0dh, 0ah, '$'
.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 5          ; outer loop counter for rows
    mov bx, 1          ; starting number to print

outer_loop:
    push cx            

    mov cx, bx         ; inner loop counter for printing numbers
inner_loop:
    push cx            ; save inner loop counter

    mov dl, bl         ; move number to dl
    call print_number  ; call procedure to print number

    pop cx             
    loop inner_loop    ; repeat inner loop

    lea dx, newline    ; print newline
    mov ah, 09h        ; function to print string
    int 21h           

    pop cx             ; restore outer loop counter
    inc bx             ; increment number to print
    loop outer_loop    ; repeat outer loop

    
    mov ah, 4ch
    int 21h
main endp

; Function to print number
print_number proc
    add dl, '0'        ; convert number to ASCII
    mov ah, 02h        ; function to print character
    int 21h
    ret
print_number endp
end main
