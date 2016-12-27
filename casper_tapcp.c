// casper_tapcp.c - CASPER TAPCP server implementation.
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
//   - `help` Returns a list of top level commands.  Format is the same
//     regardless of file transfer mode [TODO Do we want to send CRLF line
//     terminators in netascii mode?].
//
//   - `listdev` Lists all devices supported by the currently running gateware
//     design.  The offset, length, and type of each device is included in this
//     listing.  In netascii mode this listing is returned as a human readable
//     table.  In octet mode this listing is returned in the binary
//     compressed/compiled form that is stored in memory.
//
//   - `temp`  Sends the temperature of the FPGA.  In ascii mode this returns
//     the temperature rounded down to the nearest tenth of a degree C.  In
//     binary mode this returns a 4 byte single precision float in network byte
//     order (big endian).
//
//   - `dev/DEV_NAME[/OFFSET[/LENGTH]]` Accesses memory associated with
//     gateware device `DEV_NAME`.  `OFFSET` and `LENGTH`, when given, are
//     in hexadecimal.  `OFFSET` defaults to 0.  `LENGTH` defaults to 4 for
//     read and to length of data for write.  If they are not a multiple of 4,
//     OFFSET is rounded down to the previous multiple of 4 and LENGTH is
//     rounded up.
//
//   - `fpga/OFFSET[/LENGTH]]`  Accesses memory in the FPGA (i.e.
//     AXI/Wishbone) address space.  `OFFSET` and `LENGTH`, when given, are in
//     hexadecimal.  `LENGTH` defaults to 4 for read and to length of data for
//     write.  If they are not a multiple of 4, OFFSET is rounded down to the
//     previous multiple of 4 and LENGTH is rounded up.
//
//   - `cpu/OFFSET[/LENGTH]]`  Accesses memory in the CPU address space.
//     `OFFSET` and `LENGTH` are always given in hexadecimal.  `LENGTH`
//     defaults to 4 for read and to length of data for write.  If they are not
//     a multiple of 4, OFFSET is rounded down to the previous multiple of 4
//     and LENGTH is rounded up.
//
//   - `progdev/[TBD]`  A future command will be added to allow uploading a new
//     bitstream.  The exact details are under development.
//
//   - `flash/[TBD]` A future command will be added to access the FLASH device
//     attached to the FPGA.
//
// The `help`, `listdev`, and `temp` commands are read-only and can only be
// used with "get" operations.  Trying to "put" to them will result in an error
// being returned to the client.
//
// Reading with the `dev`, `wb`, and `mem` commands in netascii mode will
// return data in a hex dump like format (i.e. suitable for display in a
// terminal).  Reading with these commands in octet mode will return the
// requested data in binary form in network byte order (big endian).

#include "platform.h"
#include "lwip/apps/tftp_server.h"
#include "casper_tftp.h"
#include "casper_tapcp.h"

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

// Read functions.
static
int
casper_tapcp_read_help(struct tapcp_state *state, void *buf, int bytes)
{
  int len = bytes < state->nleft ? bytes : state->nleft;

#ifdef VERBOSE_TAPCP_IMPL
  xil_printf("casper_tapcp_read_help(%p, %p, %d) = %d/%d\n",
      state, buf, bytes, len, state->nleft);
#endif // VERBOSE_TAPCP_IMPL

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
  xil_printf("casper_tapcp_temp_help(%p, %p, %d) = %d\n",
      state, buf, bytes, len);
#endif // VERBOSE_TAPCP_IMPL

  return len;
}

// Write helpers

// Open helpers
void *
casper_tapcp_open_help(struct tapcp_state *state)
{
  // Setup tapcp state
  state->cmd = CASPER_TAPCP_CMD_HELP;
  state->ptr = tapcp_help_msg;
  state->nleft = sizeof(tapcp_help_msg) - 1;
  set_tftp_read((tftp_read_f)casper_tapcp_read_help);
  return state;
}

void *
casper_tapcp_open_temp(struct tapcp_state *state)
{
  // Setup tapcp state
  state->cmd = CASPER_TAPCP_CMD_TEMP;
  set_tftp_read((tftp_read_f)casper_tapcp_read_temp);
  return state;
}
