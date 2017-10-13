#ifndef _FLASH_H_
#define _FLASH_H_

// Device specific parameters
#define FLASH_SECTOR_SIZE 0x10000
#define FLASH_PAGE_SIZE 0x100

// Micron N25Q256A command codes -- an incomplete list

// Reset Operations
#define FLASH_RESET_ENABLE 0x66
#define FLASH_RESET_MEMORY 0x99
// Identification Operations
#define FLASH_READ_ID 0x9e
#define FLASH_MULTIPLE_IO_READ_ID 0xaf
#define FLASH_READ_SERIAL_FLASH_DISCOVERY_PARAM 0x5a
// Read Operations
#define FLASH_READ 0x03
#define FLASH_FAST_READ 0x0b
// Write Operations
#define FLASH_WRITE_ENABLE 0x06
#define FLASH_WRITE_DISABLE 0x04
// Registers
#define FLASH_READ_STATUS_REG 0x05
#define FLASH_WRITE_STATUS_REG 0x01
#define FLASH_READ_LOCK_REG 0xe8
#define FLASH_WRITE_LOCK_REG 0xe5
#define FLASH_READ_FLAG_STATUS_REG 0x70
// Program Operations
#define FLASH_PAGE_PROGRAM 0x02
// Erase Operations
#define FLASH_SUBSECTOR_ERASE 0x20
#define FLASH_SECTOR_ERASE 0xd8
// Address modes
#define FLASH_ENTER_4B_MODE 0xb7
#define FLASH_EXIT_4B_MODE 0xe9
// Quad Operations
#define FLASH_ENTER_QUAD 0x35
#define FLASH_EXIT_QUAD 0xf5


int flash_erase_sector(uint32_t addr);
int flash_write_page(uint32_t addr, uint8_t *p, int len);
int flash_read(uint32_t addr, uint8_t *p, int len);
int flash_read_id(uint8_t *p);

#endif // _FLASH_H_
