
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
 
 * Buzzer to digital pin 6
 * Sensor to analog pin  A0
 * Sim300 GSM module with echo off at Hardware Rx Tx
 //
*/ 
// a small change

#include <LiquidCrystal.h>
#include <avr/pgmspace.h>
#include <avr/wdt.h>

#define ok 1
#define success  8
#define undefResp  9
#define inv_rspnse 11
#define fail 12
#define nw_home 1
#define nw_srchng 2
#define nw_rmng 5#define nw_error 99
#define Buzz 6
#define ntimeout 13


LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

prog_char lM_0[] PROGMEM = "NPN AUTOMATION";
prog_char lM_1[] PROGMEM = "TECHNOLOGIES PVT LTD";
prog_char lM_2[] PROGMEM = "INITIALIZING";
prog_char lM_3[] PROGMEM = "TRANSFORMER TRIPPED";
prog_char lM_4[] PROGMEM = "SENDING SMS";
prog_char lM_5[] PROGMEM = "CHK SIM AND RESTART";
prog_char lM_6[] PROGMEM = "NETWORK STATUS :";
prog_char lM_7[] PROGMEM = "NETWORK PROVIDER :";
prog_char lM_8[] PROGMEM = "IMEI NUMBER";
prog_char lM_9[] PROGMEM = "SOFTWARE VERSION";
prog_char lM_10[] PROGMEM = "HOME";
prog_char lM_11[] PROGMEM = "SEARCHING";
prog_char lM_12[] PROGMEM = "ROAMING";
prog_char lM_13[] PROGMEM = "SYSTEM IS FINE";
prog_char lM_14[] PROGMEM = "UPTIME";
prog_char lM_15[] PROGMEM = "ERROR E1";



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
  lM_12,
  lM_13,
  lM_14,
  lM_15
  
  };
  
char buffer[20];


String inputString = "";     
String nwStat="";
String provName="";
String IMEI="";
String softwareVersion="ARDV1.2";
String SMS="";

//boolean stringComplete = false;
boolean state=false;
byte count=10;
unsigned int startTime=0;
unsigned int currentTime=0;
unsigned int elasped=0;
byte rst=0;

byte sendCMD(String);
byte getNetStat();
byte getProvName();
//byte sendSMS(String destNum, String smsMSG);
byte getIMEI();
//boolean chk_resp(String, byte, byte);
//void clr_strng();
boolean progSetup();
//void buzz1();

void lcdCopyThat(byte index)
{   strcpy_P(buffer, (char*)pgm_read_word(&(string_table[index])));
    lcd.print(buffer);
    delay(50);
}


void setup() {

  wdt_disable();
  startTime=millis()/60000;
  Serial.begin(9600);
  lcd.begin(16, 2);
  pinMode(Buzz, OUTPUT); 
  digitalWrite(Buzz, HIGH);
  Serial.print("ATE0");
  Serial.write(0x0D);
  Serial.print("AT&W");
  Serial.write(0x0D);
  delay(1000);
  lcdCopyThat(0); //NPN AUTOMATION
  lcd.setCursor(0,1);
  lcdCopyThat(1); //TECHNOLOGIES PRIVATE LIMITED
  byte b=3;
  while(b)
  {
    b--;
    digitalWrite(Buzz, LOW);
    delay(1000);
    digitalWrite(Buzz, HIGH);
    delay(300);    
  }
  lcd.clear();
  lcdCopyThat(2);
  lcd.setCursor(0,1);
  for(byte i=0;i<16;i++)
  {
    lcd.write(0Xff);
    delay(200);  
  }
  
  Serial.flush();
  state=progSetup();
  
}




void loop() {
  

if(count>0)
{if(state)
{
  lcd.clear();
  lcdCopyThat(13); // system is fine
  lcd.setCursor(0,1);
  lcdCopyThat(14); //uptime
  elasped=millis()/60000;
  lcd.print(elasped);
  lcd.print(" Mins");
  delay(1000);
  lcd.setCursor(0,1);
  lcdCopyThat(14); //system is fine
  elasped=millis()/60000;
  lcd.print(elasped);
  delay(1000);
  
  if(elasped>59)
    { sendMSG();
      delay(3000);
      software_Reset();
    }  
  if(chkTrip())
  {
    lcd.clear();
    lcdCopyThat(3); //transformer tripped
    lcd.setCursor(0,1);
    lcdCopyThat(4); //sending sms
    sendMSG();
    lcd.setCursor(0,1);
    lcdCopyThat(15); //sms sent
    while(1)
     {digitalWrite(Buzz, LOW); delay(80); digitalWrite(Buzz, HIGH); delay(80);}
  }  
  
}
else
{
  count--;
  state=progSetup();  
}
}
else
{
  lcd.clear();
  lcdCopyThat(5); //lcd.print("CHECK SIMCARD and restart");
  digitalWrite(Buzz,HIGH);
  delay(500);
  digitalWrite(Buzz,LOW); 
  delay(500); 
}

 
   
}

