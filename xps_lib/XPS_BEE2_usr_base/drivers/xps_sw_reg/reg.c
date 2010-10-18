/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* REGISTER access functions */

#include "reg.h"
enum { NULLMATCH,FULLMATCH,PARTMATCH,UNMATCH,MATCH,AMBIG };

/* Write to a register */
/* ********************************* */

inline void sif_reg_write(Xuint32 reg_address, Xuint32 reg_data)
{

	/* take the lock on the register */
	while(XIo_In32(reg_address + 8));

	/* write data to the register */
	XIo_Out32(reg_address + 0, reg_data);

	/* wait for the transfert done bit */
	while(!XIo_In32(reg_address + 4));

	/* release the lock on the register */
	while(XIo_In32(reg_address + 12));

}

/* Read from a register */
/* ********************************* */

inline Xuint32 sif_reg_read(Xuint32 reg_address)
{

	/* read data from the register */
	return XIo_In32(reg_address + 0);

}

/* Set a register value */
/* ********************************* */

void regwrite_cmd(int argc, char **argv)
/* command = "regwrite"                                     */
/* help    = "writes the value of a register"               */
/* params  = "<register name> <register value>"             */
{
	Xuint32 value;
	char *name;
	int i;

	if(argc!=3) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	value = tinysh_atoxi(argv[2]);
	
	for(i=0;i<NUM_CORES;i++)
		if(strstart(name,cores[i].name)==FULLMATCH)
		{
			if(cores[i].type != xps_sw_reg)
			{
				xil_printf("Core '%s' is not a register\n\r",name);
			}
			else
			{
				if(strstart("in",cores[i].params)==FULLMATCH)
					sif_reg_write(cores[i].address, value);
				else
					xil_printf("Register '%s' is not a 'From Processor' register and cannot be written\n\r",name);
			}
			break;
		}

	if(i==NUM_CORES)
		xil_printf("Could not find core named '%s'\n\r",name);

}

/* Get a register value */
/* ********************************* */

void regread_cmd(int argc, char **argv)
/* command = "regread"                                      */
/* help    = "reads the value of a register"                */
/* params  = "<register name>"                              */
{
	char *name;
	int i;
	Xuint32 value;

	if(argc!=2) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	
	for(i=0;i<NUM_CORES;i++)
		if(strstart(name,cores[i].name)==FULLMATCH)
		{
			if(cores[i].type != xps_sw_reg)
			{
				xil_printf("Core '%s' is not a register\n\r",name);
			}
			else
			{
				value = sif_reg_read(cores[i].address);
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
			break;
		}

	if(i==NUM_CORES)
		xil_printf("Could not find core named '%s'\n\r",name);

}
