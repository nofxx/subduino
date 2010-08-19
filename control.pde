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
#define infoPin 13    // LED connected to digital pin 13

// Output
int rxPin = 0;
int txPin = 1;
int relPin = 3;
int ledPin = 6;
// Input
int lightPin = 1;
int btnPin = 2;
int tempPin = 2;
int touchPin = 4;

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
  if (millis() % (3 * sec) == 0) {
    sprintf(buffer, "C1:%d,C2:%d,LIGHT:%d,TEMP:%d",
            digitalRead(btnPin),
            analogRead(touchPin),
            analogRead(lightPin),
            analogRead(tempPin));
    Serial.println(buffer);
    //Serial.println(touchState);
    // lightVal = buffer;
    digitalWrite(ledPin, HIGH);  // turn the ledPin on
    delay(100);                  // stop the program for some time
    digitalWrite(ledPin, LOW);   // turn the ledPin off
    delay(100);                  // stop the program for some time

    // if (lightVal > 200) {
    //   analogWrite(relPin, 0);
    // } else {
    //   analogWrite(relPin, 250);
    // }

  }
  while ( Serial.available() )  message.process(Serial.read());

}
