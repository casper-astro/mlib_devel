/* ********************************* */
/* *                               * */
/* * iBOB clock control functions  * */
/* *                               * */
/* ********************************* */

/* 2006 Pierre-Yves droz */

/* Clock access functions */

#include "clk.h"

/* Constants */
/* ********************************* */
int clkphase = 0;

/* measure the frequency of the user clock */
/* *************************************** */

void clkmeasure_cmd(int argc, char **argv)
/* command = "clkmeasure"                                  */
/* help    = "measure the frequency of the user clock"     */
/* params  = ""                                            */
{
	double count_100;
	double count;

	/* reset the counters */
	XIo_Out8(XPAR_OPB_CLOCKCONTROLLER_0_BASEADDR + COUNTERCTRL, RESET_COUNTERS);
	/* enable the counters */
	XIo_Out8(XPAR_OPB_CLOCKCONTROLLER_0_BASEADDR + COUNTERCTRL, ENABLE_COUNTERS);
	/* wait for a while */
	sleep(1);
	/* disable the counters */
	XIo_Out8(XPAR_OPB_CLOCKCONTROLLER_0_BASEADDR + COUNTERCTRL, 0);
	/* read the counters out */
	count_100 = (double) XIo_In32(XPAR_OPB_CLOCKCONTROLLER_0_BASEADDR + COUNTER_100);
	count     = (double) XIo_In32(XPAR_OPB_CLOCKCONTROLLER_0_BASEADDR + COUNTER);
	/* display the result */
	xil_printf("Clock frequency: %d.%04d Mhz\n\r", (int) (count*100/count_100), ((int) (count*1000000/count_100)) % 10000);
	xil_printf("Current phase  : %d degrees\n\r", clkphase * 180 / 256);
}

void clkreset_cmd(int argc, char **argv)
/* command = "clkreset"                                    */
/* help    = "reset the DLL on the user clock"             */
/* params  = ""                                            */
{
	/* assert the reset of the DCM */
	XIo_Out8(XPAR_OPB_CLOCKCONTROLLER_0_BASEADDR + RESETCTRL, RESET);
	/* wait for a while */
	sleep(1);
	/* release the reset of the DCM */
	XIo_Out8(XPAR_OPB_CLOCKCONTROLLER_0_BASEADDR + RESETCTRL, 0);
	/* reset the phase */
	clkphase = 0;
}

void clkphase_cmd(int argc, char **argv)
/* command = "clkphase"                                    */
/* help    = "set the phase of the DLL on the user clock"  */
/* params  = "<phase in degrees>"                          */
{
	int required_clkphase, differential_clkphase;
	int i;

	if(argc!=2) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}
	
	if(argv[1][0] == '-') {
		required_clkphase = - tinysh_atoxi(argv[1] + 1);
	}
	else
		required_clkphase = tinysh_atoxi(argv[1]);
	required_clkphase *= 256;
	required_clkphase /= 180;

	if(required_clkphase > 256 || required_clkphase < -256) {
		xil_printf("This clock phase can not be reached by the DCM (max range [-180;+180])\n\r");
		return;
	}

	differential_clkphase = required_clkphase - clkphase;

	if(differential_clkphase > 0) 
		for(i=0;i<differential_clkphase;i++)
			XIo_Out8(XPAR_OPB_CLOCKCONTROLLER_0_BASEADDR + PHASECTRL, POSITIVEPHASE);

	if(differential_clkphase < 0) 
		for(i=0;i<-differential_clkphase;i++)
			XIo_Out8(XPAR_OPB_CLOCKCONTROLLER_0_BASEADDR + PHASECTRL, NEGATIVEPHASE);

	clkphase = required_clkphase;

	xil_printf("WARNING: due to a silicon bug in the Virtex 2 pro DLL, the actual phase is\n\r   dependant on the frequency of the clock. It should be measured with a scope\n\r   to guarantee a correct phase shift.\n\r");

}
