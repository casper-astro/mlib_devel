/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* BRAM access functions */

#include "core_util.h"
#include "bram.h"

/* Read a word from a FIFO */
/* ********************************* */

inline Xuint32 sif_bram_read(Xuint32 bram_address, unsigned int offset)
{

	/* read one word from the BRAM */
	return XIo_In32(bram_address + (offset*4));

}

inline void sif_bram_write(Xuint32 bram_address, unsigned int offset, Xuint32 data)
{

	/* write one word to the BRAM */
	XIo_Out32(bram_address + (offset*4),data);

}

/* Write data in a bram */
/* ********************************* */

void bramwrite_cmd(int argc, char **argv)
/* command = "bramwrite"                                    */
/* help    = "writes a value in a bram"                     */
/* params  = "<bram name> <address> <value>"                */
{
	Xuint32 value;
	char *name;
	int i;
	unsigned int address,size;
	core * corep = NULL;

	if(argc!=4) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	address = tinysh_atoxi(argv[2]);
	value = tinysh_atoxi(argv[3]);
	
	switch(find_core(name,xps_bram,&corep)) {
		case CORE_WRONG_TYPE:
			xil_printf("Core '%s' is not a bram\n\r",name);
			break;
		case CORE_NOT_FOUND:
			xil_printf("Core '%s' not found\n\r",name);
			break;
		case CORE_OK:
			size = tinysh_atoxi(corep->params);

			if (address >= size) {
				xil_printf("The specified address is outside of the BRAM\n\r");
			} else {
				sif_bram_write(corep->address, address, value);
			}
			break;
	}
}

/* Read data from a bram */
/* ********************************* */

void bramread_cmd(int argc, char **argv)
/* command = "bramread"                                     */
/* help    = "reads a value from a bram"                    */
/* params  = "<bram name> <address>"                        */
{
	Xuint32 value;
	char *name;
	int i;
	unsigned int address,size;
	core * corep = NULL;

	if(argc!=3) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	address = tinysh_atoxi(argv[2]);
	
	switch(find_core(name,xps_bram,&corep)) {
		case CORE_WRONG_TYPE:
			xil_printf("Core '%s' is not a bram\n\r",name);
			break;
		case CORE_NOT_FOUND:
			xil_printf("Core '%s' not found\n\r",name);
			break;
		case CORE_OK:
			size = tinysh_atoxi(corep->params);

			if (address >= size) {
				xil_printf("The specified address is outside of the BRAM\n\r");
			} else {
				value = sif_bram_read(corep->address, address);
				pprint_address_value(address,value);
			}
			break;
	}
}

/* Dump the content from a bram */
/* ********************************* */

void bramdump_cmd(int argc, char **argv)
/* command = "bramdump"                                     */
/* help    = "dumps the content of a bram"                  */
/* params  = "<bram name> [start length]"                   */
{
	Xuint32 value;
	char *name;
	int i;
	unsigned int size,offset,start=0,length=0;
	core * corep = NULL;

	if(argc!=2 && argc!=4) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	
	switch(find_core(name,xps_bram,&corep)) {
		case CORE_WRONG_TYPE:
			xil_printf("Core '%s' is not a bram\n\r",name);
			break;
		case CORE_NOT_FOUND:
			xil_printf("Core '%s' not found\n\r",name);
			break;
		case CORE_OK:
			size = tinysh_atoxi(corep->params);
			if(argc==4) {
			  start = tinysh_atoxi(argv[2]);
			  length = tinysh_atoxi(argv[3]);
			}
			if(length==0) {
			  length = size;
			}

			for(offset=0;start+offset<size && length>0;offset++,length--)
			{
				value = sif_bram_read(corep->address, start+offset);
				if(argc==4) {
					xil_printf("0x%08x\n\r",value);
				} else {
					pprint_address_value(start+offset,value);
				}
			}
			break;
	}
}
