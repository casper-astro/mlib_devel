// casper_tftp.c - CASPER handlers for LwIP TFTP server.
//
// These handlers provide the interface between LwIP's TFTP server and the
// CASPER TAPCP implementation.

#include "lwip/apps/tftp_server.h"
#include "casper_tftp.h"
#include "casper_tapcp.h"

// Because LwIp only supports a maximum of one active transfer at any given
// time, we can use a single file-scope static structure to maintain state
// during the transfer.  The "handle" returned by `casper_tftp_open()`
// indicates the "command" being processed.  It is expected to be one of the
// `CASPER_TAPCP_CMD_...` values.

static struct tapcp_state tapcp_state = {0};

static struct tftp_context casper_tftp_context;

// This is the default TFTP read function.  It always returns an error.
// casper_tftp_open() sets the read function pointer in the tftp_context
// structure to this function, but various "open helpers" invoked by
// casper_tftp_open() can point to a different function.
//
// `handle` Handle returned by open()
// `buf` Target buffer to copy read data to
// `bytes` Number of bytes to copy to buf
// Returns Number of bytes copied on success; -1 on error
static
int
casper_tftp_read_error(void *handle, void *buf, int bytes)
{
#ifdef VERBOSE_TFTP_IMPL
  xil_printf("casper_tftp_read_error(%p, %p, %d) = -1\n",
      handle, buf, bytes);
#endif // VERBOSE_TFTP_IMPL

  return -1;
}

// This is the default TFTP write function.  It always returns an error.
// casper_tftp_open() sets the wriate function pointer in the tftp_context
// structure to this function, but various "open helpers" invoked by
// casper_tftp_open() can point to a different function if writing is allowed.
//
// `handle` Handle returned by open()
// `pbuf` PBUF adjusted such that payload pointer points
//        to the beginning of write data. In other words,
//        TFTP headers are stripped off.
// Returns Number of bytes copied on success; -1 on error
static
int
casper_tftp_write_error(void *handle, struct pbuf *p)
{
#ifdef VERBOSE_TFTP_IMPL
  xil_printf("casper_tftp_write_error(%p, %p [%u/%u]) = -1\n",
      handle, p, p->len, p->tot_len);
#endif // VERBOSE_TFTP_IMPL

  return -1;
}

// Open file for read/write.
// `fname` Filename
// `mode` Mode string from TFTP RFC 1350 (netascii, octet, mail)
// `write` Flag indicating read (0) or write (!= 0) access
// Returns Non-zero handle supplied to other functions; 0 on error
static
void *
casper_tftp_open(const char *fname, const char *mode, u8_t write)
{
  void *handle = NULL;

  // Ensure fname and mode are non-null
  if(!fname || !mode) {
    return NULL;
  }

  // If mode starts with 'o' assume it's "octet"
  tapcp_state.binary = (mode[0] == 'o');
  tapcp_state.write = write;

  // Set default read/write functions to ones that return error.
  casper_tftp_context.read = casper_tftp_read_error;
  casper_tftp_context.write = casper_tftp_write_error;

  // If filename is exactly "/help" and not writing
  if(!strcmp("/help", fname) && !write) {
    handle = casper_tapcp_open_help(&tapcp_state);

  // If filename is exactly "/listdev" and not writing
  } else if(!strcmp("/listdev", fname) && !write) {
    handle = casper_tapcp_open_listdev(&tapcp_state);

  // If filename is exactly "/temp" and not writing
  } else if(!strcmp("/temp", fname) && !write) {
    handle = casper_tapcp_open_temp(&tapcp_state);

  // If filename starts with "/fpga."
  } else if(!strncmp("/fpga.", fname, strlen("/fpga."))) {
    handle = casper_tapcp_open_mem(&tapcp_state, fname);

  // If filename starts with "/cpu." and not writing
  } else if(!strncmp("/cpu.", fname, strlen("/cpu.")) && !write) {
    handle = casper_tapcp_open_mem(&tapcp_state, fname);

  // If filename starts is exactly "/progdev" and writing
  } else if(!strcmp("/progdev", fname) && write) {
    handle = casper_tapcp_open_progdev(&tapcp_state);

  // If filename starts with "/flash."
  } else if(!strncmp("/flash.", fname, sizeof("flash."))) {
    handle = casper_tapcp_open_flash(&tapcp_state, fname);

  // If filename starts with "/flashcmd."
  } else if(!strncmp("/flashcmd.", fname, strlen("/flashcmd."))) {
    handle = casper_tapcp_open_flashcmd(&tapcp_state, fname);

  // Otherwise, treat as /dev/... request
  } else {
    handle = casper_tapcp_open_dev(&tapcp_state, fname);
  }

#ifdef VERBOSE_TFTP_IMPL
  xil_printf("casper_tftp_open(%s, %s, %u) = %p\n",
      fname, mode, write, handle);
#endif // VERBOSE_TFTP_IMPL

  return handle;
}

// Close file handle
// `handle` Handle returned by open()
static
void
casper_tftp_close(void *handle)
{
  struct tapcp_state *state = (struct tapcp_state*)handle;

#ifdef VERBOSE_TFTP_IMPL
  xil_printf("casper_tftp_close(%p)\n", handle);
#endif // VERBOSE_TFTP_IMPL

  casper_tftp_context.read = casper_tftp_read_error;
  casper_tftp_context.write = casper_tftp_write_error;

  if(state) {
    state->ptr = NULL;
    state->nleft = 0;
  }
}

err_t
casper_tftp_init()
{
  casper_tftp_context.open  = casper_tftp_open;
  casper_tftp_context.close = casper_tftp_close;
  casper_tftp_context.read  = casper_tftp_read_error;
  casper_tftp_context.write = casper_tftp_write_error;
  return tftp_init(&casper_tftp_context);
}

void
set_tftp_read(tftp_read_f read_func)
{
  casper_tftp_context.read = read_func;
}

void
set_tftp_write(tftp_write_f write_func)
{
  casper_tftp_context.write = write_func;
}
