;int外部中断实现loop循环
;按照偏移量访问栈空间
;将栈内偏移加上程序块偏移
;得到将要执行的下一条指令位置

assume cs:code
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
        mov di,160*12
        mov bx,offset s- offset se
        mov cx,80
    s:
        mov byte ptr es:[di],'!'
        mov byte ptr es:[di+1],22
        add di,2
        int 7ch
    se:
        nop
        mov ax,4c00h
        int 21h
    lp:
        push bp
        mov bp,sp
        dec cx
        jcxz lpret
        add [bp+2],bx           ;bp段地址默认ss
    lpret:
        pop bp
        iret
    lpend:
        nop
code ends
end start