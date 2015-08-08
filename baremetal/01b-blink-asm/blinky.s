@ Very minimalistic blinky program for the LPC1768
.syntax unified

@ For some reason, defining only the first two entries fails,
@ so reserve space for all 16 "base" handlers
.set nb_vtors,  16

@ We don't want to use a linker (script), so compute address of main ourselves
@ Last bit must be set to one as this is a thumb function
.set main_addr, 4 * nb_vtors + 1

@ interrupt vector table (34.3.3.4)
vtor:
    .word   0           @ we won't use the stack
    .word   main_addr
.rept nb_vtors - 2
    .word   0
.endr

@ Schematics, sheet 3/5: LED1 is P1.18
@ 8.3 says GPIO is the default function
.set led1,  1 << 18

@ 9.5 GPIO registers
.set fio1base,  0x2009C020
.set dir_offt,  0x00
.set mask_offt, 0x10
.set pin_offt,  0x14

@ see Cortex-M3 technical reference manual 3.3.1 and wait: below
@ assume the unconditional branch is easy to speculate so that the pipeline
@ refill is only 1 cycle most of the time
.set loop_cycles, 4

@ initial clock source is the internal RC at about 4MHz (4.3.1)
@ round up to nearest power of two
.set cycles_per_sec, 4 * 1024 * 1024

@ we want a half-period of about a half second
.set wait_reps, cycles_per_sec / loop_cycles / 2

main:
    mov  r0, #led1
    ldr  r1, =fio1base
    str  r0, [r1, #dir_offt]    @ led1 is output (all other are input)

blink:
    str  r0, [r1, #pin_offt]    @ set led1 on or off
    mvns r0, r0                 @ switch between on and off

    mov  r2, #wait_reps
wait:
    subs r2, #1                 @ 1 cycle
    beq  blink                  @ 1 cycle if not taken
    b    wait                   @ 1 cycle + pipeline refill (assume 2 total)

@ vim: ft=armasm
