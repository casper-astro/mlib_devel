#include <stdio.h>

#include "csl.h"

#if defined(EXTERN_CORE_INFO) && EXTERN_CORE_INFO > 0
extern unsigned char _binary_core_info_bin_start;
#define CORE_INFO (&_binary_core_info_bin_start)
#else
static unsigned char core_info[] = {
"\x01\x0D" "adc16_wb_ram1" "\x01"
"\x0C\x01"             "2" "\x02"
"\x00\x09" "eq_0_gain"     "\x03"
"\x03\x06"    "1_gain"     "\x04"
"\x01\x0C"  "th_0_bframes" "\x05"
"\x06\x04"       "core"    "\x06"
"\x00\x00"
};
#define CORE_INFO (core_info)
#endif

int
main(int argc, char *argv[])
{
  const unsigned char *key = "sys_board_id";
  const unsigned char *payload;
  unsigned char payload_len = 0;

  if(argc > 1) {
    key = argv[1];
  }

  payload = find_key(CORE_INFO, key, &payload_len);
  printf("payload length %u\n", payload_len);

  if(payload) {
    printf("%s", key);
    while(payload_len--) {
      printf(" %02x", *payload++);
    }
    printf("\n");
  } else {
    printf("%s not found\n", key);
  }

  return 0;
}
