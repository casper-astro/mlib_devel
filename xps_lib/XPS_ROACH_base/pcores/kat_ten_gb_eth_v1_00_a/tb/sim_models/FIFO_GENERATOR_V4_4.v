/*
 * $RDCfile: $ $Revision: 1.1.2.6 $ $Date: 2008/07/22 06:40:34 $
 *******************************************************************************
 *
 * FIFO Generator - Verilog Behavioral Model
 *
 *******************************************************************************
 *
 * Copyright(C) 2006 by Xilinx, Inc. All rights reserved.
 * This text/file contains proprietary, confidential
 * information of Xilinx, Inc., is distributed under
 * license from Xilinx, Inc., and may be used, copied
 * and/or disclosed only pursuant to the terms of a valid
 * license agreement with Xilinx, Inc. Xilinx hereby
 * grants you a license to use this text/file solely for
 * design, simulation, implementation and creation of
 * design files limited to Xilinx devices or technologies.
 * Use with non-Xilinx devices or technologies is expressly
 * prohibited and immediately terminates your license unless
 * covered by a separate agreement.
 *
 * Xilinx is providing theis design, code, or information
 * "as-is" solely for use in developing programs and
 * solutions for Xilinx devices, with no obligation on the
 * part of Xilinx to provide support. By providing this design,
 * code, or information as one possible implementation of
 * this feature, application or standard. Xilinx is making no
 * representation that this implementation is free from any
 * claims of infringement. You are responsible for obtaining
 * any rights you may require for your implementation.
 * Xilinx expressly disclaims any warranty whatsoever with
 * respect to the adequacy of the implementation, including
 * but not limited to any warranties or representations that this
 * implementation is free from claims of infringement, implied
 * warranties of merchantability or fitness for a particular
 * purpose.
 *
 * Xilinx products are not intended for use in life support
 * appliances, devices, or systems. Use in such applications is
 * expressly prohibited.
 *
 * This copyright and support notice must be retained as part
 * of this text at all times. (c)Copyright 1995-2006 Xilinx, Inc.
 * All rights reserved.
 *
 *******************************************************************************
 *
 * Filename: FIFO_GENERATOR_V4_4.v
 *
 * Author     : Xilinx
 *
 *******************************************************************************
 * Structure:
 * 
 * fifo_generator_v4_4.vhd
 *    |
 *    +-fifo_generator_v4_4_bhv_as
 *    |
 *    +-fifo_generator_v4_4_bhv_ss
 *    |
 *    +-fifo_generator_v4_4_bhv_preload0
 * 
 *******************************************************************************
 * Description:
 *
 * The Verilog behavioral model for the FIFO Generator.
 *
 *   The behavioral model has three parts:
 *      - The behavioral model for independent clocks FIFOs (_as)
 *      - The behavioral model for common clock FIFOs (_ss)
 *      - The "preload logic" block which implements First-word Fall-through
 * 
 *******************************************************************************
 * Description:
 *  The verilog behavioral model for the FIFO generator core.
 *
 *******************************************************************************
 */

