; I get help from this links thanks a lot!
; https://stackoverflow.com/questions/16525934/how-to-clear-console-window-in-nasm
; https://stackoverflow.com/questions/36090659/how-to-change-or-set-background-color-in-8086-assembly

[org 0x7c00]

; mov ah, 09h
; mov cx, 1000h
; mov al, 20h
; mov bl, 47  ; This is Blue & White.

mov bp, 0x7c00
mov sp, bp
mov bx, stringer

call os_clear_screen
call print_welcome_message

jmp $

print_welcome_message:
    mov ah, 0x0e
    .Loop:
    cmp [bx], byte 0 
    je .Exit
        mov al, [bx]
        int 0x10
        inc bx
        jmp .Loop
    .Exit:
    ret

stringer:
    db 'SoliOS Welcome!',0

os_clear_screen:
    pusha

    mov dx, 0           ; Position cursor at top-left
    call os_move_cursor

    mov ah, 6           ; Scroll full-screen
    mov al, 0           ; Normal white on black
    mov bh, 7           ;
    mov cx, 0           ; Top-left
    mov dh, 24          ; Bottom-right
    mov dl, 79
    int 10h

    popa
    ret

os_move_cursor:
    pusha

    mov bh, 0
    mov ah, 2
    int 10h             ; BIOS interrupt to move cursor

    popa
    ret

times 510-($-$$) db 0

dw 0xaa55

