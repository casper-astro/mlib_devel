// $Id$
//
// Useful utility functions defined in tinysh.c
#ifndef TINYSH_UTIL_H

typedef enum match_e {
  NULLMATCH,FULLMATCH,PARTMATCH,UNMATCH,MATCH,AMBIG
} match_t;

/* verify if the non-spaced part of s2 is included at the begining
 * of s1.
 * return FULLMATCH if s2 equal to s1, PARTMATCH if s1 starts with s2
 * but there are remaining chars in s1, UNMATCH if s1 does not start with
 * s2
 */
match_t strstart(unsigned char *s1, unsigned char *s2);

/* string to decimal/hexadecimal conversion
 */
unsigned long tinysh_atoxi(char *s);

#endif // TINYSH_UTIL_H
