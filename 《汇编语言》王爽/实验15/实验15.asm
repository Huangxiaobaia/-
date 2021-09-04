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

		push cs
		pop ds
		
		mov ax,0
		mov es,ax

		mov si,offset int9	;ds:siָ��Դ��ַ
		mov di,204H		;es:diָ��Ŀ�ĵ�ַ
		mov cx,offset int9end-offset int9 ;cxΪ���䳤��

		cld
		rep movsb

		push es:[9*4]	;����ԭint9�жϴ��������ڵ�ַ
		pop es:[200H]
		push es:[9*4+2]
		pop es:[202H]

			
		cli
		mov word ptr es:[9*4],204H
		mov word ptr es:[9*4+2],0
		sti
		
		mov ax,4C00H
		int 21H

int9:		push ax
		push bx
		push es
		push cx
		in al,60H
		
		pushf
		call dword ptr cs:[200H]

		cmp al,9EH
		jne int9ret
		
		mov ax,0B800H
		mov es,ax
		mov bx,0
		mov cx,2000
		mov al,'A'
s:		mov es:[bx],al
	;	inc byte ptr es:[bx]  ;�ı���Ļ��ɫ����bx��Ϊ1,9EH��Ϊ3bH(F1)
		add bx,2
		loop s
	
int9ret:	pop cx
		pop es
		pop bx
		pop ax
		iret
int9end:	nop


	
code ends

end	start
