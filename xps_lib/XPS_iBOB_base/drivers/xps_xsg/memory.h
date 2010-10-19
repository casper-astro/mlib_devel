/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* Memory acces functions */

#ifndef MEMORY_H
#define MEMORY_H 

/* Xilinx hardware drivers includes */
/* ********************************* */
#include "xparameters.h"
#include <stdio.h>
#include <stdlib.h>

/* Prototypes */
/* ********************************* */
void read_cmd(int argc, char **argv);
void write_cmd(int argc, char **argv);
void readbase_cmd(int argc, char **argv);
void writebase_cmd(int argc, char **argv);
void setbase_cmd(int argc, char **argv);

/* Constants */
/* ********************************* */
extern unsigned int base_address;

#endif
