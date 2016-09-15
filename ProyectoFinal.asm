
_escribirI2C:

;ProyectoFinal.c,31 :: 		void escribirI2C(unsigned short address, unsigned short data_){
;ProyectoFinal.c,32 :: 		I2C1_Wr(address);
	MOVF       FARG_escribirI2C_address+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ProyectoFinal.c,33 :: 		I2C1_Wr(data_);
	MOVF       FARG_escribirI2C_data_+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ProyectoFinal.c,34 :: 		}
L_end_escribirI2C:
	RETURN
; end of _escribirI2C

_main:

;ProyectoFinal.c,36 :: 		void main() {
;ProyectoFinal.c,38 :: 		int temperatura=0;
	CLRF       main_temperatura_L0+0
	CLRF       main_temperatura_L0+1
	CLRF       main_Carne_Kg_L0+0
	CLRF       main_Pollo_Kg_L0+0
	CLRF       main_Leche_Total_L0+0
;ProyectoFinal.c,44 :: 		ANSEL  = 0x04;              // Configure AN2 pin as analog
	MOVLW      4
	MOVWF      ANSEL+0
;ProyectoFinal.c,45 :: 		ANSELH = 0;                 // Configure other AN pins as digital I/O
	CLRF       ANSELH+0
;ProyectoFinal.c,46 :: 		C1ON_bit = 0;               // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;ProyectoFinal.c,47 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;ProyectoFinal.c,49 :: 		TRISA  = 0xFF;              // PORTA is input
	MOVLW      255
	MOVWF      TRISA+0
;ProyectoFinal.c,50 :: 		TRISB  = 0x00;              // PORTB is output
	CLRF       TRISB+0
;ProyectoFinal.c,51 :: 		TRISD  = 0xFF;              // PORTA is input
	MOVLW      255
	MOVWF      TRISD+0
;ProyectoFinal.c,52 :: 		TRISC  = 0x00;
	CLRF       TRISC+0
;ProyectoFinal.c,53 :: 		TRISE  = 0xFF;              // PORTE is input
	MOVLW      255
	MOVWF      TRISE+0
;ProyectoFinal.c,55 :: 		I2C1_Init(800000);
	MOVLW      2
	MOVWF      SSPADD+0
	CALL       _I2C1_Init+0
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
L_main0:
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
	GOTO       L_main3
;ProyectoFinal.c,80 :: 		RC0_bit=0;}
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
	GOTO       L_main4
L_main3:
;ProyectoFinal.c,82 :: 		RC0_bit=1;}
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
L_main4:
;ProyectoFinal.c,86 :: 		if (temperatura > 35) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_temperatura_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main10
	MOVF       main_temperatura_L0+0, 0
	SUBLW      35
L__main10:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
;ProyectoFinal.c,87 :: 		RB7_bit=1;
	BSF        RB7_bit+0, BitPos(RB7_bit+0)
;ProyectoFinal.c,88 :: 		RB6_bit=0;}
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_main6
L_main5:
;ProyectoFinal.c,90 :: 		RB6_bit=1;
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;ProyectoFinal.c,91 :: 		RB7_bit=0;}
	BCF        RB7_bit+0, BitPos(RB7_bit+0)
