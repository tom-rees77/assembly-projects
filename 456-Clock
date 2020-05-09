a 100
; Begin Program
call 0150 ; clear screen
call 0800 ; Print intro screen
call 0150 ; clear screen
call 0175 ; cursor top left
call 0125 ; print hr min sec
call 0200 ; begin second line
ret

a 125
; Set initial message "HR MIN SEC"
mov ah, 09   ; prepare AH for INT 21
mov dx, 012d ; move in message
int 21       ; print message
ret
db "HR MIN SEC AM/PM$"

a 150
; Clear Screen routine
mov ax, 0600 ; scroll entire window, blank screen
mov bh, 07   ; 0-black background, 7-light grey text
mov cx, 0    ; cx, upper left
mov dx, 184f ; dx, lower right
int 10       ; graphics int routine
ret          ; return to calling function

a 175
; Position Cursor: top left
mov ah, 02 ; set cursor for int 10
mov bh, 00 ; page number
mov dx, 00 ; [row: 0][column: 0]
int 10     ; position cursor
ret

a 200
; Start Second Line
call 225 ; initialize clock
call 400 ; increment second
ret

a 225
; Clock Initialization
mov dx, 0200 ; [row: 2][column: 0]
call 350     ; Position Cursor: hour pos; MS
call 275     ; read and print character
mov dx, 0201 ; [row: 2][column: 1]
call 350     ; Position Cursor: hour pos; LS
call 275     ; read and print character
mov dx, 0203 ; [row: 2][column: 3]
call 350     ; Position Cursor: minute pos; MS
call 275     ; read and print character
mov dx, 0204 ; [row: 2][column: 4]
call 350     ; Position Cursor: minute pos; LS
call 275     ; read and print character
mov dx, 0207 ; [row: 2][column: 7]
call 350     ; Position Cursor: second pos; MS
call 275     ; read and print character
mov dx, 0208 ; [row: 2][column: 8]
call 350     ; Position Cursor: second pos; LS
call 275     ; read and print character
mov dx, 020b ; [row: 2][column: 13]
call 350     ; Position Cursor: AM/PM pos; MS
call 275     ; read and print character
mov dx, 020c ; [row: 2][column: 14]
call 350     ; Position Cursor: AM/PM pos; LS
call 275     ; read and print character
ret

a 275
; Read from kbd and print character to the current cursor position
push ax
push bx
push cx
push dx
mov ah, 00 ; BIOS scan code
int 16     ; moves char into al
call 300
;mov dl, al ; mov al into dl to be printed
;mov ah, 02 ; set ah for int 21 
;int 21     ; print character
pop dx
pop cx
pop bx
pop ax
ret

a 300
; Print char in AL
push bx
push cx
push dx
; Color Attributes
; 0 -- Black      8 -- Dark Gray
; 1 -- Blue       9 -- Light Blue
; 2 -- Green      A -- Light Green
; 3 -- Cyan       B -- Light Cyan
; 4 -- Red        C -- Light Red
; 5 -- Magenta    D -- Light Magenta
; 6 -- Brown      E -- Yellow	
; 7 -- Light Gray F -- White
; 
;  mov ah, 02 ; int 21, write char
;  mov dl, al ; mov al into dl to be printed
;  int 21     ; print character
;test
mov ah, 09 ; for int 10, char output
; al has character already
mov bx, 00a4 ;[display page] [background color, char color]
mov cx, 01 ; num of chars to print
int 10 ; print character
; end test
pop dx
pop cx
pop bx
ret

a 325
; Delay Routine: ~1 second 0b51:032b
push ax
push bx
push cx
push dx
mov cx, ffff ; Init counter to ffffH
mov ax, aaaa ; Init ax to aaaaH
dec ax       ; decrement ax
cmp ax, 0000 ; until ax = 0000
jnz 32f      ; jump if ax != 0 to dec ax
loop 32c     ; loop the decrement ffffH times
pop dx
pop cx
pop bx
pop ax
ret

a 350
; Position Cursor:
push ax
push bx
push cx
push dx
mov ah, 02   ; set cursor for int 10
mov bh, 00   ; page number
int 10       ; position cursor
pop dx
pop cx
pop bx
pop ax
ret

