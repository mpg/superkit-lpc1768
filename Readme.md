# Projects from Sunfounder's Super Kit for Arduino - on NXP-LPC1768

I wanted to get familiar with basic eletronics components so I bought
Sunfounder's Super Start Kit ([Sunfounder][1], [Amazon][2]). I comes with a
booklet describing 19 projects and an CD with the Arduino code for the
projects.

[1]: http://www.sunfounder.com/index.php?c=show&id=51&model=Super%20Kit%20V2.0%20for%20Arduino
[2]: http://www.amazon.fr/gp/product/B00D9M4BQU?*Version*=1&*entries*=0

Rather than use the provided Arduino code, I decided to write my own, and use
the "[mbed][]" [NXP-LPC1768][lpc] board instead of the Arduino. I will also try to write
two versions of the code for each project:

* One using the [ARM mbed][] libraries, which provide a high-level
  environment comparable to the Arduino SDK;
* A bare-metal version to make sure I understand every detail of what's going
  on behind the scenes.

[mbed]: https://developer.mbed.org/platforms/mbed-LPC1768/
[lpc]: http://www.nxp.com/demoboard/OM11043.html
[ARM mbed]: https://developer.mbed.org/

This is for my own education, but I'm making it public in the hope that
someone might learn a thing or two by looking at it. Code written by me is
placed under the WTFPLv2, thought I seriously doubt anyone wants to reuse it.


## Requirements

* The booklet from Sunfounder's Super Kit and the eletronics components.
* An "mbed" NXP-LPC1768 board
* The arm-none-eabi toolchain from [GCC ARM embeded][] (might be packaged in
  your distro, otherwise just untar it and add to you path).
* An account on <https://developer.mbed.org> for the version using the mbed
  libraries.

[GCC ARM embeded]: https://launchpad.net/gcc-arm-embedded/+download
