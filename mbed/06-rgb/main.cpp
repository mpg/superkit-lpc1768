#include "mbed.h"
#include "../cie1931.h"

#define POT 0

#if POT
AnalogIn pot(p20);
#endif

PwmOut red(p21);
PwmOut gre(p24);
PwmOut blu(p25);

void color(float r, float g, float b) {
    red = cie(r);
    gre = cie(g);
    blu = cie(b);
}

void color(uint8_t c) {
    color( (c >> 0) & 1, (c >> 1) & 1, (c >> 2) & 1);
}

/* https://en.wikipedia.org/wiki/HSL_and_HSV#Converting_to_RGB */
/* We take H in the range 0..1, and fix S == V == 1 */
void color(float H) {
    if (H < 0 || H > 1)
        return;

    float h = H * 6; /* This is WP's H' */
    if (h < 1)
        color(1, h, 0);
    else if (h < 2)
        color(2-h, 1, 0);
    else if (h < 3)
        color(0, 1, h-2);
    else if (h < 4)
        color(0, 4-h, 1);
    else if (h < 5)
        color(h-4, 0, 1);
    else
        color(1, 0, 6-h);
}

const int steps = 360;
const float delay = 12.0 / steps;

int main() {
    while(1) {
#if POT
        color(pot);
#else
        for (int i = 0; i < steps; i++) {
            color((float) i / steps);
            wait(delay);
        }
        //for (int i = 0; i < 8; i++) {
        //    color(i);
        //    wait(1.0);
        //}
#endif
    }
}
