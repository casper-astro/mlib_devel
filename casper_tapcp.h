// casper_tapcp.h - Macro definitions and declarations for CASPER TAPCP
//                  implementation.

#ifndef _CASPER_TAPCP_H_
#define _CASPER_TAPCP_H_

#include "lwip/pbuf.h"

// Constants to represent the type of command being processed.  Note that `dev`
// and `gw` and `mb` commands are all just memory access commands.
#define CASPER_TAPCP_CMD_NONE    (0)
#define CASPER_TAPCP_CMD_HELP    (1)
#define CASPER_TAPCP_CMD_LISTDEV (2)
#define CASPER_TAPCP_CMD_TEMP    (3)
#define CASPER_TAPCP_CMD_MEM     (4)
#if 0 // TODO
#define CASPER_TAPCP_CMD_PROGDEV (5)
#define CASPER_TAPCP_CMD_FLASH   (6)
#endif

struct tapcp_state {
  uint8_t binary; // Flag indicating octect/binary mode
  uint8_t write;  // Flag indicating a write operation
  uint8_t cmd;    // Command type being processed
  void *ptr;      // Pointer to next location being accessed
  size_t nleft;   // Number of values still to access (cmd specific interp)
};

// Open functions
void * casper_tapcp_open_help(struct tapcp_state *state);
void * casper_tapcp_open_temp(struct tapcp_state *state);

#endif // _CASPER_TAPCP_H_
