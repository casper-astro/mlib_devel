//#define VERBOSE
//#define PRETTY

#include "lwip/debug.h"
#include "lwip/stats.h"
#include "lwip/tcp.h"
#include "xparameters.h"
#include "lwiputil.h"
#include "xuartlite_l.h"
#include "xtime_l.h"
#include "xcache_l.h"
#include "tinysh.h"
#include "core_info.h"
#include "lwip/udp.h"

#include "fifo.h"

// Defined in main.c
void display_welcome_msg(void);
void process_inputs(int feed_tinysh);

/* IBOB Configuration Variables */

// Defined in lwipinit.c
extern char fullmac[6];
extern char ip[4];
extern char subnet[4];
extern char gateway[4];
extern fifo_p input_fifo;
extern fifo_p output_fifo;

struct conn_state {
  struct tcp_pcb * tpcb;
  u8_t failed;
  u8_t netclient;
  // For the future?
  //Xuint32 CoreNum;
  //Xuint32 OutputMode;
  //Xuint32 PostState;
  //char byte[4];
};
#define FAILED_MAX 8

/* printmode switch, default = serial, 1 for tcp */
/* Defined in main.c */
extern Xuint8 printmode;
extern Xuint8 immediatemode;

// pcb for server socket
struct tcp_pcb *telnetd_pcb = NULL;
// conn_state for the current (one and only) telnet connection
// If timysh ever supports mutiple sessions we might want to
// support more than one simultaneous telnet connection.
struct conn_state *telnetstate = NULL;

// Somewhat inefficient intermedite buffer for double copy on send
// (one copy from fifo into this buffer, another copy in tcp_write
// from this buffer to lwip).
#define STAGING_BUF_SIZE 8000
char staging_buf[STAGING_BUF_SIZE];

// HTTP Stuff is all ifdef'd out for now
// TODO Keep or not?
#ifdef HTTP_ENABLE

struct parsed_get {
  char url[256];
  char variable[256];
  char value[256];
};

/* Define HTTP Connection Types */
#define INIT_CONNECT -1
#define NOT_FOUND_PAGE 1
#define INDEX_PAGE 2
#define BRAM_PAGE 3
#define REG_PAGE 4
#define NOT_FOUND 7
#define MAIN_PAGE 8
#define NUMBER_PAGE 9
#define POST_REQUEST 10

struct tcp_pcb *httppcb;
struct conn_state *httpstate;
struct parsed_get *parsed;

#endif // HTTP_ENABLE

// Prints to UART regardless of printmode setting
#if 0
#define uart_printf(...)
#else
#define uart_printf(...) do \
{ \
  Xuint8 saved_printmode = printmode; \
  printmode = 0; \
  xil_printf(__VA_ARGS__); \
  printmode = saved_printmode; \
} while(0)
#endif

#ifdef LWIP_DEBUG
void dump_fifo(fifo_p f)
{
  Xuint8 saved_printmode = printmode;
  printmode=0;
  xil_printf("depth=%d, head=%d, tail=%d, avail=%d, occupied=%d, full=%d, empty=%d\n\r",
      fifo_depth(f),
      f->head, f->tail,
      fifo_avail(f),
      fifo_occupied(f),
      is_fifo_full(f),
      is_fifo_empty(f));
  printmode = saved_printmode;
}
#endif

/*
   sends all bytes in output fifo
*/

/*---------------------------------------------------------------------------*/
  void
send_buf()
{
  int maxSendable;
  int fifoCount;
  int amountToSend;
  int amountFromFifo;
  struct tcp_pcb *pcb;
  unsigned int counter=0;

  if(!telnetstate) {
    //uart_printf("%s: telnetstate is NULL!\n\r", __FUNCTION__);
    return;
  }

  pcb = telnetstate->tpcb;

  // Until fifo is empty
  while(!is_fifo_empty(output_fifo)) {

    // Until maxSendable is greater than 0,
    // process inputs (but do not feed tinysh).
    counter=0;
    while((maxSendable=tcp_sndbuf(pcb)) == 0) {
      // Timeout
      if(counter++ > 100000) {
        uart_printf("maxSendable looped too long (%d times).\r\n",counter);
        // Truncate fifo
        fifo_reset(output_fifo);
        return;
      }
      process_inputs(0);
    }
    if(maxSendable > STAGING_BUF_SIZE) {
      maxSendable = STAGING_BUF_SIZE;
    }
    fifoCount = fifo_occupied(output_fifo);
    if(fifoCount > maxSendable) {
      amountToSend = maxSendable;
    } else {
      amountToSend = fifoCount;
    }
    amountFromFifo = fifo_get(output_fifo,staging_buf,amountToSend);
    if(amountFromFifo != amountToSend) {
      // Should "never" happen
      uart_printf("%s: Expected %d from fifo, but got %d\n\r", __FUNCTION__, amountToSend, amountFromFifo);
    }

    // Until tcp_write succeeds, process inputs (but do not feed tinysh)
    counter=0;
    while(tcp_write(pcb, staging_buf, amountToSend, 1) == ERR_MEM) {
      // Timeout
      if(counter++ > 100000) {
        uart_printf("tcp_write looped too long (%d times).\r\n",counter);
        // Truncate fifo
        fifo_reset(output_fifo);
        return;
      }
      process_inputs(0);
    }
    tcp_output(pcb);
  }
}

  void
