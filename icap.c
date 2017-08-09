// icap.c - Functions to program FPGA via ICAP interface

#include "xparameters.h"
#include "xhwicap.h"

static XHwIcap_Config *xicap_config;
static XHwIcap xicap;

/* 
 *  See UG470 (v1.11) "IPROG Using ICAPE2"
 *  Table 7-1, which defines the command
 *  sequence required to set a boot address
 *  (WBSTAR register) and then issue
 *  a program (IPROG) command.
 */

#define ICAP_REPROG_CMD_LEN 8
#define ICAP_REPROG_CMD_ADDR_POS 4
static uint32_t reprog_cmd[ICAP_REPROG_CMD_LEN] =
    {
        0xFFFFFFFF, // Dummy word
        0xAA995566, // Sync Word
        0x20000000, // Type 1 NO OP
        0x30020001, // Type 1 Write 1 word to WBSTAR
        0x00000000, // WBSTAR boot address
        0x30008001, // Type 1 Write 1 word to CMD
        0x0000000F, // IPROG (program) command
        0x20000000, // Type 1 NO OP
    };

void
init_icap()
{
    // First obtain the configuration structure pointer
    if (!(xicap_config = XHwIcap_LookupConfig(XPAR_AXI_HWICAP_0_DEVICE_ID))) {
        xil_printf("ICAP lookup FAIL\n");
    }
    // Now use this pointer to initialize the HWICAP device
    if (XHwIcap_CfgInitialize(&xicap, xicap_config, xicap_config->BaseAddress) != XST_SUCCESS) {
        xil_printf("ICAP init FAIL\n");
    } else {
        xil_printf("ICAP init OK\n");
    }
}

void
icap_reprog_from_flash(uint32_t wbstar_addr)
{
    uint32_t i=0;
    reprog_cmd[ICAP_REPROG_CMD_ADDR_POS] = wbstar_addr;

    for (i=0; i<ICAP_REPROG_CMD_LEN; i++) {
        XHwIcap_WriteReg(xicap_config->BaseAddress, XHI_WF_OFFSET, reprog_cmd[i]);
    }

    XHwIcap_WriteReg(xicap_config->BaseAddress, XHI_CR_OFFSET, XHI_CR_WRITE_MASK);

    // We should reprogram here, so never reach the following code
}
