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
### Basic Operation
cpu's run by grabbing instructions from ram and executing the
instructions. Data can be stored in two places ram and registers.
Ram is a large pool of relativly slow storage. In assembly it 
operates like a large array from C and is indexed with addresses.
The other storage mechanism is registers. Registers are located on
the cpu and are easy and fast to access. 

| Name   | Description               | Size     |
|--------|---------------------------|----------|
| ax     | general purpose register  | 2 Bytes  |
| al     | lower half of ax          | 1 byte   |
| ah     | upper half of ax          | 1 byte   |
| bx     | general purpose register  | 2 bytes  |
| bl     | lower half of bx          | 1 byte   |
| bh     | upper half of bx          | 1 byte   |
| cx     | general purpose register  | 2 bytes  | 
| cl     | lower half of cx          | 1 byte   |
| ch     | upper half of cx          | 1 byte   |
| dx     | general purpose register  | 2 bytes  | 
| dl     | lower half of dx          | 1 byte   |
| dh     | upper half of dx          | 1 byte   |

### Segment Registers
Segment registers are used to access the entirety of memory. More will be described later.

CS Code Segment

DS Data Segment

SS Stack Segment

ES Extra Segment

## Mov
the instruction MOV tells the cpu to move data. It can move data from register to register, memory to register and register to memory.

```mov ax,bx```

this moves the data in register in bx to ax

```mov [ax],bx```

this moves the data in bx to the part of ram pointed to by ax

## Add
This instruction performs an unsigned addition between two registers (or memory)

```add ax,bx```

this adds two numbers together and stores answer in ax

## AND
Performs binary and operation on operands

```and ax,bx```

this stores the result in ax. An example of an and operation is shown
below.

```
        0110 0100  0110 1010
        1010 1010  0111 0101
    AND ----------------------
        0010 0000  0110 0000
```

## OR

Performs binary or between operands and stores result in first operand

```or ax,bx```

this stores the result in ax. An example of an or operation is shown
below.

```
        0110 0100  0110 1010
        1010 1010  0111 0101
    OR ----------------------
        1110 1110  0111 1111
```

## XOR

Performs binary xor between operands and stores result in first operand

```xor ax,bx```

this stores the result in ax. An example of an xor operation is shown
below.

```
        0110 0100  0110 1010
        1010 1010  0111 0101
    XOR ----------------------
        1100 1110  0001 1111
```


## JMP

Moves the specified value into IP. is used to execute different parts of 
code. For example the following example is an infinite loop
```asm
loop_begin:
    mov ax,5
    jmp loop_begin
```

## Stack
The stack is a first in first out data structure that is commonly
used to store information relating to the call stack such as temporary
variables. The top of the stack is pointed to by the stack pointer 
(register SP). Data is pushed onto the stack with the operation 
```push```. PUSH increments SP and moves the operand to the location
pointed to by SP. data is accessed by ```POP```. POP decrements SP and
returns data pointed to by SP

## Call
Call uses the stack to make it easy to call procedures and return back to the original procedure. The call prodedure pushes IP+1 onto the stack
and jumps to the operand.

## Ret
Ret pops IP off of the stack. It is used to return from a procedure. An 
example is shown below.

```asm
main_proc:
mov ax,5
call side_task;go to side task
jmp main_proc
side_task:
ret
```

## Memory Operations

In real mode x86 a single register can not index the full 1 MB of address
space. Inorder to access memory two registers are used for indexing.
The accessed index is calculated with the following formula.

```
address=OFFSET<<4+register
```
The offset register can be ES,DS,SS,and CS.
inorder to set the offset registers the value has to be moved first into
a general purpose register.
```asm
;this sets es to 0x10
mov ax,0x10
mov es,ax
```
## Interrupts

Interrupts are events than can be triggerd by hardware or software using
the ```int``` instruction. The address of the executed code is stored in the Interrupt vector table.
The interrupt vector table is in the first 1024 bytes of ram. Each address is a 32 bit address.
here is a program to write address 0x11200 to interrupt 0 (system timer)

``` asm
;move 0 into the data segment
mov ax,0
mov ds,ax
;address to write to
mov bx,0
;getting addresses set up
mov ax,0x1200
mov [bx],ax
;writting to high bit
inc bx
mov ax,0x1
mov [bx],ax
```
