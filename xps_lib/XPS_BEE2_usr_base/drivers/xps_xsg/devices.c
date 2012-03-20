/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* Devices access functions */

#include "devices.h"

/* Constants */
/* ********************************* */

/* List the devices available in the design */
/* ********************************* */

void listdev_cmd(int argc, char **argv)
/* command = "listdev"                                     */
/* help    = "lists the devices available in the design"   */
/* params  = ""                                            */
{
	int i;
	xil_printf("Address map :\n\r");
	for(i=0;i<NUM_CORES;i++) {
		if(cores[i].address != -1)
			xil_printf("\t0x%08X -> %s\n\r",cores[i].address,cores[i].name);
		else
			xil_printf("\t<NO ADDR>  -> %s\n\r",cores[i].name);
	}
}

