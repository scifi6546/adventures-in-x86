;registers data pointed to by ax at interrupt number bx
register_interrupt:
    cli
    imul bx,0x4;getting address for interrupt

    push es;pushing extra segment onto stack
        push ax
            mov ax,0;moving 0 into ex
            mov es,ax
        pop ax
        push cx
            mov cx,cs
            ;shifting to left by 4 to add offset to ax
            shl cx,0x4
            add cx,ax
            jc add_1
            mov [es:bx+2],cs
            mov [es:bx],ax
            jmp commit_interrupt
            add_1:;if carry add 1 to interrupt
                push ax
                    mov ax,cs
                    inc ax
                    mov [es:bx+2],ax
                pop ax
                mov [es:bx],ax

            commit_interrupt:
            

        pop cx
    pop es
    sti
    ret