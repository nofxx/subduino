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

#define endPin 12

// Output
int rxPin = 0;
int txPin = 1;
int relPin = 3;
int ledPin = 6;
int infoPin = 13;

// Input
int knobPin  = 0;
int lightPin = 1;
int tempPin  = 2;
int doorPin  = 4;
int soundPin = 5;
// Digital
int btnPin = 2;

int btnState = 0;
int touchState = 0;

char buffer [50];

volatile int rx_state = LOW;
volatile int tx_state = LOW;

Messenger message = Messenger();

// Create the callback function

void setup()  {
  // nothing happens in setup
  pinMode(infoPin, OUTPUT);
  pinMode(relPin, OUTPUT);
  pinMode(ledPin, OUTPUT);

  pinMode(btnPin, INPUT);
  // pinMode(touchPin, INPUT);
  // testFalse();

  attachInterrupt(0, btnLed, CHANGE);
  Serial.begin(115200);
  //Serial.begin(9600);
  message.attach(messageReady);
}

void btnLed() {
  if(digitalRead(btnPin) == 1) {
    digitalWrite(infoPin, HIGH);
    analogWrite(relPin, 250);
  } else {
    digitalWrite(infoPin, LOW);
    analogWrite(relPin, LOW);
  }

}

void messageReady() {
  int pin = 2;
  int val = 0;
   // Loop through all the available elements of the message
  while ( message.available() && pin <= endPin ) {
    val = message.readInt();
    // Set the pin as determined by the message
    analogWrite(pin, val);
    pin = pin + 1;
  }

}

void loop()  {

  // noInterrupts();
  //  interrupts();
  if (millis() % (300 * sec) == 0) {
    digitalWrite(ledPin, HIGH);  // turn the ledPin on
    delay(100);                  // stop the program for some time
    digitalWrite(ledPin, LOW);   // turn the ledPin off
    delay(100);                  // stop the program for some time
  }

  if (millis() % (3 * sec) == 0) {
    sprintf(buffer, "A0:%d,A1:%d,Knob:%d,Sound:%d,Light:%d,Temp:%d",
            digitalRead(btnPin),   // A0
            analogRead(doorPin),   // A1
            analogRead(knobPin),   // Knob
            analogRead(soundPin),  // Sound
            analogRead(lightPin),  // Light
            analogRead(tempPin));  // Temp
    Serial.println(buffer);
    //Serial.println(touchState);
    // lightVal = buffer;

    if (analogRead(lightPin) > 200) {
      analogWrite(relPin, 0);
    } else {
      analogWrite(relPin, 250);
    }

  }
  while ( Serial.available() )  message.process(Serial.read());

}
