/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2005 Henry Chen, UCB SETI Group */

/* HWScope access functions */

#ifndef HWSCOPE_H
#define HWSCOPE_H

/* Xilinx hardware drivers includes */
/* ********************************* */
#include "xbasic_types.h"
#include "../core_info.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Prototypes */
/* ********************************* */
//inline void sif_reg_write(Xuint32 reg_address, Xuint32 reg_data);
//inline Xuint32 sif_reg_read(Xuint32 reg_address);
//inline Xuint32 sif_fifo_read_nonblock(Xuint32 fifo_address, int* fail);
void scopestatus_cmd (int argc, char **argv);
void setscopedelay_cmd (int argc, char **argv);
void scopereset_cmd (int argc, char **argv);
void scopeenable_cmd (int argc, char **argv);
void scoperead_cmd(int argc, char **argv);
void multiprint(Xuint32 value, int j, int fail);

#endif
