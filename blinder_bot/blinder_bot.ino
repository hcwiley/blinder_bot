int drivePow = 185;
int del = 10;

int pwm_a = 3;  //PWM control for motor outputs 1 and 2 is on digital pin 3
int pwm_b = 11;  //PWM control for motor outputs 3 and 4 is on digital pin 11
int dir_a = 12;  //dir control for motor outputs 1 and 2 is on digital pin 12
int dir_b = 13;  //dir control for motor outputs 3 and 4 is on digital pin 13

void setup() {
  pinMode(pwm_a, OUTPUT);  //Set control pins to be outputs
  pinMode(pwm_b, OUTPUT);
  pinMode(dir_a, OUTPUT);
  pinMode(dir_b, OUTPUT);
  Serial.begin(9600);
  Serial.println("hey");
}

void loop() {
  while(!Serial.available()){
  }
  char readIn = Serial.read();
  if(readIn == 'w'){
    drivePow = 255;
    digitalWrite(dir_a, HIGH);
    digitalWrite(dir_b, HIGH);
    analogWrite(pwm_a, drivePow);
    analogWrite(pwm_b, drivePow);
    delay(del);
    analogWrite(pwm_a, 0);
    analogWrite(pwm_b, 0);
  }
  else if( readIn == 's'){
    drivePow = 225;
    digitalWrite(dir_a, LOW);
    digitalWrite(dir_b, LOW);
    analogWrite(pwm_a, drivePow);
    analogWrite(pwm_b, drivePow);
    delay(del);
    analogWrite(pwm_a, 0);
    analogWrite(pwm_b, 0);
  }
  else if( readIn == 'a'){
    drivePow = 185;
    digitalWrite(dir_a, HIGH);
    digitalWrite(dir_b, LOW);
    analogWrite(pwm_a, drivePow);
    analogWrite(pwm_b, drivePow);
    delay(del);
    analogWrite(pwm_a, 0);
    analogWrite(pwm_b, 0);
  }
  else if( readIn == 'd'){
    drivePow = 185;
    digitalWrite(dir_a, LOW);
    digitalWrite(dir_b, HIGH);
    analogWrite(pwm_a, drivePow);
    analogWrite(pwm_b, drivePow);
    delay(del);
    analogWrite(pwm_a, 0);
    analogWrite(pwm_b, 0);
  }
}
