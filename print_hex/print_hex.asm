;prints hex in ax all registers preserved
print_hex:
push ax
    mov al,ah;moving upper 8 bits of ax into lower 8 bits
    call print_al;printing lower 8 bits
pop ax
push ax
    call print_al;printing lower 8 bits
    mov ah,0x0e;tty mode
    mov al,' ';printt new line
    int 0x10;print to tty
pop ax
ret



print_al:
    mov ah,0x0e;tty mode
    ;printing upper 4 bytes
    push ax
        shr al,4;shifting down
        call print_4_bits
    pop ax
    push ax
        and al,0x0F;getting lower 4 bits
        call print_4_bits
    pop ax
    ret
    print_4_bits:
        
        cmp al,0x9
        jg print_high
        add al,0x30
        
        int 0x10;print to screen
        ret
        print_high:
            add al,55
            int 0x10
            ret
;prints hex_str at ds:ax until reaches bx
print_hex_str:
    cmp ax,bx
    je exit
    push ax
    push bx
        mov bx,ax
        mov ax,[bx]
        call print_hex
    pop bx
    pop ax
    add ax,2
    ;printing space
    jmp print_hex_str

exit:
    ret

