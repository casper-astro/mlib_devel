// Interface to CASPER ethernet device

#include "xil_printf.h"

#include "lwip/dhcp.h"
#include "lwip/etharp.h"
#include "lwip/init.h"
#include "lwip/timeouts.h"

#include "casper_devcsl.h"
#include "casper_eth.h"
#include "casper_tftp.h"
#include "flash.h"
#include "tmrctr.h"

// Array of one (for now)
static struct netif netif_en[1];

// This should be an array as well
static struct {
  void *ptr;
  uint8_t last_link_state;
} ifstate;

#ifdef DEBUG_LOOP_TX
#define casper_netif_output casper_netif_output_loop
#else
#define casper_netif_output casper_netif_output_impl
#endif

// Function prototypes
static void casper_monitor_links();

static
err_t
casper_netif_output_impl(struct netif *netif, struct pbuf *p)
{
  uint16_t i, len;
  uint16_t bytes_sent = 0;
  uint8_t *outbuf8;
  uint16_t words_sent = 0;
  uint32_t *outbuf32;

#ifdef VERBOSE_ETH_IMPL
  xil_printf("send %u bytes as %u longwords from addr %p [ms %u]\n",
      p->tot_len, ((p->tot_len+7)>>3), p->payload, ms_tmrctr());
#endif // VERBOSE_ETH_IMPL

#ifdef DEBUG_PKT_TX
  // Print first 32 bytes of packet
  for(i=0; i<32; i++) {
    if((i & 15) == 0) xil_printf("%04x:", (i<<2));
    xil_printf(" %02x", ((uint8_t *)p->payload)[i]);
    if((i & 15) == 15) print("\n");
  }
  if((i & 15) != 0) print("\n");
  print("\n");
#endif // DEBUG_PKT_TX

  // Loop a bunch of times waiting for TX buffer to be free
  // (indicated by size going to 0)
  for(i=0; i<1000; i++) {
    // If length is zero, then TX buffer is free
    if(*TX_BUF_SIZE_PTR16(ifstate.ptr) == 0) break;
  }

  if(i == 1000) {
    // Core still busy sending previous packets.  Not sure this is the most
    // approprite error code to return, but at least it's not ERR_OK.
    xil_printf("err: prev tx not done\n");
    LINK_STATS_INC(link.drop);
    return ERR_INPROGRESS;
  }
#ifdef VERBOSE_ETH_IMPL
  else xil_printf("looped %d times waiting for previous tx to finish\n", i);
#endif // VERBOSE_ETH_IMPL

  outbuf8 = TX_BUF_PTR8(ifstate.ptr);

  // Potentially could have chain of pbufs that contain a single packet's data
  while(p) {
    // Because p->len has been shown (during development) to be "wrong" (way
    // too big) when MEM_ALIGNMENT is "wrong" (e.g. 1 instead of 4), we have
    // this sanity check here.  If you ever see the "YIKES" message, the
    // software is buggy.
    len = p->len;
    if(p->len > p->tot_len) {
      xil_printf("YIKES p->len > p->tot_len (%u > %u), using tot_len\n",
          p->len, p->tot_len);
      len = p->tot_len;
    }

    // Copy byte aligned data to 4-byte aligned TX buffer
#ifdef VERBOSE_ETH_IMPL
    xil_printf("copying %u of %u bytes from pbuf %p payload %p to tx buf %p\n",
        len, p->tot_len, p, p->payload, outbuf8);
#endif // VERBOSE_ETH_IMPL
    memcpy(outbuf8, p->payload, len);
    outbuf8 += len;
    bytes_sent += len;

    // Break out if this is the last pbuf of packet.  p->tot_len should "never"
    // be less than p->len, but that would certianly be an exit condition!
    if(p->tot_len <= p->len) {
      break;
    }

    // Go to next pbuf (if any)
    p = p->next;
  }

  // Zero-pad out to next 32-bit word boundary
  while(bytes_sent & 3) {
    *outbuf8++ = 0;
    bytes_sent++;
  }

  // Work with words from here onward
  words_sent = bytes_sent >> 2;

  // Need to byte swap 32 bit words in TX buffer
  // due to how AXI/Wishbone interface orders bytes
  outbuf32 = TX_BUF_PTR32(ifstate.ptr);
  for(i=0; i<words_sent; i++) {
    *outbuf32 = mb_swapb(*outbuf32);
    outbuf32++;
  }

  // Ensure we meet minimum packet size (avoid runt frames)
  while(words_sent < 16) {
    *outbuf32++ = 0;
    words_sent++;
  }

  // Need to send a multiple of 8 bytes (due to gateware implementation)
  if(words_sent & 1) {
    *outbuf32++ = 0;
    words_sent++;
  }

#ifdef DEBUG_PKT_TX
  outbuf32 = TX_BUF_PTR32(ifstate.ptr);
  xil_printf("TX device buf %p:\n", outbuf32);
  for(i=0; i<8; i++) {
    if((i & 3) == 0) xil_printf("%04x:", (i<<2));
    xil_printf(" %08x", outbuf32[i]);
    if((i & 3) == 3) print("\n");
  }
  if((i & 3) != 0) print("\n");
  print("\n");
#endif // DEBUG_PKT_TX

#if 1 // TODO
#else // TODO
  // cheesy tcpdump
  // last two octets of dst mac, ethertype, src udp port, udp length, tftp opcode, ms
  // obviously udp and tftp fields are valid only for udp and tftp packet.
  uint16_t *outbuf16 = (uint16_t *)TX_BUF_PTR32(ifstate.ptr);
  xil_printf("TX %04x %04x %04x %04x %04x %u\n",
    outbuf16[2^1], outbuf16[6^1], outbuf16[17^1], outbuf16[19^1], outbuf16[21^1], ms_tmrctr());
#endif

  // Set TX buffer level to number of 8 byte words to send packet
  *TX_BUF_SIZE_PTR16(ifstate.ptr) = (words_sent >> 1);

#ifdef VERBOSE_ETH_IMPL
  xil_printf("sent pkt %u bytes as %u longwords [ms %u]\n",
      4*words_sent, (words_sent >> 1), ms_tmrctr());
#endif // VERBOSE_ETH_IMPL
  LINK_STATS_INC(link.xmit);

  // Probably over conservative to check for TX completion here and upon
  // entrance to this function, but better safe than sorry.
  //
  // Loop a bunch of times waiting for TX buffer to be free
  // (indicated by size going to 0)
  for(i=0; i<1000; i++) {
    // If length is zero, then TX buffer is free
    if(*TX_BUF_SIZE_PTR16(ifstate.ptr) == 0) break;
  }

  if(i == 1000) {
    // Core still busy sending packet.
    xil_printf("warn: packet tx is slow\n");
  }

  return ERR_OK;
}

