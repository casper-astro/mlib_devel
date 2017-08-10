// casper_devcsl.c - Functions to access CASPER core_info CSL.

#include "xparameters.h"
#include "csl.h"
#include "casper_devcsl.h"

extern const uint8_t _core_info;
#define CORE_INFO (&_core_info)

// Looks for device named `name` in core_info CSL.  If found, fills in the
// `casper_dev_info` structure pointed to by `pcdi` (if non-NULL) and returns
// the device's address.  If not found, returns 0.
uint32_t *
casper_find_dev(const char *name, struct casper_dev_info *pcdi)
{
  int i;
  uint32_t addr = 0;
  const uint8_t *payload;

  // If no core_info or zero length payloads, return 0
  if(!CORE_INFO[0] || !CORE_INFO[1]) {
    return 0;
  }

  // If device is found
  if((payload = csl_find_key(CORE_INFO, (const uint8_t *)name))) {
    // Get fpga_offset from payload
    for(i=0; i<4; i++) {
      addr <<= 8;
      addr |= (*payload++ & 0xff);
    }
    if(pcdi) {
      pcdi->offset = addr;
      // Get fpga_len
      for(i=0; i<4; i++) {
        pcdi->length <<= 8;
        pcdi->length |= (*payload++ & 0xff);
      }
      pcdi->typecode = *payload;
    }
    // Add base address
    addr += XPAR_AXI_SLAVE_WISHBONE_CLASSIC_MASTER_0_BASEADDR;
  }

  return (uint32_t *)addr;
}

// Look for devices with typecode `typecode` in core_info CSL.  If found, fills
// in the `casper_dev_info` structure pointed to by `pcdi` (if non-NULL) and
// returns the device's address.  If not found, returns 0.
//
// If `first` is non-zero, this will start searching from the beginning of the
// core_info CSL.  If `first` is zero, this will continue a previous search.
//
// If `matched_key` is non-null, `*matched_key` will point to the name of the
// device found.
uint32_t *
casper_find_dev_by_typecode(
    const uint8_t typecode,
    const int first,
    struct casper_dev_info *pcdi,
    const unsigned char **matched_key)
{
  int i;
  uint32_t addr = 0;
  const uint8_t *csl;
  const uint8_t * payload;

  // If no core_info or zero length payloads, return 0
  if(!CORE_INFO[0] || !CORE_INFO[1]) {
    return 0;
  }

  csl = first ? CORE_INFO : (const uint8_t *)0;

  if((payload = csl_find_by_payload(csl, 8, typecode, matched_key))) {
    // Get fpga_offset from payload
    for(i=0; i<4; i++) {
      addr <<= 8;
      addr |= (*payload++ & 0xff);
    }
    if(pcdi) {
      pcdi->offset = addr;
      // Get fpga_len
      for(i=0; i<4; i++) {
        pcdi->length <<= 8;
        pcdi->length |= (*payload++ & 0xff);
      }
      pcdi->typecode = *payload;
    }
    // Add base address
    addr += XPAR_AXI_SLAVE_WISHBONE_CLASSIC_MASTER_0_BASEADDR;
  }

  return (uint32_t *)addr;
}
