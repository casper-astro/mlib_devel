//*****************************************************************************
// (c) Copyright 2009 - 2010 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 3.6.1
//  \   \         Application        : MIG
//  /   /         Filename           : mig_v3_61.v
// /___/   /\     Date Last Modified : $Date: 2010/10/27 17:40:42 $
// \   \  /  \    Date Created       : Mon Jun 23 2008
//  \___\/\___\
//
// Device           : Virtex-6
// Design Name      : DDR3 SDRAM
// Purpose          :
//                   Top-level  module. This module serves both as an example,
//                   and allows the user to synthesize a self-contained design,
//                   which they can use to test their hardware. In addition to
//                   the memory controller.
//                   instantiates:
//                     1. Clock generation/distribution, reset logic
//                     2. IDELAY control block
//                     3. Synthesizable testbench - used to model user's backend
//                        logic
// Reference        :
// Revision History :
//*****************************************************************************

`timescale 1ps/1ps

module ddr3_controller #
  (
   parameter REFCLK_FREQ             = 200,
                                       // # = 200 when design frequency <= 533 MHz,
                                       //   = 300 when design frequency > 533 MHz.
   parameter IODELAY_GRP             = "IODELAY_MIG",
                                       // It is associated to a set of IODELAYs with
                                       // an IDELAYCTRL that have same IODELAY CONTROLLER
                                       // clock frequency.
   parameter nCK_PER_CLK             = 2,
                                       // # of memory CKs per fabric clock.
                                       // # = 2, 1.
   parameter tCK                     = 2500,
                                       // memory tCK paramter.
                                       // # = Clock Period.
   parameter DEBUG_PORT              = "OFF",
                                       // # = "ON" Enable debug signals/controls.
                                       //   = "OFF" Disable debug signals/controls.
   parameter SIM_BYPASS_INIT_CAL     = "OFF",
                                       // # = "OFF" -  Complete memory init &
                                       //              calibration sequence
                                       // # = "SKIP" - Skip memory init &
                                       //              calibration sequence
                                       // # = "FAST" - Skip memory init & use
                                       //              abbreviated calib sequence
   parameter SIM_INIT_OPTION         = "NONE",
                                       // # = "SKIP_PU_DLY" - Skip the memory
                                       //                     initilization sequence,
                                       //   = "NONE" - Complete the memory
                                       //              initilization sequence.
   parameter SIM_CAL_OPTION          = "NONE",
                                       // # = "FAST_CAL" - Skip the delay
                                       //                  Calibration process,
                                       //   = "NONE" - Complete the delay
                                       //              Calibration process.
   parameter nCS_PER_RANK            = 1,
                                       // # of unique CS outputs per Rank for
                                       // phy.
   parameter DQS_CNT_WIDTH           = 4,
                                       // # = ceil(log2(DQS_WIDTH)).
   parameter RANK_WIDTH              = 1,
                                       // # = ceil(log2(FULL)).
   parameter BANK_WIDTH              = 3,
                                       // # of memory Bank Address bits.
   parameter CK_WIDTH                = 1,
                                       // # of CK/CK# outputs to memory.
   parameter CKE_WIDTH               = 1,
                                       // # of CKE outputs to memory.
   parameter COL_WIDTH               = 10,
                                       // # of memory Column Address bits.
   parameter CS_WIDTH                = 1,
                                       // # of unique CS outputs to memory.
   parameter DM_WIDTH                = 9,
                                       // # of Data Mask bits.
   parameter DQ_WIDTH                = 72,
                                       // # of Data (DQ) bits.
   parameter DQS_WIDTH               = 9,
                                       // # of DQS/DQS# bits.
   parameter ROW_WIDTH               = 15,
                                       // # of memory Row Address bits.
   parameter BURST_MODE              = "8",
                                       // Burst Length (Mode Register 0).
                                       // # = "8", "4", "OTF".
   parameter BM_CNT_WIDTH            = 2,
                                       // # = ceil(log2(nBANK_MACHS)).
   parameter ADDR_CMD_MODE           = "1T" ,
                                       // # = "2T", "1T".
   parameter ORDERING                = "STRICT",
                                       // # = "NORM", "STRICT", "RELAXED".
   parameter WRLVL                   = "ON",
                                       // # = "ON" - DDR3 SDRAM
                                       //   = "OFF" - DDR2 SDRAM.
   parameter PHASE_DETECT            = "ON",
                                       // # = "ON", "OFF".
   parameter RTT_NOM                 = "60",
                                       // RTT_NOM (ODT) (Mode Register 1).
                                       // # = "DISABLED" - RTT_NOM disabled,
                                       //   = "120" - RZQ/2,
                                       //   = "60"  - RZQ/4,
                                       //   = "40"  - RZQ/6.
   parameter RTT_WR                  = "OFF",
                                       // RTT_WR (ODT) (Mode Register 2).
                                       // # = "OFF" - Dynamic ODT off,
                                       //   = "120" - RZQ/2,
                                       //   = "60"  - RZQ/4,
   parameter OUTPUT_DRV              = "HIGH",
                                       // Output Driver Impedance Control (Mode Register 1).
                                       // # = "HIGH" - RZQ/7,
                                       //   = "LOW" - RZQ/6.
   parameter REG_CTRL                = "ON",
                                       // # = "ON" - RDIMMs,
                                       //   = "OFF" - Components, SODIMMs, UDIMMs.
   parameter nDQS_COL0               = 9, // Number of DQS groups in I/O column #1.
   parameter nDQS_COL1               = 0, // Number of DQS groups in I/O column #2.
   parameter nDQS_COL2               = 0, // Number of DQS groups in I/O column #3.
   parameter nDQS_COL3               = 0, // Number of DQS groups in I/O column #4.
   parameter DQS_LOC_COL0            = 144'h11100F0E0D0C0B0A09080706050403020100,
                                       // DQS groups in column #1.
   parameter DQS_LOC_COL1            = 0,
                                       // DQS groups in column #2.
   parameter DQS_LOC_COL2            = 0,
                                       // DQS groups in column #3.
   parameter DQS_LOC_COL3            = 0,
                                       // DQS groups in column #4.
   parameter tPRDI                   = 1_000_000,
                                       // memory tPRDI paramter.
   parameter tREFI                   = 7800000,
                                       // memory tREFI paramter.
   parameter ZQI                     = 512,
                                       // memory tZQI paramter.
   parameter ADDR_WIDTH              = 29,
                                       // # = RANK_WIDTH + BANK_WIDTH
                                       //     + ROW_WIDTH + COL_WIDTH;
   parameter ECC_TEST                = "OFF",
   parameter TCQ                     = 100,
   parameter DATA_WIDTH              = 72,
   parameter PAYLOAD_WIDTH           = (ECC_TEST == "OFF") ? DATA_WIDTH : DQ_WIDTH,
   parameter RST_ACT_LOW             = 0,
                                       // =1 for active low reset,
                                       // =0 for active high.
   parameter STARVE_LIMIT            = 2,
                                       // # = 2,3,4.
   parameter APP_DATA_WIDTH          = PAYLOAD_WIDTH*4,
   parameter APP_MASK_WIDTH          = APP_DATA_WIDTH/8
   )
  (

   input                             clk_mem,

   input                             clk_div2,
   input                             rst_div2,
   input                             clk_rd_base,

   inout  [DQ_WIDTH-1:0]                ddr3_dq,
   output [ROW_WIDTH-1:0]               ddr3_addr,
   output [BANK_WIDTH-1:0]              ddr3_ba,
   output                               ddr3_ras_n,
   output                               ddr3_cas_n,
   output                               ddr3_we_n,
   output                               ddr3_reset_n,
   output [(CS_WIDTH*nCS_PER_RANK)-1:0] ddr3_cs_n,
   output [(CS_WIDTH*nCS_PER_RANK)-1:0] ddr3_odt,
   output [CKE_WIDTH-1:0]               ddr3_cke,
   output [DM_WIDTH-1:0]                ddr3_dm,
   inout  [DQS_WIDTH-1:0]               ddr3_dqs_p,
   inout  [DQS_WIDTH-1:0]               ddr3_dqs_n,
   output [CK_WIDTH-1:0]                ddr3_ck_p,
   output [CK_WIDTH-1:0]                ddr3_ck_n,

   output                               phy_rdy,
   output                               cal_fail,

   output [APP_DATA_WIDTH-1:0]        app_rd_data,
   output                             app_rd_data_end,
   output                             app_rd_data_valid,
   output                             app_rdy,
   output                             app_wdf_rdy,
   input [ADDR_WIDTH-1:0]             app_addr,
   input [2:0]                        app_cmd,
   input                              app_en,
   input [APP_DATA_WIDTH-1:0]         app_wdf_data,
   input                              app_wdf_end,
   input [APP_MASK_WIDTH-1:0]         app_wdf_mask,
   input                              app_wdf_wren
  );


  //***************************************************************************

  memc_ui_top #
  (
   .ADDR_CMD_MODE        (ADDR_CMD_MODE),
   .BANK_WIDTH           (BANK_WIDTH),
   .CK_WIDTH             (CK_WIDTH),
   .CKE_WIDTH            (CKE_WIDTH),
   .nCK_PER_CLK          (nCK_PER_CLK),
   .COL_WIDTH            (COL_WIDTH),
   .CS_WIDTH             (CS_WIDTH),
   .DM_WIDTH             (DM_WIDTH),
   .nCS_PER_RANK         (nCS_PER_RANK),
   .DEBUG_PORT           (DEBUG_PORT),
   .IODELAY_GRP          (IODELAY_GRP),
   .DQ_WIDTH             (DQ_WIDTH),
   .DQS_WIDTH            (DQS_WIDTH),
   .DQS_CNT_WIDTH        (DQS_CNT_WIDTH),
   .ORDERING             (ORDERING),
   .OUTPUT_DRV           (OUTPUT_DRV),
   .PHASE_DETECT         (PHASE_DETECT),
   .RANK_WIDTH           (RANK_WIDTH),
   .REFCLK_FREQ          (REFCLK_FREQ),
   .REG_CTRL             (REG_CTRL),
   .ROW_WIDTH            (ROW_WIDTH),
   .RTT_NOM              (RTT_NOM),
   .RTT_WR               (RTT_WR),
   .SIM_CAL_OPTION       (SIM_CAL_OPTION),
   .SIM_INIT_OPTION      (SIM_INIT_OPTION),
   .SIM_BYPASS_INIT_CAL  (SIM_BYPASS_INIT_CAL),
   .WRLVL                (WRLVL),
   .nDQS_COL0            (nDQS_COL0),
   .nDQS_COL1            (nDQS_COL1),
   .nDQS_COL2            (nDQS_COL2),
   .nDQS_COL3            (nDQS_COL3),
   .DQS_LOC_COL0         (DQS_LOC_COL0),
   .DQS_LOC_COL1         (DQS_LOC_COL1),
   .DQS_LOC_COL2         (DQS_LOC_COL2),
   .DQS_LOC_COL3         (DQS_LOC_COL3),
   .tPRDI                (tPRDI),
   .tREFI                (tREFI),
   .tZQI                 (ZQI*tCK),
   .BURST_MODE           (BURST_MODE),
   .BM_CNT_WIDTH         (BM_CNT_WIDTH),
   .tCK                  (tCK),
   .ADDR_WIDTH           (ADDR_WIDTH),
   .TCQ                  (TCQ),
   .ECC_TEST             (ECC_TEST),
   .PAYLOAD_WIDTH        (PAYLOAD_WIDTH)
   )
  u_memc_ui_top
  (
   .clk                              (clk_div2),
   .clk_mem                          (clk_mem),
   .clk_rd_base                      (clk_rd_base),
   .rst                              (rst_div2),
   .ddr_addr                         (ddr3_addr),
   .ddr_ba                           (ddr3_ba),
   .ddr_cas_n                        (ddr3_cas_n),
   .ddr_ck_n                         (ddr3_ck_n),
   .ddr_ck                           (ddr3_ck_p),
   .ddr_cke                          (ddr3_cke),
   .ddr_cs_n                         (ddr3_cs_n),
   .ddr_dm                           (ddr3_dm),
   .ddr_odt                          (ddr3_odt),
   .ddr_ras_n                        (ddr3_ras_n),
   .ddr_reset_n                      (ddr3_reset_n),
   .ddr_parity                       (ddr3_parity),
   .ddr_we_n                         (ddr3_we_n),
   .ddr_dq                           (ddr3_dq),
   .ddr_dqs_n                        (ddr3_dqs_n),
   .ddr_dqs                          (ddr3_dqs_p),
   .pd_PSEN                          (),
   .pd_PSINCDEC                      (),
   .pd_PSDONE                        (1'b1),
   .dfi_init_complete                (phy_rdy),
   .bank_mach_next                   (),
   .app_ecc_multiple_err             (),
   .app_rd_data                      (app_rd_data),
   .app_rd_data_end                  (app_rd_data_end),
   .app_rd_data_valid                (app_rd_data_valid),
   .app_rdy                          (app_rdy),
   .app_addr                         (app_addr),
   .app_cmd                          (app_cmd),
   .app_en                           (app_en),
   .app_hi_pri                       (1'b1),
   .app_sz                           (1'b1),
   .app_wdf_data                     (app_wdf_data),
   .app_wdf_end                      (app_wdf_end),
   .app_wdf_mask                     (app_wdf_mask),
   .app_wdf_wren                     (app_wdf_wren),
   .app_wdf_rdy                      (app_wdf_rdy)
   );

  
  

  assign dbg_wr_dqs_tap_set     = 'b0;
  assign dbg_wr_dq_tap_set      = 'b0;
  assign dbg_wr_tap_set_en      = 1'b0;
  assign dbg_pd_off             = 1'b0;
  assign dbg_pd_maintain_off    = 1'b0;
  assign dbg_pd_maintain_0_only = 1'b0;
  assign dbg_ocb_mon_off        = 1'b0;
  assign dbg_inc_cpt            = 1'b0;
  assign dbg_dec_cpt            = 1'b0;
  assign dbg_inc_rd_dqs         = 1'b0;
  assign dbg_dec_rd_dqs         = 1'b0;
  assign dbg_inc_dec_sel        = 'b0;
  assign dbg_inc_rd_fps         = 1'b0;
  assign dbg_pd_msb_sel         = 'b0 ;
  assign dbg_sel_idel_cpt       = 'b0 ;	 
  assign dbg_sel_idel_rsync     = 'b0 ;
  assign dbg_pd_byte_sel        = 'b0 ;	
  assign dbg_dec_rd_fps         = 1'b0;
	
//  OBUF obuf_ddr3_sn[2:0](
//	.I (3'b111),
//	.O (ddr3_cs_n[3:1])
//	);

/*================================================
ICON and ILA core instantiations for monitoring the UI signals at the app_clk rate 

The ILA  wr core has a data port width of 109 bits with the following information

1) DATA[0] 	- app_en
2) DATA[1:32]	- app_addr
3) DATA[33:104] - app_wdf_data[72:0]
4) DATA[105]	- app_wdf_end
5) DATA[106]	- app_wren
6) DATA[107]	- app_wdf_rdy
7) DATA[108]	- app_rdy

The wr trigger signal is composed of 4 signals
 1) phy_rdy
 2) app_wdf_rdy
 3) app_rdy
 4) wren

Once all the signals are asserted and wren transitions from 0 to 1 (then start capturing 8192 samples)

The ILA  rd core has a data port width of 108 bits with the following information

1) DATA[0] 	- app_en
2) DATA[1:32]	- app_addr
3) DATA[33:104] - app_rd_data[72:0]
4) DATA[105]	- app_rd_data_valid
5) DATA[106]	- app_wdf_rdy
6) DATA[107]	- app_rdy

The rd trigger signal is composed of 5 signals
 1) phy_rdy
 2) app_wdf_rdy
 3) app_rdy
 4) app_cmd[0]
 5) app_rd_data_valid

Once all the signals are asserted and app_en transitions from 0 to 1 (then start capturing 8192 samples)

//
//==============================================*/
//
//wire [35:0] 	control_bus_0, control_bus_1; 
//wire [3:0] 	trigger_0;
//wire [4:0]	trigger_1;
//wire [108:0]	wr_data;
//wire [107:0]	rd_data;
//
//ddr3_ui_chipscope_icon ddr3_ui_chipscope_icon_inst (
//.CONTROL0	(control_bus_0),
//.CONTROL1	(control_bus_1)
//);
//
//assign trigger_0 = {phy_rdy,app_rdy,app_wdf_rdy,app_wdf_wren};
//assign trigger_1 = {phy_rdy,app_rdy,app_wdf_rdy,app_cmd[0],app_rd_data_valid};
//assign wr_data = {app_en,app_addr,app_wdf_data[71:0],app_wdf_end,app_wdf_wren,app_wdf_rdy,app_rdy};
//assign rd_data = {app_en,app_addr,app_rd_data[71:0],app_rd_data_valid,app_wdf_rdy,app_rdy};
//
//ddr3_ui_wr_chipscope_ila ddr3_ui_wr_chipscope_ila_inst (
//.CONTROL 	(control_bus_0),
//.CLK		(clk_div2),
//.DATA		(wr_data),
//.TRIG0	(trigger_0)
//);
//
//ddr3_ui_rd_chipscope_ila ddr3_ui_rd_chipscope_ila_inst (
//.CONTROL 	(control_bus_1),
//.CLK		(clk_div2),
//.DATA		(rd_data),
//.TRIG0	(trigger_1)
//);

endmodule
