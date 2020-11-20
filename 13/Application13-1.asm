assume cs:code
data segment
    db 'Welcome to masm!',0
data ends

code segment
    start:
        mov ax,cs
        mov ds,ax
        mov si,offset show_str
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset se - offset show_str
        cld
        rep movsb

        mov ax,0
        mov es,ax
        mov es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0h

        mov dh,10
        mov dl,10
        mov cl,2
        mov ax,data
        mov ds,ax
        mov si,0
        int 7ch

    show_str:
        push si
        push dx
        push cx
        mov di,0
        mov ax,0b800h
        mov es,ax
        mov ax,160
        mul dh
        mov bx,ax
        add dl,dl
        mov dh,0
        add bx,dx
        mov al,cl
    solve:
        mov cl,[si]
        mov ch,0
        jcxz ok
        mov byte ptr es:[bx+di],cl
        mov byte ptr es:[bx+di+1],al
        inc si
        add di,2
        jmp short solve
    ok:
        pop cx
        pop dx
        pop si
        iret
    se:
        nop


code ends
end start