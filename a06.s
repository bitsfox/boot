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
2:		jmp $bootseg,$0
msg:	.ascii "begin real mode..."
len=.-msg
.org 510
.word 0xaa55

