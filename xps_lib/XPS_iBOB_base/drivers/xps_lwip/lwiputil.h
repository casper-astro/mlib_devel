#ifndef LWIP_UTIL_H
#define LWIP_UTIL_H

#define TELNET_PORT 23

#define LWIP_TMR_INTERVAL 10
#define LWIP_TIMER_CYCLES (XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ / 1000 * LWIP_TMR_INTERVAL )

#define NETCLIENT_UNKNOWN (0)
#define NETCLIENT_TELNET  (1)
#define NETCLIENT_OTHER   (0)

void send_buf();
void bufferbyte(unsigned char c);
void telnet_init(void);

#endif // LWIP_UTIL_H
