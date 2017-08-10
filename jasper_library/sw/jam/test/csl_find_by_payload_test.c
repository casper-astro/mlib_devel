#include <stdio.h>
#include <stdlib.h>

#include "csl.h"

extern unsigned char _core_info;
// Add 2 to skip length field
#define CORE_INFO ((&_core_info) + 2)

int
main(int argc, char *argv[])
{
  unsigned char *csl = CORE_INFO;
  unsigned char payload_len = *CORE_INFO;
  const unsigned char *typecode_str = "1";
  const unsigned char *payload;
  unsigned char typecode;
  const unsigned char *key;
  unsigned int nfound = 0;
  int i;

  if(argc > 1) {
    typecode_str = argv[1];
  }

  typecode = strtoul(typecode_str, NULL, 0);

  printf("payload length %u\n", payload_len);

  while((payload = csl_find_by_payload(csl, 8, typecode, &key))) {
    nfound++;
    csl = NULL;

    printf("%s", key);
    for(i=0; i<payload_len; i++) {
      printf(" %02x", payload[i]);
    }
    printf("\n");
  }
  
  if(nfound > 0) {
    printf("found %d entries with typecode 0x%02x\n", nfound, typecode);
  } else {
    printf("typecode 0x%02x not found\n", typecode);
  }

  return 0;
}
