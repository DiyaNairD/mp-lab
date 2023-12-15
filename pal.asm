data segment
	msg1 db 0ah,0dh,"Enter the string:$"
	msg2 db 0ah,0dh,"Is a palindrome$"
	msg3 db 0ah,0dh,"Not a palindrome$"
	n db 09h dup(?)
data ends
code segment
	assume cs:code,ds:data
	start : mov ax,data
		mov ds,ax
		
		;getting offset of an array
		mov si,offset n
		mov di,offset n
	
		;printing message 1
		lea dx,msg1
		mov ah,09h
		int 21h
		
		mov cl,00h

		;reading string
	scan :  mov ah,01h
		int 21h
		
		cmp al,0dh
	        jz ended

		mov [si],al
		inc cl
		inc si
		jmp scan
	
       ended : dec si
               mov bl,[si]
              
	        cmp [di],bl
               jnz notpal
               inc di
               dec cl
               jnz ended

	pal:    ;printing palindrome
		lea dx,msg2
		mov ah,09h
		int 21h
		jmp stopped
	
	notpal: ;printing not palindrome
		lea dx,msg3
		mov ah,09h
		int 21h
		    
	stopped: mov ah,4ch
		 int 21h

code ends
end start