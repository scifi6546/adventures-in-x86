[bits 16]
[org 0x7c00]
start:
	mov bx,HELLO
	call init
	mov cx,0
	mov dx,0
	mov si,0x26
	loop:
		push ax
			mov ax,0xB000;writing to data segment
			mov ds,ax;writing to data segment
		pop ax
		and bx,0x01
		cmp bx,0
		je print_a
		cmp si,0x28
		je loop_forever
		print_A:
			mov ax,'A'
			mov [si],ax;writing to memory
			jmp loop_end
		print_a:
			mov ax,'a'
			mov [si],ax;writing to memory

		;inc al;setting color
		loop_end:
			mov [si],ax;writing to memory
			inc si
			inc bx
			jmp loop
	loop_forever:
		jmp loop_forever
init:
	;set mode to ega
	mov ah,0;set mode
	mov al,0x3;color text
	int 0x10;set video mode
	;set video page
	;mov ah,0x5;select display page
	;mov al,0x0;page 0 selected
	;int 0x10;call bios
	ret;
;params: cx: collumn
;        dx: row
HELLO:
	db "Hello World",0
times 510-($-$$) db 0
dw 0xaa55
