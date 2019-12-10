# simple operating system
## Save this code as main.asm
```asm
[bits 16]
[org 0x7c00]
start:
	mov bx,HELLO;moves pointer to HELLO into register bx
	call print_str;jumps to print_str and pushes current location onto stack
	jmp START;jumps back to the beginning
print_str:
	push ax;preserves ax
	push bx;preserves bx
	mov ah, 0x0e ; tty mode
	jmp print_str_int
print_str_int:
	mov al,0;used to check if null terminator
	cmp [bx],al
	je print_str_return;if null terminator return
	mov al,[bx];moves into al inorder to print messag
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
```
## Next compile
	compile with: ```nasm main.asm -f bin -o out```
	finally run in a virtual machine with 
	qemu-system-x86_64 -fda out
	you should then see Hello World printed over and over again

