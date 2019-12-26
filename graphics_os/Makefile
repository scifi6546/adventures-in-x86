main: main.asm
	nasm main.asm -f bin -o out
	qemu-system-x86_64 -fda out
new: new.asm
	nasm new.asm -f bin -o out
	qemu-system-x86_64 -fda out
text: new_text_mode.asm
	nasm new_text_mode.asm -f bin -o out
	qemu-system-x86_64 -fda out