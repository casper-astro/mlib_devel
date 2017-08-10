// casper_tapcp.h - Macro definitions and declarations for CASPER TAPCP
//                  implementation.

#ifndef _CASPER_TAPCP_H_
#define _CASPER_TAPCP_H_

#include "platform.h"
#include "lwip/pbuf.h"

// State structure for tapcp transfer
struct tapcp_state {
  uint8_t binary; // Flag indicating octect/binary mode
  uint8_t write;  // Flag indicating a write operation
  void *ptr;      // Pointer to next location being accessed
  int nleft;      // Number of values still to access (cmd specific interp)
  int16_t lidx;   // Index of next byte in line buffer (cmd specific interp)
  uint32_t u32;   // General purpose value (cmd specific interp)
};

// Open functions
void * casper_tapcp_open_help(struct tapcp_state *state);
void * casper_tapcp_open_listdev(struct tapcp_state *state);
void * casper_tapcp_open_temp(struct tapcp_state *state);
void * casper_tapcp_open_dev(struct tapcp_state *state, const char *fname);
void * casper_tapcp_open_mem(struct tapcp_state *state, const char *fname);
void * casper_tapcp_open_progdev(struct tapcp_state *state);
void * casper_tapcp_open_flash(struct tapcp_state *state, const char *fname);
void * casper_tapcp_open_flashcmd(struct tapcp_state *state, const char *fname);

#endif // _CASPER_TAPCP_H_
