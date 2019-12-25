[bits 16]
[org 0x7c00]
start:
	mov bx,HELLO
	call init
	mov cx,0
	mov dx,0
	mov si,0
	loop:
		mov ax,0xA000;writing to data segment
		mov ds,ax;writing to data segment
		mov al,0x5;setting color
		mov [si],al;writing to memory
		inc si
		;call wrt_pixel
		;cmp cx,0x10;checking if at edge of screen
		;inc cx;increment collumn
		;je add;start new row
		jmp loop
		add:
			mov cx,0
			inc dx
			jmp loop
init:
	;set mode to ega
	mov ah,0;set mode
	mov al,0xe;ega
	int 0x10;set video mode
	;set video page
	mov ah,0x5;select display page
	mov al,0x0;page 0 selected
	int 0x10;call bios
	ret;
;params: cx: collumn
;        dx: row
wrt_pixel:

	;write pixel
	mov ah,0xc;set write vram
	mov al,1;pixel color
	push bx
	mov bh,0;video page
	;mov cx,10;collumn
	;mov dx,10;row
	int 0x10;system interrupt
	pop bx
	ret;
HELLO:
	db "Hello World",0
times 510-($-$$) db 0
dw 0xaa55
