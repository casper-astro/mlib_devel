/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * main.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>

#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"

#include "spi.h"

int main()
{
    char s[4] = {'\x80', '\x00', '\x00', '\x00'};
    int endian = *((int *)&s);
    int i;
    float fpga_temp;
    u8 buf[128];
    u32 len;

    init_platform();

    print("SPI read identification (RDID)\n");
    test_spi(0x9e, 8);

    print("SPI read identification (RDID)\n");
    print("got ");
    buf[0] = 0x9e;
    len = 4;
    send_spi(buf, buf, len, SEND_SPI_MORE);
    for(i=0; i<len; i++) {
      xil_printf(" %02x", buf[i]);
    }
    send_spi(buf, buf, len, 0);
    for(i=0; i<len; i++) {
      xil_printf(" %02x", buf[i]);
    }
    print("\n");

    print("SPI read status register (RDSR)\n");
    test_spi(0x05, 3);

    print("SPI read non-volatile config register (RDNVCR)\n");
    test_spi(0xb5, 4);

    print("SPI read volatile config register (RDVCR)\n");
    test_spi(0x85, 3);

    print("SPI read enhanced volatile config register (RDEVCR)\n");
    test_spi(0x65, 3);

    while(1) {
        fpga_temp = get_fpga_temp();
        printf("Hello %s endian world at %.1f C\n",
            endian < 0 ? "BIG" : "little",
            fpga_temp);
        sleep(1);
    }

    cleanup_platform();
    return 0;
}
