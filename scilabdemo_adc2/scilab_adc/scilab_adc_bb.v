
module scilab_adc (
	clk_clk,
	hps_0_h2f_reset_reset_n,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	reset_reset_n,
	adc_ltc2308_0_adc_conduit_adc_convst,
	adc_ltc2308_0_adc_conduit_adc_sck,
	adc_ltc2308_0_adc_conduit_adc_sdi,
	adc_ltc2308_0_adc_conduit_adc_sdo);	

	input		clk_clk;
	output		hps_0_h2f_reset_reset_n;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	input		reset_reset_n;
	output		adc_ltc2308_0_adc_conduit_adc_convst;
	output		adc_ltc2308_0_adc_conduit_adc_sck;
	output		adc_ltc2308_0_adc_conduit_adc_sdi;
	input		adc_ltc2308_0_adc_conduit_adc_sdo;
endmodule
