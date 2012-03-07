/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* BRAM access functions */

#ifndef BRAM_H
#define BRAM_H 

/* Xilinx hardware drivers includes */
/* ********************************* */
#include "xbasic_types.h"
#include "../core_info.h"
#include <stdio.h>
#include <stdlib.h>

/* Prototypes */
/* ********************************* */
inline Xuint32 sif_bram_read                 (Xuint32 bram_address, unsigned int offset);
inline void    sif_bram_write                (Xuint32 bram_address, unsigned int offset, Xuint32 fifo_data);
void bramread_cmd(int argc, char **argv);
void bramwrite_cmd(int argc, char **argv);
void bramdump_cmd(int argc, char **argv);

#endif