#ifdef DEBUG_LOOP_TX
static
err_t
casper_netif_output_loop(struct netif *netif, struct pbuf *p)
{
  int i;
  err_t rc;
  for(i=0; i<3; i++) {
    rc = casper_netif_output_impl(netif, p);
    if(rc != ERR_OK) {
      xil_printf("casper_netif_output_impl returned %d\n", rc);
      return rc;
    }
  }
  return ERR_OK;
}
#endif // DEBUG_LOOP_TX

static
void
casper_netif_status_callback(struct netif *netif)
{
  err_t rc;

#ifdef VERBOSE_ETH_IMPL
  xil_printf("casper_netif_status_callback()\n");
#endif // VERBOSE_ETH_IMPL
  xil_printf("IP %08X  NM %08X  GW %08X\n",
      mb_swapb(netif->ip_addr.addr),
      mb_swapb(netif->netmask.addr),
      mb_swapb(netif->gw.addr));

  if(netif->ip_addr.addr != 0) {
    if((rc = casper_tftp_init()) != ERR_OK) {
      xil_printf("TAPCP server startup failed (%d)\n", rc);
    } else {
      xil_printf("TAPCP server ready\n");
    }
  }
#ifdef VERBOSE_ETH_IMPL
  else print("no ip address, NOT starting TAPCP\n");
#endif // VERBOSE_ETH_IMPL
}

