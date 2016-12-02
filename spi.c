// spi.c - Use SPI core to access flash.

#include "xparameters.h"
#include "xspi.h"

#include "spi.h"

// Missing macros
#ifndef XSpi_GetTFOcyReg
#define XSpi_GetTFOcyReg(InstancePtr) \
  XSpi_ReadReg(((InstancePtr)->BaseAddr), XSP_TFO_OFFSET)
#endif

#ifndef XSpi_GetRFOcyReg
#define XSpi_GetRFOcyReg(InstancePtr) \
  XSpi_ReadReg(((InstancePtr)->BaseAddr), XSP_RFO_OFFSET)
#endif

// Fix broken macros
#ifdef XSpi_IntrClear
#undef XSpi_IntrClear
#endif
#define XSpi_IntrClear(InstancePtr, ClearMask) \
  XSpi_WriteReg(((InstancePtr)->BaseAddr),  XSP_IISR_OFFSET, (ClearMask))

static XSpi xspi;

void
init_spi()
{
    XSpi_Config *cfg_ptr = XSpi_LookupConfig(XPAR_SPI_0_DEVICE_ID);

    XSpi_CfgInitialize(&xspi, cfg_ptr, cfg_ptr->BaseAddress);

    // Set master mode and manual slave select options
    // (manual slave select prevents toggling SS every byte)
    XSpi_SetOptions(&xspi, XSP_MASTER_OPTION | XSP_MANUAL_SSELECT_OPTION);
    // Clear slave mode error bit
    XSpi_IntrClear(&xspi, XSP_INTR_SLAVE_MODE_ERR_MASK);

    // "Start" the core
    XSpi_Start(&xspi);

    // Disable interrupt generation and just use polling
    XSpi_IntrGlobalDisable(&xspi);
}

// Dump contents of SPI registers
void
dump_spi()
{
  xil_printf("SPI controller registers:\n");
  xil_printf("  SPICR  %08x\n", XSpi_GetControlReg(&xspi));
  xil_printf("  SPISR  %08x\n", XSpi_GetStatusReg(&xspi));
  xil_printf("  SPISSR %08x\n", XSpi_GetSlaveSelectReg(&xspi));
  xil_printf("  TFOCYR %08x\n", XSpi_GetTFOcyReg(&xspi));
  xil_printf("  RFOCYR %08x\n", XSpi_GetRFOcyReg(&xspi));
  xil_printf("  DGIER  %08x\n",
                XSpi_IsIntrGlobalEnabled(&xspi) ? XSP_GINTR_ENABLE_MASK : 0);
  xil_printf("  IPISR  %08x\n", XSpi_IntrGetStatus(&xspi));
  xil_printf("  IPIER  %08x\n", XSpi_IntrGetEnabled(&xspi));
}
