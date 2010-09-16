/*
 * Arduin
 *
 *
 *  /home/nofxx/projects/ardo/control
 *
 *
 */

#include <Messenger.h>
//#include <Rub.h>

#define sec  1000
#define min  60000
#define hour 3600000
#define day  86400000


// Output
const int rxPin = 0;
const int txPin = 1;
const int relPin = 3;
const int motorPin = 10;
const int ledPin = 6;
const int infoPin = 13;

// Input
const int knobPin  = 0;
const int lightPin = 1;
const int tempPin  = 2;
const int piezoPin = 3;
const int doorPin  = 4;
const int soundPin = 5;
// Digital
const int btnPin = 2;

// Intervals (s)
unsigned long shoot = 1;
unsigned long sync  = 5 * sec;
unsigned long time_now, last_shoot, last_sync;

int btnState = 0;
int touchState = 0;
int motorState = 0;

char buffer [50];

volatile int rx_state = LOW;
volatile int tx_state = LOW;

Messenger message = Messenger();

// Create the callback function

unsigned long mintomilli(unsigned long m) {
  return(m * 60000);
}

void btnLed() {
  if(digitalRead(btnPin) == 1) {
    Serial.println("BUTTON");
    digitalWrite(infoPin, HIGH);
    analogWrite(relPin, 250);
    if (motorState != 0) {
      motorState = 0;
    } else {
      motorState = 1;
    }
  } else {
    digitalWrite(infoPin, LOW);
    analogWrite(relPin, LOW);
  }

}

void messageReady() {
  int pin = 2;
  int val = 0;
   // Loop through all the available elements of the message
  while ( message.available() && pin <= infoPin ) {
    val = message.readInt();
    // Set the pin as determined by the message
    analogWrite(pin, val);
    pin = pin + 1;
  }

}

void setup()  {
  // nothing happens in setup
  pinMode(infoPin, OUTPUT);
  pinMode(relPin, OUTPUT);
  pinMode(motorPin, OUTPUT);
  pinMode(ledPin, OUTPUT);

  // Atmega defaults INPUT
  // pinMode(btnPin, INPUT);
  // pinMode(touchPin, INPUT);
  // testFalse();
  shoot = mintomilli(shoot);

  attachInterrupt(0, btnLed, CHANGE);
  Serial.begin(115200);
  //Serial.begin(9600);
  message.attach(messageReady);
}





void loop()  {

  time_now = millis();
  // if (motorState != 0) {
  //   analogWrite(motorPin, (analogRead(knobPin)/5));
  // } else {
  //   analogWrite(motorPin, 0);
  // }


  // analogWrite(relPin, 250);
  // delay(500);
  // analogWrite(relPin, 0);
  // delay(500);


  // noInterrupts();
  //  interrupts();
  if ( abs(time_now - last_shoot) >= shoot) {
    last_shoot = time_now;
    //  Serial.println("SHOOTING");
    digitalWrite(ledPin, HIGH);  // turn the ledPin on
    delay(400);                  // stop the program for some time
    digitalWrite(ledPin, LOW);   // turn the ledPin off
  }

  if ( abs(time_now - last_sync) >= sync) {
    last_sync = time_now;
    sprintf(buffer, "i0:%d,i1:%d,knob:%d,sound:%d,lux:%d,piezo:%d,temp:%d",
            digitalRead(btnPin),   // i0
            analogRead(doorPin),   // i1
            analogRead(knobPin),   // knob
            analogRead(soundPin),  // sound
            analogRead(lightPin),  // light
            analogRead(piezoPin), // light
            analogRead(tempPin));  // temp
    Serial.println(buffer);
    // Terminate message with a linefeed and a carriage return
    // Serial.print(13,BYTE);
    // Serial.print(10,BYTE);

    //Serial.println(touchState);
    //Serial.print(byte(50));
    // * Serial.print(78, BYTE) gives "N"
    // * Serial.print(78, BIN) gives "1001110"
    // * Serial.print(78, OCT) gives "116"
    // * Serial.print(78, DEC) gives "78"
    // * Serial.print(78, HEX) gives "4E"
    // * Serial.println(1.23456, 0) gives "1"
    // * Serial.println(1.23456, 2) gives "1.23"
    // * Serial.println(1.23456, 4) gives "1.2346"
    // lightVal = buffer;

    // if (analogRead(lightPin) > 200) {
    //   analogWrite(relPin, 0);
    // } else {
    //   analogWrite(relPin, 250);
    // }

  }

  while ( Serial.available() )  message.process(Serial.read());

}

// void pulseJob(pin) {
//   analogWrite(pin, 250);
//   delay(2000);
//   analogWrite(pin, LOW);
// }

// From Doorduino
// http://github.com/martymcguire/Doorduino/blob/master/Doorduino.pde
// Log a system message to console
// void log(char* message)
// {
//   static char timeString[20];
//   getTime(timeString);

//   Serial.print("[");
//   Serial.print(timeString);
//   Serial.print("] DOOR: ");
//   Serial.println(message);

// }

// void readRTC(time& currentTime)
// {
//   Wire.beginTransmission(DS1307);
//   Wire.send(R_SECS);
//   Wire.endTransmission();

//   Wire.requestFrom(DS1307, 7);
//   currentTime.second = bcd2Dec(Wire.receive());
//   currentTime.minute = bcd2Dec(Wire.receive());
//   currentTime.hour = bcd2Dec(Wire.receive());
//   currentTime.wkDay = bcd2Dec(Wire.receive());
//   currentTime.day = bcd2Dec(Wire.receive());
//   currentTime.month = bcd2Dec(Wire.receive());
//   currentTime.year = bcd2Dec(Wire.receive());
// }


// void setRTC(time& newTime)
// {
//   Wire.beginTransmission(DS1307);
//   Wire.send(dec2Bcd(R_SECS));
//   Wire.send(dec2Bcd(newTime.second));
//   Wire.send(dec2Bcd(newTime.minute));
//   Wire.send(dec2Bcd(newTime.hour));
//   Wire.send(dec2Bcd(newTime.wkDay));
//   Wire.send(dec2Bcd(newTime.day));
//   Wire.send(dec2Bcd(newTime.month));
//   Wire.send(dec2Bcd(newTime.year));
//   Wire.endTransmission();
// }


// Build a human-readable representation of the current time
// @string character array to put the time in, must be 20 bytes long
// void getTime(char* string)
// {
//   // Grab the latest time from the RTC
//   time currentTime;
//   readRTC(currentTime);

//   // And build a formatted string to represent it
//   sprintf(string, "20%02d-%02d-%02dT%02d:%02d:%02dZ",
//                   currentTime.year, currentTime.month, currentTime.day,
//                   currentTime.hour, currentTime.minute, currentTime.second);
// }


// void setTimeFromSerial()
// {
//   time newTime;

//   char temp = 0;

//   // Wait for full time to be received
//   for (int i = 0; i < 7; i++)
//   {
//     while (Serial.available() == 0) {}

//     temp = Serial.read();

//     switch (i) {
//       case 0: newTime.year = temp; break;
//       case 1: newTime.month = temp; break;
//       case 2: newTime.day = temp; break;
//       case 3: newTime.wkDay = temp; break;
//       case 4: newTime.hour = temp; break;
//       case 5: newTime.minute = temp; break;
//       case 6: newTime.second = temp; break;
//     }
//   }

//   setRTC(newTime);
// }


byte bcd2Dec(byte bcdVal)
{
  return bcdVal / 16 * 10 + bcdVal % 16;
}

byte dec2Bcd(byte decVal)
{
  return decVal / 10 * 16 + decVal % 10;
}