static
err_t
casper_netif_init(struct netif *netif)
{
  uint16_t mac16;

  netif->linkoutput = casper_netif_output;
  netif->output     = etharp_output;
  netif->mtu        = ETHERNET_MTU;
  netif->flags      = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_ETHERNET;
  netif->hwaddr_len = ETH_HWADDR_LEN;

  // Get local MAC address from 10 GbE core
  mac16 = ((uint16_t *)ifstate.ptr)[ETH_MAC_REG16_LOCAL_MAC_HI];
  netif->hwaddr[0] = (mac16 >> 8) & 0xff;
  netif->hwaddr[1] = (mac16     ) & 0xff;
  mac16 = ((uint16_t *)ifstate.ptr)[ETH_MAC_REG16_LOCAL_MAC_MD];
  netif->hwaddr[2] = (mac16 >> 8) & 0xff;
  netif->hwaddr[3] = (mac16     ) & 0xff;
  mac16 = ((uint16_t *)ifstate.ptr)[ETH_MAC_REG16_LOCAL_MAC_LO];
  netif->hwaddr[4] = (mac16 >> 8) & 0xff;
  netif->hwaddr[5] = (mac16     ) & 0xff;

  // Add status callback
  netif->status_callback = casper_netif_status_callback;

  return ERR_OK;
}

#define get_link_state() \
  (((uint8_t *)ifstate.ptr)[ETH_MAC_REG8_XAUI_STATUS] & 1)

err_t
casper_lwip_init()
{
  const uint8_t *core_name;
#ifdef DEBUG_ETH0_MEM
  int i;
  int j;
#endif // DEBUG_ETH0_MEM

  // Init local ifstate
  ifstate.ptr = (void *)casper_find_dev_by_typecode(
      CASPER_CORE_INFO_TYPECODE_ETHCORE, 1, NULL, &core_name);
  ifstate.last_link_state = -1;

  if(!ifstate.ptr) {
    print("No ethernet cores found!\n");
    return ERR_IF;
  }

  print("using ethernet core ");
  print((const char *)core_name);
  print("\n");

#ifdef DEBUG_ETH0_MEM
  print("## eth0 memory as uint32_t:\n");
  for(i=0; i<4; i++) {
    xil_printf("%02x:", 16*i);
    for(j=0; j<4; j++) {
      xil_printf(" %08x", ((uint32_t *)ifstate.ptr)[4*i+j]);
    }
    print("\n");
  }
#endif // DEBUG_ETH0_MEM

  // TODO Get MAC address from somewhere (e.g. serial number stored in flash)
  // Needs to be stored in hardware core as:
  //     0x----0001 0x02030405
  uint8_t buf[16];
  flash_read_id(buf);
  ((uint32_t *)ifstate.ptr)[ETH_MAC_REG32_LOCAL_MAC_1] = ((uint32_t *)buf)[2] & 0xffff;
  ((uint32_t *)ifstate.ptr)[ETH_MAC_REG32_LOCAL_MAC_0] = ((uint32_t *)buf)[3];
  xil_printf("MAC 0x%04x%08x\n", ((uint32_t *)buf)[2] & 0xffff, ((uint32_t *)buf)[3]);

#ifdef DEBUG_ETH0_MEM
  print("## eth0 memory as uint32_t:\n");
  for(i=0; i<4; i++) {
    xil_printf("%02x:", 16*i);
    for(j=0; j<4; j++) {
      xil_printf(" %08x", ((uint32_t *)ifstate.ptr)[4*i+j]);
    }
    print("\n");
  }
#endif // DEBUG_ETH0_MEM

  // Now initialize LwIP
  lwip_init();

  // Set interface name before adding interface to LwIP
  netif_en[0].name[0] = 'e';
  netif_en[0].name[1] = 'n';

  netif_add(&netif_en[0],
      IP4_ADDR_ANY, IP4_ADDR_ANY, IP4_ADDR_ANY,
      &ifstate, casper_netif_init, netif_input);

  netif_set_default(&netif_en[0]);
  netif_set_up(&netif_en[0]);

  // Start DHCP
  dhcp_start(&netif_en[0]);

  // Check links
  casper_monitor_links();

  return ERR_OK;
}

static
void
casper_monitor_links()
{
  uint32_t link_state;

  // Get link state
  link_state = get_link_state();

  // Check whether it changed
  if(ifstate.last_link_state != link_state) {
    ifstate.last_link_state = link_state;
    xil_printf("link is %s\n", link_state ? "UP" : "DOWN");
    if(link_state) {
      netif_set_link_up(&netif_en[0]);
    } else {
      netif_set_link_down(&netif_en[0]);
    }
  }
}

