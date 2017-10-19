// casper_eth.h - Macro definitions and declarations for interfacing with the
//                CASPER Ethernet core.

#ifndef _CASPER_ETH_H_
#define _CASPER_ETH_H_

#include "lwip/netif.h"

// Useful constants for working with CASPER Ethernet devices via an
// AXI/Wishbone gateway.  The AXI (e.g. Microblaze) side is little endian and
// the WB side is big endian.  The AXI/WB gateway does a sensible job of
// translating the endianess, but addressing gets a little non-intuitive for
// accesses less than 32 bits wide (i.e. 16 or 8 bits wide).
//
// In an effort to help alleviate that potential for confusion, the following
// conventions are used:
//
//   * All `ADDRESS` values are addresses that can be used as pointers.
//
//   * All `OFFSET` values are byte offsets.
//
//   * All `REG32` values are offsets in units of 32 bit words.  These should
//     only be used for 32 bit wide transfers.
//
//   * All `REG16` values are offsets in units of 16 bit words.  These should
//     only be used for 16 bit wide transfers.
//
//   * All `REG8` values are offsets in units of 8 bit words.  These should
//     only be used for 8 bit wide transfers.
//
// The names of the `REG32` macros are very closely derived from the constants
// used in the Verilog implementation.  Any significant deviations are noted.

//
// Offsets for various memory regions
//

// Byte offset to register region
#define ETH_MAC_REGISTERS_OFFSET (0x0000)

// Byte offset to TX buffer region
#define ETH_MAC_TX_BUFFER_OFFSET (0x1000)

// Byte offset to RX buffer region
#define ETH_MAC_RX_BUFFER_OFFSET (0x2000)

// Byte offset to ARP cache (aka ARP table) region
#define ETH_MAC_ARP_CACHE_OFFSET (0x3000)

//
// Offstes for registers within the register region
//

// Lower 16 bits at this offset are the upper 16 bits of the 48 bit MAC
// address.
#define ETH_MAC_REG32_LOCAL_MAC_1     (0x00)
// Lower 32 bits of the 48 bit MAC address
#define ETH_MAC_REG32_LOCAL_MAC_0     (0x01)
// Upper 16 bits of the 48 bit MAC address
#define ETH_MAC_REG16_LOCAL_MAC_HI    (0x00)
// Middle 16 bits of the 48 bit MAC address
#define ETH_MAC_REG16_LOCAL_MAC_MD    (0x03)
// Lower 16 bits of the 48 bit MAC address
#define ETH_MAC_REG16_LOCAL_MAC_LO    (0x02)

// Lower 8 bits is the last octet of the IP gateway address
#define ETH_MAC_REG32_LOCAL_GATEWAY   (0x03)

// 32 bit IP address
#define ETH_MAC_REG32_LOCAL_IPADDR    (0x04)

// Upper 16 bits are size/length of data in the CPU TX buffer
// Lower 16 bits are size/length of data in the CPU RX buffer
#define ETH_MAC_REG32_BUFFER_SIZES    (0x06)
// Size/length of data in CPU TX buffer (16 bit access)
#define ETH_MAC_REG16_TX_BUFFER_SIZE  (0x0d)
// Size/length of data in CPU RX buffer (16 bit access)
#define ETH_MAC_REG16_RX_BUFFER_SIZE  (0x0c)

