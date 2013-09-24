#include <LiquidCrystal.h>
#include <avr/pgmspace.h>

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

prog_char lM_0[] PROGMEM = "   NPN AUTOMATION  .";
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
prog_char lM_13[] PROGMEM = "   NPN AUTOMATION  .";
prog_char lM_14[] PROGMEM = "TECHNOLOGIES PVT LTD";
prog_char lM_15[] PROGMEM = "INITIALIZING";
prog_char lM_16[] PROGMEM = "TRANSFORMER TRIPPED";
prog_char lM_17[] PROGMEM = "SENDING SMS";
prog_char lM_18[] PROGMEM = "CHK SIM AND RESTART";
prog_char lM_19[] PROGMEM = "NETWORK STATUS :";
prog_char lM_20[] PROGMEM = "NETWORK PROVIDER :";
prog_char lM_21[] PROGMEM = "IMEI NUMBER";
prog_char lM_22[] PROGMEM = "SOFTWARE VERSION";
prog_char lM_23[] PROGMEM = "HOME";
prog_char lM_24[] PROGMEM = "SEARCHING";
prog_char lM_25[] PROGMEM = "ROAMING";


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
  lM_15,
  lM_16,
  lM_17,
  lM_18,
  lM_19,
  lM_20,
  lM_21,
  lM_22,
  lM_23,
  lM_24,
  lM_25
  };
  
char buffer[20];

void setup() {
  
  lcd.begin(20,4);

}

void loop() {
  
  for ( int i=0; i<=25 ; i++) {
    strcpy_P(buffer, (char*)pgm_read_word(&(string_table[i])));
    lcd.clear();
    lcd.setCursor(0,2);
    lcd.print(buffer);
    delay(1500);
  }
} 

