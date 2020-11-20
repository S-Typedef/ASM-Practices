;int外部中断实现loop循环
;按照偏移量访问栈空间
;将栈内偏移加上程序块偏移
;得到将要执行的下一条指令位置

assume cs:code
data segment
    db 'conversation',0
data ends

code segment
    start:
        mov ax,cs
        mov ds,ax
        mov si,offset lp
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset lpend - offset lp
        cld
        rep movsb

        mov ax,0
        mov es,ax
        mov es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0h

        mov ax,0b800h
        mov es,ax
        mov di,160*12+32*2
        mov ax,data
        mov ds,ax
        mov si,0
    s:
        cmp byte ptr [si],0
        je se
        mov al,[si]
        mov byte ptr es:[di],al
        mov byte ptr es:[di+1],22
        add di,2
        inc si
        mov bx,offset s- offset se
        int 7ch
    se:
        nop
        mov ax,4c00h
        int 21h
    lp:
        push bp
        mov bp,sp
        add [bp+2],bx
    lpret:
        pop bp
        iret
    lpend:
        nop
code ends
end start