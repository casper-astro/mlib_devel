// casper_tapcp.c - CASPER TAPCP server implementation.
//
// TAPCP is an acronym for "TFTP Access for Program and Control Protocol".
//
// A CASPER TAPCP server is a TFTP server that exposes various aspects of its
// memory space and other services to TFTP clients.  This is done by mapping
// the memory and other services into a virtual filesystem (VFS) that is
// amenable to access via the TFTP protocol.
//
// TFTP provides two main operations: "get" and "put".  A "get" operation is
// invoked by the client to read data from the server.  A "put" operation is
// invoked to write data to the server.  Each operation can be performed in one
// of two modes: "netascii" (aka "ascii" aka "text") or "octet" (aka "binary").
// TAPCP uses these modes to determine how to interpret data being sent by the
// client (for a put operation) and how to format data being sent to a client
// (for a get operation).
//
// The CASPER TAPCP virtual filesystem appears as a hierarchical filesystem.
// The top (aka root) level of this virtual filesystem can be considered a
// command name.  Some commands accept additional parameters that are given as
// hierarchical pathname components or dotted filename extensions.  The data
// being read or written is transferred as the contents of the virtual file.
//
// Supported top level commands are (or will eventually be):
//
//   - `/help` [RO] Returns a list of top level commands.  Format is the same
//     regardless of file transfer mode [TODO Do we want to send CRLF line
//     terminators in netascii mode?].
//
//   - `/listdev` [RO] Lists all devices supported by the currently running
//     gateware design.  The offset, length, and type of each device is
//     included in this listing.  In netascii mode this listing is returned as
//     a human readable table.  In octet mode this listing is returned in the
//     binary compressed/compiled form that is stored in memory.
//
//   - `/temp` [RO] Sends the temperature of the FPGA.  In netascii mode this
//     returns the temperature rounded down to the nearest tenth of a degree C.
//     In binary mode this returns a 4 byte single precision float in network
//     byte order (big endian).
//
//   - `/dev/DEV_NAME[.WORD_OFFSET[.NWORDS]]`  Accesses memory associated with
//     gateware device `DEV_NAME`.  `WORD_OFFSET` and `NWORDS`, when given, are
//     in hexadecimal.  `WORD_OFFSET` is in 4-byte words and defaults to 0.
//     `NWORDS` is a count of 4-byte words to read and defaults to 0, meaning
//     read all words from `WORD_OFFSET` to end of the given device's memory.
//     `NWORDS` is ignored on writes because the amount of data written is
//     determined by the amount of data sent by the client.
//
//   - `/fpga.BYTE_OFFSET[.NBYTES]`  Accesses memory in the FPGA gateware
//     device address space.  `BYTE_OFFSET` and `NBYTES`, when given, are in
//     hexadecimal.  `BYTE_OFFSET` is in bytes and will be rounded down, if
//     necessary, to the closest multiple of 4.  `NBYTES` is a count of bytes
//     to read and will be rounded up, if necessary, to the closest multiple of
//     4.  `NBYTES` defaults to 4.  `NBYTES` is ignored on writes because the
//     amount of data written is determined by the amount of data sent by the
//     client.
//
//   - `/cpu.BYTE_ADDR[.NBYTES]` [RO] Accesses memory in the CPU address space.
//     `BYTE_ADDR` and `NBYTES`, when given, are in hexadecimal.  `BYTE_ADDR`
//     is a byte address and will be rounded down, if necessary, to the closest
//     multiple of 4.  `NBYTES` is a count of bytes to read and will be rounded
//     up, if necessary, to the closest multiple of 4.  `NBYTES` defaults to 4.
//     `NBYTES` is ignored on writes because the amount of data written is
//     determined by the amount of data sent by the client.
//
//   - `/progdev` [WO] Write a 32-bit address to this register to trigger a
//      reprogramming of the FPGA from this address in flash memory.
//      It is assumed that a valid boot image exists at this location. 
//
//   - `/flashcmd[.LEN].CMD`  Provides access to the SPI Flash device attached
//     to the FPGA.  Both read and write access are supported.  The Flash
//     device responds to a variety of commands to read, write, erase, or
//     program its main memory array, various registers, and the special
//     one-time programmable (OTP) memory region.  Most commands require
//     additional data to guide their operation (e.g. an address to read or
//     write) and some require some dummy bytes to ensure proper operation of
//     the Flash device's internal control logic.  The command and any
//     ancillary data should be provided in the CMD parameter as a sequence of
//     hex digits.  The bytes given in the CMD paramter will be sent to the
//     Flash device to initiate the command's operation.
//
//     For a read operations, the CMD bytes plus a number of additional data
//     bytes are returned as the data response. The number of additional bytes,
//     beyond CMD, to be returned must be given as part of the request string
//     as a hexidecimal value.  It may be given using the minimum required
//     number of hex digits if it is delimited by an extra '.' character.
//     Alternatively, it may be given as the first 8 hex digits of CMD.  The
//     data returned for a READ operation are the bytes from CMD (not counting
//     the 4 bytes of length if given as part of CMD) followed by LEN bytes of
//     additional data read from the Flash device.
//
//     Write operations do not specify a length as it is implied by the number
//     of data bytes sent by the client.  After CMD is sent to the Flash
//     device, the data bytes to be written must be transferred as the data
//     portion of the TFTP request.  When writing small amounts of data, it is
//     possible to include all or some of the data bytes are part of CMD so
//     long as the maximum filename supported by the TFTP server (255 bytes
//     plus terminating NUL) is not exceeded.
//
//     TODO: Specify any length limitations (e.g. multiple of 4 bytes) for
//     ASCII mode transfers.
//
//   - `/flash.WORD_ADDR[.NWORDS]` Accesses the on-board flash memory.
//     `WORD_ADDR` (required) and `NWORDS` (optional) are given in
//     hexadecimal, and are counted in 4-byte words. This probably should
//     be changed to bytes.
//
// The `/help`, `/listdev`, `/temp`, and `/cpu` commands are read-only and can
// only be used with "get" operations.  Trying to "put" to them will result in
// an error being returned to the client.
//
// Requested names that do not start with a slash ('/') are considered to be
// device names relative to the "/dev" command.  For example,
// `get sys_clkcounter` is equivalent to `get /dev/sys_clkcounter`.
//
// ## Tree View of TAPCP VFS
//
//     /
//     |-- cpu.*
//     |-- dev
//     |   |-- first_fpga_device*
//     |   |-- [...]
//     |   |-- sys_clkcounter*
//     |   |-- [...]
//     |   `-- last_fpga_device*
//     |-- flash.TBD
//     |-- fpga.*
//     |-- help
//     |-- listdev
//     |-- progdev
//     `-- temp
//
// ## Read Formats
//
// Reads using the `/dev`, `/fpga`, and `/mem` commands in netascii mode will
// return data in a hex dump like format (i.e. suitable for display in a
// terminal).  Reading with these commands in octet mode will return the
// requested data in binary form in network byte order (big endian).
//
// The netascii formatted output is a simple ASCII hex dump with lines
// consisting of: an eight digit hexadecimal label followed by a colon and then
// 16 bytes of data arranged as four groups of four bytes each:
//
//     00000000: 01234567 89ABCDEF 01234567 89ABCDEF
//     00000010: 12345678 9ABCDEF0 12345678 9ABCDEF0
//     00000020: 23456789 ABCDEF01 23456789 ABCDEF01
//     [...]
//
// The label of the first line is always "00000000" regardless of the offset or
// address requested.
//
// ## Write Formats
//
// Writes using the '/dev', '/fpga', and '/mem' commands in netascii mode
// accept data formatted as a hexdump.  The hex dump produced by netascii mode
// reads is valid input for netascii mode writes, but other formats are also
// valid.  The following statements describe valid hexdump formats more
// generally:
//
//   1. The hexdump lines must be terminated with a newline character ('\n').
//
//   2. Any data before the first colon of the line is considered a label
//      (e.g. address) and ignored.
//
//   3. One or more whitespace characters separate groups of hexadecimal
//      digits.  Non-numeric hexadecimal digits may be uppercase or lowercase.
//
//   4. Each group of hex digits is treated as a concatenation of 8 digit
//      (32 bit) values.  The last value of a group of hex digits may have
//      fewer than 8 digits (leading zeros assumed).
//
//   5. Other than the first colon of a line, the first character that is
//      neither whitespace nor a hexadecimal digit and all characters that
//      follow it are ignored.
//
// Note that each whitespace separated group of hex digits is treated as at
// least one 32 bit value.  The following three lines are equivalent:
//
//     label: 00 11 22 33
//
//     00000000 00000011 00000022 00000033
//
//     00000000000000110000002233 # first three have 8 digits, last has 2
//
// Watch out for these errors:
//
//     00000000 00000011 00000022 00000033 # error: first colon after data
//
//     00000000 00000011 00000022 00000033 comment looks like data
//
// The first is an error because the colon in the comment is the first colon on
// the line.  Detection of the first colon happens while buffering the line
// (i.e. before processing the line) so this "first colon" will still be
// detected a label terminator and everything before it will be ignored.
//
// The second is an error because the first character of the comment is a 'c'
// which is a valid hex digit and will be treated as the fifth 32 bit value of
// the line.
//
// The format for netascii writes was chosen to be easy to parse and compatible
// with the format output by netascii reads.  The output of the command line
// utilities `xxd` and `hexdump` is generally NOT compatible by default, but
// can be massaged fairly easily into a compatible format.

