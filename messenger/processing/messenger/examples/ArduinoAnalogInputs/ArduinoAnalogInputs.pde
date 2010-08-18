/*
This example parses a message that contains the values of an Arduino's 
analog inputs and displays them as rectangles.
The message must be composed of the readings of the 6 inputs. Each reading
is separated by a space (' ') and terminated by a carriage return and line feed
*/


import processing.serial.*;
import messenger.*;


Messenger myMessenger = new Messenger(this);
Serial serialPort;  
int[] values = {0,0,0,0,0,0};

// Callback function
void message() {
 
 int i = 0;
 while ( myMessenger.available() && i < values.length) {
   int v = myMessenger.readInt();
     values[i] = v;
     i++;
  } 
}

void setup() {

  size(420,150);

  frameRate(30);
  stroke(255);
  println("Available ports:");
  println(Serial.list());
  String port = "COM8";
  println("Opening: "+port);
  serialPort = new Serial(this, port, 115200);

  myMessenger.attach("message");

}


void draw() { 
  background(0);
  fill(255);
  
  while (serialPort.available() > 0) myMessenger.process(serialPort.readChar());

   for (int i =0; i < 6; i++ ) {
     rect(12+(i*((width-24)/6.0)),25,((width-24)/6.0)-4,values[i]/10); //
  } 
}