// Control bits and UDP port for fabric receive
// Bit 24 is software reset (1 to reset, 0 to run)
// Bit 16 is enable bit (1 to enable, 0 to disable)
// Lower 16 bits are the UDP port for fabric receive.
// Note: In Verilog this is called `..._VALID_PORTS`.
#define ETH_MAC_REG32_CTRL_PORT       (0x08)
// Control bits (16 bit access)
// Bit 8 is software reset (1 to reset, 0 to run)
// Bit 0 is enable bit (1 to enable, 0 to disable)
#define ETH_MAC_REG16_CTRL            (0x11)
// Reset bit (8 bit access)
// Bit 0 is software reset (1 to reset, 0 to run)
#define ETH_MAC_REG8_RESET            (0x23)
// Enable bit (8 bit access)
// Bit 0 is enable bit (1 to enable, 0 to disable)
#define ETH_MAC_REG8_ENABLE           (0x22)
// CPU RX enabled (8 bit access)
// Bit 0 indicates status (1 is enabled, 0 is disabled)
#define ETH_MAC_REG8_RX_ENABLE        (0x26)
// CPU TX enabled (8 bit access)
// Bit 0 indicates status (1 is enabled, 0 is disabled)
#define ETH_MAC_REG8_TX_ENABLE        (0x27)
// XAUI status (8 bit access)
#define ETH_MAC_REG8_XAUI_STATUS      (0x24)
// UDP port for fabric receive (16 bit access)
#define ETH_MAC_REG16_PORT            (0x10)

// PHY config
#define ETH_MAC_REG32_PHY_CONFIG      (0x0a)

// XAUS config
#define ETH_MAC_REG32_XAUI_CONFIG     (0x0b)

// CPU IP address
#define ETH_MAC_REG32_MC_RECV_IP      (0x0c)

// CPU subnet mask
#define ETH_MAC_REG32_MC_RECV_IP_MASK (0x0d)

//
// Macros to get pointers to various TX/RX parts of the core whose base address
// is passed as a parameter.
//

// Can be used as pointer to RX buffer itself (as uint8_t)
#define RX_BUF_PTR8(p) \
  ((uint8_t *)(p + ETH_MAC_RX_BUFFER_OFFSET))

// Can be used as pointer to RX buffer itself (as uint32_t)
#define RX_BUF_PTR32(p) \
  ((uint32_t *)(p + ETH_MAC_RX_BUFFER_OFFSET))

// Can be used as pointer to RX buffer size (as uint16_t)
#define RX_BUF_SIZE_PTR16(p) \
  (((volatile uint16_t *)p) + ETH_MAC_REG16_RX_BUFFER_SIZE)

// Can be used as pointer to TX buffer itself (as uint8_t)
#define TX_BUF_PTR8(p) \
  ((uint8_t *)(p + ETH_MAC_TX_BUFFER_OFFSET))

// Can be used as pointer to TX buffer itself (as uint32_t)
#define TX_BUF_PTR32(p) \
  ((uint32_t *)(p + ETH_MAC_TX_BUFFER_OFFSET))

// Can be used as pointer to TX buffer size (as uint16_t)
#define TX_BUF_SIZE_PTR16(p) \
  (((volatile uint16_t *)p) + ETH_MAC_REG16_TX_BUFFER_SIZE)

// The data received in the RX buffer needs to be 4-byte byte-swapped into
// another region of 4-byte aligned memory.  If the RX buffer were writable, we
// could do the byte swap in-place, but it is not so we need to write the byte
// swapped values somewhere else.  In early development, we did this to a
// 4-byte aligned buffer that we statically declared in this file, but since we
// are a single threaded program and the byte-swapped data is transient (it is
// immediately copied to byte-aligned buffers in pbufs), we can utilize the TX
// buffer to hold the byte-swapped RX data!  This trick of using the TX buffer
// for other byte-swapped transient data is also useful for other purposes as
// well.
#define SWAPB_BUF_PTR8(x)  TX_BUF_PTR8(x)
#define SWAPB_BUF_PTR32(x) TX_BUF_PTR32(x)


// LwIP related macros and functions

#ifndef ETHERNET_MTU
#define ETHERNET_MTU 1500
#endif

// Called before main loop to initialize LwIP system
err_t casper_lwip_init();

// Called from main loop to handle LwIP related tasks
void casper_lwip_handler();

#ifdef JAM_SEND_TEST_PACKET
// Send a canned test packet (an ARP packet in this case)
void send_test_packet();
#endif // JAM_SEND_TEST_PACKET

#endif // _CASPER_ETH_H_