a 375
; read character at current cursor position
; AH -> Color, AL -> Character
push bx
push cx
push dx
mov ah, 08 ; read character, int 10
mov bh, 00 ; page number
int 10
pop dx
pop cx
pop bx
ret

a 400
; Start with AM/PM field
push ax
push bx
push dx
call 450 ; Call Hour field (MS)
mov dx, 020b ; [row: 2][column: 13]
call 350     ; Position Cursor: AM/PM pos-MS; pre-read
call 375    ; read character at cursor position into AL
cmp al, 50  ; compare with 'P'
jnz 420 ; if it isn't 'P', then it's 'A' and must change to 'P'
mov dx, 020b ; [row: 2][column: 13]
call 350     ; Position Cursor: AM/PM pos-MS; pre-write
mov al, 41  ; mov 41, ascii 'A', into DL to be printed
call 300
;mov ah, 02  ; set ah for int 21
;int 21      ; print character
jmp 403
; change to 'P'
mov dx, 020b ; [row: 2][column: 13]
call 350     ; Position Cursor: AM/PM pos-MS; pre-write
mov al, 50  ; mov 50, ascii 'P', into DL to be printed
call 300
;mov ah, 02  ; set ah for int 21
;int 21      ; print character
jmp 403
pop dx
pop bx
pop ax
ret

a 450
; HOUR field (LS) / (MS)
push ax
push bx
push dx
call 550 ; call MIN field (MS)
; Check col 0 for a 1
mov dx, 0200 ; [row: 2][column: 0]
call 350     ; Position Cursor: hour pos-MS
call 375    ; read character at cursor position into AL
cmp al, 31  ; if 1, then it is already at 10-12
jz 498 ; jump to increment 0-2
; Else, get char from col 1
mov dx, 0201 ; [row: 2][column: 1]
call 350     ; Position Cursor: hour pos-MS
call 375    ; read character at cursor position into AL
cmp al, 39 ; compare AL with 39 (0-9)
jz 47d ; jump if AL == 9, else increment and then print
; increment LS
mov dx, 0201 ; [row: 2][column: 1]
call 350     ; Position Cursor: hour pos-LS
inc al     ; increment AL
call 300 ; Print char at AL
jmp 453 ; loop, incrementing HOURls
;reset to 0
mov dx, 0201 ; [row: 2][column: 1]
call 350     ; Position Cursor: hour pos-LS pre-write
mov al, 30 ; move 30, ascii 0, into AL
call 300 ; Print char at AL
;increment MS
mov dx, 0200 ; [row: 2][column: 0]
call 350     ; Position Cursor: hour pos-MS
call 375    ; read character at cursor position into AL
inc al     ; increment AL
call 300 ; Print char at AL
jmp 453 ; Incrementing Hours, ???
;increment LS 0-2
mov dx, 0201 ; [row: 2][column: 1]
call 350     ; Position Cursor: hour pos-LS
call 375    ; read character at cursor position into AL
cmp al, 31 ; compare AL with 31 (11)
jz 4c8 ; jump to increment and switch AM/PM 
cmp al, 32 ; compare AL with 32 (0-2)
jz 4b0 ; Reset both MS and LS to 01
inc al     ; Else, increment AL
call 300 ; Print char at AL
jmp 453 ; loop, incrementing HOUR
; reset both MS and LS to 01
mov dx, 0200 ; [row: 2][column: 0]
call 350     ; Position Cursor: hour pos-LS pre-write
mov al, 30 ; move 30, ascii 0, into AL
call 300 ; Print char at AL
mov dx, 0201 ; [row: 2][column: 1]
call 350     ; Position Cursor: hour pos-LS pre-write
mov al, 31 ; move 31, ascii 1, into AL
call 300 ; Print char at AL
jmp 453
inc al     ; Increment AL to 12
call 300 ; Print char at AL
pop dx
pop bx
pop ax
ret ; switch AM / PM

a 550
; MIN field (MS)
push ax
push bx
push dx
call 600
mov dx, 0203 ; [row: 2][column: 3]
call 350     ; Position Cursor: minute pos-MS
call 375    ; read character at cursor position into AL
cmp al, 35 ; compare AL with 35 (50-59)
jz 570 ; jump if AL > 5, else increment and then print
mov dx, 0203 ; [row: 2][column: 3]
call 350     ; Position Cursor: minute pos-MS
inc al     ; increment AL
call 300 ; Print char at AL
jmp 553 ; loop, incrementing MINls
; reset to 0
mov dx, 0203 ; [row: 2][column: 3]
call 350     ; Position Cursor: minute pos-MS pre-write
mov al, 30 ; move 30, ascii 0, into AL
call 300 ; Print char at AL
pop dx
pop bx
pop ax
ret  ; return when 60 minutes are complete

