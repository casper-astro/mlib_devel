/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* Memory acces functions */

#include "memory.h"

/* Constants */
/* ********************************* */
unsigned int base_address = 0;

/* Read a word or a bunch of words from the memory */
/* ********************************* */

void read_cmd(int argc, char **argv)
/* command = "read"                            */
/* help    = "reads words from memory"         */
/* params  = "<start_address> [<end_address>]" */
{
	char* s;
	long long address;
	long long start_address,end_address;

	if(argc!=2 && argc!=3) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}
	
	if(argc==2) {
		for(s=argv[1];*s!=0;s++) {
			if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[1]))) {
				xil_printf("Non-valid address\n\r");
				return;
			}
		}
		address = tinysh_atoxi(argv[1]);
		xil_printf("0x%08X : 0x%08X\n\r",(unsigned int) address,*((unsigned int*) (unsigned int) address));
	}

	if(argc==3) {
		for(s=argv[1];*s!=0;s++) {
			if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[1]))) {
				xil_printf("Non-valid start address\n\r");
				return;
			}
		}
		for(s=argv[2];*s!=0;s++) {
			if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[2]))) {
				xil_printf("Non-valid end address\n\r");
				return;
			}
		}
		start_address = tinysh_atoxi(argv[1]);
		end_address = tinysh_atoxi(argv[2]);

		start_address &= ~(0xF);
		end_address &= ~(0xF);
		end_address += 0xF;

		for(address=start_address;address<=end_address;address++) {
			if(!(address%16)) {
				xil_printf("\n\r");
				xil_printf("0x%08X | ",(unsigned int) address);
			}
			xil_printf(" %02X",*((unsigned char*) (unsigned int) address));
		}
		xil_printf("\n\r");
	}
}

/* Write data to the memory */
/* ********************************* */

void write_cmd(int argc, char **argv)
/* command = "write"                                   */
/* help    = "writes data to memory"                   */
/* params  = "<access_type (b|s|l)> <address> <data>"  */
{
	char* s;
	unsigned int address,data;

	if(argc!=4) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}
	
	for(s=argv[2];*s!=0;s++) {
		if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[2]))) {
			xil_printf("Non-valid address\n\r");
			return;
		}
	}
	address = tinysh_atoxi(argv[2]);

	for(s=argv[3];*s!=0;s++) {
		if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[3]))) {
			xil_printf("Non-valid data\n\r");
			return;
		}
	}
	data = tinysh_atoxi(argv[3]);

	if(!strcmp(argv[1],"b")) {
		*((unsigned char*) address)=(unsigned char) data;
	} else if(!strcmp(argv[1],"s")) {
		*((unsigned short*) address)=(unsigned short) data;
	} else if(!strcmp(argv[1],"l")) {
		*((unsigned long*) address)=(unsigned long) data;
	} else {
		xil_printf("Bad argument: %s\n\r",argv[1]);
		return;
	}

	xil_printf("0x%08X : 0x%08X\n\r",address,*((unsigned int*) address));
}

/* Read a word or a bunch of words from the memory using the current base address*/
/* ********************************* */

void readbase_cmd(int argc, char **argv)
/* command = "readb"                                       */
/* help    = "reads words from memory using base address"  */
/* params  = "<start_address> [<end_address>]"             */
{
	char* s;
	long long address,start_address,end_address;

	if(argc!=2 && argc!=3) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	xil_printf("base address set to 0x%08X\n\r",base_address);

	if(argc==2) {
		for(s=argv[1];*s!=0;s++) {
			if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[1]))) {
				xil_printf("Non-valid address\n\r");
				return;
			}
		}
		address = base_address + tinysh_atoxi(argv[1]);
		xil_printf("0x%08X : 0x%08X\n\r",(unsigned int) address,*((unsigned int*) (unsigned int) address));
	}

	if(argc==3) {
		for(s=argv[1];*s!=0;s++) {
			if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[1]))) {
				xil_printf("Non-valid start address\n\r");
				return;
			}
		}
		for(s=argv[2];*s!=0;s++) {
			if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[2]))) {
				xil_printf("Non-valid end address\n\r");
				return;
			}
		}
		start_address = base_address + tinysh_atoxi(argv[1]);
		end_address = base_address + tinysh_atoxi(argv[2]);

		start_address &= ~(0xF);
		end_address &= ~(0xF);
		end_address += 0xF;

		for(address=start_address;address<=end_address;address++) {
			if(!(address%16)) {
				xil_printf("\n\r");
				xil_printf("0x%08X | ",(unsigned int) address);
			}
			xil_printf(" %02X",*((unsigned char*) (unsigned int) address));
		}
		xil_printf("\n\r");
	}
}

/* Write data to the memory using the current base address*/
/* ********************************* */

void writebase_cmd(int argc, char **argv)
/* command = "writeb"                                       */
/* help    = "writes data to memory using a base address"   */
/* params  = "<access_type> <address> <data>"               */
{
	char* s;
	unsigned int address,data;

	if(argc!=4) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	xil_printf("base address set to 0x%08X\n\r",base_address);

	for(s=argv[2];*s!=0;s++) {
		if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[2]))) {
			xil_printf("Non-valid address\n\r");
			return;
		}
	}
	address = base_address + tinysh_atoxi(argv[2]);

	for(s=argv[3];*s!=0;s++) {
		if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[3]))) {
			xil_printf("Non-valid data\n\r");
			return;
		}
	}
	data = tinysh_atoxi(argv[3]);

	if(!strcmp(argv[1],"b")) {
		*((unsigned char*) address)=(unsigned char) data;
	} else if(!strcmp(argv[1],"s")) {
		*((unsigned short*) address)=(unsigned short) data;
	} else if(!strcmp(argv[1],"l")) {
		*((unsigned long*) address)=(unsigned long) data;
	} else {
		xil_printf("Bad argument: %s\n\r",argv[1]);
		return;
	}

	xil_printf("0x%08X : 0x%08X\n\r",address,*((unsigned int*) address));
}

/* sets the current base address*/
/* ********************************* */

void setbase_cmd(int argc, char **argv)
/* command = "setb"                                         */
/* help    = "sets a base address"                          */
/* params  = "<address>"                                    */
{
	char* s;
	unsigned int address,data;

	if(argc!=2) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}
	
	for(s=argv[1];*s!=0;s++) {
		if(!((*s>=48 && *s<=57) || (*s>=65 && *s<=70) || (*s>=97 && *s<=102) || (*s=='x' && s==argv[1]))) {
			xil_printf("Non-valid address\n\r");
			return;
		}
	}
	base_address = tinysh_atoxi(argv[1]);

	xil_printf("base address set to 0x%08X\n\r",base_address);

}