byte sendCMD(String cmd)
{
  Serial.flush();
  Serial.print(cmd);
  Serial.write(0x0D);
  delay(200);
  inputString="";
  while (Serial.available())
  {
    char inChar = (char)Serial.read(); 
    inputString += inChar;
//    digitalWrite(Buzz, LOW); 
 }
// lcd.clear();
// digitalWrite(Buzz, HIGH);
// lcd.print(inputString); 
// delay(1000); 
}

boolean progSetup()
{
   
  
  byte resp;


  
  while(1)
  {
     lcd.clear();
      lcdCopyThat(6); //lcd.print("NETWORK STATUS");
     lcd.setCursor(0,1);
     resp=getNetStat();
     delay(1000);
     if(resp==nw_home ||resp==nw_rmng)
      {
        break;
      }
     else if(resp==nw_srchng)
      continue;
     else if(resp==fail)
      {
        return false;
      } 
  
  }
  delay(2000);
 
  
  lcd.clear();
 lcdCopyThat(7); //lcd.print("NETWORK PROVIDER");
  lcd.setCursor(0,1);
  getProvName();
  delay(2000);
 
    
  lcd.clear();
   lcdCopyThat(8); //lcd.print("IMEI NUMBER");
  lcd.setCursor(0,1);
  getIMEI();
  delay(4000);
  
  lcd.clear();
  lcdCopyThat(9); // lcd.print("SOFTWARE VERSION");
  lcd.setCursor(0,1);
  lcd.print("RD/V1.2");
  delay(2000);
  
  return true; 


}

byte getNetStat()
{
  
    Serial.flush();
    inputString = "";
    sendCMD("AT+CREG?");
    nwStat=inputString;
  
    lcd.setCursor(0,1);
    if(nwStat.charAt(11)=='1')
      {  lcdCopyThat(10); return nw_home;}//lcd.print("HOME");  
    else if(nwStat.charAt(11)=='2')
      { lcdCopyThat(11);  return nw_srchng;  }
    else if(nwStat.charAt(11)=='5')
      { lcdCopyThat(12);  return nw_rmng;  }
    else  return fail;  
  
}

byte getProvName()
{
    Serial.flush();
    sendCMD("AT+CSPN?");
    provName=inputString;
    byte strt, stp;
    stp=provName.length();
    stp=stp-11;
    strt=10;
    String s1= provName.substring(strt,stp);
    provName="";
    provName=s1;
    lcd.print(provName);
    
}

byte getIMEI()
{
   Serial.flush();
   sendCMD("AT+GSN");  
   IMEI=inputString.substring(2,17);
   lcd.print(IMEI);
}

boolean chkTrip()
{
  byte rep=analogRead(A0);
  if(rep==0||rep==1)
  {
    delay(1000);
    rep=analogRead(A0);
    if(rep==0||rep==1)
    {
      delay(1000);
      rep=analogRead(A0);
      if(rep==0||rep==1)
       return true;
      else 
       return false; 
    }
    else 
       return false; 
    
  }
  else 
       return false; 
}    

void sendMSG()
{
  
  sendCMD("AT+CMGF=1");
  delay(1000);
  sendCMD("AT+CMGS=\"9977893993\"");
  delay(1000);
  sendCMD("XMER TRIPPED");
  Serial.write(0x1A);
/*  delay(2000);
  sendCMD("AT+CMGS=\"9977893993\"");
  delay(1000);
  sendCMD("XMER TRIPPED");
  delay(1000);
  Serial.write(0x1A);
  delay(1000);
  sendCMD("AT+CMGS=\"9977893993\"");
  delay(1000);
  sendCMD("XMER TRIPPED");
  delay(1000);
  Serial.write(0x1A);
  delay(1000);
  sendCMD("AT+CMGS=\"9977893993\"");
  delay(1000);
  sendCMD("XMER TRIPPED");
  delay(1000);
  Serial.write(0x1A);
  delay(1000);*/

}

void software_Reset() // Restarts program from beginning but does not reset the peripherals and registers
{
asm volatile ("  jmp 0");  
}  
