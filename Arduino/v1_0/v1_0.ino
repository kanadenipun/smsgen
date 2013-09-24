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
boolean stringComplete = false;
boolean state=false;
unsigned int count=10;

unsigned int sendCMD(String);
unsigned int getNetStat();
unsigned int sendSMS(String destNum, String smsMSG);
boolean chk_resp(String, unsigned int, unsigned int);
void clr_strng();
boolean progSetup();

void setup() {

  Serial.begin(9600);
  lcd.begin(16, 2);
  pinMode(Buzz, OUTPUT); 
  digitalWrite(Buzz, HIGH);
  state=progSetup();
  //sendCMD("ATE0");
  //sendCMD("AT&W");
}


void loop() {


 while(1)
{ 
  if(state)
  {
    lcd.clear();
    lcd.print("All OK ");
    delay(1000);
    lcd.clear();
    delay(300);
  }
  else
  {
   if(count)
   {
     state=progSetup();
     count--;
     continue; 
  }
     
   lcd.clear();
   lcd.print("Check Simcard");
   lcd.setCursor(0,1);
   lcd.print("And Restart");
  }
  
}



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
  delay(100);
}

boolean progSetup()
{
  unsigned int resp=0;
  
  Serial.print("ATE0");
  Serial.write(0x0D);
  Serial.print("AT&W");
  Serial.write(0x0D);
 
  lcd.clear();
  lcd.print(" NPN Autmation");
  lcd.setCursor(0,1);
  lcd.print("Tech Pvt LTd....");
  delay(2000);
  lcd.clear();
  lcd.print("Network Status");
  lcd.setCursor(0,1);
  
  while(resp!=nw_home || resp!=nw_rmng)
  {
    resp=getNetStat();
    if(resp==nw_error)
    {
      return false; 
    }
  }
  
   
}


unsigned int getNetStat()
{
  
  Serial.flush();
  sendCMD("AT+CREG?");
  if (stringComplete) {
    nwStat=inputString;
    lcd.clear();
    lcd.print(nwStat);
    delay(1000);
    inputString = "";
    stringComplete = false;
  }
  nwStat=inputString;
  if(nwStat.charAt(11)=='1')
    { lcd.print("HOME"); delay(1000); return nw_home; }
  else if(nwStat.charAt(11)=='2')
    { lcd.print("Searching"); delay(1000); return nw_srchng; }
  else if(nwStat.charAt(11)=='5')
    { lcd.print("Roaming"); delay(1000); return nw_rmng;  }
  else
    {/*lcd.print("Error"); delay(1000); lcd.setCursor(0,1); */lcd.print(nwStat); delay(1000);return nw_error;  }
   
  
}

void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read(); 
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == 0x0A) {
      stringComplete = true;
    } 
  }
}

