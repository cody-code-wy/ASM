print_string:
  pusha ;Save the registers
  mov ah, 0x0E ;Set teletype mode
  print_string_loop:
    mov al, [si] ;Get next character
    cmp al, 0 ;Check is character is 0
    je print_string_done ;Exit if the character is 0
    int 0x10 ;Print the character out
    add si, 1 ;Move to the next character
    jmp print_string_loop ;Keep going until character is 0
  print_string_done:
    popa ;Put the registers back
    ret ;Return
