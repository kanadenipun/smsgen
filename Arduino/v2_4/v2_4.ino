
/*
 The circuit:
 
 * LCD RS pin to digital pin 12
 * LCD Enable pin to digital pin 11
 * LCD D4 pin to digital pin 5
 * LCD D5 pin to digital pin 4
 * LCD D6 pin to digital pin 3
 * LCD D7 pin to digital pin 2
 * LCD R/W pin to ground
 * 10K resistor:
 * ends to +5V and ground
 * wiper to LCD VO pin (pin 3)
 
 * Buzzer to digital pin 10
 * Sensor to analog pin  A0
 * Sim300 GSM module with echo off at Hardware Rx Tx

 



MEMORY USAGE

                                          PROGRAM         DATA        ADDITION                              
1) sendCMD(), getNetState();              6270(38.3%)    415(38.3%)   
   startIt(), chkNwk(), 
2) siQual                                 7062(43.2%)    447(43.7%)   792,32
3) Optimization                           5644(34.4%)    432(42.2*)
4) RTC                                    8658(52.8%)    666(65.0%)
5) chkTrip                                9288(56.3%)    726(70.9*)



*/


#include <LiquidCrystal.h>
#include <avr/pgmspace.h>
#include <avr/wdt.h>
#include <Wire.h>
#include "RTClib.h"

RTC_DS1307 RTC;

#define ok 1
#define success  8
#define undefResp  9
#define inv_rspnse 11
#define fail 12
#define nw_home 1
#define nw_srchng 2
#define nw_rmng 5
#define nw_error 99
#define Buzz 13
#define IN1 14
#define TEST_IN 17
#define ntimeout 13

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

byte sig1[8] = {
  0b00000,
  0b00000,
  0b00000,
  0b00000,
  0b00000,
  0b00000,
  0b00001,
  0b00101
};
byte sig2[8] = {
  0b00000,
  0b00000,
  0b00000,
  0b00001,
  0b00101,
  0b10101,
  0b10101,
  0b10101
};
byte sig3[8] = {
  0b00001,
  0b00101,
  0b10101,
  0b10101,
  0b10101,
  0b10101,
  0b10101,
  0b10101
};



prog_char lM_0[] PROGMEM = "NPN AUTOMATION";
prog_char lM_1[] PROGMEM = "TECHNOLOGIES PVT LTD";
prog_char lM_2[] PROGMEM = "INITIALIZING";
prog_char lM_3[] PROGMEM = "TRANSFORMER TRIPPED";
prog_char lM_4[] PROGMEM = "SENDING SMS";
prog_char lM_5[] PROGMEM = "CHK SIM AND RESTART";
prog_char lM_6[] PROGMEM = "NETWORK STATUS :";
prog_char lM_7[] PROGMEM = "NETWORK PROVIDER :";
prog_char lM_8[] PROGMEM = "DEVICE ID : ";
prog_char lM_9[] PROGMEM = "SOFTWARE VERSION";
prog_char lM_10[] PROGMEM = "REGISTRED : HOME";
prog_char lM_11[] PROGMEM = "SEARCHING";
prog_char lM_12[] PROGMEM = "REGISTRED : ROAMING";
prog_char lM_13[] PROGMEM = "SYSTEM IS FINE";
prog_char lM_14[] PROGMEM = "UPTIME";
prog_char lM_15[] PROGMEM = "ERROR E1";
prog_char lM_16[] PROGMEM = "SGEN4410  S/W:RDV2_2" ;
prog_char lM_17[] PROGMEM = "IMEI NUMBER : "; 
prog_char lM_18[] PROGMEM = "____________________"; 
prog_char SM_1[] PROGMEM = "AT+CMGS=\"9977893993\"\r";
prog_char SM_2[] PROGMEM = "AT+CMGS=\"9977893993\"\r";
prog_char SM_3[] PROGMEM = "AT+CMGS=\"9977893993\"\r";
prog_char SM_4[] PROGMEM = "AT+CMGS=\"9977893993\"\r";
prog_char SM_5[] PROGMEM = "AT+CMGS=\"9977893993\"\r";
prog_char SM_6[] PROGMEM = "TRANSFORMER TRIPPED AT 132KV NEPANAGAR" ;
prog_char SM_7[] PROGMEM = "TEST SMS FOR 132KV NEPANAGAR"; 

PROGMEM const char *string_table[]=
{
  lM_0,
  lM_1,
  lM_2,
  lM_3,
  lM_4,
  lM_5,
  lM_6,
  lM_7,
  lM_8,
  lM_9,
  lM_10,
  lM_11,
  lM_12,
  lM_13,
  lM_14,
  lM_15,
  lM_16,
  lM_17,
  lM_18,
  SM_1,
  SM_2,
  SM_3,
  SM_4,
  SM_5,
  SM_6,
  SM_7
  
  };
  
char buffer[20];
char sbuffer[50];
char gsmBuffer[128];

void lcdCopyThat(byte index)
{   strcpy_P(buffer, (char*)pgm_read_word(&(string_table[index])));
    lcd.print(buffer);
    delay(50);
}

void serialCopyThat(byte index)
{   strcpy_P(sbuffer, (char*)pgm_read_word(&(string_table[index])));
    Serial.print(sbuffer);
    delay(50);
}

