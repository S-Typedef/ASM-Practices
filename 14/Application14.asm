assume cs:code
data segment
    db '/// ::'
data ends
code segment
    start:
        mov si,0
        mov di,0

        mov cx,3
        s1:
            push cx
            add cx,6
            mov al,cl
            call time
            call show_str
            call show_split
            pop cx
            loop s1
        call show_split
        mov cx,3
        mov ax,1
        s2:
            push cx
            add cx,ax
            sub ax,1
            push ax
            mov al,cl
            call time
            call show_str
            call show_split
            pop ax
            pop cx
            loop s2

        mov ax,4c00h
        int 21h
    time:
        out 70h,al
        in al,71h

        mov ah,al
        mov cl,4
        shr ah,cl
        and al,00001111b
        add ah,30h
        add al,30h
        ret
    show_str:
        mov bx,0b800h
        mov es,bx
        mov bx,0
        mov byte ptr es:[160*12+40*2+si],ah
        mov byte ptr es:[160*12+40*2+1+si],4
        mov byte ptr es:[160*12+40*2+2+si],al
        mov byte ptr es:[160*12+40*2+3+si],4
        add si,4
        ret
    show_split:
        mov ax,data
        mov ds,ax
        mov bx,0b800h
        mov es,bx
        mov bx,si
        mov byte ptr al,[di]
        mov byte ptr es:[160*12+40*2+bx],al
        mov byte ptr es:[160*12+40*2+1+bx],2
        inc di
        add si,2
        ret
code ends
end start