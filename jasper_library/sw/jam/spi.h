#ifndef _SPI_H_
#define _SPI_H_

#define SEND_SPI_MORE (0x01)

void init_spi();
u32 send_spi(u8 *src, u8 *dst, u32 len, u32 opt);

void dump_spi();

#endif // _SPI_H_
