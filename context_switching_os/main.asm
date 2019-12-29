[bits 16]
[org 0x7c00]
start:
    mov ax,cs
    mov es,ax
    mov bx,disk_end
    mov al,0x1a
    call disk_load
    mov ax,code_start
    call print_hex
    mov ax,0x0
    call load_prg
    
    mov bx,0x1c
    call print_hex
    mov ax,kernel_code
    call print_hex

    call register_interrupt
   
    jmp 0x2000
%include "../print_hex/print_hex.asm"
%include "../disk load/disk_load.asm"
times 0x1fe-($-$$) db 0
dw 0xaa55

disk_end: 
%include "../interrupt/interrupt.asm"

    kernel_code:
    push ax
        mov ax,bx
        call print_hex
 
        and bx,0x01
        xor bx,0x01;toggling first bit of bx
        sti
        call load_prg

        mov ax,bx
        call print_hex
        sti
    pop ax
    iret
;loads program id stored in al to 0x20000
load_prg:
    push ax
    push bx
    push cx
    imul ax,0x400;size of program
    add ax,code_start
    
    mov bx,0x2000
    loop_begin:
        cmp ax,b_end
        je exit_load
        push bx
            mov bx,ax
            mov cx,[es:bx]
        pop bx
        mov [es:bx],cx
        inc bx
        inc ax
        jmp loop_begin
    exit_load:
        pop cx
        pop bx
        pop ax
        ret
times 0x1400-($-disk_end) db 0
code_start:
incbin "a.out"
b_out:
incbin "b.out"
b_end:
