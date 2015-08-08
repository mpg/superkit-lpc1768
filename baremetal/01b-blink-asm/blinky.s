@ Very minimalistic blinky program for the LPC1768

@ 2.1 plus data sheet
.set ram_bottom, 0x10000000
.set ram_size,   0x00008000
.set ram_top,    ram_bottom + ram_size

@ interrupt vector table (34.3.3.4)
@ For some reason, defining only the first two entries fails,
@ so reserve space for all 16 "base" handlers
vtor:
    .word   ram_top
    .word   0x41
.rept 14
    .word   0
.endr

@ Schematics, sheet 3/5: LED1 is P1.18
@ 8.3 says GPIO is the default function
.set led1,  1 << 18

@ 9.5 GPIO registers
.set fio1dir,   0x2009C020
.set fio1set,   0x2009C038
.set fio1clr,   0x2009C03C

@ see Cortex-M3 technical reference manual 3.3.1 and wait: below
@ assume the unconditional branch is easy to speculate so that the pipeline
@ refill is only 1 cycle most of the time
.set loop_cycles, 4

@ initial clock source is the internal RC at about 4MHz (4.3.1)
.set cycles_per_sec, 4000000

@ we want a half-period of about a half second
.set wait_reps, cycles_per_sec / loop_cycles / 2

main:
    ldr r0, =led1
    ldr r1, =fio1dir
    str r0, [r1]        @ led1 is output
blink1:
    ldr r1, =fio1set
    str r0, [r1]        @ set led1 on

    ldr r1, =wait_reps
wait1:
    sub r1, #1          @ 1 cycle
    beq blink2          @ 1 cycle if not taken
    b wait1             @ 1 cycle + pipeline refill (assume 2 total)

blink2:
    ldr r1, =fio1clr
    str r0, [r1]        @ set led1 off

    ldr r1, =wait_reps
wait2:
    sub r1, #1          @ 1 cycle
    beq blink1          @ 1 cycle if not taken
    b wait2             @ 1 cycle + pipeline refill (assume 2 total)

@ vim: ft=armasm
