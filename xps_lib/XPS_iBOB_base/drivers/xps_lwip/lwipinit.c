/* Xilinx Includes */
#include "xtime_l.h"
#include "xparameters.h"
#include "xcache_l.h"

/* UART Support */
#include "xuartlite_l.h" 

/* LWIP Includes */
#include "netif/xemacliteif.h"
#include "lwip/tcp.h"
#include "lwip/memp.h"
#include "netif/etharp.h"
#include "lwip/udp.h"
#include "tinysh.h"
/* From tinysh.c, for strstart return value */
enum { NULLMATCH,FULLMATCH,PARTMATCH,UNMATCH,MATCH,AMBIG };

/* Our Includes */
#include "fifo.h"
#include "lwiputil.h"
#include "../core_info.h"

/* Defined in main.c */
extern void display_welcome_msg(void);

// Global Variables
// Our one and only netif struct
struct netif default_netif;
// Our network fifos
// Depth will be 16K each
#define FIFO_DEPTH (1<<14)
fifo_p input_fifo;
fifo_p output_fifo;

// Static Global Variables
static u8_t lwip_timer = 0;

/* defined in lwip/src/core/tcp.c */
extern u32_t tcp_ticks; 
/* defined in EDK generated xemacif_g.c file */
extern XEmacLiteIf_Config XEmacLiteIf_ConfigTable[]; 

/* Low bits will be derived from jumpers */
char fullmac[6] = {0x00, 0x6d, 0x12, 0x1b, 0x0b, 0x00}; 
char zeroaddr[4] = {0, 0, 0, 0};

/*
   char ip[4] =       {0, 0, 0, 0};
   char subnet[4] =   {0, 0, 0, 0};
   char gateway[4] =  {0, 0, 0, 0};
 */


char ip[4] =      {169,254,0x1b,0x0b};
char subnet[4] =  {0,0,0,0};
char gateway[4] = {0,0,0,0};

char header[4] = {1, 1, 6, 0};
char bootpacket[300];

/*---------------------------------------------------------------------------*/
/* lwip_tmr - Called periodically to dispatch TCP and ARP timers             */
/*---------------------------------------------------------------------------*/
void lwip_tmr(void)
{
  ++lwip_timer;

  if(lwip_timer == 10) {
    lwip_timer = 0;
  }
  if(lwip_timer & 1) {
    /* Call tcp_fasttmr() every 2 ms, i.e.,
     * every other timer my_tmr() is called. */
    tcp_fasttmr();
  }
  if(lwip_timer == 0 || lwip_timer == 5) {
    /* Call tcp_slowtmr() every 5 ms, i.e.,
     * every fifth timer my_tmr() is called. */
    tcp_slowtmr();
    if (tcp_ticks%2000 == 0) {
      /* Call etharp_tmr() every 20th call to tcp_slowtmr().
       * tcp_ticks is a global var defined in core/tcp.c */
      etharp_tmr();
    }
  }
}


/* Provides an ifconfig command */
void ifconfig_cmd(int argc, char **argv)
/* command = "ifconfig"                                 */
/* help    = "Displays network interface configuration" */
/* params  = ""                                         */
{
  // display ibob status report without markup
  xil_printf("MAC Address: %02X-%02X-%02X-%02X-%02X-%02X\r\n",fullmac[0],fullmac[1],fullmac[2],fullmac[3],fullmac[4],fullmac[5]);
  xil_printf(" IP Address: %d.%d.%d.%d\r\n", ip[0], ip[1], ip[2], ip[3]);
  xil_printf("Subnet Mask: %d.%d.%d.%d\r\n", subnet[0], subnet[1], subnet[2], subnet[3]);
  xil_printf(" GW Address: %d.%d.%d.%d\r\n", gateway[0], gateway[1], gateway[2], gateway[3]);
  xil_printf("Telnet Port: %d \r\n", TELNET_PORT);
}


