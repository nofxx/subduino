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

#define endPin 12
#define digPin 13    // LED connected to digital pin 13

int ledPin = 6;
int relPin = 3;
int btnPin = 2;

int btnState = 0;

Messenger message = Messenger();

// Create the callback function
void messageReady() {
  int pin = 2;
  int val = 0;
  Serial.println("TEST 25 255 1340");

  // Loop through all the available elements of the message
  while ( message.available() && pin <= endPin ) {
    val = message.readInt();
    // Set the pin as determined by the message
    analogWrite(pin, val);
    pin = pin + 1;
  }
  Serial.println("FIM");

}


void setup()  {
  // nothing happens in setup
  pinMode(digPin, OUTPUT);
  pinMode(relPin, OUTPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(btnPin, INPUT);
  testFalse();

  //Serial.begin(115200);
  Serial.begin(9600);
  message.attach(messageReady);
}

void loop()  {

  while ( Serial.available() )  message.process(Serial.read () );

}
