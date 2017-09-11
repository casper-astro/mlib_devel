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
#include "casper_devcsl.h"
#include "icap.h"

#define HEARTBEAT_MS 10000

int main()
{
#ifdef PRINT_SPI_DETAILS
    int i;
    int j;
    u32 len;
    u8 buf[128];
#endif
#ifdef DEBUG_ETH_0_CORE
    int rx_size;
#endif
    int fpga_temp;
    uint32_t next_ms = HEARTBEAT_MS;
    uint32_t curr_ms;
#ifdef JAM_TEST_TMRCTR
    u64 time0, time1;
    u32 tick0, tick1;
#endif // JAM_TEST_TMRCTR

    init_platform();

    xil_printf("\n# JAM starting\n\n");

    casper_lwip_init();

#ifdef JAM_SEND_TEST_PACKET
    for(i=0; i<3; i++) {
      send_test_packet();
    }
    print("\n");
#endif // JAM_SEND_TEST_PACKET

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
#endif // JAM_TEST_TMRCTR

#ifdef PRINT_SPI_DETAILS
    print("## SPI Flash Info\n");

    buf[0] = 0x9e;
    len = 5;
    send_spi(buf, buf, len, SEND_SPI_MORE);
    print("RDID:  ");
    for(i=1; i<len; i++) { // skip munged opcode byte
      xil_printf(" %02x", buf[i]);
    }
    print("\n");
    print("       ");
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
#endif //  PRINT_SPI_DETAILS

#if 0
    uint32_t *preg;
    // Look for sys_clkcounter register
    if((preg = casper_find_dev("sys_clkcounter", NULL))) {
      u32 tic = *preg;
      sleep(1);
      u32 toc = *preg;
      xil_printf("fabric clock: %d Hz\n\n", toc-tic);
    } else {
      print("sys_clkcounter not found\n");
    }
#endif

#ifdef DEBUG_ETH_0_CORE
    // Make various pointers to eth0 memory
    u8  *eth0_ptr8 = NULL;
    u16 *eth0_ptr16 = NULL;
    u32 *eth0_txbuf = NULL;
    u32 *eth0_rxbuf = NULL;

    // Find the first Ethernet core in the core_info list
    u32 *eth0_ptr32 = casper_find_dev_by_typecode(CASPER_CORE_INFO_TYPECODE_ETHCORE, 1, NULL, NULL);
    if(!eth0_ptr32) {
      print("Ethernet core not found\n");
    } else {
      print("Ethernet core found!\n");
      eth0_ptr8  = (u8  *)eth0_ptr32;
      eth0_ptr16 = (u16 *)eth0_ptr32;
      eth0_txbuf = TX_BUF_PTR32(eth0_ptr32);
      eth0_rxbuf = RX_BUF_PTR32(eth0_ptr32);

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
          xil_printf(" %02x", eth0_ptr8[16*i+j]);
        }
        print("\n");
      }
      print("\n");

      print("## eth0 memory as u16:\n");
      for(i=0; i<4; i++) {
        xil_printf("%02x:", 16*i);
        for(j=0; j<8; j++) {
          xil_printf(" %04x", eth0_ptr16[8*i+j]);
        }
        print("\n");
      }
      print("\n");

      print("## eth0 memory as u32:\n");
      for(i=0; i<4; i++) {
        xil_printf("%02x:", 16*i);
        for(j=0; j<4; j++) {
          xil_printf(" %08x", eth0_ptr32[4*i+j]);
        }
        print("\n");
      }
      print("\n");

      // Check TX / RX are enabled
      if (!(eth0_ptr8[ETH_MAC_REG8_RX_ENABLE] & eth0_ptr8[ETH_MAC_REG8_TX_ENABLE])) {
        xil_printf("RX_ENABLE: %d, TX_ENABLE: %d\n", eth0_ptr8[ETH_MAC_REG8_RX_ENABLE], eth0_ptr8[ETH_MAC_REG8_TX_ENABLE]);
        print("Ethernet core does not have CPU enabled RX/TX\n");
      } else {
        print("Ethernet core has TX/RX capability\n");
      }

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
        if(!*TX_BUF_SIZE_PTR16(eth0_ptr16)) break;
      }

      if(i > 0) {
        xil_printf("looped %d times waiting for TX buffer\n\n", i);
      }

      // Copy packet to TX buffer
      for(i=0; i<pktlen32; i++) {
        eth0_txbuf[i] = pkt32[i];
      }

      // Set TX buffer level to number of 8 byte words to send packet
      *TX_BUF_SIZE_PTR16(eth0_ptr16) = pktlen32/2;
    } // CPU core exists
#endif

    while(1) {
      casper_lwip_handler();
#ifdef DEBUG_ETH_0_CORE
      if(eth0_ptr32) {
        // Get RX buffer size
        rx_size = *RX_BUF_SIZE_PTR16(eth0_ptr16);
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
          *RX_BUF_SIZE_PTR16(eth0_ptr16) = 0;
        }
      }
#endif

      curr_ms = ms_tmrctr();
      if(next_ms <= curr_ms) {
        next_ms = curr_ms + HEARTBEAT_MS;

        fpga_temp = (int)(10*get_fpga_temp());
        xil_printf("FPGA at %d.%d C [ms %d]\n",
            fpga_temp / 10, fpga_temp % 10, ms_tmrctr());
      }
    }

    // Should "never" get here
    cleanup_platform();
    return 0;
}