static
void
casper_rx_packet()
{
  int i;
  uint16_t size64;
  uint16_t size32;
  uint16_t bytes_remaining;
  uint8_t *inbuf8;
  uint32_t *inbuf32;
  uint32_t *nibuf32; // byte swapped buffer ("ni" is byte swapped "in" :))
  struct pbuf *p, *q;

  // Stay in this function so long as we still have received packets
  while((size64 = *RX_BUF_SIZE_PTR16(ifstate.ptr))) {
    // Work with words
    size32 = size64 << 1;

    // If packet too large
    if(size32 > ETHERNET_MTU + SIZEOF_ETH_HDR) {
      // Ack packet so we'll receive more packets
      *RX_BUF_SIZE_PTR16(ifstate.ptr) = 0;
      LINK_STATS_INC(link.memerr);
      LINK_STATS_INC(link.drop);
      xil_printf("pkt too big %u > %u words [ms %u]\n",
          size32, ETHERNET_MTU + SIZEOF_ETH_HDR, ms_tmrctr());
      // See if we have any more packets
      continue;
    }

    // Get pbuf from pool
    p = pbuf_alloc(PBUF_RAW, (size32<<2), PBUF_POOL);

    // If we got NULL
    if(!p) {
      // Ack packet so we'll receive more packets
      *RX_BUF_SIZE_PTR16(ifstate.ptr) = 0;
      LINK_STATS_INC(link.memerr);
      LINK_STATS_INC(link.drop);
      xil_printf("bad pbuf for %d bytes [ms %u]\n",
          (size32<<2), ms_tmrctr());
      // See if we have any more packets
      continue;
    }

    // OK, got one or more pbufs to hold our packet data
    LINK_STATS_INC(link.recv);
    size32 = size64 << 1;
#ifdef VERBOSE_ETH_IMPL
    xil_printf("read %u bytes as %u longwords to addr %p [ms %u]\n",
        (size32<<2), size64, p->payload, ms_tmrctr());
#endif // VERBOSE_ETH_IMPL

#if 1 // TODO
#else // TODO
    // cheesy tcpdump
    // last two octets of src mac, ethertype, dst udp port, udp length, tftp opcode, ms
    // obviously udp and tftp fields are valid only for udp and tftp packet.
    uint16_t *inbuf16 = (uint16_t *)RX_BUF_PTR32(ifstate.ptr);
    xil_printf("RX %04x %04x %04x %04x %04x %u\n",
      inbuf16[5^1], inbuf16[6^1], inbuf16[18^1], inbuf16[19^1], inbuf16[21^1], ms_tmrctr());
#endif

    // Need to byte swap 32 bit words in RX buffer due to how AXI/Wishbone
    // interface orders bytes.  Since we can't do this in-place in the RX
    // buffer (because it is read-only for some reason or other that escapes my
    // understanding), we do it the TX buffer since it is unused by the time we
    // get here (any packet sent was transmitted long ago).
    inbuf32 = RX_BUF_PTR32(ifstate.ptr);
    nibuf32 = SWAPB_BUF_PTR32(ifstate.ptr);
#ifdef VERBOSE_ETH_IMPL
    xil_printf("byte swapping %u words to TX buff\n", size32);
#endif // VERBOSE_ETH_IMPL
    for(i=0; i<size32; i++) {
      *nibuf32++ = mb_swapb(*inbuf32++);
    }

#ifdef DEBUG_PKT_RX
    nibuf32 = SWAPB_BUF_PTR32(ifstate.ptr);
    xil_printf("RX byte-swapped buf %p:\n", nibuf32);
    for(i=0; i<8; i++) {
      if((i & 3) == 0) xil_printf("%04x:", (i<<2));
      xil_printf(" %08x", nibuf32[i]);
      if((i & 3) == 3) print("\n");
    }
    if((i & 3) != 0) print("\n");
    print("\n");
#endif // DEBUG_PKT_RX

    // Copy packet from the 4-byte aligned RX byte-swapped buffer (i.e. TX
    // buffer, see comments above) to possibly unalinged pbuf(s), so do it
    // using memcpy.  Use q to walk the pbufs.
    inbuf8 = SWAPB_BUF_PTR8(ifstate.ptr);
    bytes_remaining = (size32<<2);
    q = p;
    while(q) {
      // Determine how many bytes to copy
      if(bytes_remaining <= q->len) {
        // This will be last pbuf
        q->len     = bytes_remaining;
        q->tot_len = bytes_remaining;
        // If this is not the first pbuf
        if(q != p) {
          // TODO adjust tot_len of earlier pbufs.
          print("YIKES pkt rx truncating non-first pbuf!\n");
        }
      }
      // Copy bytes
      memcpy(q->payload, inbuf8, q->len);
      // Adjust pointer and bytes remaining counter
      inbuf8 += q->len;
      bytes_remaining -= q->len;

      // Break out if this is the last pbuf of packet.  q->tot_len should
      // "never" be less than q->len, but that would certianly be an exit
      // condition!
      if(q->tot_len <= q->len) {
        break;
      }

      // Go to next pbuf (if any)
      q = q->next;
    }

    // Done with RX buffer, so ack the packet
    *RX_BUF_SIZE_PTR16(ifstate.ptr) = 0;

#ifdef DEBUG_PKT_RX
    // Print first 32 bytes of first pbuf
    for(i=0; i<32; i++) {
      if((i & 15) == 0) xil_printf("%04x:", (i<<2));
      xil_printf(" %02x", ((uint8_t *)p->payload)[i]);
      if((i & 15) == 15) print("\n");
    }
    if((i & 15) != 0) print("\n");
    print("\n");
#endif // DEBUG_PKT_RX

    // Pass PBUF to input function
    if(netif_en[0].input(p, &netif_en[0]) != ERR_OK) {
      pbuf_free(p);
    }
  }
}

