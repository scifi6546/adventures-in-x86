# 16 bit Intel
16 bit intel assembly can address a full 1MB of ram. the problem is that a 16 bit register
can only address 64k of ram. Therefore two integers are used
## Registers
### General Purpose
AX
BX
CX
DX

### Segment Registers
CS Code Segment

DS Data Segment

SS Stack Segment

ES Extra Segment

### Writing to memory example
```asm
mov ax,0xA000 ;writing to general purpose register ax
mov ds,ax ; writng address 0xA000 to data segment register
mov si,0x1 ; writing address
mov [si],0x5 ;writing 0x5 to ds<<8+si (0xA0005)
```
# Memory Map

|  Address  | Description            |
|-----------|------------------------|
| 0x00000   | Interupt Vector Table  |
| 0xA0000   | Video Graphics Buffer  |
| 0xB0000   | MDA Text Buffer        |
| 0xB8000   | Color Text Buffer      |
| 0xC0000   | Reserved               |
| 0xF0000   | ROM BIOS               |