#include <ctype.h>
#include "xil_io.h"
#include "lwip/apps/tftp_server.h"
#include "casper_tftp.h"
#include "casper_tapcp.h"
#include "casper_devcsl.h"
#include "csl.h"
#include "spi.h"
#include "icap.h"
#include "flash.h"
#include "tmrctr.h"

// FPGA memory space macros
#define FPGA_BASEADDR XPAR_AXI_SLAVE_WISHBONE_CLASSIC_MASTER_0_BASEADDR
#define FPGA_HIGHADDR XPAR_AXI_SLAVE_WISHBONE_CLASSIC_MASTER_0_HIGHADDR
#define FPGA_NBYTES (FPGA_HIGHADDR - FPGA_BASEADDR + 1)

// Help message
static char tapcp_help_msg[] =
"Available TAPCP commands:\n"
"  /help    - this message\n"
"  /listdev - list FPGA device info\n"
"  /temp    - get FPGA temperature\n"
"  /progdev - Boot FPGA from flash.\n"
"  /flash.OFFSET[.LENGTH] - access flash memory\n"
"  /flashcmd[.LEN].CMD` - low level flash commands\n"
"  [/dev/]DEVNAME[.OFFSET[.LENGTH]] - access DEVNAME\n"
"  /fpga.OFFSET[.LENGTH] - access FPGA memory space\n"
"  /cpu.OFFSET[.LENGTH]  - access CPU memory space\n"

;

// Externally linked core_info data
extern const uint16_t _core_info_size_be;
extern const uint8_t _core_info;
#define CORE_INFO (&_core_info)

// Utility functions

// Convert ASCII hex digits to byte array.  Blindly converts 2*nbytes input
// characters as if they are hex digits.
static
uint8_t *
hex_to_u8(uint8_t *src, uint8_t *dst, uint32_t nbytes)
{
  uint8_t i, c, val;

  while(nbytes) {
    val = 0;
    // Do two nybbles
    for(i=0; i<2; i++) {
      val <<= 4;
      c = *src++;
      if(isdigit(c)) {
        val |= (c - '0')  & 0xf;
      } else {
        // Ensure c is lower case
        c |= 0x20;
        val |= (c - 'a' + 10) & 0xf;
      }
    }
    *dst++ = val;
    nbytes--;
  }

  return src;
}

// Convert ASCII hex digits to uint32_t.  Converts up to 8 hex digits, stopping
// on 9th hex digit or first non-hex-digit.
static
uint8_t *
hex_to_u32(uint8_t *p, uint32_t *u32)
{
  uint8_t i;
  uint8_t c;
  if(p && *p) {
    *u32 = 0;
    // Process up to 8 hex digits
    for(i=0; i<8; i++) {
      c = *p;
      if(!isxdigit(c)) {
        return p;
      }
      *u32 <<= 4;
      if(isdigit(c)) {
        *u32 |= c - '0';
      } else {
        // Ensure c is lower case
        c |= 0x20;
        *u32 |= c - 'a' + 10;
      }
      p++;
    }
  }
  return p;
}

