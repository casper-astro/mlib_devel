// flash.c - Functions for reading and writing flash memory

#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"
#include "spi.h"
#include "flash.h"

static void
flash_enter_4b_mode()
{
  uint8_t buf[2];
  buf[0] = FLASH_WRITE_ENABLE;
  send_spi(buf, buf, 1, 0);

  // enter 4 bytes address mode
  buf[0] = FLASH_ENTER_4B_MODE;
  send_spi(buf, buf, 1, 0);

  buf[0] = FLASH_READ_FLAG_STATUS_REG;
  send_spi(buf, buf, 2, 0);
  if (buf[1] & 1) {
    //print("Set to 4B mode\n");
  } else {
    print("Failed to set to 4B mode\n");
  }

  buf[0] = FLASH_WRITE_DISABLE;
  send_spi(buf, buf, 1, 0);
}

static void
flash_exit_4b_mode()
{
  uint8_t buf[2];
  buf[0] = FLASH_WRITE_ENABLE;
  send_spi(buf, buf, 1, 0);

  // enter 4 bytes address mode
  buf[0] = FLASH_EXIT_4B_MODE;
  send_spi(buf, buf, 1, 0);

  buf[0] = FLASH_READ_FLAG_STATUS_REG;
  send_spi(buf, buf, 2, 0);
  if (~(buf[1] & 1)) {
    //print("Left 4B mode\n");
  } else {
    print("Failed to exit to 4B mode\n");
  }

  buf[0] = FLASH_WRITE_DISABLE;
  send_spi(buf, buf, 1, 0);
}

/* 
 * Check the non-volatile
 * 3B/4B addressing flag,
 * and if it is not set to 4B,
 * change it.
 */
void
flash_enter_4b_non_volatile()
{
  uint8_t buf[3];
  int complete=0;
  buf[0] = FLASH_READ_NON_VOLATILE_CONFIG_REG;
  send_spi(buf, buf, 3, 0);
  if (~(buf[1] & 1)) {
    buf[0] = FLASH_WRITE_ENABLE;
    send_spi(buf, buf, 1, 0);
    buf[0] = FLASH_WRITE_NON_VOLATILE_CONFIG_REG;
    buf[1] = buf[1] ^ 1; // Set the address bit to 0
    send_spi(buf, buf, 3, 0);
    // wait for the write to complete
    // The data sheet suggests completion
    // can only be guaranteed by reading the flag
    // register on two polls, and seeing it high
    // both times
    while(complete < 2) {
      buf[0] = FLASH_READ_FLAG_STATUS_REG;
      send_spi(buf, buf, 2, 0);
      complete += (buf[1] >> 7) & 1;
    }
    buf[0] = FLASH_WRITE_DISABLE;
    send_spi(buf, buf, 1, 0);
  }
  // Enter dynamic 4B mode for good measure
  flash_enter_4b_mode();
}
  

/* 
 * Check the non-volatile
 * 3B/4B addressing flag,
 * and if it is not set to 3B
 * change it.
 */
void
flash_exit_4b_non_volatile()
{
  uint8_t buf[3];
  int complete=0;
  buf[0] = FLASH_READ_NON_VOLATILE_CONFIG_REG;
  send_spi(buf, buf, 3, 0);
  if (buf[1] & 1) {
    buf[0] = FLASH_WRITE_ENABLE;
    send_spi(buf, buf, 1, 0);
    buf[0] = FLASH_WRITE_NON_VOLATILE_CONFIG_REG;
    buf[1] = buf[1] | 1; // Set the address bit to 1
    send_spi(buf, buf, 2, 0);
    // wait for the write to complete
    // The data sheet suggests completion
    // can only be guaranteed by reading the flag
    // register on two polls, and seeing it high
    // both times
    while(complete < 2) {
      buf[0] = FLASH_READ_FLAG_STATUS_REG;
      send_spi(buf, buf, 2, 0);
      complete += (buf[1] >> 7) & 1;
    }
    buf[0] = FLASH_WRITE_DISABLE;
    send_spi(buf, buf, 1, 0);
  }
  // Exit dynamic 4B mode for good measure
  flash_exit_4b_mode();
}

