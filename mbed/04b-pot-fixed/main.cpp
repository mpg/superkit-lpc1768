#include "mbed.h"
#include "../cie1931.h"

PwmOut myled(p21);
AnalogIn mypot(p20);

int main() {
    while(1) {
        myled = cie((uint8_t) (mypot.read_u16() / 256));
    }
}
