# What is This
This documents my adventures in real mode x86. It (will) contain 
documentation about x86 gathered from many different sources.
## Starter Tutorial
We will learn about real mode x86 by building a simple operating system.
This is done inorder to remove complexity due to running an existing 
complicated OS. 
First copy this simple 'hello a' program and save it as hello_a.asm
```asm
[bits 16]
[org 0x7c00]
mov ah,0x0e;tty mode
mov al,'a';write a
int 0x10;write 'a'
jmp $;hang forever

times 510-($-$$) db 0;set code required for bios to boot disk
dw 0xaa55
```
next compile the code with 

```nasm hello_a.asm -f bin -o out```

finally run the code in a VM with

```qemu-system-x86_64 -fda out```
### 
cpu's run by grabbing instructions from ram and executing the
instructions. Data can be stored in two places ram and registers.
Ram is a large pool of relativly slow storage. In assembly it 
operates like a large array from C and is indexed with addresses.
The other storage mechanism is registers. Registers are located on
the cpu and are easy and fast to access. 

| Name   | Description               |
|--------|---------------------------|
| ax     | general purpose register  |
| al     | lower half of ax          |
| ah     | upper half of ax          |
| bx     | general purpose register  |
| bl     | lower half of bx          |
| bh     | upper half of bx          |
### 
## Mov
the instruction MOV tells the cpu to move data. It can move data from register to register, memory to register and register to memory.

```mov ax,bx```

this moves the data in register in bx to ax

```mov [ax],bx```

this moves the data in bx to the part of ram pointed to by ax

