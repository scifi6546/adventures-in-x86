[bits 16]
[org 0x7c00]
main:
    mov ax,cs
    mov es,ax;setting disk data to be written to code segment
    mov bx,disk_code_start
    mov al,0x02
    push ax
    ;call print_hex
    pop ax
    call disk_load
    mov bx,cs
    mov ds,bx
    mov bx,0x1c
    interrupt_loop:
    mov ax,print_6;registering to print 6
    call register_interrupt
    ;inc bx
    ;cmp bx,0x80
    ;jl interrupt_loop
    mov ax,print_6
    call print_hex
    ;printing new line
    mov ah,0x0e;tty mode
    mov al,' '
    int 0x10
    int 0x10
    int 0x10
    int 0x10
    int 0x10
    ;call print_5
   
    mov ax,0;setting ax and ds to 0 for debugging
    mov ds,ax
    mov bx,0x80
    ;call print_hex_str
    mov ax,cs
    jmp print_5
;load al sectors from disk dl to buffer at [es:bx]
disk_load:
    mov cx,0x0002;read from cylinder 0x00 and start at sector 0x02
    mov ah,0x02;specifing read
    int 0x13;running interrupt
    ret
;load al sectors from boot drive to [es:bx]
    
%include "../print_hex/print_hex.asm"
;data:
;    dw 0xf00d,0xbabe
;data_end:
;    db 0xc6a9
boot_block_end:
times 510-($-$$) db 0
dw 0xaa55
disk_code_start:
print_5:
call print_hex
loop:
inc ax
cmp ax,0
push bx
    imul bx,10
pop bx
je print_5
jmp loop
ret
print_6:
    sti
    mov ax,0x0e41
    int 0x10
    iret
;registers interrupt number bx to call code at [cs:ax]
;overwrites ax
%include "interrupt.asm"
;times 512-($-disk_code_start) dw 0xFFFF;part on next sector of disk