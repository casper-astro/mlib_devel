// casper_tftp.h - Macro definitions and declarations for CASPER implementation
//                 for LwIP TFTP server.

#ifndef _CASPER_TFTP_H_
#define _CASPER_TFTP_H_

#include "lwip/pbuf.h"

err_t casper_tftp_init();

typedef int (*tftp_read_f)(void *, void *, int bytes);
typedef int (*tftp_write_f)(void *, struct pbuf *);

void set_tftp_read(tftp_read_f read_func);
void set_tftp_write(tftp_write_f write_func);

#endif // _CASPER_TFTP_H_
