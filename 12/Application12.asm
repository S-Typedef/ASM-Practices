assume cs:code
code segment
    start:
        mov ax,cs
        mov ds,ax
        mov si,offset do0
        mov ax,0
        mov es,ax
        mov di,200h

        mov cx,offset do0end - offset do0
        cld
        rep movsb

        mov ax,0
        mov es,ax
        mov word ptr es:[0*4] ,200h
        mov word ptr es:[0*4+2],0

    work:
        mov ax,1000h
        mov bl,1
        div bl

        mov ax,4c00h
        int 21h
    do0:
        jmp short do0start
        db "overflower!",0
    do0start:
        mov ax,cs
        mov ds,ax
        mov si,202h

        mov ax,0b800h
        mov es,ax
        mov di,160*10+36*2
    s1:
        mov cl,[si]
        mov ch,0
        jcxz ok
        mov ch,88
        mov es:[di],cx
        inc si
        add di,2
        jmp s1
    ok:
        mov ax,4c00h
        int 21h
    do0end:
        nop
code ends
end start
