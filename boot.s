#.code16
.text
.org 0
#	mov %cs,%ax
		movl $0x10,%eax
		movw %ax,%ds
		movl $0x18,%ax
		movw %ax,%es
		mov $160,%ax
		movl %eax,%edi
		movl $msg,%eax
		movl %eax,%esi
		mov $0x0d,%ah
		movl $len,%ecx
1:		lodsb
		stosw
		loop 1b
		jmp .
msg:	.ascii "jump boot now~ begin protected mode"
len=.-msg
/*
gdt:
		.word 0,0,0,0
		.word 0x7ff,0,0x9a01,0xc0	#text seg  0x8
		.word 0x7ff,0,0x9201,0xc0	#data seg  0x10
		.word 0x7ff,0x8000,0x920b,0xc0	#display seg 0x18
idt_load:
		.word 0,0,0
gdt_load:
		.word 0x7ff
		.
		*/
.org   1022
.word  0

