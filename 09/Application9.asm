assume cs:code,ds:data
data segment
    db 'welcome to masm!'
data ends
code segment
    start:
        mov ax,data
        mov ds,ax
        mov ax,0b800h
        mov es,ax

    mov cx,16
    mov bx,84h
    mov si,600h
    mov di,0
    s1:

        mov al,[di]
        mov byte ptr es:[si+0a0h+bx],al
        inc bx
        inc di
        mov byte ptr es:[si+0a0h+bx],20h
        inc si
        loop s1

    mov cx,16
    mov bx,84h
    mov si,06a0h
    mov di,0
    s2:
        mov al,[di]
        mov byte ptr es:[si+0a0h][bx],al
        inc bx
        inc di
        mov byte ptr es:[si+0a0h][bx],024h
        inc si
        loop s2

    mov cx,16
    mov bx,84h
    mov si,0740h
    mov di,0
    s3:
        mov al,[di]
        mov byte ptr es:[si+0a0h][bx],al
        inc bx
        inc di
        mov byte ptr es:[si+0a0h][bx],071h
        inc si
        loop s3

    mov ax,4c00h
    int 21h
code ends
end start