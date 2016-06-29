;
; Simple boot sector w/ teletype mode
;


mov bp, 0x8000 ; Set the stack (just below the our bootsector)
mov sp, bp ; Set the stack pointer to the beginnig of the stack

push 10
push 20
push 30 ; Load some data to run, why not

check: ;needs a label so we can loop
  pop bx ; Get something to check
  cmp bx, 20 ; Check it against 20
  je check_equal
  jl check_less
  jg check_greater

jmp check_end ; No print needed, we can just go to the end for unmatched things

check_equal:
  mov al, '='
  call print ; Call print, this allows us to return
  jmp check_end

check_less:
  mov al, '<'
  call print
  jmp check_end

check_greater:
  mov al, '>'
  call print
  jmp check_end

check_end: ; We need an end now, so our loop code does not go in the print function
  cmp sp, bp
  je loop ; When we poped everytihng go and loop forever.
  jne check

print:
  pusha ;Save all registers, now we can do anything we want!
  mov ah, 0x0e ; tell the bios we want scrolling teletype mode
  int 0x10
  popa ;Pull all registers back.
  ret ;Return to where this was called

loop:
  jmp $ ; Infinite loop; $ means this line, so this means 'loop to this line'

times 510-($-$$) db 0 ;fill the 512 bit sector with 0s
dw 0xaa55 ; Final 2 bit (magic number)
