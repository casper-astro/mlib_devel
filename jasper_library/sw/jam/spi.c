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

    // Ensure the core is disabled
    XSpi_Disable(&xspi);

    // Reset fifos
    XSpi_SetControlReg(&xspi,
        XSpi_GetControlReg(&xspi) |
        XSP_CR_TXFIFO_RESET_MASK  |
        XSP_CR_RXFIFO_RESET_MASK);

    // Ensure interrupt generation is disabled and just use polling
    XSpi_IntrGlobalDisable(&xspi);
}

// SPI transaction function
//
// `src` is pointer to buffer to send
// `dst` is pointer to buffer into which received byts are stored
//       can be equal to `src` to do an "in-place" transaction
// `len` is number of bytes to transfer
// `opt` is bitmask of option flags
//       SEND_SPI_MORE leaves the transaction open
//
// Returns `len` on success; less than `len` on error.
u32
send_spi(u8 *src, u8 *dst, u32 len, u32 opt)
{
  int i;
  u8  bytes_to_xfer; // send in chunks of 16
  u32 bytes_remaining = len;
  u16 control_reg = XSpi_GetControlReg(&xspi);

  // If not already enabled, start a new transaction
  if(!(control_reg & XSP_CR_ENABLE_MASK)) {
    // Reset fifos
		control_reg |= (XSP_CR_TXFIFO_RESET_MASK | XSP_CR_RXFIFO_RESET_MASK);
    XSpi_SetControlReg(&xspi, control_reg);

    // Enable (take pins out of tri-state and allow master transactions)
    XSpi_Enable(&xspi);

    // Select slave.  Be sure to use the "...Reg()" form of the setter since we
    // are not using the higher level XSpi functions.
    XSpi_SetSlaveSelectReg(&xspi, ~1);
  }

  // Send until done
  while(bytes_remaining > 0) {
    // Send data in chunks up to 16 bytes (FIFO depth) long
    bytes_to_xfer = bytes_remaining < 16 ? bytes_remaining : 16;

    // Write data to tx fifo
    for(i=0; i < bytes_to_xfer; i++) {
      // Post-increment src
      XSpi_WriteReg(xspi.BaseAddr, XSP_DTR_OFFSET, *src++);
    }

    // Loop many time or until until tx fifo is empty
    for(i=0; i<1000; i++) {
      if(XSpi_GetStatusReg(&xspi) & XSP_SR_TX_EMPTY_MASK) {
        break;
      }
    }

    // If "timed out"
    if(i == 1000) {
      // Uh-oh, print some details
      xil_printf("looped %d times waiting for spi tx fifo empty\n", i);
      // Show SPI registers
      //dump_spi();
      return len - bytes_remaining;
    }

    // Read bytes from rx fifo
    for(i=0; i < bytes_to_xfer; i++) {
      if(XSpi_GetStatusReg(&xspi) & XSP_SR_RX_EMPTY_MASK) {
        // Underflow!
        return len - bytes_remaining;
      }
      // Post-increment dst, decrement bytes_remaining
      *(dst++) = XSpi_ReadReg(xspi.BaseAddr, XSP_DRR_OFFSET) & 0xff;
      bytes_remaining--;
    }
  }

  // If not doing more, close transaction
  if(!(opt & SEND_SPI_MORE)) {
    // De-select slave.  Be sure to use the "...Reg()" form of the setter since
    // we are not using the higher level XSpi functions.
    XSpi_SetSlaveSelectReg(&xspi, ~0);

    // Disable (tri-state pins)
    XSpi_Disable(&xspi);
  }

  return len;
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
