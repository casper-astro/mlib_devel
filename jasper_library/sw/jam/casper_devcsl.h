// casper_devcsl.h - Macro definitions and declarations for CASPER core_info
//                   CSL.

#ifndef _CASPER_DEVCSL_H_
#define _CASPER_DEVCSL_H_

#include <stdint.h>

#define CASPER_CORE_INFO_TYPECODE_GENERIC   0
#define CASPER_CORE_INFO_TYPECODE_ETHCORE   1
#define CASPER_CORE_INFO_TYPECODE_ADC16CTRL 2
#define CASPER_CORE_INFO_TYPECODE_SYSBLOCK  3

struct casper_dev_info {
  uint32_t offset;
  uint32_t length;
  uint8_t typecode;
};

uint32_t * casper_find_dev(const char *name, struct casper_dev_info *pcdi);

uint32_t * casper_find_dev_by_typecode(
    const uint8_t typecode,
    const int first,
    struct casper_dev_info *pcdi,
    const unsigned char **matched_key);

#endif // _CASPER_DEVCSL_H_
