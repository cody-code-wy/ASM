;
; Simple boot sector w/ teletype mode
;

mov ah, 0x0e ; tell the bios we want scrolling teletype mode

mov bp, 0x8000 ; Set the stack (just below the our bootsector)
mov sp, bp ; Set the stack pointer to the beginnig of the stack

push 10
push 20
push 30 ; Load some data to run, why not

check: ;needs a label so we can loop
  pop bx ; Get something to check
  cmp bx, 20 ; Check it against 20
  je equal
  jl less
  jg greater

mov al, 'E' ;I dont think this can happen, but anyways...
jmp print

equal:
  mov al, '='
  jmp print

less:
  mov al, '<'
  jmp print

greater:
  mov al, '>'
  jmp print

; Just to prove the way the stack works...
print:
  int 0x10
  cmp sp, bp ; So keep looping until the stack poninter point to the base of the stack
  je loop ; This is what happens when the stack pointer is at the base of the stack
  jg check ; This happens if the pointer is not at the base of the stack

loop:
  jmp $ ; Infinite loop; $ means this line, so this means 'loop to this line'

times 510-($-$$) db 0 ;fill the 512 bit sector with 0s
dw 0xaa55 ; Final 2 bit (magic number)
