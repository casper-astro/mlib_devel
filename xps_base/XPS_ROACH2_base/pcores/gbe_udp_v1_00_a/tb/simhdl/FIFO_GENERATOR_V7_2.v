/*
 *******************************************************************************
 *
 * FIFO Generator - Verilog Behavioral Model
 *
 *******************************************************************************
 *
 * (c) Copyright 1995 - 2009 Xilinx, Inc. All rights reserved.
 *
 * This file contains confidential and proprietary information
 * of Xilinx, Inc. and is protected under U.S. and
 * international copyright and other intellectual property
 * laws.
 *
 * DISCLAIMER
 * This disclaimer is not a license and does not grant any
 * rights to the materials distributed herewith. Except as
 * otherwise provided in a valid license issued to you by
 * Xilinx, and to the maximum extent permitted by applicable
 * law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
 * WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
 * AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
 * BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
 * INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
 * (2) Xilinx shall not be liable (whether in contract or tort,
 * including negligence, or under any other theory of
 * liability) for any loss or damage of any kind or nature
 * related to, arising under or in connection with these
 * materials, including for any direct, or any indirect,
 * special, incidental, or consequential loss or damage
 * (including loss of data, profits, goodwill, or any type of
 * loss or damage suffered as a result of any action brought
 * by a third party) even if such damage or loss was
 * reasonably foreseeable or Xilinx had been advised of the
 * possibility of the same.
 *
 * CRITICAL APPLICATIONS
 * Xilinx products are not designed or intended to be fail-
 * safe, or for use in any application requiring fail-safe
 * performance, such as life-support or safety devices or
 * systems, Class III medical devices, nuclear facilities,
 * applications related to the deployment of airbags, or any
 * other applications that could lead to death, personal
 * injury, or severe property or environmental damage
 * (individually and collectively, "Critical
 * Applications"). Customer assumes the sole risk and
 * liability of any use of Xilinx products in Critical
 * Applications, subject only to applicable laws and
 * regulations governing limitations on product liability.
 *
 * THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
 * PART OF THIS FILE AT ALL TIMES.
 *
 *******************************************************************************
 *******************************************************************************
 *
 * Filename: FIFO_GENERATOR_V7_2.v
 *
 * Author     : Xilinx
 *
 *******************************************************************************
 * Structure:
 * 
 * fifo_generator_v7_2.vhd
 *    |
 *    +-fifo_generator_v7_2_bhv_ver_as
 *    |
 *    +-fifo_generator_v7_2_bhv_ver_ss
 *    |
 *    +-fifo_generator_v7_2_bhv_ver_preload0
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

`timescale 1ps/1ps
`ifndef TCQ
 `define TCQ 100
`endif

`define LOG2VAL(x) ((x) == 8 ? 3 : (x) == 4 ? 2 : 1)

/*******************************************************************************
 * Declaration of top-level module
 ******************************************************************************/
module FIFO_GENERATOR_V7_2
  #(
    //-----------------------------------------------------------------------
    // Generic Declarations
    //-----------------------------------------------------------------------
    parameter C_COMMON_CLOCK                 = 0,
    parameter C_COUNT_TYPE                   = 0,
    parameter C_DATA_COUNT_WIDTH             = 2,
    parameter C_DEFAULT_VALUE                = "",
    parameter C_DIN_WIDTH                    = 8,
    parameter C_DOUT_RST_VAL                 = "",
    parameter C_DOUT_WIDTH                   = 8,
    parameter C_ENABLE_RLOCS                 = 0,
    parameter C_FAMILY                       = "",
    parameter C_FULL_FLAGS_RST_VAL           = 1,
    parameter C_HAS_ALMOST_EMPTY             = 0,
    parameter C_HAS_ALMOST_FULL              = 0,
    parameter C_HAS_BACKUP                   = 0,
    parameter C_HAS_DATA_COUNT               = 0,
    parameter C_HAS_INT_CLK                  = 0,
    parameter C_HAS_MEMINIT_FILE             = 0,
    parameter C_HAS_OVERFLOW                 = 0,
    parameter C_HAS_RD_DATA_COUNT            = 0,
    parameter C_HAS_RD_RST                   = 0,
    parameter C_HAS_RST                      = 1,
    parameter C_HAS_SRST                     = 0,
    parameter C_HAS_UNDERFLOW                = 0,
    parameter C_HAS_VALID                    = 0,
    parameter C_HAS_WR_ACK                   = 0,
    parameter C_HAS_WR_DATA_COUNT            = 0,
    parameter C_HAS_WR_RST                   = 0,
    parameter C_IMPLEMENTATION_TYPE          = 0,
    parameter C_INIT_WR_PNTR_VAL             = 0,
    parameter C_MEMORY_TYPE                  = 1,
    parameter C_MIF_FILE_NAME                = "",
    parameter C_OPTIMIZATION_MODE            = 0,
    parameter C_OVERFLOW_LOW                 = 0,
    parameter C_PRELOAD_LATENCY              = 1,
    parameter C_PRELOAD_REGS                 = 0,
    parameter C_PRIM_FIFO_TYPE               = "4kx4",
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL = 0,
    parameter C_PROG_EMPTY_THRESH_NEGATE_VAL = 0,
    parameter C_PROG_EMPTY_TYPE              = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL  = 0,
    parameter C_PROG_FULL_THRESH_NEGATE_VAL  = 0,
    parameter C_PROG_FULL_TYPE               = 0,
    parameter C_RD_DATA_COUNT_WIDTH          = 2,
    parameter C_RD_DEPTH                     = 256,
    parameter C_RD_FREQ                      = 1,
    parameter C_RD_PNTR_WIDTH                = 8,
    parameter C_UNDERFLOW_LOW                = 0,
    parameter C_USE_DOUT_RST                 = 0,
    parameter C_USE_ECC                      = 0,
    parameter C_USE_EMBEDDED_REG             = 0,
    parameter C_USE_FIFO16_FLAGS             = 0,
    parameter C_USE_FWFT_DATA_COUNT          = 0,
    parameter C_VALID_LOW                    = 0,
    parameter C_WR_ACK_LOW                   = 0,
    parameter C_WR_DATA_COUNT_WIDTH          = 2,
    parameter C_WR_DEPTH                     = 256,
    parameter C_WR_FREQ                      = 1,
    parameter C_WR_PNTR_WIDTH                = 8,
    parameter C_WR_RESPONSE_LATENCY          = 1,
    parameter C_MSGON_VAL                    = 1,
    parameter C_ENABLE_RST_SYNC              = 1,
    parameter C_ERROR_INJECTION_TYPE         = 0,

    // AXI Interface related parameters start here
    parameter C_INTERFACE_TYPE               = 0, // 0: Native Interface, 1: AXI Interface
    parameter C_AXI_TYPE                     = 0, // 0: AXI Stream, 1: AXI Full, 2: AXI Lite
    parameter C_HAS_AXI_WR_CHANNEL           = 0,
    parameter C_HAS_AXI_RD_CHANNEL           = 0,
    parameter C_HAS_SLAVE_CE                 = 0,
    parameter C_HAS_MASTER_CE                = 0,
    parameter C_ADD_NGC_CONSTRAINT           = 0,
    parameter C_USE_COMMON_UNDERFLOW         = 0,
    parameter C_USE_COMMON_OVERFLOW          = 0,
    parameter C_USE_DEFAULT_SETTINGS         = 0,

    // AXI Full/Lite
    parameter C_AXI_ID_WIDTH                 = 0,
    parameter C_AXI_ADDR_WIDTH               = 0,
    parameter C_AXI_DATA_WIDTH               = 0,
    parameter C_HAS_AXI_AWUSER               = 0,
    parameter C_HAS_AXI_WUSER                = 0,
    parameter C_HAS_AXI_BUSER                = 0,
    parameter C_HAS_AXI_ARUSER               = 0,
    parameter C_HAS_AXI_RUSER                = 0,
    parameter C_AXI_ARUSER_WIDTH             = 0,
    parameter C_AXI_AWUSER_WIDTH             = 0,
    parameter C_AXI_WUSER_WIDTH              = 0,
    parameter C_AXI_BUSER_WIDTH              = 0,
    parameter C_AXI_RUSER_WIDTH              = 0,

    // AXI Streaming
    parameter C_HAS_AXIS_TDATA               = 0,
    parameter C_HAS_AXIS_TID                 = 0,
    parameter C_HAS_AXIS_TDEST               = 0,
    parameter C_HAS_AXIS_TUSER               = 0,
    parameter C_HAS_AXIS_TREADY              = 0,
    parameter C_HAS_AXIS_TLAST               = 0,
    parameter C_HAS_AXIS_TSTRB               = 0,
    parameter C_HAS_AXIS_TKEEP               = 0,
    parameter C_AXIS_TDATA_WIDTH             = 1,
    parameter C_AXIS_TID_WIDTH               = 1,
    parameter C_AXIS_TDEST_WIDTH             = 1,
    parameter C_AXIS_TUSER_WIDTH             = 1,
    parameter C_AXIS_TSTRB_WIDTH             = 1,
    parameter C_AXIS_TKEEP_WIDTH             = 1,

    // AXI Channel Type
    // WACH --> Write Address Channel
    // WDCH --> Write Data Channel
    // WRCH --> Write Response Channel
    // RACH --> Read Address Channel
    // RDCH --> Read Data Channel
    // AXIS --> AXI Streaming
    parameter C_WACH_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logic
    parameter C_WDCH_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logie
    parameter C_WRCH_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logie
    parameter C_RACH_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logie
    parameter C_RDCH_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logie
    parameter C_AXIS_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logie

    // AXI Implementation Type
    // 1 = Common Clock Block RAM FIFO
    // 2 = Common Clock Distributed RAM FIFO
    // 11 = Independent Clock Block RAM FIFO
    // 12 = Independent Clock Distributed RAM FIFO
    parameter C_IMPLEMENTATION_TYPE_WACH     = 0,
    parameter C_IMPLEMENTATION_TYPE_WDCH     = 0,
    parameter C_IMPLEMENTATION_TYPE_WRCH     = 0,
    parameter C_IMPLEMENTATION_TYPE_RACH     = 0,
    parameter C_IMPLEMENTATION_TYPE_RDCH     = 0,
    parameter C_IMPLEMENTATION_TYPE_AXIS     = 0,

    // AXI FIFO Type
    // 0 = Data FIFO
    // 1 = Packet FIFO
    // 2 = Low Latency Data FIFO
    parameter C_APPLICATION_TYPE_WACH        = 0,
    parameter C_APPLICATION_TYPE_WDCH        = 0,
    parameter C_APPLICATION_TYPE_WRCH        = 0,
    parameter C_APPLICATION_TYPE_RACH        = 0,
    parameter C_APPLICATION_TYPE_RDCH        = 0,
    parameter C_APPLICATION_TYPE_AXIS        = 0,

    // Enable ECC
    // 0 = ECC disabled
    // 1 = ECC enabled
    parameter C_USE_ECC_WACH                 = 0,
    parameter C_USE_ECC_WDCH                 = 0,
    parameter C_USE_ECC_WRCH                 = 0,
    parameter C_USE_ECC_RACH                 = 0,
    parameter C_USE_ECC_RDCH                 = 0,
    parameter C_USE_ECC_AXIS                 = 0,

    // ECC Error Injection Type
    // 0 = No Error Injection
    // 1 = Single Bit Error Injection
    // 2 = Double Bit Error Injection
    // 3 = Single Bit and Double Bit Error Injection
    parameter C_ERROR_INJECTION_TYPE_WACH    = 0,
    parameter C_ERROR_INJECTION_TYPE_WDCH    = 0,
    parameter C_ERROR_INJECTION_TYPE_WRCH    = 0,
    parameter C_ERROR_INJECTION_TYPE_RACH    = 0,
    parameter C_ERROR_INJECTION_TYPE_RDCH    = 0,
    parameter C_ERROR_INJECTION_TYPE_AXIS    = 0,

    // Input Data Width
    // Accumulation of all AXI input signal's width
    parameter C_DIN_WIDTH_WACH               = 1,
    parameter C_DIN_WIDTH_WDCH               = 1,
    parameter C_DIN_WIDTH_WRCH               = 1,
    parameter C_DIN_WIDTH_RACH               = 1,
    parameter C_DIN_WIDTH_RDCH               = 1,
    parameter C_DIN_WIDTH_AXIS               = 1,

    parameter C_WR_DEPTH_WACH                = 16,
    parameter C_WR_DEPTH_WDCH                = 16,
    parameter C_WR_DEPTH_WRCH                = 16,
    parameter C_WR_DEPTH_RACH                = 16,
    parameter C_WR_DEPTH_RDCH                = 16,
    parameter C_WR_DEPTH_AXIS                = 16,

    parameter C_WR_PNTR_WIDTH_WACH           = 4,
    parameter C_WR_PNTR_WIDTH_WDCH           = 4,
    parameter C_WR_PNTR_WIDTH_WRCH           = 4,
    parameter C_WR_PNTR_WIDTH_RACH           = 4,
    parameter C_WR_PNTR_WIDTH_RDCH           = 4,
    parameter C_WR_PNTR_WIDTH_AXIS           = 4,

    parameter C_HAS_DATA_COUNTS_WACH         = 0,
    parameter C_HAS_DATA_COUNTS_WDCH         = 0,
    parameter C_HAS_DATA_COUNTS_WRCH         = 0,
    parameter C_HAS_DATA_COUNTS_RACH         = 0,
    parameter C_HAS_DATA_COUNTS_RDCH         = 0,
    parameter C_HAS_DATA_COUNTS_AXIS         = 0,

    parameter C_HAS_PROG_FLAGS_WACH          = 0,
    parameter C_HAS_PROG_FLAGS_WDCH          = 0,
    parameter C_HAS_PROG_FLAGS_WRCH          = 0,
    parameter C_HAS_PROG_FLAGS_RACH          = 0,
    parameter C_HAS_PROG_FLAGS_RDCH          = 0,
    parameter C_HAS_PROG_FLAGS_AXIS          = 0,

    parameter C_PROG_FULL_TYPE_WACH          = 0,
    parameter C_PROG_FULL_TYPE_WDCH          = 0,
    parameter C_PROG_FULL_TYPE_WRCH          = 0,
    parameter C_PROG_FULL_TYPE_RACH          = 0,
    parameter C_PROG_FULL_TYPE_RDCH          = 0,
    parameter C_PROG_FULL_TYPE_AXIS          = 0,

    parameter C_PROG_FULL_THRESH_ASSERT_VAL_WACH      = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL_WDCH      = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL_WRCH      = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL_RACH      = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL_RDCH      = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL_AXIS      = 0,

    parameter C_PROG_EMPTY_TYPE_WACH         = 0,
    parameter C_PROG_EMPTY_TYPE_WDCH         = 0,
    parameter C_PROG_EMPTY_TYPE_WRCH         = 0,
    parameter C_PROG_EMPTY_TYPE_RACH         = 0,
    parameter C_PROG_EMPTY_TYPE_RDCH         = 0,
    parameter C_PROG_EMPTY_TYPE_AXIS         = 0,

    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH     = 0,
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH     = 0,
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH     = 0,
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH     = 0,
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH     = 0,
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS     = 0,

    parameter C_REG_SLICE_MODE_WACH          = 0,
    parameter C_REG_SLICE_MODE_WDCH          = 0,
    parameter C_REG_SLICE_MODE_WRCH          = 0,
    parameter C_REG_SLICE_MODE_RACH          = 0,
    parameter C_REG_SLICE_MODE_RDCH          = 0,
    parameter C_REG_SLICE_MODE_AXIS          = 0

    )

   (
    //------------------------------------------------------------------------------
    // Input and Output Declarations
    //------------------------------------------------------------------------------

    // Conventional FIFO Interface Signals
    input                               BACKUP,
    input                               BACKUP_MARKER,
    input                               CLK,
    input                               RST,
    input                               SRST,
    input                               WR_CLK,
    input                               WR_RST,
    input                               RD_CLK,
    input                               RD_RST,
    input [C_DIN_WIDTH-1:0]             DIN,
    input                               WR_EN,
    input                               RD_EN,
    // Optional inputs
    input [C_RD_PNTR_WIDTH-1:0]         PROG_EMPTY_THRESH,
    input [C_RD_PNTR_WIDTH-1:0]         PROG_EMPTY_THRESH_ASSERT,
    input [C_RD_PNTR_WIDTH-1:0]         PROG_EMPTY_THRESH_NEGATE,
    input [C_WR_PNTR_WIDTH-1:0]         PROG_FULL_THRESH,
    input [C_WR_PNTR_WIDTH-1:0]         PROG_FULL_THRESH_ASSERT,
    input [C_WR_PNTR_WIDTH-1:0]         PROG_FULL_THRESH_NEGATE,
    input                               INT_CLK,
    input                               INJECTDBITERR,
    input                               INJECTSBITERR,

    output [C_DOUT_WIDTH-1:0]           DOUT,
    output                              FULL,
    output                              ALMOST_FULL,
    output                              WR_ACK,
    output                              OVERFLOW,
    output                              EMPTY,
    output                              ALMOST_EMPTY,
    output                              VALID,
    output                              UNDERFLOW,
    output [C_DATA_COUNT_WIDTH-1:0]     DATA_COUNT,
    output [C_RD_DATA_COUNT_WIDTH-1:0]  RD_DATA_COUNT,
    output [C_WR_DATA_COUNT_WIDTH-1:0]  WR_DATA_COUNT,
    output                              PROG_FULL,
    output                              PROG_EMPTY,
    output                              SBITERR,
    output                              DBITERR,


    // AXI Global Signal
    input                               M_ACLK,
    input                               S_ACLK,
    input                               S_ARESETN,
    input                               S_ACLK_EN,
    input                               M_ACLK_EN,
    
    // AXI Full/Lite Slave Write Channel (write side)
    input [C_AXI_ID_WIDTH-1:0]          S_AXI_AWID,
    input [C_AXI_ADDR_WIDTH-1:0]        S_AXI_AWADDR,
    input [8-1:0]                       S_AXI_AWLEN,
    input [3-1:0]                       S_AXI_AWSIZE,
    input [2-1:0]                       S_AXI_AWBURST,
    input [2-1:0]                       S_AXI_AWLOCK,
    input [4-1:0]                       S_AXI_AWCACHE,
    input [3-1:0]                       S_AXI_AWPROT,
    input [4-1:0]                       S_AXI_AWQOS,
    input [4-1:0]                       S_AXI_AWREGION,
    input [C_AXI_AWUSER_WIDTH-1:0]      S_AXI_AWUSER,
    input                               S_AXI_AWVALID,
    output                              S_AXI_AWREADY,
    input [C_AXI_ID_WIDTH-1:0]          S_AXI_WID,
    input [C_AXI_DATA_WIDTH-1:0]        S_AXI_WDATA,
    input [C_AXI_DATA_WIDTH/8-1:0]      S_AXI_WSTRB,
    input                               S_AXI_WLAST,
    input [C_AXI_WUSER_WIDTH-1:0]       S_AXI_WUSER,
    input                               S_AXI_WVALID,
    output                              S_AXI_WREADY,
    output [C_AXI_ID_WIDTH-1:0]         S_AXI_BID,
    output [2-1:0]                      S_AXI_BRESP,
    output [C_AXI_BUSER_WIDTH-1:0]      S_AXI_BUSER,
    output                              S_AXI_BVALID,
    input                               S_AXI_BREADY,
    
    // AXI Full/Lite Master Write Channel (Read side)
    output [C_AXI_ID_WIDTH-1:0]         M_AXI_AWID,
    output [C_AXI_ADDR_WIDTH-1:0]       M_AXI_AWADDR,
    output [8-1:0]                      M_AXI_AWLEN,
    output [3-1:0]                      M_AXI_AWSIZE,
    output [2-1:0]                      M_AXI_AWBURST,
    output [2-1:0]                      M_AXI_AWLOCK,
    output [4-1:0]                      M_AXI_AWCACHE,
    output [3-1:0]                      M_AXI_AWPROT,
    output [4-1:0]                      M_AXI_AWQOS,
    output [4-1:0]                      M_AXI_AWREGION,
    output [C_AXI_AWUSER_WIDTH-1:0]     M_AXI_AWUSER,
    output                              M_AXI_AWVALID,
    input                               M_AXI_AWREADY,
    output [C_AXI_ID_WIDTH-1:0]         M_AXI_WID,
    output [C_AXI_DATA_WIDTH-1:0]       M_AXI_WDATA,
    output [C_AXI_DATA_WIDTH/8-1:0]     M_AXI_WSTRB,
    output                              M_AXI_WLAST,
    output [C_AXI_WUSER_WIDTH-1:0]      M_AXI_WUSER,
    output                              M_AXI_WVALID,
    input                               M_AXI_WREADY,
    input [C_AXI_ID_WIDTH-1:0]          M_AXI_BID,
    input [2-1:0]                       M_AXI_BRESP,
    input [C_AXI_BUSER_WIDTH-1:0]       M_AXI_BUSER,
    input                               M_AXI_BVALID,
    output                              M_AXI_BREADY,
    
    
    // AXI Full/Lite Slave Read Channel (Write side)
    input [C_AXI_ID_WIDTH-1:0]          S_AXI_ARID,
    input [C_AXI_ADDR_WIDTH-1:0]        S_AXI_ARADDR, 
    input [8-1:0]                       S_AXI_ARLEN,
    input [3-1:0]                       S_AXI_ARSIZE,
    input [2-1:0]                       S_AXI_ARBURST,
    input [2-1:0]                       S_AXI_ARLOCK,
    input [4-1:0]                       S_AXI_ARCACHE,
    input [3-1:0]                       S_AXI_ARPROT,
    input [4-1:0]                       S_AXI_ARQOS,
    input [4-1:0]                       S_AXI_ARREGION,
    input [C_AXI_ARUSER_WIDTH-1:0]      S_AXI_ARUSER,
    input                               S_AXI_ARVALID,
    output                              S_AXI_ARREADY,
    output [C_AXI_ID_WIDTH-1:0]         S_AXI_RID,       
    output [C_AXI_DATA_WIDTH-1:0]       S_AXI_RDATA, 
    output [2-1:0]                      S_AXI_RRESP,
    output                              S_AXI_RLAST,
    output [C_AXI_RUSER_WIDTH-1:0]      S_AXI_RUSER,
    output                              S_AXI_RVALID,
    input                               S_AXI_RREADY,
    
    
    
    // AXI Full/Lite Master Read Channel (Read side)
    output [C_AXI_ID_WIDTH-1:0]         M_AXI_ARID,        
    output [C_AXI_ADDR_WIDTH-1:0]       M_AXI_ARADDR,  
    output [8-1:0]                      M_AXI_ARLEN,
    output [3-1:0]                      M_AXI_ARSIZE,
    output [2-1:0]                      M_AXI_ARBURST,
    output [2-1:0]                      M_AXI_ARLOCK,
    output [4-1:0]                      M_AXI_ARCACHE,
    output [3-1:0]                      M_AXI_ARPROT,
    output [4-1:0]                      M_AXI_ARQOS,
    output [4-1:0]                      M_AXI_ARREGION,
    output [C_AXI_ARUSER_WIDTH-1:0]     M_AXI_ARUSER,
    output                              M_AXI_ARVALID,
    input                               M_AXI_ARREADY,
    input [C_AXI_ID_WIDTH-1:0]          M_AXI_RID,        
    input [C_AXI_DATA_WIDTH-1:0]        M_AXI_RDATA,  
    input [2-1:0]                       M_AXI_RRESP,
    input                               M_AXI_RLAST,
    input [C_AXI_RUSER_WIDTH-1:0]       M_AXI_RUSER,
    input                               M_AXI_RVALID,
    output                              M_AXI_RREADY,
    
    
    // AXI Streaming Slave Signals (Write side)
    input                               S_AXIS_TVALID,
    output                              S_AXIS_TREADY,
    input [C_AXIS_TDATA_WIDTH-1:0]      S_AXIS_TDATA,
    input [C_AXIS_TSTRB_WIDTH-1:0]      S_AXIS_TSTRB,
    input [C_AXIS_TKEEP_WIDTH-1:0]      S_AXIS_TKEEP,
    input                               S_AXIS_TLAST,
    input [C_AXIS_TID_WIDTH-1:0]        S_AXIS_TID,
    input [C_AXIS_TDEST_WIDTH-1:0]      S_AXIS_TDEST,
    input [C_AXIS_TUSER_WIDTH-1:0]      S_AXIS_TUSER,
    
    // AXI Streaming Master Signals (Read side)
    output                              M_AXIS_TVALID,
    input                               M_AXIS_TREADY,
    output [C_AXIS_TDATA_WIDTH-1:0]     M_AXIS_TDATA,
    output [C_AXIS_TSTRB_WIDTH-1:0]     M_AXIS_TSTRB,
    output [C_AXIS_TKEEP_WIDTH-1:0]     M_AXIS_TKEEP,
    output                              M_AXIS_TLAST,
    output [C_AXIS_TID_WIDTH-1:0]       M_AXIS_TID,
    output [C_AXIS_TDEST_WIDTH-1:0]     M_AXIS_TDEST,
    output [C_AXIS_TUSER_WIDTH-1:0]     M_AXIS_TUSER,
    
           
    
    
    // AXI Full/Lite Write Address Channel Signals
    input                               AXI_AW_INJECTSBITERR,
    input                               AXI_AW_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_WACH-1:0]   AXI_AW_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_WACH-1:0]   AXI_AW_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_WACH:0]     AXI_AW_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WACH:0]     AXI_AW_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WACH:0]     AXI_AW_RD_DATA_COUNT,
    output                              AXI_AW_SBITERR,
    output                              AXI_AW_DBITERR,
    output                              AXI_AW_OVERFLOW,
    output                              AXI_AW_UNDERFLOW,
    
    
    // AXI Full/Lite Write Data Channel Signals
    input                               AXI_W_INJECTSBITERR,
    input                               AXI_W_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_WDCH-1:0]   AXI_W_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_WDCH-1:0]   AXI_W_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_WDCH:0]     AXI_W_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WDCH:0]     AXI_W_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WDCH:0]     AXI_W_RD_DATA_COUNT,
    output                              AXI_W_SBITERR,
    output                              AXI_W_DBITERR,
    output                              AXI_W_OVERFLOW,
    output                              AXI_W_UNDERFLOW,
    
    
    // AXI Full/Lite Write Response Channel Signals
    input                               AXI_B_INJECTSBITERR,
    input                               AXI_B_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_WRCH-1:0]   AXI_B_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_WRCH-1:0]   AXI_B_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_WRCH:0]     AXI_B_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WRCH:0]     AXI_B_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WRCH:0]     AXI_B_RD_DATA_COUNT,
    output                              AXI_B_SBITERR,
    output                              AXI_B_DBITERR,
    output                              AXI_B_OVERFLOW,
    output                              AXI_B_UNDERFLOW,
    
    
    
    // AXI Full/Lite Read Address Channel Signals
    input                               AXI_AR_INJECTSBITERR,
    input                               AXI_AR_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_RACH-1:0]   AXI_AR_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_RACH-1:0]   AXI_AR_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_RACH:0]     AXI_AR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_RACH:0]     AXI_AR_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_RACH:0]     AXI_AR_RD_DATA_COUNT,
    output                              AXI_AR_SBITERR,
    output                              AXI_AR_DBITERR,
    output                              AXI_AR_OVERFLOW,
    output                              AXI_AR_UNDERFLOW,

    
    // AXI Full/Lite Read Data Channel Signals
    input                               AXI_R_INJECTSBITERR,
    input                               AXI_R_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_RDCH-1:0]   AXI_R_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_RDCH-1:0]   AXI_R_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_RDCH:0]     AXI_R_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_RDCH:0]     AXI_R_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_RDCH:0]     AXI_R_RD_DATA_COUNT,
    output                              AXI_R_SBITERR,
    output                              AXI_R_DBITERR,
    output                              AXI_R_OVERFLOW,
    output                              AXI_R_UNDERFLOW,

    
    // AXI Streaming FIFO Related Signals
    input                               AXIS_INJECTSBITERR,
    input                               AXIS_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_AXIS-1:0]   AXIS_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_AXIS-1:0]   AXIS_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_AXIS:0]     AXIS_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_AXIS:0]     AXIS_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_AXIS:0]     AXIS_RD_DATA_COUNT,
    output                              AXIS_SBITERR,
    output                              AXIS_DBITERR,
    output                              AXIS_OVERFLOW,
    output                              AXIS_UNDERFLOW

    );

  generate if (C_INTERFACE_TYPE == 0) begin : conv_fifo

    FIFO_GENERATOR_V7_2_CONV_VER
      #(
        .C_COMMON_CLOCK 		(C_COMMON_CLOCK),
        .C_COUNT_TYPE			(C_COUNT_TYPE),
        .C_DATA_COUNT_WIDTH		(C_DATA_COUNT_WIDTH),
        .C_DEFAULT_VALUE		(C_DEFAULT_VALUE),
        .C_DIN_WIDTH			(C_DIN_WIDTH),
        .C_DOUT_RST_VAL			(C_DOUT_RST_VAL),
        .C_DOUT_WIDTH			(C_DOUT_WIDTH),
        .C_ENABLE_RLOCS			(C_ENABLE_RLOCS),
        .C_FAMILY			(C_FAMILY),
        .C_FULL_FLAGS_RST_VAL           (C_FULL_FLAGS_RST_VAL),
        .C_HAS_ALMOST_EMPTY		(C_HAS_ALMOST_EMPTY),
        .C_HAS_ALMOST_FULL		(C_HAS_ALMOST_FULL),
        .C_HAS_BACKUP			(C_HAS_BACKUP),
        .C_HAS_DATA_COUNT		(C_HAS_DATA_COUNT),
        .C_HAS_INT_CLK                  (C_HAS_INT_CLK),
        .C_HAS_MEMINIT_FILE		(C_HAS_MEMINIT_FILE),
        .C_HAS_OVERFLOW			(C_HAS_OVERFLOW),
        .C_HAS_RD_DATA_COUNT		(C_HAS_RD_DATA_COUNT),
        .C_HAS_RD_RST			(C_HAS_RD_RST),
        .C_HAS_RST			(C_HAS_RST),
        .C_HAS_SRST			(C_HAS_SRST),
        .C_HAS_UNDERFLOW		(C_HAS_UNDERFLOW),
        .C_HAS_VALID			(C_HAS_VALID),
        .C_HAS_WR_ACK			(C_HAS_WR_ACK),
        .C_HAS_WR_DATA_COUNT		(C_HAS_WR_DATA_COUNT),
        .C_HAS_WR_RST			(C_HAS_WR_RST),
        .C_IMPLEMENTATION_TYPE		(C_IMPLEMENTATION_TYPE),
        .C_INIT_WR_PNTR_VAL		(C_INIT_WR_PNTR_VAL),
        .C_MEMORY_TYPE			(C_MEMORY_TYPE),
        .C_MIF_FILE_NAME		(C_MIF_FILE_NAME),
        .C_OPTIMIZATION_MODE		(C_OPTIMIZATION_MODE),
        .C_OVERFLOW_LOW			(C_OVERFLOW_LOW),
        .C_PRELOAD_LATENCY		(C_PRELOAD_LATENCY),
        .C_PRELOAD_REGS			(C_PRELOAD_REGS),
        .C_PRIM_FIFO_TYPE		(C_PRIM_FIFO_TYPE),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL	(C_PROG_EMPTY_THRESH_ASSERT_VAL),
        .C_PROG_EMPTY_THRESH_NEGATE_VAL	(C_PROG_EMPTY_THRESH_NEGATE_VAL),
        .C_PROG_EMPTY_TYPE		(C_PROG_EMPTY_TYPE),
        .C_PROG_FULL_THRESH_ASSERT_VAL	(C_PROG_FULL_THRESH_ASSERT_VAL),
        .C_PROG_FULL_THRESH_NEGATE_VAL	(C_PROG_FULL_THRESH_NEGATE_VAL),
        .C_PROG_FULL_TYPE		(C_PROG_FULL_TYPE),
        .C_RD_DATA_COUNT_WIDTH		(C_RD_DATA_COUNT_WIDTH),
        .C_RD_DEPTH			(C_RD_DEPTH),
        .C_RD_FREQ			(C_RD_FREQ),
        .C_RD_PNTR_WIDTH		(C_RD_PNTR_WIDTH),
        .C_UNDERFLOW_LOW		(C_UNDERFLOW_LOW),
        .C_USE_DOUT_RST                 (C_USE_DOUT_RST),
        .C_USE_ECC                      (C_USE_ECC),
        .C_USE_EMBEDDED_REG		(C_USE_EMBEDDED_REG),
        .C_USE_FIFO16_FLAGS		(C_USE_FIFO16_FLAGS),
        .C_USE_FWFT_DATA_COUNT		(C_USE_FWFT_DATA_COUNT),
        .C_VALID_LOW			(C_VALID_LOW),
        .C_WR_ACK_LOW			(C_WR_ACK_LOW),
        .C_WR_DATA_COUNT_WIDTH		(C_WR_DATA_COUNT_WIDTH),
        .C_WR_DEPTH			(C_WR_DEPTH),
        .C_WR_FREQ			(C_WR_FREQ),
        .C_WR_PNTR_WIDTH		(C_WR_PNTR_WIDTH),
        .C_WR_RESPONSE_LATENCY		(C_WR_RESPONSE_LATENCY),
        .C_MSGON_VAL                    (C_MSGON_VAL),
        .C_ENABLE_RST_SYNC              (C_ENABLE_RST_SYNC),
        .C_ERROR_INJECTION_TYPE         (C_ERROR_INJECTION_TYPE)
      )
    fifo_generator_v7_2_conv_dut
      (
        .BACKUP                   (BACKUP),
        .BACKUP_MARKER            (BACKUP_MARKER),
        .CLK                      (CLK),
        .RST                      (RST),
        .SRST                     (SRST),
        .WR_CLK                   (WR_CLK),
        .WR_RST                   (WR_RST),
        .RD_CLK                   (RD_CLK),
        .RD_RST                   (RD_RST),
        .DIN                      (DIN),
        .WR_EN                    (WR_EN),
        .RD_EN                    (RD_EN),
        .PROG_EMPTY_THRESH        (PROG_EMPTY_THRESH),
        .PROG_EMPTY_THRESH_ASSERT (PROG_EMPTY_THRESH_ASSERT),
        .PROG_EMPTY_THRESH_NEGATE (PROG_EMPTY_THRESH_NEGATE),
        .PROG_FULL_THRESH         (PROG_FULL_THRESH),
        .PROG_FULL_THRESH_ASSERT  (PROG_FULL_THRESH_ASSERT),
        .PROG_FULL_THRESH_NEGATE  (PROG_FULL_THRESH_NEGATE),
        .INT_CLK                  (INT_CLK),
        .INJECTDBITERR            (INJECTDBITERR), 
        .INJECTSBITERR            (INJECTSBITERR),
  
        .DOUT                     (DOUT),
        .FULL                     (FULL),
        .ALMOST_FULL              (ALMOST_FULL),
        .WR_ACK                   (WR_ACK),
        .OVERFLOW                 (OVERFLOW),
        .EMPTY                    (EMPTY),
        .ALMOST_EMPTY             (ALMOST_EMPTY),
        .VALID                    (VALID),
        .UNDERFLOW                (UNDERFLOW),
        .DATA_COUNT               (DATA_COUNT),
        .RD_DATA_COUNT            (RD_DATA_COUNT),
        .WR_DATA_COUNT            (WR_DATA_COUNT),
        .PROG_FULL                (PROG_FULL),
        .PROG_EMPTY               (PROG_EMPTY),
        .SBITERR                  (SBITERR),
        .DBITERR                  (DBITERR)
       );
  end endgenerate

  localparam C_AXI_LEN_WIDTH    = 8;
  localparam C_AXI_SIZE_WIDTH   = 3;
  localparam C_AXI_BURST_WIDTH  = 2;
  localparam C_AXI_LOCK_WIDTH   = 2;
  localparam C_AXI_CACHE_WIDTH  = 4;
  localparam C_AXI_PROT_WIDTH   = 3;
  localparam C_AXI_QOS_WIDTH    = 4;
  localparam C_AXI_REGION_WIDTH = 4;
  localparam C_AXI_BRESP_WIDTH  = 2;
  localparam C_AXI_RRESP_WIDTH  = 2;

  localparam IS_AXI_STREAMING  = ((C_INTERFACE_TYPE == 1) && (C_AXI_TYPE == 0)) ? 1 : 0;
  localparam TDATA_OFFSET      = C_HAS_AXIS_TDATA == 1 ? C_DIN_WIDTH_AXIS-C_AXIS_TDATA_WIDTH : C_DIN_WIDTH_AXIS;
  localparam TSTRB_OFFSET      = C_HAS_AXIS_TSTRB == 1 ? TDATA_OFFSET-C_AXIS_TSTRB_WIDTH : TDATA_OFFSET;
  localparam TKEEP_OFFSET      = C_HAS_AXIS_TKEEP == 1 ? TSTRB_OFFSET-C_AXIS_TKEEP_WIDTH : TSTRB_OFFSET;
  localparam TID_OFFSET        = C_HAS_AXIS_TID   == 1 ? TKEEP_OFFSET-C_AXIS_TID_WIDTH : TKEEP_OFFSET;
  localparam TDEST_OFFSET      = C_HAS_AXIS_TDEST == 1 ? TID_OFFSET-C_AXIS_TDEST_WIDTH : TID_OFFSET;
  localparam TUSER_OFFSET      = C_HAS_AXIS_TUSER == 1 ? TDEST_OFFSET-C_AXIS_TUSER_WIDTH : TDEST_OFFSET;

  wire                          inverted_reset = ~S_ARESETN;
  wire  [C_DIN_WIDTH_AXIS-1:0]  axis_din          ;
  wire  [C_DIN_WIDTH_AXIS-1:0] axis_dout         ;
  wire                          axis_full         ;
  wire                          axis_almost_full  ;
  wire                          axis_prog_full    ;
  wire                          axis_empty        ;
  wire                          axis_almost_empty ;
  wire                          axis_prog_empty   ;

  generate if (IS_AXI_STREAMING == 1) begin : axi_streaming

    FIFO_GENERATOR_V7_2_CONV_VER
      #(
        .C_FAMILY			(C_FAMILY),
