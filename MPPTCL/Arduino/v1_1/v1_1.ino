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
 
*/ 

#include <LiquidCrystal.h>

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
boolean stringComplete = false;
boolean state=false;
unsigned int count=10;

unsigned int sendCMD(String);
unsigned int getNetStat();
unsigned int getProvName();
unsigned int sendSMS(String destNum, String smsMSG);
boolean chk_resp(String, unsigned int, unsigned int);
void clr_strng();
boolean progSetup();
void buzz1();

void serialEvent() {
  while (Serial.available()) {
    
    char inChar = (char)Serial.read(); 
    inputString += inChar;
    if (inChar == 0x0A) {
      stringComplete = true;
      //buzz1();
    } 
  }
}

void setup() {

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
  delay(3000);
  Serial.flush();
  state=progSetup();
  
}


void loop() {
  
if(count>0)
{if(state)
{
  lcd.clear();
  lcd.print("ALL OK");
  //getProvName();
  delay(20);
  
//  sendCMD("AT+CSPN?");
  
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
  lcd.print("CHK SIM");
}


   
   
}


void buzz1()
{
  digitalWrite(Buzz, LOW);
  delay(1000);
  digitalWrite(Buzz, HIGH);

}
void clr_strng()
{
 inputString="";
} 

unsigned int sendCMD(String cmd)
{
  Serial.flush();
 // clr_strng();  
  Serial.print(cmd);
  Serial.write(0x0D);
 delay(200);
  
  
}

boolean progSetup()
{
   
  
  unsigned int resp;
  lcd.clear();

  
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
//  getProvName();
  
  return true; 


}


unsigned int getNetStat()
{
  
    Serial.flush();
    inputString = "";
    sendCMD("AT+CREG?");
    if (stringComplete) {
    delay(25);
    nwStat=inputString;
    inputString = "";
    stringComplete = false;
    }
  
  lcd.setCursor(0,1);
  if(nwStat.charAt(11)=='1')
    { lcd.print("HOME");  return nw_home;}
  else if(nwStat.charAt(11)=='2')
    { lcd.print("SEARCHING");  return nw_srchng;  }
  else if(nwStat.charAt(11)=='5')
    { lcd.print("ROAMING");  return nw_rmng;  }
  else  return fail;  
  
}

unsigned int getProvName()
{
    Serial.flush();
    sendCMD("AT+CSPN?");
    if (stringComplete) {
    delay(25);
    provName=inputString;
    inputString = "";
    stringComplete = false;
    }
    unsigned int strt, stp;
    stp=provName.length();
   // stp=stp;-11;
   // strt=10;
   // String s1= provName.substring(strt,stp);
   // provName="";
   // provName=s1;
    lcd.print(stp);
    delay(1000);
  
  
 }


