#include "mbed.h"
#include "../cie1931.h"

PwmOut myled(p21);

const float delay = 1.0 / 256;

int main() {
    while(1) {
        for (uint8_t i = 0; i < 255; i++) {
            myled = cie(i);
            wait(delay);
        }
        for (uint8_t i = 255; i > 0; i--) {
            myled = cie(i);
            wait(delay);
        }
    }
}
