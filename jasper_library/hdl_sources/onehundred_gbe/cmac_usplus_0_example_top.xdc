###------------------------------------------------------------------------------
###  (c) Copyright 2013 Xilinx, Inc. All rights reserved.
###
###  This file contains confidential and proprietary information
###  of Xilinx, Inc. and is protected under U.S. and
###  international copyright and other intellectual property
###  laws.
###
###  DISCLAIMER
###  This disclaimer is not a license and does not grant any
###  rights to the materials distributed herewith. Except as
###  otherwise provided in a valid license issued to you by
###  Xilinx, and to the maximum extent permitted by applicable
###  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
###  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
###  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
###  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
###  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
###  (2) Xilinx shall not be liable (whether in contract or tort,
###  including negligence, or under any other theory of
###  liability) for any loss or damage of any kind or nature
###  related to, arising under or in connection with these
###  materials, including for any direct, or any indirect,
###  special, incidental, or consequential loss or damage
###  (including loss of data, profits, goodwill, or any type of
###  loss or damage suffered as a result of any action brought
###  by a third party) even if such damage or loss was
###  reasonably foreseeable or Xilinx had been advised of the
###  possibility of the same.
###
###  CRITICAL APPLICATIONS
###  Xilinx products are not designed or intended to be fail-
###  safe, or for use in any application requiring fail-safe
###  performance, such as life-support or safety devices or
###  systems, Class III medical devices, nuclear facilities,
###  applications related to the deployment of airbags, or any
###  other applications that could lead to death, personal
###  injury, or severe property or environmental damage
###  (individually and collectively, "Critical
###  Applications"). Customer assumes the sole risk and
###  liability of any use of Xilinx products                                                                             in Critical
###  Applications, subject only to applicable laws and
###  regulations governing limitations on product liability.
###
###  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
###  PART OF THIS FILE AT ALL TIMES.
###------------------------------------------------------------------------------

### -----------------------------------------------------------------------------
### CMAC example design-level XDC file
### -----------------------------------------------------------------------------

create_clock -period 10.000 [get_ports init_clk]
set_property IOSTANDARD LVCMOS18 [get_ports init_clk]

create_clock -period 6.206 [get_ports gt_ref_clk_p]
#set_property IOSTANDARD DIFF_SSTL15 [get_ports gt_ref_clk_p]

### Transceiver Reference Clock Placement
### Transceivers should be adjacent to allow timing constraints to be met easily.
### Full details of available transceiver locations can be found in the appropriate
### Transceiver User Guide, or use the Transceiver Wizard.

### These are sample constraints, please use correct constraints for your device
### As per GT recommendation, gt_ref_clk should be connected to the middle quad

### Incase of VCU108-REV-1.0 Evaluation board with xcvu095-ffva2104-2-e device,
### if user selects CAUI10 GTY default gui configuration with CMAC core as CMAC_SITE_X0Y0
### and GT group X0Y4~X0Y13, the gt_ref_clk pin location is given below
### For other configuration / CMAC and GT locations, update the gt_ref_clk pin location accordingly
### and un-comment the below line
#set_property PACKAGE_PIN AK38 [get_ports gt_ref_clk_p]



### Change these IO constraints as per your board and device
### For better placement, please LOC the IO's in the same GT SLR region

### Below IO Loc XDC constraints are for VCU108-REV-1.0 Evaluation board
### with xcvu095-ffva2104-2-e-es2 device

### For init_clk input pin assignment, if single-ended clock is not available
### on the board, user has to instantiate IBUFDS in Example Design to convert
### the differential clock to single-ended clock and make the necessary changes
#set_property LOC AV33 [get_ports init_clk]
#set_property LOC E34 [get_ports sys_reset]
#set_property LOC C38 [get_ports send_continuous_pkts]
#set_property LOC AW27 [get_ports lbus_tx_rx_restart_in]
#set_property LOC AT32 [get_ports tx_done_led]
#set_property LOC AY30 [get_ports tx_busy_led]
#set_property LOC BB32 [get_ports rx_gt_locked_led]
#set_property LOC BF32 [get_ports rx_aligned_led]
#set_property LOC AV36 [get_ports rx_done_led]
#set_property LOC AY35 [get_ports rx_data_fail_led]
#set_property LOC BA37 [get_ports rx_busy_led]

set_property IOSTANDARD LVCMOS18 [get_ports sys_reset]
set_property IOSTANDARD LVCMOS18 [get_ports send_continuous_pkts]
set_property IOSTANDARD LVCMOS18 [get_ports lbus_tx_rx_restart_in]
set_property IOSTANDARD LVCMOS18 [get_ports tx_done_led]
set_property IOSTANDARD LVCMOS18 [get_ports tx_busy_led]
set_property IOSTANDARD LVCMOS18 [get_ports rx_gt_locked_led]
set_property IOSTANDARD LVCMOS18 [get_ports rx_aligned_led]
set_property IOSTANDARD LVCMOS18 [get_ports rx_done_led]
set_property IOSTANDARD LVCMOS18 [get_ports rx_data_fail_led]
set_property IOSTANDARD LVCMOS18 [get_ports rx_busy_led]

### Any other constraints can be added here
set_false_path -to [get_pins -leaf -of_objects [get_cells -hier *cdc_to* -filter is_sequential] -filter NAME=~*cmac_cdc*/*/D]



set_property PACKAGE_PIN BD23 [get_ports lbus_tx_rx_restart_in]
set_property PACKAGE_PIN AU37 [get_ports rx_aligned_led]
set_property PACKAGE_PIN BB32 [get_ports rx_busy_led]
set_property PACKAGE_PIN AV36 [get_ports rx_data_fail_led]
set_property PACKAGE_PIN AV34 [get_ports rx_done_led]
set_property PACKAGE_PIN BF32 [get_ports rx_gt_locked_led]
set_property PACKAGE_PIN BE22 [get_ports send_continuous_pkts]
set_property PACKAGE_PIN BB24 [get_ports sys_reset]
set_property PACKAGE_PIN AY30 [get_ports tx_busy_led]
set_property PACKAGE_PIN AT32 [get_ports tx_done_led]
set_property PACKAGE_PIN AW23 [get_ports init_clk_p]
set_property PACKAGE_PIN W9 [get_ports gt_ref_clk_p]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports init_clk_p]
