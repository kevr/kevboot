bits 16 ; 16-bit assembly
org 0x7c00 ; start at 0x7c00, where boot sector is read from

boot:
	mov si,hello ; pointer si register to hello label memory location
	mov ah,0x0e ; 0x0e means "Write Character in TTY mode"

.loop:
	lodsb
	or al,al ; is al == 0 ?
	jz halt ; if (al == 0) jump to halt label
	int 0x10 ; run BIOS interrupt 0x10 (video services)
	jmp .loop

halt:
	cli ; clear interrupt flag
	hlt ; halt execution

hello: db "Hello World!",0

times 510 - ($ - $$) db 0 ; pad remaining 510 bytes with zeroes (start + 16 bits, or 2 bytes)

dw 0xaa55 ; magic bootloader - marks this 512 byte sector bootable

