// $Id$

// Determine which memory functions are available
#ifdef LWIP_ENABLE
#include "lwip/mem.h"
#define FIFO_MALLOC(n) mem_malloc(n)
#define FIFO_FREE(n) mem_free(n)
#else // Not LWIP_ENABLE
#define TEST_MODE
#include <stdio.h>
#include <stdlib.h>
#define FIFO_MALLOC(n) malloc(n)
#define FIFO_FREE(n) free(n)
#endif // LWIP_ENABLE

#include "fifo.h"

// Allocates and initializes a new fifo
// with depth locations.
fifo_p fifo_alloc(unsigned int depth)
{
#ifdef TEST_MODE
  int i;
#endif
  fifo_p f = NULL;
  if(depth > 0) {
    // Increment depth since we must always have one
    // unoccupied location.
    depth++;
    f = (fifo_p)FIFO_MALLOC(FIFO_HDR_SIZE+depth);
    if(f) {
      f->head = 0;
      f->tail = 0;
      f->len = depth;
#ifdef TEST_MODE
      for(i=0;i<depth;i++) f->buf[i] = 0xff;
#endif
    }
  }
  return f;
}

// Puts upto maxlen bytes from src into f.
// Returns actual number of bytes put into f.
unsigned int fifo_put(fifo_p f, char * src, unsigned int maxlen)
{
  unsigned int stop;
  char * p = src;

  if(f->head >= f->tail) {
    stop = f->len;
    if(f->tail == 0) stop--;
    while(maxlen > 0 && f->head < stop) {
      f->buf[f->head++] = *(p++);
      maxlen--;
    }
  }

  if(f->head == f->len) f->head = 0;

  stop = f->tail;
  while(maxlen > 0 && f->head + 1 < stop) {
    f->buf[f->head++] = *(p++);
    maxlen--;
  }

  return p-src;
}

// Puts upto maxlen bytes from src into f.
// Returns actual number of bytes put into f.
unsigned int fifo_get(fifo_p f, char * dst, unsigned int maxlen)
{
  unsigned int stop = f->len;
  char * p = dst;

  if( f->head >= f->tail) stop = f->head;
  while(maxlen && f->tail < stop) {
    *(p++) = f->buf[f->tail];
#ifdef TEST_MODE
    f->buf[f->tail] = 0xff;
#endif
    f->tail++;
    maxlen--;
  }

  if(f->tail == f->len) f->tail = 0;

  stop = f->head;
  while(maxlen && f->tail < stop) {
    *(p++) = f->buf[f->tail];
#ifdef TEST_MODE
    f->buf[f->tail] = 0xff;
#endif
    f->tail++;
    maxlen--;
  }

  return p-dst;
}

#ifdef TEST_MODE
void dump_fifo(fifo_p f)
{
  int i;
  printf("depth=%d, head=%d, tail=%d, avail=%d, occupied=%d, full=%d, empty=%d\n",
      fifo_depth(f),
      f->head, f->tail,
      fifo_avail(f),
      fifo_occupied(f),
      is_fifo_full(f),
      is_fifo_empty(f));
  for(i=0; i < f->len; i++) {
    printf(" %02x", f->buf[i] & 0xff);
  }
  printf("\n");
}

int main(int argc, char * argv[])
{
  int i, n, loop;
  char foo[] = { 0x01, 0x01, 0x01 };
  char buf[4];

#define incfoo foo[0]++;foo[1]++;foo[2]++;

  fifo_p f = fifo_alloc(10);
  dump_fifo(f);
  n = fifo_put(f,foo,3); printf("Put"); for(i=0;i<n;i++) printf(" %02x", foo[i]); printf("\n"); dump_fifo(f); incfoo;
  n = fifo_put(f,foo,3); printf("Put"); for(i=0;i<n;i++) printf(" %02x", foo[i]); printf("\n"); dump_fifo(f); incfoo;
  n = fifo_put(f,foo,3); printf("Put"); for(i=0;i<n;i++) printf(" %02x", foo[i]); printf("\n"); dump_fifo(f); incfoo;
  n = fifo_put(f,foo,3); printf("Put"); for(i=0;i<n;i++) printf(" %02x", foo[i]); printf("\n"); dump_fifo(f); incfoo;

  for(loop=0;loop<10;loop++) {
    n = fifo_get(f,buf,4); printf("Got"); for(i=0;i<n;i++) printf(" %02x", buf[i]); printf("\n"); dump_fifo(f);
    n = fifo_put(f,foo,3); printf("Put"); for(i=0;i<n;i++) printf(" %02x", foo[i]); printf("\n"); dump_fifo(f); incfoo;
  }

  return 0;
}
#endif // TEST_MODE
