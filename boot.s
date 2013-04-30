.code16
.text
.org 0
		mov %cs,%ax
		mov %ax,%ds
		mov $0xb800,%ax
		mov %ax,%es
		mov $160,%ax
		mov %ax,%di
		mov $msg,%ax
		mov %ax,%si
		mov $0x0d,%ah
		mov $len,%cx
1:		lodsb
		stosw
		loop 1b
		jmp .
msg:	.ascii "jump boot now..."
len=.-msg
.org   1022
.word  0

