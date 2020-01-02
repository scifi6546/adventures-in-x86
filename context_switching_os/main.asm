[bits 16]
[org 0x7c00]
start:
    mov ax,cs
    mov es,ax
    mov bx,disk_end
 
    mov al,0x1c
    call disk_load
    mov ax,code_start
    mov ax,0x0
    call load_prg
    mov bx,0x1c
    
    mov ax,kernel_code
    call print_hex
    call register_interrupt
    
    mov ax,0x0
    mov ds,ax
    mov ax,0x2000
    mov bx,0x2100
   ; call print_hex_str
    
;
   initilize_kernel:
       ;pushes 0 to bx
       ;saving top of kernel stack
       mov [0x5801],word 0x1000
       mov sp,0x1000
       push bx
       mov sp,0x2400
    jmp 0x2000;jump to client code
%include "../print_hex/print_hex.asm"
%include "../disk load/disk_load.asm"
times 0x1fe-($-$$) db 0
dw 0xaa55

disk_end: 
%include "../interrupt/interrupt.asm"
kernel_code:
    ;call print_hex
    ;sti 
    ;iret
    sti
    ;call print_hex
    mov cx,sp;saving program stack
    mov sp,[0x5801]
    ;pop bx
    push ax

        ;picking random point in memory for now 0xa000
        mov bx:0xa000
        mov ax,[es:bx]
        call print_hex
        xor ax,0x01;toggling first bit of bx
        and ax,0x01
        mov [es:bx],ax
        
        ;sti
        

       ; mov ax,bx
        ;call print_hex
        call load_prg
        ;call print_hex
        ;sti
    pop ax
    ;push bx
    mov sp,cx
    iret
;loads program id stored in al to 0x2000
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
