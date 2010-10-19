/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* Main file */

#include "xparameters.h"
#include "xbasic_types.h"
#include "xcache_l.h"
#include "tinysh.h"
#include <stdio.h>
#include <stdlib.h>

#include "core_info.h"
#define MAX_PACKET_SIZE 1000

/*****************************************************************
 * Data macros
 *****************************************************************/

#define SELECTMAP_FIFO_NUM_WORDS 128

static inline Xuint32 GET_STATUS()
{
  return XIo_In32(XPAR_OPB_SELECTMAP_FIFO_0_BASEADDR);
}
static inline Xuint8  SELECTMAP_STATUS(Xuint32 word)
{
  return (Xuint8)((word >> 24) & 0xff);
}

#define SELECTMAP_RFIFO_CNT(word) (Xuint8)((word >> 16) & 0xff)
#define SELECTMAP_WFIFO_CNT(word) (Xuint8)((word >> 8)  & 0xff)

/* Prototypes */
/* ********************************* */
void add_cmds();
void outbyte(unsigned char c);
int  inbyte();
void intr_selectmap(void);
void send_writeack(unsigned location, int val);
void send_selectmap_byte(unsigned char c);
unsigned char receive_selectmap_byte();
unsigned int receive_selectmap_int3();
void send_selectmap_int3(unsigned int data);
unsigned int receive_selectmap_int4();
void send_selectmap_int4(unsigned int data);
/* <prototypes> */

/* Commands */
/* ********************************* */
/* <commands_defs> */

/* Globals */
/* ********************************* */
unsigned char last_byte_written;

/* Main thread */
/* ********************************* */

int main(void)
{
  int i;

/* activate the cache on the PPC */
  XCache_EnableICache(0x00000001);
  XCache_EnableDCache(0x00000001);

/* wait for greet */
  i = 0;
  do {
    i <<= 8;
    i |= receive_selectmap_byte();
  } while (i != 0x10FFAA55);

/* display welcome message */
  xil_printf("\n\r");
  xil_printf("****************************\n\r");
  xil_printf("* TinySH lightweight shell *\n\r");
  xil_printf("****************************\n\r");
/* <hello> */
  xil_printf("\n\r");
  xil_printf("DON'T PANIC ;-)\n\r");
  xil_printf("\n\r");
  xil_printf("Type 'help' for help\n\r");
  xil_printf("Type '?' for a list of available commands\n\r");
  xil_printf("\n\r");

/* add all the commands */
/* <commands_adds> */

/* add user initilization calls */
/* <inits> */

/* change the prompt */
  tinysh_set_prompt("BEE2 % ");

/* loop waiting for chars */
  while(1) {
    tinysh_char_in(inbyte());
  }

}

/* Tinysh support */
/* ********************************* */

/* we must provide these functions to use tinysh
 */
void tinysh_char_out(unsigned char c)
{
  outbyte(c);
}

void outbyte(unsigned char c)
{

  /* memorizes the last byte sent */
  last_byte_written = c;

  /* send a "write at location 1" packet to the control FPGA */
  /* Write command */
  send_selectmap_byte(3);
  /* location = 1 */
  send_selectmap_int3(1);
  /* offset = 0 */
  send_selectmap_int4(0);
  /* size = 1 */
  send_selectmap_int4(1);
  /* payload is the character */
  send_selectmap_byte(c);
  /* interrupt */
  intr_selectmap();
}