void setup(){
  
  lcd.createChar(1, sig1);  
  lcd.createChar(2, sig2);  
  lcd.createChar(3, sig3);  
   
   wdt_disable();
   Serial.begin(9600);
   lcd.begin(20, 4);
   Wire.begin();
   RTC.begin();
   RTC.adjust(DateTime(__DATE__, __TIME__));

   pinMode(IN1, INPUT);
   pinMode(TEST_IN, INPUT);
   digitalWrite(IN1, HIGH);
   digitalWrite(TEST_IN, HIGH);
   
   pinMode(Buzz, OUTPUT); 
   digitalWrite(Buzz, HIGH);
   delay(1000);
   digitalWrite(Buzz, LOW); 
   startIt();
}

boolean startIt(){


   lcd.setCursor(3,1);
   lcdCopyThat(0); //NPN AUTOMATION
   lcd.setCursor(0,2);
   lcdCopyThat(1); //TECHNOLOGIES PRIVATE LIMITED
   delay(1000); 
   
 
   lcd.clear();
   lcd.setCursor(4,1);
   lcdCopyThat(2); //INITIALIZING
   lcd.setCursor(0,2);
   for(byte i=0;i<20;i++)
   { 
    lcd.write(0Xff);
    delay(200);  
   }
   delay(1000);
   
   lcd.clear();
   lcd.setCursor(0,1);
   lcdCopyThat(8); //DEVICE ID
   lcd.setCursor(0,2);
   lcdCopyThat(16);//SGEN4410  S/W:RDV2_2 
   delay(2000);
 
   ////----------------------------------- Network Check-----------------------------------
   ////--unless registred home or roaming, it would not go further-------------------------
   ////-- getNetState() gives netowrk details and chkNwk() prints on LCD-------------------

   while(!chkNwk());
   

}

boolean chkNwk(){
  
  lcd.clear();
  lcd.setCursor(0,1);
  lcdCopyThat(6); //Network status : 
   
  if(getNetState()==nw_home){
    lcd.setCursor(0,2);
    lcdCopyThat(10); //home
    delay(2000);
    return true;
  }
 else if(getNetState()==nw_rmng){
     lcd.setCursor(0,2);
     lcdCopyThat(12); //Roaming
     delay(2000);
     return true;
    }
    else if(getNetState()==nw_srchng){
     lcd.setCursor(0,2);
     lcdCopyThat(11); //Searching
     delay(2000);
     return false;
    }  
    else if(getNetState()==fail){
     lcd.setCursor(0,2);
     lcdCopyThat(15); //ERROR E1
     delay(2000);
     return false;
    }
    else if(getNetState()==nw_error){
     lcd.setCursor(0,2);
     lcdCopyThat(5); //Check Sim and Restart
     delay(2000);
     return false;
    }
    
}


byte sendCMD(const char *cmd){  //appends a carriage return and copies the recieving data in buff

  Serial.print(cmd);
  Serial.write(0x0D);
  
  byte len=strlen(cmd);
  len++;
  unsigned int i=0;
  
  while(i<10*len){
    if(Serial.available()<len){
      i++;
      delay(10);
      continue;
    }
    else{
      Serial.readBytes(gsmBuffer, len);
      return ok;
    }
  }

}



byte getNetState(){
 Serial.flush();
  sendCMD("AT+CREG?");
  unsigned int i=0;
 
  while(1){
    if(Serial.available()<20){
      i++;
      delay(10);
      continue;
    }
    else{
      
      Serial.readBytes(gsmBuffer, 20);
      if(gsmBuffer[11]=='1')
        return nw_home;
      else if(gsmBuffer[11]=='2')
        return nw_srchng;
      else if(gsmBuffer[11]=='5')
        return nw_rmng;
      else return nw_error;
    }
  } return fail;
}



int siQual()
{
  Serial.flush();
  sendCMD("AT+CSQ");
  unsigned int i=0;

  while(1){
    if(Serial.available()<20){
      i++;
      delay(10);
      continue;
    }
    else{
      
      Serial.readBytes(gsmBuffer, 20);
      int stn=((((int)gsmBuffer[8]-48)*10)+((int)gsmBuffer[9]-48));
      stn*=100;
      stn/=31;
      return stn; 
    }
  } 
}


void software_Reset() // Restarts program from beginning but does not reset the peripherals and registers
{
asm volatile ("jmp 0");  
}  


void loop(){

  DateTime now = RTC.now();
  lcd.clear();
  lcd.print(now.hour(), DEC);
  lcd.print(":");
  lcd.print(now.minute(), DEC);
  lcd.print(":");
  lcd.print(now.second(), DEC);
  lcd.setCursor(15,0);
  lcd.write((byte)1);
  lcd.write((byte)2);
  lcd.write((byte)3);
  lcd.print(siQual());
  lcd.setCursor(0,1);
  lcdCopyThat(18);//____________________
  
  chkTrp();
    
  lcd.setCursor(5,3);
  lcd.print("ALL IS WELL");
  delay(1000);

}

byte chkTrp()
{
  if(digitalRead(TEST_IN)==LOW || digitalRead(IN1)==LOW)
  {
    delay(2000);
    if(digitalRead(TEST_IN)==LOW){
      lcd.setCursor(0,3);
      lcdCopyThat(3);//transformer tripped
      sendCMD("AT+CMGF=1");
      serialCopyThat(19);
      serialCopyThat(24);
      Serial.write(0x1A);
      delay(1000);
      while(1)
      {
      }
    } 
  }  
  else return 0;
}
