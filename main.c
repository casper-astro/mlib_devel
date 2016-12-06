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

#include "tmrctr.h"
#include "spi.h"
#include "casper_eth.h"

int main()
{
    char s[4] = {'\x80', '\x00', '\x00', '\x00'};
    int endian = *((int *)&s);
    int i, j, rx_size;
    int fpga_temp;
    u8 buf[128];
    u32 len;
    u64 time0, time1;
    u32 tick0, tick1;

    init_platform();

    print("\n# JAM starting\n\n");

    casper_lwip_init();

#ifdef JAM_TEST_TMRCTR
    dump_tmrctr();
    dump_tmrctr();
    time0 = read_tmrctr();
    time1 = read_tmrctr();
    xil_printf("%08x%08x\n", (u32)(time0>>32), (u32)(time0 & 0xffffffff));
    xil_printf("%08x%08x %d\n", (u32)(time1>>32), (u32)(time1 & 0xffffffff),
        (u32)(time1 - time0));
    tick0 = tick_tmrctr();
    tick1 = tick_tmrctr();
    xil_printf("%08x\n", tick0);
    xil_printf("%08x %d\n", tick1, tick1 - tick0);
    print("\n");
#endif

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

// From core_info.tab
#define WB_SYS_CLKCOUNTER (0x1402c)
#define SYS_CLKCOUNTER_ADDRESS (XPAR_AXI_SLAVE_WISHBONE_CLASSIC_MASTER_0_BASEADDR + WB_SYS_CLKCOUNTER)

    s32 tic = *(u32 *)SYS_CLKCOUNTER_ADDRESS;
    sleep(1);
    s32 toc = *(u32 *)SYS_CLKCOUNTER_ADDRESS;
    xil_printf("fabric clock running at %d Hz\n\n", toc-tic);

#if 0
// From core_info.tab
#define WB_ETH0_OFFSET (0x292f8)
#define ETH0_BASE_ADDRESS (XPAR_AXI_SLAVE_WISHBONE_CLASSIC_MASTER_0_BASEADDR + WB_ETH0_OFFSET)

    // Make various pointers to eth0 memory
    volatile u32 *eth0_ptr32 = (u32 *)(ETH0_BASE_ADDRESS);
    volatile u16 *eth0_ptr16 = (u16 *)(ETH0_BASE_ADDRESS);
    volatile u8  *eth0_ptr8  = (u8  *)(ETH0_BASE_ADDRESS);

    // Arithmetic on pointers to u32 is done in units of u32
    // Scale OFFSETs accordingly!
    volatile u32 *eth0_txbuf = eth0_ptr32 + ETH_MAC_TX_BUFFER_OFFSET/sizeof(u32);
    volatile u32 *eth0_rxbuf = eth0_ptr32 + ETH_MAC_RX_BUFFER_OFFSET/sizeof(u32);
#endif

#if 0
    // Reset eth0
    eth0_ptr8[ETH_MAC_REG8_RESET] = 1;
    for(i=0; i<1000; i++) {
      if(!eth0_ptr8[ETH_MAC_REG8_RESET]) break;
    }
    xil_printf("looped %d times waiting for reset to complete\n", i);

    print("## eth0 memory as u8:\n");
    for(i=0; i<4; i++) {
      xil_printf("%02x:", 16*i);
      for(j=0; j<16; j++) {
        //xil_printf(" %02x", *(((u8 *)ETH0_BASE_ADDRESS) + 16*i+j));
        xil_printf(" %02x", eth0_ptr8[16*i+j]);
      }
      print("\n");
    }
    print("\n");

    print("## eth0 memory as u16:\n");
    for(i=0; i<4; i++) {
      xil_printf("%02x:", 16*i);
      for(j=0; j<8; j++) {
        //xil_printf(" %04x", *(((u16 *)ETH0_BASE_ADDRESS) + 8*i+j));
        xil_printf(" %04x", eth0_ptr16[8*i+j]);
      }
      print("\n");
    }
    print("\n");

    print("## eth0 memory as u32:\n");
    for(i=0; i<4; i++) {
      xil_printf("%02x:", 16*i);
      for(j=0; j<4; j++) {
        //xil_printf(" %08x", *(((u32 *)ETH0_BASE_ADDRESS) + 4*i+j));
        xil_printf(" %08x", eth0_ptr32[4*i+j]);
      }
      print("\n");
    }
    print("\n");
#endif

#if 0
    // Broadcast ARP packet.  The packet format is based this tcpdump capture
    // of a unicast ARP packet:
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
    // Replace dst MAC with ff:ff:ff:ff:ff:ff, dst IP with 10.20.30.40
    // Added 4 bytes of padding since core requires multiple of 8 bytes
    int pktlen32 = 16;
    u32 pkt32[] = {
      0xffffffff, 0xffff0202, 0x0a0a0a0a, 0x08060001,
      0x08000604, 0x00010202, 0x0a0a0a0a, 0x0a0a0a0a,
      0x00000000, 0x00000a14, 0x1e280000, 0x00000000,
      0x00000000, 0x00000000, 0x00000000, 0x00000000
    };

    // Loop a bunch of times waiting for TX buffer to be free
    // (indicated by size going to 0)
    for(i=0; i<10000; i++) {
      // If length is zero, then TX buffer is free
      if(!eth0_ptr16[ETH_MAC_REG16_TX_BUFFER_SIZE]) break;
    }

    if(i > 0) {
      xil_printf("looped %d times waiting for TX buffer\n\n", i);
    }

    // Copy packet to TX buffer
    for(i=0; i<pktlen32; i++) {
      eth0_txbuf[i] = pkt32[i];
    }

    // Set TX buffer level to number of 8 byte words to send packet
    eth0_ptr16[ETH_MAC_REG16_TX_BUFFER_SIZE] = pktlen32/2;
#endif

    while(1) {
      casper_lwip_handler();
#if 0
        // Get RX buffer size
        rx_size = eth0_ptr16[ETH_MAC_REG16_RX_BUFFER_SIZE];
        // Show packet contents if non-zero
        if(rx_size != 0) {
          // Double rx_size to get number of 32 bit words
          rx_size <<= 1;
          xil_printf("got packet with %d bytes\n", (rx_size<<2));
          for(i=0; i<rx_size; i++) {
            if((i & 3) == 0) xil_printf("%04x:", (i<<2));
            xil_printf(" %08x", eth0_rxbuf[i]);
            if((i & 3) == 3) print("\n");
          }
          if((i & 3) != 0) print("\n");

          // Ack the packet
          eth0_ptr16[ETH_MAC_REG16_RX_BUFFER_SIZE] = 0;
        }
#endif

        fpga_temp = (int)(10*get_fpga_temp());
        xil_printf("Hello %s endian world at %d.%d C [ms %d]\n",
            endian < 0 ? "BIG" : "little",
            fpga_temp / 10, fpga_temp % 10, ms_tmrctr());

        sleep(1);
    }

    cleanup_platform();
    return 0;
}