int inbyte()
{
  unsigned char cmd;
  unsigned int location,size,offset,block_size,transfer_size;
  int i;
  Xuint32 data;
  core current_core;

  /* buffer initialization*/
  unsigned int MAX_WORDS = (MAX_PACKET_SIZE-10)/4;
  unsigned int rd_buffer[MAX_WORDS];

  int buff_loc = 0;

  /* send a "read at location 0" packet to the control FPGA */
  /* Read command */
  send_selectmap_byte(1);
  /* location = 0 */
  send_selectmap_int3(0);
  /* offset = 0 */
  send_selectmap_int4(0);
  /* size = 1 */
  send_selectmap_int4(1);
  /* wait for packets from the control FPGA */
  /* HS: but we need to interrupt control FPGA to get this request */
  intr_selectmap();
  while(1) {
    cmd = receive_selectmap_byte();
    switch(cmd) {
      case 1 : /* read */
        /* get the location */
        location = receive_selectmap_int3();
        /* get the offset */
        offset = receive_selectmap_int4();
        /* get the size */
        size = receive_selectmap_int4();
        /* if location is 0, then output the location table */
        if(location == 0) {
            /* -- future implementation of location table output here -- */
        } else {
          /* check if location is greater than max loc */
          if(location >= NUM_CORES) {
              /* -- future implementation of error handling here -- */
              /* -- error wrong location -- */
          } else {
            current_core = cores[location];
            switch(current_core.type) {
              case xps_dram :
                XIo_Out32(current_core.address, 1);
              case xps_sw_reg :
              case xps_bram :
                if(current_core.type == xps_sw_reg)
                  block_size = 4;
                if(current_core.type == xps_bram)
                  block_size = 4 * tinysh_atoxi(current_core.params);
                if(current_core.type == xps_dram)
                  block_size = 0x40000000;
                if(offset+size>block_size) {
                  size = block_size - offset;
                }
                if(offset>=block_size) {
                    /* -- future implementation of error handling here -- */
                    /* -- wrong seek -- */
                }
                if(current_core.type != xps_dram)
                  offset += current_core.address;
                data = XIo_In32(offset & 0xFFFFFFFC);
                while(size != 0) {
                  if(size > MAX_PACKET_SIZE-10)
                    transfer_size = MAX_PACKET_SIZE-10;
                  else
                    transfer_size = size;
                  size -= transfer_size;

                  /* Send read ack command */
                  send_selectmap_byte(2);
                  /* location */
                  send_selectmap_int3(location);
                  /* size */
                  send_selectmap_int4(transfer_size);
                  /* payload */
                  for(;transfer_size != 0;transfer_size--) {
                    send_selectmap_byte(((unsigned char *) &data)[offset % 4]);
                    offset++;
                    if(offset % 4 == 0)
                      data = XIo_In32(offset);
                  }
                  intr_selectmap();
                }
                if(current_core.type == xps_dram)
                  XIo_Out32(current_core.address, 0);
                break;
              case xps_fifo :
				if(size > MAX_WORDS*4)
                    size = MAX_WORDS*4;
                if(offset!=0) {
                    /* -- future implementation of error handling here -- */
                    /* -- wrong offset -- */
                }
				/* fill read buffer */
                buff_loc = 0;
                while((buff_loc < size/4) & !(XIo_In32(current_core.address + 4) & 1)) {
                    rd_buffer[buff_loc] = XIo_In32(current_core.address);
                    buff_loc++;
                }

                transfer_size = 4*buff_loc;
                /* Send read ack command */
                send_selectmap_byte(2);
                /* location */
                send_selectmap_int3(location);
                /* size */
                send_selectmap_int4(transfer_size);
                /* payload */
                while (buff_loc != 0){
                  send_selectmap_int4(rd_buffer[(transfer_size/4) - buff_loc]);
                  buff_loc--;
                }
                intr_selectmap();
                break;
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//              case xps_tengbe :
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                /* Send read ack command */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                send_selectmap_byte(2);
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                /* location */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                send_selectmap_int3(location);
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                /* get a char from the configuration */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                data = tengb_getconf(cores[location].address);
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                if(data == -1) {
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                  /* size */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                  send_selectmap_int4(0);
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                } else {
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                  /* size */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                  send_selectmap_int4(1);
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                  /* payload */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                  send_selectmap_byte((char) data);
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                }
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                intr_selectmap();
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                break;
              default :
                  /* -- future implementation of error handling here -- */
                  /* -- error unsupported location -- */
                break;
            }
          }
        }
        break;
      case 2 : /* read ack */
        /* get the location. It should be 0 only as we don't read from anything else*/
        location = receive_selectmap_int3();
        if(location != 0) xil_printf("Error: Wrong location\n\r");
        /* get the size in bytes. If it is one, it means that one of our read succedded, and we return the payload */
        size = receive_selectmap_int4();
        if(size == 1) return receive_selectmap_byte();
        /* if we received an error code, we send a new request */
        /* HS should wait a bit before stalling cntrl fpga */
        usleep(100000);
        /* send a "read at location 0" packet to the control FPGA */
        /* Read command */
        send_selectmap_byte(1);
        /* location = 0 */
        send_selectmap_int3(0);
        /* offset = 0 */
        send_selectmap_int4(0);
        /* size = 1 */
        send_selectmap_int4(1);
        /* interrupt */
        intr_selectmap();
        break;
      case 3 : /* write */
        /* get the location */
        location = receive_selectmap_int3();
        /* get the offset */
        offset = receive_selectmap_int4();
        /* get the size */
        size = receive_selectmap_int4();
        /* if location is 0, then this is an error */
        if(location == 0) {
            send_writeack(location, -2);
            /* -- future implementation of error handling here -- */
            /* -- error unwritable -- */
        } else {
          /* check if location is greater than max loc */
          if(location >= NUM_CORES) {
              /* -- future implementation of error handling here -- */
              /* -- error wrong location -- */
              send_writeack(location, -3);
          } else {
            current_core = cores[location];
            switch(current_core.type) {
              case xps_dram :
                XIo_Out32(current_core.address, 1);
              case xps_sw_reg :
              case xps_bram :
                if(current_core.type == xps_sw_reg)
                  block_size = 4;
                if(current_core.type == xps_bram)
                  block_size = 4 * tinysh_atoxi(current_core.params);
                if(current_core.type == xps_dram)
                  block_size = 0x40000000;
                if(offset+size>block_size) {
                  size = block_size - offset;
                }
                if(offset>=block_size) {
                    /* -- future implementation of error handling here -- */
                    /* -- wrong seek -- */
                }
                if(current_core.type != xps_dram)
                  offset += current_core.address;
                /* prefetch data for the first read modify write operation */
                data = XIo_In32(offset & 0xFFFFFFFC);
                /* payload processing */
                for(transfer_size = 0;transfer_size < size;transfer_size++) {
                  ((unsigned char *) &data)[offset % 4] = receive_selectmap_byte();
                  offset++;
                  if(offset % 4 == 0) {
                    XIo_Out32(offset-4,data);
                    /* save some cycles */
                    if (size - transfer_size <= 4) {
                        data = XIo_In32(offset & 0xFFFFFFFC);
                    }
                  }
                }
                if (offset % 4 != 0) {
                    XIo_Out32(offset & 0xFFFFFFFC, data);
                }
                /* Send write ack command */
                send_selectmap_byte(4);
                /* location */
                send_selectmap_int3(location);
                /* size */
                send_selectmap_int4(size);
                /* interrupt */
                intr_selectmap();
                if(current_core.type == xps_dram)
                  XIo_Out32(current_core.address, 0);
                break;
              case xps_fifo :
                if(offset!=0) {
                    /* -- future implementation of error handling here -- */
                    /* -- wrong offset -- */
                }
                /* payload processing */
				transfer_size = 0;
				while ((size-transfer_size >=4) & !(XIo_In32(current_core.address + 4) & 1)) {
					XIo_Out32(current_core.address + 0, receive_selectmap_int4());
					transfer_size +=4;
				}
                /* Send write ack command */
                send_selectmap_byte(4);
                /* location */
                send_selectmap_int3(location);
                /* size */
                send_selectmap_int4(transfer_size);
                /* interrupt */
                intr_selectmap();
                break;
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//              case xps_tengbe :
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                /* process the payload */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                tengb_setconf(cores[location].address, receive_selectmap_byte());
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                /* Send write ack command */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                send_selectmap_byte(4);
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                /* location */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                send_selectmap_int3(location);
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                /* size */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                send_selectmap_int4(1);
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                /* interrupt */
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                intr_selectmap();
//IF// ~isempty(find(strcmp('xps_tengbe', core_types)))//                break;
              default :
                  /* -- future implementation of error handling here -- */
                  /* -- error unsupported location -- */
                break;
            }
          }
        }
        break;
      case 4 : /* write ack */
        /* get the location */
        location = receive_selectmap_int3();
        /* get the size */
        size = receive_selectmap_int4();
        /* check the size */
        if(size==0) {
          /* last write failed, send it again */
          /* send a "write at location 1" packet to the control FPGA */
          /* Write command */
          send_selectmap_byte(3);
          /* location = 1 */
          send_selectmap_int3(1);
          /* offset = 0 */
          send_selectmap_int4(0);
          /* size = 1 */
          send_selectmap_int4(1);
          /* payload is the character */
          send_selectmap_byte(last_byte_written);
          /* interrupt */
          intr_selectmap();

        }
        break;
      case 17: /* bye */
          /* remove magic from the fifo */
          receive_selectmap_byte();
          receive_selectmap_byte();
          receive_selectmap_byte();
          data = 0x30000000;
          asm("mtdbcr0 %0" :: "r"(data));
        break;
      default : /* unknown packet type */
          /* -- future implementation of error handling here -- */
          /* -- error unknown packet -- */
        break;
    }
  }
}