// Erase a sector of memory including the address `addr`
// Will block until the memory indicates completion or timeout/error
// Returns the number of bytes erased, or 0 for failure
int
flash_erase_sector(uint32_t addr)
{
  uint8_t buf[5];
  xil_printf("erase: %08x\n", addr);

  flash_enter_4b_mode();

  // Turn on the write enable
  buf[0] = FLASH_WRITE_ENABLE;
  send_spi(buf, buf, 1, 0);

  buf[0] = FLASH_SECTOR_ERASE;
  buf[1] = (addr >> 24) & 0xff;
  buf[2] = (addr >> 16) & 0xff;
  buf[3] = (addr >>  8) & 0xff;
  buf[4] = (addr      ) & 0xff;

  send_spi(buf, buf, 5, 0);
  // get status reg
  buf[0] = FLASH_READ_STATUS_REG;
  send_spi(buf, buf, 2, 0);
  while(buf[1] & 1) {
    buf[0] = FLASH_READ_STATUS_REG;
    send_spi(buf, buf, 2, 0);
  }

  flash_exit_4b_mode();

  // turn off the write enable
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
  uint8_t buf[5];
  //xil_printf("w: %08x\n", addr);
  if(len != FLASH_PAGE_SIZE) {
    xil_printf("Wrong size\n");
    return 0;
  }

  flash_enter_4b_mode();

  // Turn on the write enable
  buf[0] = FLASH_WRITE_ENABLE;
  send_spi(buf, buf, 1, 0);

  // Send the write command and address
  // Leave the transaction open for the data

  buf[0] = FLASH_PAGE_PROGRAM;
  buf[1] = (addr >> 24) & 0xff;
  buf[2] = (addr >> 16) & 0xff;
  buf[3] = (addr >>  8) & 0xff;
  buf[4] = (addr      ) & 0xff;

  send_spi(buf, buf, 5, SEND_SPI_MORE);
  // send the data
  send_spi(p, p, len, 0);
  // wait for the write to complete
  buf[0] = FLASH_READ_STATUS_REG;
  send_spi(buf, buf, 2, 0);
  while(buf[1] & 1) {
    buf[0] = FLASH_READ_STATUS_REG;
    send_spi(buf, buf, 2, 0);
  }

  // turn off the write enable
  buf[0] = FLASH_WRITE_DISABLE;
  send_spi(buf, buf, 1, 0);
  //xil_printf("done\n");
  // There should be some error checking here
  // to make sure the erase actually worked

  flash_exit_4b_mode();

  return len;
}

int
flash_read(uint32_t addr, uint8_t *p, int len)
{
  uint8_t buf[5];
  //xil_printf("r %d B: %08x\n", len, addr);
  flash_enter_4b_mode();

  // Send the read command and address
  // Leave the transaction open for the data

  buf[0] = FLASH_READ;
  buf[1] = (addr >> 24) & 0xff;
  buf[2] = (addr >> 16) & 0xff;
  buf[3] = (addr >>  8) & 0xff;
  buf[4] = (addr      ) & 0xff;

  send_spi(buf, buf, 5, SEND_SPI_MORE);
  // read the data
  send_spi(p, p, len, 0);
  // wait for the write to complete
  buf[0] = FLASH_READ_STATUS_REG;
  send_spi(buf, buf, 2, 0);
  while(buf[1] & 1) {
    buf[0] = FLASH_READ_STATUS_REG;
    send_spi(buf, buf, 2, 0);
  }
  flash_exit_4b_mode();

  return len;
}

/*
 * Read the flash UID into buffer p,
 * grabbing a maximum of len bytes
*/
int
flash_read_id(uint8_t *p, int len)
{
  uint8_t buf[5];
  // Send the read command
  // Leave the transaction open for the data
  buf[0] = FLASH_READ_ID;
  send_spi(buf, buf, 5, SEND_SPI_MORE);
  // read the data
  if (buf[4] > len) {
    send_spi(p, p, len, 0);
  } else {
    send_spi(p, p, buf[4], 0);
  }
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
