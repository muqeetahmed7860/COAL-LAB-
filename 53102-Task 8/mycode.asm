.model small
.stack 100h
.data
    menu_msg db 'please select the proper number from the following:', 0dh, 0ah
             db '1. addition', 0dh, 0ah
             db '2. subtraction', 0dh, 0ah
             db '3. division', 0dh, 0ah, '$'
    
    num1_msg db 0dh, 0ah, 'enter number 1: $'
    num2_msg db 0dh, 0ah, 'enter number 2: $'
    
    add_msg  db 0dh, 0ah, 'the sum is: $'
    sub_msg  db 0dh, 0ah, 'the difference is: $'
    div_msg  db 0dh, 0ah, 'the quotient is: $'
    
    num1 db ?
    num2 db ?
    result db ?

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; display menu
menu:
    mov ah, 9
    lea dx, menu_msg
    int 21h
    
    ; get user choice
    mov ah, 1
    int 21h
    sub al, '0'    ; convert ascii to number
    
    ; compare choice and jump to appropriate operation
    cmp al, 1
    je addition
    cmp al, 2
    je subtraction
    cmp al, 3
    je division
    jmp exit
    
addition:
    call get_numbers
    mov al, num1
    add al, num2
    mov result, al
    
    mov ah, 9
    lea dx, add_msg
    int 21h
    
    mov al, result
    call display_result
    jmp menu
    
subtraction:
    call get_numbers
    mov al, num1
    sub al, num2
    mov result, al
    
    mov ah, 9
    lea dx, sub_msg
    int 21h
    
    mov al, result
    call display_result
    jmp menu
    
division:
    call get_numbers
    mov al, num1
    mov ah, 0
    div num2
    mov result, al
    
    mov ah, 9
    lea dx, div_msg
    int 21h
    
    mov al, result
    call display_result
    jmp menu
    
get_numbers proc
    ; get first number
    mov ah, 9
    lea dx, num1_msg
    int 21h
    
    mov ah, 1
    int 21h
    sub al, '0'
    mov num1, al
    
    ; get second number
    mov ah, 9
    lea dx, num2_msg
    int 21h
    
    mov ah, 1
    int 21h
    sub al, '0'
    mov num2, al
    
    ret
get_numbers endp

display_result proc
    ; convert number to ascii and display
    add al, '0'
    mov dl, al
    mov ah, 2
    int 21h
    
    ; new line
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    
    ret
display_result endp

exit:
    mov ah, 4ch
    int 21h
    
end main
