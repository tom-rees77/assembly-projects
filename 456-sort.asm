e 300
12 58 55 a2 3c 07 81 ff 05 40 cd b3 d7 43 03 00

a 100
; Sort Function
call 150 ; clear registers
mov bh, 0f     ; number of elements
dec bh         ; num passes = num elements - 1
mov [0200], bh ; move num passes into mem @ 0200
mov cl, [0200] ; init CX to num passes
mov bl, 00     ; boolesn: swap performed? 0-N 1-Y
mov si, 0300   ; initialize SI to beginning of set
mov dl, [si]   ; move 1st element @ SI into DL
inc si         ; increment SI to get 2nd element
cmp dl, [si]   ; compare 1st num in DL w/ 2nd @ SI
jng 114        ; 1st not greater than 2nd, else:
mov dh, [si]   ; contents of SI into DH (2nd elem. >)
mov [si], dl   ; DL into mem @ SI (1st elem. <)
mov [si-1], dh ; DH into SI-1, swap complete
mov bl, 01     ; A swap has been performed
loop 114       ; loop num passes
cmp bl, 00     ; test if any swaps have been done
jne 10b        ; continue passing through numbers
ret

a 150
; Set registers to 0000
mov ax, 0000
mov bx, 0000
mov cx, 0000
mov dx, 0000
ret

t 100
