/*
Name: Lughnasa Miller
Email: lumiller@hmc.edu
Date: 10/8/2025
Description: Interrupt-based main code for lab 5
*/

#include "main.h"
#include "STM32L432KC.h"
#include <stm32l432xx.h>

volatile uint32_t edge_count = 0;
volatile uint32_t direction = 0;
volatile uint32_t last_triggered = 0;

int main(void) {
    // enable QE_A reader input
    gpioEnable(GPIO_PORT_A);
    pinMode(QE_A_PIN, GPIO_INPUT);
    GPIOA->PUPDR &= ~(_VAL2FLD(GPIO_PUPDR_PUPD1, 0b11));
    GPIOA->PUPDR |= (_VAL2FLD(GPIO_PUPDR_PUPD1, 0b01));
    pinMode(QE_B_PIN, GPIO_INPUT);
    GPIOA->PUPDR &= ~(_VAL2FLD(GPIO_PUPDR_PUPD2, 0b11));
    GPIOA->PUPDR |= (_VAL2FLD(GPIO_PUPDR_PUPD2, 0b01));

    // enable SYSCFG clock domain
    RCC->APB2ENR |= RCC_APB2ENR_SYSCFGEN; //

    // initialize timer TIMx for use
    RCC->APB1ENR1 |= RCC_APB1ENR1_TIM2EN; //
    initTIM(DELAY_TIM); //

    //configure EXTICR for pin X
    SYSCFG->EXTICR[0] |= _VAL2FLD(SYSCFG_EXTICR1_EXTI1, 0b000);

    //configure EXTICR for pin Y
    SYSCFG->EXTICR[0] |= _VAL2FLD(SYSCFG_EXTICR1_EXTI2, 0b000);

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
    NVIC->ISER[0] |= (1 << EXTI1_IRQn);
    NVIC->ISER[0] |= (1 << EXTI2_IRQn);
    

    // measure/delay loop
    while(1){
      // wait for 1 second
      delay_millis(DELAY_TIM, 1000);


      // print velo and direction
      float velocity = (float) edge_count / (4 * (float) PPR);
      float neg_velocity = velocity * -1;
      if (direction == 0) {
          printf("Velocity = %f; Direction = CCW\n", velocity);
      } else {
          printf("Velocity = %f ; Direction = CW\n", neg_velocity);
      }

      // reset edge count
      edge_count = 0;
    }
}

/*
This function handles interrupts from pin PA1
It is called on the positive and negative edge of PA1 
It increments an edge counter for a quadrature encoder and checks direction of rotation
*/
void EXTI1_IRQHandler(void){
    // increment edge counter
    if (EXTI->PR1 & (1 << 1)){
        
        edge_count++;
    
        // if this edge triggers twice (turns around), 
        // change direction
        if (last_triggered == 0) {
            direction = ~direction;
        }
    
        // set this edge as last triggered
        last_triggered = 0;

        // clear the pending interrupt
        EXTI->PR1 |= (1 << 1);

}
    return;
}

/*
This function handles interrupts from pin PA2
It is called on the positive and negative edge of PA2 
It increments an edge counter for a quadrature encoder and checks direction of rotation
*/
void EXTI2_IRQHandler(void){
    // increment edge counter
    if (EXTI->PR1 & (1 << 2)){
        edge_count++;

        // if this edge triggers twice (turns around), 
        // change direction
        if (last_triggered == 1) {
            direction = ~direction;
        }

        // set this edge as last triggered
        last_triggered = 1;

        // clear pending interrupt
        EXTI->PR1 |= (1 << 2);
    }
    return;
}