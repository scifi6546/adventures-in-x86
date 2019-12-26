[bits 16]
[org 0x7c00]
main:
    ;mov ax,0x2121
    ;call print_hex
    mov ax,data
    mov bx,data_end
    call print_hex_str

    mov ax,data
    mov bx,data_end
    call print_hex_str
    jmp $

    
%include "../print_hex/print_hex.asm"
data:
    dw 0xf00d,0xbabe,0x1010
data_end:
    db 0xc6a9
times 510-($-$$) db 0
dw 0xaa55
times 256 dw 0xFFFF;part on next sector of disk