print_hex:
  pusha ;Save everything
  mov bx, 0 ;Clear bx
  mov ah, 0x0E ;Set teletype mode
  print_hex_loop:
    cmp cx, 0
    jle print_hex_end ;If have have printed the rqeuested ammount stop
    ;Print 2 nibbles per loop
    mov al, '|' ;Make byte bounds
    int 0x10
    ;Put the first (upper) nibble
    mov bl, [si] ;Get the byte to display
    shr bl, 4 ;Shift right 4 (move upper nibble to lower nibble)
    call print_hex_act
    ;Put the second (lower) nibble
    mov bl, [si]
    call print_hex_act
    ;Move si forward for next loop
    add si, 1
    ;Remove 1 from loop counter
    sub cx, 1
    jmp print_hex_loop ;Keep doing it until the code excapes itself
    print_hex_act:
      and bl, 0x0F ;Get just the nibble
      mov al, [numbers_db+bx]
      int 0x10
      ret
  print_hex_end:
    mov al, '|'
    int 0x10
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    popa
    ret

print_ax:
  pusha ;Save everything
  push ax
  mov cl, 3
  ;This will print nibbles out in a wierd order.
  print_ax_loop:
    pop bx
    mov ax, bx
    and bx, 0x000F
    cmp cl,0
    je print_ax_act
    shr ax, 4
    push ax
    print_ax_act:
    add bx, numbers_db
    mov al, [bx]
    mov ah, 0x0E ;Move into teletype code
    int 0x10
    sub cl, 1
    cmp cl, 0
    jge print_ax_loop
  mov ah, 0x0E
  mov al, 10
  int 0x10
  mov al, 13
  int 0x10
  popa ;restore registers
  ret ;return from call

numbers_db: db "0123456789ABCDEF",0
