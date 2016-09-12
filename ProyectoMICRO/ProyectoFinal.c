 /*Proyecto Final*/



 // LCD module connections
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
// End LCD module connections

unsigned int lm35;
char txt[4];
char txt2[4];
char txt3[4];


void main() {

  int temperatura=0;
  int Carne_Kg=0;
  int Pollo_Kg=0;
  int Leche_Total=0;
  ANSEL  = 0x04;              // Configure AN2 pin as analog
  ANSELH = 0;                 // Configure other AN pins as digital I/O
  C1ON_bit = 0;               // Disable comparators
  C2ON_bit = 0;

  TRISA  = 0xFF;              // PORTA is input
  TRISB  = 0x00;              // PORTB is output
  TRISD  = 0xFF;              // PORTA is input
  
  Lcd_Init();                 // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,1,"Iniciando");          // Write text in first row
  Delay_1sec();
  Delay_1sec();


  do {
  
     //Lectura del sensor LM35
    lm35 = ADC_Read(2);
    temperatura = (lm35*150)/307;
    
    
    //Validación para temperatura alta y temperaturaa normal
    if (temperatura > 35) {
     RB7_bit=1;
     RB6_bit=0;   }
   else {
    RB6_bit=1;
    RB7_bit=0;}
    
    //Contador en Kg
    Carne_Kg= RA0_bit+RA1_bit+RD5_bit+RD6_bit+RD7_bit;
    Pollo_Kg= RD0_bit+RD1_bit+RD2_bit+RD3_bit+RD4_bit;
    Leche_Total = RA3_bit+RA4_bit+RA5_bit+RA6_bit+RA7_bit;
    
    
    Lcd_Cmd(_LCD_CLEAR);               // Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
    ByteToStr(Carne_Kg,txt);
    Lcd_Out(1,1,"Carne Kg:");
    Lcd_Out(2,1,txt);
   Delay_ms(700);
    
    Lcd_Cmd(_LCD_CLEAR);               // Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
    ByteToStr(Pollo_Kg,txt2);
    Lcd_Out(1,1,"Pollo Kg:");
    Lcd_Out(2,1,txt2);
    Delay_ms(700);

    Lcd_Cmd(_LCD_CLEAR);               // Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
    ByteToStr(Leche_Total,txt3);
    Lcd_Out(1,1,"Leche litros:");
    Lcd_Out(2,1,txt3);
    Delay_ms(700);
    
  } while(1);
  

}


