#include <Arduino.h>

#define pin 2
#define step 10000 // pas de temps en milli-secondes
#define DEBUG 0
#define DHT11 0
unsigned long NBCYCLES;
unsigned long start;
unsigned long now;
float rh;
float temp;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  NBCYCLES = microsecondsToClockCycles(1000);
  Serial.println(NBCYCLES);
  // initialisation de start
  start = millis();  
}

void loop() {
  // put your main code here, to run repeatedly:
  // doit-on interroger le capteur ?
  now = millis();
  if (now - start >= step)
  {
    start = millis();
    uint8_t status = readDHT();
    if (status==0)
    {
      Serial.print("humidity : ");
      Serial.println(rh);
      Serial.print("temperature : ");
      Serial.println(temp);
      Serial.println();
    }
    else 
    {
      Serial.print("erreur ");
      Serial.println(status);
    }
  }
}

int readDHT() {
  /*
   * demande et décode la réponse numérique d'un capteur DHT22 ou DHT11
   * retourne 0 en cas de succès 
   * -2 : timeout
   * -1 : erreur de checksum - paquet corrompu
   */
  // start signal
  pinMode(pin,OUTPUT);
  digitalWrite(pin,LOW);
  delay(18);
  // pullup voltage
  digitalWrite(pin,HIGH);
  delayMicroseconds(40);
  // pin en lecture
  pinMode(pin,INPUT);

  uint8_t bits[5];
  uint8_t idx = 0;
  uint8_t cnt = 7;
  unsigned long loopc;
  for(uint8_t i=0; i<5; i++) bits[i]=0;

  // response signal from sensor
  loopc = NBCYCLES;
  while(digitalRead(pin) == LOW)
      if (loopc-- == 0) return -2;
  // pullup voltage from sensor
  loopc = NBCYCLES;
  while(digitalRead(pin) == HIGH)
      if (loopc-- == 0) return -2;

  /*
   * on lit les 5 octets = 40 bits constituant la réponse du capteur
   */
  for(uint8_t i=0; i<40; i++)
  {
     loopc = NBCYCLES;
     while(digitalRead(pin) == LOW)
         if (loopc-- == 0) return -2;
     unsigned long t = micros();
     loopc = NBCYCLES;
     while(digitalRead(pin) == HIGH)
         if (loopc-- == 0) return -2;
     if ((micros()-t) > 40) bits[idx] |= (1 << cnt);
     if (cnt == 0)
     {
      // on passe a l'octet/bytes suivant
      cnt=7;
      idx++;
     } // on passe au bit suivant
     else cnt--;
  }

  // calcul du checksum théorique
  uint8_t sum = bits[0]+bits[1]+bits[2]+bits[3];
  
  if (DEBUG){
    for (uint8_t i=0;i<5;i++)
    {
      Serial.print(bits[i],BIN);
      Serial.print(" soit en decimal ");
      Serial.println(bits[i]);
    }
    Serial.print("Theorik checksum ");Serial.println(sum);
  }
  
  if (bits[4] != sum) return -1;
  
  if(DHT11){
    rh=bits[0];
    temp=bits[2];
  }
  else
  {
    rh = bits[0] << 8 | bits[1];
    rh *= 0.1;
  
    temp = (bits[2] & 0x7F) << 8 | bits[3];
    temp *= 0.1;
    // on évalue le signe
    if (bits[2] & 0x80) temp *= -1;
  }
  
  return 0;
  
}
