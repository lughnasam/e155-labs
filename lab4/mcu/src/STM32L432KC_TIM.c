// STM32F401RE_TIM.c
// TIM functions

#include "STM32L432KC_TIM.h"
#include "STM32L432KC_RCC.h"

#define PWM_PSC 16

void initTIM(TIM_TypeDef * TIMx){
  // Set prescaler to give 1 ms time base
  uint32_t psc_div = (uint32_t) ((SystemCoreClock/1e3));

  // Set prescaler division factor
  TIMx->PSC = (psc_div - 1);
  // Generate an update event to update prescaler value
  TIMx->EGR |= 1;
  // Enable counter
  TIMx->CR1 |= 1; // Set CEN = 1
}

void initPWM(TIM_TypeDef * TIMx, uint32_t freq){
  uint32_t psc_div = (uint32_t) ((SystemCoreClock/1e3));

  // set prescaler division factor
  TIMx->PSC = PWM_PSC - 1;

  // set auto reload value
  TIMx->ARR = SystemCoreClock / (PWM_PSC * freq);

  // enable autoreload
  TIMx->CR1 |= (1 << 7);

  // enable PWM mode
  TIMx->CCMR1 &= ~(1 << 16);
  TIMx->CCMR1 &= ~(0b111 << 4);
  TIMx->CCMR1 |= (0b110 << 4);

  // set duty cycle
  TIMx->CCR1 = (TIMx->ARR + 1) / 2;

  // update values for shadow register
  TIMx->EGR |= 1;
}

void delay_millis(TIM_TypeDef * TIMx, uint32_t ms){
  TIMx->ARR = ms;// Set timer max count
  TIMx->EGR |= 1;     // Force update
  TIMx->SR &= ~(0x1); // Clear UIF
  TIMx->CNT = 0;      // Reset count

  while(!(TIMx->SR & 1)); // Wait for UIF to go high
}