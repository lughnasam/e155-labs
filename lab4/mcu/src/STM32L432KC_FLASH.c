// STM32L432KC_FLASH.c
// Name: Lughnasa Miller
// Date: 6.11.2025
// Source code for FLASH functions

#include "STM32L432KC_FLASH.h"

// configure memory allocation
void configureFlash() {
    FLASH->ACR |= (0b100); // Set to 4 waitstates
    FLASH->ACR |= (1 << 8); // Turn on the ART
}