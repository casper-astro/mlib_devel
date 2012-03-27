/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* REGISTER access functions */

#include "core_util.h"
#include "reg.h"

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
	char * p;
	int i;
	core * corep;

	if(argc!=3) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	value = tinysh_atoxi(argv[2]);
	
	switch(find_core(name,xps_sw_reg,&corep)) {
		case CORE_WRONG_TYPE:
			xil_printf("Core '%s' is not a register\n\r",name);
			break;
		case CORE_NOT_FOUND:
			xil_printf("Core '%s' not found\n\r",name);
			break;
		case CORE_OK:
			p=corep->params;
			if(p[0]=='i'&&p[1]=='n'&&p[2]=='\0')
				sif_reg_write(corep->address, value);
			else
				xil_printf("Register '%s' is not a 'From Processor' register and cannot be written\n\r",name);
			break;
	}
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
	core * corep;

	if(argc!=2) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	
	switch(find_core(name,xps_sw_reg,&corep)) {
		case CORE_WRONG_TYPE:
			xil_printf("Core '%s' is not a register\n\r",name);
			break;
		case CORE_NOT_FOUND:
			xil_printf("Core '%s' not found\n\r",name);
			break;
		case CORE_OK:
			value = sif_reg_read(corep->address);
			pprint_value(value);
			break;
	}
}
