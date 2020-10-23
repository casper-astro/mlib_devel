////------------------------------------------------------------------------------
////  (c) Copyright 2013 Xilinx, Inc. All rights reserved.
////
////  This file contains confidential and proprietary information
////  of Xilinx, Inc. and is protected under U.S. and
////  international copyright and other intellectual property
////  laws.
////
////  DISCLAIMER
////  This disclaimer is not a license and does not grant any
////  rights to the materials distributed herewith. Except as
////  otherwise provided in a valid license issued to you by
////  Xilinx, and to the maximum extent permitted by applicable
////  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
////  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
////  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
////  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
////  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
////  (2) Xilinx shall not be liable (whether in contract or tort,
////  including negligence, or under any other theory of
////  liability) for any loss or damage of any kind or nature
////  related to, arising under or in connection with these
////  materials, including for any direct, or any indirect,
////  special, incidental, or consequential loss or damage
////  (including loss of data, profits, goodwill, or any type of
////  loss or damage suffered as a result of any action brought
////  by a third party) even if such damage or loss was
////  reasonably foreseeable or Xilinx had been advised of the
////  possibility of the same.
////
////  CRITICAL APPLICATIONS
////  Xilinx products are not designed or intended to be fail-
////  safe, or for use in any application requiring fail-safe
////  performance, such as life-support or safety devices or
////  systems, Class III medical devices, nuclear facilities,
////  applications related to the deployment of airbags, or any
////  other applications that could lead to death, personal
////  injury, or severe property or environmental damage
////  (individually and collectively, "Critical
////  Applications"). Customer assumes the sole risk and
////  liability of any use of Xilinx products in Critical
////  Applications, subject only to applicable laws and
////  regulations governing limitations on product liability.
////
////  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
////  PART OF THIS FILE AT ALL TIMES.
////------------------------------------------------------------------------------


`timescale 1fs/1fs

(* DowngradeIPIdentifiedWarnings="yes" *)
module xxv_ethernet_1_clocking_wrapper (
  input       gt_refclk_p,
  input       gt_refclk_n,
  output wire gt_refclk_out,
  output wire gt_refclk,
  input       qplllock,
  output wire dclk
  );
  wire  gt_refclkcopy;
 IBUFDS_GTE4 IBUFDS_GTE4_GTREFCLK0_INST (
    .I(gt_refclk_p),
    .IB(gt_refclk_n),
    .CEB(1'b0),
    .O(gt_refclk),
    .ODIV2(gt_refclkcopy)
  );
  

     BUFG_GT refclk_bufg_gt_i
  (
      .I       (gt_refclkcopy),
      .CE      (1'b1),
      .CEMASK  (1'b1),
      .CLR     (1'b0),
      .CLRMASK (1'b1),
      .DIV     (3'b000),
      .O       (gt_refclk_out)
  ); 

// MMCM to generate both clk156 and dclk
  wire mmcm_clk_fb;
  wire dclk_buf;
  MMCM_BASE #
  (
    .BANDWIDTH            ("OPTIMIZED"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (8.0),
    .CLKFBOUT_PHASE       (0.000),
    .CLKOUT0_DIVIDE_F     (16.000),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKIN1_PERIOD        (6.400),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .REF_JITTER1          (0.010)
  )
  clkgen_i
  (
    .CLKFBIN(mmcm_clk_fb),
    .CLKIN1(gt_refclk_out),
    .PWRDWN(1'b0),
    .RST(1'b0),
    .CLKFBOUT(mmcm_clk_fb),
    .CLKOUT0(dclk_buf),
    .LOCKED()
  );

  BUFG dclk_bufg_inst 
  (
      .I                              (dclk_buf),
      .O                              (dclk) 
  ); 

endmodule
  
  
  
  
  
  
  
  
