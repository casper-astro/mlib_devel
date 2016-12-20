// Interface to CASPER ethernet device

#include "xil_printf.h"

#include "lwip/dhcp.h"
#include "lwip/etharp.h"
#include "lwip/init.h"
#include "lwip/timeouts.h"

#include "casper_eth.h"
#include "tmrctr.h"

// From core_info.tab
// TODO Get this from in-memory table
#define WB_ETH0_OFFSET (0x292f8)
#define ETH0_BASE_ADDRESS (XPAR_AXI_SLAVE_WISHBONE_CLASSIC_MASTER_0_BASEADDR + WB_ETH0_OFFSET)

static struct netif netif_e0;

static struct {
  void *ptr;
  uint8_t last_link_state;
} ifstate;

// Can be used as pointer to RX buffer itself (as uint8_t)
#define RX_BUF_PTR8(p) \
  ((uint8_t *)(p + ETH_MAC_RX_BUFFER_OFFSET))

// Can be used as pointer to RX buffer itself (as uint32_t)
#define RX_BUF_PTR32(p) \
  ((uint32_t *)(p + ETH_MAC_RX_BUFFER_OFFSET))

// Can be used as pointer to RX buffer size (as uint16_t)
#define RX_BUF_SIZE_PTR16(p) \
  (((uint16_t *)p) + ETH_MAC_REG16_RX_BUFFER_SIZE)

// Can be used as pointer to TX buffer itself (as uint8_t)
#define TX_BUF_PTR8(p) \
  ((uint8_t *)(p + ETH_MAC_TX_BUFFER_OFFSET))

// Can be used as pointer to TX buffer itself (as uint32_t)
#define TX_BUF_PTR32(p) \
  ((uint32_t *)(p + ETH_MAC_TX_BUFFER_OFFSET))

// Can be used as pointer to TX buffer size (as uint16_t)
#define TX_BUF_SIZE_PTR16(p) \
  (((uint16_t *)p) + ETH_MAC_REG16_TX_BUFFER_SIZE)

#ifdef DEBUG_LOOP_TX
#define casper_netif_output casper_netif_output_loop
#else
#define casper_netif_output casper_netif_output_impl
#endif

static
err_t
casper_netif_output_impl(struct netif *netif, struct pbuf *p)
{
#if 0
  uint16_t size32 = 0;
  uint16_t sent_size32 = 0;
  uint16_t total_size32 = 0;
  uint32_t *inbuf32;
  uint32_t in_word, out_word;
  int first = 1;
#endif
  uint16_t i, len;
  uint16_t bytes_sent = 0;
  uint16_t words_sent = 0;
  uint8_t *outbuf8;
  uint32_t *outbuf32;

#if 0
  // Calc number of 32 bit words in first pbuf (rounding up)
  size32 = (p->len+3) >> 2;
  // Calc total number of 32 bit words in packet (rounding up)
  total_size32 = (p->tot_len+3) >> 2;
#endif

  xil_printf("send %u bytes as %u longwords from addr %p [ms %u]\n",
      p->tot_len, ((p->tot_len+7)>>3), p->payload, ms_tmrctr());

#ifndef DEBUG_PKT_TX
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
    xil_printf("error: previous tx still in progress\n");
    LINK_STATS_INC(link.drop);
    return ERR_INPROGRESS;
  }
  else xil_printf("looped %d times waiting for previous tx to finish\n", i);

#if 0
  sent_size32 = 0;
  out_word = 0;
