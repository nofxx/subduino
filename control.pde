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
#define digPin 13    // LED connected to digital pin 13

int ledPin = 6;
int relPin = 3;
int btnPin = 2;
int tempPin = 2;
int lightPin = 1;
int touchPin = 4;

int btnState = 0;
int touchState = 0;

char buffer [50];

Messenger message = Messenger();

// Create the callback function

void setup()  {
  // nothing happens in setup
  pinMode(digPin, OUTPUT);
  pinMode(relPin, OUTPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(btnPin, INPUT);
  // pinMode(touchPin, INPUT);
  // testFalse();

  Serial.begin(115200);
  //Serial.begin(9600);
  message.attach(messageReady);
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

  while ( Serial.available() )  message.process(Serial.read());

  if (millis() % (3 * sec) == 0) {
    touchState = digitalRead(touchPin);
    sprintf(buffer, "C1:%d,LIGHT:%d,TEMP:%d",
            analogRead(touchPin), // digitalRead(touchPin),
            analogRead(lightPin),
            analogRead(tempPin));
    Serial.println(buffer);
    //Serial.println(touchState);
    // lightVal = buffer;
    digitalWrite(ledPin, HIGH);  // turn the ledPin on
    delay(1000);                  // stop the program for some time
    digitalWrite(ledPin, LOW);   // turn the ledPin off
    delay(1000);                  // stop the program for some time

    // if (lightVal > 200) {
    //   analogWrite(relPin, 0);
    // } else {
    //   analogWrite(relPin, 250);
    // }

  }
}
