assume cs:code,ds:data,ss:stack

data segment
    db 'ibm                '
    db 'dec                '
    db 'dos                '
    db 'vax                '
data ends

stack segment
    dw 0,0,0,0,0,0,0,0
stack ends

code segment
    start:
        mov ax,stack
        mov ss,ax
        mov sp,10h
        mov ax,data
        mov ds,ax
        mov bx,0
        mov cx,4
    s0:
        push cx
        mov si,0
        mov cs,3
    s1:
        mov al,[bx+si]
        and a,11011111b
        mov [bx+si],al
        inc si
        loop s1
        add bx,10h
        pop cx
        loop s0

    mov ax,4c00h
    int 21h
code ends
end start