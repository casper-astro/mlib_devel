// flash.c - Functions for reading and writing flash memory

#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"
#include "spi.h"
#include "flash.h"

// Erase a sector of memory including the address `addr`
// Will block until the memory indicates completion or timeout/error
// Returns the number of bytes erased, or 0 for failure
int
flash_erase_sector(uint32_t addr)
{
  uint8_t buf[4];
  xil_printf("erase: %08x\n", addr);
  buf[0] = FLASH_WRITE_ENABLE;
  send_spi(buf, buf, 1, 0);
  buf[0] = FLASH_SECTOR_ERASE;
  buf[1] = (addr >> 16) & 0xff;
  buf[2] = (addr >>  8) & 0xff;
  buf[3] = (addr      ) & 0xff;
  send_spi(buf, buf, 4, 0);
  // get status reg
  buf[0] = FLASH_READ_STATUS_REG;
  send_spi(buf, buf, 2, 0);
  while(buf[1] & 1) {
    buf[0] = FLASH_READ_STATUS_REG;
    send_spi(buf, buf, 2, 0);
  }
  buf[0] = FLASH_WRITE_DISABLE;
  send_spi(buf, buf, 1, 0);
  //xil_printf("done\n");
  // There should be some error checking here
  // to make sure the erase actually worked
  return FLASH_SECTOR_SIZE;
}

int
flash_write_page(uint32_t addr, uint8_t *p, int len)
{
  uint8_t buf[4];
  xil_printf("w: %08x\n", addr);
  if(len != FLASH_PAGE_SIZE) {
    xil_printf("Wrong size\n");
    return 0;
  }
  // Turn on the write enable
  buf[0] = FLASH_WRITE_ENABLE;
  send_spi(buf, buf, 1, 0);
  // Send the write command and address
  // Leave the transaction open for the data
  buf[0] = FLASH_PAGE_PROGRAM;
  buf[1] = (addr >> 16) & 0xff;
  buf[2] = (addr >>  8) & 0xff;
  buf[3] = (addr      ) & 0xff;
  send_spi(buf, buf, 4, SEND_SPI_MORE);
  // send the data
  send_spi(p, p, len, 0);
  // wait for the write to complete
  buf[0] = FLASH_READ_STATUS_REG;
  send_spi(buf, buf, 2, 0);
  while(buf[1] & 1) {
    buf[0] = FLASH_READ_STATUS_REG;
    send_spi(buf, buf, 2, 0);
  }
  buf[0] = FLASH_WRITE_DISABLE;
  send_spi(buf, buf, 1, 0);
  //xil_printf("done\n");
  // There should be some error checking here
  // to make sure the erase actually worked
  return len;
}

int
flash_read(uint32_t addr, uint8_t *p, int len)
{
  uint8_t buf[4];
  //xil_printf("r %d B: %08x\n", len, addr);
  // Send the read command and address
  // Leave the transaction open for the data
  buf[0] = FLASH_READ;
  buf[1] = (addr >> 16) & 0xff;
  buf[2] = (addr >>  8) & 0xff;
  buf[3] = (addr      ) & 0xff;
  send_spi(buf, buf, 4, SEND_SPI_MORE);
  // read the data
  send_spi(p, p, len, 0);
  // wait for the write to complete
  buf[0] = FLASH_READ_STATUS_REG;
  send_spi(buf, buf, 2, 0);
  while(buf[1] & 1) {
    buf[0] = FLASH_READ_STATUS_REG;
    send_spi(buf, buf, 2, 0);
  }
  // There should be some error checking here
  // to make sure the erase actually worked
  return len;
}

int
flash_read_id(uint8_t *p)
{
  uint8_t buf[5];
  // Send the read command
  // Leave the transaction open for the data
  buf[0] = FLASH_READ_ID;
  send_spi(buf, buf, 5, SEND_SPI_MORE);
  // read the data
  send_spi(p, p, buf[4], 0);
  // wait for the read to complete
  buf[0] = FLASH_READ_STATUS_REG;
  send_spi(buf, buf, 2, 0);
  while(buf[1] & 1) {
    buf[0] = FLASH_READ_STATUS_REG;
    send_spi(buf, buf, 2, 0);
  }
  // There should be some error checking here
  // to make sure the command
  return buf[4];
}
