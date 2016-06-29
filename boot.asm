;
; Simple boot sector w/ teletype mode
;
mov ax, 0x07c0 ;Our memory location. Hopefully
mov ds, ax ;Needed for bios stuff

mov bp, 0x8000 ; Seth the stack (just below our boot sector)
mov sp, bp ; Set the stack pointer to the beginning of the stack

mov si, msg
call print_string

mov si, exit
call print_string

loop:
  jmp $ ; Infinite loop; $ means this line, so this means 'loop to this line'

%include "print_string.asm"

msg db 'Hello World',13,10,0
exit db 'Goodbye',13,10,0

times 510-($-$$) db 0 ;fill the 512 bit sector with 0s
dw 0xaa55 ; Final 2 bit (magic number)
