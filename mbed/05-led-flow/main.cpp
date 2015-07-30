#include "mbed.h"

DigitalOut l0(p20);
DigitalOut l1(p21);
DigitalOut l2(p22);
DigitalOut l3(p23);
DigitalOut l4(p24);
DigitalOut l5(p25);
DigitalOut l6(p26);
DigitalOut l7(p27);

DigitalOut led[] = { l0, l1, l2, l3, l4, l5, l6, l7 };

const float delay = 0.125f;

int main() {
    led[0] = 1;
    wait(delay);
    while(1) {
        for (int i = 1; i <= 7; i++) {
            led[i] = 1;
            led[i-1] = 0;
            wait(delay);
        }
        for (int i = 6; i >= 0; i--) {
            led[i] = 1;
            led[i+1] = 0;
            wait(delay);
        }
    }
}
