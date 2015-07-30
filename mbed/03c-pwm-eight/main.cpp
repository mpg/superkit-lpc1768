#include "mbed.h"
#include "../cie1931.h"

DigitalOut l0(p20);
PwmOut     l1(p21);
PwmOut     l2(p22);
PwmOut     l3(p23);
PwmOut     l4(p24);
PwmOut     l5(p25);
PwmOut     l6(p26);
DigitalOut l7(p27);

PwmOut led[] = { l1, l2, l3, l4, l5, l6 };

int main() {
    l0 = 1;
    for (int i = 1; i <= 6; i++) {
        led[i].period_us(1);
        led[i] = cie((uint8_t) i*32);
    }
    l7 = 1;

    while(1)
        ;
}
