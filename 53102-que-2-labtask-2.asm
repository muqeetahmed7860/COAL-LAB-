.model small
.stack 100h
.data
    numbers dw 0, 1, 2, 3, 4, 5, 6, 7, 8, 9  ; Array of numbers from 0 to 9
    count   dw 10                            ; Number of elements in the array
.code
main proc
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Initialize registers
    xor bx, bx           ; Clear BX to use it for the sum
    mov cx, count        ; Load the count of numbers into CX
    lea si, numbers      ; Load the address of the numbers array into SI

sum_loop:
    add bx, [si]        ; Add the current number to BX
    add si, 2           ; Move to the next number (each number is 2 bytes)
    loop sum_loop       ; Repeat until CX is 0

    ; Calculate the average
    mov ax, bx          ; Move the sum into AX
    xor dx, dx          ; Clear DX before division
    mov cx, count       ; Load count into CX
    div cx               ; AX = AX / CX, quotient in AX (average), remainder in DX

    ; Store the result (average) in BX
    mov bx, ax          ; Store the average in BX

    ; Optional: Display the average (not part of the requirements)
    ; Convert the average to ASCII and print if needed...

    ; Exit program
    mov ax, 4C00h       ; DOS terminate program
    int 21h
main endp
end main