// Convert uint8_t `u8` to ASCII hex digits in buffer pointed to by `p`.
// Leading zero included if (do_zeros >> 4) is non-zero.
// Trailing zero included if leading digit or (do_zeros & 0xf) is non-zero.
static
uint8_t *
u8_to_hex(const uint8_t u8, uint8_t *p, uint8_t do_zeros)
{
  uint8_t c;

  c = (u8 >> 4) & 0xf;
  if(c || (do_zeros >> 4)) {
    if(c > 9) {
      *p++ = c - 10 + 'A';
    } else {
      *p++ = c      + '0';
    }
    do_zeros |= c;
  }

  c = u8 & 0xf;
  if(c || (do_zeros & 0xf)) {
    if(c > 9) {
      *p++ = c - 10 + 'A';
    } else {
      *p++ = c      + '0';
    }
  }

  return p;
}

// Convert uint32_t to ASCII hex digits.
// Leading zeros are included if do_zeros is non-zero.
static
uint8_t *
u32_to_hex(const uint32_t u32, uint8_t *p, uint8_t do_zeros)
{
  uint8_t i;
  uint8_t c;

  for(i=0; i<4; i++) {
    c = (u32 >> (24 - (i<<3))) & 0xff;
    p = u8_to_hex(c, p, (do_zeros ? 0x11 : (i == 3 ? 1 : 0)));
    do_zeros |= c;
  }

  return p;
}

// Read functions.
static
int
casper_tapcp_read_help(struct tapcp_state *state, void *buf, int bytes)
{
  int len = bytes < state->nleft ? bytes : state->nleft;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->nleft);
#endif

  memcpy(buf, state->ptr, len);
  state->ptr   += len;
  state->nleft -= len;
  return len;
}

static
int
casper_tapcp_read_temp(struct tapcp_state *state, void *buf, int bytes)
{
  // We send "d.d\n", "dd.d\n", or "ddd.d\n" (4 to 6 bytes) in ascii mode.
  // We send 4 byte big endian single precision float in binary mode.
  // In any case, bytes is almost certainly larger than 6, but we check anyway.
  if(bytes < 6) {
    return -1;
  }

  int len = 0;
  float fpga_temp = get_fpga_temp();
  
  if(state->binary) {
    //*(uint32_t *)buf = mb_swapb(*(uint32_t *)&fpga_temp);
    *(uint32_t *)buf = mb_swapb(fpga_temp);
    len = 4;
  } else {
    char * bbuf = (char *)buf;
    // t is integer temp in deci-degrees
    int t = (int)(10 * fpga_temp);
    // Hundreds place
    if(t > 1000) {
      *bbuf++ = '0' + (t/1000) % 10;
      len++;
    }
    // Tens place
    if(t > 100) {
      *bbuf++ = '0' + (t/100) % 10;
      len++;
    }
    // Ones place
    *bbuf++ = '0' + (t/10) % 10;
    // Decimal point
    *bbuf++ = '.';
    // Tenths place
    *bbuf++ = '0' + t % 10;
    // Newline
    *bbuf++ = '\n';
    len += 4;
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d\n", __FUNCTION__,
      state, buf, bytes, len);
#endif

  return len;
}

// Buffer for ASCII output lines.
// Size is set by max length of ASCII listdev:
//
//     DEV_NAME "\t" MODE "\t" OFFSET "\t" SIZE "\t" TYPE "\n"
//       255     1    1    1     8     1     8   1    2    1
static uint8_t line_buf[256+2+9+9+3];

// Buffer for SPI Flash transfer
// Size is set by TFTP max filename
#define SPI_BUF_LEN TFTP_MAX_FILENAME_LEN
static uint8_t spi_buf[SPI_BUF_LEN];

static
int
casper_tapcp_read_listdev_ascii(
    struct tapcp_state *state, void *buf, int bytes)
{
  // We don't know how long our lines will be so we unpack and buffer them
  // locally (in a static buffer) before sending them.  Since we have to fill
  // the output buffer completely except to signal end of data, we will often
  // have to split lines across two calls.
  //
  // state->ptr points to the core_info CSL
  // state->lidx stores the number of line_buf bytes already output, zero if
  // there is no pending line, or -1 if this is the first line.

  uint8_t *plb;
  const uint8_t *name;
  const uint8_t *payload;
  int len = 0;
  uint32_t n;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->lidx);
#endif

  // If first line
  if(state->lidx == -1) {
    csl_iter_init(state->ptr);
    state->lidx = 0;
  }

  while(len < bytes) {
    // If need to start a new line
    if(state->lidx == 0) {
      // If no more entries
      if(!(payload = csl_iter_next(&name))) {
        // All done!
        return len;
      }

      // Init
      plb = line_buf;
      // Copy name up to, but not including, terminating NUL
      for(n=0; name[n]; n++) {
        *plb++ = name[n];
      }
      *plb++ = '\t';
      // Read offset
      n  = (*payload++ & 0xff) << 24;
      n |= (*payload++ & 0xff) << 16;
      n |= (*payload++ & 0xff) <<  8;
      n |= (*payload++ & 0xff);
      // Output mode to buffer
      *plb++ = (n&1) ? '1' : '3';
      *plb++ = '\t';
      // Output offset (masking off two LSbs) to buffer
      plb = u32_to_hex(n & ~3, plb, 0);
      *plb++ = '\t';
      // Read length
      n  = (*payload++ & 0xff) << 24;
      n |= (*payload++ & 0xff) << 16;
      n |= (*payload++ & 0xff) <<  8;
      n |= (*payload++ & 0xff);
      // Output length to buffer
      plb = u32_to_hex(n, plb, 0);
      *plb++ = '\t';
      // Read and output type to buffer
      plb = u32_to_hex(*payload, plb, 0);
      *plb++ = '\n';
    }

    // Copy data to output buf
    plb = line_buf + state->lidx;
    while(len < bytes) {
      // Copy byte
      *(uint8_t *)buf++ = *plb;
      // Increment len
      len++;
      // If end of line
      if(*plb == '\n') {
        state->lidx = 0;
        break;
      } else {
        state->lidx++;
      }
      plb++;
    }
  }

  return len;
}

