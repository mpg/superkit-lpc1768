# Projects from Sunfounder's Super Starter Kit on LPC1768 - bare metal version

In this version, I try to write all the code myself, and understand every
single line of it. To this end, I take a minimalistic approach, and only
include things I really need in the code and support files (Makefile, linker
script).

The only components I choose to use though not writing them myself are the
CMSIS headers for the platform used. I downloaded them from [lpcware][], and
from the large source tree picked only the following files:

    Core/Device/NXP/LPC17xx/Include/LPC17xx.h
    Core/CMSIS/Include/core_cm3.h
    Core/CMSIS/Include/core_cmFunc.h
    Core/CMSIS/Include/core_cmInstr.h

I then edited `LPC17xx.h` to comment the reference to `system_LPC17xx.h`, and
put thoses files in `common/include`.

[lpcware]: http://www.lpcware.com/system/files/lpc175x_6x_cmsis_driver_library_0.zip

In the comments, you'll find references such as `(4.3.4)`; unless an explicit
reference is given, this is a section number in the [LPC1768 user
manual][man]. You'll find links to this and other useful references regarding
this board, such as its schematics, on its [description on mbed.org][links].

[man]: http://www.nxp.com/documents/user_manual/UM10360.pdf
[links]: https://developer.mbed.org/platforms/mbed-LPC1768/#schematics-and-data-sheets
