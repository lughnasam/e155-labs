// STM32L432KC_TIM.c
// Name: Lughnasa Miller
// Date: 6.11.2025
// TIM functions

#include "STM32L432KC_TIM.h"
#include "STM32L432KC_RCC.h"

// initialize timer for basic use
void initTIM(TIMx_TypeDef * TIMx) {
  //enable clock

  // Set prescaler to give 1 ms time base
  uint32_t psc_div = (uint32_t) ((SystemCoreClock/2e3));

  // Set prescaler division factor
  TIMx->PSC = (psc_div - 1);
  // Generate an update event to update prescaler value
  TIMx->EGR |= 1;
  // Enable counter
  TIMx->CR1 |= 1; // Set CEN = 1
}

// intialize timer for PWM use
void initPWM(TIMx_TypeDef * TIMx) {
  // set timers to GPIO pins, PWM mode
  TIMx->CCMR1 &= ~(0b111 << 4); //reset field
  TIMx->CCMR1 |= (0b110 << 4); // PWM mode
  TIMx->CCER |= (1 << 0); // OC1 signal
  TIMx->CCMR1 |= (1 << 3); // output compare 1 preload en
  TIMx->BDTR |= (1 << 15); // set MOE
  TIMx->CCMR1 |= (1 << 4); // //preload oc1 enable

  // update shadow register
  TIMx->EGR |= (1 << 0);

  // enable the counter
  TIMx->CR1 |= (1 << 0);

  
}

// set PWM frequency with 50% duty cycle
void setPWMFreq(TIMx_TypeDef * TIMx, uint32_t freq){
  // calculate prescaler
  uint32_t psc_div = (uint32_t) ((SystemCoreClock/1e3));

  // set prescaler division factor
  TIMx->PSC = PWM_PSC - 1;

  // calculate auto-reload value
  uint32_t arr = SystemCoreClock / ((PWM_PSC + 1) * freq);

  // set parameters
  TIMx->ARR = arr; // autoreload
  TIMx->PSC = PWM_PSC; // prescaler
  TIMx->CCR1 = arr / 2; // pwm duty cycle

  // update values for shadow register
  TIMx->EGR |= 1;
}

// use timer to generate ms delay
void delay_millis(TIMx_TypeDef * TIMx, uint32_t ms){
  TIMx->ARR = 2 * ms;// Set timer max count
  TIMx->EGR |= 1;     // Force update
  TIMx->SR &= ~(0x1); // Clear UIF
  TIMx->CNT = 0;      // Reset count

  while(!(TIMx->SR & 1)); // Wait for UIF to go high
  TIMx->SR &= ~(1 << 0);
}