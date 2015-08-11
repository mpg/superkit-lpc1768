@ Very minimalistic blinky program for the LPC1768
.syntax unified

@ Schematics, sheet 3/5: LED1 is P1.18
@ 8.3 says GPIO is the default function (nothing to set up)
.set led1_bit,  18

@ 9.5 GPIO registers
.set fio1dir,   0x2009C020
.set fio1pin,   0x2009C034

@ bit-banding aliases (34.3.2.5)
.set l1bb_dir,      0x22000000 + (fio1dir - 0x20000000) * 32 + led1_bit * 4
.set bb_pin_offt,   (fio1pin - fio1dir) * 32

@ see Cortex-M3 technical reference manual 3.3.1 and "wait:" below
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
@ the result is 1 << 19
@ use that rather than loading a largish constant
@ to save two bytes (narrow instr. vs wide instr.)

@ interrupt vector table (34.3.3.4)
@
@ let's play dirty and reuse most of that for our purposes;
@ eg, we won't be using the stack, so reuse sp to hold our base I/O bitbanding
@ adress: sp-relative addressing supports wider #immediates.
@
@ apparently the core doesn't like it when we try to access vtor[7]
@ (documented as reserved) but we're compact enough to not hit it
vtor:
    .word   l1bb_dir            @ free loading into sp
    .word   0x09                @ address of main
main:
    movs r0, #1
    str  r0, [sp]               @ led1 is output (all other are input)
blink:
    str  r1, [sp, #bb_pin_offt] @ set led1 on or off
    mvns r1, r1                 @ switch between on and off

    lsls r2, r0, #19            @ that's wait_reps
wait:
    subs r2, #1                 @ 1 cycle
    beq  blink                  @ 1 cycle if not taken
    b    wait                   @ 1 cycle + pipeline refill (assume 2 total)

@ vim: ft=armasm
