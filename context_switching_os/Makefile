main: main.asm
	
	
	nasm process_a.asm -f bin -o a.out
	nasm process_b.asm -f bin -o b.out
	nasm main.asm -f bin -o out
	qemu-system-x86_64 -fda out
