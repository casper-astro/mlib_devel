#include <stdio.h>

#include "csl.h"

extern unsigned char _core_info;
// Add 2 to skip length field
#define CORE_INFO ((&_core_info) + 2)

int
main(int argc, char *argv[])
{
  const unsigned char *key = "sys_board_id";
  const unsigned char *payload;
  unsigned char payload_len = *CORE_INFO;

  if(argc > 1) {
    key = argv[1];
  }

  printf("payload length %u\n", payload_len);

  payload = csl_find_key(CORE_INFO, key);

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