bufferbyte(unsigned char c)
{
  while(telnetstate && !fifo_put(output_fifo,&c,1)) {
    // TODO Timeout!
    send_buf();
  }
  if(!telnetstate) {
    //uart_printf("bufferbyte: telnetstate is NULL\n\r");
  } else if(immediatemode) {
    send_buf();
  }
}


/*---------------------------------------------------------------------------*/
  struct conn_state *
state_new(struct tcp_pcb *tpcb)
{
  struct conn_state * ws = mem_malloc(sizeof(struct conn_state));

  if(ws) {
    /* Initialize the structure. */
    ws->tpcb = tpcb;
    ws->failed = 0;
    ws->netclient = NETCLIENT_OTHER;
  }

  return ws;
}


/*---------------------------------------------------------------------------*/
  void
telnet_err(void *arg, err_t err)
{
  struct conn_state *ws = arg;

  uart_printf("tcp_err: %d\n\r", err);
  // TODO Is it OK to free?
  //if(arg != NULL) {
  //  mem_free(arg);
  //}
}

/*---------------------------------------------------------------------------*/
  void
close_conn(struct conn_state *ws)
{
  if(ws) {
    struct tcp_pcb * tpcb = ws->tpcb;
    if(tpcb) {
      //tcp_sent(tpcb, NULL);
      //tcp_recv(tpcb, NULL);
      //tcp_poll(tpcb, NULL, 1);
      //tcp_arg(tpcb, NULL);
      tcp_close(tpcb);
      //uart_printf("Connection closed\n\r");
    }
    if(ws == telnetstate) {
      mem_free(telnetstate);
      tinysh_set_prompt("IBOB % ");
      telnetstate=NULL;
      fifo_reset(input_fifo);
      fifo_reset(output_fifo);
    }
  }
}

/*---------------------------------------------------------------------------*/
  err_t
telnet_poll(void *arg, struct tcp_pcb *pcb)
{
  struct conn_state *ws = arg;

  // If unknown pcb?
  if(ws == NULL) {
    return tcp_close(pcb);
  }
  // If not current telnet state
  if(ws != telnetstate) {
    close_conn(ws);
  }

  if(telnetstate->failed >= FAILED_MAX) {
    uart_printf("%s: Failed!\n\r", __FUNCTION__);
    close_conn(telnetstate);
    tcp_abort(pcb); // TODO Is this too late?
    return ERR_ABRT;
  }

  return ERR_OK;
}

#if 0
/*---------------------------------------------------------------------------*/
  err_t
telnet_sent(void *arg, struct tcp_pcb *pcb, u16_t len)
{
  struct conn_state *ws = arg;

  // If unknown pcb?
  if(ws == NULL) {
    uart_printf("%s: Null arg!\n\r", __FUNCTION__);
    return tcp_close(pcb);
  }
  // If not current telnet state
  if(ws != telnetstate) {
    uart_printf("%s: Old arg!\n\r", __FUNCTION__);
    close_conn(ws);
    return ERR_OK;
  }

  // Maybe send more bytes
  send_buf();

  return ERR_OK;
}
#endif

/*---------------------------------------------------------------------------*/
// Puts received bytes into input fifo
  err_t
telnet_recv(void *arg, struct tcp_pcb *pcb, struct pbuf *p, err_t err)
{
  int recved;
  Xuint8 saved_printmode;
  char * crlf = "\r\n";

  struct conn_state *ws = arg;

  // If unknown pcb?
  if(ws == NULL) {
    return tcp_close(pcb);
  }
  // If not current telnet state
  if(ws != telnetstate) {
    close_conn(ws);
    return ERR_OK;
  }

  if(p == NULL) {
    //if(ws->tpcb != pcb) {
    //  uart_printf("Weirdo-");
    //}
    //uart_printf("Connection closed by foreign host.\n\r");
    close_conn(telnetstate);
  } else {
    // Determine client type
    if(ws->netclient==NETCLIENT_UNKNOWN) {
      if( (*(char *)(p->payload)) != 255) {
        ws->netclient=NETCLIENT_OTHER;
        tinysh_set_prompt("");
      } else {
        ws->netclient=NETCLIENT_TELNET;
        /* Set remote client to character-by-character mode */	
        immediatemode = 0;
        bufferbyte(255);    //IAC
        bufferbyte(251);    //WILL  
        bufferbyte(1);      //ECHO
        bufferbyte(255);    //IAC
        bufferbyte(251);    //WILL
        immediatemode = 1;
        bufferbyte(3);      //SUPPRESS GO AHEAD
        immediatemode = 0;

        /* Set up for TCP Output */
        saved_printmode = printmode;
        printmode = 1;
        /* Display Welcome Message */
        display_welcome_msg();
        /* Reset back to saved printmode */
        printmode = saved_printmode;

        // Stuff carriage return and line feed into input fifo
        fifo_put(input_fifo,crlf,2); /* Get a TinySH Prompt */
      }
    }
    // Receive bytes into fifo
    recved = fifo_put(input_fifo,p->payload,p->len);
    tcp_recved(pcb, recved);
    pbuf_free(p); // TODO Is this needed?  Is it bad?
  }

  return ERR_OK;
}

