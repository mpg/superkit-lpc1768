#include "LPC17xx.h"

/* declared in linker script, to keep the memory layout info in one place */
extern const uint32_t _stack_top;

/* Schematics, sheet 3/5: LED1 is P1.18
 * 8.3 says GPIO is the default function */
#define LED1    (1lu << 18)

/* The initial clock source is the internal RC oscillator, at 4 MHz (4.3.1)
 * The body of our for loop is 8 instructions.
 * We want a half-period of about 1/2s. */
#define REPS    (4000000 / 8 / 2)

/* executed on startup */
void _reset(void)
{
    /* GPIO: chapter 9 */
    LPC_GPIO1->FIODIR = LED1;       /* LED1 is Output */

    while(1) {
        LPC_GPIO1->FIOPIN |= LED1;
        for (volatile uint32_t i = 0; i < REPS; i++);
        LPC_GPIO1->FIOPIN &= ~LED1;
        for (volatile uint32_t i = 0; i < REPS; i++);
    }
}

/* interrupt vector table (34.3.3.4) */
/* For some reason, defining only the first two entries fails,
 * so reserve space for all 16 "base" handlers */
__attribute__ ((section(".vtor")))
const void* _interrupt_vtor[16] = {
    &_stack_top,
    _reset,
};
