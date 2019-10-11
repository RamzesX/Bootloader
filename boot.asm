;Tron Solitare
;  *This is a PoC boot sector ( <512 bytes) game
;  *Controls to move are just up/down/left/right
;  *Avoid touching yourself, blue border, and the
;     unlucky red 7

[ORG 0x7c00]      ;add to offsets
LEFT  EQU 75
RIGHT EQU 77
UP    EQU 72
DOWN  EQU 80

;Init the environment
;  init data segment
;  init stack segment allocate area of mem
;  init E/video segment and allocate area of mem
;  Set to 0x03/80x25 text mode
;  Hide the cursor

; ah i al to jest gorna i dolna polowa ax, a ax to dolna polowa eax
   xor ax, ax     ;make it zero ; to jest taki ogolny rejestr
   mov ds, ax     ;DS=0, to jest segment danych, i to jest ten podstawowy

   mov ss, ax     ;stack starts at 0, to jest od stack segment, czyli gdzie ten stos ma sie zaczyna, troche glupio, ze segment danhych i stosu sie zaczyna, w tym samym mijescu,
   ; ale to moze tylko kwestia ustawienia sobie basepointera i toppointera, a ten ss, sie tak na prawde nie liczy
   mov sp, 0x9c00 ;200h past code start, to jest jais arbitalnie wybrany adres, jakies ciemne arkany xd
 
   mov ah, 0xb8   ;text video memory, czyli tutaj jakby przechowujemy adres pamieci grafinczej, i przez dodawanie czegos do mlodszej polowy, bedziemy sie przesuwac tylko po wydzielonym obszarze
   mov es, ax     ;ES=0xB800, to wyglada, ze tez jest jakis dodatkowy ten rejestr

   mov al, 0x03 ; w al, argument ktory bierze przerwanie
   int 0x10 ; tutaj jest jakies pierwsze uzycie biosu i nie wiem co sie z tym wiaze

   ;Seems that this isn't needed, but leaving in commented out in case it needs to be added back
   ;mov al, 0x03   ;Some BIOS crash without this.                 
   ;mov ch, 0x26
   ;inc ah
   ;int 0x10 

   ;Use this instead:
   mov ah, 1
   mov ch, 0x26 ; to jest jakas specjalna wartosc
   int 0x10       

;Draw Border
   ;Fill in all blue
   mov cx, 0x07d0    ;whole screens worth
   mov ax, 0xCC00  ;empty blue background, tutaj sie mozna pobawic co bede chcial tak na prawde, jakie obramowanie czy cos takiego
   
   xor di, di
   rep stosw         ;push it to video memory

   ;fill in all black except for remaining blue edges
   mov di, 158       ;Almost 2nd row 2nd column (need to add 4)
   cbw               ;space char on black on black
   fillin:
   scasw
   scasw             ;Adjust for next line and column
   mov cl, 78   ;inner 78 columns (exclude side borders)
   rep stosw         ;push to video memory
   cmp di, 0x0efe    ;Is it the last col of last line we want?
   jne fillin        ;If not, loop to next line

   ;init the score
   mov bp, 0x0200    ;#CHEAT (You can set the initial score higher than this)

   ;Place the game peice in starting position
   mov di, 0xB65 ;starting position
   mov al, 0x66  ;char to display
   stosb
   xor bx, bx
   mov dx, 0xA3
   
loop:
   sub di, dx
   stosb
   sub di, 0xA1
   stosb
   add bx, 0x1
   cmp bx, 0x5  
   jne loop


  
   
   
   mov di, 0xB65 ;starting position
   xor bx, bx
   mov dx, 0x9E

   
   

   sub di, dx
   stosb
   sub di, 0xA1
   stosb
   sub di, 0x9F
   stosb
   sub di, 0xA1
   stosb
   sub di, 0xA1
   add di, 0x2 ; gsdfdsgsdfgdsfgfdsgsfdgfd
   stosb
   sub di, 0xA1
   stosb
   sub di, 0xA1
   add di, 0x2
   stosb
   sub di, 0xA1
   stosb
   sub di, 0xA1
   add di, 0x2
   stosb
   sub di, 0xA1
   stosb
   
loop2:
 sub di, 0x3
 stosb   
 add bx , 0x1
 cmp bx , 0x9
 jne loop2
 
 mov al, 0x22
 xor bx, bx
 
 add di, 0x2
 
 
 
 sub di, 0xA1
 stosb
 sub di, 0x3
 sub di, 0xA0
 stosb
 sub di, 0x3
 sub di, 0xA0
 stosb
 sub di, 0x3
 sub di, 0xA0
 stosb
 sub di, 0x3
 sub di, 0xA1
 stosb
 
 
 mov di, 0x48B
 stosb
 
loop3: 
sub di, 0x9F
stosb
add bx , 0x1
cmp bx, 0x3
jne loop3
 

xor bx, bx
mov di, 0x485
stosb

loop4:
sub di, 0xA1
stosb
add bx, 0x1
cmp bx, 0x3
jne loop4
 
 mov di, 0x665
 mov al, 0x66
 sub di , 0x2
 stosb
 mov di, 0x845
 stosb

