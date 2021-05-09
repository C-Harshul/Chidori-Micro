#include "Wire.h"       
#include "I2Cdev.h"     
#include "MPU6050.h"    
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
 
const char* ssid = "Y9_2019";
const char* password = "10201020";

MPU6050 mpu;
int16_t ax, ay, az;
int16_t gx, gy, gz;
int pos = 5;
int pos_i = 5;
int pos_list[8] = {0,0,0,0,0,0,0,0};
int flag = 0;

#define LED D5

struct MyData {
  byte X;
  byte Y;
};  

MyData data;

void setup()
{
  Serial.begin(115200);
  Wire.begin();
  mpu.initialize();
  pinMode(LED, OUTPUT);
  pinMode(D6,OUTPUT);
  
  WiFi.begin(ssid, password); 
  while (WiFi.status() != WL_CONNECTED) { 
    delay(1000);
    Serial.print("Connecting.."); 
  }
  
  Serial.println("Data collecting......");
}

void loop()
{
  if (WiFi.status() == WL_CONNECTED) { //Check WiFi connection status
    HTTPClient http;  //Declare an object of class HTTPClient
    http.begin("http://security-glove.herokuapp.com/notify");  //Specify request destination

    mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
    data.X = map(ax, -17000, 17000, 0, 255 ); // X axis data
    data.Y = map(ay, -17000, 17000, 0, 255);  // Y axis data
    delay(250);
  
    if (data.Y < 40)   {   pos = 1;  } //gesture : down 
    if (data.Y > 185)  {  pos = 2;   } //gesture : up
    if (data.X > 200)  {  pos = 3;   } //gesture : left
    if (data.X < 35)   {  pos = 4;   } //gesture : right
    if (data.X > 150 && data.X < 170 && data.Y > 100 && data.Y < 135) {  pos = 5;  } //gesture : little bit down
  
  //Noting the sequence of gestures
    if (pos_i != pos){  
        pos_i = pos;  pos_list[flag]= pos;    flag = flag + 1;  
        if( flag == 8){ flag = 0; }
        for (byte i = 0; i < 8; i = i + 1) {  Serial.print(pos_list[i]);  }
        Serial.println();
        }
  
  //Identifying unique gesture sequence
    int one= 0; int two= 0; int five= 0;
    for (byte j = 0; j < 8; j = j + 1){
      if ( pos_list[j]== 1){  one = one + 1;  }
      if ( pos_list[j]== 2){  two = two + 1;  }
      if ( pos_list[j]== 5){  five = five + 1;  }
      }
  
  //Confirming the unique gesture sequence
    if ( (one > 1 and two > 2) or (one > 2 and two > 1) or (one > 2 and five > 2) or (two > 2 and five > 2)){
      Serial.println("TURN ON");  Serial.println("ALERT");  Serial.println("SOS NOTIFICATION PROCESSED");
      for (byte i = 0; i < 8; i = i + 1) {
          pos_list[i] = 0;  flag = 0;
          }
      digitalWrite(LED, HIGH);
      delay(500);
      digitalWrite(LED,LOW);
      delay(500);
      digitalWrite(LED, HIGH);
      delay(500);
      digitalWrite(LED,LOW);
      delay(500);
      digitalWrite(LED, HIGH);
      delay(500);
      digitalWrite(LED,LOW);

      digitalWrite(D6,HIGH);
      int httpCode = http.GET();  
      if (httpCode > 0) { //Check the returning code
        String payload = http.getString();   //Get the request response payload
        Serial.println(payload);             //Print the response payload 
        }
      }
  http.end();   //Close connection
  }
}
