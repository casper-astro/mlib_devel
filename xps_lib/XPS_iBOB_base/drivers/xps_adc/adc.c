/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2004 Pierre-Yves droz */

/* ADC test functions */

#include "adc.h"
enum { NULLMATCH,FULLMATCH,PARTMATCH,UNMATCH,MATCH,AMBIG };

/* write an adc register
/* ********************************* */
void adc_write(int adc, Xuint32 address, Xuint32 data)
{
	Xuint32 base_address;
	int i;

	/* define what ADC to use */
	if(adc == 0) base_address = ADC0_OFFSET + XPAR_OPB_ADCCONTROLLER_0_BASEADDR;
	if(adc == 1) base_address = ADC1_OFFSET + XPAR_OPB_ADCCONTROLLER_0_BASEADDR;
	if(adc != 0 && adc != 1) return;

	/* write data and address */
	XIo_Out16(base_address + ADC_DATA_REG, (Xuint16) data   );
	XIo_Out8 (base_address + ADC_ADDR_REG, (Xuint8)  address);

	/* start transfert */
	XIo_Out8 (base_address + ADC_CTRL_REG, 0x1);

	/* wait for transfert completion */
	while(XIo_In8(base_address + ADC_CTRL_REG)&1);

}

/* reset an adc
/* ********************************* */
void adc_reset(int adc,int interleave)
{

	/* check what ADC to reset */
	switch(adc)
	{
		case 0:
			/* reset on mode pin */
			XIo_Out8(XPAR_OPB_ADCCONTROLLER_0_BASEADDR + ADC_MODEPIN_REG, 0x2);
			usleep(1000);
			XIo_Out8(XPAR_OPB_ADCCONTROLLER_0_BASEADDR + ADC_MODEPIN_REG, 0x3);
		break;
		case 1:
			/* reset on mode pin */
			XIo_Out8(XPAR_OPB_ADCCONTROLLER_0_BASEADDR + ADC_MODEPIN_REG, 0x1);
			usleep(1000);
			XIo_Out8(XPAR_OPB_ADCCONTROLLER_0_BASEADDR + ADC_MODEPIN_REG, 0x3);
		break;
	}

	usleep(1000);

	/* configure the adc for interleaved/non-interleaved mode */
	if(interleave) 
		adc_write(adc,0,0x7C2C);
	else
		adc_write(adc,0,0x7CBC);
	usleep(1000);
	/* configure the adc for clock_out shift */
	adc_write(adc,7,0x0004);			

	/* wait for a while before resetting the DDR register */
	usleep(100000);

	/* reset the DDR register */
	XIo_Out8(XPAR_OPB_ADCCONTROLLER_0_BASEADDR + ADC_RESET_REG, 0x3);

}

/* Get the phase difference between two ADCs
/* ********************************* */
int adc_getphase(int* fail)
{
	Xuint8 val;
	int i,j;
	int acc0,acc1;
	long long int0,int1,xint0,xint1;
	int phase0, phase1;
	int phase;
	int errors;

	/* DCM 0 */

	/* Bring the phase to -128 */
	for(i=0;i<128;i++)
	{
		XIo_Out8(XPAR_OPB_ADCCONTROLLER_0_BASEADDR + ADC_DCMCTRL_REG, 0x3);
		usleep(100);
	}

	/* Bring the phase to +127 and measure the sampling */
	int0    = 0;
	xint0   = 0;
	int1    = 0;
	xint1   = 0;
	errors  = 0;
	for(i=0;i<256;i++)
	{
		XIo_Out8(XPAR_OPB_ADCCONTROLLER_0_BASEADDR + ADC_DCMCTRL_REG, 0x1);
		usleep(100);
		acc0 = 0;
		acc1 = 0;
		for (j = 0;j<1000;j++)
		{
			val = XIo_In8(XPAR_OPB_ADCCONTROLLER_0_BASEADDR + ADC_DCMMEAS_REG);
			if(val & 0x01) acc0++;
			if(val & 0x02) acc1++;
		}
		if(acc0 != 0 && acc0 != 1000)
		{
			errors++;
			if(acc0 < 500)
			{
				int0  += acc0;
				xint0 += i * acc0;
			} else {
				int0  += (1000-acc0);
				xint0 += i * (1000-acc0);
			}
		}
		if(acc1 != 0 && acc1 != 1000)
		{
			errors++;
			if(acc1 < 500)
			{
				int1  += acc1;
				xint1 += i * acc1;
			} else {
				int1  += (1000-acc1);
				xint1 += i * (1000-acc1);
			}
		}
	}


	/* Bring the phase back to 0 */
	for(i=0;i<128;i++)
	{
		XIo_Out8(XPAR_OPB_ADCCONTROLLER_0_BASEADDR + ADC_DCMCTRL_REG, 0x3);
		usleep(100);
	}

	phase0 = (xint0 * 360 / int0 / 256);
	phase1 = (xint1 * 360 / int1 / 256);
	phase  = (phase0 + phase1) / 2 - 180;

	*fail = 0;
	if(errors>20 || errors<2) *fail = 1;
	return phase;

}


