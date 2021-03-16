#include "p16F628a.inc" ;incluir librerias relacionadas con el dispositivo
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)
RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
auxj equ 0x33
auxi equ 0x34
;cont equ 0x35
auxa equ 0x20
auxc equ 0x21
a equ 0x25
c equ 0x22
d equ 0x23 
;inicio del programa:
START
 MOVLW 0x07 ;Apagar comparadores
 MOVWF CMCON
 BCF STATUS, RP1 ;Cambiar al banco 1
 BSF STATUS, RP0
 MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
 MOVWF TRISB
 BCF STATUS, RP0 ;Regresar al banco 0
 nop
 inicio:
 BSF PORTB,0 ;poner el puerto B0 (bit 0 del puerto B) en 1
 call tiempo1
 BCF PORTB,0 ;poner el puerto B0 (bit 0 del puerto B) en 0
 call tiempo2
 nop
 nop
 goto inicio ;regresar y repetirtiempo1:

tiempo1:  
 movlw d'37'
 movwf auxi
 DECFSZ auxi,f
 GOTO $-1
 nop
 movlw d'45'
 movwf i
iloop:
 movlw d'3'
 movwf auxj
 DECFSZ auxj,f
 GOTO $-1
 movlw d'56'
 movwf j
jloop:
 nop
 nop
 nop
 nop
 nop
 movlw d'58'
 movwf k
kloop:
 decfsz k,f
 goto kloop
 decfsz j,f
 goto jloop
 decfsz i,f
 goto iloop
 movlw d'30'
 movwf j
 decfsz j,f
 goto $-1
 return ;salir de la rutina de tiempo y regresar al
 ;valor de contador de programa
 
tiempo2:  
 movlw d'51'
 movwf auxa
 DECFSZ auxa,f
 GOTO $-1
 nop
 movlw d'51'
 movwf a
aloop:
 movlw d'36'
 movwf auxc
 DECFSZ auxc,f
 GOTO $-1
 movlw d'57'
 movwf c
cloop:
 nop
 nop
 nop
 nop
 nop
 movlw d'58'
 movwf d
dloop:
 decfsz d,f
 goto dloop
 decfsz c,f
 goto cloop
 decfsz a,f
 goto aloop
 movlw d'30'
 movwf c
 decfsz c,f
 goto $-1
 return ;salir de la rutina de tiempo y regresar al 
END

