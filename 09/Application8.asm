assume cs:code
code segment
    mov ax,4c00h
    int 21h
    start:
        mov ax,0            ;3
    s:
        nop                 ;1
        nop                 ;1
        mov di,offset s     ;3
        mov si,offset s2    ;3
        mov ax,cs:[si]      ;3
        mov cs:[di],ax      ;3
    s0:
        jmp short s
    s1:
        mov ax,0
        int 21h
        mov ax,0
    s2:
        jmp short s1
        nop
code ends
end start