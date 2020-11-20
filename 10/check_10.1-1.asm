assume cs:code
stack segment
    db dup(0)
stack ends

code segment
    start:
        mov ax,stack
        mov ss,ax
        mov sp,16
        mov ax,0100h
        push ax
        mov ax,0h
        push ax
        retf
    mov ax,4c00h
    int 21h
code ends
end start