include "emu8086.inc" 

    
.model small
.stack 100h
.data     
.code
main proc
MOV AH, 06h    ;Kayma fonksiyonu
XOR AL, AL     ;Butun ekrani temizle
XOR CX, CX     ;Sol ust kose CH=satir, CL=sutun
MOV DX, 184FH  ;Sol ust kose CH=satir, CL=sutun 
MOV BH, 1Eh    ;Arka plan ve yazi rengi
INT 10H
          
          
    mov ax, @data
    mov ds, ax
    define_scan_num 
    define_clear_screen   
    
 
;================== Giris Ekrani ====================== 
    
    GOTOXY 20, 7
    PRINT "|| **VKI HESAP MAKINESI ve COVID TEST** ||" 
    
    GOTOXY 2, 14
    PRINT "COVID-19 Testi icin 0'a basin"
    
    GOTOXY 2, 16
    PRINT "VKI Hesap Makinesi icin 1'e basin"
    
    GOTOXY 27, 23
    PRINT "0 veya 1'e basin..."     
    
    mov ah, 01h
    int 21h  
        
    cmp al, '0'
    je covid_test
     
     
    call clear_screen   
    
    mov cx, 0
    
    MOV AH, 06h    ;Kayma fonksiyonu
    XOR AL, AL     ;Butun ekrani temizle
    XOR CX, CX     ;Sol ust kose CH=satir, CL=sutun
    MOV DX, 184FH  ;Sag alt kose DH=satir, DL=sutun 
    MOV BH, 1Eh    ;Arka plan ve yazi rengi
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
        CALL SCAN_NUM                    ;Kullanicidan kilo girisi aliniyor.
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
            PRINT "VKI: Zayif"
            jmp press
        Normal:         
        GOTOXY 35, 11
           PRINT "VKI: Normal"
           jmp press 
        Kilolu:         
        GOTOXY 35, 11
           PRINT "VKI: Kilolu"
           jmp press 
           
           
           press:
           
           GOTOXY 2,14
           PRINT "1. VKI ZAYIF ise onerileri almak icin basin."
           
           
           GOTOXY 2,16 
           PRINT "2. VKI KILOLU ise onerileri almak icin basin."   
          
           GOTOXY 27, 23
           PRINT "Devam etmek icin giris yapin..."     
           mov ah, 0
           int 16h
        
        call clear_screen
    
    
    MOV AH, 06h    ;Kayma fonksiyonu
    XOR AL, AL     ;Butun ekrani temizle
    XOR CX, CX     ;Sol ust kose CH=satir, CL=sutun
    MOV DX, 184FH  ;Sag alt kose DH=satir, DL=sutun 
    MOV BH, 1Eh    ;Arka plan ve yazi rengi 
    INT 10H                                  
    
    MOV AX,0h   
    MOV BX,0h
    MOV CX,0h
    MOV DX,0h 
     
        GOTOXY 27, 2
        PRINT "1 veya 2'ye basin..."        
        mov ah, 01h
        int 21h
        
        
        cmp al,'1'
        JE P1
        cmp al,'2'
        JE P2
        
        P1:
        
            GOTOXY 2, 4
            PRINT "1.Daha fazla yemek tuketin ve gunde 8 saat uykunuzu alin"                ;VKI: Zayif icin oneriler.
            GOTOXY 2, 6
            PRINT "2.Yuksek kalorili besinler tuketin.(Patates, Tavuk gogsu, Pilav, Badem, vs.)" 
            GOTOXY 2, 8
            PRINT "3.Gunluk minimum 3L su icin."
            GOTOXY 2, 10
            PRINT "4.Sebze tuketin."
            GOTOXY 2, 12
            PRINT "5.Gunluk 1 bardak sut ve butun yumurta tuketin."
            GOTOXY 27, 22
            PRINT "Cikis icin herhangi bir tusa basin..."
            jmp exit
        
        P2:
         
            GOTOXY 2, 4     
            PRINT "1.Dusuk kalorili Saglikli diet uygulayin."                               ;VKI: Kilolu icin oneriler.
            GOTOXY 2, 6
            PRINT "2.Yuksek proteine sahip yiyecekler tuketin ve Fast Food'dan kacinin."
            GOTOXY 2, 8
            PRINT "3.Kilo kaybi icin calismalar yapin.(Yuruyus, Kosu, Bisiklet, vs.)"
            GOTOXY 2, 10
            PRINT "4.Omega3 iceren sebzeler tuketin."
            GOTOXY 27, 22
            PRINT "Cikis icin herhangi bir tusa basin..." 
            jmp exit
           
           
           
