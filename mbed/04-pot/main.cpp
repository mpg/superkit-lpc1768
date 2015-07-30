#include "mbed.h"

PwmOut myled(p21);
AnalogIn mypot(p20);

int main() {
    while(1) {
        myled = mypot;
    }
}
