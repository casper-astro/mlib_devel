/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* ADC test functions */

#ifndef ADC_H
#define ADC_H 

/* Xilinx hardware drivers includes */
/* ********************************* */
#include "xbasic_types.h"
#include "xparameters.h"
#include "../core_info.h"
#include <stdio.h>
#include <stdlib.h>

/* Prototypes */
/* ********************************* */
void adc_write(int adc, Xuint32 address, Xuint32 data);
void adc_reset(int adc,int interleave);
int  adc_getphase(int* fail);
void adcinit();
void adcsetreg_cmd();
void adcreset_cmd();
void adcgetphase_cmd();

/* Constants */
/* ********************************* */
#define ADC_RESET_REG      0x03
#define ADC_MODEPIN_REG    0x02
#define ADC_DCMCTRL_REG    0x01
#define ADC_DCMMEAS_REG    0x00

#define ADC0_OFFSET        0x04
#define ADC1_OFFSET        0x08

#define ADC_DATA_REG       0x00
#define ADC_ADDR_REG       0x02
#define ADC_CTRL_REG       0x03



#endif
