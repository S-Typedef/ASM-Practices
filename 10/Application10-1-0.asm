assume cs:code
data segment
        db 'welcome to masm!',0
data ends

code segment
start:  mov dh,8
        mov dl,3
        mov cl,2
        mov ax,data
        mov ds,ax
        mov si,0
        call show_str
        mov ax,4c00h
        int 21h
show_str:   push dx
			push cx
			push si     ; 保护子程序寄存器中用到的寄存器
						; 由于主程序的限定
						; 这里由CPU自动为我们分配栈空间


			mov di,0	;显示缓存区中的偏移量
			mov bl,dh
			dec bl		; bl-1才是真正的行，因为行号从0开始计数
			mov al,160
			mul bl		; 每行160字节 用 行数*每行偏移量 得到目标行的偏移量
			mov bx,ax   ; mul bl之后，乘积存储在ax中，这里要转存入bx中
			mov al,2	; 列的偏移量为2，两个字节代表一列！！！
			mul dl		; 与行偏移量同理
			add bl,al	;将列偏移量与行偏移量相加，得到指定位置的偏移量。

			mov ax,0b800h
			mov es,ax	;指定显示缓存区的内存位置

			mov al,cl	; 由于后面jcxz语句的判断要用到cx，所以我们要将
						; cl(颜色)先存下来。
	 s:     mov ch,0
			mov cl,ds:[si] ;首先将当前指向字符串的某个字符存入cx中
			jcxz ok			; 如果cx为0，则转移到ok标号执行相应代码
			mov es:[bx+di],cl	;将字符传入低地址
			mov es:[bx+di+1],al	; 将颜色传入高地址
			add di,2	; 列偏移量为2
			inc si		; 字符串的偏移量为1
			loop s		; 不为0,继续复制

	ok:     pop dx
			pop cx
			pop si		; 还原寄存器变量
			ret			; 结束子程序调用
code ends
end start