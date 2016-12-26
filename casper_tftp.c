// casper_tftp.c - CASPER handlers for LwIP TFTP server.
// These handlers implement the CASPER TFTP access protocol
// (which is in dire need of a better name and acronym).

#include "lwip/apps/tftp_server.h"
#include "casper_eth.h"

// Counter for dummy handle generator
static uint32_t handle_gen = 0;

// Open file for read/write.
// `fname` Filename
// `mode` Mode string from TFTP RFC 1350 (netascii, octet, mail)
// `write` Flag indicating read (0) or write (!= 0) access
// Returns Non-zero handle supplied to other functions; 0 on error
static
void*
casper_tftp_open(const char* fname, const char* mode, u8_t write)
{
  void *handle = (void *)handle_gen++;
  xil_printf("casper_tftp_open(%s, %s, %u) = %p\n",
      fname, mode, write);
  return handle;
}

// Close file handle
// `handle` Handle returned by open()
static
void
casper_tftp_close(void* handle)
{
  xil_printf("casper_tftp_close(%u)\n", handle);
}

// Read from file 
// `handle` Handle returned by open()
// `buf` Target buffer to copy read data to
// `bytes` Number of bytes to copy to buf
// Returns Number of bytes copied on success; -1 on error
static
int
casper_tftp_read(void* handle, void* buf, int bytes)
{
  xil_printf("casper_tftp_read(%p, %p, %d) = 0\n",
      handle, buf, bytes);
  return 0;
}

// Write to file
// `handle` Handle returned by open()
// `pbuf` PBUF adjusted such that payload pointer points
//        to the beginning of write data. In other words,
//        TFTP headers are stripped off.
// Returns Number of bytes copied on success; -1 on error
static
int
casper_tftp_write(void* handle, struct pbuf* p)
{
  xil_printf("casper_tftp_read(%p, %p) = %d\n",
      handle, p, p->tot_len);
  return p->tot_len;
}

static struct tftp_context casper_tftp_context = {
  .open  = casper_tftp_open,
  .close = casper_tftp_close,
  .read  = casper_tftp_read,
  .write = casper_tftp_write
};

err_t
casper_tftp_init()
{
  return tftp_init(&casper_tftp_context);
}
