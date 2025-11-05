// DS1722.h
// Lughnasa Miller
// lumiller@hmc.edu
// 23.10.25
// This file is a driver for reading temperature from a DS1722 board

#include "STM32L432KC.h"
#include "STM32L432KC_SPI.h"


void ds1722_init(int precision);
float ds1722_temp_read(void);