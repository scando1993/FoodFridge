
_transmision:

;ProyectoFinal.c,28 :: 		void transmision(char *cadena){
;ProyectoFinal.c,30 :: 		size=strlen(cadena);
	MOVF       FARG_transmision_cadena+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      transmision_size_L0+0
	MOVF       R0+1, 0
	MOVWF      transmision_size_L0+1
;ProyectoFinal.c,31 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_transmision0:
	DECFSZ     R13+0, 1
	GOTO       L_transmision0
	DECFSZ     R12+0, 1
	GOTO       L_transmision0
	DECFSZ     R11+0, 1
	GOTO       L_transmision0
	NOP
	NOP
;ProyectoFinal.c,32 :: 		for(i=0; i<size; i++){
	CLRF       transmision_i_L0+0
	CLRF       transmision_i_L0+1
L_transmision1:
	MOVLW      128
	XORWF      transmision_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      transmision_size_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__transmision18
	MOVF       transmision_size_L0+0, 0
	SUBWF      transmision_i_L0+0, 0
L__transmision18:
	BTFSC      STATUS+0, 0
	GOTO       L_transmision2
;ProyectoFinal.c,33 :: 		UART1_Write(cadena[i]);
	MOVF       transmision_i_L0+0, 0
	ADDWF      FARG_transmision_cadena+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;ProyectoFinal.c,34 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_transmision4:
	DECFSZ     R13+0, 1
	GOTO       L_transmision4
	DECFSZ     R12+0, 1
	GOTO       L_transmision4
	NOP
;ProyectoFinal.c,32 :: 		for(i=0; i<size; i++){
	INCF       transmision_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       transmision_i_L0+1, 1
;ProyectoFinal.c,35 :: 		}
	GOTO       L_transmision1
L_transmision2:
;ProyectoFinal.c,36 :: 		}
L_end_transmision:
	RETURN
; end of _transmision

_main:

;ProyectoFinal.c,38 :: 		void main() {
;ProyectoFinal.c,40 :: 		int temperatura=0;
	CLRF       main_temperatura_L0+0
	CLRF       main_temperatura_L0+1
	CLRF       main_Carne_Kg_L0+0
	CLRF       main_Carne_Kg_L0+1
	CLRF       main_Pollo_Kg_L0+0
	CLRF       main_Pollo_Kg_L0+1
	CLRF       main_Leche_Total_L0+0
	CLRF       main_Leche_Total_L0+1
;ProyectoFinal.c,45 :: 		ANSEL  = 0x04;              // Configure AN2 pin as analog
	MOVLW      4
	MOVWF      ANSEL+0
;ProyectoFinal.c,46 :: 		ANSELH = 0;                 // Configure other AN pins as digital I/O
	CLRF       ANSELH+0
;ProyectoFinal.c,47 :: 		C1ON_bit = 0;               // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;ProyectoFinal.c,48 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;ProyectoFinal.c,49 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;ProyectoFinal.c,51 :: 		TRISA  = 0xFF;              // PORTA is input
	MOVLW      255
	MOVWF      TRISA+0
;ProyectoFinal.c,52 :: 		TRISB  = 0x00;              // PORTB is output
	CLRF       TRISB+0
;ProyectoFinal.c,53 :: 		TRISD  = 0xFF;              // PORTA is input
	MOVLW      255
	MOVWF      TRISD+0
;ProyectoFinal.c,54 :: 		TRISC  = 0x80;              // PORTC is output
	MOVLW      128
	MOVWF      TRISC+0
;ProyectoFinal.c,55 :: 		TRISE  = 0xFF;              // PORTE is input
	MOVLW      255
	MOVWF      TRISE+0
;ProyectoFinal.c,57 :: 		Lcd_Init();                 // Initialize LCD
	CALL       _Lcd_Init+0
;ProyectoFinal.c,58 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,59 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,60 :: 		Lcd_Out(1,1,"Nevera");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,61 :: 		Lcd_Out(2,1,"Inteligente");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,62 :: 		Delay_1sec();
	CALL       _Delay_1sec+0
;ProyectoFinal.c,63 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,64 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,65 :: 		Lcd_Out(1,1,"Iniciando");          // Write text in first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,66 :: 		Delay_1sec();
	CALL       _Delay_1sec+0
;ProyectoFinal.c,67 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,68 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,71 :: 		do {
L_main5:
;ProyectoFinal.c,74 :: 		lm35 = ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _lm35+0
	MOVF       R0+1, 0
	MOVWF      _lm35+1
;ProyectoFinal.c,75 :: 		temperatura = (lm35*150)/307;
	MOVLW      150
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      51
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      main_temperatura_L0+0
	MOVF       R0+1, 0
	MOVWF      main_temperatura_L0+1
;ProyectoFinal.c,79 :: 		if (RE0_bit==1) {
	BTFSS      RE0_bit+0, BitPos(RE0_bit+0)
	GOTO       L_main8
;ProyectoFinal.c,80 :: 		RC0_bit=0;}
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
	GOTO       L_main9
L_main8:
;ProyectoFinal.c,82 :: 		RC0_bit=1;}
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
L_main9:
;ProyectoFinal.c,86 :: 		if (temperatura > 35) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_temperatura_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main20
	MOVF       main_temperatura_L0+0, 0
	SUBLW      35
L__main20:
	BTFSC      STATUS+0, 0
	GOTO       L_main10
;ProyectoFinal.c,87 :: 		RB7_bit=1;
	BSF        RB7_bit+0, BitPos(RB7_bit+0)
;ProyectoFinal.c,88 :: 		RB6_bit=0;}
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_main11
L_main10:
;ProyectoFinal.c,90 :: 		RB6_bit=1;
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;ProyectoFinal.c,91 :: 		RB7_bit=0;}
	BCF        RB7_bit+0, BitPos(RB7_bit+0)
