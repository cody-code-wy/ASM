;
; Simple boot sector w/ teletype mode
;
mov ax, 0x07c0 ;Our memory location. Hopefully
mov ds, ax ;Needed for bios stuff

mov bp, 0x8000 ; Seth the stack (just below our boot sector)
mov sp, bp ; Set the stack pointer to the beginning of the stack

mov si, hex_dump_msg
call print_string

mov si, hex_dump
mov cx, 11
call print_hex

mov si, ax_dump_msg
call print_string

mov ax, 0x3a6b
call print_ax

loop:
  jmp $ ; Infinite loop; $ means this line, so this means 'loop to this line'

%include "print_string.asm"
%include "print_hex.asm"

hex_dump_msg db 'HEX dbg',13,10,"|01|23|45|67|89|ab|cd|ef|00|aa|55|",13,10,"                                  <",13,0
hex_dump db 0x01,0x23,0x45,0x67,0x89,0xab,0xcd,0xef,0x00,0xaa,0x55 ;This looks aweful
ax_dump_msg db 'HEX a',13,10,"3a6b",13,10,"    <",13,0

times 510-($-$$) db 0 ;fill the 512 bit sector with 0s
dw 0xaa55 ; Final 2 bit (magic number)
