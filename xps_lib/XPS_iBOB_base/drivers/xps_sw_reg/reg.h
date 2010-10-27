/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* register access functions */

#ifndef REG_H
#define REG_H 

/* Xilinx hardware drivers includes */
/* ********************************* */
#include "xbasic_types.h"
#include "../core_info.h"
#include <stdio.h>
#include <stdlib.h>

/* Prototypes */
/* ********************************* */
inline void    sif_reg_write                 (Xuint32 reg_address, Xuint32 reg_data);
inline Xuint32 sif_reg_read                  (Xuint32 reg_address);
void regwrite_cmd(int argc, char **argv);
void regread_cmd(int argc, char **argv);

#endif
