;
; Simple boot sector w/ teletype mode
;

mov ah, 0x0e ; tell the bios we want scrolling teletype mode

mov al, 'H'
int 0x10 ; tell the bios to print out the contents of `al`
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10
mov al, 'W'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'd'
int 0x10 ;Very long hello world....

jmp $ ; Infinite loop; $ means this line, so this means 'loop to this line'

times 510-($-$$) db 0 ;fill the 512 bit sector with 0s
dw 0xaa55 ; Final 2 bit (magic number)
