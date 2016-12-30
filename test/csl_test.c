#include <stdio.h>

#include "csl.h"

extern unsigned char _binary_core_info_bin_start;
#define CORE_INFO (&_binary_core_info_bin_start)

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
