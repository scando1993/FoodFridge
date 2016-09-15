  unsigned short i;
void init(){
     ANSEL  = 0;         // Configure AN pins as digital
     ANSELH = 0;
     UART1_Init(9600);   // Initialize USART module
                         // (8 bit, 9600 baud rate, no parity bit...)
     
     I2C1_Init(8000000);
     PORTA = 255;
     TRISA = 255;        //Utiliza PORTA como entrada
     TRISB=0;            //Utiliza PORTB como salida
     PORTB=0;
     //TRISC=0x80;         //Utiliza RC7 como entrada
     //PORTC=0x80;
     
}
void transmision(unsigned short size_cadena){ //Funcion que permite enviar cadenas de caracteres de cualquier tamaño vía UART
     char i;
     char valor;

     Delay_ms(500);
     for(i=0; i < size_cadena; i++){
              valor = EEPROM_Read(0x00+i);
             UART1_Write(valor);
             //Delay_ms(10);
     }
}

void main() {
     char buffer1[25];  //Cadena de caracteres para guardar un valor recibido vía UART
     char *p;          //Puntero para recorrer un arreglo
     char *numero;
     char ctrlz=26;    //Caracter ascii de la tecla Control+Z
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
     memset(buffer1,'\0',strlen(buffer1)); // Borra el contenido de buffer1
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

         
/*       if(RA0_bit==1 || RA1_bit==1 || RA2_bit==1){
             //LECHE
            if(RA0_bit==1){
                        transmision("AT+CMGS=\"0985312079\"\r");
                        transmision("Sin Leche\r\n");
                        UART1_Write(ctrlz);

            }

            //POLLO
            if(RA1_bit==1){
                        transmision("AT+CMGS=\"0985312079\"\r");
                        transmision("Sin Pollo\r\n");
                        UART1_Write(ctrlz);
            }

            //CARNE
            if(RA2_bit==1){
                        transmision("AT+CMGS=\"0985312079\"\r");
                        transmision("Sin Carne\r\n");
                        UART1_Write(ctrlz);
            }

            Delay_ms(5000);
            */
            
         }
          
          /*
          if(RA0_bit==0 && RA1_bit==0 && RA2_bit==0 && UART1_Data_Ready()==1){
              while(UART1_Data_Ready()==1){
                  buffer1[cont]=UART1_Read();   //Voy guardando cada caracter recibido en la variable buffer1
                  cont++;                       //Este contador incrementará para ir guardando los valores en la variable buffer1
              }
                      Delay_ms(1000);                      //Espero 1 segundo
                      cont=0;                              //Inicializo la variable
                      p=buffer1;                           //El puntero p apunta a la primera dirección de memoria de la variable buffer1, es decir, p=buffer1[0]
                      while(*p!='\0'){                     //El puntero recorrerá la variable buffer1 hasta que apunte al fin de la cadena
                          if(*p=='L'){
                              flag1=1;
                          }
                          
                          if(*p=='P'){
                              flag2=1;
                          }
                          
                          if(*p=='C'){
                              flag3=1;
                          }
                          p++;
                       }
                      

                      if (flag1==1 || flag3==1 ||flag2==1){
                      transmision("AT+CMGS=\"0985312079\"\r");
                      transmision("OK\r\n");
                      UART1_Write(ctrlz);
                       }
                       

                      memset(buffer1,'\0',strlen(buffer1));
                      flag1=0;
                      flag2=0;
                      flag3=0;
          } */
     }
}