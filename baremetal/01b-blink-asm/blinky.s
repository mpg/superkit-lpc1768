@ Very minimalistic blinky program for the LPC1768
.syntax unified

@ Schematics, sheet 3/5: LED1 is P1.18
@ 8.3 says GPIO is the default function
.set led1,  1 << 18

@ 9.5 GPIO registers
.set fio1base,  0x2009C020
.set dir_offt,  0x00
.set pin_offt,  0x14

@ see Cortex-M3 technical reference manual 3.3.1 and wait: below
@ assume the unconditional branch is easy to speculate so that the pipeline
@ refill is only 1 cycle most of the time
@.set loop_cycles, 4
@
@ initial clock source is the internal RC at about 4MHz (4.3.1)
@ round up to nearest power of two
@.set cycles_per_sec, 4 * 1024 * 1024
@
@ we want a half-period of about a half second
@.set wait_reps, cycles_per_sec / loop_cycles / 2
@
@ notice that the result is exactly 2 * led1
@ we use that to save two bytes (narrow instr. vs wide instr.)
@ by loading the value from a register rather than immediate

@ also use the fact the lr has well-defined reset value (all bits 1)
@ to get free init for the register used to set led state

@ interrupt vector table (34.3.3.4)
@
@ let's play dirty and reuse most of that for our purposes;
@ eg, we won't be using the stack, so reuse sp to hold a big constant
@
@ apparently the core doesn't like it when we try to access vtor[7]
@ (documented as reserved) but we're compact enough to not hit it
vtor:
    .word   fio1base            @ free loading into sp
    .word   0x09                @ address of main
main:
    mov  r0, #led1
    str  r0, [sp, #dir_offt]    @ led1 is output (all other are input)
blink:
    str  r2, [sp, #pin_offt]    @ set led1 on or off
    mvns r2, r2                 @ switch between on and off

    lsls r3, r0, #1             @ that's wait_reps :)
wait:
    subs r3, #1                 @ 1 cycle
    beq  blink                  @ 1 cycle if not taken
    b    wait                   @ 1 cycle + pipeline refill (assume 2 total)

@ vim: ft=armasm
