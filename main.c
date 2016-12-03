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
    int i, j;
    float fpga_temp;
    u8 buf[128];
    u32 len;

    init_platform();

    print("\n# JAM starting\n\n");

    print("## SPI Flash Info\n");

    buf[0] = 0x9e;
    len = 5;
    send_spi(buf, buf, len, SEND_SPI_MORE);
    print("RDID:  ");
    for(i=1; i<len; i++) { // skip munged opcode byte
      xil_printf(" %02x", buf[i]);
    }
    print("\n       ");
    // Read rest of UID using length from last byte
    len = buf[--i];
    send_spi(buf, buf, len, 0);
    for(i=0; i<len; i++) {
      xil_printf(" %02x", buf[i]);
    }
    print("\n");

    buf[0] = 0x05;
    len = 2;
    send_spi(buf, buf, len, 0);
    print("RDSR:  ");
    for(i=1; i<len; i++) { // skip munged opcode byte
      xil_printf(" %02x", buf[i]);
    }
    print("\n");

    buf[0] = 0xb5;
    len = 3;
    send_spi(buf, buf, len, 0);
    print("RDNVCR:");
    for(i=1; i<len; i++) { // skip munged opcode byte
      xil_printf(" %02x", buf[i]);
    }
    print("\n");

    buf[0] = 0x85;
    len = 2;
    send_spi(buf, buf, len, 0);
    print("RDVCR: ");
    for(i=1; i<len; i++) { // skip munged opcode byte
      xil_printf(" %02x", buf[i]);
    }
    print("\n");

    buf[0] = 0x65;
    len = 2;
    send_spi(buf, buf, len, 0);
    print("RDEVCR:");
    for(i=1; i<len; i++) { // skip munged opcode byte
      xil_printf(" %02x", buf[i]);
    }
    print("\n");

    buf[0] = 0x5a; // opcode
    buf[1] = 0x00; // address
    buf[2] = 0x00; // address
    buf[3] = 0x00; // address
    buf[4] = 0x00; // dummy
    send_spi(buf, buf, 5, SEND_SPI_MORE);
    len = 128;
    send_spi(buf, buf, len, 0);
    for(i=0; i<len/16; i++) {
      print(i == 0 ? "RDSFDP:" : "       ");
      for(j=0; j<16; j++) {
        xil_printf(" %02x", buf[16*i+j]);
      }
      print("\n");
    }
    print("\n");

    // Unicast ARP packet.  The packet format is based this tcpdump capture of
    // a unicast ARP packet:
    //
    // 00:25:90:9d:aa:41 > 0c:c4:7a:aa:8a:fb, ethertype ARP (0x0806), length 60:
    // Request who-has 10.0.1.1 tell 10.0.100.49, length 46
    //      0x0000:  0cc4 7aaa 8afb 0025 909d aa41 0806 0001
    //      0x0010:  0800 0604 0001 0025 909d aa41 0a00 6431
    //      0x0020:  0000 0000 0000 0a00 0101 0000 0000 0000
    //      0x0030:  0000 0000 0000 0000 0000 0000
    //
    // The packet sent here has these changes:
    //
    // Replace src MAC with 02:02:0a:0a:0a:0a, src IP with 10.10.10.10
    // Replace dst MAC with 02:02:0a:14:1e:28, dst IP with 10.20.30.40
    // Add 4 bytes of padding since core requires multiple of 8 bytes
    int pktlen = 64;
    char pkt[64] = {
      0x02, 0x02, 0x0a, 0x14, 0x1e, 0x28, 0x02, 0x02, 0x0a, 0x0a, 0x0a, 0x0a, 0x08, 0x06, 0x00, 0x01,
      0x08, 0x00, 0x06, 0x04, 0x00, 0x01, 0x02, 0x02, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0x14, 0x1e, 0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    };

    // Create a u32 poitner to packet
    u32 *pkt32 = (u32 *)pkt;

// From core_info.tab
#define ETH0_WB_OFFSET (0x292f8)
#define ETH0_BASE_ADDRESS (XPAR_AXI_SLAVE_WISHBONE_CLASSIC_MASTER_0_BASEADDR + ETH0_WB_OFFSET)
// From Ethernet MAC
#define ETH_MAC_BUFFER_LEVEL_OFFSET   (0x18)
#define ETH_MAC_TX_BUF_OFFSET       (0x4000)

    print("## eth0 memory as u8:\n");
    for(i=0; i<4; i++) {
      xil_printf("%02x:", 16*i);
      for(j=0; j<16; j++) {
        xil_printf(" %02x", *(((u8 *)ETH0_BASE_ADDRESS) + 16*i+j));
      }
      print("\n");
    }
    print("\n");

    print("## eth0 memory as u16:\n");
    for(i=0; i<4; i++) {
      xil_printf("%02x:", 16*i);
      for(j=0; j<8; j++) {
        xil_printf(" %04x", *(((u16 *)ETH0_BASE_ADDRESS) + 8*i+j));
      }
      print("\n");
    }
    print("\n");

    print("## eth0 memory as u32:\n");
    for(i=0; i<4; i++) {
      xil_printf("%02x:", 16*i);
      for(j=0; j<4; j++) {
        xil_printf(" %08x", *(((u32 *)ETH0_BASE_ADDRESS) + 4*i+j));
      }
      print("\n");
    }
    print("\n");

#if 1
    // Copy packet to 10 GbE buffer
    // Xil_Out32(XPAR_AXI_SLAVE_WISHBONE_CLASSIC_MASTER_0_BASEADDR + uAddressOffset + ETH_MAC_CPU_TRANSMIT_BUFFER_LOW_ADDRESS + 4*uIndex, puTransmitPacket[uIndex]);
    //memcpy((void *)(ETH0_BASE_ADDRESS + ETH_MAC_TX_BUF_OFFSET), pkt, 64);
    for(i=0; i<16; i++) {
      Xil_Out32(ETH0_BASE_ADDRESS + ETH_MAC_TX_BUF_OFFSET + i, Xil_Htonl(pkt32[i]));
    }

    // Set TX buffer level to 60 to send packet
    *((u16 *)((ETH0_BASE_ADDRESS+ETH_MAC_BUFFER_LEVEL_OFFSET+2)^2)) = Xil_Htons(64/8);

    // Loop a bunch of times waiting for packet to send
    for(i=0; i<10000; i++) {
      // If length is zero, then packet was sent
      if(!*((u16 *)((ETH0_BASE_ADDRESS+ETH_MAC_BUFFER_LEVEL_OFFSET+2)^2))) break;
    }

    xil_printf("looped %d times while packet was sending\n", i);
#endif

    print("\n");

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