/*---------------------------------------------------------------------------*/
  err_t
telnet_accept(void *arg, struct tcp_pcb *pcb, err_t err)
{
  // Allocate and init structure to hold the state of the new connection
  struct conn_state *new_telnetstate = state_new(pcb);
  if(new_telnetstate == NULL) {
    uart_printf("could not malloc memory for conn_state\n\r");
    return ERR_MEM;
  }

  // Close any existing connection before accepting this new one
  close_conn(telnetstate);
  telnetstate = new_telnetstate;

  // TODO Why would we want to do this?
  //tcp_setprio(pcb, TCP_PRIO_MIN);

  // Setup TCP callbacks and callback arg data
  // Set callback arg data first!
  tcp_arg(pcb, telnetstate);
  tcp_recv(pcb, telnet_recv);
  tcp_err(pcb, telnet_err);
  tcp_poll(pcb, telnet_poll, 100);
  //tcp_sent(pcb, telnet_sent);

  //uart_printf("Network Connection Established\n\r");

  return ERR_OK;
}

/*---------------------------------------------------------------------------*/
  void
telnet_init(void)
{
  telnetd_pcb = tcp_new();
  tcp_bind(telnetd_pcb, IP_ADDR_ANY, TELNET_PORT);
  telnetd_pcb = tcp_listen(telnetd_pcb);
  tcp_accept(telnetd_pcb, telnet_accept);
}


#ifdef HTTP_ENABLE
/*---------------------------------------------------------------------------*/
  err_t
http_poll(void *arg, struct tcp_pcb *pcb)
{
  struct conn_state *ws = arg;
#ifdef VERBOSE
  xil_printf("Entering http_poll.\n");
#endif
  if(ws == NULL) {
#ifdef VERBOSE
    xil_printf("http_poll: ws == NULL, closing TCP/HTTP connection\r\n");
#endif
    close_conn(pcb, ws);
  }

  if(ws->failed >= FAILED_MAX) {
#ifdef VERBOSE
    xil_printf("http_poll: Tried %d times, closing and aborting tcp connection.\r\n", ws->failed);
#endif
    close_conn(pcb, ws);
    tcp_abort(pcb);
    return ERR_ABRT;
  }

#ifdef VERBOSE
  xil_printf("Exiting http_poll.\n");
#endif
  return ERR_OK;
}


/*---------------------------------------------------------------------------*/
  void
parse(char *chunk)
{
  int aoffset=4, boffset=4, coffset=4;

#ifdef VERBOSE
  xil_printf("Beginning parse...\r\n");
#endif

  while(*(chunk + coffset) != ' ') {
    coffset++;	
  }

#ifdef VERBOSE
  xil_printf("Got coffset: %d \r\n", coffset);
#endif


  while(*(chunk + aoffset) != '?') {
    aoffset++;	
    if (aoffset > coffset) break;
  }
#ifdef VERBOSE
  xil_printf("Got aoffset: %d \r\n", aoffset);
#endif 	

  while(*(chunk + boffset) != '=') {
    boffset++;
    if (boffset > coffset) break;
  }
#ifdef VERBOSE
  xil_printf("Got boffset: %d \r\n", boffset);
#endif 	
  if (boffset > coffset) {

    memcpy((*parsed).url, chunk + 5, coffset - 4);
    parsed->url[coffset-5] = 0;
    parsed->variable[0] = 0;
    parsed->value[0] = 0;		

  } else {

    memcpy((*parsed).url, chunk + 5, aoffset - 5);
    memcpy((*parsed).variable, chunk + aoffset + 1, boffset - aoffset -1);
    memcpy((*parsed).value, chunk + boffset + 1, coffset - boffset - 1);

    parsed->url[aoffset-5] = 0;
    parsed->variable[boffset-aoffset-1] = 0;
    parsed->value[coffset-boffset-1] = 0;		
  }
}
#endif // HTTP_ENABLE