a 600
; MIN field (LS)
push ax
push bx
push dx
call 650
mov dx, 0204 ; [row: 2][column: 4]
call 350     ; Position Cursor: minute pos-LS
call 375    ; read character at cursor position into AL
cmp al, 39 ; compare AH with 39 (0-9)
jz 620 ; jump if AH > 9, else increment and then print
mov dx, 0204 ; [row: 2][column: 4]
call 350     ; Position Cursor: minute pos-LS
inc al     ; increment AL
call 300 ; Print char at AL
jmp 603 ; loop, incrementing MINls
; reset to 0
mov dx, 0204 ; [row: 2][column: 4]
call 350     ; Position Cursor: minute pos-LS pre-write
mov al, 30 ; move 30, ascii 0, into AL
call 300 ; Print char at AL
pop dx
pop bx
pop ax
ret  ; return when 10 minutes are complete

a 650
; SEC field (MS)
push ax
push bx
push dx
call 700
mov dx, 0207 ; [row: 2][column: 7]
call 350     ; Position Cursor: second pos-MS
call 375    ; read character at cursor position into AL
cmp al, 35 ; compare AH with 35 (50-59)
jz 670 ; jump if AH > 5, else increment and then print
mov dx, 0207 ; [row: 2][column: 7]
call 350     ; Position Cursor: second pos-MS
inc al     ; increment AL
call 300 ; Print char at AL
jmp 653 ; loop, incrementing SECms
; reset to 0
mov dx, 0207 ; [row: 2][column: 7]
call 350     ; Position Cursor: second pos-MS pre-write
mov al, 30 ; move 30, ascii 0, into AL
call 300 ; Print char at AL
pop dx
pop bx
pop ax
ret ; return when 60 seconds are complete

a 700
; SEC field (LS)
push ax
push bx
push dx
mov dx, 0208 ; [row: 2][column: 8]
call 350     ; Position Cursor: second pos-LS
call 375    ; read character at cursor position into AL
cmp al, 3a ; compare AH with 3a (1 after ascii 9)
jz 720 ; jump if AL > 9, else delay, increment, and then print
mov dx, 0208 ; [row: 2][column: 8]
call 350     ; Position Cursor: second pos-LS pre-write
call 0325  ; 1 second delay
inc al     ; increment AL
call 300 ; Print char at AL
jmp 703 ; loop, incrementing SECls
; reset to 0
mov dx, 0208 ; [row: 2][column: 8]
call 350     ; Position Cursor: second pos-LS pre-write
mov al, 30 ; move 30, ascii 0, into AL
call 300 ; Print char at AL
pop dx
pop bx
pop ax
ret ; return when 10 seconds are complete

