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
unsigned short i;
char txt[4];
char txt2[4];
char txt3[4];

//Funcion que permite enviar cadenas
//de caracteres de cualquier tamaño vía UART
void transmision(char *cadena){

     int size,i;
     size=strlen(cadena);
     Delay_ms(1000);
     for(i=0; i<size; i++){
             UART1_Write(cadena[i]);
             Delay_ms(10);
     }
}

void main() {

  int temperatura=0;
  int Carne_Kg=0;
  int Pollo_Kg=0;
  char ctrlz = 26;            // Codigo ascii de ctrl + z
  int Leche_Total=0;
  ANSEL  = 0x04;              // Configure AN2 pin as analog
  ANSELH = 0;                 // Configure other AN pins as digital I/O
  C1ON_bit = 0;               // Disable comparators
  C2ON_bit = 0;
  
  UART1_Init(9600);           // (8 bit, 9600 baud rate, no parity bit)
  Delay_ms(100);

  TRISA  = 0xFF;              // PORTA is input
  TRISB  = 0x00;              // PORTB is output
  TRISD  = 0xFF;              // PORTA is input
  TRISC  = 0x80;              // PORTC is output
  TRISE  = 0xFF;              // PORTE is input
  
  Lcd_Init();                 // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,1,"Iniciando");          // Write text in first row
  Delay_1sec();
  Delay_1sec();
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off


  do {
  
     //Lectura del sensor LM35
    lm35 = ADC_Read(2);
    temperatura = (lm35*150)/307;

    //Validación para la luz de la nevera. Ahorro de energia
     if (RE0_bit==1) {
     RC0_bit=0;}
     else {
     RC0_bit=1;}
    
    //Validación para temperatura alta y temperaturaa normal
    if (temperatura > 35) {
     RB7_bit=1;
     RB6_bit=0;}
     else {
    RB6_bit=1;
    RB7_bit=0;}
    
    //Contador en Kg
    Carne_Kg= RA0_bit+RA1_bit+RD5_bit+RD6_bit+RD7_bit;
    Pollo_Kg= RD0_bit+RD1_bit+RD2_bit+RD3_bit+RD4_bit;
    Leche_Total = RA3_bit+RA4_bit+RA5_bit+RA6_bit+RA7_bit;
    
    
    //Validación para cuando algun producto se ha acabado
    if((Carne_Kg == 0)||( Pollo_Kg == 0)||(Leche_Total == 0)){
    UART1_Write("0");}
    
    //Salida en LCD
    ByteToStr(Carne_Kg,txt);
    ByteToStr(Pollo_Kg,txt2);
    ByteToStr(Leche_Total,txt3);
    Lcd_Out(1,1,"C:");
    Lcd_Out(1,3,txt);
    Lcd_Out(1,8,"P:");
    Lcd_Out(1,10,txt2);
    Lcd_Out(2,1,"L:");
    Lcd_Out(2,3,txt3);
    
    
  } while(1);
  

}