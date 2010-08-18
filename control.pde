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
  Serial.print("MESSAGE");

       // Loop through all the available elements of the message
  while ( message.available() && pin <= endPin ) {
  // Set the pin as determined by the message
         val = message.readInt();
         Serial.print("x");
         Serial.print(val);
         // digitalWrite( relPin, val );
         // digitalWrite( digPin, val );
         analogWrite( pin, val );
         pin=pin+1;
      }
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
