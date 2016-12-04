#ifndef _TMRCTR_H_
#define _TMRCTR_H_

void init_tmrctr();

// Returns 64 bit clock cycle counter value.
// With 100 MHz clock, these are in 10 ns units.
u64 read_tmrctr();

// Returns middle 32 bits of 64 bit clock cycle coutner value.
// With 100 MHz clock, these are in units of 655.36 microseconds
// and will roll every approximately every 23.5 days.
u32 tick_tmrctr();

void dump_tmrctr();

#endif // _TMRCTR_H_
