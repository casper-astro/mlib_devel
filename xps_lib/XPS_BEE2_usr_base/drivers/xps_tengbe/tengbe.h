/* ********************************* */
/* *                               * */
/* *         BEE2 Drivers          * */
/* *                               * */
/* ********************************* */

/* 2006 Pierre-Yves droz */

/* TENGBE access functions */

#ifndef TENGBE_H
#define TENGBE_H 

/* Xilinx hardware drivers includes */
/* ********************************* */
#include "xbasic_types.h"
#include "xtime_l.h"
#include "xparameters.h"
#include "../core_info.h"
#include <stdio.h>
#include <stdlib.h>

/* Constants */
/* ********************************* */
#define MAC_OFFSET        0x07
#define IP_OFFSET         0x0F
#define GATEWAY_OFFSET    0x0B
#define PORT_OFFSET       0x16
#define VALID_OFFSET      0x15
#define RX_SIZE_OFFSET    0x13
#define TX_SIZE_OFFSET    0x11

#define TX_BUFFER_OFFSET  0x1000
#define RX_BUFFER_OFFSET  0x2000
#define ARP_CACHE_OFFSET  0x3000

#define ARP_RATE          256

/*
Ten Gb ethernet register map :
                63                                                             0
 0x00 -> 0x07 : 0000000000000000MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
                                |<------------ local MAC address ------------->|

                63                                                             0
 0x08 -> 0x0F : 000000000000000000000000GGGGGGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
                |<---- gateway IP address ---->||<----- local IP address ----->|

                63                                                             0
 0x10 -> 0x17 : 00000000TTTTTTTT00000000RRRRRRRR000000000000000VPPPPPPPPPPPPPPPP
                |<- tx size  ->||<- rx size  ->|  local_valid->||<- UDP port ->|
*/

/* Prototypes */
/* ********************************* */
void tengbinfo_cmd(int argc, char **argv);

#endif
