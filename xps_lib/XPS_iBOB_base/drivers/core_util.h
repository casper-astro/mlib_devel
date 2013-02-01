// $Id$
//
// Utility functions for use with cores
#ifndef CORE_UTIL_H

// Get blk_type typedef
#include "core_info.h"

#define CORE_OK (0)
#define CORE_NOT_FOUND (-1)
#define CORE_WRONG_TYPE (-2)
// Finds a core given a name.  If type is not "all", the named core must be
// the given type.  On success, returns 0 and *corepp will contain a pointer to
// the found core.  On failure, returns CORE_NOT_FOUND or CORE_WRONG_TYPE
// and *corepp will be set to NULL.
int find_core(char * name, blk_type type, core ** corepp);

// Pretty prints a value
void pprint_value(unsigned int v);

// Pretty prints an address and a value
void pprint_address_value(unsigned int a, unsigned int v);
#endif // CORE_UTIL_H
