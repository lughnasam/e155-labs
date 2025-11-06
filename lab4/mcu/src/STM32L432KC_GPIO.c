// STM32L432KC_GPIO.c
// Name: Lughnasa Miller
// Date: 6.11.2025
// Source code for GPIO functions

#include "STM32L432KC_GPIO.h"
#include "STM32L432KC_RCC.h"

//set pinmode for given GPIO pin
void pinMode(int pin, int function) {
    switch(function) {
        case GPIO_INPUT:
            GPIO->MODER &= ~(0b11 << 2*pin);
            break;
        case GPIO_OUTPUT:
            GPIO->MODER |= (0b1 << 2*pin);
            GPIO->MODER &= ~(0b1 << (2*pin+1));
            break;
        case GPIO_ALT:
            GPIO->MODER &= ~(0b1 << 2*pin);
            GPIO->MODER |= (0b1 << (2*pin+1));
            break;
        case GPIO_ANALOG:
            GPIO->MODER |= (0b11 << 2*pin);
            break;
    }
}

// read pin value
int digitalRead(int pin) {
    return ((GPIO->IDR) >> pin) & 1;
}

// update pin value
void digitalWrite(int pin, int val) {
    GPIO->ODR |= (1 << pin);
}

//toggle pin value
void togglePin(int pin) {
    // Use XOR to toggle
    GPIO->ODR ^= (1 << pin);
}