/*---------------------------------------------------------------------------*/
/* lwip initialization function                                              */
/*---------------------------------------------------------------------------*/
void lwipinit()
  /* init */
{
  struct ip_addr ipaddr, netmask, gw;
  int i = 0;
  int macbits = 0;

  unsigned int init_wait = 15000000;

#ifdef PRETTY
  xil_printf("LWIP starting Up...\r\n");
#endif

  /*-----------------------------------------------------------------------*/
  /* Read MAC bits from header                                             */
  /*-----------------------------------------------------------------------*/
  for(i=0;i<NUM_CORES;i++) {
    // Get pointer to core name
    char * p = cores[i].name;
    // Keep track of last '/'
    char * s = NULL;
    // Walk pointer through string looking for '/'
    while(*p) {
      if(*p == '/') {
        s = p;
      }
      p++;
    }
    if(s && strstart("/macbits",s)==FULLMATCH) {
      // Use low 14 bits from header.
      // Invert bits to make installed shunt mean 1.
      // Force bit 15 to 1 and bit 14 to 0.
      macbits = ((~XIo_In32(cores[i].address)) & 0x3fff) | 0x8000;
      break;
    }
  }

  if (i==NUM_CORES) {
    xil_printf("Unable to find MAC headers.  LWIP disabled.\r\n");
    return;
  }

  fullmac[4] = (macbits >> 8) & 0xff;
  fullmac[5] = (macbits     ) & 0xff;

  ip[2] = fullmac[4];
  ip[3] = fullmac[5];

  /*-----------------------------------------------------------------------*/
  /* Do LWIP System Inits                                                  */
  /*-----------------------------------------------------------------------*/
#ifdef STATS
  stats_init();
#endif /* STATS */
  xil_printf("Initializing LWIP Memory Structures.");
  sys_init();
  mem_init();
  xil_printf(".");
  memp_init();
  xil_printf(".");
  pbuf_init();
  input_fifo = fifo_alloc(FIFO_DEPTH);
  output_fifo = fifo_alloc(FIFO_DEPTH);
  xil_printf(" done.\r\n");
  if(!input_fifo || !output_fifo) {
    xil_printf("Unable to network FIFOs.  LWIP disabled.\r\n");
    return;
  }

  /*-----------------------------------------------------------------------*/
  /* Initial Header and Menus.  Do this before the netif_init() so we can  */
  /* change the MAC Address and IP addresses if needed                     */
  /*-----------------------------------------------------------------------*/
  while(init_wait--); // TODO Why spin here?

  /*-----------------------------------------------------------------------*/
  /* Set host addresses                                                    */
  /*-----------------------------------------------------------------------*/
  xemacliteif_setmac(0, (u8_t *) fullmac);                    //Set MAC
  IP4_ADDR(&gw, gateway[0],gateway[1],gateway[2],gateway[3]); //Set gateway
  IP4_ADDR(&ipaddr, ip[0],ip[1],ip[2],ip[3]);                 //Set ip
  IP4_ADDR(&netmask,subnet[0],subnet[1],subnet[2],subnet[3]); //Set subnet msk

  /*-----------------------------------------------------------------------*/
  /* Show some host boot stuff and parameters                              */
  /*-----------------------------------------------------------------------*/
  xil_printf("\r\nStarting Network Interface...\r\n");

  /*-----------------------------------------------------------------------*/
  /* Initialize netif                                                      */
  /*-----------------------------------------------------------------------*/

  xil_printf("Intializing netif...\n\r");
  netif_init();
  xil_printf("Done.\n\r");

  /*-----------------------------------------------------------------------*/
  /* Initialize TCP Stack                                                  */
  /*-----------------------------------------------------------------------*/

  xil_printf("Initializing TCP Stack...\n\r");
  tcp_init();
  xil_printf("Done.\n\r");

  xil_printf("Initializing UDP...\n\r");
  udp_init();
  xil_printf("Done.\n\r");

  /*-----------------------------------------------------------------------*/
  /* Set up the LWIP network interface...                                  */
  /*-----------------------------------------------------------------------*/

  xil_printf("Setting up LWIP interace...\n\r");
  netif_add(&default_netif,&ipaddr, 
      &netmask,
      &gw,
      &XEmacLiteIf_ConfigTable[0],
      xemacliteif_init,
      ip_input
      );

  xil_printf("Adding interface as default...\n\r"); 
  netif_set_default(&default_netif);

  /*-----------------------------------------------------------------------*/
  /* create new tcp pcb and start applications                             */
  /*-----------------------------------------------------------------------*/

  /* Find an IP */

  xil_printf("Attempting bootstrap....\r\n");

  /* Construct initial BOOTP request.... */

  /* OP : HTYPE : HLEN : HOPS */
  memcpy(&bootpacket, &header, 4);
  /* Transaction Identifier (4 bytes) should be random? */
  memcpy(&bootpacket + 4, &header, 4);
  /* Seconds Elapsed (2 bytes) : UNUSED (2 bytes)*/
  memcpy(&bootpacket + 8, &zeroaddr, 4);
  /* Client IP */
  memcpy(&bootpacket + 12, &zeroaddr, 4);
  /* Your IP Address */
  memcpy(&bootpacket + 16, &zeroaddr, 4);
  /* Server IP Address */
  memcpy(&bootpacket + 20, &zeroaddr, 4);
  /* Router IP Address */
  memcpy(&bootpacket + 24, &zeroaddr, 4);
  /* Client Hardware Address */
  memcpy(&bootpacket + 28, &fullmac, 6);
  /* Zero the remaining bytes */
  for(i = 34;i < 300;i += 1) bootpacket[i] = 0;

  // Start the telnet server
  telnet_init();
  xil_printf("Telnet Server Running.\r\n");
  xil_printf("LWIP initialization complete.\n\r");
  ifconfig_cmd(0,NULL);
}
