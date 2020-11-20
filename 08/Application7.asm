assume cs:code,ds:data
data segment
    ;00-53h
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'
    ;年份
    ;21*4 = 84 = 54h
    ;54h-a7h
    dd 16,22,382,1356,2390,80000,16000,24486,50065,97479,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    ;21年每年总收入
    ;21*4 = 84 = 54h
    ;a8h-eah
    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800
    ;雇员人数
data ends
table segment
    db 21 dup('year summ ne ?? ')
table ends
code segment
    start:
        mov ax,data
        mov ds,ax
        mov ax,table
        mov es,ax
        mov bx,0h
        mov cx,15h
        mov si,0h
        mov di,0h
    s:
        ;写入年份，32位四字节双字
        mov ax,[bx]
        mov es:[si],ax
        mov ax,02h[bx]
        mov es:02h[si],ax
        ;写入年收入，32位四字节双字
        mov ax,54h[bx]
        mov es:05h[si],ax
        mov ax,56h[bx]
        mov es:07h[si],ax
        ;写入雇员人数，16位二字节单字
        mov ax,0a8h[di]
        mov es:0ah[si],ax
        ;写入平均工资
        ;工资32位，人数16位，用dx存放高16位，ax存放低16位，运算结果ax,存放商（实验要求取整）
        mov ax,54h[bx]
        mov dx,56h[bx]
        div word ptr 0a8h[di]   ;最初用bx，意识到人数的数据长度只有16位，和另外两个类型数据长度不匹配，必须使用另外的变量存地址
        mov es:0dh[si],ax
        ;更新下次循环初值
        add bx,4h                ;下一年
        add si,10h               ;下一行
        add di,2h                ;下一个人
        loop s
    mov ax,4c00h
    int 21h
code ends
end start