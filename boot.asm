;
; Simple boot sector w/ teletype mode
;

mov ah, 0x0e ; tell the bios we want scrolling teletype mode

mov bp, 0x8000 ; Set the stack (just below the our bootsector)
mov sp, bp ; Set the stack pointer to the beginnig of the stack

push 'A' ;Note push puts 16 bits on the stack, but characters are only 8
push 'B' ;The most significant bits will be filled with 0s
push 'C' ;So the memory will be something like 0x00ab

pop bx ;bx is a 16 bit register, hovever it has bh and bl, bl will have the last 8 bit (our character)
mov al, bl ;So get the last 8 bits
int 0x10

pop bx
mov al, bl
int 0x10

; Just to prove the way the stack works...
mov al, [0x7ffe] ;16 bits away from the stack (0x8000)
int 0x10

jmp $ ; Infinite loop; $ means this line, so this means 'loop to this line'

message:
  db 'Booting OS',0

times 510-($-$$) db 0 ;fill the 512 bit sector with 0s
dw 0xaa55 ; Final 2 bit (magic number)
