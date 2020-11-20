;博客园：https://www.cnblogs.com/nojacky/p/9523904.html
assume cs:code,ds:data
data segment
    dw 8 dup(0)
data ends
code segment
    start:
        ;ax存放被除数低16位
        ;dx存放被除数高16位
        ;cx存放除数
        mov ax,data
        mov ss,ax
        mov sp,16
        mov ax,4240h
        mov dx,00fh
        mov cx,0ah
        call divdw
    mov ax,4c00h
    int 21h
    divdw:
        ;先计算高16位再计算低16位
        push ax
        mov ax,dx
        mov dx,0
        div cx
        mov bx,ax
        pop ax
        div cx
        mov cx,dx
        mov dx,bx
        ret
code ends
end start