// Reads bytes from flash address state->ptr
// Either read len=bytes, or state->nleft, if this is less than bytes
static
int
casper_tapcp_read_flash_bytes_binary(
    struct tapcp_state *state, void *buf, int bytes)
{
  int len = 0;
  len = state->nleft > bytes ? bytes : state->nleft;
  // if len=0 then just return
  if(!len){
    return len;
  }
  len = flash_read((uint32_t)state->ptr, (uint8_t *)buf, len);
  state->nleft -= len;
  state->ptr += len*(sizeof(uint8_t));

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->nleft);
#endif

  return len;
}

// Sends bytes from state->ptr until len == bytes or state->nleft == 0.
static
int
casper_tapcp_read_mem_bytes_binary(
    struct tapcp_state *state, void *buf, int bytes)
{
  int len = 0;
  while(len < bytes && state->nleft > 0) {
    *(uint8_t *)buf++ = *(uint8_t *)state->ptr++;
    state->nleft--;
    len++;
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->nleft);
#endif

  return len;
}

// This command outputs a simple ASCII hex dump, 8 digit label followed by
// colon and then 16 bytes per line arranged as four groups of four bytes each:
//
//     00000000: 01234567 89ABCDEF 01234567 89ABCDEF
//     00000010: 12345678 9ABCDEF0 12345678 9ABCDEF0
//     00000020: 23456789 ABCDEF01 23456789 ABCDEF01
//     [...]
static
int
casper_tapcp_read_mem_bytes_ascii(
    struct tapcp_state *state, void *buf, int bytes)
{
  // state->ptr is pointer to next byte
  // state->lindex is index of next line_buf byte to send
  // state->nleft is number of bytes left to retrieve from memory
  // state->u32 is value for label of next line

  int i;
  int len = 0;
  uint8_t *plb;

  while(len < bytes && state->nleft > 0) {
    // If need to start a new line
    if(state->lidx == 0) {
      // Init with label
      plb = u32_to_hex(state->u32, line_buf, 1);
      state->u32 += 16;
      *plb++ = ':';
      *plb++ = ' ';
      // Loop to read up to 16 bytes for the line
      for(i=0; i<16; i++) {
        plb = u8_to_hex(*(uint32_t *)state->ptr++, plb, 0x11);
        state->nleft--;
        if((i & 3) == 3 && i != 15) {
          *plb++ = ' ';
        }
        // All done?
        if(state->nleft == 0) {
          break;
        }
      }
      // Terminate line
      *plb++ = '\n';
    }

    // Copy data to buf
    plb = line_buf + state->lidx;
    while(len < bytes) {
      // Copy byte
      *(uint8_t *)buf++ = *plb;
      // Increment len
      len++;
      // If end of line
      if(*plb == '\n') {
        state->lidx = 0;
        break;
      } else {
        state->lidx++;
      }
      plb++;
    }
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->nleft);
#endif

  return len;
}

// Sends FPGA words from state->ptr until len == bytes or state->nleft == 0.
// This is distinct from `..._read_mem_bytes_binary` because reads from FPGA
// devices are always word aligned so we can read a word at a time and because
// the wishbone bus currently byte swaps the 32 bit data for us so we need to
// undo this byte swap.
static
int
casper_tapcp_read_fpga_words_binary(
    struct tapcp_state *state, void *buf, int bytes)
{
  static uint32_t word = 0;
  int len = 0;

  while(len < bytes && state->nleft > 0) {
    switch(--state->nleft & 3) {
      case 3: word = *(uint32_t *)state->ptr; // Read next word to send
              state->ptr += sizeof(uint32_t); // Advance pointer
              *(uint8_t *)buf++ = (word >> 24) & 0xff; break;
      case 2: *(uint8_t *)buf++ = (word >> 16) & 0xff; break;
      case 1: *(uint8_t *)buf++ = (word >>  8) & 0xff; break;
      case 0: *(uint8_t *)buf++ = (word      ) & 0xff; break;
    }
    len++;
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->nleft);
#endif

  return len;
}

// This command outputs a simple ASCII hex dump, 8 digit label followed by
// colon and then 16 bytes per line arranged as four groups of four bytes each:
//
//     00000000: 01234567 89ABCDEF 01234567 89ABCDEF
//     00000010: 12345678 9ABCDEF0 12345678 9ABCDEF0
//     00000020: 23456789 ABCDEF01 23456789 ABCDEF01
//     [...]
static
int
casper_tapcp_read_fpga_words_ascii(
    struct tapcp_state *state, void *buf, int bytes)
{
  // state->ptr is pointer to next FPGA word
  // state->lindex is index of next line_buf byte to send
  // state->nleft is number of bytes left to retrieve from FPGA
  // state->u32 is value for label of next line

  int i;
  int len = 0;
  uint8_t *plb;
  uint32_t word;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->lidx);
#endif

  while(len < bytes && state->nleft > 0) {
    // If need to start a new line
    if(state->lidx == 0) {
      // Init with label
      plb = u32_to_hex(state->u32, line_buf, 1);
      state->u32 += 16;
      *plb++ = ':';
      *plb++ = ' ';
      // Loop to read up to four words for the line
      for(i=0; i<4; i++) {
        word = *(uint32_t *)state->ptr;
        state->ptr += sizeof(uint32_t);
        state->nleft -= sizeof(uint32_t);
        if(i > 0) {
          *plb++ = ' ';
        }
        plb = u32_to_hex(word, plb, 1);
        // All done?
        if(state->nleft == 0) {
          break;
        }
      }
      // Terminate line
      *plb++ = '\n';
    }

    // Copy data to buf
    plb = line_buf + state->lidx;
    while(len < bytes) {
      // Copy byte
      *(uint8_t *)buf++ = *plb;
      // Increment len
      len++;
      // If end of line
      if(*plb == '\n') {
        state->lidx = 0;
        break;
      } else {
        state->lidx++;
      }
      plb++;
    }
  }

  return len;
}

