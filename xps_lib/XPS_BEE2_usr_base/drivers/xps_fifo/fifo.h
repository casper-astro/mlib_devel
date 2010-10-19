/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* FIFO access functions */

#ifndef FIFO_H
#define FIFO_H 

/* Xilinx hardware drivers includes */
/* ********************************* */
#include "xbasic_types.h"
#include "../core_info.h"
#include <stdio.h>
#include <stdlib.h>

/* Prototypes */
/* ********************************* */
inline Xuint32 sif_fifo_read                 (Xuint32 fifo_address);
inline Xuint32 sif_fifo_read_nonblock        (Xuint32 fifo_address, int* fail);
inline void    sif_fifo_write                (Xuint32 fifo_address, Xuint32 fifo_data);
inline void    sif_fifo_write_nonblock       (Xuint32 fifo_address, Xuint32 fifo_data, int* fail);
       void    sif_fifo_reset                (Xuint32 fifo_address);
void fifoput_cmd(int argc, char **argv);
void fifoget_cmd(int argc, char **argv);
void fiforeset_cmd(int argc, char **argv);

#endif
