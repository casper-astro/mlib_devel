// csl.h - Function declarations for Compact Sorted List functions.

#ifndef _CSL_H_
#define _CSL_H_

const unsigned char * csl_find_key(
    const unsigned char *csl,
    const unsigned char *key);

void csl_iter_init(const unsigned char *csl);

const unsigned char * csl_iter_next(const unsigned char **pkey);

const unsigned char * csl_find_by_payload(
    const unsigned char *csl,
    const unsigned char plidx,
    const unsigned char plval,
    const unsigned char **matched_key);

#endif // _CSL_H_
