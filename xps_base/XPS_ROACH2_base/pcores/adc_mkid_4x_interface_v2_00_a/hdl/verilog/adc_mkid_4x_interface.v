`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Argonne National Laboratory
// Engineer: Timothy Madden
// 
// Create Date:    10:12:07 04/27/2015 
// Design Name: 
// Module Name:    adc_mkid_4x_interface 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:  Adapted for V6, based on 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module adc_mkid_4x_interface(
    
    //--------------------------------------
   // -- differential signals in from ADC
    //--------------------------------------
    
    //-- data ready clock from ADC
    input DRDY_I_p,
    input DRDY_I_n,
    input DRDY_Q_p,
    input DRDY_Q_n,
    
    //-- external port for synching multiple boards
    input ADC_ext_in_p,
    input ADC_ext_in_n,
    
    //-- data read from ADC (12 bits)
    input [11:0]DI_p,
    input [11:0]DI_n,
    input [11:0]DQ_p,
    input [11:0]DQ_n,
    
      
    //--------------------------------------
    //-- signals to/from design
    //--------------------------------------
    
    //-- clock from FPGA    
    input fpga_clk,

    //-- clock to FPGA
    output adc_clk_out,
    output adc_clk90_out,
    output adc_clk180_out,
    output adc_clk270_out,

   // -- dcm locked 
    output adc_dcm_locked,

    //-- yellow block ports
    output [11:0]user_data_i0,
    output [11:0]user_data_i1,
    output [11:0]user_data_i2,
    output [11:0]user_data_i3,
    
    output [11:0]user_data_q0,
    output [11:0]user_data_q1,
    output [11:0]user_data_q2,
    output [11:0]user_data_q3,

    output user_sync


    );
	 
parameter MADDOG_CLK=1;

	 
parameter OUTPUT_CLK=1;



  wire drdy_clk;
  wire data_clk;
   
  wire [11:0]data_i;
  wire [11:0]data_q;
  
  wire [11:0]data_serdes_i0;
  wire [11:0]data_serdes_i1;
  wire [11:0]data_serdes_i2;
  wire [11:0]data_serdes_i3;
  wire [11:0]data_serdes_q0;
  wire [11:0]data_serdes_q1;
  wire [11:0]data_serdes_q2;
  wire [11:0]data_serdes_q3;

  reg [11:0]recapture_data_i0; 
  reg [11:0]recapture_data_i1; 
  reg [11:0]recapture_data_i2; 
  reg [11:0]recapture_data_i3; 
  reg [11:0]recapture_data_q0; 
  reg [11:0]recapture_data_q1; 
  reg [11:0]recapture_data_q2; 
  reg [11:0]recapture_data_q3; 
  
  wire [47:0]fifo_in_q;
  wire [47:0]fifo_out_q;
  wire [47:0]fifo_in_i;
  wire [47:0]fifo_out_i;

  wire dcm_clk_in;
  wire dcm_clk  ;
  wire dcm_clk2x ;
  wire dcm_clk90 ;
  wire dcm_clk180 ;
  wire dcm_clk270;

  wire clk ;
  wire clkdiv;     
  wire clkinv;
  wire clk90div;
  wire clk180div;
  wire clk270div;

     
  wire fifo_rd_en;//1
  wire fifo_wr_en;//1
  wire fifo_rst;//0
  wire fifo_empty_i;
  wire fifo_empty_q;
  wire fifo_full_i;
  wire fifo_full_q;

  

assign fifo_rd_en = 1'b1;
assign fifo_wr_en = 1'b1;
assign fifo_rst = 1'b0;


/***********************
  ----------------------------------------
  -- Asynchronous FIFO
  ----------------------------------------
  component async_fifo_48x128
    port (
      din: IN std_logic_VECTOR(47 downto 0);
      rd_clk: IN std_logic;
      rd_en: IN std_logic;
      rst: IN std_logic;
      wr_clk: IN std_logic;
      wr_en: IN std_logic;
      dout: OUT std_logic_VECTOR(47 downto 0);
      empty: OUT std_logic;
      full: OUT std_logic);
  end component;
*/



 // ------------------------------------------------------
 // -- ADC data inputs --
 // -- 	Requires an IDDR to double the data rate, and an 
 // --	IBUFDS to convert from a differential signal.
 // ------------------------------------------------------
  
 // -- ADC input I --


genvar j;
generate
for (j=0; j<12;j=j+1)
begin: IBUFDS_inst_data_i_generate

	IBUFDS #(.IOSTANDARD("LVDS_25"))
	IBUFDS_inst_data_i (
		.O(data_i[j]),
      .I(DI_p[j]),
      .IB(DI_n[j])
	);
end
	
endgenerate


generate
for (j=0; j<12;j=j+1)
begin: ISERDES_NODELAY_inst_i_generate 


   ISERDESE1 #(
      .DATA_RATE("DDR"),           // "SDR" or "DDR" 
      .DATA_WIDTH(4),              // Parallel data width (2-8, 10)
      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (TRUE/FALSE)
      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (TRUE/FALSE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      .INIT_Q1(1'b0),
      .INIT_Q2(1'b0),
      .INIT_Q3(1'b0),
      .INIT_Q4(1'b0),
      .INTERFACE_TYPE("NETWORKING"),   // "MEMORY", "MEMORY_DDR3", "MEMORY_QDR", "NETWORKING", or "OVERSAMPLE" 
      .IOBDELAY("NONE"),           // "NONE", "IBUF", "IFD", "BOTH" 
      .NUM_CE(1),                  // Number of clock enables (1 or 2)
      .OFB_USED("FALSE"),          // Select OFB path (TRUE/FALSE)
      .SERDES_MODE("MASTER"),      // "MASTER" or "SLAVE" 
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      .SRVAL_Q1(1'b0),
      .SRVAL_Q2(1'b0),
      .SRVAL_Q3(1'b0),
      .SRVAL_Q4(1'b0) 
   )
   ISERDES_NODELAY_inst_i (
      .O(O),                       // 1-bit output: Combinatorial output
      // Q1 - Q6: 1-bit (each) output: Registered data outputs
      .Q1(data_serdes_i3[j]),
      .Q2(data_serdes_i2[j]),
      .Q3(data_serdes_i1[j]),
      .Q4(data_serdes_i0[j]),
      .Q5(),
      .Q6(),
		
      // SHIFTOUT1-SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      .SHIFTOUT1(),
      .SHIFTOUT2(),
      .BITSLIP(1'b0),           // 1-bit input: Bitslip enable input
      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      .CE1(1'b1),
      .CE2(1'b0),
      // Clocks: 1-bit (each) input: ISERDESE1 clock input ports
      .CLK(clk),                   // 1-bit input: High-speed clock input
      .CLKB(!clk),                 // 1-bit input: High-speed secondary clock input
      .CLKDIV(clkdiv),             // 1-bit input: Divided clock input
      .OCLK(1'b0),                 // 1-bit input: High speed output clock input used when
                                   // INTERFACE_TYPE="MEMORY" 

      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion input
      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion input
      // Input Data: 1-bit (each) input: ISERDESE1 data input ports
      .D(data_i[j]),                       // 1-bit input: Data input
      .DDLY(1'b0),                 // 1-bit input: Serial input data from IODELAYE1
      .OFB(OFB),                   // 1-bit input: Data feedback input from OSERDESE1
      .RST(1'b0),                   // 1-bit input: Active high asynchronous reset input
      // SHIFTIN1-SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0) 
   );

end
endgenerate
      
//  -- ADC input Q --

generate
for (j=0; j<12;j=j+1)
begin: IBUFDS_inst_data_q_generate 


	IBUFDS #(.IOSTANDARD("LVDS_25"))
	IBUFDS_inst_data_q
	(
	     .O(data_q[j]),
        .I(DQ_p[j]),
        .IB(DQ_n[j])
	);
end
 endgenerate

generate
for (j=0; j<12;j=j+1)
begin: ISERDES_NODELAY_inst_q_generate


   ISERDESE1 #(
      .DATA_RATE("DDR"),           // "SDR" or "DDR" 
      .DATA_WIDTH(4),              // Parallel data width (2-8, 10)
      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (TRUE/FALSE)
      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (TRUE/FALSE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      .INIT_Q1(1'b0),
      .INIT_Q2(1'b0),
      .INIT_Q3(1'b0),
      .INIT_Q4(1'b0),
      .INTERFACE_TYPE("NETWORKING"),   // "MEMORY", "MEMORY_DDR3", "MEMORY_QDR", "NETWORKING", or "OVERSAMPLE" 
      .IOBDELAY("NONE"),           // "NONE", "IBUF", "IFD", "BOTH" 
      .NUM_CE(1),                  // Number of clock enables (1 or 2)
      .OFB_USED("FALSE"),          // Select OFB path (TRUE/FALSE)
      .SERDES_MODE("MASTER"),      // "MASTER" or "SLAVE" 
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      .SRVAL_Q1(1'b0),
      .SRVAL_Q2(1'b0),
      .SRVAL_Q3(1'b0),
      .SRVAL_Q4(1'b0) 
   )
   ISERDES_NODELAY_inst_q (
      .O(O),                       // 1-bit output: Combinatorial output
      // Q1 - Q6: 1-bit (each) output: Registered data outputs
      .Q1(data_serdes_q3[j]),
      .Q2(data_serdes_q2[j]),
      .Q3(data_serdes_q1[j]),
      .Q4(data_serdes_q0[j]),
      .Q5(),
      .Q6(),
		
      // SHIFTOUT1-SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      .SHIFTOUT1(),
      .SHIFTOUT2(),
      .BITSLIP(1'b0),           // 1-bit input: Bitslip enable input
      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      .CE1(1'b1),
      .CE2(1'b0),
      // Clocks: 1-bit (each) input: ISERDESE1 clock input ports
      .CLK(clk),                   // 1-bit input: High-speed clock input
      .CLKB(!clk),                 // 1-bit input: High-speed secondary clock input
      .CLKDIV(clkdiv),             // 1-bit input: Divided clock input
      .OCLK(1'b0),                 // 1-bit input: High speed output clock input used when
                                   // INTERFACE_TYPE="MEMORY" 

      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion input
      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion input
      // Input Data: 1-bit (each) input: ISERDESE1 data input ports
      .D(data_q[j]),                       // 1-bit input: Data input
      .DDLY(1'b0),                 // 1-bit input: Serial input data from IODELAYE1
      .OFB(OFB),                   // 1-bit input: Data feedback input from OSERDESE1
      .RST(1'b0),                   // 1-bit input: Active high asynchronous reset input
      // SHIFTIN1-SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0) 
   );

end
endgenerate



//  -----------------------------------------------------
 // -- clock for synching several boards.
 // -----------------------------------------------------
  
  IBUFGDS #(.IOSTANDARD("LVDS_25"))
  IBUFDS_inst_user_sync (
      .O( user_sync),           
      .I(ADC_ext_in_p),
      .IB(ADC_ext_in_n)
      );
	
 
//  -----------------------------------------------------
//  -- Re-capture all DDR inputs to clkdiv's rising edge
//  -----------------------------------------------------

 always @(posedge clkdiv)
  begin
      recapture_data_q0  <= data_serdes_q0;
      recapture_data_q1  <= data_serdes_q1;
     recapture_data_q2  <= data_serdes_q2;
      recapture_data_q3  <= data_serdes_q3;
      recapture_data_i0  <= data_serdes_i0;
      recapture_data_i1  <= data_serdes_i1;
      recapture_data_i2  <= data_serdes_i2;
      recapture_data_i3  <= data_serdes_i3; 
  end
  

  
  
//  -----------------------------------------------------
 // -- FIFO 
 // -----------------------------------------------------
  
//  -- only if the fpga clock is not from the adc
generate
  if (MADDOG_CLK == 0)
begin:ADC_FIFO_Q_generate   


    
    assign fifo_in_q = {recapture_data_q3, recapture_data_q2, recapture_data_q1,recapture_data_q0};
    assign fifo_in_i = {recapture_data_i3, recapture_data_i2, recapture_data_i1, recapture_data_i0};
    assign user_data_q0 = fifo_out_q[11:0];
    assign user_data_q1 = fifo_out_q[23:12];
    assign user_data_q2 = fifo_out_q[35:24];
    assign user_data_q3 = fifo_out_q[47:36];
    assign user_data_i0 = fifo_out_i[11:0];
    assign user_data_i1 = fifo_out_i[23:12];
    assign user_data_i2 = fifo_out_i[35:24];
    assign user_data_i3 = fifo_out_i[47:36];
    
  FIFO_DUALCLOCK_MACRO  #(
      .ALMOST_EMPTY_OFFSET(9'h080), // Sets the almost empty threshold
      .ALMOST_FULL_OFFSET(9'h080),  // Sets almost full threshold
      .DATA_WIDTH(48),   // Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
      .DEVICE("VIRTEX6"),  // Target device: "VIRTEX5", "VIRTEX6" 
      .FIFO_SIZE ("36Kb"), // Target BRAM: "18Kb" or "36Kb" 
      .FIRST_WORD_FALL_THROUGH ("FALSE") // Sets the FIFO FWFT to "TRUE" or "FALSE" 
   ) ADC_FIFO_Q (
      .ALMOSTEMPTY(), // 1-bit output almost empty
      .ALMOSTFULL(),   // 1-bit output almost full
      .DO(fifo_out_q),                   // Output data, width defined by DATA_WIDTH parameter
      .EMPTY(fifo_empty_q),             // 1-bit output empty
      .FULL(fifo_full_q),               // 1-bit output full
      .RDCOUNT(),         // Output read count, width determined by FIFO depth
      .RDERR(),             // 1-bit output read error
      .WRCOUNT(),         // Output write count, width determined by FIFO depth
      .WRERR(),             // 1-bit output write error
      .DI(fifo_in_q),                   // Input data, width defined by DATA_WIDTH parameter
      .RDCLK(fpga_clk),             // 1-bit input read clock
      .RDEN(fifo_rd_en),               // 1-bit input read enable
      .RST(fifo_rst),                 // 1-bit input reset
      .WRCLK(clkdiv),             // 1-bit input write clock
      .WREN(fifo_wr_en)                // 1-bit input write enable
   );



  FIFO_DUALCLOCK_MACRO  #(
      .ALMOST_EMPTY_OFFSET(9'h080), // Sets the almost empty threshold
      .ALMOST_FULL_OFFSET(9'h080),  // Sets almost full threshold
      .DATA_WIDTH(48),   // Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
      .DEVICE("VIRTEX6"),  // Target device: "VIRTEX5", "VIRTEX6" 
      .FIFO_SIZE ("36Kb"), // Target BRAM: "18Kb" or "36Kb" 
      .FIRST_WORD_FALL_THROUGH ("FALSE") // Sets the FIFO FWFT to "TRUE" or "FALSE" 
   ) ADC_FIFO_I (
      .ALMOSTEMPTY(), // 1-bit output almost empty
      .ALMOSTFULL(),   // 1-bit output almost full
      .DO(fifo_out_i),                   // Output data, width defined by DATA_WIDTH parameter
      .EMPTY(fifo_empty_i),             // 1-bit output empty
      .FULL(fifo_full_i),               // 1-bit output full
      .RDCOUNT(),         // Output read count, width determined by FIFO depth
      .RDERR(),             // 1-bit output read error
      .WRCOUNT(),         // Output write count, width determined by FIFO depth
      .WRERR(),             // 1-bit output write error
      .DI(fifo_in_i),                   // Input data, width defined by DATA_WIDTH parameter
      .RDCLK(fpga_clk),             // 1-bit input read clock
      .RDEN(fifo_rd_en),               // 1-bit input read enable
      .RST(fifo_rst),                 // 1-bit input reset
      .WRCLK(clkdiv),             // 1-bit input write clock
      .WREN(fifo_wr_en)                // 1-bit input write enable
   );



	end
	endgenerate



generate  
 if (MADDOG_CLK == 1)
  begin
  
  
    assign user_data_q0 = recapture_data_q0;
    assign user_data_q1 = recapture_data_q1;
    assign user_data_q2 = recapture_data_q2;
    assign user_data_q3 = recapture_data_q3;
    assign user_data_i0 = recapture_data_i0;
    assign user_data_i1 = recapture_data_i1;
    assign user_data_i2 = recapture_data_i2;
    assign user_data_i3 = recapture_data_i3;
  end 
  endgenerate

    
//  -----------------------------------------------------
//  -- Clock 
//  -----------------------------------------------------

//  -- data ready clock from ADC (using DRDY_I)

IBUFGDS #(.IOSTANDARD("LVDS_25"))
	IBUFDS_inst_adc_clk(
      .O(drdy_clk),           
      .I(DRDY_I_p),
      .IB(DRDY_I_n)
      );


//  -- DCM INPUT
  

  BUFG BUFG_data_clk(
    .I(drdy_clk),
	 .O(dcm_clk_in));
  
//  -- DCM OUTPUT

 // -- dcm_clk_in divided by 2 in DCM so all the 0,90,180,270
 // -- clks are also divided by 2
//  -- devided clk multiplied by 2 for the ISERDES (so same as dcm_clk_in) but
//  -- synchronize with clkdiv 
  
  BUFG BUFG_clk0 
    (.I(dcm_clk), .O(clkdiv));
  
  BUFG BUFG_clk2x
    (.I(dcm_clk2x),.O( clk));

 BUFG  BUFG_clk90 
   (.I(dcm_clk90), .O(clk90div));
  
 BUFG BUFG_clk180 
  (.I(dcm_clk180), .O(clk180div));
  
  BUFG BUFG_clk270 
   (.I(dcm_clk270), .O(clk270div));
  
  // put buffer on clk feedback to we can compensate for buffer delay
  
  
  wire clk_feedback;
  wire clk_feedback_buf;
  
   BUFG BUFG_clk_feedback 
    (.I(clk_feedback), .O(clk_feedback_buf));
  
  
 
 generate
 if (MADDOG_CLK == 1)
 begin
    assign adc_clk_out = clkdiv;
    assign adc_clk90_out = clk90div;
    assign adc_clk180_out = clk180div;
    assign adc_clk270_out = clk270div;
 end
 endgenerate
  
// --  clkinv <= not clk;
  
  // for MMCM, 
  //Fout = Fclkin * ( M / (D*O) )
  // M = CLKFBOUT_MULT_F = 8
  //D =  DIVCLK_DIVIDE = 2
  // O = CLKOUT1_DIVIDE = 8
  //
  // Fout = 256 * (8/(2*8)) = 128
  
  
  // sample reate is 512MHz. The data will look like this
  //
  //
  //
  // sample clk 512MHz    -- __--__--__--__--__--__--
  //
  // out data clk 256Mhz   ____----____----____----____----
  //
  //out data 256MHz        --____----____----____----____
  //
  // data outclk 128M      ________--------________--------
  
  
    
//  -- MMCM

   MMCM_BASE #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming ("HIGH","LOW","OPTIMIZED")
      .CLKFBOUT_MULT_F(8.0),     // Multiply value for all CLKOUT (5.0-64.0).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (0.00-360.00).
      .CLKIN1_PERIOD(3.906),       // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      
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
      
      .CLKOUT4_PHASE(270.0),
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      // CLKOUT1_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      
      //four 128MHz clocks of different phase
      .CLKOUT0_DIVIDE_F(8.0),    // Divide amount for CLKOUT0 (1.000-128.000).
      .CLKOUT1_DIVIDE(8),
      .CLKOUT2_DIVIDE(8),
      .CLKOUT3_DIVIDE(8),
      
      //single 256 MHz clock- drives iserdes
      .CLKOUT4_DIVIDE(4),
      .CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(1),
      .CLKOUT4_CASCADE("FALSE"), // Cascase CLKOUT4 counter with CLKOUT6 (TRUE/FALSE)
      .CLOCK_HOLD("FALSE"),      // Hold VCO Frequency (TRUE/FALSE)
      .DIVCLK_DIVIDE(2),         // Master division value (1-80)
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      .STARTUP_WAIT("FALSE")     // Not supported. Must be set to FALSE.
   )
   CLK_DCM (
   
       //These are all 128MHz
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(dcm_clk),     // 1-bit output: CLKOUT0 output
      .CLKOUT0B(),   // 1-bit output: Inverted CLKOUT0 output
      .CLKOUT1(dcm_clk90),     // 1-bit output: CLKOUT1 output
      .CLKOUT1B(),   // 1-bit output: Inverted CLKOUT1 output
      .CLKOUT2(dcm_clk180),     // 1-bit output: CLKOUT2 output
      .CLKOUT2B(),   // 1-bit output: Inverted CLKOUT2 output
      .CLKOUT3(dcm_clk270),     // 1-bit output: CLKOUT3 output
      
      
      .CLKOUT3B(),   // 1-bit output: Inverted CLKOUT3 output
      
      //this clk is 256MHz, and can be phase delayed from original adc drdy clock. used to drive the iserdes DDR.
      .CLKOUT4(dcm_clk2x),     // 1-bit output: CLKOUT4 output
      .CLKOUT5(),     // 1-bit output: CLKOUT5 output
      .CLKOUT6(),     // 1-bit output: CLKOUT6 output
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(clk_feedback),   // 1-bit output: Feedback clock output
      .CLKFBOUTB(), // 1-bit output: Inverted CLKFBOUT output
      // Status Port: 1-bit (each) output: MMCM status ports
      .LOCKED(adc_dcm_locked),       // 1-bit output: LOCK output
      
      // Clock Input: 1-bit (each) input: Clock input
      .CLKIN1(dcm_clk_in),//256 M clock from ADC
      
      // Control Ports: 1-bit (each) input: MMCM control ports
      .PWRDWN(1'b0),       // 1-bit input: Power-down input
      .RST(1'b0),             // 1-bit input: Reset input
      
      //this is buff version of dcm)clk, at 128MHJz
      //this means that the clkdiv will be in phase with the original ADC drdy clk.
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(clk_feedback)      // 1-bit input: Feedback clock input
   );



  




endmodule