// Reads data bytes from flash and sends it back in binary form
static
int
casper_tapcp_read_flashcmd_binary(
    struct tapcp_state *state, void *buf, int bytes)
{
  // state->ptr is pointer to next spi_buf byte to send
  // state->nleft is total number of bytes left to send to client
  // state->u32 is number of bytes left in spi_buf to send back
  int len = 0;
  int n;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) [%d/%d]\n", __FUNCTION__,
      state, buf, bytes, state->u32, state->nleft);
#endif

  // While any bytes left in spi_buf and buf is not full
  while(state->u32 && bytes) {
    // Send as many as we can: n = min(bytes, state->u32)
    n = bytes < state->u32 ? bytes : state->u32;
    memcpy(buf, state->ptr, n);
    len += n;
    buf += n;
    state->ptr += n;
    bytes -= n;
    state->u32 -= n;
    state->nleft -= n;

    // If spi_buf is empty and there are more bytes to send
    if(!state->u32 && state->nleft) {
      // Get more bytes from flash: state->u32 = min(state->nleft, SPI_BUF_LEN)
      state->u32 = state->nleft < SPI_BUF_LEN ? state->nleft : SPI_BUF_LEN;
      send_spi(spi_buf, spi_buf, state->u32, SEND_SPI_MORE);
      state->ptr = spi_buf;
    }
  }

  // If all done
  if(len < bytes) {
    // Close SPI transaction
    send_spi(NULL, NULL, 0, 0);
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->nleft);
#endif

  return len;
}

#if 0
// Reads data bytes from flash and sends it back in ascii form
// This command outputs a simple ASCII hex dump, 8 digit label followed by
// colon and then 16 bytes per line arranged as four groups of four bytes each:
//
//     00000000: 01234567 89ABCDEF 01234567 89ABCDEF
//     00000010: 12345678 9ABCDEF0 12345678 9ABCDEF0
//     00000020: 23456789 ABCDEF01 23456789 ABCDEF01
//     [...]
static
int
casper_tapcp_read_flashcmd_ascii(
    struct tapcp_state *state, void *buf, int bytes)
{
  // state->ptr is pointer to next byte
  // state->lindex is index of next line_buf byte to send
  // state->nleft is number of bytes left to retrieve from memory
  // state->u32 is value for label of next line

  int i;
  int len = 0;
  uint8_t *plb;

  while(len < bytes && state->nleft > 0) {
    // If need to start a new line
    if(state->lidx == 0) {
      // Init with label
      plb = u32_to_hex(state->u32, line_buf, 1);
      state->u32 += 16;
      *plb++ = ':';
      *plb++ = ' ';
      // Loop to read up to 16 bytes for the line
      for(i=0; i<16; i++) {
        plb = u8_to_hex(*(uint32_t *)state->ptr++, plb, 0x11);
        state->nleft--;
        if((i & 3) == 3 && i != 15) {
          *plb++ = ' ';
        }
        // All done?
        if(state->nleft == 0) {
          break;
        }
      }
      // Terminate line
      *plb++ = '\n';
    }

    // Copy data to buf
    plb = line_buf + state->lidx;
    while(len < bytes) {
      // Copy byte
      *(uint8_t *)buf++ = *plb;
      // Increment len
      len++;
      // If end of line
      if(*plb == '\n') {
        state->lidx = 0;
        break;
      } else {
        state->lidx++;
      }
      plb++;
    }
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->nleft);
#endif

  return len;
}
#endif

// Write helpers
// Reads bytes from pbuf and writes them to Flash.
// Flash sector erases are performed as needed as the write progresses
// Writes are sent to the SPI chip in 4-byte chunks, and executed when
// a full page of writes is complete.
// It is assumed that the FLASH_SECTOR_SIZE is a multiple of FLASH_PAGE_SIZE
static
int
casper_tapcp_write_flash_words_binary(
    struct tapcp_state *state, struct pbuf *pbuf)
{
  // state->ptr is offset address in bytes of flash entry point
  // state->u32 is number of bytes already written

  uint8_t *p;
  int len = 0;
  int tot_len = 0;
  uint8_t page[FLASH_PAGE_SIZE];
  int words_left = 0;

  // While we have pbufs
  while(pbuf) {
    // Copy pbuf payload data
    p = pbuf->payload;
    for(len = 0; len < pbuf->len; len++) {
      // If we are in a new flash sector, erase it
      if ((((uint32_t)state->ptr) % FLASH_SECTOR_SIZE) == 0) {
        flash_erase_sector((uint32_t)state->ptr);
      }
      // Read byte into word
      page[state->u32 % FLASH_PAGE_SIZE] = *p++;
      state->ptr += sizeof(uint8_t);
      // If word is full, write it to flash
      if((++state->u32 % FLASH_PAGE_SIZE) == 0) {
        flash_write_page(((uint32_t)state->ptr) - FLASH_PAGE_SIZE, page, FLASH_PAGE_SIZE);
      }
    }

    // If last pbuf in chain
    if(pbuf->tot_len <= pbuf->len) {
      break;
    }

    // Setup for next pbuf, if any
    pbuf = pbuf->next;
  }

  // If we've done all the pbufs, but haven't ended on a complete page. Write what we have.
  // The remainder of that page will be garbage (or rather, will be a copy of the end of the
  // previous page.
  words_left = state->u32 % FLASH_PAGE_SIZE;
  if(words_left) {
    flash_write_page(((uint32_t)state->ptr) - words_left, page, FLASH_PAGE_SIZE);
  }


#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, [%u/%u]) = %d\n", __FUNCTION__,
      state, pbuf, pbuf->len, pbuf->tot_len, tot_len);
#endif

  return tot_len;
}

// Reads bytes from pbuf and writes them to FPGA.
// Writes to CPU memory are disallowed as too dangerous.
static
int
casper_tapcp_write_fpga_words_binary(
    struct tapcp_state *state, struct pbuf *pbuf)
{
  // state->ptr is pointer to next FPGA word
  // state->nleft, if non-negative, is max number of bytes allowed to write
  // state->u32 is number of bytes already written