; potem bedzie trzeb ogarnac jakos te petle xd
; teraz bierzemy sie za smiescze napisy
; napisy: Norbert Marchewka, Carrot Os, Carrot ; for , white rabbit ; take blue pill, take red pill
;           lewy dolny rog , prawy rog  , tak jak sie  zaczyna liscie po lewej stronie, u podloza, ale dalej z 20 kwadracikow,  te opcje jakos pod napisem, a na wysokosci poczatku marchewki <                                          
 
   push ax           ;initial key (nothing)  



   mov di, 0xf04          ;coord to start 'YOU WIN!' message
   mov al, 0xc1                     ;white text on black background
   mov si, winmessage               ;get win message pointer
   mov cl, winmessage_e - winmessage
   winloop: movsb
   stosb                            ;commit char to video memory
   loop winloop
   jne wyjscie              ;is it the last character?
   
   
   winmessage:
   db 0x4e, 0x4d;YOU WIN!
   db 0x15 , 0x00 ; to jest dalej ten napis
   winmessage_e: 

wyjscie:
   
      mov di, 0x566

   mov al, 0x0c                     ;white text on black background
   mov si, Carrot               ;get win message pointer
   mov cl, Carrot_end - Carrot
   carrotloop: movsb
   stosb                            ;commit char to video memory
   loop carrotloop
   jne wyjscie2          ;is it the last character?
   
   
   Carrot:
   db 0x43, 0x61
   db 0x72 , 0x72
   db 0x6F, 0x74
   db 0x00; to jest dalej ten napis
   Carrot_end: 


wyjscie2:
 mov di, 0x60A
 mov ax, 0x0C46
 stosw
 mov di,0x60C
 mov ax, 0x0c6F
 stosw
 mov di,0x60E
 mov ax, 0x0c72
 stosw
 
 mov di, 0x6A2
 
  mov al, 0x0F                    ;white text on black background
   mov si, White               ;get win message pointer
   mov cl, White_end - White
   whiteloop: movsb
   stosb                            ;commit char to video memory
   loop whiteloop
   jne wyjscie3          ;is it the last character?
   
   
   White:
   db 0x57, 0x68
   db 0x69 , 0x74
   db 0x65, 0x00 ; to jest dalej ten napis
   White_end: 
 ;57 68 69 74 65

wyjscie3:

mov di, 0x6AE
 
   mov al, 0x0C                    ;white text on black background
   mov si, Rabit               ;get win message pointer
   mov cl, Rabbit_end - Rabit
   rabbitloop: movsb
   stosb                            ;commit char to video memory
   loop rabbitloop
   jne wyjscie4          ;is it the last character?
   
   
   Rabit:
   db 0x52, 0x61
   db 0x62 , 0x62
   db 0x69, 0x74
   db 0x21 , 0x00  ; to jest dalej ten napis
   Rabbit_end: 
 ;52 61 62 62 69 74 21
  
wyjscie4:
mov di, 0xf8a
mov al, 0xc1
mov si, Rabit2               ;get win message pointer
   mov cl, Rabbit_end2 - Rabit2
   rabbitloop2: movsb
stosb                            ;commit char to video memory
   loop rabbitloop2
   jne wyjscie5     
   
   Rabit2:
   db 0x52, 0x61
   db 0x62 , 0x62
   db 0x69, 0x74  ; to jest dalej ten napis
   Rabbit_end2: ;

wyjscie5:
 mov ax, 0xCF4F
 stosw
 mov ax, 0xCF53
 stosw
 mov ax , 0xCFA9
 stosw
 
 mov di, 0xA52
 mov al, 0x4
 mov si, Red
 mov cl, Red_end - Red
 l: movsb
 stosb
 loop l
 jne wyjscie6
 
 wyjscie6:
 mov di, 0xA72
 mov al, 0x01
 mov si, Blue
 mov cl, Blue_end - Blue
 a: movsb
 stosb
 loop a
 jne wyjscie7
 
wyjscie7:

mov di, 0xA6E
mov ax, 0x073E
stosw

push ax 
mainloop:
 
  mov ah, 1
   int 0x16
   pop ax
   jz persisted   ;if no keypress, jump to persisting move state

   ;Clear Keyboard buffer
   xor ah, ah
   int 0x16

   ;Otherwise, move in direction last chosen
   persisted:
   push ax
   ;Check for directional pushes and take action
   cmp ah, LEFT
   je left
   cmp ah, RIGHT
   je right
   
   jne mainloop

   left:
   mov di, 0xA6E
   mov ax, 0x003E
   stosw
   mov di, 0xA4E
   mov ax, 0x073E
   stosw
   jmp mainloop
      
   right:
   mov di, 0xA4E
   mov ax, 0x003E
   stosw
   
   mov di, 0xA6E
   mov ax, 0x073E
   stosw
   
   ;add di, 4
   ;stosb
   jmp mainloop
   
   
  Red:
 db 0x52, 0x65
 db 0x64, 0x00
 db 0x50, 0x69
 db 0x6c, 0x6c
 Red_end:

 
 Blue:
 db 0x42, 0x6c
 db 0x75, 0x65
 db 0x00, 0x50
 db 0x69, 0x6c
 db 0x6c, 0x20
 Blue_end:

 stosw
 stosw
   times 510-($-$$) db 0
   dw 0xAA55

   ; Pad to floppy disk.
   ;times (1440 * 1024) - ($ - $$)  db 0

