assume cs:code
stack1 segment
    db 128 dup(0)
stack1 ends
code segment
    start:
        mov ax,stack1
        mov ss,ax
        mov sp,128

        push cs
        pop ds

        mov ax,0
        mov es,ax

        mov si,offset int9
        mov di,201h
        mov cx,offset int9end-offset int9
        cld
        rep movsb

        ;----保存原int9例程----
        push es:[9*4]
        pop es:[200h]
        push es:[9*4+2]
        pop es:[202h]
        ;安装新int9中断例程
        cli
        mov word ptr es:[9*4],204h
        mov word ptr es:[9*4+2],0
        sti
        mov ax,4c00h
        int 21h

    int9:
        push ax
        push bx
        push cx
        push es

        in al,60h

        pushf
        call dword ptr cs:[200h]

        cmp al,9eh
        jne int9ret

        mov ax,0b800h
        mov es,ax
        mov bx,0
        mov cx,2000
    s:
        mov byte ptr es:[bx],' '
        add bx,2
        loop s
    int9ret:
        pop es
        pop cx
        pop bx
        pop ax
        iret
    int9end:
        nop
code ends
end start