L_main11:
;ProyectoFinal.c,94 :: 		Carne_Kg= RA0_bit+RA1_bit+RD5_bit+RD6_bit+RD7_bit;
	CLRF       R1+0
	BTFSC      RA0_bit+0, BitPos(RA0_bit+0)
	INCF       R1+0, 1
	CLRF       R0+0
	BTFSC      RA1_bit+0, BitPos(RA1_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      R1+0, 1
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	CLRF       R0+0
	BTFSC      RD5_bit+0, BitPos(RD5_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      R1+0, 1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	CLRF       R0+0
	BTFSC      RD6_bit+0, BitPos(RD6_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      R1+0, 1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	CLRF       R0+0
	BTFSC      RD7_bit+0, BitPos(RD7_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      R1+0, 1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVF       R1+0, 0
	MOVWF      main_Carne_Kg_L0+0
	MOVF       R1+1, 0
	MOVWF      main_Carne_Kg_L0+1
;ProyectoFinal.c,95 :: 		Pollo_Kg= RD0_bit+RD1_bit+RD2_bit+RD3_bit+RD4_bit;
	MOVLW      0
	BTFSC      RD0_bit+0, BitPos(RD0_bit+0)
	MOVLW      1
	MOVWF      main_Pollo_Kg_L0+0
	CLRF       main_Pollo_Kg_L0+1
	CLRF       R0+0
	BTFSC      RD1_bit+0, BitPos(RD1_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Pollo_Kg_L0+0, 1
	CLRF       main_Pollo_Kg_L0+1
	BTFSC      STATUS+0, 0
	INCF       main_Pollo_Kg_L0+1, 1
	CLRF       R0+0
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Pollo_Kg_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       main_Pollo_Kg_L0+1, 1
	CLRF       R0+0
	BTFSC      RD3_bit+0, BitPos(RD3_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Pollo_Kg_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       main_Pollo_Kg_L0+1, 1
	CLRF       R0+0
	BTFSC      RD4_bit+0, BitPos(RD4_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Pollo_Kg_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       main_Pollo_Kg_L0+1, 1
;ProyectoFinal.c,96 :: 		Leche_Total = RA3_bit+RA4_bit+RA5_bit+RA6_bit+RA7_bit;
	MOVLW      0
	BTFSC      RA3_bit+0, BitPos(RA3_bit+0)
	MOVLW      1
	MOVWF      main_Leche_Total_L0+0
	CLRF       main_Leche_Total_L0+1
	CLRF       R0+0
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Leche_Total_L0+0, 1
	CLRF       main_Leche_Total_L0+1
	BTFSC      STATUS+0, 0
	INCF       main_Leche_Total_L0+1, 1
	CLRF       R0+0
	BTFSC      RA5_bit+0, BitPos(RA5_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Leche_Total_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       main_Leche_Total_L0+1, 1
	CLRF       R0+0
	BTFSC      RA6_bit+0, BitPos(RA6_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Leche_Total_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       main_Leche_Total_L0+1, 1
	CLRF       R0+0
	BTFSC      RA7_bit+0, BitPos(RA7_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Leche_Total_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       main_Leche_Total_L0+1, 1
;ProyectoFinal.c,98 :: 		if ((Carne_Kg==0)||(Pollo_Kg==0)||(Leche_Total==0)){
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main21
	MOVLW      0
	XORWF      R1+0, 0
L__main21:
	BTFSC      STATUS+0, 2
	GOTO       L__main16
	MOVLW      0
	XORWF      main_Pollo_Kg_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main22
	MOVLW      0
	XORWF      main_Pollo_Kg_L0+0, 0
L__main22:
	BTFSC      STATUS+0, 2
	GOTO       L__main16
	MOVLW      0
	XORWF      main_Leche_Total_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVLW      0
	XORWF      main_Leche_Total_L0+0, 0
L__main23:
	BTFSC      STATUS+0, 2
	GOTO       L__main16
	GOTO       L_main14
L__main16:
;ProyectoFinal.c,99 :: 		transmision("ATD0991255666;\r");
	MOVLW      ?lstr4_ProyectoFinal+0
	MOVWF      FARG_transmision_cadena+0
	CALL       _transmision+0
;ProyectoFinal.c,100 :: 		Delay_ms(15000);
	MOVLW      153
	MOVWF      R11+0
	MOVLW      49
	MOVWF      R12+0
	MOVLW      162
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
;ProyectoFinal.c,101 :: 		transmision("ATH\r");
	MOVLW      ?lstr5_ProyectoFinal+0
	MOVWF      FARG_transmision_cadena+0
	CALL       _transmision+0
;ProyectoFinal.c,102 :: 		}
L_main14:
;ProyectoFinal.c,107 :: 		ByteToStr(Carne_Kg,txt);
	MOVF       main_Carne_Kg_L0+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;ProyectoFinal.c,108 :: 		ByteToStr(Pollo_Kg,txt2);
	MOVF       main_Pollo_Kg_L0+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt2+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;ProyectoFinal.c,109 :: 		ByteToStr(Leche_Total,txt3);
	MOVF       main_Leche_Total_L0+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt3+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;ProyectoFinal.c,110 :: 		Lcd_Out(1,1,"C:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,111 :: 		Lcd_Out(1,3,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,112 :: 		Lcd_Out(1,8,"P:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,113 :: 		Lcd_Out(1,10,txt2);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,114 :: 		Lcd_Out(2,1,"L:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,115 :: 		Lcd_Out(2,3,txt3);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,118 :: 		} while(1);
	GOTO       L_main5
;ProyectoFinal.c,121 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
