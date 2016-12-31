// casper_tapcp.c - CASPER TAPCP server implementation.
//
// TAPCP is an acronym for "TFTP Access for Program and Control Protocol".
//
// A CASPER TAPCP server is a TFTP server that exposes various aspects of its
// memory space and other services to TFTP clients.  This is done by mapping
// the memory and other services into a virtual filesystem that is amenable to
// access via the TFTP protocol.  TFTP provides two main operations: "get" and
// "put".  A "get" operation is invoked by the client to read data from the
// server.  A "put" operation is invoked to write data to the server.  Each
// operation can be performed in one of two modes: "netascii" (aka "ascii" aka
// "text") or "octet" (aka "binary").  TAPCP uses these modes to determine how
// to interpret data being sent by the client (for a put operation) and how to
// format data being sent to a client (for a get operation).
//
// The CASPER TAPCP virtual filesystem appears as a hierarchical filesystem.
// The top level of this virtual filesystem can be considered a command name.
// Some commands accept additional parameters that are given as hierarchical
// pathname components.  The data being read or written is transferred as the
// contents of the virtual file.
//
// Supported commands are (or will eventually be):
//
//   - `help` [RO] Returns a list of top level commands.  Format is the same
//     regardless of file transfer mode [TODO Do we want to send CRLF line
//     terminators in netascii mode?].
//
//   - `listdev` [RO] Lists all devices supported by the currently running
//     gateware design.  The offset, length, and type of each device is
//     included in this listing.  In netascii mode this listing is returned as
//     a human readable table.  In octet mode this listing is returned in the
//     binary compressed/compiled form that is stored in memory.
//
//   - `temp` [RO] Sends the temperature of the FPGA.  In ascii mode this
//     returns the temperature rounded down to the nearest tenth of a degree C.
//     In binary mode this returns a 4 byte single precision float in network
//     byte order (big endian).
//
//   - `dev/DEV_NAME[/WORD_OFFSET[/NWORDS]]`  Accesses memory associated with
//     gateware device `DEV_NAME`.  `WORD_OFFSET` and `NWORDS`, when given, are
//     in hexadecimal.  `WORD_OFFSET` is in 4-byte words and defaults to 0.
//     `NWORDS` is a count of 4-byte words to read and defaults to 0, meaning
//     read all words from `WORD_OFFSET` to end of the given device's memory.
//     `NWORDS` is ignored on writes because the amount of data written is
//     determined by the amount of data sent by the client.
//
//   - `fpga/WORD_OFFSET[/NWORDS]]`  Accesses memory in the FPGA gateware (i.e.
//     AXI/Wishbone) address space.  `WORD_OFFSET` and `NWORDS`, when given,
//     are in hexadecimal.  `WORD_OFFSET` is in 4-byte words.  `NWORDS` is a
//     count of 4-byte words to read and defaults to 1.  `NWORDS` is ignored on
//     writes because the amount of data written is determined by the amount of
//     data sent by the client.
//
//   - `cpu/BYTE_ADDR[/NBYTES]]` [RO] Accesses memory in the CPU address space.
//     `BYTE_ADDR` and `NBYTES`, when given, are in hexadecimal.  `BYTE_ADDR`
//     is a byte address.  `NBYTES` is a count of bytes to read and defaults to
//     1.  `NBYTES` is ignored on writes because the amount of data written is
//     determined by the amount of data sent by the client.
//
//   - `progdev/[TBD]`  A future command will be added to allow uploading a new
//     bitstream.  The exact details are under development.
//
//   - `flash/[TBD]` A future command will be added to access the FLASH device
//     attached to the FPGA.
//
// The `help`, `listdev`, `temp`, and `cpu` commands are read-only and can only
// be used with "get" operations.  Trying to "put" to them will result in an
// error being returned to the client.
//
// Reading with the `dev`, `fpga`, and `mem` commands in netascii mode will
// return data in a hex dump like format (i.e. suitable for display in a
// terminal).  Reading with these commands in octet mode will return the
// requested data in binary form in network byte order (big endian).
//
// A leading slash is not required and will be ignored if provided.

