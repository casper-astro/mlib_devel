// icap.c - Functions to program FPGA via ICAP interface

#include "xparameters.h"
#include "xhwicap.h"

static XHwIcap_Config *xicap_config;
static XHwIcap xicap;

void
init_icap()
{
  // First obtain the configuration structure pointer
  if (!(xicap_config = XHwIcap_LookupConfig(XPAR_AXI_HWICAP_0_DEVICE_ID))) {
    xil_printf("ICAP lookup failed\n");
  } else {
    xil_printf("ICAP lookup OK\n");
  }
  // Now use this pointer to initialize the HWICAP device
  if (XHwIcap_CfgInitialize(&xicap, xicap_config, xicap_config->BaseAddress) != XST_SUCCESS) {
    xil_printf("ICAP failed to initialize\n");
  } else {
    xil_printf("ICAP initialized OK\n");
  }
}