covid_test:   								;COVID-19 Testi
call clear_screen
    
    MOV AH, 06h    ;Kayma fonksiyonu
    XOR AL, AL     ;Butun ekrani temizle
    XOR CX, CX     ;Sol ust kose CH=satir, CL=sutun
    MOV DX, 184FH  ;Sag alt kose DH=satir, DL=sutun 
    MOV BH, 1Eh    ;Arka plan ve yazi rengi 
    INT 10H 
    
        GOTOXY 27, 2
        PRINT "Devam etmek icin giris yapin..."   
        mov ah, 0
        int 16h
        
          
    MOV AX,0h   
    MOV BX,0h
    MOV CX,0h
    MOV DX,0h      
           
        GOTOXY 20, 4
        PRINT 'Celsius cinsinden atesiniz :  '         
        CALL SCAN_NUM               ;Kullanicidan ates bilgisi aliniyor.         
        MOV [0200h],CX                       
        MOV AX,CX                             
                             
                          MOV dx,ax
                                       
                          cmp dx, 38    ;Derece 38'den dusukse,
                          JLE risk_yok  ;Risk yok
                          
                                        ;Derece 38'den yuksekse, risk olabilir.              
        GOTOXY 20, 6  
        PRINT "COVID-19 tasiyor olma riskiniz var."
        
        GOTOXY 22, 22
        PRINT "Semptomlari gormek icin giris yapiniz..." 
        mov ah, 0
        int 16h 
        
        call clear_screen


    MOV AH, 06h    ;Kayma fonksiyonu
    XOR AL, AL     ;Butun ekrani temizle
    XOR CX, CX     ;Sol ust kose CH=satir, CL=sutun
    MOV DX, 184FH  ;Sag alt kose DH=satir, DL=sutun 
    MOV BH, 1Eh    ;Arka plan ve yazi rengi 
    INT 10H  
    
    
            GOTOXY 2, 4
            PRINT "Semptomlardan gosteriyorsaniz 1 yoksa 0 giriniz"                ;                
            
            GOTOXY 2, 6
            PRINT "- Dudaklarda veya yuzde morarma." 
            GOTOXY 2, 7
            PRINT "- Goguste keskin ve kalici agri veya aci."
            GOTOXY 2, 8
            PRINT "- Nefes almakta zorluk cekme."
            GOTOXY 2, 9
            PRINT "- Yeni ortaya cikmis kafa karisikligi <Dalginlik>."  
            GOTOXY 2, 10
            PRINT "- Bilincsizlik veya zor uyanma."   
            GOTOXY 2, 11
            PRINT "- Geveleyerek veya zor konusma <yeni veya ilerleme>."
            GOTOXY 2, 12
            PRINT "- Yeni veya ilerlemis nobetler."
            GOTOXY 2, 13
            PRINT "- Dusuk kan basinci belirtileri <Bas donmesi, usume, ayaklanmada sorunlar)."
            GOTOXY 2, 14
            PRINT "- Dehidrasyon <Kuru dudak ve agiz, idrara cikamama, cokuk gozler>." 
            
            GOTOXY 27, 23
            PRINT "0 veya 1'e basin..."
            mov ah, 01h
            int 21h
        
        
        cmp al,'0'
        JE semptom_yok
        
        cmp al,'1'
        JE semptom_var
        
semptom_yok:
call clear_screen

    MOV AH, 06h    ;Kayma fonksiyonu
    XOR AL, AL     ;Butun ekrani temizle
    XOR CX, CX     ;Sol ust kose CH=satir, CL=sutun
    MOV DX, 184FH  ;Sag alt kose DH=satir, DL=sutun 
    MOV BH, 1Eh    ;Arka plan ve yazi rengi 
    INT 10H  


            GOTOXY 2, 4
            print "COVID-19 tasimiyor olabilirsiniz."                ;COVID-19 Riskli icin oneriler
            
            GOTOXY 2, 6
            print "Yine de riskli durumdasiniz." 
            
            GOTOXY 2, 8
            print "Virusu tasiyor olabilirsiniz." 
            
            GOTOXY 2, 10
            print "Sosyal mesafenize dikkat edin ve maske takin."
    
            jmp exit
            
            
semptom_var:
call clear_screen

    MOV AH, 06h    ;Kayma fonksiyonu
    XOR AL, AL     ;Butun ekrani temizle
    XOR CX, CX     ;Sol ust kose CH=satir, CL=sutun
    MOV DX, 184FH  ;Sag alt kose DH=satir, DL=sutun 
    MOV BH, 1Eh    ;Arka plan ve yazi rengi 
    INT 10H  
    
    
            GOTOXY 2, 4
            PRINT "COVID-19'a yakalanmis olma ihtimaliniz yuksek." ;COVID-19 Pozitif icin oneriler               
            
            GOTOXY 2, 6
            PRINT "Acilen doktorunuza gorunun,"   
            
            GOTOXY 2, 8
            PRINT "veya hastaneniz ile iletisime gecin."
         
            jmp exit               
                      
    
risk_yok:  
        
            GOTOXY 20, 6     
            PRINT "Muhtemelen COVID-19 tasimiyorsunuz."     ;COVID-19 Negatif icin oneriler.
            
            GOTOXY 20, 8     
            PRINT "Yine de sosyal mesafenize dikkat edin."            




exit:
    mov ah, 0
    int 16h
    call clear_screen  
    

end main