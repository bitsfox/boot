a06.img:a06.bin boot.bin
	dd bs=512 if=a06.bin of=a06.img count=1
	dd bs=512 if=boot.bin of=a06.img seek=1 count=2
	dd bs=512 if=/dev/zero of=a06.img seek=3 count=2877
a06.bin:a06.elf
	objcopy -R .pdr -R .comment -R .note -S -O binary a06.elf a06.bin
boot.bin:boot.elf
	objcopy -R .pdr -R .comment -R .note -S -O binary boot.elf boot.bin
a06.elf:a06.o
	ld -o a06.elf a06.o -Ttext 0
boot.elf:boot.o
	ld -o boot.elf boot.o -Ttext 0
a06.o:a06.s
	as -o a06.o a06.s
boot.o:boot.s
	as -o boot.o boot.s
clean:
	rm *.o *.elf *.bin a06.img
	
