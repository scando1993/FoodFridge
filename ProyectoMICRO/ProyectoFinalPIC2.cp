#line 1 "C:/Users/Daniel Jossemar/Desktop/ProyectoMICRO/ProyectoFinalPIC2.c"
unsigned short kp, cnt, oldstate = 0;
char txt[6];


char keypadPort at PORTD;



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


void main() {
 cnt = 0;
 Keypad_Init();
 ANSEL = 0;
 ANSELH = 0;
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Iniciando");
 Delay_1sec();
 Delay_1sec();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Proceso");

 do {
 kp = 0;


 do

 kp = Keypad_Key_Click();
 while (!kp);

 switch (kp) {

 case 1: kp = 49; break;
 case 2: kp = 50; break;
 case 3: kp = 51; break;
 case 5: kp = 52; break;
 case 6: kp = 53; break;
 case 7: kp = 54; break;
 case 9: kp = 55; break;
 case 10: kp = 56; break;
 case 11: kp = 57; break;
 case 14: kp = 48; break;
 case 15: kp = 35; break;

 }

 if (kp != oldstate) {
 cnt = 1;
 oldstate = kp;
 }
 else {
 cnt++;
 }

 Lcd_Chr(1, 10, kp);

 if (cnt == 255) {
 cnt = 0;
 Lcd_Out(2, 10, "   ");
 }

 WordToStr(cnt, txt);
 Lcd_Out(2, 10, txt);
 } while (1);
}