void send_writeack(unsigned location, int val)
{
    /* Send write ack command */
    send_selectmap_byte(4);
    /* location */
    send_selectmap_int3(location);
    /* size */
    send_selectmap_int4(val);
    /* interrupt */
    intr_selectmap();
}

void intr_selectmap(void)
{
    XIo_Out32(XPAR_OPB_SELECTMAP_FIFO_0_BASEADDR, 1);
}

void send_selectmap_byte(unsigned char c)
{
  int retry = 0;

  /* block on fifo full */
  while (!SELECTMAP_WFIFO_CNT(GET_STATUS())) {
    if (!(retry & 0xFFFF)) {
      intr_selectmap();
    }
    retry += 1;
  }
  /* send the byte */
  XIo_Out8(XPAR_OPB_SELECTMAP_FIFO_0_BASEADDR+4, c);
}

unsigned char receive_selectmap_byte()
{
  /* block on fifo empty */
  while (!SELECTMAP_RFIFO_CNT(GET_STATUS())) {
/* <repeats> */
  }
  /* read the byte */
  return XIo_In8(XPAR_OPB_SELECTMAP_FIFO_0_BASEADDR+4);
}

unsigned int receive_selectmap_int3()
{
  unsigned int data = 0;

  data = receive_selectmap_byte();
  data <<= 8;
  data |= receive_selectmap_byte();
  data <<= 8;
  data |= receive_selectmap_byte();

  return data;
}

void send_selectmap_int3(unsigned int data)
{
  send_selectmap_byte(data >> 16);
  send_selectmap_byte(data >>  8);
  send_selectmap_byte(data >>  0);
}

unsigned int receive_selectmap_int4()
{
  unsigned int data = 0;

  data = receive_selectmap_byte();
  data <<= 8;
  data |= receive_selectmap_byte();
  data <<= 8;
  data |= receive_selectmap_byte();
  data <<= 8;
  data |= receive_selectmap_byte();

  return data;
}

void send_selectmap_int4(unsigned int data)
{
  send_selectmap_byte(data >> 24);
  send_selectmap_byte(data >> 16);
  send_selectmap_byte(data >>  8);
  send_selectmap_byte(data >>  0);
}
