// $Id$
//
// Utility functions for use with cores

#include "tinysh_util.h"
#include "core_info.h"
#include "core_util.h"

// Finds a core given a name.  If type is not "all", the named core must be
// the given type.  On success, returns 0 and *corepp will contain a pointer to
// the found core.  On failure, returns CORE_NOT_FOUND or CORE_WRONG_TYPE
// and *corepp will be set to NULL.
int find_core(char * name, blk_type type, core ** corepp)
{
  int i;

  *corepp = NULL;

  for(i=0;i<NUM_CORES;i++) {
    if(strstart(name,cores[i].name)==FULLMATCH) {
      if(type == all || cores[i].type == type) {
        *corepp = &cores[i];
        return CORE_OK;
      } else {
        return CORE_WRONG_TYPE;
      }
    }
  }

  return CORE_NOT_FOUND;
}

// Pretty prints a value
void pprint_value(unsigned int v)
{
  int i;
  xil_printf("0x%08X / 0b", v);
  for(i=31;i>=0;i--) {
    xil_printf("%d", (v>>i)&1);
  }
  xil_printf(" / %010d\n\r", v);
}

// Pretty prints an address and a value
void pprint_address_value(unsigned int a, unsigned int v)
{
  xil_printf("0x%04X / %05d -> ", a, a);
  pprint_value(v);
}