#include <ctype.h>
#include "xil_io.h"
#include "platform.h"
#include "lwip/apps/tftp_server.h"
#include "casper_tftp.h"
#include "casper_tapcp.h"
#include "csl.h"

// Help message
static char tapcp_help_msg[] =
"Available commands:\n"
"  help    - this message\n"
"  listdev - list FPGA device info\n"
"  temp    - get FPGA temperature\n"
"  dev/DEVNAME[/OFFSET[/LENGTH]] - access DEVNAME\n"
"  fpga/OFFSET[/LENGTH] - access FPGA memory space\n"
"  cpu/OFFSET[/LENGTH]  - access CPU memory space\n"
;

// Externally linked core_info data
extern const uint16_t _core_info_size_be;
extern const uint8_t _core_info;
#define CORE_INFO (&_core_info)

// Utility functions

// Convert ASCII hex digits to uint32_t.
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
  // state->lidx stores the number of line_buf bytes already output, zero if
  // there is no pending line, or -1 if this is the first line.  state->ptr
  // points to the next core info entry.

  uint8_t *plb;
  int len = 0;
  uint32_t n;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->lidx);
#endif

  while(len < bytes) {
    // If need to start a new line
    if(state->lidx <= 0) {
      // Init
      plb = line_buf;
      // If not first line, reuse characters
      if(state->lidx == 0) {
        plb += *(uint8_t *)state->ptr;
      }
      state->ptr++;
      state->lidx = 0;
      // Get tail length
      n = *(uint8_t *)state->ptr++;
      // If tail is 0, all done!
      if(n == 0) {
        return len;
      }
      // Copy tail
      memcpy(plb, state->ptr, n);
      state->ptr += n;
      plb += n;
      *plb++ = '\t';
      // Read offset
      n  = (*(uint8_t *)state->ptr++ & 0xff) << 24;
      n |= (*(uint8_t *)state->ptr++ & 0xff) << 16;
      n |= (*(uint8_t *)state->ptr++ & 0xff) <<  8;
      n |= (*(uint8_t *)state->ptr++ & 0xff);
      // Output mode to buffer
      *plb++ = (n&1) ? '1' : '3';
      *plb++ = '\t';
      // Output offset (masking off two LSbs) to buffer
      plb = u32_to_hex(n & ~3, plb, 0);
      *plb++ = '\t';
      // Read length
      n  = (*(uint8_t *)state->ptr++ & 0xff) << 24;
      n |= (*(uint8_t *)state->ptr++ & 0xff) << 16;
      n |= (*(uint8_t *)state->ptr++ & 0xff) <<  8;
      n |= (*(uint8_t *)state->ptr++ & 0xff);
      // Output length to buffer
      plb = u32_to_hex(n, plb, 0);
      *plb++ = '\t';
      // Read and output type to buffer
      plb = u32_to_hex(*(uint8_t *)state->ptr++, plb, 0);
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
    switch(state->nleft & 3) {
      case 0: word = *(uint32_t *)state->ptr; // Read next word to send
              state->ptr += sizeof(uint32_t); // Advance pointer
              *(uint8_t *)buf++ = (word >> 24) & 0xff; break;
      case 3: *(uint8_t *)buf++ = (word >> 16) & 0xff; break;
      case 2: *(uint8_t *)buf++ = (word >>  8) & 0xff; break;
      case 1: *(uint8_t *)buf++ = (word      ) & 0xff; break;
    }
    state->nleft--;
    len++;
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s(%p, %p, %d) = %d/%d\n", __FUNCTION__,
      state, buf, bytes, len, state->nleft);
#endif

  return len;
}

