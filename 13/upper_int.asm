assume cs:code
data segment
    db 'conversation',0
data ends
code segment
    start:
        mov ax,cs
        mov ds,ax
        mov si,offset upper
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset upperend - offset upper
        cld
        rep movsb

        mov ax,0
        mov es,ax
        mov es:[7ch*4],200h
        mov es:[7ch*4+2],0

        mov ax,4c00h
        int 21h
    upper:
        push cx
        push si
    change:
        mov cl,[si]
        mov ch,0
        jcxz ok
        and byte ptr [si],11011111b
        inc si
        jmp short change
    ok:
        pop si
        pop cx
        iret

code ends
end start