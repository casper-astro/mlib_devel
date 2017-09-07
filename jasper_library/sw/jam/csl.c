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
// The first value of a list entry specifies the entry's head size.  The head
// size is the number of leading characters from the previous list entry that
// are the same for the current list entry.  The second value specifies the
// entry's tail size.  The tail size is the number of trailing characters in
// the current list entry that differ from the previous list entry.  The second
// value is then followed by those trailing characters, withOUT a terminating
// NUL character since the exact length is known.  These trailing characters
// are followed by the fixed length payload, if any.  The contents of the
// payload are not relevant to the CSL data structure itself.  The payload
// bytes are opaque data provided by and returned to clients.
//
// The first entry in the list has no previous entry and therefore has an
// implicit head size of 0.  Instead of storing zero there, the first entry's
// head size field is used to specify the fixed size of each entry's payload.
//
// Technically, the list entry strings need not be sorted, but unsorted list
// entries will reduce the compactness of the CSL so it is highly recommended
// to sort the list before compacting it into a CSL.  Furthermore, unsorted
// entries will break search algorithms that depend on sorted entries.
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
// length value, the head size, and the tail size are each stored as a single
// byte.  This limits the maximum size of the strings and payloads to 255 bytes
// each.  This is an implementation limit, not an inherent limit of the CSL
// data structure.
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
const unsigned char *
csl_find_key(
    const unsigned char *csl,
    const unsigned char *key)
{
  unsigned char ntail;
  unsigned char nmatch = 0;
  unsigned char pl_len;

  if(!csl) {
    return (unsigned char *)0;
  }

  // Save payload length
  pl_len = *csl++;

  // While we have entries to process
  while((ntail = *csl++)) {
    // While we have characters to match,
    // advance through the matching characters
    while(ntail && *key && *csl == *key) {
#ifdef DEBUG_CSL
      printf("matched %c\n", *csl);
#endif
      csl++; ntail--;
      key++;
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
    csl += ntail + pl_len;
#ifdef DEBUG_CSL
    printf("next head size is %u\n", *csl);
#endif

    // Skip entries with head size greater than nmatch
    while(*csl > nmatch) {
#ifdef DEBUG_CSL
      printf("skipping head size %u ", *csl);
#endif
      csl++;
#ifdef DEBUG_CSL
      printf("and tail %u\n", *csl);
#endif
      csl += *csl + pl_len;
      csl++;
    }

    // Are we past the point where key should be?
    if(*csl++ < nmatch) {
      // Not found
#ifdef DEBUG_CSL
      printf("bailing on head size %u\n", *--csl);
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

// File static (private) static storage for csl_iter_* and find_by_* functions.
static const unsigned char *csl_pcsl = (const unsigned char )0;
static unsigned char csl_key[256] = {0};
static unsigned char csl_pl_len = 0;
static unsigned char csl_nhead = 0;

// Initialize internal storage to iterate through a CSL
void
csl_iter_init(const unsigned char *csl)
{
  csl_pcsl = csl;
  csl_key[0] = '\0';
  csl_pl_len = *csl_pcsl++;
  csl_nhead = 0;
}

// Get the next entry.  Returns pointer to payload of next entry or NULL if no
// more entries.  If pkey is non-NULL, a pointer to the entry's full key string
// will be stored in *pkey.
const unsigned char *
csl_iter_next(const unsigned char **pkey)
{
  unsigned char *pcsl_key;
  unsigned char ntail;
  const unsigned char *payload = (const unsigned char *)0;

  // csl_pcsl was left pointing to tail size field of next entry, so we can use
  // that to tell if we are at the end of the list (i.e. when ntail == 0).
  if((ntail = *csl_pcsl++)) {
    // Copy tail
    pcsl_key = csl_key + csl_nhead;
    while(ntail--) {
      *pcsl_key++ = *csl_pcsl++;
    }
    *pcsl_key = '\0';
    // Save payload pointer and key
    payload = csl_pcsl;
    if(pkey) {
      *pkey = csl_key;
    }
    // Setup for next iteration (leave csl_pcsl pointing to next entry's tail
    // size field).
    csl_pcsl += csl_pl_len;
    csl_nhead = *csl_pcsl++;
  }

  return payload;
}


// Searches a CSL for for the next entry whose payload byte `plidx` has value
// `plval`.  If found, the returned pointer is non-null.  If the CSL has
// non-zero payload length, this non-null pointer points to the first byte of
// payload corresponding to `key`.
//
// This function is designed to be called iteratively to walk through the
// entire CSL to find all matching the search criteria.  To start a new search,
// `csl` should point to the beginning of the CSL to be searched using `plidx`
// and `plval` as the search criteria.  If a matching entry is found and
// returned, the next matching entry can be found by passing NULL for `csl` and
// the desired search criteria for `plidx` and `plval`.  While the most common
// use case will involve passing the same search criteria every time, the new
// search criteria are not required to be the same for each call.
const unsigned char *
csl_find_by_payload(
    const unsigned char *csl,
    const unsigned char plidx,
    const unsigned char plval,
    const unsigned char **matched_key)
{
  const unsigned char *payload = (const unsigned char *)0;

  // If new search, restart iterator
  if(csl) {
    csl_iter_init(csl);
  }

  // If plidx is out of bounds
  if(plidx > csl_pl_len) {
    return (unsigned char *)0;
  }

  // While we have entries
  while((payload = csl_iter_next(matched_key))) {
    // Check for match
    if(payload[plidx] == plval) {
      if(matched_key) {
#ifdef DEBUG_CSL
        printf("%s returning key '%s'\n", __FUNCTION__, *matched_key);
#endif
      }
      return payload;
    }
  }

  // No more matches
  return (unsigned char *)0;
}