  uint8_t *p;
  int len = 0;
  int tot_len = 0;
  static uint32_t word;

  // While we have pbufs
  while(pbuf) {

    // Copy pbuf payload data
    p = pbuf->payload;
    for(len = 0; len < pbuf->len; len++) {
      // If we have a bound on how many bytes to write,
      // make sure we are not about to exceed it.
      if(state->nleft == 0) {
        return -1; // Error!
      }
      // Read byte into word
      word <<= 8;
      word |= *p++ & 0xff;
      // If word is full, write it to FPGA
      if((++state->u32 & 3) == 0) {
        *(uint32_t *)state->ptr = word;
        state->ptr += sizeof(uint32_t);
      }
      // Decrement nleft, if positive
      if(state->nleft > 0) {
        state->nleft--;
      }
    }

    // If last pbuf in chain
    if(pbuf->tot_len <= pbuf->len) {
      break;
    }

    // Setup for next pbuf, if any
    pbuf = pbuf->next;
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, [%u/%u]) = %d\n", __FUNCTION__,
      state, pbuf, pbuf->len, pbuf->tot_len, tot_len);
#endif

  return tot_len;
}

// Reads 4 bytes from pbuf and interprets as a flash address
// from which to reprogram the FPGA
static
int
casper_tapcp_write_progdev(
    struct tapcp_state *state, struct pbuf *pbuf)
{

  uint8_t *p;
  int len = 0;
  static uint32_t word;
  uint32_t curr_ms, next_ms = 0;

  if(!state->binary) {
    return -1; // Ascii mode not implemented
  }

  if(!pbuf) {
    return -1; // No pbuf!
  }

  if(pbuf->len != 4) {
    return -1; // Error!
  }

  // Copy pbuf payload data
  p = pbuf->payload;
  for(len = 0; len < pbuf->len; len++) {
    // Read byte into word
    word <<= 8;
    word |= *p++ & 0xff;
  }

  // Reboot the FPGA using the received value as the target address
  xil_printf("Reboot from addr: %08x\n", word);
  // Sleep here, or the print will never make it out the UART
  curr_ms = ms_tmrctr();
  while(next_ms <= (curr_ms + 1000)) {
      next_ms = ms_tmrctr();
  }
  icap_reprog_from_flash(word);
  // We'll never get here...
  return len;
}

// Reads hex formatted text from pbuf and writes them to FPGA.
// Writes to CPU memory are disallowed as too dangerous.
static
int
casper_tapcp_write_fpga_words_ascii(
    struct tapcp_state *state, struct pbuf *pbuf)
{
  // state->ptr is pointer to next FPGA word
  // state->nleft, if non-negative, is max number of bytes allowed to write
  // state->lidx is index of next line_buf location
  // state->u32 is a flag that is set on a line's first colon

  uint8_t c;
  uint8_t *p;
  uint8_t *plb = line_buf + state->lidx;
  int len = 0;
  int tot_len = 0;
  static uint32_t word;

  // While we have pbufs
  while(pbuf) {

    // Copy pbuf payload data into line_buf
    p = pbuf->payload;
    for(len = 0; len < pbuf->len; len++) {
      // Make sure we don't overflow line_buf
      if(state->lidx >= sizeof(line_buf)) {
        return -1; // Error!
      }
      // Get byte from pbuf
      c = *p++;
      // If leading white space, ignore
      if(state->lidx == 0 && isspace(c)) {
        continue;
      }
      // If first colon (label terminator), just reset plb and lidx
      if(c == ':' && !state->u32) {
        plb = line_buf;
        state->lidx = 0;
        state->u32 = 1;
        continue;
      }
      // Store in line_buf
      *plb++ = c;
      state->lidx++;
      // If newline, process line
      if(c == '\n') {
#ifdef VERBOSE_TAPCP_IMPL
        // NUL terminate
        *--plb = '\0';
        print(__FUNCTION__);
        print(" got line: ");
        print((char *)line_buf);
        print("\n");
        *plb++ = '\n';
#endif
        // Start at beginning and go until newline
        plb = line_buf;
        while(*plb != '\n') {
          // Skip whitespace
          if(isspace(*plb)) {
            plb++;
            continue;
          }
          // If not a hex digit, done with line
          if(!isxdigit(*plb)) {
            break;
          }
          // Parse possibly contiguous words
          while(isxdigit(*plb)) {
            // If we have a bound on how many bytes to write,
            // make sure we are not about to exceed it.
            if(0 <= state->nleft && state->nleft < 4) {
              return -1; // Error!
            }
            // Get word value
            plb = hex_to_u32(plb, &word);
#ifdef VERBOSE_TAPCP_IMPL
        xil_printf("%s: got word %08x\n", __FUNCTION__, word);
#endif
            // Write word to FPGA
            *(uint32_t *)state->ptr = word;
            state->ptr += sizeof(uint32_t);
            // Decrement nleft, if positive
            if(state->nleft > 0) {
              state->nleft -= sizeof(uint32_t);
            }
          }
        } // End of line
        // Setup for next line
        state->lidx = 0;
        state->u32 = 0;
      } // line processed
    } // pbuf processed

    // If last pbuf in chain
    if(pbuf->tot_len <= pbuf->len) {
      break;
    }

    // Setup for next pbuf, if any
    pbuf = pbuf->next;
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, [%u/%u]) = %d\n", __FUNCTION__,
      state, pbuf, pbuf->len, pbuf->tot_len, tot_len);
#endif

  return tot_len;
}

// Open helpers
void *
casper_tapcp_open_help(struct tapcp_state *state)
{
  // Setup tapcp state
  state->ptr = tapcp_help_msg;
  state->nleft = sizeof(tapcp_help_msg) - 1;
  set_tftp_read((tftp_read_f)casper_tapcp_read_help);
  return state;
}

void *
casper_tapcp_open_temp(struct tapcp_state *state)
{
  // Setup tapcp state
  set_tftp_read((tftp_read_f)casper_tapcp_read_temp);
  return state;
}

