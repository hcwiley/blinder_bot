int drivePow = 185;

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
    digitalWrite(dir_a, HIGH);
    digitalWrite(dir_b, HIGH);
    analogWrite(pwm_a, drivePow);
    analogWrite(pwm_b, drivePow);
    delay(50);
    analogWrite(pwm_a, 0);
    analogWrite(pwm_b, 0);
  }
  else if( readIn == 's'){
    digitalWrite(dir_a, LOW);
    digitalWrite(dir_b, LOW);
    analogWrite(pwm_a, drivePow);
    analogWrite(pwm_b, drivePow);
    delay(50);
    analogWrite(pwm_a, 0);
    analogWrite(pwm_b, 0);
  }
  else if( readIn == 'a'){
    digitalWrite(dir_a, LOW);
    digitalWrite(dir_b, HIGH);
    analogWrite(pwm_a, drivePow);
    analogWrite(pwm_b, drivePow);
    delay(50);
    analogWrite(pwm_a, 0);
    analogWrite(pwm_b, 0);
  }
  else if( readIn == 'd'){
    digitalWrite(dir_a, HIGH);
    digitalWrite(dir_b, LOW);
    analogWrite(pwm_a, drivePow);
    analogWrite(pwm_b, drivePow);
    delay(50);
    analogWrite(pwm_a, 0);
    analogWrite(pwm_b, 0);
  }
}
