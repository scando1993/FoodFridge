
_init:

;ProyectoFinalPIC2.c,2 :: 		void init(){
;ProyectoFinalPIC2.c,3 :: 		ANSEL  = 0;         // Configure AN pins as digital
	CLRF       ANSEL+0
;ProyectoFinalPIC2.c,4 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;ProyectoFinalPIC2.c,5 :: 		UART1_Init(9600);   // Initialize USART module
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;ProyectoFinalPIC2.c,8 :: 		I2C1_Init(8000000);
	CLRF       SSPADD+0
	CALL       _I2C1_Init+0
;ProyectoFinalPIC2.c,9 :: 		PORTA = 255;
	MOVLW      255
	MOVWF      PORTA+0
;ProyectoFinalPIC2.c,10 :: 		TRISA = 255;        //Utiliza PORTA como entrada
	MOVLW      255
	MOVWF      TRISA+0
;ProyectoFinalPIC2.c,11 :: 		TRISB=0;            //Utiliza PORTB como salida
	CLRF       TRISB+0
;ProyectoFinalPIC2.c,12 :: 		PORTB=0;
	CLRF       PORTB+0
;ProyectoFinalPIC2.c,16 :: 		}
L_end_init:
	RETURN
; end of _init

_transmision:

;ProyectoFinalPIC2.c,17 :: 		void transmision(unsigned short size_cadena){ //Funcion que permite enviar cadenas de caracteres de cualquier tamaño vía UART
;ProyectoFinalPIC2.c,21 :: 		Delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
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
;ProyectoFinalPIC2.c,22 :: 		for(i=0; i < size_cadena; i++){
	CLRF       transmision_i_L0+0
L_transmision1:
	MOVF       FARG_transmision_size_cadena+0, 0
	SUBWF      transmision_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_transmision2
;ProyectoFinalPIC2.c,23 :: 		valor = EEPROM_Read(0x00+i);
	MOVF       transmision_i_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
;ProyectoFinalPIC2.c,24 :: 		UART1_Write(valor);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;ProyectoFinalPIC2.c,22 :: 		for(i=0; i < size_cadena; i++){
	INCF       transmision_i_L0+0, 1
;ProyectoFinalPIC2.c,26 :: 		}
	GOTO       L_transmision1
L_transmision2:
;ProyectoFinalPIC2.c,27 :: 		}
L_end_transmision:
	RETURN
; end of _transmision

_main:

;ProyectoFinalPIC2.c,29 :: 		void main() {
;ProyectoFinalPIC2.c,33 :: 		char ctrlz=26;    //Caracter ascii de la tecla Control+Z
;ProyectoFinalPIC2.c,34 :: 		int size=0;
	CLRF       main_size_L0+0
	CLRF       main_size_L0+1
	CLRF       main_i_L0+0
	CLRF       main_pollo_L0+0
	CLRF       main_leche_L0+0
	CLRF       main_elemento_L0+0
;ProyectoFinalPIC2.c,44 :: 		init();
	CALL       _init+0
;ProyectoFinalPIC2.c,45 :: 		memset(buffer1,'\0',strlen(buffer1)); // Borra el contenido de buffer1
	MOVLW      main_buffer1_L0+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      FARG_memset_n+0
	MOVF       R0+1, 0
	MOVWF      FARG_memset_n+1
	MOVLW      main_buffer1_L0+0
	MOVWF      FARG_memset_p1+0
	CLRF       FARG_memset_character+0
	CALL       _memset+0
;ProyectoFinalPIC2.c,46 :: 		while (1) {
L_main4:
;ProyectoFinalPIC2.c,48 :: 		if(!I2C1_Is_Idle()){
	CALL       _I2C1_Is_Idle+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;ProyectoFinalPIC2.c,49 :: 		elemento = I2C1_Rd(0);
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      main_elemento_L0+0
;ProyectoFinalPIC2.c,50 :: 		switch(elemento){
	GOTO       L_main7
;ProyectoFinalPIC2.c,51 :: 		case 0:{
L_main9:
;ProyectoFinalPIC2.c,52 :: 		pollo = I2C1_Rd(0);
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      main_pollo_L0+0
;ProyectoFinalPIC2.c,53 :: 		numero = "AT+CMGS=\"0985312079\"\r";
	MOVLW      ?lstr1_ProyectoFinalPIC2+0
	MOVWF      main_numero_L0+0
;ProyectoFinalPIC2.c,54 :: 		size = strlen(numero);
	MOVF       main_numero_L0+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      main_size_L0+0
	MOVF       R0+1, 0
	MOVWF      main_size_L0+1
;ProyectoFinalPIC2.c,55 :: 		if(size <= 256){
	MOVLW      128
	XORLW      1
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main39
	MOVF       R0+0, 0
	SUBLW      0
L__main39:
	BTFSS      STATUS+0, 0
	GOTO       L_main10
;ProyectoFinalPIC2.c,56 :: 		for(i = 0; i < size; i++){
	CLRF       main_i_L0+0
L_main11:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_size_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main40
	MOVF       main_size_L0+0, 0
	SUBWF      main_i_L0+0, 0
L__main40:
	BTFSC      STATUS+0, 0
	GOTO       L_main12
;ProyectoFinalPIC2.c,57 :: 		EEPROM_Write(0x00+i,numero[i]);
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       main_i_L0+0, 0
	ADDWF      main_numero_L0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ProyectoFinalPIC2.c,56 :: 		for(i = 0; i < size; i++){
	INCF       main_i_L0+0, 1
;ProyectoFinalPIC2.c,58 :: 		}
	GOTO       L_main11
L_main12:
;ProyectoFinalPIC2.c,59 :: 		transmision(size);
	MOVF       main_size_L0+0, 0
	MOVWF      FARG_transmision_size_cadena+0
	CALL       _transmision+0
;ProyectoFinalPIC2.c,60 :: 		}
L_main10:
;ProyectoFinalPIC2.c,61 :: 		sprinti(buffer1,"Se tiene las siguientes cantidades de pollo:%d//5",pollo);
	MOVLW      main_buffer1_L0+0
	MOVWF      FARG_sprinti_wh+0
	MOVLW      ?lstr_2_ProyectoFinalPIC2+0
	MOVWF      FARG_sprinti_f+0
	MOVLW      hi_addr(?lstr_2_ProyectoFinalPIC2+0)
	MOVWF      FARG_sprinti_f+1
	MOVF       main_pollo_L0+0, 0
	MOVWF      FARG_sprinti_wh+3
	CALL       _sprinti+0
;ProyectoFinalPIC2.c,62 :: 		size = strlen(numero);
	MOVF       main_numero_L0+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      main_size_L0+0
	MOVF       R0+1, 0
	MOVWF      main_size_L0+1
;ProyectoFinalPIC2.c,63 :: 		if(size <= 256){
	MOVLW      128
	XORLW      1
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main41
	MOVF       R0+0, 0
	SUBLW      0
L__main41:
	BTFSS      STATUS+0, 0
	GOTO       L_main14
;ProyectoFinalPIC2.c,64 :: 		for(i = 0; i < size; i++){
	CLRF       main_i_L0+0
L_main15:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_size_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main42
	MOVF       main_size_L0+0, 0
	SUBWF      main_i_L0+0, 0
L__main42:
	BTFSC      STATUS+0, 0
	GOTO       L_main16
;ProyectoFinalPIC2.c,65 :: 		EEPROM_Write(0x00+i,numero[i]);
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       main_i_L0+0, 0
	ADDWF      main_numero_L0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ProyectoFinalPIC2.c,64 :: 		for(i = 0; i < size; i++){
	INCF       main_i_L0+0, 1
;ProyectoFinalPIC2.c,66 :: 		}
	GOTO       L_main15
L_main16:
;ProyectoFinalPIC2.c,67 :: 		transmision(size);
	MOVF       main_size_L0+0, 0
	MOVWF      FARG_transmision_size_cadena+0
	CALL       _transmision+0
;ProyectoFinalPIC2.c,68 :: 		}
L_main14:
;ProyectoFinalPIC2.c,69 :: 		}break;
	GOTO       L_main8
;ProyectoFinalPIC2.c,70 :: 		case 1:{
L_main18:
;ProyectoFinalPIC2.c,71 :: 		leche = I2C1_Rd(0);
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      main_leche_L0+0
;ProyectoFinalPIC2.c,72 :: 		numero = "AT+CMGS=\"0985312079\"\r";
	MOVLW      ?lstr3_ProyectoFinalPIC2+0
	MOVWF      main_numero_L0+0
;ProyectoFinalPIC2.c,73 :: 		size = strlen(numero);
	MOVF       main_numero_L0+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      main_size_L0+0
	MOVF       R0+1, 0
	MOVWF      main_size_L0+1
;ProyectoFinalPIC2.c,74 :: 		if(size <= 256){
	MOVLW      128
	XORLW      1
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main43
	MOVF       R0+0, 0
	SUBLW      0
L__main43:
	BTFSS      STATUS+0, 0
	GOTO       L_main19
;ProyectoFinalPIC2.c,75 :: 		for(i = 0; i < size; i++){
	CLRF       main_i_L0+0
L_main20:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_size_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main44
	MOVF       main_size_L0+0, 0
	SUBWF      main_i_L0+0, 0
L__main44:
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;ProyectoFinalPIC2.c,76 :: 		EEPROM_Write(0x00+i,numero[i]);
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       main_i_L0+0, 0
	ADDWF      main_numero_L0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ProyectoFinalPIC2.c,75 :: 		for(i = 0; i < size; i++){
	INCF       main_i_L0+0, 1
;ProyectoFinalPIC2.c,77 :: 		}
	GOTO       L_main20
L_main21:
;ProyectoFinalPIC2.c,78 :: 		transmision(size);
	MOVF       main_size_L0+0, 0
	MOVWF      FARG_transmision_size_cadena+0
	CALL       _transmision+0
;ProyectoFinalPIC2.c,79 :: 		}
L_main19:
;ProyectoFinalPIC2.c,80 :: 		sprinti(buffer1,"Se tiene las siguientes cantidades de leche:%d//5", leche);
	MOVLW      main_buffer1_L0+0
	MOVWF      FARG_sprinti_wh+0
	MOVLW      ?lstr_4_ProyectoFinalPIC2+0
	MOVWF      FARG_sprinti_f+0
	MOVLW      hi_addr(?lstr_4_ProyectoFinalPIC2+0)
	MOVWF      FARG_sprinti_f+1
	MOVF       main_leche_L0+0, 0
	MOVWF      FARG_sprinti_wh+3
	CALL       _sprinti+0
;ProyectoFinalPIC2.c,81 :: 		size = strlen(numero);
	MOVF       main_numero_L0+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      main_size_L0+0
	MOVF       R0+1, 0
	MOVWF      main_size_L0+1
;ProyectoFinalPIC2.c,82 :: 		if(size <= 256){
	MOVLW      128
	XORLW      1
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main45
	MOVF       R0+0, 0
	SUBLW      0
L__main45:
	BTFSS      STATUS+0, 0
	GOTO       L_main23
;ProyectoFinalPIC2.c,83 :: 		for(i = 0; i < size; i++){
	CLRF       main_i_L0+0
L_main24:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_size_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main46
	MOVF       main_size_L0+0, 0
	SUBWF      main_i_L0+0, 0
L__main46:
	BTFSC      STATUS+0, 0
	GOTO       L_main25
;ProyectoFinalPIC2.c,84 :: 		EEPROM_Write(0x00+i,numero[i]);
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       main_i_L0+0, 0
	ADDWF      main_numero_L0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ProyectoFinalPIC2.c,83 :: 		for(i = 0; i < size; i++){
	INCF       main_i_L0+0, 1
;ProyectoFinalPIC2.c,85 :: 		}
	GOTO       L_main24
L_main25:
;ProyectoFinalPIC2.c,86 :: 		transmision(size);
	MOVF       main_size_L0+0, 0
	MOVWF      FARG_transmision_size_cadena+0
	CALL       _transmision+0
;ProyectoFinalPIC2.c,87 :: 		}
L_main23:
;ProyectoFinalPIC2.c,88 :: 		}break;
	GOTO       L_main8
;ProyectoFinalPIC2.c,89 :: 		case 2:{
L_main27:
;ProyectoFinalPIC2.c,90 :: 		carne = I2C1_Rd(0);
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
;ProyectoFinalPIC2.c,91 :: 		numero = "AT+CMGS=\"0985312079\"\r";
	MOVLW      ?lstr5_ProyectoFinalPIC2+0
	MOVWF      main_numero_L0+0
;ProyectoFinalPIC2.c,92 :: 		size = strlen(numero);
	MOVF       main_numero_L0+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      main_size_L0+0
	MOVF       R0+1, 0
	MOVWF      main_size_L0+1
;ProyectoFinalPIC2.c,93 :: 		if(size <= 256){
	MOVLW      128
	XORLW      1
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main47
	MOVF       R0+0, 0
	SUBLW      0
L__main47:
	BTFSS      STATUS+0, 0
	GOTO       L_main28
;ProyectoFinalPIC2.c,94 :: 		for(i = 0; i < size; i++){
	CLRF       main_i_L0+0
L_main29:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_size_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVF       main_size_L0+0, 0
	SUBWF      main_i_L0+0, 0
L__main48:
	BTFSC      STATUS+0, 0
	GOTO       L_main30
;ProyectoFinalPIC2.c,95 :: 		EEPROM_Write(0x00+i,numero[i]);
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       main_i_L0+0, 0
	ADDWF      main_numero_L0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ProyectoFinalPIC2.c,94 :: 		for(i = 0; i < size; i++){
	INCF       main_i_L0+0, 1
;ProyectoFinalPIC2.c,96 :: 		}
	GOTO       L_main29
L_main30:
;ProyectoFinalPIC2.c,97 :: 		transmision(size);
	MOVF       main_size_L0+0, 0
	MOVWF      FARG_transmision_size_cadena+0
	CALL       _transmision+0
;ProyectoFinalPIC2.c,98 :: 		}
L_main28:
;ProyectoFinalPIC2.c,99 :: 		sprinti(buffer1,"Se tiene las siguientes cantidades de carne:%d//5");
	MOVLW      main_buffer1_L0+0
	MOVWF      FARG_sprinti_wh+0
	MOVLW      ?lstr_6_ProyectoFinalPIC2+0
	MOVWF      FARG_sprinti_f+0
	MOVLW      hi_addr(?lstr_6_ProyectoFinalPIC2+0)
	MOVWF      FARG_sprinti_f+1
	CALL       _sprinti+0
;ProyectoFinalPIC2.c,100 :: 		size = strlen(numero);
	MOVF       main_numero_L0+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      main_size_L0+0
	MOVF       R0+1, 0
	MOVWF      main_size_L0+1
;ProyectoFinalPIC2.c,101 :: 		if(size <= 256){
	MOVLW      128
	XORLW      1
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVF       R0+0, 0
	SUBLW      0
L__main49:
	BTFSS      STATUS+0, 0
	GOTO       L_main32
;ProyectoFinalPIC2.c,102 :: 		for(i = 0; i < size; i++){
	CLRF       main_i_L0+0
L_main33:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_size_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVF       main_size_L0+0, 0
	SUBWF      main_i_L0+0, 0
L__main50:
	BTFSC      STATUS+0, 0
	GOTO       L_main34
;ProyectoFinalPIC2.c,103 :: 		EEPROM_Write(0x00+i,numero[i]);
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       main_i_L0+0, 0
	ADDWF      main_numero_L0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;ProyectoFinalPIC2.c,102 :: 		for(i = 0; i < size; i++){
	INCF       main_i_L0+0, 1
;ProyectoFinalPIC2.c,104 :: 		}
	GOTO       L_main33
L_main34:
;ProyectoFinalPIC2.c,105 :: 		transmision(size);
	MOVF       main_size_L0+0, 0
	MOVWF      FARG_transmision_size_cadena+0
	CALL       _transmision+0
;ProyectoFinalPIC2.c,106 :: 		}
L_main32:
;ProyectoFinalPIC2.c,107 :: 		}break;
	GOTO       L_main8
;ProyectoFinalPIC2.c,108 :: 		}
L_main7:
	MOVF       main_elemento_L0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       main_elemento_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       main_elemento_L0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main27
L_main8:
;ProyectoFinalPIC2.c,137 :: 		}
L_main6:
;ProyectoFinalPIC2.c,176 :: 		}
	GOTO       L_main4
;ProyectoFinalPIC2.c,177 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
