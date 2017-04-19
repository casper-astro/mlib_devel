`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Argonne National Laboratory
// Engineer:  Timothy J Madden
// 
// Create Date:    13:29:50 04/21/2015 
// Design Name: 
// Module Name:    mkid_dac_4x 
// Project Name:   
// Target Devices: Virtex V6, Roach 2 board
// Tool versions: 
// Description: 
//Based on dac_mkid_4x_interface written by
//Bruno Serfass, Sean McHugh, Ran Duan at UC Santa Barbara
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dac_mkid_4x_interface(
 //  --------------------------------------
 //   -- differential signals from/to DAC
 //   --------------------------------------

 //   -- clock from DAC
 //-- this is a 256MHz clock divided down by 2 from the 512 MHz clock.
 // divider is on the ADCDAC board. A jumper sets this clock rate, by setting the divider.
 // the design calls for a 512MHz source clock into DACADC board, and it is divided.
 // dac and adc itself run on the 512 MHz clock. 
 // the data clokcs into DAC are 256 MHz, and use DDR type, so both edges are used.

    input dac_clk_p,//256MHz
    input dac_clk_n,
	 
//   -- clock to DAC

	 
    output dac_smpl_clk_i_p, // 256MHz, DDR
    output dac_smpl_clk_i_n,
    output dac_smpl_clk_q_p,
    output dac_smpl_clk_q_n,
	 
//  -- enable analog output for DAC
	 
	 
    output dac_sync_i_p,
    output dac_sync_i_n,
    output dac_sync_q_p,
    output dac_sync_q_n,
	 
//   -- data written to DAC
	 
	 
    output [15:0] dac_data_i_p,// on DDR 256MHz clk
    output [15:0] dac_data_i_n,
    output [15:0] dac_data_q_p,
    output [15:0] dac_data_q_n,
    output dac_not_sdenb_i,
    output dac_not_sdenb_q,
    output dac_sclk,
    output dac_sdi,
    output dac_not_reset,
	 
   
//    --------------------------------------
//    -- signals from/to design
//    --------------------------------------

//    -- clock from FPGA
	 
	 
	 
    input fpga_clk,//128MHz I think? I think this is the fabric clock?
	 
//   -- dcm locked
	 
	 
    output dac_clk_out, // this is fabric clock at 128MHz, derived from 256MHz dac clock
    output dac_clk90_out, // these clocks become fabric clocks in FOPGA if yellow ROACH MMSG 
    output dac_clk180_out, //block selects dac clock. 
    output dac_clk270_out,// 
    output dac_dcm_locked,// 
	 
// ------Yellow block ports	 
	 
    input [15:0] user_data_i0,// on 128MHz, non ddr. pos edge only
    input [15:0] user_data_i1,
    input [15:0] user_data_i2,
    input [15:0] user_data_i3,
    input [15:0] user_data_q0,
    input [15:0] user_data_q1,
    input [15:0] user_data_q2,
    input [15:0] user_data_q3,
	 
    input user_sync_i,// allows a snc ecvent, to set start of the data words, so dac knows where the data starts
    input user_sync_q,
	 
    input not_sdenb_i,// user can prog. the spi registers of dac. 
    input not_sdenb_q,// currently not using these in the matlab design.
	 
    input sclk,
    input sdi,
    input not_reset//for resetting who dac? or just spi interface. 
    );

parameter OUTPUT_CLK =1;




	 
	



wire data_i[15:0];
wire data_q[15:0];


wire clk;
wire clkdiv;


//  -----------------------------------------------------------------------
//  -- Serial input (DAC configuration)
//  -----------------------------------------------------------------------
  





	OBUF #(
	.IOSTANDARD("DEFAULT"))
	 OBUF_inst_not_sdenb_i (
	.O(dac_not_sdenb_i),
	// Buffer output (connect directly to top-level port)
	.I(not_sdenb_i)
	// Buffer input
	);



	OBUF #(.IOSTANDARD("DEFAULT")) // Specify the output I/O standard
	OBUF_inst_not_sdenb_q (
	.O(dac_not_sdenb_q),
	// Buffer output (connect directly to top-level port)
	.I(not_sdenb_q)
	// Buffer input
	);




	OBUF #(.IOSTANDARD("DEFAULT")) // Specify the output I/O standard
	OBUF_inst_sclk (
	.O(dac_sclk),
	// Buffer output (connect directly to top-level port)
	.I(sclk)
	// Buffer input
	);



	OBUF #(.IOSTANDARD("DEFAULT")) // Specify the output I/O standard
	OBUF_inst_sdi (
	.O(dac_sdi),
	// Buffer output (connect directly to top-level port)
	.I(sdi)
	// Buffer input
	);




OBUF #(.IOSTANDARD("DEFAULT")) // Specify the output I/O standard
 OBUF_inst_not_reset (
.O(dac_not_reset),
// Buffer output (connect directly to top-level port)
.I(not_reset)
// Buffer input
);


//  ----------------------------------
//  -- sync output to DAC --
//  ----------------------------------
  
 OBUFDS #(.IOSTANDARD("LVDS_25"))
		OBUFDS_inst_dac_sync_i
		(
      .O(dac_sync_i_p),
      .OB(dac_sync_i_n),
      .I(user_sync_i)
      );

 OBUFDS #(.IOSTANDARD("LVDS_25"))
		OBUFDS_inst_dac_sync_q
      (
      .O(dac_sync_q_p),
      .OB(dac_sync_q_n),
      .I(user_sync_q)
      );
		
		
 //  ---------------------------------------
 // -- Data to DAC using OSERDES
 // ----------------------------------------
  
 // -- signal I --
		
   
 genvar index;
 generate
 for (index =0; index<16; index = index + 1)
 begin: OSERDES_inst_data_i_generate
 
	OSERDESE1 #(
		.DATA_RATE_OQ("DDR"),
		.DATA_RATE_TQ("BUF"),
		.DATA_WIDTH(4),
		.DDR3_DATA(1),
		.INIT_OQ(1'b0),
		.INIT_TQ(1'b0),
		.INTERFACE_TYPE("DEFAULT"), // Must leave at "DEFAULT" (MIG-only parameter)
		.ODELAY_USED(0),
		.SERDES_MODE("MASTER"),
		.SRVAL_OQ(1'b0),
		.SRVAL_TQ(1'b0),
		.TRISTATE_WIDTH(1)
		)
	OSERDESE1_inst_data_i (
		// 1-bit output: Leave unconnected (MIG-only connected signal)
		// Outputs: 1-bit (each) output: Serial output ports
		.OFB(),// 1-bit output: Data feedback output to ISERDESE1
		.OQ(data_i[index]),// 1-bit output: Data output (connect to I/O port)
		.TFB(),// 1-bit output: 3-state control output
		.TQ(),// 1-bit output: 3-state path output
		// SHIFTOUT1-SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
		.SHIFTOUT1(),// 1-bit output: Connect to SHIFTIN1 of slave or unconnected
		.SHIFTOUT2(),// 1-bit output: Connect to SHIFTIN2 of slave or unconnected
		// Clocks: 1-bit (each) input: OSERDESE1 clock input ports
		.CLK(clk),// 1-bit input: High-speed clock input- This is 256MHz, DDR, both edes.
		.CLKDIV(clkdiv),// 1-bit input: Divided clock input- this is 128MHz
		// Control Signals: 1-bit (each) input: Clock enable and reset input ports
		.OCE(1'b1),// 1-bit input: Active high clock data path enable input
		.RST(1'b0),// 1-bit input: Active high reset input
		.TCE(1'b1),// 1-bit input: Active high clock enable input for 3-state
		// D1 - D6: 1-bit (each) input: Parallel data inputs
		.D1(user_data_i0[index]),
		.D2(user_data_i1[index]),
		.D3(user_data_i2[index]),
		.D4(user_data_i3[index]),
		.D5(1'b0),
		.D6(1'b0),
		// SHIFTIN1-SHIFTIN2: 1-bit (each) input: Data width expansion input ports
		.SHIFTIN1(1'b0),// 1-bit input: Connect to SHIFTOUT1 of master or GND
		.SHIFTIN2(1'b0),// 1-bit input: Connect to SHIFTOUT2 of master or GND
		// T1 - T4: 1-bit (each) input: Parallel 3-state inputs
		.T1(1'b0),
		.T2(1'b1),
		.T3(1'b1),
		.T4(1'b1)
		);

	OBUFDS #(.IOSTANDARD("LVDS_25"))
	OBUFDS_inst_data1_i (
        .O(dac_data_i_p[index]),
        .OB(dac_data_i_n[index]),
        .I(data_i[index])
        );



end
endgenerate



 // -- signal Q --
		
   
 generate
 for (index =0; index<16; index = index + 1)
 begin: OSERDES_inst_data_q_generate
 
	OSERDESE1 #(
		.DATA_RATE_OQ("DDR"),
		.DATA_RATE_TQ("BUF"),
		.DATA_WIDTH(4),
		.DDR3_DATA(1),
		.INIT_OQ(1'b0),
		.INIT_TQ(1'b0),
		.INTERFACE_TYPE("DEFAULT"), // Must leave at "DEFAULT" (MIG-only parameter)
		.ODELAY_USED(0),
		.SERDES_MODE("MASTER"),
		.SRVAL_OQ(1'b0),
		.SRVAL_TQ(1'b0),
		.TRISTATE_WIDTH(1)
		)
	OSERDESE1_inst_data_q (
		// 1-bit output: Leave unconnected (MIG-only connected signal)
		// Outputs: 1-bit (each) output: Serial output ports
		.OFB(),// 1-bit output: Data feedback output to ISERDESE1
		.OQ(data_q[index]),// 1-bit output: Data output (connect to I/O port)- on 256MHz DDR
		.TFB(),// 1-bit output: 3-state control output
		.TQ(),// 1-bit output: 3-state path output
		// SHIFTOUT1-SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
		.SHIFTOUT1(),// 1-bit output: Connect to SHIFTIN1 of slave or unconnected
		.SHIFTOUT2(),// 1-bit output: Connect to SHIFTIN2 of slave or unconnected
		// Clocks: 1-bit (each) input: OSERDESE1 clock input ports
		.CLK(clk),// 1-bit input: High-speed clock input= 256MHz, DDDR
		.CLKDIV(clkdiv),// 1-bit input: Divided clock input 128MHz
		// Control Signals: 1-bit (each) input: Clock enable and reset input ports
		.OCE(1'b1),// 1-bit input: Active high clock data path enable input
		.RST(1'b0),// 1-bit input: Active high reset input
		.TCE(1'b1),// 1-bit input: Active high clock enable input for 3-state
		// D1 - D6: 1-bit (each) input: Parallel data inputs
		.D1(user_data_q0[index]),//come in on 128MHz clock
		.D2(user_data_q1[index]),
		.D3(user_data_q2[index]),
		.D4(user_data_q3[index]),
		.D5(1'b0),
		.D6(1'b0),
		// SHIFTIN1-SHIFTIN2: 1-bit (each) input: Data width expansion input ports
		.SHIFTIN1(1'b0),// 1-bit input: Connect to SHIFTOUT1 of master or GND
		.SHIFTIN2(1'b0),// 1-bit input: Connect to SHIFTOUT2 of master or GND
		// T1 - T4: 1-bit (each) input: Parallel 3-state inputs
		.T1(1'b0),
		.T2(1'b1),
		.T3(1'b1),
		.T4(1'b1)
		);

	OBUFDS #(.IOSTANDARD("LVDS_25"))
	OBUFDS_inst_data1_q (
        .O(dac_data_q_p[index]),
        .OB(dac_data_q_n[index]),
        .I(data_q[index])
        );



end
endgenerate



  //---------------------------------------
  //-- Clock driver (use also OSERDES
  //-- to match delay with data)
  //------------------------------------------
  


	OSERDESE1 #(
		.DATA_RATE_OQ("DDR"),
		.DATA_RATE_TQ("BUF"),
		.DATA_WIDTH(4),
		.DDR3_DATA(1),
		.INIT_OQ(1'b0),
		.INIT_TQ(1'b0),
		.INTERFACE_TYPE("DEFAULT"), // Must leave at "DEFAULT" (MIG-only parameter)
		.ODELAY_USED(0),
		.SERDES_MODE("MASTER"),
		.SRVAL_OQ(1'b0),
		.SRVAL_TQ(1'b0),
		.TRISTATE_WIDTH(1)
		)
	OSERDESE1_inst_clki (
		// 1-bit output: Leave unconnected (MIG-only connected signal)
		// Outputs: 1-bit (each) output: Serial output ports
		.OFB(),// 1-bit output: Data feedback output to ISERDESE1
		.OQ(data_clk_i),// 1-bit output: Data output (connect to I/O port)
		.TFB(),// 1-bit output: 3-state control output
		.TQ(),// 1-bit output: 3-state path output
		// SHIFTOUT1-SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
		.SHIFTOUT1(),// 1-bit output: Connect to SHIFTIN1 of slave or unconnected
		.SHIFTOUT2(),// 1-bit output: Connect to SHIFTIN2 of slave or unconnected
		// Clocks: 1-bit (each) input: OSERDESE1 clock input ports
		.CLK(clk),// 1-bit input: High-speed clock input- 256MHz
		.CLKDIV(clkdiv),// 1-bit input: Divided clock input - 128MHz
		// Control Signals: 1-bit (each) input: Clock enable and reset input ports
		.OCE(1'b1),// 1-bit input: Active high clock data path enable input
		.RST(1'b0),// 1-bit input: Active high reset input
		.TCE(1'b1),// 1-bit input: Active high clock enable input for 3-state
		// D1 - D6: 1-bit (each) input: Parallel data inputs
		.D1(1'b0),// use 1010 output to make 256 ddr clock -10101010 etc...
		.D2(1'b1),
		.D3(1'b0),
		.D4(1'b1),
		.D5(1'b0),
		.D6(1'b0),
		// SHIFTIN1-SHIFTIN2: 1-bit (each) input: Data width expansion input ports
		.SHIFTIN1(1'b0),// 1-bit input: Connect to SHIFTOUT1 of master or GND
		.SHIFTIN2(1'b0),// 1-bit input: Connect to SHIFTOUT2 of master or GND
		// T1 - T4: 1-bit (each) input: Parallel 3-state inputs
		.T1(1'b0),
		.T2(1'b1),
		.T3(1'b1),
		.T4(1'b1)
		);




	OSERDESE1 #(
		.DATA_RATE_OQ("DDR"),
		.DATA_RATE_TQ("BUF"),
		.DATA_WIDTH(4),
		.DDR3_DATA(1),
		.INIT_OQ(1'b0),
		.INIT_TQ(1'b0),
		.INTERFACE_TYPE("DEFAULT"), // Must leave at "DEFAULT" (MIG-only parameter)
		.ODELAY_USED(0),
		.SERDES_MODE("MASTER"),
		.SRVAL_OQ(1'b0),
		.SRVAL_TQ(1'b0),
		.TRISTATE_WIDTH(1)
		)
	OSERDESE1_inst_clkq (
		// 1-bit output: Leave unconnected (MIG-only connected signal)
		// Outputs: 1-bit (each) output: Serial output ports
		.OFB(),// 1-bit output: Data feedback output to ISERDESE1
		.OQ(data_clk_q),// 1-bit output: Data output (connect to I/O port)
		.TFB(),// 1-bit output: 3-state control output
		.TQ(),// 1-bit output: 3-state path output
		// SHIFTOUT1-SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
		.SHIFTOUT1(),// 1-bit output: Connect to SHIFTIN1 of slave or unconnected
		.SHIFTOUT2(),// 1-bit output: Connect to SHIFTIN2 of slave or unconnected
		// Clocks: 1-bit (each) input: OSERDESE1 clock input ports
		.CLK(clk),// 1-bit input: High-speed clock input- 256MHz syncronzed...
		.CLKDIV(clkdiv),// 1-bit input: Divided clock input- 128MHz,
		// Control Signals: 1-bit (each) input: Clock enable and reset input ports
		.OCE(1'b1),// 1-bit input: Active high clock data path enable input
		.RST(1'b0),// 1-bit input: Active high reset input
		.TCE(1'b1),// 1-bit input: Active high clock enable input for 3-state
		// D1 - D6: 1-bit (each) input: Parallel data inputs
		.D1(1'b0),
		.D2(1'b1),
		.D3(1'b0),
		.D4(1'b1),
		.D5(1'b0),
		.D6(1'b0),
		// SHIFTIN1-SHIFTIN2: 1-bit (each) input: Data width expansion input ports
		.SHIFTIN1(1'b0),// 1-bit input: Connect to SHIFTOUT1 of master or GND
		.SHIFTIN2(1'b0),// 1-bit input: Connect to SHIFTOUT2 of master or GND
		// T1 - T4: 1-bit (each) input: Parallel 3-state inputs
		.T1(1'b0),
		.T2(1'b1),
		.T3(1'b1),
		.T4(1'b1)
		);



	OBUFDS #(.IOSTANDARD("LVDS_25"))
	OBUFDS_inst_smpl_clk_i (
        .O(dac_smpl_clk_i_p),
        .OB(dac_smpl_clk_i_n),
        .I(data_clk_i)
        );



	OBUFDS #(.IOSTANDARD("LVDS_25"))
	OBUFDS_inst_smpl_clk_q (
        .O(dac_smpl_clk_q_p),
        .OB(dac_smpl_clk_q_n),
        .I(data_clk_q)
        );


//  -----------------------------------
//  -- Clock  Management 
//  -----------------------------------
   
//  -- Use clk from DAC, output to FPGA

// dac_clk_in - single ended input clk from dac. 256MHz
// dcm_clk_in- same as dac_clk_in but thru fpga global clk driver. 256MHz.
//				drives MMCMs at 256MHz.

// dcm_clk, 90,180,270, outptu of MMCM, the 90, 180,270 is unused...128MHz
// clkdiv- 128MHz, buffered dcm_clk, from fpga glob clk driver.
//clkdiv 90, 180, 270, phase altered versions, of clkdiv, not used, and at 128MHz


	generate
	if(OUTPUT_CLK==1)
	begin

	// get clock from DAC
	
	IBUFGDS #(
		.IOSTANDARD("LVDS_25")
		) 
		IBUFGDS_inst_dac_clk (
		.O(dac_clk_in), // Clock buffer
		.I(dac_clk_p), // Diff_p clock
		.IB(dac_clk_n) // Diff_n clock
		);

//    -- this is input to MMCM. 
   
		// BUFG: Global Clock Buffer
		//Virtex-6
		// Xilinx HDL Libraries Guide, version 13.1
		BUFG BUFG_clk_dac (
		.O(dcm_clk_in), // 1-bit output: Clock buffer output
		.I(dac_clk_in) // 1-bit input: Clock buffer input
		);

	
    
   // -- buffer DCM output

    //-- dcm_clk_in divided by 2 in DCM so all the 0,90,180,270
    //-- 
  
    //-- clk    = dcm_clk_in (however divided, then multiplied by 2 in DCM so
    //--           that it is synchronize qith clkdiv)
    //-- clkdiv = dcm_clk_in divided by 2 =  DAC/ADC sample rate / 4. DDR clk is used so actual clk is sample rate/2

   
		BUFG BUFG_clk (
		.O(clkdiv), // 1-bit output: Clock buffer output
		.I(dcm_clk) // 1-bit input: Clock buffer input
		);


		BUFG BUFG_clk2x (
		.O(clk), // 1-bit output: Clock buffer output
		.I(dcm_clk2x) // 1-bit input: Clock buffer input
		);


		BUFG BUFG_clk90 (
		.O(clk90div), // 1-bit output: Clock buffer output
		.I(dcm_clk90) // 1-bit input: Clock buffer input
		);

 

		BUFG BUFG_clk180 (
		.O(clk180div), // 1-bit output: Clock buffer output
		.I(dcm_clk180) // 1-bit input: Clock buffer input
		);
 
 		BUFG BUFG_clk270 (
		.O(clk270div), // 1-bit output: Clock buffer output
		.I(dcm_clk270) // 1-bit input: Clock buffer input
		);
 
   
	//128MHz clocks, with 4 phases. I guess drives FPGA fabric? based on DAC clk?
    assign dac_clk_out = clkdiv;// this deives oserdes. all of thiese clocks can be sel to drive 
    assign dac_clk90_out = clk90div;//  fpga fabric based on ROACH MMSE setup block
    assign dac_clk180_out = clk180div;// 
    assign dac_clk270_out = clk270div;// 

//take 256MHz dac clk, buffered version called dcm_clk_in and generate 4 phases of 128MHz clockls
// tjhese clocks will be aligned with dcm_clk_in using feed back loop.
// we also generate a 256MHz clkdiv2x, with proper alignment with all the 128MHz clockls.
//this MMCM is generated of on the yellow block ROACH MMSE, if we select dac clk. to drive fabric in yellow 
// ROACH MMSE block then dac_clk out will be the fpga fabric clock. phased vbersion will be used too. 

// (FVCO = 1000*CLKFBOUT_MULT_F/(CLKIN1_PERIOD*DIVCLK_DIVIDE))

  MMCM_BASE #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming ("HIGH","LOW","OPTIMIZED")
      .CLKFBOUT_MULT_F(8.0),     // Multiply value for all CLKOUT (5.0-64.0).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (0.00-360.00).
      .CLKIN1_PERIOD(3.906),       // 256MHz Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      .CLKOUT0_DIVIDE_F(8.0),    // Divide amount for CLKOUT0 (1.000-128.000).
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.5),
      .CLKOUT2_DUTY_CYCLE(0.5),
      .CLKOUT3_DUTY_CYCLE(0.5),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),//128MHz
      .CLKOUT1_PHASE(90.0),
      .CLKOUT2_PHASE(180.0),
      .CLKOUT3_PHASE(270.0),
      .CLKOUT4_PHASE(0.0),//256MHz
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      // CLKOUT1_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT1_DIVIDE(8),//these must be 128MHz
      .CLKOUT2_DIVIDE(8),
      .CLKOUT3_DIVIDE(8),
      .CLKOUT4_DIVIDE(4),//these must be 256MHz
      .CLKOUT5_DIVIDE(8),
      .CLKOUT6_DIVIDE(8),
      .CLKOUT4_CASCADE("FALSE"), // Cascase CLKOUT4 counter with CLKOUT6 (TRUE/FALSE)
      .CLOCK_HOLD("FALSE"),      // Hold VCO Frequency (TRUE/FALSE)
      .DIVCLK_DIVIDE(2),         // Master division value (1-80)
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      .STARTUP_WAIT("FALSE")     // Not supported. Must be set to FALSE.
   )
   MMCM_BASE_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(dcm_clk),     // 1-bit output: CLKOUT0 output- 128MHz
      .CLKOUT0B(),   // 1-bit output: Inverted CLKOUT0 output
      .CLKOUT1(dcm_clk90),     // 1-bit output: CLKOUT1 output- 128MHz
      .CLKOUT1B(),   // 1-bit output: Inverted CLKOUT1 output
      .CLKOUT2(dcm_clk180),     // 1-bit output: CLKOUT2 output- 128MHz
      .CLKOUT2B(),   // 1-bit output: Inverted CLKOUT2 output
      .CLKOUT3(dcm_clk270),     // 1-bit output: CLKOUT3 output- 128MHz
      .CLKOUT3B(),   // 1-bit output: Inverted CLKOUT3 output
      .CLKOUT4(dcm_clk2x),     // 1-bit output: CLKOUT4 output- 256MHz
      .CLKOUT5(),     // 1-bit output: CLKOUT5 output
      .CLKOUT6(),     // 1-bit output: CLKOUT6 output
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(),   // 1-bit output: Feedback clock output
      .CLKFBOUTB(), // 1-bit output: Inverted CLKFBOUT output
      // Status Port: 1-bit (each) output: MMCM status ports
      .LOCKED(dac_dcm_locked),       // 1-bit output: LOCK output
      // Clock Input: 1-bit (each) input: Clock input
      .CLKIN1(dcm_clk_in),//256MHz, a buffered version of raw dac input clock.
      // Control Ports: 1-bit (each) input: MMCM control ports
      .PWRDWN(1'b0),       // 1-bit input: Power-down input
      .RST(1'b0),             // 1-bit input: Reset input
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(clkdiv)      // 1-bit input: Feedback clock input- this is dcm_clk, at 128MHz, but buffered. makes
										//makes sure that the mmcm output (dcm_clk) is aligned with buffer delay.
										// clkdiv will be aligned with dcm_clk_in, or dac clock. clk div is 128M, dac clk is 256M
   );


	end
	endgenerate








//  -----------------------------------
//  -- Clock  Management - if ROACH MMSG yellow block selects system clock (assume 128MHz) for fabric.
//  -----------------------------------
   
//  -- Use clk from FPGA, generate DAC data clocks

// dac_clk_in - single ended input clk from dac. 256MHz
// dcm_clk_in- same as dac_clk_in but thru fpga global clk driver. 256MHz.
//				drives MMCMs at 256MHz.

// dcm_clk, 90,180,270, outptu of MMCM, the 90, 180,270 is unused...128MHz
// clkdiv- 128MHz, buffered dcm_clk, from fpga glob clk driver.
//clkdiv 90, 180, 270, phase altered versions, of clkdiv, not used, and at 128MHz


	generate
	if(OUTPUT_CLK==0)
	begin

	// get clock from FPGA
	
	
	   
  //  -- clock from FPGA
  
    
	 
		// BUFG: Global Clock Buffer
		//Virtex-6
		// Xilinx HDL Libraries Guide, version 13.1
		BUFG BUFG_clkfpga (
		.O(dcm_clk_in), // 1-bit output: Clock buffer output- 128MHz, buffered
		.I(fpga_clk) // 1-bit input: Clock buffer input - raw 128MHz 
		);

	 
	 
	 
 //   -- buffer DCM output

   // -- clk    = 2xFPGA (or DAC/ADC sampe rate divided by 2)- 256MHz
   // -- clkdiv = FPGA clk (or DAC/ADC sample rate divided by 4) - 128MHz
    
		
	BUFG BUFG_clk2x (
		.O(clk), // 1-bit output: Clock buffer output- 256MHz, buffered
		.I(dcm_clk2x) // 1-bit input: mmc output, 256MHz
		);
		
		
  
	BUFG BUFG_clk (
		.O(clkdiv), // 1-bit output: Clock buffer output- 128MHz, buffered
		.I(dcm_clk) // 1-bit input:dcm out - raw 128MHz 
		);
	
	

//    -- this is input to MMCM. 
   
	
    
   // -- buffer DCM output

    //-- dcm_clk_in divided by 2 in DCM so all the 0,90,180,270
    //-- 
  
    //-- clk    = dcm_clk_in (however divided, then multiplied by 2 in DCM so
    //--           that it is synchronize qith clkdiv)
    //-- clkdiv = dcm_clk_in divided by 2 =  DAC/ADC sample rate / 4. DDR clk is used so actual clk is sample rate/2

   
	

		BUFG BUFG_clk90 (
		.O(clk90div), // 1-bit output: Clock buffer output
		.I(dcm_clk90) // 1-bit input: Clock buffer input
		);

 

		BUFG BUFG_clk180 (
		.O(clk180div), // 1-bit output: Clock buffer output
		.I(dcm_clk180) // 1-bit input: Clock buffer input
		);
 
 		BUFG BUFG_clk270 (
		.O(clk270div), // 1-bit output: Clock buffer output
		.I(dcm_clk270) // 1-bit input: Clock buffer input
		);
 
   
	//128MHz clocks, with 4 phases. I guess drives FPGA fabric? based on DAC clk?
    assign dac_clk_out = clkdiv;// this deives oserdes. all of thiese clocks can be sel to drive 
    assign dac_clk90_out = clk90div;//  fpga fabric based on ROACH MMSE setup block
    assign dac_clk180_out = clk180div;// 
    assign dac_clk270_out = clk270div;// 

//take 256MHz dac clk, buffered version called dcm_clk_in and generate 4 phases of 128MHz clockls
// tjhese clocks will be aligned with dcm_clk_in using feed back loop.
// we also generate a 256MHz clkdiv2x, with proper alignment with all the 128MHz clockls.
//this MMCM is generated of on the yellow block ROACH MMSE, if we select dac clk. to drive fabric in yellow 
// ROACH MMSE block then dac_clk out will be the fpga fabric clock. phased vbersion will be used too. 

  MMCM_BASE #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming ("HIGH","LOW","OPTIMIZED")
      .CLKFBOUT_MULT_F(8.0),     // Multiply value for all CLKOUT (5.0-64.0).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (0.00-360.00).
      .CLKIN1_PERIOD(7.812),       // 256MHz Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      .CLKOUT0_DIVIDE_F(8.0),    // Divide amount for CLKOUT0 (1.000-128.000).
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.5),
      .CLKOUT2_DUTY_CYCLE(0.5),
      .CLKOUT3_DUTY_CYCLE(0.5),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(90.0),
      .CLKOUT2_PHASE(180.0),
      .CLKOUT3_PHASE(270.0),
      .CLKOUT4_PHASE(0.0),
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      // CLKOUT1_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT1_DIVIDE(8),//these must be 128MHz
      .CLKOUT2_DIVIDE(8),
      .CLKOUT3_DIVIDE(8),
      .CLKOUT4_DIVIDE(4),//these must be 256MHz
      .CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(1),
      .CLKOUT4_CASCADE("FALSE"), // Cascase CLKOUT4 counter with CLKOUT6 (TRUE/FALSE)
      .CLOCK_HOLD("FALSE"),      // Hold VCO Frequency (TRUE/FALSE)
      .DIVCLK_DIVIDE(1),         // Master division value (1-80)
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      .STARTUP_WAIT("FALSE")     // Not supported. Must be set to FALSE.
   )
   MMCM_BASE_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(dcm_clk),     // 1-bit output: CLKOUT0 output- 128MHz
      .CLKOUT0B(),   // 1-bit output: Inverted CLKOUT0 output
      .CLKOUT1(dcm_clk90),     // 1-bit output: CLKOUT1 output- 128MHz
      .CLKOUT1B(),   // 1-bit output: Inverted CLKOUT1 output
      .CLKOUT2(dcm_clk180),     // 1-bit output: CLKOUT2 output- 128MHz
      .CLKOUT2B(),   // 1-bit output: Inverted CLKOUT2 output
      .CLKOUT3(dcm_clk270),     // 1-bit output: CLKOUT3 output- 128MHz
      .CLKOUT3B(),   // 1-bit output: Inverted CLKOUT3 output
      .CLKOUT4(dcm_clk2x),     // 1-bit output: CLKOUT4 output- 256MHz
      .CLKOUT5(),     // 1-bit output: CLKOUT5 output
      .CLKOUT6(),     // 1-bit output: CLKOUT6 output
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(),   // 1-bit output: Feedback clock output
      .CLKFBOUTB(), // 1-bit output: Inverted CLKFBOUT output
      // Status Port: 1-bit (each) output: MMCM status ports
      .LOCKED(dac_dcm_locked),       // 1-bit output: LOCK output
      // Clock Input: 1-bit (each) input: Clock input
      .CLKIN1(dcm_clk_in),//256MHz, a buffered version of raw dac input clock.
      // Control Ports: 1-bit (each) input: MMCM control ports
      .PWRDWN(1'b0),       // 1-bit input: Power-down input
      .RST(1'b0),             // 1-bit input: Reset input
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(clkdiv)      // 1-bit input: Feedback clock input- this is dcm_clk, at 128MHz, but buffered. makes
										//makes sure that the mmcm output (dcm_clk) is aligned with buffer delay.
										// clkdiv will be aligned with dcm_clk_in, or dac clock. clk div is 128M, dac clk is 256M
   );


	end
	endgenerate










endmodule
