include "emu8086.inc" 

    
.model small
.stack 100h
.data     
.code
main proc
MOV AH, 06h    ; Kayma fonksiyonu
XOR AL, AL     ; Butun ekrani temizle
XOR CX, CX     ; Sol ust kose CH=satir, CL=sutun
MOV DX, 184FH  ; Sag alt kose DH=satir, DL=sutun 
MOV BH, 1Eh    ; Arka plan ve yazi rengi
INT 10H
          
          
    mov ax, @data
    mov ds, ax
    define_scan_num 
    define_clear_screen
;================== Giris Ekrani ====================== 
    
    GOTOXY 20, 5  
    printn "||======================================||"
    GOTOXY 20, 6
    printn "||                                      ||"
    GOTOXY 20, 7
    printn "||      ** VKI HESAP MAKINESI **        ||"
    GOTOXY 20, 8
    printn "||                                      ||"
    GOTOXY 20, 9
    printn "||______________________________________||"
    GOTOXY 20, 10
    printn "||                                      ||"
    GOTOXY 20, 11
    printn "||       => Oguzhan Varsak <=           ||"
    GOTOXY 20, 12
    printn "||                                      ||"
    GOTOXY 20, 13
    printn "||======================================||"

     
    call clear_screen
    mov cx, 0
    
MOV AH, 06h    ; Kayma fonksiyonu
XOR AL, AL     ; Butun ekrani temizle
XOR CX, CX     ; Sol ust kose CH=satir, CL=sutun
MOV DX, 184FH  ; Sag alt kose DH=satir, DL=sutun 
MOV BH, 1Eh    ; Arka plan ve yazi rengi
INT 10H
    GOTOXY 0, 1     ;Giris ekrani tamamlandi.
      
MOV AX,0h   
MOV BX,0h
MOV CX,0h
MOV DX,0h      
       
    GOTOXY 15, 5
    PRINT 'CM cinsinden boyunuz:  '         
        CALL SCAN_NUM                ;Kullanicidan boy girisi aliniyor.         
        MOV [0200h],CX                       
        MOV AX,CX                             
                             
 
  
    GOTOXY 15, 7
    PRINT 'KG cinsinden kilonuz:  ' 
    CALL SCAN_NUM                ;Kullanicidan kilo girisi aliniyor.       
    MOV [0202h],CX                       
    MOV CX,0h 
    
                      MOV BX,[0202h] 
                      DIV BX          

                      mov dx,ax
                                    
                      cmp dx, 1     ;dx 1 ise
                      JE Kilolu     ;Kilolu fonksiyonuna atla
                      
                      cmp dx, 2     ;dx 2 ise
                      JE Kilolu     ;Kilolu fonksiyonuna atla
                      
                      cmp dx, 3     ;dx 3 ise
                      JE Normal     ;Normal fonksionuna atla
    
                      cmp dx, 4     ;dx 4 ise
                      JE Zayif      ;Zayif fonksiyonuna atla
                      
                      cmp dx, 5     ;dx 5 ise
                      JE Zayif      ;Zayif fonksiyonuna atla
                      
     
    Zayif:
    GOTOXY 35, 11
        print "VKI: Zayif "
        jmp press
    Normal:
    GOTOXY 35, 11
       print "VKI: Normal Kiloda "
       jmp press 
    Kilolu:
    GOTOXY 35, 11
       print "VKI: Kilolu "
       jmp press 
       
       
       press:
       
       GOTOXY 2,14
       print "1. VKI ZAYIF ise onerileri almak icin basin."
       
       
       GOTOXY 2,16 
       print "2. VKI KILOLU ise onerileri almak icin basin."
      GOTOXY 27, 23
      
    print "Devam etmek icin giris yapin..."
    mov ah, 0
    int 16h
    
    call clear_screen


MOV AH, 06h    ; Kayma fonksiyonu
XOR AL, AL     ; Butun ekrani temizle
XOR CX, CX     ; Sol ust kose CH=satir, CL=sutun
MOV DX, 184FH  ; Sag alt kose DH=satir, DL=sutun 
MOV BH, 1Eh    ; Arka plan ve yazi rengi 
INT 10H                                  

MOV AX,0h   
MOV BX,0h
MOV CX,0h
MOV DX,0h 
 
    GOTOXY 27, 2
    print "1 veya 2'ye basin..."
    mov ah, 01h
    int 21h
    
    
    cmp al,'1'
    JE P1
    cmp al,'2'
    JE P2
    
    P1:
    
        GOTOXY 2, 4
        print "1.Daha fazla yemek tuketin ve gunde 8 saat uykunuzu alin"
        GOTOXY 2, 6
        print "2.Yuksek kalorili besinler tuketin.(Patates, Tavuk gogsu, Pilav, Badem, vs.)" 
        GOTOXY 2, 9
        print "3.Gunluk minimum 3L su icin."
        GOTOXY 2, 11
        print "4.Sebze tuketin."
        GOTOXY 2, 13
        print "5.Gunluk 1 bardak sut ve butun yumurta tuketin."
        GOTOXY 27, 23
        print "Cikis icin herhangi bir tusa basin..."
        jmp exit
    
    P2:
     
        GOTOXY 2, 4
        print "1.Dusuk kalorili Saglikli diet uygulayin."
        GOTOXY 2, 6
        print "2.Yuksek proteine sahip yiyecekler tuketin ve Fast Food'dan kacinin."
        GOTOXY 2, 8
        print "3.Kilo kaybi icin calismalar yapin.(Yuruyus, Kosu, Bisiklet, vs.)"
        GOTOXY 2, 10
        print "4.Omega3 iceren sebzeler tuketin."
        GOTOXY 27, 23
        print "Cikis icin herhangi bir tusa basin..." 
        jmp exit
    
    exit:
        mov ah, 0
        int 16h
        call clear_screen

end main