#ifndef JAM_LWIP_CHECK_TIMEOUTS_INTERVAL_MS
#define JAM_LWIP_CHECK_TIMEOUTS_INTERVAL_MS 10
#endif

void
casper_lwip_handler()
{
  static uint32_t next_timeout_check_ms = JAM_LWIP_CHECK_TIMEOUTS_INTERVAL_MS;
  uint32_t curr_ms;

  // Monitor links (TODO handle more than one link)
  casper_monitor_links();

  // Receive newly arrive packet, if any
  casper_rx_packet();

  // Only call timeout check every so often (10 ms by default).
  curr_ms = ms_tmrctr();
  if(next_timeout_check_ms <= curr_ms) {
    next_timeout_check_ms = curr_ms + JAM_LWIP_CHECK_TIMEOUTS_INTERVAL_MS;

    // Cyclic LwIP timers check
    sys_check_timeouts();
  }
}

#ifdef JAM_SEND_TEST_PACKET
void
send_test_packet()
{
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
  int i;

  int pktlen8 = 64;
  uint8_t pkt8[] = {
    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x02, 0x02, 0x08, 0x08, 0x08, 0x08, 0x08, 0x06, 0x00, 0x01,
    0x08, 0x00, 0x06, 0x04, 0x00, 0x01, 0x02, 0x02, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0x14, 0x1e, 0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
  };

  int pktlen32 = 16;
  uint32_t pkt32[] = {
    0xffffffff, 0xffff0202, 0x0a0a0a0a, 0x08060001,
    0x08000604, 0x00010202, 0x0a0a0a0a, 0x0a0a0a0a,
    0x00000000, 0x00000a14, 0x1e280000, 0x00000000,
    0x00000000, 0x00000000, 0x00000000, 0x00000000
  };

  uint32_t *outbuf;

  // Loop a bunch of times waiting for TX buffer to be free
  // (indicated by size going to 0)
  for(i=0; i<10000; i++) {
    // If length is zero, then TX buffer is free
    if(!*TX_BUF_SIZE_PTR16(ifstate.ptr)) break;
  }

  if(i > 0) {
    xil_printf("looped %d times waiting for TX buffer\n\n", i);
  }

  print("send pkt32\n");

  // Copy packet to TX buffer
  for(i=0; i<pktlen32; i++) {
    TX_BUF_PTR32(ifstate.ptr)[i] = pkt32[i];
  }

  // Set TX buffer size to number of 8 byte words to send packet
  *TX_BUF_SIZE_PTR16(ifstate.ptr) = pktlen32/2;

  print("send pkt8\n");

  // Copy packet to TX buffer
  memcpy(TX_BUF_PTR8(ifstate.ptr), pkt8, pktlen8);
  outbuf = TX_BUF_PTR32(ifstate.ptr);
  // Byte swap the packet
  for(i=0; i<pktlen32; i++) {
    *outbuf = mb_swapb(*outbuf);
    outbuf++;
  }

  // Set TX buffer size to number of 8 byte words to send packet
  *TX_BUF_SIZE_PTR16(ifstate.ptr) = pktlen32/2;
}
#endif // JAM_SEND_TEST_PACKET
