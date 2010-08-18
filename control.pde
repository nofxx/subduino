//
// Arduin
///home/nofxx/projects/ardo/control/
//#include <Messenger.h>
#include <messenger/arduino/Messenger/Messenger.h>

int ledPin = 6;
#define digPin 13    // LED connected to digital pin 13
int relPin = 3;
int btnPin = 2;

int btnState = 0;

void setup()  {
  // nothing happens in setup
  pinMode(digPin, OUTPUT);
  pinMode(relPin, OUTPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(btnPin, INPUT);

  Serial.begin(9600);
}

void loop()  {
  btnState = digitalRead(btnPin);

  if (btnState == HIGH) {
    Serial.print("START\n");
    Serial.println("State:");
    Serial.println(10/2.0);
    Serial.println(btnState);
    digitalWrite(digPin, HIGH);   // set the LED on
    delay(250);                  // wait for a second
    digitalWrite(digPin, LOW);    // set the LED off
    delay(250);                  // wait for a second

    // fade in from min to max in increments of 5 points:
    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin, fadeValue);
      // wait for 30 milliseconds to see the dimming effect
      delay(10);
    }

    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin, fadeValue);
      // wait for 30 milliseconds to see the dimming effect
      delay(10);
    }


    analogWrite(relPin, 255);   // set the LED on
    delay(2500);                  // wait for a second
    digitalWrite(relPin, LOW);    // set the LED off
    delay(500);                  // wait for a second
  } //else {
  //
  //}
}
