// DS1722.c
// Lughnasa Miller
// lumiller@hmc.edu
// 23.10.25
// This file is a driver for reading temperature from a DS1722 board

#include "STM32L432KC.h"
#include "STM32L432KC_SPI.h"
#include "DS1722.h"

// This function initializes SPI communication on the DS1722 board
// precision specifies the number of bits of precision desired for measurement
void ds1722_init(int precision){
    // determine our enable based on precision input
    char enable;
    switch(precision) {
        case 8:
            enable = 0xE0;
            break;
        case 10:
            enable = 0xE4;
            break;
        case 11: 
            enable = 0xE6;
            break;
        case 12: 
            enable = 0xE8;
            break;
        default: 
            enable = 0xE2;

    }
    
    digitalWrite(SPI_CE, PIO_LOW);
    digitalWrite(SPI_CE, PIO_HIGH);
    spiSendReceive(0x80); // csr address
    spiSendReceive(enable);
    digitalWrite(SPI_CE, PIO_LOW);
}

// this function reads the upper and lower bits of
float ds1722_temp_read(void) {
    //read upper bits
    digitalWrite(SPI_CE, PIO_HIGH);
    spiSendReceive(0x02);
    char upper = spiSendReceive(0x00);
    digitalWrite(SPI_CE, PIO_LOW);
    printf("upper: %d\n", upper);

    //read lower bits
    digitalWrite(SPI_CE, PIO_HIGH);
    spiSendReceive(0x01);
    char lower = spiSendReceive(0x01);
    digitalWrite(SPI_CE, PIO_LOW);
    printf("lower: %d\n", lower);

    int16_t temp = ((int16_t) upper << 8) | ((int16_t) lower);
    float tempOut = (((float) temp) / 256.0);
   
    return tempOut;
}

