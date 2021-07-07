# microcontrolleur STM32

première carte de prototypage achetée : F030R8

Le pinout est dispo içi : https://os.mbed.com/platforms/ST-Nucleo-F030R8/

elle comporte une interface ST-Link qui permet de télécharger les firmwares compilés, se présentant sous la forme de fichiers .bin, sur le microcontroleur, par simple copier-coller !

Pour compiler pour STM32 : 
- la solution de base est d'utiliser STM32cube, logiciel de la marque ST-micro et de faire du C bas niveau
- une alternative consiste à passer par platformio, si l'on veut des résultats rapides et recycler des codes arduino 

# platformio

platformio est intégré à Atom, mais si on veut bien comprendre ce qu'on fait, il peut être utile de l'utiliser en ligne de commande

il est souvent installé dans le home directory de l'utilisateur en cours, dans un répertoire .platformio

il faut lancer un environnement virtuel python pour pouvoir utiliser la ligne de commande de platformio :
```
cd .platformio/penv
source activate
```
On peut placer ses projets dans son home directory, à l'emplacement suivant : `Documents/PlatformIO/Projects` 

un projet platformio contient généralement un répertoire src avec les sources, qui peuvent se limiter à un seul fichier cpp. Voici quelques lignes qui font clignoter la LED 2 de la carte F030R8 toutes les secondes, en affichant "hello" sur le port série. 
```
#include <Arduino.h>

#ifndef LED_BUILTIN
  #define LED_BUILTIN PC13
#endif

void setup()
{
  // initialize LED digital pin as an output.
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
}

void loop()
{
  // turn the LED on (HIGH is the voltage level)
  digitalWrite(LED_BUILTIN, HIGH);
  // wait for a second
  delay(1000);
  // turn the LED off by making the voltage LOW
  digitalWrite(LED_BUILTIN, LOW);
   // wait for a second
  delay(1000);
  Serial.print("Hello\n");

}
```
Pour que platformio reconnaisse le projet, il faut avoir à la racine du projet un ficihier platformio.ini, précisant la plateforme, le type de carte et le framework de travail 
```
[env:nucleo_f030r8]
platform = ststm32
framework = arduino
board = nucleo_f030r8
```
Pour compiler, une fois positionné dans le répertoire du projet, on lance :
```
pio run
```
Si la library ststm32 et le compilateur gcc-arm-none-eabi ne sont pas présents sur le système, la commande `pio run` les installera

Pour réaliser cette installation manuellement : 
```
pio platform install "ststm32"

Platform Manager: Installing ststm32```
Downloading...
Unpacking...
Platform Manager: ststm32 @ 14.0.1 has been installed!
Tool Manager: Installing platformio/toolchain-gccarmnoneeabi @ >=1.60301.0,<1.80000.0
Downloading...
Unpacking...
Tool Manager: toolchain-gccarmnoneeabi @ 1.70201.0 has been installed!
The platform 'ststm32' has been successfully installed!
The rest of the packages will be installed later depending on your build environment.
```
cf https://platformio.org/platforms/ststm32/installation

la compilation crée un dossier ./pio/build/nucleo_f030r8 et y dépose tous les binaires

pour téléverser le binaire sur le microcontrolleur :

```
cp .pio/build/nucleo_f030r8/firmware.bin /media/alexandrecuer/NODE_F030R8/
```
Lors du téléversement, la LED1 sur l'interface ST-Link (qui est rouge si on n'a jamais téléversé depuis qu'on a mis la carte sous tension) se met à clignoter rouge/vert puis s'éclaire en vert si le téléversement est réussi.

Pour afficher les données arrivant sur le port série :
```
pio device monitor --port /dev/ttyACM0 --baud 9600
```

on trouve un certain nombre d'exemples içi :

https://github.com/platformio/platform-ststm32

# STM32Cube

Ce code generator va créer tous les patterns du projet

créer un compte my.st.com

https://my.st.com/content/my_st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-configurators-and-code-generators/stm32cubemx.html

https://www.st.com/stm32cube

Le logiciel s'installe dans : 

```
/usr/local/STMicroelectronics/STM32Cube/STM32CubeMX
```

On crée un nouveau projet en choisissant la carte dont on a fait l'acquisition (eg: F030R8)

Avec l'outil graphique, on configure le pin PA5, ou D13 en notation arduino (sur lequel la LED2 est branchée) sur GPIO_Output

Dans Project Settings, on donne à son projet : 
-  un nom, par exemple F030R8_1st, 
-  une localisation, par exemple la même que pour les projets platformio, ie `/home/alexandrecuer/Documents/PlatformIO/Projects`

Comme méthode de compilation (Toolchain / IDE) on choisit Makefile

Dans Code generator, on choisit de cocher les cases suivantes :
- copy all used libraries into the project folder
- generate peripheral initialization as pair of '.c/.h' files per peripheral
- keep User Code when re-generating
- set all free pins as analog

On clique sur GENERATE CODE

Il reste ensuite à modifier le fichier Core/Src/main.c, en ajoutant les lignes suivantes dans la boucle while de la section USER CODE :

```
/* Infinite loop */
/* USER CODE BEGIN WHILE */
while (1)
{
  HAL_GPIO_TogglePin(GPIOA, GPIO_PIN_5);
  HAL_Delay(200);
/* USER CODE END WHILE */

/* USER CODE BEGIN 3 */

}
/* USER CODE END 3 */
```

Pour compiler, un simple `make` à la racine du projet suffit.

Pour téléverser, on procéde comme on a fait lorsqu'on a compilé avec platformio
