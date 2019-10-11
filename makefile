IMGP = bin/boot.bin

all: disk.img

run: disk.img
	@qemu-system-i386 -hda disk.img

clean:
	@rm -rf bin disk.img 2>/dev/null | true

bin:
	@mkdir -p bin

bin/boot.bin: boot.asm | bin
	@nasm -f bin boot.asm -o bin/boot.bin

disk.img: $(IMGP)
	@cat $(IMGP) >disk.img
