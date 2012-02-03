/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* Main file */

#include "xparameters.h"
#include "xuartns550_l.h"
#include "xcache_l.h"
#include <stdio.h>
#include <stdlib.h>
#include "FAT/FAT32_Definitions.h"
#include "FAT/FileLib.h"
#define RAM_SIZE            0x01000000
#define KERNEL_IMAGE_OFFSET 0x00400000

/* Prototypes */
/* ********************************* */
void outbyte(unsigned char c);
int  inbyte();
/* <prototypes> */

/* Main thread */
/* ********************************* */

int main(void)
{
	int i;
	Xuint32 data;
        Xuint32 address, real, gold;
        FileLib_File * file;
        int c;
        void (*start) (void);

/* release control of the serial port */
	XIo_Out32(XPAR_OPB_SERIALSWITCH_0_BASEADDR,0);
	usleep(1000);

/* activate the UART */
/* Set the baud rate and number of stop bits */
        XUartNs550_SetBaud(XPAR_RS232_UART_BASEADDR, 100000000, 115200);
        XUartNs550_mSetLineControlReg(XPAR_RS232_UART_BASEADDR, XUN_LCR_8_DATA_BITS);
/* Enable the FIFOs for 16550 mode since the device defaults to no FIFOs */
        XUartNs550_mWriteReg(XPAR_RS232_UART_BASEADDR, XUN_FCR_OFFSET, XUN_FIFO_ENABLE);

/* activate the cache on the PPC */
	XCache_EnableICache(0x00000001);
	XCache_EnableDCache(0x00000001);

/* testing sram */
        srand(0);
        for(address=0;address < RAM_SIZE; address += 4) {
                XIo_Out32(address, rand() | ((rand()&1) << 31));
        }
        srand(0);
        i = 0;
        for(address=0;address < RAM_SIZE; address += 4) {
                real = XIo_In32(address);
                gold = rand() | ((rand()&1) << 31);
                if(real != gold) {
			/* reset the processor */
			data = 0x30000000;
			asm("mtdbcr0 %0" :: "r"(data));
		}
	}

/* Initializing SD Card */
	SD_Init();

/* Check if partition 0 on drive is FAT32 */
	if (FAT32_GetFATVersion()!=FAT_TYPE_FAT32)
	{
		/* reset the processor */
		data = 0x30000000;
		asm("mtdbcr0 %0" :: "r"(data));
	}

	/* Initialise FAT parameters */
	if (!FAT32_InitFAT())
	{
		/* reset the processor */
		data = 0x30000000;
		asm("mtdbcr0 %0" :: "r"(data));
	}

/* take control of the serial port */
	XIo_Out32(XPAR_OPB_SERIALSWITCH_0_BASEADDR,1);
	usleep(1000);

/* display welcome message */
	xil_printf("\n\r");
	xil_printf("****************************\n\r");
	xil_printf("*   iBOB linux bootloader  *\n\r");
	xil_printf("****************************\n\r");
	xil_printf("\n\r");
	xil_printf("Found and tested linux add-on card, booting linux\n\r");
        FileLib_Init();


/* loading linux image in RAM */
	if(file = FileLib_fopen("C:\\linux.bin")) {
		xil_printf("\n\rFound linux image, file size: %d Bytes\n\r",file->filelength);
		if(file->filelength > 0x200000) {
			xil_printf("kernel image too big, aborting\n\r");
	                /* reset the processor */
        	        data = 0x30000000;
                	asm("mtdbcr0 %0" :: "r"(data));
		}
		xil_printf("loading [                     ]\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b");
		address = KERNEL_IMAGE_OFFSET;
		for(i=0;i<file->filelength;i++) {
			c = FileLib_fgetc(file);
			XIo_Out8(address++, c);
			if(i%(file->filelength/20) == 0) xil_printf(".");
		}
		xil_printf(".]\n\r");

		/* jump in the kernel and never returns */
		start = (void*) KERNEL_IMAGE_OFFSET;
		start();
	} else {
		xil_printf("cannot find kernel (linux.bin) on the card, resetting processor\n\r");
                /* reset the processor */
                data = 0x30000000;
                asm("mtdbcr0 %0" :: "r"(data));
	}

}


void outbyte(unsigned char c)
{
        XUartNs550_SendByte(XPAR_RS232_UART_BASEADDR, c);
}

int inbyte()
{
        return XUartNs550_RecvByte(XPAR_RS232_UART_BASEADDR);
}
