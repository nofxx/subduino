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
int tempPin = 2;
int lightPin = 1;

int btnState = 0;
int tempVal  = 0;
int lightVal  = 0;

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

  tempVal = analogRead(tempPin);
  lightVal = analogRead(lightPin);
  digitalWrite(ledPin, HIGH);  // turn the ledPin on
  delay(1000);                  // stop the program for some time
  digitalWrite(ledPin, LOW);   // turn the ledPin off
  delay(1000);                  // stop the program for some time
  Serial.print("TEMP:");
  Serial.println(tempVal);
  if (lightVal > 200) {
    analogWrite(relPin, 0);
  } else {
    analogWrite(relPin, 250);
  }
  Serial.print("LIGHT:");
  Serial.println(lightVal);

}
