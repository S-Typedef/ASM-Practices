assume cs:code
code segment
    mov ax,cs       ;3
    mov ds,ax       ;2
    mov ax,0020h    ;3
    mov es,ax       ;2
    mov bx,0        ;3
    mov cx,24       ;3
s:
    mov al,[bx]     ;2+1
    mov es:[bx],al  ;2
    inc bx          ;1
    loop s          ;2
mov ax,4c00h
int 21h
code ends
end