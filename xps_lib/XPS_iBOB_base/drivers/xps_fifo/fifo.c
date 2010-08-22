/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* FIFO access functions */

#include "fifo.h"
enum { NULLMATCH,FULLMATCH,PARTMATCH,UNMATCH,MATCH,AMBIG };

/* Read a word from a FIFO */
/* ********************************* */

inline Xuint32 sif_fifo_read(Xuint32 fifo_address)
{
	Xuint32 fifo_data;

	/* take the lock on the FIFO */
	while(XIo_In32(fifo_address + 8));

	/* check the FIFO empty bit */
	while(XIo_In32(fifo_address + 4) & 1);

	/* read one word from the FIFO */
	fifo_data = XIo_In32(fifo_address + 0);

	/* release the lock on the FIFO */
	while(!XIo_In32(fifo_address + 12));

	return fifo_data;
}

inline Xuint32 sif_fifo_read_nonblock(Xuint32 fifo_address, int* fail)
{
	Xuint32 fifo_data;

	/* take the lock on the FIFO */
	while(XIo_In32(fifo_address + 8));

	/* check the FIFO empty bit */
	*fail = (int) XIo_In32(fifo_address + 4) & 1;
	
	/* read one word from the FIFO */
	if(!*fail) fifo_data = XIo_In32(fifo_address + 0); else fifo_data = 0;

	/* release the lock on the FIFO */
	while(!XIo_In32(fifo_address + 12));

	return fifo_data;
}

/* Write a word to a FIFO */
/* ********************************* */

inline void sif_fifo_write(Xuint32 fifo_address, Xuint32 fifo_data)
{

	/* take the lock on the FIFO */
	while(XIo_In32(fifo_address + 8));

	/* check the FIFO full bit */
	while(XIo_In32(fifo_address + 4) & 1);

	/* write one word to the FIFO */
	XIo_Out32(fifo_address + 0, fifo_data);

	/* release the lock on the FIFO */
	while(!XIo_In32(fifo_address + 12));

}

inline void sif_fifo_write_nonblock(Xuint32 fifo_address, Xuint32 fifo_data, int* fail)
{

	/* take the lock on the FIFO */
	while(XIo_In32(fifo_address + 8));

	/* check the FIFO full bit */
	*fail = XIo_In32(fifo_address + 4) & 1;

	/* write one word to the FIFO */
	if(!*fail) XIo_Out32(fifo_address + 0, fifo_data);

	/* release the lock on the FIFO */
	while(!XIo_In32(fifo_address + 12));

}

/* Reset a FIFO */
/* ********************************* */

void sif_fifo_reset(Xuint32 fifo_address)
{
	/* take the lock on the FIFO */
	while(XIo_In32(fifo_address + 8));

	/* set the reset bit */
	XIo_Out32(fifo_address + 4, 0x00000002);

	/* wait for a while */
	usleep(1);

	/* clear the reset bit */
	XIo_Out32(fifo_address + 4, 0x00000000);

	/* release the lock on the FIFO */
	while(XIo_In32(fifo_address + 12));

}

/* Put data in a fifo */
/* ********************************* */

void fifoput_cmd(int argc, char **argv)
/* command = "fifoput"                                      */
/* help    = "puts a value in a fifo"                       */
/* params  = "<fifo name> <value>"                          */
{
	Xuint32 value;
	char *name;
	int i;
	int fail = 0;

	if(argc!=3) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	value = tinysh_atoxi(argv[2]);
	
	for(i=0;i<NUM_CORES;i++)
		if(strstart(name,cores[i].name)==FULLMATCH)
		{
			if(cores[i].type != xps_fifo)
			{
				xil_printf("Core '%s' is not a fifo\n\r",name);
			}
			else
			{
				if(strstart("in",cores[i].params)==FULLMATCH)
				{
					sif_fifo_write_nonblock(cores[i].address, value, &fail);
					if(fail)
						xil_printf("Operation failed. Fifo is full\n\r");
				}
				else
					xil_printf("Fifo '%s' is not a 'From Processor' fifo and cannot accept data\n\r",name);
			}
			break;
		}

	if(i==NUM_CORES)
		xil_printf("Could not find core named '%s'\n\r",name);

}

/* Get data from a fifo */
/* ********************************* */

void fifoget_cmd(int argc, char **argv)
/* command = "fifoget"                                      */
/* help    = "gets data from a fifo"                        */
/* params  = "<fifo name> [<repeat>]"                       */
{
	char *name;
	int i,j;
	int fail;
	int repeat;
	Xuint32 value;

	if(argc!=2 && argc !=3) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];

	for(i=0;i<NUM_CORES;i++)
		if(strstart(name,cores[i].name)==FULLMATCH)
		{
			if(cores[i].type != xps_fifo)
			{
				xil_printf("Core '%s' is not a fifo\n\r",name);
			}
			else
			{
				if(strstart("out",cores[i].params)==FULLMATCH)
				{
					if(argc==3)
					{
						repeat = tinysh_atoxi(argv[2]);
						for(j=0;j<repeat;j++)
						{
							value = sif_fifo_read_nonblock(cores[i].address, &fail);
							if(fail)
								xil_printf("0x%04X / %05d -> Operation failed. Fifo is empty\n\r", j, j);
							else
							{
								xil_printf("0x%04X / %05d -> 0x%08X / 0b%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d / %010d\n\r",
									j,
									j,
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
					} else {
						value = sif_fifo_read_nonblock(cores[i].address, &fail);
						if(fail)
							xil_printf("Operation failed. Fifo is empty\n\r");
						else
						{
							xil_printf("0x%08X / 0b%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d / %010d\n\r",
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
				}
				else
					xil_printf("Fifo '%s' is not a 'To Processor' fifo and cannot be read\n\r",name);
			}
			break;
		}

	if(i==NUM_CORES)
		xil_printf("Could not find core named '%s'\n\r",name);

}

/* Reset a fifo */
/* ********************************* */

void fiforeset_cmd(int argc, char **argv)
/* command = "fiforeset"                                    */
/* help    = "resets a fifo"                                */
/* params  = "<fifo name>"                                  */
{
	char *name;
	int i;

	if(argc!=2) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	
	for(i=0;i<NUM_CORES;i++)
		if(strstart(name,cores[i].name)==FULLMATCH)
		{
			if(cores[i].type != xps_fifo)
			{
				xil_printf("Core '%s' is not a fifo\n\r",name);
			}
			else
			{
				sif_fifo_reset(cores[i].address);
			}
			break;
		}

	if(i==NUM_CORES)
		xil_printf("Could not find core named '%s'\n\r",name);

}
