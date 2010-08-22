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
int motorPin = 10;
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
int motorState = 0;

char buffer [50];

volatile int rx_state = LOW;
volatile int tx_state = LOW;

Messenger message = Messenger();

// Create the callback function

void setup()  {
  // nothing happens in setup
  pinMode(infoPin, OUTPUT);
  pinMode(relPin, OUTPUT);
  pinMode(motorPin, OUTPUT);
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
  while ( message.available() && pin <= endPin ) {
    val = message.readInt();
    // Set the pin as determined by the message
    analogWrite(pin, val);
    pin = pin + 1;
  }

}

void loop()  {

  if (motorState != 0) {
    analogWrite(motorPin, (analogRead(knobPin)/5));
  } else {
    analogWrite(motorPin, 0);
  }

  // noInterrupts();
  //  interrupts();
  if (millis() % (10 * sec) == 0) {
    digitalWrite(ledPin, HIGH);  // turn the ledPin on
    delay(100);                  // stop the program for some time
    digitalWrite(ledPin, LOW);   // turn the ledPin off
    delay(100);                  // stop the program for some time
  }

  if (millis() % (3 * sec) == 0) {
    sprintf(buffer, "i0:%d,i1:%d,knob:%d,sound:%d,lux:%d,temp:%d",
            digitalRead(btnPin),   // i0
            analogRead(doorPin),   // i1
            analogRead(knobPin),   // knob
            analogRead(soundPin),  // sound
            analogRead(lightPin),  // light
            analogRead(tempPin));  // temp
    Serial.println(buffer);
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
