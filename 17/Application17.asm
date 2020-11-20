

;!!!!!!!!!!!!!!!
;
;禁止在主机运行
;务必拷贝至虚拟机试运行
;
;!!!!!!!!!!!!!!!

assume cs:code
code segment

    int7ch:
        push ax
        push bx
        mov ax,dx   ;dx存放逻辑扇区号
        mov dx,0
        mov cx,1440
        div cx
        ;此时dx,存余数，ax存商
        push ax ;商，存放面号,应该是al
        mov ax,dx;把余数给ax
        mov dx,0
        mov cx,18
        div cx
        inc dx
        mov ch,al   ;磁道号
        mov cl,dl

        pop dx  ;dl为面号
        mov dh,dl
        mov dl,0
        ;ch磁道号就位
        ;cl扇区号就位
        ;dl驱动器号就位
        ;dh磁头号就位
        ;例程2读 3写
        ;传参0读 1写
        mov bp,sp
        mov ax,ss:[bp+2]
        add ah,2
        int 13h

        pop bx
        pop ax
        iret
    int7che:
        nop
    start:
        mov ax,cs
        mov ds,ax
        mov si,offset int7ch
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset int7che-offset int7ch
        cld
        rep movsb

        mov ax,0
        mov es,ax
        mov es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0h

        mov ax,0b800h
        mov es,ax
        mov bx,0
        mov ah,1
        mov al,10
        mov dx,35
        int 7ch

    mov ax,4c00h
    int 21h
code ends
end start