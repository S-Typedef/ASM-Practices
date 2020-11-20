assume cs:code
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
stack segment
    dw 8 dup(0)
stack ends
table segment
    dw 8 dup(0)
table ends
code segment
    start:
        mov ax,data
        mov es,ax
        mov ax,table
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov sp,16
        mov bx,0
        mov cx,21
        mov si,0
        mov di,0

        push cx
        mov cx,4
    s1:
        mov ax,es:[bx]
        mov [bx],ax
        mov ax,es:[bx+2]
        mov [bx+2],ax
        mov ax,di
        mov dh,al
        mov dl,al
        call show_str



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

