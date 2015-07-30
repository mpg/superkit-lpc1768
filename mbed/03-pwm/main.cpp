#include "mbed.h"

PwmOut myled(p21);

const int steps = 4;
const float delay = 1.0 / steps;

int main() {
    while(1) {
        for (int i = 0; i < steps; i++) {
            myled = (float) i / steps;
            wait(delay);
        }
        for (int i = steps; i > 0; i--) {
            myled = (float) i / steps;
            wait(delay);
        }
    }
}
