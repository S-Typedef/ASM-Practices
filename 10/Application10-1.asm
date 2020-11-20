assume cs:code,ds:data
data segment
    db "I'm so vegetable",0
data ends
code segment
    start:
        ;dh 表示行号
        ;dl 表示列号
        ;cl 表示颜色
        ;ds:si 指向字符串首地址
        mov dh,15
        mov dl,32
        mov cl,36
        mov ax,data
        mov ds,ax
        mov si,0
        call show_str
    mov ax,4c00h
    int 21h
    show_str:
        ;第 n 行 ：n*160
        ;第 m 列 : m*2,显示字符，m*2+1格式控制
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
        ret
code ends
end start