void *
casper_tapcp_open_listdev(struct tapcp_state *state)
{
  // Setup tapcp state
  if(state->binary) {
    // Binary outout includes the CSL length
    state->ptr = (void *)(CORE_INFO - 2);
    state->nleft = Xil_Ntohs(_core_info_size_be) + 2;
    set_tftp_read((tftp_read_f)casper_tapcp_read_mem_bytes_binary);
  } else {
    state->ptr = (void *)CORE_INFO;
    state->lidx = -1;
    set_tftp_read((tftp_read_f)casper_tapcp_read_listdev_ascii);
  }
  return state;
}

void *
casper_tapcp_open_progdev(struct tapcp_state *state) {
  set_tftp_write((tftp_write_f)casper_tapcp_write_progdev);
  return state;
}

void *
casper_tapcp_open_flash(struct tapcp_state *state, const char *fname)
{
  uint8_t *p = NULL;
  uint32_t cmd_off = 0; // From command line
  uint32_t cmd_len = 0; // From command line

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s fname '%s'\n", __FUNCTION__, fname);
#endif

  // Only allow binary operations
  if(!state->binary) {
    return NULL;
  }

  // advance past leading "/flash."
  // We must have already checked the string starts with "/flash." before calling
  // this function
  fname += strlen("/flash.");

  // Parse "command line"

  p = (uint8_t *)fname;
  // Offset is required
  if(!*p) {
    return NULL;
  }

  // Read hex value into cmd_off
  p = hex_to_u32(p, &cmd_off);
  //xil_printf("offset: %d\n", cmd_off);
  // If reading and not at end of string
  // (ignore client supplied length on writes)
  if(!state->write && *p) {
    // Read length info cmd_len
    p = hex_to_u32(++p, &cmd_len);
    //xil_printf("len: %d\n", cmd_len);
  }

  // convert words to bytes
  cmd_off = cmd_off << 2;
  cmd_len = cmd_len << 2;

  // If a write command, the offset should be at the start of a sector
  if(state->write) {
    if ((cmd_off % FLASH_SECTOR_SIZE) != 0) {
      return NULL;
    }
  }

  // Pointer value is offset in flash memory
  state->ptr = (void *)cmd_off;
  // nleft is a byte count
  state->nleft = cmd_len;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("ptr=%p nleft=%u\n", state->ptr, state->nleft);
#endif

  // Only allow binary transactions
  if(!state->write) {
    set_tftp_read((tftp_read_f)casper_tapcp_read_flash_bytes_binary);
  } else {
    state->u32 = 0; //used to track words written
    set_tftp_write((tftp_write_f)casper_tapcp_write_flash_words_binary);
  }

  return state;
}