`define LOG2(x) ((x) == 8 ? 3 : (x) == 4 ? 2 : 1)
/*******************************************************************************
 * Declaration of top-level module
 ******************************************************************************/
module FIFO_GENERATOR_V4_4
(
  BACKUP, //not used
  BACKUP_MARKER, //not used
  CLK,
  DIN,
  PROG_EMPTY_THRESH,
  PROG_EMPTY_THRESH_ASSERT,
  PROG_EMPTY_THRESH_NEGATE,
  PROG_FULL_THRESH,
  PROG_FULL_THRESH_ASSERT,
  PROG_FULL_THRESH_NEGATE,
  RD_CLK,
  RD_EN,
  RD_RST, //not used
  RST,
  SRST,
  WR_CLK,
  WR_EN,
  WR_RST, //not used
  INT_CLK,

  ALMOST_EMPTY,
  ALMOST_FULL,
  DATA_COUNT,
  DOUT,
  EMPTY,
  FULL,
  OVERFLOW,
  PROG_EMPTY,
  PROG_FULL,
  RD_DATA_COUNT,
  UNDERFLOW,
  VALID,
  WR_ACK,
  WR_DATA_COUNT,
 
  SBITERR,
  DBITERR
  );

/*
 ******************************************************************************
 * Definition of Parameters
 ******************************************************************************
 *     C_COMMON_CLOCK                : Common Clock (1), Independent Clocks (0)
 *     C_COUNT_TYPE                  :    *not used
 *     C_DATA_COUNT_WIDTH            : Width of DATA_COUNT bus
 *     C_DEFAULT_VALUE               :    *not used
 *     C_DIN_WIDTH                   : Width of DIN bus
 *     C_DOUT_RST_VAL                : Reset value of DOUT
 *     C_DOUT_WIDTH                  : Width of DOUT bus
 *     C_ENABLE_RLOCS                :    *not used
 *     C_FAMILY                      : not used in bhv model
 *     C_FULL_FLAGS_RST_VAL          : Full flags rst val (0 or 1)
 *     C_HAS_ALMOST_EMPTY            : 1=Core has ALMOST_EMPTY flag
 *     C_HAS_ALMOST_FULL             : 1=Core has ALMOST_FULL flag
 *     C_HAS_BACKUP                  :    *not used
 *     C_HAS_DATA_COUNT              : 1=Core has DATA_COUNT bus
 *     C_HAS_INT_CLK                 : not used in bhv model
 *     C_HAS_MEMINIT_FILE            :    *not used
 *     C_HAS_OVERFLOW                : 1=Core has OVERFLOW flag
 *     C_HAS_RD_DATA_COUNT           : 1=Core has RD_DATA_COUNT bus
 *     C_HAS_RD_RST                  :    *not used
 *     C_HAS_RST                     : 1=Core has Async Rst
 *     C_HAS_SRST                    : 1=Core has Sync Rst
 *     C_HAS_UNDERFLOW               : 1=Core has UNDERFLOW flag
 *     C_HAS_VALID                   : 1=Core has VALID flag
 *     C_HAS_WR_ACK                  : 1=Core has WR_ACK flag
 *     C_HAS_WR_DATA_COUNT           : 1=Core has WR_DATA_COUNT bus
 *     C_HAS_WR_RST                  :    *not used
 *     C_IMPLEMENTATION_TYPE         : 0=Common-Clock Bram/Dram
 *                                     1=Common-Clock ShiftRam
 *                                     2=Indep. Clocks Bram/Dram
 *                                     3=Virtex-4 Built-in
 *                                     4=Virtex-5 Built-in
 *     C_INIT_WR_PNTR_VAL            :   *not used
 *     C_MEMORY_TYPE                 : 1=Block RAM
 *                                     2=Distributed RAM
 *                                     3=Shift RAM
 *                                     4=Built-in FIFO
 *     C_MIF_FILE_NAME               :   *not used
 *     C_OPTIMIZATION_MODE           :   *not used
 *     C_OVERFLOW_LOW                : 1=OVERFLOW active low
 *     C_PRELOAD_LATENCY             : Latency of read: 0, 1, 2
 *     C_PRELOAD_REGS                : 1=Use output registers
 *     C_PRIM_FIFO_TYPE              : not used in bhv model
 *     C_PROG_EMPTY_THRESH_ASSERT_VAL: PROG_EMPTY assert threshold
 *     C_PROG_EMPTY_THRESH_NEGATE_VAL: PROG_EMPTY negate threshold
 *     C_PROG_EMPTY_TYPE             : 0=No programmable empty
 *                                     1=Single prog empty thresh constant
 *                                     2=Multiple prog empty thresh constants
 *                                     3=Single prog empty thresh input
 *                                     4=Multiple prog empty thresh inputs
 *     C_PROG_FULL_THRESH_ASSERT_VAL : PROG_FULL assert threshold
 *     C_PROG_FULL_THRESH_NEGATE_VAL : PROG_FULL negate threshold
 *     C_PROG_FULL_TYPE              : 0=No prog full
 *                                     1=Single prog full thresh constant
 *                                     2=Multiple prog full thresh constants
 *                                     3=Single prog full thresh input
 *                                     4=Multiple prog full thresh inputs
 *     C_RD_DATA_COUNT_WIDTH         : Width of RD_DATA_COUNT bus
 *     C_RD_DEPTH                    : Depth of read interface (2^N)
 *     C_RD_FREQ                     : not used in bhv model
 *     C_RD_PNTR_WIDTH               : always log2(C_RD_DEPTH)
 *     C_UNDERFLOW_LOW               : 1=UNDERFLOW active low
 *     C_USE_DOUT_RST                : 1=Resets DOUT on RST
 *     C_USE_ECC                     : not used in bhv model
 *     C_USE_EMBEDDED_REG            : 1=Use BRAM embedded output register
 *     C_USE_FIFO16_FLAGS            : not used in bhv model
 *     C_USE_FWFT_DATA_COUNT         : 1=Use extra logic for FWFT data count
 *     C_VALID_LOW                   : 1=VALID active low
 *     C_WR_ACK_LOW                  : 1=WR_ACK active low
 *     C_WR_DATA_COUNT_WIDTH         : Width of WR_DATA_COUNT bus
 *     C_WR_DEPTH                    : Depth of write interface (2^N)
 *     C_WR_FREQ                     : not used in bhv model
 *     C_WR_PNTR_WIDTH               : always log2(C_WR_DEPTH)
 *     C_WR_RESPONSE_LATENCY         :    *not used
 *     C_MSGON_VAL                   :    *not used by bhv model
 ******************************************************************************
 * Definition of Ports
 ******************************************************************************
 *   BACKUP       : Not used
 *   BACKUP_MARKER: Not used
 *   CLK          : Clock
 *   DIN          : Input data bus
 *   PROG_EMPTY_THRESH       : Threshold for Programmable Empty Flag
 *   PROG_EMPTY_THRESH_ASSERT: Threshold for Programmable Empty Flag
 *   PROG_EMPTY_THRESH_NEGATE: Threshold for Programmable Empty Flag
 *   PROG_FULL_THRESH        : Threshold for Programmable Full Flag
 *   PROG_FULL_THRESH_ASSERT : Threshold for Programmable Full Flag
 *   PROG_FULL_THRESH_NEGATE : Threshold for Programmable Full Flag
 *   RD_CLK       : Read Domain Clock
 *   RD_EN        : Read enable
 *   RD_RST       : Not used
 *   RST          : Asynchronous Reset
 *   SRST         : Synchronous Reset
 *   WR_CLK       : Write Domain Clock
 *   WR_EN        : Write enable
 *   WR_RST       : Not used
 *   INT_CLK      : Internal Clock
 *   ALMOST_EMPTY : One word remaining in FIFO
 *   ALMOST_FULL  : One empty space remaining in FIFO
 *   DATA_COUNT   : Number of data words in fifo( synchronous to CLK)
 *   DOUT         : Output data bus
 *   EMPTY        : Empty flag
 *   FULL         : Full flag
 *   OVERFLOW     : Last write rejected
 *   PROG_EMPTY   : Programmable Empty Flag
 *   PROG_FULL    : Programmable Full Flag
 *   RD_DATA_COUNT: Number of data words in fifo (synchronous to RD_CLK)
 *   UNDERFLOW    : Last read rejected
 *   VALID        : Last read acknowledged, DOUT bus VALID
 *   WR_ACK       : Last write acknowledged
 *   WR_DATA_COUNT: Number of data words in fifo (synchronous to WR_CLK)
 *   SBITERR      : Single Bit ECC Error Detected
 *   DBITERR      : Double Bit ECC Error Detected
 ******************************************************************************
 */

   
  /****************************************************************************
  * Declare user parameters and their defaults
  *****************************************************************************/
  parameter  C_COMMON_CLOCK                 = 0;
  parameter  C_COUNT_TYPE                   = 0; //not used
  parameter  C_DATA_COUNT_WIDTH             = 2;
  parameter  C_DEFAULT_VALUE                = ""; //not used
  parameter  C_DIN_WIDTH                    = 8;
  parameter  C_DOUT_RST_VAL                 = "";
  parameter  C_DOUT_WIDTH                   = 8;
  parameter  C_ENABLE_RLOCS                 = 0; //not used
  parameter  C_FAMILY                       = "virtex2"; //not used in bhv model
  parameter  C_FULL_FLAGS_RST_VAL           = 1;
  parameter  C_HAS_ALMOST_EMPTY             = 0;
  parameter  C_HAS_ALMOST_FULL              = 0;
  parameter  C_HAS_BACKUP                   = 0; //not used
  parameter  C_HAS_DATA_COUNT               = 0;
  parameter  C_HAS_INT_CLK                  = 0; //not used in bhv model
  parameter  C_HAS_MEMINIT_FILE             = 0; //not used
  parameter  C_HAS_OVERFLOW                 = 0;
  parameter  C_HAS_RD_DATA_COUNT            = 0;
  parameter  C_HAS_RD_RST                   = 0; //not used
  parameter  C_HAS_RST                      = 0;
  parameter  C_HAS_SRST                     = 0;
  parameter  C_HAS_UNDERFLOW                = 0;
  parameter  C_HAS_VALID                    = 0;
  parameter  C_HAS_WR_ACK                   = 0;
  parameter  C_HAS_WR_DATA_COUNT            = 0;
  parameter  C_HAS_WR_RST                   = 0; //not used
  parameter  C_IMPLEMENTATION_TYPE          = 0;
  parameter  C_INIT_WR_PNTR_VAL             = 0; //not used
  parameter  C_MEMORY_TYPE                  = 1;
  parameter  C_MIF_FILE_NAME                = ""; //not used
  parameter  C_OPTIMIZATION_MODE            = 0; //not used
  parameter  C_OVERFLOW_LOW                 = 0;
  parameter  C_PRELOAD_LATENCY              = 1;
  parameter  C_PRELOAD_REGS                 = 0;
  parameter  C_PRIM_FIFO_TYPE               = 512; //not used in bhv model
  parameter  C_PROG_EMPTY_THRESH_ASSERT_VAL = 0;
  parameter  C_PROG_EMPTY_THRESH_NEGATE_VAL = 0;
  parameter  C_PROG_EMPTY_TYPE              = 0;
  parameter  C_PROG_FULL_THRESH_ASSERT_VAL  = 0;
  parameter  C_PROG_FULL_THRESH_NEGATE_VAL  = 0;
  parameter  C_PROG_FULL_TYPE               = 0;
  parameter  C_RD_DATA_COUNT_WIDTH          = 2;
  parameter  C_RD_DEPTH                     = 256;
  parameter  C_RD_FREQ                      = 1; //not used in bhv model
  parameter  C_RD_PNTR_WIDTH                = 8;
  parameter  C_UNDERFLOW_LOW                = 0;
  parameter  C_USE_DOUT_RST                 = 0;
  parameter  C_USE_ECC                      = 0; //not used in bhv model
  parameter  C_USE_EMBEDDED_REG             = 0;
  parameter  C_USE_FIFO16_FLAGS             = 0; //not used in bhv model
  parameter  C_USE_FWFT_DATA_COUNT          = 0;
  parameter  C_VALID_LOW                    = 0;
  parameter  C_WR_ACK_LOW                   = 0;
  parameter  C_WR_DATA_COUNT_WIDTH          = 2;
  parameter  C_WR_DEPTH                     = 256;
  parameter  C_WR_FREQ                      = 1; //not used in bhv model
  parameter  C_WR_PNTR_WIDTH                = 8;
  parameter  C_WR_RESPONSE_LATENCY          = 1; //not used
  parameter  C_MSGON_VAL                    = 1; //not used 



  /*****************************************************************************
   * Derived parameters
   ****************************************************************************/
  //There are 2 Verilog behavioral models
  // 0 = Common-Clock FIFO/ShiftRam FIFO
  // 1 = Independent Clocks FIFO
  parameter  C_VERILOG_IMPL = (C_IMPLEMENTATION_TYPE==0 ? 0 :
                               (C_IMPLEMENTATION_TYPE==1 ? 0 :
                                (C_IMPLEMENTATION_TYPE==2 ? 1 : 0)));

  /*****************************************************************************
   * Declare Input and Output Ports
   ****************************************************************************/
  input                              CLK;
  input                              BACKUP;
  input                              BACKUP_MARKER;
  input [C_DIN_WIDTH-1:0]            DIN;
  input [C_RD_PNTR_WIDTH-1:0]        PROG_EMPTY_THRESH;
  input [C_RD_PNTR_WIDTH-1:0]        PROG_EMPTY_THRESH_ASSERT;
  input [C_RD_PNTR_WIDTH-1:0]        PROG_EMPTY_THRESH_NEGATE;
  input [C_WR_PNTR_WIDTH-1:0]        PROG_FULL_THRESH;
  input [C_WR_PNTR_WIDTH-1:0]        PROG_FULL_THRESH_ASSERT;
  input [C_WR_PNTR_WIDTH-1:0]        PROG_FULL_THRESH_NEGATE;
  input                              RD_CLK;
  input                              RD_EN;
  input                              RD_RST;
  input                              RST;
  input                              SRST;
  input                              WR_CLK;
  input                              WR_EN;
  input                              WR_RST;
  input                              INT_CLK;

  output                             ALMOST_EMPTY;
  output                             ALMOST_FULL;
  output [C_DATA_COUNT_WIDTH-1:0]    DATA_COUNT;
  output [C_DOUT_WIDTH-1:0]          DOUT;
  output                             EMPTY;
  output                             FULL;
  output                             OVERFLOW;
  output                             PROG_EMPTY;
  output                             PROG_FULL;


  output                             VALID;
  output [C_RD_DATA_COUNT_WIDTH-1:0] RD_DATA_COUNT;
  output                             UNDERFLOW;
  output                             WR_ACK;
  output [C_WR_DATA_COUNT_WIDTH-1:0] WR_DATA_COUNT;
  output                             SBITERR;
  output                             DBITERR;


  wire                               ALMOST_EMPTY;
  wire                               ALMOST_FULL;
  wire [C_DATA_COUNT_WIDTH-1:0]      DATA_COUNT;
  wire [C_DOUT_WIDTH-1:0]            DOUT;
  wire                               EMPTY;
  wire                               FULL;
  wire                               OVERFLOW;
  wire                               PROG_EMPTY;
  wire                               PROG_FULL; //wtf why did this not work as a wire...
  wire                               VALID;
  wire [C_RD_DATA_COUNT_WIDTH-1:0]   RD_DATA_COUNT;
  wire                               UNDERFLOW;
  wire                               WR_ACK;
  wire [C_WR_DATA_COUNT_WIDTH-1:0]   WR_DATA_COUNT;


  wire                               RD_CLK_P0_IN;
  wire                               RST_P0_IN;
  wire                               RD_EN_FIFO_IN;
  wire                               RD_EN_P0_IN;

  wire                               ALMOST_EMPTY_FIFO_OUT;
  wire                               ALMOST_FULL_FIFO_OUT;
  wire [C_DATA_COUNT_WIDTH-1:0]      DATA_COUNT_FIFO_OUT;
  wire [C_DOUT_WIDTH-1:0]            DOUT_FIFO_OUT;
  wire                               EMPTY_FIFO_OUT;
  wire                               FULL_FIFO_OUT;
  wire                               OVERFLOW_FIFO_OUT;
  wire                               PROG_EMPTY_FIFO_OUT;
  wire                               PROG_FULL_FIFO_OUT;
  wire                               VALID_FIFO_OUT;
  wire [C_RD_DATA_COUNT_WIDTH-1:0]   RD_DATA_COUNT_FIFO_OUT;
  wire                               UNDERFLOW_FIFO_OUT;
  wire                               WR_ACK_FIFO_OUT;
  wire [C_WR_DATA_COUNT_WIDTH-1:0]   WR_DATA_COUNT_FIFO_OUT;


  //***************************************************************************
  // Internal Signals
  //   The core uses either the internal_ wires or the preload0_ wires depending
  //     on whether the core uses Preload0 or not.
  //   When using preload0, the internal signals connect the internal core to
  //     the preload logic, and the external core's interfaces are tied to the
  //     preload0 signals from the preload logic.
  //***************************************************************************
  wire [C_DOUT_WIDTH-1:0]            DATA_P0_OUT;
  wire                               VALID_P0_OUT;
  wire                               EMPTY_P0_OUT;
  wire                               ALMOSTEMPTY_P0_OUT;
  reg                                EMPTY_P0_OUT_Q;
  reg                                ALMOSTEMPTY_P0_OUT_Q;
  wire                               UNDERFLOW_P0_OUT;
  wire                               RDEN_P0_OUT;
  wire [C_DOUT_WIDTH-1:0]            DATA_P0_IN;
  wire                               EMPTY_P0_IN;
  reg  [31:0]      DATA_COUNT_FWFT;
  reg                               SS_FWFT_WR  ;
  reg                              SS_FWFT_RD ;

  assign SBITERR = 1'b0;
  assign DBITERR = 1'b0;

  //Independent Clocks Behavioral Model
  fifo_generator_v4_4_bhv_ver_as
  #(
    C_DATA_COUNT_WIDTH,
    C_DIN_WIDTH,
    C_DOUT_RST_VAL,
    C_DOUT_WIDTH,
    C_FULL_FLAGS_RST_VAL,
    C_HAS_ALMOST_EMPTY,
    C_HAS_ALMOST_FULL,
    C_HAS_DATA_COUNT,
    C_HAS_OVERFLOW,
    C_HAS_RD_DATA_COUNT,
    C_HAS_RST,
    C_HAS_UNDERFLOW,
    C_HAS_VALID,
    C_HAS_WR_ACK,
    C_HAS_WR_DATA_COUNT,
    C_IMPLEMENTATION_TYPE,
    C_MEMORY_TYPE,
    C_OVERFLOW_LOW,
    C_PRELOAD_LATENCY,
    C_PRELOAD_REGS,
    C_PROG_EMPTY_THRESH_ASSERT_VAL,
    C_PROG_EMPTY_THRESH_NEGATE_VAL,
    C_PROG_EMPTY_TYPE,
    C_PROG_FULL_THRESH_ASSERT_VAL,
    C_PROG_FULL_THRESH_NEGATE_VAL,
    C_PROG_FULL_TYPE,
    C_RD_DATA_COUNT_WIDTH,
    C_RD_DEPTH,
    C_RD_PNTR_WIDTH,
    C_UNDERFLOW_LOW,
    C_USE_DOUT_RST,
    C_USE_EMBEDDED_REG,
    C_USE_FWFT_DATA_COUNT,
    C_VALID_LOW,
    C_WR_ACK_LOW,
    C_WR_DATA_COUNT_WIDTH,
    C_WR_DEPTH,
    C_WR_PNTR_WIDTH
  )
  gen_as
  (
    .WR_CLK                   (WR_CLK),
    .RD_CLK                   (RD_CLK),
    .RST                      (RST),
    .DIN                      (DIN),
    .WR_EN                    (WR_EN),
    .RD_EN                    (RD_EN_FIFO_IN),
    .PROG_EMPTY_THRESH        (PROG_EMPTY_THRESH),
    .PROG_EMPTY_THRESH_ASSERT (PROG_EMPTY_THRESH_ASSERT),
    .PROG_EMPTY_THRESH_NEGATE (PROG_EMPTY_THRESH_NEGATE),
    .PROG_FULL_THRESH         (PROG_FULL_THRESH),
    .PROG_FULL_THRESH_ASSERT  (PROG_FULL_THRESH_ASSERT),
    .PROG_FULL_THRESH_NEGATE  (PROG_FULL_THRESH_NEGATE),
    .DOUT                     (DOUT_FIFO_OUT),
    .FULL                     (FULL_FIFO_OUT),
    .ALMOST_FULL              (ALMOST_FULL_FIFO_OUT),
    .WR_ACK                   (WR_ACK_FIFO_OUT),
    .OVERFLOW                 (OVERFLOW_FIFO_OUT),
    .EMPTY                    (EMPTY_FIFO_OUT),
    .ALMOST_EMPTY             (ALMOST_EMPTY_FIFO_OUT),
    .VALID                    (VALID_FIFO_OUT),
    .UNDERFLOW                (UNDERFLOW_FIFO_OUT),
    .RD_DATA_COUNT            (RD_DATA_COUNT_FIFO_OUT),
    .WR_DATA_COUNT            (WR_DATA_COUNT_FIFO_OUT),
    .PROG_FULL                (PROG_FULL_FIFO_OUT),
    .PROG_EMPTY               (PROG_EMPTY_FIFO_OUT)
   );

   //**************************************************************************
   // Connect Internal Signals
   //   (Signals labeled internal_*)
   //  In the normal case, these signals tie directly to the FIFO's inputs and
   //    outputs.
   //  In the case of Preload Latency 0 or 1, there are intermediate
   //    signals between the internal FIFO and the preload logic.
   //**************************************************************************
   
   
   //***********************************************
   // If First-Word Fall-Through, instantiate
   // the preload0 (FWFT) module
   //***********************************************
   wire RAMVALID_P0_OUT;
   generate
      if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin : block2
	 
	 

	 fifo_generator_v4_4_bhv_ver_preload0
	   #(
	     C_DOUT_RST_VAL,
	     C_DOUT_WIDTH,
	     C_HAS_RST,
	     C_HAS_SRST,
	     C_USE_DOUT_RST,
	     C_VALID_LOW,
	     C_UNDERFLOW_LOW
	     )
	     fgpl0
	       (
		.RD_CLK           (RD_CLK_P0_IN),
		.RD_RST           (RST_P0_IN),
		.SRST             (SRST),
		.RD_EN            (RD_EN_P0_IN),
		.FIFOEMPTY        (EMPTY_P0_IN),
		.FIFODATA         (DATA_P0_IN),
		.USERDATA         (DATA_P0_OUT),
		.USERVALID        (VALID_P0_OUT),
		.USEREMPTY        (EMPTY_P0_OUT),
		.USERALMOSTEMPTY  (ALMOSTEMPTY_P0_OUT),
		.USERUNDERFLOW    (UNDERFLOW_P0_OUT),
		.RAMVALID         (RAMVALID_P0_OUT),
		.FIFORDEN         (RDEN_P0_OUT)
		);
	 
	 
	 //***********************************************
	 // Connect inputs to preload (FWFT) module
	 //***********************************************
	 //Connect the RD_CLK of the Preload (FWFT) module to CLK if we 
	 // have a common-clock FIFO, or RD_CLK if we have an 
	 // independent clock FIFO
	 assign RD_CLK_P0_IN       = ((C_VERILOG_IMPL == 0) ? CLK : RD_CLK);
	 assign RST_P0_IN          = RST;
	 assign RD_EN_P0_IN        = RD_EN;
	 assign EMPTY_P0_IN        = EMPTY_FIFO_OUT;
	 assign DATA_P0_IN         = DOUT_FIFO_OUT;
	 
	 //***********************************************
	 // Connect outputs from preload (FWFT) module
	 //***********************************************
	 assign DOUT               = DATA_P0_OUT;
	 assign VALID              = VALID_P0_OUT ;
	 assign EMPTY              = EMPTY_P0_OUT;
	 assign ALMOST_EMPTY       = ALMOSTEMPTY_P0_OUT;
	 assign UNDERFLOW          = UNDERFLOW_P0_OUT ;
	 
	 assign RD_EN_FIFO_IN      = RDEN_P0_OUT;
	 
	 
	 //***********************************************
	 // Create DATA_COUNT from First-Word Fall-Through
	 // data count
	 //***********************************************
	 assign DATA_COUNT = (C_USE_FWFT_DATA_COUNT == 0)? DATA_COUNT_FIFO_OUT:
           (C_DATA_COUNT_WIDTH>C_RD_PNTR_WIDTH) ? DATA_COUNT_FWFT[C_RD_PNTR_WIDTH:0] : 
	   DATA_COUNT_FWFT[C_RD_PNTR_WIDTH:C_RD_PNTR_WIDTH-C_DATA_COUNT_WIDTH+1];  
	 
	 //***********************************************
	 // Create DATA_COUNT from First-Word Fall-Through
	 // data count
	 //***********************************************
	 always @ (posedge RD_CLK or posedge RST) begin
	    if (RST) begin
	       EMPTY_P0_OUT_Q       <= 1;
	       ALMOSTEMPTY_P0_OUT_Q <= 1;
	    end else begin
	       EMPTY_P0_OUT_Q       <= EMPTY_P0_OUT;
	       ALMOSTEMPTY_P0_OUT_Q <= ALMOSTEMPTY_P0_OUT;
	    end
	 end //always
	 
	 
	 //***********************************************
	 // logic for common-clock data count when FWFT is selected
	 //***********************************************
	 initial begin
	    SS_FWFT_RD = 1'b0;
	    DATA_COUNT_FWFT = 0 ;
	    SS_FWFT_WR   = 1'b0 ;
	 end //initial
	 
	 
	 //***********************************************
	 // common-clock data count is implemented as an
	 // up-down counter. SS_FWFT_WR and SS_FWFT_RD
	 // are the up/down enables for the counter.
	 //***********************************************
	 always @ (RD_EN or VALID_P0_OUT or WR_EN or FULL_FIFO_OUT) begin
	    SS_FWFT_RD = RD_EN && VALID_P0_OUT ;	    
	    SS_FWFT_WR = (WR_EN && (~FULL_FIFO_OUT))  ;
	 end 

	 //***********************************************
	 // common-clock data count is implemented as an
	 // up-down counter for FWFT. This always block 
	 // calculates the counter.
	 //***********************************************
	 always @ (posedge RD_CLK_P0_IN or posedge RST) begin
	    if (RST && (C_HAS_RST == 1) ) begin
	       DATA_COUNT_FWFT      <= 0;
	    end else begin
	       if (SRST && (C_HAS_SRST == 1) ) begin
		  DATA_COUNT_FWFT      <= 0;
               end else begin
		  case ( {SS_FWFT_WR, SS_FWFT_RD})
		    2'b00: DATA_COUNT_FWFT <= DATA_COUNT_FWFT ;
		    2'b01: DATA_COUNT_FWFT <= DATA_COUNT_FWFT - 1 ;
		    2'b10: DATA_COUNT_FWFT <= DATA_COUNT_FWFT + 1 ;
		    2'b11: DATA_COUNT_FWFT <= DATA_COUNT_FWFT ;
		  endcase  
               end //if SRST
	    end //IF RST
	 end //always

	 
      end else begin : block2 //if !(C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0)
	 
	 //***********************************************
	 // If NOT First-Word Fall-Through, wire the outputs
	 // of the internal _ss or _as FIFO directly to the
	 // output, and do not instantiate the preload0
	 // module.
	 //***********************************************
	 
	 assign RD_CLK_P0_IN       = 0;
	 assign RST_P0_IN          = 0;
	 assign RD_EN_P0_IN        = 0;
	 
	 assign RD_EN_FIFO_IN      = RD_EN;
	 
	 assign DOUT               = DOUT_FIFO_OUT;
	 assign DATA_P0_IN         = 0;
	 assign VALID              = VALID_FIFO_OUT;
	 assign EMPTY              = EMPTY_FIFO_OUT;
	 assign ALMOST_EMPTY       = ALMOST_EMPTY_FIFO_OUT;
	 assign EMPTY_P0_IN        = 0;
	 assign UNDERFLOW          = UNDERFLOW_FIFO_OUT;
	 assign DATA_COUNT         = DATA_COUNT_FIFO_OUT;
	 
      end //if !(C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0)
   endgenerate


   //***********************************************
   // Connect user flags to internal signals
   //***********************************************
   
   //If we are using extra logic for the FWFT data count, then override the
   //RD_DATA_COUNT output when we are EMPTY or ALMOST_EMPTY.
   //RD_DATA_COUNT is 0 when EMPTY and 1 when ALMOST_EMPTY.
   generate
      if (C_USE_FWFT_DATA_COUNT==1 && (C_RD_DATA_COUNT_WIDTH>C_RD_PNTR_WIDTH) ) begin : block3
	 assign RD_DATA_COUNT = (EMPTY_P0_OUT_Q | RST) ? 0 : (ALMOSTEMPTY_P0_OUT_Q ? 1 : RD_DATA_COUNT_FIFO_OUT);
      end //block3
   endgenerate
   
   //If we are using extra logic for the FWFT data count, then override the
   //RD_DATA_COUNT output when we are EMPTY or ALMOST_EMPTY.
   //Due to asymmetric ports, RD_DATA_COUNT is 0 when EMPTY or ALMOST_EMPTY.
   generate
      if (C_USE_FWFT_DATA_COUNT==1 && (C_RD_DATA_COUNT_WIDTH <=C_RD_PNTR_WIDTH) ) begin : block30
	 assign RD_DATA_COUNT = (EMPTY_P0_OUT_Q | RST) ? 0 : (ALMOSTEMPTY_P0_OUT_Q ? 0 : RD_DATA_COUNT_FIFO_OUT);
      end //block30
   endgenerate

   //If we are not using extra logic for the FWFT data count,
   //then connect RD_DATA_COUNT to the RD_DATA_COUNT from the
   //internal FIFO instance  
   generate
      if (C_USE_FWFT_DATA_COUNT==0 ) begin : block31
	 assign RD_DATA_COUNT = RD_DATA_COUNT_FIFO_OUT;
      end
   endgenerate

   //Always connect WR_DATA_COUNT to the WR_DATA_COUNT from the internal
   //FIFO instance
   generate
      if (C_USE_FWFT_DATA_COUNT==1) begin : block4
	 assign WR_DATA_COUNT = WR_DATA_COUNT_FIFO_OUT;
      end
      else begin : block4
	 assign WR_DATA_COUNT = WR_DATA_COUNT_FIFO_OUT;
      end
   endgenerate


   //Connect other flags to the internal FIFO instance
   assign 	FULL        = FULL_FIFO_OUT;
   assign 	ALMOST_FULL = ALMOST_FULL_FIFO_OUT;
   assign 	WR_ACK      = WR_ACK_FIFO_OUT;
   assign 	OVERFLOW    = OVERFLOW_FIFO_OUT;

   assign PROG_FULL = PROG_FULL_FIFO_OUT;

   assign 	PROG_EMPTY  = PROG_EMPTY_FIFO_OUT;

endmodule //FIFO_GENERATOR_V4_4
