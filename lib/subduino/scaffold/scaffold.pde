/*
 *
 *     SCAFFOLD
 *
 *
 *     #{Time.now}
*/

#include <Messenger.h>

#define sec  1000
#define min  60000
#define hour 3600000
#define day  86400000

// Output
const int rxPin = 0;
const int txPin = 1;
const int d2 = 2;
const int d3 = 3;
const int d4 = 4;
const int d5 = 5;
const int d6 = 6;
const int d7 = 7;
const int d8 = 8;
const int d9 = 9;
//const int d10 = 10;
//const int d11 = 11;
//const int d12 = 12;
const int infoPin = 13;

// Input
const int i0 = A0;
const int i1 = A1;
const int i2 = A2;
const int i3 = A3;
const int i4 = A4;
const int i5 = A5;
// Digital
const int d10 = 10;
const int d11 = 11;
const int d12 = 12;

Messenger message = Messenger();

// Create the callback function

unsigned long mintomilli(unsigned long m) {
  return(m * 60000);
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

void setup() {
  // Atmega defaults INPUT
  pinMode(infoPin, OUTPUT);

  Serial.begin(115200);
  message.attach(messageReady);
}

void loop() {

  time_now = millis();

  // Sync over wire
  if ( abs(time_now - last_sync) >= sync) {
    last_sync = time_now;
    sprintf(buffer, "i0:%d,i1:%d,i2:%d,i3:%d,i4:%d,i5:%d,d11:%d,d12:%d",
            analogRead(i0),
            analogRead(i1),
            analogRead(i2),
            analogRead(i3),
            analogRead(i4),
            analogRead(i5),
            digitalRead(d11),
            digitalRead(d12));
    Serial.println(buffer);
  }

  while ( Serial.available() )  message.process(Serial.read());

}
