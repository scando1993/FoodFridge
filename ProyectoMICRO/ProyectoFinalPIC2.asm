
_main:

;ProyectoFinalPIC2.c,24 :: 		void main() {
;ProyectoFinalPIC2.c,25 :: 		cnt = 0;                                 // Reset counter
	CLRF       _cnt+0
;ProyectoFinalPIC2.c,26 :: 		Keypad_Init();                           // Initialize Keypad
	CALL       _Keypad_Init+0
;ProyectoFinalPIC2.c,27 :: 		ANSEL  = 0;                              // Configure AN pins as digital I/O
	CLRF       ANSEL+0
;ProyectoFinalPIC2.c,28 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;ProyectoFinalPIC2.c,29 :: 		Lcd_Init();                              // Initialize LCD
	CALL       _Lcd_Init+0
;ProyectoFinalPIC2.c,30 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinalPIC2.c,31 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinalPIC2.c,32 :: 		Lcd_Out(1, 1, "Iniciando");                 // Write message text on LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_ProyectoFinalPIC2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinalPIC2.c,33 :: 		Delay_1sec();
	CALL       _Delay_1sec+0
;ProyectoFinalPIC2.c,34 :: 		Delay_1sec();
	CALL       _Delay_1sec+0
;ProyectoFinalPIC2.c,35 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ProyectoFinalPIC2.c,36 :: 		Lcd_Out(1, 1, "Proceso");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_ProyectoFinalPIC2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinalPIC2.c,38 :: 		do {
L_main0:
;ProyectoFinalPIC2.c,39 :: 		kp = 0;                                // Reset key code variable
	CLRF       _kp+0
;ProyectoFinalPIC2.c,42 :: 		do
L_main3:
;ProyectoFinalPIC2.c,44 :: 		kp = Keypad_Key_Click();             // Store key code in kp variable
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;ProyectoFinalPIC2.c,45 :: 		while (!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;ProyectoFinalPIC2.c,47 :: 		switch (kp) {
	GOTO       L_main6
;ProyectoFinalPIC2.c,49 :: 		case  1: kp = 49; break; // 1
L_main8:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,50 :: 		case  2: kp = 50; break; // 2
L_main9:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,51 :: 		case  3: kp = 51; break; // 3
L_main10:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,52 :: 		case  5: kp = 52; break; // 4
L_main11:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,53 :: 		case  6: kp = 53; break; // 5
L_main12:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,54 :: 		case  7: kp = 54; break; // 6
L_main13:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,55 :: 		case  9: kp = 55; break; // 7
L_main14:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,56 :: 		case 10: kp = 56; break; // 8
L_main15:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,57 :: 		case 11: kp = 57; break; // 9
L_main16:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,58 :: 		case 14: kp = 48; break; // 0
L_main17:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,59 :: 		case 15: kp = 35; break; // #
L_main18:
	MOVLW      35
	MOVWF      _kp+0
	GOTO       L_main7
;ProyectoFinalPIC2.c,61 :: 		}
L_main6:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main15
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main18
L_main7:
;ProyectoFinalPIC2.c,63 :: 		if (kp != oldstate) {                  // Pressed key differs from previous
	MOVF       _kp+0, 0
	XORWF      _oldstate+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
;ProyectoFinalPIC2.c,64 :: 		cnt = 1;
	MOVLW      1
	MOVWF      _cnt+0
;ProyectoFinalPIC2.c,65 :: 		oldstate = kp;
	MOVF       _kp+0, 0
	MOVWF      _oldstate+0
;ProyectoFinalPIC2.c,66 :: 		}
	GOTO       L_main20
L_main19:
;ProyectoFinalPIC2.c,68 :: 		cnt++;
	INCF       _cnt+0, 1
;ProyectoFinalPIC2.c,69 :: 		}
L_main20:
;ProyectoFinalPIC2.c,71 :: 		Lcd_Chr(1, 10, kp);                    // Print key ASCII value on LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _kp+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;ProyectoFinalPIC2.c,73 :: 		if (cnt == 255) {                      // If counter varialble overflow
	MOVF       _cnt+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_main21
;ProyectoFinalPIC2.c,74 :: 		cnt = 0;
	CLRF       _cnt+0
;ProyectoFinalPIC2.c,75 :: 		Lcd_Out(2, 10, "   ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_ProyectoFinalPIC2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinalPIC2.c,76 :: 		}
L_main21:
;ProyectoFinalPIC2.c,78 :: 		WordToStr(cnt, txt);                   // Transform counter value to string
	MOVF       _cnt+0, 0
	MOVWF      FARG_WordToStr_input+0
	CLRF       FARG_WordToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;ProyectoFinalPIC2.c,79 :: 		Lcd_Out(2, 10, txt);                   // Display counter value on LCD
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ProyectoFinalPIC2.c,80 :: 		} while (1);
	GOTO       L_main0
;ProyectoFinalPIC2.c,81 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
