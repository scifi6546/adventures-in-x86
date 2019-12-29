;load al sectors from boot drive to [es:bx]
disk_load:
    mov cx,0x0002;read from cylinder 0x00 and start at sector 0x02
    mov ah,0x02;specifing read
    int 0x13;running interrupt
    ret
