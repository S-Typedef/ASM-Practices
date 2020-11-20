assume cs:code,ds:data
data segment
    db "Beginner's All-purpose Symbolic Instruction Code.",0
data ends
code segment
    start:
        mov ax,data
        mov ds,ax
        mov si,0
        mov dh,15
        mov dl,5
        mov cx,36
        call show_str
        call letterc
        mov dh,16
        mov dl,5
        mov cx,36
        call show_str
    mov ax,4c00h
    int 21h
    letterc:
        push si
    s2:
        mov cl,[si]
        mov ch,0
        jcxz ok1
        mov al,[si]
        cmp al,97
        jb back
        cmp al,122
        ja back
        and al,11011111B
        mov byte ptr [si],al
    back:
        inc si
        jmp s2
    ok1:
        pop si
        ret
    show_str:
        ;第 n 行 ：n*160
        ;第 m 列 : m*2,显示字符，m*2+1格式控制
        push si
        push dx
        push cx
        mov di,0
        mov si,0
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