//        .C_COMMON_CLOCK                 ((C_COMMON_CLOCK < 3) ? 1 : 0),
        .C_COMMON_CLOCK                 (C_COMMON_CLOCK),
        .C_MEMORY_TYPE			((C_IMPLEMENTATION_TYPE_AXIS == 1 || C_IMPLEMENTATION_TYPE_AXIS == 11) ? 1 : 2),
        .C_IMPLEMENTATION_TYPE		(C_IMPLEMENTATION_TYPE_AXIS < 3 ? 0 : 2),
        .C_PRELOAD_REGS			(1), // always FWFT for AXI
        .C_PRELOAD_LATENCY		(0), // always FWFT for AXI
        .C_DIN_WIDTH			(C_DIN_WIDTH_AXIS),
        .C_WR_DEPTH			(C_WR_DEPTH_AXIS),
        .C_WR_PNTR_WIDTH		(C_WR_PNTR_WIDTH_AXIS),
        .C_DOUT_WIDTH			(C_DIN_WIDTH_AXIS),
        .C_RD_DEPTH			(C_WR_DEPTH_AXIS),
        .C_RD_PNTR_WIDTH		(C_WR_PNTR_WIDTH_AXIS),
        .C_PROG_FULL_TYPE		(C_PROG_FULL_TYPE_AXIS),
        .C_PROG_FULL_THRESH_ASSERT_VAL	(C_PROG_FULL_THRESH_ASSERT_VAL_AXIS),
//        .C_PROG_FULL_THRESH_NEGATE_VAL	(C_PROG_FULL_THRESH_NEGATE_VAL_AXIS),
        .C_PROG_EMPTY_TYPE		(C_PROG_EMPTY_TYPE_AXIS),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL	(C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS),
