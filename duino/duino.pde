/*
 * Arduin v2
 *
 *
 *  /home/nofxx/projects/ardo/control
 *
 *
 */

#define SEC  1000
#define MIN  60000
#define HOUR 3600000
#define DAY  86400000
#define MAX  50

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

// Intervals (s)
unsigned long sync  = 5 * SEC;
unsigned long time_now, last_sync;

int i = 0;
int btnState = 0;
int touchState = 0;
int motorState = 0;

char outbuf[MAX];
char cmdbuf[MAX];

volatile int rx_state = LOW;
volatile int tx_state = LOW;


unsigned long mintomilli(unsigned long m) {
  return(m * 60000);
}

int ctoi( int c )
{
  return c - '0';
}

/*

  Read Sensors Data

*/
void read_sensors() {
  sprintf(outbuf, "i0:%d,i1:%d,i2:%d,i3:%d,i4:%d,i5:%d,d11:%d,d12:%d",
          analogRead(i0),
          analogRead(i1),
          analogRead(i2),
          analogRead(i3),
          analogRead(i4),
          analogRead(i5),
          digitalRead(d11),
          digitalRead(d12));

  Serial.println(outbuf);
}

void switch_pin(int pin) {
  analogWrite(pin, digitalRead(pin) == 0 ? 999 : 0);
}

void pulse_pin(int pin) {
  analogWrite(pin, HIGH);
  delay(500);
  analogWrite(pin, LOW);
}

/*

  Command Protocol -> NNvvv
  2 bytes pin number NN
  3 bytes value vvv
  Split commands with ','

  13500,130,13999

  Pin 13 -> 500 -> 000 -> 999

*/
void read_commands() {
  char c;
  while( Serial.available() && c != '\n' ) {  // buffer up a line
    c = Serial.read();
    if (c == '\n' || c == ',') {
      Serial.println("<<");
      int pin; int val;
      pin = (ctoi(cmdbuf[0])*10) + ctoi(cmdbuf[1]);
      val = (ctoi(cmdbuf[2])*100) + (ctoi(cmdbuf[3])*10) + ctoi(cmdbuf[4]);
      Serial.println("<<");
      analogWrite(pin, val);
      i = 0;
    } else if (c == 'x') {
      read_sensors();
    } else {
      cmdbuf[i++] = c;
    }
  }
}

void setup()  {
  // Atmega defaults INPUT
  pinMode(infoPin, OUTPUT);
  pinMode(rxPin, OUTPUT);
  pinMode(txPin, OUTPUT);
  for (int k=0;k<=7;k++)
    pinMode(k,OUTPUT);
  // pinMode(d2, OUTPUT);
  // pinMode(d3, OUTPUT);
  // pinMode(d4, OUTPUT);
  // pinMode(d5, OUTPUT);
  // pinMode(d6, OUTPUT);
  // pinMode(d7, OUTPUT);
  // pinMode(d10, OUTPUT);
  // digitalWrite(rxPin, 0); FAIL
  // digitalWrite(txPin, 0);


  //  attachInterrupt(0, btnLed, CHANGE);
  Serial.begin(115200);
}


void loop()  {
  time_now = millis();

  read_commands();

  // Sync over wire
  if ( abs(time_now - last_sync) >= sync) {
    last_sync = time_now;
    read_sensors();
  }


}


// void btnLed() {
//   if(digitalRead(d2) == 1) {
//     Serial.println("BUTTON");
//     digitalWrite(infoPin, HIGH);
//     analogWrite(d3, 250);
//     if (motorState != 0) {
//       motorState = 0;
//     } else {
//       motorState = 1;
//     }
//   } else {
//     digitalWrite(infoPin, LOW);
//     analogWrite(d3, LOW);
//   }

// }


  // if (motorState != 0) {
  //   analogWrite(d10, (analogRead(i1)/5));
  // } else {
  //   analogWrite(d10, 0);
  // }

  // noInterrupts();
  //  interrupts();

    // Terminate message with a linefeed and a carriage return
    // Serial.print(13,BYTE);
    // Serial.print(10,BYTE);

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

    // if (analogRead(i2) > 200) {
    //   analogWrite(d3, 0);
    // } else {
    //   analogWrite(d3, 250);
    // }



// void pulseJob(pin) {
//   analogWrite(pin, 250);
//   delay(2000);
//   analogWrite(pin, LOW);
// }

// From Doorduino
// http://github.com/martymcguire/Doorduino/blob/master/Doorduino.pde
// Log a system message to console
// void log(char* message)
// {
//   static char timeString[20];
//   getTime(timeString);

//   Serial.print("[");
//   Serial.print(timeString);
//   Serial.print("] DOOR: ");
//   Serial.println(message);

// }

// void readRTC(time& currentTime)
// {
//   Wire.beginTransmission(DS1307);
//   Wire.send(R_SECS);
//   Wire.endTransmission();

//   Wire.requestFrom(DS1307, 7);
//   currentTime.second = bcd2Dec(Wire.receive());
//   currentTime.minute = bcd2Dec(Wire.receive());
//   currentTime.hour = bcd2Dec(Wire.receive());
//   currentTime.wkDay = bcd2Dec(Wire.receive());
//   currentTime.day = bcd2Dec(Wire.receive());
//   currentTime.month = bcd2Dec(Wire.receive());
//   currentTime.year = bcd2Dec(Wire.receive());
// }


// void setRTC(time& newTime)
// {
//   Wire.beginTransmission(DS1307);
//   Wire.send(dec2Bcd(R_SECS));
//   Wire.send(dec2Bcd(newTime.second));
//   Wire.send(dec2Bcd(newTime.minute));
//   Wire.send(dec2Bcd(newTime.hour));
//   Wire.send(dec2Bcd(newTime.wkDay));
//   Wire.send(dec2Bcd(newTime.day));
//   Wire.send(dec2Bcd(newTime.month));
//   Wire.send(dec2Bcd(newTime.year));
//   Wire.endTransmission();
// }


// Build a human-readable representation of the current time
// @string character array to put the time in, must be 20 bytes long
// void getTime(char* string)
// {
//   // Grab the latest time from the RTC
//   time currentTime;
//   readRTC(currentTime);

//   // And build a formatted string to represent it
//   sprintf(string, "20%02d-%02d-%02dT%02d:%02d:%02dZ",
//                   currentTime.year, currentTime.month, currentTime.day,
//                   currentTime.hour, currentTime.minute, currentTime.second);
// }


// void setTimeFromSerial()
// {
//   time newTime;

//   char temp = 0;

//   // Wait for full time to be received
//   for (int i = 0; i < 7; i++)
//   {
//     while (Serial.available() == 0) {}

//     temp = Serial.read();

//     switch (i) {
//       case 0: newTime.year = temp; break;
//       case 1: newTime.month = temp; break;
//       case 2: newTime.day = temp; break;
//       case 3: newTime.wkDay = temp; break;
//       case 4: newTime.hour = temp; break;
//       case 5: newTime.minute = temp; break;
//       case 6: newTime.second = temp; break;
//     }
//   }

//   setRTC(newTime);
// }


byte bcd2Dec(byte bcdVal)
{
  return bcdVal / 16 * 10 + bcdVal % 16;
}

byte dec2Bcd(byte decVal)
{
  return decVal / 10 * 16 + decVal % 10;
}
