[bits 16]
[org 0x7c00]
start:
	mov bx,HELLO
	call print_str
	jmp start
print_str:
	push ax
	push bx
	mov ah, 0x0e ; tty mode
	jmp print_str_int
print_str_int:
	mov al,0
	cmp [bx],al
	je print_str_return
	mov al,[bx]
	int 0x10;prints message
	inc bx
	jmp print_str_int
print_str_return:
	pop bx
	pop ax
	ret

HELLO:
	db "Hello World",0
times 510-($-$$) db 0
dw 0xaa55