//        .C_PROG_EMPTY_THRESH_NEGATE_VAL	(C_PROG_EMPTY_THRESH_NEGATE_VAL_AXIS),
        .C_USE_ECC                      (C_USE_ECC_AXIS),
        .C_ERROR_INJECTION_TYPE         (C_ERROR_INJECTION_TYPE_AXIS),
        .C_HAS_ALMOST_EMPTY		((C_PROG_EMPTY_TYPE_AXIS == 6) ? 1 : 0),
        .C_HAS_ALMOST_FULL		((C_PROG_FULL_TYPE_AXIS == 6) ? 1 : 0),

        .C_HAS_WR_RST			(0),
        .C_HAS_RD_RST			(0),
        .C_HAS_RST			(C_HAS_RST),
        .C_HAS_SRST			(0),
        .C_DOUT_RST_VAL			(C_DOUT_RST_VAL),

        .C_HAS_VALID			(0),
        .C_VALID_LOW			(C_VALID_LOW),
        .C_HAS_UNDERFLOW		(C_HAS_UNDERFLOW),
        .C_UNDERFLOW_LOW		(C_UNDERFLOW_LOW),
        .C_HAS_WR_ACK			(0),
        .C_WR_ACK_LOW			(C_WR_ACK_LOW),
        .C_HAS_OVERFLOW			(C_HAS_OVERFLOW),
        .C_OVERFLOW_LOW			(C_OVERFLOW_LOW),

        .C_HAS_DATA_COUNT		((C_COMMON_CLOCK == 1 && C_HAS_DATA_COUNTS_AXIS == 1) ? 1 : 0),
        .C_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_AXIS + 1),
        .C_HAS_RD_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_AXIS == 1) ? 1 : 0),
        .C_RD_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_AXIS + 1),
        .C_USE_FWFT_DATA_COUNT		(1), // use extra logic is always true
        .C_HAS_WR_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_AXIS == 1) ? 1 : 0),
        .C_WR_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_AXIS + 1),
        .C_FULL_FLAGS_RST_VAL           (1),
        .C_USE_EMBEDDED_REG		(0),
        .C_USE_DOUT_RST                 (0),
        .C_MSGON_VAL                    (C_MSGON_VAL),
        .C_ENABLE_RST_SYNC              (1),

        .C_COUNT_TYPE			(C_COUNT_TYPE),
        .C_DEFAULT_VALUE		(C_DEFAULT_VALUE),
        .C_ENABLE_RLOCS			(C_ENABLE_RLOCS),
        .C_HAS_BACKUP			(C_HAS_BACKUP),
        .C_HAS_INT_CLK                  (C_HAS_INT_CLK),
        .C_MIF_FILE_NAME		(C_MIF_FILE_NAME),
        .C_HAS_MEMINIT_FILE		(C_HAS_MEMINIT_FILE),
        .C_INIT_WR_PNTR_VAL		(C_INIT_WR_PNTR_VAL),
        .C_OPTIMIZATION_MODE		(C_OPTIMIZATION_MODE),
        .C_PRIM_FIFO_TYPE		(C_PRIM_FIFO_TYPE),
        .C_RD_FREQ			(C_RD_FREQ),
        .C_USE_FIFO16_FLAGS		(C_USE_FIFO16_FLAGS),
        .C_WR_FREQ			(C_WR_FREQ),
        .C_WR_RESPONSE_LATENCY		(C_WR_RESPONSE_LATENCY)
      )
    fifo_generator_v7_2_axis_dut
      (
        .CLK                      (S_ACLK),
        .WR_CLK                   (S_ACLK),
        .RD_CLK                   (M_ACLK),
        .RST                      (inverted_reset),
        .SRST                     (1'b0),
        .WR_RST                   (inverted_reset),
        .RD_RST                   (inverted_reset),
        .WR_EN                    (S_AXIS_TVALID),
        .RD_EN                    (M_AXIS_TREADY),
        .PROG_FULL_THRESH         (AXIS_PROG_FULL_THRESH),
        .PROG_FULL_THRESH_ASSERT  ({C_WR_PNTR_WIDTH_AXIS{1'b0}}),
        .PROG_FULL_THRESH_NEGATE  ({C_WR_PNTR_WIDTH_AXIS{1'b0}}),
        .PROG_EMPTY_THRESH        (AXIS_PROG_EMPTY_THRESH),
        .PROG_EMPTY_THRESH_ASSERT ({C_WR_PNTR_WIDTH_AXIS{1'b0}}),
        .PROG_EMPTY_THRESH_NEGATE ({C_WR_PNTR_WIDTH_AXIS{1'b0}}),
        .INJECTDBITERR            (AXIS_INJECTDBITERR), 
        .INJECTSBITERR            (AXIS_INJECTSBITERR),
  
        .DIN                      (axis_din),
        .DOUT                     (axis_dout),
        .FULL                     (axis_full),
        .ALMOST_FULL              (axis_almost_full),
        .PROG_FULL                (axis_prog_full),
        .EMPTY                    (axis_empty),
        .ALMOST_EMPTY             (axis_almost_empty),
        .PROG_EMPTY               (axis_prog_empty),
  
        .WR_ACK                   (),
        .OVERFLOW                 (AXIS_OVERFLOW),
        .VALID                    (),
        .UNDERFLOW                (AXIS_UNDERFLOW),
        .DATA_COUNT               (AXIS_DATA_COUNT),
        .RD_DATA_COUNT            (AXIS_RD_DATA_COUNT),
        .WR_DATA_COUNT            (AXIS_WR_DATA_COUNT),
        .SBITERR                  (AXIS_SBITERR),
        .DBITERR                  (AXIS_DBITERR),
  
        .BACKUP                   (BACKUP),
        .BACKUP_MARKER            (BACKUP_MARKER),
        .INT_CLK                  (INT_CLK)
       );

    assign S_AXIS_TREADY = C_PROG_FULL_TYPE_AXIS == 5 ? ~axis_full : 
                           C_PROG_FULL_TYPE_AXIS == 6 ? ~axis_almost_full : ~axis_prog_full;
    assign M_AXIS_TVALID = C_PROG_EMPTY_TYPE_AXIS == 5 ? ~axis_empty : 
                           C_PROG_EMPTY_TYPE_AXIS == 6 ? ~axis_almost_empty : ~axis_prog_empty;
  end endgenerate // axi_streaming


  generate if (IS_AXI_STREAMING == 1 && C_HAS_AXIS_TDATA == 1) begin : tdata
    assign axis_din[C_DIN_WIDTH_AXIS-1:TDATA_OFFSET] = S_AXIS_TDATA;
    assign M_AXIS_TDATA   = axis_dout[C_DIN_WIDTH_AXIS-1:TDATA_OFFSET];
  end endgenerate

  generate if (IS_AXI_STREAMING == 1 && C_HAS_AXIS_TSTRB == 1) begin : tstrb
    assign axis_din[TDATA_OFFSET-1:TSTRB_OFFSET] = S_AXIS_TSTRB;
    assign M_AXIS_TSTRB   = axis_dout[TDATA_OFFSET-1:TSTRB_OFFSET];
  end endgenerate

  generate if (IS_AXI_STREAMING == 1 && C_HAS_AXIS_TKEEP == 1) begin : tkeep
    assign axis_din[TSTRB_OFFSET-1:TKEEP_OFFSET] = S_AXIS_TKEEP;
    assign M_AXIS_TKEEP   = axis_dout[TSTRB_OFFSET-1:TKEEP_OFFSET];
  end endgenerate

  generate if (IS_AXI_STREAMING == 1 && C_HAS_AXIS_TID == 1) begin : tid
    assign axis_din[TKEEP_OFFSET-1:TID_OFFSET] = S_AXIS_TID;
    assign M_AXIS_TID     = axis_dout[TKEEP_OFFSET-1:TID_OFFSET];
  end endgenerate

  generate if (IS_AXI_STREAMING == 1 && C_HAS_AXIS_TDEST == 1) begin : tdest
    assign axis_din[TID_OFFSET-1:TDEST_OFFSET] = S_AXIS_TDEST;
    assign M_AXIS_TDEST   = axis_dout[TID_OFFSET-1:TDEST_OFFSET];
  end endgenerate

  generate if (IS_AXI_STREAMING == 1 && C_HAS_AXIS_TUSER == 1) begin : tuser
    assign axis_din[TDEST_OFFSET-1:TUSER_OFFSET] = S_AXIS_TUSER;
    assign M_AXIS_TUSER   = axis_dout[TDEST_OFFSET-1:TUSER_OFFSET];
  end endgenerate

  generate if (IS_AXI_STREAMING == 1 && C_HAS_AXIS_TLAST == 1) begin : tlast
    assign axis_din[0] = S_AXIS_TLAST;
    assign M_AXIS_TLAST   = axis_dout[0];
  end endgenerate

  //###########################################################################
  //  AXI FULL Write Channel (axi_write_channel)
  //###########################################################################

  localparam IS_AXI_FULL_WR_CH = ((C_INTERFACE_TYPE == 1) && (C_AXI_TYPE == 1) && C_HAS_AXI_WR_CHANNEL == 1) ? 1 : 0;
  localparam IS_AXI_FULL_RD_CH = ((C_INTERFACE_TYPE == 1) && (C_AXI_TYPE == 1) && C_HAS_AXI_RD_CHANNEL == 1) ? 1 : 0;
  localparam IS_AXI_LITE_WR_CH = ((C_INTERFACE_TYPE == 1) && (C_AXI_TYPE == 2) && C_HAS_AXI_WR_CHANNEL == 1) ? 1 : 0;
  localparam IS_AXI_LITE_RD_CH = ((C_INTERFACE_TYPE == 1) && (C_AXI_TYPE == 2) && C_HAS_AXI_RD_CHANNEL == 1) ? 1 : 0;

  localparam AWID_OFFSET       = C_AXI_TYPE == 1 ? C_DIN_WIDTH_WACH - C_AXI_ID_WIDTH : C_DIN_WIDTH_WACH;
  localparam AWADDR_OFFSET     = AWID_OFFSET - C_AXI_ADDR_WIDTH;
  localparam AWLEN_OFFSET      = C_AXI_TYPE == 1 ? AWADDR_OFFSET - C_AXI_LEN_WIDTH : AWADDR_OFFSET;
  localparam AWSIZE_OFFSET     = C_AXI_TYPE == 1 ? AWLEN_OFFSET - C_AXI_SIZE_WIDTH : AWLEN_OFFSET;
  localparam AWBURST_OFFSET    = C_AXI_TYPE == 1 ? AWSIZE_OFFSET - C_AXI_BURST_WIDTH : AWSIZE_OFFSET;
  localparam AWLOCK_OFFSET     = C_AXI_TYPE == 1 ? AWBURST_OFFSET - C_AXI_LOCK_WIDTH : AWBURST_OFFSET;
  localparam AWCACHE_OFFSET    = C_AXI_TYPE == 1 ? AWLOCK_OFFSET - C_AXI_CACHE_WIDTH : AWLOCK_OFFSET;
  localparam AWPROT_OFFSET     = AWCACHE_OFFSET - C_AXI_PROT_WIDTH;
  localparam AWQOS_OFFSET      = AWPROT_OFFSET - C_AXI_QOS_WIDTH;
  localparam AWREGION_OFFSET   = AWQOS_OFFSET - C_AXI_REGION_WIDTH;
  localparam AWUSER_OFFSET     = C_HAS_AXI_AWUSER == 1 ? AWREGION_OFFSET-C_AXI_AWUSER_WIDTH : AWREGION_OFFSET;

  localparam WID_OFFSET        = C_AXI_TYPE == 1 ? C_DIN_WIDTH_WDCH - C_AXI_ID_WIDTH : C_DIN_WIDTH_WDCH;
  localparam WDATA_OFFSET      = WID_OFFSET - C_AXI_DATA_WIDTH;
  localparam WSTRB_OFFSET      = WDATA_OFFSET - C_AXI_DATA_WIDTH/8;
  localparam WUSER_OFFSET      = C_HAS_AXI_WUSER == 1 ? WSTRB_OFFSET-C_AXI_WUSER_WIDTH : WSTRB_OFFSET;

  localparam BID_OFFSET        = C_AXI_TYPE == 1 ? C_DIN_WIDTH_WRCH - C_AXI_ID_WIDTH : C_DIN_WIDTH_WRCH;
  localparam BRESP_OFFSET      = BID_OFFSET - C_AXI_BRESP_WIDTH;
  localparam BUSER_OFFSET      = C_HAS_AXI_BUSER == 1 ? BRESP_OFFSET-C_AXI_BUSER_WIDTH : BRESP_OFFSET;


  wire  [C_DIN_WIDTH_WACH-1:0]  wach_din          ;
  wire  [C_DIN_WIDTH_WACH-1:0]  wach_dout         ;
  wire                          wach_full         ;
  wire                          wach_almost_full  ;
  wire                          wach_prog_full    ;
  wire                          wach_empty        ;
  wire                          wach_almost_empty ;
  wire                          wach_prog_empty   ;
  wire  [C_DIN_WIDTH_WDCH-1:0]  wdch_din          ;
  wire  [C_DIN_WIDTH_WDCH-1:0]  wdch_dout         ;
  wire                          wdch_full         ;
  wire                          wdch_almost_full  ;
  wire                          wdch_prog_full    ;
  wire                          wdch_empty        ;
  wire                          wdch_almost_empty ;
  wire                          wdch_prog_empty   ;
  wire  [C_DIN_WIDTH_WRCH-1:0]  wrch_din          ;
  wire  [C_DIN_WIDTH_WRCH-1:0]  wrch_dout         ;
  wire                          wrch_full         ;
  wire                          wrch_almost_full  ;
  wire                          wrch_prog_full    ;
  wire                          wrch_empty        ;
  wire                          wrch_almost_empty ;
  wire                          wrch_prog_empty   ;
  wire                          axi_aw_underflow_i;
  wire                          axi_w_underflow_i ;
  wire                          axi_b_underflow_i ;
  wire                          axi_aw_overflow_i ;
  wire                          axi_w_overflow_i  ;
  wire                          axi_b_overflow_i  ;
  wire                          axi_wr_underflow_i;
  wire                          axi_wr_overflow_i ;






  generate if (IS_AXI_FULL_WR_CH == 1 || IS_AXI_LITE_WR_CH == 1) begin : axi_write_channel

    FIFO_GENERATOR_V7_2_CONV_VER
      #(
        .C_FAMILY			(C_FAMILY),
//        .C_COMMON_CLOCK                 ((C_COMMON_CLOCK < 3) ? 1 : 0),
        .C_COMMON_CLOCK                 (C_COMMON_CLOCK),
        .C_MEMORY_TYPE			((C_IMPLEMENTATION_TYPE_WACH == 1 || C_IMPLEMENTATION_TYPE_WACH == 11) ? 1 : 2),
        .C_IMPLEMENTATION_TYPE		(C_IMPLEMENTATION_TYPE_WACH < 3 ? 0 : 2),
        .C_PRELOAD_REGS			(1), // always FWFT for AXI
        .C_PRELOAD_LATENCY		(0), // always FWFT for AXI
        .C_DIN_WIDTH			(C_DIN_WIDTH_WACH),
        .C_WR_DEPTH			(C_WR_DEPTH_WACH),
        .C_WR_PNTR_WIDTH		(C_WR_PNTR_WIDTH_WACH),
        .C_DOUT_WIDTH			(C_DIN_WIDTH_WACH),
        .C_RD_DEPTH			(C_WR_DEPTH_WACH),
        .C_RD_PNTR_WIDTH		(C_WR_PNTR_WIDTH_WACH),
        .C_PROG_FULL_TYPE		(C_PROG_FULL_TYPE_WACH),
        .C_PROG_FULL_THRESH_ASSERT_VAL	(C_PROG_FULL_THRESH_ASSERT_VAL_WACH),
//        .C_PROG_FULL_THRESH_NEGATE_VAL	(C_PROG_FULL_THRESH_NEGATE_VAL_WACH),
        .C_PROG_EMPTY_TYPE		(C_PROG_EMPTY_TYPE_WACH),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL	(C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH),
//        .C_PROG_EMPTY_THRESH_NEGATE_VAL	(C_PROG_EMPTY_THRESH_NEGATE_VAL_WACH),
        .C_USE_ECC                      (C_USE_ECC_WACH),
        .C_ERROR_INJECTION_TYPE         (C_ERROR_INJECTION_TYPE_WACH),
        .C_HAS_ALMOST_EMPTY		((C_PROG_EMPTY_TYPE_WACH == 6) ? 1 : 0),
        .C_HAS_ALMOST_FULL		((C_PROG_FULL_TYPE_WACH == 6) ? 1 : 0),

        .C_HAS_WR_RST			(0),
        .C_HAS_RD_RST			(0),
        .C_HAS_RST			(C_HAS_RST),
        .C_HAS_SRST			(0),
        .C_DOUT_RST_VAL			(C_DOUT_RST_VAL),

        .C_HAS_VALID			(0),
        .C_VALID_LOW			(C_VALID_LOW),
        .C_HAS_UNDERFLOW		(C_HAS_UNDERFLOW),
        .C_UNDERFLOW_LOW		(C_UNDERFLOW_LOW),
        .C_HAS_WR_ACK			(0),
        .C_WR_ACK_LOW			(C_WR_ACK_LOW),
        .C_HAS_OVERFLOW			(C_HAS_OVERFLOW),
        .C_OVERFLOW_LOW			(C_OVERFLOW_LOW),

        .C_HAS_DATA_COUNT		((C_COMMON_CLOCK == 1 && C_HAS_DATA_COUNTS_WACH == 1) ? 1 : 0),
        .C_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_WACH + 1),
        .C_HAS_RD_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_WACH == 1) ? 1 : 0),
        .C_RD_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_WACH + 1),
        .C_USE_FWFT_DATA_COUNT		(1), // use extra logic is always true
        .C_HAS_WR_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_WACH == 1) ? 1 : 0),
        .C_WR_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_WACH + 1),
        .C_FULL_FLAGS_RST_VAL           (1),
        .C_USE_EMBEDDED_REG		(0),
        .C_USE_DOUT_RST                 (0),
        .C_MSGON_VAL                    (C_MSGON_VAL),
        .C_ENABLE_RST_SYNC              (1),

        .C_COUNT_TYPE			(C_COUNT_TYPE),
        .C_DEFAULT_VALUE		(C_DEFAULT_VALUE),
        .C_ENABLE_RLOCS			(C_ENABLE_RLOCS),
        .C_HAS_BACKUP			(C_HAS_BACKUP),
        .C_HAS_INT_CLK                  (C_HAS_INT_CLK),
        .C_MIF_FILE_NAME		(C_MIF_FILE_NAME),
        .C_HAS_MEMINIT_FILE		(C_HAS_MEMINIT_FILE),
        .C_INIT_WR_PNTR_VAL		(C_INIT_WR_PNTR_VAL),
        .C_OPTIMIZATION_MODE		(C_OPTIMIZATION_MODE),
        .C_PRIM_FIFO_TYPE		(C_PRIM_FIFO_TYPE),
        .C_RD_FREQ			(C_RD_FREQ),
        .C_USE_FIFO16_FLAGS		(C_USE_FIFO16_FLAGS),
        .C_WR_FREQ			(C_WR_FREQ),
        .C_WR_RESPONSE_LATENCY		(C_WR_RESPONSE_LATENCY)
      )
    fifo_generator_v7_2_wach_dut
      (
        .CLK                      (S_ACLK),
        .WR_CLK                   (S_ACLK),
        .RD_CLK                   (M_ACLK),
        .RST                      (inverted_reset),
        .SRST                     (1'b0),
        .WR_RST                   (inverted_reset),
        .RD_RST                   (inverted_reset),
        .WR_EN                    (S_AXI_AWVALID),
        .RD_EN                    (M_AXI_AWREADY),
        .PROG_FULL_THRESH         (AXI_AW_PROG_FULL_THRESH),
        .PROG_FULL_THRESH_ASSERT  ({C_WR_PNTR_WIDTH_WACH{1'b0}}),
        .PROG_FULL_THRESH_NEGATE  ({C_WR_PNTR_WIDTH_WACH{1'b0}}),
        .PROG_EMPTY_THRESH        (AXI_AW_PROG_EMPTY_THRESH),
        .PROG_EMPTY_THRESH_ASSERT ({C_WR_PNTR_WIDTH_WACH{1'b0}}),
        .PROG_EMPTY_THRESH_NEGATE ({C_WR_PNTR_WIDTH_WACH{1'b0}}),
        .INJECTDBITERR            (AXI_AW_INJECTDBITERR), 
        .INJECTSBITERR            (AXI_AW_INJECTSBITERR),
  
        .DIN                      (wach_din),
        .DOUT                     (wach_dout),
        .FULL                     (wach_full),
        .ALMOST_FULL              (wach_almost_full),
        .PROG_FULL                (wach_prog_full),
        .EMPTY                    (wach_empty),
        .ALMOST_EMPTY             (wach_almost_empty),
        .PROG_EMPTY               (wach_prog_empty),
  
        .WR_ACK                   (),
        .OVERFLOW                 (axi_aw_overflow_i),
        .VALID                    (),
        .UNDERFLOW                (axi_aw_underflow_i),
        .DATA_COUNT               (AXI_AW_DATA_COUNT),
        .RD_DATA_COUNT            (AXI_AW_RD_DATA_COUNT),
        .WR_DATA_COUNT            (AXI_AW_WR_DATA_COUNT),
        .SBITERR                  (AXI_AW_SBITERR),
        .DBITERR                  (AXI_AW_DBITERR),
  
        .BACKUP                   (BACKUP),
        .BACKUP_MARKER            (BACKUP_MARKER),
        .INT_CLK                  (INT_CLK)
       );



    FIFO_GENERATOR_V7_2_CONV_VER
      #(
        .C_FAMILY			(C_FAMILY),
//        .C_COMMON_CLOCK                 ((C_COMMON_CLOCK < 3) ? 1 : 0),
        .C_COMMON_CLOCK                 (C_COMMON_CLOCK),
        .C_MEMORY_TYPE			((C_IMPLEMENTATION_TYPE_WDCH == 1 || C_IMPLEMENTATION_TYPE_WDCH == 11) ? 1 : 2),
        .C_IMPLEMENTATION_TYPE		(C_IMPLEMENTATION_TYPE_WDCH < 3 ? 0 : 2),
        .C_PRELOAD_REGS			(1), // always FWFT for AXI
        .C_PRELOAD_LATENCY		(0), // always FWFT for AXI
        .C_DIN_WIDTH			(C_DIN_WIDTH_WDCH),
        .C_WR_DEPTH			(C_WR_DEPTH_WDCH),
        .C_WR_PNTR_WIDTH		(C_WR_PNTR_WIDTH_WDCH),
        .C_DOUT_WIDTH			(C_DIN_WIDTH_WDCH),
        .C_RD_DEPTH			(C_WR_DEPTH_WDCH),
        .C_RD_PNTR_WIDTH		(C_WR_PNTR_WIDTH_WDCH),
        .C_PROG_FULL_TYPE		(C_PROG_FULL_TYPE_WDCH),
        .C_PROG_FULL_THRESH_ASSERT_VAL	(C_PROG_FULL_THRESH_ASSERT_VAL_WDCH),
//        .C_PROG_FULL_THRESH_NEGATE_VAL	(C_PROG_FULL_THRESH_NEGATE_VAL_WDCH),
        .C_PROG_EMPTY_TYPE		(C_PROG_EMPTY_TYPE_WDCH),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL	(C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH),
//        .C_PROG_EMPTY_THRESH_NEGATE_VAL	(C_PROG_EMPTY_THRESH_NEGATE_VAL_WDCH),
        .C_USE_ECC                      (C_USE_ECC_WDCH),
        .C_ERROR_INJECTION_TYPE         (C_ERROR_INJECTION_TYPE_WDCH),
        .C_HAS_ALMOST_EMPTY		((C_PROG_EMPTY_TYPE_WDCH == 6) ? 1 : 0),
        .C_HAS_ALMOST_FULL		((C_PROG_FULL_TYPE_WDCH == 6) ? 1 : 0),

        .C_HAS_WR_RST			(0),
        .C_HAS_RD_RST			(0),
        .C_HAS_RST			(C_HAS_RST),
        .C_HAS_SRST			(0),
        .C_DOUT_RST_VAL			(C_DOUT_RST_VAL),

        .C_HAS_VALID			(0),
        .C_VALID_LOW			(C_VALID_LOW),
        .C_HAS_UNDERFLOW		(C_HAS_UNDERFLOW),
        .C_UNDERFLOW_LOW		(C_UNDERFLOW_LOW),
        .C_HAS_WR_ACK			(0),
        .C_WR_ACK_LOW			(C_WR_ACK_LOW),
        .C_HAS_OVERFLOW			(C_HAS_OVERFLOW),
        .C_OVERFLOW_LOW			(C_OVERFLOW_LOW),

        .C_HAS_DATA_COUNT		((C_COMMON_CLOCK == 1 && C_HAS_DATA_COUNTS_WDCH == 1) ? 1 : 0),
        .C_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_WDCH + 1),
        .C_HAS_RD_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_WDCH == 1) ? 1 : 0),
        .C_RD_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_WDCH + 1),
        .C_USE_FWFT_DATA_COUNT		(1), // use extra logic is always true
        .C_HAS_WR_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_WDCH == 1) ? 1 : 0),
        .C_WR_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_WDCH + 1),
        .C_FULL_FLAGS_RST_VAL           (1),
        .C_USE_EMBEDDED_REG		(0),
        .C_USE_DOUT_RST                 (0),
        .C_MSGON_VAL                    (C_MSGON_VAL),
        .C_ENABLE_RST_SYNC              (1),

        .C_COUNT_TYPE			(C_COUNT_TYPE),
        .C_DEFAULT_VALUE		(C_DEFAULT_VALUE),
        .C_ENABLE_RLOCS			(C_ENABLE_RLOCS),
        .C_HAS_BACKUP			(C_HAS_BACKUP),
        .C_HAS_INT_CLK                  (C_HAS_INT_CLK),
        .C_MIF_FILE_NAME		(C_MIF_FILE_NAME),
        .C_HAS_MEMINIT_FILE		(C_HAS_MEMINIT_FILE),
        .C_INIT_WR_PNTR_VAL		(C_INIT_WR_PNTR_VAL),
        .C_OPTIMIZATION_MODE		(C_OPTIMIZATION_MODE),
        .C_PRIM_FIFO_TYPE		(C_PRIM_FIFO_TYPE),
        .C_RD_FREQ			(C_RD_FREQ),
        .C_USE_FIFO16_FLAGS		(C_USE_FIFO16_FLAGS),
        .C_WR_FREQ			(C_WR_FREQ),
        .C_WR_RESPONSE_LATENCY		(C_WR_RESPONSE_LATENCY)
      )
    fifo_generator_v7_2_wdch_dut
      (
        .CLK                      (S_ACLK),
        .WR_CLK                   (S_ACLK),
        .RD_CLK                   (M_ACLK),
        .RST                      (inverted_reset),
        .SRST                     (1'b0),
        .WR_RST                   (inverted_reset),
        .RD_RST                   (inverted_reset),
        .WR_EN                    (S_AXI_WVALID),
        .RD_EN                    (M_AXI_WREADY),
        .PROG_FULL_THRESH         (AXI_W_PROG_FULL_THRESH),
        .PROG_FULL_THRESH_ASSERT  ({C_WR_PNTR_WIDTH_WDCH{1'b0}}),
        .PROG_FULL_THRESH_NEGATE  ({C_WR_PNTR_WIDTH_WDCH{1'b0}}),
        .PROG_EMPTY_THRESH        (AXI_W_PROG_EMPTY_THRESH),
        .PROG_EMPTY_THRESH_ASSERT ({C_WR_PNTR_WIDTH_WDCH{1'b0}}),
        .PROG_EMPTY_THRESH_NEGATE ({C_WR_PNTR_WIDTH_WDCH{1'b0}}),
        .INJECTDBITERR            (AXI_W_INJECTDBITERR), 
        .INJECTSBITERR            (AXI_W_INJECTSBITERR),
  
        .DIN                      (wdch_din),
        .DOUT                     (wdch_dout),
        .FULL                     (wdch_full),
        .ALMOST_FULL              (wdch_almost_full),
        .PROG_FULL                (wdch_prog_full),
        .EMPTY                    (wdch_empty),
        .ALMOST_EMPTY             (wdch_almost_empty),
        .PROG_EMPTY               (wdch_prog_empty),
  
        .WR_ACK                   (),
        .OVERFLOW                 (axi_w_overflow_i),
        .VALID                    (),
        .UNDERFLOW                (axi_w_underflow_i),
        .DATA_COUNT               (AXI_W_DATA_COUNT),
        .RD_DATA_COUNT            (AXI_W_RD_DATA_COUNT),
        .WR_DATA_COUNT            (AXI_W_WR_DATA_COUNT),
        .SBITERR                  (AXI_W_SBITERR),
        .DBITERR                  (AXI_W_DBITERR),
  
        .BACKUP                   (BACKUP),
        .BACKUP_MARKER            (BACKUP_MARKER),
        .INT_CLK                  (INT_CLK)
       );



    FIFO_GENERATOR_V7_2_CONV_VER
      #(
        .C_FAMILY			(C_FAMILY),
//        .C_COMMON_CLOCK                 ((C_COMMON_CLOCK < 3) ? 1 : 0),
        .C_COMMON_CLOCK                 (C_COMMON_CLOCK),
        .C_MEMORY_TYPE			((C_IMPLEMENTATION_TYPE_WRCH == 1 || C_IMPLEMENTATION_TYPE_WRCH == 11) ? 1 : 2),
        .C_IMPLEMENTATION_TYPE		(C_IMPLEMENTATION_TYPE_WRCH < 3 ? 0 : 2),
        .C_PRELOAD_REGS			(1), // always FWFT for AXI
        .C_PRELOAD_LATENCY		(0), // always FWFT for AXI
        .C_DIN_WIDTH			(C_DIN_WIDTH_WRCH),
        .C_WR_DEPTH			(C_WR_DEPTH_WRCH),
        .C_WR_PNTR_WIDTH		(C_WR_PNTR_WIDTH_WRCH),
        .C_DOUT_WIDTH			(C_DIN_WIDTH_WRCH),
        .C_RD_DEPTH			(C_WR_DEPTH_WRCH),
        .C_RD_PNTR_WIDTH		(C_WR_PNTR_WIDTH_WRCH),
        .C_PROG_FULL_TYPE		(C_PROG_FULL_TYPE_WRCH),
        .C_PROG_FULL_THRESH_ASSERT_VAL	(C_PROG_FULL_THRESH_ASSERT_VAL_WRCH),
//        .C_PROG_FULL_THRESH_NEGATE_VAL	(C_PROG_FULL_THRESH_NEGATE_VAL_WRCH),
        .C_PROG_EMPTY_TYPE		(C_PROG_EMPTY_TYPE_WRCH),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL	(C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH),
//        .C_PROG_EMPTY_THRESH_NEGATE_VAL	(C_PROG_EMPTY_THRESH_NEGATE_VAL_WRCH),
        .C_USE_ECC                      (C_USE_ECC_WRCH),
        .C_ERROR_INJECTION_TYPE         (C_ERROR_INJECTION_TYPE_WRCH),
        .C_HAS_ALMOST_EMPTY		((C_PROG_EMPTY_TYPE_WRCH == 6) ? 1 : 0),
        .C_HAS_ALMOST_FULL		((C_PROG_FULL_TYPE_WRCH == 6) ? 1 : 0),

        .C_HAS_WR_RST			(0),
        .C_HAS_RD_RST			(0),
        .C_HAS_RST			(C_HAS_RST),
        .C_HAS_SRST			(0),
        .C_DOUT_RST_VAL			(C_DOUT_RST_VAL),

        .C_HAS_VALID			(0),
        .C_VALID_LOW			(C_VALID_LOW),
        .C_HAS_UNDERFLOW		(C_HAS_UNDERFLOW),
        .C_UNDERFLOW_LOW		(C_UNDERFLOW_LOW),
        .C_HAS_WR_ACK			(0),
        .C_WR_ACK_LOW			(C_WR_ACK_LOW),
        .C_HAS_OVERFLOW			(C_HAS_OVERFLOW),
        .C_OVERFLOW_LOW			(C_OVERFLOW_LOW),

        .C_HAS_DATA_COUNT		((C_COMMON_CLOCK == 1 && C_HAS_DATA_COUNTS_WRCH == 1) ? 1 : 0),
        .C_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_WRCH + 1),
        .C_HAS_RD_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_WRCH == 1) ? 1 : 0),
        .C_RD_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_WRCH + 1),
        .C_USE_FWFT_DATA_COUNT		(1), // use extra logic is always true
        .C_HAS_WR_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_WRCH == 1) ? 1 : 0),
        .C_WR_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_WRCH + 1),
        .C_FULL_FLAGS_RST_VAL           (1),
        .C_USE_EMBEDDED_REG		(0),
        .C_USE_DOUT_RST                 (0),
        .C_MSGON_VAL                    (C_MSGON_VAL),
        .C_ENABLE_RST_SYNC              (1),

        .C_COUNT_TYPE			(C_COUNT_TYPE),
        .C_DEFAULT_VALUE		(C_DEFAULT_VALUE),
        .C_ENABLE_RLOCS			(C_ENABLE_RLOCS),
        .C_HAS_BACKUP			(C_HAS_BACKUP),
        .C_HAS_INT_CLK                  (C_HAS_INT_CLK),
        .C_MIF_FILE_NAME		(C_MIF_FILE_NAME),
        .C_HAS_MEMINIT_FILE		(C_HAS_MEMINIT_FILE),
        .C_INIT_WR_PNTR_VAL		(C_INIT_WR_PNTR_VAL),
        .C_OPTIMIZATION_MODE		(C_OPTIMIZATION_MODE),
        .C_PRIM_FIFO_TYPE		(C_PRIM_FIFO_TYPE),
        .C_RD_FREQ			(C_RD_FREQ),
        .C_USE_FIFO16_FLAGS		(C_USE_FIFO16_FLAGS),
        .C_WR_FREQ			(C_WR_FREQ),
        .C_WR_RESPONSE_LATENCY		(C_WR_RESPONSE_LATENCY)
      )
    fifo_generator_v7_2_wrch_dut
      (
        .CLK                      (S_ACLK),
        .WR_CLK                   (S_ACLK),
        .RD_CLK                   (M_ACLK),
        .RST                      (inverted_reset),
        .SRST                     (1'b0),
        .WR_RST                   (inverted_reset),
        .RD_RST                   (inverted_reset),
        .WR_EN                    (M_AXI_BVALID),
        .RD_EN                    (S_AXI_BREADY),
        .PROG_FULL_THRESH         (AXI_B_PROG_FULL_THRESH),
        .PROG_FULL_THRESH_ASSERT  ({C_WR_PNTR_WIDTH_WRCH{1'b0}}),
        .PROG_FULL_THRESH_NEGATE  ({C_WR_PNTR_WIDTH_WRCH{1'b0}}),
        .PROG_EMPTY_THRESH        (AXI_B_PROG_EMPTY_THRESH),
        .PROG_EMPTY_THRESH_ASSERT ({C_WR_PNTR_WIDTH_WRCH{1'b0}}),
        .PROG_EMPTY_THRESH_NEGATE ({C_WR_PNTR_WIDTH_WRCH{1'b0}}),
        .INJECTDBITERR            (AXI_B_INJECTDBITERR), 
        .INJECTSBITERR            (AXI_B_INJECTSBITERR),
  
        .DIN                      (wrch_din),
        .DOUT                     (wrch_dout),
        .FULL                     (wrch_full),
        .ALMOST_FULL              (wrch_almost_full),
        .PROG_FULL                (wrch_prog_full),
        .EMPTY                    (wrch_empty),
        .ALMOST_EMPTY             (wrch_almost_empty),
        .PROG_EMPTY               (wrch_prog_empty),
  
        .WR_ACK                   (),
        .OVERFLOW                 (axi_b_overflow_i),
        .VALID                    (),
        .UNDERFLOW                (axi_b_underflow_i),
        .DATA_COUNT               (AXI_B_DATA_COUNT),
        .RD_DATA_COUNT            (AXI_B_RD_DATA_COUNT),
        .WR_DATA_COUNT            (AXI_B_WR_DATA_COUNT),
        .SBITERR                  (AXI_B_SBITERR),
        .DBITERR                  (AXI_B_DBITERR),
  
        .BACKUP                   (BACKUP),
        .BACKUP_MARKER            (BACKUP_MARKER),
        .INT_CLK                  (INT_CLK)
       );


    assign S_AXI_AWREADY = C_PROG_FULL_TYPE_WACH  == 5 ? ~wach_full  : C_PROG_FULL_TYPE_WACH  == 6 ? ~wach_almost_full  : ~wach_prog_full;
    assign S_AXI_WREADY  = C_PROG_FULL_TYPE_WDCH  == 5 ? ~wdch_full  : C_PROG_FULL_TYPE_WDCH  == 6 ? ~wdch_almost_full  : ~wdch_prog_full;
    assign M_AXI_BREADY  = C_PROG_FULL_TYPE_WRCH  == 5 ? ~wrch_full  : C_PROG_FULL_TYPE_WRCH  == 6 ? ~wrch_almost_full  : ~wrch_prog_full;
    assign M_AXI_AWVALID = C_PROG_EMPTY_TYPE_WACH == 5 ? ~wach_empty : C_PROG_EMPTY_TYPE_WACH == 6 ? ~wach_almost_empty : ~wach_prog_empty;
    assign M_AXI_WVALID  = C_PROG_EMPTY_TYPE_WDCH == 5 ? ~wdch_empty : C_PROG_EMPTY_TYPE_WDCH == 6 ? ~wdch_almost_empty : ~wdch_prog_empty;
    assign S_AXI_BVALID  = C_PROG_EMPTY_TYPE_WRCH == 5 ? ~wrch_empty : C_PROG_EMPTY_TYPE_WRCH == 6 ? ~wrch_almost_empty : ~wrch_prog_empty;

    assign AXI_AW_UNDERFLOW  = C_USE_COMMON_UNDERFLOW == 0 ? axi_aw_underflow_i : 0;
    assign AXI_W_UNDERFLOW   = C_USE_COMMON_UNDERFLOW == 0 ? axi_w_underflow_i  : 0;
    assign AXI_B_UNDERFLOW   = C_USE_COMMON_UNDERFLOW == 0 ? axi_b_underflow_i  : 0;
    assign AXI_AW_OVERFLOW   = C_USE_COMMON_OVERFLOW  == 0 ? axi_aw_overflow_i  : 0;
    assign AXI_W_OVERFLOW    = C_USE_COMMON_OVERFLOW  == 0 ? axi_w_overflow_i   : 0;
    assign AXI_B_OVERFLOW    = C_USE_COMMON_OVERFLOW  == 0 ? axi_b_overflow_i   : 0;

    assign axi_wr_underflow_i = C_USE_COMMON_UNDERFLOW  == 1 ? (axi_aw_underflow_i || axi_w_underflow_i || axi_b_underflow_i) : 0;
    assign axi_wr_overflow_i  = C_USE_COMMON_OVERFLOW   == 1 ? (axi_aw_overflow_i  || axi_w_overflow_i  || axi_b_overflow_i)  : 0;

  end endgenerate // axi_write_channel


  generate if (IS_AXI_FULL_WR_CH == 1) begin : axi_full_wr_ch_output
    assign M_AXI_AWID      = wach_dout[C_DIN_WIDTH_WACH-1:AWID_OFFSET];    
    assign M_AXI_AWADDR    = wach_dout[AWID_OFFSET-1:AWADDR_OFFSET];    
    assign M_AXI_AWLEN     = wach_dout[AWADDR_OFFSET-1:AWLEN_OFFSET];    
    assign M_AXI_AWSIZE    = wach_dout[AWLEN_OFFSET-1:AWSIZE_OFFSET];    
    assign M_AXI_AWBURST   = wach_dout[AWSIZE_OFFSET-1:AWBURST_OFFSET];    
    assign M_AXI_AWLOCK    = wach_dout[AWBURST_OFFSET-1:AWLOCK_OFFSET];    
    assign M_AXI_AWCACHE   = wach_dout[AWLOCK_OFFSET-1:AWCACHE_OFFSET];    
    assign M_AXI_AWPROT    = wach_dout[AWCACHE_OFFSET-1:AWPROT_OFFSET];    
    assign M_AXI_AWQOS     = wach_dout[AWPROT_OFFSET-1:AWQOS_OFFSET];    
    assign M_AXI_AWREGION  = wach_dout[AWQOS_OFFSET-1:AWREGION_OFFSET];    
    assign M_AXI_WID       = wdch_dout[C_DIN_WIDTH_WDCH-1:WID_OFFSET];
    assign M_AXI_WDATA     = wdch_dout[WID_OFFSET-1:WDATA_OFFSET];
    assign M_AXI_WSTRB     = wdch_dout[WDATA_OFFSET-1:WSTRB_OFFSET];
    assign M_AXI_WLAST     = wdch_dout[0];
    assign S_AXI_BID       = wrch_dout[C_DIN_WIDTH_WRCH-1:BID_OFFSET]; 
    assign S_AXI_BRESP     = wrch_dout[BID_OFFSET-1:BRESP_OFFSET]; 
  end endgenerate // axi_full_wr_ch_output

  generate if (IS_AXI_LITE_WR_CH == 1) begin : axi_lite_wr_ch_output
    assign wach_din        = {S_AXI_AWADDR, S_AXI_AWPROT};
    assign wdch_din        = {S_AXI_WDATA, S_AXI_WSTRB};
    assign wrch_din        = M_AXI_BRESP;
    assign M_AXI_AWADDR    = wach_dout[C_DIN_WIDTH_WACH-1:AWADDR_OFFSET];    
    assign M_AXI_AWPROT    = wach_dout[AWADDR_OFFSET-1:AWPROT_OFFSET];    
    assign M_AXI_WDATA     = wdch_dout[C_DIN_WIDTH_WDCH-1:WDATA_OFFSET];
    assign M_AXI_WSTRB     = wdch_dout[WDATA_OFFSET-1:WSTRB_OFFSET];
    assign S_AXI_BRESP     = wrch_dout[C_DIN_WIDTH_WRCH-1:BRESP_OFFSET]; 
  end endgenerate // axi_lite_wr_ch_output

  generate if (IS_AXI_FULL_WR_CH == 1 && C_HAS_AXI_AWUSER == 1) begin : gwach_din1
    assign wach_din     = {S_AXI_AWID, S_AXI_AWADDR, S_AXI_AWLEN, S_AXI_AWSIZE, S_AXI_AWBURST,
                           S_AXI_AWLOCK, S_AXI_AWCACHE, S_AXI_AWPROT, S_AXI_AWQOS, S_AXI_AWREGION,
                           S_AXI_AWUSER};
    assign M_AXI_AWUSER = wach_dout[AWREGION_OFFSET-1:AWUSER_OFFSET];
  end endgenerate // gwach_din1

  generate if (IS_AXI_FULL_WR_CH == 1 && C_HAS_AXI_AWUSER == 0) begin : gwach_din2
    assign wach_din     = {S_AXI_AWID, S_AXI_AWADDR, S_AXI_AWLEN, S_AXI_AWSIZE, S_AXI_AWBURST,
                           S_AXI_AWLOCK, S_AXI_AWCACHE, S_AXI_AWPROT, S_AXI_AWQOS, S_AXI_AWREGION};
    assign M_AXI_AWUSER = 0;
  end endgenerate // gwach_din2

  generate if (IS_AXI_FULL_WR_CH == 1 && C_HAS_AXI_WUSER == 1) begin : gwdch_din1
    assign wdch_din     = {S_AXI_WID, S_AXI_WDATA, S_AXI_WSTRB, S_AXI_WUSER, S_AXI_WLAST};
    assign M_AXI_WUSER  = wdch_dout[WSTRB_OFFSET-1:WUSER_OFFSET];
  end endgenerate // gwdch_din1

  generate if (IS_AXI_FULL_WR_CH == 1 && C_HAS_AXI_WUSER == 0) begin : gwdch_din2
    assign wdch_din     = {S_AXI_WID, S_AXI_WDATA, S_AXI_WSTRB, S_AXI_WLAST};
    assign M_AXI_WUSER  = 0;
  end endgenerate // gwdch_din2

  generate if (IS_AXI_FULL_WR_CH == 1 && C_HAS_AXI_BUSER == 1) begin : gwrch_din1
    assign wrch_din    = {M_AXI_BID, M_AXI_BRESP, M_AXI_BUSER};
    assign S_AXI_BUSER = wrch_dout[BRESP_OFFSET-1:BUSER_OFFSET]; 
  end endgenerate // gwrch_din1

  generate if (IS_AXI_FULL_WR_CH == 1 && C_HAS_AXI_BUSER == 0) begin : gwrch_din2
    assign wrch_din    = {M_AXI_BID, M_AXI_BRESP};
    assign S_AXI_BUSER = 0;
  end endgenerate // gwrch_din2

  //end of  axi_write_channel

  //###########################################################################
  //  AXI FULL Read Channel (axi_read_channel)
  //###########################################################################
  wire [C_DIN_WIDTH_RACH-1:0]        rach_din            ;
  wire [C_DIN_WIDTH_RACH-1:0]        rach_dout           ;
  wire                               rach_full           ;
  wire                               rach_almost_full    ;
  wire                               rach_prog_full      ;
  wire                               rach_empty          ;
  wire                               rach_almost_empty   ;
  wire                               rach_prog_empty     ;
  wire [C_DIN_WIDTH_RDCH-1:0]        rdch_din            ;
  wire [C_DIN_WIDTH_RDCH-1:0]        rdch_dout           ;
  wire                               rdch_full           ;
  wire                               rdch_almost_full    ;
  wire                               rdch_prog_full      ;
  wire                               rdch_empty          ;
  wire                               rdch_almost_empty   ;
  wire                               rdch_prog_empty     ;
  wire                               axi_ar_underflow_i  ;
  wire                               axi_r_underflow_i   ;
  wire                               axi_ar_overflow_i   ;
  wire                               axi_r_overflow_i    ;
  wire                               axi_rd_underflow_i  ;
  wire                               axi_rd_overflow_i   ;

  localparam ARID_OFFSET       = C_AXI_TYPE == 1 ? C_DIN_WIDTH_RACH - C_AXI_ID_WIDTH : C_DIN_WIDTH_RACH;
  localparam ARADDR_OFFSET     = ARID_OFFSET - C_AXI_ADDR_WIDTH;
  localparam ARLEN_OFFSET      = C_AXI_TYPE == 1 ? ARADDR_OFFSET - C_AXI_LEN_WIDTH : ARADDR_OFFSET;
  localparam ARSIZE_OFFSET     = C_AXI_TYPE == 1 ? ARLEN_OFFSET - C_AXI_SIZE_WIDTH : ARLEN_OFFSET;
  localparam ARBURST_OFFSET    = C_AXI_TYPE == 1 ? ARSIZE_OFFSET - C_AXI_BURST_WIDTH : ARSIZE_OFFSET;
  localparam ARLOCK_OFFSET     = C_AXI_TYPE == 1 ? ARBURST_OFFSET - C_AXI_LOCK_WIDTH : ARBURST_OFFSET;
  localparam ARCACHE_OFFSET    = C_AXI_TYPE == 1 ? ARLOCK_OFFSET - C_AXI_CACHE_WIDTH : ARLOCK_OFFSET;
  localparam ARPROT_OFFSET     = ARCACHE_OFFSET - C_AXI_PROT_WIDTH;
  localparam ARQOS_OFFSET      = ARPROT_OFFSET - C_AXI_QOS_WIDTH;
  localparam ARREGION_OFFSET   = ARQOS_OFFSET - C_AXI_REGION_WIDTH;
  localparam ARUSER_OFFSET     = C_HAS_AXI_ARUSER == 1 ? ARREGION_OFFSET-C_AXI_ARUSER_WIDTH : ARREGION_OFFSET;

  localparam RID_OFFSET        = C_AXI_TYPE == 1 ? C_DIN_WIDTH_RDCH - C_AXI_ID_WIDTH : C_DIN_WIDTH_RDCH;
  localparam RDATA_OFFSET      = RID_OFFSET - C_AXI_DATA_WIDTH;
  localparam RRESP_OFFSET      = RDATA_OFFSET - C_AXI_RRESP_WIDTH;
  localparam RUSER_OFFSET      = C_HAS_AXI_RUSER == 1 ? RRESP_OFFSET-C_AXI_RUSER_WIDTH : RRESP_OFFSET;



  generate if (IS_AXI_FULL_RD_CH == 1 || IS_AXI_LITE_RD_CH == 1) begin : axi_read_channel

    FIFO_GENERATOR_V7_2_CONV_VER
      #(
        .C_FAMILY			(C_FAMILY),
//        .C_COMMON_CLOCK                 ((C_COMMON_CLOCK < 3) ? 1 : 0),
        .C_COMMON_CLOCK                 (C_COMMON_CLOCK),
        .C_MEMORY_TYPE			((C_IMPLEMENTATION_TYPE_RACH == 1 || C_IMPLEMENTATION_TYPE_RACH == 11) ? 1 : 2),
        .C_IMPLEMENTATION_TYPE		(C_IMPLEMENTATION_TYPE_RACH < 3 ? 0 : 2),
        .C_PRELOAD_REGS			(1), // always FWFT for AXI
        .C_PRELOAD_LATENCY		(0), // always FWFT for AXI
        .C_DIN_WIDTH			(C_DIN_WIDTH_RACH),
        .C_WR_DEPTH			(C_WR_DEPTH_RACH),
        .C_WR_PNTR_WIDTH		(C_WR_PNTR_WIDTH_RACH),
        .C_DOUT_WIDTH			(C_DIN_WIDTH_RACH),
        .C_RD_DEPTH			(C_WR_DEPTH_RACH),
        .C_RD_PNTR_WIDTH		(C_WR_PNTR_WIDTH_RACH),
        .C_PROG_FULL_TYPE		(C_PROG_FULL_TYPE_RACH),
        .C_PROG_FULL_THRESH_ASSERT_VAL	(C_PROG_FULL_THRESH_ASSERT_VAL_RACH),
//        .C_PROG_FULL_THRESH_NEGATE_VAL	(C_PROG_FULL_THRESH_NEGATE_VAL_RACH),
        .C_PROG_EMPTY_TYPE		(C_PROG_EMPTY_TYPE_RACH),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL	(C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH),
//        .C_PROG_EMPTY_THRESH_NEGATE_VAL	(C_PROG_EMPTY_THRESH_NEGATE_VAL_RACH),
        .C_USE_ECC                      (C_USE_ECC_RACH),
        .C_ERROR_INJECTION_TYPE         (C_ERROR_INJECTION_TYPE_RACH),
        .C_HAS_ALMOST_EMPTY		((C_PROG_EMPTY_TYPE_RACH == 6) ? 1 : 0),
        .C_HAS_ALMOST_FULL		((C_PROG_FULL_TYPE_RACH == 6) ? 1 : 0),

        .C_HAS_WR_RST			(0),
        .C_HAS_RD_RST			(0),
        .C_HAS_RST			(C_HAS_RST),
        .C_HAS_SRST			(0),
        .C_DOUT_RST_VAL			(C_DOUT_RST_VAL),

        .C_HAS_VALID			(0),
        .C_VALID_LOW			(C_VALID_LOW),
        .C_HAS_UNDERFLOW		(C_HAS_UNDERFLOW),
        .C_UNDERFLOW_LOW		(C_UNDERFLOW_LOW),
        .C_HAS_WR_ACK			(0),
        .C_WR_ACK_LOW			(C_WR_ACK_LOW),
        .C_HAS_OVERFLOW			(C_HAS_OVERFLOW),
        .C_OVERFLOW_LOW			(C_OVERFLOW_LOW),

        .C_HAS_DATA_COUNT		((C_COMMON_CLOCK == 1 && C_HAS_DATA_COUNTS_RACH == 1) ? 1 : 0),
        .C_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_RACH + 1),
        .C_HAS_RD_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_RACH == 1) ? 1 : 0),
        .C_RD_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_RACH + 1),
        .C_USE_FWFT_DATA_COUNT		(1), // use extra logic is always true
        .C_HAS_WR_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_RACH == 1) ? 1 : 0),
        .C_WR_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_RACH + 1),
        .C_FULL_FLAGS_RST_VAL           (1),
        .C_USE_EMBEDDED_REG		(0),
        .C_USE_DOUT_RST                 (0),
        .C_MSGON_VAL                    (C_MSGON_VAL),
        .C_ENABLE_RST_SYNC              (1),

        .C_COUNT_TYPE			(C_COUNT_TYPE),
        .C_DEFAULT_VALUE		(C_DEFAULT_VALUE),
        .C_ENABLE_RLOCS			(C_ENABLE_RLOCS),
        .C_HAS_BACKUP			(C_HAS_BACKUP),
        .C_HAS_INT_CLK                  (C_HAS_INT_CLK),
        .C_MIF_FILE_NAME		(C_MIF_FILE_NAME),
        .C_HAS_MEMINIT_FILE		(C_HAS_MEMINIT_FILE),
        .C_INIT_WR_PNTR_VAL		(C_INIT_WR_PNTR_VAL),
        .C_OPTIMIZATION_MODE		(C_OPTIMIZATION_MODE),
        .C_PRIM_FIFO_TYPE		(C_PRIM_FIFO_TYPE),
        .C_RD_FREQ			(C_RD_FREQ),
        .C_USE_FIFO16_FLAGS		(C_USE_FIFO16_FLAGS),
        .C_WR_FREQ			(C_WR_FREQ),
        .C_WR_RESPONSE_LATENCY		(C_WR_RESPONSE_LATENCY)
      )
    fifo_generator_v7_2_rach_dut
      (
        .CLK                      (S_ACLK),
        .WR_CLK                   (S_ACLK),
        .RD_CLK                   (M_ACLK),
        .RST                      (inverted_reset),
        .SRST                     (1'b0),
        .WR_RST                   (inverted_reset),
        .RD_RST                   (inverted_reset),
        .WR_EN                    (S_AXI_ARVALID),
        .RD_EN                    (M_AXI_ARREADY),
        .PROG_FULL_THRESH         (AXI_AR_PROG_FULL_THRESH),
        .PROG_FULL_THRESH_ASSERT  ({C_WR_PNTR_WIDTH_RACH{1'b0}}),
        .PROG_FULL_THRESH_NEGATE  ({C_WR_PNTR_WIDTH_RACH{1'b0}}),
        .PROG_EMPTY_THRESH        (AXI_AR_PROG_EMPTY_THRESH),
        .PROG_EMPTY_THRESH_ASSERT ({C_WR_PNTR_WIDTH_RACH{1'b0}}),
        .PROG_EMPTY_THRESH_NEGATE ({C_WR_PNTR_WIDTH_RACH{1'b0}}),
        .INJECTDBITERR            (AXI_AR_INJECTDBITERR), 
        .INJECTSBITERR            (AXI_AR_INJECTSBITERR),
  
        .DIN                      (rach_din),
        .DOUT                     (rach_dout),
        .FULL                     (rach_full),
        .ALMOST_FULL              (rach_almost_full),
        .PROG_FULL                (rach_prog_full),
        .EMPTY                    (rach_empty),
        .ALMOST_EMPTY             (rach_almost_empty),
        .PROG_EMPTY               (rach_prog_empty),
  
        .WR_ACK                   (),
        .OVERFLOW                 (axi_ar_overflow_i),
        .VALID                    (),
        .UNDERFLOW                (axi_ar_underflow_i),
        .DATA_COUNT               (AXI_AR_DATA_COUNT),
        .RD_DATA_COUNT            (AXI_AR_RD_DATA_COUNT),
        .WR_DATA_COUNT            (AXI_AR_WR_DATA_COUNT),
        .SBITERR                  (AXI_AR_SBITERR),
        .DBITERR                  (AXI_AR_DBITERR),
  
        .BACKUP                   (BACKUP),
        .BACKUP_MARKER            (BACKUP_MARKER),
        .INT_CLK                  (INT_CLK)
       );



    FIFO_GENERATOR_V7_2_CONV_VER
      #(
        .C_FAMILY			(C_FAMILY),
//        .C_COMMON_CLOCK                 ((C_COMMON_CLOCK < 3) ? 1 : 0),
        .C_COMMON_CLOCK                 (C_COMMON_CLOCK),
        .C_MEMORY_TYPE			((C_IMPLEMENTATION_TYPE_RDCH == 1 || C_IMPLEMENTATION_TYPE_RDCH == 11) ? 1 : 2),
        .C_IMPLEMENTATION_TYPE		(C_IMPLEMENTATION_TYPE_RDCH < 3 ? 0 : 2),
        .C_PRELOAD_REGS			(1), // always FWFT for AXI
        .C_PRELOAD_LATENCY		(0), // always FWFT for AXI
        .C_DIN_WIDTH			(C_DIN_WIDTH_RDCH),
        .C_WR_DEPTH			(C_WR_DEPTH_RDCH),
        .C_WR_PNTR_WIDTH		(C_WR_PNTR_WIDTH_RDCH),
        .C_DOUT_WIDTH			(C_DIN_WIDTH_RDCH),
        .C_RD_DEPTH			(C_WR_DEPTH_RDCH),
        .C_RD_PNTR_WIDTH		(C_WR_PNTR_WIDTH_RDCH),
        .C_PROG_FULL_TYPE		(C_PROG_FULL_TYPE_RDCH),
        .C_PROG_FULL_THRESH_ASSERT_VAL	(C_PROG_FULL_THRESH_ASSERT_VAL_RDCH),
//        .C_PROG_FULL_THRESH_NEGATE_VAL	(C_PROG_FULL_THRESH_NEGATE_VAL_RDCH),
        .C_PROG_EMPTY_TYPE		(C_PROG_EMPTY_TYPE_RDCH),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL	(C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH),
//        .C_PROG_EMPTY_THRESH_NEGATE_VAL	(C_PROG_EMPTY_THRESH_NEGATE_VAL_RDCH),
        .C_USE_ECC                      (C_USE_ECC_RDCH),
        .C_ERROR_INJECTION_TYPE         (C_ERROR_INJECTION_TYPE_RDCH),
        .C_HAS_ALMOST_EMPTY		((C_PROG_EMPTY_TYPE_RDCH == 6) ? 1 : 0),
        .C_HAS_ALMOST_FULL		((C_PROG_FULL_TYPE_RDCH == 6) ? 1 : 0),

        .C_HAS_WR_RST			(0),
        .C_HAS_RD_RST			(0),
        .C_HAS_RST			(C_HAS_RST),
        .C_HAS_SRST			(0),
        .C_DOUT_RST_VAL			(C_DOUT_RST_VAL),

        .C_HAS_VALID			(0),
        .C_VALID_LOW			(C_VALID_LOW),
        .C_HAS_UNDERFLOW		(C_HAS_UNDERFLOW),
        .C_UNDERFLOW_LOW		(C_UNDERFLOW_LOW),
        .C_HAS_WR_ACK			(0),
        .C_WR_ACK_LOW			(C_WR_ACK_LOW),
        .C_HAS_OVERFLOW			(C_HAS_OVERFLOW),
        .C_OVERFLOW_LOW			(C_OVERFLOW_LOW),

        .C_HAS_DATA_COUNT		((C_COMMON_CLOCK == 1 && C_HAS_DATA_COUNTS_RDCH == 1) ? 1 : 0),
        .C_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_RDCH + 1),
        .C_HAS_RD_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_RDCH == 1) ? 1 : 0),
        .C_RD_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_RDCH + 1),
        .C_USE_FWFT_DATA_COUNT		(1), // use extra logic is always true
        .C_HAS_WR_DATA_COUNT		((C_COMMON_CLOCK == 0 && C_HAS_DATA_COUNTS_RDCH == 1) ? 1 : 0),
        .C_WR_DATA_COUNT_WIDTH		(C_WR_PNTR_WIDTH_RDCH + 1),
        .C_FULL_FLAGS_RST_VAL           (1),
        .C_USE_EMBEDDED_REG		(0),
        .C_USE_DOUT_RST                 (0),
        .C_MSGON_VAL                    (C_MSGON_VAL),
        .C_ENABLE_RST_SYNC              (1),

        .C_COUNT_TYPE			(C_COUNT_TYPE),
        .C_DEFAULT_VALUE		(C_DEFAULT_VALUE),
        .C_ENABLE_RLOCS			(C_ENABLE_RLOCS),
        .C_HAS_BACKUP			(C_HAS_BACKUP),
        .C_HAS_INT_CLK                  (C_HAS_INT_CLK),
        .C_MIF_FILE_NAME		(C_MIF_FILE_NAME),
        .C_HAS_MEMINIT_FILE		(C_HAS_MEMINIT_FILE),
        .C_INIT_WR_PNTR_VAL		(C_INIT_WR_PNTR_VAL),
        .C_OPTIMIZATION_MODE		(C_OPTIMIZATION_MODE),
        .C_PRIM_FIFO_TYPE		(C_PRIM_FIFO_TYPE),
        .C_RD_FREQ			(C_RD_FREQ),
        .C_USE_FIFO16_FLAGS		(C_USE_FIFO16_FLAGS),
        .C_WR_FREQ			(C_WR_FREQ),
        .C_WR_RESPONSE_LATENCY		(C_WR_RESPONSE_LATENCY)
      )
    fifo_generator_v7_2_rdch_dut
      (
        .CLK                      (S_ACLK),
        .WR_CLK                   (S_ACLK),
        .RD_CLK                   (M_ACLK),
        .RST                      (inverted_reset),
        .SRST                     (1'b0),
        .WR_RST                   (inverted_reset),
        .RD_RST                   (inverted_reset),
        .WR_EN                    (M_AXI_RVALID),
        .RD_EN                    (S_AXI_RREADY),
        .PROG_FULL_THRESH         (AXI_R_PROG_FULL_THRESH),
        .PROG_FULL_THRESH_ASSERT  ({C_WR_PNTR_WIDTH_RDCH{1'b0}}),
        .PROG_FULL_THRESH_NEGATE  ({C_WR_PNTR_WIDTH_RDCH{1'b0}}),
        .PROG_EMPTY_THRESH        (AXI_R_PROG_EMPTY_THRESH),
        .PROG_EMPTY_THRESH_ASSERT ({C_WR_PNTR_WIDTH_RDCH{1'b0}}),
        .PROG_EMPTY_THRESH_NEGATE ({C_WR_PNTR_WIDTH_RDCH{1'b0}}),
        .INJECTDBITERR            (AXI_R_INJECTDBITERR), 
        .INJECTSBITERR            (AXI_R_INJECTSBITERR),
  
        .DIN                      (rdch_din),
        .DOUT                     (rdch_dout),
        .FULL                     (rdch_full),
        .ALMOST_FULL              (rdch_almost_full),
        .PROG_FULL                (rdch_prog_full),
        .EMPTY                    (rdch_empty),
        .ALMOST_EMPTY             (rdch_almost_empty),
        .PROG_EMPTY               (rdch_prog_empty),
  
        .WR_ACK                   (),
        .OVERFLOW                 (axi_r_overflow_i),
        .VALID                    (),
        .UNDERFLOW                (axi_r_underflow_i),
        .DATA_COUNT               (AXI_R_DATA_COUNT),
        .RD_DATA_COUNT            (AXI_R_RD_DATA_COUNT),
        .WR_DATA_COUNT            (AXI_R_WR_DATA_COUNT),
        .SBITERR                  (AXI_R_SBITERR),
        .DBITERR                  (AXI_R_DBITERR),
  
        .BACKUP                   (BACKUP),
        .BACKUP_MARKER            (BACKUP_MARKER),
        .INT_CLK                  (INT_CLK)
       );


    assign S_AXI_ARREADY = C_PROG_FULL_TYPE_RACH  == 5 ? ~rach_full  : C_PROG_FULL_TYPE_RACH  == 6 ? ~rach_almost_full  : ~rach_prog_full;
    assign M_AXI_RREADY  = C_PROG_FULL_TYPE_RDCH  == 5 ? ~rdch_full  : C_PROG_FULL_TYPE_RDCH  == 6 ? ~rdch_almost_full  : ~rdch_prog_full;
    assign M_AXI_ARVALID = C_PROG_EMPTY_TYPE_RACH == 5 ? ~rach_empty : C_PROG_EMPTY_TYPE_RACH == 6 ? ~rach_almost_empty : ~rach_prog_empty;
    assign S_AXI_RVALID  = C_PROG_EMPTY_TYPE_RDCH == 5 ? ~rdch_empty : C_PROG_EMPTY_TYPE_RDCH == 6 ? ~rdch_almost_empty : ~rdch_prog_empty;

    assign AXI_AR_UNDERFLOW  = C_USE_COMMON_UNDERFLOW == 0 ? axi_ar_underflow_i : 0;
    assign AXI_R_UNDERFLOW   = C_USE_COMMON_UNDERFLOW == 0 ? axi_r_underflow_i  : 0;
    assign AXI_AR_OVERFLOW   = C_USE_COMMON_OVERFLOW  == 0 ? axi_ar_overflow_i  : 0;
    assign AXI_R_OVERFLOW    = C_USE_COMMON_OVERFLOW  == 0 ? axi_r_overflow_i   : 0;

    assign axi_rd_underflow_i = C_USE_COMMON_UNDERFLOW == 1 ? (axi_ar_underflow_i || axi_r_underflow_i) : 0;
    assign axi_rd_overflow_i  = C_USE_COMMON_OVERFLOW  == 1 ? (axi_ar_overflow_i  || axi_r_overflow_i) : 0;

  end endgenerate // axi_read_channel


  generate if (IS_AXI_FULL_RD_CH == 1) begin : axi_full_rd_ch_output
    assign M_AXI_ARID      = rach_dout[C_DIN_WIDTH_RACH-1:ARID_OFFSET];    
    assign M_AXI_ARADDR    = rach_dout[ARID_OFFSET-1:ARADDR_OFFSET];    
    assign M_AXI_ARLEN     = rach_dout[ARADDR_OFFSET-1:ARLEN_OFFSET];    
    assign M_AXI_ARSIZE    = rach_dout[ARLEN_OFFSET-1:ARSIZE_OFFSET];    
    assign M_AXI_ARBURST   = rach_dout[ARSIZE_OFFSET-1:ARBURST_OFFSET];    
    assign M_AXI_ARLOCK    = rach_dout[ARBURST_OFFSET-1:ARLOCK_OFFSET];    
    assign M_AXI_ARCACHE   = rach_dout[ARLOCK_OFFSET-1:ARCACHE_OFFSET];    
    assign M_AXI_ARPROT    = rach_dout[ARCACHE_OFFSET-1:ARPROT_OFFSET];    
    assign M_AXI_ARQOS     = rach_dout[ARPROT_OFFSET-1:ARQOS_OFFSET];    
    assign M_AXI_ARREGION  = rach_dout[ARQOS_OFFSET-1:ARREGION_OFFSET];    
    assign S_AXI_RID       = rdch_dout[C_DIN_WIDTH_RDCH-1:RID_OFFSET];
    assign S_AXI_RDATA     = rdch_dout[RID_OFFSET-1:RDATA_OFFSET];
    assign S_AXI_RRESP     = rdch_dout[RDATA_OFFSET-1:RRESP_OFFSET];
    assign S_AXI_RLAST     = rdch_dout[0];
  end endgenerate // axi_full_rd_ch_output

  generate if (IS_AXI_LITE_RD_CH == 1) begin : axi_lite_rd_ch_output
    assign rach_din      = {S_AXI_ARADDR, S_AXI_ARPROT};
    assign rdch_din      = {M_AXI_RDATA, M_AXI_RRESP};
    assign M_AXI_ARADDR  = rach_dout[C_DIN_WIDTH_RACH-1:ARADDR_OFFSET];
    assign M_AXI_ARPROT  = rach_dout[ARADDR_OFFSET-1:ARPROT_OFFSET];
    assign S_AXI_RDATA   = rdch_dout[C_DIN_WIDTH_RDCH-1:RDATA_OFFSET];
    assign S_AXI_RRESP   = rdch_dout[RDATA_OFFSET-1:RRESP_OFFSET];
  end endgenerate // axi_lite_rd_ch_output

  generate if (IS_AXI_FULL_RD_CH == 1 && C_HAS_AXI_ARUSER == 1) begin : grach_din1
    assign rach_din     = {S_AXI_ARID, S_AXI_ARADDR, S_AXI_ARLEN, S_AXI_ARSIZE, S_AXI_ARBURST, 
                           S_AXI_ARLOCK, S_AXI_ARCACHE, S_AXI_ARPROT, S_AXI_ARQOS, S_AXI_ARREGION, 
                           S_AXI_ARUSER};
    assign M_AXI_ARUSER = rach_dout[ARREGION_OFFSET-1:ARUSER_OFFSET];
  end endgenerate // grach_din1

  generate if (IS_AXI_FULL_RD_CH == 1 && C_HAS_AXI_ARUSER == 0) begin : grach_din2
    assign rach_din     = {S_AXI_ARID, S_AXI_ARADDR, S_AXI_ARLEN, S_AXI_ARSIZE, S_AXI_ARBURST, 
                           S_AXI_ARLOCK, S_AXI_ARCACHE, S_AXI_ARPROT, S_AXI_ARQOS, S_AXI_ARREGION};
    assign M_AXI_ARUSER = 0;
  end endgenerate // grach_din2

  generate if (IS_AXI_FULL_RD_CH == 1 && C_HAS_AXI_RUSER == 1) begin : grdch_din1
    assign rdch_din     = {M_AXI_RID, M_AXI_RDATA, M_AXI_RRESP, M_AXI_RUSER, M_AXI_RLAST};
    assign S_AXI_RUSER  = rdch_dout[RRESP_OFFSET-1:RUSER_OFFSET];
  end endgenerate // grdch_din1

  generate if (IS_AXI_FULL_RD_CH == 1 && C_HAS_AXI_RUSER == 0) begin : grdch_din2
    assign rdch_din     = {M_AXI_RID, M_AXI_RDATA, M_AXI_RRESP, M_AXI_RLAST};
    assign S_AXI_RUSER  = 0;
  end endgenerate // grdch_din2

  //end of axi_read_channel

  generate if (C_INTERFACE_TYPE == 1 && C_USE_COMMON_UNDERFLOW == 1) begin : gaxi_comm_uf
    assign UNDERFLOW = (C_HAS_AXI_WR_CHANNEL == 1 && C_HAS_AXI_RD_CHANNEL == 1) ? (axi_wr_underflow_i || axi_rd_underflow_i) :
                       (C_HAS_AXI_WR_CHANNEL == 1 && C_HAS_AXI_RD_CHANNEL == 0) ? axi_wr_underflow_i :
                       (C_HAS_AXI_WR_CHANNEL == 0 && C_HAS_AXI_RD_CHANNEL == 1) ? axi_rd_underflow_i : 0;
  end endgenerate // gaxi_comm_uf

  generate if (C_INTERFACE_TYPE == 1 && C_USE_COMMON_OVERFLOW == 1) begin : gaxi_comm_of
    assign OVERFLOW = (C_HAS_AXI_WR_CHANNEL == 1 && C_HAS_AXI_RD_CHANNEL == 1) ? (axi_wr_overflow_i || axi_rd_overflow_i) :
                      (C_HAS_AXI_WR_CHANNEL == 1 && C_HAS_AXI_RD_CHANNEL == 0) ? axi_wr_overflow_i :
                      (C_HAS_AXI_WR_CHANNEL == 0 && C_HAS_AXI_RD_CHANNEL == 1) ? axi_rd_overflow_i : 0;
  end endgenerate // gaxi_comm_of
  
  //-------------------------------------------------------------------------
  //-------------------------------------------------------------------------
  //-------------------------------------------------------------------------
  // Pass Through Logic or Wiring Logic
  //-------------------------------------------------------------------------
  //-------------------------------------------------------------------------
  //-------------------------------------------------------------------------
  
  //-------------------------------------------------------------------------
  // Pass Through Logic for Read Channel
  //-------------------------------------------------------------------------

  // Wiring logic for Write Address Channel
  generate if (C_WACH_TYPE == 2) begin : gwach_pass_through
    assign M_AXI_AWID      = S_AXI_AWID;
    assign M_AXI_AWADDR    = S_AXI_AWADDR;
    assign M_AXI_AWLEN     = S_AXI_AWLEN;
    assign M_AXI_AWSIZE    = S_AXI_AWSIZE;
    assign M_AXI_AWBURST   = S_AXI_AWBURST;
    assign M_AXI_AWLOCK    = S_AXI_AWLOCK;
    assign M_AXI_AWCACHE   = S_AXI_AWCACHE;
    assign M_AXI_AWPROT    = S_AXI_AWPROT;
    assign M_AXI_AWQOS     = S_AXI_AWQOS;
    assign M_AXI_AWREGION  = S_AXI_AWREGION;
    assign M_AXI_AWUSER    = S_AXI_AWUSER;
    assign S_AXI_AWREADY   = M_AXI_AWREADY;
    assign M_AXI_AWVALID   = S_AXI_AWVALID;
  end endgenerate // gwach_pass_through;

  // Wiring logic for Write Data Channel
  generate if (C_WDCH_TYPE == 2) begin : gwdch_pass_through
    assign M_AXI_WID       = S_AXI_WID;
    assign M_AXI_WDATA     = S_AXI_WDATA;
    assign M_AXI_WSTRB     = S_AXI_WSTRB;
    assign M_AXI_WLAST     = S_AXI_WLAST;
    assign M_AXI_WUSER     = S_AXI_WUSER;
    assign S_AXI_WREADY    = M_AXI_WREADY;
    assign M_AXI_WVALID    = S_AXI_WVALID;
  end endgenerate // gwdch_pass_through;

  // Wiring logic for Write Response Channel
  generate if (C_WRCH_TYPE == 2) begin : gwrch_pass_through
    assign S_AXI_BID       = M_AXI_BID;
    assign S_AXI_BRESP     = M_AXI_BRESP;
    assign S_AXI_BUSER     = M_AXI_BUSER;
    assign M_AXI_BREADY    = S_AXI_BREADY;
    assign S_AXI_BVALID    = M_AXI_BVALID;
  end endgenerate // gwrch_pass_through;

  //-------------------------------------------------------------------------
  // Pass Through Logic for Read Channel
  //-------------------------------------------------------------------------

  // Wiring logic for Read Address Channel
  generate if (C_RACH_TYPE == 2) begin : grach_pass_through
    assign M_AXI_ARID      = S_AXI_ARID;
    assign M_AXI_ARADDR    = S_AXI_ARADDR;
    assign M_AXI_ARLEN     = S_AXI_ARLEN;
    assign M_AXI_ARSIZE    = S_AXI_ARSIZE;
    assign M_AXI_ARBURST   = S_AXI_ARBURST;
    assign M_AXI_ARLOCK    = S_AXI_ARLOCK;
    assign M_AXI_ARCACHE   = S_AXI_ARCACHE;
    assign M_AXI_ARPROT    = S_AXI_ARPROT;
    assign M_AXI_ARQOS     = S_AXI_ARQOS;
    assign M_AXI_ARREGION  = S_AXI_ARREGION;
    assign M_AXI_ARUSER    = S_AXI_ARUSER;
    assign S_AXI_ARREADY   = M_AXI_ARREADY;
    assign M_AXI_ARVALID   = S_AXI_ARVALID;
  end endgenerate // grach_pass_through;

  // Wiring logic for Read Data Channel 
  generate if (C_RDCH_TYPE == 2) begin : grdch_pass_through
    assign S_AXI_RID      = M_AXI_RID;
    assign S_AXI_RLAST    = M_AXI_RLAST;
    assign S_AXI_RUSER    = M_AXI_RUSER;
    assign S_AXI_RDATA    = M_AXI_RDATA;
    assign S_AXI_RRESP    = M_AXI_RRESP;
    assign S_AXI_RVALID   = M_AXI_RVALID;
    assign M_AXI_RREADY   = S_AXI_RREADY;
  end endgenerate // grdch_pass_through;

  // Wiring logic for AXI Streaming
  generate if (C_AXIS_TYPE == 2) begin : gaxis_pass_through
    assign M_AXIS_TDATA   = S_AXIS_TDATA;
    assign M_AXIS_TSTRB   = S_AXIS_TSTRB;
    assign M_AXIS_TKEEP   = S_AXIS_TKEEP;
    assign M_AXIS_TID     = S_AXIS_TID;
    assign M_AXIS_TDEST   = S_AXIS_TDEST;
    assign M_AXIS_TUSER   = S_AXIS_TUSER;
    assign M_AXIS_TLAST   = S_AXIS_TLAST;
    assign S_AXIS_TREADY  = M_AXIS_TREADY;
    assign M_AXIS_TVALID  = S_AXIS_TVALID;
  end endgenerate // gaxis_pass_through;


endmodule //FIFO_GENERATOR_V7_2



/*******************************************************************************
 * Declaration of top-level module for Conventional FIFO
 ******************************************************************************/
module FIFO_GENERATOR_V7_2_CONV_VER
  #(
    parameter  C_COMMON_CLOCK                 = 0,
    parameter  C_COUNT_TYPE                   = 0,
    parameter  C_DATA_COUNT_WIDTH             = 2,
    parameter  C_DEFAULT_VALUE                = "",
    parameter  C_DIN_WIDTH                    = 8,
    parameter  C_DOUT_RST_VAL                 = "",
    parameter  C_DOUT_WIDTH                   = 8,
    parameter  C_ENABLE_RLOCS                 = 0,
    parameter  C_FAMILY                       = "virtex6", //Not allowed in Verilog model
    parameter  C_FULL_FLAGS_RST_VAL           = 1,
    parameter  C_HAS_ALMOST_EMPTY             = 0,
    parameter  C_HAS_ALMOST_FULL              = 0,
    parameter  C_HAS_BACKUP                   = 0,
    parameter  C_HAS_DATA_COUNT               = 0,
    parameter  C_HAS_INT_CLK                  = 0,
    parameter  C_HAS_MEMINIT_FILE             = 0,
    parameter  C_HAS_OVERFLOW                 = 0,
    parameter  C_HAS_RD_DATA_COUNT            = 0,
    parameter  C_HAS_RD_RST                   = 0,
    parameter  C_HAS_RST                      = 0,
    parameter  C_HAS_SRST                     = 0,
    parameter  C_HAS_UNDERFLOW                = 0,
    parameter  C_HAS_VALID                    = 0,
    parameter  C_HAS_WR_ACK                   = 0,
    parameter  C_HAS_WR_DATA_COUNT            = 0,
    parameter  C_HAS_WR_RST                   = 0,
    parameter  C_IMPLEMENTATION_TYPE          = 0,
    parameter  C_INIT_WR_PNTR_VAL             = 0,
    parameter  C_MEMORY_TYPE                  = 1,
    parameter  C_MIF_FILE_NAME                = "",
    parameter  C_OPTIMIZATION_MODE            = 0,
    parameter  C_OVERFLOW_LOW                 = 0,
    parameter  C_PRELOAD_LATENCY              = 1,
    parameter  C_PRELOAD_REGS                 = 0,
    parameter  C_PRIM_FIFO_TYPE               = "",
    parameter  C_PROG_EMPTY_THRESH_ASSERT_VAL = 0,
    parameter  C_PROG_EMPTY_THRESH_NEGATE_VAL = 0,
    parameter  C_PROG_EMPTY_TYPE              = 0,
    parameter  C_PROG_FULL_THRESH_ASSERT_VAL  = 0,
    parameter  C_PROG_FULL_THRESH_NEGATE_VAL  = 0,
    parameter  C_PROG_FULL_TYPE               = 0,
    parameter  C_RD_DATA_COUNT_WIDTH          = 2,
    parameter  C_RD_DEPTH                     = 256,
    parameter  C_RD_FREQ                      = 1,
    parameter  C_RD_PNTR_WIDTH                = 8,
    parameter  C_UNDERFLOW_LOW                = 0,
    parameter  C_USE_DOUT_RST                 = 0,
    parameter  C_USE_ECC                      = 0,
    parameter  C_USE_EMBEDDED_REG             = 0,
    parameter  C_USE_FIFO16_FLAGS             = 0,
    parameter  C_USE_FWFT_DATA_COUNT          = 0,
    parameter  C_VALID_LOW                    = 0,
    parameter  C_WR_ACK_LOW                   = 0,
    parameter  C_WR_DATA_COUNT_WIDTH          = 2,
    parameter  C_WR_DEPTH                     = 256,
    parameter  C_WR_FREQ                      = 1,
    parameter  C_WR_PNTR_WIDTH                = 8,
    parameter  C_WR_RESPONSE_LATENCY          = 1,
    parameter  C_MSGON_VAL                    = 1,
    parameter  C_ENABLE_RST_SYNC              = 1,
    parameter  C_ERROR_INJECTION_TYPE         = 0
   )

  (
   input                               BACKUP,
   input                               BACKUP_MARKER,
   input                               CLK,
   input                               RST,
   input                               SRST,
   input                               WR_CLK,
   input                               WR_RST,
   input                               RD_CLK,
   input                               RD_RST,
   input [C_DIN_WIDTH-1:0]             DIN,
   input                               WR_EN,
   input                               RD_EN,
   input [C_RD_PNTR_WIDTH-1:0]         PROG_EMPTY_THRESH,
   input [C_RD_PNTR_WIDTH-1:0]         PROG_EMPTY_THRESH_ASSERT,
   input [C_RD_PNTR_WIDTH-1:0]         PROG_EMPTY_THRESH_NEGATE,
   input [C_WR_PNTR_WIDTH-1:0]         PROG_FULL_THRESH,
   input [C_WR_PNTR_WIDTH-1:0]         PROG_FULL_THRESH_ASSERT,
   input [C_WR_PNTR_WIDTH-1:0]         PROG_FULL_THRESH_NEGATE,
   input                               INT_CLK,
   input                               INJECTDBITERR,
   input                               INJECTSBITERR,
  
   output [C_DOUT_WIDTH-1:0]           DOUT,
   output                              FULL,
   output                              ALMOST_FULL,
   output                              WR_ACK,
   output                              OVERFLOW,
   output                              EMPTY,
   output                              ALMOST_EMPTY,
   output                              VALID,
   output                              UNDERFLOW,
   output [C_DATA_COUNT_WIDTH-1:0]     DATA_COUNT,
   output [C_RD_DATA_COUNT_WIDTH-1:0]  RD_DATA_COUNT,
   output [C_WR_DATA_COUNT_WIDTH-1:0]  WR_DATA_COUNT,
   output                              PROG_FULL,
   output                              PROG_EMPTY,
   output                              SBITERR,
   output                              DBITERR
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
 *     C_USE_ECC                     : Used for error injection purpose
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
 *     C_ENABLE_RST_SYNC             : 0 = Use WR_RST & RD_RST
 *                                     1 = Use RST
 *     C_ERROR_INJECTION_TYPE        : 0 = No error injection
 *                                     1 = Single bit error injection only
 *                                     2 = Double bit error injection only
 *                                     3 = Single and double bit error injection
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
 *   RD_RST       : Read Reset
 *   RST          : Asynchronous Reset
 *   SRST         : Synchronous Reset
 *   WR_CLK       : Write Domain Clock
 *   WR_EN        : Write enable
 *   WR_RST       : Write Reset
 *   INT_CLK      : Internal Clock
 *   INJECTSBITERR: Inject Signle bit error
 *   INJECTDBITERR: Inject Double bit error
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


  /*****************************************************************************
   * Derived parameters
   ****************************************************************************/
  //There are 2 Verilog behavioral models
  // 0 = Common-Clock FIFO/ShiftRam FIFO
  // 1 = Independent Clocks FIFO
  localparam C_VERILOG_IMPL = (C_IMPLEMENTATION_TYPE == 2) ? 1 : 0;

  //Internal reset signals
  reg                                rd_rst_asreg    = 0;
  reg                                rd_rst_asreg_d1 = 0;
  reg                                rd_rst_asreg_d2 = 0;
  reg                                rd_rst_reg      = 0;
  wire                               rd_rst_comb;
  reg                                rd_rst_d1       = 0;
  reg                                wr_rst_asreg    = 0;
  reg                                wr_rst_asreg_d1 = 0;
  reg                                wr_rst_asreg_d2 = 0;
  reg                                wr_rst_reg      = 0;
  wire                               wr_rst_comb;
  wire                               wr_rst_i;
  wire                               rd_rst_i;
  wire                               rst_i;

  //Internal reset signals
  reg                                rst_asreg    = 0;
  reg                                rst_asreg_d1 = 0;
  reg                                rst_asreg_d2 = 0;
  reg                                rst_reg      = 0;
  wire                               rst_comb;
  wire                               rst_full_gen_i;
  wire                               rst_full_ff_i;
                                     
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
  reg  [31:0]                        DATA_COUNT_FWFT;
  reg                                SS_FWFT_WR  ;
  reg                                SS_FWFT_RD ;

  wire                               sbiterr_fifo_out;
  wire                               dbiterr_fifo_out;

  // Assign 0 if not selected to avoid 'X' propogation to S/DBITERR.
  wire inject_sbit_err = ((C_ERROR_INJECTION_TYPE == 1) || (C_ERROR_INJECTION_TYPE == 3)) ?
                         INJECTSBITERR : 0;
  wire inject_dbit_err = ((C_ERROR_INJECTION_TYPE == 2) || (C_ERROR_INJECTION_TYPE == 3)) ?
                           INJECTDBITERR : 0;
                           
   
// Choose the behavioral model to instantiate based on the C_VERILOG_IMPL
// parameter (1=Independent Clocks, 0=Common Clock)

  localparam FULL_FLAGS_RST_VAL = (C_HAS_SRST == 1) ? 0 : C_FULL_FLAGS_RST_VAL;
generate
case (C_VERILOG_IMPL)
0 : begin : block1
  //Common Clock Behavioral Model
  fifo_generator_v7_2_bhv_ver_ss
  #(
    C_DATA_COUNT_WIDTH,
    C_DIN_WIDTH,
    C_DOUT_RST_VAL,
    C_DOUT_WIDTH,
//    C_FULL_FLAGS_RST_VAL,
    FULL_FLAGS_RST_VAL,
    C_HAS_ALMOST_EMPTY,
    C_HAS_ALMOST_FULL,
    C_HAS_DATA_COUNT,
    C_HAS_OVERFLOW,
    C_HAS_RD_DATA_COUNT,
    C_HAS_RST,
    C_HAS_SRST,
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
    C_WR_PNTR_WIDTH,
    C_USE_ECC,
    C_ENABLE_RST_SYNC,
    C_ERROR_INJECTION_TYPE
  )
  gen_ss
  (
    .CLK                      (CLK),
    .RST                      (rst_i),
    .SRST                     (SRST),
    .RST_FULL_GEN             (rst_full_gen_i),
    .RST_FULL_FF              (rst_full_ff_i),
    .DIN                      (DIN),
    .WR_EN                    (WR_EN),
    .RD_EN                    (RD_EN_FIFO_IN),
    .PROG_EMPTY_THRESH        (PROG_EMPTY_THRESH),
    .PROG_EMPTY_THRESH_ASSERT (PROG_EMPTY_THRESH_ASSERT),
    .PROG_EMPTY_THRESH_NEGATE (PROG_EMPTY_THRESH_NEGATE),
    .PROG_FULL_THRESH         (PROG_FULL_THRESH),
    .PROG_FULL_THRESH_ASSERT  (PROG_FULL_THRESH_ASSERT),
    .PROG_FULL_THRESH_NEGATE  (PROG_FULL_THRESH_NEGATE),
    .INJECTSBITERR            (inject_sbit_err),
    .INJECTDBITERR            (inject_dbit_err),
    .DOUT                     (DOUT_FIFO_OUT),
    .FULL                     (FULL_FIFO_OUT),
    .ALMOST_FULL              (ALMOST_FULL_FIFO_OUT),
    .WR_ACK                   (WR_ACK_FIFO_OUT),
    .OVERFLOW                 (OVERFLOW_FIFO_OUT),
    .EMPTY                    (EMPTY_FIFO_OUT),
    .ALMOST_EMPTY             (ALMOST_EMPTY_FIFO_OUT),
    .VALID                    (VALID_FIFO_OUT),
    .UNDERFLOW                (UNDERFLOW_FIFO_OUT),
    .DATA_COUNT               (DATA_COUNT_FIFO_OUT),
    .PROG_FULL                (PROG_FULL_FIFO_OUT),
    .PROG_EMPTY               (PROG_EMPTY_FIFO_OUT),
    .SBITERR                  (sbiterr_fifo_out),
    .DBITERR                  (dbiterr_fifo_out)
   );
end
1 : begin : block1
  //Independent Clocks Behavioral Model
  fifo_generator_v7_2_bhv_ver_as
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
    C_WR_PNTR_WIDTH,
    C_USE_ECC,
    C_ENABLE_RST_SYNC,
    C_ERROR_INJECTION_TYPE
  )
  gen_as
  (
    .WR_CLK                   (WR_CLK),
    .RD_CLK                   (RD_CLK),
    .RST                      (rst_i),
    .RST_FULL_GEN             (rst_full_gen_i),
    .RST_FULL_FF              (rst_full_ff_i),
    .WR_RST                   (wr_rst_i),
    .RD_RST                   (rd_rst_i),
    .DIN                      (DIN),
    .WR_EN                    (WR_EN),
    .RD_EN                    (RD_EN_FIFO_IN),
    .RD_EN_USER               (RD_EN),
    .PROG_EMPTY_THRESH        (PROG_EMPTY_THRESH),
    .PROG_EMPTY_THRESH_ASSERT (PROG_EMPTY_THRESH_ASSERT),
    .PROG_EMPTY_THRESH_NEGATE (PROG_EMPTY_THRESH_NEGATE),
    .PROG_FULL_THRESH         (PROG_FULL_THRESH),
    .PROG_FULL_THRESH_ASSERT  (PROG_FULL_THRESH_ASSERT),
    .PROG_FULL_THRESH_NEGATE  (PROG_FULL_THRESH_NEGATE),
    .INJECTSBITERR            (inject_sbit_err),
    .INJECTDBITERR            (inject_dbit_err),
    .USER_EMPTY_FB            (EMPTY_P0_OUT),
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
    .PROG_EMPTY               (PROG_EMPTY_FIFO_OUT),
    .SBITERR                  (sbiterr_fifo_out),
    .DBITERR                  (dbiterr_fifo_out)
   );
end

default : begin : block1
  //Independent Clocks Behavioral Model
  fifo_generator_v7_2_bhv_ver_as
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
    C_WR_PNTR_WIDTH,
    C_USE_ECC,
    C_ENABLE_RST_SYNC,
    C_ERROR_INJECTION_TYPE
  )
  gen_as
  (
    .WR_CLK                   (WR_CLK),
    .RD_CLK                   (RD_CLK),
    .RST                      (rst_i),
    .RST_FULL_GEN             (rst_full_gen_i),
    .RST_FULL_FF              (rst_full_ff_i),
    .WR_RST                   (wr_rst_i),
    .RD_RST                   (rd_rst_i),
    .DIN                      (DIN),
    .WR_EN                    (WR_EN),
    .RD_EN                    (RD_EN_FIFO_IN),
    .RD_EN_USER               (RD_EN),
    .PROG_EMPTY_THRESH        (PROG_EMPTY_THRESH),
    .PROG_EMPTY_THRESH_ASSERT (PROG_EMPTY_THRESH_ASSERT),
    .PROG_EMPTY_THRESH_NEGATE (PROG_EMPTY_THRESH_NEGATE),
    .PROG_FULL_THRESH         (PROG_FULL_THRESH),
    .PROG_FULL_THRESH_ASSERT  (PROG_FULL_THRESH_ASSERT),
    .PROG_FULL_THRESH_NEGATE  (PROG_FULL_THRESH_NEGATE),
    .INJECTSBITERR            (inject_sbit_err),
    .INJECTDBITERR            (inject_dbit_err),
    .USER_EMPTY_FB            (EMPTY_P0_OUT),
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
    .PROG_EMPTY               (PROG_EMPTY_FIFO_OUT),
    .SBITERR                  (sbiterr_fifo_out),
    .DBITERR                  (dbiterr_fifo_out)
   );
end

endcase
endgenerate


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
         
         
         fifo_generator_v7_2_bhv_ver_preload0
           #(
             C_DOUT_RST_VAL,
             C_DOUT_WIDTH,
             C_HAS_RST,
             C_ENABLE_RST_SYNC,
             C_HAS_SRST,
             C_USE_DOUT_RST,
             C_USE_ECC,
             C_VALID_LOW,
             C_UNDERFLOW_LOW,
             C_MEMORY_TYPE
             )
             fgpl0
               (
                .RD_CLK           (RD_CLK_P0_IN),
                .RD_RST           (RST_P0_IN),
                .SRST             (SRST),
                .RD_EN            (RD_EN_P0_IN),
                .FIFOEMPTY        (EMPTY_P0_IN),
                .FIFODATA         (DATA_P0_IN),
                .FIFOSBITERR      (sbiterr_fifo_out),
                .FIFODBITERR      (dbiterr_fifo_out),
                .USERDATA         (DATA_P0_OUT),
                .USERVALID        (VALID_P0_OUT),
                .USEREMPTY        (EMPTY_P0_OUT),
                .USERALMOSTEMPTY  (ALMOSTEMPTY_P0_OUT),
                .USERUNDERFLOW    (UNDERFLOW_P0_OUT),
                .RAMVALID         (RAMVALID_P0_OUT),
                .FIFORDEN         (RDEN_P0_OUT),
                .USERSBITERR      (SBITERR),
                .USERDBITERR      (DBITERR)
                );
         
         
         //***********************************************
         // Connect inputs to preload (FWFT) module
         //***********************************************
         //Connect the RD_CLK of the Preload (FWFT) module to CLK if we 
         // have a common-clock FIFO, or RD_CLK if we have an 
         // independent clock FIFO
         assign RD_CLK_P0_IN       = ((C_VERILOG_IMPL == 0) ? CLK : RD_CLK);
         assign RST_P0_IN          = (C_COMMON_CLOCK == 0) ? rd_rst_i : (C_HAS_RST == 1) ? rst_i : 0;
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
         always @ (posedge RD_CLK or posedge RST_P0_IN) begin
            if (RST_P0_IN) begin
               EMPTY_P0_OUT_Q       <= #`TCQ 1;
               ALMOSTEMPTY_P0_OUT_Q <= #`TCQ 1;
            end else begin
               EMPTY_P0_OUT_Q       <= #`TCQ EMPTY_P0_OUT;
               ALMOSTEMPTY_P0_OUT_Q <= #`TCQ ALMOSTEMPTY_P0_OUT;
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
            if (C_VALID_LOW == 1) begin
              SS_FWFT_RD = RD_EN && ~VALID_P0_OUT ;
            end else begin
              SS_FWFT_RD = RD_EN && VALID_P0_OUT ;
            end
            SS_FWFT_WR = (WR_EN && (~FULL_FIFO_OUT))  ;
         end 

         //***********************************************
         // common-clock data count is implemented as an
         // up-down counter for FWFT. This always block 
         // calculates the counter.
         //***********************************************
         always @ (posedge RD_CLK_P0_IN or posedge RST_P0_IN) begin
            if (RST_P0_IN) begin
               DATA_COUNT_FWFT      <= #`TCQ 0;
            end else begin
               if (SRST && (C_HAS_SRST == 1) ) begin
                  DATA_COUNT_FWFT      <= #`TCQ 0;
               end else begin
                  case ( {SS_FWFT_WR, SS_FWFT_RD})
                    2'b00: DATA_COUNT_FWFT <= #`TCQ DATA_COUNT_FWFT ;
                    2'b01: DATA_COUNT_FWFT <= #`TCQ DATA_COUNT_FWFT - 1 ;
                    2'b10: DATA_COUNT_FWFT <= #`TCQ DATA_COUNT_FWFT + 1 ;
                    2'b11: DATA_COUNT_FWFT <= #`TCQ DATA_COUNT_FWFT ;
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
         assign SBITERR            = sbiterr_fifo_out;
         assign DBITERR            = dbiterr_fifo_out;
         
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
         assign RD_DATA_COUNT = (EMPTY_P0_OUT_Q | RST_P0_IN) ? 0 : (ALMOSTEMPTY_P0_OUT_Q ? 1 : RD_DATA_COUNT_FIFO_OUT);
      end //block3
   endgenerate
   
   //If we are using extra logic for the FWFT data count, then override the
   //RD_DATA_COUNT output when we are EMPTY or ALMOST_EMPTY.
   //Due to asymmetric ports, RD_DATA_COUNT is 0 when EMPTY or ALMOST_EMPTY.
   generate
      if (C_USE_FWFT_DATA_COUNT==1 && (C_RD_DATA_COUNT_WIDTH <=C_RD_PNTR_WIDTH) ) begin : block30
         assign RD_DATA_COUNT = (EMPTY_P0_OUT_Q | RST_P0_IN) ? 0 : (ALMOSTEMPTY_P0_OUT_Q ? 0 : RD_DATA_COUNT_FIFO_OUT);
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
   assign       FULL        = FULL_FIFO_OUT;
   assign       ALMOST_FULL = ALMOST_FULL_FIFO_OUT;
   assign       WR_ACK      = WR_ACK_FIFO_OUT;
   assign       OVERFLOW    = OVERFLOW_FIFO_OUT;
   assign       PROG_FULL   = PROG_FULL_FIFO_OUT;
   assign       PROG_EMPTY  = PROG_EMPTY_FIFO_OUT;


  /**************************************************************************
  * find_log2
  *   Returns the 'log2' value for the input value for the supported ratios
  ***************************************************************************/
  function integer find_log2;
    input integer int_val;
    integer i,j;
    begin
      i = 1;
      j = 0;
      for (i = 1; i < int_val; i = i*2) begin
        j = j + 1;
      end
      find_log2 = j;
    end
  endfunction

   // if an asynchronous FIFO has been selected, display a message that the FIFO
   //   will not be cycle-accurate in simulation
   initial begin
      if (C_IMPLEMENTATION_TYPE == 2) begin
         $display("WARNING: Behavioral models for independent clock FIFO configurations do not model synchronization delays. The behavioral models are functionally correct, and will represent the behavior of the configured FIFO. See the FIFO Generator User Guide for more information.");
      end else if (C_MEMORY_TYPE == 4) begin
         $display("FAILURE : Behavioral models for Virtex-4, Virtex-5 and Virtex-6 built-in FIFO configurations is currently not supported. Please select the structural simulation model option in CORE Generator. You can enable this in CORE Generator by selecting Project -> Project Options -> Generation tab -> Structural Simulation. See the FIFO Generator User Guide for more information.");
         $finish;
      end

      if (C_WR_PNTR_WIDTH != find_log2(C_WR_DEPTH)) begin
         $display("FAILURE : C_WR_PNTR_WIDTH is not log2 of C_WR_DEPTH.");
         $finish;
      end

      if (C_RD_PNTR_WIDTH != find_log2(C_RD_DEPTH)) begin
         $display("FAILURE : C_RD_PNTR_WIDTH is not log2 of C_RD_DEPTH.");
         $finish;
      end

   end //initial

  /**************************************************************************
  * Internal reset logic
  **************************************************************************/
  assign wr_rst_i         = (C_HAS_RST == 1 || C_ENABLE_RST_SYNC == 0) ? wr_rst_reg : 0;
  assign rd_rst_i         = (C_HAS_RST == 1 || C_ENABLE_RST_SYNC == 0) ? rd_rst_reg : 0;
  assign rst_i            = C_HAS_RST ? rst_reg : 0;

  wire rst_2_sync;
  wire clk_2_sync = (C_COMMON_CLOCK == 1) ? CLK : WR_CLK;
  generate
      if (C_ENABLE_RST_SYNC == 0) begin : gnrst_sync
        always @* begin
          wr_rst_reg <= WR_RST;
          rd_rst_reg <= RD_RST;
          rst_reg    <= 1'b0;
        end
        assign rst_2_sync = WR_RST;
      end else if (C_HAS_RST == 1 && C_COMMON_CLOCK == 0) begin : gic_rst
        assign wr_rst_comb      = !wr_rst_asreg_d2 && wr_rst_asreg;
        assign rd_rst_comb      = !rd_rst_asreg_d2 && rd_rst_asreg;
        assign rst_2_sync = RST;

        always @(posedge WR_CLK or posedge RST) begin
          if (RST == 1'b1) begin
            wr_rst_asreg <= #`TCQ 1'b1;
          end else begin
            if (wr_rst_asreg_d1 == 1'b1) begin
              wr_rst_asreg <= #`TCQ 1'b0;
            end else begin
              wr_rst_asreg <= #`TCQ wr_rst_asreg;
            end
          end    
        end   
      
        always @(posedge WR_CLK) begin
          wr_rst_asreg_d1 <= #`TCQ wr_rst_asreg;
          wr_rst_asreg_d2 <= #`TCQ wr_rst_asreg_d1;
        end
        
        always @(posedge WR_CLK or posedge wr_rst_comb) begin
          if (wr_rst_comb == 1'b1) begin
            wr_rst_reg <= #`TCQ 1'b1;
          end else begin
            wr_rst_reg <= #`TCQ 1'b0;
          end    
        end   
        
        always @(posedge RD_CLK or posedge RST) begin
          if (RST == 1'b1) begin
            rd_rst_asreg <= #`TCQ 1'b1;
          end else begin
            if (rd_rst_asreg_d1 == 1'b1) begin
              rd_rst_asreg <= #`TCQ 1'b0;
            end else begin
              rd_rst_asreg <= #`TCQ rd_rst_asreg;
            end
          end    
        end   

        always @(posedge RD_CLK) begin
          rd_rst_asreg_d1 <= #`TCQ rd_rst_asreg;
          rd_rst_asreg_d2 <= #`TCQ rd_rst_asreg_d1;
        end
        
         always @(posedge RD_CLK or posedge rd_rst_comb) begin
          if (rd_rst_comb == 1'b1) begin
            rd_rst_reg <= #`TCQ 1'b1;
          end else begin
            rd_rst_reg <= #`TCQ 1'b0;
          end    
        end   
      end else if (C_HAS_RST == 1 && C_COMMON_CLOCK == 1) begin : gcc_rst
        assign rst_comb      = !rst_asreg_d2 && rst_asreg;     
        assign rst_2_sync = RST;
 
        always @(posedge CLK or posedge RST) begin
           if (RST == 1'b1) begin
             rst_asreg <= #`TCQ 1'b1;
           end else begin
             if (rst_asreg_d1 == 1'b1) begin
               rst_asreg <= #`TCQ 1'b0;
             end else begin
               rst_asreg <= #`TCQ rst_asreg;
             end
           end    
        end   
        
        always @(posedge CLK) begin
           rst_asreg_d1 <= #`TCQ rst_asreg;
           rst_asreg_d2 <= #`TCQ rst_asreg_d1;
        end
      
        always @(posedge CLK or posedge rst_comb) begin
           if (rst_comb == 1'b1) begin
             rst_reg <= #`TCQ 1'b1;
           end else begin
             rst_reg <= #`TCQ 1'b0;
           end    
        end   
      end
  endgenerate 

  reg rst_d1 = 1'b0;
  reg rst_d2 = 1'b0;
  reg rst_d3 = 1'b0;
  reg rst_d4 = 1'b0;
  generate
    if ((C_HAS_RST == 1 || C_HAS_SRST == 1 || C_ENABLE_RST_SYNC == 0) && C_FULL_FLAGS_RST_VAL == 1) begin : grstd1
    // RST_FULL_GEN replaces the reset falling edge detection used to de-assert
    // FULL, ALMOST_FULL & PROG_FULL flags if C_FULL_FLAGS_RST_VAL = 1.

    // RST_FULL_FF goes to the reset pin of the final flop of FULL, ALMOST_FULL &
    // PROG_FULL

      always @ (posedge rst_2_sync or posedge clk_2_sync) begin
        if (rst_2_sync) begin
          rst_d1         <= 1'b1;
          rst_d2         <= 1'b1;
          rst_d3         <= 1'b1;
          rst_d4         <= 1'b0;
        end else begin
          if (SRST) begin
            rst_d1         <= #`TCQ 1'b1;
            rst_d2         <= #`TCQ 1'b1;
            rst_d3         <= #`TCQ 1'b1;
            rst_d4         <= #`TCQ 1'b0;
          end else begin
            rst_d1         <= #`TCQ 1'b0;
            rst_d2         <= #`TCQ rst_d1;
            rst_d3         <= #`TCQ rst_d2;
            rst_d4         <= #`TCQ rst_d3;
          end
        end
      end
      assign rst_full_ff_i  = (C_HAS_SRST == 0) ? rst_d2 : 1'b0 ;
      assign rst_full_gen_i = rst_d4;

    end else if ((C_HAS_RST == 1 || C_HAS_SRST == 1 || C_ENABLE_RST_SYNC == 0) && C_FULL_FLAGS_RST_VAL == 0) begin : gnrst_full
      assign rst_full_gen_i = 1'b0;
      assign rst_full_ff_i  = (C_COMMON_CLOCK == 0) ? wr_rst_i : rst_i;
    end
  endgenerate

endmodule //FIFO_GENERATOR_V7_2_CONV_VER



/*******************************************************************************
 * Declaration of Independent-Clocks FIFO Module
 ******************************************************************************/
module fifo_generator_v7_2_bhv_ver_as
   
  /***************************************************************************
   * Declare user parameters and their defaults
   ***************************************************************************/
  #(
    parameter  C_DATA_COUNT_WIDTH             = 2,
    parameter  C_DIN_WIDTH                    = 8,
    parameter  C_DOUT_RST_VAL                 = "",
    parameter  C_DOUT_WIDTH                   = 8,
    parameter  C_FULL_FLAGS_RST_VAL           = 1,
    parameter  C_HAS_ALMOST_EMPTY             = 0,
    parameter  C_HAS_ALMOST_FULL              = 0,
    parameter  C_HAS_DATA_COUNT               = 0,
    parameter  C_HAS_OVERFLOW                 = 0,
    parameter  C_HAS_RD_DATA_COUNT            = 0,
    parameter  C_HAS_RST                      = 0,
    parameter  C_HAS_UNDERFLOW                = 0,
    parameter  C_HAS_VALID                    = 0,
    parameter  C_HAS_WR_ACK                   = 0,
    parameter  C_HAS_WR_DATA_COUNT            = 0,
    parameter  C_IMPLEMENTATION_TYPE          = 0,
    parameter  C_MEMORY_TYPE                  = 1,
    parameter  C_OVERFLOW_LOW                 = 0,
    parameter  C_PRELOAD_LATENCY              = 1,
    parameter  C_PRELOAD_REGS                 = 0,
    parameter  C_PROG_EMPTY_THRESH_ASSERT_VAL = 0,
    parameter  C_PROG_EMPTY_THRESH_NEGATE_VAL = 0,
    parameter  C_PROG_EMPTY_TYPE              = 0,
    parameter  C_PROG_FULL_THRESH_ASSERT_VAL  = 0,
    parameter  C_PROG_FULL_THRESH_NEGATE_VAL  = 0,
    parameter  C_PROG_FULL_TYPE               = 0,
    parameter  C_RD_DATA_COUNT_WIDTH          = 2,
    parameter  C_RD_DEPTH                     = 256,
    parameter  C_RD_PNTR_WIDTH                = 8,
    parameter  C_UNDERFLOW_LOW                = 0,
    parameter  C_USE_DOUT_RST                 = 0,
    parameter  C_USE_EMBEDDED_REG             = 0,
    parameter  C_USE_FWFT_DATA_COUNT          = 0,
    parameter  C_VALID_LOW                    = 0,
    parameter  C_WR_ACK_LOW                   = 0,
    parameter  C_WR_DATA_COUNT_WIDTH          = 2,
    parameter  C_WR_DEPTH                     = 256,
    parameter  C_WR_PNTR_WIDTH                = 8,
    parameter  C_USE_ECC                      = 0, 
    parameter  C_ENABLE_RST_SYNC              = 1,
    parameter  C_ERROR_INJECTION_TYPE         = 0
   )

  /***************************************************************************
   * Declare Input and Output Ports
   ***************************************************************************/
  (
   input       [C_DIN_WIDTH-1:0]                 DIN,
   input       [C_RD_PNTR_WIDTH-1:0]             PROG_EMPTY_THRESH,
   input       [C_RD_PNTR_WIDTH-1:0]             PROG_EMPTY_THRESH_ASSERT,
   input       [C_RD_PNTR_WIDTH-1:0]             PROG_EMPTY_THRESH_NEGATE,
   input       [C_WR_PNTR_WIDTH-1:0]             PROG_FULL_THRESH,
   input       [C_WR_PNTR_WIDTH-1:0]             PROG_FULL_THRESH_ASSERT,
   input       [C_WR_PNTR_WIDTH-1:0]             PROG_FULL_THRESH_NEGATE,
   input                                         RD_CLK,
   input                                         RD_EN,
   input                                         RD_EN_USER,
   input                                         RST,
   input                                         RST_FULL_GEN,
   input                                         RST_FULL_FF,
   input                                         WR_RST,
   input                                         RD_RST,
   input                                         WR_CLK,
   input                                         WR_EN,
   input                                         INJECTDBITERR,
   input                                         INJECTSBITERR,
   input                                         USER_EMPTY_FB,
   output reg                                    ALMOST_EMPTY = 1'b1,
   output reg                                    ALMOST_FULL = C_FULL_FLAGS_RST_VAL,
   output      [C_DOUT_WIDTH-1:0]                DOUT,
   output reg                                    EMPTY = 1'b1,
   output reg                                    FULL = C_FULL_FLAGS_RST_VAL,
   output                                        OVERFLOW,
   output                                        PROG_EMPTY,
   output                                        PROG_FULL,
   output                                        VALID,
   output      [C_RD_DATA_COUNT_WIDTH-1:0]       RD_DATA_COUNT,
   output                                        UNDERFLOW,
   output                                        WR_ACK,
   output      [C_WR_DATA_COUNT_WIDTH-1:0]       WR_DATA_COUNT,
   output                                        SBITERR,
   output                                        DBITERR
  );
   
   reg  [C_RD_PNTR_WIDTH:0] rd_data_count_int = 0;
   reg  [C_WR_PNTR_WIDTH:0] wr_data_count_int = 0;
   reg  [C_WR_PNTR_WIDTH:0] wdc_fwft_ext_as = 0;
   
  
   /***************************************************************************
    * Parameters used as constants
    **************************************************************************/
   //When RST is present, set FULL reset value to '1'.
   //If core has no RST, make sure FULL powers-on as '0'.
   localparam C_DEPTH_RATIO_WR =  
      (C_WR_DEPTH>C_RD_DEPTH) ? (C_WR_DEPTH/C_RD_DEPTH) : 1;
   localparam C_DEPTH_RATIO_RD =  
      (C_RD_DEPTH>C_WR_DEPTH) ? (C_RD_DEPTH/C_WR_DEPTH) : 1;
   localparam C_FIFO_WR_DEPTH = C_WR_DEPTH - 1;
   localparam C_FIFO_RD_DEPTH = C_RD_DEPTH - 1;

   //  C_DEPTH_RATIO_WR | C_DEPTH_RATIO_RD | C_PNTR_WIDTH    | EXTRA_WORDS_DC
   //  -----------------|------------------|-----------------|---------------
   //  1                | 8                | C_RD_PNTR_WIDTH | 2
   //  1                | 4                | C_RD_PNTR_WIDTH | 2
   //  1                | 2                | C_RD_PNTR_WIDTH | 2
   //  1                | 1                | C_WR_PNTR_WIDTH | 2
   //  2                | 1                | C_WR_PNTR_WIDTH | 4
   //  4                | 1                | C_WR_PNTR_WIDTH | 8
   //  8                | 1                | C_WR_PNTR_WIDTH | 16
   
   localparam C_PNTR_WIDTH  = (C_WR_PNTR_WIDTH>=C_RD_PNTR_WIDTH) ? C_WR_PNTR_WIDTH : C_RD_PNTR_WIDTH;
   wire [C_PNTR_WIDTH:0] EXTRA_WORDS_DC = (C_DEPTH_RATIO_WR == 1) ? 2 : (2 * C_DEPTH_RATIO_WR/C_DEPTH_RATIO_RD);

   localparam [31:0] reads_per_write = C_DIN_WIDTH/C_DOUT_WIDTH;
   
   localparam [31:0] log2_reads_per_write = `LOG2VAL(reads_per_write);
   
   localparam [31:0] writes_per_read = C_DOUT_WIDTH/C_DIN_WIDTH;
   
   localparam [31:0] log2_writes_per_read = `LOG2VAL(writes_per_read);



   /**************************************************************************
    * FIFO Contents Tracking and Data Count Calculations
    *************************************************************************/
   
   // Memory which will be used to simulate a FIFO
   reg [C_DIN_WIDTH-1:0] memory[C_WR_DEPTH-1:0];
   // Local parameters used to determine whether to inject ECC error or not
   localparam SYMMETRIC_PORT = (C_DIN_WIDTH == C_DOUT_WIDTH) ? 1 : 0;
   localparam ERR_INJECTION = (C_ERROR_INJECTION_TYPE != 0) ? 1 : 0;
   localparam ENABLE_ERR_INJECTION = C_USE_ECC && SYMMETRIC_PORT && ERR_INJECTION;
   // Array that holds the error injection type (single/double bit error) on 
   // a specific write operation, which is returned on read to corrupt the
   // output data.
   reg [1:0] ecc_err[C_WR_DEPTH-1:0];

   //The amount of data stored in the FIFO at any time is given
   // by num_wr_bits (in the WR_CLK domain) and num_rd_bits (in the RD_CLK
   // domain.
   //num_wr_bits is calculated by considering the total words in the FIFO,
   // and the state of the read pointer (which may not have yet crossed clock
   // domains.)
   //num_rd_bits is calculated by considering the total words in the FIFO,
   // and the state of the write pointer (which may not have yet crossed clock
   // domains.)
   reg [31:0]  num_wr_bits;
   reg [31:0]  num_rd_bits;
   reg [31:0]  next_num_wr_bits;
   reg [31:0]  next_num_rd_bits;

   //The write pointer - tracks write operations
   // (Works opposite to core: wr_ptr is a DOWN counter)
   reg  [31:0]                 wr_ptr;
   reg  [C_WR_PNTR_WIDTH-1:0]  wr_pntr = 0; // UP counter: Rolls back to 0 when reaches to max value.
   reg  [C_WR_PNTR_WIDTH-1:0]  wr_pntr_rd1    = 0;
   reg  [C_WR_PNTR_WIDTH-1:0]  wr_pntr_rd2    = 0;
   reg  [C_WR_PNTR_WIDTH-1:0]  wr_pntr_rd3    = 0;
   wire [C_RD_PNTR_WIDTH-1:0]  adj_wr_pntr_rd;
   reg  [C_WR_PNTR_WIDTH-1:0]  wr_pntr_rd     = 0;
   wire                        wr_rst_i = WR_RST;   
   reg                         wr_rst_d1      =0;

   //The read pointer - tracks read operations
   // (rd_ptr Works opposite to core: rd_ptr is a DOWN counter)
   reg  [31:0]                 rd_ptr;
   reg  [C_RD_PNTR_WIDTH-1:0]  rd_pntr = 0; // UP counter: Rolls back to 0 when reaches to max value.
   reg  [C_RD_PNTR_WIDTH-1:0]  rd_pntr_wr1 = 0;
   reg  [C_RD_PNTR_WIDTH-1:0]  rd_pntr_wr2 = 0;
   reg  [C_RD_PNTR_WIDTH-1:0]  rd_pntr_wr3 = 0;
   reg  [C_RD_PNTR_WIDTH-1:0]  rd_pntr_wr4 = 0;
   wire [C_WR_PNTR_WIDTH-1:0]  adj_rd_pntr_wr;
   reg  [C_RD_PNTR_WIDTH-1:0]  rd_pntr_wr  = 0;
   wire                        rd_rst_i = RD_RST;
   wire                        ram_rd_en;
   reg                         ram_rd_en_d1 = 1'b0;


   // Delayed ram_rd_en is needed only for STD Embedded register option
   generate
     if (C_PRELOAD_LATENCY == 2) begin : grd_d
       always @ (posedge RD_CLK or posedge rd_rst_i) begin
         if (rd_rst_i)
           ram_rd_en_d1 <= #`TCQ 1'b0;
         else
           ram_rd_en_d1 <= #`TCQ ram_rd_en;
       end
     end
   endgenerate

   // Write pointer adjustment based on pointers width for EMPTY/ALMOST_EMPTY generation
   generate
     if (C_RD_PNTR_WIDTH > C_WR_PNTR_WIDTH) begin : rdg // Read depth greater than write depth
       assign adj_wr_pntr_rd[C_RD_PNTR_WIDTH-1:C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH] = wr_pntr_rd;
       assign adj_wr_pntr_rd[C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH-1:0] = 0;
     end else begin : rdl // Read depth lesser than or equal to write depth
       assign adj_wr_pntr_rd = wr_pntr_rd[C_WR_PNTR_WIDTH-1:C_WR_PNTR_WIDTH-C_RD_PNTR_WIDTH];
     end
   endgenerate

   // Generate Empty and Almost Empty
  // ram_rd_en used to determine EMPTY should depend on the EMPTY.
   assign ram_rd_en        = RD_EN & !EMPTY;
   wire empty_int        = ((adj_wr_pntr_rd == rd_pntr) || (ram_rd_en && (adj_wr_pntr_rd == (rd_pntr+1'h1))));
   wire almost_empty_int = ((adj_wr_pntr_rd == (rd_pntr+1'h1)) || (ram_rd_en && (adj_wr_pntr_rd == (rd_pntr+2'h2))));

   // Register Empty and Almost Empty
   always @ (posedge RD_CLK or posedge rd_rst_i)
     begin
       if (rd_rst_i) begin
         EMPTY             <= #`TCQ 1'b1;
         ALMOST_EMPTY      <= #`TCQ 1'b1;
         rd_data_count_int <= #`TCQ {C_RD_PNTR_WIDTH-1{1'b0}};
       end else begin
         rd_data_count_int <= #`TCQ {(adj_wr_pntr_rd[C_RD_PNTR_WIDTH-1:0] - rd_pntr[C_RD_PNTR_WIDTH-1:0]), 1'b0};

         if (empty_int)
           EMPTY           <= #`TCQ 1'b1;
         else
           EMPTY           <= #`TCQ 1'b0;

         if (!EMPTY) begin
           if (almost_empty_int)
             ALMOST_EMPTY  <= #`TCQ 1'b1;
           else
             ALMOST_EMPTY  <= #`TCQ 1'b0;
         end
       end // rd_rst_i
     end // always

   // Read pointer adjustment based on pointers width for EMPTY/ALMOST_EMPTY generation
   generate
     if (C_WR_PNTR_WIDTH > C_RD_PNTR_WIDTH) begin : wdg // Write depth greater than read depth
       assign adj_rd_pntr_wr[C_WR_PNTR_WIDTH-1:C_WR_PNTR_WIDTH-C_RD_PNTR_WIDTH] = rd_pntr_wr;
       assign adj_rd_pntr_wr[C_WR_PNTR_WIDTH-C_RD_PNTR_WIDTH-1:0] = 0;
     end else begin : wdl // Write depth lesser than or equal to read depth
       assign adj_rd_pntr_wr = rd_pntr_wr[C_RD_PNTR_WIDTH-1:C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH];
     end
   endgenerate

  // Generate FULL and ALMOST_FULL
  // ram_wr_en used to determine FULL should depend on the FULL.
  wire ram_wr_en       = WR_EN & !FULL;
  wire full_int        = ((adj_rd_pntr_wr == (wr_pntr+1'h1)) || (ram_wr_en && (adj_rd_pntr_wr == (wr_pntr+2'h2))));
  wire almost_full_int = ((adj_rd_pntr_wr == (wr_pntr+2'h2)) || (ram_wr_en && (adj_rd_pntr_wr == (wr_pntr+3'h3))));

   // Register FULL and ALMOST_FULL Empty
   always @ (posedge WR_CLK or posedge RST_FULL_FF)
     begin
       if (RST_FULL_FF) begin
         FULL             <= #`TCQ C_FULL_FLAGS_RST_VAL;
         ALMOST_FULL      <= #`TCQ C_FULL_FLAGS_RST_VAL;
         wr_data_count_int <= #`TCQ {C_WR_DATA_COUNT_WIDTH-1{1'b0}};
       end else begin
         wr_data_count_int <= #`TCQ {(wr_pntr[C_WR_PNTR_WIDTH-1:0] - adj_rd_pntr_wr[C_WR_PNTR_WIDTH-1:0]), 1'b0};
         if (full_int) begin
           FULL           <= #`TCQ 1'b1;
         end else begin
           FULL           <= #`TCQ 1'b0;
         end

         if (RST_FULL_GEN) begin
           ALMOST_FULL    <= #`TCQ 1'b0;
         end else if (!FULL) begin
           if (almost_full_int)
             ALMOST_FULL  <= #`TCQ 1'b1;
           else
             ALMOST_FULL  <= #`TCQ 1'b0;
         end
       end // wr_rst_i
     end // always

   // Determine which stage in FWFT registers are valid
   reg stage1_valid = 0;
   reg stage2_valid = 0;
   generate
     if (C_PRELOAD_LATENCY == 0) begin : grd_fwft_proc
       always @ (posedge RD_CLK or posedge rd_rst_i) begin
         if (rd_rst_i) begin
           stage1_valid     <= #`TCQ 0;
           stage2_valid     <= #`TCQ 0;
         end else begin

           if (!stage1_valid && !stage2_valid) begin
             if (!EMPTY)
               stage1_valid    <= #`TCQ 1'b1;
             else
               stage1_valid    <= #`TCQ 1'b0;
           end else if (stage1_valid && !stage2_valid) begin
             if (EMPTY) begin
               stage1_valid    <= #`TCQ 1'b0;
               stage2_valid    <= #`TCQ 1'b1;
             end else begin
               stage1_valid    <= #`TCQ 1'b1;
               stage2_valid    <= #`TCQ 1'b1;
             end
           end else if (!stage1_valid && stage2_valid) begin
             if (EMPTY && RD_EN_USER) begin
               stage1_valid    <= #`TCQ 1'b0;
               stage2_valid    <= #`TCQ 1'b0;
             end else if (!EMPTY && RD_EN_USER) begin
               stage1_valid    <= #`TCQ 1'b1;
               stage2_valid    <= #`TCQ 1'b0;
             end else if (!EMPTY && !RD_EN_USER) begin
               stage1_valid    <= #`TCQ 1'b1;
               stage2_valid    <= #`TCQ 1'b1;
             end else begin
               stage1_valid    <= #`TCQ 1'b0;
               stage2_valid    <= #`TCQ 1'b1;
             end
           end else if (stage1_valid && stage2_valid) begin
             if (EMPTY && RD_EN_USER) begin
               stage1_valid    <= #`TCQ 1'b0;
               stage2_valid    <= #`TCQ 1'b1;
             end else begin
               stage1_valid    <= #`TCQ 1'b1;
               stage2_valid    <= #`TCQ 1'b1;
             end
           end else begin
             stage1_valid    <= #`TCQ 1'b0;
             stage2_valid    <= #`TCQ 1'b0;
           end
         end // rd_rst_i
       end // always
     end
   endgenerate

   //Pointers passed into opposite clock domain
   reg [31:0]  wr_ptr_rdclk;
   reg [31:0]  wr_ptr_rdclk_next;
   reg [31:0]  rd_ptr_wrclk;
   reg [31:0]  rd_ptr_wrclk_next;

   //Amount of data stored in the FIFO scaled to the narrowest (deepest) port
   // (Do not include data in FWFT stages)
   //Used to calculate PROG_EMPTY.
   wire [31:0] num_read_words_pe = 
     num_rd_bits/(C_DOUT_WIDTH/C_DEPTH_RATIO_WR);

   //Amount of data stored in the FIFO scaled to the narrowest (deepest) port
   // (Do not include data in FWFT stages)
   //Used to calculate PROG_FULL.
   wire [31:0] num_write_words_pf =
     num_wr_bits/(C_DIN_WIDTH/C_DEPTH_RATIO_RD);

   /**************************
    * Read Data Count
    *************************/

   reg [31:0] num_read_words_dc;
   reg [C_RD_DATA_COUNT_WIDTH-1:0] num_read_words_sized_i;
   
   always @(num_rd_bits) begin
     if (C_USE_FWFT_DATA_COUNT) begin
        
        //If using extra logic for FWFT Data Counts, 
        // then scale FIFO contents to read domain, 
        // and add two read words for FWFT stages
        //This value is only a temporary value and not used in the code.
        num_read_words_dc = (num_rd_bits/C_DOUT_WIDTH+2);
        
        //Trim the read words for use with RD_DATA_COUNT
        num_read_words_sized_i = 
          num_read_words_dc[C_RD_PNTR_WIDTH : C_RD_PNTR_WIDTH-C_RD_DATA_COUNT_WIDTH+1];
        
     end else begin
        
        //If not using extra logic for FWFT Data Counts, 
        // then scale FIFO contents to read domain.
        //This value is only a temporary value and not used in the code.
        num_read_words_dc = num_rd_bits/C_DOUT_WIDTH;
        
        //Trim the read words for use with RD_DATA_COUNT
        num_read_words_sized_i = 
          num_read_words_dc[C_RD_PNTR_WIDTH-1 : C_RD_PNTR_WIDTH-C_RD_DATA_COUNT_WIDTH];
        
     end //if (C_USE_FWFT_DATA_COUNT)
   end //always

   
   /**************************
    * Write Data Count
    *************************/

   reg [31:0] num_write_words_dc;
   reg [C_WR_DATA_COUNT_WIDTH-1:0] num_write_words_sized_i;
   
   always @(num_wr_bits) begin
     if (C_USE_FWFT_DATA_COUNT) begin
        
        //Calculate the Data Count value for the number of write words, 
        // when using First-Word Fall-Through with extra logic for Data 
        // Counts. This takes into consideration the number of words that 
        // are expected to be stored in the FWFT register stages (it always 
        // assumes they are filled).
        //This value is scaled to the Write Domain.
        //The expression (((A-1)/B))+1 divides A/B, but takes the 
        // ceiling of the result.
        //When num_wr_bits==0, set the result manually to prevent 
        // division errors.
        //EXTRA_WORDS_DC is the number of words added to write_words 
        // due to FWFT.
        //This value is only a temporary value and not used in the code.
        num_write_words_dc = (num_wr_bits==0) ? EXTRA_WORDS_DC :  (((num_wr_bits-1)/C_DIN_WIDTH)+1) + EXTRA_WORDS_DC ;
        
        //Trim the write words for use with WR_DATA_COUNT
        num_write_words_sized_i = 
          num_write_words_dc[C_WR_PNTR_WIDTH : C_WR_PNTR_WIDTH-C_WR_DATA_COUNT_WIDTH+1];
        
     end else begin
        
        //Calculate the Data Count value for the number of write words, when NOT
        // using First-Word Fall-Through with extra logic for Data Counts. This 
        // calculates only the number of words in the internal FIFO.
        //The expression (((A-1)/B))+1 divides A/B, but takes the 
        // ceiling of the result.
        //This value is scaled to the Write Domain.
        //When num_wr_bits==0, set the result manually to prevent 
        // division errors.
        //This value is only a temporary value and not used in the code.
        num_write_words_dc = (num_wr_bits==0) ? 0 : ((num_wr_bits-1)/C_DIN_WIDTH)+1;
        
        //Trim the read words for use with RD_DATA_COUNT
        num_write_words_sized_i = 
          num_write_words_dc[C_WR_PNTR_WIDTH-1 : C_WR_PNTR_WIDTH-C_WR_DATA_COUNT_WIDTH];
        
     end //if (C_USE_FWFT_DATA_COUNT)
   end //always

    
    
   /***************************************************************************
    * Internal registers and wires
    **************************************************************************/

   //Temporary signals used for calculating the model's outputs. These
   //are only used in the assign statements immediately following wire,
   //parameter, and function declarations.
   wire [C_DOUT_WIDTH-1:0] ideal_dout_out;      
   wire valid_i;
   wire valid_out;  
   wire underflow_i;

   //Ideal FIFO signals. These are the raw output of the behavioral model,
   //which behaves like an ideal FIFO.
   reg [1:0]               err_type                 = 0;
   reg [1:0]               err_type_d1              = 0;
   reg [C_DOUT_WIDTH-1:0]  ideal_dout               = 0;
   reg [C_DOUT_WIDTH-1:0]  ideal_dout_d1            = 0;
   reg                     ideal_wr_ack             = 0;
   reg                     ideal_valid              = 0;
   reg                     ideal_overflow           = 0;
   reg                     ideal_underflow          = 0;
   reg                     ideal_prog_full          = 0;
   reg                     ideal_prog_empty         = 1;
   reg [C_WR_DATA_COUNT_WIDTH-1 : 0] ideal_wr_count = 0;
   reg [C_RD_DATA_COUNT_WIDTH-1 : 0] ideal_rd_count = 0;

   //Assorted reg values for delayed versions of signals   
   reg         valid_d1     = 0;
   
   
   //user specified value for reseting the size of the fifo
   reg [C_DOUT_WIDTH-1:0]            dout_reset_val = 0;
   
   //temporary registers for WR_RESPONSE_LATENCY feature
   
   integer                           tmp_wr_listsize;
   integer                           tmp_rd_listsize;
   
   //Signal for registered version of prog full and empty
   
   //Threshold values for Programmable Flags
   integer                           prog_empty_actual_thresh_assert;
   integer                           prog_empty_actual_thresh_negate;
   integer                           prog_full_actual_thresh_assert;
   integer                           prog_full_actual_thresh_negate;
   

  /****************************************************************************
   * Function Declarations
   ***************************************************************************/

  /**************************************************************************
   * write_fifo
   *   This task writes a word to the FIFO memory and updates the 
   * write pointer.
   *   FIFO size is relative to write domain.
  ***************************************************************************/
  task write_fifo;
    begin
      memory[wr_ptr]     <= DIN;
      wr_pntr <= #`TCQ wr_pntr + 1;
      // Store the type of error injection (double/single) on write
      case (C_ERROR_INJECTION_TYPE)
        3:       ecc_err[wr_ptr]    <= {INJECTDBITERR,INJECTSBITERR};
        2:       ecc_err[wr_ptr]    <= {INJECTDBITERR,1'b0};
        1:       ecc_err[wr_ptr]    <= {1'b0,INJECTSBITERR};
        default: ecc_err[wr_ptr]    <= 0;
      endcase
      // (Works opposite to core: wr_ptr is a DOWN counter)
      if (wr_ptr == 0) begin
        wr_ptr          <= C_WR_DEPTH - 1;
      end else begin
        wr_ptr          <= wr_ptr - 1;
      end
    end
  endtask // write_fifo

  /**************************************************************************
   * read_fifo
   *   This task reads a word from the FIFO memory and updates the read 
   * pointer. It's output is the ideal_dout bus.
   *   FIFO size is relative to write domain.
   ***************************************************************************/
  task read_fifo;
    integer i;
    reg [C_DOUT_WIDTH-1:0]      tmp_dout;
    reg [C_DIN_WIDTH-1:0]       memory_read;
    reg [31:0]                  tmp_rd_ptr;
    reg [31:0]                  rd_ptr_high;
    reg [31:0]                  rd_ptr_low;
    reg [1:0]                   tmp_ecc_err;
    begin
      rd_pntr <= #`TCQ rd_pntr + 1;
      // output is wider than input
      if (reads_per_write == 0) begin
        tmp_dout = 0;
        tmp_rd_ptr = (rd_ptr << log2_writes_per_read)+(writes_per_read-1);
        for (i = writes_per_read - 1; i >= 0; i = i - 1) begin
          tmp_dout = tmp_dout << C_DIN_WIDTH;
          tmp_dout = tmp_dout | memory[tmp_rd_ptr];
           
          // (Works opposite to core: rd_ptr is a DOWN counter)
          if (tmp_rd_ptr == 0) begin
            tmp_rd_ptr = C_WR_DEPTH - 1;
          end else begin
            tmp_rd_ptr = tmp_rd_ptr - 1;
          end
        end

      // output is symmetric
      end else if (reads_per_write == 1) begin
        tmp_dout = memory[rd_ptr][C_DIN_WIDTH-1:0];
        // Retreive the error injection type. Based on the error injection type
        // corrupt the output data.
        tmp_ecc_err = ecc_err[rd_ptr];
        if (ENABLE_ERR_INJECTION && C_DIN_WIDTH == C_DOUT_WIDTH) begin
          if (tmp_ecc_err[1]) begin // Corrupt the output data only for double bit error
            if (C_DOUT_WIDTH == 1)
              tmp_dout = tmp_dout[C_DOUT_WIDTH-1:0];
            else if (C_DOUT_WIDTH == 2)
              tmp_dout = {~tmp_dout[C_DOUT_WIDTH-1],~tmp_dout[C_DOUT_WIDTH-2]};
            else
              tmp_dout = {~tmp_dout[C_DOUT_WIDTH-1],~tmp_dout[C_DOUT_WIDTH-2],(tmp_dout << 2)};
          end else begin
            tmp_dout = tmp_dout[C_DOUT_WIDTH-1:0];
          end
          err_type <= {tmp_ecc_err[1], tmp_ecc_err[0] & !tmp_ecc_err[1]};
        end else begin
          err_type <= 0;
        end

      // input is wider than output
      end else begin
        rd_ptr_high = rd_ptr >> log2_reads_per_write;
        rd_ptr_low  = rd_ptr & (reads_per_write - 1);
        memory_read = memory[rd_ptr_high];
        tmp_dout    = memory_read >> (rd_ptr_low*C_DOUT_WIDTH);
      end
      ideal_dout <= tmp_dout;
       
      // (Works opposite to core: rd_ptr is a DOWN counter)
      if (rd_ptr == 0) begin
        rd_ptr <= C_RD_DEPTH - 1;
      end else begin
        rd_ptr <= rd_ptr - 1;
      end
    end
  endtask

  /***********************************************************************
  * hexstr_conv
  *   Converts a string of type hex to a binary value (for C_DOUT_RST_VAL)
  ***********************************************************************/
  function [C_DOUT_WIDTH-1:0] hexstr_conv;
    input [(C_DOUT_WIDTH*8)-1:0] def_data;

    integer index,i,j;
    reg [3:0] bin;

    begin
      index = 0;
      hexstr_conv = 'b0;
      for( i=C_DOUT_WIDTH-1; i>=0; i=i-1 )
      begin
        case (def_data[7:0])
          8'b00000000 :
          begin
            bin = 4'b0000;
            i = -1;
          end
          8'b00110000 : bin = 4'b0000;
          8'b00110001 : bin = 4'b0001;
          8'b00110010 : bin = 4'b0010;
          8'b00110011 : bin = 4'b0011;
          8'b00110100 : bin = 4'b0100;
          8'b00110101 : bin = 4'b0101;
          8'b00110110 : bin = 4'b0110;
          8'b00110111 : bin = 4'b0111;
          8'b00111000 : bin = 4'b1000;
          8'b00111001 : bin = 4'b1001;
          8'b01000001 : bin = 4'b1010;
          8'b01000010 : bin = 4'b1011;
          8'b01000011 : bin = 4'b1100;
          8'b01000100 : bin = 4'b1101;
          8'b01000101 : bin = 4'b1110;
          8'b01000110 : bin = 4'b1111;
          8'b01100001 : bin = 4'b1010;
          8'b01100010 : bin = 4'b1011;
          8'b01100011 : bin = 4'b1100;
          8'b01100100 : bin = 4'b1101;
          8'b01100101 : bin = 4'b1110;
          8'b01100110 : bin = 4'b1111;
          default :
          begin
            bin = 4'bx;
          end
        endcase
        for( j=0; j<4; j=j+1)
        begin
          if ((index*4)+j < C_DOUT_WIDTH)
          begin
            hexstr_conv[(index*4)+j] = bin[j];
          end
        end
        index = index + 1;
        def_data = def_data >> 8;
      end
    end
  endfunction

  /*************************************************************************
  * Initialize Signals for clean power-on simulation
  *************************************************************************/
   initial begin
      num_wr_bits        = 0;
      num_rd_bits        = 0;
      next_num_wr_bits   = 0;
      next_num_rd_bits   = 0;
      rd_ptr             = C_RD_DEPTH - 1;
      wr_ptr             = C_WR_DEPTH - 1;
      wr_pntr            = 0;
      rd_pntr            = 0;
      rd_ptr_wrclk       = rd_ptr;
      wr_ptr_rdclk       = wr_ptr;
      dout_reset_val     = hexstr_conv(C_DOUT_RST_VAL);
      ideal_dout         = dout_reset_val;
      err_type           = 0;
      ideal_dout_d1      = dout_reset_val;
      ideal_wr_ack       = 1'b0;
      ideal_valid        = 1'b0;
      valid_d1           = 1'b0;
      ideal_overflow     = 1'b0;
      ideal_underflow    = 1'b0;
      ideal_wr_count     = 0;
      ideal_rd_count     = 0;
      ideal_prog_full    = 1'b0;
      ideal_prog_empty   = 1'b1;
    end


  /*************************************************************************
   * Connect the module inputs and outputs to the internal signals of the 
   * behavioral model.
   *************************************************************************/
   //Inputs
   /*
    wire [C_DIN_WIDTH-1:0] DIN;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH_ASSERT;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH_NEGATE;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH_ASSERT;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH_NEGATE;   
   wire RD_CLK;
   wire RD_EN;
   wire RST;
   wire WR_CLK;
   wire WR_EN;
    */

   //***************************************************************************
   // Dout may change behavior based on latency
   //***************************************************************************
   assign ideal_dout_out[C_DOUT_WIDTH-1:0] = (C_PRELOAD_LATENCY==2 &&
                          (C_MEMORY_TYPE==0 || C_MEMORY_TYPE==1))?
                         ideal_dout_d1: ideal_dout;   
   assign DOUT[C_DOUT_WIDTH-1:0] = ideal_dout_out; 

   //***************************************************************************
   // Assign SBITERR and DBITERR based on latency 
   //***************************************************************************
   assign SBITERR = (C_ERROR_INJECTION_TYPE == 1 || C_ERROR_INJECTION_TYPE == 3) && 
                    (C_PRELOAD_LATENCY == 2 &&
                    (C_MEMORY_TYPE==0 || C_MEMORY_TYPE==1)) ?
                    err_type_d1[0]: err_type[0]; 
   assign DBITERR = (C_ERROR_INJECTION_TYPE == 2 || C_ERROR_INJECTION_TYPE == 3) &&
                    (C_PRELOAD_LATENCY==2 && (C_MEMORY_TYPE==0 || C_MEMORY_TYPE==1)) ?
                    err_type_d1[1]: err_type[1]; 
  

   //***************************************************************************
   // Overflow may be active-low
   //***************************************************************************
   generate
      if (C_HAS_OVERFLOW==1) begin : blockOF1
   assign OVERFLOW = ideal_overflow ? !C_OVERFLOW_LOW : C_OVERFLOW_LOW;
      end
   endgenerate

   assign PROG_EMPTY = ideal_prog_empty;
   assign PROG_FULL  = ideal_prog_full;

   //***************************************************************************
   // Valid may change behavior based on latency or active-low
   //***************************************************************************
   generate
      if (C_HAS_VALID==1) begin : blockVL1
   assign valid_i   = (C_PRELOAD_LATENCY==0) ? (RD_EN & ~EMPTY) : ideal_valid;
   assign valid_out = (C_PRELOAD_LATENCY==2 &&
                       (C_MEMORY_TYPE==0 || C_MEMORY_TYPE==1))?
                       valid_d1: valid_i;  
   assign VALID     = valid_out ? !C_VALID_LOW : C_VALID_LOW;
     end
   endgenerate


   //***************************************************************************
   // Underflow may change behavior based on latency or active-low   
   //***************************************************************************
   generate
      if (C_HAS_UNDERFLOW==1) begin : blockUF1
   assign underflow_i = (C_PRELOAD_LATENCY==0) ? (RD_EN & EMPTY) : ideal_underflow;
   assign UNDERFLOW   = underflow_i ? !C_UNDERFLOW_LOW : C_UNDERFLOW_LOW;
    end
   endgenerate

   //***************************************************************************
   // Write acknowledge may be active low
   //***************************************************************************
   generate
      if (C_HAS_WR_ACK==1) begin : blockWK1
   assign WR_ACK = ideal_wr_ack ? !C_WR_ACK_LOW : C_WR_ACK_LOW;
     end
   endgenerate


   //***************************************************************************
   // Generate RD_DATA_COUNT if Use Extra Logic option is selected
   //***************************************************************************
   generate
      if (C_HAS_WR_DATA_COUNT == 1 && C_USE_FWFT_DATA_COUNT == 1) begin : wdc_fwft_ext

      reg  [C_PNTR_WIDTH-1:0]  adjusted_wr_pntr = 0;
      reg  [C_PNTR_WIDTH-1:0]  adjusted_rd_pntr = 0;
      wire [C_PNTR_WIDTH-1:0]  diff_wr_rd_tmp;
      wire [C_PNTR_WIDTH:0]    diff_wr_rd;
      reg  [C_PNTR_WIDTH:0]    wr_data_count_i  = 0;
        always @* begin
          if (C_WR_PNTR_WIDTH > C_RD_PNTR_WIDTH) begin
            adjusted_wr_pntr = wr_pntr;
            adjusted_rd_pntr = 0;
            adjusted_rd_pntr[C_PNTR_WIDTH-1:C_PNTR_WIDTH-C_RD_PNTR_WIDTH] = rd_pntr_wr;
          end else if (C_WR_PNTR_WIDTH < C_RD_PNTR_WIDTH) begin
            adjusted_rd_pntr = rd_pntr_wr;
            adjusted_wr_pntr = 0;
            adjusted_wr_pntr[C_PNTR_WIDTH-1:C_PNTR_WIDTH-C_WR_PNTR_WIDTH] = wr_pntr;
          end else begin
            adjusted_wr_pntr = wr_pntr;
            adjusted_rd_pntr = rd_pntr_wr;
          end
        end // always @*

        assign diff_wr_rd_tmp = adjusted_wr_pntr - adjusted_rd_pntr;
        assign diff_wr_rd     = {1'b0,diff_wr_rd_tmp};

        always @ (posedge wr_rst_i or posedge WR_CLK)
        begin
            if (wr_rst_i)
              wr_data_count_i <= #`TCQ 0;
            else
              wr_data_count_i <= #`TCQ diff_wr_rd + EXTRA_WORDS_DC;
        end // always @ (posedge WR_CLK or posedge WR_CLK)

        always @* begin
          if (C_WR_PNTR_WIDTH >= C_RD_PNTR_WIDTH)
            wdc_fwft_ext_as = wr_data_count_i[C_PNTR_WIDTH:0];
          else
            wdc_fwft_ext_as = wr_data_count_i[C_PNTR_WIDTH:C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH];
        end // always @*
      end // wdc_fwft_ext
   endgenerate

   //***************************************************************************
   // Generate RD_DATA_COUNT if Use Extra Logic option is selected
   //***************************************************************************
   reg  [C_RD_PNTR_WIDTH:0]    rdc_fwft_ext_as  = 0;

   generate
      if (C_HAS_RD_DATA_COUNT == 1 && C_USE_FWFT_DATA_COUNT == 1) begin : rdc_fwft_ext
      reg  [C_RD_PNTR_WIDTH-1:0]  adjusted_wr_pntr_rd = 0;
      wire [C_RD_PNTR_WIDTH-1:0]  diff_rd_wr_tmp;
      wire [C_RD_PNTR_WIDTH:0]    diff_rd_wr;
        always @* begin
          if (C_RD_PNTR_WIDTH > C_WR_PNTR_WIDTH) begin
            adjusted_wr_pntr_rd = 0;
            adjusted_wr_pntr_rd[C_RD_PNTR_WIDTH-1:C_RD_PNTR_WIDTH-C_WR_PNTR_WIDTH] = wr_pntr_rd;
          end else begin
            adjusted_wr_pntr_rd = wr_pntr_rd[C_WR_PNTR_WIDTH-1:C_WR_PNTR_WIDTH-C_RD_PNTR_WIDTH];
          end
        end // always @*

        assign diff_rd_wr_tmp = adjusted_wr_pntr_rd - rd_pntr;
        assign diff_rd_wr     = {1'b0,diff_rd_wr_tmp};

        always @ (posedge rd_rst_i or posedge RD_CLK)
        begin
            if (rd_rst_i) begin
              rdc_fwft_ext_as   <= #`TCQ 0;
            end else begin
              if (!stage2_valid)
                rdc_fwft_ext_as <= #`TCQ 0;
              else if (!stage1_valid && stage2_valid)
                rdc_fwft_ext_as <= #`TCQ 1;
              else
                rdc_fwft_ext_as <= #`TCQ diff_rd_wr + 2'h2;
            end 
        end // always @ (posedge WR_CLK or posedge WR_CLK)
      end // rdc_fwft_ext
   endgenerate

   //***************************************************************************
   // Assign the read data count value only if it is selected, 
   // otherwise output zeros.
   //***************************************************************************
   generate
      if (C_HAS_RD_DATA_COUNT == 1) begin : grdc
   assign RD_DATA_COUNT[C_RD_DATA_COUNT_WIDTH-1:0] = C_USE_FWFT_DATA_COUNT ?
          rdc_fwft_ext_as[C_RD_PNTR_WIDTH:C_RD_PNTR_WIDTH+1-C_RD_DATA_COUNT_WIDTH] :
          rd_data_count_int[C_RD_PNTR_WIDTH:C_RD_PNTR_WIDTH+1-C_RD_DATA_COUNT_WIDTH];
      end
   endgenerate

   generate
      if (C_HAS_RD_DATA_COUNT == 0) begin : gnrdc
   assign RD_DATA_COUNT[C_RD_DATA_COUNT_WIDTH-1:0] = {C_RD_DATA_COUNT_WIDTH-1{1'b0}};
      end
   endgenerate

   //***************************************************************************
   // Assign the write data count value only if it is selected, 
   // otherwise output zeros
   //***************************************************************************
   generate
      if (C_HAS_WR_DATA_COUNT == 1) begin : gwdc
   assign WR_DATA_COUNT[C_WR_DATA_COUNT_WIDTH-1:0] = (C_USE_FWFT_DATA_COUNT == 1) ?
          wdc_fwft_ext_as[C_WR_PNTR_WIDTH:C_WR_PNTR_WIDTH+1-C_WR_DATA_COUNT_WIDTH] :
          wr_data_count_int[C_WR_PNTR_WIDTH:C_WR_PNTR_WIDTH+1-C_WR_DATA_COUNT_WIDTH];
      end
   endgenerate
   
   generate
      if (C_HAS_WR_DATA_COUNT == 0) begin : gnwdc
   assign WR_DATA_COUNT[C_WR_DATA_COUNT_WIDTH-1:0] = {C_WR_DATA_COUNT_WIDTH-1{1'b0}};
      end
   endgenerate


  /**************************************************************************
  * Assorted registers for delayed versions of signals
  **************************************************************************/
  //Capture delayed version of valid
  generate
      if (C_HAS_VALID==1) begin : blockVL2
  always @(posedge RD_CLK or posedge rd_rst_i) begin
    if (rd_rst_i == 1'b1) begin
      valid_d1 <= #`TCQ 1'b0;
    end else begin
      valid_d1 <= #`TCQ valid_i;
    end    
  end 
      end
 endgenerate  
   
  //Capture delayed version of dout
  always @(posedge RD_CLK or posedge rd_rst_i) begin
    if (rd_rst_i == 1'b1) begin
      // Reset err_type only if ECC is not selected
      if (C_USE_ECC == 0)
        err_type_d1     <= #`TCQ 0;
    end else if (ram_rd_en_d1) begin
      ideal_dout_d1   <= #`TCQ ideal_dout;
      err_type_d1     <= #`TCQ err_type;
    end    
  end   
  
   /**************************************************************************
    * Overflow and Underflow Flag calculation
    *  (handled separately because they don't support rst)
    **************************************************************************/
   generate
      if (C_HAS_OVERFLOW==1) begin : blockOF2
   always @(posedge WR_CLK) begin
     ideal_overflow    <= #`TCQ WR_EN & FULL;
   end
      end
   endgenerate

   generate
      if (C_HAS_UNDERFLOW==1) begin : blockUF2
   always @(posedge RD_CLK) begin
     ideal_underflow    <= #`TCQ EMPTY & RD_EN;
   end
      end
   endgenerate

   /**************************************************************************
   * Write Domain Logic
   **************************************************************************/
   reg [C_WR_PNTR_WIDTH-1:0] diff_pntr = 0;
   always @(posedge WR_CLK or posedge wr_rst_i) begin : gen_fifo_w

     /****** Reset fifo (case 1)***************************************/
     if (wr_rst_i == 1'b1) begin
       num_wr_bits       <= #`TCQ 0;
       next_num_wr_bits   = #`TCQ 0;
       wr_ptr            <= #`TCQ C_WR_DEPTH - 1;
       rd_ptr_wrclk      <= #`TCQ C_RD_DEPTH - 1;
       ideal_wr_ack      <= #`TCQ 0;
       ideal_wr_count    <= #`TCQ 0;
       tmp_wr_listsize    = #`TCQ 0;
       rd_ptr_wrclk_next <= #`TCQ 0;
       wr_pntr           <= #`TCQ 0;
       wr_pntr_rd1        <= #`TCQ 0;
       rd_pntr_wr2       <= #`TCQ 0;
       rd_pntr_wr3       <= #`TCQ 0;
       rd_pntr_wr4       <= #`TCQ 0;
       rd_pntr_wr        <= #`TCQ 0;


     end else begin //wr_rst_i==0

      wr_pntr_rd1   <= #`TCQ wr_pntr;

      // Synchronize the rd_pntr in read domain
      rd_pntr_wr2   <= #`TCQ rd_pntr_wr1;
      rd_pntr_wr3   <= #`TCQ rd_pntr_wr2;
      rd_pntr_wr4   <= #`TCQ rd_pntr_wr2;
      rd_pntr_wr    <= #`TCQ rd_pntr_wr4;



       //Determine the current number of words in the FIFO
       tmp_wr_listsize = (C_DEPTH_RATIO_RD > 1) ? num_wr_bits/C_DOUT_WIDTH :
                         num_wr_bits/C_DIN_WIDTH;
       rd_ptr_wrclk_next = rd_ptr;
       if (rd_ptr_wrclk < rd_ptr_wrclk_next) begin
         next_num_wr_bits = num_wr_bits -
                            C_DOUT_WIDTH*(rd_ptr_wrclk + C_RD_DEPTH
                                          - rd_ptr_wrclk_next);
       end else begin
         next_num_wr_bits = num_wr_bits -
                            C_DOUT_WIDTH*(rd_ptr_wrclk - rd_ptr_wrclk_next);
       end

       //If this is a write, handle the write by adding the value
       // to the linked list, and updating all outputs appropriately
       if (WR_EN == 1'b1) begin
         if (FULL == 1'b1) begin

           //If the FIFO is full, do NOT perform the write,
           // update flags accordingly
           if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD 
             >= C_FIFO_WR_DEPTH) begin
             //write unsuccessful - do not change contents

             //Do not acknowledge the write
             ideal_wr_ack      <= #`TCQ 0;
             //Reminder that FIFO is still full

             ideal_wr_count    <= #`TCQ num_write_words_sized_i;

           //If the FIFO is one from full, but reporting full
           end else 
             if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD ==
                C_FIFO_WR_DEPTH-1) begin
             //No change to FIFO

             //Write not successful
             ideal_wr_ack      <= #`TCQ 0;
             //With DEPTH-1 words in the FIFO, it is almost_full

             ideal_wr_count    <= #`TCQ num_write_words_sized_i;


           //If the FIFO is completely empty, but it is
           // reporting FULL for some reason (like reset)
           end else 
             if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD <=
                C_FIFO_WR_DEPTH-2) begin
             //No change to FIFO

             //Write not successful
             ideal_wr_ack      <= #`TCQ 0;
             //FIFO is really not close to full, so change flag status.

             ideal_wr_count    <= #`TCQ num_write_words_sized_i;
           end //(tmp_wr_listsize == 0)

         end else begin

           //If the FIFO is full, do NOT perform the write,
           // update flags accordingly
           if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD >=
              C_FIFO_WR_DEPTH) begin
             //write unsuccessful - do not change contents

             //Do not acknowledge the write
             ideal_wr_ack       <= #`TCQ 0;
             //Reminder that FIFO is still full

             ideal_wr_count     <= #`TCQ num_write_words_sized_i;

           //If the FIFO is one from full
           end else 
             if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD ==
                C_FIFO_WR_DEPTH-1) begin
             //Add value on DIN port to FIFO
             write_fifo;
             next_num_wr_bits = next_num_wr_bits + C_DIN_WIDTH;

             //Write successful, so issue acknowledge
             // and no error
             ideal_wr_ack      <= #`TCQ 1;
             //This write is CAUSING the FIFO to go full

             ideal_wr_count    <= #`TCQ num_write_words_sized_i;

           //If the FIFO is 2 from full
           end else 
             if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD == 
                C_FIFO_WR_DEPTH-2) begin
             //Add value on DIN port to FIFO
             write_fifo;
             next_num_wr_bits =  next_num_wr_bits + C_DIN_WIDTH;
             //Write successful, so issue acknowledge
             // and no error
             ideal_wr_ack      <= #`TCQ 1;
             //Still 2 from full

             ideal_wr_count    <= #`TCQ num_write_words_sized_i;

           //If the FIFO is not close to being full
           end else 
             if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD <
                C_FIFO_WR_DEPTH-2) begin
             //Add value on DIN port to FIFO
             write_fifo;
             next_num_wr_bits  = next_num_wr_bits + C_DIN_WIDTH;
             //Write successful, so issue acknowledge
             // and no error
             ideal_wr_ack      <= #`TCQ 1;
             //Not even close to full.

             ideal_wr_count    <= num_write_words_sized_i;

           end

         end

       end else begin //(WR_EN == 1'b1)

         //If user did not attempt a write, then do not
         // give ack or err
         ideal_wr_ack   <= #`TCQ 0;
         ideal_wr_count <= #`TCQ num_write_words_sized_i;
       end
       num_wr_bits       <= #`TCQ next_num_wr_bits;
       rd_ptr_wrclk      <= #`TCQ rd_ptr;

     end //wr_rst_i==0
   end // write always


  /***************************************************************************
   * Programmable FULL flags
   ***************************************************************************/

   reg [C_WR_PNTR_WIDTH-1:0] pf_thr_assert_val = 0;
   reg [C_WR_PNTR_WIDTH-1:0] pf_thr_negate_val = 0;

   always @(posedge WR_CLK or posedge RST_FULL_FF) begin : gen_pf

     if (RST_FULL_FF == 1'b1) begin
       diff_pntr         <= 0;
       ideal_prog_full   <= #`TCQ C_FULL_FLAGS_RST_VAL;
     end else begin
       if (ram_wr_en)
         diff_pntr <= #`TCQ (wr_pntr - adj_rd_pntr_wr + 2'h1);
       else if (!ram_wr_en)
         diff_pntr <= #`TCQ (wr_pntr - adj_rd_pntr_wr);

       if (C_PRELOAD_REGS == 1 && C_PRELOAD_LATENCY == 0) begin // FWFT
         pf_thr_assert_val <= #`TCQ C_PROG_FULL_THRESH_ASSERT_VAL - EXTRA_WORDS_DC;
         pf_thr_negate_val <= #`TCQ C_PROG_FULL_THRESH_NEGATE_VAL - EXTRA_WORDS_DC;
       end else begin
         pf_thr_assert_val <= #`TCQ C_PROG_FULL_THRESH_ASSERT_VAL;
         pf_thr_negate_val <= #`TCQ C_PROG_FULL_THRESH_NEGATE_VAL;
       end

       if (RST_FULL_GEN)
         ideal_prog_full   <= #`TCQ 0;
       //Single Programmable Full Constant Threshold
       else if (C_PROG_FULL_TYPE == 1) begin
         if (FULL == 0) begin
           if (diff_pntr >= pf_thr_assert_val)
             ideal_prog_full <= #`TCQ 1;
           else
             ideal_prog_full <= #`TCQ 0;
         end else
           ideal_prog_full   <= #`TCQ ideal_prog_full;
       //Two Programmable Full Constant Thresholds
       end else if (C_PROG_FULL_TYPE == 2) begin
         if (FULL == 0) begin
           if (diff_pntr >= pf_thr_assert_val)
             ideal_prog_full <= #`TCQ 1;
           else if (diff_pntr < pf_thr_negate_val)
             ideal_prog_full <= #`TCQ 0;
           else
             ideal_prog_full <= #`TCQ ideal_prog_full;
         end else
           ideal_prog_full   <= #`TCQ ideal_prog_full;
       //Single Programmable Full Threshold Input
       end else if (C_PROG_FULL_TYPE == 3) begin
         if (FULL == 0) begin
           if (C_PRELOAD_REGS == 1 && C_PRELOAD_LATENCY == 0) begin // FWFT
             if (diff_pntr >= (PROG_FULL_THRESH - EXTRA_WORDS_DC))
               ideal_prog_full <= #`TCQ 1;
             else
               ideal_prog_full <= #`TCQ 0;
           end else begin // STD
             if (diff_pntr >= PROG_FULL_THRESH)
               ideal_prog_full <= #`TCQ 1;
             else
               ideal_prog_full <= #`TCQ 0;
           end
         end else
           ideal_prog_full   <= #`TCQ ideal_prog_full;
       //Two Programmable Full Threshold Inputs
       end else if (C_PROG_FULL_TYPE == 4) begin
         if (FULL == 0) begin
           if (C_PRELOAD_REGS == 1 && C_PRELOAD_LATENCY == 0) begin // FWFT
             if (diff_pntr >= (PROG_FULL_THRESH_ASSERT - EXTRA_WORDS_DC))
               ideal_prog_full <= #`TCQ 1;
             else if (diff_pntr < (PROG_FULL_THRESH_NEGATE - EXTRA_WORDS_DC))
               ideal_prog_full <= #`TCQ 0;
             else
               ideal_prog_full <= #`TCQ ideal_prog_full;
           end else begin // STD
             if (diff_pntr >= PROG_FULL_THRESH_ASSERT)
               ideal_prog_full <= #`TCQ 1;
             else if (diff_pntr < PROG_FULL_THRESH_NEGATE)
               ideal_prog_full <= #`TCQ 0;
             else
               ideal_prog_full <= #`TCQ ideal_prog_full;
           end
         end else
           ideal_prog_full   <= #`TCQ ideal_prog_full;
       end // C_PROG_FULL_TYPE

     end //wr_rst_i==0
   end //

   
   /**************************************************************************
   * Read Domain Logic
   **************************************************************************/


   /*********************************************************
    * Programmable EMPTY flags
    *********************************************************/
   //Determine the Assert and Negate thresholds for Programmable Empty

   reg [C_RD_PNTR_WIDTH-1:0] pe_thr_assert_val = 0;
   reg [C_RD_PNTR_WIDTH-1:0] pe_thr_negate_val = 0;
   reg [C_RD_PNTR_WIDTH-1:0] diff_pntr_rd      = 0;
//   always @* begin
//
//     if (C_PROG_EMPTY_TYPE == 3) begin
//
//       // If empty input threshold is selected, then subtract 2 for FWFT to
//       // compensate the FWFT stage, otherwise assign the input value.
//       if (C_PRELOAD_REGS == 1 && C_PRELOAD_LATENCY == 0) // FWFT
//         pe_thr_assert_val <= PROG_EMPTY_THRESH - 2'h2;
//       else
//         pe_thr_assert_val <= PROG_EMPTY_THRESH;
//
//     end else if (C_PROG_EMPTY_TYPE == 4) begin
//
//       // If empty input threshold is selected, then subtract 2 for FWFT to
//       // compensate the FWFT stage, otherwise assign the input value.
//       if (C_PRELOAD_REGS == 1 && C_PRELOAD_LATENCY == 0) begin // FWFT
//         pe_thr_assert_val <= PROG_EMPTY_THRESH_ASSERT - 2'h2;
//         pe_thr_negate_val <= PROG_EMPTY_THRESH_NEGATE - 2'h2;
//       end else begin
//         pe_thr_assert_val <= PROG_EMPTY_THRESH_ASSERT;
//         pe_thr_negate_val <= PROG_EMPTY_THRESH_NEGATE;
//       end
//     end else begin
//
//       if (C_PRELOAD_REGS == 1 && C_PRELOAD_LATENCY == 0) begin // FWFT
//         pe_thr_assert_val <= C_PROG_EMPTY_THRESH_ASSERT_VAL - 2;
//         pe_thr_negate_val <= C_PROG_EMPTY_THRESH_NEGATE_VAL - 2;
//       end else begin
//         pe_thr_assert_val <= C_PROG_EMPTY_THRESH_ASSERT_VAL;
//         pe_thr_negate_val <= C_PROG_EMPTY_THRESH_NEGATE_VAL;
//       end
//     end
//   end // always @*

   always @(posedge RD_CLK or posedge rd_rst_i) begin : gen_pe

     if (rd_rst_i) begin
       diff_pntr_rd       <= #`TCQ 0;
       ideal_prog_empty   <= #`TCQ 1'b1;
     end else begin
       if (ram_rd_en)
         diff_pntr_rd       <=  #`TCQ (adj_wr_pntr_rd - rd_pntr) - 1'h1;
       else if (!ram_rd_en)
         diff_pntr_rd       <=  #`TCQ (adj_wr_pntr_rd - rd_pntr);
       else
         diff_pntr_rd       <=  #`TCQ diff_pntr_rd;
  
       if (C_PROG_EMPTY_TYPE == 1) begin
         if (EMPTY == 0) begin
           if (diff_pntr_rd <= pe_thr_assert_val)
             ideal_prog_empty <= #`TCQ 1;
           else
             ideal_prog_empty <= #`TCQ 0;
         end else
           ideal_prog_empty   <= #`TCQ ideal_prog_empty;
       end else if (C_PROG_EMPTY_TYPE == 2) begin
         if (EMPTY == 0) begin
           if (diff_pntr_rd <= pe_thr_assert_val)
             ideal_prog_empty <= #`TCQ 1;
           else if (diff_pntr_rd > pe_thr_negate_val)
             ideal_prog_empty <= #`TCQ 0;
           else
             ideal_prog_empty <= #`TCQ ideal_prog_empty;
         end else
           ideal_prog_empty   <= #`TCQ ideal_prog_empty;
       end else if (C_PROG_EMPTY_TYPE == 3) begin
         if (EMPTY == 0) begin
           if (diff_pntr_rd <= pe_thr_assert_val)
             ideal_prog_empty <= #`TCQ 1;
           else
             ideal_prog_empty <= #`TCQ 0;
         end else
           ideal_prog_empty   <= #`TCQ ideal_prog_empty;
       end else if (C_PROG_EMPTY_TYPE == 4) begin
         if (EMPTY == 0) begin
           if (diff_pntr_rd >= pe_thr_assert_val)
             ideal_prog_empty <= #`TCQ 1;
           else if (diff_pntr_rd > pe_thr_negate_val)
             ideal_prog_empty <= #`TCQ 0;
           else
             ideal_prog_empty <= #`TCQ ideal_prog_empty;
         end else
           ideal_prog_empty   <= #`TCQ ideal_prog_empty;
       end  //C_PROG_EMPTY_TYPE
     end

     if (C_PROG_EMPTY_TYPE == 3) begin

       // If empty input threshold is selected, then subtract 2 for FWFT to
       // compensate the FWFT stage, otherwise assign the input value.
       if (C_PRELOAD_REGS == 1 && C_PRELOAD_LATENCY == 0) // FWFT
         pe_thr_assert_val <= PROG_EMPTY_THRESH - 2'h2;
       else
         pe_thr_assert_val <= PROG_EMPTY_THRESH;

     end else if (C_PROG_EMPTY_TYPE == 4) begin

       // If empty input threshold is selected, then subtract 2 for FWFT to
       // compensate the FWFT stage, otherwise assign the input value.
       if (C_PRELOAD_REGS == 1 && C_PRELOAD_LATENCY == 0) begin // FWFT
         pe_thr_assert_val <= PROG_EMPTY_THRESH_ASSERT - 2'h2;
         pe_thr_negate_val <= PROG_EMPTY_THRESH_NEGATE - 2'h2;
       end else begin
         pe_thr_assert_val <= PROG_EMPTY_THRESH_ASSERT;
         pe_thr_negate_val <= PROG_EMPTY_THRESH_NEGATE;
       end
     end else begin

       if (C_PRELOAD_REGS == 1 && C_PRELOAD_LATENCY == 0) begin // FWFT
         pe_thr_assert_val <= C_PROG_EMPTY_THRESH_ASSERT_VAL - 2;
         pe_thr_negate_val <= C_PROG_EMPTY_THRESH_NEGATE_VAL - 2;
       end else begin
         pe_thr_assert_val <= C_PROG_EMPTY_THRESH_ASSERT_VAL;
         pe_thr_negate_val <= C_PROG_EMPTY_THRESH_NEGATE_VAL;
       end
     end
 
   end 
   
   // block memory has a synchronous reset
   always @(posedge RD_CLK) begin : gen_fifo_blkmemdout
      // make it consistent with the core.
      if (rd_rst_i) begin
         // Reset err_type only if ECC is not selected
         if (C_USE_ECC == 0 && C_MEMORY_TYPE < 2)
            err_type <= #`TCQ 0;
   
         // BRAM resets synchronously
         if (C_USE_DOUT_RST == 1 && C_MEMORY_TYPE < 2) begin
            ideal_dout    <= #`TCQ dout_reset_val;
            ideal_dout_d1 <= #`TCQ dout_reset_val;
         end
      end
   end //always

   always @(posedge RD_CLK or posedge rd_rst_i) begin : gen_fifo_r

     /****** Reset fifo (case 1)***************************************/
     if (rd_rst_i) begin
       num_rd_bits        <= #`TCQ 0;
       next_num_rd_bits    = #`TCQ 0;
       rd_ptr             <= #`TCQ C_RD_DEPTH -1;
       rd_pntr            <= #`TCQ 0;
       rd_pntr_wr1       <= #`TCQ 0;
       wr_pntr_rd2        <= #`TCQ 0;
       wr_pntr_rd3        <= #`TCQ 0;
       wr_pntr_rd         <= #`TCQ 0;
       wr_ptr_rdclk       <= #`TCQ C_WR_DEPTH -1;
  
       // DRAM resets asynchronously
       if (C_MEMORY_TYPE == 2 && C_USE_DOUT_RST == 1)
          ideal_dout    <= #`TCQ dout_reset_val;
  
       // Reset err_type only if ECC is not selected
       if (C_USE_ECC == 0)
         err_type         <= #`TCQ 0;
       ideal_valid        <= #`TCQ 1'b0;
       ideal_rd_count     <= #`TCQ 0;

     end else begin //rd_rst_i==0

      rd_pntr_wr1   <= #`TCQ rd_pntr;

      // Synchronize the wr_pntr in read domain
      wr_pntr_rd2   <= #`TCQ wr_pntr_rd1;
      wr_pntr_rd3   <= #`TCQ wr_pntr_rd2;
      wr_pntr_rd    <= #`TCQ wr_pntr_rd3;



       //Determine the current number of words in the FIFO
       tmp_rd_listsize = (C_DEPTH_RATIO_WR > 1) ? num_rd_bits/C_DIN_WIDTH :
                         num_rd_bits/C_DOUT_WIDTH;
       wr_ptr_rdclk_next = wr_ptr;

       if (wr_ptr_rdclk < wr_ptr_rdclk_next) begin
         next_num_rd_bits = num_rd_bits +
                            C_DIN_WIDTH*(wr_ptr_rdclk +C_WR_DEPTH
                                         - wr_ptr_rdclk_next);
       end else begin
         next_num_rd_bits = num_rd_bits +
                             C_DIN_WIDTH*(wr_ptr_rdclk - wr_ptr_rdclk_next);
       end

       /*****************************************************************/
       // Read Operation - Read Latency 1
       /*****************************************************************/
       if (C_PRELOAD_LATENCY==1 || C_PRELOAD_LATENCY==2) begin
                 ideal_valid        <= #`TCQ 1'b0;

         if (ram_rd_en == 1'b1) begin

           if (EMPTY == 1'b1) begin

             //If the FIFO is completely empty, and is reporting empty
             if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 0)
               begin
                 //Do not change the contents of the FIFO

                 //Do not acknowledge the read from empty FIFO
                 ideal_valid        <= #`TCQ 1'b0;
                 //Reminder that FIFO is still empty

                 ideal_rd_count     <= #`TCQ num_read_words_sized_i;
               end // if (tmp_rd_listsize <= 0)

             //If the FIFO is one from empty, but it is reporting empty
             else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 1)
               begin
                 //Do not change the contents of the FIFO

                 //Do not acknowledge the read from empty FIFO
                 ideal_valid        <= #`TCQ 1'b0;
                 //Note that FIFO is no longer empty, but is almost empty (has one word left)

                 ideal_rd_count     <= #`TCQ num_read_words_sized_i;

               end // if (tmp_rd_listsize == 1)

             //If the FIFO is two from empty, and is reporting empty
             else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 2)
               begin
                 //Do not change the contents of the FIFO

                 //Do not acknowledge the read from empty FIFO
                 ideal_valid        <= #`TCQ 1'b0;
                 //Fifo has two words, so is neither empty or almost empty

                 ideal_rd_count     <= #`TCQ num_read_words_sized_i;

               end // if (tmp_rd_listsize == 2)

             //If the FIFO is not close to empty, but is reporting that it is
             // Treat the FIFO as empty this time, but unset EMPTY flags.
             if ((tmp_rd_listsize/C_DEPTH_RATIO_WR > 2) && (tmp_rd_listsize/C_DEPTH_RATIO_WR<C_FIFO_RD_DEPTH))
               begin
                 //Do not change the contents of the FIFO

                 //Do not acknowledge the read from empty FIFO
                 ideal_valid <= #`TCQ 1'b0;
                 //Note that the FIFO is No Longer Empty or Almost Empty

                 ideal_rd_count <= #`TCQ num_read_words_sized_i;

               end // if ((tmp_rd_listsize > 2) && (tmp_rd_listsize<=C_FIFO_RD_DEPTH-1))
             end // else: if(ideal_empty == 1'b1)

           else //if (ideal_empty == 1'b0)
             begin

               //If the FIFO is completely full, and we are successfully reading from it
               if (tmp_rd_listsize/C_DEPTH_RATIO_WR >= C_FIFO_RD_DEPTH)
                 begin
                   //Read the value from the FIFO
                   read_fifo;
                   next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

                   //Acknowledge the read from the FIFO, no error
                   ideal_valid        <= #`TCQ 1'b1;
                   //Not close to empty

                   ideal_rd_count     <= #`TCQ num_read_words_sized_i;

                 end // if (tmp_rd_listsize == C_FIFO_RD_DEPTH)

               //If the FIFO is not close to being empty
               else if ((tmp_rd_listsize/C_DEPTH_RATIO_WR > 2) && (tmp_rd_listsize/C_DEPTH_RATIO_WR<=C_FIFO_RD_DEPTH))
                 begin
                   //Read the value from the FIFO
                   read_fifo;
                   next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

                   //Acknowledge the read from the FIFO, no error
                   ideal_valid        <= #`TCQ 1'b1;
                   //Not close to empty

                   ideal_rd_count     <= #`TCQ num_read_words_sized_i;

                 end // if ((tmp_rd_listsize > 2) && (tmp_rd_listsize<=C_FIFO_RD_DEPTH-1))

               //If the FIFO is two from empty
               else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 2)
                 begin
                   //Read the value from the FIFO
                   read_fifo;
                   next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

                   //Acknowledge the read from the FIFO, no error
                   ideal_valid        <= #`TCQ 1'b1;
                   //Fifo is not yet empty. It is going almost_empty

                   ideal_rd_count     <= #`TCQ num_read_words_sized_i;

                 end // if (tmp_rd_listsize == 2)

               //If the FIFO is one from empty
               else if ((tmp_rd_listsize/C_DEPTH_RATIO_WR == 1))
                 begin
                   //Read the value from the FIFO
                   read_fifo;
                   next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

                   //Acknowledge the read from the FIFO, no error
                   ideal_valid        <= #`TCQ 1'b1;
                   //Note that FIFO is GOING empty

                   ideal_rd_count     <= #`TCQ num_read_words_sized_i;

                 end // if (tmp_rd_listsize == 1)


               //If the FIFO is completely empty
               else if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 0)
                 begin
                   //Do not change the contents of the FIFO

                   //Do not acknowledge the read from empty FIFO
                   ideal_valid        <= #`TCQ 1'b0;

                   ideal_rd_count     <= #`TCQ num_read_words_sized_i;

                 end // if (tmp_rd_listsize <= 0)

             end // if (ideal_empty == 1'b0)

           end //(RD_EN == 1'b1)

         else //if (RD_EN == 1'b0)
           begin
             //If user did not attempt a read, do not give an ack or err
             ideal_valid          <= #`TCQ 1'b0;

             ideal_rd_count       <= #`TCQ num_read_words_sized_i;

           end // else: !if(RD_EN == 1'b1)

       /*****************************************************************/
       // Read Operation - Read Latency 0
       /*****************************************************************/
       end else if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin
                 ideal_valid        <= #`TCQ 1'b0;
         if (ram_rd_en == 1'b1) begin

           if (EMPTY == 1'b1) begin

             //If the FIFO is completely empty, and is reporting empty
             if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 0) begin
               //Do not change the contents of the FIFO

               //Do not acknowledge the read from empty FIFO
               ideal_valid        <= #`TCQ 1'b0;
               //Reminder that FIFO is still empty

               ideal_rd_count     <= #`TCQ num_read_words_sized_i;

             //If the FIFO is one from empty, but it is reporting empty
             end else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 1) begin
               //Do not change the contents of the FIFO

               //Do not acknowledge the read from empty FIFO
               ideal_valid        <= #`TCQ 1'b0;
               //Note that FIFO is no longer empty, but is almost empty (has one word left)

               ideal_rd_count     <= #`TCQ num_read_words_sized_i;

             //If the FIFO is two from empty, and is reporting empty
             end else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 2) begin
               //Do not change the contents of the FIFO

               //Do not acknowledge the read from empty FIFO
               ideal_valid        <= #`TCQ 1'b0;
               //Fifo has two words, so is neither empty or almost empty

               ideal_rd_count     <= #`TCQ num_read_words_sized_i;

               //If the FIFO is not close to empty, but is reporting that it is
             // Treat the FIFO as empty this time, but unset EMPTY flags.
             end else if ((tmp_rd_listsize/C_DEPTH_RATIO_WR > 2) &&
                         (tmp_rd_listsize/C_DEPTH_RATIO_WR<C_FIFO_RD_DEPTH)) begin
               //Do not change the contents of the FIFO

               //Do not acknowledge the read from empty FIFO
               ideal_valid        <= #`TCQ 1'b0;
               //Note that the FIFO is No Longer Empty or Almost Empty

               ideal_rd_count     <= #`TCQ num_read_words_sized_i;

             end // if ((tmp_rd_listsize > 2) && (tmp_rd_listsize<=C_FIFO_RD_DEPTH-1))

           end else begin

             //If the FIFO is completely full, and we are successfully reading from it
             if (tmp_rd_listsize/C_DEPTH_RATIO_WR >= C_FIFO_RD_DEPTH) begin
               //Read the value from the FIFO
               read_fifo;
               next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

               //Acknowledge the read from the FIFO, no error
               ideal_valid        <= #`TCQ 1'b1;
               //Not close to empty

               ideal_rd_count     <= #`TCQ num_read_words_sized_i;

             //If the FIFO is not close to being empty
             end else if ((tmp_rd_listsize/C_DEPTH_RATIO_WR > 2) &&
                          (tmp_rd_listsize/C_DEPTH_RATIO_WR<=C_FIFO_RD_DEPTH)) begin
               //Read the value from the FIFO
               read_fifo;
               next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

               //Acknowledge the read from the FIFO, no error
               ideal_valid        <= #`TCQ 1'b1;
               //Not close to empty

               ideal_rd_count     <= #`TCQ num_read_words_sized_i;

             //If the FIFO is two from empty
             end else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 2) begin
               //Read the value from the FIFO
               read_fifo;
               next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

               //Acknowledge the read from the FIFO, no error
               ideal_valid        <= #`TCQ 1'b1;
               //Fifo is not yet empty. It is going almost_empty

               ideal_rd_count     <= #`TCQ num_read_words_sized_i;

             //If the FIFO is one from empty
             end else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 1) begin
               //Read the value from the FIFO
               read_fifo;
               next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

               //Acknowledge the read from the FIFO, no error
               ideal_valid        <= #`TCQ 1'b1;
               //Note that FIFO is GOING empty

               ideal_rd_count     <= #`TCQ num_read_words_sized_i;

             //If the FIFO is completely empty
             end else if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 0) begin
               //Do not change the contents of the FIFO

               //Do not acknowledge the read from empty FIFO
               ideal_valid        <= #`TCQ 1'b0;
               //Reminder that FIFO is still empty

               ideal_rd_count     <= #`TCQ num_read_words_sized_i;

             end // if (tmp_rd_listsize <= 0)

           end // if (ideal_empty == 1'b0)

         end else begin//(RD_EN == 1'b0)

         
           //If user did not attempt a read, do not give an ack or err
           ideal_valid           <= #`TCQ 1'b0;
           ideal_rd_count        <= #`TCQ num_read_words_sized_i;

         end // else: !if(RD_EN == 1'b1)
       end //if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0)

       num_rd_bits      <= #`TCQ next_num_rd_bits;
       wr_ptr_rdclk     <= #`TCQ wr_ptr;
     end //rd_rst_i==0
   end //always

endmodule // fifo_generator_v7_2_bhv_ver_as


/*******************************************************************************
 * Declaration of top-level module
 ******************************************************************************/
module fifo_generator_v7_2_bhv_ver_ss
   
  /**************************************************************************
   * Declare user parameters and their defaults
   *************************************************************************/
  #(
    parameter  C_DATA_COUNT_WIDTH             = 2,
    parameter  C_DIN_WIDTH                    = 8,
    parameter  C_DOUT_RST_VAL                 = "",
    parameter  C_DOUT_WIDTH                   = 8,
    parameter  C_FULL_FLAGS_RST_VAL           = 1,
    parameter  C_HAS_ALMOST_EMPTY             = 0,
    parameter  C_HAS_ALMOST_FULL              = 0,
    parameter  C_HAS_DATA_COUNT               = 0,
    parameter  C_HAS_OVERFLOW                 = 0,
    parameter  C_HAS_RD_DATA_COUNT            = 0,
    parameter  C_HAS_RST                      = 0,
    parameter  C_HAS_SRST                     = 0,
    parameter  C_HAS_UNDERFLOW                = 0,
    parameter  C_HAS_VALID                    = 0,
    parameter  C_HAS_WR_ACK                   = 0,
    parameter  C_HAS_WR_DATA_COUNT            = 0,
    parameter  C_IMPLEMENTATION_TYPE          = 0,
    parameter  C_MEMORY_TYPE                  = 1,
    parameter  C_OVERFLOW_LOW                 = 0,
    parameter  C_PRELOAD_LATENCY              = 1,
    parameter  C_PRELOAD_REGS                 = 0,
    parameter  C_PROG_EMPTY_THRESH_ASSERT_VAL = 0,
    parameter  C_PROG_EMPTY_THRESH_NEGATE_VAL = 0,
    parameter  C_PROG_EMPTY_TYPE              = 0,
    parameter  C_PROG_FULL_THRESH_ASSERT_VAL  = 0,
    parameter  C_PROG_FULL_THRESH_NEGATE_VAL  = 0,
    parameter  C_PROG_FULL_TYPE               = 0,
    parameter  C_RD_DATA_COUNT_WIDTH          = 2,
    parameter  C_RD_DEPTH                     = 256,
    parameter  C_RD_PNTR_WIDTH                = 8,
    parameter  C_UNDERFLOW_LOW                = 0,
    parameter  C_USE_DOUT_RST                 = 0,
    parameter  C_USE_EMBEDDED_REG             = 0,
    parameter  C_USE_FWFT_DATA_COUNT          = 0,
    parameter  C_VALID_LOW                    = 0,
    parameter  C_WR_ACK_LOW                   = 0,
    parameter  C_WR_DATA_COUNT_WIDTH          = 2,
    parameter  C_WR_DEPTH                     = 256,
    parameter  C_WR_PNTR_WIDTH                = 8,
    parameter  C_USE_ECC                      = 0, 
    parameter  C_ENABLE_RST_SYNC              = 1,
    parameter  C_ERROR_INJECTION_TYPE         = 0
   )
   
  /**************************************************************************
   * Declare Input and Output Ports
   *************************************************************************/
   (
    //Inputs
    input                                 CLK,
    input       [C_DIN_WIDTH-1:0]         DIN,
    input       [C_RD_PNTR_WIDTH-1:0]     PROG_EMPTY_THRESH,
    input       [C_RD_PNTR_WIDTH-1:0]     PROG_EMPTY_THRESH_ASSERT,
    input       [C_RD_PNTR_WIDTH-1:0]     PROG_EMPTY_THRESH_NEGATE,
    input       [C_WR_PNTR_WIDTH-1:0]     PROG_FULL_THRESH,
    input       [C_WR_PNTR_WIDTH-1:0]     PROG_FULL_THRESH_ASSERT,
    input       [C_WR_PNTR_WIDTH-1:0]     PROG_FULL_THRESH_NEGATE,
    input                                 RD_EN,
    input                                 RST,
    input                                 RST_FULL_GEN,
    input                                 RST_FULL_FF,
    input                                 SRST,
    input                                 WR_EN,
    input                                 INJECTDBITERR,
    input                                 INJECTSBITERR,
                                    
    //Outputs                       
    output                                ALMOST_EMPTY,
    output                                ALMOST_FULL,
    output reg   [C_DATA_COUNT_WIDTH-1:0] DATA_COUNT,
    output       [C_DOUT_WIDTH-1:0]       DOUT,
    output                                EMPTY,
    output                                FULL,
    output                                OVERFLOW,
    output                                PROG_EMPTY,
    output                                PROG_FULL,
    output                                VALID,
    output                                UNDERFLOW,
    output                                WR_ACK,
    output                                SBITERR,
    output                                DBITERR
   );


   /***************************************************************************
    * Parameters used as constants
    **************************************************************************/
   //When RST is present, set FULL reset value to '1'.
   //If core has no RST, make sure FULL powers-on as '0'.
   //The reset value assignments for FULL, ALMOST_FULL, and PROG_FULL are not 
   //changed for v3.2(IP2_Im). When the core has Sync Reset, C_HAS_SRST=1 and C_HAS_RST=0.
   // Therefore, during SRST, all the FULL flags reset to 0.
   localparam                      C_HAS_FAST_FIFO = 0;
   localparam                      C_FIFO_WR_DEPTH = C_WR_DEPTH;
   localparam                      C_FIFO_RD_DEPTH = C_RD_DEPTH;

  /**************************************************************************
    * FIFO Contents Tracking and Data Count Calculations
    *************************************************************************/
   // Memory which will be used to simulate a FIFO
   reg [C_DIN_WIDTH-1:0] memory[C_WR_DEPTH-1:0];
   // Local parameters used to determine whether to inject ECC error or not
   localparam SYMMETRIC_PORT = (C_DIN_WIDTH == C_DOUT_WIDTH) ? 1 : 0;
   localparam ERR_INJECTION = (C_ERROR_INJECTION_TYPE != 0) ? 1 : 0;
   localparam ENABLE_ERR_INJECTION = C_USE_ECC && SYMMETRIC_PORT && ERR_INJECTION;
   // Array that holds the error injection type (single/double bit error) on 
   // a specific write operation, which is returned on read to corrupt the
   // output data.
   reg [1:0] ecc_err[C_WR_DEPTH-1:0];

   //The amount of data stored in the FIFO at any time is given
   // by num_bits.
   //num_bits is calculated by from the total words in the FIFO.
   reg [31:0]                     num_bits;

   //The write pointer - tracks write operations
   // (Works opposite to core: wr_ptr is a DOWN counter)
   reg [31:0]                     wr_ptr;

   //The write pointer - tracks read operations
   // (Works opposite to core: rd_ptr is a DOWN counter)
   reg [31:0]                     rd_ptr;
  
   /**************************
    * Data Count
    *************************/   
   //Amount of data stored in the FIFO scaled to read words
   wire [31:0]                    num_read_words  = num_bits/C_DOUT_WIDTH;
   //num_read_words delayed 1 clock cycle
   reg [31:0]                     num_read_words_q;

   //Amount of data stored in the FIFO scaled to write words
   wire [31:0]                    num_write_words = num_bits/C_DIN_WIDTH;
   //num_write_words delayed 1 clock cycle
   reg [31:0]                     num_write_words_q;

   
   /**************************************************************************
    * Internal Registers and wires
    *************************************************************************/

   //Temporary signals used for calculating the model's outputs. These
   //are only used in the assign statements immediately following wire,
   //parameter, and function declarations.
   wire                           underflow_i;
   wire                           valid_i;
   wire                           valid_out;

   //Ideal FIFO signals. These are the raw output of the behavioral model,
   //which behaves like an ideal FIFO.
   reg [1:0]                      err_type           = 0;
   reg [1:0]                      err_type_d1        = 0;
   reg  [C_DOUT_WIDTH-1:0]        ideal_dout         = 0;
   reg  [C_DOUT_WIDTH-1:0]        ideal_dout_d1      = 0;
   wire [C_DOUT_WIDTH-1:0]        ideal_dout_out;
   wire                           fwft_enabled;
   reg                            ideal_wr_ack       = 0;
   reg                            ideal_valid        = 0;
   reg                            ideal_overflow     = 0;
   reg                            ideal_underflow    = 0;
   reg                            ideal_full         = 0;
   reg                            ideal_empty        = 1;
   reg                            ideal_almost_full  = 0;
   reg                            ideal_almost_empty = 1;
   reg                            ideal_prog_full    = 0;
   reg                            ideal_prog_empty   = 1;

   //Assorted reg values for delayed versions of signals
   reg                            valid_d1           = 0;
   reg                            prog_full_d        = 0;
   reg                            prog_empty_d       = 1;
   
   wire                           rst_i;
   wire                           srst_i;

   //Delayed version of RST
   reg                            rst_q;
   reg                            rst_qq;

   //user specified value for reseting the size of the fifo
   reg [C_DOUT_WIDTH-1:0]         dout_reset_val = 0;


   /****************************************************************************
    * Function Declarations
    ***************************************************************************/

  /**************************************************************************
   * write_fifo
   *   This task writes a word to the FIFO memory and updates the
   * write pointer.
   *   FIFO size is relative to write domain.
  ***************************************************************************/
  task write_fifo;
    reg [1:0] corrupted_data;
    begin
      memory[wr_ptr]     <= DIN;
      // Store the type of error injection (double/single) on write
      case (C_ERROR_INJECTION_TYPE)
        3:       ecc_err[wr_ptr]    <= {INJECTDBITERR,INJECTSBITERR};
        2:       ecc_err[wr_ptr]    <= {INJECTDBITERR,1'b0};
        1:       ecc_err[wr_ptr]    <= {1'b0,INJECTSBITERR};
        default: ecc_err[wr_ptr]    <= 0;
      endcase
      if (wr_ptr == 0) begin
         wr_ptr          <= C_WR_DEPTH - 1;
      end else begin
         wr_ptr          <= wr_ptr - 1;
      end
    end
  endtask // write_fifo

  /**************************************************************************
   * read_fifo
   *   This task reads a word from the FIFO memory and updates the read
   * pointer. It's output is the ideal_dout bus.
   *   FIFO size is relative to write domain.
   ***************************************************************************/
   task  read_fifo;
    reg [C_DOUT_WIDTH-1:0] tmp_dout;
    reg [1:0]              tmp_ecc_err;
      begin
        tmp_dout = memory[rd_ptr][C_DOUT_WIDTH-1:0];
        // Retreive the error injection type. Based on the error injection type
        // corrupt the output data.
        tmp_ecc_err = ecc_err[rd_ptr];
        if (ENABLE_ERR_INJECTION) begin
          if (tmp_ecc_err[1]) begin // Corrupt the output data only for double bit error
            if (C_DOUT_WIDTH == 1)
              tmp_dout = tmp_dout[C_DOUT_WIDTH-1:0];
            else if (C_DOUT_WIDTH == 2)
              tmp_dout = {~tmp_dout[C_DOUT_WIDTH-1],~tmp_dout[C_DOUT_WIDTH-2]};
            else
              tmp_dout = {~tmp_dout[C_DOUT_WIDTH-1],~tmp_dout[C_DOUT_WIDTH-2],(tmp_dout << 2)};
          end else begin
            tmp_dout = tmp_dout[C_DOUT_WIDTH-1:0];
          end
          err_type <= {tmp_ecc_err[1], tmp_ecc_err[0] & !tmp_ecc_err[1]};
        end else begin
          err_type <= 0;
        end
        ideal_dout <= tmp_dout;

        if (rd_ptr == 0) begin
           rd_ptr  <= C_RD_DEPTH - 1;
        end else begin
           rd_ptr  <= rd_ptr - 1;
        end
      end
   endtask

   /****************************************************************************
    * hexstr_conv
    *   Converts a string of type hex to a binary value (for C_DOUT_RST_VAL)
    ***************************************************************************/
    function [C_DOUT_WIDTH-1:0] hexstr_conv;
    input [(C_DOUT_WIDTH*8)-1:0] def_data;

    integer index,i,j;
    reg [3:0] bin;

    begin
      index = 0;
      hexstr_conv = 'b0;
      for( i=C_DOUT_WIDTH-1; i>=0; i=i-1 )
      begin
        case (def_data[7:0])
          8'b00000000 :
          begin
            bin = 4'b0000;
            i = -1;
          end
          8'b00110000 : bin = 4'b0000;
          8'b00110001 : bin = 4'b0001;
          8'b00110010 : bin = 4'b0010;
          8'b00110011 : bin = 4'b0011;
          8'b00110100 : bin = 4'b0100;
          8'b00110101 : bin = 4'b0101;
          8'b00110110 : bin = 4'b0110;
          8'b00110111 : bin = 4'b0111;
          8'b00111000 : bin = 4'b1000;
          8'b00111001 : bin = 4'b1001;
          8'b01000001 : bin = 4'b1010;
          8'b01000010 : bin = 4'b1011;
          8'b01000011 : bin = 4'b1100;
          8'b01000100 : bin = 4'b1101;
          8'b01000101 : bin = 4'b1110;
          8'b01000110 : bin = 4'b1111;
          8'b01100001 : bin = 4'b1010;
          8'b01100010 : bin = 4'b1011;
          8'b01100011 : bin = 4'b1100;
          8'b01100100 : bin = 4'b1101;
          8'b01100101 : bin = 4'b1110;
          8'b01100110 : bin = 4'b1111;
          default :
          begin
            bin = 4'bx;
          end
        endcase
        for( j=0; j<4; j=j+1)
        begin
          if ((index*4)+j < C_DOUT_WIDTH)
          begin
            hexstr_conv[(index*4)+j] = bin[j];
          end
        end
        index = index + 1;
        def_data = def_data >> 8;
      end
    end
  endfunction

   
  /*************************************************************************
  * Initialize Signals for clean power-on simulation
  *************************************************************************/
   initial begin
      num_bits           = 0;
      num_read_words_q   = 0;
      num_write_words_q  = 0;
      rd_ptr             = C_RD_DEPTH -1;
      wr_ptr             = C_WR_DEPTH -1;
      dout_reset_val     = hexstr_conv(C_DOUT_RST_VAL);
      ideal_dout         = dout_reset_val;
      err_type           = 0;
      ideal_wr_ack       = 1'b0;
      ideal_valid        = 1'b0;
      valid_d1           = 1'b0;
      ideal_overflow     = 1'b0;
      ideal_underflow    = 1'b0;
      ideal_full         = 1'b0;
      ideal_empty        = 1'b1;
      ideal_almost_full  = 1'b0;
      ideal_almost_empty = 1'b1;
      ideal_prog_full    = 1'b0;
      ideal_prog_empty   = 1'b1;
      prog_full_d        = 1'b0;
      prog_empty_d       = 1'b1;
      rst_q              = 1'b0;
      rst_qq             = 1'b0;    
   end


  /*************************************************************************
   * Connect the module inputs and outputs to the internal signals of the
   * behavioral model.
   *************************************************************************/
   //Inputs
   /*
   wire CLK;
   wire [C_DIN_WIDTH-1:0] DIN;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH_ASSERT;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH_NEGATE;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH_ASSERT;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH_NEGATE;
   wire RD_EN;
   wire RST;
   wire WR_EN;
    */

  //Outputs
   generate
      if (C_HAS_ALMOST_EMPTY==1) begin : blockAE10
   assign ALMOST_EMPTY = ideal_almost_empty;
      end
   endgenerate
   
   generate
      if (C_HAS_ALMOST_FULL==1) begin : blockAF10
   assign ALMOST_FULL  = ideal_almost_full;
      end
   endgenerate

   //Dout may change behavior based on latency
  assign fwft_enabled = (C_PRELOAD_LATENCY == 0 && C_PRELOAD_REGS == 1)?
                         1: 0;
  assign ideal_dout_out= ((C_USE_EMBEDDED_REG==1 && (fwft_enabled == 0)) &&
                          (C_MEMORY_TYPE==0 || C_MEMORY_TYPE==1))?
                         ideal_dout_d1: ideal_dout; 
  assign DOUT = ideal_dout_out;

  // Assign SBITERR and DBITERR based on latency 
   assign SBITERR = (C_ERROR_INJECTION_TYPE == 1 || C_ERROR_INJECTION_TYPE == 3) && 
                    ((C_USE_EMBEDDED_REG==1 && (fwft_enabled == 0)) &&
                     (C_MEMORY_TYPE==0 || C_MEMORY_TYPE==1)) ?
                    err_type_d1[0]: err_type[0]; 
   assign DBITERR = (C_ERROR_INJECTION_TYPE == 2 || C_ERROR_INJECTION_TYPE == 3) &&
                    ((C_USE_EMBEDDED_REG==1 && (fwft_enabled == 0)) &&
                     (C_MEMORY_TYPE==0 || C_MEMORY_TYPE==1)) ?
                    err_type_d1[1]: err_type[1]; 

  assign EMPTY         = ideal_empty;
  assign FULL          = ideal_full;

  //Overflow may be active-low
  generate
      if (C_HAS_OVERFLOW==1) begin : blockOF10
  assign OVERFLOW = ideal_overflow ? !C_OVERFLOW_LOW : C_OVERFLOW_LOW;
      end
  endgenerate

  assign PROG_EMPTY    = ideal_prog_empty;
  assign PROG_FULL     = ideal_prog_full;

   //Valid may change behavior based on latency or active-low
  generate
      if (C_HAS_VALID==1) begin : blockVL10
  assign valid_i       = (C_PRELOAD_LATENCY==0) ? (RD_EN & ~EMPTY) : ideal_valid;
  assign valid_out     = (C_PRELOAD_LATENCY==2 &&
                          (C_MEMORY_TYPE==0 || C_MEMORY_TYPE==1))?
                         valid_d1: valid_i; 
  assign VALID         = valid_out ? !C_VALID_LOW : C_VALID_LOW;
     end
  endgenerate

  //Trim data count differently depending on set widths
  generate
     if ((C_HAS_DATA_COUNT == 1) && 
         (C_DATA_COUNT_WIDTH > C_RD_PNTR_WIDTH)) begin : blockDC1
        always @(num_read_words)
           DATA_COUNT = num_read_words[C_RD_PNTR_WIDTH:0]; 
     end else if (C_HAS_DATA_COUNT == 1) begin : blockDC2
        always @(num_read_words)
           DATA_COUNT = num_read_words[C_RD_PNTR_WIDTH-1:C_RD_PNTR_WIDTH-C_DATA_COUNT_WIDTH]; 
     end //if
  endgenerate

  //Underflow may change behavior based on latency or active-low
  generate
      if (C_HAS_UNDERFLOW==1) begin : blockUF10
  assign underflow_i   = ideal_underflow;
  assign UNDERFLOW     = underflow_i ? !C_UNDERFLOW_LOW : C_UNDERFLOW_LOW;
      end 
  endgenerate   
 

  //Write acknowledge may be active low 
 generate
      if (C_HAS_WR_ACK==1) begin : blockWK10
  assign WR_ACK        = ideal_wr_ack ? !C_WR_ACK_LOW : C_WR_ACK_LOW;
      end
 endgenerate


  /*****************************************************************************
   * Internal reset logic 
   ****************************************************************************/
  assign srst_i        = C_HAS_SRST ? SRST : 0;
  assign rst_i         = C_HAS_RST ? RST : 0;

   /**************************************************************************
    * Assorted registers for delayed versions of signals
    **************************************************************************/
   //Capture delayed version of valid
   generate
      if (C_HAS_VALID==1) begin : blockVL20
   always @(posedge CLK or posedge rst_i) begin
      if (rst_i == 1'b1) begin
         valid_d1 <= #`TCQ 1'b0;
      end else begin
         if (srst_i) begin
            valid_d1 <= #`TCQ 1'b0;
         end else begin
            valid_d1 <= #`TCQ valid_i;
         end
      end    
   end // always @ (posedge CLK or posedge rst_i)
      end
   endgenerate
  
   
   // block memory has a synchronous reset
   always @(posedge CLK) begin : gen_fifo_blkmemdout_emb
      // make it consistent with the core.
      if (rst_i || srst_i) begin
         // BRAM resets synchronously
         if (C_USE_DOUT_RST == 1 && C_MEMORY_TYPE < 2) begin
            ideal_dout_d1 <= #`TCQ dout_reset_val;
         end
      end
   end //always
   
   reg ram_rd_en_d1 = 1'b0;
   //Capture delayed version of dout
   always @(posedge CLK or posedge rst_i) begin
      if (rst_i == 1'b1) begin
         // Reset err_type only if ECC is not selected
         if (C_USE_ECC == 0)
            err_type_d1      <= #`TCQ 0;
  
         // DRAM and SRAM reset asynchronously
         if ((C_MEMORY_TYPE == 2 || C_MEMORY_TYPE == 3) && C_USE_DOUT_RST == 1)
            ideal_dout_d1 <= #`TCQ dout_reset_val;
  
         ram_rd_en_d1 <= #`TCQ 1'b0;
      end else begin
         ram_rd_en_d1 <= #`TCQ RD_EN & !EMPTY;
         if (srst_i) begin
            ram_rd_en_d1 <= #`TCQ 1'b0;
            // Reset err_type only if ECC is not selected
            if (C_USE_ECC == 0)
               err_type_d1   <= #`TCQ 0;
            // Reset DRAM and SRAM based FIFO, BRAM based FIFO is reset above
            if ((C_MEMORY_TYPE == 2 || C_MEMORY_TYPE == 3) && C_USE_DOUT_RST == 1)
               ideal_dout_d1 <= #`TCQ dout_reset_val;
         end else if (ram_rd_en_d1) begin
            ideal_dout_d1 <= #`TCQ ideal_dout;
            err_type_d1   <= #`TCQ err_type;
         end
      end    
   end   

   /**************************************************************************
    * Overflow and Underflow Flag calculation
    *  (handled separately because they don't support rst)
    **************************************************************************/
   generate
      if (C_HAS_OVERFLOW==1) begin : blockOF20
   always @(posedge CLK) begin
     ideal_overflow    <= #`TCQ WR_EN & ideal_full;
   end
      end
   endgenerate
 
   generate
      if (C_HAS_UNDERFLOW==1) begin : blockUF20
   always @(posedge CLK) begin
     ideal_underflow   <= #`TCQ ideal_empty & RD_EN;
   end
      end
   endgenerate

   /*************************************************************************
    * Write and Read Logic  
    ************************************************************************/
   always @(posedge CLK or posedge rst_i)
     begin : gen_wr_ack_resp
        
        //Register reset
        rst_q   <= #`TCQ rst_i;
        rst_qq  <= #`TCQ rst_q;
        
     end // block: gen_wr_ack_resp
   
   // block memory has a synchronous reset
   always @(posedge CLK) begin : gen_fifo_blkmemdout
      //Changed the latency of during async reset to '1' instead of '2' to 
      // make it consistent with the core.
      if (rst_i || rst_q || srst_i) begin
         // Reset err_type only if ECC is not selected
         if (C_USE_ECC == 0 && C_MEMORY_TYPE == 1)
            err_type <= #`TCQ 0;
         /******Initialize Read Domain Signals*********************************/
         if (C_USE_DOUT_RST == 1 && C_MEMORY_TYPE < 2) begin
            ideal_dout <= #`TCQ dout_reset_val;
         end
      end
   end //always
   
  // FULL_FLAG_RESET value given for SRST as well.
   reg srst_i_d1 = 0;
   reg srst_i_d2 = 0;
   always @(posedge CLK or posedge RST_FULL_FF) begin : gen_fifo
      
      /****** Reset fifo - Asynchronous Reset**********************************/
      //Changed the latency of during async reset to '1' instead of '2' to 
      // make it consistent with the core.
      if (RST_FULL_FF) begin //v3.2
         /******Initialize Generic FIFO constructs*****************************/
         num_bits           <= #`TCQ 0;
         wr_ptr             <= #`TCQ C_WR_DEPTH - 1;
         rd_ptr             <= #`TCQ C_RD_DEPTH - 1;
         num_read_words_q   <= #`TCQ 0;
         num_write_words_q  <= #`TCQ 0;
         // Reset err_type only if ECC is not selected
         if (C_USE_ECC == 0 && C_MEMORY_TYPE != 1)
            err_type           <= #`TCQ 0;
         
         
         /******Initialize Write Domain Signals********************************/
         ideal_wr_ack       <= #`TCQ 0;
         ideal_full         <= #`TCQ C_FULL_FLAGS_RST_VAL;
         ideal_almost_full  <= #`TCQ C_FULL_FLAGS_RST_VAL;
         
         /******Initialize Read Domain Signals*********************************/
         // DRAM and SRAM reset asynchronously
         if (C_USE_DOUT_RST == 1 && (C_MEMORY_TYPE == 2 || C_MEMORY_TYPE == 3)) begin
            ideal_dout      <= #`TCQ dout_reset_val;
         end
         ideal_valid        <= #`TCQ 1'b0;
         ideal_empty        <= #`TCQ 1'b1;
         ideal_almost_empty <= #`TCQ 1'b1;
         
      end else begin  
         // Register SRST twice to be consistant with RST behavior
         srst_i_d1 <= #`TCQ srst_i; 
         srst_i_d2 <= #`TCQ srst_i_d1; 
         if (srst_i) begin
            // SRST is available only for Sync BRAM, DRAM and SRAM.
            if (C_MEMORY_TYPE == 1 || C_MEMORY_TYPE == 2 || C_MEMORY_TYPE == 3) begin
               /******Initialize Generic FIFO constructs***********************/
               num_bits           <= #`TCQ 0;
               wr_ptr             <= #`TCQ C_WR_DEPTH - 1;
               rd_ptr             <= #`TCQ C_RD_DEPTH - 1;
               num_read_words_q   <= #`TCQ 0;
               num_write_words_q  <= #`TCQ 0;
               // Reset err_type only if ECC is not selected
               if (C_USE_ECC == 0)
                  err_type           <= #`TCQ 0;
               
               /******Initialize Write Domain Signals**************************/
               ideal_wr_ack       <= #`TCQ 0;
               ideal_full         <= #`TCQ C_FULL_FLAGS_RST_VAL;
               ideal_almost_full  <= #`TCQ C_FULL_FLAGS_RST_VAL;
               
               /******Initialize Read Domain Signals***************************/
               //Reset DOUT of Sync DRAM/Shift RAM. Sync BRAM DOUT was reset in the 
               // above always block.
               if (C_USE_DOUT_RST == 1 && (C_MEMORY_TYPE == 2 || C_MEMORY_TYPE == 3)) begin
                  ideal_dout      <= #`TCQ dout_reset_val;
               end
               ideal_valid        <= #`TCQ 1'b0;
               ideal_empty        <= #`TCQ 1'b1;
               ideal_almost_empty <= #`TCQ 1'b1;
            end
            
         end else if ((srst_i_d1 || srst_i_d2) && (C_FULL_FLAGS_RST_VAL == 1)) begin  //Hold full flag reset value set during RST/SRST
            ideal_full         <= #`TCQ C_FULL_FLAGS_RST_VAL;
            ideal_almost_full  <= #`TCQ C_FULL_FLAGS_RST_VAL;
         end else begin  //normal operating conditions
         /********************************************************************/
         // Synchronous FIFO Condition #1 : Writing and not reading
         /********************************************************************/
                 ideal_valid        <= #`TCQ 1'b0;
         if (WR_EN & ~RD_EN) begin

            /*********************************/
            //If the FIFO is full, do NOT perform the write,
            // update flags accordingly
            /*********************************/
            if (num_write_words >= C_FIFO_WR_DEPTH) begin
               ideal_wr_ack       <= #`TCQ 0;

               //still full
               ideal_full         <= #`TCQ 1'b1;
               ideal_almost_full  <= #`TCQ 1'b1;

               //write unsuccessful - do not change contents

               // no read attempted
               ideal_valid        <= #`TCQ 1'b0;

               //Not near empty
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;


            /*********************************/
            //If the FIFO is reporting FULL
            // (Startup condition)
            /*********************************/
            end else if ((num_write_words < C_FIFO_WR_DEPTH) && (ideal_full == 1'b1)) begin
               ideal_wr_ack       <= #`TCQ 0;

               //still full
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               //write unsuccessful - do not change contents

               // no read attempted
               ideal_valid        <= #`TCQ 1'b0;

               //FIFO EMPTY in this state can not be determined
               //ideal_empty        <= 1'b0;
               //ideal_almost_empty <= 1'b0;


               /*********************************/
               //If the FIFO is one from full
               /*********************************/
            end else if (num_write_words == C_FIFO_WR_DEPTH-1) begin
               //good write
               ideal_wr_ack       <= #`TCQ 1;

               //FIFO is one from FULL and going FULL
               ideal_full         <= #`TCQ 1'b1;
               ideal_almost_full  <= #`TCQ 1'b1;

               //Add input data
               write_fifo;

               // no read attempted
               ideal_valid        <= #`TCQ 1'b0;

               //Not near empty
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;

               num_bits           <= num_bits + C_DIN_WIDTH;

               /*********************************/
               //If the FIFO is 2 from full
               /*********************************/
            end else if (num_write_words == C_FIFO_WR_DEPTH-2) begin
               //good write
               ideal_wr_ack       <= #`TCQ 1;

               //2 from full, and writing, so set almost_full
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b1;

               //Add input data
               write_fifo;

               //no read attempted
               ideal_valid        <= #`TCQ 1'b0;

               //Not near empty
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;

               num_bits           <= #`TCQ num_bits + C_DIN_WIDTH;

               /*********************************/
               //If the FIFO is ALMOST EMPTY
               /*********************************/
            end else if (num_read_words == 1) begin
               //good write
               ideal_wr_ack       <= #`TCQ 1;

               //Not near FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               //Add input data
               write_fifo;

               // no read attempted
               ideal_valid        <= #`TCQ 1'b0;

               //Leaving ALMOST_EMPTY
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;

               num_bits           <= #`TCQ num_bits + C_DIN_WIDTH;

               /*********************************/
               //If the FIFO is EMPTY
               /*********************************/
            end else if (num_read_words == 0) begin
               // good write
               ideal_wr_ack       <= #`TCQ 1;

               //Not near FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               //Add input data
               write_fifo;

               // no read attempted
               ideal_valid        <= #`TCQ 1'b0;

               //Leaving EMPTY (still ALMOST_EMPTY)
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b1;

               num_bits           <= #`TCQ num_bits + C_DIN_WIDTH;

               /*********************************/
               //If the FIFO is not near EMPTY or FULL
               /*********************************/
            end else begin
               // good write
               ideal_wr_ack       <= #`TCQ 1;

               //Not near FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               //Add input data
               write_fifo;

               // no read attempted
               ideal_valid        <= #`TCQ 1'b0;

               //Not near EMPTY
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;

               num_bits           <= #`TCQ num_bits + C_DIN_WIDTH;

            end // average case


            /******************************************************************/
            // Synchronous FIFO Condition #2 : Reading and not writing
            /******************************************************************/
         end else if (~WR_EN & RD_EN) begin

            /*********************************/
            //If the FIFO is EMPTY
            /*********************************/
            if ((num_read_words == 0) || (ideal_empty == 1'b1)) begin
               //no write attemped
               ideal_wr_ack       <= #`TCQ 0;

               //FIFO is not near FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               //Read will fail
               ideal_valid        <= #`TCQ 1'b0;

               //FIFO is still empty
               ideal_empty        <= #`TCQ 1'b1;
               ideal_almost_empty <= #`TCQ 1'b1;

               //No read

               /*********************************/
               //If the FIFO is ALMOST EMPTY
               /*********************************/
            end else if (num_read_words == 1) begin
               //no write attempted
               ideal_wr_ack       <= #`TCQ 0;

               //FIFO is not near FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               //Read successful
               ideal_valid        <= #`TCQ 1'b1;

               //This read will make FIFO go empty
               ideal_empty        <= #`TCQ 1'b1;
               ideal_almost_empty <= #`TCQ 1'b1;

               //Get the data from the FIFO
               read_fifo;
               num_bits           <= #`TCQ num_bits - C_DIN_WIDTH;


               /*********************************/
               //If the FIFO is 2 from EMPTY
               /*********************************/
            end else if (num_read_words == 2) begin

               //no write attempted
               ideal_wr_ack       <= #`TCQ 0;

               //FIFO is not near FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               //Read successful
               ideal_valid        <= #`TCQ 1'b1;

               //FIFO is going ALMOST_EMPTY
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b1;

               //Get the data from the FIFO
               read_fifo;
               num_bits           <= #`TCQ num_bits - C_DOUT_WIDTH;



               /*********************************/
               //If the FIFO is one from full
               /*********************************/
            end else if (num_write_words == C_FIFO_WR_DEPTH-1) begin

               //no write attempted
               ideal_wr_ack       <= #`TCQ 0;

               //FIFO is leaving ALMOST FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               //Read successful
               ideal_valid        <= #`TCQ 1'b1;

               //Not near empty
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;

               //Read from the FIFO
               read_fifo;
               num_bits           <= #`TCQ num_bits - C_DOUT_WIDTH;


               /*********************************/
               // FIFO is FULL
               /*********************************/
            end else if (num_write_words >= C_FIFO_WR_DEPTH)
              begin
                 //no write attempted
                 ideal_wr_ack       <= #`TCQ 0;

                 //FIFO is leaving FULL, but is still ALMOST_FULL
                 ideal_full         <= #`TCQ 1'b0;
                 ideal_almost_full  <= #`TCQ 1'b1;

                 //Read successful
                 ideal_valid        <= #`TCQ 1'b1;

                 //Not near empty
                 ideal_empty        <= #`TCQ 1'b0;
                 ideal_almost_empty <= #`TCQ 1'b0;

                 //Read from the FIFO
                 read_fifo;
                 num_bits           <= #`TCQ num_bits - C_DOUT_WIDTH;

                 /*********************************/
                 //If the FIFO is not near EMPTY or FULL
                 /*********************************/
              end else begin
                 //no write attemped
                 ideal_wr_ack       <= #`TCQ 0;

                 //Not near empty
                 ideal_full         <= #`TCQ 1'b0;
                 ideal_almost_full  <= #`TCQ 1'b0;

                 //Read successful
                 ideal_valid        <= #`TCQ 1'b1;

                 //Not near empty
                 ideal_empty        <= #`TCQ 1'b0;
                 ideal_almost_empty <= #`TCQ 1'b0;

                 //Read from the FIFO
                 read_fifo;
                 num_bits           <= #`TCQ num_bits - C_DOUT_WIDTH;


              end // average read


            /******************************************************************/
            // Synchronous FIFO Condition #3 : Reading and writing
            /******************************************************************/
         end else if (WR_EN & RD_EN) begin

            /*********************************/
            // FIFO is FULL
            /*********************************/
            if (num_write_words >= C_FIFO_WR_DEPTH) begin

               ideal_wr_ack       <= #`TCQ 0;

               //Read will be successful, so FIFO will leave FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b1;

               //Read successful
               ideal_valid        <= #`TCQ 1'b1;

               //Not near empty
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;

               //Read from the FIFO
               read_fifo;
               num_bits           <= #`TCQ num_bits - C_DOUT_WIDTH;


            /*********************************/
            // FIFO is reporting FULL, but it is empty
            // (This is a special case, when coming out of RST
            /*********************************/
            end else if ((num_write_words == 0) && (ideal_full == 1'b1)) begin

               ideal_wr_ack       <= #`TCQ 0;

               //Read will be successful, so FIFO will leave FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               //Read unsuccessful
               ideal_valid        <= #`TCQ 1'b0;

               //Report empty condition
               ideal_empty        <= #`TCQ 1'b1;
               ideal_almost_empty <= #`TCQ 1'b1;

               //Do not read from empty FIFO
               // Read from the FIFO


               /*********************************/
               //If the FIFO is one from full
               /*********************************/
            end else if (num_write_words == C_FIFO_WR_DEPTH-1) begin

               //Write successful
               ideal_wr_ack       <= #`TCQ 1;

               //FIFO will remain ALMOST_FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b1;

               // put the data into the FIFO
               write_fifo;

               //Read successful
               ideal_valid        <= #`TCQ 1'b1;

               //Not near empty
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;

               //Read from the FIFO
               read_fifo;
               num_bits           <= #`TCQ num_bits + C_DIN_WIDTH - C_DOUT_WIDTH;

               /*********************************/
               //If the FIFO is ALMOST EMPTY
               /*********************************/
            end else if (num_read_words == 1) begin

               //Write successful
               ideal_wr_ack       <= #`TCQ 1;

               // Not near FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               // put the data into the FIFO
               write_fifo;

               //Read successful
               ideal_valid        <= #`TCQ 1'b1;

               //FIFO will stay ALMOST_EMPTY
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b1;

               //Read from the FIFO
               read_fifo;
               num_bits           <= #`TCQ num_bits + C_DIN_WIDTH - C_DOUT_WIDTH;


               /*********************************/
               //If the FIFO is EMPTY
               /*********************************/
            end else if (num_read_words == 0) begin

               //Write successful
               ideal_wr_ack       <= #`TCQ 1;

               // Not near FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               // put the data into the FIFO
               write_fifo;

               //Read will fail
               ideal_valid        <= #`TCQ 1'b0;

               //FIFO will leave EMPTY
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b1;

               // No read
               num_bits           <= #`TCQ num_bits + C_DIN_WIDTH;


               /*********************************/
               //If the FIFO is not near EMPTY or FULL
               /*********************************/
            end else begin

               //Write successful
               ideal_wr_ack       <= #`TCQ 1;

               // Not near FULL
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               // put the data into the FIFO
               write_fifo;

               //Read successful
               ideal_valid        <= #`TCQ 1'b1;

               // Not near EMPTY
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;

               //Read from the FIFO
               read_fifo;
               num_bits           <= #`TCQ num_bits + C_DIN_WIDTH - C_DOUT_WIDTH;

            end // average case

            /******************************************************************/
            // Synchronous FIFO Condition #4 : Not reading or writing
            /******************************************************************/
         end else begin

            /*********************************/
            // FIFO is FULL
            /*********************************/
            if (num_write_words >= C_FIFO_WR_DEPTH) begin

               //No write
               ideal_wr_ack       <= #`TCQ 0;
               ideal_full         <= #`TCQ 1'b1;
               ideal_almost_full  <= #`TCQ 1'b1;

               //No read
               ideal_valid        <= #`TCQ 1'b0;
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;

               //No change to memory

               /*********************************/
               //If the FIFO is one from full
               /*********************************/
            end else if (num_write_words == C_FIFO_WR_DEPTH-1) begin

               //No write
               ideal_wr_ack       <= #`TCQ 0;
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b1;

               //No read
               ideal_valid        <= #`TCQ 1'b0;
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b0;

               //No change to memory

               /*********************************/
               //If the FIFO is ALMOST EMPTY
               /*********************************/
            end else if (num_read_words == 1) begin
               //No write
               ideal_wr_ack       <= #`TCQ 0;
               ideal_full         <= #`TCQ 1'b0;
               ideal_almost_full  <= #`TCQ 1'b0;

               //No read
               ideal_valid        <= #`TCQ 1'b0;
               ideal_empty        <= #`TCQ 1'b0;
               ideal_almost_empty <= #`TCQ 1'b1;

               //No change to memory

            end // almost empty


            /*********************************/
            //If the FIFO is EMPTY
            /*********************************/
            else if (num_read_words == 0)
              begin
                 //No write
                 ideal_wr_ack       <= #`TCQ 0;
                 ideal_full         <= #`TCQ 1'b0;
                 ideal_almost_full  <= #`TCQ 1'b0;

                 //No read
                 ideal_valid        <= #`TCQ 1'b0;
                 ideal_empty        <= #`TCQ 1'b1;
                 ideal_almost_empty <= #`TCQ 1'b1;

                 //No change to memory

                 /*********************************/
                 //If the FIFO is not near EMPTY or FULL
                 /*********************************/
              end else begin

                 //No write
                 ideal_wr_ack       <= #`TCQ 0;
                 ideal_full         <= #`TCQ 1'b0;
                 ideal_almost_full  <= #`TCQ 1'b0;

                 //No read
                 ideal_valid        <= #`TCQ 1'b0;
                 ideal_empty        <= #`TCQ 1'b0;
                 ideal_almost_empty <= #`TCQ 1'b0;

                 //No change to memory

              end //    average case

         end // neither reading or writing

         num_read_words_q  <= #`TCQ num_read_words;
         num_write_words_q <= #`TCQ num_write_words;
        
         end //normal operating conditions
      end 

   end // block: gen_fifo

   
   always @(posedge CLK or posedge RST_FULL_FF) begin : gen_fifo_p

      /****** Reset fifo - Async Reset****************************************/
      //The latency of de-assertion of the flags is reduced by 1 to be 
      // consistent with the core.
      if (RST_FULL_FF) begin 
         ideal_prog_full   <= #`TCQ C_FULL_FLAGS_RST_VAL;
         ideal_prog_empty  <= #`TCQ 1'b1;
         prog_full_d       <= #`TCQ C_FULL_FLAGS_RST_VAL;
         prog_empty_d      <= #`TCQ 1'b1;

      end else begin
         if (srst_i) begin
            //SRST is available only for Sync BRAM and Sync DRAM. Not for SSHFT.
            if (C_MEMORY_TYPE == 1 || C_MEMORY_TYPE == 2 || C_MEMORY_TYPE == 3) begin
               ideal_prog_empty  <= #`TCQ 1'b1;
               prog_empty_d      <= #`TCQ 1'b1;
               ideal_prog_full   <= #`TCQ C_FULL_FLAGS_RST_VAL;
               prog_full_d       <= #`TCQ C_FULL_FLAGS_RST_VAL;
            end
         end else if ((srst_i_d1 || srst_i_d2) && (C_FULL_FLAGS_RST_VAL == 1)) begin 
            ideal_prog_full   <= #`TCQ C_FULL_FLAGS_RST_VAL;
            prog_full_d       <= #`TCQ C_FULL_FLAGS_RST_VAL;
         end else begin 

            /***************************************************************
             * Programmable FULL flags
             ****************************************************************/
            //calculation for standard fifo and latency =2
            if  (! (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) ) begin  
               //Single constant threshold
               if (C_PROG_FULL_TYPE == 1) begin
                  if ((num_write_words >= C_PROG_FULL_THRESH_ASSERT_VAL-1)
                      && WR_EN && !RD_EN) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if (((num_write_words == C_PROG_FULL_THRESH_ASSERT_VAL)
                                && RD_EN && !WR_EN) || (RST_FULL_GEN)) begin
                     prog_full_d <= #`TCQ 1'b0;
                  end

                  //Dual constant thresholds
               end else if (C_PROG_FULL_TYPE == 2) begin
                  if ((num_write_words == C_PROG_FULL_THRESH_ASSERT_VAL-1)
                      && WR_EN && !RD_EN) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if ((num_write_words == C_PROG_FULL_THRESH_NEGATE_VAL)
                               && RD_EN && !WR_EN) begin
                     prog_full_d <= #`TCQ 1'b0;
                  end
                  
                  //Single input threshold
               end else if (C_PROG_FULL_TYPE == 3) begin
                  if ((num_write_words == PROG_FULL_THRESH-1)
                      && WR_EN && !RD_EN) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if ((num_write_words == PROG_FULL_THRESH)
                               && !WR_EN && RD_EN) begin
                     prog_full_d <= #`TCQ 1'b0;
                  end else if (num_write_words >= PROG_FULL_THRESH) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if (num_write_words < PROG_FULL_THRESH) begin
                     prog_full_d <= #`TCQ 1'b0;
                  end
                  
                  //Dual input thresholds
               end else begin
                  if ((num_write_words == PROG_FULL_THRESH_ASSERT-1)
                      && WR_EN && !RD_EN) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if ((num_write_words == PROG_FULL_THRESH_NEGATE)
                               && !WR_EN && RD_EN)begin
                     prog_full_d <= #`TCQ 1'b0;
                  end else if (num_write_words >= PROG_FULL_THRESH_ASSERT) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if (num_write_words < PROG_FULL_THRESH_NEGATE) begin 
                     prog_full_d <= #`TCQ 1'b0;
                  end
               end
            end  // (~ (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) )
            
            
            //calculation for FWFT fifo 
            if  (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0)  begin  
               if (C_PROG_FULL_TYPE == 1) begin
                  if ((num_write_words >= C_PROG_FULL_THRESH_ASSERT_VAL-1 - 2)
                      && WR_EN && !RD_EN) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if (((num_write_words == C_PROG_FULL_THRESH_ASSERT_VAL - 2)
                                && RD_EN && !WR_EN) || (RST_FULL_GEN)) begin
                     prog_full_d <= #`TCQ 1'b0;
                  end
                  
                  //Dual constant thresholds
               end else if (C_PROG_FULL_TYPE == 2) begin
                  if ((num_write_words == C_PROG_FULL_THRESH_ASSERT_VAL-1 - 2)
                      && WR_EN && !RD_EN) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if ((num_write_words == C_PROG_FULL_THRESH_NEGATE_VAL - 2)
                               && RD_EN && !WR_EN) begin
                     prog_full_d <= #`TCQ 1'b0;
                  end
                  
                  //Single input threshold
               end else if (C_PROG_FULL_TYPE == 3) begin
                  if ((num_write_words == PROG_FULL_THRESH-1 - 2)
                      && WR_EN && !RD_EN) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if ((num_write_words == PROG_FULL_THRESH - 2)
                               && !WR_EN && RD_EN) begin
                     prog_full_d <= #`TCQ 1'b0;
                  end else if (num_write_words >= PROG_FULL_THRESH - 2) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if (num_write_words < PROG_FULL_THRESH - 2) begin
                     prog_full_d <= #`TCQ 1'b0;
                  end
                  
                  //Dual input thresholds
               end else begin
                  if ((num_write_words == PROG_FULL_THRESH_ASSERT-1 - 2)
                      && WR_EN && !RD_EN) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if ((num_write_words == PROG_FULL_THRESH_NEGATE - 2)
                               && !WR_EN && RD_EN)begin
                     prog_full_d <= #`TCQ 1'b0;
                  end else if (num_write_words >= PROG_FULL_THRESH_ASSERT - 2) begin
                     prog_full_d <= #`TCQ 1'b1;
                  end else if (num_write_words < PROG_FULL_THRESH_NEGATE - 2) begin
                     prog_full_d <= #`TCQ 1'b0;
                  end
               end  
            end  //  (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0)  
            
            /*****************************************************************
             * Programmable EMPTY flags
             ****************************************************************/
            //calculation for standard fifo and latency = 2
            if  (! (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) ) begin  
               //Single constant threshold
               if (C_PROG_EMPTY_TYPE == 1) begin
                  if ((num_read_words == C_PROG_EMPTY_THRESH_ASSERT_VAL+1)
                      && RD_EN && !WR_EN) begin
                     prog_empty_d <= #`TCQ 1'b1;
                  end else if ((num_read_words == C_PROG_EMPTY_THRESH_ASSERT_VAL)
                               && WR_EN && !RD_EN) begin
                     prog_empty_d <= #`TCQ 1'b0;
               end
            //Dual constant thresholds
            end else if (C_PROG_EMPTY_TYPE == 2) begin
               if ((num_read_words == C_PROG_EMPTY_THRESH_ASSERT_VAL+1)
                   && RD_EN && !WR_EN) begin
                  prog_empty_d <= #`TCQ 1'b1;
               end else if ((num_read_words == C_PROG_EMPTY_THRESH_NEGATE_VAL)
                            && !RD_EN && WR_EN) begin
                  prog_empty_d <= #`TCQ 1'b0;
               end

            //Single input threshold
            end else if (C_PROG_EMPTY_TYPE == 3) begin
               if ((num_read_words == PROG_EMPTY_THRESH+1)
                             && RD_EN && !WR_EN) begin
                  prog_empty_d <= #`TCQ 1'b1;
               end else if ((num_read_words == PROG_EMPTY_THRESH)
                             && !RD_EN && WR_EN) begin
                  prog_empty_d <= #`TCQ 1'b0;
               end else if (num_read_words <= PROG_EMPTY_THRESH) begin
                  prog_empty_d <= #`TCQ 1'b1;
               end else if (num_read_words > PROG_EMPTY_THRESH)begin
                  prog_empty_d <= #`TCQ 1'b0;
               end

            //Dual input thresholds
            end else begin
               if (num_read_words <= PROG_EMPTY_THRESH_ASSERT) begin 
                  prog_empty_d <= #`TCQ 1'b1;
               end else if ((num_read_words == PROG_EMPTY_THRESH_ASSERT+1)
                   && RD_EN && !WR_EN) begin
                  prog_empty_d <= #`TCQ 1'b1;
               end else if (num_read_words > PROG_EMPTY_THRESH_NEGATE)begin
                  prog_empty_d <= #`TCQ 1'b0;
               end else if ((num_read_words == PROG_EMPTY_THRESH_NEGATE)
                   && !RD_EN && WR_EN) begin
                  prog_empty_d <= #`TCQ 1'b0;
               end
            end
          end // (~ (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) )
            
            //calculation for FWFT fifo
            if   (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0)  begin  
               //Single constant threshold
               if (C_PROG_EMPTY_TYPE == 1) begin
                  if ((num_read_words == C_PROG_EMPTY_THRESH_ASSERT_VAL+1 - 2)
                      && RD_EN && !WR_EN) begin
                     prog_empty_d <= #`TCQ 1'b1;    
                  end else if ((num_read_words == C_PROG_EMPTY_THRESH_ASSERT_VAL - 2)
                               && WR_EN && !RD_EN) begin
                     prog_empty_d <= #`TCQ 1'b0;    
                  end
                  //Dual constant thresholds
               end else if (C_PROG_EMPTY_TYPE == 2) begin
                  if ((num_read_words == C_PROG_EMPTY_THRESH_ASSERT_VAL+1 - 2)  
                      && RD_EN && !WR_EN) begin
                     prog_empty_d <= #`TCQ 1'b1;    
                  end else if ((num_read_words == C_PROG_EMPTY_THRESH_NEGATE_VAL - 2)
                               && !RD_EN && WR_EN) begin
                     prog_empty_d <= #`TCQ 1'b0;
                  end
                  
                  //Single input threshold
               end else if (C_PROG_EMPTY_TYPE == 3) begin
                  if ((num_read_words == PROG_EMPTY_THRESH+1 - 2)
                      && RD_EN && !WR_EN) begin   
                     prog_empty_d <= #`TCQ 1'b1;
                  end else if ((num_read_words == PROG_EMPTY_THRESH - 2)
                               && !RD_EN && WR_EN) begin
                     prog_empty_d <= #`TCQ 1'b0;
                  end else if (num_read_words <= PROG_EMPTY_THRESH - 2) begin
                     prog_empty_d <= #`TCQ 1'b1;
                  end else if (num_read_words > PROG_EMPTY_THRESH - 2)begin
                     prog_empty_d <= #`TCQ 1'b0;
                  end
                  
                  //Dual input thresholds
               end else begin
                  if (num_read_words <= PROG_EMPTY_THRESH_ASSERT - 2) begin 
                     prog_empty_d <= #`TCQ 1'b1;
                  end else if ((num_read_words == PROG_EMPTY_THRESH_ASSERT+1 - 2)
                               && RD_EN && !WR_EN) begin
                     prog_empty_d <= #`TCQ 1'b1;    
                  end else if (num_read_words > PROG_EMPTY_THRESH_NEGATE - 2)begin
                     prog_empty_d <= #`TCQ 1'b0;
                  end else if ((num_read_words == PROG_EMPTY_THRESH_NEGATE - 2)
                               && !RD_EN && WR_EN) begin
                     prog_empty_d <= #`TCQ 1'b0;    
                  end
               end  
            end // (~ (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) )
            
            ideal_prog_empty  <= prog_empty_d;
            if (RST_FULL_GEN) begin
               ideal_prog_full   <= #`TCQ 1'b0;
               prog_full_d       <= #`TCQ 1'b0;
            end else begin
               ideal_prog_full   <= #`TCQ prog_full_d;
            end
            
         end //if (srst_i) begin
      end //if (rst_i) begin
   end //always @(posedge CLK or posedge rst_i) begin : gen_fifo_p
endmodule // fifo_generator_v7_2_bhv_ver_ss



/**************************************************************************
 * First-Word Fall-Through module (preload 0)
 **************************************************************************/
module fifo_generator_v7_2_bhv_ver_preload0
 (
  RD_CLK,
  RD_RST,
  SRST,
  RD_EN,
  FIFOEMPTY,
  FIFODATA,
  FIFOSBITERR,
  FIFODBITERR,
  USERDATA,
  USERVALID,
  USERUNDERFLOW,
  USEREMPTY,
  USERALMOSTEMPTY,
  RAMVALID,
  FIFORDEN,
  USERSBITERR,
  USERDBITERR
  );

 parameter  C_DOUT_RST_VAL            = "";
 parameter  C_DOUT_WIDTH              = 8;
 parameter  C_HAS_RST                 = 0;
 parameter  C_ENABLE_RST_SYNC         = 0;
 parameter  C_HAS_SRST                = 0;
 parameter  C_USE_DOUT_RST            = 0;
 parameter  C_USE_ECC                 = 0;
 parameter  C_USERVALID_LOW           = 0;
 parameter  C_USERUNDERFLOW_LOW       = 0;
 parameter  C_MEMORY_TYPE             = 0;

 //Inputs
 input                     RD_CLK;
 input                     RD_RST;
 input                     SRST;
 input                     RD_EN;
 input                     FIFOEMPTY;
 input  [C_DOUT_WIDTH-1:0] FIFODATA;
 input                     FIFOSBITERR;
 input                     FIFODBITERR;

 //Outputs
 output [C_DOUT_WIDTH-1:0] USERDATA;
 output                    USERVALID;
 output                    USERUNDERFLOW;
 output                    USEREMPTY;
 output                    USERALMOSTEMPTY;
 output                    RAMVALID;
 output                    FIFORDEN;
 output                    USERSBITERR;
 output                    USERDBITERR;

 //Inputs
 wire                      RD_CLK;
 wire                      RD_RST;
 wire                      RD_EN;
 wire                      FIFOEMPTY;
 wire [C_DOUT_WIDTH-1:0]   FIFODATA;
 wire                      FIFOSBITERR;
 wire                      FIFODBITERR;

 //Outputs
 reg [C_DOUT_WIDTH-1:0]    USERDATA;
 wire                      USERVALID;
 wire                      USERUNDERFLOW;
 wire                      USEREMPTY;
 wire                      USERALMOSTEMPTY;
 wire                      RAMVALID;
 wire                      FIFORDEN;
 reg                       USERSBITERR;
 reg                       USERDBITERR;

 //Internal signals
 wire                      preloadstage1;
 wire                      preloadstage2;
 reg                       ram_valid_i;
 reg                       read_data_valid_i;
 wire                      ram_regout_en;
 wire                      ram_rd_en;
 reg                       empty_i        = 1'b1;
 reg                       empty_q        = 1'b1;
 reg                       rd_en_q        = 1'b0;
 reg                       almost_empty_i = 1'b1;
 reg                       almost_empty_q = 1'b1;
 wire                      rd_rst_i;
 wire                      srst_i;


/*************************************************************************
* FUNCTIONS
*************************************************************************/

   /*************************************************************************
    * hexstr_conv
    *   Converts a string of type hex to a binary value (for C_DOUT_RST_VAL)
    ***********************************************************************/
    function [C_DOUT_WIDTH-1:0] hexstr_conv;
    input [(C_DOUT_WIDTH*8)-1:0] def_data;

    integer index,i,j;
    reg [3:0] bin;

    begin
      index = 0;
      hexstr_conv = 'b0;
      for( i=C_DOUT_WIDTH-1; i>=0; i=i-1 )
      begin
        case (def_data[7:0])
          8'b00000000 :
          begin
            bin = 4'b0000;
            i = -1;
          end
          8'b00110000 : bin = 4'b0000;
          8'b00110001 : bin = 4'b0001;
          8'b00110010 : bin = 4'b0010;
          8'b00110011 : bin = 4'b0011;
          8'b00110100 : bin = 4'b0100;
          8'b00110101 : bin = 4'b0101;
          8'b00110110 : bin = 4'b0110;
          8'b00110111 : bin = 4'b0111;
          8'b00111000 : bin = 4'b1000;
          8'b00111001 : bin = 4'b1001;
          8'b01000001 : bin = 4'b1010;
          8'b01000010 : bin = 4'b1011;
          8'b01000011 : bin = 4'b1100;
          8'b01000100 : bin = 4'b1101;
          8'b01000101 : bin = 4'b1110;
          8'b01000110 : bin = 4'b1111;
          8'b01100001 : bin = 4'b1010;
          8'b01100010 : bin = 4'b1011;
          8'b01100011 : bin = 4'b1100;
          8'b01100100 : bin = 4'b1101;
          8'b01100101 : bin = 4'b1110;
          8'b01100110 : bin = 4'b1111;
          default :
          begin
            bin = 4'bx;
          end
        endcase
        for( j=0; j<4; j=j+1)
        begin
          if ((index*4)+j < C_DOUT_WIDTH)
          begin
            hexstr_conv[(index*4)+j] = bin[j];
          end
        end
        index = index + 1;
        def_data = def_data >> 8;
      end
    end
  endfunction

   
   //*************************************************************************
   //  Set power-on states for regs
   //*************************************************************************
   initial begin
      ram_valid_i       = 1'b0;
      read_data_valid_i = 1'b0;
      USERDATA          = hexstr_conv(C_DOUT_RST_VAL);
      USERSBITERR       = 1'b0;
      USERDBITERR       = 1'b0;
   end //initial

   //***************************************************************************
   //  connect up optional reset
   //***************************************************************************
   assign rd_rst_i = (C_HAS_RST == 1 || C_ENABLE_RST_SYNC == 0) ? RD_RST : 0;
   assign srst_i = C_HAS_SRST ? SRST : 0;


   //***************************************************************************
   //  preloadstage2 indicates that stage2 needs to be updated. This is true
   //  whenever read_data_valid is false, and RAM_valid is true.
   //***************************************************************************
   assign preloadstage2 = ram_valid_i & (~read_data_valid_i | RD_EN);

   //***************************************************************************
   //  preloadstage1 indicates that stage1 needs to be updated. This is true
   //  whenever the RAM has data (RAM_EMPTY is false), and either RAM_Valid is
   //  false (indicating that Stage1 needs updating), or preloadstage2 is active
   //  (indicating that Stage2 is going to update, so Stage1, therefore, must
   //  also be updated to keep it valid.
   //***************************************************************************
   assign preloadstage1 = ((~ram_valid_i | preloadstage2) & ~FIFOEMPTY);

   //***************************************************************************
   // Calculate RAM_REGOUT_EN
   //  The output registers are controlled by the ram_regout_en signal.
   //  These registers should be updated either when the output in Stage2 is
   //  invalid (preloadstage2), OR when the user is reading, in which case the
   //  Stage2 value will go invalid unless it is replenished.
   //***************************************************************************
   assign ram_regout_en = preloadstage2;

   //***************************************************************************
   // Calculate RAM_RD_EN
   //   RAM_RD_EN will be asserted whenever the RAM needs to be read in order to
   //  update the value in Stage1.
   //   One case when this happens is when preloadstage1=true, which indicates
   //  that the data in Stage1 or Stage2 is invalid, and needs to automatically
   //  be updated.
   //   The other case is when the user is reading from the FIFO, which 
   // guarantees that Stage1 or Stage2 will be invalid on the next clock 
   // cycle, unless it is replinished by data from the memory. So, as long 
   // as the RAM has data in it, a read of the RAM should occur.
   //***************************************************************************
   assign ram_rd_en = (RD_EN & ~FIFOEMPTY) | preloadstage1;
   
   //***************************************************************************
   // Calculate RAMVALID_P0_OUT
   //   RAMVALID_P0_OUT indicates that the data in Stage1 is valid.
   //
   //   If the RAM is being read from on this clock cycle (ram_rd_en=1), then
   //   RAMVALID_P0_OUT is certainly going to be true.
   //   If the RAM is not being read from, but the output registers are being
   //   updated to fill Stage2 (ram_regout_en=1), then Stage1 will be emptying,
   //   therefore causing RAMVALID_P0_OUT to be false.
   //   Otherwise, RAMVALID_P0_OUT will remain unchanged.
   //***************************************************************************
   // PROCESS regout_valid
   always @ (posedge RD_CLK or posedge rd_rst_i) begin  
      if (rd_rst_i) begin 
         // asynchronous reset (active high)
         ram_valid_i     <= #`TCQ 1'b0;
      end else begin
         if (srst_i) begin 
            // synchronous reset (active high)
            ram_valid_i     <= #`TCQ 1'b0;
         end else begin
            if (ram_rd_en == 1'b1) begin
               ram_valid_i   <= #`TCQ 1'b1;
            end else begin
               if (ram_regout_en == 1'b1)
                 ram_valid_i <= #`TCQ 1'b0;
               else
                 ram_valid_i <= #`TCQ ram_valid_i;
            end
         end //srst_i
      end //rd_rst_i
   end //always
   
   //***************************************************************************
   // Calculate READ_DATA_VALID
   //  READ_DATA_VALID indicates whether the value in Stage2 is valid or not.
   //  Stage2 has valid data whenever Stage1 had valid data and 
   //  ram_regout_en_i=1, such that the data in Stage1 is propogated 
   //  into Stage2.
   //***************************************************************************
   always @ (posedge RD_CLK or posedge rd_rst_i) begin
      if (rd_rst_i)
        read_data_valid_i <= #`TCQ 1'b0;
      else if (srst_i)
        read_data_valid_i <= #`TCQ 1'b0;
      else 
        read_data_valid_i <= #`TCQ ram_valid_i | (read_data_valid_i & ~RD_EN);
   end //always
   
   
   //**************************************************************************
   // Calculate EMPTY
   //  Defined as the inverse of READ_DATA_VALID
   //
   // Description:
   //
   //  If read_data_valid_i indicates that the output is not valid,
   // and there is no valid data on the output of the ram to preload it
   // with, then we will report empty.
   //
   //  If there is no valid data on the output of the ram and we are
   // reading, then the FIFO will go empty.
   //
   //**************************************************************************
   always @ (posedge RD_CLK or posedge rd_rst_i) begin
      if (rd_rst_i) begin
         // asynchronous reset (active high)
         empty_i <= #`TCQ 1'b1;
      end else begin
         if (srst_i) begin
            // synchronous reset (active high)
            empty_i <= #`TCQ 1'b1;
         end else begin
            // rising clock edge
            empty_i <= #`TCQ (~ram_valid_i & ~read_data_valid_i) | (~ram_valid_i & RD_EN);
         end
      end
   end //always
   
   // Register RD_EN from user to calculate USERUNDERFLOW.
   // Register empty_i to calculate USERUNDERFLOW.
   always @ (posedge RD_CLK) begin
     rd_en_q <= #`TCQ RD_EN;
     empty_q <= #`TCQ empty_i;
   end //always
   
   
   //***************************************************************************
   // Calculate user_almost_empty
   //  user_almost_empty is defined such that, unless more words are written
   //  to the FIFO, the next read will cause the FIFO to go EMPTY.
   //
   //  In most cases, whenever the output registers are updated (due to a user
   // read or a preload condition), then user_almost_empty will update to
   // whatever RAM_EMPTY is.
   //
   //  The exception is when the output is valid, the user is not reading, and
   // Stage1 is not empty. In this condition, Stage1 will be preloaded from the
   // memory, so we need to make sure user_almost_empty deasserts properly under
   // this condition.
   //***************************************************************************
   always @ (posedge RD_CLK or posedge rd_rst_i)
     begin
        if (rd_rst_i) begin         // asynchronous reset (active high)
             almost_empty_i <= #`TCQ 1'b1;
             almost_empty_q <= #`TCQ 1'b1;
        end else begin // rising clock edge
           if (srst_i) begin          // synchronous reset (active high)
              almost_empty_i <= #`TCQ 1'b1;
              almost_empty_q <= #`TCQ 1'b1;
           end else begin
              if ((ram_regout_en) | (~FIFOEMPTY & read_data_valid_i & ~RD_EN)) begin
                 almost_empty_i <= #`TCQ FIFOEMPTY;
              end
              almost_empty_q   <= #`TCQ empty_i;
           end
        end
     end //always
   
   
   assign USEREMPTY       = empty_i;
   assign USERALMOSTEMPTY = almost_empty_i;
   assign FIFORDEN        = ram_rd_en;
   assign RAMVALID        = ram_valid_i;
   assign USERVALID       = C_USERVALID_LOW ? ~read_data_valid_i : read_data_valid_i;
   assign USERUNDERFLOW   = C_USERUNDERFLOW_LOW ? ~(empty_q & rd_en_q) : empty_q & rd_en_q;
  
  // BRAM resets synchronously
   always @ (posedge RD_CLK)
     begin
        if (rd_rst_i || srst_i) begin
          if (C_USE_DOUT_RST == 1 && C_MEMORY_TYPE < 2)
            USERDATA     <= #`TCQ hexstr_conv(C_DOUT_RST_VAL);
        end
     end //always

 
   always @ (posedge RD_CLK or posedge rd_rst_i)
     begin
        if (rd_rst_i) begin //asynchronous reset (active high)
          if (C_USE_ECC == 0) begin // Reset S/DBITERR only if ECC is OFF
            USERSBITERR    <= #`TCQ 0;
            USERDBITERR    <= #`TCQ 0;
          end
          // DRAM resets asynchronously
          if (C_USE_DOUT_RST == 1 && C_MEMORY_TYPE == 2)  //asynchronous reset (active high)
            USERDATA     <= #`TCQ hexstr_conv(C_DOUT_RST_VAL);
        end else begin // rising clock edge
          if (srst_i) begin
            if (C_USE_ECC == 0) begin // Reset S/DBITERR only if ECC is OFF
              USERSBITERR  <= #`TCQ 0;
              USERDBITERR  <= #`TCQ 0;
            end
            if (C_USE_DOUT_RST == 1 && C_MEMORY_TYPE == 2)
              USERDATA   <= #`TCQ hexstr_conv(C_DOUT_RST_VAL);
          end else begin
            if (ram_regout_en) begin
               USERDATA     <= #`TCQ FIFODATA;
               USERSBITERR  <= #`TCQ FIFOSBITERR;
               USERDBITERR  <= #`TCQ FIFODBITERR;
            end
          end
        end
     end //always

endmodule

