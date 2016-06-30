print_hex:
  pusha ;Save everything
  mov ah, 0x0E ;Ste teletype mode
  print_hex_loop:
    cmp cx, 0
    jle print_hex_end ;If have have printed the rqeuested ammount stop
    sub cx, 1
    ;Print 2 nibbles per loop
    mov al, '|' ;Make byte bounds
    int 0x10
    ;Put the first (upper) nibble
    mov bl, [si] ;Get the byte to display
    mov bh, 0 ;Clear the upper byte of dx before saving it
    push bx ;Copy for upper nibble
    shr bl, 4 ;Shirf right 4 (move upper nibble to lower nibble)
    and bl, 0x0F ;Get the first nibble
    mov al, [numbers_db+bx];Get the character that corisponds with the nibble's value
    int 0x10
    ;Put the second (lower) nibble
    pop bx ;Get the copy we saved earlier
    and bl, 0x0F ;Get just the nibble
    mov al, [numbers_db+bx]
    int 0x10
    ;Move si forward for next loop
    add si, 1
    jmp print_hex_loop ;Keep doing it until the code excapes itself
  print_hex_end:
    mov al, '|'
    int 0x10
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    popa
    ret

print_dx:
  pusha ;Save everything
  mov ah, 0x0E ;Move into teletype code
  push dx ;save DX for the upper byte
  mov dl, dh ;copy upper byte to lower byte
  shr dh, 4 ;Shift upper byte right (move upper nibble to lower)
  and dh, 0x0F ;Get lower nibble
  and dl, 0x0F ;Get lower nibble
  push dx ;Save dx for lower nibble
  mov dl, dh ;move upper nibble to lower
  mov dh, 0 ;remove upper byte
  mov bx, dx ;move into bx (to actually use offset)
  mov al, [numbers_db+bx] ;Get hex code for that
  int 0x10 ;Print
  pop dx ;Pop dx for lower nibble
  mov dh, 0 ;remove upper nibble
  mov bx, dx ;move into bx (to actually use offset)
  mov al, [numbers_db+bx] ;Get hex code for lower nibble
  int 0x10 ;Print
  pop dx ;Pop dx for upper byte
  mov dh, dl ;Copy lower byte to upper byte
  shr dh, 4 ;Shift upper byte right (move upper nibble to lower)
  and dh, 0x0F ;Get lower nibble
  and dl, 0x0F ;Get lower nibble
  push dx ;Push dx for lower nibble
  mov dl, dh ;move upper byte to lower byte
  mov dh, 0 ;remove upper byte
  mov bx, dx ;Move inte bx (to use offset)
  mov al, [numbers_db+bx] ;Get hex code for lower nibble
  int 0x10 ;Print
  pop dx ;Pop dx for lower nibble
  mov dh, 0 ;Remove upper byte
  mov bx, dx ;Move into bx (to use offset)
  mov al, [numbers_db+bx] ;Get hex code for lower nibble
  int 0x10 ;Print
  mov al, 13 ;CR
  int 0x10 ;Print
  mov al, 10 ;NL
  int 0x10 ;Print
  popa ;restore registers
  ret ;return from call



;old_print_hex:
;  pusha ;Save the registers
;  mov ah, 0x0E ;Set teletype mode
;  old_print_hex_loop:
;    ;Print 2 nibbles per loop
;    mov al, '|' ;Make byte bounds
;    int 0x10
;    mov dl, [si] ;Copy for lower nibble
;    cmp dl, 0
;    je old_print_hex_exit
;    mov dh, dl ;Copy for upper nibble
;    and dl, 0x0F ;Filter out lower nibble
;    shr dh, 4
;    and dh, 0x0F ;Filter out upper nibble
;    mov bx, numbers_db
;    mov al, dh ;save it for now
;    mov dh, 0
;    add bx, dx
;    mov dh, al ;restore
;    mov al, [bx]
;    int 0x10
;    mov bx, numbers_db
;    mov dl, dh ;Make it usable
;    mov dh, 0
;    add bx, dx
;    mov al, [bx]
;    int 0x10
;  old_print_hex_exit:
;    mov al, '|'
;    int 0x10
;    mov al, 13
;    int 0x10
;    mov al, 10
;    int 0x10
;    popa
;    ret

numbers_db: db "0123456789ABCDEF",0