/* initialize the ADCs
/* ********************************* */
void adcinit()
/* init */
{
	int i;
	int adc_num[2],adc_interleave[2];
	int adc = 0;
	int phase, fail;
	for(i=0;i<NUM_CORES;i++)
		if(cores[i].type == xps_adc)
		{
			adc_num[adc] = cores[i].params[9] - '0';
			adc_interleave[adc] = (strstart(&(cores[i].params[26]),"on")==FULLMATCH);
			adc++;
		}

	if(adc==1)
		adc_reset(adc_num[0],adc_interleave[0]);
	if(adc==2)
	{
		for(i=0;i<50;i++)
		{
			adc_reset(adc_num[0],adc_interleave[0]);
			adc_reset(adc_num[1],adc_interleave[1]);
			phase = adc_getphase(&fail);
			if(fail) {
				xil_printf("\n\rERROR: ADC clocks not fed properly\n\r");
			}
			if(phase < 20 && phase > -20)
			{
				xil_printf("INFO: ADCs residual phase: %d degres (+/- 5%%), obtained after %d resets\n\r",phase,i+1);
				xil_printf("INFO: Phase is given for the FPGA clocks (ADC clock / 4)\n\r");	
				return;
			}
		}
		xil_printf("\n\rERROR: ADC clocks could not be synchronized after 50 tries\n\r");
	}
}

/* reset an ADC
/* ********************************* */
void adcreset_cmd(int argc, char **argv)
/* command = "adcreset"                  */
/* help    = "resets an ADC board"       */
/* params  = "<interleave mode> [<adc>]" */
{

	int adc, adc_start, adc_end, interleave;
	char* s;

	if(argc!=3 && argc!=2) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	if(argc == 3)
	{
		adc_start = adc_end = tinysh_atoxi(argv[2]);
	}
	if(argc == 2)
	{
		adc_start = 0;
		adc_end = 1;
	}

	interleave = tinysh_atoxi(argv[1]);

	for(adc = adc_start;adc <= adc_end;adc++)
		adc_reset(adc,interleave);

}

/* Set ADC register value */
/* ********************************* */

void adcsetreg_cmd(int argc, char **argv)
/* command = "adcsetreg"                                    */
/* help    = "sets the value of an ADC register"            */
/* params  = "<adc> <register address> <register value>"    */
{
	int adc, reg, value;

	if(argc!=4) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	adc = tinysh_atoxi(argv[1]);
	reg = tinysh_atoxi(argv[2]);
	value = tinysh_atoxi(argv[3]);
	
	adc_write(adc,reg,value);	

}

/* Set ADC register value */
/* ********************************* */

void adcgetphase_cmd(int argc, char **argv)
/* command = "adcgetphase"                                  */
/* help    = "get the clock phase between the two ADCs"     */
/* params  = ""                                             */
{
	int value, fail;

	if(argc!=1) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}
	
	value = adc_getphase(&fail);
	if(fail)
		xil_printf("Measure failed. Check that the clocks are fed properly to the ADCs\n\r");
	else
		xil_printf("Phase from ADC0 to ADC1: %d degres (+/- 5%%)\n\r", value);	
		xil_printf("INFO: Phase is given for the FPGA clocks (ADC clock / 4)\n\r");	

}