a 800
; Intro Message
mov dx, 0000 ; [row: 0][column: 0]
call 350 ; Position Cursor
mov ah, 09   ; prepare AH for INT 21
mov dx, 0a00 ; move in message
int 21       ; print message
mov dx, 0100 ; [row: 1][column: 0]
call 350 ; Position Cursor
mov dx, 0a13 ; move in message
int 21       ; print message
mov dx, 0200 ; [row: 2][column: 0]
call 350 ; Position Cursor
mov dx, 0a27 ; move in message
int 21       ; print message
mov dx, 0300 ; [row: 3][column: 0]
call 350 ; Position Cursor
mov dx, 0a3b ; move in message
int 21       ; print message
mov dx, 0400 ; [row: 4][column: 0]
call 350 ; Position Cursor
mov dx, 0a4f ; move in message
int 21       ; print message
mov dx, 0500 ; [row: 5][column: 0]
call 350 ; Position Cursor
mov dx, 0a50 ; move in message
int 21       ; print message
mov dx, 0600 ; [row: 6][column: 0]
call 350 ; Position Cursor
mov dx, 0a5e ; move in message
int 21       ; print message
mov dx, 0700 ; [row: 7][column: 0]
call 350 ; Position Cursor
mov dx, 0a5f ; move in message
int 21       ; print message
mov dx, 0800 ; [row: 8][column: 0]
call 350 ; Position Cursor
mov dx, 0a83 ; move in message
int 21       ; print message
mov dx, 0900 ; [row: 9][column: 0]
call 350 ; Position Cursor
mov dx, 0a9c ; move in message
int 21       ; print message
mov dx, 0a00 ; [row: 10][column: 0]
call 350 ; Position Cursor
mov dx, 0ab2 ; move in message
int 21       ; print message
mov dx, 0b00 ; [row: 11][column: 0]
call 350 ; Position Cursor
mov dx, 0ab3 ; move in message
int 21       ; print message
mov dx, 0c00 ; [row: 12][column: 0]
call 350 ; Position Cursor
mov dx, 0ac6 ; move in message
int 21       ; print message
mov dx, 0d00 ; [row: 13][column: 0]
call 350 ; Position Cursor
mov dx, 0aeb ; move in message
int 21       ; print message
mov dx, 0e00 ; [row: 14][column: 0]
call 350 ; Position Cursor
mov dx, 0b04 ; move in message
int 21       ; print message
mov dx, 0f00 ; [row: 15][column: 0]
call 350 ; Position Cursor
mov dx, 0b0e ; move in message
int 21       ; print message
mov dx, 1000 ; [row: 16][column: 0]
call 350 ; Position Cursor
mov dx, 0b0f ; move in message
int 21       ; print message
mov dx, 1100 ; [row: 17][column: 0]
call 350 ; Position Cursor
mov dx, 0b45 ; move in message
int 21       ; print message
mov dx, 1200 ; [row: 18][column: 0]
call 350 ; Position Cursor
mov dx, 0b7b ; move in message
int 21       ; print message
mov dx, 1300 ; [row: 19][column: 0]
call 350 ; Position Cursor
mov dx, 0bb1 ; move in message
int 21       ; print message
mov dx, 1400 ; [row: 20][column: 0]
call 350 ; Position Cursor
mov dx, 0be7 ; move in message
int 21       ; print message
mov dx, 1500 ; [row: 21][column: 0]
call 350 ; Position Cursor
mov dx, 0be8 ; move in message
int 21       ; print message
mov dx, 1600 ; [row: 22][column: 0]
call 350 ; Position Cursor
mov dx, 0c19 ; move in message
int 21       ; print message
mov dx, 1700 ; [row: 23][column: 0]
call 350 ; Position Cursor
mov dx, 0c1a ; move in message
int 21       ; print message
mov ah, 00 ; BIOS scan code
int 16     ; wait for keystroke
ret

a 0a00
db " _________________$"
db "|                 |$"
db "|  12 Hour Clock  |$"
db "|_________________|$"
db "$"
db "Instructions:$"
db "$"
db "This is an example Clock interface:$"
db "        HR MIN SEC AM/PM$"
db "        10 47  22  PM$"
db "$"
db "To input the time:$"
db "You will be presented with a prompt:$"
db "        HR MIN SEC AM/PM$"
db "        _$"
db "$"
db "To set, you must type the Hours, Minutes, and Seconds$"
db "then the AM or PM. There are two characters for every$"
db "field.  Single digits (less than 10) must be preceded$"
db "by a 0. So, for [2 35 07 AM], you would type 023507AM$"
db "$"
db "NOTE: Spaces between the numbers are unnecessary$"
db "$"
db "Press ENTER to continue...$"

a 0d00
; Print colons
mov dx, 0200 ; [row: 2][column: ?]
call 350 ; Position Cursor
; ASCII for colon: 3a

a 0e00
; put display code here

a 0f00
db "         ________________________________________$"
db "        /                                       /|$"
db "       /                                       / |$"
db "      /     ****  *     ****  ****  *  **     /  |$"
db "     /     *     *     *  *  *     * *       /   |$"
db "    /     *     *     *  *  *     *         /    |$"
db "   /     *     *     *  *  *     * *       /     |$"
db "  /     ****  ****  ****  ****  *  **     /      /$"
db " /_______________________________________/      /$"
db "|                                        |     /$"
db "|                                        |    /$"
db "|                                        |   /$"
db "|                                        |  /$"
db "|                                        | /$"
db "|________________________________________|/$"

g=100
