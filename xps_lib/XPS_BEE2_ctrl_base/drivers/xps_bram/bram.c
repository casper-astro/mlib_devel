/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* BRAM access functions */

#include "bram.h"
enum { NULLMATCH,FULLMATCH,PARTMATCH,UNMATCH,MATCH,AMBIG };

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

	if(argc!=4) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	address = tinysh_atoxi(argv[2]);
	value = tinysh_atoxi(argv[3]);
	
	for(i=0;i<NUM_CORES;i++)
		if(strstart(name,cores[i].name)==FULLMATCH)
		{
			if(cores[i].type != xps_bram)
			{
				xil_printf("Core '%s' is not a bram\n\r",name);
			}
			else
			{
				size = tinysh_atoxi(cores[i].params);

				if (address >= size)
				{
					xil_printf("The specified address is outside of the BRAM\n\r");
					return;
				}

				sif_bram_write(cores[i].address, address, value);
			}
			break;
		}

	if(i==NUM_CORES)
		xil_printf("Could not find core named '%s'\n\r",name);

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

	if(argc!=3) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	address = tinysh_atoxi(argv[2]);
	
	for(i=0;i<NUM_CORES;i++)
		if(strstart(name,cores[i].name)==FULLMATCH)
		{
			if(cores[i].type != xps_bram)
			{
				xil_printf("Core '%s' is not a bram\n\r",name);
			}
			else
			{
				size = tinysh_atoxi(cores[i].params);

				if (address >= size)
				{
					xil_printf("The specified address is outside of the BRAM\n\r");
					return;
				}
				value = sif_bram_read(cores[i].address, address);
				xil_printf("0x%04X / %05d -> 0x%08X / 0b%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d / %010d\n\r",
						address,
						address,
						value,
						(value>>31)&1,
						(value>>30)&1,
						(value>>29)&1,
						(value>>28)&1,
						(value>>27)&1,
						(value>>26)&1,
						(value>>25)&1,
						(value>>24)&1,
						(value>>23)&1,
						(value>>22)&1,
						(value>>21)&1,
						(value>>20)&1,
						(value>>19)&1,
						(value>>18)&1,
						(value>>17)&1,
						(value>>16)&1,
						(value>>15)&1,
						(value>>14)&1,
						(value>>13)&1,
						(value>>12)&1,
						(value>>11)&1,
						(value>>10)&1,
						(value>> 9)&1,
						(value>> 8)&1,
						(value>> 7)&1,
						(value>> 6)&1,
						(value>> 5)&1,
						(value>> 4)&1,
						(value>> 3)&1,
						(value>> 2)&1,
						(value>> 1)&1,
						(value>> 0)&1,
						value);
			}
			break;
		}

	if(i==NUM_CORES)
		xil_printf("Could not find core named '%s'\n\r",name);

}

/* Dump the content from a bram */
/* ********************************* */

void bramdump_cmd(int argc, char **argv)
/* command = "bramdump"                                     */
/* help    = "dumps the content of a bram"                  */
/* params  = "<bram name>"                                  */
{
	Xuint32 value;
	char *name;
	int i;
	unsigned int size,address;

	if(argc!=2) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	
	for(i=0;i<NUM_CORES;i++)
		if(strstart(name,cores[i].name)==FULLMATCH)
		{
			if(cores[i].type != xps_bram)
			{
				xil_printf("Core '%s' is not a bram\n\r",name);
			}
			else
			{
				size = tinysh_atoxi(cores[i].params);

				for(address=0;address<size;address++)
				{
					value = sif_bram_read(cores[i].address, address);
					xil_printf("0x%04X / %05d -> 0x%08X / 0b%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d / %010d\n\r",
							address,
							address,
							value,
							(value>>31)&1,
							(value>>30)&1,
							(value>>29)&1,
							(value>>28)&1,
							(value>>27)&1,
							(value>>26)&1,
							(value>>25)&1,
							(value>>24)&1,
							(value>>23)&1,
							(value>>22)&1,
							(value>>21)&1,
							(value>>20)&1,
							(value>>19)&1,
							(value>>18)&1,
							(value>>17)&1,
							(value>>16)&1,
							(value>>15)&1,
							(value>>14)&1,
							(value>>13)&1,
							(value>>12)&1,
							(value>>11)&1,
							(value>>10)&1,
							(value>> 9)&1,
							(value>> 8)&1,
							(value>> 7)&1,
							(value>> 6)&1,
							(value>> 5)&1,
							(value>> 4)&1,
							(value>> 3)&1,
							(value>> 2)&1,
							(value>> 1)&1,
							(value>> 0)&1,
							value);
				}
			}
			break;
		}

	if(i==NUM_CORES)
		xil_printf("Could not find core named '%s'\n\r",name);

}