void *
casper_tapcp_open_dev(struct tapcp_state *state, const char *fname)
{
  uint8_t *p = NULL;
#if 1 // TODO
#else
  uint8_t i;
  const uint8_t *cip = NULL; // core_info payload
  uint32_t fpga_off  = 0; // From core_info
  uint32_t fpga_len  = 0; // From core_info
#endif
  struct casper_dev_info dev_info;
  uint32_t cmd_off = 0; // From command line
  uint32_t cmd_len = 0; // From command line

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s fname '%s'\n", __FUNCTION__, fname);
#endif

  // Parse "command line"
  //
  // Advance fname past leading "/dev/", if present
  if(!strncmp("/dev/", fname, strlen("/dev/"))) {
    fname += strlen("/dev/");
  }
  // Look for dot
  p = (uint8_t *)strchr(fname, '.');
  if(p) {
    // NUL terminate fname (violate const, temporarily)
    *p = '\0';
  }

  // Look for device
  state->ptr = casper_find_dev(fname, &dev_info);

  if(p) {
    // Restore dot (and const-ness) and advance p
    *p++ = '.';
  }

  // If device not found, return error
  if(!state->ptr) {
#ifdef VERBOSE_TAPCP_IMPL
    xil_printf("did not find device in core info\n");
#endif
    return NULL;
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("dev_off=%p dev_len=%x\n", dev_info.offset, dev_info.length);
#endif

  // Disallow writes to read only devices
  if(state->write && (dev_info.offset & 1)) {
    return NULL;
  }

  // If dot was found and characters follow, parse offset (and length)
  if(p && *p) {
    // Read hex value into cmd_off
    p = hex_to_u32(p, &cmd_off);
    // If reading and not at end of string
    // (ignore client supplied length on writes)
    if(!state->write && *p) {
      // Read length info cmd_len
      p = hex_to_u32(++p, &cmd_len);
    }
  }

  // Zero or not given length means all of it starting from cmd_offset
  if(cmd_len == 0) {
    cmd_len = (dev_info.length >> 2) - cmd_off;
    // If nothing left after cmd_offset
    if(cmd_len == 0) {
#ifdef VERBOSE_TAPCP_IMPL
      xil_printf("request too short\n");
#endif
      return NULL;
    }
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("cmd_off=%p cmd_len=%x\n", cmd_off, cmd_len);
#endif

  // Bounds check on reads only
  if(!state->write && cmd_off + cmd_len > (dev_info.length >> 2)) {
#ifdef VERBOSE_TAPCP_IMPL
    xil_printf("request too long\n");
#endif
    return NULL;
  }

  // Add cmd_off to device pointer
  state->ptr += cmd_off << 2;
  // nleft is a byte count
  state->nleft = cmd_len << 2;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("ptr=%p nleft=%u\n", state->ptr, state->nleft);
#endif

  if(!state->write) {
    if(state->binary) {
      set_tftp_read((tftp_read_f)casper_tapcp_read_fpga_words_binary);
    } else {
      state->lidx = 0;
      state->u32 = 0; // Used for line labels
      set_tftp_read((tftp_read_f)casper_tapcp_read_fpga_words_ascii);
    }
  } else { // Already disallowed dev writes to read-only devices above
    if(state->binary) {
      state->u32 = 0; // Used to track total bytes written
      set_tftp_write((tftp_write_f)casper_tapcp_write_fpga_words_binary);
    } else {
      state->lidx = 0;
      state->u32 = 0; // Used to detect line labels
      set_tftp_write((tftp_write_f)casper_tapcp_write_fpga_words_ascii);
    }
  }

  return state;
}

// Used to open `fpga` or `cpu` requests.  The `baseaddr` parameter should be
// FPGA_BASEADDR for `fpga` requests and CPU_BASEADDR or `cpu` requests.
// Likewise, the `nbytes` parameter should be FPGA_NBYTES or CPU_NBYTES, resp.
void *
casper_tapcp_open_mem(
    struct tapcp_state *state,
    const char *fname)
{
  uint8_t *p;
  uint32_t cmd_off = 0; // From command line
  uint32_t cmd_len = 1; // From command line
  uint32_t baseaddr = 0;
  uint32_t nbytes = 0;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s fname='%s'\n", __FUNCTION__, fname);
#endif

  // Advance fname past leading "/fpga." or "/cpu."
  if(!strncmp("/fpga.", fname, strlen("/fpga."))) {
    fname += strlen("/fpga.");
    baseaddr = FPGA_BASEADDR;
    nbytes = FPGA_NBYTES;
  // Only allow cpu read access
  } else if(!state->write && !strncmp("/cpu.", fname, strlen("/cpu."))) {
    fname += strlen("/cpu.");
  } else {
    return NULL;
  }
  // Parse "command line"
  p = (uint8_t *)fname;
  // Offset is required
  if(!*p) {
    return NULL;
  }
  // Read hex value into cmd_off
  p = hex_to_u32(p, &cmd_off);
  // If reading and not at end of string
  // (ignore client supplied length on writes)
  if(!state->write && *p) {
    // Read hex value into cmd_len
    p = hex_to_u32(++p, &cmd_len);
  }
  // Word align the input
  cmd_off &= ~3; // align cmd_off downward
  cmd_len +=  3; // align cmd_len upward
  cmd_len &= ~3;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("cmd_off=%p cmd_len=%x\n", cmd_off, cmd_len);
#endif

  // Bounds check on read only
  //
  if(!state->write) {
    if(cmd_len == 0) {
#ifdef VERBOSE_TAPCP_IMPL
      xil_printf("request too short\n");
#endif
      return NULL;
    }
    // Only bounds check for long FPGA reads.
    // Let CPU requests wrap around.
    if(baseaddr == FPGA_BASEADDR && cmd_off + cmd_len > nbytes) {
#ifdef VERBOSE_TAPCP_IMPL
      xil_printf("request too long\n");
#endif
      return NULL;
    }
  }

  // Setup tapcp state
  // Treat all terms as ints, then cast result to pointer.
  state->ptr = (void *)(baseaddr + cmd_off);
  // nleft is a byte count.  On reads, use client specified (or default)
  // length.  On writes (fpga only!), nleft is an upper bound on how many bytes
  // are permitted to be written.
  state->nleft = state->write ? FPGA_NBYTES - cmd_off : cmd_len;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("ptr=%p nleft=%u\n", state->ptr, state->nleft);
#endif

  if(!state->write) {
    if(baseaddr == FPGA_BASEADDR) {
      if(state->binary) {
        set_tftp_read((tftp_read_f)casper_tapcp_read_fpga_words_binary);
      } else {
        state->lidx = 0;
        state->u32 = 0; // Used for line labels
        set_tftp_read((tftp_read_f)casper_tapcp_read_fpga_words_ascii);
      }
    } else {
      if(state->binary) {
        set_tftp_read((tftp_read_f)casper_tapcp_read_mem_bytes_binary);
      } else {
        state->lidx = 0;
        state->u32 = 0; // Used for line labels
        set_tftp_read((tftp_read_f)casper_tapcp_read_mem_bytes_ascii);
      }
    }
  } else { // Already disallowed writes to CPU memory above
    if(state->binary) {
      state->u32 = 0; // Used to track total bytes written
      set_tftp_write((tftp_write_f)casper_tapcp_write_fpga_words_binary);
    } else {
      state->lidx = 0;
      state->u32 = 0; // Used to detect line labels
      set_tftp_write((tftp_write_f)casper_tapcp_write_fpga_words_ascii);
    }
  }

  return state;
}

// Used to open `flash` requests.
void *
casper_tapcp_open_flashcmd(
    struct tapcp_state *state,
    const char *fname)
{
  uint8_t *p;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s fname '%s'\n", __FUNCTION__, fname);
#endif

  // TODO
  if(state->write) {
    return NULL;
  }

  // Parse "command line"
  //
  // Advance fname past leading "/flashcmd.", if present
  if(!strncmp("/flashcmd.", fname, strlen("/flashcmd."))) {
    fname += strlen("/flashcmd.");
  }

  // Walk p through parameters
  p = (uint8_t *)fname;
  // If reading, get LEN in state->nleft.
  if(!state->write) {
    p = hex_to_u32(p, (uint32_t *)&state->nleft);
    // If delimited by another dot, advance past it
    if(*p == '.') {
      p++;
    }
  }
  // Save CMD length (in binary bytes, not hex digits) to state->u32
  // Note that this is strictly command/opcode plus any address/dummy/data
  // bytes; it does not include any of the optional 4 bytes for read length.
  state->u32 = strlen((char *)p) >> 1;
  // If reading
  if(!state->write) {
    // Increment nleft by CMD byte count
    state->nleft += state->u32;
  }
  // Convert CMD hex digits to bytes in the spi_buf
  // (an odd trailing digit will be ignored)
  hex_to_u8(p, spi_buf, state->u32);
  // Send to SPI device, results stored in place
  send_spi(spi_buf, spi_buf, state->u32, SEND_SPI_MORE);
  // Set state->ptr to first byte of spi_buf
  state->ptr = spi_buf;

  // Set read/write function for data transfer
  if(!state->write) {
    if(state->binary) {
      set_tftp_read((tftp_read_f)casper_tapcp_read_flashcmd_binary);
    } else {
#if 0
      set_tftp_read((tftp_read_f)casper_tapcp_read_flashcmd_ascii);
#else
      send_spi(NULL, NULL, 0, 0);
      return NULL;
#endif
    }
  } else {
    // TODO
    send_spi(NULL, NULL, 0, 0);
    return NULL;
  }

  return state;
}
