/**
    Main Header: Contains general defines and selected portions of CMSIS files
    @file main.h
    @author Josh Brake
    @version 1.0 10/7/2020
*/

#ifndef MAIN_H
#define MAIN_H

#include "../lib/STM32L432KC.h"
#include "../lib/DS1722.h"

#define LED_PIN PA6 // LED pin for blinking on Port B pin 3
#define BUFF_LEN 32
#define BITRES_8  8   // specifies 8 bit resolution for ds1722
#define BITRES_9  9   // specifies 9 bit resolution for ds1722
#define BITRES_10 10  // specifies 10 bit resolution for ds1722
#define BITRES_11 11  // specifies 11 bit resolution for ds1722
#define BITRES_12 12  // specifies 12 bit resolution for ds1722

#endif // MAIN_H