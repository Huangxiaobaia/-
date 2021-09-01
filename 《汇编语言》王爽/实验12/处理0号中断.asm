assume cs:code,ss:stack
	;	

stack segment stack
	db	128 dup(0)
stack ends
	

code segment

start:	
		mov ax,stack
		mov ss,ax
		mov sp,128
		
		mov ax,cs
		mov ds,ax
		mov si,offset do0

		mov ax,0
		mov es,ax
		mov di,200H

		mov cx,offset do0end-offset do0

		cld
		rep movsb

		;设置中断向量表		
		mov ax,0
		mov es,ax
		mov word ptr es:[0*4],200H
		mov word ptr es:[0*4+2],0

		mov ax,1000H
		mov bh,1
		div bh
		

		mov ax,4C00H
		int 21H	

do0:		jmp short do0start
		db "overflow!"

do0start:	mov ax,cs
		mov ds,ax
		mov si,202H
		
		mov ax,0b800H
		mov es,ax
		mov di,12*160+36*2

		mov cx,9
s:		mov al,ds:[si]
		mov es:[di],al
		inc si
		add di,2
		loop s
		
		mov ax,4c00H
		int 21H
do0end:nop
		


	
	
code ends

end	start