L_main6:
;ProyectoFinal.c,94 :: 		Carne_Kg= RA0_bit+RA1_bit+RD5_bit+RD6_bit+RD7_bit;
	MOVLW      0
	BTFSC      RA0_bit+0, BitPos(RA0_bit+0)
	MOVLW      1
	MOVWF      main_Carne_Kg_L0+0
	CLRF       R0+0
	BTFSC      RA1_bit+0, BitPos(RA1_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Carne_Kg_L0+0, 1
	CLRF       R0+0
	BTFSC      RD5_bit+0, BitPos(RD5_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Carne_Kg_L0+0, 1
	CLRF       R0+0
	BTFSC      RD6_bit+0, BitPos(RD6_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Carne_Kg_L0+0, 1
	CLRF       R0+0
	BTFSC      RD7_bit+0, BitPos(RD7_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Carne_Kg_L0+0, 1
;ProyectoFinal.c,95 :: 		Pollo_Kg= RD0_bit+RD1_bit+RD2_bit+RD3_bit+RD4_bit;
	MOVLW      0
	BTFSC      RD0_bit+0, BitPos(RD0_bit+0)
	MOVLW      1
	MOVWF      main_Pollo_Kg_L0+0
	CLRF       R0+0
	BTFSC      RD1_bit+0, BitPos(RD1_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Pollo_Kg_L0+0, 1
	CLRF       R0+0
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Pollo_Kg_L0+0, 1
	CLRF       R0+0
	BTFSC      RD3_bit+0, BitPos(RD3_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Pollo_Kg_L0+0, 1
	CLRF       R0+0
	BTFSC      RD4_bit+0, BitPos(RD4_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Pollo_Kg_L0+0, 1
;ProyectoFinal.c,96 :: 		Leche_Total = RA3_bit+RA4_bit+RA5_bit+RA6_bit+RA7_bit;
	MOVLW      0
	BTFSC      RA3_bit+0, BitPos(RA3_bit+0)
	MOVLW      1
	MOVWF      main_Leche_Total_L0+0
	CLRF       R0+0
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Leche_Total_L0+0, 1
	CLRF       R0+0
	BTFSC      RA5_bit+0, BitPos(RA5_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Leche_Total_L0+0, 1
	CLRF       R0+0
	BTFSC      RA6_bit+0, BitPos(RA6_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Leche_Total_L0+0, 1
	CLRF       R0+0
	BTFSC      RA7_bit+0, BitPos(RA7_bit+0)
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      main_Leche_Total_L0+0, 1
;ProyectoFinal.c,101 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;ProyectoFinal.c,102 :: 		escribirI2C(0XA0,Carne_Kg);
	MOVLW      160
	MOVWF      FARG_escribirI2C_address+0
	MOVF       main_Carne_Kg_L0+0, 0
	MOVWF      FARG_escribirI2C_data_+0
	CALL       _escribirI2C+0
;ProyectoFinal.c,103 :: 		I2C1_Repeated_Start();
	CALL       _I2C1_Repeated_Start+0
;ProyectoFinal.c,104 :: 		escribirI2C(0XA0,Pollo_Kg);
	MOVLW      160
	MOVWF      FARG_escribirI2C_address+0
	MOVF       main_Pollo_Kg_L0+0, 0
	MOVWF      FARG_escribirI2C_data_+0
	CALL       _escribirI2C+0
;ProyectoFinal.c,105 :: 		I2C1_Repeated_Start();
	CALL       _I2C1_Repeated_Start+0
;ProyectoFinal.c,106 :: 		escribirI2C(0XA0,Leche_Total);
	MOVLW      160
	MOVWF      FARG_escribirI2C_address+0
	MOVF       main_Leche_Total_L0+0, 0
	MOVWF      FARG_escribirI2C_data_+0
	CALL       _escribirI2C+0
;ProyectoFinal.c,107 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;ProyectoFinal.c,131 :: 		ByteToStr(Carne_Kg,txt);
	MOVF       main_Carne_Kg_L0+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;ProyectoFinal.c,132 :: 		ByteToStr(Pollo_Kg,txt2);
	MOVF       main_Pollo_Kg_L0+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt2+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;ProyectoFinal.c,133 :: 		ByteToStr(Leche_Total,txt3);
	MOVF       main_Leche_Total_L0+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt3+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;ProyectoFinal.c,134 :: 		Lcd_Out(1,1,"C:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,135 :: 		Lcd_Out(1,3,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,136 :: 		Lcd_Out(1,8,"P:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,137 :: 		Lcd_Out(1,10,txt2);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,138 :: 		Lcd_Out(2,1,"L:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_ProyectoFinal+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,139 :: 		Lcd_Out(2,3,txt3);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinal.c,142 :: 		} while(1);
	GOTO       L_main0
;ProyectoFinal.c,145 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
