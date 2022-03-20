include 'emu8086.inc'
org 100h  

.data    
    s db 'ababc$'
    lens = $ - offset s - 1    ; strlen(s)
    t db 'babca$'  
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
    mov ax, lens
    
      
     
    mov cx, lens   
    loop1: ;i
        mov lp, cx ; Save to lp
        mov cx, lent
        loop2:   ; j 
            mov j, 0
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
        mov dl, [bx]
        mov ah, 02h
        int 21h
        inc bx
        loop print
                
               

    
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
        

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS ; required for print_num.
DEFINE_PTHIS DEFINE_GET_STRING
DEFINE_PRINT_STRING
END ; directive to stop the com 