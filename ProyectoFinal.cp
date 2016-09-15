#line 1 "C:/Users/kevin/Downloads/ProyectoMICRO/ProyectoFinal.c"









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


unsigned int lm35;
unsigned short i;
char txt[4];
char txt2[4];
char txt3[4];

void escribirI2C(unsigned short address, unsigned short data_){
 I2C1_Wr(address);
 I2C1_Wr(data_);
}

void main() {

 int temperatura=0;
 short Carne_Kg=0;
 short Pollo_Kg=0;
 char ctrlz = 26;
 short Leche_Total=0;

 ANSEL = 0x04;
 ANSELH = 0;
 C1ON_bit = 0;
 C2ON_bit = 0;

 TRISA = 0xFF;
 TRISB = 0x00;
 TRISD = 0xFF;
 TRISC = 0x00;
 TRISE = 0xFF;

 I2C1_Init(800000);

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Nevera");
 Lcd_Out(2,1,"Inteligente");
 Delay_1sec();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Iniciando");
 Delay_1sec();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 do {


 lm35 = ADC_Read(2);
 temperatura = (lm35*150)/307;



 if (RE0_bit==1) {
 RC0_bit=0;}
 else {
 RC0_bit=1;}



 if (temperatura > 35) {
 RB7_bit=1;
 RB6_bit=0;}
 else {
 RB6_bit=1;
 RB7_bit=0;}


 Carne_Kg= RA0_bit+RA1_bit+RD5_bit+RD6_bit+RD7_bit;
 Pollo_Kg= RD0_bit+RD1_bit+RD2_bit+RD3_bit+RD4_bit;
 Leche_Total = RA3_bit+RA4_bit+RA5_bit+RA6_bit+RA7_bit;


 if(1){

 I2C1_Start();
 escribirI2C(0XA0,Carne_Kg);
 I2C1_Repeated_Start();
 escribirI2C(0XA0,Pollo_Kg);
 I2C1_Repeated_Start();
 escribirI2C(0XA0,Leche_Total);
 I2C1_Stop();
#line 128 "C:/Users/kevin/Downloads/ProyectoMICRO/ProyectoFinal.c"
 }


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
