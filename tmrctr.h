#ifndef _TMRCTR_H_
#define _TMRCTR_H_

void init_tmrctr();

// Returns 64 bit clock cycle counter value.
// With 100 MHz clock, these are in 10 ns units.
u64 read_tmrctr();

// Returns bits [46:15] of the 64 bit clock cycle counter value.  With 100 MHz
// clock, the tick interval is 327.68 microseconds and tick values will roll
// approximately every 16.25 days.  Note that every 3 ticks is approximatelty 1
// ms (983.04 usec).
u32 tick_tmrctr();

// Returns a millisecond approximation of the tick counter.  The actual units
// are 983.04 microseconds rather than 1000.000 microseconds.
u32 ms_tmrctr();

void dump_tmrctr();

#endif // _TMRCTR_H_
