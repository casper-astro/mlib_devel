/* ********************************* */
/* *                               * */
/* * iBOB clock control functions  * */
/* *                               * */
/* ********************************* */

/* 2006 Pierre-Yves droz */

/* Memory acces functions */

#ifndef CLK_H
#define CLK_H

/* Xilinx hardware drivers includes */
/* ********************************* */
#include "xparameters.h"
#include "xbasic_types.h"
#include <stdio.h>
#include <stdlib.h>

/* Prototypes */
/* ********************************* */
void clkphase_cmd(int argc, char **argv);
void clkreset_cmd(int argc, char **argv);
void clkmeasure_cmd(int argc, char **argv);

/* Constants */
/* ********************************* */
#define COUNTER_100     0x4
#define COUNTER         0x8
#define COUNTERCTRL     0x2
#define RESETCTRL       0x1
#define PHASECTRL       0x3
#define RESET_COUNTERS  2
#define ENABLE_COUNTERS 1
#define RESET           1
#define POSITIVEPHASE   3
#define NEGATIVEPHASE   2

#endif

