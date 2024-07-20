#include <Servo.h>
#include "V3.h"

//arm difference due to motor positioning
#define armLen1 85.0
#define armLen2 110.0

//offset is caused by the structure of the arm
//base of arm + offset = bottom left corner of working area.
V3 offset { 75, -75, -20 };

void moveToPoint(V3* point, int steps = 10, int interval = 10);

float degToRad(float deg) { return deg / 180 * PI; }
float radToDeg(float rad) { return rad / PI * 180; }
float degAtan(float num) { return radToDeg(atan(num)); }
float degAcos(float num) { return radToDeg(acos(num)); }
float degAsin(float num) { return radToDeg(asin(num)); }

Servo base;
Servo arm1;
Servo arm2;

V3 currentPoint = {0, 0, 25}; // 0 0 0 = bottom left corner

void setup() {
  base.attach(9);
  arm1.attach(10);
  arm2.attach(11);
  
  Serial.begin(9600);
  
  moveToPoint(&currentPoint, 1);
}

void moveToPoint(V3* point, int steps, int interval) {
  
  for(int i = 0; i < steps; i++)
  {
    Serial.print(" i: ");
    Serial.print(i);
    
    V3 stepPoint = {
      (((point->x-currentPoint.x)) / steps) * i + currentPoint.x + offset.x,
      (((point->y-currentPoint.y) / steps)) * i + currentPoint.y + offset.y,
      (((point->z-currentPoint.z)) / steps) * i + currentPoint.z + offset.z
    };
    Serial.print(" x: ");
    Serial.print(stepPoint.x);
    Serial.print(" y: ");
    Serial.print(stepPoint.y);
    Serial.print(" z: ");
    Serial.print(stepPoint.z);
    
    base.write(degAtan(abs(stepPoint.y)/abs(stepPoint.x)) * (stepPoint.y > 0 ? 1 : -1) + 90);
    
    //calculate arm rotations based on law of cosines
    float requiredLength = sqrt(stepPoint.x*stepPoint.x+stepPoint.y*stepPoint.y+stepPoint.z*stepPoint.z);
    Serial.print(" reqiored Length: ");
    Serial.print(requiredLength);
    
    
    arm1.write(180-degAcos((armLen1*armLen1 + requiredLength*requiredLength - armLen2*armLen2) / (2*armLen1*requiredLength))
    - degAsin(stepPoint.z/requiredLength)
    );
    Serial.print(" bottomangle: ");
    Serial.print(degAcos((armLen1*armLen1 + requiredLength*requiredLength - armLen2*armLen2) / (2*armLen1*requiredLength))
    - degAsin(stepPoint.z/requiredLength)*0);
    
    arm2.write(180-degAcos((armLen1*armLen1 + armLen2*armLen2 - requiredLength*requiredLength) / (2*armLen1*armLen2)));
    Serial.print(" topangle: ");
    Serial.print(degAcos((armLen1*armLen1 + armLen2*armLen2 - requiredLength*requiredLength) / (2*armLen1*armLen2)));
    
    Serial.print("\n");
    
    delay(interval);
  }
  
  currentPoint.x = point->x;
  currentPoint.y = point->y;
  currentPoint.z = point->z;
}

void pressAt(V3 at)
{
  V3 aboveAt = {at.x, at.y, 50};
  V3 belowAt = {at.x, at.y, -10};
  moveToPoint(&aboveAt);
  moveToPoint(&belowAt, 5, 10);
  moveToPoint(&aboveAt, 5, 10);
}

void loop() {
  V3 startBattle = {75, 40, 0};
  V3 troopSpawn = {80, 20, 0}; // first troop
  // V3 troopSpawn = {90, 20, 0}; // second troop
  // V3 troopSpawn = {100, 20, 0}; // third troop
  pressAt(startBattle);
  pressAt(startBattle);
  for(int i = 0; i < 10; i++)
  {
    pressAt(troopSpawn);
  }
}
