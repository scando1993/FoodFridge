#line 1 "C:/Users/kevin/Downloads/ProyectoMICRO/ProyectoFinalPIC2.c"
 unsigned short i;
void init(){
 ANSEL = 0;
 ANSELH = 0;
 UART1_Init(9600);


 I2C1_Init(8000000);
 PORTA = 255;
 TRISA = 255;
 TRISB=0;
 PORTB=0;



}
void transmision(unsigned short size_cadena){
 char i;
 char valor;

 Delay_ms(500);
 for(i=0; i < size_cadena; i++){
 valor = EEPROM_Read(0x00+i);
 UART1_Write(valor);

 }
}

void main() {
 char buffer1[25];
 char *p;
 char *numero;
 char ctrlz=26;
 int size=0;
 char i=0;
 char flag1=0;
 int cont=0;
 char flag2=0;
 char flag3=0;
 char pollo = 0;
 char carne = 0;
 char leche = 0;
 char elemento = 0;
 init();
 memset(buffer1,'\0',strlen(buffer1));
 while (1) {

 if(!I2C1_Is_Idle()){
 elemento = I2C1_Rd(0);
 switch(elemento){
 case 0:{
 pollo = I2C1_Rd(0);
 numero = "AT+CMGS=\"0985312079\"\r";
 size = strlen(numero);
 if(size <= 256){
 for(i = 0; i < size; i++){
 EEPROM_Write(0x00+i,numero[i]);
 }
 transmision(size);
 }
 sprinti(buffer1,"Se tiene las siguientes cantidades de pollo:%d//5",pollo);
 size = strlen(numero);
 if(size <= 256){
 for(i = 0; i < size; i++){
 EEPROM_Write(0x00+i,numero[i]);
 }
 transmision(size);
 }
 }break;
 case 1:{
 leche = I2C1_Rd(0);
 numero = "AT+CMGS=\"0985312079\"\r";
 size = strlen(numero);
 if(size <= 256){
 for(i = 0; i < size; i++){
 EEPROM_Write(0x00+i,numero[i]);
 }
 transmision(size);
 }
 sprinti(buffer1,"Se tiene las siguientes cantidades de leche:%d//5", leche);
 size = strlen(numero);
 if(size <= 256){
 for(i = 0; i < size; i++){
 EEPROM_Write(0x00+i,numero[i]);
 }
 transmision(size);
 }
 }break;
 case 2:{
 carne = I2C1_Rd(0);
 numero = "AT+CMGS=\"0985312079\"\r";
 size = strlen(numero);
 if(size <= 256){
 for(i = 0; i < size; i++){
 EEPROM_Write(0x00+i,numero[i]);
 }
 transmision(size);
 }
 sprinti(buffer1,"Se tiene las siguientes cantidades de carne:%d//5");
 size = strlen(numero);
 if(size <= 256){
 for(i = 0; i < size; i++){
 EEPROM_Write(0x00+i,numero[i]);
 }
 transmision(size);
 }
 }break;
 }
#line 137 "C:/Users/kevin/Downloads/ProyectoMICRO/ProyectoFinalPIC2.c"
 }
#line 176 "C:/Users/kevin/Downloads/ProyectoMICRO/ProyectoFinalPIC2.c"
 }
}
