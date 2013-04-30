.code16
.text
orgseg=0x7c0
bootseg=0x1000
dispseg=0xb800
		jmp $orgseg,$go
go:		mov %cs,%ax
		mov %ax,%ds
		mov $dispseg,%ax
		mov %ax,%es
		mov $msg,%ax
		mov %ax,%si
		xor %di,%di
		mov $0x0c,%ah
		mov $len,%cx
1:		lodsb
		stosw
		loop 1b
		mov $0,%dx
		mov $2,%cx
		mov $bootseg,%bx
		mov %bx,%es
		xor %bx,%bx
		mov $0x200,%ax
		add $2,%ax	#read 2 sectors
		int $0x13
		jnc 2f
		jmp .
#2:		jmp $bootseg,$0
2:		mov %cs,%ax
		mov %ax,%ds
		mov %ax,%es
		lidt idt_load
		lgdt gdt_load
		cli
		mov $0x1,%ax
		lmsw %ax
		jmp $8,$0
gdt:
		.word 0,0,0,0
		.word 0x7ff,0,0x9a01,0xc0	#text seg  0x8
		.word 0x7ff,0,0x9201,0xc0	#data seg  0x10
		.word 0x7ff,0x8000,0x920b,0xc0	#display seg 0x18
idt_load:
		.word 0,0,0
gdt_load:
		.word 0x7ff
		.word gdt+0x7c00,0
msg:	.ascii "begin real mode..."
len=.-msg
.org 510
.word 0xaa55

