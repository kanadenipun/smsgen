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
#include <avr/wdt.h>

#define ok 1
#define success  8
#define undefResp  9
#define inv_rspnse 11
#define fail 12
#define nw_home 1
#define nw_srchng 2
#define nw_rmng 5
#define nw_error 99
#define Buzz 6
#define ntimeout 13


LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
String inputString = "";     
String nwStat="";
String provName="";
String IMEI="";
//String softwareVersion="ARDV1.2";
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
  lcd.print(" NPN AUTOMATION");
  lcd.setCursor(0,1);
  lcd.print("  TECHNOLOGIES");
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
  lcd.print("INITIALIZING");  
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
  lcd.print("SYSTEM IS FINE");
  lcd.setCursor(0,1);
  lcd.print("UPTIME : ");
  elasped=millis()/60000;
  lcd.print(elasped);
  lcd.print(" Mins");
  delay(1000);
  lcd.setCursor(0,1);
  lcd.print("UPTIME   ");
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
    lcd.print("XMER TRIPPED");
    lcd.setCursor(0,1);
    lcd.print("SENDING SMS ");
    sendMSG();
    lcd.setCursor(0,1);
    lcd.print("SMS SENT        ");
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
  lcd.print("CHECK SIMCARD");
  lcd.setCursor(0,1);
  lcd.print("AND RESTART ");
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
     lcd.print("NETWORK STATUS");
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
  lcd.print("NETWORK PROVIDER");
  lcd.setCursor(0,1);
  getProvName();
  delay(2000);
 
    
  lcd.clear();
  lcd.print("IMEI NUMBER");
  lcd.setCursor(0,1);
  getIMEI();
  delay(4000);
  
  lcd.clear();
  lcd.print("SOFTWARE VERSION");
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
      { lcd.print("HOME");  return nw_home;}
    else if(nwStat.charAt(11)=='2')
      { lcd.print("SEARCHING");  return nw_srchng;  }
    else if(nwStat.charAt(11)=='5')
      { lcd.print("ROAMING");  return nw_rmng;  }
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
