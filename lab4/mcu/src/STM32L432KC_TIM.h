// STM32L432KC_TIM.h
// Name: Lughnasa Miller
// Date: 6.11.2025
// Header for TIM functions

#ifndef STM32L4_TIM_H
#define STM32L4_TIM_H

#include <stdint.h> // Include stdint header

#define SystemCoreClock 80000000
#define PWM_PSC 15

#define TIM15_BASE (0x40014000UL) 
#define TIM16_BASE (0x40014400UL) 

typedef struct {
    volatile uint32_t CR1; // 0x00
    volatile uint32_t CR2; // 0x04
    volatile uint32_t SMCR; // 0x08
    volatile uint32_t DIER; // 0x0C
    volatile uint32_t SR; // 0x10
    volatile uint32_t EGR; // 0x14
    volatile uint32_t CCMR1; // 0x18
    volatile uint32_t CCMR2; // 0x1C
    volatile uint32_t CCER; // 0x20
    volatile uint32_t CNT; // 0x24
    volatile uint32_t PSC; // 0x28
    volatile uint32_t ARR; // 0x2C
    volatile uint32_t RCR; // 0x30
    volatile uint32_t CCR1; // 0x34
    volatile uint32_t CCR2; // 0x38
    volatile uint32_t CCR3; // 0x3C
    volatile uint32_t CCR4; // 0x40
    volatile uint32_t BDTR; // 0x44
    volatile uint32_t DCR; // 0x48
    volatile uint32_t DMAR; // 0x4C
    volatile uint32_t OR1; // 0x50
    volatile uint32_t CCMR3; // 0x54
    volatile uint32_t CCR5; // 0x58
    volatile uint32_t CCR6; // 0x5C
    volatile uint32_t OR2; // 0x60
    volatile uint32_t OR3; // 0x64

} TIMx_TypeDef;

#define TIM15 ((TIMx_TypeDef *) TIM15_BASE)
#define TIM16 ((TIMx_TypeDef *) TIM16_BASE)

///////////////////////////////////////////////////////////////////////////////
// Function prototypes
///////////////////////////////////////////////////////////////////////////////

void initTIM(TIMx_TypeDef * TIMx);
void initPWM(TIMx_TypeDef * TIMx);
void setPWMFreq(TIMx_TypeDef * TIMx, uint32_t pitch);
void delay_millis(TIMx_TypeDef * TIMx, uint32_t ms);

#endif