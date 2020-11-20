assume cs:code,ds:data
;存放处理后的要显示的字符
data segment
    db 10 dup(0)
data ends
;逆序存放余数
table segment
    dw 8 dup(0)
table ends
code segment
    start:
        ;给出十进制数
        mov ax,12666
        mov bx,data
        mov ds,bx
        mov bx,table
        mov ss,bx
        mov sp,16
        mov si,0
        call dtoc
        ;打印十进制数对应字符串
        mov dh,8
        mov dl,3
        mov cl,2
        call show_str
    mov ax,4c00h
    int 21h
    dtoc:
        push si             ;保存 si
    dsolve:
        mov dx,0            ;使用divdw需要32位除法，dx保存高位，题目中实际的被除数只有16位
        mov cx,10           ;除数
        call divdw
        mov dx,cx           ;暂存divdw操作后的余数
        mov cx,ax           ;判断商是否为0
        jcxz dtoc_ok
        mov cx,dx           ;不为零，还原余数
        add cx,30h
        push cx             ;将10进制数转化为对应ascii码，并压入栈中
        inc si              ;用以记录栈长度
        jmp short dsolve
    dtoc_ok:
        mov cx,dx           ;此时商为0，需要将最后一个余数转化为ascii
        add cx,30h
        push cx
        inc si
        mov cx,si           ;设置循环次数
        mov si,0            ;设置ds:si指向要写入数据的位置
    s:
        pop ax
        mov [si],ax         ;将栈中输入送入data中
        inc si
        loop s
        pop si              ;还原最早的si值
        ret
    divdw:
        ;高16位与除数运算，取商和余
        ;商*65536+（余数*65536+低16位）/除数
        push ax             ;保存低16位
        mov ax,dx           ;先计算高16位
        mov dx,0
        div cx
        mov bx,ax
        pop ax              ;再计算低16位
        div cx
        mov cx,dx
        mov dx,bx
        ;dx存高16位
        ;ax存低16位
        ;cx存余数
        ret
    show_str:
        ;第 n 行 ：n*160
        ;第 m 列 : m*2,显示字符，m*2+1格式控制
        push si
        push dx
        push cx
        mov di,0            ;记录行偏移量
        mov ax,0b800h
        mov es,ax
        mov ax,160          ;行地址
        mul dh
        mov bx,ax
        add dl,dl           ;列地址
        mov dh,0
        add bx,dx           ;写入的地址
        mov al,cl
    solve:
        mov cl,[si]         ;si记录data偏移量
        mov ch,0
        jcxz solve_ok
        mov byte ptr es:[bx+di],cl      ;写入数值
        mov byte ptr es:[bx+di+1],al    ;写入控制信息
        inc si
        add di,2            ;每次后移两字节
        jmp short solve
    solve_ok:               ;还原
        pop cx
        pop dx
        pop si
        ret
code ends
end start