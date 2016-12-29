// csl.c - Compact Sorted List

// A compact sorted list (CSL) is a data structure used to store a sorted list
// of strings compactly by reusing as many leading characters as possible from
// one list entry to the next.  Each list entry may be followed by a fixed size
// payload, thereby making the data structure resemble a limited form of sorted
// hash table.
//
// The CSL is stored in memory as a sequence of entries.  Each list entry
// consists of two values followed by characters followed by the fixed length
// payload, if any.  The final list entry is followed by two zero values (with
// no trailing characters and no payload bytes).
//
// The first value of a list entry specifies the number of leading characters
// from the previous list entry are the same in the current list entry.  The
// second value specifies the number of trailing characters in the current list
// entry that differ from the previous list entry.  The second value is then
// followed by those trailing characters, withOUT a terminating NUL character
// since the exact length is known.  These trailing characters are followed by
// the fixed length payload, if any.  The contents of the payload are not
// relevant to the CSL data structure itself.  The payload bytes are opaque
// data provided by and returned to clients.  The first entry in the list has
// no previous entry and therefore has no characters to reuse.  The first
// entry's first value (normally a "reuse" character count) specifies the fixed
// size of each entry's payload.
//
// Technically, the list entry strings need not be sorted, but unsorted list
// entries will reduce the compactness of the CSL so it is highly recommended
// to sort the list before compacting it into a CSL.
//
// The CSL has certain characteristics that can affect its suitability for a
// given application.  These are discussed here briefly:
//
//   - Compact form
//
//     The strings stored in a CSL are not so compact as a compression
//     algorithm might be able to achieve, but they can be searched without
//     having to uncompress them first.
//
//   - Efficient searching
//
//     The count of characters in common with the previous entry combined with
//     the length of the new characters makes it fast to skip over entries that
//     do not match the search string.
//
//   - Self-contained/Relocatable
//
//     The CSL is completely self-contained and uses no pointers so it can be
//     located anywhere in memory.
//
//   - Expensive inserts
//
//     The sequential nature of the CSL makes inserts expensive.  The CSL is
//     therefore better suited for use with static (i.e. read-only) lists.
//
// This CSL implementation is designed for embedded systems with limited memory
// resources, so compactness is favored over generality.  To that end, payload
// length value, the number of reused characters, and the number of new
// characters are each stored as a single byte.  This limits the maximum size
// of the strings and payloads to 255 bytes each.  This is an implementation
// limit, not an inherent limit of the CSL data structure.
//
// Example:
//
// The CSL for the following sorted list of keywords and one byte payloads is
// shown below.
//
//     adc16_wb_ram1   1
//     adc16_wb_ram2   2
//     eq_0_gain       3
//     eq_1_gain       4
//     eth_0_bframes   5
//     eth_0_core      6
//
// The CSL for that list would be stored as:
//
//     01 0D a d c 1 6 _ w b _ r a m 1 01
//     0C 01 2 02
//     00 09 e q _ 0 _ g a i n 03
//     03 06 1 _ g a i n 04
//     01 0C t h _ 0 _ b f r a m e s 05
//     06 04 c o r e 06
//     00 00
//
// Line breaks are added for clarity only.  The CSL uses no string or line
// terminator characters.  The compact representation, excluding payload which
// is not compacted and payload length value, occupies 58 bytes whereas the
// original representation, including terminating NULs, occupies 73 bytes.  

#include "csl.h"

#ifdef DEBUG_CSL
#include <stdio.h>
#endif

// Searches the CSL pointed to by `csl` for the string `key`.  If found, the
// returned pointer is non-null.  If the CSL has non-zero payload length, the
// non-null pointer points to the first byte of payload corresponding to `key`.
// If `payload_len` is non-NULL, the payload length is stored in the pointed to
// location.
const unsigned char *
find_key(
    const unsigned char *csl,
    const unsigned char *key,
    unsigned char *payload_len)
{
  unsigned char ntail;
  unsigned char nmatch = 0;
  unsigned char plen;

  if(!csl) {
    return (unsigned char *)0;
  }

  // Save payload length
  plen = *csl++;
  if(payload_len) {
    *payload_len = plen;
  }

  // While we have lest entries to process
  while((ntail = *csl++)) {
    // While we have characters to match,
    // advance through the matching characters
    while(ntail && *key && *csl == *key) {
#ifdef DEBUG_CSL
      printf("matched %c\n", *csl);
#endif
      csl++; ntail--;
      key++; //nkey--;
      nmatch++;
    }

#ifdef DEBUG_CSL
      printf("matched %u, *key=%02x *csl=%02x, ntail=%u\n",
          nmatch, *key, *csl, ntail);
#endif

    // If key and tail matched to the end
    if(!*key && !ntail) {
      // Found it!
      return csl;
    }
    // If key is depleted
    if(!*key) {
      // Not found
      return (unsigned char *)0;
    }

    // Keep looking...

    // Skip to next entry
    csl += ntail + plen;
#ifdef DEBUG_CSL
    printf("next reuse is %u\n", *csl);
#endif

    // Skip entries with reuse count greater than nmatch
    while(*csl > nmatch) {
#ifdef DEBUG_CSL
      printf("skipping reuse %u ", *csl);
#endif
      csl++;
#ifdef DEBUG_CSL
      printf("and tail %u\n", *csl);
#endif
      csl += *csl + plen;
      csl++;
    }

    // Are we past the point where key should be?
    if(*csl++ < nmatch) {
      // Not found
#ifdef DEBUG_CSL
      printf("bailing on reuse %u\n", *--csl);
#endif
      return (unsigned char *)0;
    }
  }

  // Not found
#ifdef DEBUG_CSL
  printf("never matched! ntail=%u\n", ntail);
#endif
  return (unsigned char *)0;
}