#endif
  outbuf8 = TX_BUF_PTR8(ifstate.ptr);

  // Potentially could have chain of pbufs that contain a single packet's data
  while(p) {
#if 0
    // If this is not the last pbuf, it must have a multiple of four bytes
    // (because I am lasy and don't want to write the codfe to carry over the
    // extra bytes to the next pbuf), otherwise return an error.
    if(p->tot_len > p->len && (p->len & 3)) {
      xil_printf("error: not last pbuf has %u words\n", p->len);

      while(p) {
        xil_printf("pbuf %x, tot_len %u, len %u, next %x\n",
            p, p->tot_len, p->len, p->next);
        for(i=0; i<8; i++) {
          if((i & 3) == 0) xil_printf("%04x:", (i<<2));
          xil_printf(" %08x", ((uint32_t *)p->payload)[i]);
          if((i & 3) == 3) print("\n");
        }
        if((i & 3) != 0) print("\n");
        p = p->next;
      }
      print("\n");

      LINK_STATS_INC(link.lenerr);
      LINK_STATS_INC(link.drop);
      return ERR_BUF;
    }
#endif

#if 1
    // Because p->len has been shown (during development) to be "wrong" (way
    // too big) when MEM_ALIGNMENT is "wrong" (e.g. 1 instead of 4), we have
    // this sanity check here.  If you ever see the "YIKES" message, the
    // software is buggy.
    len = p->len;
    if(p->len > p->tot_len) {
      xil_printf("YIKES p->len > p->tot_len (%u > %u), using p->tot_len\n",
          p->len, p->tot_len);
      len = p->tot_len;
    }

    // Copy byte aligned data to 4-byte aligned TX buffer
    xil_printf("copying %u of %u bytes from pbuf %p payload %p to tx buf %p\n",
        len, p->tot_len, p, p->payload, outbuf8);
    memcpy(outbuf8, p->payload, len);
    outbuf8 += len;
    bytes_sent += len;

//  // Byte swap 32 bit words and output them.
//  for(i=0; i<size32; i++) {
//    *outbuf32++ = mb_swapb(*inbuf32++);
//  }

//  sent_size32 += size32;
#else
    // Calc number of 32 bit words in current pbuf (rounding up).  I think the
    // rounding part is not strictly needed because we set MEM_ALIGNMENT to 8.
    size32 = (p->len+3) >> 2;

    // Copy pbuf payload to TX buffer.  This is not so trivial.  Due to the way
    // the ethernet header gets packed by the compiler, the packet data is
    // offset by 2 bytes in the payload.  The bytes in memory are arranged as:
    //
    //     PP PP 00 01 02 03 04 05 06 07 .. ..
    //
    // where PP is a padding(?)/packing(?) byte and the other bytes are
    // numbered in the order they should go out on the link.  Because we are on
    // a 32-bit system, the most efficient way to access the data is as
    // unint32_t values.  Because this is a little endian system, these
    // uint32_t values appear in the payload of the first PBUF as:
    //
    //     0x0100PPPP 0x05040302 0x09080706 ...
    //
    // We cannot send the PP bytes to the ethernet TX buffer.  To further
    // complicate things, the 32 bit words that we write to the TX buffer get
    // byte swapped along the way due to how the AXI/Wishbone interface is
    // wired in the FPGA.  We therefore have to send the data to the TX buffer
    // as:
    //
    //     0x00010203 0x04050607 0x....0908 ...
    //     
    // Here's how to perform this permutation.  Data bytes are numbered in
    // transmit sequence.  Intermediate zero-values bytes are shown as "__".
    // Some steps can be combined, but are shown separately for clarity.
    // Operations that happen only for the first word of the first PBUF are
    // marked with "[first]".
    //
    //      out_word   in_word   operation
    //     ========== ========== ==============
    //     0x0100PPPP            [first] load value from pbuf
    //     0xPPPP0001            [first] swap bytes
    //     0x0001____            [first] shift left 16 bits
    //                0x05040302 load next value from pbuf
    //                0x03020504 swap half-words
    //                0x04050203 swap bytes
    //     0x00010203            bit-or low half of in_word into out_word
    //                           write out_word to tx buffer
    //     0x04050203            move in_word to out_word
    //     0x0405____            mask off low half of in_word
    //                           repeat non-first steps for all words in all pbufs.
    //                           finally output final word
    //
    inbuf = (uint32_t *)p->payload;
    i = 0;
    if(first) {
      first = 0;
      out_word = mb_swapb(*inbuf++) << 16;
      i++;
    }
    for(; i<size32; i++) {
      // Read word from inbuf and massage it
      in_word = mb_swapb(mb_swaph(*inbuf++));
      // Output combined half-words
      *outbuf++ = out_word | (in_word & 0x0000ffff);
      sent_size32++;
      // Move in_word to out_word and mask off low half
      out_word = in_word & 0xffff0000;
    }
#endif

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

#if 0
  // Finally output final word
  *outbuf++ = out_word;
  sent_size32++;
#endif

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

#ifndef DEBUG_PKT_TX
  outbuf32 = TX_BUF_PTR32(ifstate.ptr);
  xil_printf("TX device buf %08x:\n", outbuf32);
  //for(i=0; i<sent_size32; i++) {
  for(i=0; i<8; i++) {
    if((i & 3) == 0) xil_printf("%04x:", (i<<2));
    xil_printf(" %08x", outbuf32[i]);
    if((i & 3) == 3) print("\n");
  }
  if((i & 3) != 0) print("\n");
  print("\n");
#endif // DEBUG_PKT_TX

  // Set TX buffer level to number of 8 byte words to send packet
  *TX_BUF_SIZE_PTR16(ifstate.ptr) = (words_sent >> 1);

  xil_printf("sent pkt %u bytes as %u longwords [ms %u]\n",
      4*words_sent, (words_sent >> 1), ms_tmrctr());
  LINK_STATS_INC(link.xmit);

  // Loop a bunch of times waiting for TX buffer to be free
  // (indicated by size going to 0)
  for(i=0; i<1000; i++) {
    // If length is zero, then TX buffer is free
    if(*TX_BUF_SIZE_PTR16(ifstate.ptr) == 0) break;
  }

  if(i == 1000) {
    // Core still busy sending packet.
    xil_printf("warning: packet tx is slow\n");
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

  return ERR_OK;
}

#define get_link_state() \
  (((uint32_t *)ifstate.ptr)[ETH_MAC_REG32_XAUI_STATUS] & 1)

err_t
casper_lwip_init()
{
  int i, j;

  // Init local ifstate
  ifstate.ptr = (void *)ETH0_BASE_ADDRESS;
  ifstate.last_link_state = -1;

  print("## eth0 memory as uint32_t:\n");
  for(i=0; i<4; i++) {
    xil_printf("%02x:", 16*i);
    for(j=0; j<4; j++) {
      //xil_printf(" %08x", *(((uint32_t *)ETH0_BASE_ADDRESS) + 4*i+j));
      xil_printf(" %08x", ((uint32_t *)ifstate.ptr)[4*i+j]);
    }
    print("\n");
  }

  // TODO Get MAC address from somewhere (e.g. serial number stored in flash)
  // Needs to be stored in hardware core as:
  //     0x----0001 0x02030405
  ((uint32_t *)ifstate.ptr)[ETH_MAC_REG32_LOCAL_MAC_1] = 0x00000203;
  ((uint32_t *)ifstate.ptr)[ETH_MAC_REG32_LOCAL_MAC_0] = 0x04050607;

  print("## eth0 memory as uint32_t:\n");
  for(i=0; i<4; i++) {
    xil_printf("%02x:", 16*i);
    for(j=0; j<4; j++) {
      //xil_printf(" %08x", *(((uint32_t *)ETH0_BASE_ADDRESS) + 4*i+j));
      xil_printf(" %08x", ((uint32_t *)ifstate.ptr)[4*i+j]);
    }
    print("\n");
  }

  // Now initialize LwIP
  lwip_init();

  // Set interface name before adding interface to LwIP
  netif_e0.name[0] = 'e';
  netif_e0.name[1] = 'n';

  netif_add(&netif_e0,
      IP4_ADDR_ANY, IP4_ADDR_ANY, IP4_ADDR_ANY,
      &ifstate, casper_netif_init, netif_input);

  netif_set_default(&netif_e0);
  netif_set_up(&netif_e0);

  // Start DHCP
  dhcp_start(&netif_e0);

  return ERR_OK;
}

void
casper_lwip_handler()
{
  uint16_t i, size64, size32;
  uint32_t *inbuf, *outbuf;
#if 0
  uint32_t in_word, out_word;
#endif
  struct pbuf *p;
  uint32_t link_state;

  // Get link state
  link_state = get_link_state();
  // Check whether it changed
  if(ifstate.last_link_state != link_state) {
    ifstate.last_link_state = link_state;
    xil_printf("link is %s\n", link_state ? "UP" : "DOWN");
    if(link_state) {
      netif_set_link_up(&netif_e0);
    } else {
      netif_set_link_down(&netif_e0);
    }
  }

  // Check for received frames, feed them to lwIP
  if((size64 = *RX_BUF_SIZE_PTR16(ifstate.ptr))) {
    // Get pbuf from pool
    p = pbuf_alloc(PBUF_RAW, (size64<<3)+2, PBUF_POOL);

    // If we got NULL or not a single PBUF
    if(!p || p->tot_len > p->len) {
      // Ack packet so we'll receive more packets
      *RX_BUF_SIZE_PTR16(ifstate.ptr) = 0;
      LINK_STATS_INC(link.memerr);
      LINK_STATS_INC(link.drop);
      xil_printf("bad pbuf for %d bytes [ms %u]\n",
          (size64<<3)+2, ms_tmrctr());
    } else {
      LINK_STATS_INC(link.recv);
      inbuf = RX_BUF_PTR32(ifstate.ptr);
      outbuf = (uint32_t *)p->payload;
      size32 = size64 << 1;
      xil_printf("rx pkt %u words [ms %u]\n", size32, ms_tmrctr());

#ifdef DEBUG_PKT_RX
      print("RX device buf:\n");
      for(i=0; i<size32; i++) {
        if((i & 3) == 0) xil_printf("%04x:", (i<<2));
        xil_printf(" %08x", inbuf[i]);
        if((i & 3) == 3) print("\n");
      }
      if((i & 3) != 0) print("\n");
      print("\n");
#endif // DEBUG_PKT_RX

      // Copy packet from the RX buffer.  This is not so trivial.  The packet
      // data, when accessed as type uint32_t, appear in the RX buffer as:
      //
      //     0x00010203 0x04050607 ...
      //
      // Due to the way the PBUF ethernet header gets packed by the compiler, the
      // packet data needs to be offset by 2 bytes in the PBUF.  The bytes in the
      // PBUF need to be are arranged as:
      //
      //     PP PP 00 01 02 03 04 05 06 07 .. ..
      //
      // where PP is a padding/packing byte and the other bytes are numbered in
      // network byte order.  Because we are on a 32-bit system, the most
      // efficient way to access the data is as unint32_t values.  Because this
      // is a little endian system, these uint32_t values need to appear in the
      // payload of the PBUF as:
      //
      //     0x0100PPPP 0x05040302 0x....0706
      //
      // Here's how to perform this permutation.  Data bytes are numbered in
      // network byte order.  Intermediate zero-values bytes are shown as "__".
      // Some steps can be combined, but are shown separately for clarity.
      // Operations that happen only for the first word of the PBUF are marked
      // with "[first]".
      //
      //      out_word   in_word   operation
      //     ========== ========== ==============
      //     0x________            [first] init out_word to 0
      //                0x00010203 load value from rx buffer
      //                0x03020100 swap bytes
      //                0x01000302 swap half words
      //     0x0100____            bit-or high half of in_word into out_word
      //                           write out_word to pbuf payload
      //     0x01000302            move in_word to out_word
      //     0x____0302            mask off high half of in_word
      //                           repeat non-first steps for all words in all pbufs.
      //                           finally output final word
      //
#if 0
      out_word = 0;
#endif
      for(i=0; i<size32; i++) {
#if 1
        // Output combined half-words
        *outbuf++ = mb_swapb(*inbuf++);
#else
        // Read word from inbuf and massage it
        in_word = mb_swaph(mb_swapb(*inbuf++));
        // Output combined half-words
        *outbuf++ = out_word | (in_word & 0xffff0000);
        // Move in_word to out_word and mask off high half
        out_word = in_word & 0x0000ffff;
#endif
      }

      // Done with RX buffer, so ack the packet
      *RX_BUF_SIZE_PTR16(ifstate.ptr) = 0;

#ifdef DEBUG_PKT_RX
      outbuf = (uint32_t *)p->payload;
      for(i=0; i<size32; i++) {
        if((i & 3) == 0) xil_printf("%04x:", (i<<2));
        xil_printf(" %08x", outbuf[i]);
        if((i & 3) == 3) print("\n");
      }
      if((i & 3) != 0) print("\n");
      print("\n");
#endif // DEBUG_PKT_RX

      // Pass PBUF to input function
      if(netif_e0.input(p, &netif_e0) != ERR_OK) {
        pbuf_free(p);
      }
    }

  }

  // Cyclic LwIP timers check
  sys_check_timeouts();
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
