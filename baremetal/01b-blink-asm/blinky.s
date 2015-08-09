@ Very minimalistic blinky program for the LPC1768
.syntax unified

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
@ we use that to save two bytes (narrow instr. vs wide isntr.)
@ by loading the value from a register rather than immediate

@ also use the fact the lr has well-defined reset value (all bits 1)
@ to get free init for the register used to set led state

@ interrupt vector table (34.3.3.4)
@ let's play dirty and reuse most of that for our purposes,
@ just keep some reserved registers (7-10 and 12-13) to a 0 value
vtor:
    .word   0                   @ not usin the stack
    .word   0x09                @ address of main
main:
    mov  r0, #led1
    ldr  r1, iobase_addr
    str  r0, [r1, #dir_offt]    @ led1 is output (all other are input)
blink:
    str  r2, [r1, #pin_offt]    @ set led1 on or off
    mvns r2, r2                 @ switch between on and off

    lsls r3, r0, #1             @ that's wait_reps :)
wait:
    subs r3, #1                 @ 1 cycle
    beq  blink                  @ 1 cycle if not taken
    b    wait                   @ 1 cycle + pipeline refill (assume 2 total)
@ this was 20 bytes, ie vtor[2] to vtor[6] included, next is vtor[7]
@ apparently the core cares about vtor[7] being 0, so make it happy
    .word   0
@ apparently the core doesn't care about the rest of the reserved vtors,
@ so just put the last address we need here and be done
iobase_addr:
    .word   fio1base

@ vim: ft=armasm
