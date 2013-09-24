#include <LiquidCrystal.h>
#include <avr/pgmspace.h>

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);


void setup() {
  
  lcd.begin(20,4);

}

String s[] = {"   NPN AUTOMATION  .", "TECHNOLOGIES PVT LTD",  "INITIALIZING", "TRANSFORMER TRIPPED", "SENDING SMS", "CHK SIM AND RESTART", "NETWORK STATUS :", "NETWORK PROVIDER :", 
             "IMEI NUMBER", "SOFTWARE VERSION", "HOME", "SEARCHING", "ROAMING","    NPN AUTOMATION  .", "TECHNOLOGIES PVT LTD",  "INITIALIZING", "TRANSFORMER TRIPPED", "SENDING SMS", "CHK SIM AND RESTART", "NETWORK STATUS :", "NETWORK PROVIDER :", 
             "IMEI NUMBER", "SOFTWARE VERSION", "HOME", "SEARCHING", "ROAMING"};


void loop() {
  
    for ( int i=0; i<=25 ; i++) {
    lcd.clear();
    lcd.setCursor(0,2);
    lcd.print(s[i]);
    delay(1500);

  }
} 

