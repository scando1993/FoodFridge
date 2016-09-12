
_main:

;ProyectoFinal.c,27 :: 		void main() {
;ProyectoFinal.c,29 :: 		int temperatura=0;
;ProyectoFinal.c,30 :: 		int Carne_Kg=0;
	CLRF       main_Carne_Kg_L0+0
	CLRF       main_Carne_Kg_L0+1
	CLRF       main_Pollo_Kg_L0+0
	CLRF       main_Pollo_Kg_L0+1
	CLRF       main_Leche_Total_L0+0
	CLRF       main_Leche_Total_L0+1
;ProyectoFinal.c,33 :: 		ANSEL  = 0x04;              // Configure AN2 pin as analog
	MOVLW      4
	MOVWF      ANSEL+0
;ProyectoFinal.c,34 :: 		ANSELH = 0;                 // Configure other AN pins as digital I/O
	CLRF       ANSELH+0
;ProyectoFinal.c,35 :: 		C1ON_bit = 0;               // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;ProyectoFinal.c,36 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;ProyectoFinal.c,38 :: 		TRISA  = 0xFF;              // PORTA is input
	MOVLW      255
	MOVWF      TRISA+0
;ProyectoFinal.c,39 :: 		TRISB  = 0x00;              // PORTB is output
	CLRF       TRISB+0
;ProyectoFinal.c,40 :: 		TRISD  = 0xFF;              // PORTA is input
	MOVLW      255
	MOVWF      TRISD+0
;ProyectoFinal.c,42 :: 		Lcd_Init();                 // Initialize LCD
	CALL       _Lcd_Init+0
;ProyectoFinal.c,43 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,44 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,45 :: 		Lcd_Out(1,1,"Iniciando");          // Write text in first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,46 :: 		Delay_1sec();
	CALL       _Delay_1sec+0
;ProyectoFinal.c,47 :: 		Delay_1sec();
	CALL       _Delay_1sec+0
;ProyectoFinal.c,50 :: 		do {
L_main0:
;ProyectoFinal.c,53 :: 		lm35 = ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _lm35+0
	MOVF       R0+1, 0
	MOVWF      _lm35+1
;ProyectoFinal.c,54 :: 		temperatura = (lm35*150)/307;
	MOVLW      150
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      51
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
;ProyectoFinal.c,58 :: 		if (temperatura > 35) {
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVF       R0+0, 0
	SUBLW      35
L__main9:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;ProyectoFinal.c,59 :: 		RB7_bit=1;
	BSF        RB7_bit+0, BitPos(RB7_bit+0)
;ProyectoFinal.c,60 :: 		RB6_bit=0;   }
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_main4
L_main3:
;ProyectoFinal.c,62 :: 		RB6_bit=1;
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;ProyectoFinal.c,63 :: 		RB7_bit=0;}
	BCF        RB7_bit+0, BitPos(RB7_bit+0)
L_main4:
;ProyectoFinal.c,66 :: 		Carne_Kg= RA0_bit+RA1_bit+RD5_bit+RD6_bit+RD7_bit;
	MOVLW      0
	BTFSC      RA0_bit+0, BitPos(RA0_bit+0)
	MOVLW      1
	MOVWF      main_Carne_Kg_L0+0
	CLRF       main_Carne_Kg_L0+1
	CLRF       R0+0
	BTFSC      RA1_bit+0, BitPos(RA1_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Carne_Kg_L0+0, 1
	CLRF       main_Carne_Kg_L0+1
	BTFSC      STATUS+0, 0
	INCF       main_Carne_Kg_L0+1, 1
	CLRF       R0+0
	BTFSC      RD5_bit+0, BitPos(RD5_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Carne_Kg_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       main_Carne_Kg_L0+1, 1
	CLRF       R0+0
	BTFSC      RD6_bit+0, BitPos(RD6_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Carne_Kg_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       main_Carne_Kg_L0+1, 1
	CLRF       R0+0
	BTFSC      RD7_bit+0, BitPos(RD7_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Carne_Kg_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       main_Carne_Kg_L0+1, 1
;ProyectoFinal.c,67 :: 		Pollo_Kg= RD0_bit+RD1_bit+RD2_bit+RD3_bit+RD4_bit;
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
;ProyectoFinal.c,68 :: 		Leche_Total = RA3_bit+RA4_bit+RA5_bit+RA6_bit+RA7_bit;
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
;ProyectoFinal.c,71 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,72 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,73 :: 		ByteToStr(Carne_Kg,txt);
	MOVF       main_Carne_Kg_L0+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;ProyectoFinal.c,74 :: 		Lcd_Out(1,1,"Carne Kg:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,75 :: 		Lcd_Out(2,1,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,76 :: 		Delay_ms(700);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      27
	MOVWF      R12+0
	MOVLW      39
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
;ProyectoFinal.c,78 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,79 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,80 :: 		ByteToStr(Pollo_Kg,txt2);
	MOVF       main_Pollo_Kg_L0+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt2+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;ProyectoFinal.c,81 :: 		Lcd_Out(1,1,"Pollo Kg:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,82 :: 		Lcd_Out(2,1,txt2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,83 :: 		Delay_ms(700);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      27
	MOVWF      R12+0
	MOVLW      39
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
;ProyectoFinal.c,85 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,86 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinal.c,87 :: 		ByteToStr(Leche_Total,txt3);
	MOVF       main_Leche_Total_L0+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt3+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;ProyectoFinal.c,88 :: 		Lcd_Out(1,1,"Leche litros:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,89 :: 		Lcd_Out(2,1,txt3);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,90 :: 		Delay_ms(700);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      27
	MOVWF      R12+0
	MOVLW      39
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
;ProyectoFinal.c,92 :: 		} while(1);
	GOTO       L_main0
;ProyectoFinal.c,95 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
