org 100h  

.data    
    s db 'ATTAGGTXXTAXXTAXTAAXT$'
    lens = $ - offset s - 1    ; strlen(s)
    t db 'TTAGGXTAAGTAAGXXTAXGATTXAATG$'  
    lent = $ - offset t - 1    ; strlen(t)
    i dw 0
    j dw 0
    k dw 0  
    lp dw 0  
    index dw 0
    ans dw 0 
    temp db 0
    
    
.code 
    mov ax, @data
    mov ds, ax
    
      
     
    mov cx, lens   
    loop1: ;i
        mov lp, cx ; Save to lp
        mov cx, lent 
        mov j, 0
        loop2:   ; j 
            
            mov k, 0 
            check:       
                mov ax, i
                add ax, k  
                cmp ax, lens ; (i + k < strlen()? )
                jge stop
                mov ax, j
                add ax, k  ; (j + k < strlen()? )  
                cmp ax, lent
                jge stop        
                mov bx, offset s
                add bx, i
                add bx, k
                mov dl, [bx]   
                mov bx, offset t
                add bx, j
                add bx, k
                mov al, [bx]    
                cmp dl, al
                jne stop 
                add k, 1
                jmp check 
            
            stop:  
                add j, 1
                mov ax, ans
                cmp ax, k
                jge pass
                mov ax, k
                mov ans, ax
                mov ax, i
                mov index, ax 
            pass:
                   
            loop loop2 
        add i, 1
        mov cx, lp
        loop loop1
                   
     mov bx, offset s
     add bx, index
     mov cx, ans
     print:  
        cmp cx, 0
        jle quit   
        mov dl, [bx]
        mov ah, 02h
        int 21h
        inc bx
        loop print
                    
     quit:
               

    
ret
    

newline proc ;New line proc
    mov dx,13
    mov ah,2
    int 21h  
    mov dx,10
    mov ah,2
    int 21h
    ret
newline endp  

        
END ; directive to stop the com 