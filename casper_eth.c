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

static struct netif netif;

static struct {
  void *ptr;
  uint8_t last_link_state;
} ifstate;

// Can be used as pointer to RX buffer itself (as uint32_t)
#define RX_BUF_PTR(p) \
  ((uint32_t *)(p + ETH_MAC_RX_BUFFER_OFFSET))

// Can be used as pointer to RX buffer size (as uint16_t)
#define RX_BUF_SIZE_PTR(p) \
  (((uint16_t *)p) + ETH_MAC_REG16_RX_BUFFER_SIZE)

// Can be used as pointer to TX buffer itself (as uint32_t)
#define TX_BUF_PTR(p) \
  ((uint32_t *)(p + ETH_MAC_TX_BUFFER_OFFSET))

// Can be used as pointer to TX buffer size (as uint16_t)
#define TX_BUF_SIZE_PTR(p) \
  (((uint16_t *)p) + ETH_MAC_REG16_TX_BUFFER_SIZE)

static
err_t
casper_netif_output(struct netif *netif, struct pbuf *p)
{
  uint16_t i;
  uint16_t size32 = 0;
  uint16_t total_size32 = 0;
  uint32_t *inbuf, *outbuf;
  uint32_t in_word, out_word;
  int first = 1;

  // Calc number of 32 bit words in packet (rounding up)
  size32 = (p->len+3) >> 2;

  xil_printf("send pkt %u bytes %u words [tick %u]\n",
      p->len, size32, tick_tmrctr());

//#if 0
  for(i=0; i<size32; i++) {
    if((i & 3) == 0) xil_printf("%04x:", (i<<2));
    xil_printf(" %08x", ((uint32_t *)p->payload)[i]);
    if((i & 3) == 3) print("\n");
  }
  if((i & 3) != 0) print("\n");
  print("\n");
//#else
  // Loop a bunch of times waiting for TX buffer to be free
  // (indicated by size going to 0)
  for(i=0; i<1000; i++) {
    // If length is zero, then TX buffer is free
    if(*TX_BUF_SIZE_PTR(ifstate.ptr) == 0) break;
  }

  if(i > 1000) {
    // Core still busy sending previous packets.  Not sure this is the most
    // approprite error code to return, but at least it's not ERR_OK.
    xil_printf("error: previous tx still in progress\n");
    return ERR_INPROGRESS;
  }

  outbuf = TX_BUF_PTR(ifstate.ptr);

  // Potentially could have chain of pbufs
  while(p) {
    // If this is not the last pbuf, it must have a multiple of four bytes,
    // otherwise return an error.  I think this is not strictly needed because
    // we set MEM_ALIGNMENT to 8.
    if(p->next && (p->len & 3)) {
      xil_printf("error: not last pbuf has %u words\n", p->len);
      return ERR_BUF;
    }

    // Calc number of 32 bit words in packet (rounding up).  I think the
    // rounding part is not strictly needed because we set MEM_ALIGNMENT to 8.
    size32 = (p->len+3) >> 2;

    // Copy packet to TX buffer.  This is not so trivial.  Due to the way the
    // ethernet header gets packed by the compiler, the packet data is offset
    // by 2 bytes in the payload.  The bytes in memory are arranged as:
    //
    //     PP PP 00 01 02 03 04 05 06 07 .. ..
    //
    // where PP is a padding/packing byte and the other bytes are numbered in
    // the order they should go out on the link.  Because we are on a 32-bit
    // system, the most efficient way to access the data is as unint32_t
    // values.  Because this is a little endian system, these uint32_t values
    // appear in the payload of the first PBUF as:
    //
    //     0x0100PPPP 0x05040302 0x....0706
    //
    // We cannot send the PP bytes to the ethernet TX buffer.  To further
    // complicate things, the 32 bit words that we write to the TX buffer get
    // byte swapped along the way due to how the AXI/Wishbone interface is
    // wired in the FPGA.  We therefore have to send the data to the TX buffer
    // as:
    //
    //     0x00010203 0x04050607 0x....0706
    //     
    // Here's how to perform this permutation.  Data bytes are numbered in
    // transmit sequence.  Intermediate zero-values bytes are shown as "__".
    // Some steps can be combined, but are shown separately for clarity.
    // Operations that happen only for the first word of the first PBUF are
    // marked with "[first]"
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
      *outbuf++ = out_word | (in_word & 0xffff);
      // Move in_word to out_word and mask off low half
      out_word = in_word & 0xffff0000;
    }

    // Increment total_size32
    total_size32 += size32;

    // Go to next pbuf (if any)
    p = p->next;
  }

  // Finally output final word
  *outbuf = out_word;


  print("outbuf:\n");
  outbuf = TX_BUF_PTR(ifstate.ptr);
  for(i=0; i<total_size32; i++) {
    if((i & 3) == 0) xil_printf("%04x:", (i<<2));
    xil_printf(" %08x", ((uint32_t *)outbuf)[i]);
    if((i & 3) == 3) print("\n");
  }
  if((i & 3) != 0) print("\n");
  print("\n");

  // Set TX buffer level to number of 8 byte words to send packet (rounding
  // up).
  *TX_BUF_SIZE_PTR(ifstate.ptr) = ((total_size32+1) >> 1);

  xil_printf("sent pkt %u longwords [tick %u]\n",
      ((total_size32+1) >> 1), tick_tmrctr());


//#endif

  return ERR_OK;
}

static
err_t
casper_netif_init(struct netif *netif)
{
  int i;

  netif->linkoutput = casper_netif_output;
  netif->output     = etharp_output;
  netif->mtu        = ETHERNET_MTU;
  netif->flags      = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_ETHERNET;
  netif->hwaddr_len = ETH_HWADDR_LEN;

  // TODO Get MAC address from somewhere (e.g. serial number stored in flash)
  for(i=0; i<ETH_HWADDR_LEN; i++) {
    netif->hwaddr[i] = 0x02 + i;
  }

  return ERR_OK;
}

#define get_link_state() \
  (((uint32_t *)ifstate.ptr)[ETH_MAC_REG32_XAUI_STATUS] & 1)

err_t
casper_lwip_init()
{
  lwip_init();

  // Init ifstate
  ifstate.ptr = (void *)ETH0_BASE_ADDRESS;
  ifstate.last_link_state = -1;

  netif_add(&netif,
      IP4_ADDR_ANY, IP4_ADDR_ANY, IP4_ADDR_ANY,
      &ifstate, casper_netif_init, netif_input);

  netif.name[0] = 'e';
  netif.name[1] = '0';

  //TODO? netif.ip6_autoconfig_enabled = 1;
  //TODO? netif_set_status_callback(&netif, netif_status_callback);
  netif_set_default(&netif);
  netif_set_up(&netif);
  
  // Start DHCP
  dhcp_start(&netif);

  return ERR_OK;
}

void
casper_lwip_handler()
{
  uint32_t link_state = get_link_state();

  if(ifstate.last_link_state != link_state) {
    ifstate.last_link_state = link_state;
    xil_printf("link is %s\n", link_state ? "UP" : "DOWN");
    if(link_state) {
      netif_set_link_up(&netif);
    } else {
      netif_set_link_down(&netif);
    }
  }

  // TODO Check for received frames, feed them to lwIP

  // Cyclic lwIP timers check
  sys_check_timeouts();
}
