;
; Simple boot sector w/ teletype mode
;

loop:

jmp loop ; Infinite loop

times 510-($-$$) db 0 ;fill the 512 bit sector with 0s
dw 0xaa55 ; Final 2 bit (magic number)
