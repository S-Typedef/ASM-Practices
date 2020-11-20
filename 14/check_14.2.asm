assume cs:code
code segment
    start:
        mov ax,2
        mov bx,ax
        mov cl,2
        shl ax,cl
        mov cl,8
        mov bx,cl
        add ax,bx
code ends
end start