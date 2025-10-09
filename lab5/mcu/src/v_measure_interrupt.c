/*
Name: Lughnasa Miller
Email: lumiller@hmc.edu
Date: 10/8/2025
Description: Interrupt-based main code for lab 5
*/

#include "main.h"
#include "STM32L432KC.h"

volatile uint32_t edge_count;
volatile uint32_t direction;
volatile uint32_t last_triggered;

int main(void) {
    // enable QE_A reader input
    gpioEnable(GPIO_PORT_A);
    pinMode(QE_A_PIN, GPIO_INPUT);
    GPIOA->PUPDR &= ~(_VAL2FLD(GPIO_PUPDR_PUPD0, 0b11));

    // enable QE_B reader input
    gpioEnable(GPIO_PORT_B);
    pinmode(QE_B_PIN, GPIO_INPUT);
    GPIOB->PUPDR &= ~(_VAL2FLD(GPIO_PUPDR_PUP1, 0b11));

    // initialize timer TIMx for use
    RCC->APB2ENR |= RCC_APB1ENR1_TIM2EN;
    initTIMwINT(DELAY_TIM, LOOP_TIME);

    // enable SYSCFG clock domain
    RCC->APB2ENR |= RCC_APB2ENR_SYSCFGEN;

    //configure EXTICR for pin X
    SYSCFG->EXTICR[1] |= _VAL2FLD(SYSCFG_EXTICR1_EXTI0, 0b000);

    //configure EXTICR for pin Y
    SYSCFG->EXTICR[1] |= _VAL2FLD(SYSCFG_EXTICR1_EXTI1, 0b001);

    //enable global interrupts
    __enable_irq();

    // configure mask bit for QE pins
    EXTI->IMR1 |= (1 << gpioPinOffset(QE_A_PIN));
    EXTI->IMR1 |= (1 << gpioPinOffset(QE_B_PIN));

    // enable rising edge triggers for pins
    EXTI->RTSR1 |= (1 << gpioPinOffset(QE_A_PIN));
    EXTI->RTSR1 |= (1 << gpioPinOffset(QE_B_PIN));

    // enable falling edge triggers for pins
    EXTI->FTSR1 |= (1 << gpioPinOffset(QE_A_PIN));
    EXTI->FTSR1 |= (1 << gpioPinOffset(QE_B_PIN));

    // turn on EXTI interrupts in NVIC_ISER
    NVIC->ISER[0] |= (1 << EXTI0_IRQn);
    NVIC->ISER[0] |= (1 << EXTI1_IRQn);


}


void EXTI0_IRQHandler(void){
    // increment edge counter
    edge_count++;

    // if this edge triggers twice (turns around), 
    // change direction
    if (last_triggered == 0) {
        direction = ~direction;
    }
    
    // set this edge as last triggered
    last_triggered = 0;

    // clear the pending interrupt
    EXTI->PR1 &= ~(1 << 0);
}

void EXTI1_IRQHandler(void){
    // increment edge counter
    edge_count++;

    // if this edge triggers twice (turns around), 
    // change direction
    if (last_triggered == 0) {
        direction = ~direction;
    }
}

void TIM2_IRQHandler(void){
    int32_t velocity = edge_count / 4;
    int32_t neg_velocity = velocity * direction;
    if (direction == 0) {
        print("Velocity = %d; Direction = CCW")
    }
}