// This command outputs a simple ASCII hex dump, 16 bytes per line arranged as
// 4 groups of four bytes each:
//
//     01234567 89ABCDEF 01234567 89ABCDEF
//     12345678 9ABCDEF0 12345678 9ABCDEF0
//     23456789 ABCDEF01 23456789 ABCDEF01
//     [...]
static
int
casper_tapcp_read_fpga_words_ascii(
    struct tapcp_state *state, void *buf, int bytes)
{
  // state->ptr is pointer to next FPGA word
  // state->lindex is index of next line_buf byte to send
  // state->nleft is number of bytes left to retrieve from FPGA

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
      // Init
      plb = line_buf;
      // Loop to read four words for the line
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

// Write helpers

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
casper_tapcp_open_dev(struct tapcp_state *state, const char *fname)
{
  uint8_t i;
  uint8_t *p = NULL;
  const uint8_t *cip = NULL; // core_info payload
  uint32_t fpga_off  = 0; // From payload
  uint32_t fpga_len  = 0; // From payload
  uint32_t cmd_off = 0; // From command line
  uint32_t cmd_len = 0; // From command line

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("%s fname '%s'\n", __FUNCTION__, fname);
#endif

  // Parse "command line"
  //
  // Look for slash
  p = (uint8_t *)strchr(fname, '/');
  if(p) {
    // NUL terminate fname (violate const, temporarily)
    *p = '\0';
  }

  // Look for device name
  cip = find_key(CORE_INFO, (const uint8_t *)fname, NULL);

  if(p) {
    // Restore '/' (and const-ness)
    *p++ = '/';
  }

  // If device not found, return error
  if(!cip) {
#ifdef VERBOSE_TAPCP_IMPL
    xil_printf("did not find device in core info\n");
#endif
    return NULL;
  }

  // Get fpga_offset and fpga_len from payload
  for(i=0; i<4; i++) {
    fpga_off <<= 8;
    fpga_off |= (*cip++ & 0xff);
  }
  for(i=0; i<4; i++) {
    fpga_len <<= 8;
    fpga_len |= (*cip++ & 0xff);
  }
#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("fpga_off=%p fpga_len=%x\n", fpga_off, fpga_len);
#endif

  // If slash was found and characters follow, parse offset (and length)
  if(p && *p) {
    // Read hex value into cmd_off
    p = hex_to_u32(p, &cmd_off);
    // If not at end of string
    if(*p) {
      p = hex_to_u32(++p, &cmd_len);
    }
  }

  // Zero or not given length means all of it starting from cmd_offset
  if(cmd_len == 0) {
    cmd_len = (fpga_len >> 2) - cmd_off;
    // If nothing left after cmd_offset
    if(cmd_len == 0) {
#ifdef VERBOSE_TAPCP_IMPL
      xil_printf("request too short\n");
#endif
    }
  }

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("cmd_off=%p cmd_len=%x\n", cmd_off, cmd_len);
#endif

  // Bounds check
  if(cmd_off + cmd_len > (fpga_len >> 2)) {
#ifdef VERBOSE_TAPCP_IMPL
    xil_printf("request too long\n");
#endif
    return NULL;
  }

  // Setup tapcp state
  // Treat all terms as ints, then cast result to pointer.
  state->ptr = (void *)(
      XPAR_AXI_SLAVE_WISHBONE_CLASSIC_MASTER_0_BASEADDR +
      (fpga_off & ~3) + (cmd_off << 2));
  // nleft is in bytes
  state->nleft = cmd_len << 2;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("ptr=%p\n", state->ptr);
#endif

  if(!state->write) {
    if(state->binary) {
      set_tftp_read((tftp_read_f)casper_tapcp_read_fpga_words_binary);
    } else {
      state->lidx = 0;
      set_tftp_read((tftp_read_f)casper_tapcp_read_fpga_words_ascii);
    }
  } else if(!(fpga_off & 1)) {
#if 1 // TODO
    return NULL;
#else
    set_tftp_write((tftp_read_f)casper_tapcp_write_mem);
#endif
  }

  return state;
}
