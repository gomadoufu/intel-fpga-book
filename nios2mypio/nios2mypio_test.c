#include "io.h"
#include "system.h"

int main() {
    int in, out;
    while (1) {
        in = IORD_8DIRECT(MYPIO_0_BASE, 1);
        switch (in) {
            case 0x0:
                out = 0x40;
                break;
            case 0x1:
                out = 0x79;
                break;
            case 0x2:
                out = 0x24;
                break;
            case 0x3:
                out = 0x30;
                break;
            case 0x4:
                out = 0x19;
                break;
            case 0x5:
                out = 0x12;
                break;
            case 0x6:
                out = 0x02;
                break;
            case 0x7:
                out = 0x58;
                break;
            case 0x8:
                out = 0x00;
                break;
            case 0x9:
                out = 0x10;
                break;
            case OxA:
                out = 0x08;
                break;
            case OxB:
                out = 0x03;
                break;
            case 0xC:
                out = 0x46;
                break;
            case 0XD:
                out = 0x21;
                break;
            case OxE:
                out = 0x06;
                break;
            case OxF:
                out = 0x0e;
                break;
            default:
                out = 0x7f;
                break;
        }
        IOWR_8DIRECT(MYPIO_0_BASE, 0, out);
    }
    return 0;
}
