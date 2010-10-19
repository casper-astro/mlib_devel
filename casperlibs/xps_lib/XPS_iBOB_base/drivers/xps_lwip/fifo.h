#ifndef FIFO_H
#define FIFO_H

typedef struct {
  unsigned int head;
  unsigned int tail;
  unsigned int len;
  char buf[];
} * fifo_p;

#define FIFO_HDR_SIZE (3*sizeof(int))

// Frees a fifo
#ifndef FIFO_FREE
#define FIFO_FREE(n) free(n)
#endif
#define fifo_free(f) FIFO_FREE(f)
// Number of total locations in fifo
#define fifo_depth(f) (f->len-1)
// Number of available locations in fifo
#define fifo_avail(f) ((f->tail-f->head-1+f->len)%f->len)
// Number of occupied locations in fifo
#define fifo_occupied(f) (fifo_depth(f)-fifo_avail(f))
// Non-zero if fifo is full
#define is_fifo_full(f) (fifo_avail(f)==0)
// Non-zero if fifo is empty
#define is_fifo_empty(f) (fifo_avail(f)==fifo_depth(f))
// Resets fifo
#define fifo_reset(f) do { f->head=0; f->tail=0; } while(0)

// Allocates and initializes a new fifo
// with depth locations.
fifo_p fifo_alloc(unsigned int depth);

// Puts upto maxlen bytes from src into f.
// Returns actual number of bytes put into f.
unsigned int fifo_put(fifo_p f, char * src, unsigned int maxlen);

// Puts upto maxlen bytes from src into f.
// Returns actual number of bytes put into f.
unsigned int fifo_get(fifo_p f, char * dst, unsigned int maxlen);

#endif // FIFO_H
