// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
// Date        : Tue Oct 11 13:47:45 2016
// Host        : adam-cm running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aisaacson/work/git_work/ska_sa/projects/skarab_bsp_firmware/firmware/FRM123701U1R1/Vivado/Source/SKA_40GbE_PHY/IEEE802_3_XL_PMA/IEEE802_3_XL_PMA.srcs/sources_1/ip/XLAUI/XLAUI_funcsim.v
// Design      : XLAUI
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "XLAUI,gtwizard_v3_4,{protocol_file=xlaui}" *) (* core_generation_info = "XLAUI,gtwizard_v3_4,{protocol_file=xlaui}" *) 
(* NotValidForBitStream *)
module XLAUI
   (SYSCLK_IN,
    SOFT_RESET_IN,
    DONT_RESET_ON_DATA_ERROR_IN,
    GT0_TX_FSM_RESET_DONE_OUT,
    GT0_RX_FSM_RESET_DONE_OUT,
    GT0_DATA_VALID_IN,
    GT0_TX_MMCM_LOCK_IN,
    GT0_TX_MMCM_RESET_OUT,
    GT0_RX_MMCM_LOCK_IN,
    GT0_RX_MMCM_RESET_OUT,
    GT1_TX_FSM_RESET_DONE_OUT,
    GT1_RX_FSM_RESET_DONE_OUT,
    GT1_DATA_VALID_IN,
    GT1_TX_MMCM_LOCK_IN,
    GT1_TX_MMCM_RESET_OUT,
    GT1_RX_MMCM_LOCK_IN,
    GT1_RX_MMCM_RESET_OUT,
    GT2_TX_FSM_RESET_DONE_OUT,
    GT2_RX_FSM_RESET_DONE_OUT,
    GT2_DATA_VALID_IN,
    GT2_TX_MMCM_LOCK_IN,
    GT2_TX_MMCM_RESET_OUT,
    GT2_RX_MMCM_LOCK_IN,
    GT2_RX_MMCM_RESET_OUT,
    GT3_TX_FSM_RESET_DONE_OUT,
    GT3_RX_FSM_RESET_DONE_OUT,
    GT3_DATA_VALID_IN,
    GT3_TX_MMCM_LOCK_IN,
    GT3_TX_MMCM_RESET_OUT,
    GT3_RX_MMCM_LOCK_IN,
    GT3_RX_MMCM_RESET_OUT,
    gt0_drpaddr_in,
    gt0_drpclk_in,
    gt0_drpdi_in,
    gt0_drpdo_out,
    gt0_drpen_in,
    gt0_drprdy_out,
    gt0_drpwe_in,
    gt0_loopback_in,
    gt0_eyescanreset_in,
    gt0_rxuserrdy_in,
    gt0_eyescandataerror_out,
    gt0_eyescantrigger_in,
    gt0_dmonitorout_out,
    gt0_rxusrclk_in,
    gt0_rxusrclk2_in,
    gt0_rxdata_out,
    gt0_rxprbserr_out,
    gt0_rxprbssel_in,
    gt0_rxprbscntreset_in,
    gt0_gthrxn_in,
    gt0_rxbufreset_in,
    gt0_rxbufstatus_out,
    gt0_rxmonitorout_out,
    gt0_rxmonitorsel_in,
    gt0_rxoutclk_out,
    gt0_rxdatavalid_out,
    gt0_rxheader_out,
    gt0_rxheadervalid_out,
    gt0_rxgearboxslip_in,
    gt0_gtrxreset_in,
    gt0_rxpcsreset_in,
    gt0_gthrxp_in,
    gt0_rxresetdone_out,
    gt0_gttxreset_in,
    gt0_txuserrdy_in,
    gt0_txheader_in,
    gt0_txusrclk_in,
    gt0_txusrclk2_in,
    gt0_txelecidle_in,
    gt0_txprbsforceerr_in,
    gt0_txbufstatus_out,
    gt0_txdata_in,
    gt0_gthtxn_out,
    gt0_gthtxp_out,
    gt0_txoutclk_out,
    gt0_txoutclkfabric_out,
    gt0_txoutclkpcs_out,
    gt0_txsequence_in,
    gt0_txpcsreset_in,
    gt0_txresetdone_out,
    gt0_txpolarity_in,
    gt0_txprbssel_in,
    gt1_drpaddr_in,
    gt1_drpclk_in,
    gt1_drpdi_in,
    gt1_drpdo_out,
    gt1_drpen_in,
    gt1_drprdy_out,
    gt1_drpwe_in,
    gt1_loopback_in,
    gt1_eyescanreset_in,
    gt1_rxuserrdy_in,
    gt1_eyescandataerror_out,
    gt1_eyescantrigger_in,
    gt1_dmonitorout_out,
    gt1_rxusrclk_in,
    gt1_rxusrclk2_in,
    gt1_rxdata_out,
    gt1_rxprbserr_out,
    gt1_rxprbssel_in,
    gt1_rxprbscntreset_in,
    gt1_gthrxn_in,
    gt1_rxbufreset_in,
    gt1_rxbufstatus_out,
    gt1_rxmonitorout_out,
    gt1_rxmonitorsel_in,
    gt1_rxoutclk_out,
    gt1_rxdatavalid_out,
    gt1_rxheader_out,
    gt1_rxheadervalid_out,
    gt1_rxgearboxslip_in,
    gt1_gtrxreset_in,
    gt1_rxpcsreset_in,
    gt1_gthrxp_in,
    gt1_rxresetdone_out,
    gt1_gttxreset_in,
    gt1_txuserrdy_in,
    gt1_txheader_in,
    gt1_txusrclk_in,
    gt1_txusrclk2_in,
    gt1_txelecidle_in,
    gt1_txprbsforceerr_in,
    gt1_txbufstatus_out,
    gt1_txdata_in,
    gt1_gthtxn_out,
    gt1_gthtxp_out,
    gt1_txoutclk_out,
    gt1_txoutclkfabric_out,
    gt1_txoutclkpcs_out,
    gt1_txsequence_in,
    gt1_txpcsreset_in,
    gt1_txresetdone_out,
    gt1_txpolarity_in,
    gt1_txprbssel_in,
    gt2_drpaddr_in,
    gt2_drpclk_in,
    gt2_drpdi_in,
    gt2_drpdo_out,
    gt2_drpen_in,
    gt2_drprdy_out,
    gt2_drpwe_in,
    gt2_loopback_in,
    gt2_eyescanreset_in,
    gt2_rxuserrdy_in,
    gt2_eyescandataerror_out,
    gt2_eyescantrigger_in,
    gt2_dmonitorout_out,
    gt2_rxusrclk_in,
    gt2_rxusrclk2_in,
    gt2_rxdata_out,
    gt2_rxprbserr_out,
    gt2_rxprbssel_in,
    gt2_rxprbscntreset_in,
    gt2_gthrxn_in,
    gt2_rxbufreset_in,
    gt2_rxbufstatus_out,
    gt2_rxmonitorout_out,
    gt2_rxmonitorsel_in,
    gt2_rxoutclk_out,
    gt2_rxdatavalid_out,
    gt2_rxheader_out,
    gt2_rxheadervalid_out,
    gt2_rxgearboxslip_in,
    gt2_gtrxreset_in,
    gt2_rxpcsreset_in,
    gt2_gthrxp_in,
    gt2_rxresetdone_out,
    gt2_gttxreset_in,
    gt2_txuserrdy_in,
    gt2_txheader_in,
    gt2_txusrclk_in,
    gt2_txusrclk2_in,
    gt2_txelecidle_in,
    gt2_txprbsforceerr_in,
    gt2_txbufstatus_out,
    gt2_txdata_in,
    gt2_gthtxn_out,
    gt2_gthtxp_out,
    gt2_txoutclk_out,
    gt2_txoutclkfabric_out,
    gt2_txoutclkpcs_out,
    gt2_txsequence_in,
    gt2_txpcsreset_in,
    gt2_txresetdone_out,
    gt2_txpolarity_in,
    gt2_txprbssel_in,
    gt3_drpaddr_in,
    gt3_drpclk_in,
    gt3_drpdi_in,
    gt3_drpdo_out,
    gt3_drpen_in,
    gt3_drprdy_out,
    gt3_drpwe_in,
    gt3_loopback_in,
    gt3_eyescanreset_in,
    gt3_rxuserrdy_in,
    gt3_eyescandataerror_out,
    gt3_eyescantrigger_in,
    gt3_dmonitorout_out,
    gt3_rxusrclk_in,
    gt3_rxusrclk2_in,
    gt3_rxdata_out,
    gt3_rxprbserr_out,
    gt3_rxprbssel_in,
    gt3_rxprbscntreset_in,
    gt3_gthrxn_in,
    gt3_rxbufreset_in,
    gt3_rxbufstatus_out,
    gt3_rxmonitorout_out,
    gt3_rxmonitorsel_in,
    gt3_rxoutclk_out,
    gt3_rxdatavalid_out,
    gt3_rxheader_out,
    gt3_rxheadervalid_out,
    gt3_rxgearboxslip_in,
    gt3_gtrxreset_in,
    gt3_rxpcsreset_in,
    gt3_gthrxp_in,
    gt3_rxresetdone_out,
    gt3_gttxreset_in,
    gt3_txuserrdy_in,
    gt3_txheader_in,
    gt3_txusrclk_in,
    gt3_txusrclk2_in,
    gt3_txelecidle_in,
    gt3_txprbsforceerr_in,
    gt3_txbufstatus_out,
    gt3_txdata_in,
    gt3_gthtxn_out,
    gt3_gthtxp_out,
    gt3_txoutclk_out,
    gt3_txoutclkfabric_out,
    gt3_txoutclkpcs_out,
    gt3_txsequence_in,
    gt3_txpcsreset_in,
    gt3_txresetdone_out,
    gt3_txpolarity_in,
    gt3_txprbssel_in,
    GT0_QPLLLOCK_IN,
    GT0_QPLLREFCLKLOST_IN,
    GT0_QPLLRESET_OUT,
    GT0_QPLLOUTCLK_IN,
    GT0_QPLLOUTREFCLK_IN);
  input SYSCLK_IN;
  input SOFT_RESET_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  output GT0_TX_FSM_RESET_DONE_OUT;
  output GT0_RX_FSM_RESET_DONE_OUT;
  input GT0_DATA_VALID_IN;
  input GT0_TX_MMCM_LOCK_IN;
  output GT0_TX_MMCM_RESET_OUT;
  input GT0_RX_MMCM_LOCK_IN;
  output GT0_RX_MMCM_RESET_OUT;
  output GT1_TX_FSM_RESET_DONE_OUT;
  output GT1_RX_FSM_RESET_DONE_OUT;
  input GT1_DATA_VALID_IN;
  input GT1_TX_MMCM_LOCK_IN;
  output GT1_TX_MMCM_RESET_OUT;
  input GT1_RX_MMCM_LOCK_IN;
  output GT1_RX_MMCM_RESET_OUT;
  output GT2_TX_FSM_RESET_DONE_OUT;
  output GT2_RX_FSM_RESET_DONE_OUT;
  input GT2_DATA_VALID_IN;
  input GT2_TX_MMCM_LOCK_IN;
  output GT2_TX_MMCM_RESET_OUT;
  input GT2_RX_MMCM_LOCK_IN;
  output GT2_RX_MMCM_RESET_OUT;
  output GT3_TX_FSM_RESET_DONE_OUT;
  output GT3_RX_FSM_RESET_DONE_OUT;
  input GT3_DATA_VALID_IN;
  input GT3_TX_MMCM_LOCK_IN;
  output GT3_TX_MMCM_RESET_OUT;
  input GT3_RX_MMCM_LOCK_IN;
  output GT3_RX_MMCM_RESET_OUT;
  input [8:0]gt0_drpaddr_in;
  input gt0_drpclk_in;
  input [15:0]gt0_drpdi_in;
  output [15:0]gt0_drpdo_out;
  input gt0_drpen_in;
  output gt0_drprdy_out;
  input gt0_drpwe_in;
  input [2:0]gt0_loopback_in;
  input gt0_eyescanreset_in;
  input gt0_rxuserrdy_in;
  output gt0_eyescandataerror_out;
  input gt0_eyescantrigger_in;
  output [14:0]gt0_dmonitorout_out;
  input gt0_rxusrclk_in;
  input gt0_rxusrclk2_in;
  output [63:0]gt0_rxdata_out;
  output gt0_rxprbserr_out;
  input [2:0]gt0_rxprbssel_in;
  input gt0_rxprbscntreset_in;
  input gt0_gthrxn_in;
  input gt0_rxbufreset_in;
  output [2:0]gt0_rxbufstatus_out;
  output [6:0]gt0_rxmonitorout_out;
  input [1:0]gt0_rxmonitorsel_in;
  output gt0_rxoutclk_out;
  output gt0_rxdatavalid_out;
  output [1:0]gt0_rxheader_out;
  output gt0_rxheadervalid_out;
  input gt0_rxgearboxslip_in;
  input gt0_gtrxreset_in;
  input gt0_rxpcsreset_in;
  input gt0_gthrxp_in;
  output gt0_rxresetdone_out;
  input gt0_gttxreset_in;
  input gt0_txuserrdy_in;
  input [1:0]gt0_txheader_in;
  input gt0_txusrclk_in;
  input gt0_txusrclk2_in;
  input gt0_txelecidle_in;
  input gt0_txprbsforceerr_in;
  output [1:0]gt0_txbufstatus_out;
  input [63:0]gt0_txdata_in;
  output gt0_gthtxn_out;
  output gt0_gthtxp_out;
  output gt0_txoutclk_out;
  output gt0_txoutclkfabric_out;
  output gt0_txoutclkpcs_out;
  input [6:0]gt0_txsequence_in;
  input gt0_txpcsreset_in;
  output gt0_txresetdone_out;
  input gt0_txpolarity_in;
  input [2:0]gt0_txprbssel_in;
  input [8:0]gt1_drpaddr_in;
  input gt1_drpclk_in;
  input [15:0]gt1_drpdi_in;
  output [15:0]gt1_drpdo_out;
  input gt1_drpen_in;
  output gt1_drprdy_out;
  input gt1_drpwe_in;
  input [2:0]gt1_loopback_in;
  input gt1_eyescanreset_in;
  input gt1_rxuserrdy_in;
  output gt1_eyescandataerror_out;
  input gt1_eyescantrigger_in;
  output [14:0]gt1_dmonitorout_out;
  input gt1_rxusrclk_in;
  input gt1_rxusrclk2_in;
  output [63:0]gt1_rxdata_out;
  output gt1_rxprbserr_out;
  input [2:0]gt1_rxprbssel_in;
  input gt1_rxprbscntreset_in;
  input gt1_gthrxn_in;
  input gt1_rxbufreset_in;
  output [2:0]gt1_rxbufstatus_out;
  output [6:0]gt1_rxmonitorout_out;
  input [1:0]gt1_rxmonitorsel_in;
  output gt1_rxoutclk_out;
  output gt1_rxdatavalid_out;
  output [1:0]gt1_rxheader_out;
  output gt1_rxheadervalid_out;
  input gt1_rxgearboxslip_in;
  input gt1_gtrxreset_in;
  input gt1_rxpcsreset_in;
  input gt1_gthrxp_in;
  output gt1_rxresetdone_out;
  input gt1_gttxreset_in;
  input gt1_txuserrdy_in;
  input [1:0]gt1_txheader_in;
  input gt1_txusrclk_in;
  input gt1_txusrclk2_in;
  input gt1_txelecidle_in;
  input gt1_txprbsforceerr_in;
  output [1:0]gt1_txbufstatus_out;
  input [63:0]gt1_txdata_in;
  output gt1_gthtxn_out;
  output gt1_gthtxp_out;
  output gt1_txoutclk_out;
  output gt1_txoutclkfabric_out;
  output gt1_txoutclkpcs_out;
  input [6:0]gt1_txsequence_in;
  input gt1_txpcsreset_in;
  output gt1_txresetdone_out;
  input gt1_txpolarity_in;
  input [2:0]gt1_txprbssel_in;
  input [8:0]gt2_drpaddr_in;
  input gt2_drpclk_in;
  input [15:0]gt2_drpdi_in;
  output [15:0]gt2_drpdo_out;
  input gt2_drpen_in;
  output gt2_drprdy_out;
  input gt2_drpwe_in;
  input [2:0]gt2_loopback_in;
  input gt2_eyescanreset_in;
  input gt2_rxuserrdy_in;
  output gt2_eyescandataerror_out;
  input gt2_eyescantrigger_in;
  output [14:0]gt2_dmonitorout_out;
  input gt2_rxusrclk_in;
  input gt2_rxusrclk2_in;
  output [63:0]gt2_rxdata_out;
  output gt2_rxprbserr_out;
  input [2:0]gt2_rxprbssel_in;
  input gt2_rxprbscntreset_in;
  input gt2_gthrxn_in;
  input gt2_rxbufreset_in;
  output [2:0]gt2_rxbufstatus_out;
  output [6:0]gt2_rxmonitorout_out;
  input [1:0]gt2_rxmonitorsel_in;
  output gt2_rxoutclk_out;
  output gt2_rxdatavalid_out;
  output [1:0]gt2_rxheader_out;
  output gt2_rxheadervalid_out;
  input gt2_rxgearboxslip_in;
  input gt2_gtrxreset_in;
  input gt2_rxpcsreset_in;
  input gt2_gthrxp_in;
  output gt2_rxresetdone_out;
  input gt2_gttxreset_in;
  input gt2_txuserrdy_in;
  input [1:0]gt2_txheader_in;
  input gt2_txusrclk_in;
  input gt2_txusrclk2_in;
  input gt2_txelecidle_in;
  input gt2_txprbsforceerr_in;
  output [1:0]gt2_txbufstatus_out;
  input [63:0]gt2_txdata_in;
  output gt2_gthtxn_out;
  output gt2_gthtxp_out;
  output gt2_txoutclk_out;
  output gt2_txoutclkfabric_out;
  output gt2_txoutclkpcs_out;
  input [6:0]gt2_txsequence_in;
  input gt2_txpcsreset_in;
  output gt2_txresetdone_out;
  input gt2_txpolarity_in;
  input [2:0]gt2_txprbssel_in;
  input [8:0]gt3_drpaddr_in;
  input gt3_drpclk_in;
  input [15:0]gt3_drpdi_in;
  output [15:0]gt3_drpdo_out;
  input gt3_drpen_in;
  output gt3_drprdy_out;
  input gt3_drpwe_in;
  input [2:0]gt3_loopback_in;
  input gt3_eyescanreset_in;
  input gt3_rxuserrdy_in;
  output gt3_eyescandataerror_out;
  input gt3_eyescantrigger_in;
  output [14:0]gt3_dmonitorout_out;
  input gt3_rxusrclk_in;
  input gt3_rxusrclk2_in;
  output [63:0]gt3_rxdata_out;
  output gt3_rxprbserr_out;
  input [2:0]gt3_rxprbssel_in;
  input gt3_rxprbscntreset_in;
  input gt3_gthrxn_in;
  input gt3_rxbufreset_in;
  output [2:0]gt3_rxbufstatus_out;
  output [6:0]gt3_rxmonitorout_out;
  input [1:0]gt3_rxmonitorsel_in;
  output gt3_rxoutclk_out;
  output gt3_rxdatavalid_out;
  output [1:0]gt3_rxheader_out;
  output gt3_rxheadervalid_out;
  input gt3_rxgearboxslip_in;
  input gt3_gtrxreset_in;
  input gt3_rxpcsreset_in;
  input gt3_gthrxp_in;
  output gt3_rxresetdone_out;
  input gt3_gttxreset_in;
  input gt3_txuserrdy_in;
  input [1:0]gt3_txheader_in;
  input gt3_txusrclk_in;
  input gt3_txusrclk2_in;
  input gt3_txelecidle_in;
  input gt3_txprbsforceerr_in;
  output [1:0]gt3_txbufstatus_out;
  input [63:0]gt3_txdata_in;
  output gt3_gthtxn_out;
  output gt3_gthtxp_out;
  output gt3_txoutclk_out;
  output gt3_txoutclkfabric_out;
  output gt3_txoutclkpcs_out;
  input [6:0]gt3_txsequence_in;
  input gt3_txpcsreset_in;
  output gt3_txresetdone_out;
  input gt3_txpolarity_in;
  input [2:0]gt3_txprbssel_in;
  input GT0_QPLLLOCK_IN;
  input GT0_QPLLREFCLKLOST_IN;
  output GT0_QPLLRESET_OUT;
  input GT0_QPLLOUTCLK_IN;
  input GT0_QPLLOUTREFCLK_IN;

  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire GT0_DATA_VALID_IN;
  wire GT0_QPLLLOCK_IN;
  wire GT0_QPLLOUTCLK_IN;
  wire GT0_QPLLOUTREFCLK_IN;
  wire GT0_QPLLRESET_OUT;
  wire GT0_RX_FSM_RESET_DONE_OUT;
  wire GT0_RX_MMCM_LOCK_IN;
  wire GT0_RX_MMCM_RESET_OUT;
  wire GT0_TX_FSM_RESET_DONE_OUT;
  wire GT0_TX_MMCM_LOCK_IN;
  wire GT0_TX_MMCM_RESET_OUT;
  wire GT1_DATA_VALID_IN;
  wire GT1_RX_FSM_RESET_DONE_OUT;
  wire GT1_RX_MMCM_LOCK_IN;
  wire GT1_RX_MMCM_RESET_OUT;
  wire GT1_TX_FSM_RESET_DONE_OUT;
  wire GT1_TX_MMCM_LOCK_IN;
  wire GT1_TX_MMCM_RESET_OUT;
  wire GT2_DATA_VALID_IN;
  wire GT2_RX_FSM_RESET_DONE_OUT;
  wire GT2_RX_MMCM_LOCK_IN;
  wire GT2_RX_MMCM_RESET_OUT;
  wire GT2_TX_FSM_RESET_DONE_OUT;
  wire GT2_TX_MMCM_LOCK_IN;
  wire GT2_TX_MMCM_RESET_OUT;
  wire GT3_DATA_VALID_IN;
  wire GT3_RX_FSM_RESET_DONE_OUT;
  wire GT3_RX_MMCM_LOCK_IN;
  wire GT3_RX_MMCM_RESET_OUT;
  wire GT3_TX_FSM_RESET_DONE_OUT;
  wire GT3_TX_MMCM_LOCK_IN;
  wire GT3_TX_MMCM_RESET_OUT;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire [14:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drprdy_out;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire gt0_gthrxn_in;
  wire gt0_gthrxp_in;
  wire gt0_gthtxn_out;
  wire gt0_gthtxp_out;
  wire [2:0]gt0_loopback_in;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire [63:0]gt0_rxdata_out;
  wire gt0_rxdatavalid_out;
  wire gt0_rxgearboxslip_in;
  wire [1:0]gt0_rxheader_out;
  wire gt0_rxheadervalid_out;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire gt0_rxoutclk_out;
  wire gt0_rxpcsreset_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire gt0_rxresetdone_out;
  wire gt0_rxusrclk2_in;
  wire gt0_rxusrclk_in;
  wire [1:0]gt0_txbufstatus_out;
  wire [63:0]gt0_txdata_in;
  wire gt0_txelecidle_in;
  wire [1:0]gt0_txheader_in;
  wire gt0_txoutclk_out;
  wire gt0_txoutclkfabric_out;
  wire gt0_txoutclkpcs_out;
  wire gt0_txpcsreset_in;
  wire gt0_txpolarity_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire gt0_txresetdone_out;
  wire [6:0]gt0_txsequence_in;
  wire gt0_txusrclk2_in;
  wire gt0_txusrclk_in;
  wire [14:0]gt1_dmonitorout_out;
  wire [8:0]gt1_drpaddr_in;
  wire gt1_drpclk_in;
  wire [15:0]gt1_drpdi_in;
  wire [15:0]gt1_drpdo_out;
  wire gt1_drpen_in;
  wire gt1_drprdy_out;
  wire gt1_drpwe_in;
  wire gt1_eyescandataerror_out;
  wire gt1_eyescanreset_in;
  wire gt1_eyescantrigger_in;
  wire gt1_gthrxn_in;
  wire gt1_gthrxp_in;
  wire gt1_gthtxn_out;
  wire gt1_gthtxp_out;
  wire [2:0]gt1_loopback_in;
  wire gt1_rxbufreset_in;
  wire [2:0]gt1_rxbufstatus_out;
  wire [63:0]gt1_rxdata_out;
  wire gt1_rxdatavalid_out;
  wire gt1_rxgearboxslip_in;
  wire [1:0]gt1_rxheader_out;
  wire gt1_rxheadervalid_out;
  wire [6:0]gt1_rxmonitorout_out;
  wire [1:0]gt1_rxmonitorsel_in;
  wire gt1_rxoutclk_out;
  wire gt1_rxpcsreset_in;
  wire gt1_rxprbscntreset_in;
  wire gt1_rxprbserr_out;
  wire [2:0]gt1_rxprbssel_in;
  wire gt1_rxresetdone_out;
  wire gt1_rxusrclk2_in;
  wire gt1_rxusrclk_in;
  wire [1:0]gt1_txbufstatus_out;
  wire [63:0]gt1_txdata_in;
  wire gt1_txelecidle_in;
  wire [1:0]gt1_txheader_in;
  wire gt1_txoutclk_out;
  wire gt1_txoutclkfabric_out;
  wire gt1_txoutclkpcs_out;
  wire gt1_txpcsreset_in;
  wire gt1_txpolarity_in;
  wire gt1_txprbsforceerr_in;
  wire [2:0]gt1_txprbssel_in;
  wire gt1_txresetdone_out;
  wire [6:0]gt1_txsequence_in;
  wire gt1_txusrclk2_in;
  wire gt1_txusrclk_in;
  wire [14:0]gt2_dmonitorout_out;
  wire [8:0]gt2_drpaddr_in;
  wire gt2_drpclk_in;
  wire [15:0]gt2_drpdi_in;
  wire [15:0]gt2_drpdo_out;
  wire gt2_drpen_in;
  wire gt2_drprdy_out;
  wire gt2_drpwe_in;
  wire gt2_eyescandataerror_out;
  wire gt2_eyescanreset_in;
  wire gt2_eyescantrigger_in;
  wire gt2_gthrxn_in;
  wire gt2_gthrxp_in;
  wire gt2_gthtxn_out;
  wire gt2_gthtxp_out;
  wire [2:0]gt2_loopback_in;
  wire gt2_rxbufreset_in;
  wire [2:0]gt2_rxbufstatus_out;
  wire [63:0]gt2_rxdata_out;
  wire gt2_rxdatavalid_out;
  wire gt2_rxgearboxslip_in;
  wire [1:0]gt2_rxheader_out;
  wire gt2_rxheadervalid_out;
  wire [6:0]gt2_rxmonitorout_out;
  wire [1:0]gt2_rxmonitorsel_in;
  wire gt2_rxoutclk_out;
  wire gt2_rxpcsreset_in;
  wire gt2_rxprbscntreset_in;
  wire gt2_rxprbserr_out;
  wire [2:0]gt2_rxprbssel_in;
  wire gt2_rxresetdone_out;
  wire gt2_rxusrclk2_in;
  wire gt2_rxusrclk_in;
  wire [1:0]gt2_txbufstatus_out;
  wire [63:0]gt2_txdata_in;
  wire gt2_txelecidle_in;
  wire [1:0]gt2_txheader_in;
  wire gt2_txoutclk_out;
  wire gt2_txoutclkfabric_out;
  wire gt2_txoutclkpcs_out;
  wire gt2_txpcsreset_in;
  wire gt2_txpolarity_in;
  wire gt2_txprbsforceerr_in;
  wire [2:0]gt2_txprbssel_in;
  wire gt2_txresetdone_out;
  wire [6:0]gt2_txsequence_in;
  wire gt2_txusrclk2_in;
  wire gt2_txusrclk_in;
  wire [14:0]gt3_dmonitorout_out;
  wire [8:0]gt3_drpaddr_in;
  wire gt3_drpclk_in;
  wire [15:0]gt3_drpdi_in;
  wire [15:0]gt3_drpdo_out;
  wire gt3_drpen_in;
  wire gt3_drprdy_out;
  wire gt3_drpwe_in;
  wire gt3_eyescandataerror_out;
  wire gt3_eyescanreset_in;
  wire gt3_eyescantrigger_in;
  wire gt3_gthrxn_in;
  wire gt3_gthrxp_in;
  wire gt3_gthtxn_out;
  wire gt3_gthtxp_out;
  wire [2:0]gt3_loopback_in;
  wire gt3_rxbufreset_in;
  wire [2:0]gt3_rxbufstatus_out;
  wire [63:0]gt3_rxdata_out;
  wire gt3_rxdatavalid_out;
  wire gt3_rxgearboxslip_in;
  wire [1:0]gt3_rxheader_out;
  wire gt3_rxheadervalid_out;
  wire [6:0]gt3_rxmonitorout_out;
  wire [1:0]gt3_rxmonitorsel_in;
  wire gt3_rxoutclk_out;
  wire gt3_rxpcsreset_in;
  wire gt3_rxprbscntreset_in;
  wire gt3_rxprbserr_out;
  wire [2:0]gt3_rxprbssel_in;
  wire gt3_rxresetdone_out;
  wire gt3_rxusrclk2_in;
  wire gt3_rxusrclk_in;
  wire [1:0]gt3_txbufstatus_out;
  wire [63:0]gt3_txdata_in;
  wire gt3_txelecidle_in;
  wire [1:0]gt3_txheader_in;
  wire gt3_txoutclk_out;
  wire gt3_txoutclkfabric_out;
  wire gt3_txoutclkpcs_out;
  wire gt3_txpcsreset_in;
  wire gt3_txpolarity_in;
  wire gt3_txprbsforceerr_in;
  wire [2:0]gt3_txprbssel_in;
  wire gt3_txresetdone_out;
  wire [6:0]gt3_txsequence_in;
  wire gt3_txusrclk2_in;
  wire gt3_txusrclk_in;

XLAUI_XLAUI_init__parameterized0 U0
       (.DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .GT0_DATA_VALID_IN(GT0_DATA_VALID_IN),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT0_QPLLRESET_OUT(GT0_QPLLRESET_OUT),
        .GT0_RX_FSM_RESET_DONE_OUT(GT0_RX_FSM_RESET_DONE_OUT),
        .GT0_RX_MMCM_LOCK_IN(GT0_RX_MMCM_LOCK_IN),
        .GT0_RX_MMCM_RESET_OUT(GT0_RX_MMCM_RESET_OUT),
        .GT0_TX_FSM_RESET_DONE_OUT(GT0_TX_FSM_RESET_DONE_OUT),
        .GT0_TX_MMCM_LOCK_IN(GT0_TX_MMCM_LOCK_IN),
        .GT0_TX_MMCM_RESET_OUT(GT0_TX_MMCM_RESET_OUT),
        .GT1_DATA_VALID_IN(GT1_DATA_VALID_IN),
        .GT1_RX_FSM_RESET_DONE_OUT(GT1_RX_FSM_RESET_DONE_OUT),
        .GT1_RX_MMCM_LOCK_IN(GT1_RX_MMCM_LOCK_IN),
        .GT1_RX_MMCM_RESET_OUT(GT1_RX_MMCM_RESET_OUT),
        .GT1_TX_FSM_RESET_DONE_OUT(GT1_TX_FSM_RESET_DONE_OUT),
        .GT1_TX_MMCM_LOCK_IN(GT1_TX_MMCM_LOCK_IN),
        .GT1_TX_MMCM_RESET_OUT(GT1_TX_MMCM_RESET_OUT),
        .GT2_DATA_VALID_IN(GT2_DATA_VALID_IN),
        .GT2_RX_FSM_RESET_DONE_OUT(GT2_RX_FSM_RESET_DONE_OUT),
        .GT2_RX_MMCM_LOCK_IN(GT2_RX_MMCM_LOCK_IN),
        .GT2_RX_MMCM_RESET_OUT(GT2_RX_MMCM_RESET_OUT),
        .GT2_TX_FSM_RESET_DONE_OUT(GT2_TX_FSM_RESET_DONE_OUT),
        .GT2_TX_MMCM_LOCK_IN(GT2_TX_MMCM_LOCK_IN),
        .GT2_TX_MMCM_RESET_OUT(GT2_TX_MMCM_RESET_OUT),
        .GT3_DATA_VALID_IN(GT3_DATA_VALID_IN),
        .GT3_RX_FSM_RESET_DONE_OUT(GT3_RX_FSM_RESET_DONE_OUT),
        .GT3_RX_MMCM_LOCK_IN(GT3_RX_MMCM_LOCK_IN),
        .GT3_RX_MMCM_RESET_OUT(GT3_RX_MMCM_RESET_OUT),
        .GT3_TX_FSM_RESET_DONE_OUT(GT3_TX_FSM_RESET_DONE_OUT),
        .GT3_TX_MMCM_LOCK_IN(GT3_TX_MMCM_LOCK_IN),
        .GT3_TX_MMCM_RESET_OUT(GT3_TX_MMCM_RESET_OUT),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .gt0_dmonitorout_out(gt0_dmonitorout_out),
        .gt0_drpaddr_in(gt0_drpaddr_in),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdi_in(gt0_drpdi_in),
        .gt0_drpdo_out(gt0_drpdo_out),
        .gt0_drpen_in(gt0_drpen_in),
        .gt0_drprdy_out(gt0_drprdy_out),
        .gt0_drpwe_in(gt0_drpwe_in),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_gthrxn_in(gt0_gthrxn_in),
        .gt0_gthrxp_in(gt0_gthrxp_in),
        .gt0_gthtxn_out(gt0_gthtxn_out),
        .gt0_gthtxp_out(gt0_gthtxp_out),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_rxbufreset_in(gt0_rxbufreset_in),
        .gt0_rxbufstatus_out(gt0_rxbufstatus_out),
        .gt0_rxdata_out(gt0_rxdata_out),
        .gt0_rxdatavalid_out(gt0_rxdatavalid_out),
        .gt0_rxgearboxslip_in(gt0_rxgearboxslip_in),
        .gt0_rxheader_out(gt0_rxheader_out),
        .gt0_rxheadervalid_out(gt0_rxheadervalid_out),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxoutclk_out(gt0_rxoutclk_out),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_rxresetdone_out(gt0_rxresetdone_out),
        .gt0_rxusrclk2_in(gt0_rxusrclk2_in),
        .gt0_rxusrclk_in(gt0_rxusrclk_in),
        .gt0_txbufstatus_out(gt0_txbufstatus_out),
        .gt0_txdata_in(gt0_txdata_in),
        .gt0_txelecidle_in(gt0_txelecidle_in),
        .gt0_txheader_in(gt0_txheader_in),
        .gt0_txoutclk_out(gt0_txoutclk_out),
        .gt0_txoutclkfabric_out(gt0_txoutclkfabric_out),
        .gt0_txoutclkpcs_out(gt0_txoutclkpcs_out),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txresetdone_out(gt0_txresetdone_out),
        .gt0_txsequence_in(gt0_txsequence_in),
        .gt0_txusrclk2_in(gt0_txusrclk2_in),
        .gt0_txusrclk_in(gt0_txusrclk_in),
        .gt1_dmonitorout_out(gt1_dmonitorout_out),
        .gt1_drpaddr_in(gt1_drpaddr_in),
        .gt1_drpclk_in(gt1_drpclk_in),
        .gt1_drpdi_in(gt1_drpdi_in),
        .gt1_drpdo_out(gt1_drpdo_out),
        .gt1_drpen_in(gt1_drpen_in),
        .gt1_drprdy_out(gt1_drprdy_out),
        .gt1_drpwe_in(gt1_drpwe_in),
        .gt1_eyescandataerror_out(gt1_eyescandataerror_out),
        .gt1_eyescanreset_in(gt1_eyescanreset_in),
        .gt1_eyescantrigger_in(gt1_eyescantrigger_in),
        .gt1_gthrxn_in(gt1_gthrxn_in),
        .gt1_gthrxp_in(gt1_gthrxp_in),
        .gt1_gthtxn_out(gt1_gthtxn_out),
        .gt1_gthtxp_out(gt1_gthtxp_out),
        .gt1_loopback_in(gt1_loopback_in),
        .gt1_rxbufreset_in(gt1_rxbufreset_in),
        .gt1_rxbufstatus_out(gt1_rxbufstatus_out),
        .gt1_rxdata_out(gt1_rxdata_out),
        .gt1_rxdatavalid_out(gt1_rxdatavalid_out),
        .gt1_rxgearboxslip_in(gt1_rxgearboxslip_in),
        .gt1_rxheader_out(gt1_rxheader_out),
        .gt1_rxheadervalid_out(gt1_rxheadervalid_out),
        .gt1_rxmonitorout_out(gt1_rxmonitorout_out),
        .gt1_rxmonitorsel_in(gt1_rxmonitorsel_in),
        .gt1_rxoutclk_out(gt1_rxoutclk_out),
        .gt1_rxpcsreset_in(gt1_rxpcsreset_in),
        .gt1_rxprbscntreset_in(gt1_rxprbscntreset_in),
        .gt1_rxprbserr_out(gt1_rxprbserr_out),
        .gt1_rxprbssel_in(gt1_rxprbssel_in),
        .gt1_rxresetdone_out(gt1_rxresetdone_out),
        .gt1_rxusrclk2_in(gt1_rxusrclk2_in),
        .gt1_rxusrclk_in(gt1_rxusrclk_in),
        .gt1_txbufstatus_out(gt1_txbufstatus_out),
        .gt1_txdata_in(gt1_txdata_in),
        .gt1_txelecidle_in(gt1_txelecidle_in),
        .gt1_txheader_in(gt1_txheader_in),
        .gt1_txoutclk_out(gt1_txoutclk_out),
        .gt1_txoutclkfabric_out(gt1_txoutclkfabric_out),
        .gt1_txoutclkpcs_out(gt1_txoutclkpcs_out),
        .gt1_txpcsreset_in(gt1_txpcsreset_in),
        .gt1_txpolarity_in(gt1_txpolarity_in),
        .gt1_txprbsforceerr_in(gt1_txprbsforceerr_in),
        .gt1_txprbssel_in(gt1_txprbssel_in),
        .gt1_txresetdone_out(gt1_txresetdone_out),
        .gt1_txsequence_in(gt1_txsequence_in),
        .gt1_txusrclk2_in(gt1_txusrclk2_in),
        .gt1_txusrclk_in(gt1_txusrclk_in),
        .gt2_dmonitorout_out(gt2_dmonitorout_out),
        .gt2_drpaddr_in(gt2_drpaddr_in),
        .gt2_drpclk_in(gt2_drpclk_in),
        .gt2_drpdi_in(gt2_drpdi_in),
        .gt2_drpdo_out(gt2_drpdo_out),
        .gt2_drpen_in(gt2_drpen_in),
        .gt2_drprdy_out(gt2_drprdy_out),
        .gt2_drpwe_in(gt2_drpwe_in),
        .gt2_eyescandataerror_out(gt2_eyescandataerror_out),
        .gt2_eyescanreset_in(gt2_eyescanreset_in),
        .gt2_eyescantrigger_in(gt2_eyescantrigger_in),
        .gt2_gthrxn_in(gt2_gthrxn_in),
        .gt2_gthrxp_in(gt2_gthrxp_in),
        .gt2_gthtxn_out(gt2_gthtxn_out),
        .gt2_gthtxp_out(gt2_gthtxp_out),
        .gt2_loopback_in(gt2_loopback_in),
        .gt2_rxbufreset_in(gt2_rxbufreset_in),
        .gt2_rxbufstatus_out(gt2_rxbufstatus_out),
        .gt2_rxdata_out(gt2_rxdata_out),
        .gt2_rxdatavalid_out(gt2_rxdatavalid_out),
        .gt2_rxgearboxslip_in(gt2_rxgearboxslip_in),
        .gt2_rxheader_out(gt2_rxheader_out),
        .gt2_rxheadervalid_out(gt2_rxheadervalid_out),
        .gt2_rxmonitorout_out(gt2_rxmonitorout_out),
        .gt2_rxmonitorsel_in(gt2_rxmonitorsel_in),
        .gt2_rxoutclk_out(gt2_rxoutclk_out),
        .gt2_rxpcsreset_in(gt2_rxpcsreset_in),
        .gt2_rxprbscntreset_in(gt2_rxprbscntreset_in),
        .gt2_rxprbserr_out(gt2_rxprbserr_out),
        .gt2_rxprbssel_in(gt2_rxprbssel_in),
        .gt2_rxresetdone_out(gt2_rxresetdone_out),
        .gt2_rxusrclk2_in(gt2_rxusrclk2_in),
        .gt2_rxusrclk_in(gt2_rxusrclk_in),
        .gt2_txbufstatus_out(gt2_txbufstatus_out),
        .gt2_txdata_in(gt2_txdata_in),
        .gt2_txelecidle_in(gt2_txelecidle_in),
        .gt2_txheader_in(gt2_txheader_in),
        .gt2_txoutclk_out(gt2_txoutclk_out),
        .gt2_txoutclkfabric_out(gt2_txoutclkfabric_out),
        .gt2_txoutclkpcs_out(gt2_txoutclkpcs_out),
        .gt2_txpcsreset_in(gt2_txpcsreset_in),
        .gt2_txpolarity_in(gt2_txpolarity_in),
        .gt2_txprbsforceerr_in(gt2_txprbsforceerr_in),
        .gt2_txprbssel_in(gt2_txprbssel_in),
        .gt2_txresetdone_out(gt2_txresetdone_out),
        .gt2_txsequence_in(gt2_txsequence_in),
        .gt2_txusrclk2_in(gt2_txusrclk2_in),
        .gt2_txusrclk_in(gt2_txusrclk_in),
        .gt3_dmonitorout_out(gt3_dmonitorout_out),
        .gt3_drpaddr_in(gt3_drpaddr_in),
        .gt3_drpclk_in(gt3_drpclk_in),
        .gt3_drpdi_in(gt3_drpdi_in),
        .gt3_drpdo_out(gt3_drpdo_out),
        .gt3_drpen_in(gt3_drpen_in),
        .gt3_drprdy_out(gt3_drprdy_out),
        .gt3_drpwe_in(gt3_drpwe_in),
        .gt3_eyescandataerror_out(gt3_eyescandataerror_out),
        .gt3_eyescanreset_in(gt3_eyescanreset_in),
        .gt3_eyescantrigger_in(gt3_eyescantrigger_in),
        .gt3_gthrxn_in(gt3_gthrxn_in),
        .gt3_gthrxp_in(gt3_gthrxp_in),
        .gt3_gthtxn_out(gt3_gthtxn_out),
        .gt3_gthtxp_out(gt3_gthtxp_out),
        .gt3_loopback_in(gt3_loopback_in),
        .gt3_rxbufreset_in(gt3_rxbufreset_in),
        .gt3_rxbufstatus_out(gt3_rxbufstatus_out),
        .gt3_rxdata_out(gt3_rxdata_out),
        .gt3_rxdatavalid_out(gt3_rxdatavalid_out),
        .gt3_rxgearboxslip_in(gt3_rxgearboxslip_in),
        .gt3_rxheader_out(gt3_rxheader_out),
        .gt3_rxheadervalid_out(gt3_rxheadervalid_out),
        .gt3_rxmonitorout_out(gt3_rxmonitorout_out),
        .gt3_rxmonitorsel_in(gt3_rxmonitorsel_in),
        .gt3_rxoutclk_out(gt3_rxoutclk_out),
        .gt3_rxpcsreset_in(gt3_rxpcsreset_in),
        .gt3_rxprbscntreset_in(gt3_rxprbscntreset_in),
        .gt3_rxprbserr_out(gt3_rxprbserr_out),
        .gt3_rxprbssel_in(gt3_rxprbssel_in),
        .gt3_rxresetdone_out(gt3_rxresetdone_out),
        .gt3_rxusrclk2_in(gt3_rxusrclk2_in),
        .gt3_rxusrclk_in(gt3_rxusrclk_in),
        .gt3_txbufstatus_out(gt3_txbufstatus_out),
        .gt3_txdata_in(gt3_txdata_in),
        .gt3_txelecidle_in(gt3_txelecidle_in),
        .gt3_txheader_in(gt3_txheader_in),
        .gt3_txoutclk_out(gt3_txoutclk_out),
        .gt3_txoutclkfabric_out(gt3_txoutclkfabric_out),
        .gt3_txoutclkpcs_out(gt3_txoutclkpcs_out),
        .gt3_txpcsreset_in(gt3_txpcsreset_in),
        .gt3_txpolarity_in(gt3_txpolarity_in),
        .gt3_txprbsforceerr_in(gt3_txprbsforceerr_in),
        .gt3_txprbssel_in(gt3_txprbssel_in),
        .gt3_txresetdone_out(gt3_txresetdone_out),
        .gt3_txsequence_in(gt3_txsequence_in),
        .gt3_txusrclk2_in(gt3_txusrclk2_in),
        .gt3_txusrclk_in(gt3_txusrclk_in));
endmodule

(* ORIG_REF_NAME = "XLAUI_GT" *) 
module XLAUI_XLAUI_GT__parameterized0
   (gt0_drprdy_out,
    gt0_eyescandataerror_out,
    gt0_gthtxn_out,
    gt0_gthtxp_out,
    gt0_rxoutclk_out,
    GT0_RXPMARESETDONE_OUT,
    gt0_rxprbserr_out,
    gt0_rxresetdone_out,
    gt0_txoutclk_out,
    gt0_txoutclkfabric_out,
    gt0_txoutclkpcs_out,
    gt0_txresetdone_out,
    gt0_dmonitorout_out,
    gt0_drpdo_out,
    gt0_rxdatavalid_out,
    gt0_rxheadervalid_out,
    gt0_txbufstatus_out,
    gt0_rxbufstatus_out,
    gt0_rxheader_out,
    gt0_rxdata_out,
    gt0_rxmonitorout_out,
    gt0_drpclk_in,
    gt0_drpen_in,
    gt0_drpwe_in,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    gt0_gthrxn_in,
    gt0_gthrxp_in,
    SR,
    gt0_gttxreset_in,
    GT0_QPLLOUTCLK_IN,
    GT0_QPLLOUTREFCLK_IN,
    gt0_rxbufreset_in,
    gt0_rxgearboxslip_in,
    gt0_rxpcsreset_in,
    gt0_rxprbscntreset_in,
    gt0_rxuserrdy_in,
    gt0_rxusrclk_in,
    gt0_rxusrclk2_in,
    gt0_txelecidle_in,
    gt0_txpcsreset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    gt0_txuserrdy_in,
    gt0_txusrclk_in,
    gt0_txusrclk2_in,
    gt0_drpdi_in,
    gt0_rxmonitorsel_in,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_txheader_in,
    gt0_txprbssel_in,
    gt0_txdata_in,
    gt0_txsequence_in,
    gt0_drpaddr_in);
  output gt0_drprdy_out;
  output gt0_eyescandataerror_out;
  output gt0_gthtxn_out;
  output gt0_gthtxp_out;
  output gt0_rxoutclk_out;
  output GT0_RXPMARESETDONE_OUT;
  output gt0_rxprbserr_out;
  output gt0_rxresetdone_out;
  output gt0_txoutclk_out;
  output gt0_txoutclkfabric_out;
  output gt0_txoutclkpcs_out;
  output gt0_txresetdone_out;
  output [14:0]gt0_dmonitorout_out;
  output [15:0]gt0_drpdo_out;
  output gt0_rxdatavalid_out;
  output gt0_rxheadervalid_out;
  output [1:0]gt0_txbufstatus_out;
  output [2:0]gt0_rxbufstatus_out;
  output [1:0]gt0_rxheader_out;
  output [63:0]gt0_rxdata_out;
  output [6:0]gt0_rxmonitorout_out;
  input gt0_drpclk_in;
  input gt0_drpen_in;
  input gt0_drpwe_in;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input gt0_gthrxn_in;
  input gt0_gthrxp_in;
  input [0:0]SR;
  input gt0_gttxreset_in;
  input GT0_QPLLOUTCLK_IN;
  input GT0_QPLLOUTREFCLK_IN;
  input gt0_rxbufreset_in;
  input gt0_rxgearboxslip_in;
  input gt0_rxpcsreset_in;
  input gt0_rxprbscntreset_in;
  input gt0_rxuserrdy_in;
  input gt0_rxusrclk_in;
  input gt0_rxusrclk2_in;
  input gt0_txelecidle_in;
  input gt0_txpcsreset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input gt0_txuserrdy_in;
  input gt0_txusrclk_in;
  input gt0_txusrclk2_in;
  input [15:0]gt0_drpdi_in;
  input [1:0]gt0_rxmonitorsel_in;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [1:0]gt0_txheader_in;
  input [2:0]gt0_txprbssel_in;
  input [63:0]gt0_txdata_in;
  input [6:0]gt0_txsequence_in;
  input [8:0]gt0_drpaddr_in;

  wire GT0_QPLLOUTCLK_IN;
  wire GT0_QPLLOUTREFCLK_IN;
  wire GT0_RXPMARESETDONE_OUT;
  wire [0:0]SR;
  wire [14:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drprdy_out;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire gt0_gthrxn_in;
  wire gt0_gthrxp_in;
  wire gt0_gthtxn_out;
  wire gt0_gthtxp_out;
  wire gt0_gttxreset_in;
  wire [2:0]gt0_loopback_in;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire [63:0]gt0_rxdata_out;
  wire gt0_rxdatavalid_out;
  wire gt0_rxgearboxslip_in;
  wire [1:0]gt0_rxheader_out;
  wire gt0_rxheadervalid_out;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire gt0_rxoutclk_out;
  wire gt0_rxpcsreset_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire gt0_rxresetdone_out;
  wire gt0_rxuserrdy_in;
  wire gt0_rxusrclk2_in;
  wire gt0_rxusrclk_in;
  wire [1:0]gt0_txbufstatus_out;
  wire [63:0]gt0_txdata_in;
  wire gt0_txelecidle_in;
  wire [1:0]gt0_txheader_in;
  wire gt0_txoutclk_out;
  wire gt0_txoutclkfabric_out;
  wire gt0_txoutclkpcs_out;
  wire gt0_txpcsreset_in;
  wire gt0_txpolarity_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire gt0_txresetdone_out;
  wire [6:0]gt0_txsequence_in;
  wire gt0_txuserrdy_in;
  wire gt0_txusrclk2_in;
  wire gt0_txusrclk_in;
  wire n_50_gthe2_i;
  wire NLW_gthe2_i_CPLLFBCLKLOST_UNCONNECTED;
  wire NLW_gthe2_i_CPLLLOCK_UNCONNECTED;
  wire NLW_gthe2_i_CPLLREFCLKLOST_UNCONNECTED;
  wire NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED;
  wire NLW_gthe2_i_PHYSTATUS_UNCONNECTED;
  wire NLW_gthe2_i_RSOSINTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXBYTEISALIGNED_UNCONNECTED;
  wire NLW_gthe2_i_RXBYTEREALIGN_UNCONNECTED;
  wire NLW_gthe2_i_RXCDRLOCK_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMINITDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMMADET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMSASDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXELECIDLE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED;
  wire NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_RXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCOUT_UNCONNECTED;
  wire NLW_gthe2_i_RXVALID_UNCONNECTED;
  wire NLW_gthe2_i_TXCOMFINISH_UNCONNECTED;
  wire NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED;
  wire NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXPHINITDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_TXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCOUT_UNCONNECTED;
  wire [15:0]NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXCHARISK_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXCHBONDO_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED;
  wire [1:1]NLW_gthe2_i_RXDATAVALID_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXDISPERR_UNCONNECTED;
  wire [5:2]NLW_gthe2_i_RXHEADER_UNCONNECTED;
  wire [1:1]NLW_gthe2_i_RXHEADERVALID_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHMONITOR_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED;
  wire [2:0]NLW_gthe2_i_RXSTATUS_UNCONNECTED;

(* box_type = "PRIMITIVE" *) 
   GTHE2_CHANNEL #(
    .ACJTAG_DEBUG_MODE(1'b0),
    .ACJTAG_MODE(1'b0),
    .ACJTAG_RESET(1'b0),
    .ADAPT_CFG0(20'h00C10),
    .ALIGN_COMMA_DOUBLE("FALSE"),
    .ALIGN_COMMA_ENABLE(10'b0001111111),
    .ALIGN_COMMA_WORD(1),
    .ALIGN_MCOMMA_DET("FALSE"),
    .ALIGN_MCOMMA_VALUE(10'b1010000011),
    .ALIGN_PCOMMA_DET("FALSE"),
    .ALIGN_PCOMMA_VALUE(10'b0101111100),
    .A_RXOSCALRESET(1'b0),
    .CBCC_DATA_SOURCE_SEL("ENCODED"),
    .CFOK_CFG(42'h24800040E80),
    .CFOK_CFG2(6'b100000),
    .CFOK_CFG3(6'b100000),
    .CHAN_BOND_KEEP_ALIGN("FALSE"),
    .CHAN_BOND_MAX_SKEW(1),
    .CHAN_BOND_SEQ_1_1(10'b0000000000),
    .CHAN_BOND_SEQ_1_2(10'b0000000000),
    .CHAN_BOND_SEQ_1_3(10'b0000000000),
    .CHAN_BOND_SEQ_1_4(10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_1(10'b0000000000),
    .CHAN_BOND_SEQ_2_2(10'b0000000000),
    .CHAN_BOND_SEQ_2_3(10'b0000000000),
    .CHAN_BOND_SEQ_2_4(10'b0000000000),
    .CHAN_BOND_SEQ_2_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_USE("FALSE"),
    .CHAN_BOND_SEQ_LEN(1),
    .CLK_CORRECT_USE("FALSE"),
    .CLK_COR_KEEP_IDLE("FALSE"),
    .CLK_COR_MAX_LAT(19),
    .CLK_COR_MIN_LAT(15),
    .CLK_COR_PRECEDENCE("TRUE"),
    .CLK_COR_REPEAT_WAIT(0),
    .CLK_COR_SEQ_1_1(10'b0100000000),
    .CLK_COR_SEQ_1_2(10'b0000000000),
    .CLK_COR_SEQ_1_3(10'b0000000000),
    .CLK_COR_SEQ_1_4(10'b0000000000),
    .CLK_COR_SEQ_1_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_1(10'b0100000000),
    .CLK_COR_SEQ_2_2(10'b0000000000),
    .CLK_COR_SEQ_2_3(10'b0000000000),
    .CLK_COR_SEQ_2_4(10'b0000000000),
    .CLK_COR_SEQ_2_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_USE("FALSE"),
    .CLK_COR_SEQ_LEN(1),
    .CPLL_CFG(29'h00BC07DC),
    .CPLL_FBDIV(4),
    .CPLL_FBDIV_45(5),
    .CPLL_INIT_CFG(24'h00001E),
    .CPLL_LOCK_CFG(16'h01E8),
    .CPLL_REFCLK_DIV(1),
    .DEC_MCOMMA_DETECT("FALSE"),
    .DEC_PCOMMA_DETECT("FALSE"),
    .DEC_VALID_COMMA_ONLY("FALSE"),
    .DMONITOR_CFG(24'h000A00),
    .ES_CLK_PHASE_SEL(1'b0),
    .ES_CONTROL(6'b000000),
    .ES_ERRDET_EN("FALSE"),
    .ES_EYE_SCAN_EN("TRUE"),
    .ES_HORZ_OFFSET(12'h000),
    .ES_PMA_CFG(10'b0000000000),
    .ES_PRESCALE(5'b00000),
    .ES_QUALIFIER(80'h00000000000000000000),
    .ES_QUAL_MASK(80'h00000000000000000000),
    .ES_SDATA_MASK(80'h00000000000000000000),
    .ES_VERT_OFFSET(9'b000000000),
    .FTS_DESKEW_SEQ_ENABLE(4'b1111),
    .FTS_LANE_DESKEW_CFG(4'b1111),
    .FTS_LANE_DESKEW_EN("FALSE"),
    .GEARBOX_MODE(3'b001),
    .IS_CLKRSVD0_INVERTED(1'b0),
    .IS_CLKRSVD1_INVERTED(1'b0),
    .IS_CPLLLOCKDETCLK_INVERTED(1'b0),
    .IS_DMONITORCLK_INVERTED(1'b0),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_RXUSRCLK2_INVERTED(1'b0),
    .IS_RXUSRCLK_INVERTED(1'b0),
    .IS_SIGVALIDCLK_INVERTED(1'b0),
    .IS_TXPHDLYTSTCLK_INVERTED(1'b0),
    .IS_TXUSRCLK2_INVERTED(1'b0),
    .IS_TXUSRCLK_INVERTED(1'b0),
    .LOOPBACK_CFG(1'b0),
    .OUTREFCLK_SEL_INV(2'b11),
    .PCS_PCIE_EN("FALSE"),
    .PCS_RSVD_ATTR(48'h000000000000),
    .PD_TRANS_TIME_FROM_P2(12'h03C),
    .PD_TRANS_TIME_NONE_P2(8'h19),
    .PD_TRANS_TIME_TO_P2(8'h64),
    .PMA_RSV(32'b00000000000000000000000010000000),
    .PMA_RSV2(32'b00011100000000000000000000001010),
    .PMA_RSV3(2'b00),
    .PMA_RSV4(15'b000000000001000),
    .PMA_RSV5(4'b0000),
    .RESET_POWERSAVE_DISABLE(1'b0),
    .RXBUFRESET_TIME(5'b00001),
    .RXBUF_ADDR_MODE("FAST"),
    .RXBUF_EIDLE_HI_CNT(4'b1000),
    .RXBUF_EIDLE_LO_CNT(4'b0000),
    .RXBUF_EN("TRUE"),
    .RXBUF_RESET_ON_CB_CHANGE("TRUE"),
    .RXBUF_RESET_ON_COMMAALIGN("FALSE"),
    .RXBUF_RESET_ON_EIDLE("FALSE"),
    .RXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .RXBUF_THRESH_OVFLW(61),
    .RXBUF_THRESH_OVRD("FALSE"),
    .RXBUF_THRESH_UNDFLW(4),
    .RXCDRFREQRESET_TIME(5'b00001),
    .RXCDRPHRESET_TIME(5'b00001),
    .RXCDR_CFG(83'h0002007FE2000C208001A),
    .RXCDR_FR_RESET_ON_EIDLE(1'b0),
    .RXCDR_HOLD_DURING_EIDLE(1'b0),
    .RXCDR_LOCK_CFG(6'b010101),
    .RXCDR_PH_RESET_ON_EIDLE(1'b0),
    .RXDFELPMRESET_TIME(7'b0001111),
    .RXDLY_CFG(16'h001F),
    .RXDLY_LCFG(9'h030),
    .RXDLY_TAP_CFG(16'h0000),
    .RXGEARBOX_EN("TRUE"),
    .RXISCANRESET_TIME(5'b00001),
    .RXLPM_HF_CFG(14'b00001000000000),
    .RXLPM_LF_CFG(18'b001001000000000000),
    .RXOOB_CFG(7'b0000110),
    .RXOOB_CLK_CFG("PMA"),
    .RXOSCALRESET_TIME(5'b00011),
    .RXOSCALRESET_TIMEOUT(5'b00000),
    .RXOUT_DIV(1),
    .RXPCSRESET_TIME(5'b00001),
    .RXPHDLY_CFG(24'h084020),
    .RXPH_CFG(24'hC00002),
    .RXPH_MONITOR_SEL(5'b00000),
    .RXPI_CFG0(2'b00),
    .RXPI_CFG1(2'b11),
    .RXPI_CFG2(2'b11),
    .RXPI_CFG3(2'b11),
    .RXPI_CFG4(1'b0),
    .RXPI_CFG5(1'b0),
    .RXPI_CFG6(3'b100),
    .RXPMARESET_TIME(5'b00011),
    .RXPRBS_ERR_LOOPBACK(1'b0),
    .RXSLIDE_AUTO_WAIT(7),
    .RXSLIDE_MODE("OFF"),
    .RXSYNC_MULTILANE(1'b1),
    .RXSYNC_OVRD(1'b0),
    .RXSYNC_SKIP_DA(1'b0),
    .RX_BIAS_CFG(24'b000011000000000000010000),
    .RX_BUFFER_CFG(6'b000000),
    .RX_CLK25_DIV(7),
    .RX_CLKMUX_PD(1'b1),
    .RX_CM_SEL(2'b11),
    .RX_CM_TRIM(4'b1010),
    .RX_DATA_WIDTH(64),
    .RX_DDI_SEL(6'b000000),
    .RX_DEBUG_CFG(14'b00000000000000),
    .RX_DEFER_RESET_BUF_EN("TRUE"),
    .RX_DFELPM_CFG0(4'b0110),
    .RX_DFELPM_CFG1(1'b0),
    .RX_DFELPM_KLKH_AGC_STUP_EN(1'b1),
    .RX_DFE_AGC_CFG0(2'b00),
    .RX_DFE_AGC_CFG1(3'b100),
    .RX_DFE_AGC_CFG2(4'b0000),
    .RX_DFE_AGC_OVRDEN(1'b1),
    .RX_DFE_GAIN_CFG(23'h0020C0),
    .RX_DFE_H2_CFG(12'b000000000000),
    .RX_DFE_H3_CFG(12'b000001000000),
    .RX_DFE_H4_CFG(11'b00011100000),
    .RX_DFE_H5_CFG(11'b00011100000),
    .RX_DFE_H6_CFG(11'b00000100000),
    .RX_DFE_H7_CFG(11'b00000100000),
    .RX_DFE_KL_CFG(33'b001000001000000000000001100010000),
    .RX_DFE_KL_LPM_KH_CFG0(2'b01),
    .RX_DFE_KL_LPM_KH_CFG1(3'b010),
    .RX_DFE_KL_LPM_KH_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KH_OVRDEN(1'b1),
    .RX_DFE_KL_LPM_KL_CFG0(2'b10),
    .RX_DFE_KL_LPM_KL_CFG1(3'b010),
    .RX_DFE_KL_LPM_KL_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KL_OVRDEN(1'b1),
    .RX_DFE_LPM_CFG(16'h0080),
    .RX_DFE_LPM_HOLD_DURING_EIDLE(1'b0),
    .RX_DFE_ST_CFG(54'h00E100000C003F),
    .RX_DFE_UT_CFG(17'b00011100000000000),
    .RX_DFE_VP_CFG(17'b00011101010100011),
    .RX_DISPERR_SEQ_MATCH("FALSE"),
    .RX_INT_DATAWIDTH(1),
    .RX_OS_CFG(13'b0000010000000),
    .RX_SIG_VALID_DLY(10),
    .RX_XCLK_SEL("RXREC"),
    .SAS_MAX_COM(64),
    .SAS_MIN_COM(36),
    .SATA_BURST_SEQ_LEN(4'b0101),
    .SATA_BURST_VAL(3'b100),
    .SATA_CPLL_CFG("VCO_3000MHZ"),
    .SATA_EIDLE_VAL(3'b100),
    .SATA_MAX_BURST(8),
    .SATA_MAX_INIT(21),
    .SATA_MAX_WAKE(7),
    .SATA_MIN_BURST(4),
    .SATA_MIN_INIT(12),
    .SATA_MIN_WAKE(4),
    .SHOW_REALIGN_COMMA("FALSE"),
    .SIM_CPLLREFCLK_SEL(3'b001),
    .SIM_RECEIVER_DETECT_PASS("TRUE"),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_TX_EIDLE_DRIVE_LEVEL("X"),
    .SIM_VERSION("2.0"),
    .TERM_RCAL_CFG(15'b100001000010000),
    .TERM_RCAL_OVRD(3'b000),
    .TRANS_TIME_RATE(8'h0E),
    .TST_RSV(32'h00000000),
    .TXBUF_EN("TRUE"),
    .TXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .TXDLY_CFG(16'h001F),
    .TXDLY_LCFG(9'h030),
    .TXDLY_TAP_CFG(16'h0000),
    .TXGEARBOX_EN("TRUE"),
    .TXOOB_CFG(1'b0),
    .TXOUT_DIV(1),
    .TXPCSRESET_TIME(5'b00001),
    .TXPHDLY_CFG(24'h084020),
    .TXPH_CFG(16'h0780),
    .TXPH_MONITOR_SEL(5'b00000),
    .TXPI_CFG0(2'b00),
    .TXPI_CFG1(2'b00),
    .TXPI_CFG2(2'b00),
    .TXPI_CFG3(1'b0),
    .TXPI_CFG4(1'b0),
    .TXPI_CFG5(3'b100),
    .TXPI_GREY_SEL(1'b0),
    .TXPI_INVSTROBE_SEL(1'b0),
    .TXPI_PPMCLK_SEL("TXUSRCLK2"),
    .TXPI_PPM_CFG(8'b00000000),
    .TXPI_SYNFREQ_PPM(3'b000),
    .TXPMARESET_TIME(5'b00001),
    .TXSYNC_MULTILANE(1'b0),
    .TXSYNC_OVRD(1'b0),
    .TXSYNC_SKIP_DA(1'b0),
    .TX_CLK25_DIV(7),
    .TX_CLKMUX_PD(1'b1),
    .TX_DATA_WIDTH(64),
    .TX_DEEMPH0(6'b000000),
    .TX_DEEMPH1(6'b000000),
    .TX_DRIVE_MODE("DIRECT"),
    .TX_EIDLE_ASSERT_DELAY(3'b110),
    .TX_EIDLE_DEASSERT_DELAY(3'b100),
    .TX_INT_DATAWIDTH(1),
    .TX_LOOPBACK_DRIVE_HIZ("FALSE"),
    .TX_MAINCURSOR_SEL(1'b0),
    .TX_MARGIN_FULL_0(7'b1001110),
    .TX_MARGIN_FULL_1(7'b1001001),
    .TX_MARGIN_FULL_2(7'b1000101),
    .TX_MARGIN_FULL_3(7'b1000010),
    .TX_MARGIN_FULL_4(7'b1000000),
    .TX_MARGIN_LOW_0(7'b1000110),
    .TX_MARGIN_LOW_1(7'b1000100),
    .TX_MARGIN_LOW_2(7'b1000010),
    .TX_MARGIN_LOW_3(7'b1000000),
    .TX_MARGIN_LOW_4(7'b1000000),
    .TX_QPI_STATUS_EN(1'b0),
    .TX_RXDETECT_CFG(14'h1832),
    .TX_RXDETECT_PRECHARGE_TIME(17'h155CC),
    .TX_RXDETECT_REF(3'b100),
    .TX_XCLK_SEL("TXOUT"),
    .UCODEER_CLR(1'b0),
    .USE_PCS_CLK_PHASE_SEL(1'b0)) 
     gthe2_i
       (.CFGRESET(1'b0),
        .CLKRSVD0(1'b0),
        .CLKRSVD1(1'b0),
        .CPLLFBCLKLOST(NLW_gthe2_i_CPLLFBCLKLOST_UNCONNECTED),
        .CPLLLOCK(NLW_gthe2_i_CPLLLOCK_UNCONNECTED),
        .CPLLLOCKDETCLK(1'b0),
        .CPLLLOCKEN(1'b1),
        .CPLLPD(1'b1),
        .CPLLREFCLKLOST(NLW_gthe2_i_CPLLREFCLKLOST_UNCONNECTED),
        .CPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .CPLLRESET(1'b0),
        .DMONFIFORESET(1'b0),
        .DMONITORCLK(1'b0),
        .DMONITOROUT(gt0_dmonitorout_out),
        .DRPADDR(gt0_drpaddr_in),
        .DRPCLK(gt0_drpclk_in),
        .DRPDI(gt0_drpdi_in),
        .DRPDO(gt0_drpdo_out),
        .DRPEN(gt0_drpen_in),
        .DRPRDY(gt0_drprdy_out),
        .DRPWE(gt0_drpwe_in),
        .EYESCANDATAERROR(gt0_eyescandataerror_out),
        .EYESCANMODE(1'b0),
        .EYESCANRESET(gt0_eyescanreset_in),
        .EYESCANTRIGGER(gt0_eyescantrigger_in),
        .GTGREFCLK(1'b0),
        .GTHRXN(gt0_gthrxn_in),
        .GTHRXP(gt0_gthrxp_in),
        .GTHTXN(gt0_gthtxn_out),
        .GTHTXP(gt0_gthtxp_out),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(1'b0),
        .GTREFCLK1(1'b0),
        .GTREFCLKMONITOR(NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED),
        .GTRESETSEL(1'b0),
        .GTRSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GTRXRESET(SR),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .GTTXRESET(gt0_gttxreset_in),
        .LOOPBACK(gt0_loopback_in),
        .PCSRSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDOUT(NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED[15:0]),
        .PHYSTATUS(NLW_gthe2_i_PHYSTATUS_UNCONNECTED),
        .PMARSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLCLK(GT0_QPLLOUTCLK_IN),
        .QPLLREFCLK(GT0_QPLLOUTREFCLK_IN),
        .RESETOVRD(1'b0),
        .RSOSINTDONE(NLW_gthe2_i_RSOSINTDONE_UNCONNECTED),
        .RX8B10BEN(1'b0),
        .RXADAPTSELTEST({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXBUFRESET(gt0_rxbufreset_in),
        .RXBUFSTATUS(gt0_rxbufstatus_out),
        .RXBYTEISALIGNED(NLW_gthe2_i_RXBYTEISALIGNED_UNCONNECTED),
        .RXBYTEREALIGN(NLW_gthe2_i_RXBYTEREALIGN_UNCONNECTED),
        .RXCDRFREQRESET(1'b0),
        .RXCDRHOLD(1'b0),
        .RXCDRLOCK(NLW_gthe2_i_RXCDRLOCK_UNCONNECTED),
        .RXCDROVRDEN(1'b0),
        .RXCDRRESET(1'b0),
        .RXCDRRESETRSV(1'b0),
        .RXCHANBONDSEQ(NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED),
        .RXCHANISALIGNED(NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED),
        .RXCHANREALIGN(NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED),
        .RXCHARISCOMMA(NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED[7:0]),
        .RXCHARISK(NLW_gthe2_i_RXCHARISK_UNCONNECTED[7:0]),
        .RXCHBONDEN(1'b0),
        .RXCHBONDI({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXCHBONDLEVEL({1'b0,1'b0,1'b0}),
        .RXCHBONDMASTER(1'b0),
        .RXCHBONDO(NLW_gthe2_i_RXCHBONDO_UNCONNECTED[4:0]),
        .RXCHBONDSLAVE(1'b0),
        .RXCLKCORCNT(NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED[1:0]),
        .RXCOMINITDET(NLW_gthe2_i_RXCOMINITDET_UNCONNECTED),
        .RXCOMMADET(NLW_gthe2_i_RXCOMMADET_UNCONNECTED),
        .RXCOMMADETEN(1'b0),
        .RXCOMSASDET(NLW_gthe2_i_RXCOMSASDET_UNCONNECTED),
        .RXCOMWAKEDET(NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED),
        .RXDATA(gt0_rxdata_out),
        .RXDATAVALID({NLW_gthe2_i_RXDATAVALID_UNCONNECTED[1],gt0_rxdatavalid_out}),
        .RXDDIEN(1'b0),
        .RXDFEAGCHOLD(1'b0),
        .RXDFEAGCOVRDEN(1'b0),
        .RXDFEAGCTRL({1'b1,1'b0,1'b0,1'b0,1'b0}),
        .RXDFECM1EN(1'b0),
        .RXDFELFHOLD(1'b0),
        .RXDFELFOVRDEN(1'b0),
        .RXDFELPMRESET(1'b0),
        .RXDFESLIDETAP({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPADAPTEN(1'b0),
        .RXDFESLIDETAPHOLD(1'b0),
        .RXDFESLIDETAPID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPINITOVRDEN(1'b0),
        .RXDFESLIDETAPONLYADAPTEN(1'b0),
        .RXDFESLIDETAPOVRDEN(1'b0),
        .RXDFESLIDETAPSTARTED(NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED),
        .RXDFESLIDETAPSTROBE(1'b0),
        .RXDFESLIDETAPSTROBEDONE(NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED),
        .RXDFESLIDETAPSTROBESTARTED(NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED),
        .RXDFESTADAPTDONE(NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED),
        .RXDFETAP2HOLD(1'b0),
        .RXDFETAP2OVRDEN(1'b0),
        .RXDFETAP3HOLD(1'b0),
        .RXDFETAP3OVRDEN(1'b0),
        .RXDFETAP4HOLD(1'b0),
        .RXDFETAP4OVRDEN(1'b0),
        .RXDFETAP5HOLD(1'b0),
        .RXDFETAP5OVRDEN(1'b0),
        .RXDFETAP6HOLD(1'b0),
        .RXDFETAP6OVRDEN(1'b0),
        .RXDFETAP7HOLD(1'b0),
        .RXDFETAP7OVRDEN(1'b0),
        .RXDFEUTHOLD(1'b0),
        .RXDFEUTOVRDEN(1'b0),
        .RXDFEVPHOLD(1'b0),
        .RXDFEVPOVRDEN(1'b0),
        .RXDFEVSEN(1'b0),
        .RXDFEXYDEN(1'b1),
        .RXDISPERR(NLW_gthe2_i_RXDISPERR_UNCONNECTED[7:0]),
        .RXDLYBYPASS(1'b1),
        .RXDLYEN(1'b0),
        .RXDLYOVRDEN(1'b0),
        .RXDLYSRESET(1'b0),
        .RXDLYSRESETDONE(NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED),
        .RXELECIDLE(NLW_gthe2_i_RXELECIDLE_UNCONNECTED),
        .RXELECIDLEMODE({1'b1,1'b1}),
        .RXGEARBOXSLIP(gt0_rxgearboxslip_in),
        .RXHEADER({NLW_gthe2_i_RXHEADER_UNCONNECTED[5:2],gt0_rxheader_out}),
        .RXHEADERVALID({NLW_gthe2_i_RXHEADERVALID_UNCONNECTED[1],gt0_rxheadervalid_out}),
        .RXLPMEN(1'b0),
        .RXLPMHFHOLD(1'b0),
        .RXLPMHFOVRDEN(1'b0),
        .RXLPMLFHOLD(1'b0),
        .RXLPMLFKLOVRDEN(1'b0),
        .RXMCOMMAALIGNEN(1'b0),
        .RXMONITOROUT(gt0_rxmonitorout_out),
        .RXMONITORSEL(gt0_rxmonitorsel_in),
        .RXNOTINTABLE(NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED[7:0]),
        .RXOOBRESET(1'b0),
        .RXOSCALRESET(1'b0),
        .RXOSHOLD(1'b0),
        .RXOSINTCFG({1'b0,1'b1,1'b1,1'b0}),
        .RXOSINTEN(1'b1),
        .RXOSINTHOLD(1'b0),
        .RXOSINTID0({1'b0,1'b0,1'b0,1'b0}),
        .RXOSINTNTRLEN(1'b0),
        .RXOSINTOVRDEN(1'b0),
        .RXOSINTSTARTED(NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED),
        .RXOSINTSTROBE(1'b0),
        .RXOSINTSTROBEDONE(NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED),
        .RXOSINTSTROBESTARTED(NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED),
        .RXOSINTTESTOVRDEN(1'b0),
        .RXOSOVRDEN(1'b0),
        .RXOUTCLK(gt0_rxoutclk_out),
        .RXOUTCLKFABRIC(NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED),
        .RXOUTCLKPCS(NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED),
        .RXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .RXPCOMMAALIGNEN(1'b0),
        .RXPCSRESET(gt0_rxpcsreset_in),
        .RXPD({1'b0,1'b0}),
        .RXPHALIGN(1'b0),
        .RXPHALIGNDONE(NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED),
        .RXPHALIGNEN(1'b0),
        .RXPHDLYPD(1'b0),
        .RXPHDLYRESET(1'b0),
        .RXPHMONITOR(NLW_gthe2_i_RXPHMONITOR_UNCONNECTED[4:0]),
        .RXPHOVRDEN(1'b0),
        .RXPHSLIPMONITOR(NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED[4:0]),
        .RXPMARESET(1'b0),
        .RXPMARESETDONE(GT0_RXPMARESETDONE_OUT),
        .RXPOLARITY(1'b0),
        .RXPRBSCNTRESET(gt0_rxprbscntreset_in),
        .RXPRBSERR(gt0_rxprbserr_out),
        .RXPRBSSEL(gt0_rxprbssel_in),
        .RXQPIEN(1'b0),
        .RXQPISENN(NLW_gthe2_i_RXQPISENN_UNCONNECTED),
        .RXQPISENP(NLW_gthe2_i_RXQPISENP_UNCONNECTED),
        .RXRATE({1'b0,1'b0,1'b0}),
        .RXRATEDONE(NLW_gthe2_i_RXRATEDONE_UNCONNECTED),
        .RXRATEMODE(1'b0),
        .RXRESETDONE(gt0_rxresetdone_out),
        .RXSLIDE(1'b0),
        .RXSTARTOFSEQ(NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED[1:0]),
        .RXSTATUS(NLW_gthe2_i_RXSTATUS_UNCONNECTED[2:0]),
        .RXSYNCALLIN(1'b0),
        .RXSYNCDONE(NLW_gthe2_i_RXSYNCDONE_UNCONNECTED),
        .RXSYNCIN(1'b0),
        .RXSYNCMODE(1'b0),
        .RXSYNCOUT(NLW_gthe2_i_RXSYNCOUT_UNCONNECTED),
        .RXSYSCLKSEL({1'b1,1'b1}),
        .RXUSERRDY(gt0_rxuserrdy_in),
        .RXUSRCLK(gt0_rxusrclk_in),
        .RXUSRCLK2(gt0_rxusrclk2_in),
        .RXVALID(NLW_gthe2_i_RXVALID_UNCONNECTED),
        .SETERRSTATUS(1'b0),
        .SIGVALIDCLK(1'b0),
        .TSTIN({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .TX8B10BBYPASS({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TX8B10BEN(1'b0),
        .TXBUFDIFFCTRL({1'b1,1'b0,1'b0}),
        .TXBUFSTATUS(gt0_txbufstatus_out),
        .TXCHARDISPMODE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARDISPVAL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARISK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCOMFINISH(NLW_gthe2_i_TXCOMFINISH_UNCONNECTED),
        .TXCOMINIT(1'b0),
        .TXCOMSAS(1'b0),
        .TXCOMWAKE(1'b0),
        .TXDATA(gt0_txdata_in),
        .TXDEEMPH(1'b0),
        .TXDETECTRX(1'b0),
        .TXDIFFCTRL({1'b1,1'b0,1'b0,1'b0}),
        .TXDIFFPD(1'b0),
        .TXDLYBYPASS(1'b1),
        .TXDLYEN(1'b0),
        .TXDLYHOLD(1'b0),
        .TXDLYOVRDEN(1'b0),
        .TXDLYSRESET(1'b0),
        .TXDLYSRESETDONE(NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED),
        .TXDLYUPDOWN(1'b0),
        .TXELECIDLE(gt0_txelecidle_in),
        .TXGEARBOXREADY(NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED),
        .TXHEADER({1'b0,gt0_txheader_in}),
        .TXINHIBIT(1'b0),
        .TXMAINCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXMARGIN({1'b0,1'b0,1'b0}),
        .TXOUTCLK(gt0_txoutclk_out),
        .TXOUTCLKFABRIC(gt0_txoutclkfabric_out),
        .TXOUTCLKPCS(gt0_txoutclkpcs_out),
        .TXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .TXPCSRESET(gt0_txpcsreset_in),
        .TXPD({1'b0,1'b0}),
        .TXPDELECIDLEMODE(1'b0),
        .TXPHALIGN(1'b0),
        .TXPHALIGNDONE(NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED),
        .TXPHALIGNEN(1'b0),
        .TXPHDLYPD(1'b0),
        .TXPHDLYRESET(1'b0),
        .TXPHDLYTSTCLK(1'b0),
        .TXPHINIT(1'b0),
        .TXPHINITDONE(NLW_gthe2_i_TXPHINITDONE_UNCONNECTED),
        .TXPHOVRDEN(1'b0),
        .TXPIPPMEN(1'b0),
        .TXPIPPMOVRDEN(1'b0),
        .TXPIPPMPD(1'b0),
        .TXPIPPMSEL(1'b1),
        .TXPIPPMSTEPSIZE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPISOPD(1'b0),
        .TXPMARESET(1'b0),
        .TXPMARESETDONE(n_50_gthe2_i),
        .TXPOLARITY(gt0_txpolarity_in),
        .TXPOSTCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPOSTCURSORINV(1'b0),
        .TXPRBSFORCEERR(gt0_txprbsforceerr_in),
        .TXPRBSSEL(gt0_txprbssel_in),
        .TXPRECURSOR({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPRECURSORINV(1'b0),
        .TXQPIBIASEN(1'b0),
        .TXQPISENN(NLW_gthe2_i_TXQPISENN_UNCONNECTED),
        .TXQPISENP(NLW_gthe2_i_TXQPISENP_UNCONNECTED),
        .TXQPISTRONGPDOWN(1'b0),
        .TXQPIWEAKPUP(1'b0),
        .TXRATE({1'b0,1'b0,1'b0}),
        .TXRATEDONE(NLW_gthe2_i_TXRATEDONE_UNCONNECTED),
        .TXRATEMODE(1'b0),
        .TXRESETDONE(gt0_txresetdone_out),
        .TXSEQUENCE(gt0_txsequence_in),
        .TXSTARTSEQ(1'b0),
        .TXSWING(1'b0),
        .TXSYNCALLIN(1'b0),
        .TXSYNCDONE(NLW_gthe2_i_TXSYNCDONE_UNCONNECTED),
        .TXSYNCIN(1'b0),
        .TXSYNCMODE(1'b0),
        .TXSYNCOUT(NLW_gthe2_i_TXSYNCOUT_UNCONNECTED),
        .TXSYSCLKSEL({1'b1,1'b1}),
        .TXUSERRDY(gt0_txuserrdy_in),
        .TXUSRCLK(gt0_txusrclk_in),
        .TXUSRCLK2(gt0_txusrclk2_in));
endmodule

(* ORIG_REF_NAME = "XLAUI_GT" *) 
module XLAUI_XLAUI_GT__parameterized0_65
   (gt1_drprdy_out,
    gt1_eyescandataerror_out,
    gt1_gthtxn_out,
    gt1_gthtxp_out,
    gt1_rxoutclk_out,
    GT1_RXPMARESETDONE_OUT,
    gt1_rxprbserr_out,
    gt1_rxresetdone_out,
    gt1_txoutclk_out,
    gt1_txoutclkfabric_out,
    gt1_txoutclkpcs_out,
    gt1_txresetdone_out,
    gt1_dmonitorout_out,
    gt1_drpdo_out,
    gt1_rxdatavalid_out,
    gt1_rxheadervalid_out,
    gt1_txbufstatus_out,
    gt1_rxbufstatus_out,
    gt1_rxheader_out,
    gt1_rxdata_out,
    gt1_rxmonitorout_out,
    gt1_drpclk_in,
    gt1_drpen_in,
    gt1_drpwe_in,
    gt1_eyescanreset_in,
    gt1_eyescantrigger_in,
    gt1_gthrxn_in,
    gt1_gthrxp_in,
    I1,
    gt1_gttxreset_in,
    GT0_QPLLOUTCLK_IN,
    GT0_QPLLOUTREFCLK_IN,
    gt1_rxbufreset_in,
    gt1_rxgearboxslip_in,
    gt1_rxpcsreset_in,
    gt1_rxprbscntreset_in,
    gt1_rxuserrdy_in,
    gt1_rxusrclk_in,
    gt1_rxusrclk2_in,
    gt1_txelecidle_in,
    gt1_txpcsreset_in,
    gt1_txpolarity_in,
    gt1_txprbsforceerr_in,
    gt1_txuserrdy_in,
    gt1_txusrclk_in,
    gt1_txusrclk2_in,
    gt1_drpdi_in,
    gt1_rxmonitorsel_in,
    gt1_loopback_in,
    gt1_rxprbssel_in,
    gt1_txheader_in,
    gt1_txprbssel_in,
    gt1_txdata_in,
    gt1_txsequence_in,
    gt1_drpaddr_in);
  output gt1_drprdy_out;
  output gt1_eyescandataerror_out;
  output gt1_gthtxn_out;
  output gt1_gthtxp_out;
  output gt1_rxoutclk_out;
  output GT1_RXPMARESETDONE_OUT;
  output gt1_rxprbserr_out;
  output gt1_rxresetdone_out;
  output gt1_txoutclk_out;
  output gt1_txoutclkfabric_out;
  output gt1_txoutclkpcs_out;
  output gt1_txresetdone_out;
  output [14:0]gt1_dmonitorout_out;
  output [15:0]gt1_drpdo_out;
  output gt1_rxdatavalid_out;
  output gt1_rxheadervalid_out;
  output [1:0]gt1_txbufstatus_out;
  output [2:0]gt1_rxbufstatus_out;
  output [1:0]gt1_rxheader_out;
  output [63:0]gt1_rxdata_out;
  output [6:0]gt1_rxmonitorout_out;
  input gt1_drpclk_in;
  input gt1_drpen_in;
  input gt1_drpwe_in;
  input gt1_eyescanreset_in;
  input gt1_eyescantrigger_in;
  input gt1_gthrxn_in;
  input gt1_gthrxp_in;
  input [0:0]I1;
  input gt1_gttxreset_in;
  input GT0_QPLLOUTCLK_IN;
  input GT0_QPLLOUTREFCLK_IN;
  input gt1_rxbufreset_in;
  input gt1_rxgearboxslip_in;
  input gt1_rxpcsreset_in;
  input gt1_rxprbscntreset_in;
  input gt1_rxuserrdy_in;
  input gt1_rxusrclk_in;
  input gt1_rxusrclk2_in;
  input gt1_txelecidle_in;
  input gt1_txpcsreset_in;
  input gt1_txpolarity_in;
  input gt1_txprbsforceerr_in;
  input gt1_txuserrdy_in;
  input gt1_txusrclk_in;
  input gt1_txusrclk2_in;
  input [15:0]gt1_drpdi_in;
  input [1:0]gt1_rxmonitorsel_in;
  input [2:0]gt1_loopback_in;
  input [2:0]gt1_rxprbssel_in;
  input [1:0]gt1_txheader_in;
  input [2:0]gt1_txprbssel_in;
  input [63:0]gt1_txdata_in;
  input [6:0]gt1_txsequence_in;
  input [8:0]gt1_drpaddr_in;

  wire GT0_QPLLOUTCLK_IN;
  wire GT0_QPLLOUTREFCLK_IN;
  wire GT1_RXPMARESETDONE_OUT;
  wire [0:0]I1;
  wire [14:0]gt1_dmonitorout_out;
  wire [8:0]gt1_drpaddr_in;
  wire gt1_drpclk_in;
  wire [15:0]gt1_drpdi_in;
  wire [15:0]gt1_drpdo_out;
  wire gt1_drpen_in;
  wire gt1_drprdy_out;
  wire gt1_drpwe_in;
  wire gt1_eyescandataerror_out;
  wire gt1_eyescanreset_in;
  wire gt1_eyescantrigger_in;
  wire gt1_gthrxn_in;
  wire gt1_gthrxp_in;
  wire gt1_gthtxn_out;
  wire gt1_gthtxp_out;
  wire gt1_gttxreset_in;
  wire [2:0]gt1_loopback_in;
  wire gt1_rxbufreset_in;
  wire [2:0]gt1_rxbufstatus_out;
  wire [63:0]gt1_rxdata_out;
  wire gt1_rxdatavalid_out;
  wire gt1_rxgearboxslip_in;
  wire [1:0]gt1_rxheader_out;
  wire gt1_rxheadervalid_out;
  wire [6:0]gt1_rxmonitorout_out;
  wire [1:0]gt1_rxmonitorsel_in;
  wire gt1_rxoutclk_out;
  wire gt1_rxpcsreset_in;
  wire gt1_rxprbscntreset_in;
  wire gt1_rxprbserr_out;
  wire [2:0]gt1_rxprbssel_in;
  wire gt1_rxresetdone_out;
  wire gt1_rxuserrdy_in;
  wire gt1_rxusrclk2_in;
  wire gt1_rxusrclk_in;
  wire [1:0]gt1_txbufstatus_out;
  wire [63:0]gt1_txdata_in;
  wire gt1_txelecidle_in;
  wire [1:0]gt1_txheader_in;
  wire gt1_txoutclk_out;
  wire gt1_txoutclkfabric_out;
  wire gt1_txoutclkpcs_out;
  wire gt1_txpcsreset_in;
  wire gt1_txpolarity_in;
  wire gt1_txprbsforceerr_in;
  wire [2:0]gt1_txprbssel_in;
  wire gt1_txresetdone_out;
  wire [6:0]gt1_txsequence_in;
  wire gt1_txuserrdy_in;
  wire gt1_txusrclk2_in;
  wire gt1_txusrclk_in;
  wire n_50_gthe2_i;
  wire NLW_gthe2_i_CPLLFBCLKLOST_UNCONNECTED;
  wire NLW_gthe2_i_CPLLLOCK_UNCONNECTED;
  wire NLW_gthe2_i_CPLLREFCLKLOST_UNCONNECTED;
  wire NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED;
  wire NLW_gthe2_i_PHYSTATUS_UNCONNECTED;
  wire NLW_gthe2_i_RSOSINTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXBYTEISALIGNED_UNCONNECTED;
  wire NLW_gthe2_i_RXBYTEREALIGN_UNCONNECTED;
  wire NLW_gthe2_i_RXCDRLOCK_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMINITDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMMADET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMSASDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXELECIDLE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED;
  wire NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_RXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCOUT_UNCONNECTED;
  wire NLW_gthe2_i_RXVALID_UNCONNECTED;
  wire NLW_gthe2_i_TXCOMFINISH_UNCONNECTED;
  wire NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED;
  wire NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXPHINITDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_TXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCOUT_UNCONNECTED;
  wire [15:0]NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXCHARISK_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXCHBONDO_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED;
  wire [1:1]NLW_gthe2_i_RXDATAVALID_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXDISPERR_UNCONNECTED;
  wire [5:2]NLW_gthe2_i_RXHEADER_UNCONNECTED;
  wire [1:1]NLW_gthe2_i_RXHEADERVALID_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHMONITOR_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED;
  wire [2:0]NLW_gthe2_i_RXSTATUS_UNCONNECTED;

(* box_type = "PRIMITIVE" *) 
   GTHE2_CHANNEL #(
    .ACJTAG_DEBUG_MODE(1'b0),
    .ACJTAG_MODE(1'b0),
    .ACJTAG_RESET(1'b0),
    .ADAPT_CFG0(20'h00C10),
    .ALIGN_COMMA_DOUBLE("FALSE"),
    .ALIGN_COMMA_ENABLE(10'b0001111111),
    .ALIGN_COMMA_WORD(1),
    .ALIGN_MCOMMA_DET("FALSE"),
    .ALIGN_MCOMMA_VALUE(10'b1010000011),
    .ALIGN_PCOMMA_DET("FALSE"),
    .ALIGN_PCOMMA_VALUE(10'b0101111100),
    .A_RXOSCALRESET(1'b0),
    .CBCC_DATA_SOURCE_SEL("ENCODED"),
    .CFOK_CFG(42'h24800040E80),
    .CFOK_CFG2(6'b100000),
    .CFOK_CFG3(6'b100000),
    .CHAN_BOND_KEEP_ALIGN("FALSE"),
    .CHAN_BOND_MAX_SKEW(1),
    .CHAN_BOND_SEQ_1_1(10'b0000000000),
    .CHAN_BOND_SEQ_1_2(10'b0000000000),
    .CHAN_BOND_SEQ_1_3(10'b0000000000),
    .CHAN_BOND_SEQ_1_4(10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_1(10'b0000000000),
    .CHAN_BOND_SEQ_2_2(10'b0000000000),
    .CHAN_BOND_SEQ_2_3(10'b0000000000),
    .CHAN_BOND_SEQ_2_4(10'b0000000000),
    .CHAN_BOND_SEQ_2_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_USE("FALSE"),
    .CHAN_BOND_SEQ_LEN(1),
    .CLK_CORRECT_USE("FALSE"),
    .CLK_COR_KEEP_IDLE("FALSE"),
    .CLK_COR_MAX_LAT(19),
    .CLK_COR_MIN_LAT(15),
    .CLK_COR_PRECEDENCE("TRUE"),
    .CLK_COR_REPEAT_WAIT(0),
    .CLK_COR_SEQ_1_1(10'b0100000000),
    .CLK_COR_SEQ_1_2(10'b0000000000),
    .CLK_COR_SEQ_1_3(10'b0000000000),
    .CLK_COR_SEQ_1_4(10'b0000000000),
    .CLK_COR_SEQ_1_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_1(10'b0100000000),
    .CLK_COR_SEQ_2_2(10'b0000000000),
    .CLK_COR_SEQ_2_3(10'b0000000000),
    .CLK_COR_SEQ_2_4(10'b0000000000),
    .CLK_COR_SEQ_2_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_USE("FALSE"),
    .CLK_COR_SEQ_LEN(1),
    .CPLL_CFG(29'h00BC07DC),
    .CPLL_FBDIV(4),
    .CPLL_FBDIV_45(5),
    .CPLL_INIT_CFG(24'h00001E),
    .CPLL_LOCK_CFG(16'h01E8),
    .CPLL_REFCLK_DIV(1),
    .DEC_MCOMMA_DETECT("FALSE"),
    .DEC_PCOMMA_DETECT("FALSE"),
    .DEC_VALID_COMMA_ONLY("FALSE"),
    .DMONITOR_CFG(24'h000A00),
    .ES_CLK_PHASE_SEL(1'b0),
    .ES_CONTROL(6'b000000),
    .ES_ERRDET_EN("FALSE"),
    .ES_EYE_SCAN_EN("TRUE"),
    .ES_HORZ_OFFSET(12'h000),
    .ES_PMA_CFG(10'b0000000000),
    .ES_PRESCALE(5'b00000),
    .ES_QUALIFIER(80'h00000000000000000000),
    .ES_QUAL_MASK(80'h00000000000000000000),
    .ES_SDATA_MASK(80'h00000000000000000000),
    .ES_VERT_OFFSET(9'b000000000),
    .FTS_DESKEW_SEQ_ENABLE(4'b1111),
    .FTS_LANE_DESKEW_CFG(4'b1111),
    .FTS_LANE_DESKEW_EN("FALSE"),
    .GEARBOX_MODE(3'b001),
    .IS_CLKRSVD0_INVERTED(1'b0),
    .IS_CLKRSVD1_INVERTED(1'b0),
    .IS_CPLLLOCKDETCLK_INVERTED(1'b0),
    .IS_DMONITORCLK_INVERTED(1'b0),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_RXUSRCLK2_INVERTED(1'b0),
    .IS_RXUSRCLK_INVERTED(1'b0),
    .IS_SIGVALIDCLK_INVERTED(1'b0),
    .IS_TXPHDLYTSTCLK_INVERTED(1'b0),
    .IS_TXUSRCLK2_INVERTED(1'b0),
    .IS_TXUSRCLK_INVERTED(1'b0),
    .LOOPBACK_CFG(1'b0),
    .OUTREFCLK_SEL_INV(2'b11),
    .PCS_PCIE_EN("FALSE"),
    .PCS_RSVD_ATTR(48'h000000000000),
    .PD_TRANS_TIME_FROM_P2(12'h03C),
    .PD_TRANS_TIME_NONE_P2(8'h19),
    .PD_TRANS_TIME_TO_P2(8'h64),
    .PMA_RSV(32'b00000000000000000000000010000000),
    .PMA_RSV2(32'b00011100000000000000000000001010),
    .PMA_RSV3(2'b00),
    .PMA_RSV4(15'b000000000001000),
    .PMA_RSV5(4'b0000),
    .RESET_POWERSAVE_DISABLE(1'b0),
    .RXBUFRESET_TIME(5'b00001),
    .RXBUF_ADDR_MODE("FAST"),
    .RXBUF_EIDLE_HI_CNT(4'b1000),
    .RXBUF_EIDLE_LO_CNT(4'b0000),
    .RXBUF_EN("TRUE"),
    .RXBUF_RESET_ON_CB_CHANGE("TRUE"),
    .RXBUF_RESET_ON_COMMAALIGN("FALSE"),
    .RXBUF_RESET_ON_EIDLE("FALSE"),
    .RXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .RXBUF_THRESH_OVFLW(61),
    .RXBUF_THRESH_OVRD("FALSE"),
    .RXBUF_THRESH_UNDFLW(4),
    .RXCDRFREQRESET_TIME(5'b00001),
    .RXCDRPHRESET_TIME(5'b00001),
    .RXCDR_CFG(83'h0002007FE2000C208001A),
    .RXCDR_FR_RESET_ON_EIDLE(1'b0),
    .RXCDR_HOLD_DURING_EIDLE(1'b0),
    .RXCDR_LOCK_CFG(6'b010101),
    .RXCDR_PH_RESET_ON_EIDLE(1'b0),
    .RXDFELPMRESET_TIME(7'b0001111),
    .RXDLY_CFG(16'h001F),
    .RXDLY_LCFG(9'h030),
    .RXDLY_TAP_CFG(16'h0000),
    .RXGEARBOX_EN("TRUE"),
    .RXISCANRESET_TIME(5'b00001),
    .RXLPM_HF_CFG(14'b00001000000000),
    .RXLPM_LF_CFG(18'b001001000000000000),
    .RXOOB_CFG(7'b0000110),
    .RXOOB_CLK_CFG("PMA"),
    .RXOSCALRESET_TIME(5'b00011),
    .RXOSCALRESET_TIMEOUT(5'b00000),
    .RXOUT_DIV(1),
    .RXPCSRESET_TIME(5'b00001),
    .RXPHDLY_CFG(24'h084020),
    .RXPH_CFG(24'hC00002),
    .RXPH_MONITOR_SEL(5'b00000),
    .RXPI_CFG0(2'b00),
    .RXPI_CFG1(2'b11),
    .RXPI_CFG2(2'b11),
    .RXPI_CFG3(2'b11),
    .RXPI_CFG4(1'b0),
    .RXPI_CFG5(1'b0),
    .RXPI_CFG6(3'b100),
    .RXPMARESET_TIME(5'b00011),
    .RXPRBS_ERR_LOOPBACK(1'b0),
    .RXSLIDE_AUTO_WAIT(7),
    .RXSLIDE_MODE("OFF"),
    .RXSYNC_MULTILANE(1'b1),
    .RXSYNC_OVRD(1'b0),
    .RXSYNC_SKIP_DA(1'b0),
    .RX_BIAS_CFG(24'b000011000000000000010000),
    .RX_BUFFER_CFG(6'b000000),
    .RX_CLK25_DIV(7),
    .RX_CLKMUX_PD(1'b1),
    .RX_CM_SEL(2'b11),
    .RX_CM_TRIM(4'b1010),
    .RX_DATA_WIDTH(64),
    .RX_DDI_SEL(6'b000000),
    .RX_DEBUG_CFG(14'b00000000000000),
    .RX_DEFER_RESET_BUF_EN("TRUE"),
    .RX_DFELPM_CFG0(4'b0110),
    .RX_DFELPM_CFG1(1'b0),
    .RX_DFELPM_KLKH_AGC_STUP_EN(1'b1),
    .RX_DFE_AGC_CFG0(2'b00),
    .RX_DFE_AGC_CFG1(3'b100),
    .RX_DFE_AGC_CFG2(4'b0000),
    .RX_DFE_AGC_OVRDEN(1'b1),
    .RX_DFE_GAIN_CFG(23'h0020C0),
    .RX_DFE_H2_CFG(12'b000000000000),
    .RX_DFE_H3_CFG(12'b000001000000),
    .RX_DFE_H4_CFG(11'b00011100000),
    .RX_DFE_H5_CFG(11'b00011100000),
    .RX_DFE_H6_CFG(11'b00000100000),
    .RX_DFE_H7_CFG(11'b00000100000),
    .RX_DFE_KL_CFG(33'b001000001000000000000001100010000),
    .RX_DFE_KL_LPM_KH_CFG0(2'b01),
    .RX_DFE_KL_LPM_KH_CFG1(3'b010),
    .RX_DFE_KL_LPM_KH_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KH_OVRDEN(1'b1),
    .RX_DFE_KL_LPM_KL_CFG0(2'b10),
    .RX_DFE_KL_LPM_KL_CFG1(3'b010),
    .RX_DFE_KL_LPM_KL_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KL_OVRDEN(1'b1),
    .RX_DFE_LPM_CFG(16'h0080),
    .RX_DFE_LPM_HOLD_DURING_EIDLE(1'b0),
    .RX_DFE_ST_CFG(54'h00E100000C003F),
    .RX_DFE_UT_CFG(17'b00011100000000000),
    .RX_DFE_VP_CFG(17'b00011101010100011),
    .RX_DISPERR_SEQ_MATCH("FALSE"),
    .RX_INT_DATAWIDTH(1),
    .RX_OS_CFG(13'b0000010000000),
    .RX_SIG_VALID_DLY(10),
    .RX_XCLK_SEL("RXREC"),
    .SAS_MAX_COM(64),
    .SAS_MIN_COM(36),
    .SATA_BURST_SEQ_LEN(4'b0101),
    .SATA_BURST_VAL(3'b100),
    .SATA_CPLL_CFG("VCO_3000MHZ"),
    .SATA_EIDLE_VAL(3'b100),
    .SATA_MAX_BURST(8),
    .SATA_MAX_INIT(21),
    .SATA_MAX_WAKE(7),
    .SATA_MIN_BURST(4),
    .SATA_MIN_INIT(12),
    .SATA_MIN_WAKE(4),
    .SHOW_REALIGN_COMMA("FALSE"),
    .SIM_CPLLREFCLK_SEL(3'b001),
    .SIM_RECEIVER_DETECT_PASS("TRUE"),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_TX_EIDLE_DRIVE_LEVEL("X"),
    .SIM_VERSION("2.0"),
    .TERM_RCAL_CFG(15'b100001000010000),
    .TERM_RCAL_OVRD(3'b000),
    .TRANS_TIME_RATE(8'h0E),
    .TST_RSV(32'h00000000),
    .TXBUF_EN("TRUE"),
    .TXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .TXDLY_CFG(16'h001F),
    .TXDLY_LCFG(9'h030),
    .TXDLY_TAP_CFG(16'h0000),
    .TXGEARBOX_EN("TRUE"),
    .TXOOB_CFG(1'b0),
    .TXOUT_DIV(1),
    .TXPCSRESET_TIME(5'b00001),
    .TXPHDLY_CFG(24'h084020),
    .TXPH_CFG(16'h0780),
    .TXPH_MONITOR_SEL(5'b00000),
    .TXPI_CFG0(2'b00),
    .TXPI_CFG1(2'b00),
    .TXPI_CFG2(2'b00),
    .TXPI_CFG3(1'b0),
    .TXPI_CFG4(1'b0),
    .TXPI_CFG5(3'b100),
    .TXPI_GREY_SEL(1'b0),
    .TXPI_INVSTROBE_SEL(1'b0),
    .TXPI_PPMCLK_SEL("TXUSRCLK2"),
    .TXPI_PPM_CFG(8'b00000000),
    .TXPI_SYNFREQ_PPM(3'b000),
    .TXPMARESET_TIME(5'b00001),
    .TXSYNC_MULTILANE(1'b0),
    .TXSYNC_OVRD(1'b0),
    .TXSYNC_SKIP_DA(1'b0),
    .TX_CLK25_DIV(7),
    .TX_CLKMUX_PD(1'b1),
    .TX_DATA_WIDTH(64),
    .TX_DEEMPH0(6'b000000),
    .TX_DEEMPH1(6'b000000),
    .TX_DRIVE_MODE("DIRECT"),
    .TX_EIDLE_ASSERT_DELAY(3'b110),
    .TX_EIDLE_DEASSERT_DELAY(3'b100),
    .TX_INT_DATAWIDTH(1),
    .TX_LOOPBACK_DRIVE_HIZ("FALSE"),
    .TX_MAINCURSOR_SEL(1'b0),
    .TX_MARGIN_FULL_0(7'b1001110),
    .TX_MARGIN_FULL_1(7'b1001001),
    .TX_MARGIN_FULL_2(7'b1000101),
    .TX_MARGIN_FULL_3(7'b1000010),
    .TX_MARGIN_FULL_4(7'b1000000),
    .TX_MARGIN_LOW_0(7'b1000110),
    .TX_MARGIN_LOW_1(7'b1000100),
    .TX_MARGIN_LOW_2(7'b1000010),
    .TX_MARGIN_LOW_3(7'b1000000),
    .TX_MARGIN_LOW_4(7'b1000000),
    .TX_QPI_STATUS_EN(1'b0),
    .TX_RXDETECT_CFG(14'h1832),
    .TX_RXDETECT_PRECHARGE_TIME(17'h155CC),
    .TX_RXDETECT_REF(3'b100),
    .TX_XCLK_SEL("TXOUT"),
    .UCODEER_CLR(1'b0),
    .USE_PCS_CLK_PHASE_SEL(1'b0)) 
     gthe2_i
       (.CFGRESET(1'b0),
        .CLKRSVD0(1'b0),
        .CLKRSVD1(1'b0),
        .CPLLFBCLKLOST(NLW_gthe2_i_CPLLFBCLKLOST_UNCONNECTED),
        .CPLLLOCK(NLW_gthe2_i_CPLLLOCK_UNCONNECTED),
        .CPLLLOCKDETCLK(1'b0),
        .CPLLLOCKEN(1'b1),
        .CPLLPD(1'b1),
        .CPLLREFCLKLOST(NLW_gthe2_i_CPLLREFCLKLOST_UNCONNECTED),
        .CPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .CPLLRESET(1'b0),
        .DMONFIFORESET(1'b0),
        .DMONITORCLK(1'b0),
        .DMONITOROUT(gt1_dmonitorout_out),
        .DRPADDR(gt1_drpaddr_in),
        .DRPCLK(gt1_drpclk_in),
        .DRPDI(gt1_drpdi_in),
        .DRPDO(gt1_drpdo_out),
        .DRPEN(gt1_drpen_in),
        .DRPRDY(gt1_drprdy_out),
        .DRPWE(gt1_drpwe_in),
        .EYESCANDATAERROR(gt1_eyescandataerror_out),
        .EYESCANMODE(1'b0),
        .EYESCANRESET(gt1_eyescanreset_in),
        .EYESCANTRIGGER(gt1_eyescantrigger_in),
        .GTGREFCLK(1'b0),
        .GTHRXN(gt1_gthrxn_in),
        .GTHRXP(gt1_gthrxp_in),
        .GTHTXN(gt1_gthtxn_out),
        .GTHTXP(gt1_gthtxp_out),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(1'b0),
        .GTREFCLK1(1'b0),
        .GTREFCLKMONITOR(NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED),
        .GTRESETSEL(1'b0),
        .GTRSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GTRXRESET(I1),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .GTTXRESET(gt1_gttxreset_in),
        .LOOPBACK(gt1_loopback_in),
        .PCSRSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDOUT(NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED[15:0]),
        .PHYSTATUS(NLW_gthe2_i_PHYSTATUS_UNCONNECTED),
        .PMARSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLCLK(GT0_QPLLOUTCLK_IN),
        .QPLLREFCLK(GT0_QPLLOUTREFCLK_IN),
        .RESETOVRD(1'b0),
        .RSOSINTDONE(NLW_gthe2_i_RSOSINTDONE_UNCONNECTED),
        .RX8B10BEN(1'b0),
        .RXADAPTSELTEST({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXBUFRESET(gt1_rxbufreset_in),
        .RXBUFSTATUS(gt1_rxbufstatus_out),
        .RXBYTEISALIGNED(NLW_gthe2_i_RXBYTEISALIGNED_UNCONNECTED),
        .RXBYTEREALIGN(NLW_gthe2_i_RXBYTEREALIGN_UNCONNECTED),
        .RXCDRFREQRESET(1'b0),
        .RXCDRHOLD(1'b0),
        .RXCDRLOCK(NLW_gthe2_i_RXCDRLOCK_UNCONNECTED),
        .RXCDROVRDEN(1'b0),
        .RXCDRRESET(1'b0),
        .RXCDRRESETRSV(1'b0),
        .RXCHANBONDSEQ(NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED),
        .RXCHANISALIGNED(NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED),
        .RXCHANREALIGN(NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED),
        .RXCHARISCOMMA(NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED[7:0]),
        .RXCHARISK(NLW_gthe2_i_RXCHARISK_UNCONNECTED[7:0]),
        .RXCHBONDEN(1'b0),
        .RXCHBONDI({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXCHBONDLEVEL({1'b0,1'b0,1'b0}),
        .RXCHBONDMASTER(1'b0),
        .RXCHBONDO(NLW_gthe2_i_RXCHBONDO_UNCONNECTED[4:0]),
        .RXCHBONDSLAVE(1'b0),
        .RXCLKCORCNT(NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED[1:0]),
        .RXCOMINITDET(NLW_gthe2_i_RXCOMINITDET_UNCONNECTED),
        .RXCOMMADET(NLW_gthe2_i_RXCOMMADET_UNCONNECTED),
        .RXCOMMADETEN(1'b0),
        .RXCOMSASDET(NLW_gthe2_i_RXCOMSASDET_UNCONNECTED),
        .RXCOMWAKEDET(NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED),
        .RXDATA(gt1_rxdata_out),
        .RXDATAVALID({NLW_gthe2_i_RXDATAVALID_UNCONNECTED[1],gt1_rxdatavalid_out}),
        .RXDDIEN(1'b0),
        .RXDFEAGCHOLD(1'b0),
        .RXDFEAGCOVRDEN(1'b0),
        .RXDFEAGCTRL({1'b1,1'b0,1'b0,1'b0,1'b0}),
        .RXDFECM1EN(1'b0),
        .RXDFELFHOLD(1'b0),
        .RXDFELFOVRDEN(1'b0),
        .RXDFELPMRESET(1'b0),
        .RXDFESLIDETAP({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPADAPTEN(1'b0),
        .RXDFESLIDETAPHOLD(1'b0),
        .RXDFESLIDETAPID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPINITOVRDEN(1'b0),
        .RXDFESLIDETAPONLYADAPTEN(1'b0),
        .RXDFESLIDETAPOVRDEN(1'b0),
        .RXDFESLIDETAPSTARTED(NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED),
        .RXDFESLIDETAPSTROBE(1'b0),
        .RXDFESLIDETAPSTROBEDONE(NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED),
        .RXDFESLIDETAPSTROBESTARTED(NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED),
        .RXDFESTADAPTDONE(NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED),
        .RXDFETAP2HOLD(1'b0),
        .RXDFETAP2OVRDEN(1'b0),
        .RXDFETAP3HOLD(1'b0),
        .RXDFETAP3OVRDEN(1'b0),
        .RXDFETAP4HOLD(1'b0),
        .RXDFETAP4OVRDEN(1'b0),
        .RXDFETAP5HOLD(1'b0),
        .RXDFETAP5OVRDEN(1'b0),
        .RXDFETAP6HOLD(1'b0),
        .RXDFETAP6OVRDEN(1'b0),
        .RXDFETAP7HOLD(1'b0),
        .RXDFETAP7OVRDEN(1'b0),
        .RXDFEUTHOLD(1'b0),
        .RXDFEUTOVRDEN(1'b0),
        .RXDFEVPHOLD(1'b0),
        .RXDFEVPOVRDEN(1'b0),
        .RXDFEVSEN(1'b0),
        .RXDFEXYDEN(1'b1),
        .RXDISPERR(NLW_gthe2_i_RXDISPERR_UNCONNECTED[7:0]),
        .RXDLYBYPASS(1'b1),
        .RXDLYEN(1'b0),
        .RXDLYOVRDEN(1'b0),
        .RXDLYSRESET(1'b0),
        .RXDLYSRESETDONE(NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED),
        .RXELECIDLE(NLW_gthe2_i_RXELECIDLE_UNCONNECTED),
        .RXELECIDLEMODE({1'b1,1'b1}),
        .RXGEARBOXSLIP(gt1_rxgearboxslip_in),
        .RXHEADER({NLW_gthe2_i_RXHEADER_UNCONNECTED[5:2],gt1_rxheader_out}),
        .RXHEADERVALID({NLW_gthe2_i_RXHEADERVALID_UNCONNECTED[1],gt1_rxheadervalid_out}),
        .RXLPMEN(1'b0),
        .RXLPMHFHOLD(1'b0),
        .RXLPMHFOVRDEN(1'b0),
        .RXLPMLFHOLD(1'b0),
        .RXLPMLFKLOVRDEN(1'b0),
        .RXMCOMMAALIGNEN(1'b0),
        .RXMONITOROUT(gt1_rxmonitorout_out),
        .RXMONITORSEL(gt1_rxmonitorsel_in),
        .RXNOTINTABLE(NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED[7:0]),
        .RXOOBRESET(1'b0),
        .RXOSCALRESET(1'b0),
        .RXOSHOLD(1'b0),
        .RXOSINTCFG({1'b0,1'b1,1'b1,1'b0}),
        .RXOSINTEN(1'b1),
        .RXOSINTHOLD(1'b0),
        .RXOSINTID0({1'b0,1'b0,1'b0,1'b0}),
        .RXOSINTNTRLEN(1'b0),
        .RXOSINTOVRDEN(1'b0),
        .RXOSINTSTARTED(NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED),
        .RXOSINTSTROBE(1'b0),
        .RXOSINTSTROBEDONE(NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED),
        .RXOSINTSTROBESTARTED(NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED),
        .RXOSINTTESTOVRDEN(1'b0),
        .RXOSOVRDEN(1'b0),
        .RXOUTCLK(gt1_rxoutclk_out),
        .RXOUTCLKFABRIC(NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED),
        .RXOUTCLKPCS(NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED),
        .RXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .RXPCOMMAALIGNEN(1'b0),
        .RXPCSRESET(gt1_rxpcsreset_in),
        .RXPD({1'b0,1'b0}),
        .RXPHALIGN(1'b0),
        .RXPHALIGNDONE(NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED),
        .RXPHALIGNEN(1'b0),
        .RXPHDLYPD(1'b0),
        .RXPHDLYRESET(1'b0),
        .RXPHMONITOR(NLW_gthe2_i_RXPHMONITOR_UNCONNECTED[4:0]),
        .RXPHOVRDEN(1'b0),
        .RXPHSLIPMONITOR(NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED[4:0]),
        .RXPMARESET(1'b0),
        .RXPMARESETDONE(GT1_RXPMARESETDONE_OUT),
        .RXPOLARITY(1'b0),
        .RXPRBSCNTRESET(gt1_rxprbscntreset_in),
        .RXPRBSERR(gt1_rxprbserr_out),
        .RXPRBSSEL(gt1_rxprbssel_in),
        .RXQPIEN(1'b0),
        .RXQPISENN(NLW_gthe2_i_RXQPISENN_UNCONNECTED),
        .RXQPISENP(NLW_gthe2_i_RXQPISENP_UNCONNECTED),
        .RXRATE({1'b0,1'b0,1'b0}),
        .RXRATEDONE(NLW_gthe2_i_RXRATEDONE_UNCONNECTED),
        .RXRATEMODE(1'b0),
        .RXRESETDONE(gt1_rxresetdone_out),
        .RXSLIDE(1'b0),
        .RXSTARTOFSEQ(NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED[1:0]),
        .RXSTATUS(NLW_gthe2_i_RXSTATUS_UNCONNECTED[2:0]),
        .RXSYNCALLIN(1'b0),
        .RXSYNCDONE(NLW_gthe2_i_RXSYNCDONE_UNCONNECTED),
        .RXSYNCIN(1'b0),
        .RXSYNCMODE(1'b0),
        .RXSYNCOUT(NLW_gthe2_i_RXSYNCOUT_UNCONNECTED),
        .RXSYSCLKSEL({1'b1,1'b1}),
        .RXUSERRDY(gt1_rxuserrdy_in),
        .RXUSRCLK(gt1_rxusrclk_in),
        .RXUSRCLK2(gt1_rxusrclk2_in),
        .RXVALID(NLW_gthe2_i_RXVALID_UNCONNECTED),
        .SETERRSTATUS(1'b0),
        .SIGVALIDCLK(1'b0),
        .TSTIN({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .TX8B10BBYPASS({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TX8B10BEN(1'b0),
        .TXBUFDIFFCTRL({1'b1,1'b0,1'b0}),
        .TXBUFSTATUS(gt1_txbufstatus_out),
        .TXCHARDISPMODE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARDISPVAL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARISK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCOMFINISH(NLW_gthe2_i_TXCOMFINISH_UNCONNECTED),
        .TXCOMINIT(1'b0),
        .TXCOMSAS(1'b0),
        .TXCOMWAKE(1'b0),
        .TXDATA(gt1_txdata_in),
        .TXDEEMPH(1'b0),
        .TXDETECTRX(1'b0),
        .TXDIFFCTRL({1'b1,1'b0,1'b0,1'b0}),
        .TXDIFFPD(1'b0),
        .TXDLYBYPASS(1'b1),
        .TXDLYEN(1'b0),
        .TXDLYHOLD(1'b0),
        .TXDLYOVRDEN(1'b0),
        .TXDLYSRESET(1'b0),
        .TXDLYSRESETDONE(NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED),
        .TXDLYUPDOWN(1'b0),
        .TXELECIDLE(gt1_txelecidle_in),
        .TXGEARBOXREADY(NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED),
        .TXHEADER({1'b0,gt1_txheader_in}),
        .TXINHIBIT(1'b0),
        .TXMAINCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXMARGIN({1'b0,1'b0,1'b0}),
        .TXOUTCLK(gt1_txoutclk_out),
        .TXOUTCLKFABRIC(gt1_txoutclkfabric_out),
        .TXOUTCLKPCS(gt1_txoutclkpcs_out),
        .TXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .TXPCSRESET(gt1_txpcsreset_in),
        .TXPD({1'b0,1'b0}),
        .TXPDELECIDLEMODE(1'b0),
        .TXPHALIGN(1'b0),
        .TXPHALIGNDONE(NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED),
        .TXPHALIGNEN(1'b0),
        .TXPHDLYPD(1'b0),
        .TXPHDLYRESET(1'b0),
        .TXPHDLYTSTCLK(1'b0),
        .TXPHINIT(1'b0),
        .TXPHINITDONE(NLW_gthe2_i_TXPHINITDONE_UNCONNECTED),
        .TXPHOVRDEN(1'b0),
        .TXPIPPMEN(1'b0),
        .TXPIPPMOVRDEN(1'b0),
        .TXPIPPMPD(1'b0),
        .TXPIPPMSEL(1'b1),
        .TXPIPPMSTEPSIZE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPISOPD(1'b0),
        .TXPMARESET(1'b0),
        .TXPMARESETDONE(n_50_gthe2_i),
        .TXPOLARITY(gt1_txpolarity_in),
        .TXPOSTCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPOSTCURSORINV(1'b0),
        .TXPRBSFORCEERR(gt1_txprbsforceerr_in),
        .TXPRBSSEL(gt1_txprbssel_in),
        .TXPRECURSOR({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPRECURSORINV(1'b0),
        .TXQPIBIASEN(1'b0),
        .TXQPISENN(NLW_gthe2_i_TXQPISENN_UNCONNECTED),
        .TXQPISENP(NLW_gthe2_i_TXQPISENP_UNCONNECTED),
        .TXQPISTRONGPDOWN(1'b0),
        .TXQPIWEAKPUP(1'b0),
        .TXRATE({1'b0,1'b0,1'b0}),
        .TXRATEDONE(NLW_gthe2_i_TXRATEDONE_UNCONNECTED),
        .TXRATEMODE(1'b0),
        .TXRESETDONE(gt1_txresetdone_out),
        .TXSEQUENCE(gt1_txsequence_in),
        .TXSTARTSEQ(1'b0),
        .TXSWING(1'b0),
        .TXSYNCALLIN(1'b0),
        .TXSYNCDONE(NLW_gthe2_i_TXSYNCDONE_UNCONNECTED),
        .TXSYNCIN(1'b0),
        .TXSYNCMODE(1'b0),
        .TXSYNCOUT(NLW_gthe2_i_TXSYNCOUT_UNCONNECTED),
        .TXSYSCLKSEL({1'b1,1'b1}),
        .TXUSERRDY(gt1_txuserrdy_in),
        .TXUSRCLK(gt1_txusrclk_in),
        .TXUSRCLK2(gt1_txusrclk2_in));
endmodule

(* ORIG_REF_NAME = "XLAUI_GT" *) 
module XLAUI_XLAUI_GT__parameterized0_66
   (gt2_drprdy_out,
    gt2_eyescandataerror_out,
    gt2_gthtxn_out,
    gt2_gthtxp_out,
    gt2_rxoutclk_out,
    GT2_RXPMARESETDONE_OUT,
    gt2_rxprbserr_out,
    gt2_rxresetdone_out,
    gt2_txoutclk_out,
    gt2_txoutclkfabric_out,
    gt2_txoutclkpcs_out,
    gt2_txresetdone_out,
    gt2_dmonitorout_out,
    gt2_drpdo_out,
    gt2_rxdatavalid_out,
    gt2_rxheadervalid_out,
    gt2_txbufstatus_out,
    gt2_rxbufstatus_out,
    gt2_rxheader_out,
    gt2_rxdata_out,
    gt2_rxmonitorout_out,
    gt2_drpclk_in,
    gt2_drpen_in,
    gt2_drpwe_in,
    gt2_eyescanreset_in,
    gt2_eyescantrigger_in,
    gt2_gthrxn_in,
    gt2_gthrxp_in,
    I2,
    gt2_gttxreset_in,
    GT0_QPLLOUTCLK_IN,
    GT0_QPLLOUTREFCLK_IN,
    gt2_rxbufreset_in,
    gt2_rxgearboxslip_in,
    gt2_rxpcsreset_in,
    gt2_rxprbscntreset_in,
    gt2_rxuserrdy_in,
    gt2_rxusrclk_in,
    gt2_rxusrclk2_in,
    gt2_txelecidle_in,
    gt2_txpcsreset_in,
    gt2_txpolarity_in,
    gt2_txprbsforceerr_in,
    gt2_txuserrdy_in,
    gt2_txusrclk_in,
    gt2_txusrclk2_in,
    gt2_drpdi_in,
    gt2_rxmonitorsel_in,
    gt2_loopback_in,
    gt2_rxprbssel_in,
    gt2_txheader_in,
    gt2_txprbssel_in,
    gt2_txdata_in,
    gt2_txsequence_in,
    gt2_drpaddr_in);
  output gt2_drprdy_out;
  output gt2_eyescandataerror_out;
  output gt2_gthtxn_out;
  output gt2_gthtxp_out;
  output gt2_rxoutclk_out;
  output GT2_RXPMARESETDONE_OUT;
  output gt2_rxprbserr_out;
  output gt2_rxresetdone_out;
  output gt2_txoutclk_out;
  output gt2_txoutclkfabric_out;
  output gt2_txoutclkpcs_out;
  output gt2_txresetdone_out;
  output [14:0]gt2_dmonitorout_out;
  output [15:0]gt2_drpdo_out;
  output gt2_rxdatavalid_out;
  output gt2_rxheadervalid_out;
  output [1:0]gt2_txbufstatus_out;
  output [2:0]gt2_rxbufstatus_out;
  output [1:0]gt2_rxheader_out;
  output [63:0]gt2_rxdata_out;
  output [6:0]gt2_rxmonitorout_out;
  input gt2_drpclk_in;
  input gt2_drpen_in;
  input gt2_drpwe_in;
  input gt2_eyescanreset_in;
  input gt2_eyescantrigger_in;
  input gt2_gthrxn_in;
  input gt2_gthrxp_in;
  input [0:0]I2;
  input gt2_gttxreset_in;
  input GT0_QPLLOUTCLK_IN;
  input GT0_QPLLOUTREFCLK_IN;
  input gt2_rxbufreset_in;
  input gt2_rxgearboxslip_in;
  input gt2_rxpcsreset_in;
  input gt2_rxprbscntreset_in;
  input gt2_rxuserrdy_in;
  input gt2_rxusrclk_in;
  input gt2_rxusrclk2_in;
  input gt2_txelecidle_in;
  input gt2_txpcsreset_in;
  input gt2_txpolarity_in;
  input gt2_txprbsforceerr_in;
  input gt2_txuserrdy_in;
  input gt2_txusrclk_in;
  input gt2_txusrclk2_in;
  input [15:0]gt2_drpdi_in;
  input [1:0]gt2_rxmonitorsel_in;
  input [2:0]gt2_loopback_in;
  input [2:0]gt2_rxprbssel_in;
  input [1:0]gt2_txheader_in;
  input [2:0]gt2_txprbssel_in;
  input [63:0]gt2_txdata_in;
  input [6:0]gt2_txsequence_in;
  input [8:0]gt2_drpaddr_in;

  wire GT0_QPLLOUTCLK_IN;
  wire GT0_QPLLOUTREFCLK_IN;
  wire GT2_RXPMARESETDONE_OUT;
  wire [0:0]I2;
  wire [14:0]gt2_dmonitorout_out;
  wire [8:0]gt2_drpaddr_in;
  wire gt2_drpclk_in;
  wire [15:0]gt2_drpdi_in;
  wire [15:0]gt2_drpdo_out;
  wire gt2_drpen_in;
  wire gt2_drprdy_out;
  wire gt2_drpwe_in;
  wire gt2_eyescandataerror_out;
  wire gt2_eyescanreset_in;
  wire gt2_eyescantrigger_in;
  wire gt2_gthrxn_in;
  wire gt2_gthrxp_in;
  wire gt2_gthtxn_out;
  wire gt2_gthtxp_out;
  wire gt2_gttxreset_in;
  wire [2:0]gt2_loopback_in;
  wire gt2_rxbufreset_in;
  wire [2:0]gt2_rxbufstatus_out;
  wire [63:0]gt2_rxdata_out;
  wire gt2_rxdatavalid_out;
  wire gt2_rxgearboxslip_in;
  wire [1:0]gt2_rxheader_out;
  wire gt2_rxheadervalid_out;
  wire [6:0]gt2_rxmonitorout_out;
  wire [1:0]gt2_rxmonitorsel_in;
  wire gt2_rxoutclk_out;
  wire gt2_rxpcsreset_in;
  wire gt2_rxprbscntreset_in;
  wire gt2_rxprbserr_out;
  wire [2:0]gt2_rxprbssel_in;
  wire gt2_rxresetdone_out;
  wire gt2_rxuserrdy_in;
  wire gt2_rxusrclk2_in;
  wire gt2_rxusrclk_in;
  wire [1:0]gt2_txbufstatus_out;
  wire [63:0]gt2_txdata_in;
  wire gt2_txelecidle_in;
  wire [1:0]gt2_txheader_in;
  wire gt2_txoutclk_out;
  wire gt2_txoutclkfabric_out;
  wire gt2_txoutclkpcs_out;
  wire gt2_txpcsreset_in;
  wire gt2_txpolarity_in;
  wire gt2_txprbsforceerr_in;
  wire [2:0]gt2_txprbssel_in;
  wire gt2_txresetdone_out;
  wire [6:0]gt2_txsequence_in;
  wire gt2_txuserrdy_in;
  wire gt2_txusrclk2_in;
  wire gt2_txusrclk_in;
  wire n_50_gthe2_i;
  wire NLW_gthe2_i_CPLLFBCLKLOST_UNCONNECTED;
  wire NLW_gthe2_i_CPLLLOCK_UNCONNECTED;
  wire NLW_gthe2_i_CPLLREFCLKLOST_UNCONNECTED;
  wire NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED;
  wire NLW_gthe2_i_PHYSTATUS_UNCONNECTED;
  wire NLW_gthe2_i_RSOSINTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXBYTEISALIGNED_UNCONNECTED;
  wire NLW_gthe2_i_RXBYTEREALIGN_UNCONNECTED;
  wire NLW_gthe2_i_RXCDRLOCK_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMINITDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMMADET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMSASDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXELECIDLE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED;
  wire NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_RXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCOUT_UNCONNECTED;
  wire NLW_gthe2_i_RXVALID_UNCONNECTED;
  wire NLW_gthe2_i_TXCOMFINISH_UNCONNECTED;
  wire NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED;
  wire NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXPHINITDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_TXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCOUT_UNCONNECTED;
  wire [15:0]NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXCHARISK_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXCHBONDO_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED;
  wire [1:1]NLW_gthe2_i_RXDATAVALID_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXDISPERR_UNCONNECTED;
  wire [5:2]NLW_gthe2_i_RXHEADER_UNCONNECTED;
  wire [1:1]NLW_gthe2_i_RXHEADERVALID_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHMONITOR_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED;
  wire [2:0]NLW_gthe2_i_RXSTATUS_UNCONNECTED;

(* box_type = "PRIMITIVE" *) 
   GTHE2_CHANNEL #(
    .ACJTAG_DEBUG_MODE(1'b0),
    .ACJTAG_MODE(1'b0),
    .ACJTAG_RESET(1'b0),
    .ADAPT_CFG0(20'h00C10),
    .ALIGN_COMMA_DOUBLE("FALSE"),
    .ALIGN_COMMA_ENABLE(10'b0001111111),
    .ALIGN_COMMA_WORD(1),
    .ALIGN_MCOMMA_DET("FALSE"),
    .ALIGN_MCOMMA_VALUE(10'b1010000011),
    .ALIGN_PCOMMA_DET("FALSE"),
    .ALIGN_PCOMMA_VALUE(10'b0101111100),
    .A_RXOSCALRESET(1'b0),
    .CBCC_DATA_SOURCE_SEL("ENCODED"),
    .CFOK_CFG(42'h24800040E80),
    .CFOK_CFG2(6'b100000),
    .CFOK_CFG3(6'b100000),
    .CHAN_BOND_KEEP_ALIGN("FALSE"),
    .CHAN_BOND_MAX_SKEW(1),
    .CHAN_BOND_SEQ_1_1(10'b0000000000),
    .CHAN_BOND_SEQ_1_2(10'b0000000000),
    .CHAN_BOND_SEQ_1_3(10'b0000000000),
    .CHAN_BOND_SEQ_1_4(10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_1(10'b0000000000),
    .CHAN_BOND_SEQ_2_2(10'b0000000000),
    .CHAN_BOND_SEQ_2_3(10'b0000000000),
    .CHAN_BOND_SEQ_2_4(10'b0000000000),
    .CHAN_BOND_SEQ_2_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_USE("FALSE"),
    .CHAN_BOND_SEQ_LEN(1),
    .CLK_CORRECT_USE("FALSE"),
    .CLK_COR_KEEP_IDLE("FALSE"),
    .CLK_COR_MAX_LAT(19),
    .CLK_COR_MIN_LAT(15),
    .CLK_COR_PRECEDENCE("TRUE"),
    .CLK_COR_REPEAT_WAIT(0),
    .CLK_COR_SEQ_1_1(10'b0100000000),
    .CLK_COR_SEQ_1_2(10'b0000000000),
    .CLK_COR_SEQ_1_3(10'b0000000000),
    .CLK_COR_SEQ_1_4(10'b0000000000),
    .CLK_COR_SEQ_1_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_1(10'b0100000000),
    .CLK_COR_SEQ_2_2(10'b0000000000),
    .CLK_COR_SEQ_2_3(10'b0000000000),
    .CLK_COR_SEQ_2_4(10'b0000000000),
    .CLK_COR_SEQ_2_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_USE("FALSE"),
    .CLK_COR_SEQ_LEN(1),
    .CPLL_CFG(29'h00BC07DC),
    .CPLL_FBDIV(4),
    .CPLL_FBDIV_45(5),
    .CPLL_INIT_CFG(24'h00001E),
    .CPLL_LOCK_CFG(16'h01E8),
    .CPLL_REFCLK_DIV(1),
    .DEC_MCOMMA_DETECT("FALSE"),
    .DEC_PCOMMA_DETECT("FALSE"),
    .DEC_VALID_COMMA_ONLY("FALSE"),
    .DMONITOR_CFG(24'h000A00),
    .ES_CLK_PHASE_SEL(1'b0),
    .ES_CONTROL(6'b000000),
    .ES_ERRDET_EN("FALSE"),
    .ES_EYE_SCAN_EN("TRUE"),
    .ES_HORZ_OFFSET(12'h000),
    .ES_PMA_CFG(10'b0000000000),
    .ES_PRESCALE(5'b00000),
    .ES_QUALIFIER(80'h00000000000000000000),
    .ES_QUAL_MASK(80'h00000000000000000000),
    .ES_SDATA_MASK(80'h00000000000000000000),
    .ES_VERT_OFFSET(9'b000000000),
    .FTS_DESKEW_SEQ_ENABLE(4'b1111),
    .FTS_LANE_DESKEW_CFG(4'b1111),
    .FTS_LANE_DESKEW_EN("FALSE"),
    .GEARBOX_MODE(3'b001),
    .IS_CLKRSVD0_INVERTED(1'b0),
    .IS_CLKRSVD1_INVERTED(1'b0),
    .IS_CPLLLOCKDETCLK_INVERTED(1'b0),
    .IS_DMONITORCLK_INVERTED(1'b0),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_RXUSRCLK2_INVERTED(1'b0),
    .IS_RXUSRCLK_INVERTED(1'b0),
    .IS_SIGVALIDCLK_INVERTED(1'b0),
    .IS_TXPHDLYTSTCLK_INVERTED(1'b0),
    .IS_TXUSRCLK2_INVERTED(1'b0),
    .IS_TXUSRCLK_INVERTED(1'b0),
    .LOOPBACK_CFG(1'b0),
    .OUTREFCLK_SEL_INV(2'b11),
    .PCS_PCIE_EN("FALSE"),
    .PCS_RSVD_ATTR(48'h000000000000),
    .PD_TRANS_TIME_FROM_P2(12'h03C),
    .PD_TRANS_TIME_NONE_P2(8'h19),
    .PD_TRANS_TIME_TO_P2(8'h64),
    .PMA_RSV(32'b00000000000000000000000010000000),
    .PMA_RSV2(32'b00011100000000000000000000001010),
    .PMA_RSV3(2'b00),
    .PMA_RSV4(15'b000000000001000),
    .PMA_RSV5(4'b0000),
    .RESET_POWERSAVE_DISABLE(1'b0),
    .RXBUFRESET_TIME(5'b00001),
    .RXBUF_ADDR_MODE("FAST"),
    .RXBUF_EIDLE_HI_CNT(4'b1000),
    .RXBUF_EIDLE_LO_CNT(4'b0000),
    .RXBUF_EN("TRUE"),
    .RXBUF_RESET_ON_CB_CHANGE("TRUE"),
    .RXBUF_RESET_ON_COMMAALIGN("FALSE"),
    .RXBUF_RESET_ON_EIDLE("FALSE"),
    .RXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .RXBUF_THRESH_OVFLW(61),
    .RXBUF_THRESH_OVRD("FALSE"),
    .RXBUF_THRESH_UNDFLW(4),
    .RXCDRFREQRESET_TIME(5'b00001),
    .RXCDRPHRESET_TIME(5'b00001),
    .RXCDR_CFG(83'h0002007FE2000C208001A),
    .RXCDR_FR_RESET_ON_EIDLE(1'b0),
    .RXCDR_HOLD_DURING_EIDLE(1'b0),
    .RXCDR_LOCK_CFG(6'b010101),
    .RXCDR_PH_RESET_ON_EIDLE(1'b0),
    .RXDFELPMRESET_TIME(7'b0001111),
    .RXDLY_CFG(16'h001F),
    .RXDLY_LCFG(9'h030),
    .RXDLY_TAP_CFG(16'h0000),
    .RXGEARBOX_EN("TRUE"),
    .RXISCANRESET_TIME(5'b00001),
    .RXLPM_HF_CFG(14'b00001000000000),
    .RXLPM_LF_CFG(18'b001001000000000000),
    .RXOOB_CFG(7'b0000110),
    .RXOOB_CLK_CFG("PMA"),
    .RXOSCALRESET_TIME(5'b00011),
    .RXOSCALRESET_TIMEOUT(5'b00000),
    .RXOUT_DIV(1),
    .RXPCSRESET_TIME(5'b00001),
    .RXPHDLY_CFG(24'h084020),
    .RXPH_CFG(24'hC00002),
    .RXPH_MONITOR_SEL(5'b00000),
    .RXPI_CFG0(2'b00),
    .RXPI_CFG1(2'b11),
    .RXPI_CFG2(2'b11),
    .RXPI_CFG3(2'b11),
    .RXPI_CFG4(1'b0),
    .RXPI_CFG5(1'b0),
    .RXPI_CFG6(3'b100),
    .RXPMARESET_TIME(5'b00011),
    .RXPRBS_ERR_LOOPBACK(1'b0),
    .RXSLIDE_AUTO_WAIT(7),
    .RXSLIDE_MODE("OFF"),
    .RXSYNC_MULTILANE(1'b1),
    .RXSYNC_OVRD(1'b0),
    .RXSYNC_SKIP_DA(1'b0),
    .RX_BIAS_CFG(24'b000011000000000000010000),
    .RX_BUFFER_CFG(6'b000000),
    .RX_CLK25_DIV(7),
    .RX_CLKMUX_PD(1'b1),
    .RX_CM_SEL(2'b11),
    .RX_CM_TRIM(4'b1010),
    .RX_DATA_WIDTH(64),
    .RX_DDI_SEL(6'b000000),
    .RX_DEBUG_CFG(14'b00000000000000),
    .RX_DEFER_RESET_BUF_EN("TRUE"),
    .RX_DFELPM_CFG0(4'b0110),
    .RX_DFELPM_CFG1(1'b0),
    .RX_DFELPM_KLKH_AGC_STUP_EN(1'b1),
    .RX_DFE_AGC_CFG0(2'b00),
    .RX_DFE_AGC_CFG1(3'b100),
    .RX_DFE_AGC_CFG2(4'b0000),
    .RX_DFE_AGC_OVRDEN(1'b1),
    .RX_DFE_GAIN_CFG(23'h0020C0),
    .RX_DFE_H2_CFG(12'b000000000000),
    .RX_DFE_H3_CFG(12'b000001000000),
    .RX_DFE_H4_CFG(11'b00011100000),
    .RX_DFE_H5_CFG(11'b00011100000),
    .RX_DFE_H6_CFG(11'b00000100000),
    .RX_DFE_H7_CFG(11'b00000100000),
    .RX_DFE_KL_CFG(33'b001000001000000000000001100010000),
    .RX_DFE_KL_LPM_KH_CFG0(2'b01),
    .RX_DFE_KL_LPM_KH_CFG1(3'b010),
    .RX_DFE_KL_LPM_KH_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KH_OVRDEN(1'b1),
    .RX_DFE_KL_LPM_KL_CFG0(2'b10),
    .RX_DFE_KL_LPM_KL_CFG1(3'b010),
    .RX_DFE_KL_LPM_KL_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KL_OVRDEN(1'b1),
    .RX_DFE_LPM_CFG(16'h0080),
    .RX_DFE_LPM_HOLD_DURING_EIDLE(1'b0),
    .RX_DFE_ST_CFG(54'h00E100000C003F),
    .RX_DFE_UT_CFG(17'b00011100000000000),
    .RX_DFE_VP_CFG(17'b00011101010100011),
    .RX_DISPERR_SEQ_MATCH("FALSE"),
    .RX_INT_DATAWIDTH(1),
    .RX_OS_CFG(13'b0000010000000),
    .RX_SIG_VALID_DLY(10),
    .RX_XCLK_SEL("RXREC"),
    .SAS_MAX_COM(64),
    .SAS_MIN_COM(36),
    .SATA_BURST_SEQ_LEN(4'b0101),
    .SATA_BURST_VAL(3'b100),
    .SATA_CPLL_CFG("VCO_3000MHZ"),
    .SATA_EIDLE_VAL(3'b100),
    .SATA_MAX_BURST(8),
    .SATA_MAX_INIT(21),
    .SATA_MAX_WAKE(7),
    .SATA_MIN_BURST(4),
    .SATA_MIN_INIT(12),
    .SATA_MIN_WAKE(4),
    .SHOW_REALIGN_COMMA("FALSE"),
    .SIM_CPLLREFCLK_SEL(3'b001),
    .SIM_RECEIVER_DETECT_PASS("TRUE"),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_TX_EIDLE_DRIVE_LEVEL("X"),
    .SIM_VERSION("2.0"),
    .TERM_RCAL_CFG(15'b100001000010000),
    .TERM_RCAL_OVRD(3'b000),
    .TRANS_TIME_RATE(8'h0E),
    .TST_RSV(32'h00000000),
    .TXBUF_EN("TRUE"),
    .TXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .TXDLY_CFG(16'h001F),
    .TXDLY_LCFG(9'h030),
    .TXDLY_TAP_CFG(16'h0000),
    .TXGEARBOX_EN("TRUE"),
    .TXOOB_CFG(1'b0),
    .TXOUT_DIV(1),
    .TXPCSRESET_TIME(5'b00001),
    .TXPHDLY_CFG(24'h084020),
    .TXPH_CFG(16'h0780),
    .TXPH_MONITOR_SEL(5'b00000),
    .TXPI_CFG0(2'b00),
    .TXPI_CFG1(2'b00),
    .TXPI_CFG2(2'b00),
    .TXPI_CFG3(1'b0),
    .TXPI_CFG4(1'b0),
    .TXPI_CFG5(3'b100),
    .TXPI_GREY_SEL(1'b0),
    .TXPI_INVSTROBE_SEL(1'b0),
    .TXPI_PPMCLK_SEL("TXUSRCLK2"),
    .TXPI_PPM_CFG(8'b00000000),
    .TXPI_SYNFREQ_PPM(3'b000),
    .TXPMARESET_TIME(5'b00001),
    .TXSYNC_MULTILANE(1'b0),
    .TXSYNC_OVRD(1'b0),
    .TXSYNC_SKIP_DA(1'b0),
    .TX_CLK25_DIV(7),
    .TX_CLKMUX_PD(1'b1),
    .TX_DATA_WIDTH(64),
    .TX_DEEMPH0(6'b000000),
    .TX_DEEMPH1(6'b000000),
    .TX_DRIVE_MODE("DIRECT"),
    .TX_EIDLE_ASSERT_DELAY(3'b110),
    .TX_EIDLE_DEASSERT_DELAY(3'b100),
    .TX_INT_DATAWIDTH(1),
    .TX_LOOPBACK_DRIVE_HIZ("FALSE"),
    .TX_MAINCURSOR_SEL(1'b0),
    .TX_MARGIN_FULL_0(7'b1001110),
    .TX_MARGIN_FULL_1(7'b1001001),
    .TX_MARGIN_FULL_2(7'b1000101),
    .TX_MARGIN_FULL_3(7'b1000010),
    .TX_MARGIN_FULL_4(7'b1000000),
    .TX_MARGIN_LOW_0(7'b1000110),
    .TX_MARGIN_LOW_1(7'b1000100),
    .TX_MARGIN_LOW_2(7'b1000010),
    .TX_MARGIN_LOW_3(7'b1000000),
    .TX_MARGIN_LOW_4(7'b1000000),
    .TX_QPI_STATUS_EN(1'b0),
    .TX_RXDETECT_CFG(14'h1832),
    .TX_RXDETECT_PRECHARGE_TIME(17'h155CC),
    .TX_RXDETECT_REF(3'b100),
    .TX_XCLK_SEL("TXOUT"),
    .UCODEER_CLR(1'b0),
    .USE_PCS_CLK_PHASE_SEL(1'b0)) 
     gthe2_i
       (.CFGRESET(1'b0),
        .CLKRSVD0(1'b0),
        .CLKRSVD1(1'b0),
        .CPLLFBCLKLOST(NLW_gthe2_i_CPLLFBCLKLOST_UNCONNECTED),
        .CPLLLOCK(NLW_gthe2_i_CPLLLOCK_UNCONNECTED),
        .CPLLLOCKDETCLK(1'b0),
        .CPLLLOCKEN(1'b1),
        .CPLLPD(1'b1),
        .CPLLREFCLKLOST(NLW_gthe2_i_CPLLREFCLKLOST_UNCONNECTED),
        .CPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .CPLLRESET(1'b0),
        .DMONFIFORESET(1'b0),
        .DMONITORCLK(1'b0),
        .DMONITOROUT(gt2_dmonitorout_out),
        .DRPADDR(gt2_drpaddr_in),
        .DRPCLK(gt2_drpclk_in),
        .DRPDI(gt2_drpdi_in),
        .DRPDO(gt2_drpdo_out),
        .DRPEN(gt2_drpen_in),
        .DRPRDY(gt2_drprdy_out),
        .DRPWE(gt2_drpwe_in),
        .EYESCANDATAERROR(gt2_eyescandataerror_out),
        .EYESCANMODE(1'b0),
        .EYESCANRESET(gt2_eyescanreset_in),
        .EYESCANTRIGGER(gt2_eyescantrigger_in),
        .GTGREFCLK(1'b0),
        .GTHRXN(gt2_gthrxn_in),
        .GTHRXP(gt2_gthrxp_in),
        .GTHTXN(gt2_gthtxn_out),
        .GTHTXP(gt2_gthtxp_out),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(1'b0),
        .GTREFCLK1(1'b0),
        .GTREFCLKMONITOR(NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED),
        .GTRESETSEL(1'b0),
        .GTRSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GTRXRESET(I2),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .GTTXRESET(gt2_gttxreset_in),
        .LOOPBACK(gt2_loopback_in),
        .PCSRSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDOUT(NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED[15:0]),
        .PHYSTATUS(NLW_gthe2_i_PHYSTATUS_UNCONNECTED),
        .PMARSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLCLK(GT0_QPLLOUTCLK_IN),
        .QPLLREFCLK(GT0_QPLLOUTREFCLK_IN),
        .RESETOVRD(1'b0),
        .RSOSINTDONE(NLW_gthe2_i_RSOSINTDONE_UNCONNECTED),
        .RX8B10BEN(1'b0),
        .RXADAPTSELTEST({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXBUFRESET(gt2_rxbufreset_in),
        .RXBUFSTATUS(gt2_rxbufstatus_out),
        .RXBYTEISALIGNED(NLW_gthe2_i_RXBYTEISALIGNED_UNCONNECTED),
        .RXBYTEREALIGN(NLW_gthe2_i_RXBYTEREALIGN_UNCONNECTED),
        .RXCDRFREQRESET(1'b0),
        .RXCDRHOLD(1'b0),
        .RXCDRLOCK(NLW_gthe2_i_RXCDRLOCK_UNCONNECTED),
        .RXCDROVRDEN(1'b0),
        .RXCDRRESET(1'b0),
        .RXCDRRESETRSV(1'b0),
        .RXCHANBONDSEQ(NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED),
        .RXCHANISALIGNED(NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED),
        .RXCHANREALIGN(NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED),
        .RXCHARISCOMMA(NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED[7:0]),
        .RXCHARISK(NLW_gthe2_i_RXCHARISK_UNCONNECTED[7:0]),
        .RXCHBONDEN(1'b0),
        .RXCHBONDI({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXCHBONDLEVEL({1'b0,1'b0,1'b0}),
        .RXCHBONDMASTER(1'b0),
        .RXCHBONDO(NLW_gthe2_i_RXCHBONDO_UNCONNECTED[4:0]),
        .RXCHBONDSLAVE(1'b0),
        .RXCLKCORCNT(NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED[1:0]),
        .RXCOMINITDET(NLW_gthe2_i_RXCOMINITDET_UNCONNECTED),
        .RXCOMMADET(NLW_gthe2_i_RXCOMMADET_UNCONNECTED),
        .RXCOMMADETEN(1'b0),
        .RXCOMSASDET(NLW_gthe2_i_RXCOMSASDET_UNCONNECTED),
        .RXCOMWAKEDET(NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED),
        .RXDATA(gt2_rxdata_out),
        .RXDATAVALID({NLW_gthe2_i_RXDATAVALID_UNCONNECTED[1],gt2_rxdatavalid_out}),
        .RXDDIEN(1'b0),
        .RXDFEAGCHOLD(1'b0),
        .RXDFEAGCOVRDEN(1'b0),
        .RXDFEAGCTRL({1'b1,1'b0,1'b0,1'b0,1'b0}),
        .RXDFECM1EN(1'b0),
        .RXDFELFHOLD(1'b0),
        .RXDFELFOVRDEN(1'b0),
        .RXDFELPMRESET(1'b0),
        .RXDFESLIDETAP({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPADAPTEN(1'b0),
        .RXDFESLIDETAPHOLD(1'b0),
        .RXDFESLIDETAPID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPINITOVRDEN(1'b0),
        .RXDFESLIDETAPONLYADAPTEN(1'b0),
        .RXDFESLIDETAPOVRDEN(1'b0),
        .RXDFESLIDETAPSTARTED(NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED),
        .RXDFESLIDETAPSTROBE(1'b0),
        .RXDFESLIDETAPSTROBEDONE(NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED),
        .RXDFESLIDETAPSTROBESTARTED(NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED),
        .RXDFESTADAPTDONE(NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED),
        .RXDFETAP2HOLD(1'b0),
        .RXDFETAP2OVRDEN(1'b0),
        .RXDFETAP3HOLD(1'b0),
        .RXDFETAP3OVRDEN(1'b0),
        .RXDFETAP4HOLD(1'b0),
        .RXDFETAP4OVRDEN(1'b0),
        .RXDFETAP5HOLD(1'b0),
        .RXDFETAP5OVRDEN(1'b0),
        .RXDFETAP6HOLD(1'b0),
        .RXDFETAP6OVRDEN(1'b0),
        .RXDFETAP7HOLD(1'b0),
        .RXDFETAP7OVRDEN(1'b0),
        .RXDFEUTHOLD(1'b0),
        .RXDFEUTOVRDEN(1'b0),
        .RXDFEVPHOLD(1'b0),
        .RXDFEVPOVRDEN(1'b0),
        .RXDFEVSEN(1'b0),
        .RXDFEXYDEN(1'b1),
        .RXDISPERR(NLW_gthe2_i_RXDISPERR_UNCONNECTED[7:0]),
        .RXDLYBYPASS(1'b1),
        .RXDLYEN(1'b0),
        .RXDLYOVRDEN(1'b0),
        .RXDLYSRESET(1'b0),
        .RXDLYSRESETDONE(NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED),
        .RXELECIDLE(NLW_gthe2_i_RXELECIDLE_UNCONNECTED),
        .RXELECIDLEMODE({1'b1,1'b1}),
        .RXGEARBOXSLIP(gt2_rxgearboxslip_in),
        .RXHEADER({NLW_gthe2_i_RXHEADER_UNCONNECTED[5:2],gt2_rxheader_out}),
        .RXHEADERVALID({NLW_gthe2_i_RXHEADERVALID_UNCONNECTED[1],gt2_rxheadervalid_out}),
        .RXLPMEN(1'b0),
        .RXLPMHFHOLD(1'b0),
        .RXLPMHFOVRDEN(1'b0),
        .RXLPMLFHOLD(1'b0),
        .RXLPMLFKLOVRDEN(1'b0),
        .RXMCOMMAALIGNEN(1'b0),
        .RXMONITOROUT(gt2_rxmonitorout_out),
        .RXMONITORSEL(gt2_rxmonitorsel_in),
        .RXNOTINTABLE(NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED[7:0]),
        .RXOOBRESET(1'b0),
        .RXOSCALRESET(1'b0),
        .RXOSHOLD(1'b0),
        .RXOSINTCFG({1'b0,1'b1,1'b1,1'b0}),
        .RXOSINTEN(1'b1),
        .RXOSINTHOLD(1'b0),
        .RXOSINTID0({1'b0,1'b0,1'b0,1'b0}),
        .RXOSINTNTRLEN(1'b0),
        .RXOSINTOVRDEN(1'b0),
        .RXOSINTSTARTED(NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED),
        .RXOSINTSTROBE(1'b0),
        .RXOSINTSTROBEDONE(NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED),
        .RXOSINTSTROBESTARTED(NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED),
        .RXOSINTTESTOVRDEN(1'b0),
        .RXOSOVRDEN(1'b0),
        .RXOUTCLK(gt2_rxoutclk_out),
        .RXOUTCLKFABRIC(NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED),
        .RXOUTCLKPCS(NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED),
        .RXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .RXPCOMMAALIGNEN(1'b0),
        .RXPCSRESET(gt2_rxpcsreset_in),
        .RXPD({1'b0,1'b0}),
        .RXPHALIGN(1'b0),
        .RXPHALIGNDONE(NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED),
        .RXPHALIGNEN(1'b0),
        .RXPHDLYPD(1'b0),
        .RXPHDLYRESET(1'b0),
        .RXPHMONITOR(NLW_gthe2_i_RXPHMONITOR_UNCONNECTED[4:0]),
        .RXPHOVRDEN(1'b0),
        .RXPHSLIPMONITOR(NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED[4:0]),
        .RXPMARESET(1'b0),
        .RXPMARESETDONE(GT2_RXPMARESETDONE_OUT),
        .RXPOLARITY(1'b0),
        .RXPRBSCNTRESET(gt2_rxprbscntreset_in),
        .RXPRBSERR(gt2_rxprbserr_out),
        .RXPRBSSEL(gt2_rxprbssel_in),
        .RXQPIEN(1'b0),
        .RXQPISENN(NLW_gthe2_i_RXQPISENN_UNCONNECTED),
        .RXQPISENP(NLW_gthe2_i_RXQPISENP_UNCONNECTED),
        .RXRATE({1'b0,1'b0,1'b0}),
        .RXRATEDONE(NLW_gthe2_i_RXRATEDONE_UNCONNECTED),
        .RXRATEMODE(1'b0),
        .RXRESETDONE(gt2_rxresetdone_out),
        .RXSLIDE(1'b0),
        .RXSTARTOFSEQ(NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED[1:0]),
        .RXSTATUS(NLW_gthe2_i_RXSTATUS_UNCONNECTED[2:0]),
        .RXSYNCALLIN(1'b0),
        .RXSYNCDONE(NLW_gthe2_i_RXSYNCDONE_UNCONNECTED),
        .RXSYNCIN(1'b0),
        .RXSYNCMODE(1'b0),
        .RXSYNCOUT(NLW_gthe2_i_RXSYNCOUT_UNCONNECTED),
        .RXSYSCLKSEL({1'b1,1'b1}),
        .RXUSERRDY(gt2_rxuserrdy_in),
        .RXUSRCLK(gt2_rxusrclk_in),
        .RXUSRCLK2(gt2_rxusrclk2_in),
        .RXVALID(NLW_gthe2_i_RXVALID_UNCONNECTED),
        .SETERRSTATUS(1'b0),
        .SIGVALIDCLK(1'b0),
        .TSTIN({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .TX8B10BBYPASS({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TX8B10BEN(1'b0),
        .TXBUFDIFFCTRL({1'b1,1'b0,1'b0}),
        .TXBUFSTATUS(gt2_txbufstatus_out),
        .TXCHARDISPMODE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARDISPVAL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARISK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCOMFINISH(NLW_gthe2_i_TXCOMFINISH_UNCONNECTED),
        .TXCOMINIT(1'b0),
        .TXCOMSAS(1'b0),
        .TXCOMWAKE(1'b0),
        .TXDATA(gt2_txdata_in),
        .TXDEEMPH(1'b0),
        .TXDETECTRX(1'b0),
        .TXDIFFCTRL({1'b1,1'b0,1'b0,1'b0}),
        .TXDIFFPD(1'b0),
        .TXDLYBYPASS(1'b1),
        .TXDLYEN(1'b0),
        .TXDLYHOLD(1'b0),
        .TXDLYOVRDEN(1'b0),
        .TXDLYSRESET(1'b0),
        .TXDLYSRESETDONE(NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED),
        .TXDLYUPDOWN(1'b0),
        .TXELECIDLE(gt2_txelecidle_in),
        .TXGEARBOXREADY(NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED),
        .TXHEADER({1'b0,gt2_txheader_in}),
        .TXINHIBIT(1'b0),
        .TXMAINCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXMARGIN({1'b0,1'b0,1'b0}),
        .TXOUTCLK(gt2_txoutclk_out),
        .TXOUTCLKFABRIC(gt2_txoutclkfabric_out),
        .TXOUTCLKPCS(gt2_txoutclkpcs_out),
        .TXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .TXPCSRESET(gt2_txpcsreset_in),
        .TXPD({1'b0,1'b0}),
        .TXPDELECIDLEMODE(1'b0),
        .TXPHALIGN(1'b0),
        .TXPHALIGNDONE(NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED),
        .TXPHALIGNEN(1'b0),
        .TXPHDLYPD(1'b0),
        .TXPHDLYRESET(1'b0),
        .TXPHDLYTSTCLK(1'b0),
        .TXPHINIT(1'b0),
        .TXPHINITDONE(NLW_gthe2_i_TXPHINITDONE_UNCONNECTED),
        .TXPHOVRDEN(1'b0),
        .TXPIPPMEN(1'b0),
        .TXPIPPMOVRDEN(1'b0),
        .TXPIPPMPD(1'b0),
        .TXPIPPMSEL(1'b1),
        .TXPIPPMSTEPSIZE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPISOPD(1'b0),
        .TXPMARESET(1'b0),
        .TXPMARESETDONE(n_50_gthe2_i),
        .TXPOLARITY(gt2_txpolarity_in),
        .TXPOSTCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPOSTCURSORINV(1'b0),
        .TXPRBSFORCEERR(gt2_txprbsforceerr_in),
        .TXPRBSSEL(gt2_txprbssel_in),
        .TXPRECURSOR({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPRECURSORINV(1'b0),
        .TXQPIBIASEN(1'b0),
        .TXQPISENN(NLW_gthe2_i_TXQPISENN_UNCONNECTED),
        .TXQPISENP(NLW_gthe2_i_TXQPISENP_UNCONNECTED),
        .TXQPISTRONGPDOWN(1'b0),
        .TXQPIWEAKPUP(1'b0),
        .TXRATE({1'b0,1'b0,1'b0}),
        .TXRATEDONE(NLW_gthe2_i_TXRATEDONE_UNCONNECTED),
        .TXRATEMODE(1'b0),
        .TXRESETDONE(gt2_txresetdone_out),
        .TXSEQUENCE(gt2_txsequence_in),
        .TXSTARTSEQ(1'b0),
        .TXSWING(1'b0),
        .TXSYNCALLIN(1'b0),
        .TXSYNCDONE(NLW_gthe2_i_TXSYNCDONE_UNCONNECTED),
        .TXSYNCIN(1'b0),
        .TXSYNCMODE(1'b0),
        .TXSYNCOUT(NLW_gthe2_i_TXSYNCOUT_UNCONNECTED),
        .TXSYSCLKSEL({1'b1,1'b1}),
        .TXUSERRDY(gt2_txuserrdy_in),
        .TXUSRCLK(gt2_txusrclk_in),
        .TXUSRCLK2(gt2_txusrclk2_in));
endmodule

(* ORIG_REF_NAME = "XLAUI_GT" *) 
module XLAUI_XLAUI_GT__parameterized0_67
   (gt3_drprdy_out,
    gt3_eyescandataerror_out,
    gt3_gthtxn_out,
    gt3_gthtxp_out,
    gt3_rxoutclk_out,
    GT3_RXPMARESETDONE_OUT,
    gt3_rxprbserr_out,
    gt3_rxresetdone_out,
    gt3_txoutclk_out,
    gt3_txoutclkfabric_out,
    gt3_txoutclkpcs_out,
    gt3_txresetdone_out,
    gt3_dmonitorout_out,
    gt3_drpdo_out,
    gt3_rxdatavalid_out,
    gt3_rxheadervalid_out,
    gt3_txbufstatus_out,
    gt3_rxbufstatus_out,
    gt3_rxheader_out,
    gt3_rxdata_out,
    gt3_rxmonitorout_out,
    gt3_drpclk_in,
    gt3_drpen_in,
    gt3_drpwe_in,
    gt3_eyescanreset_in,
    gt3_eyescantrigger_in,
    gt3_gthrxn_in,
    gt3_gthrxp_in,
    I3,
    gt3_gttxreset_in,
    GT0_QPLLOUTCLK_IN,
    GT0_QPLLOUTREFCLK_IN,
    gt3_rxbufreset_in,
    gt3_rxgearboxslip_in,
    gt3_rxpcsreset_in,
    gt3_rxprbscntreset_in,
    gt3_rxuserrdy_in,
    gt3_rxusrclk_in,
    gt3_rxusrclk2_in,
    gt3_txelecidle_in,
    gt3_txpcsreset_in,
    gt3_txpolarity_in,
    gt3_txprbsforceerr_in,
    gt3_txuserrdy_in,
    gt3_txusrclk_in,
    gt3_txusrclk2_in,
    gt3_drpdi_in,
    gt3_rxmonitorsel_in,
    gt3_loopback_in,
    gt3_rxprbssel_in,
    gt3_txheader_in,
    gt3_txprbssel_in,
    gt3_txdata_in,
    gt3_txsequence_in,
    gt3_drpaddr_in);
  output gt3_drprdy_out;
  output gt3_eyescandataerror_out;
  output gt3_gthtxn_out;
  output gt3_gthtxp_out;
  output gt3_rxoutclk_out;
  output GT3_RXPMARESETDONE_OUT;
  output gt3_rxprbserr_out;
  output gt3_rxresetdone_out;
  output gt3_txoutclk_out;
  output gt3_txoutclkfabric_out;
  output gt3_txoutclkpcs_out;
  output gt3_txresetdone_out;
  output [14:0]gt3_dmonitorout_out;
  output [15:0]gt3_drpdo_out;
  output gt3_rxdatavalid_out;
  output gt3_rxheadervalid_out;
  output [1:0]gt3_txbufstatus_out;
  output [2:0]gt3_rxbufstatus_out;
  output [1:0]gt3_rxheader_out;
  output [63:0]gt3_rxdata_out;
  output [6:0]gt3_rxmonitorout_out;
  input gt3_drpclk_in;
  input gt3_drpen_in;
  input gt3_drpwe_in;
  input gt3_eyescanreset_in;
  input gt3_eyescantrigger_in;
  input gt3_gthrxn_in;
  input gt3_gthrxp_in;
  input [0:0]I3;
  input gt3_gttxreset_in;
  input GT0_QPLLOUTCLK_IN;
  input GT0_QPLLOUTREFCLK_IN;
  input gt3_rxbufreset_in;
  input gt3_rxgearboxslip_in;
  input gt3_rxpcsreset_in;
  input gt3_rxprbscntreset_in;
  input gt3_rxuserrdy_in;
  input gt3_rxusrclk_in;
  input gt3_rxusrclk2_in;
  input gt3_txelecidle_in;
  input gt3_txpcsreset_in;
  input gt3_txpolarity_in;
  input gt3_txprbsforceerr_in;
  input gt3_txuserrdy_in;
  input gt3_txusrclk_in;
  input gt3_txusrclk2_in;
  input [15:0]gt3_drpdi_in;
  input [1:0]gt3_rxmonitorsel_in;
  input [2:0]gt3_loopback_in;
  input [2:0]gt3_rxprbssel_in;
  input [1:0]gt3_txheader_in;
  input [2:0]gt3_txprbssel_in;
  input [63:0]gt3_txdata_in;
  input [6:0]gt3_txsequence_in;
  input [8:0]gt3_drpaddr_in;

  wire GT0_QPLLOUTCLK_IN;
  wire GT0_QPLLOUTREFCLK_IN;
  wire GT3_RXPMARESETDONE_OUT;
  wire [0:0]I3;
  wire [14:0]gt3_dmonitorout_out;
  wire [8:0]gt3_drpaddr_in;
  wire gt3_drpclk_in;
  wire [15:0]gt3_drpdi_in;
  wire [15:0]gt3_drpdo_out;
  wire gt3_drpen_in;
  wire gt3_drprdy_out;
  wire gt3_drpwe_in;
  wire gt3_eyescandataerror_out;
  wire gt3_eyescanreset_in;
  wire gt3_eyescantrigger_in;
  wire gt3_gthrxn_in;
  wire gt3_gthrxp_in;
  wire gt3_gthtxn_out;
  wire gt3_gthtxp_out;
  wire gt3_gttxreset_in;
  wire [2:0]gt3_loopback_in;
  wire gt3_rxbufreset_in;
  wire [2:0]gt3_rxbufstatus_out;
  wire [63:0]gt3_rxdata_out;
  wire gt3_rxdatavalid_out;
  wire gt3_rxgearboxslip_in;
  wire [1:0]gt3_rxheader_out;
  wire gt3_rxheadervalid_out;
  wire [6:0]gt3_rxmonitorout_out;
  wire [1:0]gt3_rxmonitorsel_in;
  wire gt3_rxoutclk_out;
  wire gt3_rxpcsreset_in;
  wire gt3_rxprbscntreset_in;
  wire gt3_rxprbserr_out;
  wire [2:0]gt3_rxprbssel_in;
  wire gt3_rxresetdone_out;
  wire gt3_rxuserrdy_in;
  wire gt3_rxusrclk2_in;
  wire gt3_rxusrclk_in;
  wire [1:0]gt3_txbufstatus_out;
  wire [63:0]gt3_txdata_in;
  wire gt3_txelecidle_in;
  wire [1:0]gt3_txheader_in;
  wire gt3_txoutclk_out;
  wire gt3_txoutclkfabric_out;
  wire gt3_txoutclkpcs_out;
  wire gt3_txpcsreset_in;
  wire gt3_txpolarity_in;
  wire gt3_txprbsforceerr_in;
  wire [2:0]gt3_txprbssel_in;
  wire gt3_txresetdone_out;
  wire [6:0]gt3_txsequence_in;
  wire gt3_txuserrdy_in;
  wire gt3_txusrclk2_in;
  wire gt3_txusrclk_in;
  wire n_50_gthe2_i;
  wire NLW_gthe2_i_CPLLFBCLKLOST_UNCONNECTED;
  wire NLW_gthe2_i_CPLLLOCK_UNCONNECTED;
  wire NLW_gthe2_i_CPLLREFCLKLOST_UNCONNECTED;
  wire NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED;
  wire NLW_gthe2_i_PHYSTATUS_UNCONNECTED;
  wire NLW_gthe2_i_RSOSINTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXBYTEISALIGNED_UNCONNECTED;
  wire NLW_gthe2_i_RXBYTEREALIGN_UNCONNECTED;
  wire NLW_gthe2_i_RXCDRLOCK_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMINITDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMMADET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMSASDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXELECIDLE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED;
  wire NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_RXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCOUT_UNCONNECTED;
  wire NLW_gthe2_i_RXVALID_UNCONNECTED;
  wire NLW_gthe2_i_TXCOMFINISH_UNCONNECTED;
  wire NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED;
  wire NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXPHINITDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_TXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCOUT_UNCONNECTED;
  wire [15:0]NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXCHARISK_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXCHBONDO_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED;
  wire [1:1]NLW_gthe2_i_RXDATAVALID_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXDISPERR_UNCONNECTED;
  wire [5:2]NLW_gthe2_i_RXHEADER_UNCONNECTED;
  wire [1:1]NLW_gthe2_i_RXHEADERVALID_UNCONNECTED;
  wire [7:0]NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHMONITOR_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED;
  wire [2:0]NLW_gthe2_i_RXSTATUS_UNCONNECTED;

(* box_type = "PRIMITIVE" *) 
   GTHE2_CHANNEL #(
    .ACJTAG_DEBUG_MODE(1'b0),
    .ACJTAG_MODE(1'b0),
    .ACJTAG_RESET(1'b0),
    .ADAPT_CFG0(20'h00C10),
    .ALIGN_COMMA_DOUBLE("FALSE"),
    .ALIGN_COMMA_ENABLE(10'b0001111111),
    .ALIGN_COMMA_WORD(1),
    .ALIGN_MCOMMA_DET("FALSE"),
    .ALIGN_MCOMMA_VALUE(10'b1010000011),
    .ALIGN_PCOMMA_DET("FALSE"),
    .ALIGN_PCOMMA_VALUE(10'b0101111100),
    .A_RXOSCALRESET(1'b0),
    .CBCC_DATA_SOURCE_SEL("ENCODED"),
    .CFOK_CFG(42'h24800040E80),
    .CFOK_CFG2(6'b100000),
    .CFOK_CFG3(6'b100000),
    .CHAN_BOND_KEEP_ALIGN("FALSE"),
    .CHAN_BOND_MAX_SKEW(1),
    .CHAN_BOND_SEQ_1_1(10'b0000000000),
    .CHAN_BOND_SEQ_1_2(10'b0000000000),
    .CHAN_BOND_SEQ_1_3(10'b0000000000),
    .CHAN_BOND_SEQ_1_4(10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_1(10'b0000000000),
    .CHAN_BOND_SEQ_2_2(10'b0000000000),
    .CHAN_BOND_SEQ_2_3(10'b0000000000),
    .CHAN_BOND_SEQ_2_4(10'b0000000000),
    .CHAN_BOND_SEQ_2_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_USE("FALSE"),
    .CHAN_BOND_SEQ_LEN(1),
    .CLK_CORRECT_USE("FALSE"),
    .CLK_COR_KEEP_IDLE("FALSE"),
    .CLK_COR_MAX_LAT(19),
    .CLK_COR_MIN_LAT(15),
    .CLK_COR_PRECEDENCE("TRUE"),
    .CLK_COR_REPEAT_WAIT(0),
    .CLK_COR_SEQ_1_1(10'b0100000000),
    .CLK_COR_SEQ_1_2(10'b0000000000),
    .CLK_COR_SEQ_1_3(10'b0000000000),
    .CLK_COR_SEQ_1_4(10'b0000000000),
    .CLK_COR_SEQ_1_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_1(10'b0100000000),
    .CLK_COR_SEQ_2_2(10'b0000000000),
    .CLK_COR_SEQ_2_3(10'b0000000000),
    .CLK_COR_SEQ_2_4(10'b0000000000),
    .CLK_COR_SEQ_2_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_USE("FALSE"),
    .CLK_COR_SEQ_LEN(1),
    .CPLL_CFG(29'h00BC07DC),
    .CPLL_FBDIV(4),
    .CPLL_FBDIV_45(5),
    .CPLL_INIT_CFG(24'h00001E),
    .CPLL_LOCK_CFG(16'h01E8),
    .CPLL_REFCLK_DIV(1),
    .DEC_MCOMMA_DETECT("FALSE"),
    .DEC_PCOMMA_DETECT("FALSE"),
    .DEC_VALID_COMMA_ONLY("FALSE"),
    .DMONITOR_CFG(24'h000A00),
    .ES_CLK_PHASE_SEL(1'b0),
    .ES_CONTROL(6'b000000),
    .ES_ERRDET_EN("FALSE"),
    .ES_EYE_SCAN_EN("TRUE"),
    .ES_HORZ_OFFSET(12'h000),
    .ES_PMA_CFG(10'b0000000000),
    .ES_PRESCALE(5'b00000),
    .ES_QUALIFIER(80'h00000000000000000000),
    .ES_QUAL_MASK(80'h00000000000000000000),
    .ES_SDATA_MASK(80'h00000000000000000000),
    .ES_VERT_OFFSET(9'b000000000),
    .FTS_DESKEW_SEQ_ENABLE(4'b1111),
    .FTS_LANE_DESKEW_CFG(4'b1111),
    .FTS_LANE_DESKEW_EN("FALSE"),
    .GEARBOX_MODE(3'b001),
    .IS_CLKRSVD0_INVERTED(1'b0),
    .IS_CLKRSVD1_INVERTED(1'b0),
    .IS_CPLLLOCKDETCLK_INVERTED(1'b0),
    .IS_DMONITORCLK_INVERTED(1'b0),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_RXUSRCLK2_INVERTED(1'b0),
    .IS_RXUSRCLK_INVERTED(1'b0),
    .IS_SIGVALIDCLK_INVERTED(1'b0),
    .IS_TXPHDLYTSTCLK_INVERTED(1'b0),
    .IS_TXUSRCLK2_INVERTED(1'b0),
    .IS_TXUSRCLK_INVERTED(1'b0),
    .LOOPBACK_CFG(1'b0),
    .OUTREFCLK_SEL_INV(2'b11),
    .PCS_PCIE_EN("FALSE"),
    .PCS_RSVD_ATTR(48'h000000000000),
    .PD_TRANS_TIME_FROM_P2(12'h03C),
    .PD_TRANS_TIME_NONE_P2(8'h19),
    .PD_TRANS_TIME_TO_P2(8'h64),
    .PMA_RSV(32'b00000000000000000000000010000000),
    .PMA_RSV2(32'b00011100000000000000000000001010),
    .PMA_RSV3(2'b00),
    .PMA_RSV4(15'b000000000001000),
    .PMA_RSV5(4'b0000),
    .RESET_POWERSAVE_DISABLE(1'b0),
    .RXBUFRESET_TIME(5'b00001),
    .RXBUF_ADDR_MODE("FAST"),
    .RXBUF_EIDLE_HI_CNT(4'b1000),
    .RXBUF_EIDLE_LO_CNT(4'b0000),
    .RXBUF_EN("TRUE"),
    .RXBUF_RESET_ON_CB_CHANGE("TRUE"),
    .RXBUF_RESET_ON_COMMAALIGN("FALSE"),
    .RXBUF_RESET_ON_EIDLE("FALSE"),
    .RXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .RXBUF_THRESH_OVFLW(61),
    .RXBUF_THRESH_OVRD("FALSE"),
    .RXBUF_THRESH_UNDFLW(4),
    .RXCDRFREQRESET_TIME(5'b00001),
    .RXCDRPHRESET_TIME(5'b00001),
    .RXCDR_CFG(83'h0002007FE2000C208001A),
    .RXCDR_FR_RESET_ON_EIDLE(1'b0),
    .RXCDR_HOLD_DURING_EIDLE(1'b0),
    .RXCDR_LOCK_CFG(6'b010101),
    .RXCDR_PH_RESET_ON_EIDLE(1'b0),
    .RXDFELPMRESET_TIME(7'b0001111),
    .RXDLY_CFG(16'h001F),
    .RXDLY_LCFG(9'h030),
    .RXDLY_TAP_CFG(16'h0000),
    .RXGEARBOX_EN("TRUE"),
    .RXISCANRESET_TIME(5'b00001),
    .RXLPM_HF_CFG(14'b00001000000000),
    .RXLPM_LF_CFG(18'b001001000000000000),
    .RXOOB_CFG(7'b0000110),
    .RXOOB_CLK_CFG("PMA"),
    .RXOSCALRESET_TIME(5'b00011),
    .RXOSCALRESET_TIMEOUT(5'b00000),
    .RXOUT_DIV(1),
    .RXPCSRESET_TIME(5'b00001),
    .RXPHDLY_CFG(24'h084020),
    .RXPH_CFG(24'hC00002),
    .RXPH_MONITOR_SEL(5'b00000),
    .RXPI_CFG0(2'b00),
    .RXPI_CFG1(2'b11),
    .RXPI_CFG2(2'b11),
    .RXPI_CFG3(2'b11),
    .RXPI_CFG4(1'b0),
    .RXPI_CFG5(1'b0),
    .RXPI_CFG6(3'b100),
    .RXPMARESET_TIME(5'b00011),
    .RXPRBS_ERR_LOOPBACK(1'b0),
    .RXSLIDE_AUTO_WAIT(7),
    .RXSLIDE_MODE("OFF"),
    .RXSYNC_MULTILANE(1'b1),
    .RXSYNC_OVRD(1'b0),
    .RXSYNC_SKIP_DA(1'b0),
    .RX_BIAS_CFG(24'b000011000000000000010000),
    .RX_BUFFER_CFG(6'b000000),
    .RX_CLK25_DIV(7),
    .RX_CLKMUX_PD(1'b1),
    .RX_CM_SEL(2'b11),
    .RX_CM_TRIM(4'b1010),
    .RX_DATA_WIDTH(64),
    .RX_DDI_SEL(6'b000000),
    .RX_DEBUG_CFG(14'b00000000000000),
    .RX_DEFER_RESET_BUF_EN("TRUE"),
    .RX_DFELPM_CFG0(4'b0110),
    .RX_DFELPM_CFG1(1'b0),
    .RX_DFELPM_KLKH_AGC_STUP_EN(1'b1),
    .RX_DFE_AGC_CFG0(2'b00),
    .RX_DFE_AGC_CFG1(3'b100),
    .RX_DFE_AGC_CFG2(4'b0000),
    .RX_DFE_AGC_OVRDEN(1'b1),
    .RX_DFE_GAIN_CFG(23'h0020C0),
    .RX_DFE_H2_CFG(12'b000000000000),
    .RX_DFE_H3_CFG(12'b000001000000),
    .RX_DFE_H4_CFG(11'b00011100000),
    .RX_DFE_H5_CFG(11'b00011100000),
    .RX_DFE_H6_CFG(11'b00000100000),
    .RX_DFE_H7_CFG(11'b00000100000),
    .RX_DFE_KL_CFG(33'b001000001000000000000001100010000),
    .RX_DFE_KL_LPM_KH_CFG0(2'b01),
    .RX_DFE_KL_LPM_KH_CFG1(3'b010),
    .RX_DFE_KL_LPM_KH_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KH_OVRDEN(1'b1),
    .RX_DFE_KL_LPM_KL_CFG0(2'b10),
    .RX_DFE_KL_LPM_KL_CFG1(3'b010),
    .RX_DFE_KL_LPM_KL_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KL_OVRDEN(1'b1),
    .RX_DFE_LPM_CFG(16'h0080),
    .RX_DFE_LPM_HOLD_DURING_EIDLE(1'b0),
    .RX_DFE_ST_CFG(54'h00E100000C003F),
    .RX_DFE_UT_CFG(17'b00011100000000000),
    .RX_DFE_VP_CFG(17'b00011101010100011),
    .RX_DISPERR_SEQ_MATCH("FALSE"),
    .RX_INT_DATAWIDTH(1),
    .RX_OS_CFG(13'b0000010000000),
    .RX_SIG_VALID_DLY(10),
    .RX_XCLK_SEL("RXREC"),
    .SAS_MAX_COM(64),
    .SAS_MIN_COM(36),
    .SATA_BURST_SEQ_LEN(4'b0101),
    .SATA_BURST_VAL(3'b100),
    .SATA_CPLL_CFG("VCO_3000MHZ"),
    .SATA_EIDLE_VAL(3'b100),
    .SATA_MAX_BURST(8),
    .SATA_MAX_INIT(21),
    .SATA_MAX_WAKE(7),
    .SATA_MIN_BURST(4),
    .SATA_MIN_INIT(12),
    .SATA_MIN_WAKE(4),
    .SHOW_REALIGN_COMMA("FALSE"),
    .SIM_CPLLREFCLK_SEL(3'b001),
    .SIM_RECEIVER_DETECT_PASS("TRUE"),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_TX_EIDLE_DRIVE_LEVEL("X"),
    .SIM_VERSION("2.0"),
    .TERM_RCAL_CFG(15'b100001000010000),
    .TERM_RCAL_OVRD(3'b000),
    .TRANS_TIME_RATE(8'h0E),
    .TST_RSV(32'h00000000),
    .TXBUF_EN("TRUE"),
    .TXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .TXDLY_CFG(16'h001F),
    .TXDLY_LCFG(9'h030),
    .TXDLY_TAP_CFG(16'h0000),
    .TXGEARBOX_EN("TRUE"),
    .TXOOB_CFG(1'b0),
    .TXOUT_DIV(1),
    .TXPCSRESET_TIME(5'b00001),
    .TXPHDLY_CFG(24'h084020),
    .TXPH_CFG(16'h0780),
    .TXPH_MONITOR_SEL(5'b00000),
    .TXPI_CFG0(2'b00),
    .TXPI_CFG1(2'b00),
    .TXPI_CFG2(2'b00),
    .TXPI_CFG3(1'b0),
    .TXPI_CFG4(1'b0),
    .TXPI_CFG5(3'b100),
    .TXPI_GREY_SEL(1'b0),
    .TXPI_INVSTROBE_SEL(1'b0),
    .TXPI_PPMCLK_SEL("TXUSRCLK2"),
    .TXPI_PPM_CFG(8'b00000000),
    .TXPI_SYNFREQ_PPM(3'b000),
    .TXPMARESET_TIME(5'b00001),
    .TXSYNC_MULTILANE(1'b0),
    .TXSYNC_OVRD(1'b0),
    .TXSYNC_SKIP_DA(1'b0),
    .TX_CLK25_DIV(7),
    .TX_CLKMUX_PD(1'b1),
    .TX_DATA_WIDTH(64),
    .TX_DEEMPH0(6'b000000),
    .TX_DEEMPH1(6'b000000),
    .TX_DRIVE_MODE("DIRECT"),
    .TX_EIDLE_ASSERT_DELAY(3'b110),
    .TX_EIDLE_DEASSERT_DELAY(3'b100),
    .TX_INT_DATAWIDTH(1),
    .TX_LOOPBACK_DRIVE_HIZ("FALSE"),
    .TX_MAINCURSOR_SEL(1'b0),
    .TX_MARGIN_FULL_0(7'b1001110),
    .TX_MARGIN_FULL_1(7'b1001001),
    .TX_MARGIN_FULL_2(7'b1000101),
    .TX_MARGIN_FULL_3(7'b1000010),
    .TX_MARGIN_FULL_4(7'b1000000),
    .TX_MARGIN_LOW_0(7'b1000110),
    .TX_MARGIN_LOW_1(7'b1000100),
    .TX_MARGIN_LOW_2(7'b1000010),
    .TX_MARGIN_LOW_3(7'b1000000),
    .TX_MARGIN_LOW_4(7'b1000000),
    .TX_QPI_STATUS_EN(1'b0),
    .TX_RXDETECT_CFG(14'h1832),
    .TX_RXDETECT_PRECHARGE_TIME(17'h155CC),
    .TX_RXDETECT_REF(3'b100),
    .TX_XCLK_SEL("TXOUT"),
    .UCODEER_CLR(1'b0),
    .USE_PCS_CLK_PHASE_SEL(1'b0)) 
     gthe2_i
       (.CFGRESET(1'b0),
        .CLKRSVD0(1'b0),
        .CLKRSVD1(1'b0),
        .CPLLFBCLKLOST(NLW_gthe2_i_CPLLFBCLKLOST_UNCONNECTED),
        .CPLLLOCK(NLW_gthe2_i_CPLLLOCK_UNCONNECTED),
        .CPLLLOCKDETCLK(1'b0),
        .CPLLLOCKEN(1'b1),
        .CPLLPD(1'b1),
        .CPLLREFCLKLOST(NLW_gthe2_i_CPLLREFCLKLOST_UNCONNECTED),
        .CPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .CPLLRESET(1'b0),
        .DMONFIFORESET(1'b0),
        .DMONITORCLK(1'b0),
        .DMONITOROUT(gt3_dmonitorout_out),
        .DRPADDR(gt3_drpaddr_in),
        .DRPCLK(gt3_drpclk_in),
        .DRPDI(gt3_drpdi_in),
        .DRPDO(gt3_drpdo_out),
        .DRPEN(gt3_drpen_in),
        .DRPRDY(gt3_drprdy_out),
        .DRPWE(gt3_drpwe_in),
        .EYESCANDATAERROR(gt3_eyescandataerror_out),
        .EYESCANMODE(1'b0),
        .EYESCANRESET(gt3_eyescanreset_in),
        .EYESCANTRIGGER(gt3_eyescantrigger_in),
        .GTGREFCLK(1'b0),
        .GTHRXN(gt3_gthrxn_in),
        .GTHRXP(gt3_gthrxp_in),
        .GTHTXN(gt3_gthtxn_out),
        .GTHTXP(gt3_gthtxp_out),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(1'b0),
        .GTREFCLK1(1'b0),
        .GTREFCLKMONITOR(NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED),
        .GTRESETSEL(1'b0),
        .GTRSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GTRXRESET(I3),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .GTTXRESET(gt3_gttxreset_in),
        .LOOPBACK(gt3_loopback_in),
        .PCSRSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDOUT(NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED[15:0]),
        .PHYSTATUS(NLW_gthe2_i_PHYSTATUS_UNCONNECTED),
        .PMARSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLCLK(GT0_QPLLOUTCLK_IN),
        .QPLLREFCLK(GT0_QPLLOUTREFCLK_IN),
        .RESETOVRD(1'b0),
        .RSOSINTDONE(NLW_gthe2_i_RSOSINTDONE_UNCONNECTED),
        .RX8B10BEN(1'b0),
        .RXADAPTSELTEST({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXBUFRESET(gt3_rxbufreset_in),
        .RXBUFSTATUS(gt3_rxbufstatus_out),
        .RXBYTEISALIGNED(NLW_gthe2_i_RXBYTEISALIGNED_UNCONNECTED),
        .RXBYTEREALIGN(NLW_gthe2_i_RXBYTEREALIGN_UNCONNECTED),
        .RXCDRFREQRESET(1'b0),
        .RXCDRHOLD(1'b0),
        .RXCDRLOCK(NLW_gthe2_i_RXCDRLOCK_UNCONNECTED),
        .RXCDROVRDEN(1'b0),
        .RXCDRRESET(1'b0),
        .RXCDRRESETRSV(1'b0),
        .RXCHANBONDSEQ(NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED),
        .RXCHANISALIGNED(NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED),
        .RXCHANREALIGN(NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED),
        .RXCHARISCOMMA(NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED[7:0]),
        .RXCHARISK(NLW_gthe2_i_RXCHARISK_UNCONNECTED[7:0]),
        .RXCHBONDEN(1'b0),
        .RXCHBONDI({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXCHBONDLEVEL({1'b0,1'b0,1'b0}),
        .RXCHBONDMASTER(1'b0),
        .RXCHBONDO(NLW_gthe2_i_RXCHBONDO_UNCONNECTED[4:0]),
        .RXCHBONDSLAVE(1'b0),
        .RXCLKCORCNT(NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED[1:0]),
        .RXCOMINITDET(NLW_gthe2_i_RXCOMINITDET_UNCONNECTED),
        .RXCOMMADET(NLW_gthe2_i_RXCOMMADET_UNCONNECTED),
        .RXCOMMADETEN(1'b0),
        .RXCOMSASDET(NLW_gthe2_i_RXCOMSASDET_UNCONNECTED),
        .RXCOMWAKEDET(NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED),
        .RXDATA(gt3_rxdata_out),
        .RXDATAVALID({NLW_gthe2_i_RXDATAVALID_UNCONNECTED[1],gt3_rxdatavalid_out}),
        .RXDDIEN(1'b0),
        .RXDFEAGCHOLD(1'b0),
        .RXDFEAGCOVRDEN(1'b0),
        .RXDFEAGCTRL({1'b1,1'b0,1'b0,1'b0,1'b0}),
        .RXDFECM1EN(1'b0),
        .RXDFELFHOLD(1'b0),
        .RXDFELFOVRDEN(1'b0),
        .RXDFELPMRESET(1'b0),
        .RXDFESLIDETAP({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPADAPTEN(1'b0),
        .RXDFESLIDETAPHOLD(1'b0),
        .RXDFESLIDETAPID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPINITOVRDEN(1'b0),
        .RXDFESLIDETAPONLYADAPTEN(1'b0),
        .RXDFESLIDETAPOVRDEN(1'b0),
        .RXDFESLIDETAPSTARTED(NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED),
        .RXDFESLIDETAPSTROBE(1'b0),
        .RXDFESLIDETAPSTROBEDONE(NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED),
        .RXDFESLIDETAPSTROBESTARTED(NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED),
        .RXDFESTADAPTDONE(NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED),
        .RXDFETAP2HOLD(1'b0),
        .RXDFETAP2OVRDEN(1'b0),
        .RXDFETAP3HOLD(1'b0),
        .RXDFETAP3OVRDEN(1'b0),
        .RXDFETAP4HOLD(1'b0),
        .RXDFETAP4OVRDEN(1'b0),
        .RXDFETAP5HOLD(1'b0),
        .RXDFETAP5OVRDEN(1'b0),
        .RXDFETAP6HOLD(1'b0),
        .RXDFETAP6OVRDEN(1'b0),
        .RXDFETAP7HOLD(1'b0),
        .RXDFETAP7OVRDEN(1'b0),
        .RXDFEUTHOLD(1'b0),
        .RXDFEUTOVRDEN(1'b0),
        .RXDFEVPHOLD(1'b0),
        .RXDFEVPOVRDEN(1'b0),
        .RXDFEVSEN(1'b0),
        .RXDFEXYDEN(1'b1),
        .RXDISPERR(NLW_gthe2_i_RXDISPERR_UNCONNECTED[7:0]),
        .RXDLYBYPASS(1'b1),
        .RXDLYEN(1'b0),
        .RXDLYOVRDEN(1'b0),
        .RXDLYSRESET(1'b0),
        .RXDLYSRESETDONE(NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED),
        .RXELECIDLE(NLW_gthe2_i_RXELECIDLE_UNCONNECTED),
        .RXELECIDLEMODE({1'b1,1'b1}),
        .RXGEARBOXSLIP(gt3_rxgearboxslip_in),
        .RXHEADER({NLW_gthe2_i_RXHEADER_UNCONNECTED[5:2],gt3_rxheader_out}),
        .RXHEADERVALID({NLW_gthe2_i_RXHEADERVALID_UNCONNECTED[1],gt3_rxheadervalid_out}),
        .RXLPMEN(1'b0),
        .RXLPMHFHOLD(1'b0),
        .RXLPMHFOVRDEN(1'b0),
        .RXLPMLFHOLD(1'b0),
        .RXLPMLFKLOVRDEN(1'b0),
        .RXMCOMMAALIGNEN(1'b0),
        .RXMONITOROUT(gt3_rxmonitorout_out),
        .RXMONITORSEL(gt3_rxmonitorsel_in),
        .RXNOTINTABLE(NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED[7:0]),
        .RXOOBRESET(1'b0),
        .RXOSCALRESET(1'b0),
        .RXOSHOLD(1'b0),
        .RXOSINTCFG({1'b0,1'b1,1'b1,1'b0}),
        .RXOSINTEN(1'b1),
        .RXOSINTHOLD(1'b0),
        .RXOSINTID0({1'b0,1'b0,1'b0,1'b0}),
        .RXOSINTNTRLEN(1'b0),
        .RXOSINTOVRDEN(1'b0),
        .RXOSINTSTARTED(NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED),
        .RXOSINTSTROBE(1'b0),
        .RXOSINTSTROBEDONE(NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED),
        .RXOSINTSTROBESTARTED(NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED),
        .RXOSINTTESTOVRDEN(1'b0),
        .RXOSOVRDEN(1'b0),
        .RXOUTCLK(gt3_rxoutclk_out),
        .RXOUTCLKFABRIC(NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED),
        .RXOUTCLKPCS(NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED),
        .RXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .RXPCOMMAALIGNEN(1'b0),
        .RXPCSRESET(gt3_rxpcsreset_in),
        .RXPD({1'b0,1'b0}),
        .RXPHALIGN(1'b0),
        .RXPHALIGNDONE(NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED),
        .RXPHALIGNEN(1'b0),
        .RXPHDLYPD(1'b0),
        .RXPHDLYRESET(1'b0),
        .RXPHMONITOR(NLW_gthe2_i_RXPHMONITOR_UNCONNECTED[4:0]),
        .RXPHOVRDEN(1'b0),
        .RXPHSLIPMONITOR(NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED[4:0]),
        .RXPMARESET(1'b0),
        .RXPMARESETDONE(GT3_RXPMARESETDONE_OUT),
        .RXPOLARITY(1'b0),
        .RXPRBSCNTRESET(gt3_rxprbscntreset_in),
        .RXPRBSERR(gt3_rxprbserr_out),
        .RXPRBSSEL(gt3_rxprbssel_in),
        .RXQPIEN(1'b0),
        .RXQPISENN(NLW_gthe2_i_RXQPISENN_UNCONNECTED),
        .RXQPISENP(NLW_gthe2_i_RXQPISENP_UNCONNECTED),
        .RXRATE({1'b0,1'b0,1'b0}),
        .RXRATEDONE(NLW_gthe2_i_RXRATEDONE_UNCONNECTED),
        .RXRATEMODE(1'b0),
        .RXRESETDONE(gt3_rxresetdone_out),
        .RXSLIDE(1'b0),
        .RXSTARTOFSEQ(NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED[1:0]),
        .RXSTATUS(NLW_gthe2_i_RXSTATUS_UNCONNECTED[2:0]),
        .RXSYNCALLIN(1'b0),
        .RXSYNCDONE(NLW_gthe2_i_RXSYNCDONE_UNCONNECTED),
        .RXSYNCIN(1'b0),
        .RXSYNCMODE(1'b0),
        .RXSYNCOUT(NLW_gthe2_i_RXSYNCOUT_UNCONNECTED),
        .RXSYSCLKSEL({1'b1,1'b1}),
        .RXUSERRDY(gt3_rxuserrdy_in),
        .RXUSRCLK(gt3_rxusrclk_in),
        .RXUSRCLK2(gt3_rxusrclk2_in),
        .RXVALID(NLW_gthe2_i_RXVALID_UNCONNECTED),
        .SETERRSTATUS(1'b0),
        .SIGVALIDCLK(1'b0),
        .TSTIN({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .TX8B10BBYPASS({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TX8B10BEN(1'b0),
        .TXBUFDIFFCTRL({1'b1,1'b0,1'b0}),
        .TXBUFSTATUS(gt3_txbufstatus_out),
        .TXCHARDISPMODE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARDISPVAL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARISK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCOMFINISH(NLW_gthe2_i_TXCOMFINISH_UNCONNECTED),
        .TXCOMINIT(1'b0),
        .TXCOMSAS(1'b0),
        .TXCOMWAKE(1'b0),
        .TXDATA(gt3_txdata_in),
        .TXDEEMPH(1'b0),
        .TXDETECTRX(1'b0),
        .TXDIFFCTRL({1'b1,1'b0,1'b0,1'b0}),
        .TXDIFFPD(1'b0),
        .TXDLYBYPASS(1'b1),
        .TXDLYEN(1'b0),
        .TXDLYHOLD(1'b0),
        .TXDLYOVRDEN(1'b0),
        .TXDLYSRESET(1'b0),
        .TXDLYSRESETDONE(NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED),
        .TXDLYUPDOWN(1'b0),
        .TXELECIDLE(gt3_txelecidle_in),
        .TXGEARBOXREADY(NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED),
        .TXHEADER({1'b0,gt3_txheader_in}),
        .TXINHIBIT(1'b0),
        .TXMAINCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXMARGIN({1'b0,1'b0,1'b0}),
        .TXOUTCLK(gt3_txoutclk_out),
        .TXOUTCLKFABRIC(gt3_txoutclkfabric_out),
        .TXOUTCLKPCS(gt3_txoutclkpcs_out),
        .TXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .TXPCSRESET(gt3_txpcsreset_in),
        .TXPD({1'b0,1'b0}),
        .TXPDELECIDLEMODE(1'b0),
        .TXPHALIGN(1'b0),
        .TXPHALIGNDONE(NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED),
        .TXPHALIGNEN(1'b0),
        .TXPHDLYPD(1'b0),
        .TXPHDLYRESET(1'b0),
        .TXPHDLYTSTCLK(1'b0),
        .TXPHINIT(1'b0),
        .TXPHINITDONE(NLW_gthe2_i_TXPHINITDONE_UNCONNECTED),
        .TXPHOVRDEN(1'b0),
        .TXPIPPMEN(1'b0),
        .TXPIPPMOVRDEN(1'b0),
        .TXPIPPMPD(1'b0),
        .TXPIPPMSEL(1'b1),
        .TXPIPPMSTEPSIZE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPISOPD(1'b0),
        .TXPMARESET(1'b0),
        .TXPMARESETDONE(n_50_gthe2_i),
        .TXPOLARITY(gt3_txpolarity_in),
        .TXPOSTCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPOSTCURSORINV(1'b0),
        .TXPRBSFORCEERR(gt3_txprbsforceerr_in),
        .TXPRBSSEL(gt3_txprbssel_in),
        .TXPRECURSOR({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPRECURSORINV(1'b0),
        .TXQPIBIASEN(1'b0),
        .TXQPISENN(NLW_gthe2_i_TXQPISENN_UNCONNECTED),
        .TXQPISENP(NLW_gthe2_i_TXQPISENP_UNCONNECTED),
        .TXQPISTRONGPDOWN(1'b0),
        .TXQPIWEAKPUP(1'b0),
        .TXRATE({1'b0,1'b0,1'b0}),
        .TXRATEDONE(NLW_gthe2_i_TXRATEDONE_UNCONNECTED),
        .TXRATEMODE(1'b0),
        .TXRESETDONE(gt3_txresetdone_out),
        .TXSEQUENCE(gt3_txsequence_in),
        .TXSTARTSEQ(1'b0),
        .TXSWING(1'b0),
        .TXSYNCALLIN(1'b0),
        .TXSYNCDONE(NLW_gthe2_i_TXSYNCDONE_UNCONNECTED),
        .TXSYNCIN(1'b0),
        .TXSYNCMODE(1'b0),
        .TXSYNCOUT(NLW_gthe2_i_TXSYNCOUT_UNCONNECTED),
        .TXSYSCLKSEL({1'b1,1'b1}),
        .TXUSERRDY(gt3_txuserrdy_in),
        .TXUSRCLK(gt3_txusrclk_in),
        .TXUSRCLK2(gt3_txusrclk2_in));
endmodule

(* ORIG_REF_NAME = "XLAUI_RX_STARTUP_FSM" *) 
module XLAUI_XLAUI_RX_STARTUP_FSM__parameterized0
   (SR,
    GT0_RX_MMCM_RESET_OUT,
    GT0_RX_FSM_RESET_DONE_OUT,
    RXUSERRDY,
    RXOUTCLK,
    SYSCLK_IN,
    gt0_rxusrclk_in,
    SOFT_RESET_IN,
    DONT_RESET_ON_DATA_ERROR_IN,
    data_in,
    gt0_rxresetdone_out,
    GT0_RX_MMCM_LOCK_IN,
    GT0_DATA_VALID_IN,
    GT0_QPLLLOCK_IN,
    I1);
  output [0:0]SR;
  output GT0_RX_MMCM_RESET_OUT;
  output GT0_RX_FSM_RESET_DONE_OUT;
  output RXUSERRDY;
  input RXOUTCLK;
  input SYSCLK_IN;
  input gt0_rxusrclk_in;
  input SOFT_RESET_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input data_in;
  input gt0_rxresetdone_out;
  input GT0_RX_MMCM_LOCK_IN;
  input GT0_DATA_VALID_IN;
  input GT0_QPLLLOCK_IN;
  input I1;

  wire D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire GT0_DATA_VALID_IN;
  wire GT0_QPLLLOCK_IN;
  wire GT0_RX_FSM_RESET_DONE_OUT;
  wire GT0_RX_MMCM_LOCK_IN;
  wire GT0_RX_MMCM_RESET_OUT;
  wire I1;
  wire Q;
  wire RXOUTCLK;
  wire RXUSERRDY;
  wire SOFT_RESET_IN;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_in;
  wire gt0_rxresetdone_out;
  wire gt0_rxusrclk_in;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_rx_state[0]_i_2 ;
  wire \n_0_FSM_sequential_rx_state[2]_i_1 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_4 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_8 ;
  wire n_0_RXUSERRDY_i_1;
  wire n_0_check_tlock_max_i_1;
  wire n_0_check_tlock_max_reg;
  wire n_0_gtrxreset_i_i_1;
  wire \n_0_init_wait_count[6]_i_1__3 ;
  wire \n_0_init_wait_count[6]_i_3__3 ;
  wire \n_0_init_wait_count[6]_i_4__3 ;
  wire n_0_init_wait_done_i_1__3;
  wire n_0_init_wait_done_reg;
  wire \n_0_mmcm_lock_count[6]_i_2__3 ;
  wire \n_0_mmcm_lock_count[7]_i_2__3 ;
  wire \n_0_mmcm_lock_count[7]_i_4__3 ;
  wire n_0_reset_time_out_reg;
  wire n_0_run_phase_alignment_int_i_1__3;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_run_phase_alignment_int_s3_reg;
  wire n_0_sync_QPLLLOCK;
  wire n_0_sync_data_valid;
  wire n_0_sync_mmcm_lock_reclocked;
  wire n_0_sync_rxpmaresetdone;
  wire n_0_sync_rxpmaresetdone_rx_s;
  wire n_0_time_out_1us_i_1;
  wire n_0_time_out_1us_i_2__0;
  wire n_0_time_out_1us_i_3;
  wire n_0_time_out_1us_i_4;
  wire n_0_time_out_1us_reg;
  wire n_0_time_out_2ms_i_1__3;
  wire n_0_time_out_2ms_i_2;
  wire n_0_time_out_2ms_i_3;
  wire n_0_time_out_2ms_i_4;
  wire n_0_time_out_2ms_reg;
  wire n_0_time_out_500us_i_1;
  wire n_0_time_out_500us_i_2__0;
  wire n_0_time_out_500us_i_3__0;
  wire n_0_time_out_500us_i_4;
  wire n_0_time_out_500us_reg;
  wire \n_0_time_out_counter[0]_i_1__3 ;
  wire \n_0_time_out_counter[0]_i_3 ;
  wire \n_0_time_out_counter[0]_i_4 ;
  wire \n_0_time_out_counter[0]_i_5__3 ;
  wire \n_0_time_out_counter[0]_i_6__3 ;
  wire \n_0_time_out_counter[0]_i_7__3 ;
  wire \n_0_time_out_counter[0]_i_8 ;
  wire \n_0_time_out_counter[12]_i_2__3 ;
  wire \n_0_time_out_counter[12]_i_3__3 ;
  wire \n_0_time_out_counter[12]_i_4__3 ;
  wire \n_0_time_out_counter[12]_i_5__3 ;
  wire \n_0_time_out_counter[16]_i_2__3 ;
  wire \n_0_time_out_counter[16]_i_3__3 ;
  wire \n_0_time_out_counter[16]_i_4__3 ;
  wire \n_0_time_out_counter[4]_i_2__3 ;
  wire \n_0_time_out_counter[4]_i_3__3 ;
  wire \n_0_time_out_counter[4]_i_4__3 ;
  wire \n_0_time_out_counter[4]_i_5__3 ;
  wire \n_0_time_out_counter[8]_i_2__3 ;
  wire \n_0_time_out_counter[8]_i_3__3 ;
  wire \n_0_time_out_counter[8]_i_4__3 ;
  wire \n_0_time_out_counter[8]_i_5__3 ;
  wire \n_0_time_out_counter_reg[0]_i_2__3 ;
  wire \n_0_time_out_counter_reg[12]_i_1__3 ;
  wire \n_0_time_out_counter_reg[4]_i_1__3 ;
  wire \n_0_time_out_counter_reg[8]_i_1__3 ;
  wire n_0_time_out_wait_bypass_i_1__3;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_10;
  wire n_0_time_tlock_max_i_11__0;
  wire n_0_time_tlock_max_i_12;
  wire n_0_time_tlock_max_i_13;
  wire n_0_time_tlock_max_i_14;
  wire n_0_time_tlock_max_i_15;
  wire n_0_time_tlock_max_i_16;
  wire n_0_time_tlock_max_i_17;
  wire n_0_time_tlock_max_i_18;
  wire n_0_time_tlock_max_i_19;
  wire n_0_time_tlock_max_i_1__3;
  wire n_0_time_tlock_max_i_20;
  wire n_0_time_tlock_max_i_4;
  wire n_0_time_tlock_max_i_5;
  wire n_0_time_tlock_max_i_6;
  wire n_0_time_tlock_max_i_8;
  wire n_0_time_tlock_max_i_9;
  wire n_0_time_tlock_max_reg_i_3;
  wire n_0_time_tlock_max_reg_i_7;
  wire \n_0_wait_bypass_count[0]_i_1__3 ;
  wire \n_0_wait_bypass_count[0]_i_2__3 ;
  wire \n_0_wait_bypass_count[0]_i_4__3 ;
  wire \n_0_wait_bypass_count[0]_i_5__3 ;
  wire \n_0_wait_bypass_count[0]_i_6__3 ;
  wire \n_0_wait_bypass_count[0]_i_7__3 ;
  wire \n_0_wait_bypass_count[0]_i_8__3 ;
  wire \n_0_wait_bypass_count[0]_i_9 ;
  wire \n_0_wait_bypass_count[12]_i_2__3 ;
  wire \n_0_wait_bypass_count[4]_i_2__3 ;
  wire \n_0_wait_bypass_count[4]_i_3__3 ;
  wire \n_0_wait_bypass_count[4]_i_4__3 ;
  wire \n_0_wait_bypass_count[4]_i_5__3 ;
  wire \n_0_wait_bypass_count[8]_i_2__3 ;
  wire \n_0_wait_bypass_count[8]_i_3__3 ;
  wire \n_0_wait_bypass_count[8]_i_4__3 ;
  wire \n_0_wait_bypass_count[8]_i_5__3 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3__3 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1__3 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1__3 ;
  wire \n_0_wait_time_cnt[1]_i_1__3 ;
  wire \n_0_wait_time_cnt[4]_i_1__3 ;
  wire \n_0_wait_time_cnt[6]_i_1__3 ;
  wire \n_0_wait_time_cnt[6]_i_2__3 ;
  wire \n_0_wait_time_cnt[6]_i_4__3 ;
  wire n_1_sync_QPLLLOCK;
  wire n_1_sync_data_valid;
  wire n_1_sync_mmcm_lock_reclocked;
  wire n_1_sync_rxpmaresetdone;
  wire \n_1_time_out_counter_reg[0]_i_2__3 ;
  wire \n_1_time_out_counter_reg[12]_i_1__3 ;
  wire \n_1_time_out_counter_reg[4]_i_1__3 ;
  wire \n_1_time_out_counter_reg[8]_i_1__3 ;
  wire n_1_time_tlock_max_reg_i_3;
  wire n_1_time_tlock_max_reg_i_7;
  wire \n_1_wait_bypass_count_reg[0]_i_3__3 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1__3 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1__3 ;
  wire n_2_sync_data_valid;
  wire \n_2_time_out_counter_reg[0]_i_2__3 ;
  wire \n_2_time_out_counter_reg[12]_i_1__3 ;
  wire \n_2_time_out_counter_reg[16]_i_1__3 ;
  wire \n_2_time_out_counter_reg[4]_i_1__3 ;
  wire \n_2_time_out_counter_reg[8]_i_1__3 ;
  wire n_2_time_tlock_max_reg_i_3;
  wire n_2_time_tlock_max_reg_i_7;
  wire \n_2_wait_bypass_count_reg[0]_i_3__3 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1__3 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1__3 ;
  wire n_3_sync_data_valid;
  wire \n_3_time_out_counter_reg[0]_i_2__3 ;
  wire \n_3_time_out_counter_reg[12]_i_1__3 ;
  wire \n_3_time_out_counter_reg[16]_i_1__3 ;
  wire \n_3_time_out_counter_reg[4]_i_1__3 ;
  wire \n_3_time_out_counter_reg[8]_i_1__3 ;
  wire n_3_time_tlock_max_reg_i_2;
  wire n_3_time_tlock_max_reg_i_3;
  wire n_3_time_tlock_max_reg_i_7;
  wire \n_3_wait_bypass_count_reg[0]_i_3__3 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1__3 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1__3 ;
  wire n_4_sync_data_valid;
  wire \n_4_time_out_counter_reg[0]_i_2__3 ;
  wire \n_4_time_out_counter_reg[12]_i_1__3 ;
  wire \n_4_time_out_counter_reg[4]_i_1__3 ;
  wire \n_4_time_out_counter_reg[8]_i_1__3 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3__3 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1__3 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1__3 ;
  wire n_5_sync_data_valid;
  wire \n_5_time_out_counter_reg[0]_i_2__3 ;
  wire \n_5_time_out_counter_reg[12]_i_1__3 ;
  wire \n_5_time_out_counter_reg[16]_i_1__3 ;
  wire \n_5_time_out_counter_reg[4]_i_1__3 ;
  wire \n_5_time_out_counter_reg[8]_i_1__3 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3__3 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1__3 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1__3 ;
  wire \n_6_time_out_counter_reg[0]_i_2__3 ;
  wire \n_6_time_out_counter_reg[12]_i_1__3 ;
  wire \n_6_time_out_counter_reg[16]_i_1__3 ;
  wire \n_6_time_out_counter_reg[4]_i_1__3 ;
  wire \n_6_time_out_counter_reg[8]_i_1__3 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3__3 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1__3 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1__3 ;
  wire \n_7_time_out_counter_reg[0]_i_2__3 ;
  wire \n_7_time_out_counter_reg[12]_i_1__3 ;
  wire \n_7_time_out_counter_reg[16]_i_1__3 ;
  wire \n_7_time_out_counter_reg[4]_i_1__3 ;
  wire \n_7_time_out_counter_reg[8]_i_1__3 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3__3 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1__3 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1__3 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1__3 ;
  wire [6:0]p_0_in__7;
  wire [7:0]p_0_in__8;
  wire run_phase_alignment_int_s2;
  wire rx_fsm_reset_done_int_s2;
  wire rx_fsm_reset_done_int_s3;
(* RTL_KEEP = "yes" *)   wire [3:0]rx_state;
  wire rx_state16_out;
  wire rxpmaresetdone_i;
  wire rxresetdone_s2;
  wire rxresetdone_s3;
  wire [18:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire time_tlock_max1;
  wire [12:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0__3;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__3_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__3_O_UNCONNECTED ;
  wire [3:2]NLW_time_tlock_max_reg_i_2_CO_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_2_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_3_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_7_O_UNCONNECTED;
  wire [3:0]\NLW_wait_bypass_count_reg[12]_i_1__3_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[12]_i_1__3_O_UNCONNECTED ;

LUT6 #(
    .INIT(64'h4E0AEE2A4E0ACE0A)) 
     \FSM_sequential_rx_state[0]_i_2 
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .I3(n_0_time_out_2ms_reg),
        .I4(n_0_reset_time_out_reg),
        .I5(time_tlock_max),
        .O(\n_0_FSM_sequential_rx_state[0]_i_2 ));
LUT6 #(
    .INIT(64'h1111004015150040)) 
     \FSM_sequential_rx_state[2]_i_1 
       (.I0(rx_state[3]),
        .I1(rx_state[0]),
        .I2(rx_state[1]),
        .I3(n_0_time_out_2ms_reg),
        .I4(rx_state[2]),
        .I5(rx_state16_out),
        .O(\n_0_FSM_sequential_rx_state[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_rx_state[2]_i_2 
       (.I0(time_tlock_max),
        .I1(n_0_reset_time_out_reg),
        .O(rx_state16_out));
LUT6 #(
    .INIT(64'h0F0F0F0F4F404040)) 
     \FSM_sequential_rx_state[3]_i_4 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_FSM_sequential_rx_state[3]_i_8 ),
        .I2(rx_state[1]),
        .I3(I1),
        .I4(rx_state[2]),
        .I5(rx_state[3]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_4 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_sequential_rx_state[3]_i_8 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[3]),
        .I4(wait_time_cnt_reg__0[0]),
        .I5(wait_time_cnt_reg__0[1]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_8 ));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_3_sync_data_valid),
        .Q(rx_state[0]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_2_sync_data_valid),
        .Q(rx_state[1]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(\n_0_FSM_sequential_rx_state[2]_i_1 ),
        .Q(rx_state[2]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_1_sync_data_valid),
        .Q(rx_state[3]),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD2000)) 
     RXUSERRDY_i_1
       (.I0(rx_state[0]),
        .I1(rx_state[3]),
        .I2(rx_state[2]),
        .I3(rx_state[1]),
        .I4(RXUSERRDY),
        .O(n_0_RXUSERRDY_i_1));
FDRE #(
    .INIT(1'b0)) 
     RXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_RXUSERRDY_i_1),
        .Q(RXUSERRDY),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0008)) 
     check_tlock_max_i_1
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(rx_state[3]),
        .I3(rx_state[1]),
        .I4(n_0_check_tlock_max_reg),
        .O(n_0_check_tlock_max_i_1));
FDRE #(
    .INIT(1'b0)) 
     check_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_check_tlock_max_i_1),
        .Q(n_0_check_tlock_max_reg),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD0004)) 
     gtrxreset_i_i_1
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(rx_state[3]),
        .I3(rx_state[1]),
        .I4(SR),
        .O(n_0_gtrxreset_i_i_1));
FDRE #(
    .INIT(1'b0)) 
     gtrxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gtrxreset_i_i_1),
        .Q(SR),
        .R(SOFT_RESET_IN));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1__3 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in__7[0]));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1__3 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in__7[1]));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[2]_i_1__3 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .O(p_0_in__7[2]));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \init_wait_count[3]_i_1__3 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .O(p_0_in__7[3]));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \init_wait_count[4]_i_1__3 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .O(p_0_in__7[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \init_wait_count[5]_i_1__3 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .I5(init_wait_count_reg__0[4]),
        .O(p_0_in__7[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
     \init_wait_count[6]_i_1__3 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[0]),
        .I3(\n_0_init_wait_count[6]_i_3__3 ),
        .I4(init_wait_count_reg__0[4]),
        .I5(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_1__3 ));
LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[6]_i_2__3 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\n_0_init_wait_count[6]_i_4__3 ),
        .I2(init_wait_count_reg__0[5]),
        .O(p_0_in__7[6]));
LUT2 #(
    .INIT(4'h7)) 
     \init_wait_count[6]_i_3__3 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_3__3 ));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT5 #(
    .INIT(32'h80000000)) 
     \init_wait_count[6]_i_4__3 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_4__3 ));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__3 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__7[0]),
        .Q(init_wait_count_reg__0[0]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__3 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__7[1]),
        .Q(init_wait_count_reg__0[1]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__3 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__7[2]),
        .Q(init_wait_count_reg__0[2]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__3 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__7[3]),
        .Q(init_wait_count_reg__0[3]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__3 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__7[4]),
        .Q(init_wait_count_reg__0[4]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__3 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__7[5]),
        .Q(init_wait_count_reg__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__3 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__7[6]),
        .Q(init_wait_count_reg__0[6]));
LUT2 #(
    .INIT(4'hE)) 
     init_wait_done_i_1__3
       (.I0(init_wait_done),
        .I1(n_0_init_wait_done_reg),
        .O(n_0_init_wait_done_i_1__3));
LUT6 #(
    .INIT(64'h0000000004000000)) 
     init_wait_done_i_2__3
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[4]),
        .I2(\n_0_init_wait_count[6]_i_3__3 ),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_done));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(n_0_init_wait_done_i_1__3),
        .Q(n_0_init_wait_done_reg));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__8[0]));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__8[1]));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[2]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__8[2]));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \mmcm_lock_count[3]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__8[3]));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \mmcm_lock_count[4]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[3]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__8[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[5]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__8[5]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[6]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(\n_0_mmcm_lock_count[6]_i_2__3 ),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__8[6]));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \mmcm_lock_count[6]_i_2__3 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(\n_0_mmcm_lock_count[6]_i_2__3 ));
LUT3 #(
    .INIT(8'h7F)) 
     \mmcm_lock_count[7]_i_2__3 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__3 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(\n_0_mmcm_lock_count[7]_i_2__3 ));
LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[7]_i_3__3 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__3 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__8[7]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \mmcm_lock_count[7]_i_4__3 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(\n_0_mmcm_lock_count[7]_i_4__3 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__3 ),
        .D(p_0_in__8[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__3 ),
        .D(p_0_in__8[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__3 ),
        .D(p_0_in__8[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__3 ),
        .D(p_0_in__8[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__3 ),
        .D(p_0_in__8[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__3 ),
        .D(p_0_in__8[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__3 ),
        .D(p_0_in__8[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__3 ),
        .D(p_0_in__8[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
FDRE #(
    .INIT(1'b1)) 
     mmcm_reset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_rxpmaresetdone),
        .Q(GT0_RX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync1_rx
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(1'b0),
        .PRE(SR),
        .Q(D));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync2_rx
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(D),
        .PRE(SR),
        .Q(Q));
FDSE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_QPLLLOCK),
        .Q(n_0_reset_time_out_reg),
        .S(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0002)) 
     run_phase_alignment_int_i_1__3
       (.I0(rx_state[3]),
        .I1(rx_state[0]),
        .I2(rx_state[2]),
        .I3(rx_state[1]),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1__3));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1__3),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(run_phase_alignment_int_s2),
        .Q(n_0_run_phase_alignment_int_s3_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_data_valid),
        .Q(GT0_RX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_s3_reg
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(rx_fsm_reset_done_int_s2),
        .Q(rx_fsm_reset_done_int_s3),
        .R(1'b0));
FDCE #(
    .INIT(1'b0)) 
     rxpmaresetdone_i_reg
       (.C(RXOUTCLK),
        .CE(1'b1),
        .CLR(Q),
        .D(n_0_sync_rxpmaresetdone_rx_s),
        .Q(rxpmaresetdone_i));
FDRE #(
    .INIT(1'b0)) 
     rxresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(rxresetdone_s2),
        .Q(rxresetdone_s3),
        .R(1'b0));
XLAUI_XLAUI_sync_block__parameterized0_56 sync_QPLLLOCK
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .I1(n_5_sync_data_valid),
        .I2(n_1_sync_rxpmaresetdone),
        .I3(n_0_reset_time_out_reg),
        .I4(n_0_time_out_2ms_reg),
        .O1(n_0_sync_QPLLLOCK),
        .O2(n_1_sync_QPLLLOCK),
        .SYSCLK_IN(SYSCLK_IN),
        .out(rx_state[3:1]),
        .rxresetdone_s3(rxresetdone_s3));
XLAUI_XLAUI_sync_block__parameterized0_57 sync_RXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(rxresetdone_s2),
        .gt0_rxresetdone_out(gt0_rxresetdone_out));
XLAUI_XLAUI_sync_block__parameterized0_58 sync_data_valid
       (.D({n_1_sync_data_valid,n_2_sync_data_valid,n_3_sync_data_valid}),
        .DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .E(n_4_sync_data_valid),
        .GT0_DATA_VALID_IN(GT0_DATA_VALID_IN),
        .GT0_RX_FSM_RESET_DONE_OUT(GT0_RX_FSM_RESET_DONE_OUT),
        .I1(n_0_reset_time_out_reg),
        .I2(n_0_time_out_500us_reg),
        .I3(n_0_time_out_1us_reg),
        .I4(\n_0_FSM_sequential_rx_state[0]_i_2 ),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_4 ),
        .I6(n_1_sync_QPLLLOCK),
        .I7(n_0_init_wait_done_reg),
        .I8(I1),
        .I9(n_0_time_out_2ms_reg),
        .O1(n_0_sync_data_valid),
        .O2(n_5_sync_data_valid),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state),
        .rx_state16_out(rx_state16_out),
        .rxresetdone_s3(rxresetdone_s3),
        .time_out_wait_bypass_s3(time_out_wait_bypass_s3));
XLAUI_XLAUI_sync_block__parameterized0_59 sync_mmcm_lock_reclocked
       (.GT0_RX_MMCM_LOCK_IN(GT0_RX_MMCM_LOCK_IN),
        .I1(\n_0_mmcm_lock_count[7]_i_4__3 ),
        .O1(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(n_0_sync_mmcm_lock_reclocked),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked));
XLAUI_XLAUI_sync_block__parameterized0_60 sync_run_phase_alignment_int
       (.data_in(n_0_run_phase_alignment_int_reg),
        .data_out(run_phase_alignment_int_s2),
        .gt0_rxusrclk_in(gt0_rxusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_61 sync_rx_fsm_reset_done_int
       (.GT0_RX_FSM_RESET_DONE_OUT(GT0_RX_FSM_RESET_DONE_OUT),
        .data_out(rx_fsm_reset_done_int_s2),
        .gt0_rxusrclk_in(gt0_rxusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_62 sync_rxpmaresetdone
       (.GT0_RX_MMCM_RESET_OUT(GT0_RX_MMCM_RESET_OUT),
        .I1(I1),
        .O1(n_0_sync_rxpmaresetdone),
        .O2(n_1_sync_rxpmaresetdone),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(rxpmaresetdone_i),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state));
XLAUI_XLAUI_sync_block__parameterized0_63 sync_rxpmaresetdone_rx_s
       (.RXOUTCLK(RXOUTCLK),
        .data_in(data_in),
        .data_out(n_0_sync_rxpmaresetdone_rx_s));
XLAUI_XLAUI_sync_block__parameterized0_64 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
LUT6 #(
    .INIT(64'hFFFFFFFF00100000)) 
     time_out_1us_i_1
       (.I0(time_out_counter_reg[18]),
        .I1(time_out_counter_reg[4]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[17]),
        .I4(n_0_time_out_1us_i_2__0),
        .I5(n_0_time_out_1us_reg),
        .O(n_0_time_out_1us_i_1));
LUT6 #(
    .INIT(64'h0001000000000000)) 
     time_out_1us_i_2__0
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[12]),
        .I3(time_out_counter_reg[13]),
        .I4(n_0_time_out_1us_i_3),
        .I5(n_0_time_out_1us_i_4),
        .O(n_0_time_out_1us_i_2__0));
LUT6 #(
    .INIT(64'h0000000000100000)) 
     time_out_1us_i_3
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .I4(time_out_counter_reg[1]),
        .I5(time_out_counter_reg[15]),
        .O(n_0_time_out_1us_i_3));
LUT5 #(
    .INIT(32'h00000010)) 
     time_out_1us_i_4
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[16]),
        .I4(time_out_counter_reg[0]),
        .O(n_0_time_out_1us_i_4));
FDRE #(
    .INIT(1'b0)) 
     time_out_1us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_1us_i_1),
        .Q(n_0_time_out_1us_reg),
        .R(n_0_reset_time_out_reg));
LUT5 #(
    .INIT(32'hAAAAAAAB)) 
     time_out_2ms_i_1__3
       (.I0(n_0_time_out_2ms_reg),
        .I1(n_0_time_out_2ms_i_2),
        .I2(n_0_time_out_2ms_i_3),
        .I3(n_0_time_out_2ms_i_4),
        .I4(\n_0_time_out_counter[0]_i_3 ),
        .O(n_0_time_out_2ms_i_1__3));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT5 #(
    .INIT(32'hFEFFFFFF)) 
     time_out_2ms_i_2
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[9]),
        .I4(time_out_counter_reg[12]),
        .O(n_0_time_out_2ms_i_2));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFDFF)) 
     time_out_2ms_i_3
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[18]),
        .I4(time_out_counter_reg[8]),
        .I5(time_out_counter_reg[17]),
        .O(n_0_time_out_2ms_i_3));
LUT4 #(
    .INIT(16'h7FFF)) 
     time_out_2ms_i_4
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[2]),
        .O(n_0_time_out_2ms_i_4));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1__3),
        .Q(n_0_time_out_2ms_reg),
        .R(n_0_reset_time_out_reg));
LUT5 #(
    .INIT(32'hFFFF1000)) 
     time_out_500us_i_1
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[18]),
        .I2(n_0_time_out_500us_i_2__0),
        .I3(n_0_time_out_500us_i_3__0),
        .I4(n_0_time_out_500us_reg),
        .O(n_0_time_out_500us_i_1));
LUT4 #(
    .INIT(16'h0020)) 
     time_out_500us_i_2__0
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[17]),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[9]),
        .O(n_0_time_out_500us_i_2__0));
LUT6 #(
    .INIT(64'h0000000000040000)) 
     time_out_500us_i_3__0
       (.I0(n_0_time_out_2ms_i_4),
        .I1(n_0_time_out_500us_i_4),
        .I2(\n_0_time_out_counter[0]_i_3 ),
        .I3(time_out_counter_reg[11]),
        .I4(time_out_counter_reg[14]),
        .I5(time_out_counter_reg[3]),
        .O(n_0_time_out_500us_i_3__0));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT2 #(
    .INIT(4'h1)) 
     time_out_500us_i_4
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_out_500us_i_4));
FDRE #(
    .INIT(1'b0)) 
     time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_500us_i_1),
        .Q(n_0_time_out_500us_reg),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFFFFFFFFBFFFFFFF)) 
     \time_out_counter[0]_i_1__3 
       (.I0(\n_0_time_out_counter[0]_i_3 ),
        .I1(time_out_counter_reg[16]),
        .I2(time_out_counter_reg[0]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[2]),
        .I5(\n_0_time_out_counter[0]_i_4 ),
        .O(\n_0_time_out_counter[0]_i_1__3 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \time_out_counter[0]_i_3 
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[0]_i_3 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFF7)) 
     \time_out_counter[0]_i_4 
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[3]),
        .I4(time_out_counter_reg[14]),
        .I5(n_0_time_out_2ms_i_3),
        .O(\n_0_time_out_counter[0]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_5__3 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_5__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6__3 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_6__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_7__3 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_7__3 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_8 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_8 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2__3 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3__3 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4__3 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5__3 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2__3 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_2__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3__3 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_3__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4__3 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_4__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2__3 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3__3 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4__3 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5__3 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2__3 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3__3 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4__3 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5__3 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5__3 ));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_7_time_out_counter_reg[0]_i_2__3 ),
        .Q(time_out_counter_reg[0]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[0]_i_2__3 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2__3 ,\n_1_time_out_counter_reg[0]_i_2__3 ,\n_2_time_out_counter_reg[0]_i_2__3 ,\n_3_time_out_counter_reg[0]_i_2__3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2__3 ,\n_5_time_out_counter_reg[0]_i_2__3 ,\n_6_time_out_counter_reg[0]_i_2__3 ,\n_7_time_out_counter_reg[0]_i_2__3 }),
        .S({\n_0_time_out_counter[0]_i_5__3 ,\n_0_time_out_counter[0]_i_6__3 ,\n_0_time_out_counter[0]_i_7__3 ,\n_0_time_out_counter[0]_i_8 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_5_time_out_counter_reg[8]_i_1__3 ),
        .Q(time_out_counter_reg[10]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_4_time_out_counter_reg[8]_i_1__3 ),
        .Q(time_out_counter_reg[11]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_7_time_out_counter_reg[12]_i_1__3 ),
        .Q(time_out_counter_reg[12]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[12]_i_1__3 
       (.CI(\n_0_time_out_counter_reg[8]_i_1__3 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1__3 ,\n_1_time_out_counter_reg[12]_i_1__3 ,\n_2_time_out_counter_reg[12]_i_1__3 ,\n_3_time_out_counter_reg[12]_i_1__3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1__3 ,\n_5_time_out_counter_reg[12]_i_1__3 ,\n_6_time_out_counter_reg[12]_i_1__3 ,\n_7_time_out_counter_reg[12]_i_1__3 }),
        .S({\n_0_time_out_counter[12]_i_2__3 ,\n_0_time_out_counter[12]_i_3__3 ,\n_0_time_out_counter[12]_i_4__3 ,\n_0_time_out_counter[12]_i_5__3 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_6_time_out_counter_reg[12]_i_1__3 ),
        .Q(time_out_counter_reg[13]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_5_time_out_counter_reg[12]_i_1__3 ),
        .Q(time_out_counter_reg[14]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_4_time_out_counter_reg[12]_i_1__3 ),
        .Q(time_out_counter_reg[15]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_7_time_out_counter_reg[16]_i_1__3 ),
        .Q(time_out_counter_reg[16]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[16]_i_1__3 
       (.CI(\n_0_time_out_counter_reg[12]_i_1__3 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__3_CO_UNCONNECTED [3:2],\n_2_time_out_counter_reg[16]_i_1__3 ,\n_3_time_out_counter_reg[16]_i_1__3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__3_O_UNCONNECTED [3],\n_5_time_out_counter_reg[16]_i_1__3 ,\n_6_time_out_counter_reg[16]_i_1__3 ,\n_7_time_out_counter_reg[16]_i_1__3 }),
        .S({1'b0,\n_0_time_out_counter[16]_i_2__3 ,\n_0_time_out_counter[16]_i_3__3 ,\n_0_time_out_counter[16]_i_4__3 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_6_time_out_counter_reg[16]_i_1__3 ),
        .Q(time_out_counter_reg[17]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_5_time_out_counter_reg[16]_i_1__3 ),
        .Q(time_out_counter_reg[18]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_6_time_out_counter_reg[0]_i_2__3 ),
        .Q(time_out_counter_reg[1]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_5_time_out_counter_reg[0]_i_2__3 ),
        .Q(time_out_counter_reg[2]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_4_time_out_counter_reg[0]_i_2__3 ),
        .Q(time_out_counter_reg[3]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_7_time_out_counter_reg[4]_i_1__3 ),
        .Q(time_out_counter_reg[4]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[4]_i_1__3 
       (.CI(\n_0_time_out_counter_reg[0]_i_2__3 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1__3 ,\n_1_time_out_counter_reg[4]_i_1__3 ,\n_2_time_out_counter_reg[4]_i_1__3 ,\n_3_time_out_counter_reg[4]_i_1__3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1__3 ,\n_5_time_out_counter_reg[4]_i_1__3 ,\n_6_time_out_counter_reg[4]_i_1__3 ,\n_7_time_out_counter_reg[4]_i_1__3 }),
        .S({\n_0_time_out_counter[4]_i_2__3 ,\n_0_time_out_counter[4]_i_3__3 ,\n_0_time_out_counter[4]_i_4__3 ,\n_0_time_out_counter[4]_i_5__3 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_6_time_out_counter_reg[4]_i_1__3 ),
        .Q(time_out_counter_reg[5]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_5_time_out_counter_reg[4]_i_1__3 ),
        .Q(time_out_counter_reg[6]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_4_time_out_counter_reg[4]_i_1__3 ),
        .Q(time_out_counter_reg[7]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_7_time_out_counter_reg[8]_i_1__3 ),
        .Q(time_out_counter_reg[8]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[8]_i_1__3 
       (.CI(\n_0_time_out_counter_reg[4]_i_1__3 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1__3 ,\n_1_time_out_counter_reg[8]_i_1__3 ,\n_2_time_out_counter_reg[8]_i_1__3 ,\n_3_time_out_counter_reg[8]_i_1__3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1__3 ,\n_5_time_out_counter_reg[8]_i_1__3 ,\n_6_time_out_counter_reg[8]_i_1__3 ,\n_7_time_out_counter_reg[8]_i_1__3 }),
        .S({\n_0_time_out_counter[8]_i_2__3 ,\n_0_time_out_counter[8]_i_3__3 ,\n_0_time_out_counter[8]_i_4__3 ,\n_0_time_out_counter[8]_i_5__3 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__3 ),
        .D(\n_6_time_out_counter_reg[8]_i_1__3 ),
        .Q(time_out_counter_reg[9]),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1__3
       (.I0(\n_0_wait_bypass_count[0]_i_4__3 ),
        .I1(wait_bypass_count_reg[3]),
        .I2(\n_0_wait_bypass_count[0]_i_5__3 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(rx_fsm_reset_done_int_s3),
        .I5(n_0_run_phase_alignment_int_s3_reg),
        .O(n_0_time_out_wait_bypass_i_1__3));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1__3),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_10
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[15]),
        .O(n_0_time_tlock_max_i_10));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_11__0
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_tlock_max_i_11__0));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_12
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[10]),
        .O(n_0_time_tlock_max_i_12));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_13
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .O(n_0_time_tlock_max_i_13));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_14
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[6]),
        .O(n_0_time_tlock_max_i_14));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_15
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_15));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_16
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(n_0_time_tlock_max_i_16));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_17
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(n_0_time_tlock_max_i_17));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_18
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[5]),
        .O(n_0_time_tlock_max_i_18));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_19
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_19));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT3 #(
    .INIT(8'hF8)) 
     time_tlock_max_i_1__3
       (.I0(n_0_check_tlock_max_reg),
        .I1(time_tlock_max1),
        .I2(time_tlock_max),
        .O(n_0_time_tlock_max_i_1__3));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_20
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(n_0_time_tlock_max_i_20));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_4
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[16]),
        .O(n_0_time_tlock_max_i_4));
LUT1 #(
    .INIT(2'h1)) 
     time_tlock_max_i_5
       (.I0(time_out_counter_reg[18]),
        .O(n_0_time_tlock_max_i_5));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_6
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(n_0_time_tlock_max_i_6));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_8
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .O(n_0_time_tlock_max_i_8));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_9
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(n_0_time_tlock_max_i_9));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1__3),
        .Q(time_tlock_max),
        .R(n_0_reset_time_out_reg));
CARRY4 time_tlock_max_reg_i_2
       (.CI(n_0_time_tlock_max_reg_i_3),
        .CO({NLW_time_tlock_max_reg_i_2_CO_UNCONNECTED[3:2],time_tlock_max1,n_3_time_tlock_max_reg_i_2}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,time_out_counter_reg[18],n_0_time_tlock_max_i_4}),
        .O(NLW_time_tlock_max_reg_i_2_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,n_0_time_tlock_max_i_5,n_0_time_tlock_max_i_6}));
CARRY4 time_tlock_max_reg_i_3
       (.CI(n_0_time_tlock_max_reg_i_7),
        .CO({n_0_time_tlock_max_reg_i_3,n_1_time_tlock_max_reg_i_3,n_2_time_tlock_max_reg_i_3,n_3_time_tlock_max_reg_i_3}),
        .CYINIT(1'b0),
        .DI({time_out_counter_reg[15],n_0_time_tlock_max_i_8,n_0_time_tlock_max_i_9,time_out_counter_reg[9]}),
        .O(NLW_time_tlock_max_reg_i_3_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_10,n_0_time_tlock_max_i_11__0,n_0_time_tlock_max_i_12,n_0_time_tlock_max_i_13}));
CARRY4 time_tlock_max_reg_i_7
       (.CI(1'b0),
        .CO({n_0_time_tlock_max_reg_i_7,n_1_time_tlock_max_reg_i_7,n_2_time_tlock_max_reg_i_7,n_3_time_tlock_max_reg_i_7}),
        .CYINIT(1'b0),
        .DI({n_0_time_tlock_max_i_14,time_out_counter_reg[5],n_0_time_tlock_max_i_15,n_0_time_tlock_max_i_16}),
        .O(NLW_time_tlock_max_reg_i_7_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_17,n_0_time_tlock_max_i_18,n_0_time_tlock_max_i_19,n_0_time_tlock_max_i_20}));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1__3 
       (.I0(n_0_run_phase_alignment_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_1__3 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2__3 
       (.I0(\n_0_wait_bypass_count[0]_i_4__3 ),
        .I1(wait_bypass_count_reg[3]),
        .I2(\n_0_wait_bypass_count[0]_i_5__3 ),
        .I3(rx_fsm_reset_done_int_s3),
        .O(\n_0_wait_bypass_count[0]_i_2__3 ));
LUT6 #(
    .INIT(64'hFFFFEFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_4__3 
       (.I0(wait_bypass_count_reg[11]),
        .I1(wait_bypass_count_reg[4]),
        .I2(wait_bypass_count_reg[0]),
        .I3(wait_bypass_count_reg[9]),
        .I4(wait_bypass_count_reg[10]),
        .I5(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_4__3 ));
LUT6 #(
    .INIT(64'hFDFFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_5__3 
       (.I0(wait_bypass_count_reg[1]),
        .I1(wait_bypass_count_reg[6]),
        .I2(wait_bypass_count_reg[5]),
        .I3(wait_bypass_count_reg[12]),
        .I4(wait_bypass_count_reg[8]),
        .I5(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[0]_i_5__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_6__3 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_6__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7__3 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_7__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8__3 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_8__3 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_9 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_9 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2__3 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_2__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2__3 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3__3 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4__3 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5__3 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2__3 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3__3 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4__3 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5__3 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5__3 ));
FDRE \wait_bypass_count_reg[0] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3__3 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
CARRY4 \wait_bypass_count_reg[0]_i_3__3 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3__3 ,\n_1_wait_bypass_count_reg[0]_i_3__3 ,\n_2_wait_bypass_count_reg[0]_i_3__3 ,\n_3_wait_bypass_count_reg[0]_i_3__3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3__3 ,\n_5_wait_bypass_count_reg[0]_i_3__3 ,\n_6_wait_bypass_count_reg[0]_i_3__3 ,\n_7_wait_bypass_count_reg[0]_i_3__3 }),
        .S({\n_0_wait_bypass_count[0]_i_6__3 ,\n_0_wait_bypass_count[0]_i_7__3 ,\n_0_wait_bypass_count[0]_i_8__3 ,\n_0_wait_bypass_count[0]_i_9 }));
FDRE \wait_bypass_count_reg[10] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1__3 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
FDRE \wait_bypass_count_reg[11] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1__3 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
FDRE \wait_bypass_count_reg[12] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1__3 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
CARRY4 \wait_bypass_count_reg[12]_i_1__3 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1__3 ),
        .CO(\NLW_wait_bypass_count_reg[12]_i_1__3_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[12]_i_1__3_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[12]_i_1__3 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[12]_i_2__3 }));
FDRE \wait_bypass_count_reg[1] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3__3 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
FDRE \wait_bypass_count_reg[2] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3__3 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
FDRE \wait_bypass_count_reg[3] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3__3 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
FDRE \wait_bypass_count_reg[4] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1__3 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
CARRY4 \wait_bypass_count_reg[4]_i_1__3 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3__3 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1__3 ,\n_1_wait_bypass_count_reg[4]_i_1__3 ,\n_2_wait_bypass_count_reg[4]_i_1__3 ,\n_3_wait_bypass_count_reg[4]_i_1__3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1__3 ,\n_5_wait_bypass_count_reg[4]_i_1__3 ,\n_6_wait_bypass_count_reg[4]_i_1__3 ,\n_7_wait_bypass_count_reg[4]_i_1__3 }),
        .S({\n_0_wait_bypass_count[4]_i_2__3 ,\n_0_wait_bypass_count[4]_i_3__3 ,\n_0_wait_bypass_count[4]_i_4__3 ,\n_0_wait_bypass_count[4]_i_5__3 }));
FDRE \wait_bypass_count_reg[5] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1__3 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
FDRE \wait_bypass_count_reg[6] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1__3 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
FDRE \wait_bypass_count_reg[7] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1__3 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
FDRE \wait_bypass_count_reg[8] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1__3 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
CARRY4 \wait_bypass_count_reg[8]_i_1__3 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1__3 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1__3 ,\n_1_wait_bypass_count_reg[8]_i_1__3 ,\n_2_wait_bypass_count_reg[8]_i_1__3 ,\n_3_wait_bypass_count_reg[8]_i_1__3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1__3 ,\n_5_wait_bypass_count_reg[8]_i_1__3 ,\n_6_wait_bypass_count_reg[8]_i_1__3 ,\n_7_wait_bypass_count_reg[8]_i_1__3 }),
        .S({\n_0_wait_bypass_count[8]_i_2__3 ,\n_0_wait_bypass_count[8]_i_3__3 ,\n_0_wait_bypass_count[8]_i_4__3 ,\n_0_wait_bypass_count[8]_i_5__3 }));
FDRE \wait_bypass_count_reg[9] 
       (.C(gt0_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__3 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1__3 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1__3 ));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1__3 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__3[0]));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1__3 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\n_0_wait_time_cnt[1]_i_1__3 ));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1__3 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__3[2]));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \wait_time_cnt[3]_i_1__3 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0__3[3]));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1__3 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\n_0_wait_time_cnt[4]_i_1__3 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[5]_i_1__3 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[1]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__3[5]));
LUT3 #(
    .INIT(8'h10)) 
     \wait_time_cnt[6]_i_1__3 
       (.I0(rx_state[1]),
        .I1(rx_state[3]),
        .I2(rx_state[0]),
        .O(\n_0_wait_time_cnt[6]_i_1__3 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_2__3 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(wait_time_cnt_reg__0[5]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .I5(\n_0_wait_time_cnt[6]_i_4__3 ),
        .O(\n_0_wait_time_cnt[6]_i_2__3 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[6]_i_3__3 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4__3 ),
        .I2(wait_time_cnt_reg__0[3]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[5]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__3[6]));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_4__3 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(\n_0_wait_time_cnt[6]_i_4__3 ));
FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__3 ),
        .D(wait_time_cnt0__3[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\n_0_wait_time_cnt[6]_i_1__3 ));
FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__3 ),
        .D(\n_0_wait_time_cnt[1]_i_1__3 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\n_0_wait_time_cnt[6]_i_1__3 ));
FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__3 ),
        .D(wait_time_cnt0__3[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\n_0_wait_time_cnt[6]_i_1__3 ));
FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__3 ),
        .D(wait_time_cnt0__3[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\n_0_wait_time_cnt[6]_i_1__3 ));
FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__3 ),
        .D(\n_0_wait_time_cnt[4]_i_1__3 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\n_0_wait_time_cnt[6]_i_1__3 ));
FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__3 ),
        .D(wait_time_cnt0__3[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\n_0_wait_time_cnt[6]_i_1__3 ));
FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__3 ),
        .D(wait_time_cnt0__3[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\n_0_wait_time_cnt[6]_i_1__3 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_RX_STARTUP_FSM" *) 
module XLAUI_XLAUI_RX_STARTUP_FSM__parameterized0_0
   (SR,
    GT1_RX_MMCM_RESET_OUT,
    GT1_RX_FSM_RESET_DONE_OUT,
    O1,
    RXOUTCLK,
    SYSCLK_IN,
    gt1_rxusrclk_in,
    SOFT_RESET_IN,
    DONT_RESET_ON_DATA_ERROR_IN,
    data_in,
    gt1_rxresetdone_out,
    GT1_RX_MMCM_LOCK_IN,
    GT1_DATA_VALID_IN,
    GT0_QPLLLOCK_IN,
    I1);
  output [0:0]SR;
  output GT1_RX_MMCM_RESET_OUT;
  output GT1_RX_FSM_RESET_DONE_OUT;
  output O1;
  input RXOUTCLK;
  input SYSCLK_IN;
  input gt1_rxusrclk_in;
  input SOFT_RESET_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input data_in;
  input gt1_rxresetdone_out;
  input GT1_RX_MMCM_LOCK_IN;
  input GT1_DATA_VALID_IN;
  input GT0_QPLLLOCK_IN;
  input I1;

  wire D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire GT0_QPLLLOCK_IN;
  wire GT1_DATA_VALID_IN;
  wire GT1_RX_FSM_RESET_DONE_OUT;
  wire GT1_RX_MMCM_LOCK_IN;
  wire GT1_RX_MMCM_RESET_OUT;
  wire I1;
  wire O1;
  wire Q;
  wire RXOUTCLK;
  wire SOFT_RESET_IN;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_in;
  wire gt1_rxresetdone_out;
  wire gt1_rxusrclk_in;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_rx_state[0]_i_2__0 ;
  wire \n_0_FSM_sequential_rx_state[2]_i_1__0 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_4__0 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_8__0 ;
  wire n_0_RXUSERRDY_i_1__0;
  wire n_0_check_tlock_max_i_1__0;
  wire n_0_check_tlock_max_reg;
  wire n_0_gtrxreset_i_i_1__0;
  wire \n_0_init_wait_count[6]_i_1__4 ;
  wire \n_0_init_wait_count[6]_i_3__4 ;
  wire \n_0_init_wait_count[6]_i_4__4 ;
  wire n_0_init_wait_done_i_1__4;
  wire n_0_init_wait_done_reg;
  wire \n_0_mmcm_lock_count[6]_i_2__4 ;
  wire \n_0_mmcm_lock_count[7]_i_2__4 ;
  wire \n_0_mmcm_lock_count[7]_i_4__4 ;
  wire n_0_reset_time_out_reg;
  wire n_0_run_phase_alignment_int_i_1__4;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_run_phase_alignment_int_s3_reg;
  wire n_0_rx_fsm_reset_done_int_s3_reg;
  wire n_0_sync_QPLLLOCK;
  wire n_0_sync_data_valid;
  wire n_0_sync_mmcm_lock_reclocked;
  wire n_0_sync_rxpmaresetdone;
  wire n_0_sync_rxpmaresetdone_rx_s;
  wire n_0_time_out_1us_i_1__0;
  wire n_0_time_out_1us_i_2__1;
  wire n_0_time_out_1us_i_3__0;
  wire n_0_time_out_1us_i_4__0;
  wire n_0_time_out_1us_reg;
  wire n_0_time_out_2ms_i_1__4;
  wire n_0_time_out_2ms_i_2__0;
  wire n_0_time_out_2ms_i_3__0;
  wire n_0_time_out_2ms_i_4__0;
  wire n_0_time_out_2ms_reg;
  wire n_0_time_out_500us_i_1__0;
  wire n_0_time_out_500us_i_2__1;
  wire n_0_time_out_500us_i_3__1;
  wire n_0_time_out_500us_i_4__0;
  wire n_0_time_out_500us_reg;
  wire \n_0_time_out_counter[0]_i_1__4 ;
  wire \n_0_time_out_counter[0]_i_3__0 ;
  wire \n_0_time_out_counter[0]_i_4__0 ;
  wire \n_0_time_out_counter[0]_i_5__4 ;
  wire \n_0_time_out_counter[0]_i_6__4 ;
  wire \n_0_time_out_counter[0]_i_7__4 ;
  wire \n_0_time_out_counter[0]_i_8__0 ;
  wire \n_0_time_out_counter[12]_i_2__4 ;
  wire \n_0_time_out_counter[12]_i_3__4 ;
  wire \n_0_time_out_counter[12]_i_4__4 ;
  wire \n_0_time_out_counter[12]_i_5__4 ;
  wire \n_0_time_out_counter[16]_i_2__4 ;
  wire \n_0_time_out_counter[16]_i_3__4 ;
  wire \n_0_time_out_counter[16]_i_4__4 ;
  wire \n_0_time_out_counter[4]_i_2__4 ;
  wire \n_0_time_out_counter[4]_i_3__4 ;
  wire \n_0_time_out_counter[4]_i_4__4 ;
  wire \n_0_time_out_counter[4]_i_5__4 ;
  wire \n_0_time_out_counter[8]_i_2__4 ;
  wire \n_0_time_out_counter[8]_i_3__4 ;
  wire \n_0_time_out_counter[8]_i_4__4 ;
  wire \n_0_time_out_counter[8]_i_5__4 ;
  wire \n_0_time_out_counter_reg[0]_i_2__4 ;
  wire \n_0_time_out_counter_reg[12]_i_1__4 ;
  wire \n_0_time_out_counter_reg[4]_i_1__4 ;
  wire \n_0_time_out_counter_reg[8]_i_1__4 ;
  wire n_0_time_out_wait_bypass_i_1__4;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_10__0;
  wire n_0_time_tlock_max_i_11__1;
  wire n_0_time_tlock_max_i_12__0;
  wire n_0_time_tlock_max_i_13__0;
  wire n_0_time_tlock_max_i_14__0;
  wire n_0_time_tlock_max_i_15__0;
  wire n_0_time_tlock_max_i_16__0;
  wire n_0_time_tlock_max_i_17__0;
  wire n_0_time_tlock_max_i_18__0;
  wire n_0_time_tlock_max_i_19__0;
  wire n_0_time_tlock_max_i_1__4;
  wire n_0_time_tlock_max_i_20__0;
  wire n_0_time_tlock_max_i_4__0;
  wire n_0_time_tlock_max_i_5__0;
  wire n_0_time_tlock_max_i_6__0;
  wire n_0_time_tlock_max_i_8__0;
  wire n_0_time_tlock_max_i_9__0;
  wire n_0_time_tlock_max_reg_i_3__0;
  wire n_0_time_tlock_max_reg_i_7__0;
  wire \n_0_wait_bypass_count[0]_i_1__4 ;
  wire \n_0_wait_bypass_count[0]_i_2__4 ;
  wire \n_0_wait_bypass_count[0]_i_4__4 ;
  wire \n_0_wait_bypass_count[0]_i_5__4 ;
  wire \n_0_wait_bypass_count[0]_i_6__4 ;
  wire \n_0_wait_bypass_count[0]_i_7__4 ;
  wire \n_0_wait_bypass_count[0]_i_8__4 ;
  wire \n_0_wait_bypass_count[0]_i_9__0 ;
  wire \n_0_wait_bypass_count[12]_i_2__4 ;
  wire \n_0_wait_bypass_count[4]_i_2__4 ;
  wire \n_0_wait_bypass_count[4]_i_3__4 ;
  wire \n_0_wait_bypass_count[4]_i_4__4 ;
  wire \n_0_wait_bypass_count[4]_i_5__4 ;
  wire \n_0_wait_bypass_count[8]_i_2__4 ;
  wire \n_0_wait_bypass_count[8]_i_3__4 ;
  wire \n_0_wait_bypass_count[8]_i_4__4 ;
  wire \n_0_wait_bypass_count[8]_i_5__4 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3__4 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1__4 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1__4 ;
  wire \n_0_wait_time_cnt[1]_i_1__4 ;
  wire \n_0_wait_time_cnt[4]_i_1__4 ;
  wire \n_0_wait_time_cnt[6]_i_1__4 ;
  wire \n_0_wait_time_cnt[6]_i_2__4 ;
  wire \n_0_wait_time_cnt[6]_i_4__4 ;
  wire n_1_sync_QPLLLOCK;
  wire n_1_sync_data_valid;
  wire n_1_sync_mmcm_lock_reclocked;
  wire n_1_sync_rxpmaresetdone;
  wire \n_1_time_out_counter_reg[0]_i_2__4 ;
  wire \n_1_time_out_counter_reg[12]_i_1__4 ;
  wire \n_1_time_out_counter_reg[4]_i_1__4 ;
  wire \n_1_time_out_counter_reg[8]_i_1__4 ;
  wire n_1_time_tlock_max_reg_i_3__0;
  wire n_1_time_tlock_max_reg_i_7__0;
  wire \n_1_wait_bypass_count_reg[0]_i_3__4 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1__4 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1__4 ;
  wire n_2_sync_data_valid;
  wire \n_2_time_out_counter_reg[0]_i_2__4 ;
  wire \n_2_time_out_counter_reg[12]_i_1__4 ;
  wire \n_2_time_out_counter_reg[16]_i_1__4 ;
  wire \n_2_time_out_counter_reg[4]_i_1__4 ;
  wire \n_2_time_out_counter_reg[8]_i_1__4 ;
  wire n_2_time_tlock_max_reg_i_3__0;
  wire n_2_time_tlock_max_reg_i_7__0;
  wire \n_2_wait_bypass_count_reg[0]_i_3__4 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1__4 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1__4 ;
  wire n_3_sync_data_valid;
  wire \n_3_time_out_counter_reg[0]_i_2__4 ;
  wire \n_3_time_out_counter_reg[12]_i_1__4 ;
  wire \n_3_time_out_counter_reg[16]_i_1__4 ;
  wire \n_3_time_out_counter_reg[4]_i_1__4 ;
  wire \n_3_time_out_counter_reg[8]_i_1__4 ;
  wire n_3_time_tlock_max_reg_i_2__0;
  wire n_3_time_tlock_max_reg_i_3__0;
  wire n_3_time_tlock_max_reg_i_7__0;
  wire \n_3_wait_bypass_count_reg[0]_i_3__4 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1__4 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1__4 ;
  wire n_4_sync_data_valid;
  wire \n_4_time_out_counter_reg[0]_i_2__4 ;
  wire \n_4_time_out_counter_reg[12]_i_1__4 ;
  wire \n_4_time_out_counter_reg[4]_i_1__4 ;
  wire \n_4_time_out_counter_reg[8]_i_1__4 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3__4 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1__4 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1__4 ;
  wire n_5_sync_data_valid;
  wire \n_5_time_out_counter_reg[0]_i_2__4 ;
  wire \n_5_time_out_counter_reg[12]_i_1__4 ;
  wire \n_5_time_out_counter_reg[16]_i_1__4 ;
  wire \n_5_time_out_counter_reg[4]_i_1__4 ;
  wire \n_5_time_out_counter_reg[8]_i_1__4 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3__4 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1__4 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1__4 ;
  wire \n_6_time_out_counter_reg[0]_i_2__4 ;
  wire \n_6_time_out_counter_reg[12]_i_1__4 ;
  wire \n_6_time_out_counter_reg[16]_i_1__4 ;
  wire \n_6_time_out_counter_reg[4]_i_1__4 ;
  wire \n_6_time_out_counter_reg[8]_i_1__4 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3__4 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1__4 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1__4 ;
  wire \n_7_time_out_counter_reg[0]_i_2__4 ;
  wire \n_7_time_out_counter_reg[12]_i_1__4 ;
  wire \n_7_time_out_counter_reg[16]_i_1__4 ;
  wire \n_7_time_out_counter_reg[4]_i_1__4 ;
  wire \n_7_time_out_counter_reg[8]_i_1__4 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3__4 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1__4 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1__4 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1__4 ;
  wire [7:0]p_0_in__10;
  wire [6:0]p_0_in__9;
  wire run_phase_alignment_int_s2;
  wire rx_fsm_reset_done_int_s2;
(* RTL_KEEP = "yes" *)   wire [3:0]rx_state;
  wire rx_state16_out;
  wire rxpmaresetdone_i;
  wire rxresetdone_s2;
  wire rxresetdone_s3;
  wire [18:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire time_tlock_max1;
  wire [12:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0__4;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__4_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__4_O_UNCONNECTED ;
  wire [3:2]NLW_time_tlock_max_reg_i_2__0_CO_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_2__0_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_3__0_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_7__0_O_UNCONNECTED;
  wire [3:0]\NLW_wait_bypass_count_reg[12]_i_1__4_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[12]_i_1__4_O_UNCONNECTED ;

LUT6 #(
    .INIT(64'h4E0AEE2A4E0ACE0A)) 
     \FSM_sequential_rx_state[0]_i_2__0 
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .I3(n_0_time_out_2ms_reg),
        .I4(n_0_reset_time_out_reg),
        .I5(time_tlock_max),
        .O(\n_0_FSM_sequential_rx_state[0]_i_2__0 ));
LUT6 #(
    .INIT(64'h1111004015150040)) 
     \FSM_sequential_rx_state[2]_i_1__0 
       (.I0(rx_state[3]),
        .I1(rx_state[0]),
        .I2(rx_state[1]),
        .I3(n_0_time_out_2ms_reg),
        .I4(rx_state[2]),
        .I5(rx_state16_out),
        .O(\n_0_FSM_sequential_rx_state[2]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair30" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_rx_state[2]_i_2__0 
       (.I0(time_tlock_max),
        .I1(n_0_reset_time_out_reg),
        .O(rx_state16_out));
LUT6 #(
    .INIT(64'h0F0F0F0F4F404040)) 
     \FSM_sequential_rx_state[3]_i_4__0 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_FSM_sequential_rx_state[3]_i_8__0 ),
        .I2(rx_state[1]),
        .I3(I1),
        .I4(rx_state[2]),
        .I5(rx_state[3]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_4__0 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_sequential_rx_state[3]_i_8__0 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[3]),
        .I4(wait_time_cnt_reg__0[0]),
        .I5(wait_time_cnt_reg__0[1]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_8__0 ));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_3_sync_data_valid),
        .Q(rx_state[0]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_2_sync_data_valid),
        .Q(rx_state[1]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(\n_0_FSM_sequential_rx_state[2]_i_1__0 ),
        .Q(rx_state[2]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_1_sync_data_valid),
        .Q(rx_state[3]),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD2000)) 
     RXUSERRDY_i_1__0
       (.I0(rx_state[0]),
        .I1(rx_state[3]),
        .I2(rx_state[2]),
        .I3(rx_state[1]),
        .I4(O1),
        .O(n_0_RXUSERRDY_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     RXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_RXUSERRDY_i_1__0),
        .Q(O1),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0008)) 
     check_tlock_max_i_1__0
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(rx_state[3]),
        .I3(rx_state[1]),
        .I4(n_0_check_tlock_max_reg),
        .O(n_0_check_tlock_max_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     check_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_check_tlock_max_i_1__0),
        .Q(n_0_check_tlock_max_reg),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD0004)) 
     gtrxreset_i_i_1__0
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(rx_state[3]),
        .I3(rx_state[1]),
        .I4(SR),
        .O(n_0_gtrxreset_i_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     gtrxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gtrxreset_i_i_1__0),
        .Q(SR),
        .R(SOFT_RESET_IN));
(* SOFT_HLUTNM = "soft_lutpair34" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1__4 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in__9[0]));
(* SOFT_HLUTNM = "soft_lutpair34" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1__4 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in__9[1]));
(* SOFT_HLUTNM = "soft_lutpair28" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[2]_i_1__4 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .O(p_0_in__9[2]));
(* SOFT_HLUTNM = "soft_lutpair28" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \init_wait_count[3]_i_1__4 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .O(p_0_in__9[3]));
(* SOFT_HLUTNM = "soft_lutpair26" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \init_wait_count[4]_i_1__4 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .O(p_0_in__9[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \init_wait_count[5]_i_1__4 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .I5(init_wait_count_reg__0[4]),
        .O(p_0_in__9[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
     \init_wait_count[6]_i_1__4 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[0]),
        .I3(\n_0_init_wait_count[6]_i_3__4 ),
        .I4(init_wait_count_reg__0[4]),
        .I5(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_1__4 ));
LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[6]_i_2__4 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\n_0_init_wait_count[6]_i_4__4 ),
        .I2(init_wait_count_reg__0[5]),
        .O(p_0_in__9[6]));
LUT2 #(
    .INIT(4'h7)) 
     \init_wait_count[6]_i_3__4 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_3__4 ));
(* SOFT_HLUTNM = "soft_lutpair26" *) 
   LUT5 #(
    .INIT(32'h80000000)) 
     \init_wait_count[6]_i_4__4 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_4__4 ));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__4 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__9[0]),
        .Q(init_wait_count_reg__0[0]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__4 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__9[1]),
        .Q(init_wait_count_reg__0[1]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__4 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__9[2]),
        .Q(init_wait_count_reg__0[2]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__4 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__9[3]),
        .Q(init_wait_count_reg__0[3]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__4 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__9[4]),
        .Q(init_wait_count_reg__0[4]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__4 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__9[5]),
        .Q(init_wait_count_reg__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__4 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__9[6]),
        .Q(init_wait_count_reg__0[6]));
LUT2 #(
    .INIT(4'hE)) 
     init_wait_done_i_1__4
       (.I0(init_wait_done),
        .I1(n_0_init_wait_done_reg),
        .O(n_0_init_wait_done_i_1__4));
LUT6 #(
    .INIT(64'h0000000004000000)) 
     init_wait_done_i_2__4
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[4]),
        .I2(\n_0_init_wait_count[6]_i_3__4 ),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_done));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(n_0_init_wait_done_i_1__4),
        .Q(n_0_init_wait_done_reg));
(* SOFT_HLUTNM = "soft_lutpair33" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__10[0]));
(* SOFT_HLUTNM = "soft_lutpair33" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__10[1]));
(* SOFT_HLUTNM = "soft_lutpair31" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[2]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__10[2]));
(* SOFT_HLUTNM = "soft_lutpair27" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \mmcm_lock_count[3]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__10[3]));
(* SOFT_HLUTNM = "soft_lutpair27" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \mmcm_lock_count[4]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[3]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__10[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[5]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__10[5]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[6]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(\n_0_mmcm_lock_count[6]_i_2__4 ),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__10[6]));
(* SOFT_HLUTNM = "soft_lutpair31" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \mmcm_lock_count[6]_i_2__4 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(\n_0_mmcm_lock_count[6]_i_2__4 ));
LUT3 #(
    .INIT(8'h7F)) 
     \mmcm_lock_count[7]_i_2__4 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__4 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(\n_0_mmcm_lock_count[7]_i_2__4 ));
LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[7]_i_3__4 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__4 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__10[7]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \mmcm_lock_count[7]_i_4__4 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(\n_0_mmcm_lock_count[7]_i_4__4 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__4 ),
        .D(p_0_in__10[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__4 ),
        .D(p_0_in__10[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__4 ),
        .D(p_0_in__10[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__4 ),
        .D(p_0_in__10[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__4 ),
        .D(p_0_in__10[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__4 ),
        .D(p_0_in__10[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__4 ),
        .D(p_0_in__10[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__4 ),
        .D(p_0_in__10[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
FDRE #(
    .INIT(1'b1)) 
     mmcm_reset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_rxpmaresetdone),
        .Q(GT1_RX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync1_rx
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(1'b0),
        .PRE(SR),
        .Q(D));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync2_rx
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(D),
        .PRE(SR),
        .Q(Q));
FDSE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_QPLLLOCK),
        .Q(n_0_reset_time_out_reg),
        .S(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0002)) 
     run_phase_alignment_int_i_1__4
       (.I0(rx_state[3]),
        .I1(rx_state[0]),
        .I2(rx_state[2]),
        .I3(rx_state[1]),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1__4));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1__4),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(run_phase_alignment_int_s2),
        .Q(n_0_run_phase_alignment_int_s3_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_data_valid),
        .Q(GT1_RX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_s3_reg
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(rx_fsm_reset_done_int_s2),
        .Q(n_0_rx_fsm_reset_done_int_s3_reg),
        .R(1'b0));
FDCE #(
    .INIT(1'b0)) 
     rxpmaresetdone_i_reg
       (.C(RXOUTCLK),
        .CE(1'b1),
        .CLR(Q),
        .D(n_0_sync_rxpmaresetdone_rx_s),
        .Q(rxpmaresetdone_i));
FDRE #(
    .INIT(1'b0)) 
     rxresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(rxresetdone_s2),
        .Q(rxresetdone_s3),
        .R(1'b0));
XLAUI_XLAUI_sync_block__parameterized0_41 sync_QPLLLOCK
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .I1(n_5_sync_data_valid),
        .I2(n_1_sync_rxpmaresetdone),
        .I3(n_0_reset_time_out_reg),
        .I4(n_0_time_out_2ms_reg),
        .O1(n_0_sync_QPLLLOCK),
        .O2(n_1_sync_QPLLLOCK),
        .SYSCLK_IN(SYSCLK_IN),
        .out(rx_state[3:1]),
        .rxresetdone_s3(rxresetdone_s3));
XLAUI_XLAUI_sync_block__parameterized0_42 sync_RXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(rxresetdone_s2),
        .gt1_rxresetdone_out(gt1_rxresetdone_out));
XLAUI_XLAUI_sync_block__parameterized0_43 sync_data_valid
       (.D({n_1_sync_data_valid,n_2_sync_data_valid,n_3_sync_data_valid}),
        .DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .E(n_4_sync_data_valid),
        .GT1_DATA_VALID_IN(GT1_DATA_VALID_IN),
        .GT1_RX_FSM_RESET_DONE_OUT(GT1_RX_FSM_RESET_DONE_OUT),
        .I1(n_0_reset_time_out_reg),
        .I2(n_0_time_out_500us_reg),
        .I3(n_0_time_out_1us_reg),
        .I4(\n_0_FSM_sequential_rx_state[0]_i_2__0 ),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_4__0 ),
        .I6(n_1_sync_QPLLLOCK),
        .I7(n_0_init_wait_done_reg),
        .I8(I1),
        .I9(n_0_time_out_2ms_reg),
        .O1(n_0_sync_data_valid),
        .O2(n_5_sync_data_valid),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state),
        .rx_state16_out(rx_state16_out),
        .rxresetdone_s3(rxresetdone_s3),
        .time_out_wait_bypass_s3(time_out_wait_bypass_s3));
XLAUI_XLAUI_sync_block__parameterized0_44 sync_mmcm_lock_reclocked
       (.GT1_RX_MMCM_LOCK_IN(GT1_RX_MMCM_LOCK_IN),
        .I1(\n_0_mmcm_lock_count[7]_i_4__4 ),
        .O1(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(n_0_sync_mmcm_lock_reclocked),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked));
XLAUI_XLAUI_sync_block__parameterized0_45 sync_run_phase_alignment_int
       (.data_in(n_0_run_phase_alignment_int_reg),
        .data_out(run_phase_alignment_int_s2),
        .gt1_rxusrclk_in(gt1_rxusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_46 sync_rx_fsm_reset_done_int
       (.GT1_RX_FSM_RESET_DONE_OUT(GT1_RX_FSM_RESET_DONE_OUT),
        .data_out(rx_fsm_reset_done_int_s2),
        .gt1_rxusrclk_in(gt1_rxusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_47 sync_rxpmaresetdone
       (.GT1_RX_MMCM_RESET_OUT(GT1_RX_MMCM_RESET_OUT),
        .I1(I1),
        .O1(n_0_sync_rxpmaresetdone),
        .O2(n_1_sync_rxpmaresetdone),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(rxpmaresetdone_i),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state));
XLAUI_XLAUI_sync_block__parameterized0_48 sync_rxpmaresetdone_rx_s
       (.RXOUTCLK(RXOUTCLK),
        .data_in(data_in),
        .data_out(n_0_sync_rxpmaresetdone_rx_s));
XLAUI_XLAUI_sync_block__parameterized0_49 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
LUT6 #(
    .INIT(64'hFFFFFFFF00100000)) 
     time_out_1us_i_1__0
       (.I0(time_out_counter_reg[18]),
        .I1(time_out_counter_reg[4]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[17]),
        .I4(n_0_time_out_1us_i_2__1),
        .I5(n_0_time_out_1us_reg),
        .O(n_0_time_out_1us_i_1__0));
LUT6 #(
    .INIT(64'h0001000000000000)) 
     time_out_1us_i_2__1
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[12]),
        .I3(time_out_counter_reg[13]),
        .I4(n_0_time_out_1us_i_3__0),
        .I5(n_0_time_out_1us_i_4__0),
        .O(n_0_time_out_1us_i_2__1));
LUT6 #(
    .INIT(64'h0000000000100000)) 
     time_out_1us_i_3__0
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .I4(time_out_counter_reg[1]),
        .I5(time_out_counter_reg[15]),
        .O(n_0_time_out_1us_i_3__0));
LUT5 #(
    .INIT(32'h00000010)) 
     time_out_1us_i_4__0
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[16]),
        .I4(time_out_counter_reg[0]),
        .O(n_0_time_out_1us_i_4__0));
FDRE #(
    .INIT(1'b0)) 
     time_out_1us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_1us_i_1__0),
        .Q(n_0_time_out_1us_reg),
        .R(n_0_reset_time_out_reg));
LUT5 #(
    .INIT(32'hAAAAAAAB)) 
     time_out_2ms_i_1__4
       (.I0(n_0_time_out_2ms_reg),
        .I1(n_0_time_out_2ms_i_2__0),
        .I2(n_0_time_out_2ms_i_3__0),
        .I3(n_0_time_out_2ms_i_4__0),
        .I4(\n_0_time_out_counter[0]_i_3__0 ),
        .O(n_0_time_out_2ms_i_1__4));
LUT5 #(
    .INIT(32'hFFFEFFFF)) 
     time_out_2ms_i_2__0
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[13]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[11]),
        .I4(time_out_counter_reg[9]),
        .O(n_0_time_out_2ms_i_2__0));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFF7FF)) 
     time_out_2ms_i_3__0
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[4]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[18]),
        .I4(time_out_counter_reg[7]),
        .I5(time_out_counter_reg[8]),
        .O(n_0_time_out_2ms_i_3__0));
LUT4 #(
    .INIT(16'h7FFF)) 
     time_out_2ms_i_4__0
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[2]),
        .O(n_0_time_out_2ms_i_4__0));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1__4),
        .Q(n_0_time_out_2ms_reg),
        .R(n_0_reset_time_out_reg));
LUT5 #(
    .INIT(32'hFFFF1000)) 
     time_out_500us_i_1__0
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[18]),
        .I2(n_0_time_out_500us_i_2__1),
        .I3(n_0_time_out_500us_i_3__1),
        .I4(n_0_time_out_500us_reg),
        .O(n_0_time_out_500us_i_1__0));
LUT4 #(
    .INIT(16'h0020)) 
     time_out_500us_i_2__1
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[17]),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[9]),
        .O(n_0_time_out_500us_i_2__1));
LUT6 #(
    .INIT(64'h0000000000040000)) 
     time_out_500us_i_3__1
       (.I0(n_0_time_out_2ms_i_4__0),
        .I1(n_0_time_out_500us_i_4__0),
        .I2(\n_0_time_out_counter[0]_i_3__0 ),
        .I3(time_out_counter_reg[11]),
        .I4(time_out_counter_reg[14]),
        .I5(time_out_counter_reg[3]),
        .O(n_0_time_out_500us_i_3__1));
LUT2 #(
    .INIT(4'h1)) 
     time_out_500us_i_4__0
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_out_500us_i_4__0));
FDRE #(
    .INIT(1'b0)) 
     time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_500us_i_1__0),
        .Q(n_0_time_out_500us_reg),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFFFFFFFFBFFFFFFF)) 
     \time_out_counter[0]_i_1__4 
       (.I0(\n_0_time_out_counter[0]_i_3__0 ),
        .I1(time_out_counter_reg[16]),
        .I2(time_out_counter_reg[0]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[2]),
        .I5(\n_0_time_out_counter[0]_i_4__0 ),
        .O(\n_0_time_out_counter[0]_i_1__4 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \time_out_counter[0]_i_3__0 
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[0]_i_3__0 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFD)) 
     \time_out_counter[0]_i_4__0 
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[13]),
        .I4(time_out_counter_reg[17]),
        .I5(n_0_time_out_2ms_i_3__0),
        .O(\n_0_time_out_counter[0]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_5__4 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_5__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6__4 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_6__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_7__4 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_7__4 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_8__0 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_8__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2__4 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3__4 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4__4 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5__4 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2__4 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_2__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3__4 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_3__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4__4 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_4__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2__4 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3__4 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4__4 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5__4 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2__4 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3__4 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4__4 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5__4 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5__4 ));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_7_time_out_counter_reg[0]_i_2__4 ),
        .Q(time_out_counter_reg[0]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[0]_i_2__4 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2__4 ,\n_1_time_out_counter_reg[0]_i_2__4 ,\n_2_time_out_counter_reg[0]_i_2__4 ,\n_3_time_out_counter_reg[0]_i_2__4 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2__4 ,\n_5_time_out_counter_reg[0]_i_2__4 ,\n_6_time_out_counter_reg[0]_i_2__4 ,\n_7_time_out_counter_reg[0]_i_2__4 }),
        .S({\n_0_time_out_counter[0]_i_5__4 ,\n_0_time_out_counter[0]_i_6__4 ,\n_0_time_out_counter[0]_i_7__4 ,\n_0_time_out_counter[0]_i_8__0 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_5_time_out_counter_reg[8]_i_1__4 ),
        .Q(time_out_counter_reg[10]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_4_time_out_counter_reg[8]_i_1__4 ),
        .Q(time_out_counter_reg[11]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_7_time_out_counter_reg[12]_i_1__4 ),
        .Q(time_out_counter_reg[12]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[12]_i_1__4 
       (.CI(\n_0_time_out_counter_reg[8]_i_1__4 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1__4 ,\n_1_time_out_counter_reg[12]_i_1__4 ,\n_2_time_out_counter_reg[12]_i_1__4 ,\n_3_time_out_counter_reg[12]_i_1__4 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1__4 ,\n_5_time_out_counter_reg[12]_i_1__4 ,\n_6_time_out_counter_reg[12]_i_1__4 ,\n_7_time_out_counter_reg[12]_i_1__4 }),
        .S({\n_0_time_out_counter[12]_i_2__4 ,\n_0_time_out_counter[12]_i_3__4 ,\n_0_time_out_counter[12]_i_4__4 ,\n_0_time_out_counter[12]_i_5__4 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_6_time_out_counter_reg[12]_i_1__4 ),
        .Q(time_out_counter_reg[13]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_5_time_out_counter_reg[12]_i_1__4 ),
        .Q(time_out_counter_reg[14]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_4_time_out_counter_reg[12]_i_1__4 ),
        .Q(time_out_counter_reg[15]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_7_time_out_counter_reg[16]_i_1__4 ),
        .Q(time_out_counter_reg[16]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[16]_i_1__4 
       (.CI(\n_0_time_out_counter_reg[12]_i_1__4 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__4_CO_UNCONNECTED [3:2],\n_2_time_out_counter_reg[16]_i_1__4 ,\n_3_time_out_counter_reg[16]_i_1__4 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__4_O_UNCONNECTED [3],\n_5_time_out_counter_reg[16]_i_1__4 ,\n_6_time_out_counter_reg[16]_i_1__4 ,\n_7_time_out_counter_reg[16]_i_1__4 }),
        .S({1'b0,\n_0_time_out_counter[16]_i_2__4 ,\n_0_time_out_counter[16]_i_3__4 ,\n_0_time_out_counter[16]_i_4__4 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_6_time_out_counter_reg[16]_i_1__4 ),
        .Q(time_out_counter_reg[17]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_5_time_out_counter_reg[16]_i_1__4 ),
        .Q(time_out_counter_reg[18]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_6_time_out_counter_reg[0]_i_2__4 ),
        .Q(time_out_counter_reg[1]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_5_time_out_counter_reg[0]_i_2__4 ),
        .Q(time_out_counter_reg[2]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_4_time_out_counter_reg[0]_i_2__4 ),
        .Q(time_out_counter_reg[3]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_7_time_out_counter_reg[4]_i_1__4 ),
        .Q(time_out_counter_reg[4]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[4]_i_1__4 
       (.CI(\n_0_time_out_counter_reg[0]_i_2__4 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1__4 ,\n_1_time_out_counter_reg[4]_i_1__4 ,\n_2_time_out_counter_reg[4]_i_1__4 ,\n_3_time_out_counter_reg[4]_i_1__4 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1__4 ,\n_5_time_out_counter_reg[4]_i_1__4 ,\n_6_time_out_counter_reg[4]_i_1__4 ,\n_7_time_out_counter_reg[4]_i_1__4 }),
        .S({\n_0_time_out_counter[4]_i_2__4 ,\n_0_time_out_counter[4]_i_3__4 ,\n_0_time_out_counter[4]_i_4__4 ,\n_0_time_out_counter[4]_i_5__4 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_6_time_out_counter_reg[4]_i_1__4 ),
        .Q(time_out_counter_reg[5]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_5_time_out_counter_reg[4]_i_1__4 ),
        .Q(time_out_counter_reg[6]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_4_time_out_counter_reg[4]_i_1__4 ),
        .Q(time_out_counter_reg[7]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_7_time_out_counter_reg[8]_i_1__4 ),
        .Q(time_out_counter_reg[8]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[8]_i_1__4 
       (.CI(\n_0_time_out_counter_reg[4]_i_1__4 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1__4 ,\n_1_time_out_counter_reg[8]_i_1__4 ,\n_2_time_out_counter_reg[8]_i_1__4 ,\n_3_time_out_counter_reg[8]_i_1__4 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1__4 ,\n_5_time_out_counter_reg[8]_i_1__4 ,\n_6_time_out_counter_reg[8]_i_1__4 ,\n_7_time_out_counter_reg[8]_i_1__4 }),
        .S({\n_0_time_out_counter[8]_i_2__4 ,\n_0_time_out_counter[8]_i_3__4 ,\n_0_time_out_counter[8]_i_4__4 ,\n_0_time_out_counter[8]_i_5__4 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__4 ),
        .D(\n_6_time_out_counter_reg[8]_i_1__4 ),
        .Q(time_out_counter_reg[9]),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1__4
       (.I0(\n_0_wait_bypass_count[0]_i_4__4 ),
        .I1(wait_bypass_count_reg[3]),
        .I2(\n_0_wait_bypass_count[0]_i_5__4 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(n_0_rx_fsm_reset_done_int_s3_reg),
        .I5(n_0_run_phase_alignment_int_s3_reg),
        .O(n_0_time_out_wait_bypass_i_1__4));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1__4),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_10__0
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[15]),
        .O(n_0_time_tlock_max_i_10__0));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_11__1
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_tlock_max_i_11__1));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_12__0
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[10]),
        .O(n_0_time_tlock_max_i_12__0));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_13__0
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .O(n_0_time_tlock_max_i_13__0));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_14__0
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[6]),
        .O(n_0_time_tlock_max_i_14__0));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_15__0
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_15__0));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_16__0
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(n_0_time_tlock_max_i_16__0));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_17__0
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(n_0_time_tlock_max_i_17__0));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_18__0
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[5]),
        .O(n_0_time_tlock_max_i_18__0));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_19__0
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_19__0));
(* SOFT_HLUTNM = "soft_lutpair30" *) 
   LUT3 #(
    .INIT(8'hF8)) 
     time_tlock_max_i_1__4
       (.I0(n_0_check_tlock_max_reg),
        .I1(time_tlock_max1),
        .I2(time_tlock_max),
        .O(n_0_time_tlock_max_i_1__4));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_20__0
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(n_0_time_tlock_max_i_20__0));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_4__0
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[16]),
        .O(n_0_time_tlock_max_i_4__0));
LUT1 #(
    .INIT(2'h1)) 
     time_tlock_max_i_5__0
       (.I0(time_out_counter_reg[18]),
        .O(n_0_time_tlock_max_i_5__0));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_6__0
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(n_0_time_tlock_max_i_6__0));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_8__0
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .O(n_0_time_tlock_max_i_8__0));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_9__0
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(n_0_time_tlock_max_i_9__0));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1__4),
        .Q(time_tlock_max),
        .R(n_0_reset_time_out_reg));
CARRY4 time_tlock_max_reg_i_2__0
       (.CI(n_0_time_tlock_max_reg_i_3__0),
        .CO({NLW_time_tlock_max_reg_i_2__0_CO_UNCONNECTED[3:2],time_tlock_max1,n_3_time_tlock_max_reg_i_2__0}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,time_out_counter_reg[18],n_0_time_tlock_max_i_4__0}),
        .O(NLW_time_tlock_max_reg_i_2__0_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,n_0_time_tlock_max_i_5__0,n_0_time_tlock_max_i_6__0}));
CARRY4 time_tlock_max_reg_i_3__0
       (.CI(n_0_time_tlock_max_reg_i_7__0),
        .CO({n_0_time_tlock_max_reg_i_3__0,n_1_time_tlock_max_reg_i_3__0,n_2_time_tlock_max_reg_i_3__0,n_3_time_tlock_max_reg_i_3__0}),
        .CYINIT(1'b0),
        .DI({time_out_counter_reg[15],n_0_time_tlock_max_i_8__0,n_0_time_tlock_max_i_9__0,time_out_counter_reg[9]}),
        .O(NLW_time_tlock_max_reg_i_3__0_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_10__0,n_0_time_tlock_max_i_11__1,n_0_time_tlock_max_i_12__0,n_0_time_tlock_max_i_13__0}));
CARRY4 time_tlock_max_reg_i_7__0
       (.CI(1'b0),
        .CO({n_0_time_tlock_max_reg_i_7__0,n_1_time_tlock_max_reg_i_7__0,n_2_time_tlock_max_reg_i_7__0,n_3_time_tlock_max_reg_i_7__0}),
        .CYINIT(1'b0),
        .DI({n_0_time_tlock_max_i_14__0,time_out_counter_reg[5],n_0_time_tlock_max_i_15__0,n_0_time_tlock_max_i_16__0}),
        .O(NLW_time_tlock_max_reg_i_7__0_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_17__0,n_0_time_tlock_max_i_18__0,n_0_time_tlock_max_i_19__0,n_0_time_tlock_max_i_20__0}));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1__4 
       (.I0(n_0_run_phase_alignment_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_1__4 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2__4 
       (.I0(\n_0_wait_bypass_count[0]_i_4__4 ),
        .I1(wait_bypass_count_reg[3]),
        .I2(\n_0_wait_bypass_count[0]_i_5__4 ),
        .I3(n_0_rx_fsm_reset_done_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_2__4 ));
LUT6 #(
    .INIT(64'hFFFFEFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_4__4 
       (.I0(wait_bypass_count_reg[11]),
        .I1(wait_bypass_count_reg[4]),
        .I2(wait_bypass_count_reg[0]),
        .I3(wait_bypass_count_reg[9]),
        .I4(wait_bypass_count_reg[10]),
        .I5(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_4__4 ));
LUT6 #(
    .INIT(64'hFDFFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_5__4 
       (.I0(wait_bypass_count_reg[1]),
        .I1(wait_bypass_count_reg[6]),
        .I2(wait_bypass_count_reg[5]),
        .I3(wait_bypass_count_reg[12]),
        .I4(wait_bypass_count_reg[8]),
        .I5(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[0]_i_5__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_6__4 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_6__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7__4 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_7__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8__4 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_8__4 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_9__0 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_9__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2__4 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_2__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2__4 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3__4 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4__4 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5__4 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2__4 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3__4 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4__4 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5__4 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5__4 ));
FDRE \wait_bypass_count_reg[0] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3__4 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
CARRY4 \wait_bypass_count_reg[0]_i_3__4 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3__4 ,\n_1_wait_bypass_count_reg[0]_i_3__4 ,\n_2_wait_bypass_count_reg[0]_i_3__4 ,\n_3_wait_bypass_count_reg[0]_i_3__4 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3__4 ,\n_5_wait_bypass_count_reg[0]_i_3__4 ,\n_6_wait_bypass_count_reg[0]_i_3__4 ,\n_7_wait_bypass_count_reg[0]_i_3__4 }),
        .S({\n_0_wait_bypass_count[0]_i_6__4 ,\n_0_wait_bypass_count[0]_i_7__4 ,\n_0_wait_bypass_count[0]_i_8__4 ,\n_0_wait_bypass_count[0]_i_9__0 }));
FDRE \wait_bypass_count_reg[10] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1__4 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
FDRE \wait_bypass_count_reg[11] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1__4 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
FDRE \wait_bypass_count_reg[12] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1__4 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
CARRY4 \wait_bypass_count_reg[12]_i_1__4 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1__4 ),
        .CO(\NLW_wait_bypass_count_reg[12]_i_1__4_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[12]_i_1__4_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[12]_i_1__4 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[12]_i_2__4 }));
FDRE \wait_bypass_count_reg[1] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3__4 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
FDRE \wait_bypass_count_reg[2] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3__4 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
FDRE \wait_bypass_count_reg[3] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3__4 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
FDRE \wait_bypass_count_reg[4] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1__4 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
CARRY4 \wait_bypass_count_reg[4]_i_1__4 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3__4 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1__4 ,\n_1_wait_bypass_count_reg[4]_i_1__4 ,\n_2_wait_bypass_count_reg[4]_i_1__4 ,\n_3_wait_bypass_count_reg[4]_i_1__4 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1__4 ,\n_5_wait_bypass_count_reg[4]_i_1__4 ,\n_6_wait_bypass_count_reg[4]_i_1__4 ,\n_7_wait_bypass_count_reg[4]_i_1__4 }),
        .S({\n_0_wait_bypass_count[4]_i_2__4 ,\n_0_wait_bypass_count[4]_i_3__4 ,\n_0_wait_bypass_count[4]_i_4__4 ,\n_0_wait_bypass_count[4]_i_5__4 }));
FDRE \wait_bypass_count_reg[5] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1__4 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
FDRE \wait_bypass_count_reg[6] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1__4 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
FDRE \wait_bypass_count_reg[7] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1__4 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
FDRE \wait_bypass_count_reg[8] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1__4 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
CARRY4 \wait_bypass_count_reg[8]_i_1__4 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1__4 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1__4 ,\n_1_wait_bypass_count_reg[8]_i_1__4 ,\n_2_wait_bypass_count_reg[8]_i_1__4 ,\n_3_wait_bypass_count_reg[8]_i_1__4 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1__4 ,\n_5_wait_bypass_count_reg[8]_i_1__4 ,\n_6_wait_bypass_count_reg[8]_i_1__4 ,\n_7_wait_bypass_count_reg[8]_i_1__4 }),
        .S({\n_0_wait_bypass_count[8]_i_2__4 ,\n_0_wait_bypass_count[8]_i_3__4 ,\n_0_wait_bypass_count[8]_i_4__4 ,\n_0_wait_bypass_count[8]_i_5__4 }));
FDRE \wait_bypass_count_reg[9] 
       (.C(gt1_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__4 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1__4 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1__4 ));
(* SOFT_HLUTNM = "soft_lutpair32" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1__4 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__4[0]));
(* SOFT_HLUTNM = "soft_lutpair32" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1__4 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\n_0_wait_time_cnt[1]_i_1__4 ));
(* SOFT_HLUTNM = "soft_lutpair29" *) 
   LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1__4 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__4[2]));
(* SOFT_HLUTNM = "soft_lutpair25" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \wait_time_cnt[3]_i_1__4 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0__4[3]));
(* SOFT_HLUTNM = "soft_lutpair25" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1__4 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\n_0_wait_time_cnt[4]_i_1__4 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[5]_i_1__4 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[1]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__4[5]));
LUT3 #(
    .INIT(8'h10)) 
     \wait_time_cnt[6]_i_1__4 
       (.I0(rx_state[1]),
        .I1(rx_state[3]),
        .I2(rx_state[0]),
        .O(\n_0_wait_time_cnt[6]_i_1__4 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_2__4 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(wait_time_cnt_reg__0[5]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .I5(\n_0_wait_time_cnt[6]_i_4__4 ),
        .O(\n_0_wait_time_cnt[6]_i_2__4 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[6]_i_3__4 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4__4 ),
        .I2(wait_time_cnt_reg__0[3]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[5]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__4[6]));
(* SOFT_HLUTNM = "soft_lutpair29" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_4__4 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(\n_0_wait_time_cnt[6]_i_4__4 ));
FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__4 ),
        .D(wait_time_cnt0__4[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\n_0_wait_time_cnt[6]_i_1__4 ));
FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__4 ),
        .D(\n_0_wait_time_cnt[1]_i_1__4 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\n_0_wait_time_cnt[6]_i_1__4 ));
FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__4 ),
        .D(wait_time_cnt0__4[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\n_0_wait_time_cnt[6]_i_1__4 ));
FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__4 ),
        .D(wait_time_cnt0__4[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\n_0_wait_time_cnt[6]_i_1__4 ));
FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__4 ),
        .D(\n_0_wait_time_cnt[4]_i_1__4 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\n_0_wait_time_cnt[6]_i_1__4 ));
FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__4 ),
        .D(wait_time_cnt0__4[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\n_0_wait_time_cnt[6]_i_1__4 ));
FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__4 ),
        .D(wait_time_cnt0__4[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\n_0_wait_time_cnt[6]_i_1__4 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_RX_STARTUP_FSM" *) 
module XLAUI_XLAUI_RX_STARTUP_FSM__parameterized0_2
   (SR,
    GT2_RX_MMCM_RESET_OUT,
    GT2_RX_FSM_RESET_DONE_OUT,
    O1,
    RXOUTCLK,
    SYSCLK_IN,
    gt2_rxusrclk_in,
    SOFT_RESET_IN,
    DONT_RESET_ON_DATA_ERROR_IN,
    data_in,
    gt2_rxresetdone_out,
    GT2_RX_MMCM_LOCK_IN,
    GT2_DATA_VALID_IN,
    GT0_QPLLLOCK_IN,
    I1);
  output [0:0]SR;
  output GT2_RX_MMCM_RESET_OUT;
  output GT2_RX_FSM_RESET_DONE_OUT;
  output O1;
  input RXOUTCLK;
  input SYSCLK_IN;
  input gt2_rxusrclk_in;
  input SOFT_RESET_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input data_in;
  input gt2_rxresetdone_out;
  input GT2_RX_MMCM_LOCK_IN;
  input GT2_DATA_VALID_IN;
  input GT0_QPLLLOCK_IN;
  input I1;

  wire D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire GT0_QPLLLOCK_IN;
  wire GT2_DATA_VALID_IN;
  wire GT2_RX_FSM_RESET_DONE_OUT;
  wire GT2_RX_MMCM_LOCK_IN;
  wire GT2_RX_MMCM_RESET_OUT;
  wire I1;
  wire O1;
  wire Q;
  wire RXOUTCLK;
  wire SOFT_RESET_IN;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_in;
  wire gt2_rxresetdone_out;
  wire gt2_rxusrclk_in;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_rx_state[0]_i_2__1 ;
  wire \n_0_FSM_sequential_rx_state[2]_i_1__1 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_4__1 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_8__1 ;
  wire n_0_RXUSERRDY_i_1__1;
  wire n_0_check_tlock_max_i_1__1;
  wire n_0_check_tlock_max_reg;
  wire n_0_gtrxreset_i_i_1__1;
  wire \n_0_init_wait_count[6]_i_1__5 ;
  wire \n_0_init_wait_count[6]_i_3__5 ;
  wire \n_0_init_wait_count[6]_i_4__5 ;
  wire n_0_init_wait_done_i_1__5;
  wire n_0_init_wait_done_reg;
  wire \n_0_mmcm_lock_count[6]_i_2__5 ;
  wire \n_0_mmcm_lock_count[7]_i_2__5 ;
  wire \n_0_mmcm_lock_count[7]_i_4__5 ;
  wire n_0_reset_time_out_reg;
  wire n_0_run_phase_alignment_int_i_1__5;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_run_phase_alignment_int_s3_reg;
  wire n_0_rx_fsm_reset_done_int_s3_reg;
  wire n_0_sync_QPLLLOCK;
  wire n_0_sync_data_valid;
  wire n_0_sync_mmcm_lock_reclocked;
  wire n_0_sync_rxpmaresetdone;
  wire n_0_sync_rxpmaresetdone_rx_s;
  wire n_0_time_out_1us_i_1__1;
  wire n_0_time_out_1us_i_2__2;
  wire n_0_time_out_1us_i_3__1;
  wire n_0_time_out_1us_i_4__1;
  wire n_0_time_out_1us_reg;
  wire n_0_time_out_2ms_i_1__5;
  wire n_0_time_out_2ms_i_2__1;
  wire n_0_time_out_2ms_i_3__1;
  wire n_0_time_out_2ms_i_4__1;
  wire n_0_time_out_2ms_reg;
  wire n_0_time_out_500us_i_1__1;
  wire n_0_time_out_500us_i_2__2;
  wire n_0_time_out_500us_i_3__2;
  wire n_0_time_out_500us_i_4__1;
  wire n_0_time_out_500us_reg;
  wire \n_0_time_out_counter[0]_i_1__5 ;
  wire \n_0_time_out_counter[0]_i_3__1 ;
  wire \n_0_time_out_counter[0]_i_4__1 ;
  wire \n_0_time_out_counter[0]_i_5__5 ;
  wire \n_0_time_out_counter[0]_i_6__5 ;
  wire \n_0_time_out_counter[0]_i_7__5 ;
  wire \n_0_time_out_counter[0]_i_8__1 ;
  wire \n_0_time_out_counter[12]_i_2__5 ;
  wire \n_0_time_out_counter[12]_i_3__5 ;
  wire \n_0_time_out_counter[12]_i_4__5 ;
  wire \n_0_time_out_counter[12]_i_5__5 ;
  wire \n_0_time_out_counter[16]_i_2__5 ;
  wire \n_0_time_out_counter[16]_i_3__5 ;
  wire \n_0_time_out_counter[16]_i_4__5 ;
  wire \n_0_time_out_counter[4]_i_2__5 ;
  wire \n_0_time_out_counter[4]_i_3__5 ;
  wire \n_0_time_out_counter[4]_i_4__5 ;
  wire \n_0_time_out_counter[4]_i_5__5 ;
  wire \n_0_time_out_counter[8]_i_2__5 ;
  wire \n_0_time_out_counter[8]_i_3__5 ;
  wire \n_0_time_out_counter[8]_i_4__5 ;
  wire \n_0_time_out_counter[8]_i_5__5 ;
  wire \n_0_time_out_counter_reg[0]_i_2__5 ;
  wire \n_0_time_out_counter_reg[12]_i_1__5 ;
  wire \n_0_time_out_counter_reg[4]_i_1__5 ;
  wire \n_0_time_out_counter_reg[8]_i_1__5 ;
  wire n_0_time_out_wait_bypass_i_1__5;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_10__1;
  wire n_0_time_tlock_max_i_11__2;
  wire n_0_time_tlock_max_i_12__1;
  wire n_0_time_tlock_max_i_13__1;
  wire n_0_time_tlock_max_i_14__1;
  wire n_0_time_tlock_max_i_15__1;
  wire n_0_time_tlock_max_i_16__1;
  wire n_0_time_tlock_max_i_17__1;
  wire n_0_time_tlock_max_i_18__1;
  wire n_0_time_tlock_max_i_19__1;
  wire n_0_time_tlock_max_i_1__5;
  wire n_0_time_tlock_max_i_20__1;
  wire n_0_time_tlock_max_i_4__1;
  wire n_0_time_tlock_max_i_5__1;
  wire n_0_time_tlock_max_i_6__1;
  wire n_0_time_tlock_max_i_8__1;
  wire n_0_time_tlock_max_i_9__1;
  wire n_0_time_tlock_max_reg_i_3__1;
  wire n_0_time_tlock_max_reg_i_7__1;
  wire \n_0_wait_bypass_count[0]_i_1__5 ;
  wire \n_0_wait_bypass_count[0]_i_2__5 ;
  wire \n_0_wait_bypass_count[0]_i_4__5 ;
  wire \n_0_wait_bypass_count[0]_i_5__5 ;
  wire \n_0_wait_bypass_count[0]_i_6__5 ;
  wire \n_0_wait_bypass_count[0]_i_7__5 ;
  wire \n_0_wait_bypass_count[0]_i_8__5 ;
  wire \n_0_wait_bypass_count[0]_i_9__1 ;
  wire \n_0_wait_bypass_count[12]_i_2__5 ;
  wire \n_0_wait_bypass_count[4]_i_2__5 ;
  wire \n_0_wait_bypass_count[4]_i_3__5 ;
  wire \n_0_wait_bypass_count[4]_i_4__5 ;
  wire \n_0_wait_bypass_count[4]_i_5__5 ;
  wire \n_0_wait_bypass_count[8]_i_2__5 ;
  wire \n_0_wait_bypass_count[8]_i_3__5 ;
  wire \n_0_wait_bypass_count[8]_i_4__5 ;
  wire \n_0_wait_bypass_count[8]_i_5__5 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3__5 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1__5 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1__5 ;
  wire \n_0_wait_time_cnt[1]_i_1__5 ;
  wire \n_0_wait_time_cnt[4]_i_1__5 ;
  wire \n_0_wait_time_cnt[6]_i_1__5 ;
  wire \n_0_wait_time_cnt[6]_i_2__5 ;
  wire \n_0_wait_time_cnt[6]_i_4__5 ;
  wire n_1_sync_QPLLLOCK;
  wire n_1_sync_data_valid;
  wire n_1_sync_mmcm_lock_reclocked;
  wire n_1_sync_rxpmaresetdone;
  wire \n_1_time_out_counter_reg[0]_i_2__5 ;
  wire \n_1_time_out_counter_reg[12]_i_1__5 ;
  wire \n_1_time_out_counter_reg[4]_i_1__5 ;
  wire \n_1_time_out_counter_reg[8]_i_1__5 ;
  wire n_1_time_tlock_max_reg_i_3__1;
  wire n_1_time_tlock_max_reg_i_7__1;
  wire \n_1_wait_bypass_count_reg[0]_i_3__5 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1__5 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1__5 ;
  wire n_2_sync_data_valid;
  wire \n_2_time_out_counter_reg[0]_i_2__5 ;
  wire \n_2_time_out_counter_reg[12]_i_1__5 ;
  wire \n_2_time_out_counter_reg[16]_i_1__5 ;
  wire \n_2_time_out_counter_reg[4]_i_1__5 ;
  wire \n_2_time_out_counter_reg[8]_i_1__5 ;
  wire n_2_time_tlock_max_reg_i_3__1;
  wire n_2_time_tlock_max_reg_i_7__1;
  wire \n_2_wait_bypass_count_reg[0]_i_3__5 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1__5 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1__5 ;
  wire n_3_sync_data_valid;
  wire \n_3_time_out_counter_reg[0]_i_2__5 ;
  wire \n_3_time_out_counter_reg[12]_i_1__5 ;
  wire \n_3_time_out_counter_reg[16]_i_1__5 ;
  wire \n_3_time_out_counter_reg[4]_i_1__5 ;
  wire \n_3_time_out_counter_reg[8]_i_1__5 ;
  wire n_3_time_tlock_max_reg_i_2__1;
  wire n_3_time_tlock_max_reg_i_3__1;
  wire n_3_time_tlock_max_reg_i_7__1;
  wire \n_3_wait_bypass_count_reg[0]_i_3__5 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1__5 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1__5 ;
  wire n_4_sync_data_valid;
  wire \n_4_time_out_counter_reg[0]_i_2__5 ;
  wire \n_4_time_out_counter_reg[12]_i_1__5 ;
  wire \n_4_time_out_counter_reg[4]_i_1__5 ;
  wire \n_4_time_out_counter_reg[8]_i_1__5 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3__5 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1__5 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1__5 ;
  wire n_5_sync_data_valid;
  wire \n_5_time_out_counter_reg[0]_i_2__5 ;
  wire \n_5_time_out_counter_reg[12]_i_1__5 ;
  wire \n_5_time_out_counter_reg[16]_i_1__5 ;
  wire \n_5_time_out_counter_reg[4]_i_1__5 ;
  wire \n_5_time_out_counter_reg[8]_i_1__5 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3__5 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1__5 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1__5 ;
  wire \n_6_time_out_counter_reg[0]_i_2__5 ;
  wire \n_6_time_out_counter_reg[12]_i_1__5 ;
  wire \n_6_time_out_counter_reg[16]_i_1__5 ;
  wire \n_6_time_out_counter_reg[4]_i_1__5 ;
  wire \n_6_time_out_counter_reg[8]_i_1__5 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3__5 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1__5 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1__5 ;
  wire \n_7_time_out_counter_reg[0]_i_2__5 ;
  wire \n_7_time_out_counter_reg[12]_i_1__5 ;
  wire \n_7_time_out_counter_reg[16]_i_1__5 ;
  wire \n_7_time_out_counter_reg[4]_i_1__5 ;
  wire \n_7_time_out_counter_reg[8]_i_1__5 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3__5 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1__5 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1__5 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1__5 ;
  wire [6:0]p_0_in__11;
  wire [7:0]p_0_in__12;
  wire run_phase_alignment_int_s2;
  wire rx_fsm_reset_done_int_s2;
(* RTL_KEEP = "yes" *)   wire [3:0]rx_state;
  wire rx_state16_out;
  wire rxpmaresetdone_i;
  wire rxresetdone_s2;
  wire rxresetdone_s3;
  wire [18:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire time_tlock_max1;
  wire [12:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0__5;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__5_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__5_O_UNCONNECTED ;
  wire [3:2]NLW_time_tlock_max_reg_i_2__1_CO_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_2__1_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_3__1_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_7__1_O_UNCONNECTED;
  wire [3:0]\NLW_wait_bypass_count_reg[12]_i_1__5_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[12]_i_1__5_O_UNCONNECTED ;

LUT6 #(
    .INIT(64'h4E0AEE2A4E0ACE0A)) 
     \FSM_sequential_rx_state[0]_i_2__1 
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .I3(n_0_time_out_2ms_reg),
        .I4(n_0_reset_time_out_reg),
        .I5(time_tlock_max),
        .O(\n_0_FSM_sequential_rx_state[0]_i_2__1 ));
LUT6 #(
    .INIT(64'h1111004015150040)) 
     \FSM_sequential_rx_state[2]_i_1__1 
       (.I0(rx_state[3]),
        .I1(rx_state[0]),
        .I2(rx_state[1]),
        .I3(n_0_time_out_2ms_reg),
        .I4(rx_state[2]),
        .I5(rx_state16_out),
        .O(\n_0_FSM_sequential_rx_state[2]_i_1__1 ));
(* SOFT_HLUTNM = "soft_lutpair54" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_rx_state[2]_i_2__1 
       (.I0(time_tlock_max),
        .I1(n_0_reset_time_out_reg),
        .O(rx_state16_out));
LUT6 #(
    .INIT(64'h0F0F0F0F4F404040)) 
     \FSM_sequential_rx_state[3]_i_4__1 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_FSM_sequential_rx_state[3]_i_8__1 ),
        .I2(rx_state[1]),
        .I3(I1),
        .I4(rx_state[2]),
        .I5(rx_state[3]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_4__1 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_sequential_rx_state[3]_i_8__1 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[3]),
        .I4(wait_time_cnt_reg__0[0]),
        .I5(wait_time_cnt_reg__0[1]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_8__1 ));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_3_sync_data_valid),
        .Q(rx_state[0]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_2_sync_data_valid),
        .Q(rx_state[1]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(\n_0_FSM_sequential_rx_state[2]_i_1__1 ),
        .Q(rx_state[2]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_1_sync_data_valid),
        .Q(rx_state[3]),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD2000)) 
     RXUSERRDY_i_1__1
       (.I0(rx_state[0]),
        .I1(rx_state[3]),
        .I2(rx_state[2]),
        .I3(rx_state[1]),
        .I4(O1),
        .O(n_0_RXUSERRDY_i_1__1));
FDRE #(
    .INIT(1'b0)) 
     RXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_RXUSERRDY_i_1__1),
        .Q(O1),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0008)) 
     check_tlock_max_i_1__1
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(rx_state[3]),
        .I3(rx_state[1]),
        .I4(n_0_check_tlock_max_reg),
        .O(n_0_check_tlock_max_i_1__1));
FDRE #(
    .INIT(1'b0)) 
     check_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_check_tlock_max_i_1__1),
        .Q(n_0_check_tlock_max_reg),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD0004)) 
     gtrxreset_i_i_1__1
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(rx_state[3]),
        .I3(rx_state[1]),
        .I4(SR),
        .O(n_0_gtrxreset_i_i_1__1));
FDRE #(
    .INIT(1'b0)) 
     gtrxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gtrxreset_i_i_1__1),
        .Q(SR),
        .R(SOFT_RESET_IN));
(* SOFT_HLUTNM = "soft_lutpair58" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1__5 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in__11[0]));
(* SOFT_HLUTNM = "soft_lutpair58" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1__5 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in__11[1]));
(* SOFT_HLUTNM = "soft_lutpair52" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[2]_i_1__5 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .O(p_0_in__11[2]));
(* SOFT_HLUTNM = "soft_lutpair52" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \init_wait_count[3]_i_1__5 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .O(p_0_in__11[3]));
(* SOFT_HLUTNM = "soft_lutpair50" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \init_wait_count[4]_i_1__5 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .O(p_0_in__11[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \init_wait_count[5]_i_1__5 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .I5(init_wait_count_reg__0[4]),
        .O(p_0_in__11[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
     \init_wait_count[6]_i_1__5 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[0]),
        .I3(\n_0_init_wait_count[6]_i_3__5 ),
        .I4(init_wait_count_reg__0[4]),
        .I5(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_1__5 ));
LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[6]_i_2__5 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\n_0_init_wait_count[6]_i_4__5 ),
        .I2(init_wait_count_reg__0[5]),
        .O(p_0_in__11[6]));
LUT2 #(
    .INIT(4'h7)) 
     \init_wait_count[6]_i_3__5 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_3__5 ));
(* SOFT_HLUTNM = "soft_lutpair50" *) 
   LUT5 #(
    .INIT(32'h80000000)) 
     \init_wait_count[6]_i_4__5 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_4__5 ));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__5 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__11[0]),
        .Q(init_wait_count_reg__0[0]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__5 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__11[1]),
        .Q(init_wait_count_reg__0[1]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__5 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__11[2]),
        .Q(init_wait_count_reg__0[2]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__5 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__11[3]),
        .Q(init_wait_count_reg__0[3]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__5 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__11[4]),
        .Q(init_wait_count_reg__0[4]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__5 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__11[5]),
        .Q(init_wait_count_reg__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__5 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__11[6]),
        .Q(init_wait_count_reg__0[6]));
LUT2 #(
    .INIT(4'hE)) 
     init_wait_done_i_1__5
       (.I0(init_wait_done),
        .I1(n_0_init_wait_done_reg),
        .O(n_0_init_wait_done_i_1__5));
LUT6 #(
    .INIT(64'h0000000004000000)) 
     init_wait_done_i_2__5
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[4]),
        .I2(\n_0_init_wait_count[6]_i_3__5 ),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_done));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(n_0_init_wait_done_i_1__5),
        .Q(n_0_init_wait_done_reg));
(* SOFT_HLUTNM = "soft_lutpair57" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__12[0]));
(* SOFT_HLUTNM = "soft_lutpair57" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__12[1]));
(* SOFT_HLUTNM = "soft_lutpair55" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[2]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__12[2]));
(* SOFT_HLUTNM = "soft_lutpair51" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \mmcm_lock_count[3]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__12[3]));
(* SOFT_HLUTNM = "soft_lutpair51" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \mmcm_lock_count[4]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[3]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__12[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[5]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__12[5]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[6]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(\n_0_mmcm_lock_count[6]_i_2__5 ),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__12[6]));
(* SOFT_HLUTNM = "soft_lutpair55" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \mmcm_lock_count[6]_i_2__5 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(\n_0_mmcm_lock_count[6]_i_2__5 ));
LUT3 #(
    .INIT(8'h7F)) 
     \mmcm_lock_count[7]_i_2__5 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__5 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(\n_0_mmcm_lock_count[7]_i_2__5 ));
LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[7]_i_3__5 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__5 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__12[7]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \mmcm_lock_count[7]_i_4__5 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(\n_0_mmcm_lock_count[7]_i_4__5 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__5 ),
        .D(p_0_in__12[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__5 ),
        .D(p_0_in__12[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__5 ),
        .D(p_0_in__12[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__5 ),
        .D(p_0_in__12[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__5 ),
        .D(p_0_in__12[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__5 ),
        .D(p_0_in__12[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__5 ),
        .D(p_0_in__12[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__5 ),
        .D(p_0_in__12[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
FDRE #(
    .INIT(1'b1)) 
     mmcm_reset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_rxpmaresetdone),
        .Q(GT2_RX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync1_rx
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(1'b0),
        .PRE(SR),
        .Q(D));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync2_rx
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(D),
        .PRE(SR),
        .Q(Q));
FDSE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_QPLLLOCK),
        .Q(n_0_reset_time_out_reg),
        .S(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0002)) 
     run_phase_alignment_int_i_1__5
       (.I0(rx_state[3]),
        .I1(rx_state[0]),
        .I2(rx_state[2]),
        .I3(rx_state[1]),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1__5));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1__5),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(run_phase_alignment_int_s2),
        .Q(n_0_run_phase_alignment_int_s3_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_data_valid),
        .Q(GT2_RX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_s3_reg
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(rx_fsm_reset_done_int_s2),
        .Q(n_0_rx_fsm_reset_done_int_s3_reg),
        .R(1'b0));
FDCE #(
    .INIT(1'b0)) 
     rxpmaresetdone_i_reg
       (.C(RXOUTCLK),
        .CE(1'b1),
        .CLR(Q),
        .D(n_0_sync_rxpmaresetdone_rx_s),
        .Q(rxpmaresetdone_i));
FDRE #(
    .INIT(1'b0)) 
     rxresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(rxresetdone_s2),
        .Q(rxresetdone_s3),
        .R(1'b0));
XLAUI_XLAUI_sync_block__parameterized0_26 sync_QPLLLOCK
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .I1(n_5_sync_data_valid),
        .I2(n_1_sync_rxpmaresetdone),
        .I3(n_0_reset_time_out_reg),
        .I4(n_0_time_out_2ms_reg),
        .O1(n_0_sync_QPLLLOCK),
        .O2(n_1_sync_QPLLLOCK),
        .SYSCLK_IN(SYSCLK_IN),
        .out(rx_state[3:1]),
        .rxresetdone_s3(rxresetdone_s3));
XLAUI_XLAUI_sync_block__parameterized0_27 sync_RXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(rxresetdone_s2),
        .gt2_rxresetdone_out(gt2_rxresetdone_out));
XLAUI_XLAUI_sync_block__parameterized0_28 sync_data_valid
       (.D({n_1_sync_data_valid,n_2_sync_data_valid,n_3_sync_data_valid}),
        .DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .E(n_4_sync_data_valid),
        .GT2_DATA_VALID_IN(GT2_DATA_VALID_IN),
        .GT2_RX_FSM_RESET_DONE_OUT(GT2_RX_FSM_RESET_DONE_OUT),
        .I1(n_0_reset_time_out_reg),
        .I2(n_0_time_out_500us_reg),
        .I3(n_0_time_out_1us_reg),
        .I4(\n_0_FSM_sequential_rx_state[0]_i_2__1 ),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_4__1 ),
        .I6(n_1_sync_QPLLLOCK),
        .I7(n_0_init_wait_done_reg),
        .I8(I1),
        .I9(n_0_time_out_2ms_reg),
        .O1(n_0_sync_data_valid),
        .O2(n_5_sync_data_valid),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state),
        .rx_state16_out(rx_state16_out),
        .rxresetdone_s3(rxresetdone_s3),
        .time_out_wait_bypass_s3(time_out_wait_bypass_s3));
XLAUI_XLAUI_sync_block__parameterized0_29 sync_mmcm_lock_reclocked
       (.GT2_RX_MMCM_LOCK_IN(GT2_RX_MMCM_LOCK_IN),
        .I1(\n_0_mmcm_lock_count[7]_i_4__5 ),
        .O1(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(n_0_sync_mmcm_lock_reclocked),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked));
XLAUI_XLAUI_sync_block__parameterized0_30 sync_run_phase_alignment_int
       (.data_in(n_0_run_phase_alignment_int_reg),
        .data_out(run_phase_alignment_int_s2),
        .gt2_rxusrclk_in(gt2_rxusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_31 sync_rx_fsm_reset_done_int
       (.GT2_RX_FSM_RESET_DONE_OUT(GT2_RX_FSM_RESET_DONE_OUT),
        .data_out(rx_fsm_reset_done_int_s2),
        .gt2_rxusrclk_in(gt2_rxusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_32 sync_rxpmaresetdone
       (.GT2_RX_MMCM_RESET_OUT(GT2_RX_MMCM_RESET_OUT),
        .I1(I1),
        .O1(n_0_sync_rxpmaresetdone),
        .O2(n_1_sync_rxpmaresetdone),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(rxpmaresetdone_i),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state));
XLAUI_XLAUI_sync_block__parameterized0_33 sync_rxpmaresetdone_rx_s
       (.RXOUTCLK(RXOUTCLK),
        .data_in(data_in),
        .data_out(n_0_sync_rxpmaresetdone_rx_s));
XLAUI_XLAUI_sync_block__parameterized0_34 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
LUT6 #(
    .INIT(64'hFFFFFFFF00100000)) 
     time_out_1us_i_1__1
       (.I0(time_out_counter_reg[18]),
        .I1(time_out_counter_reg[4]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[17]),
        .I4(n_0_time_out_1us_i_2__2),
        .I5(n_0_time_out_1us_reg),
        .O(n_0_time_out_1us_i_1__1));
LUT6 #(
    .INIT(64'h0001000000000000)) 
     time_out_1us_i_2__2
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[12]),
        .I3(time_out_counter_reg[13]),
        .I4(n_0_time_out_1us_i_3__1),
        .I5(n_0_time_out_1us_i_4__1),
        .O(n_0_time_out_1us_i_2__2));
LUT6 #(
    .INIT(64'h0000000000100000)) 
     time_out_1us_i_3__1
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .I4(time_out_counter_reg[1]),
        .I5(time_out_counter_reg[15]),
        .O(n_0_time_out_1us_i_3__1));
LUT5 #(
    .INIT(32'h00000010)) 
     time_out_1us_i_4__1
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[16]),
        .I4(time_out_counter_reg[0]),
        .O(n_0_time_out_1us_i_4__1));
FDRE #(
    .INIT(1'b0)) 
     time_out_1us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_1us_i_1__1),
        .Q(n_0_time_out_1us_reg),
        .R(n_0_reset_time_out_reg));
LUT5 #(
    .INIT(32'hAAAAAAAB)) 
     time_out_2ms_i_1__5
       (.I0(n_0_time_out_2ms_reg),
        .I1(n_0_time_out_2ms_i_2__1),
        .I2(n_0_time_out_2ms_i_3__1),
        .I3(n_0_time_out_2ms_i_4__1),
        .I4(\n_0_time_out_counter[0]_i_3__1 ),
        .O(n_0_time_out_2ms_i_1__5));
(* SOFT_HLUTNM = "soft_lutpair49" *) 
   LUT5 #(
    .INIT(32'hFEFFFFFF)) 
     time_out_2ms_i_2__1
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[9]),
        .I4(time_out_counter_reg[12]),
        .O(n_0_time_out_2ms_i_2__1));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFDFF)) 
     time_out_2ms_i_3__1
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[18]),
        .I4(time_out_counter_reg[8]),
        .I5(time_out_counter_reg[17]),
        .O(n_0_time_out_2ms_i_3__1));
LUT4 #(
    .INIT(16'h7FFF)) 
     time_out_2ms_i_4__1
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[2]),
        .O(n_0_time_out_2ms_i_4__1));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1__5),
        .Q(n_0_time_out_2ms_reg),
        .R(n_0_reset_time_out_reg));
LUT5 #(
    .INIT(32'hFFFF1000)) 
     time_out_500us_i_1__1
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[18]),
        .I2(n_0_time_out_500us_i_2__2),
        .I3(n_0_time_out_500us_i_3__2),
        .I4(n_0_time_out_500us_reg),
        .O(n_0_time_out_500us_i_1__1));
LUT4 #(
    .INIT(16'h0020)) 
     time_out_500us_i_2__2
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[17]),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[9]),
        .O(n_0_time_out_500us_i_2__2));
LUT6 #(
    .INIT(64'h0000000000040000)) 
     time_out_500us_i_3__2
       (.I0(n_0_time_out_2ms_i_4__1),
        .I1(n_0_time_out_500us_i_4__1),
        .I2(\n_0_time_out_counter[0]_i_3__1 ),
        .I3(time_out_counter_reg[11]),
        .I4(time_out_counter_reg[14]),
        .I5(time_out_counter_reg[3]),
        .O(n_0_time_out_500us_i_3__2));
(* SOFT_HLUTNM = "soft_lutpair49" *) 
   LUT2 #(
    .INIT(4'h1)) 
     time_out_500us_i_4__1
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_out_500us_i_4__1));
FDRE #(
    .INIT(1'b0)) 
     time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_500us_i_1__1),
        .Q(n_0_time_out_500us_reg),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFFFFFFFFBFFFFFFF)) 
     \time_out_counter[0]_i_1__5 
       (.I0(\n_0_time_out_counter[0]_i_3__1 ),
        .I1(time_out_counter_reg[16]),
        .I2(time_out_counter_reg[0]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[2]),
        .I5(\n_0_time_out_counter[0]_i_4__1 ),
        .O(\n_0_time_out_counter[0]_i_1__5 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \time_out_counter[0]_i_3__1 
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[0]_i_3__1 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFF7)) 
     \time_out_counter[0]_i_4__1 
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[3]),
        .I4(time_out_counter_reg[14]),
        .I5(n_0_time_out_2ms_i_3__1),
        .O(\n_0_time_out_counter[0]_i_4__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_5__5 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_5__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6__5 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_6__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_7__5 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_7__5 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_8__1 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_8__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2__5 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3__5 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4__5 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5__5 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2__5 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_2__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3__5 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_3__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4__5 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_4__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2__5 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3__5 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4__5 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5__5 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2__5 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3__5 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4__5 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5__5 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5__5 ));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_7_time_out_counter_reg[0]_i_2__5 ),
        .Q(time_out_counter_reg[0]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[0]_i_2__5 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2__5 ,\n_1_time_out_counter_reg[0]_i_2__5 ,\n_2_time_out_counter_reg[0]_i_2__5 ,\n_3_time_out_counter_reg[0]_i_2__5 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2__5 ,\n_5_time_out_counter_reg[0]_i_2__5 ,\n_6_time_out_counter_reg[0]_i_2__5 ,\n_7_time_out_counter_reg[0]_i_2__5 }),
        .S({\n_0_time_out_counter[0]_i_5__5 ,\n_0_time_out_counter[0]_i_6__5 ,\n_0_time_out_counter[0]_i_7__5 ,\n_0_time_out_counter[0]_i_8__1 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_5_time_out_counter_reg[8]_i_1__5 ),
        .Q(time_out_counter_reg[10]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_4_time_out_counter_reg[8]_i_1__5 ),
        .Q(time_out_counter_reg[11]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_7_time_out_counter_reg[12]_i_1__5 ),
        .Q(time_out_counter_reg[12]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[12]_i_1__5 
       (.CI(\n_0_time_out_counter_reg[8]_i_1__5 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1__5 ,\n_1_time_out_counter_reg[12]_i_1__5 ,\n_2_time_out_counter_reg[12]_i_1__5 ,\n_3_time_out_counter_reg[12]_i_1__5 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1__5 ,\n_5_time_out_counter_reg[12]_i_1__5 ,\n_6_time_out_counter_reg[12]_i_1__5 ,\n_7_time_out_counter_reg[12]_i_1__5 }),
        .S({\n_0_time_out_counter[12]_i_2__5 ,\n_0_time_out_counter[12]_i_3__5 ,\n_0_time_out_counter[12]_i_4__5 ,\n_0_time_out_counter[12]_i_5__5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_6_time_out_counter_reg[12]_i_1__5 ),
        .Q(time_out_counter_reg[13]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_5_time_out_counter_reg[12]_i_1__5 ),
        .Q(time_out_counter_reg[14]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_4_time_out_counter_reg[12]_i_1__5 ),
        .Q(time_out_counter_reg[15]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_7_time_out_counter_reg[16]_i_1__5 ),
        .Q(time_out_counter_reg[16]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[16]_i_1__5 
       (.CI(\n_0_time_out_counter_reg[12]_i_1__5 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__5_CO_UNCONNECTED [3:2],\n_2_time_out_counter_reg[16]_i_1__5 ,\n_3_time_out_counter_reg[16]_i_1__5 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__5_O_UNCONNECTED [3],\n_5_time_out_counter_reg[16]_i_1__5 ,\n_6_time_out_counter_reg[16]_i_1__5 ,\n_7_time_out_counter_reg[16]_i_1__5 }),
        .S({1'b0,\n_0_time_out_counter[16]_i_2__5 ,\n_0_time_out_counter[16]_i_3__5 ,\n_0_time_out_counter[16]_i_4__5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_6_time_out_counter_reg[16]_i_1__5 ),
        .Q(time_out_counter_reg[17]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_5_time_out_counter_reg[16]_i_1__5 ),
        .Q(time_out_counter_reg[18]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_6_time_out_counter_reg[0]_i_2__5 ),
        .Q(time_out_counter_reg[1]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_5_time_out_counter_reg[0]_i_2__5 ),
        .Q(time_out_counter_reg[2]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_4_time_out_counter_reg[0]_i_2__5 ),
        .Q(time_out_counter_reg[3]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_7_time_out_counter_reg[4]_i_1__5 ),
        .Q(time_out_counter_reg[4]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[4]_i_1__5 
       (.CI(\n_0_time_out_counter_reg[0]_i_2__5 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1__5 ,\n_1_time_out_counter_reg[4]_i_1__5 ,\n_2_time_out_counter_reg[4]_i_1__5 ,\n_3_time_out_counter_reg[4]_i_1__5 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1__5 ,\n_5_time_out_counter_reg[4]_i_1__5 ,\n_6_time_out_counter_reg[4]_i_1__5 ,\n_7_time_out_counter_reg[4]_i_1__5 }),
        .S({\n_0_time_out_counter[4]_i_2__5 ,\n_0_time_out_counter[4]_i_3__5 ,\n_0_time_out_counter[4]_i_4__5 ,\n_0_time_out_counter[4]_i_5__5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_6_time_out_counter_reg[4]_i_1__5 ),
        .Q(time_out_counter_reg[5]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_5_time_out_counter_reg[4]_i_1__5 ),
        .Q(time_out_counter_reg[6]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_4_time_out_counter_reg[4]_i_1__5 ),
        .Q(time_out_counter_reg[7]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_7_time_out_counter_reg[8]_i_1__5 ),
        .Q(time_out_counter_reg[8]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[8]_i_1__5 
       (.CI(\n_0_time_out_counter_reg[4]_i_1__5 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1__5 ,\n_1_time_out_counter_reg[8]_i_1__5 ,\n_2_time_out_counter_reg[8]_i_1__5 ,\n_3_time_out_counter_reg[8]_i_1__5 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1__5 ,\n_5_time_out_counter_reg[8]_i_1__5 ,\n_6_time_out_counter_reg[8]_i_1__5 ,\n_7_time_out_counter_reg[8]_i_1__5 }),
        .S({\n_0_time_out_counter[8]_i_2__5 ,\n_0_time_out_counter[8]_i_3__5 ,\n_0_time_out_counter[8]_i_4__5 ,\n_0_time_out_counter[8]_i_5__5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__5 ),
        .D(\n_6_time_out_counter_reg[8]_i_1__5 ),
        .Q(time_out_counter_reg[9]),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1__5
       (.I0(\n_0_wait_bypass_count[0]_i_4__5 ),
        .I1(wait_bypass_count_reg[3]),
        .I2(\n_0_wait_bypass_count[0]_i_5__5 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(n_0_rx_fsm_reset_done_int_s3_reg),
        .I5(n_0_run_phase_alignment_int_s3_reg),
        .O(n_0_time_out_wait_bypass_i_1__5));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1__5),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_10__1
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[15]),
        .O(n_0_time_tlock_max_i_10__1));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_11__2
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_tlock_max_i_11__2));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_12__1
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[10]),
        .O(n_0_time_tlock_max_i_12__1));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_13__1
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .O(n_0_time_tlock_max_i_13__1));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_14__1
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[6]),
        .O(n_0_time_tlock_max_i_14__1));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_15__1
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_15__1));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_16__1
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(n_0_time_tlock_max_i_16__1));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_17__1
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(n_0_time_tlock_max_i_17__1));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_18__1
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[5]),
        .O(n_0_time_tlock_max_i_18__1));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_19__1
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_19__1));
(* SOFT_HLUTNM = "soft_lutpair54" *) 
   LUT3 #(
    .INIT(8'hF8)) 
     time_tlock_max_i_1__5
       (.I0(n_0_check_tlock_max_reg),
        .I1(time_tlock_max1),
        .I2(time_tlock_max),
        .O(n_0_time_tlock_max_i_1__5));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_20__1
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(n_0_time_tlock_max_i_20__1));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_4__1
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[16]),
        .O(n_0_time_tlock_max_i_4__1));
LUT1 #(
    .INIT(2'h1)) 
     time_tlock_max_i_5__1
       (.I0(time_out_counter_reg[18]),
        .O(n_0_time_tlock_max_i_5__1));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_6__1
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(n_0_time_tlock_max_i_6__1));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_8__1
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .O(n_0_time_tlock_max_i_8__1));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_9__1
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(n_0_time_tlock_max_i_9__1));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1__5),
        .Q(time_tlock_max),
        .R(n_0_reset_time_out_reg));
CARRY4 time_tlock_max_reg_i_2__1
       (.CI(n_0_time_tlock_max_reg_i_3__1),
        .CO({NLW_time_tlock_max_reg_i_2__1_CO_UNCONNECTED[3:2],time_tlock_max1,n_3_time_tlock_max_reg_i_2__1}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,time_out_counter_reg[18],n_0_time_tlock_max_i_4__1}),
        .O(NLW_time_tlock_max_reg_i_2__1_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,n_0_time_tlock_max_i_5__1,n_0_time_tlock_max_i_6__1}));
CARRY4 time_tlock_max_reg_i_3__1
       (.CI(n_0_time_tlock_max_reg_i_7__1),
        .CO({n_0_time_tlock_max_reg_i_3__1,n_1_time_tlock_max_reg_i_3__1,n_2_time_tlock_max_reg_i_3__1,n_3_time_tlock_max_reg_i_3__1}),
        .CYINIT(1'b0),
        .DI({time_out_counter_reg[15],n_0_time_tlock_max_i_8__1,n_0_time_tlock_max_i_9__1,time_out_counter_reg[9]}),
        .O(NLW_time_tlock_max_reg_i_3__1_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_10__1,n_0_time_tlock_max_i_11__2,n_0_time_tlock_max_i_12__1,n_0_time_tlock_max_i_13__1}));
CARRY4 time_tlock_max_reg_i_7__1
       (.CI(1'b0),
        .CO({n_0_time_tlock_max_reg_i_7__1,n_1_time_tlock_max_reg_i_7__1,n_2_time_tlock_max_reg_i_7__1,n_3_time_tlock_max_reg_i_7__1}),
        .CYINIT(1'b0),
        .DI({n_0_time_tlock_max_i_14__1,time_out_counter_reg[5],n_0_time_tlock_max_i_15__1,n_0_time_tlock_max_i_16__1}),
        .O(NLW_time_tlock_max_reg_i_7__1_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_17__1,n_0_time_tlock_max_i_18__1,n_0_time_tlock_max_i_19__1,n_0_time_tlock_max_i_20__1}));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1__5 
       (.I0(n_0_run_phase_alignment_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_1__5 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2__5 
       (.I0(\n_0_wait_bypass_count[0]_i_4__5 ),
        .I1(wait_bypass_count_reg[3]),
        .I2(\n_0_wait_bypass_count[0]_i_5__5 ),
        .I3(n_0_rx_fsm_reset_done_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_2__5 ));
LUT6 #(
    .INIT(64'hFFFFEFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_4__5 
       (.I0(wait_bypass_count_reg[11]),
        .I1(wait_bypass_count_reg[4]),
        .I2(wait_bypass_count_reg[0]),
        .I3(wait_bypass_count_reg[9]),
        .I4(wait_bypass_count_reg[10]),
        .I5(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_4__5 ));
LUT6 #(
    .INIT(64'hFDFFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_5__5 
       (.I0(wait_bypass_count_reg[1]),
        .I1(wait_bypass_count_reg[6]),
        .I2(wait_bypass_count_reg[5]),
        .I3(wait_bypass_count_reg[12]),
        .I4(wait_bypass_count_reg[8]),
        .I5(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[0]_i_5__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_6__5 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_6__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7__5 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_7__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8__5 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_8__5 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_9__1 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_9__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2__5 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_2__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2__5 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3__5 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4__5 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5__5 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2__5 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3__5 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4__5 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5__5 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5__5 ));
FDRE \wait_bypass_count_reg[0] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3__5 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
CARRY4 \wait_bypass_count_reg[0]_i_3__5 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3__5 ,\n_1_wait_bypass_count_reg[0]_i_3__5 ,\n_2_wait_bypass_count_reg[0]_i_3__5 ,\n_3_wait_bypass_count_reg[0]_i_3__5 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3__5 ,\n_5_wait_bypass_count_reg[0]_i_3__5 ,\n_6_wait_bypass_count_reg[0]_i_3__5 ,\n_7_wait_bypass_count_reg[0]_i_3__5 }),
        .S({\n_0_wait_bypass_count[0]_i_6__5 ,\n_0_wait_bypass_count[0]_i_7__5 ,\n_0_wait_bypass_count[0]_i_8__5 ,\n_0_wait_bypass_count[0]_i_9__1 }));
FDRE \wait_bypass_count_reg[10] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1__5 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
FDRE \wait_bypass_count_reg[11] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1__5 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
FDRE \wait_bypass_count_reg[12] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1__5 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
CARRY4 \wait_bypass_count_reg[12]_i_1__5 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1__5 ),
        .CO(\NLW_wait_bypass_count_reg[12]_i_1__5_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[12]_i_1__5_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[12]_i_1__5 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[12]_i_2__5 }));
FDRE \wait_bypass_count_reg[1] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3__5 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
FDRE \wait_bypass_count_reg[2] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3__5 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
FDRE \wait_bypass_count_reg[3] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3__5 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
FDRE \wait_bypass_count_reg[4] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1__5 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
CARRY4 \wait_bypass_count_reg[4]_i_1__5 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3__5 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1__5 ,\n_1_wait_bypass_count_reg[4]_i_1__5 ,\n_2_wait_bypass_count_reg[4]_i_1__5 ,\n_3_wait_bypass_count_reg[4]_i_1__5 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1__5 ,\n_5_wait_bypass_count_reg[4]_i_1__5 ,\n_6_wait_bypass_count_reg[4]_i_1__5 ,\n_7_wait_bypass_count_reg[4]_i_1__5 }),
        .S({\n_0_wait_bypass_count[4]_i_2__5 ,\n_0_wait_bypass_count[4]_i_3__5 ,\n_0_wait_bypass_count[4]_i_4__5 ,\n_0_wait_bypass_count[4]_i_5__5 }));
FDRE \wait_bypass_count_reg[5] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1__5 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
FDRE \wait_bypass_count_reg[6] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1__5 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
FDRE \wait_bypass_count_reg[7] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1__5 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
FDRE \wait_bypass_count_reg[8] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1__5 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
CARRY4 \wait_bypass_count_reg[8]_i_1__5 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1__5 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1__5 ,\n_1_wait_bypass_count_reg[8]_i_1__5 ,\n_2_wait_bypass_count_reg[8]_i_1__5 ,\n_3_wait_bypass_count_reg[8]_i_1__5 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1__5 ,\n_5_wait_bypass_count_reg[8]_i_1__5 ,\n_6_wait_bypass_count_reg[8]_i_1__5 ,\n_7_wait_bypass_count_reg[8]_i_1__5 }),
        .S({\n_0_wait_bypass_count[8]_i_2__5 ,\n_0_wait_bypass_count[8]_i_3__5 ,\n_0_wait_bypass_count[8]_i_4__5 ,\n_0_wait_bypass_count[8]_i_5__5 }));
FDRE \wait_bypass_count_reg[9] 
       (.C(gt2_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__5 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1__5 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1__5 ));
(* SOFT_HLUTNM = "soft_lutpair56" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1__5 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__5[0]));
(* SOFT_HLUTNM = "soft_lutpair56" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1__5 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\n_0_wait_time_cnt[1]_i_1__5 ));
(* SOFT_HLUTNM = "soft_lutpair53" *) 
   LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1__5 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__5[2]));
(* SOFT_HLUTNM = "soft_lutpair48" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \wait_time_cnt[3]_i_1__5 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0__5[3]));
(* SOFT_HLUTNM = "soft_lutpair48" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1__5 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\n_0_wait_time_cnt[4]_i_1__5 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[5]_i_1__5 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[1]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__5[5]));
LUT3 #(
    .INIT(8'h10)) 
     \wait_time_cnt[6]_i_1__5 
       (.I0(rx_state[1]),
        .I1(rx_state[3]),
        .I2(rx_state[0]),
        .O(\n_0_wait_time_cnt[6]_i_1__5 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_2__5 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(wait_time_cnt_reg__0[5]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .I5(\n_0_wait_time_cnt[6]_i_4__5 ),
        .O(\n_0_wait_time_cnt[6]_i_2__5 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[6]_i_3__5 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4__5 ),
        .I2(wait_time_cnt_reg__0[3]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[5]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__5[6]));
(* SOFT_HLUTNM = "soft_lutpair53" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_4__5 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(\n_0_wait_time_cnt[6]_i_4__5 ));
FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__5 ),
        .D(wait_time_cnt0__5[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\n_0_wait_time_cnt[6]_i_1__5 ));
FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__5 ),
        .D(\n_0_wait_time_cnt[1]_i_1__5 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\n_0_wait_time_cnt[6]_i_1__5 ));
FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__5 ),
        .D(wait_time_cnt0__5[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\n_0_wait_time_cnt[6]_i_1__5 ));
FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__5 ),
        .D(wait_time_cnt0__5[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\n_0_wait_time_cnt[6]_i_1__5 ));
FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__5 ),
        .D(\n_0_wait_time_cnt[4]_i_1__5 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\n_0_wait_time_cnt[6]_i_1__5 ));
FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__5 ),
        .D(wait_time_cnt0__5[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\n_0_wait_time_cnt[6]_i_1__5 ));
FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__5 ),
        .D(wait_time_cnt0__5[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\n_0_wait_time_cnt[6]_i_1__5 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_RX_STARTUP_FSM" *) 
module XLAUI_XLAUI_RX_STARTUP_FSM__parameterized0_4
   (SR,
    GT3_RX_MMCM_RESET_OUT,
    GT3_RX_FSM_RESET_DONE_OUT,
    O1,
    RXOUTCLK,
    SYSCLK_IN,
    gt3_rxusrclk_in,
    SOFT_RESET_IN,
    DONT_RESET_ON_DATA_ERROR_IN,
    data_in,
    gt3_rxresetdone_out,
    GT3_RX_MMCM_LOCK_IN,
    GT3_DATA_VALID_IN,
    GT0_QPLLLOCK_IN,
    I1);
  output [0:0]SR;
  output GT3_RX_MMCM_RESET_OUT;
  output GT3_RX_FSM_RESET_DONE_OUT;
  output O1;
  input RXOUTCLK;
  input SYSCLK_IN;
  input gt3_rxusrclk_in;
  input SOFT_RESET_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input data_in;
  input gt3_rxresetdone_out;
  input GT3_RX_MMCM_LOCK_IN;
  input GT3_DATA_VALID_IN;
  input GT0_QPLLLOCK_IN;
  input I1;

  wire D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire GT0_QPLLLOCK_IN;
  wire GT3_DATA_VALID_IN;
  wire GT3_RX_FSM_RESET_DONE_OUT;
  wire GT3_RX_MMCM_LOCK_IN;
  wire GT3_RX_MMCM_RESET_OUT;
  wire I1;
  wire O1;
  wire Q;
  wire RXOUTCLK;
  wire SOFT_RESET_IN;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_in;
  wire gt3_rxresetdone_out;
  wire gt3_rxusrclk_in;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_rx_state[0]_i_2__2 ;
  wire \n_0_FSM_sequential_rx_state[2]_i_1__2 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_4__2 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_8__2 ;
  wire n_0_RXUSERRDY_i_1__2;
  wire n_0_check_tlock_max_i_1__2;
  wire n_0_check_tlock_max_reg;
  wire n_0_gtrxreset_i_i_1__2;
  wire \n_0_init_wait_count[6]_i_1__6 ;
  wire \n_0_init_wait_count[6]_i_3__6 ;
  wire \n_0_init_wait_count[6]_i_4__6 ;
  wire n_0_init_wait_done_i_1__6;
  wire n_0_init_wait_done_reg;
  wire \n_0_mmcm_lock_count[6]_i_2__6 ;
  wire \n_0_mmcm_lock_count[7]_i_2__6 ;
  wire \n_0_mmcm_lock_count[7]_i_4__6 ;
  wire n_0_reset_time_out_reg;
  wire n_0_run_phase_alignment_int_i_1__6;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_run_phase_alignment_int_s3_reg;
  wire n_0_rx_fsm_reset_done_int_s3_reg;
  wire n_0_sync_QPLLLOCK;
  wire n_0_sync_data_valid;
  wire n_0_sync_mmcm_lock_reclocked;
  wire n_0_sync_rxpmaresetdone;
  wire n_0_sync_rxpmaresetdone_rx_s;
  wire n_0_time_out_1us_i_1__2;
  wire n_0_time_out_1us_i_2;
  wire n_0_time_out_1us_i_3__2;
  wire n_0_time_out_1us_i_4__2;
  wire n_0_time_out_1us_reg;
  wire n_0_time_out_2ms_i_1__6;
  wire n_0_time_out_2ms_i_2__2;
  wire n_0_time_out_2ms_i_3__2;
  wire n_0_time_out_2ms_i_4__2;
  wire n_0_time_out_2ms_reg;
  wire n_0_time_out_500us_i_1__2;
  wire n_0_time_out_500us_i_2__3;
  wire n_0_time_out_500us_i_3;
  wire n_0_time_out_500us_i_4__3;
  wire n_0_time_out_500us_reg;
  wire \n_0_time_out_counter[0]_i_1__6 ;
  wire \n_0_time_out_counter[0]_i_3__2 ;
  wire \n_0_time_out_counter[0]_i_4__2 ;
  wire \n_0_time_out_counter[0]_i_5__6 ;
  wire \n_0_time_out_counter[0]_i_6__6 ;
  wire \n_0_time_out_counter[0]_i_7__6 ;
  wire \n_0_time_out_counter[0]_i_8__2 ;
  wire \n_0_time_out_counter[12]_i_2__6 ;
  wire \n_0_time_out_counter[12]_i_3__6 ;
  wire \n_0_time_out_counter[12]_i_4__6 ;
  wire \n_0_time_out_counter[12]_i_5__6 ;
  wire \n_0_time_out_counter[16]_i_2__6 ;
  wire \n_0_time_out_counter[16]_i_3__6 ;
  wire \n_0_time_out_counter[16]_i_4__6 ;
  wire \n_0_time_out_counter[4]_i_2__6 ;
  wire \n_0_time_out_counter[4]_i_3__6 ;
  wire \n_0_time_out_counter[4]_i_4__6 ;
  wire \n_0_time_out_counter[4]_i_5__6 ;
  wire \n_0_time_out_counter[8]_i_2__6 ;
  wire \n_0_time_out_counter[8]_i_3__6 ;
  wire \n_0_time_out_counter[8]_i_4__6 ;
  wire \n_0_time_out_counter[8]_i_5__6 ;
  wire \n_0_time_out_counter_reg[0]_i_2__6 ;
  wire \n_0_time_out_counter_reg[12]_i_1__6 ;
  wire \n_0_time_out_counter_reg[4]_i_1__6 ;
  wire \n_0_time_out_counter_reg[8]_i_1__6 ;
  wire n_0_time_out_wait_bypass_i_1__6;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_10__2;
  wire n_0_time_tlock_max_i_11;
  wire n_0_time_tlock_max_i_12__2;
  wire n_0_time_tlock_max_i_13__2;
  wire n_0_time_tlock_max_i_14__2;
  wire n_0_time_tlock_max_i_15__2;
  wire n_0_time_tlock_max_i_16__2;
  wire n_0_time_tlock_max_i_17__2;
  wire n_0_time_tlock_max_i_18__2;
  wire n_0_time_tlock_max_i_19__2;
  wire n_0_time_tlock_max_i_1__6;
  wire n_0_time_tlock_max_i_20__2;
  wire n_0_time_tlock_max_i_4__2;
  wire n_0_time_tlock_max_i_5__2;
  wire n_0_time_tlock_max_i_6__2;
  wire n_0_time_tlock_max_i_8__2;
  wire n_0_time_tlock_max_i_9__2;
  wire n_0_time_tlock_max_reg_i_3__2;
  wire n_0_time_tlock_max_reg_i_7__2;
  wire \n_0_wait_bypass_count[0]_i_1__6 ;
  wire \n_0_wait_bypass_count[0]_i_2__6 ;
  wire \n_0_wait_bypass_count[0]_i_4__6 ;
  wire \n_0_wait_bypass_count[0]_i_5__6 ;
  wire \n_0_wait_bypass_count[0]_i_6__6 ;
  wire \n_0_wait_bypass_count[0]_i_7__6 ;
  wire \n_0_wait_bypass_count[0]_i_8__6 ;
  wire \n_0_wait_bypass_count[0]_i_9__2 ;
  wire \n_0_wait_bypass_count[12]_i_2__6 ;
  wire \n_0_wait_bypass_count[4]_i_2__6 ;
  wire \n_0_wait_bypass_count[4]_i_3__6 ;
  wire \n_0_wait_bypass_count[4]_i_4__6 ;
  wire \n_0_wait_bypass_count[4]_i_5__6 ;
  wire \n_0_wait_bypass_count[8]_i_2__6 ;
  wire \n_0_wait_bypass_count[8]_i_3__6 ;
  wire \n_0_wait_bypass_count[8]_i_4__6 ;
  wire \n_0_wait_bypass_count[8]_i_5__6 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3__6 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1__6 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1__6 ;
  wire \n_0_wait_time_cnt[1]_i_1__6 ;
  wire \n_0_wait_time_cnt[4]_i_1__6 ;
  wire \n_0_wait_time_cnt[6]_i_1__6 ;
  wire \n_0_wait_time_cnt[6]_i_2__6 ;
  wire \n_0_wait_time_cnt[6]_i_4__6 ;
  wire n_1_sync_QPLLLOCK;
  wire n_1_sync_data_valid;
  wire n_1_sync_mmcm_lock_reclocked;
  wire n_1_sync_rxpmaresetdone;
  wire \n_1_time_out_counter_reg[0]_i_2__6 ;
  wire \n_1_time_out_counter_reg[12]_i_1__6 ;
  wire \n_1_time_out_counter_reg[4]_i_1__6 ;
  wire \n_1_time_out_counter_reg[8]_i_1__6 ;
  wire n_1_time_tlock_max_reg_i_3__2;
  wire n_1_time_tlock_max_reg_i_7__2;
  wire \n_1_wait_bypass_count_reg[0]_i_3__6 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1__6 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1__6 ;
  wire n_2_sync_data_valid;
  wire \n_2_time_out_counter_reg[0]_i_2__6 ;
  wire \n_2_time_out_counter_reg[12]_i_1__6 ;
  wire \n_2_time_out_counter_reg[16]_i_1__6 ;
  wire \n_2_time_out_counter_reg[4]_i_1__6 ;
  wire \n_2_time_out_counter_reg[8]_i_1__6 ;
  wire n_2_time_tlock_max_reg_i_3__2;
  wire n_2_time_tlock_max_reg_i_7__2;
  wire \n_2_wait_bypass_count_reg[0]_i_3__6 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1__6 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1__6 ;
  wire n_3_sync_data_valid;
  wire \n_3_time_out_counter_reg[0]_i_2__6 ;
  wire \n_3_time_out_counter_reg[12]_i_1__6 ;
  wire \n_3_time_out_counter_reg[16]_i_1__6 ;
  wire \n_3_time_out_counter_reg[4]_i_1__6 ;
  wire \n_3_time_out_counter_reg[8]_i_1__6 ;
  wire n_3_time_tlock_max_reg_i_2__2;
  wire n_3_time_tlock_max_reg_i_3__2;
  wire n_3_time_tlock_max_reg_i_7__2;
  wire \n_3_wait_bypass_count_reg[0]_i_3__6 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1__6 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1__6 ;
  wire n_4_sync_data_valid;
  wire \n_4_time_out_counter_reg[0]_i_2__6 ;
  wire \n_4_time_out_counter_reg[12]_i_1__6 ;
  wire \n_4_time_out_counter_reg[4]_i_1__6 ;
  wire \n_4_time_out_counter_reg[8]_i_1__6 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3__6 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1__6 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1__6 ;
  wire n_5_sync_data_valid;
  wire \n_5_time_out_counter_reg[0]_i_2__6 ;
  wire \n_5_time_out_counter_reg[12]_i_1__6 ;
  wire \n_5_time_out_counter_reg[16]_i_1__6 ;
  wire \n_5_time_out_counter_reg[4]_i_1__6 ;
  wire \n_5_time_out_counter_reg[8]_i_1__6 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3__6 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1__6 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1__6 ;
  wire \n_6_time_out_counter_reg[0]_i_2__6 ;
  wire \n_6_time_out_counter_reg[12]_i_1__6 ;
  wire \n_6_time_out_counter_reg[16]_i_1__6 ;
  wire \n_6_time_out_counter_reg[4]_i_1__6 ;
  wire \n_6_time_out_counter_reg[8]_i_1__6 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3__6 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1__6 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1__6 ;
  wire \n_7_time_out_counter_reg[0]_i_2__6 ;
  wire \n_7_time_out_counter_reg[12]_i_1__6 ;
  wire \n_7_time_out_counter_reg[16]_i_1__6 ;
  wire \n_7_time_out_counter_reg[4]_i_1__6 ;
  wire \n_7_time_out_counter_reg[8]_i_1__6 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3__6 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1__6 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1__6 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1__6 ;
  wire [6:0]p_0_in__13;
  wire [7:0]p_0_in__14;
  wire run_phase_alignment_int_s2;
  wire rx_fsm_reset_done_int_s2;
(* RTL_KEEP = "yes" *)   wire [3:0]rx_state;
  wire rx_state16_out;
  wire rxpmaresetdone_i;
  wire rxresetdone_s2;
  wire rxresetdone_s3;
  wire [18:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire time_tlock_max1;
  wire [12:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0__6;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__6_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__6_O_UNCONNECTED ;
  wire [3:2]NLW_time_tlock_max_reg_i_2__2_CO_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_2__2_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_3__2_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_7__2_O_UNCONNECTED;
  wire [3:0]\NLW_wait_bypass_count_reg[12]_i_1__6_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[12]_i_1__6_O_UNCONNECTED ;

LUT6 #(
    .INIT(64'h4E0AEE2A4E0ACE0A)) 
     \FSM_sequential_rx_state[0]_i_2__2 
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .I3(n_0_time_out_2ms_reg),
        .I4(n_0_reset_time_out_reg),
        .I5(time_tlock_max),
        .O(\n_0_FSM_sequential_rx_state[0]_i_2__2 ));
LUT6 #(
    .INIT(64'h1111004015150040)) 
     \FSM_sequential_rx_state[2]_i_1__2 
       (.I0(rx_state[3]),
        .I1(rx_state[0]),
        .I2(rx_state[1]),
        .I3(n_0_time_out_2ms_reg),
        .I4(rx_state[2]),
        .I5(rx_state16_out),
        .O(\n_0_FSM_sequential_rx_state[2]_i_1__2 ));
(* SOFT_HLUTNM = "soft_lutpair78" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_rx_state[2]_i_2__2 
       (.I0(time_tlock_max),
        .I1(n_0_reset_time_out_reg),
        .O(rx_state16_out));
LUT6 #(
    .INIT(64'h0F0F0F0F4F404040)) 
     \FSM_sequential_rx_state[3]_i_4__2 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_FSM_sequential_rx_state[3]_i_8__2 ),
        .I2(rx_state[1]),
        .I3(I1),
        .I4(rx_state[2]),
        .I5(rx_state[3]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_4__2 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_sequential_rx_state[3]_i_8__2 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[3]),
        .I4(wait_time_cnt_reg__0[0]),
        .I5(wait_time_cnt_reg__0[1]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_8__2 ));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_3_sync_data_valid),
        .Q(rx_state[0]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_2_sync_data_valid),
        .Q(rx_state[1]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(\n_0_FSM_sequential_rx_state[2]_i_1__2 ),
        .Q(rx_state[2]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(n_4_sync_data_valid),
        .D(n_1_sync_data_valid),
        .Q(rx_state[3]),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD2000)) 
     RXUSERRDY_i_1__2
       (.I0(rx_state[0]),
        .I1(rx_state[3]),
        .I2(rx_state[2]),
        .I3(rx_state[1]),
        .I4(O1),
        .O(n_0_RXUSERRDY_i_1__2));
FDRE #(
    .INIT(1'b0)) 
     RXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_RXUSERRDY_i_1__2),
        .Q(O1),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0008)) 
     check_tlock_max_i_1__2
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(rx_state[3]),
        .I3(rx_state[1]),
        .I4(n_0_check_tlock_max_reg),
        .O(n_0_check_tlock_max_i_1__2));
FDRE #(
    .INIT(1'b0)) 
     check_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_check_tlock_max_i_1__2),
        .Q(n_0_check_tlock_max_reg),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD0004)) 
     gtrxreset_i_i_1__2
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(rx_state[3]),
        .I3(rx_state[1]),
        .I4(SR),
        .O(n_0_gtrxreset_i_i_1__2));
FDRE #(
    .INIT(1'b0)) 
     gtrxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gtrxreset_i_i_1__2),
        .Q(SR),
        .R(SOFT_RESET_IN));
(* SOFT_HLUTNM = "soft_lutpair82" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1__6 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in__13[0]));
(* SOFT_HLUTNM = "soft_lutpair82" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1__6 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in__13[1]));
(* SOFT_HLUTNM = "soft_lutpair75" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[2]_i_1__6 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .O(p_0_in__13[2]));
(* SOFT_HLUTNM = "soft_lutpair75" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \init_wait_count[3]_i_1__6 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .O(p_0_in__13[3]));
(* SOFT_HLUTNM = "soft_lutpair72" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \init_wait_count[4]_i_1__6 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .O(p_0_in__13[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \init_wait_count[5]_i_1__6 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .I5(init_wait_count_reg__0[4]),
        .O(p_0_in__13[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
     \init_wait_count[6]_i_1__6 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[0]),
        .I3(\n_0_init_wait_count[6]_i_3__6 ),
        .I4(init_wait_count_reg__0[4]),
        .I5(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_1__6 ));
LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[6]_i_2__6 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\n_0_init_wait_count[6]_i_4__6 ),
        .I2(init_wait_count_reg__0[5]),
        .O(p_0_in__13[6]));
LUT2 #(
    .INIT(4'h7)) 
     \init_wait_count[6]_i_3__6 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_3__6 ));
(* SOFT_HLUTNM = "soft_lutpair72" *) 
   LUT5 #(
    .INIT(32'h80000000)) 
     \init_wait_count[6]_i_4__6 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_4__6 ));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__6 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__13[0]),
        .Q(init_wait_count_reg__0[0]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__6 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__13[1]),
        .Q(init_wait_count_reg__0[1]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__6 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__13[2]),
        .Q(init_wait_count_reg__0[2]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__6 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__13[3]),
        .Q(init_wait_count_reg__0[3]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__6 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__13[4]),
        .Q(init_wait_count_reg__0[4]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__6 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__13[5]),
        .Q(init_wait_count_reg__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__6 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__13[6]),
        .Q(init_wait_count_reg__0[6]));
LUT2 #(
    .INIT(4'hE)) 
     init_wait_done_i_1__6
       (.I0(init_wait_done),
        .I1(n_0_init_wait_done_reg),
        .O(n_0_init_wait_done_i_1__6));
LUT6 #(
    .INIT(64'h0000000004000000)) 
     init_wait_done_i_2__6
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[4]),
        .I2(\n_0_init_wait_count[6]_i_3__6 ),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_done));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(n_0_init_wait_done_i_1__6),
        .Q(n_0_init_wait_done_reg));
(* SOFT_HLUTNM = "soft_lutpair81" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__14[0]));
(* SOFT_HLUTNM = "soft_lutpair81" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__14[1]));
(* SOFT_HLUTNM = "soft_lutpair79" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[2]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__14[2]));
(* SOFT_HLUTNM = "soft_lutpair74" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \mmcm_lock_count[3]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__14[3]));
(* SOFT_HLUTNM = "soft_lutpair74" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \mmcm_lock_count[4]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[3]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__14[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[5]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__14[5]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[6]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(\n_0_mmcm_lock_count[6]_i_2__6 ),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__14[6]));
(* SOFT_HLUTNM = "soft_lutpair79" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \mmcm_lock_count[6]_i_2__6 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(\n_0_mmcm_lock_count[6]_i_2__6 ));
LUT3 #(
    .INIT(8'h7F)) 
     \mmcm_lock_count[7]_i_2__6 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__6 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(\n_0_mmcm_lock_count[7]_i_2__6 ));
LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[7]_i_3__6 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__6 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__14[7]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \mmcm_lock_count[7]_i_4__6 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(\n_0_mmcm_lock_count[7]_i_4__6 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__6 ),
        .D(p_0_in__14[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__6 ),
        .D(p_0_in__14[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__6 ),
        .D(p_0_in__14[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__6 ),
        .D(p_0_in__14[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__6 ),
        .D(p_0_in__14[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__6 ),
        .D(p_0_in__14[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__6 ),
        .D(p_0_in__14[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__6 ),
        .D(p_0_in__14[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
FDRE #(
    .INIT(1'b1)) 
     mmcm_reset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_rxpmaresetdone),
        .Q(GT3_RX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync1_rx
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(1'b0),
        .PRE(SR),
        .Q(D));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync2_rx
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(D),
        .PRE(SR),
        .Q(Q));
FDSE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_QPLLLOCK),
        .Q(n_0_reset_time_out_reg),
        .S(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0002)) 
     run_phase_alignment_int_i_1__6
       (.I0(rx_state[3]),
        .I1(rx_state[0]),
        .I2(rx_state[2]),
        .I3(rx_state[1]),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1__6));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1__6),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(run_phase_alignment_int_s2),
        .Q(n_0_run_phase_alignment_int_s3_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_data_valid),
        .Q(GT3_RX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_s3_reg
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(rx_fsm_reset_done_int_s2),
        .Q(n_0_rx_fsm_reset_done_int_s3_reg),
        .R(1'b0));
FDCE #(
    .INIT(1'b0)) 
     rxpmaresetdone_i_reg
       (.C(RXOUTCLK),
        .CE(1'b1),
        .CLR(Q),
        .D(n_0_sync_rxpmaresetdone_rx_s),
        .Q(rxpmaresetdone_i));
FDRE #(
    .INIT(1'b0)) 
     rxresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(rxresetdone_s2),
        .Q(rxresetdone_s3),
        .R(1'b0));
XLAUI_XLAUI_sync_block__parameterized0_11 sync_QPLLLOCK
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .I1(n_5_sync_data_valid),
        .I2(n_1_sync_rxpmaresetdone),
        .I3(n_0_reset_time_out_reg),
        .I4(n_0_time_out_2ms_reg),
        .O1(n_0_sync_QPLLLOCK),
        .O2(n_1_sync_QPLLLOCK),
        .SYSCLK_IN(SYSCLK_IN),
        .out(rx_state[3:1]),
        .rxresetdone_s3(rxresetdone_s3));
XLAUI_XLAUI_sync_block__parameterized0_12 sync_RXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(rxresetdone_s2),
        .gt3_rxresetdone_out(gt3_rxresetdone_out));
XLAUI_XLAUI_sync_block__parameterized0_13 sync_data_valid
       (.D({n_1_sync_data_valid,n_2_sync_data_valid,n_3_sync_data_valid}),
        .DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .E(n_4_sync_data_valid),
        .GT3_DATA_VALID_IN(GT3_DATA_VALID_IN),
        .GT3_RX_FSM_RESET_DONE_OUT(GT3_RX_FSM_RESET_DONE_OUT),
        .I1(n_0_reset_time_out_reg),
        .I2(n_0_time_out_500us_reg),
        .I3(n_0_time_out_1us_reg),
        .I4(\n_0_FSM_sequential_rx_state[0]_i_2__2 ),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_4__2 ),
        .I6(n_1_sync_QPLLLOCK),
        .I7(n_0_init_wait_done_reg),
        .I8(I1),
        .I9(n_0_time_out_2ms_reg),
        .O1(n_0_sync_data_valid),
        .O2(n_5_sync_data_valid),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state),
        .rx_state16_out(rx_state16_out),
        .rxresetdone_s3(rxresetdone_s3),
        .time_out_wait_bypass_s3(time_out_wait_bypass_s3));
XLAUI_XLAUI_sync_block__parameterized0_14 sync_mmcm_lock_reclocked
       (.GT3_RX_MMCM_LOCK_IN(GT3_RX_MMCM_LOCK_IN),
        .I1(\n_0_mmcm_lock_count[7]_i_4__6 ),
        .O1(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(n_0_sync_mmcm_lock_reclocked),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked));
XLAUI_XLAUI_sync_block__parameterized0_15 sync_run_phase_alignment_int
       (.data_in(n_0_run_phase_alignment_int_reg),
        .data_out(run_phase_alignment_int_s2),
        .gt3_rxusrclk_in(gt3_rxusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_16 sync_rx_fsm_reset_done_int
       (.GT3_RX_FSM_RESET_DONE_OUT(GT3_RX_FSM_RESET_DONE_OUT),
        .data_out(rx_fsm_reset_done_int_s2),
        .gt3_rxusrclk_in(gt3_rxusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_17 sync_rxpmaresetdone
       (.GT3_RX_MMCM_RESET_OUT(GT3_RX_MMCM_RESET_OUT),
        .I1(I1),
        .O1(n_0_sync_rxpmaresetdone),
        .O2(n_1_sync_rxpmaresetdone),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(rxpmaresetdone_i),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state));
XLAUI_XLAUI_sync_block__parameterized0_18 sync_rxpmaresetdone_rx_s
       (.RXOUTCLK(RXOUTCLK),
        .data_in(data_in),
        .data_out(n_0_sync_rxpmaresetdone_rx_s));
XLAUI_XLAUI_sync_block__parameterized0_19 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
LUT6 #(
    .INIT(64'hFFFFFFFF02000000)) 
     time_out_1us_i_1__2
       (.I0(n_0_time_out_500us_i_3),
        .I1(n_0_time_out_1us_i_2),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[7]),
        .I4(n_0_time_out_1us_i_3__2),
        .I5(n_0_time_out_1us_reg),
        .O(n_0_time_out_1us_i_1__2));
(* SOFT_HLUTNM = "soft_lutpair76" *) 
   LUT2 #(
    .INIT(4'hE)) 
     time_out_1us_i_2
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(n_0_time_out_1us_i_2));
LUT6 #(
    .INIT(64'h0000001000000000)) 
     time_out_1us_i_3__2
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[16]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[9]),
        .I4(time_out_counter_reg[3]),
        .I5(n_0_time_out_1us_i_4__2),
        .O(n_0_time_out_1us_i_3__2));
LUT6 #(
    .INIT(64'h0000000000100000)) 
     time_out_1us_i_4__2
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .I4(time_out_counter_reg[1]),
        .I5(time_out_counter_reg[15]),
        .O(n_0_time_out_1us_i_4__2));
FDRE #(
    .INIT(1'b0)) 
     time_out_1us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_1us_i_1__2),
        .Q(n_0_time_out_1us_reg),
        .R(n_0_reset_time_out_reg));
LUT5 #(
    .INIT(32'hAAAAAAAB)) 
     time_out_2ms_i_1__6
       (.I0(n_0_time_out_2ms_reg),
        .I1(n_0_time_out_2ms_i_2__2),
        .I2(n_0_time_out_2ms_i_3__2),
        .I3(n_0_time_out_2ms_i_4__2),
        .I4(\n_0_time_out_counter[0]_i_3__2 ),
        .O(n_0_time_out_2ms_i_1__6));
LUT5 #(
    .INIT(32'hFEFFFFFF)) 
     time_out_2ms_i_2__2
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[9]),
        .I4(time_out_counter_reg[12]),
        .O(n_0_time_out_2ms_i_2__2));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFDFF)) 
     time_out_2ms_i_3__2
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[18]),
        .I4(time_out_counter_reg[8]),
        .I5(time_out_counter_reg[17]),
        .O(n_0_time_out_2ms_i_3__2));
(* SOFT_HLUTNM = "soft_lutpair76" *) 
   LUT4 #(
    .INIT(16'h7FFF)) 
     time_out_2ms_i_4__2
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[2]),
        .O(n_0_time_out_2ms_i_4__2));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1__6),
        .Q(n_0_time_out_2ms_reg),
        .R(n_0_reset_time_out_reg));
LUT5 #(
    .INIT(32'hFFFF0080)) 
     time_out_500us_i_1__2
       (.I0(n_0_time_out_500us_i_2__3),
        .I1(n_0_time_out_500us_i_3),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[17]),
        .I4(n_0_time_out_500us_reg),
        .O(n_0_time_out_500us_i_1__2));
LUT5 #(
    .INIT(32'h00000200)) 
     time_out_500us_i_2__3
       (.I0(n_0_time_out_500us_i_4__3),
        .I1(\n_0_time_out_counter[0]_i_3__2 ),
        .I2(time_out_counter_reg[11]),
        .I3(time_out_counter_reg[14]),
        .I4(time_out_counter_reg[3]),
        .O(n_0_time_out_500us_i_2__3));
LUT4 #(
    .INIT(16'h0001)) 
     time_out_500us_i_3
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[4]),
        .O(n_0_time_out_500us_i_3));
LUT6 #(
    .INIT(64'h2000000000000000)) 
     time_out_500us_i_4__3
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[0]),
        .I5(time_out_counter_reg[16]),
        .O(n_0_time_out_500us_i_4__3));
FDRE #(
    .INIT(1'b0)) 
     time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_500us_i_1__2),
        .Q(n_0_time_out_500us_reg),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFFFFFFFFBFFFFFFF)) 
     \time_out_counter[0]_i_1__6 
       (.I0(\n_0_time_out_counter[0]_i_3__2 ),
        .I1(time_out_counter_reg[16]),
        .I2(time_out_counter_reg[0]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[2]),
        .I5(\n_0_time_out_counter[0]_i_4__2 ),
        .O(\n_0_time_out_counter[0]_i_1__6 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \time_out_counter[0]_i_3__2 
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[0]_i_3__2 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFF7)) 
     \time_out_counter[0]_i_4__2 
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[3]),
        .I4(time_out_counter_reg[14]),
        .I5(n_0_time_out_2ms_i_3__2),
        .O(\n_0_time_out_counter[0]_i_4__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_5__6 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_5__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6__6 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_6__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_7__6 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_7__6 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_8__2 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_8__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2__6 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3__6 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4__6 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5__6 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2__6 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_2__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3__6 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_3__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4__6 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_4__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2__6 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3__6 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4__6 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5__6 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2__6 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3__6 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4__6 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5__6 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5__6 ));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_7_time_out_counter_reg[0]_i_2__6 ),
        .Q(time_out_counter_reg[0]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[0]_i_2__6 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2__6 ,\n_1_time_out_counter_reg[0]_i_2__6 ,\n_2_time_out_counter_reg[0]_i_2__6 ,\n_3_time_out_counter_reg[0]_i_2__6 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2__6 ,\n_5_time_out_counter_reg[0]_i_2__6 ,\n_6_time_out_counter_reg[0]_i_2__6 ,\n_7_time_out_counter_reg[0]_i_2__6 }),
        .S({\n_0_time_out_counter[0]_i_5__6 ,\n_0_time_out_counter[0]_i_6__6 ,\n_0_time_out_counter[0]_i_7__6 ,\n_0_time_out_counter[0]_i_8__2 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_5_time_out_counter_reg[8]_i_1__6 ),
        .Q(time_out_counter_reg[10]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_4_time_out_counter_reg[8]_i_1__6 ),
        .Q(time_out_counter_reg[11]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_7_time_out_counter_reg[12]_i_1__6 ),
        .Q(time_out_counter_reg[12]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[12]_i_1__6 
       (.CI(\n_0_time_out_counter_reg[8]_i_1__6 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1__6 ,\n_1_time_out_counter_reg[12]_i_1__6 ,\n_2_time_out_counter_reg[12]_i_1__6 ,\n_3_time_out_counter_reg[12]_i_1__6 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1__6 ,\n_5_time_out_counter_reg[12]_i_1__6 ,\n_6_time_out_counter_reg[12]_i_1__6 ,\n_7_time_out_counter_reg[12]_i_1__6 }),
        .S({\n_0_time_out_counter[12]_i_2__6 ,\n_0_time_out_counter[12]_i_3__6 ,\n_0_time_out_counter[12]_i_4__6 ,\n_0_time_out_counter[12]_i_5__6 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_6_time_out_counter_reg[12]_i_1__6 ),
        .Q(time_out_counter_reg[13]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_5_time_out_counter_reg[12]_i_1__6 ),
        .Q(time_out_counter_reg[14]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_4_time_out_counter_reg[12]_i_1__6 ),
        .Q(time_out_counter_reg[15]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_7_time_out_counter_reg[16]_i_1__6 ),
        .Q(time_out_counter_reg[16]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[16]_i_1__6 
       (.CI(\n_0_time_out_counter_reg[12]_i_1__6 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__6_CO_UNCONNECTED [3:2],\n_2_time_out_counter_reg[16]_i_1__6 ,\n_3_time_out_counter_reg[16]_i_1__6 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__6_O_UNCONNECTED [3],\n_5_time_out_counter_reg[16]_i_1__6 ,\n_6_time_out_counter_reg[16]_i_1__6 ,\n_7_time_out_counter_reg[16]_i_1__6 }),
        .S({1'b0,\n_0_time_out_counter[16]_i_2__6 ,\n_0_time_out_counter[16]_i_3__6 ,\n_0_time_out_counter[16]_i_4__6 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_6_time_out_counter_reg[16]_i_1__6 ),
        .Q(time_out_counter_reg[17]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_5_time_out_counter_reg[16]_i_1__6 ),
        .Q(time_out_counter_reg[18]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_6_time_out_counter_reg[0]_i_2__6 ),
        .Q(time_out_counter_reg[1]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_5_time_out_counter_reg[0]_i_2__6 ),
        .Q(time_out_counter_reg[2]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_4_time_out_counter_reg[0]_i_2__6 ),
        .Q(time_out_counter_reg[3]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_7_time_out_counter_reg[4]_i_1__6 ),
        .Q(time_out_counter_reg[4]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[4]_i_1__6 
       (.CI(\n_0_time_out_counter_reg[0]_i_2__6 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1__6 ,\n_1_time_out_counter_reg[4]_i_1__6 ,\n_2_time_out_counter_reg[4]_i_1__6 ,\n_3_time_out_counter_reg[4]_i_1__6 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1__6 ,\n_5_time_out_counter_reg[4]_i_1__6 ,\n_6_time_out_counter_reg[4]_i_1__6 ,\n_7_time_out_counter_reg[4]_i_1__6 }),
        .S({\n_0_time_out_counter[4]_i_2__6 ,\n_0_time_out_counter[4]_i_3__6 ,\n_0_time_out_counter[4]_i_4__6 ,\n_0_time_out_counter[4]_i_5__6 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_6_time_out_counter_reg[4]_i_1__6 ),
        .Q(time_out_counter_reg[5]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_5_time_out_counter_reg[4]_i_1__6 ),
        .Q(time_out_counter_reg[6]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_4_time_out_counter_reg[4]_i_1__6 ),
        .Q(time_out_counter_reg[7]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_7_time_out_counter_reg[8]_i_1__6 ),
        .Q(time_out_counter_reg[8]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[8]_i_1__6 
       (.CI(\n_0_time_out_counter_reg[4]_i_1__6 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1__6 ,\n_1_time_out_counter_reg[8]_i_1__6 ,\n_2_time_out_counter_reg[8]_i_1__6 ,\n_3_time_out_counter_reg[8]_i_1__6 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1__6 ,\n_5_time_out_counter_reg[8]_i_1__6 ,\n_6_time_out_counter_reg[8]_i_1__6 ,\n_7_time_out_counter_reg[8]_i_1__6 }),
        .S({\n_0_time_out_counter[8]_i_2__6 ,\n_0_time_out_counter[8]_i_3__6 ,\n_0_time_out_counter[8]_i_4__6 ,\n_0_time_out_counter[8]_i_5__6 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__6 ),
        .D(\n_6_time_out_counter_reg[8]_i_1__6 ),
        .Q(time_out_counter_reg[9]),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1__6
       (.I0(\n_0_wait_bypass_count[0]_i_4__6 ),
        .I1(wait_bypass_count_reg[3]),
        .I2(\n_0_wait_bypass_count[0]_i_5__6 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(n_0_rx_fsm_reset_done_int_s3_reg),
        .I5(n_0_run_phase_alignment_int_s3_reg),
        .O(n_0_time_out_wait_bypass_i_1__6));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1__6),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_10__2
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[15]),
        .O(n_0_time_tlock_max_i_10__2));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_11
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_tlock_max_i_11));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_12__2
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[10]),
        .O(n_0_time_tlock_max_i_12__2));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_13__2
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .O(n_0_time_tlock_max_i_13__2));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_14__2
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[6]),
        .O(n_0_time_tlock_max_i_14__2));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_15__2
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_15__2));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_16__2
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(n_0_time_tlock_max_i_16__2));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_17__2
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(n_0_time_tlock_max_i_17__2));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_18__2
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[5]),
        .O(n_0_time_tlock_max_i_18__2));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_19__2
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_19__2));
(* SOFT_HLUTNM = "soft_lutpair78" *) 
   LUT3 #(
    .INIT(8'hF8)) 
     time_tlock_max_i_1__6
       (.I0(n_0_check_tlock_max_reg),
        .I1(time_tlock_max1),
        .I2(time_tlock_max),
        .O(n_0_time_tlock_max_i_1__6));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_20__2
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(n_0_time_tlock_max_i_20__2));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_4__2
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[16]),
        .O(n_0_time_tlock_max_i_4__2));
LUT1 #(
    .INIT(2'h1)) 
     time_tlock_max_i_5__2
       (.I0(time_out_counter_reg[18]),
        .O(n_0_time_tlock_max_i_5__2));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_6__2
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(n_0_time_tlock_max_i_6__2));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_8__2
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .O(n_0_time_tlock_max_i_8__2));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_9__2
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(n_0_time_tlock_max_i_9__2));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1__6),
        .Q(time_tlock_max),
        .R(n_0_reset_time_out_reg));
CARRY4 time_tlock_max_reg_i_2__2
       (.CI(n_0_time_tlock_max_reg_i_3__2),
        .CO({NLW_time_tlock_max_reg_i_2__2_CO_UNCONNECTED[3:2],time_tlock_max1,n_3_time_tlock_max_reg_i_2__2}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,time_out_counter_reg[18],n_0_time_tlock_max_i_4__2}),
        .O(NLW_time_tlock_max_reg_i_2__2_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,n_0_time_tlock_max_i_5__2,n_0_time_tlock_max_i_6__2}));
CARRY4 time_tlock_max_reg_i_3__2
       (.CI(n_0_time_tlock_max_reg_i_7__2),
        .CO({n_0_time_tlock_max_reg_i_3__2,n_1_time_tlock_max_reg_i_3__2,n_2_time_tlock_max_reg_i_3__2,n_3_time_tlock_max_reg_i_3__2}),
        .CYINIT(1'b0),
        .DI({time_out_counter_reg[15],n_0_time_tlock_max_i_8__2,n_0_time_tlock_max_i_9__2,time_out_counter_reg[9]}),
        .O(NLW_time_tlock_max_reg_i_3__2_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_10__2,n_0_time_tlock_max_i_11,n_0_time_tlock_max_i_12__2,n_0_time_tlock_max_i_13__2}));
CARRY4 time_tlock_max_reg_i_7__2
       (.CI(1'b0),
        .CO({n_0_time_tlock_max_reg_i_7__2,n_1_time_tlock_max_reg_i_7__2,n_2_time_tlock_max_reg_i_7__2,n_3_time_tlock_max_reg_i_7__2}),
        .CYINIT(1'b0),
        .DI({n_0_time_tlock_max_i_14__2,time_out_counter_reg[5],n_0_time_tlock_max_i_15__2,n_0_time_tlock_max_i_16__2}),
        .O(NLW_time_tlock_max_reg_i_7__2_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_17__2,n_0_time_tlock_max_i_18__2,n_0_time_tlock_max_i_19__2,n_0_time_tlock_max_i_20__2}));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1__6 
       (.I0(n_0_run_phase_alignment_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_1__6 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2__6 
       (.I0(\n_0_wait_bypass_count[0]_i_4__6 ),
        .I1(wait_bypass_count_reg[3]),
        .I2(\n_0_wait_bypass_count[0]_i_5__6 ),
        .I3(n_0_rx_fsm_reset_done_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_2__6 ));
LUT6 #(
    .INIT(64'hFFFFEFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_4__6 
       (.I0(wait_bypass_count_reg[11]),
        .I1(wait_bypass_count_reg[4]),
        .I2(wait_bypass_count_reg[0]),
        .I3(wait_bypass_count_reg[9]),
        .I4(wait_bypass_count_reg[10]),
        .I5(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_4__6 ));
LUT6 #(
    .INIT(64'hFDFFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_5__6 
       (.I0(wait_bypass_count_reg[1]),
        .I1(wait_bypass_count_reg[6]),
        .I2(wait_bypass_count_reg[5]),
        .I3(wait_bypass_count_reg[12]),
        .I4(wait_bypass_count_reg[8]),
        .I5(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[0]_i_5__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_6__6 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_6__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7__6 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_7__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8__6 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_8__6 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_9__2 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_9__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2__6 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_2__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2__6 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3__6 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4__6 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5__6 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2__6 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3__6 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4__6 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5__6 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5__6 ));
FDRE \wait_bypass_count_reg[0] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3__6 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
CARRY4 \wait_bypass_count_reg[0]_i_3__6 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3__6 ,\n_1_wait_bypass_count_reg[0]_i_3__6 ,\n_2_wait_bypass_count_reg[0]_i_3__6 ,\n_3_wait_bypass_count_reg[0]_i_3__6 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3__6 ,\n_5_wait_bypass_count_reg[0]_i_3__6 ,\n_6_wait_bypass_count_reg[0]_i_3__6 ,\n_7_wait_bypass_count_reg[0]_i_3__6 }),
        .S({\n_0_wait_bypass_count[0]_i_6__6 ,\n_0_wait_bypass_count[0]_i_7__6 ,\n_0_wait_bypass_count[0]_i_8__6 ,\n_0_wait_bypass_count[0]_i_9__2 }));
FDRE \wait_bypass_count_reg[10] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1__6 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
FDRE \wait_bypass_count_reg[11] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1__6 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
FDRE \wait_bypass_count_reg[12] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1__6 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
CARRY4 \wait_bypass_count_reg[12]_i_1__6 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1__6 ),
        .CO(\NLW_wait_bypass_count_reg[12]_i_1__6_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[12]_i_1__6_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[12]_i_1__6 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[12]_i_2__6 }));
FDRE \wait_bypass_count_reg[1] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3__6 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
FDRE \wait_bypass_count_reg[2] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3__6 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
FDRE \wait_bypass_count_reg[3] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3__6 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
FDRE \wait_bypass_count_reg[4] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1__6 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
CARRY4 \wait_bypass_count_reg[4]_i_1__6 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3__6 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1__6 ,\n_1_wait_bypass_count_reg[4]_i_1__6 ,\n_2_wait_bypass_count_reg[4]_i_1__6 ,\n_3_wait_bypass_count_reg[4]_i_1__6 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1__6 ,\n_5_wait_bypass_count_reg[4]_i_1__6 ,\n_6_wait_bypass_count_reg[4]_i_1__6 ,\n_7_wait_bypass_count_reg[4]_i_1__6 }),
        .S({\n_0_wait_bypass_count[4]_i_2__6 ,\n_0_wait_bypass_count[4]_i_3__6 ,\n_0_wait_bypass_count[4]_i_4__6 ,\n_0_wait_bypass_count[4]_i_5__6 }));
FDRE \wait_bypass_count_reg[5] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1__6 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
FDRE \wait_bypass_count_reg[6] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1__6 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
FDRE \wait_bypass_count_reg[7] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1__6 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
FDRE \wait_bypass_count_reg[8] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1__6 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
CARRY4 \wait_bypass_count_reg[8]_i_1__6 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1__6 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1__6 ,\n_1_wait_bypass_count_reg[8]_i_1__6 ,\n_2_wait_bypass_count_reg[8]_i_1__6 ,\n_3_wait_bypass_count_reg[8]_i_1__6 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1__6 ,\n_5_wait_bypass_count_reg[8]_i_1__6 ,\n_6_wait_bypass_count_reg[8]_i_1__6 ,\n_7_wait_bypass_count_reg[8]_i_1__6 }),
        .S({\n_0_wait_bypass_count[8]_i_2__6 ,\n_0_wait_bypass_count[8]_i_3__6 ,\n_0_wait_bypass_count[8]_i_4__6 ,\n_0_wait_bypass_count[8]_i_5__6 }));
FDRE \wait_bypass_count_reg[9] 
       (.C(gt3_rxusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__6 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1__6 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1__6 ));
(* SOFT_HLUTNM = "soft_lutpair80" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1__6 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__6[0]));
(* SOFT_HLUTNM = "soft_lutpair80" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1__6 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\n_0_wait_time_cnt[1]_i_1__6 ));
(* SOFT_HLUTNM = "soft_lutpair77" *) 
   LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1__6 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__6[2]));
(* SOFT_HLUTNM = "soft_lutpair73" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \wait_time_cnt[3]_i_1__6 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0__6[3]));
(* SOFT_HLUTNM = "soft_lutpair73" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1__6 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\n_0_wait_time_cnt[4]_i_1__6 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[5]_i_1__6 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[1]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__6[5]));
LUT3 #(
    .INIT(8'h10)) 
     \wait_time_cnt[6]_i_1__6 
       (.I0(rx_state[1]),
        .I1(rx_state[3]),
        .I2(rx_state[0]),
        .O(\n_0_wait_time_cnt[6]_i_1__6 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_2__6 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(wait_time_cnt_reg__0[5]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .I5(\n_0_wait_time_cnt[6]_i_4__6 ),
        .O(\n_0_wait_time_cnt[6]_i_2__6 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[6]_i_3__6 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4__6 ),
        .I2(wait_time_cnt_reg__0[3]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[5]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__6[6]));
(* SOFT_HLUTNM = "soft_lutpair77" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_4__6 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(\n_0_wait_time_cnt[6]_i_4__6 ));
FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__6 ),
        .D(wait_time_cnt0__6[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\n_0_wait_time_cnt[6]_i_1__6 ));
FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__6 ),
        .D(\n_0_wait_time_cnt[1]_i_1__6 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\n_0_wait_time_cnt[6]_i_1__6 ));
FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__6 ),
        .D(wait_time_cnt0__6[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\n_0_wait_time_cnt[6]_i_1__6 ));
FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__6 ),
        .D(wait_time_cnt0__6[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\n_0_wait_time_cnt[6]_i_1__6 ));
FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__6 ),
        .D(\n_0_wait_time_cnt[4]_i_1__6 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\n_0_wait_time_cnt[6]_i_1__6 ));
FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__6 ),
        .D(wait_time_cnt0__6[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\n_0_wait_time_cnt[6]_i_1__6 ));
FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__6 ),
        .D(wait_time_cnt0__6[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\n_0_wait_time_cnt[6]_i_1__6 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_TX_STARTUP_FSM" *) 
module XLAUI_XLAUI_TX_STARTUP_FSM__parameterized0
   (GTTXRESET,
    GT0_TX_MMCM_RESET_OUT,
    GT0_QPLLRESET_OUT,
    GT0_TX_FSM_RESET_DONE_OUT,
    TXUSERRDY,
    SYSCLK_IN,
    gt0_txusrclk_in,
    SOFT_RESET_IN,
    gt0_txresetdone_out,
    GT0_TX_MMCM_LOCK_IN,
    GT0_QPLLLOCK_IN);
  output GTTXRESET;
  output GT0_TX_MMCM_RESET_OUT;
  output GT0_QPLLRESET_OUT;
  output GT0_TX_FSM_RESET_DONE_OUT;
  output TXUSERRDY;
  input SYSCLK_IN;
  input gt0_txusrclk_in;
  input SOFT_RESET_IN;
  input gt0_txresetdone_out;
  input GT0_TX_MMCM_LOCK_IN;
  input GT0_QPLLLOCK_IN;

  wire GT0_QPLLLOCK_IN;
  wire GT0_QPLLRESET_OUT;
  wire GT0_TX_FSM_RESET_DONE_OUT;
  wire GT0_TX_MMCM_LOCK_IN;
  wire GT0_TX_MMCM_RESET_OUT;
  wire GTTXRESET;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire TXUSERRDY;
  wire clear;
  wire data_out;
  wire gt0_txresetdone_out;
  wire gt0_txusrclk_in;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_tx_state[0]_i_1 ;
  wire \n_0_FSM_sequential_tx_state[0]_i_2 ;
  wire \n_0_FSM_sequential_tx_state[1]_i_1 ;
  wire \n_0_FSM_sequential_tx_state[1]_i_2 ;
  wire \n_0_FSM_sequential_tx_state[2]_i_1 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_2 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_4 ;
  wire n_0_MMCM_RESET_i_1;
  wire n_0_QPLL_RESET_i_1;
  wire n_0_TXUSERRDY_i_1;
  wire n_0_gttxreset_i_i_1;
  wire \n_0_init_wait_count[6]_i_1 ;
  wire \n_0_init_wait_count[6]_i_3 ;
  wire \n_0_init_wait_count[6]_i_4 ;
  wire n_0_init_wait_done_i_1;
  wire n_0_init_wait_done_reg;
  wire \n_0_mmcm_lock_count[6]_i_2 ;
  wire \n_0_mmcm_lock_count[7]_i_2 ;
  wire \n_0_mmcm_lock_count[7]_i_4 ;
  wire n_0_pll_reset_asserted_i_1;
  wire n_0_pll_reset_asserted_reg;
  wire n_0_run_phase_alignment_int_i_1;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_sync_QPLLLOCK;
  wire n_0_sync_mmcm_lock_reclocked;
  wire n_0_time_out_2ms_i_1;
  wire n_0_time_out_2ms_reg;
  wire n_0_time_out_500us_i_1__3;
  wire n_0_time_out_500us_i_2__4;
  wire n_0_time_out_500us_i_3__4;
  wire n_0_time_out_500us_reg;
  wire \n_0_time_out_counter[0]_i_1 ;
  wire \n_0_time_out_counter[0]_i_10 ;
  wire \n_0_time_out_counter[0]_i_11 ;
  wire \n_0_time_out_counter[0]_i_4__3 ;
  wire \n_0_time_out_counter[0]_i_5 ;
  wire \n_0_time_out_counter[0]_i_6 ;
  wire \n_0_time_out_counter[0]_i_7 ;
  wire \n_0_time_out_counter[0]_i_8__3 ;
  wire \n_0_time_out_counter[0]_i_9 ;
  wire \n_0_time_out_counter[12]_i_2 ;
  wire \n_0_time_out_counter[12]_i_3 ;
  wire \n_0_time_out_counter[12]_i_4 ;
  wire \n_0_time_out_counter[12]_i_5 ;
  wire \n_0_time_out_counter[16]_i_2 ;
  wire \n_0_time_out_counter[16]_i_3 ;
  wire \n_0_time_out_counter[16]_i_4 ;
  wire \n_0_time_out_counter[4]_i_2 ;
  wire \n_0_time_out_counter[4]_i_3 ;
  wire \n_0_time_out_counter[4]_i_4 ;
  wire \n_0_time_out_counter[4]_i_5 ;
  wire \n_0_time_out_counter[8]_i_2 ;
  wire \n_0_time_out_counter[8]_i_3 ;
  wire \n_0_time_out_counter[8]_i_4 ;
  wire \n_0_time_out_counter[8]_i_5 ;
  wire \n_0_time_out_counter_reg[0]_i_2 ;
  wire \n_0_time_out_counter_reg[12]_i_1 ;
  wire \n_0_time_out_counter_reg[4]_i_1 ;
  wire \n_0_time_out_counter_reg[8]_i_1 ;
  wire n_0_time_out_wait_bypass_i_1;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_1;
  wire n_0_time_tlock_max_i_3__1;
  wire n_0_time_tlock_max_i_4__3;
  wire n_0_time_tlock_max_reg;
  wire n_0_tx_fsm_reset_done_int_i_1;
  wire \n_0_wait_bypass_count[0]_i_1 ;
  wire \n_0_wait_bypass_count[0]_i_10 ;
  wire \n_0_wait_bypass_count[0]_i_2 ;
  wire \n_0_wait_bypass_count[0]_i_4 ;
  wire \n_0_wait_bypass_count[0]_i_5 ;
  wire \n_0_wait_bypass_count[0]_i_6 ;
  wire \n_0_wait_bypass_count[0]_i_7 ;
  wire \n_0_wait_bypass_count[0]_i_8 ;
  wire \n_0_wait_bypass_count[0]_i_9__3 ;
  wire \n_0_wait_bypass_count[12]_i_2 ;
  wire \n_0_wait_bypass_count[12]_i_3 ;
  wire \n_0_wait_bypass_count[12]_i_4 ;
  wire \n_0_wait_bypass_count[12]_i_5 ;
  wire \n_0_wait_bypass_count[16]_i_2 ;
  wire \n_0_wait_bypass_count[4]_i_2 ;
  wire \n_0_wait_bypass_count[4]_i_3 ;
  wire \n_0_wait_bypass_count[4]_i_4 ;
  wire \n_0_wait_bypass_count[4]_i_5 ;
  wire \n_0_wait_bypass_count[8]_i_2 ;
  wire \n_0_wait_bypass_count[8]_i_3 ;
  wire \n_0_wait_bypass_count[8]_i_4 ;
  wire \n_0_wait_bypass_count[8]_i_5 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3 ;
  wire \n_0_wait_bypass_count_reg[12]_i_1 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1 ;
  wire \n_0_wait_time_cnt[1]_i_1 ;
  wire \n_0_wait_time_cnt[4]_i_1 ;
  wire \n_0_wait_time_cnt[6]_i_2 ;
  wire \n_0_wait_time_cnt[6]_i_4 ;
  wire n_1_sync_QPLLLOCK;
  wire n_1_sync_mmcm_lock_reclocked;
  wire \n_1_time_out_counter_reg[0]_i_2 ;
  wire \n_1_time_out_counter_reg[12]_i_1 ;
  wire \n_1_time_out_counter_reg[4]_i_1 ;
  wire \n_1_time_out_counter_reg[8]_i_1 ;
  wire \n_1_wait_bypass_count_reg[0]_i_3 ;
  wire \n_1_wait_bypass_count_reg[12]_i_1 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1 ;
  wire \n_2_time_out_counter_reg[0]_i_2 ;
  wire \n_2_time_out_counter_reg[12]_i_1 ;
  wire \n_2_time_out_counter_reg[16]_i_1 ;
  wire \n_2_time_out_counter_reg[4]_i_1 ;
  wire \n_2_time_out_counter_reg[8]_i_1 ;
  wire \n_2_wait_bypass_count_reg[0]_i_3 ;
  wire \n_2_wait_bypass_count_reg[12]_i_1 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1 ;
  wire \n_3_time_out_counter_reg[0]_i_2 ;
  wire \n_3_time_out_counter_reg[12]_i_1 ;
  wire \n_3_time_out_counter_reg[16]_i_1 ;
  wire \n_3_time_out_counter_reg[4]_i_1 ;
  wire \n_3_time_out_counter_reg[8]_i_1 ;
  wire \n_3_wait_bypass_count_reg[0]_i_3 ;
  wire \n_3_wait_bypass_count_reg[12]_i_1 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1 ;
  wire \n_4_time_out_counter_reg[0]_i_2 ;
  wire \n_4_time_out_counter_reg[12]_i_1 ;
  wire \n_4_time_out_counter_reg[4]_i_1 ;
  wire \n_4_time_out_counter_reg[8]_i_1 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3 ;
  wire \n_4_wait_bypass_count_reg[12]_i_1 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1 ;
  wire \n_5_time_out_counter_reg[0]_i_2 ;
  wire \n_5_time_out_counter_reg[12]_i_1 ;
  wire \n_5_time_out_counter_reg[16]_i_1 ;
  wire \n_5_time_out_counter_reg[4]_i_1 ;
  wire \n_5_time_out_counter_reg[8]_i_1 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3 ;
  wire \n_5_wait_bypass_count_reg[12]_i_1 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1 ;
  wire \n_6_time_out_counter_reg[0]_i_2 ;
  wire \n_6_time_out_counter_reg[12]_i_1 ;
  wire \n_6_time_out_counter_reg[16]_i_1 ;
  wire \n_6_time_out_counter_reg[4]_i_1 ;
  wire \n_6_time_out_counter_reg[8]_i_1 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3 ;
  wire \n_6_wait_bypass_count_reg[12]_i_1 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1 ;
  wire \n_7_time_out_counter_reg[0]_i_2 ;
  wire \n_7_time_out_counter_reg[12]_i_1 ;
  wire \n_7_time_out_counter_reg[16]_i_1 ;
  wire \n_7_time_out_counter_reg[4]_i_1 ;
  wire \n_7_time_out_counter_reg[8]_i_1 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1 ;
  wire \n_7_wait_bypass_count_reg[16]_i_1 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1 ;
  wire [6:0]p_0_in;
  wire [7:0]p_0_in__0;
  wire reset_time_out;
  wire run_phase_alignment_int_s3;
  wire time_out_2ms;
  wire [18:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire tx_fsm_reset_done_int_s2;
  wire tx_fsm_reset_done_int_s3;
(* RTL_KEEP = "yes" *)   wire [3:0]tx_state;
  wire tx_state12_out;
  wire tx_state13_out;
  wire txresetdone_s2;
  wire txresetdone_s3;
  wire [16:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0;
  wire [6:0]wait_time_cnt_reg__0;
  wire wait_time_done;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1_O_UNCONNECTED ;
  wire [3:0]\NLW_wait_bypass_count_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[16]_i_1_O_UNCONNECTED ;

LUT5 #(
    .INIT(32'h0F001F1F)) 
     \FSM_sequential_tx_state[0]_i_1 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[3]),
        .I3(\n_0_FSM_sequential_tx_state[0]_i_2 ),
        .I4(tx_state[0]),
        .O(\n_0_FSM_sequential_tx_state[0]_i_1 ));
LUT6 #(
    .INIT(64'h22F0000022F0FFFF)) 
     \FSM_sequential_tx_state[0]_i_2 
       (.I0(n_0_time_out_500us_reg),
        .I1(reset_time_out),
        .I2(n_0_time_out_2ms_reg),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .I5(\n_0_FSM_sequential_tx_state[1]_i_2 ),
        .O(\n_0_FSM_sequential_tx_state[0]_i_2 ));
LUT4 #(
    .INIT(16'h0062)) 
     \FSM_sequential_tx_state[1]_i_1 
       (.I0(tx_state[1]),
        .I1(tx_state[0]),
        .I2(\n_0_FSM_sequential_tx_state[1]_i_2 ),
        .I3(tx_state[3]),
        .O(\n_0_FSM_sequential_tx_state[1]_i_1 ));
LUT4 #(
    .INIT(16'hFFDF)) 
     \FSM_sequential_tx_state[1]_i_2 
       (.I0(tx_state[2]),
        .I1(mmcm_lock_reclocked),
        .I2(n_0_time_tlock_max_reg),
        .I3(reset_time_out),
        .O(\n_0_FSM_sequential_tx_state[1]_i_2 ));
LUT6 #(
    .INIT(64'h00000000222A662A)) 
     \FSM_sequential_tx_state[2]_i_1 
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state13_out),
        .I3(tx_state[1]),
        .I4(n_0_time_out_2ms_reg),
        .I5(tx_state[3]),
        .O(\n_0_FSM_sequential_tx_state[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT3 #(
    .INIT(8'h04)) 
     \FSM_sequential_tx_state[2]_i_2 
       (.I0(reset_time_out),
        .I1(n_0_time_tlock_max_reg),
        .I2(mmcm_lock_reclocked),
        .O(tx_state13_out));
LUT6 #(
    .INIT(64'h0300004C00000044)) 
     \FSM_sequential_tx_state[3]_i_2 
       (.I0(time_out_wait_bypass_s3),
        .I1(tx_state[3]),
        .I2(tx_state12_out),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .I5(tx_state[0]),
        .O(\n_0_FSM_sequential_tx_state[3]_i_2 ));
LUT2 #(
    .INIT(4'h1)) 
     \FSM_sequential_tx_state[3]_i_4 
       (.I0(tx_state[2]),
        .I1(tx_state[1]),
        .O(\n_0_FSM_sequential_tx_state[3]_i_4 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_sequential_tx_state[3]_i_5 
       (.I0(\n_0_wait_time_cnt[6]_i_4 ),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[5]),
        .I4(wait_time_cnt_reg__0[4]),
        .I5(wait_time_cnt_reg__0[6]),
        .O(wait_time_done));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_tx_state[3]_i_6 
       (.I0(n_0_time_out_500us_reg),
        .I1(reset_time_out),
        .O(tx_state12_out));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[0]_i_1 ),
        .Q(tx_state[0]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[1]_i_1 ),
        .Q(tx_state[1]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[2]_i_1 ),
        .Q(tx_state[2]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[3]_i_2 ),
        .Q(tx_state[3]),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFDF0010)) 
     MMCM_RESET_i_1
       (.I0(tx_state[2]),
        .I1(tx_state[1]),
        .I2(tx_state[0]),
        .I3(tx_state[3]),
        .I4(GT0_TX_MMCM_RESET_OUT),
        .O(n_0_MMCM_RESET_i_1));
FDRE #(
    .INIT(1'b1)) 
     MMCM_RESET_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_MMCM_RESET_i_1),
        .Q(GT0_TX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
LUT6 #(
    .INIT(64'hFFFFFFF700000004)) 
     QPLL_RESET_i_1
       (.I0(n_0_pll_reset_asserted_reg),
        .I1(tx_state[0]),
        .I2(tx_state[2]),
        .I3(tx_state[1]),
        .I4(tx_state[3]),
        .I5(GT0_QPLLRESET_OUT),
        .O(n_0_QPLL_RESET_i_1));
FDRE #(
    .INIT(1'b0)) 
     QPLL_RESET_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_QPLL_RESET_i_1),
        .Q(GT0_QPLLRESET_OUT),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD0080)) 
     TXUSERRDY_i_1
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[3]),
        .I4(TXUSERRDY),
        .O(n_0_TXUSERRDY_i_1));
FDRE #(
    .INIT(1'b0)) 
     TXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_TXUSERRDY_i_1),
        .Q(TXUSERRDY),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0010)) 
     gttxreset_i_i_1
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[0]),
        .I3(tx_state[3]),
        .I4(GTTXRESET),
        .O(n_0_gttxreset_i_i_1));
FDRE #(
    .INIT(1'b0)) 
     gttxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gttxreset_i_i_1),
        .Q(GTTXRESET),
        .R(SOFT_RESET_IN));
(* SOFT_HLUTNM = "soft_lutpair21" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in[0]));
(* SOFT_HLUTNM = "soft_lutpair21" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in[1]));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[2]_i_1 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .O(p_0_in[2]));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \init_wait_count[3]_i_1 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .O(p_0_in[3]));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \init_wait_count[4]_i_1 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .O(p_0_in[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \init_wait_count[5]_i_1 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .I5(init_wait_count_reg__0[4]),
        .O(p_0_in[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
     \init_wait_count[6]_i_1 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[0]),
        .I3(\n_0_init_wait_count[6]_i_3 ),
        .I4(init_wait_count_reg__0[4]),
        .I5(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_1 ));
LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[6]_i_2 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\n_0_init_wait_count[6]_i_4 ),
        .I2(init_wait_count_reg__0[5]),
        .O(p_0_in[6]));
LUT2 #(
    .INIT(4'h7)) 
     \init_wait_count[6]_i_3 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT5 #(
    .INIT(32'h80000000)) 
     \init_wait_count[6]_i_4 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_4 ));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[0]),
        .Q(init_wait_count_reg__0[0]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
LUT2 #(
    .INIT(4'hE)) 
     init_wait_done_i_1
       (.I0(init_wait_done),
        .I1(n_0_init_wait_done_reg),
        .O(n_0_init_wait_done_i_1));
LUT6 #(
    .INIT(64'h0000000004000000)) 
     init_wait_done_i_2
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[4]),
        .I2(\n_0_init_wait_count[6]_i_3 ),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_done));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(n_0_init_wait_done_i_1),
        .Q(n_0_init_wait_done_reg));
(* SOFT_HLUTNM = "soft_lutpair22" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[0]));
(* SOFT_HLUTNM = "soft_lutpair22" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[1]));
(* SOFT_HLUTNM = "soft_lutpair20" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[2]_i_1 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[2]));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \mmcm_lock_count[3]_i_1 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__0[3]));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \mmcm_lock_count[4]_i_1 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[3]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[5]_i_1 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__0[5]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[6]_i_1 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(\n_0_mmcm_lock_count[6]_i_2 ),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__0[6]));
(* SOFT_HLUTNM = "soft_lutpair20" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \mmcm_lock_count[6]_i_2 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(\n_0_mmcm_lock_count[6]_i_2 ));
LUT3 #(
    .INIT(8'h7F)) 
     \mmcm_lock_count[7]_i_2 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[7]_i_4 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(\n_0_mmcm_lock_count[7]_i_2 ));
LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[7]_i_3 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[7]_i_4 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__0[7]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \mmcm_lock_count[7]_i_4 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(\n_0_mmcm_lock_count[7]_i_4 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2 ),
        .D(p_0_in__0[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2 ),
        .D(p_0_in__0[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2 ),
        .D(p_0_in__0[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2 ),
        .D(p_0_in__0[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2 ),
        .D(p_0_in__0[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2 ),
        .D(p_0_in__0[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2 ),
        .D(p_0_in__0[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2 ),
        .D(p_0_in__0[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
LUT5 #(
    .INIT(32'hF0F0F072)) 
     pll_reset_asserted_i_1
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(n_0_pll_reset_asserted_reg),
        .I3(tx_state[2]),
        .I4(tx_state[3]),
        .O(n_0_pll_reset_asserted_i_1));
FDRE #(
    .INIT(1'b0)) 
     pll_reset_asserted_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_pll_reset_asserted_i_1),
        .Q(n_0_pll_reset_asserted_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_QPLLLOCK),
        .Q(reset_time_out),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFEFF0002)) 
     run_phase_alignment_int_i_1
       (.I0(tx_state[3]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_out),
        .Q(run_phase_alignment_int_s3),
        .R(1'b0));
XLAUI_XLAUI_sync_block__parameterized0_50 sync_QPLLLOCK
       (.E(n_1_sync_QPLLLOCK),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .I1(n_0_init_wait_done_reg),
        .I2(\n_0_FSM_sequential_tx_state[3]_i_4 ),
        .I3(n_0_time_out_500us_reg),
        .I4(n_0_time_out_2ms_reg),
        .I5(n_0_time_tlock_max_reg),
        .I6(n_0_pll_reset_asserted_reg),
        .O1(n_0_sync_QPLLLOCK),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(tx_state),
        .reset_time_out(reset_time_out),
        .txresetdone_s3(txresetdone_s3),
        .wait_time_done(wait_time_done));
XLAUI_XLAUI_sync_block__parameterized0_51 sync_TXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(txresetdone_s2),
        .gt0_txresetdone_out(gt0_txresetdone_out));
XLAUI_XLAUI_sync_block__parameterized0_52 sync_mmcm_lock_reclocked
       (.GT0_TX_MMCM_LOCK_IN(GT0_TX_MMCM_LOCK_IN),
        .I1(\n_0_mmcm_lock_count[7]_i_4 ),
        .O1(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(n_0_sync_mmcm_lock_reclocked),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked));
XLAUI_XLAUI_sync_block__parameterized0_53 sync_run_phase_alignment_int
       (.data_in(n_0_run_phase_alignment_int_reg),
        .data_out(data_out),
        .gt0_txusrclk_in(gt0_txusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_54 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
XLAUI_XLAUI_sync_block__parameterized0_55 sync_tx_fsm_reset_done_int
       (.GT0_TX_FSM_RESET_DONE_OUT(GT0_TX_FSM_RESET_DONE_OUT),
        .data_out(tx_fsm_reset_done_int_s2),
        .gt0_txusrclk_in(gt0_txusrclk_in));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT3 #(
    .INIT(8'h0E)) 
     time_out_2ms_i_1
       (.I0(n_0_time_out_2ms_reg),
        .I1(time_out_2ms),
        .I2(reset_time_out),
        .O(n_0_time_out_2ms_i_1));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1),
        .Q(n_0_time_out_2ms_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000BAAAAAAA)) 
     time_out_500us_i_1__3
       (.I0(n_0_time_out_500us_reg),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[8]),
        .I3(n_0_time_out_500us_i_2__4),
        .I4(n_0_time_out_500us_i_3__4),
        .I5(reset_time_out),
        .O(n_0_time_out_500us_i_1__3));
LUT5 #(
    .INIT(32'h00400000)) 
     time_out_500us_i_2__4
       (.I0(\n_0_time_out_counter[0]_i_11 ),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[12]),
        .I4(\n_0_time_out_counter[0]_i_10 ),
        .O(n_0_time_out_500us_i_2__4));
LUT6 #(
    .INIT(64'h0000000000000040)) 
     time_out_500us_i_3__4
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[4]),
        .I4(time_out_counter_reg[3]),
        .I5(time_out_counter_reg[18]),
        .O(n_0_time_out_500us_i_3__4));
FDRE #(
    .INIT(1'b0)) 
     time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_500us_i_1__3),
        .Q(n_0_time_out_500us_reg),
        .R(1'b0));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_1 
       (.I0(time_out_2ms),
        .O(\n_0_time_out_counter[0]_i_1 ));
LUT4 #(
    .INIT(16'h0001)) 
     \time_out_counter[0]_i_10 
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[13]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[0]_i_10 ));
LUT4 #(
    .INIT(16'hFFF7)) 
     \time_out_counter[0]_i_11 
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[16]),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_11 ));
LUT6 #(
    .INIT(64'h0080000000000000)) 
     \time_out_counter[0]_i_3__3 
       (.I0(\n_0_time_out_counter[0]_i_8__3 ),
        .I1(\n_0_time_out_counter[0]_i_9 ),
        .I2(\n_0_time_out_counter[0]_i_10 ),
        .I3(\n_0_time_out_counter[0]_i_11 ),
        .I4(time_out_counter_reg[2]),
        .I5(time_out_counter_reg[10]),
        .O(time_out_2ms));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_4__3 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_4__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_5 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_6 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_7 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_7 ));
LUT3 #(
    .INIT(8'h04)) 
     \time_out_counter[0]_i_8__3 
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[0]_i_8__3 ));
LUT6 #(
    .INIT(64'h0004000000000000)) 
     \time_out_counter[0]_i_9 
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[18]),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[4]),
        .I5(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[0]_i_9 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5 ));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2 ,\n_1_time_out_counter_reg[0]_i_2 ,\n_2_time_out_counter_reg[0]_i_2 ,\n_3_time_out_counter_reg[0]_i_2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2 ,\n_5_time_out_counter_reg[0]_i_2 ,\n_6_time_out_counter_reg[0]_i_2 ,\n_7_time_out_counter_reg[0]_i_2 }),
        .S({\n_0_time_out_counter[0]_i_4__3 ,\n_0_time_out_counter[0]_i_5 ,\n_0_time_out_counter[0]_i_6 ,\n_0_time_out_counter[0]_i_7 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[12]_i_1 
       (.CI(\n_0_time_out_counter_reg[8]_i_1 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1 ,\n_1_time_out_counter_reg[12]_i_1 ,\n_2_time_out_counter_reg[12]_i_1 ,\n_3_time_out_counter_reg[12]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1 ,\n_5_time_out_counter_reg[12]_i_1 ,\n_6_time_out_counter_reg[12]_i_1 ,\n_7_time_out_counter_reg[12]_i_1 }),
        .S({\n_0_time_out_counter[12]_i_2 ,\n_0_time_out_counter[12]_i_3 ,\n_0_time_out_counter[12]_i_4 ,\n_0_time_out_counter[12]_i_5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[16]_i_1 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[16]_i_1 
       (.CI(\n_0_time_out_counter_reg[12]_i_1 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1_CO_UNCONNECTED [3:2],\n_2_time_out_counter_reg[16]_i_1 ,\n_3_time_out_counter_reg[16]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1_O_UNCONNECTED [3],\n_5_time_out_counter_reg[16]_i_1 ,\n_6_time_out_counter_reg[16]_i_1 ,\n_7_time_out_counter_reg[16]_i_1 }),
        .S({1'b0,\n_0_time_out_counter[16]_i_2 ,\n_0_time_out_counter[16]_i_3 ,\n_0_time_out_counter[16]_i_4 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[16]_i_1 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[16]_i_1 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[4]_i_1 
       (.CI(\n_0_time_out_counter_reg[0]_i_2 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1 ,\n_1_time_out_counter_reg[4]_i_1 ,\n_2_time_out_counter_reg[4]_i_1 ,\n_3_time_out_counter_reg[4]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1 ,\n_5_time_out_counter_reg[4]_i_1 ,\n_6_time_out_counter_reg[4]_i_1 ,\n_7_time_out_counter_reg[4]_i_1 }),
        .S({\n_0_time_out_counter[4]_i_2 ,\n_0_time_out_counter[4]_i_3 ,\n_0_time_out_counter[4]_i_4 ,\n_0_time_out_counter[4]_i_5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[8]_i_1 
       (.CI(\n_0_time_out_counter_reg[4]_i_1 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1 ,\n_1_time_out_counter_reg[8]_i_1 ,\n_2_time_out_counter_reg[8]_i_1 ,\n_3_time_out_counter_reg[8]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1 ,\n_5_time_out_counter_reg[8]_i_1 ,\n_6_time_out_counter_reg[8]_i_1 ,\n_7_time_out_counter_reg[8]_i_1 }),
        .S({\n_0_time_out_counter[8]_i_2 ,\n_0_time_out_counter[8]_i_3 ,\n_0_time_out_counter[8]_i_4 ,\n_0_time_out_counter[8]_i_5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1
       (.I0(\n_0_wait_bypass_count[0]_i_4 ),
        .I1(\n_0_wait_bypass_count[0]_i_5 ),
        .I2(\n_0_wait_bypass_count[0]_i_6 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(tx_fsm_reset_done_int_s3),
        .I5(run_phase_alignment_int_s3),
        .O(n_0_time_out_wait_bypass_i_1));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT3 #(
    .INIT(8'h0E)) 
     time_tlock_max_i_1
       (.I0(n_0_time_tlock_max_reg),
        .I1(time_tlock_max),
        .I2(reset_time_out),
        .O(n_0_time_tlock_max_i_1));
LUT6 #(
    .INIT(64'h0040000000000000)) 
     time_tlock_max_i_2__0
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[8]),
        .I2(\n_0_time_out_counter[0]_i_10 ),
        .I3(time_out_counter_reg[10]),
        .I4(n_0_time_tlock_max_i_3__1),
        .I5(n_0_time_tlock_max_i_4__3),
        .O(time_tlock_max));
LUT6 #(
    .INIT(64'h0000000000400000)) 
     time_tlock_max_i_3__1
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[4]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[3]),
        .I5(time_out_counter_reg[18]),
        .O(n_0_time_tlock_max_i_3__1));
LUT6 #(
    .INIT(64'h0000000000000010)) 
     time_tlock_max_i_4__3
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[2]),
        .I2(time_out_counter_reg[1]),
        .I3(time_out_counter_reg[0]),
        .I4(time_out_counter_reg[17]),
        .I5(time_out_counter_reg[16]),
        .O(n_0_time_tlock_max_i_4__3));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1),
        .Q(n_0_time_tlock_max_reg),
        .R(1'b0));
LUT5 #(
    .INIT(32'hFFFF0200)) 
     tx_fsm_reset_done_int_i_1
       (.I0(tx_state[3]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(GT0_TX_FSM_RESET_DONE_OUT),
        .O(n_0_tx_fsm_reset_done_int_i_1));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_tx_fsm_reset_done_int_i_1),
        .Q(GT0_TX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_s3_reg
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_s2),
        .Q(tx_fsm_reset_done_int_s3),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     txresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(txresetdone_s2),
        .Q(txresetdone_s3),
        .R(1'b0));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1 
       (.I0(run_phase_alignment_int_s3),
        .O(\n_0_wait_bypass_count[0]_i_1 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_10 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_10 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2 
       (.I0(\n_0_wait_bypass_count[0]_i_4 ),
        .I1(\n_0_wait_bypass_count[0]_i_5 ),
        .I2(\n_0_wait_bypass_count[0]_i_6 ),
        .I3(tx_fsm_reset_done_int_s3),
        .O(\n_0_wait_bypass_count[0]_i_2 ));
LUT5 #(
    .INIT(32'hBFFFFFFF)) 
     \wait_bypass_count[0]_i_4 
       (.I0(wait_bypass_count_reg[15]),
        .I1(wait_bypass_count_reg[1]),
        .I2(wait_bypass_count_reg[2]),
        .I3(wait_bypass_count_reg[16]),
        .I4(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_4 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFDFF)) 
     \wait_bypass_count[0]_i_5 
       (.I0(wait_bypass_count_reg[10]),
        .I1(wait_bypass_count_reg[9]),
        .I2(wait_bypass_count_reg[14]),
        .I3(wait_bypass_count_reg[13]),
        .I4(wait_bypass_count_reg[11]),
        .I5(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[0]_i_5 ));
LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_6 
       (.I0(wait_bypass_count_reg[4]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[7]),
        .I3(wait_bypass_count_reg[8]),
        .I4(wait_bypass_count_reg[5]),
        .I5(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[0]_i_6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_7 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_8 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_9__3 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_9__3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2 
       (.I0(wait_bypass_count_reg[15]),
        .O(\n_0_wait_bypass_count[12]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_3 
       (.I0(wait_bypass_count_reg[14]),
        .O(\n_0_wait_bypass_count[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_4 
       (.I0(wait_bypass_count_reg[13]),
        .O(\n_0_wait_bypass_count[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_5 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[16]_i_2 
       (.I0(wait_bypass_count_reg[16]),
        .O(\n_0_wait_bypass_count[16]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5 ));
FDRE \wait_bypass_count_reg[0] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3 ,\n_1_wait_bypass_count_reg[0]_i_3 ,\n_2_wait_bypass_count_reg[0]_i_3 ,\n_3_wait_bypass_count_reg[0]_i_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3 ,\n_5_wait_bypass_count_reg[0]_i_3 ,\n_6_wait_bypass_count_reg[0]_i_3 ,\n_7_wait_bypass_count_reg[0]_i_3 }),
        .S({\n_0_wait_bypass_count[0]_i_7 ,\n_0_wait_bypass_count[0]_i_8 ,\n_0_wait_bypass_count[0]_i_9__3 ,\n_0_wait_bypass_count[0]_i_10 }));
FDRE \wait_bypass_count_reg[10] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[11] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[12] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[12]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1 ),
        .CO({\n_0_wait_bypass_count_reg[12]_i_1 ,\n_1_wait_bypass_count_reg[12]_i_1 ,\n_2_wait_bypass_count_reg[12]_i_1 ,\n_3_wait_bypass_count_reg[12]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[12]_i_1 ,\n_5_wait_bypass_count_reg[12]_i_1 ,\n_6_wait_bypass_count_reg[12]_i_1 ,\n_7_wait_bypass_count_reg[12]_i_1 }),
        .S({\n_0_wait_bypass_count[12]_i_2 ,\n_0_wait_bypass_count[12]_i_3 ,\n_0_wait_bypass_count[12]_i_4 ,\n_0_wait_bypass_count[12]_i_5 }));
FDRE \wait_bypass_count_reg[13] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[13]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[14] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[14]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[15] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[15]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[16] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[16]_i_1 ),
        .Q(wait_bypass_count_reg[16]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[16]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[12]_i_1 ),
        .CO(\NLW_wait_bypass_count_reg[16]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[16]_i_1_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[16]_i_1 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[16]_i_2 }));
FDRE \wait_bypass_count_reg[1] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[2] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[3] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[4] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[4]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1 ,\n_1_wait_bypass_count_reg[4]_i_1 ,\n_2_wait_bypass_count_reg[4]_i_1 ,\n_3_wait_bypass_count_reg[4]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1 ,\n_5_wait_bypass_count_reg[4]_i_1 ,\n_6_wait_bypass_count_reg[4]_i_1 ,\n_7_wait_bypass_count_reg[4]_i_1 }),
        .S({\n_0_wait_bypass_count[4]_i_2 ,\n_0_wait_bypass_count[4]_i_3 ,\n_0_wait_bypass_count[4]_i_4 ,\n_0_wait_bypass_count[4]_i_5 }));
FDRE \wait_bypass_count_reg[5] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[6] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[7] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[8] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[8]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1 ,\n_1_wait_bypass_count_reg[8]_i_1 ,\n_2_wait_bypass_count_reg[8]_i_1 ,\n_3_wait_bypass_count_reg[8]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1 ,\n_5_wait_bypass_count_reg[8]_i_1 ,\n_6_wait_bypass_count_reg[8]_i_1 ,\n_7_wait_bypass_count_reg[8]_i_1 }),
        .S({\n_0_wait_bypass_count[8]_i_2 ,\n_0_wait_bypass_count[8]_i_3 ,\n_0_wait_bypass_count[8]_i_4 ,\n_0_wait_bypass_count[8]_i_5 }));
FDRE \wait_bypass_count_reg[9] 
       (.C(gt0_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair23" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
(* SOFT_HLUTNM = "soft_lutpair23" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\n_0_wait_time_cnt[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[2]));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \wait_time_cnt[3]_i_1 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0[3]));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\n_0_wait_time_cnt[4]_i_1 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[5]_i_1 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[1]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[5]));
LUT4 #(
    .INIT(16'h0700)) 
     \wait_time_cnt[6]_i_1 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[3]),
        .I3(tx_state[0]),
        .O(clear));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_2 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(wait_time_cnt_reg__0[5]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .I5(\n_0_wait_time_cnt[6]_i_4 ),
        .O(\n_0_wait_time_cnt[6]_i_2 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[6]_i_3 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4 ),
        .I2(wait_time_cnt_reg__0[3]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[5]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[6]));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_4 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(\n_0_wait_time_cnt[6]_i_4 ));
FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2 ),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(clear));
FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2 ),
        .D(\n_0_wait_time_cnt[1]_i_1 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(clear));
FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2 ),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(clear));
FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2 ),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(clear));
FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2 ),
        .D(\n_0_wait_time_cnt[4]_i_1 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(clear));
FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2 ),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(clear));
FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2 ),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(clear));
endmodule

(* ORIG_REF_NAME = "XLAUI_TX_STARTUP_FSM" *) 
module XLAUI_XLAUI_TX_STARTUP_FSM__parameterized0_1
   (O1,
    GT1_TX_MMCM_RESET_OUT,
    GT1_TX_FSM_RESET_DONE_OUT,
    O2,
    SYSCLK_IN,
    gt1_txusrclk_in,
    SOFT_RESET_IN,
    gt1_txresetdone_out,
    GT1_TX_MMCM_LOCK_IN,
    GT0_QPLLLOCK_IN);
  output O1;
  output GT1_TX_MMCM_RESET_OUT;
  output GT1_TX_FSM_RESET_DONE_OUT;
  output O2;
  input SYSCLK_IN;
  input gt1_txusrclk_in;
  input SOFT_RESET_IN;
  input gt1_txresetdone_out;
  input GT1_TX_MMCM_LOCK_IN;
  input GT0_QPLLLOCK_IN;

  wire GT0_QPLLLOCK_IN;
  wire GT1_TX_FSM_RESET_DONE_OUT;
  wire GT1_TX_MMCM_LOCK_IN;
  wire GT1_TX_MMCM_RESET_OUT;
  wire O1;
  wire O2;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire data_out;
  wire gt1_txresetdone_out;
  wire gt1_txusrclk_in;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_tx_state[0]_i_1__0 ;
  wire \n_0_FSM_sequential_tx_state[0]_i_2__0 ;
  wire \n_0_FSM_sequential_tx_state[1]_i_1__0 ;
  wire \n_0_FSM_sequential_tx_state[1]_i_2__0 ;
  wire \n_0_FSM_sequential_tx_state[2]_i_1__0 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_2__0 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_4__0 ;
  wire n_0_MMCM_RESET_i_1__0;
  wire n_0_TXUSERRDY_i_1__0;
  wire n_0_gttxreset_i_i_1__0;
  wire \n_0_init_wait_count[6]_i_1__0 ;
  wire \n_0_init_wait_count[6]_i_3__0 ;
  wire \n_0_init_wait_count[6]_i_4__0 ;
  wire n_0_init_wait_done_i_1__0;
  wire n_0_init_wait_done_reg;
  wire \n_0_mmcm_lock_count[6]_i_2__0 ;
  wire \n_0_mmcm_lock_count[7]_i_2__0 ;
  wire \n_0_mmcm_lock_count[7]_i_4__0 ;
  wire n_0_pll_reset_asserted_i_1__0;
  wire n_0_pll_reset_asserted_reg;
  wire n_0_reset_time_out_reg;
  wire n_0_run_phase_alignment_int_i_1__0;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_run_phase_alignment_int_s3_reg;
  wire n_0_sync_QPLLLOCK;
  wire n_0_sync_mmcm_lock_reclocked;
  wire n_0_time_out_2ms_i_1__0;
  wire n_0_time_out_2ms_reg;
  wire n_0_time_out_500us_i_1__4;
  wire n_0_time_out_500us_i_2;
  wire n_0_time_out_500us_i_3__3;
  wire n_0_time_out_500us_i_4__4;
  wire n_0_time_out_500us_reg;
  wire \n_0_time_out_counter[0]_i_10__0 ;
  wire \n_0_time_out_counter[0]_i_11__0 ;
  wire \n_0_time_out_counter[0]_i_1__0 ;
  wire \n_0_time_out_counter[0]_i_4__4 ;
  wire \n_0_time_out_counter[0]_i_5__0 ;
  wire \n_0_time_out_counter[0]_i_6__0 ;
  wire \n_0_time_out_counter[0]_i_7__0 ;
  wire \n_0_time_out_counter[0]_i_8__4 ;
  wire \n_0_time_out_counter[0]_i_9__0 ;
  wire \n_0_time_out_counter[12]_i_2__0 ;
  wire \n_0_time_out_counter[12]_i_3__0 ;
  wire \n_0_time_out_counter[12]_i_4__0 ;
  wire \n_0_time_out_counter[12]_i_5__0 ;
  wire \n_0_time_out_counter[16]_i_2__0 ;
  wire \n_0_time_out_counter[16]_i_3__0 ;
  wire \n_0_time_out_counter[16]_i_4__0 ;
  wire \n_0_time_out_counter[4]_i_2__0 ;
  wire \n_0_time_out_counter[4]_i_3__0 ;
  wire \n_0_time_out_counter[4]_i_4__0 ;
  wire \n_0_time_out_counter[4]_i_5__0 ;
  wire \n_0_time_out_counter[8]_i_2__0 ;
  wire \n_0_time_out_counter[8]_i_3__0 ;
  wire \n_0_time_out_counter[8]_i_4__0 ;
  wire \n_0_time_out_counter[8]_i_5__0 ;
  wire \n_0_time_out_counter_reg[0]_i_2__0 ;
  wire \n_0_time_out_counter_reg[12]_i_1__0 ;
  wire \n_0_time_out_counter_reg[4]_i_1__0 ;
  wire \n_0_time_out_counter_reg[8]_i_1__0 ;
  wire n_0_time_out_wait_bypass_i_1__0;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_1__0;
  wire n_0_time_tlock_max_i_2__2;
  wire n_0_time_tlock_max_i_3;
  wire n_0_time_tlock_max_i_4__4;
  wire n_0_time_tlock_max_reg;
  wire n_0_tx_fsm_reset_done_int_i_1__0;
  wire n_0_tx_fsm_reset_done_int_s3_reg;
  wire \n_0_wait_bypass_count[0]_i_10__0 ;
  wire \n_0_wait_bypass_count[0]_i_1__0 ;
  wire \n_0_wait_bypass_count[0]_i_2__0 ;
  wire \n_0_wait_bypass_count[0]_i_4__0 ;
  wire \n_0_wait_bypass_count[0]_i_5__0 ;
  wire \n_0_wait_bypass_count[0]_i_6__0 ;
  wire \n_0_wait_bypass_count[0]_i_7__0 ;
  wire \n_0_wait_bypass_count[0]_i_8__0 ;
  wire \n_0_wait_bypass_count[0]_i_9__4 ;
  wire \n_0_wait_bypass_count[12]_i_2__0 ;
  wire \n_0_wait_bypass_count[12]_i_3__0 ;
  wire \n_0_wait_bypass_count[12]_i_4__0 ;
  wire \n_0_wait_bypass_count[12]_i_5__0 ;
  wire \n_0_wait_bypass_count[16]_i_2__0 ;
  wire \n_0_wait_bypass_count[4]_i_2__0 ;
  wire \n_0_wait_bypass_count[4]_i_3__0 ;
  wire \n_0_wait_bypass_count[4]_i_4__0 ;
  wire \n_0_wait_bypass_count[4]_i_5__0 ;
  wire \n_0_wait_bypass_count[8]_i_2__0 ;
  wire \n_0_wait_bypass_count[8]_i_3__0 ;
  wire \n_0_wait_bypass_count[8]_i_4__0 ;
  wire \n_0_wait_bypass_count[8]_i_5__0 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_0_wait_bypass_count_reg[12]_i_1__0 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_0_wait_time_cnt[1]_i_1__0 ;
  wire \n_0_wait_time_cnt[4]_i_1__0 ;
  wire \n_0_wait_time_cnt[6]_i_1__0 ;
  wire \n_0_wait_time_cnt[6]_i_2__0 ;
  wire \n_0_wait_time_cnt[6]_i_4__0 ;
  wire n_1_sync_QPLLLOCK;
  wire n_1_sync_mmcm_lock_reclocked;
  wire \n_1_time_out_counter_reg[0]_i_2__0 ;
  wire \n_1_time_out_counter_reg[12]_i_1__0 ;
  wire \n_1_time_out_counter_reg[4]_i_1__0 ;
  wire \n_1_time_out_counter_reg[8]_i_1__0 ;
  wire \n_1_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_1_wait_bypass_count_reg[12]_i_1__0 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_2_time_out_counter_reg[0]_i_2__0 ;
  wire \n_2_time_out_counter_reg[12]_i_1__0 ;
  wire \n_2_time_out_counter_reg[16]_i_1__0 ;
  wire \n_2_time_out_counter_reg[4]_i_1__0 ;
  wire \n_2_time_out_counter_reg[8]_i_1__0 ;
  wire \n_2_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_2_wait_bypass_count_reg[12]_i_1__0 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_3_time_out_counter_reg[0]_i_2__0 ;
  wire \n_3_time_out_counter_reg[12]_i_1__0 ;
  wire \n_3_time_out_counter_reg[16]_i_1__0 ;
  wire \n_3_time_out_counter_reg[4]_i_1__0 ;
  wire \n_3_time_out_counter_reg[8]_i_1__0 ;
  wire \n_3_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_3_wait_bypass_count_reg[12]_i_1__0 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_4_time_out_counter_reg[0]_i_2__0 ;
  wire \n_4_time_out_counter_reg[12]_i_1__0 ;
  wire \n_4_time_out_counter_reg[4]_i_1__0 ;
  wire \n_4_time_out_counter_reg[8]_i_1__0 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_4_wait_bypass_count_reg[12]_i_1__0 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_5_time_out_counter_reg[0]_i_2__0 ;
  wire \n_5_time_out_counter_reg[12]_i_1__0 ;
  wire \n_5_time_out_counter_reg[16]_i_1__0 ;
  wire \n_5_time_out_counter_reg[4]_i_1__0 ;
  wire \n_5_time_out_counter_reg[8]_i_1__0 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_5_wait_bypass_count_reg[12]_i_1__0 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_6_time_out_counter_reg[0]_i_2__0 ;
  wire \n_6_time_out_counter_reg[12]_i_1__0 ;
  wire \n_6_time_out_counter_reg[16]_i_1__0 ;
  wire \n_6_time_out_counter_reg[4]_i_1__0 ;
  wire \n_6_time_out_counter_reg[8]_i_1__0 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_6_wait_bypass_count_reg[12]_i_1__0 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_7_time_out_counter_reg[0]_i_2__0 ;
  wire \n_7_time_out_counter_reg[12]_i_1__0 ;
  wire \n_7_time_out_counter_reg[16]_i_1__0 ;
  wire \n_7_time_out_counter_reg[4]_i_1__0 ;
  wire \n_7_time_out_counter_reg[8]_i_1__0 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1__0 ;
  wire \n_7_wait_bypass_count_reg[16]_i_1__0 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1__0 ;
  wire [6:0]p_0_in__1;
  wire [7:0]p_0_in__2;
  wire time_out_2ms;
  wire [18:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire tx_fsm_reset_done_int_s2;
(* RTL_KEEP = "yes" *)   wire [3:0]tx_state;
  wire tx_state12_out;
  wire tx_state13_out;
  wire txresetdone_s2;
  wire txresetdone_s3;
  wire [16:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0__0;
  wire [6:0]wait_time_cnt_reg__0;
  wire wait_time_done;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__0_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__0_O_UNCONNECTED ;
  wire [3:0]\NLW_wait_bypass_count_reg[16]_i_1__0_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[16]_i_1__0_O_UNCONNECTED ;

LUT5 #(
    .INIT(32'h0F001F1F)) 
     \FSM_sequential_tx_state[0]_i_1__0 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[3]),
        .I3(\n_0_FSM_sequential_tx_state[0]_i_2__0 ),
        .I4(tx_state[0]),
        .O(\n_0_FSM_sequential_tx_state[0]_i_1__0 ));
LUT6 #(
    .INIT(64'h22F0000022F0FFFF)) 
     \FSM_sequential_tx_state[0]_i_2__0 
       (.I0(n_0_time_out_500us_reg),
        .I1(n_0_reset_time_out_reg),
        .I2(n_0_time_out_2ms_reg),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .I5(\n_0_FSM_sequential_tx_state[1]_i_2__0 ),
        .O(\n_0_FSM_sequential_tx_state[0]_i_2__0 ));
LUT4 #(
    .INIT(16'h0062)) 
     \FSM_sequential_tx_state[1]_i_1__0 
       (.I0(tx_state[1]),
        .I1(tx_state[0]),
        .I2(\n_0_FSM_sequential_tx_state[1]_i_2__0 ),
        .I3(tx_state[3]),
        .O(\n_0_FSM_sequential_tx_state[1]_i_1__0 ));
LUT4 #(
    .INIT(16'hFFDF)) 
     \FSM_sequential_tx_state[1]_i_2__0 
       (.I0(tx_state[2]),
        .I1(mmcm_lock_reclocked),
        .I2(n_0_time_tlock_max_reg),
        .I3(n_0_reset_time_out_reg),
        .O(\n_0_FSM_sequential_tx_state[1]_i_2__0 ));
LUT6 #(
    .INIT(64'h00000000222A662A)) 
     \FSM_sequential_tx_state[2]_i_1__0 
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state13_out),
        .I3(tx_state[1]),
        .I4(n_0_time_out_2ms_reg),
        .I5(tx_state[3]),
        .O(\n_0_FSM_sequential_tx_state[2]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair41" *) 
   LUT3 #(
    .INIT(8'h04)) 
     \FSM_sequential_tx_state[2]_i_2__0 
       (.I0(n_0_reset_time_out_reg),
        .I1(n_0_time_tlock_max_reg),
        .I2(mmcm_lock_reclocked),
        .O(tx_state13_out));
LUT6 #(
    .INIT(64'h0300004C00000044)) 
     \FSM_sequential_tx_state[3]_i_2__0 
       (.I0(time_out_wait_bypass_s3),
        .I1(tx_state[3]),
        .I2(tx_state12_out),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .I5(tx_state[0]),
        .O(\n_0_FSM_sequential_tx_state[3]_i_2__0 ));
LUT2 #(
    .INIT(4'h1)) 
     \FSM_sequential_tx_state[3]_i_4__0 
       (.I0(tx_state[2]),
        .I1(tx_state[1]),
        .O(\n_0_FSM_sequential_tx_state[3]_i_4__0 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_sequential_tx_state[3]_i_5__0 
       (.I0(\n_0_wait_time_cnt[6]_i_4__0 ),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[5]),
        .I4(wait_time_cnt_reg__0[4]),
        .I5(wait_time_cnt_reg__0[6]),
        .O(wait_time_done));
(* SOFT_HLUTNM = "soft_lutpair41" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_tx_state[3]_i_6__0 
       (.I0(n_0_time_out_500us_reg),
        .I1(n_0_reset_time_out_reg),
        .O(tx_state12_out));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[0]_i_1__0 ),
        .Q(tx_state[0]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[1]_i_1__0 ),
        .Q(tx_state[1]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[2]_i_1__0 ),
        .Q(tx_state[2]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[3]_i_2__0 ),
        .Q(tx_state[3]),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFDF0010)) 
     MMCM_RESET_i_1__0
       (.I0(tx_state[2]),
        .I1(tx_state[1]),
        .I2(tx_state[0]),
        .I3(tx_state[3]),
        .I4(GT1_TX_MMCM_RESET_OUT),
        .O(n_0_MMCM_RESET_i_1__0));
FDRE #(
    .INIT(1'b1)) 
     MMCM_RESET_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_MMCM_RESET_i_1__0),
        .Q(GT1_TX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD0080)) 
     TXUSERRDY_i_1__0
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[3]),
        .I4(O2),
        .O(n_0_TXUSERRDY_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     TXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_TXUSERRDY_i_1__0),
        .Q(O2),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0010)) 
     gttxreset_i_i_1__0
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[0]),
        .I3(tx_state[3]),
        .I4(O1),
        .O(n_0_gttxreset_i_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     gttxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gttxreset_i_i_1__0),
        .Q(O1),
        .R(SOFT_RESET_IN));
(* SOFT_HLUTNM = "soft_lutpair45" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1__0 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in__1[0]));
(* SOFT_HLUTNM = "soft_lutpair45" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1__0 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in__1[1]));
(* SOFT_HLUTNM = "soft_lutpair39" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[2]_i_1__0 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .O(p_0_in__1[2]));
(* SOFT_HLUTNM = "soft_lutpair39" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \init_wait_count[3]_i_1__0 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .O(p_0_in__1[3]));
(* SOFT_HLUTNM = "soft_lutpair36" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \init_wait_count[4]_i_1__0 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .O(p_0_in__1[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \init_wait_count[5]_i_1__0 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .I5(init_wait_count_reg__0[4]),
        .O(p_0_in__1[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
     \init_wait_count[6]_i_1__0 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[0]),
        .I3(\n_0_init_wait_count[6]_i_3__0 ),
        .I4(init_wait_count_reg__0[4]),
        .I5(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_1__0 ));
LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[6]_i_2__0 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\n_0_init_wait_count[6]_i_4__0 ),
        .I2(init_wait_count_reg__0[5]),
        .O(p_0_in__1[6]));
LUT2 #(
    .INIT(4'h7)) 
     \init_wait_count[6]_i_3__0 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_3__0 ));
(* SOFT_HLUTNM = "soft_lutpair36" *) 
   LUT5 #(
    .INIT(32'h80000000)) 
     \init_wait_count[6]_i_4__0 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_4__0 ));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__1[0]),
        .Q(init_wait_count_reg__0[0]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__1[1]),
        .Q(init_wait_count_reg__0[1]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__1[2]),
        .Q(init_wait_count_reg__0[2]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__1[3]),
        .Q(init_wait_count_reg__0[3]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__1[4]),
        .Q(init_wait_count_reg__0[4]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__1[5]),
        .Q(init_wait_count_reg__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__1[6]),
        .Q(init_wait_count_reg__0[6]));
LUT2 #(
    .INIT(4'hE)) 
     init_wait_done_i_1__0
       (.I0(init_wait_done),
        .I1(n_0_init_wait_done_reg),
        .O(n_0_init_wait_done_i_1__0));
LUT6 #(
    .INIT(64'h0000000004000000)) 
     init_wait_done_i_2__0
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[4]),
        .I2(\n_0_init_wait_count[6]_i_3__0 ),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_done));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(n_0_init_wait_done_i_1__0),
        .Q(n_0_init_wait_done_reg));
(* SOFT_HLUTNM = "soft_lutpair44" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__2[0]));
(* SOFT_HLUTNM = "soft_lutpair44" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__2[1]));
(* SOFT_HLUTNM = "soft_lutpair43" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[2]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__2[2]));
(* SOFT_HLUTNM = "soft_lutpair37" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \mmcm_lock_count[3]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__2[3]));
(* SOFT_HLUTNM = "soft_lutpair37" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \mmcm_lock_count[4]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[3]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__2[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[5]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__2[5]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[6]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(\n_0_mmcm_lock_count[6]_i_2__0 ),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__2[6]));
(* SOFT_HLUTNM = "soft_lutpair43" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \mmcm_lock_count[6]_i_2__0 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(\n_0_mmcm_lock_count[6]_i_2__0 ));
LUT3 #(
    .INIT(8'h7F)) 
     \mmcm_lock_count[7]_i_2__0 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__0 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(\n_0_mmcm_lock_count[7]_i_2__0 ));
LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[7]_i_3__0 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__0 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__2[7]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \mmcm_lock_count[7]_i_4__0 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(\n_0_mmcm_lock_count[7]_i_4__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__0 ),
        .D(p_0_in__2[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__0 ),
        .D(p_0_in__2[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__0 ),
        .D(p_0_in__2[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__0 ),
        .D(p_0_in__2[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__0 ),
        .D(p_0_in__2[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__0 ),
        .D(p_0_in__2[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__0 ),
        .D(p_0_in__2[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__0 ),
        .D(p_0_in__2[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
LUT5 #(
    .INIT(32'hF0F0F072)) 
     pll_reset_asserted_i_1__0
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(n_0_pll_reset_asserted_reg),
        .I3(tx_state[2]),
        .I4(tx_state[3]),
        .O(n_0_pll_reset_asserted_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     pll_reset_asserted_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_pll_reset_asserted_i_1__0),
        .Q(n_0_pll_reset_asserted_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_QPLLLOCK),
        .Q(n_0_reset_time_out_reg),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFEFF0002)) 
     run_phase_alignment_int_i_1__0
       (.I0(tx_state[3]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1__0),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_out),
        .Q(n_0_run_phase_alignment_int_s3_reg),
        .R(1'b0));
XLAUI_XLAUI_sync_block__parameterized0_35 sync_QPLLLOCK
       (.E(n_1_sync_QPLLLOCK),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .I1(n_0_init_wait_done_reg),
        .I2(n_0_reset_time_out_reg),
        .I3(\n_0_FSM_sequential_tx_state[3]_i_4__0 ),
        .I4(n_0_time_out_500us_reg),
        .I5(n_0_time_out_2ms_reg),
        .I6(n_0_time_tlock_max_reg),
        .I7(n_0_pll_reset_asserted_reg),
        .O1(n_0_sync_QPLLLOCK),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(tx_state),
        .txresetdone_s3(txresetdone_s3),
        .wait_time_done(wait_time_done));
XLAUI_XLAUI_sync_block__parameterized0_36 sync_TXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(txresetdone_s2),
        .gt1_txresetdone_out(gt1_txresetdone_out));
XLAUI_XLAUI_sync_block__parameterized0_37 sync_mmcm_lock_reclocked
       (.GT1_TX_MMCM_LOCK_IN(GT1_TX_MMCM_LOCK_IN),
        .I1(\n_0_mmcm_lock_count[7]_i_4__0 ),
        .O1(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(n_0_sync_mmcm_lock_reclocked),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked));
XLAUI_XLAUI_sync_block__parameterized0_38 sync_run_phase_alignment_int
       (.data_in(n_0_run_phase_alignment_int_reg),
        .data_out(data_out),
        .gt1_txusrclk_in(gt1_txusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_39 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
XLAUI_XLAUI_sync_block__parameterized0_40 sync_tx_fsm_reset_done_int
       (.GT1_TX_FSM_RESET_DONE_OUT(GT1_TX_FSM_RESET_DONE_OUT),
        .data_out(tx_fsm_reset_done_int_s2),
        .gt1_txusrclk_in(gt1_txusrclk_in));
LUT3 #(
    .INIT(8'h0E)) 
     time_out_2ms_i_1__0
       (.I0(n_0_time_out_2ms_reg),
        .I1(time_out_2ms),
        .I2(n_0_reset_time_out_reg),
        .O(n_0_time_out_2ms_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1__0),
        .Q(n_0_time_out_2ms_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000ABAAAAAA)) 
     time_out_500us_i_1__4
       (.I0(n_0_time_out_500us_reg),
        .I1(n_0_time_out_500us_i_2),
        .I2(time_out_counter_reg[9]),
        .I3(time_out_counter_reg[8]),
        .I4(n_0_time_out_500us_i_3__3),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_time_out_500us_i_1__4));
(* SOFT_HLUTNM = "soft_lutpair42" *) 
   LUT2 #(
    .INIT(4'hE)) 
     time_out_500us_i_2
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[18]),
        .O(n_0_time_out_500us_i_2));
LUT5 #(
    .INIT(32'h00800000)) 
     time_out_500us_i_3__3
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[2]),
        .I2(\n_0_time_out_counter[0]_i_10__0 ),
        .I3(\n_0_time_out_counter[0]_i_11__0 ),
        .I4(n_0_time_out_500us_i_4__4),
        .O(n_0_time_out_500us_i_3__3));
LUT5 #(
    .INIT(32'h00000020)) 
     time_out_500us_i_4__4
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[4]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[3]),
        .I4(time_out_counter_reg[17]),
        .O(n_0_time_out_500us_i_4__4));
FDRE #(
    .INIT(1'b0)) 
     time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_500us_i_1__4),
        .Q(n_0_time_out_500us_reg),
        .R(1'b0));
LUT4 #(
    .INIT(16'h0001)) 
     \time_out_counter[0]_i_10__0 
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[13]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[0]_i_10__0 ));
LUT4 #(
    .INIT(16'hFFF7)) 
     \time_out_counter[0]_i_11__0 
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[16]),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_11__0 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_1__0 
       (.I0(time_out_2ms),
        .O(\n_0_time_out_counter[0]_i_1__0 ));
LUT6 #(
    .INIT(64'h0080000000000000)) 
     \time_out_counter[0]_i_3__4 
       (.I0(\n_0_time_out_counter[0]_i_8__4 ),
        .I1(\n_0_time_out_counter[0]_i_9__0 ),
        .I2(\n_0_time_out_counter[0]_i_10__0 ),
        .I3(\n_0_time_out_counter[0]_i_11__0 ),
        .I4(time_out_counter_reg[2]),
        .I5(time_out_counter_reg[10]),
        .O(time_out_2ms));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_4__4 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_4__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_5__0 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6__0 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_6__0 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_7__0 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_7__0 ));
(* SOFT_HLUTNM = "soft_lutpair42" *) 
   LUT3 #(
    .INIT(8'h04)) 
     \time_out_counter[0]_i_8__4 
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[0]_i_8__4 ));
LUT6 #(
    .INIT(64'h0004000000000000)) 
     \time_out_counter[0]_i_9__0 
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[18]),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[4]),
        .I5(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[0]_i_9__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2__0 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3__0 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4__0 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5__0 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2__0 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3__0 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4__0 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2__0 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3__0 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4__0 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5__0 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2__0 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3__0 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4__0 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5__0 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5__0 ));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[0]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[0]_i_2__0 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2__0 ,\n_1_time_out_counter_reg[0]_i_2__0 ,\n_2_time_out_counter_reg[0]_i_2__0 ,\n_3_time_out_counter_reg[0]_i_2__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2__0 ,\n_5_time_out_counter_reg[0]_i_2__0 ,\n_6_time_out_counter_reg[0]_i_2__0 ,\n_7_time_out_counter_reg[0]_i_2__0 }),
        .S({\n_0_time_out_counter[0]_i_4__4 ,\n_0_time_out_counter[0]_i_5__0 ,\n_0_time_out_counter[0]_i_6__0 ,\n_0_time_out_counter[0]_i_7__0 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[10]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[11]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[12]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[12]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[8]_i_1__0 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1__0 ,\n_1_time_out_counter_reg[12]_i_1__0 ,\n_2_time_out_counter_reg[12]_i_1__0 ,\n_3_time_out_counter_reg[12]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1__0 ,\n_5_time_out_counter_reg[12]_i_1__0 ,\n_6_time_out_counter_reg[12]_i_1__0 ,\n_7_time_out_counter_reg[12]_i_1__0 }),
        .S({\n_0_time_out_counter[12]_i_2__0 ,\n_0_time_out_counter[12]_i_3__0 ,\n_0_time_out_counter[12]_i_4__0 ,\n_0_time_out_counter[12]_i_5__0 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[13]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[14]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[15]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[16]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[16]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[12]_i_1__0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__0_CO_UNCONNECTED [3:2],\n_2_time_out_counter_reg[16]_i_1__0 ,\n_3_time_out_counter_reg[16]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__0_O_UNCONNECTED [3],\n_5_time_out_counter_reg[16]_i_1__0 ,\n_6_time_out_counter_reg[16]_i_1__0 ,\n_7_time_out_counter_reg[16]_i_1__0 }),
        .S({1'b0,\n_0_time_out_counter[16]_i_2__0 ,\n_0_time_out_counter[16]_i_3__0 ,\n_0_time_out_counter[16]_i_4__0 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[17]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[18]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[1]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[2]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[3]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[4]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[4]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[0]_i_2__0 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1__0 ,\n_1_time_out_counter_reg[4]_i_1__0 ,\n_2_time_out_counter_reg[4]_i_1__0 ,\n_3_time_out_counter_reg[4]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1__0 ,\n_5_time_out_counter_reg[4]_i_1__0 ,\n_6_time_out_counter_reg[4]_i_1__0 ,\n_7_time_out_counter_reg[4]_i_1__0 }),
        .S({\n_0_time_out_counter[4]_i_2__0 ,\n_0_time_out_counter[4]_i_3__0 ,\n_0_time_out_counter[4]_i_4__0 ,\n_0_time_out_counter[4]_i_5__0 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[5]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[6]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[7]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[8]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[8]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[4]_i_1__0 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1__0 ,\n_1_time_out_counter_reg[8]_i_1__0 ,\n_2_time_out_counter_reg[8]_i_1__0 ,\n_3_time_out_counter_reg[8]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1__0 ,\n_5_time_out_counter_reg[8]_i_1__0 ,\n_6_time_out_counter_reg[8]_i_1__0 ,\n_7_time_out_counter_reg[8]_i_1__0 }),
        .S({\n_0_time_out_counter[8]_i_2__0 ,\n_0_time_out_counter[8]_i_3__0 ,\n_0_time_out_counter[8]_i_4__0 ,\n_0_time_out_counter[8]_i_5__0 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[9]),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1__0
       (.I0(\n_0_wait_bypass_count[0]_i_4__0 ),
        .I1(\n_0_wait_bypass_count[0]_i_5__0 ),
        .I2(\n_0_wait_bypass_count[0]_i_6__0 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(n_0_tx_fsm_reset_done_int_s3_reg),
        .I5(n_0_run_phase_alignment_int_s3_reg),
        .O(n_0_time_out_wait_bypass_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1__0),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000AAAAEAAA)) 
     time_tlock_max_i_1__0
       (.I0(n_0_time_tlock_max_reg),
        .I1(n_0_time_tlock_max_i_2__2),
        .I2(n_0_time_tlock_max_i_3),
        .I3(time_out_counter_reg[8]),
        .I4(time_out_counter_reg[9]),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_time_tlock_max_i_1__0));
LUT6 #(
    .INIT(64'h0000000100000000)) 
     time_tlock_max_i_2__2
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[0]),
        .I4(time_out_counter_reg[16]),
        .I5(n_0_time_tlock_max_i_4__4),
        .O(n_0_time_tlock_max_i_2__2));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     time_tlock_max_i_3
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[5]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[11]),
        .I4(time_out_counter_reg[18]),
        .I5(time_out_counter_reg[12]),
        .O(n_0_time_tlock_max_i_3));
LUT6 #(
    .INIT(64'h0040000000000000)) 
     time_tlock_max_i_4__4
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[4]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[14]),
        .I5(time_out_counter_reg[3]),
        .O(n_0_time_tlock_max_i_4__4));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1__0),
        .Q(n_0_time_tlock_max_reg),
        .R(1'b0));
LUT5 #(
    .INIT(32'hFFFF0200)) 
     tx_fsm_reset_done_int_i_1__0
       (.I0(tx_state[3]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(GT1_TX_FSM_RESET_DONE_OUT),
        .O(n_0_tx_fsm_reset_done_int_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_tx_fsm_reset_done_int_i_1__0),
        .Q(GT1_TX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_s3_reg
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_s2),
        .Q(n_0_tx_fsm_reset_done_int_s3_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     txresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(txresetdone_s2),
        .Q(txresetdone_s3),
        .R(1'b0));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_10__0 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_10__0 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1__0 
       (.I0(n_0_run_phase_alignment_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_1__0 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2__0 
       (.I0(\n_0_wait_bypass_count[0]_i_4__0 ),
        .I1(\n_0_wait_bypass_count[0]_i_5__0 ),
        .I2(\n_0_wait_bypass_count[0]_i_6__0 ),
        .I3(n_0_tx_fsm_reset_done_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_2__0 ));
LUT5 #(
    .INIT(32'hBFFFFFFF)) 
     \wait_bypass_count[0]_i_4__0 
       (.I0(wait_bypass_count_reg[15]),
        .I1(wait_bypass_count_reg[1]),
        .I2(wait_bypass_count_reg[2]),
        .I3(wait_bypass_count_reg[16]),
        .I4(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_4__0 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFDFF)) 
     \wait_bypass_count[0]_i_5__0 
       (.I0(wait_bypass_count_reg[10]),
        .I1(wait_bypass_count_reg[9]),
        .I2(wait_bypass_count_reg[14]),
        .I3(wait_bypass_count_reg[13]),
        .I4(wait_bypass_count_reg[11]),
        .I5(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[0]_i_5__0 ));
LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_6__0 
       (.I0(wait_bypass_count_reg[4]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[7]),
        .I3(wait_bypass_count_reg[8]),
        .I4(wait_bypass_count_reg[5]),
        .I5(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[0]_i_6__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7__0 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_7__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8__0 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_8__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_9__4 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_9__4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2__0 
       (.I0(wait_bypass_count_reg[15]),
        .O(\n_0_wait_bypass_count[12]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_3__0 
       (.I0(wait_bypass_count_reg[14]),
        .O(\n_0_wait_bypass_count[12]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_4__0 
       (.I0(wait_bypass_count_reg[13]),
        .O(\n_0_wait_bypass_count[12]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_5__0 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[16]_i_2__0 
       (.I0(wait_bypass_count_reg[16]),
        .O(\n_0_wait_bypass_count[16]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2__0 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3__0 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4__0 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5__0 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2__0 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3__0 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4__0 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5__0 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5__0 ));
FDRE \wait_bypass_count_reg[0] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[0]_i_3__0 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3__0 ,\n_1_wait_bypass_count_reg[0]_i_3__0 ,\n_2_wait_bypass_count_reg[0]_i_3__0 ,\n_3_wait_bypass_count_reg[0]_i_3__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3__0 ,\n_5_wait_bypass_count_reg[0]_i_3__0 ,\n_6_wait_bypass_count_reg[0]_i_3__0 ,\n_7_wait_bypass_count_reg[0]_i_3__0 }),
        .S({\n_0_wait_bypass_count[0]_i_7__0 ,\n_0_wait_bypass_count[0]_i_8__0 ,\n_0_wait_bypass_count[0]_i_9__4 ,\n_0_wait_bypass_count[0]_i_10__0 }));
FDRE \wait_bypass_count_reg[10] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[11] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[12] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1__0 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[12]_i_1__0 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1__0 ),
        .CO({\n_0_wait_bypass_count_reg[12]_i_1__0 ,\n_1_wait_bypass_count_reg[12]_i_1__0 ,\n_2_wait_bypass_count_reg[12]_i_1__0 ,\n_3_wait_bypass_count_reg[12]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[12]_i_1__0 ,\n_5_wait_bypass_count_reg[12]_i_1__0 ,\n_6_wait_bypass_count_reg[12]_i_1__0 ,\n_7_wait_bypass_count_reg[12]_i_1__0 }),
        .S({\n_0_wait_bypass_count[12]_i_2__0 ,\n_0_wait_bypass_count[12]_i_3__0 ,\n_0_wait_bypass_count[12]_i_4__0 ,\n_0_wait_bypass_count[12]_i_5__0 }));
FDRE \wait_bypass_count_reg[13] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_6_wait_bypass_count_reg[12]_i_1__0 ),
        .Q(wait_bypass_count_reg[13]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[14] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_5_wait_bypass_count_reg[12]_i_1__0 ),
        .Q(wait_bypass_count_reg[14]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[15] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_4_wait_bypass_count_reg[12]_i_1__0 ),
        .Q(wait_bypass_count_reg[15]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[16] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[16]_i_1__0 ),
        .Q(wait_bypass_count_reg[16]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[16]_i_1__0 
       (.CI(\n_0_wait_bypass_count_reg[12]_i_1__0 ),
        .CO(\NLW_wait_bypass_count_reg[16]_i_1__0_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[16]_i_1__0_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[16]_i_1__0 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[16]_i_2__0 }));
FDRE \wait_bypass_count_reg[1] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[2] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[3] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[4] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[4]_i_1__0 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3__0 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1__0 ,\n_1_wait_bypass_count_reg[4]_i_1__0 ,\n_2_wait_bypass_count_reg[4]_i_1__0 ,\n_3_wait_bypass_count_reg[4]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1__0 ,\n_5_wait_bypass_count_reg[4]_i_1__0 ,\n_6_wait_bypass_count_reg[4]_i_1__0 ,\n_7_wait_bypass_count_reg[4]_i_1__0 }),
        .S({\n_0_wait_bypass_count[4]_i_2__0 ,\n_0_wait_bypass_count[4]_i_3__0 ,\n_0_wait_bypass_count[4]_i_4__0 ,\n_0_wait_bypass_count[4]_i_5__0 }));
FDRE \wait_bypass_count_reg[5] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[6] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[7] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[8] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[8]_i_1__0 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1__0 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1__0 ,\n_1_wait_bypass_count_reg[8]_i_1__0 ,\n_2_wait_bypass_count_reg[8]_i_1__0 ,\n_3_wait_bypass_count_reg[8]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1__0 ,\n_5_wait_bypass_count_reg[8]_i_1__0 ,\n_6_wait_bypass_count_reg[8]_i_1__0 ,\n_7_wait_bypass_count_reg[8]_i_1__0 }),
        .S({\n_0_wait_bypass_count[8]_i_2__0 ,\n_0_wait_bypass_count[8]_i_3__0 ,\n_0_wait_bypass_count[8]_i_4__0 ,\n_0_wait_bypass_count[8]_i_5__0 }));
FDRE \wait_bypass_count_reg[9] 
       (.C(gt1_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair46" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1__0 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__0[0]));
(* SOFT_HLUTNM = "soft_lutpair46" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1__0 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\n_0_wait_time_cnt[1]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair40" *) 
   LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1__0 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__0[2]));
(* SOFT_HLUTNM = "soft_lutpair38" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \wait_time_cnt[3]_i_1__0 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0__0[3]));
(* SOFT_HLUTNM = "soft_lutpair38" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1__0 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\n_0_wait_time_cnt[4]_i_1__0 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[5]_i_1__0 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[1]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__0[5]));
LUT4 #(
    .INIT(16'h0700)) 
     \wait_time_cnt[6]_i_1__0 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[3]),
        .I3(tx_state[0]),
        .O(\n_0_wait_time_cnt[6]_i_1__0 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_2__0 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(wait_time_cnt_reg__0[5]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .I5(\n_0_wait_time_cnt[6]_i_4__0 ),
        .O(\n_0_wait_time_cnt[6]_i_2__0 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[6]_i_3__0 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4__0 ),
        .I2(wait_time_cnt_reg__0[3]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[5]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__0[6]));
(* SOFT_HLUTNM = "soft_lutpair40" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_4__0 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(\n_0_wait_time_cnt[6]_i_4__0 ));
FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(\n_0_wait_time_cnt[1]_i_1__0 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\n_0_wait_time_cnt[6]_i_1__0 ));
FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(\n_0_wait_time_cnt[4]_i_1__0 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\n_0_wait_time_cnt[6]_i_1__0 ));
FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\n_0_wait_time_cnt[6]_i_1__0 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_TX_STARTUP_FSM" *) 
module XLAUI_XLAUI_TX_STARTUP_FSM__parameterized0_3
   (O1,
    GT2_TX_MMCM_RESET_OUT,
    GT2_TX_FSM_RESET_DONE_OUT,
    O2,
    SYSCLK_IN,
    gt2_txusrclk_in,
    SOFT_RESET_IN,
    gt2_txresetdone_out,
    GT2_TX_MMCM_LOCK_IN,
    GT0_QPLLLOCK_IN);
  output O1;
  output GT2_TX_MMCM_RESET_OUT;
  output GT2_TX_FSM_RESET_DONE_OUT;
  output O2;
  input SYSCLK_IN;
  input gt2_txusrclk_in;
  input SOFT_RESET_IN;
  input gt2_txresetdone_out;
  input GT2_TX_MMCM_LOCK_IN;
  input GT0_QPLLLOCK_IN;

  wire GT0_QPLLLOCK_IN;
  wire GT2_TX_FSM_RESET_DONE_OUT;
  wire GT2_TX_MMCM_LOCK_IN;
  wire GT2_TX_MMCM_RESET_OUT;
  wire O1;
  wire O2;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire data_out;
  wire gt2_txresetdone_out;
  wire gt2_txusrclk_in;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_tx_state[0]_i_1__1 ;
  wire \n_0_FSM_sequential_tx_state[0]_i_2__1 ;
  wire \n_0_FSM_sequential_tx_state[1]_i_1__1 ;
  wire \n_0_FSM_sequential_tx_state[1]_i_2__1 ;
  wire \n_0_FSM_sequential_tx_state[2]_i_1__1 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_2__1 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_4__1 ;
  wire n_0_MMCM_RESET_i_1__1;
  wire n_0_TXUSERRDY_i_1__1;
  wire n_0_gttxreset_i_i_1__1;
  wire \n_0_init_wait_count[6]_i_1__1 ;
  wire \n_0_init_wait_count[6]_i_3__1 ;
  wire \n_0_init_wait_count[6]_i_4__1 ;
  wire n_0_init_wait_done_i_1__1;
  wire n_0_init_wait_done_reg;
  wire \n_0_mmcm_lock_count[6]_i_2__1 ;
  wire \n_0_mmcm_lock_count[7]_i_2__1 ;
  wire \n_0_mmcm_lock_count[7]_i_4__1 ;
  wire n_0_pll_reset_asserted_i_1__1;
  wire n_0_pll_reset_asserted_reg;
  wire n_0_reset_time_out_reg;
  wire n_0_run_phase_alignment_int_i_1__1;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_run_phase_alignment_int_s3_reg;
  wire n_0_sync_QPLLLOCK;
  wire n_0_sync_mmcm_lock_reclocked;
  wire n_0_time_out_2ms_i_1__1;
  wire n_0_time_out_2ms_reg;
  wire n_0_time_out_500us_i_1__5;
  wire n_0_time_out_500us_i_2__5;
  wire n_0_time_out_500us_i_3__5;
  wire n_0_time_out_500us_reg;
  wire \n_0_time_out_counter[0]_i_10__1 ;
  wire \n_0_time_out_counter[0]_i_11__1 ;
  wire \n_0_time_out_counter[0]_i_1__1 ;
  wire \n_0_time_out_counter[0]_i_4__5 ;
  wire \n_0_time_out_counter[0]_i_5__1 ;
  wire \n_0_time_out_counter[0]_i_6__1 ;
  wire \n_0_time_out_counter[0]_i_7__1 ;
  wire \n_0_time_out_counter[0]_i_8__5 ;
  wire \n_0_time_out_counter[0]_i_9__1 ;
  wire \n_0_time_out_counter[12]_i_2__1 ;
  wire \n_0_time_out_counter[12]_i_3__1 ;
  wire \n_0_time_out_counter[12]_i_4__1 ;
  wire \n_0_time_out_counter[12]_i_5__1 ;
  wire \n_0_time_out_counter[16]_i_2__1 ;
  wire \n_0_time_out_counter[16]_i_3__1 ;
  wire \n_0_time_out_counter[16]_i_4__1 ;
  wire \n_0_time_out_counter[4]_i_2__1 ;
  wire \n_0_time_out_counter[4]_i_3__1 ;
  wire \n_0_time_out_counter[4]_i_4__1 ;
  wire \n_0_time_out_counter[4]_i_5__1 ;
  wire \n_0_time_out_counter[8]_i_2__1 ;
  wire \n_0_time_out_counter[8]_i_3__1 ;
  wire \n_0_time_out_counter[8]_i_4__1 ;
  wire \n_0_time_out_counter[8]_i_5__1 ;
  wire \n_0_time_out_counter_reg[0]_i_2__1 ;
  wire \n_0_time_out_counter_reg[12]_i_1__1 ;
  wire \n_0_time_out_counter_reg[4]_i_1__1 ;
  wire \n_0_time_out_counter_reg[8]_i_1__1 ;
  wire n_0_time_out_wait_bypass_i_1__1;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_1__1;
  wire n_0_time_tlock_max_i_3__2;
  wire n_0_time_tlock_max_i_4__5;
  wire n_0_time_tlock_max_reg;
  wire n_0_tx_fsm_reset_done_int_i_1__1;
  wire n_0_tx_fsm_reset_done_int_s3_reg;
  wire \n_0_wait_bypass_count[0]_i_10__1 ;
  wire \n_0_wait_bypass_count[0]_i_1__1 ;
  wire \n_0_wait_bypass_count[0]_i_2__1 ;
  wire \n_0_wait_bypass_count[0]_i_4__1 ;
  wire \n_0_wait_bypass_count[0]_i_5__1 ;
  wire \n_0_wait_bypass_count[0]_i_6__1 ;
  wire \n_0_wait_bypass_count[0]_i_7__1 ;
  wire \n_0_wait_bypass_count[0]_i_8__1 ;
  wire \n_0_wait_bypass_count[0]_i_9__5 ;
  wire \n_0_wait_bypass_count[12]_i_2__1 ;
  wire \n_0_wait_bypass_count[12]_i_3__1 ;
  wire \n_0_wait_bypass_count[12]_i_4__1 ;
  wire \n_0_wait_bypass_count[12]_i_5__1 ;
  wire \n_0_wait_bypass_count[16]_i_2__1 ;
  wire \n_0_wait_bypass_count[4]_i_2__1 ;
  wire \n_0_wait_bypass_count[4]_i_3__1 ;
  wire \n_0_wait_bypass_count[4]_i_4__1 ;
  wire \n_0_wait_bypass_count[4]_i_5__1 ;
  wire \n_0_wait_bypass_count[8]_i_2__1 ;
  wire \n_0_wait_bypass_count[8]_i_3__1 ;
  wire \n_0_wait_bypass_count[8]_i_4__1 ;
  wire \n_0_wait_bypass_count[8]_i_5__1 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3__1 ;
  wire \n_0_wait_bypass_count_reg[12]_i_1__1 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1__1 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1__1 ;
  wire \n_0_wait_time_cnt[1]_i_1__1 ;
  wire \n_0_wait_time_cnt[4]_i_1__1 ;
  wire \n_0_wait_time_cnt[6]_i_1__1 ;
  wire \n_0_wait_time_cnt[6]_i_2__1 ;
  wire \n_0_wait_time_cnt[6]_i_4__1 ;
  wire n_1_sync_QPLLLOCK;
  wire n_1_sync_mmcm_lock_reclocked;
  wire \n_1_time_out_counter_reg[0]_i_2__1 ;
  wire \n_1_time_out_counter_reg[12]_i_1__1 ;
  wire \n_1_time_out_counter_reg[4]_i_1__1 ;
  wire \n_1_time_out_counter_reg[8]_i_1__1 ;
  wire \n_1_wait_bypass_count_reg[0]_i_3__1 ;
  wire \n_1_wait_bypass_count_reg[12]_i_1__1 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1__1 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1__1 ;
  wire \n_2_time_out_counter_reg[0]_i_2__1 ;
  wire \n_2_time_out_counter_reg[12]_i_1__1 ;
  wire \n_2_time_out_counter_reg[16]_i_1__1 ;
  wire \n_2_time_out_counter_reg[4]_i_1__1 ;
  wire \n_2_time_out_counter_reg[8]_i_1__1 ;
  wire \n_2_wait_bypass_count_reg[0]_i_3__1 ;
  wire \n_2_wait_bypass_count_reg[12]_i_1__1 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1__1 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1__1 ;
  wire \n_3_time_out_counter_reg[0]_i_2__1 ;
  wire \n_3_time_out_counter_reg[12]_i_1__1 ;
  wire \n_3_time_out_counter_reg[16]_i_1__1 ;
  wire \n_3_time_out_counter_reg[4]_i_1__1 ;
  wire \n_3_time_out_counter_reg[8]_i_1__1 ;
  wire \n_3_wait_bypass_count_reg[0]_i_3__1 ;
  wire \n_3_wait_bypass_count_reg[12]_i_1__1 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1__1 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1__1 ;
  wire \n_4_time_out_counter_reg[0]_i_2__1 ;
  wire \n_4_time_out_counter_reg[12]_i_1__1 ;
  wire \n_4_time_out_counter_reg[4]_i_1__1 ;
  wire \n_4_time_out_counter_reg[8]_i_1__1 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3__1 ;
  wire \n_4_wait_bypass_count_reg[12]_i_1__1 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1__1 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1__1 ;
  wire \n_5_time_out_counter_reg[0]_i_2__1 ;
  wire \n_5_time_out_counter_reg[12]_i_1__1 ;
  wire \n_5_time_out_counter_reg[16]_i_1__1 ;
  wire \n_5_time_out_counter_reg[4]_i_1__1 ;
  wire \n_5_time_out_counter_reg[8]_i_1__1 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3__1 ;
  wire \n_5_wait_bypass_count_reg[12]_i_1__1 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1__1 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1__1 ;
  wire \n_6_time_out_counter_reg[0]_i_2__1 ;
  wire \n_6_time_out_counter_reg[12]_i_1__1 ;
  wire \n_6_time_out_counter_reg[16]_i_1__1 ;
  wire \n_6_time_out_counter_reg[4]_i_1__1 ;
  wire \n_6_time_out_counter_reg[8]_i_1__1 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3__1 ;
  wire \n_6_wait_bypass_count_reg[12]_i_1__1 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1__1 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1__1 ;
  wire \n_7_time_out_counter_reg[0]_i_2__1 ;
  wire \n_7_time_out_counter_reg[12]_i_1__1 ;
  wire \n_7_time_out_counter_reg[16]_i_1__1 ;
  wire \n_7_time_out_counter_reg[4]_i_1__1 ;
  wire \n_7_time_out_counter_reg[8]_i_1__1 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3__1 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1__1 ;
  wire \n_7_wait_bypass_count_reg[16]_i_1__1 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1__1 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1__1 ;
  wire [6:0]p_0_in__3;
  wire [7:0]p_0_in__4;
  wire time_out_2ms;
  wire [18:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire tx_fsm_reset_done_int_s2;
(* RTL_KEEP = "yes" *)   wire [3:0]tx_state;
  wire tx_state12_out;
  wire tx_state13_out;
  wire txresetdone_s2;
  wire txresetdone_s3;
  wire [16:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0__1;
  wire [6:0]wait_time_cnt_reg__0;
  wire wait_time_done;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__1_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__1_O_UNCONNECTED ;
  wire [3:0]\NLW_wait_bypass_count_reg[16]_i_1__1_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[16]_i_1__1_O_UNCONNECTED ;

LUT5 #(
    .INIT(32'h0F001F1F)) 
     \FSM_sequential_tx_state[0]_i_1__1 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[3]),
        .I3(\n_0_FSM_sequential_tx_state[0]_i_2__1 ),
        .I4(tx_state[0]),
        .O(\n_0_FSM_sequential_tx_state[0]_i_1__1 ));
LUT6 #(
    .INIT(64'h22F0000022F0FFFF)) 
     \FSM_sequential_tx_state[0]_i_2__1 
       (.I0(n_0_time_out_500us_reg),
        .I1(n_0_reset_time_out_reg),
        .I2(n_0_time_out_2ms_reg),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .I5(\n_0_FSM_sequential_tx_state[1]_i_2__1 ),
        .O(\n_0_FSM_sequential_tx_state[0]_i_2__1 ));
LUT4 #(
    .INIT(16'h0062)) 
     \FSM_sequential_tx_state[1]_i_1__1 
       (.I0(tx_state[1]),
        .I1(tx_state[0]),
        .I2(\n_0_FSM_sequential_tx_state[1]_i_2__1 ),
        .I3(tx_state[3]),
        .O(\n_0_FSM_sequential_tx_state[1]_i_1__1 ));
LUT4 #(
    .INIT(16'hFFDF)) 
     \FSM_sequential_tx_state[1]_i_2__1 
       (.I0(tx_state[2]),
        .I1(mmcm_lock_reclocked),
        .I2(n_0_time_tlock_max_reg),
        .I3(n_0_reset_time_out_reg),
        .O(\n_0_FSM_sequential_tx_state[1]_i_2__1 ));
LUT6 #(
    .INIT(64'h00000000222A662A)) 
     \FSM_sequential_tx_state[2]_i_1__1 
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state13_out),
        .I3(tx_state[1]),
        .I4(n_0_time_out_2ms_reg),
        .I5(tx_state[3]),
        .O(\n_0_FSM_sequential_tx_state[2]_i_1__1 ));
(* SOFT_HLUTNM = "soft_lutpair65" *) 
   LUT3 #(
    .INIT(8'h04)) 
     \FSM_sequential_tx_state[2]_i_2__1 
       (.I0(n_0_reset_time_out_reg),
        .I1(n_0_time_tlock_max_reg),
        .I2(mmcm_lock_reclocked),
        .O(tx_state13_out));
LUT6 #(
    .INIT(64'h0300004C00000044)) 
     \FSM_sequential_tx_state[3]_i_2__1 
       (.I0(time_out_wait_bypass_s3),
        .I1(tx_state[3]),
        .I2(tx_state12_out),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .I5(tx_state[0]),
        .O(\n_0_FSM_sequential_tx_state[3]_i_2__1 ));
LUT2 #(
    .INIT(4'h1)) 
     \FSM_sequential_tx_state[3]_i_4__1 
       (.I0(tx_state[2]),
        .I1(tx_state[1]),
        .O(\n_0_FSM_sequential_tx_state[3]_i_4__1 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_sequential_tx_state[3]_i_5__1 
       (.I0(\n_0_wait_time_cnt[6]_i_4__1 ),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[5]),
        .I4(wait_time_cnt_reg__0[4]),
        .I5(wait_time_cnt_reg__0[6]),
        .O(wait_time_done));
(* SOFT_HLUTNM = "soft_lutpair66" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_tx_state[3]_i_6__1 
       (.I0(n_0_time_out_500us_reg),
        .I1(n_0_reset_time_out_reg),
        .O(tx_state12_out));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[0]_i_1__1 ),
        .Q(tx_state[0]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[1]_i_1__1 ),
        .Q(tx_state[1]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[2]_i_1__1 ),
        .Q(tx_state[2]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[3]_i_2__1 ),
        .Q(tx_state[3]),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFDF0010)) 
     MMCM_RESET_i_1__1
       (.I0(tx_state[2]),
        .I1(tx_state[1]),
        .I2(tx_state[0]),
        .I3(tx_state[3]),
        .I4(GT2_TX_MMCM_RESET_OUT),
        .O(n_0_MMCM_RESET_i_1__1));
FDRE #(
    .INIT(1'b1)) 
     MMCM_RESET_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_MMCM_RESET_i_1__1),
        .Q(GT2_TX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD0080)) 
     TXUSERRDY_i_1__1
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[3]),
        .I4(O2),
        .O(n_0_TXUSERRDY_i_1__1));
FDRE #(
    .INIT(1'b0)) 
     TXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_TXUSERRDY_i_1__1),
        .Q(O2),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0010)) 
     gttxreset_i_i_1__1
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[0]),
        .I3(tx_state[3]),
        .I4(O1),
        .O(n_0_gttxreset_i_i_1__1));
FDRE #(
    .INIT(1'b0)) 
     gttxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gttxreset_i_i_1__1),
        .Q(O1),
        .R(SOFT_RESET_IN));
(* SOFT_HLUTNM = "soft_lutpair68" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1__1 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in__3[0]));
(* SOFT_HLUTNM = "soft_lutpair68" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1__1 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in__3[1]));
(* SOFT_HLUTNM = "soft_lutpair63" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[2]_i_1__1 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .O(p_0_in__3[2]));
(* SOFT_HLUTNM = "soft_lutpair63" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \init_wait_count[3]_i_1__1 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .O(p_0_in__3[3]));
(* SOFT_HLUTNM = "soft_lutpair61" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \init_wait_count[4]_i_1__1 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .O(p_0_in__3[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \init_wait_count[5]_i_1__1 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .I5(init_wait_count_reg__0[4]),
        .O(p_0_in__3[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
     \init_wait_count[6]_i_1__1 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[0]),
        .I3(\n_0_init_wait_count[6]_i_3__1 ),
        .I4(init_wait_count_reg__0[4]),
        .I5(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_1__1 ));
LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[6]_i_2__1 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\n_0_init_wait_count[6]_i_4__1 ),
        .I2(init_wait_count_reg__0[5]),
        .O(p_0_in__3[6]));
LUT2 #(
    .INIT(4'h7)) 
     \init_wait_count[6]_i_3__1 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_3__1 ));
(* SOFT_HLUTNM = "soft_lutpair61" *) 
   LUT5 #(
    .INIT(32'h80000000)) 
     \init_wait_count[6]_i_4__1 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_4__1 ));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__3[0]),
        .Q(init_wait_count_reg__0[0]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__3[1]),
        .Q(init_wait_count_reg__0[1]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__3[2]),
        .Q(init_wait_count_reg__0[2]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__3[3]),
        .Q(init_wait_count_reg__0[3]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__3[4]),
        .Q(init_wait_count_reg__0[4]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__3[5]),
        .Q(init_wait_count_reg__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__1 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__3[6]),
        .Q(init_wait_count_reg__0[6]));
LUT2 #(
    .INIT(4'hE)) 
     init_wait_done_i_1__1
       (.I0(init_wait_done),
        .I1(n_0_init_wait_done_reg),
        .O(n_0_init_wait_done_i_1__1));
LUT6 #(
    .INIT(64'h0000000004000000)) 
     init_wait_done_i_2__1
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[4]),
        .I2(\n_0_init_wait_count[6]_i_3__1 ),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_done));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(n_0_init_wait_done_i_1__1),
        .Q(n_0_init_wait_done_reg));
(* SOFT_HLUTNM = "soft_lutpair69" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__4[0]));
(* SOFT_HLUTNM = "soft_lutpair69" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__4[1]));
(* SOFT_HLUTNM = "soft_lutpair67" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[2]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__4[2]));
(* SOFT_HLUTNM = "soft_lutpair62" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \mmcm_lock_count[3]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__4[3]));
(* SOFT_HLUTNM = "soft_lutpair62" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \mmcm_lock_count[4]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[3]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__4[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[5]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__4[5]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[6]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(\n_0_mmcm_lock_count[6]_i_2__1 ),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__4[6]));
(* SOFT_HLUTNM = "soft_lutpair67" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \mmcm_lock_count[6]_i_2__1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(\n_0_mmcm_lock_count[6]_i_2__1 ));
LUT3 #(
    .INIT(8'h7F)) 
     \mmcm_lock_count[7]_i_2__1 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__1 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(\n_0_mmcm_lock_count[7]_i_2__1 ));
LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[7]_i_3__1 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__1 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__4[7]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \mmcm_lock_count[7]_i_4__1 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(\n_0_mmcm_lock_count[7]_i_4__1 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__1 ),
        .D(p_0_in__4[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__1 ),
        .D(p_0_in__4[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__1 ),
        .D(p_0_in__4[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__1 ),
        .D(p_0_in__4[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__1 ),
        .D(p_0_in__4[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__1 ),
        .D(p_0_in__4[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__1 ),
        .D(p_0_in__4[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__1 ),
        .D(p_0_in__4[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
LUT5 #(
    .INIT(32'hF0F0F072)) 
     pll_reset_asserted_i_1__1
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(n_0_pll_reset_asserted_reg),
        .I3(tx_state[2]),
        .I4(tx_state[3]),
        .O(n_0_pll_reset_asserted_i_1__1));
FDRE #(
    .INIT(1'b0)) 
     pll_reset_asserted_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_pll_reset_asserted_i_1__1),
        .Q(n_0_pll_reset_asserted_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_QPLLLOCK),
        .Q(n_0_reset_time_out_reg),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFEFF0002)) 
     run_phase_alignment_int_i_1__1
       (.I0(tx_state[3]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1__1));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1__1),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_out),
        .Q(n_0_run_phase_alignment_int_s3_reg),
        .R(1'b0));
XLAUI_XLAUI_sync_block__parameterized0_20 sync_QPLLLOCK
       (.E(n_1_sync_QPLLLOCK),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .I1(n_0_init_wait_done_reg),
        .I2(n_0_reset_time_out_reg),
        .I3(\n_0_FSM_sequential_tx_state[3]_i_4__1 ),
        .I4(n_0_time_out_500us_reg),
        .I5(n_0_time_out_2ms_reg),
        .I6(n_0_time_tlock_max_reg),
        .I7(n_0_pll_reset_asserted_reg),
        .O1(n_0_sync_QPLLLOCK),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(tx_state),
        .txresetdone_s3(txresetdone_s3),
        .wait_time_done(wait_time_done));
XLAUI_XLAUI_sync_block__parameterized0_21 sync_TXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(txresetdone_s2),
        .gt2_txresetdone_out(gt2_txresetdone_out));
XLAUI_XLAUI_sync_block__parameterized0_22 sync_mmcm_lock_reclocked
       (.GT2_TX_MMCM_LOCK_IN(GT2_TX_MMCM_LOCK_IN),
        .I1(\n_0_mmcm_lock_count[7]_i_4__1 ),
        .O1(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(n_0_sync_mmcm_lock_reclocked),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked));
XLAUI_XLAUI_sync_block__parameterized0_23 sync_run_phase_alignment_int
       (.data_in(n_0_run_phase_alignment_int_reg),
        .data_out(data_out),
        .gt2_txusrclk_in(gt2_txusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_24 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
XLAUI_XLAUI_sync_block__parameterized0_25 sync_tx_fsm_reset_done_int
       (.GT2_TX_FSM_RESET_DONE_OUT(GT2_TX_FSM_RESET_DONE_OUT),
        .data_out(tx_fsm_reset_done_int_s2),
        .gt2_txusrclk_in(gt2_txusrclk_in));
(* SOFT_HLUTNM = "soft_lutpair66" *) 
   LUT3 #(
    .INIT(8'h0E)) 
     time_out_2ms_i_1__1
       (.I0(n_0_time_out_2ms_reg),
        .I1(time_out_2ms),
        .I2(n_0_reset_time_out_reg),
        .O(n_0_time_out_2ms_i_1__1));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1__1),
        .Q(n_0_time_out_2ms_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000BAAAAAAA)) 
     time_out_500us_i_1__5
       (.I0(n_0_time_out_500us_reg),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[8]),
        .I3(n_0_time_out_500us_i_2__5),
        .I4(n_0_time_out_500us_i_3__5),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_time_out_500us_i_1__5));
LUT5 #(
    .INIT(32'h00400000)) 
     time_out_500us_i_2__5
       (.I0(\n_0_time_out_counter[0]_i_11__1 ),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[12]),
        .I4(\n_0_time_out_counter[0]_i_10__1 ),
        .O(n_0_time_out_500us_i_2__5));
LUT6 #(
    .INIT(64'h0000000000000040)) 
     time_out_500us_i_3__5
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[4]),
        .I4(time_out_counter_reg[3]),
        .I5(time_out_counter_reg[18]),
        .O(n_0_time_out_500us_i_3__5));
FDRE #(
    .INIT(1'b0)) 
     time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_500us_i_1__5),
        .Q(n_0_time_out_500us_reg),
        .R(1'b0));
LUT4 #(
    .INIT(16'h0001)) 
     \time_out_counter[0]_i_10__1 
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[13]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[0]_i_10__1 ));
LUT4 #(
    .INIT(16'hFFF7)) 
     \time_out_counter[0]_i_11__1 
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[16]),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_11__1 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_1__1 
       (.I0(time_out_2ms),
        .O(\n_0_time_out_counter[0]_i_1__1 ));
LUT6 #(
    .INIT(64'h0080000000000000)) 
     \time_out_counter[0]_i_3__5 
       (.I0(\n_0_time_out_counter[0]_i_8__5 ),
        .I1(\n_0_time_out_counter[0]_i_9__1 ),
        .I2(\n_0_time_out_counter[0]_i_10__1 ),
        .I3(\n_0_time_out_counter[0]_i_11__1 ),
        .I4(time_out_counter_reg[2]),
        .I5(time_out_counter_reg[10]),
        .O(time_out_2ms));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_4__5 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_4__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_5__1 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_5__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6__1 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_6__1 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_7__1 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_7__1 ));
LUT3 #(
    .INIT(8'h04)) 
     \time_out_counter[0]_i_8__5 
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[0]_i_8__5 ));
LUT6 #(
    .INIT(64'h0004000000000000)) 
     \time_out_counter[0]_i_9__1 
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[18]),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[4]),
        .I5(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[0]_i_9__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2__1 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3__1 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4__1 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5__1 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2__1 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_2__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3__1 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_3__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4__1 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_4__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2__1 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3__1 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4__1 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5__1 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2__1 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3__1 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4__1 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5__1 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5__1 ));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_7_time_out_counter_reg[0]_i_2__1 ),
        .Q(time_out_counter_reg[0]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[0]_i_2__1 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2__1 ,\n_1_time_out_counter_reg[0]_i_2__1 ,\n_2_time_out_counter_reg[0]_i_2__1 ,\n_3_time_out_counter_reg[0]_i_2__1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2__1 ,\n_5_time_out_counter_reg[0]_i_2__1 ,\n_6_time_out_counter_reg[0]_i_2__1 ,\n_7_time_out_counter_reg[0]_i_2__1 }),
        .S({\n_0_time_out_counter[0]_i_4__5 ,\n_0_time_out_counter[0]_i_5__1 ,\n_0_time_out_counter[0]_i_6__1 ,\n_0_time_out_counter[0]_i_7__1 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_5_time_out_counter_reg[8]_i_1__1 ),
        .Q(time_out_counter_reg[10]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_4_time_out_counter_reg[8]_i_1__1 ),
        .Q(time_out_counter_reg[11]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_7_time_out_counter_reg[12]_i_1__1 ),
        .Q(time_out_counter_reg[12]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[12]_i_1__1 
       (.CI(\n_0_time_out_counter_reg[8]_i_1__1 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1__1 ,\n_1_time_out_counter_reg[12]_i_1__1 ,\n_2_time_out_counter_reg[12]_i_1__1 ,\n_3_time_out_counter_reg[12]_i_1__1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1__1 ,\n_5_time_out_counter_reg[12]_i_1__1 ,\n_6_time_out_counter_reg[12]_i_1__1 ,\n_7_time_out_counter_reg[12]_i_1__1 }),
        .S({\n_0_time_out_counter[12]_i_2__1 ,\n_0_time_out_counter[12]_i_3__1 ,\n_0_time_out_counter[12]_i_4__1 ,\n_0_time_out_counter[12]_i_5__1 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_6_time_out_counter_reg[12]_i_1__1 ),
        .Q(time_out_counter_reg[13]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_5_time_out_counter_reg[12]_i_1__1 ),
        .Q(time_out_counter_reg[14]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_4_time_out_counter_reg[12]_i_1__1 ),
        .Q(time_out_counter_reg[15]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_7_time_out_counter_reg[16]_i_1__1 ),
        .Q(time_out_counter_reg[16]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[16]_i_1__1 
       (.CI(\n_0_time_out_counter_reg[12]_i_1__1 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__1_CO_UNCONNECTED [3:2],\n_2_time_out_counter_reg[16]_i_1__1 ,\n_3_time_out_counter_reg[16]_i_1__1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__1_O_UNCONNECTED [3],\n_5_time_out_counter_reg[16]_i_1__1 ,\n_6_time_out_counter_reg[16]_i_1__1 ,\n_7_time_out_counter_reg[16]_i_1__1 }),
        .S({1'b0,\n_0_time_out_counter[16]_i_2__1 ,\n_0_time_out_counter[16]_i_3__1 ,\n_0_time_out_counter[16]_i_4__1 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_6_time_out_counter_reg[16]_i_1__1 ),
        .Q(time_out_counter_reg[17]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_5_time_out_counter_reg[16]_i_1__1 ),
        .Q(time_out_counter_reg[18]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_6_time_out_counter_reg[0]_i_2__1 ),
        .Q(time_out_counter_reg[1]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_5_time_out_counter_reg[0]_i_2__1 ),
        .Q(time_out_counter_reg[2]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_4_time_out_counter_reg[0]_i_2__1 ),
        .Q(time_out_counter_reg[3]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_7_time_out_counter_reg[4]_i_1__1 ),
        .Q(time_out_counter_reg[4]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[4]_i_1__1 
       (.CI(\n_0_time_out_counter_reg[0]_i_2__1 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1__1 ,\n_1_time_out_counter_reg[4]_i_1__1 ,\n_2_time_out_counter_reg[4]_i_1__1 ,\n_3_time_out_counter_reg[4]_i_1__1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1__1 ,\n_5_time_out_counter_reg[4]_i_1__1 ,\n_6_time_out_counter_reg[4]_i_1__1 ,\n_7_time_out_counter_reg[4]_i_1__1 }),
        .S({\n_0_time_out_counter[4]_i_2__1 ,\n_0_time_out_counter[4]_i_3__1 ,\n_0_time_out_counter[4]_i_4__1 ,\n_0_time_out_counter[4]_i_5__1 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_6_time_out_counter_reg[4]_i_1__1 ),
        .Q(time_out_counter_reg[5]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_5_time_out_counter_reg[4]_i_1__1 ),
        .Q(time_out_counter_reg[6]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_4_time_out_counter_reg[4]_i_1__1 ),
        .Q(time_out_counter_reg[7]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_7_time_out_counter_reg[8]_i_1__1 ),
        .Q(time_out_counter_reg[8]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[8]_i_1__1 
       (.CI(\n_0_time_out_counter_reg[4]_i_1__1 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1__1 ,\n_1_time_out_counter_reg[8]_i_1__1 ,\n_2_time_out_counter_reg[8]_i_1__1 ,\n_3_time_out_counter_reg[8]_i_1__1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1__1 ,\n_5_time_out_counter_reg[8]_i_1__1 ,\n_6_time_out_counter_reg[8]_i_1__1 ,\n_7_time_out_counter_reg[8]_i_1__1 }),
        .S({\n_0_time_out_counter[8]_i_2__1 ,\n_0_time_out_counter[8]_i_3__1 ,\n_0_time_out_counter[8]_i_4__1 ,\n_0_time_out_counter[8]_i_5__1 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__1 ),
        .D(\n_6_time_out_counter_reg[8]_i_1__1 ),
        .Q(time_out_counter_reg[9]),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1__1
       (.I0(\n_0_wait_bypass_count[0]_i_4__1 ),
        .I1(\n_0_wait_bypass_count[0]_i_5__1 ),
        .I2(\n_0_wait_bypass_count[0]_i_6__1 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(n_0_tx_fsm_reset_done_int_s3_reg),
        .I5(n_0_run_phase_alignment_int_s3_reg),
        .O(n_0_time_out_wait_bypass_i_1__1));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1__1),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair65" *) 
   LUT3 #(
    .INIT(8'h0E)) 
     time_tlock_max_i_1__1
       (.I0(n_0_time_tlock_max_reg),
        .I1(time_tlock_max),
        .I2(n_0_reset_time_out_reg),
        .O(n_0_time_tlock_max_i_1__1));
LUT6 #(
    .INIT(64'h0040000000000000)) 
     time_tlock_max_i_2__1
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[8]),
        .I2(\n_0_time_out_counter[0]_i_10__1 ),
        .I3(time_out_counter_reg[10]),
        .I4(n_0_time_tlock_max_i_3__2),
        .I5(n_0_time_tlock_max_i_4__5),
        .O(time_tlock_max));
LUT6 #(
    .INIT(64'h0000000000400000)) 
     time_tlock_max_i_3__2
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[4]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[3]),
        .I5(time_out_counter_reg[18]),
        .O(n_0_time_tlock_max_i_3__2));
LUT6 #(
    .INIT(64'h0000000000000010)) 
     time_tlock_max_i_4__5
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[2]),
        .I2(time_out_counter_reg[1]),
        .I3(time_out_counter_reg[0]),
        .I4(time_out_counter_reg[17]),
        .I5(time_out_counter_reg[16]),
        .O(n_0_time_tlock_max_i_4__5));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1__1),
        .Q(n_0_time_tlock_max_reg),
        .R(1'b0));
LUT5 #(
    .INIT(32'hFFFF0200)) 
     tx_fsm_reset_done_int_i_1__1
       (.I0(tx_state[3]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(GT2_TX_FSM_RESET_DONE_OUT),
        .O(n_0_tx_fsm_reset_done_int_i_1__1));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_tx_fsm_reset_done_int_i_1__1),
        .Q(GT2_TX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_s3_reg
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_s2),
        .Q(n_0_tx_fsm_reset_done_int_s3_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     txresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(txresetdone_s2),
        .Q(txresetdone_s3),
        .R(1'b0));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_10__1 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_10__1 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1__1 
       (.I0(n_0_run_phase_alignment_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_1__1 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2__1 
       (.I0(\n_0_wait_bypass_count[0]_i_4__1 ),
        .I1(\n_0_wait_bypass_count[0]_i_5__1 ),
        .I2(\n_0_wait_bypass_count[0]_i_6__1 ),
        .I3(n_0_tx_fsm_reset_done_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_2__1 ));
LUT5 #(
    .INIT(32'hBFFFFFFF)) 
     \wait_bypass_count[0]_i_4__1 
       (.I0(wait_bypass_count_reg[15]),
        .I1(wait_bypass_count_reg[1]),
        .I2(wait_bypass_count_reg[2]),
        .I3(wait_bypass_count_reg[16]),
        .I4(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_4__1 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFDFF)) 
     \wait_bypass_count[0]_i_5__1 
       (.I0(wait_bypass_count_reg[10]),
        .I1(wait_bypass_count_reg[9]),
        .I2(wait_bypass_count_reg[14]),
        .I3(wait_bypass_count_reg[13]),
        .I4(wait_bypass_count_reg[11]),
        .I5(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[0]_i_5__1 ));
LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_6__1 
       (.I0(wait_bypass_count_reg[4]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[7]),
        .I3(wait_bypass_count_reg[8]),
        .I4(wait_bypass_count_reg[5]),
        .I5(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[0]_i_6__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7__1 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_7__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8__1 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_8__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_9__5 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_9__5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2__1 
       (.I0(wait_bypass_count_reg[15]),
        .O(\n_0_wait_bypass_count[12]_i_2__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_3__1 
       (.I0(wait_bypass_count_reg[14]),
        .O(\n_0_wait_bypass_count[12]_i_3__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_4__1 
       (.I0(wait_bypass_count_reg[13]),
        .O(\n_0_wait_bypass_count[12]_i_4__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_5__1 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_5__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[16]_i_2__1 
       (.I0(wait_bypass_count_reg[16]),
        .O(\n_0_wait_bypass_count[16]_i_2__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2__1 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3__1 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4__1 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5__1 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2__1 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3__1 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4__1 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4__1 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5__1 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5__1 ));
FDRE \wait_bypass_count_reg[0] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3__1 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
CARRY4 \wait_bypass_count_reg[0]_i_3__1 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3__1 ,\n_1_wait_bypass_count_reg[0]_i_3__1 ,\n_2_wait_bypass_count_reg[0]_i_3__1 ,\n_3_wait_bypass_count_reg[0]_i_3__1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3__1 ,\n_5_wait_bypass_count_reg[0]_i_3__1 ,\n_6_wait_bypass_count_reg[0]_i_3__1 ,\n_7_wait_bypass_count_reg[0]_i_3__1 }),
        .S({\n_0_wait_bypass_count[0]_i_7__1 ,\n_0_wait_bypass_count[0]_i_8__1 ,\n_0_wait_bypass_count[0]_i_9__5 ,\n_0_wait_bypass_count[0]_i_10__1 }));
FDRE \wait_bypass_count_reg[10] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1__1 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[11] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1__1 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[12] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1__1 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
CARRY4 \wait_bypass_count_reg[12]_i_1__1 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1__1 ),
        .CO({\n_0_wait_bypass_count_reg[12]_i_1__1 ,\n_1_wait_bypass_count_reg[12]_i_1__1 ,\n_2_wait_bypass_count_reg[12]_i_1__1 ,\n_3_wait_bypass_count_reg[12]_i_1__1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[12]_i_1__1 ,\n_5_wait_bypass_count_reg[12]_i_1__1 ,\n_6_wait_bypass_count_reg[12]_i_1__1 ,\n_7_wait_bypass_count_reg[12]_i_1__1 }),
        .S({\n_0_wait_bypass_count[12]_i_2__1 ,\n_0_wait_bypass_count[12]_i_3__1 ,\n_0_wait_bypass_count[12]_i_4__1 ,\n_0_wait_bypass_count[12]_i_5__1 }));
FDRE \wait_bypass_count_reg[13] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_6_wait_bypass_count_reg[12]_i_1__1 ),
        .Q(wait_bypass_count_reg[13]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[14] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_5_wait_bypass_count_reg[12]_i_1__1 ),
        .Q(wait_bypass_count_reg[14]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[15] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_4_wait_bypass_count_reg[12]_i_1__1 ),
        .Q(wait_bypass_count_reg[15]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[16] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_7_wait_bypass_count_reg[16]_i_1__1 ),
        .Q(wait_bypass_count_reg[16]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
CARRY4 \wait_bypass_count_reg[16]_i_1__1 
       (.CI(\n_0_wait_bypass_count_reg[12]_i_1__1 ),
        .CO(\NLW_wait_bypass_count_reg[16]_i_1__1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[16]_i_1__1_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[16]_i_1__1 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[16]_i_2__1 }));
FDRE \wait_bypass_count_reg[1] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3__1 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[2] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3__1 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[3] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3__1 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[4] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1__1 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
CARRY4 \wait_bypass_count_reg[4]_i_1__1 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3__1 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1__1 ,\n_1_wait_bypass_count_reg[4]_i_1__1 ,\n_2_wait_bypass_count_reg[4]_i_1__1 ,\n_3_wait_bypass_count_reg[4]_i_1__1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1__1 ,\n_5_wait_bypass_count_reg[4]_i_1__1 ,\n_6_wait_bypass_count_reg[4]_i_1__1 ,\n_7_wait_bypass_count_reg[4]_i_1__1 }),
        .S({\n_0_wait_bypass_count[4]_i_2__1 ,\n_0_wait_bypass_count[4]_i_3__1 ,\n_0_wait_bypass_count[4]_i_4__1 ,\n_0_wait_bypass_count[4]_i_5__1 }));
FDRE \wait_bypass_count_reg[5] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1__1 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[6] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1__1 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[7] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1__1 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
FDRE \wait_bypass_count_reg[8] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1__1 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
CARRY4 \wait_bypass_count_reg[8]_i_1__1 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1__1 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1__1 ,\n_1_wait_bypass_count_reg[8]_i_1__1 ,\n_2_wait_bypass_count_reg[8]_i_1__1 ,\n_3_wait_bypass_count_reg[8]_i_1__1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1__1 ,\n_5_wait_bypass_count_reg[8]_i_1__1 ,\n_6_wait_bypass_count_reg[8]_i_1__1 ,\n_7_wait_bypass_count_reg[8]_i_1__1 }),
        .S({\n_0_wait_bypass_count[8]_i_2__1 ,\n_0_wait_bypass_count[8]_i_3__1 ,\n_0_wait_bypass_count[8]_i_4__1 ,\n_0_wait_bypass_count[8]_i_5__1 }));
FDRE \wait_bypass_count_reg[9] 
       (.C(gt2_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__1 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1__1 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1__1 ));
(* SOFT_HLUTNM = "soft_lutpair70" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1__1 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__1[0]));
(* SOFT_HLUTNM = "soft_lutpair70" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1__1 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\n_0_wait_time_cnt[1]_i_1__1 ));
(* SOFT_HLUTNM = "soft_lutpair64" *) 
   LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1__1 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__1[2]));
(* SOFT_HLUTNM = "soft_lutpair60" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \wait_time_cnt[3]_i_1__1 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0__1[3]));
(* SOFT_HLUTNM = "soft_lutpair60" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1__1 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\n_0_wait_time_cnt[4]_i_1__1 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[5]_i_1__1 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[1]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__1[5]));
LUT4 #(
    .INIT(16'h0700)) 
     \wait_time_cnt[6]_i_1__1 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[3]),
        .I3(tx_state[0]),
        .O(\n_0_wait_time_cnt[6]_i_1__1 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_2__1 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(wait_time_cnt_reg__0[5]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .I5(\n_0_wait_time_cnt[6]_i_4__1 ),
        .O(\n_0_wait_time_cnt[6]_i_2__1 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[6]_i_3__1 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4__1 ),
        .I2(wait_time_cnt_reg__0[3]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[5]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__1[6]));
(* SOFT_HLUTNM = "soft_lutpair64" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_4__1 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(\n_0_wait_time_cnt[6]_i_4__1 ));
FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__1 ),
        .D(wait_time_cnt0__1[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\n_0_wait_time_cnt[6]_i_1__1 ));
FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__1 ),
        .D(\n_0_wait_time_cnt[1]_i_1__1 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\n_0_wait_time_cnt[6]_i_1__1 ));
FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__1 ),
        .D(wait_time_cnt0__1[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\n_0_wait_time_cnt[6]_i_1__1 ));
FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__1 ),
        .D(wait_time_cnt0__1[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\n_0_wait_time_cnt[6]_i_1__1 ));
FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__1 ),
        .D(\n_0_wait_time_cnt[4]_i_1__1 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\n_0_wait_time_cnt[6]_i_1__1 ));
FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__1 ),
        .D(wait_time_cnt0__1[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\n_0_wait_time_cnt[6]_i_1__1 ));
FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__1 ),
        .D(wait_time_cnt0__1[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\n_0_wait_time_cnt[6]_i_1__1 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_TX_STARTUP_FSM" *) 
module XLAUI_XLAUI_TX_STARTUP_FSM__parameterized0_5
   (O1,
    GT3_TX_MMCM_RESET_OUT,
    GT3_TX_FSM_RESET_DONE_OUT,
    O2,
    SYSCLK_IN,
    gt3_txusrclk_in,
    SOFT_RESET_IN,
    gt3_txresetdone_out,
    GT3_TX_MMCM_LOCK_IN,
    GT0_QPLLLOCK_IN);
  output O1;
  output GT3_TX_MMCM_RESET_OUT;
  output GT3_TX_FSM_RESET_DONE_OUT;
  output O2;
  input SYSCLK_IN;
  input gt3_txusrclk_in;
  input SOFT_RESET_IN;
  input gt3_txresetdone_out;
  input GT3_TX_MMCM_LOCK_IN;
  input GT0_QPLLLOCK_IN;

  wire GT0_QPLLLOCK_IN;
  wire GT3_TX_FSM_RESET_DONE_OUT;
  wire GT3_TX_MMCM_LOCK_IN;
  wire GT3_TX_MMCM_RESET_OUT;
  wire O1;
  wire O2;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire data_out;
  wire gt3_txresetdone_out;
  wire gt3_txusrclk_in;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_tx_state[0]_i_1__2 ;
  wire \n_0_FSM_sequential_tx_state[0]_i_2__2 ;
  wire \n_0_FSM_sequential_tx_state[1]_i_1__2 ;
  wire \n_0_FSM_sequential_tx_state[1]_i_2__2 ;
  wire \n_0_FSM_sequential_tx_state[2]_i_1__2 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_2__2 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_4__2 ;
  wire n_0_MMCM_RESET_i_1__2;
  wire n_0_TXUSERRDY_i_1__2;
  wire n_0_gttxreset_i_i_1__2;
  wire \n_0_init_wait_count[6]_i_1__2 ;
  wire \n_0_init_wait_count[6]_i_3__2 ;
  wire \n_0_init_wait_count[6]_i_4__2 ;
  wire n_0_init_wait_done_i_1__2;
  wire n_0_init_wait_done_reg;
  wire \n_0_mmcm_lock_count[6]_i_2__2 ;
  wire \n_0_mmcm_lock_count[7]_i_2__2 ;
  wire \n_0_mmcm_lock_count[7]_i_4__2 ;
  wire n_0_pll_reset_asserted_i_1__2;
  wire n_0_pll_reset_asserted_reg;
  wire n_0_reset_time_out_reg;
  wire n_0_run_phase_alignment_int_i_1__2;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_run_phase_alignment_int_s3_reg;
  wire n_0_sync_QPLLLOCK;
  wire n_0_sync_mmcm_lock_reclocked;
  wire n_0_time_out_2ms_i_1__2;
  wire n_0_time_out_2ms_reg;
  wire n_0_time_out_500us_i_1__6;
  wire n_0_time_out_500us_i_2__6;
  wire n_0_time_out_500us_i_3__6;
  wire n_0_time_out_500us_i_4__2;
  wire n_0_time_out_500us_reg;
  wire \n_0_time_out_counter[0]_i_1__2 ;
  wire \n_0_time_out_counter[0]_i_4__6 ;
  wire \n_0_time_out_counter[0]_i_5__2 ;
  wire \n_0_time_out_counter[0]_i_6__2 ;
  wire \n_0_time_out_counter[0]_i_7__2 ;
  wire \n_0_time_out_counter[0]_i_8__6 ;
  wire \n_0_time_out_counter[0]_i_9__2 ;
  wire \n_0_time_out_counter[12]_i_2__2 ;
  wire \n_0_time_out_counter[12]_i_3__2 ;
  wire \n_0_time_out_counter[12]_i_4__2 ;
  wire \n_0_time_out_counter[12]_i_5__2 ;
  wire \n_0_time_out_counter[16]_i_2__2 ;
  wire \n_0_time_out_counter[16]_i_3__2 ;
  wire \n_0_time_out_counter[16]_i_4__2 ;
  wire \n_0_time_out_counter[4]_i_2__2 ;
  wire \n_0_time_out_counter[4]_i_3__2 ;
  wire \n_0_time_out_counter[4]_i_4__2 ;
  wire \n_0_time_out_counter[4]_i_5__2 ;
  wire \n_0_time_out_counter[8]_i_2__2 ;
  wire \n_0_time_out_counter[8]_i_3__2 ;
  wire \n_0_time_out_counter[8]_i_4__2 ;
  wire \n_0_time_out_counter[8]_i_5__2 ;
  wire \n_0_time_out_counter_reg[0]_i_2__2 ;
  wire \n_0_time_out_counter_reg[12]_i_1__2 ;
  wire \n_0_time_out_counter_reg[4]_i_1__2 ;
  wire \n_0_time_out_counter_reg[8]_i_1__2 ;
  wire n_0_time_out_wait_bypass_i_1__2;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_1__2;
  wire n_0_time_tlock_max_i_2;
  wire n_0_time_tlock_max_i_3__0;
  wire n_0_time_tlock_max_i_4__6;
  wire n_0_time_tlock_max_i_5__3;
  wire n_0_time_tlock_max_reg;
  wire n_0_tx_fsm_reset_done_int_i_1__2;
  wire n_0_tx_fsm_reset_done_int_s3_reg;
  wire \n_0_wait_bypass_count[0]_i_10__2 ;
  wire \n_0_wait_bypass_count[0]_i_1__2 ;
  wire \n_0_wait_bypass_count[0]_i_2__2 ;
  wire \n_0_wait_bypass_count[0]_i_4__2 ;
  wire \n_0_wait_bypass_count[0]_i_5__2 ;
  wire \n_0_wait_bypass_count[0]_i_6__2 ;
  wire \n_0_wait_bypass_count[0]_i_7__2 ;
  wire \n_0_wait_bypass_count[0]_i_8__2 ;
  wire \n_0_wait_bypass_count[0]_i_9__6 ;
  wire \n_0_wait_bypass_count[12]_i_2__2 ;
  wire \n_0_wait_bypass_count[12]_i_3__2 ;
  wire \n_0_wait_bypass_count[12]_i_4__2 ;
  wire \n_0_wait_bypass_count[12]_i_5__2 ;
  wire \n_0_wait_bypass_count[16]_i_2__2 ;
  wire \n_0_wait_bypass_count[4]_i_2__2 ;
  wire \n_0_wait_bypass_count[4]_i_3__2 ;
  wire \n_0_wait_bypass_count[4]_i_4__2 ;
  wire \n_0_wait_bypass_count[4]_i_5__2 ;
  wire \n_0_wait_bypass_count[8]_i_2__2 ;
  wire \n_0_wait_bypass_count[8]_i_3__2 ;
  wire \n_0_wait_bypass_count[8]_i_4__2 ;
  wire \n_0_wait_bypass_count[8]_i_5__2 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3__2 ;
  wire \n_0_wait_bypass_count_reg[12]_i_1__2 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1__2 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1__2 ;
  wire \n_0_wait_time_cnt[1]_i_1__2 ;
  wire \n_0_wait_time_cnt[4]_i_1__2 ;
  wire \n_0_wait_time_cnt[6]_i_1__2 ;
  wire \n_0_wait_time_cnt[6]_i_2__2 ;
  wire \n_0_wait_time_cnt[6]_i_4__2 ;
  wire n_1_sync_QPLLLOCK;
  wire n_1_sync_mmcm_lock_reclocked;
  wire \n_1_time_out_counter_reg[0]_i_2__2 ;
  wire \n_1_time_out_counter_reg[12]_i_1__2 ;
  wire \n_1_time_out_counter_reg[4]_i_1__2 ;
  wire \n_1_time_out_counter_reg[8]_i_1__2 ;
  wire \n_1_wait_bypass_count_reg[0]_i_3__2 ;
  wire \n_1_wait_bypass_count_reg[12]_i_1__2 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1__2 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1__2 ;
  wire \n_2_time_out_counter_reg[0]_i_2__2 ;
  wire \n_2_time_out_counter_reg[12]_i_1__2 ;
  wire \n_2_time_out_counter_reg[16]_i_1__2 ;
  wire \n_2_time_out_counter_reg[4]_i_1__2 ;
  wire \n_2_time_out_counter_reg[8]_i_1__2 ;
  wire \n_2_wait_bypass_count_reg[0]_i_3__2 ;
  wire \n_2_wait_bypass_count_reg[12]_i_1__2 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1__2 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1__2 ;
  wire \n_3_time_out_counter_reg[0]_i_2__2 ;
  wire \n_3_time_out_counter_reg[12]_i_1__2 ;
  wire \n_3_time_out_counter_reg[16]_i_1__2 ;
  wire \n_3_time_out_counter_reg[4]_i_1__2 ;
  wire \n_3_time_out_counter_reg[8]_i_1__2 ;
  wire \n_3_wait_bypass_count_reg[0]_i_3__2 ;
  wire \n_3_wait_bypass_count_reg[12]_i_1__2 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1__2 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1__2 ;
  wire \n_4_time_out_counter_reg[0]_i_2__2 ;
  wire \n_4_time_out_counter_reg[12]_i_1__2 ;
  wire \n_4_time_out_counter_reg[4]_i_1__2 ;
  wire \n_4_time_out_counter_reg[8]_i_1__2 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3__2 ;
  wire \n_4_wait_bypass_count_reg[12]_i_1__2 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1__2 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1__2 ;
  wire \n_5_time_out_counter_reg[0]_i_2__2 ;
  wire \n_5_time_out_counter_reg[12]_i_1__2 ;
  wire \n_5_time_out_counter_reg[16]_i_1__2 ;
  wire \n_5_time_out_counter_reg[4]_i_1__2 ;
  wire \n_5_time_out_counter_reg[8]_i_1__2 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3__2 ;
  wire \n_5_wait_bypass_count_reg[12]_i_1__2 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1__2 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1__2 ;
  wire \n_6_time_out_counter_reg[0]_i_2__2 ;
  wire \n_6_time_out_counter_reg[12]_i_1__2 ;
  wire \n_6_time_out_counter_reg[16]_i_1__2 ;
  wire \n_6_time_out_counter_reg[4]_i_1__2 ;
  wire \n_6_time_out_counter_reg[8]_i_1__2 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3__2 ;
  wire \n_6_wait_bypass_count_reg[12]_i_1__2 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1__2 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1__2 ;
  wire \n_7_time_out_counter_reg[0]_i_2__2 ;
  wire \n_7_time_out_counter_reg[12]_i_1__2 ;
  wire \n_7_time_out_counter_reg[16]_i_1__2 ;
  wire \n_7_time_out_counter_reg[4]_i_1__2 ;
  wire \n_7_time_out_counter_reg[8]_i_1__2 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3__2 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1__2 ;
  wire \n_7_wait_bypass_count_reg[16]_i_1__2 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1__2 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1__2 ;
  wire [6:0]p_0_in__5;
  wire [7:0]p_0_in__6;
  wire time_out_2ms;
  wire [18:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire tx_fsm_reset_done_int_s2;
(* RTL_KEEP = "yes" *)   wire [3:0]tx_state;
  wire tx_state12_out;
  wire tx_state13_out;
  wire txresetdone_s2;
  wire txresetdone_s3;
  wire [16:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0__2;
  wire [6:0]wait_time_cnt_reg__0;
  wire wait_time_done;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__2_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__2_O_UNCONNECTED ;
  wire [3:0]\NLW_wait_bypass_count_reg[16]_i_1__2_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[16]_i_1__2_O_UNCONNECTED ;

LUT5 #(
    .INIT(32'h0F001F1F)) 
     \FSM_sequential_tx_state[0]_i_1__2 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[3]),
        .I3(\n_0_FSM_sequential_tx_state[0]_i_2__2 ),
        .I4(tx_state[0]),
        .O(\n_0_FSM_sequential_tx_state[0]_i_1__2 ));
LUT6 #(
    .INIT(64'h22F0000022F0FFFF)) 
     \FSM_sequential_tx_state[0]_i_2__2 
       (.I0(n_0_time_out_500us_reg),
        .I1(n_0_reset_time_out_reg),
        .I2(n_0_time_out_2ms_reg),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .I5(\n_0_FSM_sequential_tx_state[1]_i_2__2 ),
        .O(\n_0_FSM_sequential_tx_state[0]_i_2__2 ));
LUT4 #(
    .INIT(16'h0062)) 
     \FSM_sequential_tx_state[1]_i_1__2 
       (.I0(tx_state[1]),
        .I1(tx_state[0]),
        .I2(\n_0_FSM_sequential_tx_state[1]_i_2__2 ),
        .I3(tx_state[3]),
        .O(\n_0_FSM_sequential_tx_state[1]_i_1__2 ));
LUT4 #(
    .INIT(16'hFFDF)) 
     \FSM_sequential_tx_state[1]_i_2__2 
       (.I0(tx_state[2]),
        .I1(mmcm_lock_reclocked),
        .I2(n_0_time_tlock_max_reg),
        .I3(n_0_reset_time_out_reg),
        .O(\n_0_FSM_sequential_tx_state[1]_i_2__2 ));
LUT6 #(
    .INIT(64'h00000000222A662A)) 
     \FSM_sequential_tx_state[2]_i_1__2 
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state13_out),
        .I3(tx_state[1]),
        .I4(n_0_time_out_2ms_reg),
        .I5(tx_state[3]),
        .O(\n_0_FSM_sequential_tx_state[2]_i_1__2 ));
(* SOFT_HLUTNM = "soft_lutpair90" *) 
   LUT3 #(
    .INIT(8'h04)) 
     \FSM_sequential_tx_state[2]_i_2__2 
       (.I0(n_0_reset_time_out_reg),
        .I1(n_0_time_tlock_max_reg),
        .I2(mmcm_lock_reclocked),
        .O(tx_state13_out));
LUT6 #(
    .INIT(64'h0300004C00000044)) 
     \FSM_sequential_tx_state[3]_i_2__2 
       (.I0(time_out_wait_bypass_s3),
        .I1(tx_state[3]),
        .I2(tx_state12_out),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .I5(tx_state[0]),
        .O(\n_0_FSM_sequential_tx_state[3]_i_2__2 ));
LUT2 #(
    .INIT(4'h1)) 
     \FSM_sequential_tx_state[3]_i_4__2 
       (.I0(tx_state[2]),
        .I1(tx_state[1]),
        .O(\n_0_FSM_sequential_tx_state[3]_i_4__2 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_sequential_tx_state[3]_i_5__2 
       (.I0(\n_0_wait_time_cnt[6]_i_4__2 ),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[5]),
        .I4(wait_time_cnt_reg__0[4]),
        .I5(wait_time_cnt_reg__0[6]),
        .O(wait_time_done));
(* SOFT_HLUTNM = "soft_lutpair90" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_tx_state[3]_i_6__2 
       (.I0(n_0_time_out_500us_reg),
        .I1(n_0_reset_time_out_reg),
        .O(tx_state12_out));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[0]_i_1__2 ),
        .Q(tx_state[0]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[1]_i_1__2 ),
        .Q(tx_state[1]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[2]_i_1__2 ),
        .Q(tx_state[2]),
        .R(SOFT_RESET_IN));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(n_1_sync_QPLLLOCK),
        .D(\n_0_FSM_sequential_tx_state[3]_i_2__2 ),
        .Q(tx_state[3]),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFDF0010)) 
     MMCM_RESET_i_1__2
       (.I0(tx_state[2]),
        .I1(tx_state[1]),
        .I2(tx_state[0]),
        .I3(tx_state[3]),
        .I4(GT3_TX_MMCM_RESET_OUT),
        .O(n_0_MMCM_RESET_i_1__2));
FDRE #(
    .INIT(1'b1)) 
     MMCM_RESET_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_MMCM_RESET_i_1__2),
        .Q(GT3_TX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFD0080)) 
     TXUSERRDY_i_1__2
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[3]),
        .I4(O2),
        .O(n_0_TXUSERRDY_i_1__2));
FDRE #(
    .INIT(1'b0)) 
     TXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_TXUSERRDY_i_1__2),
        .Q(O2),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFFFB0010)) 
     gttxreset_i_i_1__2
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[0]),
        .I3(tx_state[3]),
        .I4(O1),
        .O(n_0_gttxreset_i_i_1__2));
FDRE #(
    .INIT(1'b0)) 
     gttxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gttxreset_i_i_1__2),
        .Q(O1),
        .R(SOFT_RESET_IN));
(* SOFT_HLUTNM = "soft_lutpair92" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1__2 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in__5[0]));
(* SOFT_HLUTNM = "soft_lutpair92" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1__2 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in__5[1]));
(* SOFT_HLUTNM = "soft_lutpair88" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[2]_i_1__2 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .O(p_0_in__5[2]));
(* SOFT_HLUTNM = "soft_lutpair88" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \init_wait_count[3]_i_1__2 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .O(p_0_in__5[3]));
(* SOFT_HLUTNM = "soft_lutpair85" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \init_wait_count[4]_i_1__2 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .O(p_0_in__5[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \init_wait_count[5]_i_1__2 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[3]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[0]),
        .I5(init_wait_count_reg__0[4]),
        .O(p_0_in__5[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
     \init_wait_count[6]_i_1__2 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[0]),
        .I3(\n_0_init_wait_count[6]_i_3__2 ),
        .I4(init_wait_count_reg__0[4]),
        .I5(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_1__2 ));
LUT3 #(
    .INIT(8'h6A)) 
     \init_wait_count[6]_i_2__2 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\n_0_init_wait_count[6]_i_4__2 ),
        .I2(init_wait_count_reg__0[5]),
        .O(p_0_in__5[6]));
LUT2 #(
    .INIT(4'h7)) 
     \init_wait_count[6]_i_3__2 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_3__2 ));
(* SOFT_HLUTNM = "soft_lutpair85" *) 
   LUT5 #(
    .INIT(32'h80000000)) 
     \init_wait_count[6]_i_4__2 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(\n_0_init_wait_count[6]_i_4__2 ));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__2 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__5[0]),
        .Q(init_wait_count_reg__0[0]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__2 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__5[1]),
        .Q(init_wait_count_reg__0[1]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__2 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__5[2]),
        .Q(init_wait_count_reg__0[2]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__2 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__5[3]),
        .Q(init_wait_count_reg__0[3]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__2 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__5[4]),
        .Q(init_wait_count_reg__0[4]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__2 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__5[5]),
        .Q(init_wait_count_reg__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_init_wait_count[6]_i_1__2 ),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in__5[6]),
        .Q(init_wait_count_reg__0[6]));
LUT2 #(
    .INIT(4'hE)) 
     init_wait_done_i_1__2
       (.I0(init_wait_done),
        .I1(n_0_init_wait_done_reg),
        .O(n_0_init_wait_done_i_1__2));
LUT6 #(
    .INIT(64'h0000000004000000)) 
     init_wait_done_i_2__2
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[4]),
        .I2(\n_0_init_wait_count[6]_i_3__2 ),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_done));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(n_0_init_wait_done_i_1__2),
        .Q(n_0_init_wait_done_reg));
(* SOFT_HLUTNM = "soft_lutpair93" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__6[0]));
(* SOFT_HLUTNM = "soft_lutpair93" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__6[1]));
(* SOFT_HLUTNM = "soft_lutpair91" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[2]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__6[2]));
(* SOFT_HLUTNM = "soft_lutpair86" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \mmcm_lock_count[3]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__6[3]));
(* SOFT_HLUTNM = "soft_lutpair86" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \mmcm_lock_count[4]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[3]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__6[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[5]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__6[5]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \mmcm_lock_count[6]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(\n_0_mmcm_lock_count[6]_i_2__2 ),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__6[6]));
(* SOFT_HLUTNM = "soft_lutpair91" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \mmcm_lock_count[6]_i_2__2 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(\n_0_mmcm_lock_count[6]_i_2__2 ));
LUT3 #(
    .INIT(8'h7F)) 
     \mmcm_lock_count[7]_i_2__2 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__2 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(\n_0_mmcm_lock_count[7]_i_2__2 ));
LUT3 #(
    .INIT(8'h6A)) 
     \mmcm_lock_count[7]_i_3__2 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[7]_i_4__2 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__6[7]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \mmcm_lock_count[7]_i_4__2 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(\n_0_mmcm_lock_count[7]_i_4__2 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__2 ),
        .D(p_0_in__6[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__2 ),
        .D(p_0_in__6[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__2 ),
        .D(p_0_in__6[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__2 ),
        .D(p_0_in__6[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__2 ),
        .D(p_0_in__6[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__2 ),
        .D(p_0_in__6[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__2 ),
        .D(p_0_in__6[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_mmcm_lock_count[7]_i_2__2 ),
        .D(p_0_in__6[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(n_0_sync_mmcm_lock_reclocked));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
LUT5 #(
    .INIT(32'hF0F0F072)) 
     pll_reset_asserted_i_1__2
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(n_0_pll_reset_asserted_reg),
        .I3(tx_state[2]),
        .I4(tx_state[3]),
        .O(n_0_pll_reset_asserted_i_1__2));
FDRE #(
    .INIT(1'b0)) 
     pll_reset_asserted_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_pll_reset_asserted_i_1__2),
        .Q(n_0_pll_reset_asserted_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_sync_QPLLLOCK),
        .Q(n_0_reset_time_out_reg),
        .R(SOFT_RESET_IN));
LUT5 #(
    .INIT(32'hFEFF0002)) 
     run_phase_alignment_int_i_1__2
       (.I0(tx_state[3]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1__2));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1__2),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_out),
        .Q(n_0_run_phase_alignment_int_s3_reg),
        .R(1'b0));
XLAUI_XLAUI_sync_block__parameterized0 sync_QPLLLOCK
       (.E(n_1_sync_QPLLLOCK),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .I1(n_0_init_wait_done_reg),
        .I2(n_0_reset_time_out_reg),
        .I3(\n_0_FSM_sequential_tx_state[3]_i_4__2 ),
        .I4(n_0_time_out_500us_reg),
        .I5(n_0_time_out_2ms_reg),
        .I6(n_0_time_tlock_max_reg),
        .I7(n_0_pll_reset_asserted_reg),
        .O1(n_0_sync_QPLLLOCK),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(tx_state),
        .txresetdone_s3(txresetdone_s3),
        .wait_time_done(wait_time_done));
XLAUI_XLAUI_sync_block__parameterized0_6 sync_TXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(txresetdone_s2),
        .gt3_txresetdone_out(gt3_txresetdone_out));
XLAUI_XLAUI_sync_block__parameterized0_7 sync_mmcm_lock_reclocked
       (.GT3_TX_MMCM_LOCK_IN(GT3_TX_MMCM_LOCK_IN),
        .I1(\n_0_mmcm_lock_count[7]_i_4__2 ),
        .O1(n_1_sync_mmcm_lock_reclocked),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(n_0_sync_mmcm_lock_reclocked),
        .SYSCLK_IN(SYSCLK_IN),
        .mmcm_lock_reclocked(mmcm_lock_reclocked));
XLAUI_XLAUI_sync_block__parameterized0_8 sync_run_phase_alignment_int
       (.data_in(n_0_run_phase_alignment_int_reg),
        .data_out(data_out),
        .gt3_txusrclk_in(gt3_txusrclk_in));
XLAUI_XLAUI_sync_block__parameterized0_9 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
XLAUI_XLAUI_sync_block__parameterized0_10 sync_tx_fsm_reset_done_int
       (.GT3_TX_FSM_RESET_DONE_OUT(GT3_TX_FSM_RESET_DONE_OUT),
        .data_out(tx_fsm_reset_done_int_s2),
        .gt3_txusrclk_in(gt3_txusrclk_in));
LUT3 #(
    .INIT(8'h0E)) 
     time_out_2ms_i_1__2
       (.I0(n_0_time_out_2ms_reg),
        .I1(time_out_2ms),
        .I2(n_0_reset_time_out_reg),
        .O(n_0_time_out_2ms_i_1__2));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1__2),
        .Q(n_0_time_out_2ms_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000AAEAAAAA)) 
     time_out_500us_i_1__6
       (.I0(n_0_time_out_500us_reg),
        .I1(n_0_time_out_500us_i_2__6),
        .I2(n_0_time_out_500us_i_3__6),
        .I3(n_0_time_out_500us_i_4__2),
        .I4(n_0_time_tlock_max_i_3__0),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_time_out_500us_i_1__6));
(* SOFT_HLUTNM = "soft_lutpair84" *) 
   LUT5 #(
    .INIT(32'h20000000)) 
     time_out_500us_i_2__6
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[2]),
        .I4(time_out_counter_reg[10]),
        .O(n_0_time_out_500us_i_2__6));
LUT6 #(
    .INIT(64'h0000000000000010)) 
     time_out_500us_i_3__6
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[4]),
        .I4(time_out_counter_reg[3]),
        .I5(time_out_counter_reg[18]),
        .O(n_0_time_out_500us_i_3__6));
LUT4 #(
    .INIT(16'hFFF7)) 
     time_out_500us_i_4__2
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[16]),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_counter_reg[1]),
        .O(n_0_time_out_500us_i_4__2));
FDRE #(
    .INIT(1'b0)) 
     time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_out_500us_i_1__6),
        .Q(n_0_time_out_500us_reg),
        .R(1'b0));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_1__2 
       (.I0(time_out_2ms),
        .O(\n_0_time_out_counter[0]_i_1__2 ));
LUT6 #(
    .INIT(64'h0080000000000000)) 
     \time_out_counter[0]_i_3__6 
       (.I0(\n_0_time_out_counter[0]_i_8__6 ),
        .I1(\n_0_time_out_counter[0]_i_9__2 ),
        .I2(n_0_time_tlock_max_i_3__0),
        .I3(n_0_time_out_500us_i_4__2),
        .I4(time_out_counter_reg[2]),
        .I5(time_out_counter_reg[10]),
        .O(time_out_2ms));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_4__6 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_4__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_5__2 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_5__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6__2 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_6__2 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_7__2 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_7__2 ));
LUT3 #(
    .INIT(8'h04)) 
     \time_out_counter[0]_i_8__6 
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[0]_i_8__6 ));
LUT6 #(
    .INIT(64'h0004000000000000)) 
     \time_out_counter[0]_i_9__2 
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[18]),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[4]),
        .I5(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[0]_i_9__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2__2 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3__2 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4__2 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5__2 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2__2 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_2__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3__2 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_3__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4__2 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_4__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2__2 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3__2 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4__2 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5__2 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2__2 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3__2 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4__2 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5__2 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5__2 ));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_7_time_out_counter_reg[0]_i_2__2 ),
        .Q(time_out_counter_reg[0]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[0]_i_2__2 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2__2 ,\n_1_time_out_counter_reg[0]_i_2__2 ,\n_2_time_out_counter_reg[0]_i_2__2 ,\n_3_time_out_counter_reg[0]_i_2__2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2__2 ,\n_5_time_out_counter_reg[0]_i_2__2 ,\n_6_time_out_counter_reg[0]_i_2__2 ,\n_7_time_out_counter_reg[0]_i_2__2 }),
        .S({\n_0_time_out_counter[0]_i_4__6 ,\n_0_time_out_counter[0]_i_5__2 ,\n_0_time_out_counter[0]_i_6__2 ,\n_0_time_out_counter[0]_i_7__2 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_5_time_out_counter_reg[8]_i_1__2 ),
        .Q(time_out_counter_reg[10]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_4_time_out_counter_reg[8]_i_1__2 ),
        .Q(time_out_counter_reg[11]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_7_time_out_counter_reg[12]_i_1__2 ),
        .Q(time_out_counter_reg[12]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[12]_i_1__2 
       (.CI(\n_0_time_out_counter_reg[8]_i_1__2 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1__2 ,\n_1_time_out_counter_reg[12]_i_1__2 ,\n_2_time_out_counter_reg[12]_i_1__2 ,\n_3_time_out_counter_reg[12]_i_1__2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1__2 ,\n_5_time_out_counter_reg[12]_i_1__2 ,\n_6_time_out_counter_reg[12]_i_1__2 ,\n_7_time_out_counter_reg[12]_i_1__2 }),
        .S({\n_0_time_out_counter[12]_i_2__2 ,\n_0_time_out_counter[12]_i_3__2 ,\n_0_time_out_counter[12]_i_4__2 ,\n_0_time_out_counter[12]_i_5__2 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_6_time_out_counter_reg[12]_i_1__2 ),
        .Q(time_out_counter_reg[13]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_5_time_out_counter_reg[12]_i_1__2 ),
        .Q(time_out_counter_reg[14]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_4_time_out_counter_reg[12]_i_1__2 ),
        .Q(time_out_counter_reg[15]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_7_time_out_counter_reg[16]_i_1__2 ),
        .Q(time_out_counter_reg[16]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[16]_i_1__2 
       (.CI(\n_0_time_out_counter_reg[12]_i_1__2 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__2_CO_UNCONNECTED [3:2],\n_2_time_out_counter_reg[16]_i_1__2 ,\n_3_time_out_counter_reg[16]_i_1__2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__2_O_UNCONNECTED [3],\n_5_time_out_counter_reg[16]_i_1__2 ,\n_6_time_out_counter_reg[16]_i_1__2 ,\n_7_time_out_counter_reg[16]_i_1__2 }),
        .S({1'b0,\n_0_time_out_counter[16]_i_2__2 ,\n_0_time_out_counter[16]_i_3__2 ,\n_0_time_out_counter[16]_i_4__2 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_6_time_out_counter_reg[16]_i_1__2 ),
        .Q(time_out_counter_reg[17]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_5_time_out_counter_reg[16]_i_1__2 ),
        .Q(time_out_counter_reg[18]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_6_time_out_counter_reg[0]_i_2__2 ),
        .Q(time_out_counter_reg[1]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_5_time_out_counter_reg[0]_i_2__2 ),
        .Q(time_out_counter_reg[2]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_4_time_out_counter_reg[0]_i_2__2 ),
        .Q(time_out_counter_reg[3]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_7_time_out_counter_reg[4]_i_1__2 ),
        .Q(time_out_counter_reg[4]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[4]_i_1__2 
       (.CI(\n_0_time_out_counter_reg[0]_i_2__2 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1__2 ,\n_1_time_out_counter_reg[4]_i_1__2 ,\n_2_time_out_counter_reg[4]_i_1__2 ,\n_3_time_out_counter_reg[4]_i_1__2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1__2 ,\n_5_time_out_counter_reg[4]_i_1__2 ,\n_6_time_out_counter_reg[4]_i_1__2 ,\n_7_time_out_counter_reg[4]_i_1__2 }),
        .S({\n_0_time_out_counter[4]_i_2__2 ,\n_0_time_out_counter[4]_i_3__2 ,\n_0_time_out_counter[4]_i_4__2 ,\n_0_time_out_counter[4]_i_5__2 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_6_time_out_counter_reg[4]_i_1__2 ),
        .Q(time_out_counter_reg[5]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_5_time_out_counter_reg[4]_i_1__2 ),
        .Q(time_out_counter_reg[6]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_4_time_out_counter_reg[4]_i_1__2 ),
        .Q(time_out_counter_reg[7]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_7_time_out_counter_reg[8]_i_1__2 ),
        .Q(time_out_counter_reg[8]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[8]_i_1__2 
       (.CI(\n_0_time_out_counter_reg[4]_i_1__2 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1__2 ,\n_1_time_out_counter_reg[8]_i_1__2 ,\n_2_time_out_counter_reg[8]_i_1__2 ,\n_3_time_out_counter_reg[8]_i_1__2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1__2 ,\n_5_time_out_counter_reg[8]_i_1__2 ,\n_6_time_out_counter_reg[8]_i_1__2 ,\n_7_time_out_counter_reg[8]_i_1__2 }),
        .S({\n_0_time_out_counter[8]_i_2__2 ,\n_0_time_out_counter[8]_i_3__2 ,\n_0_time_out_counter[8]_i_4__2 ,\n_0_time_out_counter[8]_i_5__2 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(\n_0_time_out_counter[0]_i_1__2 ),
        .D(\n_6_time_out_counter_reg[8]_i_1__2 ),
        .Q(time_out_counter_reg[9]),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1__2
       (.I0(\n_0_wait_bypass_count[0]_i_4__2 ),
        .I1(\n_0_wait_bypass_count[0]_i_5__2 ),
        .I2(\n_0_wait_bypass_count[0]_i_6__2 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(n_0_tx_fsm_reset_done_int_s3_reg),
        .I5(n_0_run_phase_alignment_int_s3_reg),
        .O(n_0_time_out_wait_bypass_i_1__2));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1__2),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000BAAAAAAA)) 
     time_tlock_max_i_1__2
       (.I0(n_0_time_tlock_max_reg),
        .I1(n_0_time_tlock_max_i_2),
        .I2(n_0_time_tlock_max_i_3__0),
        .I3(n_0_time_tlock_max_i_4__6),
        .I4(n_0_time_tlock_max_i_5__3),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_time_tlock_max_i_1__2));
(* SOFT_HLUTNM = "soft_lutpair84" *) 
   LUT3 #(
    .INIT(8'hDF)) 
     time_tlock_max_i_2
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[8]),
        .O(n_0_time_tlock_max_i_2));
LUT4 #(
    .INIT(16'h0001)) 
     time_tlock_max_i_3__0
       (.I0(time_out_counter_reg[5]),
        .I1(time_out_counter_reg[6]),
        .I2(time_out_counter_reg[11]),
        .I3(time_out_counter_reg[13]),
        .O(n_0_time_tlock_max_i_3__0));
LUT6 #(
    .INIT(64'h0000000000400000)) 
     time_tlock_max_i_4__6
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[4]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[3]),
        .I5(time_out_counter_reg[18]),
        .O(n_0_time_tlock_max_i_4__6));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     time_tlock_max_i_5__3
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[16]),
        .I3(time_out_counter_reg[0]),
        .I4(time_out_counter_reg[12]),
        .I5(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_5__3));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1__2),
        .Q(n_0_time_tlock_max_reg),
        .R(1'b0));
LUT5 #(
    .INIT(32'hFFFF0200)) 
     tx_fsm_reset_done_int_i_1__2
       (.I0(tx_state[3]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(GT3_TX_FSM_RESET_DONE_OUT),
        .O(n_0_tx_fsm_reset_done_int_i_1__2));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_tx_fsm_reset_done_int_i_1__2),
        .Q(GT3_TX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_s3_reg
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_s2),
        .Q(n_0_tx_fsm_reset_done_int_s3_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     txresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(txresetdone_s2),
        .Q(txresetdone_s3),
        .R(1'b0));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_10__2 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_10__2 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1__2 
       (.I0(n_0_run_phase_alignment_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_1__2 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2__2 
       (.I0(\n_0_wait_bypass_count[0]_i_4__2 ),
        .I1(\n_0_wait_bypass_count[0]_i_5__2 ),
        .I2(\n_0_wait_bypass_count[0]_i_6__2 ),
        .I3(n_0_tx_fsm_reset_done_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_2__2 ));
LUT5 #(
    .INIT(32'hBFFFFFFF)) 
     \wait_bypass_count[0]_i_4__2 
       (.I0(wait_bypass_count_reg[15]),
        .I1(wait_bypass_count_reg[1]),
        .I2(wait_bypass_count_reg[2]),
        .I3(wait_bypass_count_reg[16]),
        .I4(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_4__2 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFDFF)) 
     \wait_bypass_count[0]_i_5__2 
       (.I0(wait_bypass_count_reg[10]),
        .I1(wait_bypass_count_reg[9]),
        .I2(wait_bypass_count_reg[14]),
        .I3(wait_bypass_count_reg[13]),
        .I4(wait_bypass_count_reg[11]),
        .I5(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[0]_i_5__2 ));
LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_6__2 
       (.I0(wait_bypass_count_reg[4]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[7]),
        .I3(wait_bypass_count_reg[8]),
        .I4(wait_bypass_count_reg[5]),
        .I5(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[0]_i_6__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7__2 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_7__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8__2 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_8__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_9__6 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_9__6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2__2 
       (.I0(wait_bypass_count_reg[15]),
        .O(\n_0_wait_bypass_count[12]_i_2__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_3__2 
       (.I0(wait_bypass_count_reg[14]),
        .O(\n_0_wait_bypass_count[12]_i_3__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_4__2 
       (.I0(wait_bypass_count_reg[13]),
        .O(\n_0_wait_bypass_count[12]_i_4__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_5__2 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_5__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[16]_i_2__2 
       (.I0(wait_bypass_count_reg[16]),
        .O(\n_0_wait_bypass_count[16]_i_2__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2__2 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3__2 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4__2 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5__2 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2__2 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3__2 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4__2 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4__2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5__2 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5__2 ));
FDRE \wait_bypass_count_reg[0] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3__2 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
CARRY4 \wait_bypass_count_reg[0]_i_3__2 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3__2 ,\n_1_wait_bypass_count_reg[0]_i_3__2 ,\n_2_wait_bypass_count_reg[0]_i_3__2 ,\n_3_wait_bypass_count_reg[0]_i_3__2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3__2 ,\n_5_wait_bypass_count_reg[0]_i_3__2 ,\n_6_wait_bypass_count_reg[0]_i_3__2 ,\n_7_wait_bypass_count_reg[0]_i_3__2 }),
        .S({\n_0_wait_bypass_count[0]_i_7__2 ,\n_0_wait_bypass_count[0]_i_8__2 ,\n_0_wait_bypass_count[0]_i_9__6 ,\n_0_wait_bypass_count[0]_i_10__2 }));
FDRE \wait_bypass_count_reg[10] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1__2 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[11] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1__2 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[12] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1__2 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
CARRY4 \wait_bypass_count_reg[12]_i_1__2 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1__2 ),
        .CO({\n_0_wait_bypass_count_reg[12]_i_1__2 ,\n_1_wait_bypass_count_reg[12]_i_1__2 ,\n_2_wait_bypass_count_reg[12]_i_1__2 ,\n_3_wait_bypass_count_reg[12]_i_1__2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[12]_i_1__2 ,\n_5_wait_bypass_count_reg[12]_i_1__2 ,\n_6_wait_bypass_count_reg[12]_i_1__2 ,\n_7_wait_bypass_count_reg[12]_i_1__2 }),
        .S({\n_0_wait_bypass_count[12]_i_2__2 ,\n_0_wait_bypass_count[12]_i_3__2 ,\n_0_wait_bypass_count[12]_i_4__2 ,\n_0_wait_bypass_count[12]_i_5__2 }));
FDRE \wait_bypass_count_reg[13] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_6_wait_bypass_count_reg[12]_i_1__2 ),
        .Q(wait_bypass_count_reg[13]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[14] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_5_wait_bypass_count_reg[12]_i_1__2 ),
        .Q(wait_bypass_count_reg[14]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[15] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_4_wait_bypass_count_reg[12]_i_1__2 ),
        .Q(wait_bypass_count_reg[15]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[16] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_7_wait_bypass_count_reg[16]_i_1__2 ),
        .Q(wait_bypass_count_reg[16]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
CARRY4 \wait_bypass_count_reg[16]_i_1__2 
       (.CI(\n_0_wait_bypass_count_reg[12]_i_1__2 ),
        .CO(\NLW_wait_bypass_count_reg[16]_i_1__2_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[16]_i_1__2_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[16]_i_1__2 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[16]_i_2__2 }));
FDRE \wait_bypass_count_reg[1] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3__2 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[2] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3__2 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[3] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3__2 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[4] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1__2 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
CARRY4 \wait_bypass_count_reg[4]_i_1__2 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3__2 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1__2 ,\n_1_wait_bypass_count_reg[4]_i_1__2 ,\n_2_wait_bypass_count_reg[4]_i_1__2 ,\n_3_wait_bypass_count_reg[4]_i_1__2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1__2 ,\n_5_wait_bypass_count_reg[4]_i_1__2 ,\n_6_wait_bypass_count_reg[4]_i_1__2 ,\n_7_wait_bypass_count_reg[4]_i_1__2 }),
        .S({\n_0_wait_bypass_count[4]_i_2__2 ,\n_0_wait_bypass_count[4]_i_3__2 ,\n_0_wait_bypass_count[4]_i_4__2 ,\n_0_wait_bypass_count[4]_i_5__2 }));
FDRE \wait_bypass_count_reg[5] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1__2 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[6] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1__2 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[7] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1__2 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
FDRE \wait_bypass_count_reg[8] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1__2 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
CARRY4 \wait_bypass_count_reg[8]_i_1__2 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1__2 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1__2 ,\n_1_wait_bypass_count_reg[8]_i_1__2 ,\n_2_wait_bypass_count_reg[8]_i_1__2 ,\n_3_wait_bypass_count_reg[8]_i_1__2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1__2 ,\n_5_wait_bypass_count_reg[8]_i_1__2 ,\n_6_wait_bypass_count_reg[8]_i_1__2 ,\n_7_wait_bypass_count_reg[8]_i_1__2 }),
        .S({\n_0_wait_bypass_count[8]_i_2__2 ,\n_0_wait_bypass_count[8]_i_3__2 ,\n_0_wait_bypass_count[8]_i_4__2 ,\n_0_wait_bypass_count[8]_i_5__2 }));
FDRE \wait_bypass_count_reg[9] 
       (.C(gt3_txusrclk_in),
        .CE(\n_0_wait_bypass_count[0]_i_2__2 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1__2 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1__2 ));
(* SOFT_HLUTNM = "soft_lutpair94" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1__2 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__2[0]));
(* SOFT_HLUTNM = "soft_lutpair94" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1__2 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\n_0_wait_time_cnt[1]_i_1__2 ));
(* SOFT_HLUTNM = "soft_lutpair89" *) 
   LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1__2 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__2[2]));
(* SOFT_HLUTNM = "soft_lutpair87" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \wait_time_cnt[3]_i_1__2 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0__2[3]));
(* SOFT_HLUTNM = "soft_lutpair87" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1__2 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\n_0_wait_time_cnt[4]_i_1__2 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[5]_i_1__2 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[1]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__2[5]));
LUT4 #(
    .INIT(16'h0700)) 
     \wait_time_cnt[6]_i_1__2 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[3]),
        .I3(tx_state[0]),
        .O(\n_0_wait_time_cnt[6]_i_1__2 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_2__2 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(wait_time_cnt_reg__0[5]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[3]),
        .I5(\n_0_wait_time_cnt[6]_i_4__2 ),
        .O(\n_0_wait_time_cnt[6]_i_2__2 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[6]_i_3__2 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4__2 ),
        .I2(wait_time_cnt_reg__0[3]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[5]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__2[6]));
(* SOFT_HLUTNM = "soft_lutpair89" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_4__2 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(\n_0_wait_time_cnt[6]_i_4__2 ));
FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__2 ),
        .D(wait_time_cnt0__2[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\n_0_wait_time_cnt[6]_i_1__2 ));
FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__2 ),
        .D(\n_0_wait_time_cnt[1]_i_1__2 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\n_0_wait_time_cnt[6]_i_1__2 ));
FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__2 ),
        .D(wait_time_cnt0__2[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\n_0_wait_time_cnt[6]_i_1__2 ));
FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__2 ),
        .D(wait_time_cnt0__2[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\n_0_wait_time_cnt[6]_i_1__2 ));
FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__2 ),
        .D(\n_0_wait_time_cnt[4]_i_1__2 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\n_0_wait_time_cnt[6]_i_1__2 ));
FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__2 ),
        .D(wait_time_cnt0__2[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\n_0_wait_time_cnt[6]_i_1__2 ));
FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\n_0_wait_time_cnt[6]_i_2__2 ),
        .D(wait_time_cnt0__2[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\n_0_wait_time_cnt[6]_i_1__2 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_init" *) 
module XLAUI_XLAUI_init__parameterized0
   (gt0_drprdy_out,
    gt0_eyescandataerror_out,
    gt0_gthtxn_out,
    gt0_gthtxp_out,
    gt0_rxoutclk_out,
    gt0_rxprbserr_out,
    gt0_rxresetdone_out,
    gt0_txoutclk_out,
    gt0_txoutclkfabric_out,
    gt0_txoutclkpcs_out,
    gt0_txresetdone_out,
    gt0_dmonitorout_out,
    gt0_drpdo_out,
    gt0_rxdatavalid_out,
    gt0_rxheadervalid_out,
    gt0_txbufstatus_out,
    gt0_rxbufstatus_out,
    gt0_rxheader_out,
    gt0_rxdata_out,
    gt0_rxmonitorout_out,
    gt1_drprdy_out,
    gt1_eyescandataerror_out,
    gt1_gthtxn_out,
    gt1_gthtxp_out,
    gt1_rxoutclk_out,
    gt1_rxprbserr_out,
    gt1_rxresetdone_out,
    gt1_txoutclk_out,
    gt1_txoutclkfabric_out,
    gt1_txoutclkpcs_out,
    gt1_txresetdone_out,
    gt1_dmonitorout_out,
    gt1_drpdo_out,
    gt1_rxdatavalid_out,
    gt1_rxheadervalid_out,
    gt1_txbufstatus_out,
    gt1_rxbufstatus_out,
    gt1_rxheader_out,
    gt1_rxdata_out,
    gt1_rxmonitorout_out,
    gt2_drprdy_out,
    gt2_eyescandataerror_out,
    gt2_gthtxn_out,
    gt2_gthtxp_out,
    gt2_rxoutclk_out,
    gt2_rxprbserr_out,
    gt2_rxresetdone_out,
    gt2_txoutclk_out,
    gt2_txoutclkfabric_out,
    gt2_txoutclkpcs_out,
    gt2_txresetdone_out,
    gt2_dmonitorout_out,
    gt2_drpdo_out,
    gt2_rxdatavalid_out,
    gt2_rxheadervalid_out,
    gt2_txbufstatus_out,
    gt2_rxbufstatus_out,
    gt2_rxheader_out,
    gt2_rxdata_out,
    gt2_rxmonitorout_out,
    gt3_drprdy_out,
    gt3_eyescandataerror_out,
    gt3_gthtxn_out,
    gt3_gthtxp_out,
    gt3_rxoutclk_out,
    gt3_rxprbserr_out,
    gt3_rxresetdone_out,
    gt3_txoutclk_out,
    gt3_txoutclkfabric_out,
    gt3_txoutclkpcs_out,
    gt3_txresetdone_out,
    gt3_dmonitorout_out,
    gt3_drpdo_out,
    gt3_rxdatavalid_out,
    gt3_rxheadervalid_out,
    gt3_txbufstatus_out,
    gt3_rxbufstatus_out,
    gt3_rxheader_out,
    gt3_rxdata_out,
    gt3_rxmonitorout_out,
    GT0_TX_FSM_RESET_DONE_OUT,
    GT1_TX_FSM_RESET_DONE_OUT,
    GT2_TX_FSM_RESET_DONE_OUT,
    GT3_TX_FSM_RESET_DONE_OUT,
    GT0_RX_FSM_RESET_DONE_OUT,
    GT1_RX_FSM_RESET_DONE_OUT,
    GT2_RX_FSM_RESET_DONE_OUT,
    GT3_RX_FSM_RESET_DONE_OUT,
    GT0_TX_MMCM_RESET_OUT,
    GT0_QPLLRESET_OUT,
    GT1_TX_MMCM_RESET_OUT,
    GT2_TX_MMCM_RESET_OUT,
    GT3_TX_MMCM_RESET_OUT,
    GT0_RX_MMCM_RESET_OUT,
    GT1_RX_MMCM_RESET_OUT,
    GT2_RX_MMCM_RESET_OUT,
    GT3_RX_MMCM_RESET_OUT,
    gt0_drpclk_in,
    gt0_drpen_in,
    gt0_drpwe_in,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    gt0_gthrxn_in,
    gt0_gthrxp_in,
    GT0_QPLLOUTCLK_IN,
    GT0_QPLLOUTREFCLK_IN,
    gt0_rxbufreset_in,
    gt0_rxgearboxslip_in,
    gt0_rxpcsreset_in,
    gt0_rxprbscntreset_in,
    gt0_rxusrclk_in,
    gt0_rxusrclk2_in,
    gt0_txelecidle_in,
    gt0_txpcsreset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    gt0_txusrclk_in,
    gt0_txusrclk2_in,
    gt0_drpdi_in,
    gt0_rxmonitorsel_in,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_txheader_in,
    gt0_txprbssel_in,
    gt0_txdata_in,
    gt0_txsequence_in,
    gt0_drpaddr_in,
    gt1_drpclk_in,
    gt1_drpen_in,
    gt1_drpwe_in,
    gt1_eyescanreset_in,
    gt1_eyescantrigger_in,
    gt1_gthrxn_in,
    gt1_gthrxp_in,
    gt1_rxbufreset_in,
    gt1_rxgearboxslip_in,
    gt1_rxpcsreset_in,
    gt1_rxprbscntreset_in,
    gt1_rxusrclk_in,
    gt1_rxusrclk2_in,
    gt1_txelecidle_in,
    gt1_txpcsreset_in,
    gt1_txpolarity_in,
    gt1_txprbsforceerr_in,
    gt1_txusrclk_in,
    gt1_txusrclk2_in,
    gt1_drpdi_in,
    gt1_rxmonitorsel_in,
    gt1_loopback_in,
    gt1_rxprbssel_in,
    gt1_txheader_in,
    gt1_txprbssel_in,
    gt1_txdata_in,
    gt1_txsequence_in,
    gt1_drpaddr_in,
    gt2_drpclk_in,
    gt2_drpen_in,
    gt2_drpwe_in,
    gt2_eyescanreset_in,
    gt2_eyescantrigger_in,
    gt2_gthrxn_in,
    gt2_gthrxp_in,
    gt2_rxbufreset_in,
    gt2_rxgearboxslip_in,
    gt2_rxpcsreset_in,
    gt2_rxprbscntreset_in,
    gt2_rxusrclk_in,
    gt2_rxusrclk2_in,
    gt2_txelecidle_in,
    gt2_txpcsreset_in,
    gt2_txpolarity_in,
    gt2_txprbsforceerr_in,
    gt2_txusrclk_in,
    gt2_txusrclk2_in,
    gt2_drpdi_in,
    gt2_rxmonitorsel_in,
    gt2_loopback_in,
    gt2_rxprbssel_in,
    gt2_txheader_in,
    gt2_txprbssel_in,
    gt2_txdata_in,
    gt2_txsequence_in,
    gt2_drpaddr_in,
    gt3_drpclk_in,
    gt3_drpen_in,
    gt3_drpwe_in,
    gt3_eyescanreset_in,
    gt3_eyescantrigger_in,
    gt3_gthrxn_in,
    gt3_gthrxp_in,
    gt3_rxbufreset_in,
    gt3_rxgearboxslip_in,
    gt3_rxpcsreset_in,
    gt3_rxprbscntreset_in,
    gt3_rxusrclk_in,
    gt3_rxusrclk2_in,
    gt3_txelecidle_in,
    gt3_txpcsreset_in,
    gt3_txpolarity_in,
    gt3_txprbsforceerr_in,
    gt3_txusrclk_in,
    gt3_txusrclk2_in,
    gt3_drpdi_in,
    gt3_rxmonitorsel_in,
    gt3_loopback_in,
    gt3_rxprbssel_in,
    gt3_txheader_in,
    gt3_txprbssel_in,
    gt3_txdata_in,
    gt3_txsequence_in,
    gt3_drpaddr_in,
    SYSCLK_IN,
    GT0_TX_MMCM_LOCK_IN,
    GT0_QPLLLOCK_IN,
    SOFT_RESET_IN,
    GT1_TX_MMCM_LOCK_IN,
    GT2_TX_MMCM_LOCK_IN,
    GT3_TX_MMCM_LOCK_IN,
    GT0_RX_MMCM_LOCK_IN,
    GT0_DATA_VALID_IN,
    GT1_RX_MMCM_LOCK_IN,
    GT1_DATA_VALID_IN,
    GT2_RX_MMCM_LOCK_IN,
    GT2_DATA_VALID_IN,
    GT3_RX_MMCM_LOCK_IN,
    GT3_DATA_VALID_IN,
    DONT_RESET_ON_DATA_ERROR_IN);
  output gt0_drprdy_out;
  output gt0_eyescandataerror_out;
  output gt0_gthtxn_out;
  output gt0_gthtxp_out;
  output gt0_rxoutclk_out;
  output gt0_rxprbserr_out;
  output gt0_rxresetdone_out;
  output gt0_txoutclk_out;
  output gt0_txoutclkfabric_out;
  output gt0_txoutclkpcs_out;
  output gt0_txresetdone_out;
  output [14:0]gt0_dmonitorout_out;
  output [15:0]gt0_drpdo_out;
  output gt0_rxdatavalid_out;
  output gt0_rxheadervalid_out;
  output [1:0]gt0_txbufstatus_out;
  output [2:0]gt0_rxbufstatus_out;
  output [1:0]gt0_rxheader_out;
  output [63:0]gt0_rxdata_out;
  output [6:0]gt0_rxmonitorout_out;
  output gt1_drprdy_out;
  output gt1_eyescandataerror_out;
  output gt1_gthtxn_out;
  output gt1_gthtxp_out;
  output gt1_rxoutclk_out;
  output gt1_rxprbserr_out;
  output gt1_rxresetdone_out;
  output gt1_txoutclk_out;
  output gt1_txoutclkfabric_out;
  output gt1_txoutclkpcs_out;
  output gt1_txresetdone_out;
  output [14:0]gt1_dmonitorout_out;
  output [15:0]gt1_drpdo_out;
  output gt1_rxdatavalid_out;
  output gt1_rxheadervalid_out;
  output [1:0]gt1_txbufstatus_out;
  output [2:0]gt1_rxbufstatus_out;
  output [1:0]gt1_rxheader_out;
  output [63:0]gt1_rxdata_out;
  output [6:0]gt1_rxmonitorout_out;
  output gt2_drprdy_out;
  output gt2_eyescandataerror_out;
  output gt2_gthtxn_out;
  output gt2_gthtxp_out;
  output gt2_rxoutclk_out;
  output gt2_rxprbserr_out;
  output gt2_rxresetdone_out;
  output gt2_txoutclk_out;
  output gt2_txoutclkfabric_out;
  output gt2_txoutclkpcs_out;
  output gt2_txresetdone_out;
  output [14:0]gt2_dmonitorout_out;
  output [15:0]gt2_drpdo_out;
  output gt2_rxdatavalid_out;
  output gt2_rxheadervalid_out;
  output [1:0]gt2_txbufstatus_out;
  output [2:0]gt2_rxbufstatus_out;
  output [1:0]gt2_rxheader_out;
  output [63:0]gt2_rxdata_out;
  output [6:0]gt2_rxmonitorout_out;
  output gt3_drprdy_out;
  output gt3_eyescandataerror_out;
  output gt3_gthtxn_out;
  output gt3_gthtxp_out;
  output gt3_rxoutclk_out;
  output gt3_rxprbserr_out;
  output gt3_rxresetdone_out;
  output gt3_txoutclk_out;
  output gt3_txoutclkfabric_out;
  output gt3_txoutclkpcs_out;
  output gt3_txresetdone_out;
  output [14:0]gt3_dmonitorout_out;
  output [15:0]gt3_drpdo_out;
  output gt3_rxdatavalid_out;
  output gt3_rxheadervalid_out;
  output [1:0]gt3_txbufstatus_out;
  output [2:0]gt3_rxbufstatus_out;
  output [1:0]gt3_rxheader_out;
  output [63:0]gt3_rxdata_out;
  output [6:0]gt3_rxmonitorout_out;
  output GT0_TX_FSM_RESET_DONE_OUT;
  output GT1_TX_FSM_RESET_DONE_OUT;
  output GT2_TX_FSM_RESET_DONE_OUT;
  output GT3_TX_FSM_RESET_DONE_OUT;
  output GT0_RX_FSM_RESET_DONE_OUT;
  output GT1_RX_FSM_RESET_DONE_OUT;
  output GT2_RX_FSM_RESET_DONE_OUT;
  output GT3_RX_FSM_RESET_DONE_OUT;
  output GT0_TX_MMCM_RESET_OUT;
  output GT0_QPLLRESET_OUT;
  output GT1_TX_MMCM_RESET_OUT;
  output GT2_TX_MMCM_RESET_OUT;
  output GT3_TX_MMCM_RESET_OUT;
  output GT0_RX_MMCM_RESET_OUT;
  output GT1_RX_MMCM_RESET_OUT;
  output GT2_RX_MMCM_RESET_OUT;
  output GT3_RX_MMCM_RESET_OUT;
  input gt0_drpclk_in;
  input gt0_drpen_in;
  input gt0_drpwe_in;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input gt0_gthrxn_in;
  input gt0_gthrxp_in;
  input GT0_QPLLOUTCLK_IN;
  input GT0_QPLLOUTREFCLK_IN;
  input gt0_rxbufreset_in;
  input gt0_rxgearboxslip_in;
  input gt0_rxpcsreset_in;
  input gt0_rxprbscntreset_in;
  input gt0_rxusrclk_in;
  input gt0_rxusrclk2_in;
  input gt0_txelecidle_in;
  input gt0_txpcsreset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input gt0_txusrclk_in;
  input gt0_txusrclk2_in;
  input [15:0]gt0_drpdi_in;
  input [1:0]gt0_rxmonitorsel_in;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [1:0]gt0_txheader_in;
  input [2:0]gt0_txprbssel_in;
  input [63:0]gt0_txdata_in;
  input [6:0]gt0_txsequence_in;
  input [8:0]gt0_drpaddr_in;
  input gt1_drpclk_in;
  input gt1_drpen_in;
  input gt1_drpwe_in;
  input gt1_eyescanreset_in;
  input gt1_eyescantrigger_in;
  input gt1_gthrxn_in;
  input gt1_gthrxp_in;
  input gt1_rxbufreset_in;
  input gt1_rxgearboxslip_in;
  input gt1_rxpcsreset_in;
  input gt1_rxprbscntreset_in;
  input gt1_rxusrclk_in;
  input gt1_rxusrclk2_in;
  input gt1_txelecidle_in;
  input gt1_txpcsreset_in;
  input gt1_txpolarity_in;
  input gt1_txprbsforceerr_in;
  input gt1_txusrclk_in;
  input gt1_txusrclk2_in;
  input [15:0]gt1_drpdi_in;
  input [1:0]gt1_rxmonitorsel_in;
  input [2:0]gt1_loopback_in;
  input [2:0]gt1_rxprbssel_in;
  input [1:0]gt1_txheader_in;
  input [2:0]gt1_txprbssel_in;
  input [63:0]gt1_txdata_in;
  input [6:0]gt1_txsequence_in;
  input [8:0]gt1_drpaddr_in;
  input gt2_drpclk_in;
  input gt2_drpen_in;
  input gt2_drpwe_in;
  input gt2_eyescanreset_in;
  input gt2_eyescantrigger_in;
  input gt2_gthrxn_in;
  input gt2_gthrxp_in;
  input gt2_rxbufreset_in;
  input gt2_rxgearboxslip_in;
  input gt2_rxpcsreset_in;
  input gt2_rxprbscntreset_in;
  input gt2_rxusrclk_in;
  input gt2_rxusrclk2_in;
  input gt2_txelecidle_in;
  input gt2_txpcsreset_in;
  input gt2_txpolarity_in;
  input gt2_txprbsforceerr_in;
  input gt2_txusrclk_in;
  input gt2_txusrclk2_in;
  input [15:0]gt2_drpdi_in;
  input [1:0]gt2_rxmonitorsel_in;
  input [2:0]gt2_loopback_in;
  input [2:0]gt2_rxprbssel_in;
  input [1:0]gt2_txheader_in;
  input [2:0]gt2_txprbssel_in;
  input [63:0]gt2_txdata_in;
  input [6:0]gt2_txsequence_in;
  input [8:0]gt2_drpaddr_in;
  input gt3_drpclk_in;
  input gt3_drpen_in;
  input gt3_drpwe_in;
  input gt3_eyescanreset_in;
  input gt3_eyescantrigger_in;
  input gt3_gthrxn_in;
  input gt3_gthrxp_in;
  input gt3_rxbufreset_in;
  input gt3_rxgearboxslip_in;
  input gt3_rxpcsreset_in;
  input gt3_rxprbscntreset_in;
  input gt3_rxusrclk_in;
  input gt3_rxusrclk2_in;
  input gt3_txelecidle_in;
  input gt3_txpcsreset_in;
  input gt3_txpolarity_in;
  input gt3_txprbsforceerr_in;
  input gt3_txusrclk_in;
  input gt3_txusrclk2_in;
  input [15:0]gt3_drpdi_in;
  input [1:0]gt3_rxmonitorsel_in;
  input [2:0]gt3_loopback_in;
  input [2:0]gt3_rxprbssel_in;
  input [1:0]gt3_txheader_in;
  input [2:0]gt3_txprbssel_in;
  input [63:0]gt3_txdata_in;
  input [6:0]gt3_txsequence_in;
  input [8:0]gt3_drpaddr_in;
  input SYSCLK_IN;
  input GT0_TX_MMCM_LOCK_IN;
  input GT0_QPLLLOCK_IN;
  input SOFT_RESET_IN;
  input GT1_TX_MMCM_LOCK_IN;
  input GT2_TX_MMCM_LOCK_IN;
  input GT3_TX_MMCM_LOCK_IN;
  input GT0_RX_MMCM_LOCK_IN;
  input GT0_DATA_VALID_IN;
  input GT1_RX_MMCM_LOCK_IN;
  input GT1_DATA_VALID_IN;
  input GT2_RX_MMCM_LOCK_IN;
  input GT2_DATA_VALID_IN;
  input GT3_RX_MMCM_LOCK_IN;
  input GT3_DATA_VALID_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;

  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire GT0_DATA_VALID_IN;
  wire GT0_QPLLLOCK_IN;
  wire GT0_QPLLOUTCLK_IN;
  wire GT0_QPLLOUTREFCLK_IN;
  wire GT0_QPLLRESET_OUT;
  wire GT0_RX_FSM_RESET_DONE_OUT;
  wire GT0_RX_MMCM_LOCK_IN;
  wire GT0_RX_MMCM_RESET_OUT;
  wire GT0_TX_FSM_RESET_DONE_OUT;
  wire GT0_TX_MMCM_LOCK_IN;
  wire GT0_TX_MMCM_RESET_OUT;
  wire GT1_DATA_VALID_IN;
  wire GT1_RX_FSM_RESET_DONE_OUT;
  wire GT1_RX_MMCM_LOCK_IN;
  wire GT1_RX_MMCM_RESET_OUT;
  wire GT1_TX_FSM_RESET_DONE_OUT;
  wire GT1_TX_MMCM_LOCK_IN;
  wire GT1_TX_MMCM_RESET_OUT;
  wire GT2_DATA_VALID_IN;
  wire GT2_RX_FSM_RESET_DONE_OUT;
  wire GT2_RX_MMCM_LOCK_IN;
  wire GT2_RX_MMCM_RESET_OUT;
  wire GT2_TX_FSM_RESET_DONE_OUT;
  wire GT2_TX_MMCM_LOCK_IN;
  wire GT2_TX_MMCM_RESET_OUT;
  wire GT3_DATA_VALID_IN;
  wire GT3_RX_FSM_RESET_DONE_OUT;
  wire GT3_RX_MMCM_LOCK_IN;
  wire GT3_RX_MMCM_RESET_OUT;
  wire GT3_TX_FSM_RESET_DONE_OUT;
  wire GT3_TX_MMCM_LOCK_IN;
  wire GT3_TX_MMCM_RESET_OUT;
  wire GTRXRESET;
  wire GTTXRESET;
  wire RXOUTCLK;
  wire RXPMARESETDONE;
  wire RXUSERRDY;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire TXUSERRDY;
  wire [14:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drprdy_out;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire gt0_gthrxn_in;
  wire gt0_gthrxp_in;
  wire gt0_gthtxn_out;
  wire gt0_gthtxp_out;
  wire [2:0]gt0_loopback_in;
  wire [9:0]gt0_rx_cdrlock_counter;
  wire [9:0]gt0_rx_cdrlock_counter_0;
  wire gt0_rx_cdrlocked;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire [63:0]gt0_rxdata_out;
  wire gt0_rxdatavalid_out;
  wire gt0_rxgearboxslip_in;
  wire [1:0]gt0_rxheader_out;
  wire gt0_rxheadervalid_out;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire gt0_rxoutclk_out;
  wire gt0_rxpcsreset_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire gt0_rxresetdone_out;
  wire gt0_rxusrclk2_in;
  wire gt0_rxusrclk_in;
  wire [1:0]gt0_txbufstatus_out;
  wire [63:0]gt0_txdata_in;
  wire gt0_txelecidle_in;
  wire [1:0]gt0_txheader_in;
  wire gt0_txoutclk_out;
  wire gt0_txoutclkfabric_out;
  wire gt0_txoutclkpcs_out;
  wire gt0_txpcsreset_in;
  wire gt0_txpolarity_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire gt0_txresetdone_out;
  wire [6:0]gt0_txsequence_in;
  wire gt0_txusrclk2_in;
  wire gt0_txusrclk_in;
  wire [14:0]gt1_dmonitorout_out;
  wire [8:0]gt1_drpaddr_in;
  wire gt1_drpclk_in;
  wire [15:0]gt1_drpdi_in;
  wire [15:0]gt1_drpdo_out;
  wire gt1_drpen_in;
  wire gt1_drprdy_out;
  wire gt1_drpwe_in;
  wire gt1_eyescandataerror_out;
  wire gt1_eyescanreset_in;
  wire gt1_eyescantrigger_in;
  wire gt1_gthrxn_in;
  wire gt1_gthrxp_in;
  wire gt1_gthtxn_out;
  wire gt1_gthtxp_out;
  wire [2:0]gt1_loopback_in;
  wire [9:0]gt1_rx_cdrlock_counter;
  wire [9:0]gt1_rx_cdrlock_counter_1;
  wire gt1_rx_cdrlocked;
  wire gt1_rxbufreset_in;
  wire [2:0]gt1_rxbufstatus_out;
  wire [63:0]gt1_rxdata_out;
  wire gt1_rxdatavalid_out;
  wire gt1_rxgearboxslip_in;
  wire [1:0]gt1_rxheader_out;
  wire gt1_rxheadervalid_out;
  wire [6:0]gt1_rxmonitorout_out;
  wire [1:0]gt1_rxmonitorsel_in;
  wire gt1_rxoutclk_out;
  wire gt1_rxpcsreset_in;
  wire gt1_rxprbscntreset_in;
  wire gt1_rxprbserr_out;
  wire [2:0]gt1_rxprbssel_in;
  wire gt1_rxresetdone_out;
  wire gt1_rxusrclk2_in;
  wire gt1_rxusrclk_in;
  wire [1:0]gt1_txbufstatus_out;
  wire [63:0]gt1_txdata_in;
  wire gt1_txelecidle_in;
  wire [1:0]gt1_txheader_in;
  wire gt1_txoutclk_out;
  wire gt1_txoutclkfabric_out;
  wire gt1_txoutclkpcs_out;
  wire gt1_txpcsreset_in;
  wire gt1_txpolarity_in;
  wire gt1_txprbsforceerr_in;
  wire [2:0]gt1_txprbssel_in;
  wire gt1_txresetdone_out;
  wire [6:0]gt1_txsequence_in;
  wire gt1_txusrclk2_in;
  wire gt1_txusrclk_in;
  wire [14:0]gt2_dmonitorout_out;
  wire [8:0]gt2_drpaddr_in;
  wire gt2_drpclk_in;
  wire [15:0]gt2_drpdi_in;
  wire [15:0]gt2_drpdo_out;
  wire gt2_drpen_in;
  wire gt2_drprdy_out;
  wire gt2_drpwe_in;
  wire gt2_eyescandataerror_out;
  wire gt2_eyescanreset_in;
  wire gt2_eyescantrigger_in;
  wire gt2_gthrxn_in;
  wire gt2_gthrxp_in;
  wire gt2_gthtxn_out;
  wire gt2_gthtxp_out;
  wire [2:0]gt2_loopback_in;
  wire [9:0]gt2_rx_cdrlock_counter;
  wire [9:0]gt2_rx_cdrlock_counter_2;
  wire gt2_rx_cdrlocked;
  wire gt2_rxbufreset_in;
  wire [2:0]gt2_rxbufstatus_out;
  wire [63:0]gt2_rxdata_out;
  wire gt2_rxdatavalid_out;
  wire gt2_rxgearboxslip_in;
  wire [1:0]gt2_rxheader_out;
  wire gt2_rxheadervalid_out;
  wire [6:0]gt2_rxmonitorout_out;
  wire [1:0]gt2_rxmonitorsel_in;
  wire gt2_rxoutclk_out;
  wire gt2_rxpcsreset_in;
  wire gt2_rxprbscntreset_in;
  wire gt2_rxprbserr_out;
  wire [2:0]gt2_rxprbssel_in;
  wire gt2_rxresetdone_out;
  wire gt2_rxusrclk2_in;
  wire gt2_rxusrclk_in;
  wire [1:0]gt2_txbufstatus_out;
  wire [63:0]gt2_txdata_in;
  wire gt2_txelecidle_in;
  wire [1:0]gt2_txheader_in;
  wire gt2_txoutclk_out;
  wire gt2_txoutclkfabric_out;
  wire gt2_txoutclkpcs_out;
  wire gt2_txpcsreset_in;
  wire gt2_txpolarity_in;
  wire gt2_txprbsforceerr_in;
  wire [2:0]gt2_txprbssel_in;
  wire gt2_txresetdone_out;
  wire [6:0]gt2_txsequence_in;
  wire gt2_txusrclk2_in;
  wire gt2_txusrclk_in;
  wire [14:0]gt3_dmonitorout_out;
  wire [8:0]gt3_drpaddr_in;
  wire gt3_drpclk_in;
  wire [15:0]gt3_drpdi_in;
  wire [15:0]gt3_drpdo_out;
  wire gt3_drpen_in;
  wire gt3_drprdy_out;
  wire gt3_drpwe_in;
  wire gt3_eyescandataerror_out;
  wire gt3_eyescanreset_in;
  wire gt3_eyescantrigger_in;
  wire gt3_gthrxn_in;
  wire gt3_gthrxp_in;
  wire gt3_gthtxn_out;
  wire gt3_gthtxp_out;
  wire [2:0]gt3_loopback_in;
  wire [9:0]gt3_rx_cdrlock_counter;
  wire [9:0]gt3_rx_cdrlock_counter_3;
  wire gt3_rx_cdrlocked;
  wire gt3_rxbufreset_in;
  wire [2:0]gt3_rxbufstatus_out;
  wire [63:0]gt3_rxdata_out;
  wire gt3_rxdatavalid_out;
  wire gt3_rxgearboxslip_in;
  wire [1:0]gt3_rxheader_out;
  wire gt3_rxheadervalid_out;
  wire [6:0]gt3_rxmonitorout_out;
  wire [1:0]gt3_rxmonitorsel_in;
  wire gt3_rxoutclk_out;
  wire gt3_rxpcsreset_in;
  wire gt3_rxprbscntreset_in;
  wire gt3_rxprbserr_out;
  wire [2:0]gt3_rxprbssel_in;
  wire gt3_rxresetdone_out;
  wire gt3_rxusrclk2_in;
  wire gt3_rxusrclk_in;
  wire [1:0]gt3_txbufstatus_out;
  wire [63:0]gt3_txdata_in;
  wire gt3_txelecidle_in;
  wire [1:0]gt3_txheader_in;
  wire gt3_txoutclk_out;
  wire gt3_txoutclkfabric_out;
  wire gt3_txoutclkpcs_out;
  wire gt3_txpcsreset_in;
  wire gt3_txpolarity_in;
  wire gt3_txprbsforceerr_in;
  wire [2:0]gt3_txprbssel_in;
  wire gt3_txresetdone_out;
  wire [6:0]gt3_txsequence_in;
  wire gt3_txusrclk2_in;
  wire gt3_txusrclk_in;
  wire \n_0_gt0_rx_cdrlock_counter[1]_i_3 ;
  wire \n_0_gt0_rx_cdrlock_counter[4]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[8]_i_2 ;
  wire \n_0_gt0_rx_cdrlock_counter[9]_i_2 ;
  wire n_0_gt0_rx_cdrlocked_i_1;
  wire n_0_gt0_rx_cdrlocked_reg;
  wire \n_0_gt1_rx_cdrlock_counter[1]_i_3 ;
  wire \n_0_gt1_rx_cdrlock_counter[4]_i_1 ;
  wire \n_0_gt1_rx_cdrlock_counter[8]_i_2 ;
  wire \n_0_gt1_rx_cdrlock_counter[9]_i_2 ;
  wire n_0_gt1_rx_cdrlocked_i_1;
  wire n_0_gt1_rx_cdrlocked_reg;
  wire n_0_gt1_rxresetfsm_i;
  wire n_0_gt1_txresetfsm_i;
  wire \n_0_gt2_rx_cdrlock_counter[1]_i_3 ;
  wire \n_0_gt2_rx_cdrlock_counter[4]_i_1 ;
  wire \n_0_gt2_rx_cdrlock_counter[8]_i_2 ;
  wire \n_0_gt2_rx_cdrlock_counter[9]_i_2 ;
  wire n_0_gt2_rx_cdrlocked_i_1;
  wire n_0_gt2_rx_cdrlocked_reg;
  wire n_0_gt2_rxresetfsm_i;
  wire n_0_gt2_txresetfsm_i;
  wire \n_0_gt3_rx_cdrlock_counter[1]_i_3 ;
  wire \n_0_gt3_rx_cdrlock_counter[4]_i_1 ;
  wire \n_0_gt3_rx_cdrlock_counter[8]_i_2 ;
  wire \n_0_gt3_rx_cdrlock_counter[9]_i_2 ;
  wire n_0_gt3_rx_cdrlocked_i_1;
  wire n_0_gt3_rx_cdrlocked_reg;
  wire n_0_gt3_rxresetfsm_i;
  wire n_0_gt3_txresetfsm_i;
  wire n_128_XLAUI_i;
  wire n_251_XLAUI_i;
  wire n_374_XLAUI_i;
  wire n_3_gt1_rxresetfsm_i;
  wire n_3_gt1_txresetfsm_i;
  wire n_3_gt2_rxresetfsm_i;
  wire n_3_gt2_txresetfsm_i;
  wire n_3_gt3_rxresetfsm_i;
  wire n_3_gt3_txresetfsm_i;

XLAUI_XLAUI_multi_gt__parameterized0 XLAUI_i
       (.GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT0_RXPMARESETDONE_OUT(RXPMARESETDONE),
        .GT1_RXPMARESETDONE_OUT(n_128_XLAUI_i),
        .GT2_RXPMARESETDONE_OUT(n_251_XLAUI_i),
        .GT3_RXPMARESETDONE_OUT(n_374_XLAUI_i),
        .I1(n_0_gt1_rxresetfsm_i),
        .I2(n_0_gt2_rxresetfsm_i),
        .I3(n_0_gt3_rxresetfsm_i),
        .SR(GTRXRESET),
        .gt0_dmonitorout_out(gt0_dmonitorout_out),
        .gt0_drpaddr_in(gt0_drpaddr_in),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdi_in(gt0_drpdi_in),
        .gt0_drpdo_out(gt0_drpdo_out),
        .gt0_drpen_in(gt0_drpen_in),
        .gt0_drprdy_out(gt0_drprdy_out),
        .gt0_drpwe_in(gt0_drpwe_in),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_gthrxn_in(gt0_gthrxn_in),
        .gt0_gthrxp_in(gt0_gthrxp_in),
        .gt0_gthtxn_out(gt0_gthtxn_out),
        .gt0_gthtxp_out(gt0_gthtxp_out),
        .gt0_gttxreset_in(GTTXRESET),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_rxbufreset_in(gt0_rxbufreset_in),
        .gt0_rxbufstatus_out(gt0_rxbufstatus_out),
        .gt0_rxdata_out(gt0_rxdata_out),
        .gt0_rxdatavalid_out(gt0_rxdatavalid_out),
        .gt0_rxgearboxslip_in(gt0_rxgearboxslip_in),
        .gt0_rxheader_out(gt0_rxheader_out),
        .gt0_rxheadervalid_out(gt0_rxheadervalid_out),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxoutclk_out(gt0_rxoutclk_out),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_rxresetdone_out(gt0_rxresetdone_out),
        .gt0_rxuserrdy_in(RXUSERRDY),
        .gt0_rxusrclk2_in(gt0_rxusrclk2_in),
        .gt0_rxusrclk_in(gt0_rxusrclk_in),
        .gt0_txbufstatus_out(gt0_txbufstatus_out),
        .gt0_txdata_in(gt0_txdata_in),
        .gt0_txelecidle_in(gt0_txelecidle_in),
        .gt0_txheader_in(gt0_txheader_in),
        .gt0_txoutclk_out(gt0_txoutclk_out),
        .gt0_txoutclkfabric_out(gt0_txoutclkfabric_out),
        .gt0_txoutclkpcs_out(gt0_txoutclkpcs_out),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txresetdone_out(gt0_txresetdone_out),
        .gt0_txsequence_in(gt0_txsequence_in),
        .gt0_txuserrdy_in(TXUSERRDY),
        .gt0_txusrclk2_in(gt0_txusrclk2_in),
        .gt0_txusrclk_in(gt0_txusrclk_in),
        .gt1_dmonitorout_out(gt1_dmonitorout_out),
        .gt1_drpaddr_in(gt1_drpaddr_in),
        .gt1_drpclk_in(gt1_drpclk_in),
        .gt1_drpdi_in(gt1_drpdi_in),
        .gt1_drpdo_out(gt1_drpdo_out),
        .gt1_drpen_in(gt1_drpen_in),
        .gt1_drprdy_out(gt1_drprdy_out),
        .gt1_drpwe_in(gt1_drpwe_in),
        .gt1_eyescandataerror_out(gt1_eyescandataerror_out),
        .gt1_eyescanreset_in(gt1_eyescanreset_in),
        .gt1_eyescantrigger_in(gt1_eyescantrigger_in),
        .gt1_gthrxn_in(gt1_gthrxn_in),
        .gt1_gthrxp_in(gt1_gthrxp_in),
        .gt1_gthtxn_out(gt1_gthtxn_out),
        .gt1_gthtxp_out(gt1_gthtxp_out),
        .gt1_gttxreset_in(n_0_gt1_txresetfsm_i),
        .gt1_loopback_in(gt1_loopback_in),
        .gt1_rxbufreset_in(gt1_rxbufreset_in),
        .gt1_rxbufstatus_out(gt1_rxbufstatus_out),
        .gt1_rxdata_out(gt1_rxdata_out),
        .gt1_rxdatavalid_out(gt1_rxdatavalid_out),
        .gt1_rxgearboxslip_in(gt1_rxgearboxslip_in),
        .gt1_rxheader_out(gt1_rxheader_out),
        .gt1_rxheadervalid_out(gt1_rxheadervalid_out),
        .gt1_rxmonitorout_out(gt1_rxmonitorout_out),
        .gt1_rxmonitorsel_in(gt1_rxmonitorsel_in),
        .gt1_rxoutclk_out(gt1_rxoutclk_out),
        .gt1_rxpcsreset_in(gt1_rxpcsreset_in),
        .gt1_rxprbscntreset_in(gt1_rxprbscntreset_in),
        .gt1_rxprbserr_out(gt1_rxprbserr_out),
        .gt1_rxprbssel_in(gt1_rxprbssel_in),
        .gt1_rxresetdone_out(gt1_rxresetdone_out),
        .gt1_rxuserrdy_in(n_3_gt1_rxresetfsm_i),
        .gt1_rxusrclk2_in(gt1_rxusrclk2_in),
        .gt1_rxusrclk_in(gt1_rxusrclk_in),
        .gt1_txbufstatus_out(gt1_txbufstatus_out),
        .gt1_txdata_in(gt1_txdata_in),
        .gt1_txelecidle_in(gt1_txelecidle_in),
        .gt1_txheader_in(gt1_txheader_in),
        .gt1_txoutclk_out(gt1_txoutclk_out),
        .gt1_txoutclkfabric_out(gt1_txoutclkfabric_out),
        .gt1_txoutclkpcs_out(gt1_txoutclkpcs_out),
        .gt1_txpcsreset_in(gt1_txpcsreset_in),
        .gt1_txpolarity_in(gt1_txpolarity_in),
        .gt1_txprbsforceerr_in(gt1_txprbsforceerr_in),
        .gt1_txprbssel_in(gt1_txprbssel_in),
        .gt1_txresetdone_out(gt1_txresetdone_out),
        .gt1_txsequence_in(gt1_txsequence_in),
        .gt1_txuserrdy_in(n_3_gt1_txresetfsm_i),
        .gt1_txusrclk2_in(gt1_txusrclk2_in),
        .gt1_txusrclk_in(gt1_txusrclk_in),
        .gt2_dmonitorout_out(gt2_dmonitorout_out),
        .gt2_drpaddr_in(gt2_drpaddr_in),
        .gt2_drpclk_in(gt2_drpclk_in),
        .gt2_drpdi_in(gt2_drpdi_in),
        .gt2_drpdo_out(gt2_drpdo_out),
        .gt2_drpen_in(gt2_drpen_in),
        .gt2_drprdy_out(gt2_drprdy_out),
        .gt2_drpwe_in(gt2_drpwe_in),
        .gt2_eyescandataerror_out(gt2_eyescandataerror_out),
        .gt2_eyescanreset_in(gt2_eyescanreset_in),
        .gt2_eyescantrigger_in(gt2_eyescantrigger_in),
        .gt2_gthrxn_in(gt2_gthrxn_in),
        .gt2_gthrxp_in(gt2_gthrxp_in),
        .gt2_gthtxn_out(gt2_gthtxn_out),
        .gt2_gthtxp_out(gt2_gthtxp_out),
        .gt2_gttxreset_in(n_0_gt2_txresetfsm_i),
        .gt2_loopback_in(gt2_loopback_in),
        .gt2_rxbufreset_in(gt2_rxbufreset_in),
        .gt2_rxbufstatus_out(gt2_rxbufstatus_out),
        .gt2_rxdata_out(gt2_rxdata_out),
        .gt2_rxdatavalid_out(gt2_rxdatavalid_out),
        .gt2_rxgearboxslip_in(gt2_rxgearboxslip_in),
        .gt2_rxheader_out(gt2_rxheader_out),
        .gt2_rxheadervalid_out(gt2_rxheadervalid_out),
        .gt2_rxmonitorout_out(gt2_rxmonitorout_out),
        .gt2_rxmonitorsel_in(gt2_rxmonitorsel_in),
        .gt2_rxoutclk_out(gt2_rxoutclk_out),
        .gt2_rxpcsreset_in(gt2_rxpcsreset_in),
        .gt2_rxprbscntreset_in(gt2_rxprbscntreset_in),
        .gt2_rxprbserr_out(gt2_rxprbserr_out),
        .gt2_rxprbssel_in(gt2_rxprbssel_in),
        .gt2_rxresetdone_out(gt2_rxresetdone_out),
        .gt2_rxuserrdy_in(n_3_gt2_rxresetfsm_i),
        .gt2_rxusrclk2_in(gt2_rxusrclk2_in),
        .gt2_rxusrclk_in(gt2_rxusrclk_in),
        .gt2_txbufstatus_out(gt2_txbufstatus_out),
        .gt2_txdata_in(gt2_txdata_in),
        .gt2_txelecidle_in(gt2_txelecidle_in),
        .gt2_txheader_in(gt2_txheader_in),
        .gt2_txoutclk_out(gt2_txoutclk_out),
        .gt2_txoutclkfabric_out(gt2_txoutclkfabric_out),
        .gt2_txoutclkpcs_out(gt2_txoutclkpcs_out),
        .gt2_txpcsreset_in(gt2_txpcsreset_in),
        .gt2_txpolarity_in(gt2_txpolarity_in),
        .gt2_txprbsforceerr_in(gt2_txprbsforceerr_in),
        .gt2_txprbssel_in(gt2_txprbssel_in),
        .gt2_txresetdone_out(gt2_txresetdone_out),
        .gt2_txsequence_in(gt2_txsequence_in),
        .gt2_txuserrdy_in(n_3_gt2_txresetfsm_i),
        .gt2_txusrclk2_in(gt2_txusrclk2_in),
        .gt2_txusrclk_in(gt2_txusrclk_in),
        .gt3_dmonitorout_out(gt3_dmonitorout_out),
        .gt3_drpaddr_in(gt3_drpaddr_in),
        .gt3_drpclk_in(gt3_drpclk_in),
        .gt3_drpdi_in(gt3_drpdi_in),
        .gt3_drpdo_out(gt3_drpdo_out),
        .gt3_drpen_in(gt3_drpen_in),
        .gt3_drprdy_out(gt3_drprdy_out),
        .gt3_drpwe_in(gt3_drpwe_in),
        .gt3_eyescandataerror_out(gt3_eyescandataerror_out),
        .gt3_eyescanreset_in(gt3_eyescanreset_in),
        .gt3_eyescantrigger_in(gt3_eyescantrigger_in),
        .gt3_gthrxn_in(gt3_gthrxn_in),
        .gt3_gthrxp_in(gt3_gthrxp_in),
        .gt3_gthtxn_out(gt3_gthtxn_out),
        .gt3_gthtxp_out(gt3_gthtxp_out),
        .gt3_gttxreset_in(n_0_gt3_txresetfsm_i),
        .gt3_loopback_in(gt3_loopback_in),
        .gt3_rxbufreset_in(gt3_rxbufreset_in),
        .gt3_rxbufstatus_out(gt3_rxbufstatus_out),
        .gt3_rxdata_out(gt3_rxdata_out),
        .gt3_rxdatavalid_out(gt3_rxdatavalid_out),
        .gt3_rxgearboxslip_in(gt3_rxgearboxslip_in),
        .gt3_rxheader_out(gt3_rxheader_out),
        .gt3_rxheadervalid_out(gt3_rxheadervalid_out),
        .gt3_rxmonitorout_out(gt3_rxmonitorout_out),
        .gt3_rxmonitorsel_in(gt3_rxmonitorsel_in),
        .gt3_rxoutclk_out(gt3_rxoutclk_out),
        .gt3_rxpcsreset_in(gt3_rxpcsreset_in),
        .gt3_rxprbscntreset_in(gt3_rxprbscntreset_in),
        .gt3_rxprbserr_out(gt3_rxprbserr_out),
        .gt3_rxprbssel_in(gt3_rxprbssel_in),
        .gt3_rxresetdone_out(gt3_rxresetdone_out),
        .gt3_rxuserrdy_in(n_3_gt3_rxresetfsm_i),
        .gt3_rxusrclk2_in(gt3_rxusrclk2_in),
        .gt3_rxusrclk_in(gt3_rxusrclk_in),
        .gt3_txbufstatus_out(gt3_txbufstatus_out),
        .gt3_txdata_in(gt3_txdata_in),
        .gt3_txelecidle_in(gt3_txelecidle_in),
        .gt3_txheader_in(gt3_txheader_in),
        .gt3_txoutclk_out(gt3_txoutclk_out),
        .gt3_txoutclkfabric_out(gt3_txoutclkfabric_out),
        .gt3_txoutclkpcs_out(gt3_txoutclkpcs_out),
        .gt3_txpcsreset_in(gt3_txpcsreset_in),
        .gt3_txpolarity_in(gt3_txpolarity_in),
        .gt3_txprbsforceerr_in(gt3_txprbsforceerr_in),
        .gt3_txprbssel_in(gt3_txprbssel_in),
        .gt3_txresetdone_out(gt3_txresetdone_out),
        .gt3_txsequence_in(gt3_txsequence_in),
        .gt3_txuserrdy_in(n_3_gt3_txresetfsm_i),
        .gt3_txusrclk2_in(gt3_txusrclk2_in),
        .gt3_txusrclk_in(gt3_txusrclk_in));
(* SOFT_HLUTNM = "soft_lutpair108" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \gt0_rx_cdrlock_counter[0]_i_1 
       (.I0(gt0_rx_cdrlocked),
        .I1(gt0_rx_cdrlock_counter[0]),
        .O(gt0_rx_cdrlock_counter_0[0]));
(* SOFT_HLUTNM = "soft_lutpair108" *) 
   LUT3 #(
    .INIT(8'h06)) 
     \gt0_rx_cdrlock_counter[1]_i_1 
       (.I0(gt0_rx_cdrlock_counter[1]),
        .I1(gt0_rx_cdrlock_counter[0]),
        .I2(gt0_rx_cdrlocked),
        .O(gt0_rx_cdrlock_counter_0[1]));
LUT5 #(
    .INIT(32'h20000000)) 
     \gt0_rx_cdrlock_counter[1]_i_2 
       (.I0(gt0_rx_cdrlock_counter[6]),
        .I1(gt0_rx_cdrlock_counter[7]),
        .I2(gt0_rx_cdrlock_counter[9]),
        .I3(gt0_rx_cdrlock_counter[8]),
        .I4(\n_0_gt0_rx_cdrlock_counter[1]_i_3 ),
        .O(gt0_rx_cdrlocked));
LUT6 #(
    .INIT(64'h0000000000010000)) 
     \gt0_rx_cdrlock_counter[1]_i_3 
       (.I0(gt0_rx_cdrlock_counter[4]),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(gt0_rx_cdrlock_counter[2]),
        .I3(gt0_rx_cdrlock_counter[3]),
        .I4(gt0_rx_cdrlock_counter[0]),
        .I5(gt0_rx_cdrlock_counter[1]),
        .O(\n_0_gt0_rx_cdrlock_counter[1]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair105" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \gt0_rx_cdrlock_counter[2]_i_1 
       (.I0(gt0_rx_cdrlock_counter[2]),
        .I1(gt0_rx_cdrlock_counter[0]),
        .I2(gt0_rx_cdrlock_counter[1]),
        .O(gt0_rx_cdrlock_counter_0[2]));
(* SOFT_HLUTNM = "soft_lutpair99" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \gt0_rx_cdrlock_counter[3]_i_1 
       (.I0(gt0_rx_cdrlock_counter[3]),
        .I1(gt0_rx_cdrlock_counter[1]),
        .I2(gt0_rx_cdrlock_counter[0]),
        .I3(gt0_rx_cdrlock_counter[2]),
        .O(gt0_rx_cdrlock_counter_0[3]));
(* SOFT_HLUTNM = "soft_lutpair99" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gt0_rx_cdrlock_counter[4]_i_1 
       (.I0(gt0_rx_cdrlock_counter[4]),
        .I1(gt0_rx_cdrlock_counter[3]),
        .I2(gt0_rx_cdrlock_counter[1]),
        .I3(gt0_rx_cdrlock_counter[0]),
        .I4(gt0_rx_cdrlock_counter[2]),
        .O(\n_0_gt0_rx_cdrlock_counter[4]_i_1 ));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \gt0_rx_cdrlock_counter[5]_i_1 
       (.I0(gt0_rx_cdrlock_counter[5]),
        .I1(gt0_rx_cdrlock_counter[2]),
        .I2(gt0_rx_cdrlock_counter[0]),
        .I3(gt0_rx_cdrlock_counter[1]),
        .I4(gt0_rx_cdrlock_counter[3]),
        .I5(gt0_rx_cdrlock_counter[4]),
        .O(gt0_rx_cdrlock_counter_0[5]));
(* SOFT_HLUTNM = "soft_lutpair98" *) 
   LUT4 #(
    .INIT(16'hA6AA)) 
     \gt0_rx_cdrlock_counter[6]_i_1 
       (.I0(gt0_rx_cdrlock_counter[6]),
        .I1(gt0_rx_cdrlock_counter[4]),
        .I2(\n_0_gt0_rx_cdrlock_counter[8]_i_2 ),
        .I3(gt0_rx_cdrlock_counter[5]),
        .O(gt0_rx_cdrlock_counter_0[6]));
(* SOFT_HLUTNM = "soft_lutpair98" *) 
   LUT5 #(
    .INIT(32'hA6AAAAAA)) 
     \gt0_rx_cdrlock_counter[7]_i_1 
       (.I0(gt0_rx_cdrlock_counter[7]),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[8]_i_2 ),
        .I3(gt0_rx_cdrlock_counter[4]),
        .I4(gt0_rx_cdrlock_counter[6]),
        .O(gt0_rx_cdrlock_counter_0[7]));
LUT6 #(
    .INIT(64'hAA6AAAAAAAAAAAAA)) 
     \gt0_rx_cdrlock_counter[8]_i_1 
       (.I0(gt0_rx_cdrlock_counter[8]),
        .I1(gt0_rx_cdrlock_counter[6]),
        .I2(gt0_rx_cdrlock_counter[4]),
        .I3(\n_0_gt0_rx_cdrlock_counter[8]_i_2 ),
        .I4(gt0_rx_cdrlock_counter[5]),
        .I5(gt0_rx_cdrlock_counter[7]),
        .O(gt0_rx_cdrlock_counter_0[8]));
(* SOFT_HLUTNM = "soft_lutpair105" *) 
   LUT4 #(
    .INIT(16'h7FFF)) 
     \gt0_rx_cdrlock_counter[8]_i_2 
       (.I0(gt0_rx_cdrlock_counter[2]),
        .I1(gt0_rx_cdrlock_counter[0]),
        .I2(gt0_rx_cdrlock_counter[1]),
        .I3(gt0_rx_cdrlock_counter[3]),
        .O(\n_0_gt0_rx_cdrlock_counter[8]_i_2 ));
LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gt0_rx_cdrlock_counter[9]_i_1 
       (.I0(gt0_rx_cdrlock_counter[9]),
        .I1(gt0_rx_cdrlock_counter[7]),
        .I2(\n_0_gt0_rx_cdrlock_counter[9]_i_2 ),
        .I3(gt0_rx_cdrlock_counter[6]),
        .I4(gt0_rx_cdrlock_counter[8]),
        .O(gt0_rx_cdrlock_counter_0[9]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \gt0_rx_cdrlock_counter[9]_i_2 
       (.I0(gt0_rx_cdrlock_counter[5]),
        .I1(gt0_rx_cdrlock_counter[2]),
        .I2(gt0_rx_cdrlock_counter[0]),
        .I3(gt0_rx_cdrlock_counter[1]),
        .I4(gt0_rx_cdrlock_counter[3]),
        .I5(gt0_rx_cdrlock_counter[4]),
        .O(\n_0_gt0_rx_cdrlock_counter[9]_i_2 ));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_0[0]),
        .Q(gt0_rx_cdrlock_counter[0]),
        .R(GTRXRESET));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_0[1]),
        .Q(gt0_rx_cdrlock_counter[1]),
        .R(GTRXRESET));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_0[2]),
        .Q(gt0_rx_cdrlock_counter[2]),
        .R(GTRXRESET));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_0[3]),
        .Q(gt0_rx_cdrlock_counter[3]),
        .R(GTRXRESET));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[4]_i_1 ),
        .Q(gt0_rx_cdrlock_counter[4]),
        .R(GTRXRESET));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_0[5]),
        .Q(gt0_rx_cdrlock_counter[5]),
        .R(GTRXRESET));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_0[6]),
        .Q(gt0_rx_cdrlock_counter[6]),
        .R(GTRXRESET));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_0[7]),
        .Q(gt0_rx_cdrlock_counter[7]),
        .R(GTRXRESET));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_0[8]),
        .Q(gt0_rx_cdrlock_counter[8]),
        .R(GTRXRESET));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_0[9]),
        .Q(gt0_rx_cdrlock_counter[9]),
        .R(GTRXRESET));
LUT2 #(
    .INIT(4'hE)) 
     gt0_rx_cdrlocked_i_1
       (.I0(gt0_rx_cdrlocked),
        .I1(n_0_gt0_rx_cdrlocked_reg),
        .O(n_0_gt0_rx_cdrlocked_i_1));
FDRE gt0_rx_cdrlocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gt0_rx_cdrlocked_i_1),
        .Q(n_0_gt0_rx_cdrlocked_reg),
        .R(GTRXRESET));
XLAUI_XLAUI_RX_STARTUP_FSM__parameterized0 gt0_rxresetfsm_i
       (.DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .GT0_DATA_VALID_IN(GT0_DATA_VALID_IN),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT0_RX_FSM_RESET_DONE_OUT(GT0_RX_FSM_RESET_DONE_OUT),
        .GT0_RX_MMCM_LOCK_IN(GT0_RX_MMCM_LOCK_IN),
        .GT0_RX_MMCM_RESET_OUT(GT0_RX_MMCM_RESET_OUT),
        .I1(n_0_gt0_rx_cdrlocked_reg),
        .RXOUTCLK(RXOUTCLK),
        .RXUSERRDY(RXUSERRDY),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SR(GTRXRESET),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(RXPMARESETDONE),
        .gt0_rxresetdone_out(gt0_rxresetdone_out),
        .gt0_rxusrclk_in(gt0_rxusrclk_in));
XLAUI_XLAUI_TX_STARTUP_FSM__parameterized0 gt0_txresetfsm_i
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT0_QPLLRESET_OUT(GT0_QPLLRESET_OUT),
        .GT0_TX_FSM_RESET_DONE_OUT(GT0_TX_FSM_RESET_DONE_OUT),
        .GT0_TX_MMCM_LOCK_IN(GT0_TX_MMCM_LOCK_IN),
        .GT0_TX_MMCM_RESET_OUT(GT0_TX_MMCM_RESET_OUT),
        .GTTXRESET(GTTXRESET),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .TXUSERRDY(TXUSERRDY),
        .gt0_txresetdone_out(gt0_txresetdone_out),
        .gt0_txusrclk_in(gt0_txusrclk_in));
(* SOFT_HLUTNM = "soft_lutpair107" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \gt1_rx_cdrlock_counter[0]_i_1 
       (.I0(gt1_rx_cdrlocked),
        .I1(gt1_rx_cdrlock_counter[0]),
        .O(gt1_rx_cdrlock_counter_1[0]));
(* SOFT_HLUTNM = "soft_lutpair107" *) 
   LUT3 #(
    .INIT(8'h06)) 
     \gt1_rx_cdrlock_counter[1]_i_1 
       (.I0(gt1_rx_cdrlock_counter[1]),
        .I1(gt1_rx_cdrlock_counter[0]),
        .I2(gt1_rx_cdrlocked),
        .O(gt1_rx_cdrlock_counter_1[1]));
LUT5 #(
    .INIT(32'h20000000)) 
     \gt1_rx_cdrlock_counter[1]_i_2 
       (.I0(gt1_rx_cdrlock_counter[6]),
        .I1(gt1_rx_cdrlock_counter[7]),
        .I2(gt1_rx_cdrlock_counter[9]),
        .I3(gt1_rx_cdrlock_counter[8]),
        .I4(\n_0_gt1_rx_cdrlock_counter[1]_i_3 ),
        .O(gt1_rx_cdrlocked));
LUT6 #(
    .INIT(64'h0000000000010000)) 
     \gt1_rx_cdrlock_counter[1]_i_3 
       (.I0(gt1_rx_cdrlock_counter[4]),
        .I1(gt1_rx_cdrlock_counter[5]),
        .I2(gt1_rx_cdrlock_counter[2]),
        .I3(gt1_rx_cdrlock_counter[3]),
        .I4(gt1_rx_cdrlock_counter[0]),
        .I5(gt1_rx_cdrlock_counter[1]),
        .O(\n_0_gt1_rx_cdrlock_counter[1]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair104" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \gt1_rx_cdrlock_counter[2]_i_1 
       (.I0(gt1_rx_cdrlock_counter[2]),
        .I1(gt1_rx_cdrlock_counter[0]),
        .I2(gt1_rx_cdrlock_counter[1]),
        .O(gt1_rx_cdrlock_counter_1[2]));
(* SOFT_HLUTNM = "soft_lutpair95" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \gt1_rx_cdrlock_counter[3]_i_1 
       (.I0(gt1_rx_cdrlock_counter[3]),
        .I1(gt1_rx_cdrlock_counter[1]),
        .I2(gt1_rx_cdrlock_counter[0]),
        .I3(gt1_rx_cdrlock_counter[2]),
        .O(gt1_rx_cdrlock_counter_1[3]));
(* SOFT_HLUTNM = "soft_lutpair95" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gt1_rx_cdrlock_counter[4]_i_1 
       (.I0(gt1_rx_cdrlock_counter[4]),
        .I1(gt1_rx_cdrlock_counter[3]),
        .I2(gt1_rx_cdrlock_counter[1]),
        .I3(gt1_rx_cdrlock_counter[0]),
        .I4(gt1_rx_cdrlock_counter[2]),
        .O(\n_0_gt1_rx_cdrlock_counter[4]_i_1 ));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \gt1_rx_cdrlock_counter[5]_i_1 
       (.I0(gt1_rx_cdrlock_counter[5]),
        .I1(gt1_rx_cdrlock_counter[2]),
        .I2(gt1_rx_cdrlock_counter[0]),
        .I3(gt1_rx_cdrlock_counter[1]),
        .I4(gt1_rx_cdrlock_counter[3]),
        .I5(gt1_rx_cdrlock_counter[4]),
        .O(gt1_rx_cdrlock_counter_1[5]));
(* SOFT_HLUTNM = "soft_lutpair100" *) 
   LUT4 #(
    .INIT(16'hA6AA)) 
     \gt1_rx_cdrlock_counter[6]_i_1 
       (.I0(gt1_rx_cdrlock_counter[6]),
        .I1(gt1_rx_cdrlock_counter[4]),
        .I2(\n_0_gt1_rx_cdrlock_counter[8]_i_2 ),
        .I3(gt1_rx_cdrlock_counter[5]),
        .O(gt1_rx_cdrlock_counter_1[6]));
(* SOFT_HLUTNM = "soft_lutpair100" *) 
   LUT5 #(
    .INIT(32'hA6AAAAAA)) 
     \gt1_rx_cdrlock_counter[7]_i_1 
       (.I0(gt1_rx_cdrlock_counter[7]),
        .I1(gt1_rx_cdrlock_counter[5]),
        .I2(\n_0_gt1_rx_cdrlock_counter[8]_i_2 ),
        .I3(gt1_rx_cdrlock_counter[4]),
        .I4(gt1_rx_cdrlock_counter[6]),
        .O(gt1_rx_cdrlock_counter_1[7]));
LUT6 #(
    .INIT(64'hAA6AAAAAAAAAAAAA)) 
     \gt1_rx_cdrlock_counter[8]_i_1 
       (.I0(gt1_rx_cdrlock_counter[8]),
        .I1(gt1_rx_cdrlock_counter[6]),
        .I2(gt1_rx_cdrlock_counter[4]),
        .I3(\n_0_gt1_rx_cdrlock_counter[8]_i_2 ),
        .I4(gt1_rx_cdrlock_counter[5]),
        .I5(gt1_rx_cdrlock_counter[7]),
        .O(gt1_rx_cdrlock_counter_1[8]));
(* SOFT_HLUTNM = "soft_lutpair104" *) 
   LUT4 #(
    .INIT(16'h7FFF)) 
     \gt1_rx_cdrlock_counter[8]_i_2 
       (.I0(gt1_rx_cdrlock_counter[2]),
        .I1(gt1_rx_cdrlock_counter[0]),
        .I2(gt1_rx_cdrlock_counter[1]),
        .I3(gt1_rx_cdrlock_counter[3]),
        .O(\n_0_gt1_rx_cdrlock_counter[8]_i_2 ));
LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gt1_rx_cdrlock_counter[9]_i_1 
       (.I0(gt1_rx_cdrlock_counter[9]),
        .I1(gt1_rx_cdrlock_counter[7]),
        .I2(\n_0_gt1_rx_cdrlock_counter[9]_i_2 ),
        .I3(gt1_rx_cdrlock_counter[6]),
        .I4(gt1_rx_cdrlock_counter[8]),
        .O(gt1_rx_cdrlock_counter_1[9]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \gt1_rx_cdrlock_counter[9]_i_2 
       (.I0(gt1_rx_cdrlock_counter[5]),
        .I1(gt1_rx_cdrlock_counter[2]),
        .I2(gt1_rx_cdrlock_counter[0]),
        .I3(gt1_rx_cdrlock_counter[1]),
        .I4(gt1_rx_cdrlock_counter[3]),
        .I5(gt1_rx_cdrlock_counter[4]),
        .O(\n_0_gt1_rx_cdrlock_counter[9]_i_2 ));
FDRE #(
    .INIT(1'b0)) 
     \gt1_rx_cdrlock_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rx_cdrlock_counter_1[0]),
        .Q(gt1_rx_cdrlock_counter[0]),
        .R(n_0_gt1_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt1_rx_cdrlock_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rx_cdrlock_counter_1[1]),
        .Q(gt1_rx_cdrlock_counter[1]),
        .R(n_0_gt1_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt1_rx_cdrlock_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rx_cdrlock_counter_1[2]),
        .Q(gt1_rx_cdrlock_counter[2]),
        .R(n_0_gt1_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt1_rx_cdrlock_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rx_cdrlock_counter_1[3]),
        .Q(gt1_rx_cdrlock_counter[3]),
        .R(n_0_gt1_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt1_rx_cdrlock_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(\n_0_gt1_rx_cdrlock_counter[4]_i_1 ),
        .Q(gt1_rx_cdrlock_counter[4]),
        .R(n_0_gt1_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt1_rx_cdrlock_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rx_cdrlock_counter_1[5]),
        .Q(gt1_rx_cdrlock_counter[5]),
        .R(n_0_gt1_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt1_rx_cdrlock_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rx_cdrlock_counter_1[6]),
        .Q(gt1_rx_cdrlock_counter[6]),
        .R(n_0_gt1_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt1_rx_cdrlock_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rx_cdrlock_counter_1[7]),
        .Q(gt1_rx_cdrlock_counter[7]),
        .R(n_0_gt1_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt1_rx_cdrlock_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rx_cdrlock_counter_1[8]),
        .Q(gt1_rx_cdrlock_counter[8]),
        .R(n_0_gt1_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt1_rx_cdrlock_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rx_cdrlock_counter_1[9]),
        .Q(gt1_rx_cdrlock_counter[9]),
        .R(n_0_gt1_rxresetfsm_i));
LUT2 #(
    .INIT(4'hE)) 
     gt1_rx_cdrlocked_i_1
       (.I0(gt1_rx_cdrlocked),
        .I1(n_0_gt1_rx_cdrlocked_reg),
        .O(n_0_gt1_rx_cdrlocked_i_1));
FDRE gt1_rx_cdrlocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gt1_rx_cdrlocked_i_1),
        .Q(n_0_gt1_rx_cdrlocked_reg),
        .R(n_0_gt1_rxresetfsm_i));
XLAUI_XLAUI_RX_STARTUP_FSM__parameterized0_0 gt1_rxresetfsm_i
       (.DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT1_DATA_VALID_IN(GT1_DATA_VALID_IN),
        .GT1_RX_FSM_RESET_DONE_OUT(GT1_RX_FSM_RESET_DONE_OUT),
        .GT1_RX_MMCM_LOCK_IN(GT1_RX_MMCM_LOCK_IN),
        .GT1_RX_MMCM_RESET_OUT(GT1_RX_MMCM_RESET_OUT),
        .I1(n_0_gt1_rx_cdrlocked_reg),
        .O1(n_3_gt1_rxresetfsm_i),
        .RXOUTCLK(RXOUTCLK),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SR(n_0_gt1_rxresetfsm_i),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(n_128_XLAUI_i),
        .gt1_rxresetdone_out(gt1_rxresetdone_out),
        .gt1_rxusrclk_in(gt1_rxusrclk_in));
XLAUI_XLAUI_TX_STARTUP_FSM__parameterized0_1 gt1_txresetfsm_i
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT1_TX_FSM_RESET_DONE_OUT(GT1_TX_FSM_RESET_DONE_OUT),
        .GT1_TX_MMCM_LOCK_IN(GT1_TX_MMCM_LOCK_IN),
        .GT1_TX_MMCM_RESET_OUT(GT1_TX_MMCM_RESET_OUT),
        .O1(n_0_gt1_txresetfsm_i),
        .O2(n_3_gt1_txresetfsm_i),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .gt1_txresetdone_out(gt1_txresetdone_out),
        .gt1_txusrclk_in(gt1_txusrclk_in));
(* SOFT_HLUTNM = "soft_lutpair109" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \gt2_rx_cdrlock_counter[0]_i_1 
       (.I0(gt2_rx_cdrlocked),
        .I1(gt2_rx_cdrlock_counter[0]),
        .O(gt2_rx_cdrlock_counter_2[0]));
(* SOFT_HLUTNM = "soft_lutpair109" *) 
   LUT3 #(
    .INIT(8'h06)) 
     \gt2_rx_cdrlock_counter[1]_i_1 
       (.I0(gt2_rx_cdrlock_counter[1]),
        .I1(gt2_rx_cdrlock_counter[0]),
        .I2(gt2_rx_cdrlocked),
        .O(gt2_rx_cdrlock_counter_2[1]));
LUT5 #(
    .INIT(32'h20000000)) 
     \gt2_rx_cdrlock_counter[1]_i_2 
       (.I0(gt2_rx_cdrlock_counter[6]),
        .I1(gt2_rx_cdrlock_counter[7]),
        .I2(gt2_rx_cdrlock_counter[9]),
        .I3(gt2_rx_cdrlock_counter[8]),
        .I4(\n_0_gt2_rx_cdrlock_counter[1]_i_3 ),
        .O(gt2_rx_cdrlocked));
LUT6 #(
    .INIT(64'h0000000000010000)) 
     \gt2_rx_cdrlock_counter[1]_i_3 
       (.I0(gt2_rx_cdrlock_counter[4]),
        .I1(gt2_rx_cdrlock_counter[5]),
        .I2(gt2_rx_cdrlock_counter[2]),
        .I3(gt2_rx_cdrlock_counter[3]),
        .I4(gt2_rx_cdrlock_counter[0]),
        .I5(gt2_rx_cdrlock_counter[1]),
        .O(\n_0_gt2_rx_cdrlock_counter[1]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair106" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \gt2_rx_cdrlock_counter[2]_i_1 
       (.I0(gt2_rx_cdrlock_counter[2]),
        .I1(gt2_rx_cdrlock_counter[0]),
        .I2(gt2_rx_cdrlock_counter[1]),
        .O(gt2_rx_cdrlock_counter_2[2]));
(* SOFT_HLUTNM = "soft_lutpair97" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \gt2_rx_cdrlock_counter[3]_i_1 
       (.I0(gt2_rx_cdrlock_counter[3]),
        .I1(gt2_rx_cdrlock_counter[1]),
        .I2(gt2_rx_cdrlock_counter[0]),
        .I3(gt2_rx_cdrlock_counter[2]),
        .O(gt2_rx_cdrlock_counter_2[3]));
(* SOFT_HLUTNM = "soft_lutpair97" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gt2_rx_cdrlock_counter[4]_i_1 
       (.I0(gt2_rx_cdrlock_counter[4]),
        .I1(gt2_rx_cdrlock_counter[3]),
        .I2(gt2_rx_cdrlock_counter[1]),
        .I3(gt2_rx_cdrlock_counter[0]),
        .I4(gt2_rx_cdrlock_counter[2]),
        .O(\n_0_gt2_rx_cdrlock_counter[4]_i_1 ));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \gt2_rx_cdrlock_counter[5]_i_1 
       (.I0(gt2_rx_cdrlock_counter[5]),
        .I1(gt2_rx_cdrlock_counter[2]),
        .I2(gt2_rx_cdrlock_counter[0]),
        .I3(gt2_rx_cdrlock_counter[1]),
        .I4(gt2_rx_cdrlock_counter[3]),
        .I5(gt2_rx_cdrlock_counter[4]),
        .O(gt2_rx_cdrlock_counter_2[5]));
(* SOFT_HLUTNM = "soft_lutpair102" *) 
   LUT4 #(
    .INIT(16'hA6AA)) 
     \gt2_rx_cdrlock_counter[6]_i_1 
       (.I0(gt2_rx_cdrlock_counter[6]),
        .I1(gt2_rx_cdrlock_counter[4]),
        .I2(\n_0_gt2_rx_cdrlock_counter[8]_i_2 ),
        .I3(gt2_rx_cdrlock_counter[5]),
        .O(gt2_rx_cdrlock_counter_2[6]));
(* SOFT_HLUTNM = "soft_lutpair102" *) 
   LUT5 #(
    .INIT(32'hA6AAAAAA)) 
     \gt2_rx_cdrlock_counter[7]_i_1 
       (.I0(gt2_rx_cdrlock_counter[7]),
        .I1(gt2_rx_cdrlock_counter[5]),
        .I2(\n_0_gt2_rx_cdrlock_counter[8]_i_2 ),
        .I3(gt2_rx_cdrlock_counter[4]),
        .I4(gt2_rx_cdrlock_counter[6]),
        .O(gt2_rx_cdrlock_counter_2[7]));
LUT6 #(
    .INIT(64'hAA6AAAAAAAAAAAAA)) 
     \gt2_rx_cdrlock_counter[8]_i_1 
       (.I0(gt2_rx_cdrlock_counter[8]),
        .I1(gt2_rx_cdrlock_counter[6]),
        .I2(gt2_rx_cdrlock_counter[4]),
        .I3(\n_0_gt2_rx_cdrlock_counter[8]_i_2 ),
        .I4(gt2_rx_cdrlock_counter[5]),
        .I5(gt2_rx_cdrlock_counter[7]),
        .O(gt2_rx_cdrlock_counter_2[8]));
(* SOFT_HLUTNM = "soft_lutpair106" *) 
   LUT4 #(
    .INIT(16'h7FFF)) 
     \gt2_rx_cdrlock_counter[8]_i_2 
       (.I0(gt2_rx_cdrlock_counter[2]),
        .I1(gt2_rx_cdrlock_counter[0]),
        .I2(gt2_rx_cdrlock_counter[1]),
        .I3(gt2_rx_cdrlock_counter[3]),
        .O(\n_0_gt2_rx_cdrlock_counter[8]_i_2 ));
LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gt2_rx_cdrlock_counter[9]_i_1 
       (.I0(gt2_rx_cdrlock_counter[9]),
        .I1(gt2_rx_cdrlock_counter[7]),
        .I2(\n_0_gt2_rx_cdrlock_counter[9]_i_2 ),
        .I3(gt2_rx_cdrlock_counter[6]),
        .I4(gt2_rx_cdrlock_counter[8]),
        .O(gt2_rx_cdrlock_counter_2[9]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \gt2_rx_cdrlock_counter[9]_i_2 
       (.I0(gt2_rx_cdrlock_counter[5]),
        .I1(gt2_rx_cdrlock_counter[2]),
        .I2(gt2_rx_cdrlock_counter[0]),
        .I3(gt2_rx_cdrlock_counter[1]),
        .I4(gt2_rx_cdrlock_counter[3]),
        .I5(gt2_rx_cdrlock_counter[4]),
        .O(\n_0_gt2_rx_cdrlock_counter[9]_i_2 ));
FDRE #(
    .INIT(1'b0)) 
     \gt2_rx_cdrlock_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rx_cdrlock_counter_2[0]),
        .Q(gt2_rx_cdrlock_counter[0]),
        .R(n_0_gt2_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt2_rx_cdrlock_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rx_cdrlock_counter_2[1]),
        .Q(gt2_rx_cdrlock_counter[1]),
        .R(n_0_gt2_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt2_rx_cdrlock_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rx_cdrlock_counter_2[2]),
        .Q(gt2_rx_cdrlock_counter[2]),
        .R(n_0_gt2_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt2_rx_cdrlock_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rx_cdrlock_counter_2[3]),
        .Q(gt2_rx_cdrlock_counter[3]),
        .R(n_0_gt2_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt2_rx_cdrlock_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(\n_0_gt2_rx_cdrlock_counter[4]_i_1 ),
        .Q(gt2_rx_cdrlock_counter[4]),
        .R(n_0_gt2_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt2_rx_cdrlock_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rx_cdrlock_counter_2[5]),
        .Q(gt2_rx_cdrlock_counter[5]),
        .R(n_0_gt2_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt2_rx_cdrlock_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rx_cdrlock_counter_2[6]),
        .Q(gt2_rx_cdrlock_counter[6]),
        .R(n_0_gt2_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt2_rx_cdrlock_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rx_cdrlock_counter_2[7]),
        .Q(gt2_rx_cdrlock_counter[7]),
        .R(n_0_gt2_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt2_rx_cdrlock_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rx_cdrlock_counter_2[8]),
        .Q(gt2_rx_cdrlock_counter[8]),
        .R(n_0_gt2_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt2_rx_cdrlock_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rx_cdrlock_counter_2[9]),
        .Q(gt2_rx_cdrlock_counter[9]),
        .R(n_0_gt2_rxresetfsm_i));
LUT2 #(
    .INIT(4'hE)) 
     gt2_rx_cdrlocked_i_1
       (.I0(gt2_rx_cdrlocked),
        .I1(n_0_gt2_rx_cdrlocked_reg),
        .O(n_0_gt2_rx_cdrlocked_i_1));
FDRE gt2_rx_cdrlocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gt2_rx_cdrlocked_i_1),
        .Q(n_0_gt2_rx_cdrlocked_reg),
        .R(n_0_gt2_rxresetfsm_i));
XLAUI_XLAUI_RX_STARTUP_FSM__parameterized0_2 gt2_rxresetfsm_i
       (.DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT2_DATA_VALID_IN(GT2_DATA_VALID_IN),
        .GT2_RX_FSM_RESET_DONE_OUT(GT2_RX_FSM_RESET_DONE_OUT),
        .GT2_RX_MMCM_LOCK_IN(GT2_RX_MMCM_LOCK_IN),
        .GT2_RX_MMCM_RESET_OUT(GT2_RX_MMCM_RESET_OUT),
        .I1(n_0_gt2_rx_cdrlocked_reg),
        .O1(n_3_gt2_rxresetfsm_i),
        .RXOUTCLK(RXOUTCLK),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SR(n_0_gt2_rxresetfsm_i),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(n_251_XLAUI_i),
        .gt2_rxresetdone_out(gt2_rxresetdone_out),
        .gt2_rxusrclk_in(gt2_rxusrclk_in));
XLAUI_XLAUI_TX_STARTUP_FSM__parameterized0_3 gt2_txresetfsm_i
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT2_TX_FSM_RESET_DONE_OUT(GT2_TX_FSM_RESET_DONE_OUT),
        .GT2_TX_MMCM_LOCK_IN(GT2_TX_MMCM_LOCK_IN),
        .GT2_TX_MMCM_RESET_OUT(GT2_TX_MMCM_RESET_OUT),
        .O1(n_0_gt2_txresetfsm_i),
        .O2(n_3_gt2_txresetfsm_i),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .gt2_txresetdone_out(gt2_txresetdone_out),
        .gt2_txusrclk_in(gt2_txusrclk_in));
(* SOFT_HLUTNM = "soft_lutpair110" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \gt3_rx_cdrlock_counter[0]_i_1 
       (.I0(gt3_rx_cdrlocked),
        .I1(gt3_rx_cdrlock_counter[0]),
        .O(gt3_rx_cdrlock_counter_3[0]));
(* SOFT_HLUTNM = "soft_lutpair110" *) 
   LUT3 #(
    .INIT(8'h06)) 
     \gt3_rx_cdrlock_counter[1]_i_1 
       (.I0(gt3_rx_cdrlock_counter[1]),
        .I1(gt3_rx_cdrlock_counter[0]),
        .I2(gt3_rx_cdrlocked),
        .O(gt3_rx_cdrlock_counter_3[1]));
LUT5 #(
    .INIT(32'h20000000)) 
     \gt3_rx_cdrlock_counter[1]_i_2 
       (.I0(gt3_rx_cdrlock_counter[6]),
        .I1(gt3_rx_cdrlock_counter[7]),
        .I2(gt3_rx_cdrlock_counter[9]),
        .I3(gt3_rx_cdrlock_counter[8]),
        .I4(\n_0_gt3_rx_cdrlock_counter[1]_i_3 ),
        .O(gt3_rx_cdrlocked));
LUT6 #(
    .INIT(64'h0000000000010000)) 
     \gt3_rx_cdrlock_counter[1]_i_3 
       (.I0(gt3_rx_cdrlock_counter[4]),
        .I1(gt3_rx_cdrlock_counter[5]),
        .I2(gt3_rx_cdrlock_counter[2]),
        .I3(gt3_rx_cdrlock_counter[3]),
        .I4(gt3_rx_cdrlock_counter[0]),
        .I5(gt3_rx_cdrlock_counter[1]),
        .O(\n_0_gt3_rx_cdrlock_counter[1]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair103" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \gt3_rx_cdrlock_counter[2]_i_1 
       (.I0(gt3_rx_cdrlock_counter[2]),
        .I1(gt3_rx_cdrlock_counter[0]),
        .I2(gt3_rx_cdrlock_counter[1]),
        .O(gt3_rx_cdrlock_counter_3[2]));
(* SOFT_HLUTNM = "soft_lutpair96" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \gt3_rx_cdrlock_counter[3]_i_1 
       (.I0(gt3_rx_cdrlock_counter[3]),
        .I1(gt3_rx_cdrlock_counter[1]),
        .I2(gt3_rx_cdrlock_counter[0]),
        .I3(gt3_rx_cdrlock_counter[2]),
        .O(gt3_rx_cdrlock_counter_3[3]));
(* SOFT_HLUTNM = "soft_lutpair96" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gt3_rx_cdrlock_counter[4]_i_1 
       (.I0(gt3_rx_cdrlock_counter[4]),
        .I1(gt3_rx_cdrlock_counter[3]),
        .I2(gt3_rx_cdrlock_counter[1]),
        .I3(gt3_rx_cdrlock_counter[0]),
        .I4(gt3_rx_cdrlock_counter[2]),
        .O(\n_0_gt3_rx_cdrlock_counter[4]_i_1 ));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \gt3_rx_cdrlock_counter[5]_i_1 
       (.I0(gt3_rx_cdrlock_counter[5]),
        .I1(gt3_rx_cdrlock_counter[2]),
        .I2(gt3_rx_cdrlock_counter[0]),
        .I3(gt3_rx_cdrlock_counter[1]),
        .I4(gt3_rx_cdrlock_counter[3]),
        .I5(gt3_rx_cdrlock_counter[4]),
        .O(gt3_rx_cdrlock_counter_3[5]));
(* SOFT_HLUTNM = "soft_lutpair101" *) 
   LUT4 #(
    .INIT(16'hA6AA)) 
     \gt3_rx_cdrlock_counter[6]_i_1 
       (.I0(gt3_rx_cdrlock_counter[6]),
        .I1(gt3_rx_cdrlock_counter[4]),
        .I2(\n_0_gt3_rx_cdrlock_counter[8]_i_2 ),
        .I3(gt3_rx_cdrlock_counter[5]),
        .O(gt3_rx_cdrlock_counter_3[6]));
(* SOFT_HLUTNM = "soft_lutpair101" *) 
   LUT5 #(
    .INIT(32'hA6AAAAAA)) 
     \gt3_rx_cdrlock_counter[7]_i_1 
       (.I0(gt3_rx_cdrlock_counter[7]),
        .I1(gt3_rx_cdrlock_counter[5]),
        .I2(\n_0_gt3_rx_cdrlock_counter[8]_i_2 ),
        .I3(gt3_rx_cdrlock_counter[4]),
        .I4(gt3_rx_cdrlock_counter[6]),
        .O(gt3_rx_cdrlock_counter_3[7]));
LUT6 #(
    .INIT(64'hAA6AAAAAAAAAAAAA)) 
     \gt3_rx_cdrlock_counter[8]_i_1 
       (.I0(gt3_rx_cdrlock_counter[8]),
        .I1(gt3_rx_cdrlock_counter[6]),
        .I2(gt3_rx_cdrlock_counter[4]),
        .I3(\n_0_gt3_rx_cdrlock_counter[8]_i_2 ),
        .I4(gt3_rx_cdrlock_counter[5]),
        .I5(gt3_rx_cdrlock_counter[7]),
        .O(gt3_rx_cdrlock_counter_3[8]));
(* SOFT_HLUTNM = "soft_lutpair103" *) 
   LUT4 #(
    .INIT(16'h7FFF)) 
     \gt3_rx_cdrlock_counter[8]_i_2 
       (.I0(gt3_rx_cdrlock_counter[2]),
        .I1(gt3_rx_cdrlock_counter[0]),
        .I2(gt3_rx_cdrlock_counter[1]),
        .I3(gt3_rx_cdrlock_counter[3]),
        .O(\n_0_gt3_rx_cdrlock_counter[8]_i_2 ));
LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gt3_rx_cdrlock_counter[9]_i_1 
       (.I0(gt3_rx_cdrlock_counter[9]),
        .I1(gt3_rx_cdrlock_counter[7]),
        .I2(\n_0_gt3_rx_cdrlock_counter[9]_i_2 ),
        .I3(gt3_rx_cdrlock_counter[6]),
        .I4(gt3_rx_cdrlock_counter[8]),
        .O(gt3_rx_cdrlock_counter_3[9]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \gt3_rx_cdrlock_counter[9]_i_2 
       (.I0(gt3_rx_cdrlock_counter[5]),
        .I1(gt3_rx_cdrlock_counter[2]),
        .I2(gt3_rx_cdrlock_counter[0]),
        .I3(gt3_rx_cdrlock_counter[1]),
        .I4(gt3_rx_cdrlock_counter[3]),
        .I5(gt3_rx_cdrlock_counter[4]),
        .O(\n_0_gt3_rx_cdrlock_counter[9]_i_2 ));
FDRE #(
    .INIT(1'b0)) 
     \gt3_rx_cdrlock_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rx_cdrlock_counter_3[0]),
        .Q(gt3_rx_cdrlock_counter[0]),
        .R(n_0_gt3_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt3_rx_cdrlock_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rx_cdrlock_counter_3[1]),
        .Q(gt3_rx_cdrlock_counter[1]),
        .R(n_0_gt3_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt3_rx_cdrlock_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rx_cdrlock_counter_3[2]),
        .Q(gt3_rx_cdrlock_counter[2]),
        .R(n_0_gt3_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt3_rx_cdrlock_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rx_cdrlock_counter_3[3]),
        .Q(gt3_rx_cdrlock_counter[3]),
        .R(n_0_gt3_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt3_rx_cdrlock_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(\n_0_gt3_rx_cdrlock_counter[4]_i_1 ),
        .Q(gt3_rx_cdrlock_counter[4]),
        .R(n_0_gt3_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt3_rx_cdrlock_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rx_cdrlock_counter_3[5]),
        .Q(gt3_rx_cdrlock_counter[5]),
        .R(n_0_gt3_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt3_rx_cdrlock_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rx_cdrlock_counter_3[6]),
        .Q(gt3_rx_cdrlock_counter[6]),
        .R(n_0_gt3_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt3_rx_cdrlock_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rx_cdrlock_counter_3[7]),
        .Q(gt3_rx_cdrlock_counter[7]),
        .R(n_0_gt3_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt3_rx_cdrlock_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rx_cdrlock_counter_3[8]),
        .Q(gt3_rx_cdrlock_counter[8]),
        .R(n_0_gt3_rxresetfsm_i));
FDRE #(
    .INIT(1'b0)) 
     \gt3_rx_cdrlock_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rx_cdrlock_counter_3[9]),
        .Q(gt3_rx_cdrlock_counter[9]),
        .R(n_0_gt3_rxresetfsm_i));
LUT2 #(
    .INIT(4'hE)) 
     gt3_rx_cdrlocked_i_1
       (.I0(gt3_rx_cdrlocked),
        .I1(n_0_gt3_rx_cdrlocked_reg),
        .O(n_0_gt3_rx_cdrlocked_i_1));
FDRE gt3_rx_cdrlocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(n_0_gt3_rx_cdrlocked_i_1),
        .Q(n_0_gt3_rx_cdrlocked_reg),
        .R(n_0_gt3_rxresetfsm_i));
XLAUI_XLAUI_RX_STARTUP_FSM__parameterized0_4 gt3_rxresetfsm_i
       (.DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT3_DATA_VALID_IN(GT3_DATA_VALID_IN),
        .GT3_RX_FSM_RESET_DONE_OUT(GT3_RX_FSM_RESET_DONE_OUT),
        .GT3_RX_MMCM_LOCK_IN(GT3_RX_MMCM_LOCK_IN),
        .GT3_RX_MMCM_RESET_OUT(GT3_RX_MMCM_RESET_OUT),
        .I1(n_0_gt3_rx_cdrlocked_reg),
        .O1(n_3_gt3_rxresetfsm_i),
        .RXOUTCLK(RXOUTCLK),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SR(n_0_gt3_rxresetfsm_i),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(n_374_XLAUI_i),
        .gt3_rxresetdone_out(gt3_rxresetdone_out),
        .gt3_rxusrclk_in(gt3_rxusrclk_in));
XLAUI_XLAUI_TX_STARTUP_FSM__parameterized0_5 gt3_txresetfsm_i
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT3_TX_FSM_RESET_DONE_OUT(GT3_TX_FSM_RESET_DONE_OUT),
        .GT3_TX_MMCM_LOCK_IN(GT3_TX_MMCM_LOCK_IN),
        .GT3_TX_MMCM_RESET_OUT(GT3_TX_MMCM_RESET_OUT),
        .O1(n_0_gt3_txresetfsm_i),
        .O2(n_3_gt3_txresetfsm_i),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .gt3_txresetdone_out(gt3_txresetdone_out),
        .gt3_txusrclk_in(gt3_txusrclk_in));
(* box_type = "PRIMITIVE" *) 
   BUFH rxout0_i
       (.I(gt0_rxoutclk_out),
        .O(RXOUTCLK));
endmodule

(* ORIG_REF_NAME = "XLAUI_multi_gt" *) 
module XLAUI_XLAUI_multi_gt__parameterized0
   (gt0_drprdy_out,
    gt0_eyescandataerror_out,
    gt0_gthtxn_out,
    gt0_gthtxp_out,
    gt0_rxoutclk_out,
    GT0_RXPMARESETDONE_OUT,
    gt0_rxprbserr_out,
    gt0_rxresetdone_out,
    gt0_txoutclk_out,
    gt0_txoutclkfabric_out,
    gt0_txoutclkpcs_out,
    gt0_txresetdone_out,
    gt0_dmonitorout_out,
    gt0_drpdo_out,
    gt0_rxdatavalid_out,
    gt0_rxheadervalid_out,
    gt0_txbufstatus_out,
    gt0_rxbufstatus_out,
    gt0_rxheader_out,
    gt0_rxdata_out,
    gt0_rxmonitorout_out,
    gt1_drprdy_out,
    gt1_eyescandataerror_out,
    gt1_gthtxn_out,
    gt1_gthtxp_out,
    gt1_rxoutclk_out,
    GT1_RXPMARESETDONE_OUT,
    gt1_rxprbserr_out,
    gt1_rxresetdone_out,
    gt1_txoutclk_out,
    gt1_txoutclkfabric_out,
    gt1_txoutclkpcs_out,
    gt1_txresetdone_out,
    gt1_dmonitorout_out,
    gt1_drpdo_out,
    gt1_rxdatavalid_out,
    gt1_rxheadervalid_out,
    gt1_txbufstatus_out,
    gt1_rxbufstatus_out,
    gt1_rxheader_out,
    gt1_rxdata_out,
    gt1_rxmonitorout_out,
    gt2_drprdy_out,
    gt2_eyescandataerror_out,
    gt2_gthtxn_out,
    gt2_gthtxp_out,
    gt2_rxoutclk_out,
    GT2_RXPMARESETDONE_OUT,
    gt2_rxprbserr_out,
    gt2_rxresetdone_out,
    gt2_txoutclk_out,
    gt2_txoutclkfabric_out,
    gt2_txoutclkpcs_out,
    gt2_txresetdone_out,
    gt2_dmonitorout_out,
    gt2_drpdo_out,
    gt2_rxdatavalid_out,
    gt2_rxheadervalid_out,
    gt2_txbufstatus_out,
    gt2_rxbufstatus_out,
    gt2_rxheader_out,
    gt2_rxdata_out,
    gt2_rxmonitorout_out,
    gt3_drprdy_out,
    gt3_eyescandataerror_out,
    gt3_gthtxn_out,
    gt3_gthtxp_out,
    gt3_rxoutclk_out,
    GT3_RXPMARESETDONE_OUT,
    gt3_rxprbserr_out,
    gt3_rxresetdone_out,
    gt3_txoutclk_out,
    gt3_txoutclkfabric_out,
    gt3_txoutclkpcs_out,
    gt3_txresetdone_out,
    gt3_dmonitorout_out,
    gt3_drpdo_out,
    gt3_rxdatavalid_out,
    gt3_rxheadervalid_out,
    gt3_txbufstatus_out,
    gt3_rxbufstatus_out,
    gt3_rxheader_out,
    gt3_rxdata_out,
    gt3_rxmonitorout_out,
    gt0_drpclk_in,
    gt0_drpen_in,
    gt0_drpwe_in,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    gt0_gthrxn_in,
    gt0_gthrxp_in,
    SR,
    gt0_gttxreset_in,
    GT0_QPLLOUTCLK_IN,
    GT0_QPLLOUTREFCLK_IN,
    gt0_rxbufreset_in,
    gt0_rxgearboxslip_in,
    gt0_rxpcsreset_in,
    gt0_rxprbscntreset_in,
    gt0_rxuserrdy_in,
    gt0_rxusrclk_in,
    gt0_rxusrclk2_in,
    gt0_txelecidle_in,
    gt0_txpcsreset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    gt0_txuserrdy_in,
    gt0_txusrclk_in,
    gt0_txusrclk2_in,
    gt0_drpdi_in,
    gt0_rxmonitorsel_in,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_txheader_in,
    gt0_txprbssel_in,
    gt0_txdata_in,
    gt0_txsequence_in,
    gt0_drpaddr_in,
    gt1_drpclk_in,
    gt1_drpen_in,
    gt1_drpwe_in,
    gt1_eyescanreset_in,
    gt1_eyescantrigger_in,
    gt1_gthrxn_in,
    gt1_gthrxp_in,
    I1,
    gt1_gttxreset_in,
    gt1_rxbufreset_in,
    gt1_rxgearboxslip_in,
    gt1_rxpcsreset_in,
    gt1_rxprbscntreset_in,
    gt1_rxuserrdy_in,
    gt1_rxusrclk_in,
    gt1_rxusrclk2_in,
    gt1_txelecidle_in,
    gt1_txpcsreset_in,
    gt1_txpolarity_in,
    gt1_txprbsforceerr_in,
    gt1_txuserrdy_in,
    gt1_txusrclk_in,
    gt1_txusrclk2_in,
    gt1_drpdi_in,
    gt1_rxmonitorsel_in,
    gt1_loopback_in,
    gt1_rxprbssel_in,
    gt1_txheader_in,
    gt1_txprbssel_in,
    gt1_txdata_in,
    gt1_txsequence_in,
    gt1_drpaddr_in,
    gt2_drpclk_in,
    gt2_drpen_in,
    gt2_drpwe_in,
    gt2_eyescanreset_in,
    gt2_eyescantrigger_in,
    gt2_gthrxn_in,
    gt2_gthrxp_in,
    I2,
    gt2_gttxreset_in,
    gt2_rxbufreset_in,
    gt2_rxgearboxslip_in,
    gt2_rxpcsreset_in,
    gt2_rxprbscntreset_in,
    gt2_rxuserrdy_in,
    gt2_rxusrclk_in,
    gt2_rxusrclk2_in,
    gt2_txelecidle_in,
    gt2_txpcsreset_in,
    gt2_txpolarity_in,
    gt2_txprbsforceerr_in,
    gt2_txuserrdy_in,
    gt2_txusrclk_in,
    gt2_txusrclk2_in,
    gt2_drpdi_in,
    gt2_rxmonitorsel_in,
    gt2_loopback_in,
    gt2_rxprbssel_in,
    gt2_txheader_in,
    gt2_txprbssel_in,
    gt2_txdata_in,
    gt2_txsequence_in,
    gt2_drpaddr_in,
    gt3_drpclk_in,
    gt3_drpen_in,
    gt3_drpwe_in,
    gt3_eyescanreset_in,
    gt3_eyescantrigger_in,
    gt3_gthrxn_in,
    gt3_gthrxp_in,
    I3,
    gt3_gttxreset_in,
    gt3_rxbufreset_in,
    gt3_rxgearboxslip_in,
    gt3_rxpcsreset_in,
    gt3_rxprbscntreset_in,
    gt3_rxuserrdy_in,
    gt3_rxusrclk_in,
    gt3_rxusrclk2_in,
    gt3_txelecidle_in,
    gt3_txpcsreset_in,
    gt3_txpolarity_in,
    gt3_txprbsforceerr_in,
    gt3_txuserrdy_in,
    gt3_txusrclk_in,
    gt3_txusrclk2_in,
    gt3_drpdi_in,
    gt3_rxmonitorsel_in,
    gt3_loopback_in,
    gt3_rxprbssel_in,
    gt3_txheader_in,
    gt3_txprbssel_in,
    gt3_txdata_in,
    gt3_txsequence_in,
    gt3_drpaddr_in);
  output gt0_drprdy_out;
  output gt0_eyescandataerror_out;
  output gt0_gthtxn_out;
  output gt0_gthtxp_out;
  output gt0_rxoutclk_out;
  output GT0_RXPMARESETDONE_OUT;
  output gt0_rxprbserr_out;
  output gt0_rxresetdone_out;
  output gt0_txoutclk_out;
  output gt0_txoutclkfabric_out;
  output gt0_txoutclkpcs_out;
  output gt0_txresetdone_out;
  output [14:0]gt0_dmonitorout_out;
  output [15:0]gt0_drpdo_out;
  output gt0_rxdatavalid_out;
  output gt0_rxheadervalid_out;
  output [1:0]gt0_txbufstatus_out;
  output [2:0]gt0_rxbufstatus_out;
  output [1:0]gt0_rxheader_out;
  output [63:0]gt0_rxdata_out;
  output [6:0]gt0_rxmonitorout_out;
  output gt1_drprdy_out;
  output gt1_eyescandataerror_out;
  output gt1_gthtxn_out;
  output gt1_gthtxp_out;
  output gt1_rxoutclk_out;
  output GT1_RXPMARESETDONE_OUT;
  output gt1_rxprbserr_out;
  output gt1_rxresetdone_out;
  output gt1_txoutclk_out;
  output gt1_txoutclkfabric_out;
  output gt1_txoutclkpcs_out;
  output gt1_txresetdone_out;
  output [14:0]gt1_dmonitorout_out;
  output [15:0]gt1_drpdo_out;
  output gt1_rxdatavalid_out;
  output gt1_rxheadervalid_out;
  output [1:0]gt1_txbufstatus_out;
  output [2:0]gt1_rxbufstatus_out;
  output [1:0]gt1_rxheader_out;
  output [63:0]gt1_rxdata_out;
  output [6:0]gt1_rxmonitorout_out;
  output gt2_drprdy_out;
  output gt2_eyescandataerror_out;
  output gt2_gthtxn_out;
  output gt2_gthtxp_out;
  output gt2_rxoutclk_out;
  output GT2_RXPMARESETDONE_OUT;
  output gt2_rxprbserr_out;
  output gt2_rxresetdone_out;
  output gt2_txoutclk_out;
  output gt2_txoutclkfabric_out;
  output gt2_txoutclkpcs_out;
  output gt2_txresetdone_out;
  output [14:0]gt2_dmonitorout_out;
  output [15:0]gt2_drpdo_out;
  output gt2_rxdatavalid_out;
  output gt2_rxheadervalid_out;
  output [1:0]gt2_txbufstatus_out;
  output [2:0]gt2_rxbufstatus_out;
  output [1:0]gt2_rxheader_out;
  output [63:0]gt2_rxdata_out;
  output [6:0]gt2_rxmonitorout_out;
  output gt3_drprdy_out;
  output gt3_eyescandataerror_out;
  output gt3_gthtxn_out;
  output gt3_gthtxp_out;
  output gt3_rxoutclk_out;
  output GT3_RXPMARESETDONE_OUT;
  output gt3_rxprbserr_out;
  output gt3_rxresetdone_out;
  output gt3_txoutclk_out;
  output gt3_txoutclkfabric_out;
  output gt3_txoutclkpcs_out;
  output gt3_txresetdone_out;
  output [14:0]gt3_dmonitorout_out;
  output [15:0]gt3_drpdo_out;
  output gt3_rxdatavalid_out;
  output gt3_rxheadervalid_out;
  output [1:0]gt3_txbufstatus_out;
  output [2:0]gt3_rxbufstatus_out;
  output [1:0]gt3_rxheader_out;
  output [63:0]gt3_rxdata_out;
  output [6:0]gt3_rxmonitorout_out;
  input gt0_drpclk_in;
  input gt0_drpen_in;
  input gt0_drpwe_in;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input gt0_gthrxn_in;
  input gt0_gthrxp_in;
  input [0:0]SR;
  input gt0_gttxreset_in;
  input GT0_QPLLOUTCLK_IN;
  input GT0_QPLLOUTREFCLK_IN;
  input gt0_rxbufreset_in;
  input gt0_rxgearboxslip_in;
  input gt0_rxpcsreset_in;
  input gt0_rxprbscntreset_in;
  input gt0_rxuserrdy_in;
  input gt0_rxusrclk_in;
  input gt0_rxusrclk2_in;
  input gt0_txelecidle_in;
  input gt0_txpcsreset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input gt0_txuserrdy_in;
  input gt0_txusrclk_in;
  input gt0_txusrclk2_in;
  input [15:0]gt0_drpdi_in;
  input [1:0]gt0_rxmonitorsel_in;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [1:0]gt0_txheader_in;
  input [2:0]gt0_txprbssel_in;
  input [63:0]gt0_txdata_in;
  input [6:0]gt0_txsequence_in;
  input [8:0]gt0_drpaddr_in;
  input gt1_drpclk_in;
  input gt1_drpen_in;
  input gt1_drpwe_in;
  input gt1_eyescanreset_in;
  input gt1_eyescantrigger_in;
  input gt1_gthrxn_in;
  input gt1_gthrxp_in;
  input [0:0]I1;
  input gt1_gttxreset_in;
  input gt1_rxbufreset_in;
  input gt1_rxgearboxslip_in;
  input gt1_rxpcsreset_in;
  input gt1_rxprbscntreset_in;
  input gt1_rxuserrdy_in;
  input gt1_rxusrclk_in;
  input gt1_rxusrclk2_in;
  input gt1_txelecidle_in;
  input gt1_txpcsreset_in;
  input gt1_txpolarity_in;
  input gt1_txprbsforceerr_in;
  input gt1_txuserrdy_in;
  input gt1_txusrclk_in;
  input gt1_txusrclk2_in;
  input [15:0]gt1_drpdi_in;
  input [1:0]gt1_rxmonitorsel_in;
  input [2:0]gt1_loopback_in;
  input [2:0]gt1_rxprbssel_in;
  input [1:0]gt1_txheader_in;
  input [2:0]gt1_txprbssel_in;
  input [63:0]gt1_txdata_in;
  input [6:0]gt1_txsequence_in;
  input [8:0]gt1_drpaddr_in;
  input gt2_drpclk_in;
  input gt2_drpen_in;
  input gt2_drpwe_in;
  input gt2_eyescanreset_in;
  input gt2_eyescantrigger_in;
  input gt2_gthrxn_in;
  input gt2_gthrxp_in;
  input [0:0]I2;
  input gt2_gttxreset_in;
  input gt2_rxbufreset_in;
  input gt2_rxgearboxslip_in;
  input gt2_rxpcsreset_in;
  input gt2_rxprbscntreset_in;
  input gt2_rxuserrdy_in;
  input gt2_rxusrclk_in;
  input gt2_rxusrclk2_in;
  input gt2_txelecidle_in;
  input gt2_txpcsreset_in;
  input gt2_txpolarity_in;
  input gt2_txprbsforceerr_in;
  input gt2_txuserrdy_in;
  input gt2_txusrclk_in;
  input gt2_txusrclk2_in;
  input [15:0]gt2_drpdi_in;
  input [1:0]gt2_rxmonitorsel_in;
  input [2:0]gt2_loopback_in;
  input [2:0]gt2_rxprbssel_in;
  input [1:0]gt2_txheader_in;
  input [2:0]gt2_txprbssel_in;
  input [63:0]gt2_txdata_in;
  input [6:0]gt2_txsequence_in;
  input [8:0]gt2_drpaddr_in;
  input gt3_drpclk_in;
  input gt3_drpen_in;
  input gt3_drpwe_in;
  input gt3_eyescanreset_in;
  input gt3_eyescantrigger_in;
  input gt3_gthrxn_in;
  input gt3_gthrxp_in;
  input [0:0]I3;
  input gt3_gttxreset_in;
  input gt3_rxbufreset_in;
  input gt3_rxgearboxslip_in;
  input gt3_rxpcsreset_in;
  input gt3_rxprbscntreset_in;
  input gt3_rxuserrdy_in;
  input gt3_rxusrclk_in;
  input gt3_rxusrclk2_in;
  input gt3_txelecidle_in;
  input gt3_txpcsreset_in;
  input gt3_txpolarity_in;
  input gt3_txprbsforceerr_in;
  input gt3_txuserrdy_in;
  input gt3_txusrclk_in;
  input gt3_txusrclk2_in;
  input [15:0]gt3_drpdi_in;
  input [1:0]gt3_rxmonitorsel_in;
  input [2:0]gt3_loopback_in;
  input [2:0]gt3_rxprbssel_in;
  input [1:0]gt3_txheader_in;
  input [2:0]gt3_txprbssel_in;
  input [63:0]gt3_txdata_in;
  input [6:0]gt3_txsequence_in;
  input [8:0]gt3_drpaddr_in;

  wire GT0_QPLLOUTCLK_IN;
  wire GT0_QPLLOUTREFCLK_IN;
  wire GT0_RXPMARESETDONE_OUT;
  wire GT1_RXPMARESETDONE_OUT;
  wire GT2_RXPMARESETDONE_OUT;
  wire GT3_RXPMARESETDONE_OUT;
  wire [0:0]I1;
  wire [0:0]I2;
  wire [0:0]I3;
  wire [0:0]SR;
  wire [14:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drprdy_out;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire gt0_gthrxn_in;
  wire gt0_gthrxp_in;
  wire gt0_gthtxn_out;
  wire gt0_gthtxp_out;
  wire gt0_gttxreset_in;
  wire [2:0]gt0_loopback_in;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire [63:0]gt0_rxdata_out;
  wire gt0_rxdatavalid_out;
  wire gt0_rxgearboxslip_in;
  wire [1:0]gt0_rxheader_out;
  wire gt0_rxheadervalid_out;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire gt0_rxoutclk_out;
  wire gt0_rxpcsreset_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire gt0_rxresetdone_out;
  wire gt0_rxuserrdy_in;
  wire gt0_rxusrclk2_in;
  wire gt0_rxusrclk_in;
  wire [1:0]gt0_txbufstatus_out;
  wire [63:0]gt0_txdata_in;
  wire gt0_txelecidle_in;
  wire [1:0]gt0_txheader_in;
  wire gt0_txoutclk_out;
  wire gt0_txoutclkfabric_out;
  wire gt0_txoutclkpcs_out;
  wire gt0_txpcsreset_in;
  wire gt0_txpolarity_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire gt0_txresetdone_out;
  wire [6:0]gt0_txsequence_in;
  wire gt0_txuserrdy_in;
  wire gt0_txusrclk2_in;
  wire gt0_txusrclk_in;
  wire [14:0]gt1_dmonitorout_out;
  wire [8:0]gt1_drpaddr_in;
  wire gt1_drpclk_in;
  wire [15:0]gt1_drpdi_in;
  wire [15:0]gt1_drpdo_out;
  wire gt1_drpen_in;
  wire gt1_drprdy_out;
  wire gt1_drpwe_in;
  wire gt1_eyescandataerror_out;
  wire gt1_eyescanreset_in;
  wire gt1_eyescantrigger_in;
  wire gt1_gthrxn_in;
  wire gt1_gthrxp_in;
  wire gt1_gthtxn_out;
  wire gt1_gthtxp_out;
  wire gt1_gttxreset_in;
  wire [2:0]gt1_loopback_in;
  wire gt1_rxbufreset_in;
  wire [2:0]gt1_rxbufstatus_out;
  wire [63:0]gt1_rxdata_out;
  wire gt1_rxdatavalid_out;
  wire gt1_rxgearboxslip_in;
  wire [1:0]gt1_rxheader_out;
  wire gt1_rxheadervalid_out;
  wire [6:0]gt1_rxmonitorout_out;
  wire [1:0]gt1_rxmonitorsel_in;
  wire gt1_rxoutclk_out;
  wire gt1_rxpcsreset_in;
  wire gt1_rxprbscntreset_in;
  wire gt1_rxprbserr_out;
  wire [2:0]gt1_rxprbssel_in;
  wire gt1_rxresetdone_out;
  wire gt1_rxuserrdy_in;
  wire gt1_rxusrclk2_in;
  wire gt1_rxusrclk_in;
  wire [1:0]gt1_txbufstatus_out;
  wire [63:0]gt1_txdata_in;
  wire gt1_txelecidle_in;
  wire [1:0]gt1_txheader_in;
  wire gt1_txoutclk_out;
  wire gt1_txoutclkfabric_out;
  wire gt1_txoutclkpcs_out;
  wire gt1_txpcsreset_in;
  wire gt1_txpolarity_in;
  wire gt1_txprbsforceerr_in;
  wire [2:0]gt1_txprbssel_in;
  wire gt1_txresetdone_out;
  wire [6:0]gt1_txsequence_in;
  wire gt1_txuserrdy_in;
  wire gt1_txusrclk2_in;
  wire gt1_txusrclk_in;
  wire [14:0]gt2_dmonitorout_out;
  wire [8:0]gt2_drpaddr_in;
  wire gt2_drpclk_in;
  wire [15:0]gt2_drpdi_in;
  wire [15:0]gt2_drpdo_out;
  wire gt2_drpen_in;
  wire gt2_drprdy_out;
  wire gt2_drpwe_in;
  wire gt2_eyescandataerror_out;
  wire gt2_eyescanreset_in;
  wire gt2_eyescantrigger_in;
  wire gt2_gthrxn_in;
  wire gt2_gthrxp_in;
  wire gt2_gthtxn_out;
  wire gt2_gthtxp_out;
  wire gt2_gttxreset_in;
  wire [2:0]gt2_loopback_in;
  wire gt2_rxbufreset_in;
  wire [2:0]gt2_rxbufstatus_out;
  wire [63:0]gt2_rxdata_out;
  wire gt2_rxdatavalid_out;
  wire gt2_rxgearboxslip_in;
  wire [1:0]gt2_rxheader_out;
  wire gt2_rxheadervalid_out;
  wire [6:0]gt2_rxmonitorout_out;
  wire [1:0]gt2_rxmonitorsel_in;
  wire gt2_rxoutclk_out;
  wire gt2_rxpcsreset_in;
  wire gt2_rxprbscntreset_in;
  wire gt2_rxprbserr_out;
  wire [2:0]gt2_rxprbssel_in;
  wire gt2_rxresetdone_out;
  wire gt2_rxuserrdy_in;
  wire gt2_rxusrclk2_in;
  wire gt2_rxusrclk_in;
  wire [1:0]gt2_txbufstatus_out;
  wire [63:0]gt2_txdata_in;
  wire gt2_txelecidle_in;
  wire [1:0]gt2_txheader_in;
  wire gt2_txoutclk_out;
  wire gt2_txoutclkfabric_out;
  wire gt2_txoutclkpcs_out;
  wire gt2_txpcsreset_in;
  wire gt2_txpolarity_in;
  wire gt2_txprbsforceerr_in;
  wire [2:0]gt2_txprbssel_in;
  wire gt2_txresetdone_out;
  wire [6:0]gt2_txsequence_in;
  wire gt2_txuserrdy_in;
  wire gt2_txusrclk2_in;
  wire gt2_txusrclk_in;
  wire [14:0]gt3_dmonitorout_out;
  wire [8:0]gt3_drpaddr_in;
  wire gt3_drpclk_in;
  wire [15:0]gt3_drpdi_in;
  wire [15:0]gt3_drpdo_out;
  wire gt3_drpen_in;
  wire gt3_drprdy_out;
  wire gt3_drpwe_in;
  wire gt3_eyescandataerror_out;
  wire gt3_eyescanreset_in;
  wire gt3_eyescantrigger_in;
  wire gt3_gthrxn_in;
  wire gt3_gthrxp_in;
  wire gt3_gthtxn_out;
  wire gt3_gthtxp_out;
  wire gt3_gttxreset_in;
  wire [2:0]gt3_loopback_in;
  wire gt3_rxbufreset_in;
  wire [2:0]gt3_rxbufstatus_out;
  wire [63:0]gt3_rxdata_out;
  wire gt3_rxdatavalid_out;
  wire gt3_rxgearboxslip_in;
  wire [1:0]gt3_rxheader_out;
  wire gt3_rxheadervalid_out;
  wire [6:0]gt3_rxmonitorout_out;
  wire [1:0]gt3_rxmonitorsel_in;
  wire gt3_rxoutclk_out;
  wire gt3_rxpcsreset_in;
  wire gt3_rxprbscntreset_in;
  wire gt3_rxprbserr_out;
  wire [2:0]gt3_rxprbssel_in;
  wire gt3_rxresetdone_out;
  wire gt3_rxuserrdy_in;
  wire gt3_rxusrclk2_in;
  wire gt3_rxusrclk_in;
  wire [1:0]gt3_txbufstatus_out;
  wire [63:0]gt3_txdata_in;
  wire gt3_txelecidle_in;
  wire [1:0]gt3_txheader_in;
  wire gt3_txoutclk_out;
  wire gt3_txoutclkfabric_out;
  wire gt3_txoutclkpcs_out;
  wire gt3_txpcsreset_in;
  wire gt3_txpolarity_in;
  wire gt3_txprbsforceerr_in;
  wire [2:0]gt3_txprbssel_in;
  wire gt3_txresetdone_out;
  wire [6:0]gt3_txsequence_in;
  wire gt3_txuserrdy_in;
  wire gt3_txusrclk2_in;
  wire gt3_txusrclk_in;

XLAUI_XLAUI_GT__parameterized0 gt0_XLAUI_i
       (.GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT0_RXPMARESETDONE_OUT(GT0_RXPMARESETDONE_OUT),
        .SR(SR),
        .gt0_dmonitorout_out(gt0_dmonitorout_out),
        .gt0_drpaddr_in(gt0_drpaddr_in),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdi_in(gt0_drpdi_in),
        .gt0_drpdo_out(gt0_drpdo_out),
        .gt0_drpen_in(gt0_drpen_in),
        .gt0_drprdy_out(gt0_drprdy_out),
        .gt0_drpwe_in(gt0_drpwe_in),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_gthrxn_in(gt0_gthrxn_in),
        .gt0_gthrxp_in(gt0_gthrxp_in),
        .gt0_gthtxn_out(gt0_gthtxn_out),
        .gt0_gthtxp_out(gt0_gthtxp_out),
        .gt0_gttxreset_in(gt0_gttxreset_in),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_rxbufreset_in(gt0_rxbufreset_in),
        .gt0_rxbufstatus_out(gt0_rxbufstatus_out),
        .gt0_rxdata_out(gt0_rxdata_out),
        .gt0_rxdatavalid_out(gt0_rxdatavalid_out),
        .gt0_rxgearboxslip_in(gt0_rxgearboxslip_in),
        .gt0_rxheader_out(gt0_rxheader_out),
        .gt0_rxheadervalid_out(gt0_rxheadervalid_out),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxoutclk_out(gt0_rxoutclk_out),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_rxresetdone_out(gt0_rxresetdone_out),
        .gt0_rxuserrdy_in(gt0_rxuserrdy_in),
        .gt0_rxusrclk2_in(gt0_rxusrclk2_in),
        .gt0_rxusrclk_in(gt0_rxusrclk_in),
        .gt0_txbufstatus_out(gt0_txbufstatus_out),
        .gt0_txdata_in(gt0_txdata_in),
        .gt0_txelecidle_in(gt0_txelecidle_in),
        .gt0_txheader_in(gt0_txheader_in),
        .gt0_txoutclk_out(gt0_txoutclk_out),
        .gt0_txoutclkfabric_out(gt0_txoutclkfabric_out),
        .gt0_txoutclkpcs_out(gt0_txoutclkpcs_out),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txresetdone_out(gt0_txresetdone_out),
        .gt0_txsequence_in(gt0_txsequence_in),
        .gt0_txuserrdy_in(gt0_txuserrdy_in),
        .gt0_txusrclk2_in(gt0_txusrclk2_in),
        .gt0_txusrclk_in(gt0_txusrclk_in));
XLAUI_XLAUI_GT__parameterized0_65 gt1_XLAUI_i
       (.GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT1_RXPMARESETDONE_OUT(GT1_RXPMARESETDONE_OUT),
        .I1(I1),
        .gt1_dmonitorout_out(gt1_dmonitorout_out),
        .gt1_drpaddr_in(gt1_drpaddr_in),
        .gt1_drpclk_in(gt1_drpclk_in),
        .gt1_drpdi_in(gt1_drpdi_in),
        .gt1_drpdo_out(gt1_drpdo_out),
        .gt1_drpen_in(gt1_drpen_in),
        .gt1_drprdy_out(gt1_drprdy_out),
        .gt1_drpwe_in(gt1_drpwe_in),
        .gt1_eyescandataerror_out(gt1_eyescandataerror_out),
        .gt1_eyescanreset_in(gt1_eyescanreset_in),
        .gt1_eyescantrigger_in(gt1_eyescantrigger_in),
        .gt1_gthrxn_in(gt1_gthrxn_in),
        .gt1_gthrxp_in(gt1_gthrxp_in),
        .gt1_gthtxn_out(gt1_gthtxn_out),
        .gt1_gthtxp_out(gt1_gthtxp_out),
        .gt1_gttxreset_in(gt1_gttxreset_in),
        .gt1_loopback_in(gt1_loopback_in),
        .gt1_rxbufreset_in(gt1_rxbufreset_in),
        .gt1_rxbufstatus_out(gt1_rxbufstatus_out),
        .gt1_rxdata_out(gt1_rxdata_out),
        .gt1_rxdatavalid_out(gt1_rxdatavalid_out),
        .gt1_rxgearboxslip_in(gt1_rxgearboxslip_in),
        .gt1_rxheader_out(gt1_rxheader_out),
        .gt1_rxheadervalid_out(gt1_rxheadervalid_out),
        .gt1_rxmonitorout_out(gt1_rxmonitorout_out),
        .gt1_rxmonitorsel_in(gt1_rxmonitorsel_in),
        .gt1_rxoutclk_out(gt1_rxoutclk_out),
        .gt1_rxpcsreset_in(gt1_rxpcsreset_in),
        .gt1_rxprbscntreset_in(gt1_rxprbscntreset_in),
        .gt1_rxprbserr_out(gt1_rxprbserr_out),
        .gt1_rxprbssel_in(gt1_rxprbssel_in),
        .gt1_rxresetdone_out(gt1_rxresetdone_out),
        .gt1_rxuserrdy_in(gt1_rxuserrdy_in),
        .gt1_rxusrclk2_in(gt1_rxusrclk2_in),
        .gt1_rxusrclk_in(gt1_rxusrclk_in),
        .gt1_txbufstatus_out(gt1_txbufstatus_out),
        .gt1_txdata_in(gt1_txdata_in),
        .gt1_txelecidle_in(gt1_txelecidle_in),
        .gt1_txheader_in(gt1_txheader_in),
        .gt1_txoutclk_out(gt1_txoutclk_out),
        .gt1_txoutclkfabric_out(gt1_txoutclkfabric_out),
        .gt1_txoutclkpcs_out(gt1_txoutclkpcs_out),
        .gt1_txpcsreset_in(gt1_txpcsreset_in),
        .gt1_txpolarity_in(gt1_txpolarity_in),
        .gt1_txprbsforceerr_in(gt1_txprbsforceerr_in),
        .gt1_txprbssel_in(gt1_txprbssel_in),
        .gt1_txresetdone_out(gt1_txresetdone_out),
        .gt1_txsequence_in(gt1_txsequence_in),
        .gt1_txuserrdy_in(gt1_txuserrdy_in),
        .gt1_txusrclk2_in(gt1_txusrclk2_in),
        .gt1_txusrclk_in(gt1_txusrclk_in));
XLAUI_XLAUI_GT__parameterized0_66 gt2_XLAUI_i
       (.GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT2_RXPMARESETDONE_OUT(GT2_RXPMARESETDONE_OUT),
        .I2(I2),
        .gt2_dmonitorout_out(gt2_dmonitorout_out),
        .gt2_drpaddr_in(gt2_drpaddr_in),
        .gt2_drpclk_in(gt2_drpclk_in),
        .gt2_drpdi_in(gt2_drpdi_in),
        .gt2_drpdo_out(gt2_drpdo_out),
        .gt2_drpen_in(gt2_drpen_in),
        .gt2_drprdy_out(gt2_drprdy_out),
        .gt2_drpwe_in(gt2_drpwe_in),
        .gt2_eyescandataerror_out(gt2_eyescandataerror_out),
        .gt2_eyescanreset_in(gt2_eyescanreset_in),
        .gt2_eyescantrigger_in(gt2_eyescantrigger_in),
        .gt2_gthrxn_in(gt2_gthrxn_in),
        .gt2_gthrxp_in(gt2_gthrxp_in),
        .gt2_gthtxn_out(gt2_gthtxn_out),
        .gt2_gthtxp_out(gt2_gthtxp_out),
        .gt2_gttxreset_in(gt2_gttxreset_in),
        .gt2_loopback_in(gt2_loopback_in),
        .gt2_rxbufreset_in(gt2_rxbufreset_in),
        .gt2_rxbufstatus_out(gt2_rxbufstatus_out),
        .gt2_rxdata_out(gt2_rxdata_out),
        .gt2_rxdatavalid_out(gt2_rxdatavalid_out),
        .gt2_rxgearboxslip_in(gt2_rxgearboxslip_in),
        .gt2_rxheader_out(gt2_rxheader_out),
        .gt2_rxheadervalid_out(gt2_rxheadervalid_out),
        .gt2_rxmonitorout_out(gt2_rxmonitorout_out),
        .gt2_rxmonitorsel_in(gt2_rxmonitorsel_in),
        .gt2_rxoutclk_out(gt2_rxoutclk_out),
        .gt2_rxpcsreset_in(gt2_rxpcsreset_in),
        .gt2_rxprbscntreset_in(gt2_rxprbscntreset_in),
        .gt2_rxprbserr_out(gt2_rxprbserr_out),
        .gt2_rxprbssel_in(gt2_rxprbssel_in),
        .gt2_rxresetdone_out(gt2_rxresetdone_out),
        .gt2_rxuserrdy_in(gt2_rxuserrdy_in),
        .gt2_rxusrclk2_in(gt2_rxusrclk2_in),
        .gt2_rxusrclk_in(gt2_rxusrclk_in),
        .gt2_txbufstatus_out(gt2_txbufstatus_out),
        .gt2_txdata_in(gt2_txdata_in),
        .gt2_txelecidle_in(gt2_txelecidle_in),
        .gt2_txheader_in(gt2_txheader_in),
        .gt2_txoutclk_out(gt2_txoutclk_out),
        .gt2_txoutclkfabric_out(gt2_txoutclkfabric_out),
        .gt2_txoutclkpcs_out(gt2_txoutclkpcs_out),
        .gt2_txpcsreset_in(gt2_txpcsreset_in),
        .gt2_txpolarity_in(gt2_txpolarity_in),
        .gt2_txprbsforceerr_in(gt2_txprbsforceerr_in),
        .gt2_txprbssel_in(gt2_txprbssel_in),
        .gt2_txresetdone_out(gt2_txresetdone_out),
        .gt2_txsequence_in(gt2_txsequence_in),
        .gt2_txuserrdy_in(gt2_txuserrdy_in),
        .gt2_txusrclk2_in(gt2_txusrclk2_in),
        .gt2_txusrclk_in(gt2_txusrclk_in));
XLAUI_XLAUI_GT__parameterized0_67 gt3_XLAUI_i
       (.GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT3_RXPMARESETDONE_OUT(GT3_RXPMARESETDONE_OUT),
        .I3(I3),
        .gt3_dmonitorout_out(gt3_dmonitorout_out),
        .gt3_drpaddr_in(gt3_drpaddr_in),
        .gt3_drpclk_in(gt3_drpclk_in),
        .gt3_drpdi_in(gt3_drpdi_in),
        .gt3_drpdo_out(gt3_drpdo_out),
        .gt3_drpen_in(gt3_drpen_in),
        .gt3_drprdy_out(gt3_drprdy_out),
        .gt3_drpwe_in(gt3_drpwe_in),
        .gt3_eyescandataerror_out(gt3_eyescandataerror_out),
        .gt3_eyescanreset_in(gt3_eyescanreset_in),
        .gt3_eyescantrigger_in(gt3_eyescantrigger_in),
        .gt3_gthrxn_in(gt3_gthrxn_in),
        .gt3_gthrxp_in(gt3_gthrxp_in),
        .gt3_gthtxn_out(gt3_gthtxn_out),
        .gt3_gthtxp_out(gt3_gthtxp_out),
        .gt3_gttxreset_in(gt3_gttxreset_in),
        .gt3_loopback_in(gt3_loopback_in),
        .gt3_rxbufreset_in(gt3_rxbufreset_in),
        .gt3_rxbufstatus_out(gt3_rxbufstatus_out),
        .gt3_rxdata_out(gt3_rxdata_out),
        .gt3_rxdatavalid_out(gt3_rxdatavalid_out),
        .gt3_rxgearboxslip_in(gt3_rxgearboxslip_in),
        .gt3_rxheader_out(gt3_rxheader_out),
        .gt3_rxheadervalid_out(gt3_rxheadervalid_out),
        .gt3_rxmonitorout_out(gt3_rxmonitorout_out),
        .gt3_rxmonitorsel_in(gt3_rxmonitorsel_in),
        .gt3_rxoutclk_out(gt3_rxoutclk_out),
        .gt3_rxpcsreset_in(gt3_rxpcsreset_in),
        .gt3_rxprbscntreset_in(gt3_rxprbscntreset_in),
        .gt3_rxprbserr_out(gt3_rxprbserr_out),
        .gt3_rxprbssel_in(gt3_rxprbssel_in),
        .gt3_rxresetdone_out(gt3_rxresetdone_out),
        .gt3_rxuserrdy_in(gt3_rxuserrdy_in),
        .gt3_rxusrclk2_in(gt3_rxusrclk2_in),
        .gt3_rxusrclk_in(gt3_rxusrclk_in),
        .gt3_txbufstatus_out(gt3_txbufstatus_out),
        .gt3_txdata_in(gt3_txdata_in),
        .gt3_txelecidle_in(gt3_txelecidle_in),
        .gt3_txheader_in(gt3_txheader_in),
        .gt3_txoutclk_out(gt3_txoutclk_out),
        .gt3_txoutclkfabric_out(gt3_txoutclkfabric_out),
        .gt3_txoutclkpcs_out(gt3_txoutclkpcs_out),
        .gt3_txpcsreset_in(gt3_txpcsreset_in),
        .gt3_txpolarity_in(gt3_txpolarity_in),
        .gt3_txprbsforceerr_in(gt3_txprbsforceerr_in),
        .gt3_txprbssel_in(gt3_txprbssel_in),
        .gt3_txresetdone_out(gt3_txresetdone_out),
        .gt3_txsequence_in(gt3_txsequence_in),
        .gt3_txuserrdy_in(gt3_txuserrdy_in),
        .gt3_txusrclk2_in(gt3_txusrclk2_in),
        .gt3_txusrclk_in(gt3_txusrclk_in));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0
   (O1,
    E,
    out,
    I1,
    I2,
    I3,
    wait_time_done,
    txresetdone_s3,
    I4,
    I5,
    mmcm_lock_reclocked,
    I6,
    I7,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output O1;
  output [0:0]E;
  input [3:0]out;
  input I1;
  input I2;
  input I3;
  input wait_time_done;
  input txresetdone_s3;
  input I4;
  input I5;
  input mmcm_lock_reclocked;
  input I6;
  input I7;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire [0:0]E;
  wire GT0_QPLLLOCK_IN;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire O1;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_tx_state[3]_i_7__2 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_8__2 ;
  wire \n_0_FSM_sequential_tx_state_reg[3]_i_3__2 ;
  wire n_0_reset_time_out_i_2__2;
  wire n_0_reset_time_out_i_3__2;
  wire [3:0]out;
  wire qplllock_sync;
  wire txresetdone_s3;
  wire wait_time_done;

LUT6 #(
    .INIT(64'h4F4AEFEF4F4AEAEA)) 
     \FSM_sequential_tx_state[3]_i_1__2 
       (.I0(out[3]),
        .I1(\n_0_FSM_sequential_tx_state_reg[3]_i_3__2 ),
        .I2(out[0]),
        .I3(I1),
        .I4(I3),
        .I5(wait_time_done),
        .O(E));
LUT6 #(
    .INIT(64'hBA00BA00BAFFBA00)) 
     \FSM_sequential_tx_state[3]_i_7__2 
       (.I0(mmcm_lock_reclocked),
        .I1(I2),
        .I2(I6),
        .I3(out[2]),
        .I4(I7),
        .I5(qplllock_sync),
        .O(\n_0_FSM_sequential_tx_state[3]_i_7__2 ));
LUT6 #(
    .INIT(64'hBAFFBAFFBAFFBA00)) 
     \FSM_sequential_tx_state[3]_i_8__2 
       (.I0(txresetdone_s3),
        .I1(I2),
        .I2(I4),
        .I3(out[2]),
        .I4(I5),
        .I5(qplllock_sync),
        .O(\n_0_FSM_sequential_tx_state[3]_i_8__2 ));
MUXF7 \FSM_sequential_tx_state_reg[3]_i_3__2 
       (.I0(\n_0_FSM_sequential_tx_state[3]_i_7__2 ),
        .I1(\n_0_FSM_sequential_tx_state[3]_i_8__2 ),
        .O(\n_0_FSM_sequential_tx_state_reg[3]_i_3__2 ),
        .S(out[1]));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_QPLLLOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(qplllock_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'hD0C0FFFFD0C00000)) 
     reset_time_out_i_1__2
       (.I0(out[3]),
        .I1(out[0]),
        .I2(n_0_reset_time_out_i_2__2),
        .I3(I1),
        .I4(n_0_reset_time_out_i_3__2),
        .I5(I2),
        .O(O1));
LUT5 #(
    .INIT(32'hCFC0AFAF)) 
     reset_time_out_i_2__2
       (.I0(qplllock_sync),
        .I1(txresetdone_s3),
        .I2(out[1]),
        .I3(mmcm_lock_reclocked),
        .I4(out[2]),
        .O(n_0_reset_time_out_i_2__2));
LUT6 #(
    .INIT(64'h505040FF505040FA)) 
     reset_time_out_i_3__2
       (.I0(out[3]),
        .I1(qplllock_sync),
        .I2(out[0]),
        .I3(out[1]),
        .I4(out[2]),
        .I5(I1),
        .O(n_0_reset_time_out_i_3__2));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_10
   (data_out,
    GT3_TX_FSM_RESET_DONE_OUT,
    gt3_txusrclk_in);
  output data_out;
  input GT3_TX_FSM_RESET_DONE_OUT;
  input gt3_txusrclk_in;

  wire GT3_TX_FSM_RESET_DONE_OUT;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_txusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(GT3_TX_FSM_RESET_DONE_OUT),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_11
   (O1,
    O2,
    out,
    I1,
    I2,
    I3,
    I4,
    rxresetdone_s3,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output O1;
  output O2;
  input [2:0]out;
  input I1;
  input I2;
  input I3;
  input I4;
  input rxresetdone_s3;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire GT0_QPLLLOCK_IN;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \n_0_FSM_sequential_rx_state[3]_i_9__2 ;
  wire [2:0]out;
  wire qplllock_sync;
  wire rxresetdone_s3;

LUT6 #(
    .INIT(64'hAA08FFFFAA080000)) 
     \FSM_sequential_rx_state[3]_i_5__2 
       (.I0(out[0]),
        .I1(I4),
        .I2(I3),
        .I3(rxresetdone_s3),
        .I4(out[1]),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_9__2 ),
        .O(O2));
LUT4 #(
    .INIT(16'h5455)) 
     \FSM_sequential_rx_state[3]_i_9__2 
       (.I0(out[2]),
        .I1(qplllock_sync),
        .I2(I4),
        .I3(out[0]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_9__2 ));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_QPLLLOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(qplllock_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFF10FFFFFF100000)) 
     reset_time_out_i_1__6
       (.I0(out[2]),
        .I1(out[1]),
        .I2(qplllock_sync),
        .I3(I1),
        .I4(I2),
        .I5(I3),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_12
   (data_out,
    gt3_rxresetdone_out,
    SYSCLK_IN);
  output data_out;
  input gt3_rxresetdone_out;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_rxresetdone_out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rxresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_13
   (O1,
    D,
    E,
    O2,
    I1,
    I2,
    DONT_RESET_ON_DATA_ERROR_IN,
    out,
    GT3_RX_FSM_RESET_DONE_OUT,
    I3,
    I4,
    I5,
    I6,
    I7,
    rx_state16_out,
    mmcm_lock_reclocked,
    rxresetdone_s3,
    I8,
    time_out_wait_bypass_s3,
    I9,
    GT3_DATA_VALID_IN,
    SYSCLK_IN);
  output O1;
  output [2:0]D;
  output [0:0]E;
  output O2;
  input I1;
  input I2;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input [3:0]out;
  input GT3_RX_FSM_RESET_DONE_OUT;
  input I3;
  input I4;
  input I5;
  input I6;
  input I7;
  input rx_state16_out;
  input mmcm_lock_reclocked;
  input rxresetdone_s3;
  input I8;
  input time_out_wait_bypass_s3;
  input I9;
  input GT3_DATA_VALID_IN;
  input SYSCLK_IN;

  wire [2:0]D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire [0:0]E;
  wire GT3_DATA_VALID_IN;
  wire GT3_RX_FSM_RESET_DONE_OUT;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire data_valid_sync;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_rx_state[3]_i_3__2 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_6__2 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_7__2 ;
  wire n_0_reset_time_out_i_4__2;
  wire n_0_rx_fsm_reset_done_int_i_3__2;
  wire [3:0]out;
  wire rx_fsm_reset_done_int;
  wire rx_state1;
  wire rx_state16_out;
  wire rxresetdone_s3;
  wire time_out_wait_bypass_s3;

LUT6 #(
    .INIT(64'h0C0C5DFD0C0C5D5D)) 
     \FSM_sequential_rx_state[0]_i_1__2 
       (.I0(out[0]),
        .I1(I4),
        .I2(out[3]),
        .I3(out[1]),
        .I4(out[2]),
        .I5(rx_state1),
        .O(D[0]));
LUT6 #(
    .INIT(64'h0000050000FF7700)) 
     \FSM_sequential_rx_state[1]_i_1__2 
       (.I0(out[2]),
        .I1(rx_state16_out),
        .I2(rx_state1),
        .I3(out[0]),
        .I4(out[1]),
        .I5(out[3]),
        .O(D[1]));
LUT4 #(
    .INIT(16'h0004)) 
     \FSM_sequential_rx_state[1]_i_2__2 
       (.I0(I1),
        .I1(I2),
        .I2(DONT_RESET_ON_DATA_ERROR_IN),
        .I3(data_valid_sync),
        .O(rx_state1));
LUT5 #(
    .INIT(32'hFEFEFEAE)) 
     \FSM_sequential_rx_state[3]_i_1__2 
       (.I0(\n_0_FSM_sequential_rx_state[3]_i_3__2 ),
        .I1(I5),
        .I2(out[0]),
        .I3(I6),
        .I4(\n_0_FSM_sequential_rx_state[3]_i_6__2 ),
        .O(E));
LUT6 #(
    .INIT(64'h55AA00A2000000A2)) 
     \FSM_sequential_rx_state[3]_i_2__2 
       (.I0(out[3]),
        .I1(time_out_wait_bypass_s3),
        .I2(out[1]),
        .I3(out[2]),
        .I4(out[0]),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_7__2 ),
        .O(D[2]));
LUT5 #(
    .INIT(32'hCCCC4430)) 
     \FSM_sequential_rx_state[3]_i_3__2 
       (.I0(data_valid_sync),
        .I1(out[3]),
        .I2(I7),
        .I3(out[1]),
        .I4(out[2]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_3__2 ));
LUT6 #(
    .INIT(64'hF0F0F0F0EFEFEFE0)) 
     \FSM_sequential_rx_state[3]_i_6__2 
       (.I0(rx_state1),
        .I1(data_valid_sync),
        .I2(out[3]),
        .I3(rx_state16_out),
        .I4(mmcm_lock_reclocked),
        .I5(out[1]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_6__2 ));
LUT5 #(
    .INIT(32'hB0B0000F)) 
     \FSM_sequential_rx_state[3]_i_7__2 
       (.I0(I1),
        .I1(I9),
        .I2(out[1]),
        .I3(rx_state1),
        .I4(out[2]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_7__2 ));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT3_DATA_VALID_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_valid_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'h8F88FFFF8F880000)) 
     reset_time_out_i_2__6
       (.I0(rxresetdone_s3),
        .I1(out[2]),
        .I2(data_valid_sync),
        .I3(out[3]),
        .I4(out[1]),
        .I5(n_0_reset_time_out_i_4__2),
        .O(O2));
LUT6 #(
    .INIT(64'hFFF3DDF333F311F3)) 
     reset_time_out_i_4__2
       (.I0(out[3]),
        .I1(out[2]),
        .I2(I8),
        .I3(out[0]),
        .I4(data_valid_sync),
        .I5(mmcm_lock_reclocked),
        .O(n_0_reset_time_out_i_4__2));
LUT5 #(
    .INIT(32'hEFFF2000)) 
     rx_fsm_reset_done_int_i_1__2
       (.I0(rx_fsm_reset_done_int),
        .I1(out[2]),
        .I2(out[3]),
        .I3(n_0_rx_fsm_reset_done_int_i_3__2),
        .I4(GT3_RX_FSM_RESET_DONE_OUT),
        .O(O1));
LUT4 #(
    .INIT(16'h0080)) 
     rx_fsm_reset_done_int_i_2__2
       (.I0(out[1]),
        .I1(data_valid_sync),
        .I2(I3),
        .I3(I1),
        .O(rx_fsm_reset_done_int));
LUT6 #(
    .INIT(64'h0C380C383C380C38)) 
     rx_fsm_reset_done_int_i_3__2
       (.I0(rx_state1),
        .I1(out[0]),
        .I2(out[1]),
        .I3(data_valid_sync),
        .I4(I3),
        .I5(I1),
        .O(n_0_rx_fsm_reset_done_int_i_3__2));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_14
   (SR,
    O1,
    mmcm_lock_reclocked,
    Q,
    I1,
    GT3_RX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output O1;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input I1;
  input GT3_RX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT3_RX_MMCM_LOCK_IN;
  wire I1;
  wire O1;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT3_RX_MMCM_LOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(mmcm_lock_i),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair71" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[7]_i_1__6 
       (.I0(mmcm_lock_i),
        .O(SR));
(* SOFT_HLUTNM = "soft_lutpair71" *) 
   LUT5 #(
    .INIT(32'hEAAA0000)) 
     mmcm_lock_reclocked_i_1__6
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(I1),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_15
   (data_out,
    data_in,
    gt3_rxusrclk_in);
  output data_out;
  input data_in;
  input gt3_rxusrclk_in;

  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_rxusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_16
   (data_out,
    GT3_RX_FSM_RESET_DONE_OUT,
    gt3_rxusrclk_in);
  output data_out;
  input GT3_RX_FSM_RESET_DONE_OUT;
  input gt3_rxusrclk_in;

  wire GT3_RX_FSM_RESET_DONE_OUT;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_rxusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(GT3_RX_FSM_RESET_DONE_OUT),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_17
   (O1,
    O2,
    out,
    GT3_RX_MMCM_RESET_OUT,
    I1,
    mmcm_lock_reclocked,
    data_in,
    SYSCLK_IN);
  output O1;
  output O2;
  input [3:0]out;
  input GT3_RX_MMCM_RESET_OUT;
  input I1;
  input mmcm_lock_reclocked;
  input data_in;
  input SYSCLK_IN;

  wire GT3_RX_MMCM_RESET_OUT;
  wire I1;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_reclocked;
  wire n_0_reset_time_out_i_5__2;
  wire [3:0]out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
LUT6 #(
    .INIT(64'hEFFFFFFF00100010)) 
     mmcm_reset_i_i_1__2
       (.I0(out[3]),
        .I1(out[1]),
        .I2(out[0]),
        .I3(out[2]),
        .I4(data_out),
        .I5(GT3_RX_MMCM_RESET_OUT),
        .O(O1));
LUT6 #(
    .INIT(64'h8888BBBB88B88888)) 
     reset_time_out_i_3__6
       (.I0(n_0_reset_time_out_i_5__2),
        .I1(out[0]),
        .I2(I1),
        .I3(out[1]),
        .I4(out[2]),
        .I5(out[3]),
        .O(O2));
LUT5 #(
    .INIT(32'h1111FFFD)) 
     reset_time_out_i_5__2
       (.I0(out[2]),
        .I1(out[1]),
        .I2(data_out),
        .I3(mmcm_lock_reclocked),
        .I4(out[3]),
        .O(n_0_reset_time_out_i_5__2));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_18
   (data_out,
    data_in,
    RXOUTCLK);
  output data_out;
  input data_in;
  input RXOUTCLK;

  wire RXOUTCLK;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_19
   (data_out,
    data_in,
    SYSCLK_IN);
  output data_out;
  input data_in;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_20
   (O1,
    E,
    out,
    I1,
    I2,
    I3,
    wait_time_done,
    txresetdone_s3,
    I4,
    I5,
    mmcm_lock_reclocked,
    I6,
    I7,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output O1;
  output [0:0]E;
  input [3:0]out;
  input I1;
  input I2;
  input I3;
  input wait_time_done;
  input txresetdone_s3;
  input I4;
  input I5;
  input mmcm_lock_reclocked;
  input I6;
  input I7;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire [0:0]E;
  wire GT0_QPLLLOCK_IN;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire O1;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_tx_state[3]_i_7__1 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_8__1 ;
  wire \n_0_FSM_sequential_tx_state_reg[3]_i_3__1 ;
  wire n_0_reset_time_out_i_2__1;
  wire n_0_reset_time_out_i_3__1;
  wire [3:0]out;
  wire qplllock_sync;
  wire txresetdone_s3;
  wire wait_time_done;

LUT6 #(
    .INIT(64'h4F4AEFEF4F4AEAEA)) 
     \FSM_sequential_tx_state[3]_i_1__1 
       (.I0(out[3]),
        .I1(\n_0_FSM_sequential_tx_state_reg[3]_i_3__1 ),
        .I2(out[0]),
        .I3(I1),
        .I4(I3),
        .I5(wait_time_done),
        .O(E));
LUT6 #(
    .INIT(64'hBA00BA00BAFFBA00)) 
     \FSM_sequential_tx_state[3]_i_7__1 
       (.I0(mmcm_lock_reclocked),
        .I1(I2),
        .I2(I6),
        .I3(out[2]),
        .I4(I7),
        .I5(qplllock_sync),
        .O(\n_0_FSM_sequential_tx_state[3]_i_7__1 ));
LUT6 #(
    .INIT(64'hBAFFBAFFBAFFBA00)) 
     \FSM_sequential_tx_state[3]_i_8__1 
       (.I0(txresetdone_s3),
        .I1(I2),
        .I2(I4),
        .I3(out[2]),
        .I4(I5),
        .I5(qplllock_sync),
        .O(\n_0_FSM_sequential_tx_state[3]_i_8__1 ));
MUXF7 \FSM_sequential_tx_state_reg[3]_i_3__1 
       (.I0(\n_0_FSM_sequential_tx_state[3]_i_7__1 ),
        .I1(\n_0_FSM_sequential_tx_state[3]_i_8__1 ),
        .O(\n_0_FSM_sequential_tx_state_reg[3]_i_3__1 ),
        .S(out[1]));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_QPLLLOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(qplllock_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'hD0C0FFFFD0C00000)) 
     reset_time_out_i_1__1
       (.I0(out[3]),
        .I1(out[0]),
        .I2(n_0_reset_time_out_i_2__1),
        .I3(I1),
        .I4(n_0_reset_time_out_i_3__1),
        .I5(I2),
        .O(O1));
LUT5 #(
    .INIT(32'hCFC0AFAF)) 
     reset_time_out_i_2__1
       (.I0(qplllock_sync),
        .I1(txresetdone_s3),
        .I2(out[1]),
        .I3(mmcm_lock_reclocked),
        .I4(out[2]),
        .O(n_0_reset_time_out_i_2__1));
LUT6 #(
    .INIT(64'h505040FF505040FA)) 
     reset_time_out_i_3__1
       (.I0(out[3]),
        .I1(qplllock_sync),
        .I2(out[0]),
        .I3(out[1]),
        .I4(out[2]),
        .I5(I1),
        .O(n_0_reset_time_out_i_3__1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_21
   (data_out,
    gt2_txresetdone_out,
    SYSCLK_IN);
  output data_out;
  input gt2_txresetdone_out;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_txresetdone_out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_txresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_22
   (SR,
    O1,
    mmcm_lock_reclocked,
    Q,
    I1,
    GT2_TX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output O1;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input I1;
  input GT2_TX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT2_TX_MMCM_LOCK_IN;
  wire I1;
  wire O1;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT2_TX_MMCM_LOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(mmcm_lock_i),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair59" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[7]_i_1__1 
       (.I0(mmcm_lock_i),
        .O(SR));
(* SOFT_HLUTNM = "soft_lutpair59" *) 
   LUT5 #(
    .INIT(32'hEAAA0000)) 
     mmcm_lock_reclocked_i_1__1
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(I1),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_23
   (data_out,
    data_in,
    gt2_txusrclk_in);
  output data_out;
  input data_in;
  input gt2_txusrclk_in;

  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_txusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_24
   (data_out,
    data_in,
    SYSCLK_IN);
  output data_out;
  input data_in;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_25
   (data_out,
    GT2_TX_FSM_RESET_DONE_OUT,
    gt2_txusrclk_in);
  output data_out;
  input GT2_TX_FSM_RESET_DONE_OUT;
  input gt2_txusrclk_in;

  wire GT2_TX_FSM_RESET_DONE_OUT;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_txusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(GT2_TX_FSM_RESET_DONE_OUT),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_26
   (O1,
    O2,
    out,
    I1,
    I2,
    I3,
    I4,
    rxresetdone_s3,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output O1;
  output O2;
  input [2:0]out;
  input I1;
  input I2;
  input I3;
  input I4;
  input rxresetdone_s3;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire GT0_QPLLLOCK_IN;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \n_0_FSM_sequential_rx_state[3]_i_9__1 ;
  wire [2:0]out;
  wire qplllock_sync;
  wire rxresetdone_s3;

LUT6 #(
    .INIT(64'hAA08FFFFAA080000)) 
     \FSM_sequential_rx_state[3]_i_5__1 
       (.I0(out[0]),
        .I1(I4),
        .I2(I3),
        .I3(rxresetdone_s3),
        .I4(out[1]),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_9__1 ),
        .O(O2));
LUT4 #(
    .INIT(16'h5455)) 
     \FSM_sequential_rx_state[3]_i_9__1 
       (.I0(out[2]),
        .I1(qplllock_sync),
        .I2(I4),
        .I3(out[0]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_9__1 ));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_QPLLLOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(qplllock_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFF10FFFFFF100000)) 
     reset_time_out_i_1__5
       (.I0(out[2]),
        .I1(out[1]),
        .I2(qplllock_sync),
        .I3(I1),
        .I4(I2),
        .I5(I3),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_27
   (data_out,
    gt2_rxresetdone_out,
    SYSCLK_IN);
  output data_out;
  input gt2_rxresetdone_out;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_rxresetdone_out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rxresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_28
   (O1,
    D,
    E,
    O2,
    I1,
    I2,
    DONT_RESET_ON_DATA_ERROR_IN,
    out,
    GT2_RX_FSM_RESET_DONE_OUT,
    I3,
    I4,
    I5,
    I6,
    I7,
    rx_state16_out,
    mmcm_lock_reclocked,
    rxresetdone_s3,
    I8,
    time_out_wait_bypass_s3,
    I9,
    GT2_DATA_VALID_IN,
    SYSCLK_IN);
  output O1;
  output [2:0]D;
  output [0:0]E;
  output O2;
  input I1;
  input I2;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input [3:0]out;
  input GT2_RX_FSM_RESET_DONE_OUT;
  input I3;
  input I4;
  input I5;
  input I6;
  input I7;
  input rx_state16_out;
  input mmcm_lock_reclocked;
  input rxresetdone_s3;
  input I8;
  input time_out_wait_bypass_s3;
  input I9;
  input GT2_DATA_VALID_IN;
  input SYSCLK_IN;

  wire [2:0]D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire [0:0]E;
  wire GT2_DATA_VALID_IN;
  wire GT2_RX_FSM_RESET_DONE_OUT;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire data_valid_sync;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_rx_state[3]_i_3__1 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_6__1 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_7__1 ;
  wire n_0_reset_time_out_i_4__1;
  wire n_0_rx_fsm_reset_done_int_i_3__1;
  wire [3:0]out;
  wire rx_fsm_reset_done_int;
  wire rx_state1;
  wire rx_state16_out;
  wire rxresetdone_s3;
  wire time_out_wait_bypass_s3;

LUT6 #(
    .INIT(64'h0C0C5DFD0C0C5D5D)) 
     \FSM_sequential_rx_state[0]_i_1__1 
       (.I0(out[0]),
        .I1(I4),
        .I2(out[3]),
        .I3(out[1]),
        .I4(out[2]),
        .I5(rx_state1),
        .O(D[0]));
LUT6 #(
    .INIT(64'h0000050000FF7700)) 
     \FSM_sequential_rx_state[1]_i_1__1 
       (.I0(out[2]),
        .I1(rx_state16_out),
        .I2(rx_state1),
        .I3(out[0]),
        .I4(out[1]),
        .I5(out[3]),
        .O(D[1]));
LUT4 #(
    .INIT(16'h0004)) 
     \FSM_sequential_rx_state[1]_i_2__1 
       (.I0(I1),
        .I1(I2),
        .I2(DONT_RESET_ON_DATA_ERROR_IN),
        .I3(data_valid_sync),
        .O(rx_state1));
LUT5 #(
    .INIT(32'hFEFEFEAE)) 
     \FSM_sequential_rx_state[3]_i_1__1 
       (.I0(\n_0_FSM_sequential_rx_state[3]_i_3__1 ),
        .I1(I5),
        .I2(out[0]),
        .I3(I6),
        .I4(\n_0_FSM_sequential_rx_state[3]_i_6__1 ),
        .O(E));
LUT6 #(
    .INIT(64'h55AA00A2000000A2)) 
     \FSM_sequential_rx_state[3]_i_2__1 
       (.I0(out[3]),
        .I1(time_out_wait_bypass_s3),
        .I2(out[1]),
        .I3(out[2]),
        .I4(out[0]),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_7__1 ),
        .O(D[2]));
LUT5 #(
    .INIT(32'hCCCC4430)) 
     \FSM_sequential_rx_state[3]_i_3__1 
       (.I0(data_valid_sync),
        .I1(out[3]),
        .I2(I7),
        .I3(out[1]),
        .I4(out[2]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_3__1 ));
LUT6 #(
    .INIT(64'hF0F0F0F0EFEFEFE0)) 
     \FSM_sequential_rx_state[3]_i_6__1 
       (.I0(rx_state1),
        .I1(data_valid_sync),
        .I2(out[3]),
        .I3(rx_state16_out),
        .I4(mmcm_lock_reclocked),
        .I5(out[1]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_6__1 ));
LUT5 #(
    .INIT(32'hB0B0000F)) 
     \FSM_sequential_rx_state[3]_i_7__1 
       (.I0(I1),
        .I1(I9),
        .I2(out[1]),
        .I3(rx_state1),
        .I4(out[2]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_7__1 ));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT2_DATA_VALID_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_valid_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'h8F88FFFF8F880000)) 
     reset_time_out_i_2__5
       (.I0(rxresetdone_s3),
        .I1(out[2]),
        .I2(data_valid_sync),
        .I3(out[3]),
        .I4(out[1]),
        .I5(n_0_reset_time_out_i_4__1),
        .O(O2));
LUT6 #(
    .INIT(64'hFFF3DDF333F311F3)) 
     reset_time_out_i_4__1
       (.I0(out[3]),
        .I1(out[2]),
        .I2(I8),
        .I3(out[0]),
        .I4(data_valid_sync),
        .I5(mmcm_lock_reclocked),
        .O(n_0_reset_time_out_i_4__1));
LUT5 #(
    .INIT(32'hEFFF2000)) 
     rx_fsm_reset_done_int_i_1__1
       (.I0(rx_fsm_reset_done_int),
        .I1(out[2]),
        .I2(out[3]),
        .I3(n_0_rx_fsm_reset_done_int_i_3__1),
        .I4(GT2_RX_FSM_RESET_DONE_OUT),
        .O(O1));
LUT4 #(
    .INIT(16'h0080)) 
     rx_fsm_reset_done_int_i_2__1
       (.I0(out[1]),
        .I1(data_valid_sync),
        .I2(I3),
        .I3(I1),
        .O(rx_fsm_reset_done_int));
LUT6 #(
    .INIT(64'h0C380C383C380C38)) 
     rx_fsm_reset_done_int_i_3__1
       (.I0(rx_state1),
        .I1(out[0]),
        .I2(out[1]),
        .I3(data_valid_sync),
        .I4(I3),
        .I5(I1),
        .O(n_0_rx_fsm_reset_done_int_i_3__1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_29
   (SR,
    O1,
    mmcm_lock_reclocked,
    Q,
    I1,
    GT2_RX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output O1;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input I1;
  input GT2_RX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT2_RX_MMCM_LOCK_IN;
  wire I1;
  wire O1;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT2_RX_MMCM_LOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(mmcm_lock_i),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair47" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[7]_i_1__5 
       (.I0(mmcm_lock_i),
        .O(SR));
(* SOFT_HLUTNM = "soft_lutpair47" *) 
   LUT5 #(
    .INIT(32'hEAAA0000)) 
     mmcm_lock_reclocked_i_1__5
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(I1),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_30
   (data_out,
    data_in,
    gt2_rxusrclk_in);
  output data_out;
  input data_in;
  input gt2_rxusrclk_in;

  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_rxusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_31
   (data_out,
    GT2_RX_FSM_RESET_DONE_OUT,
    gt2_rxusrclk_in);
  output data_out;
  input GT2_RX_FSM_RESET_DONE_OUT;
  input gt2_rxusrclk_in;

  wire GT2_RX_FSM_RESET_DONE_OUT;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_rxusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(GT2_RX_FSM_RESET_DONE_OUT),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_32
   (O1,
    O2,
    out,
    GT2_RX_MMCM_RESET_OUT,
    I1,
    mmcm_lock_reclocked,
    data_in,
    SYSCLK_IN);
  output O1;
  output O2;
  input [3:0]out;
  input GT2_RX_MMCM_RESET_OUT;
  input I1;
  input mmcm_lock_reclocked;
  input data_in;
  input SYSCLK_IN;

  wire GT2_RX_MMCM_RESET_OUT;
  wire I1;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_reclocked;
  wire n_0_reset_time_out_i_5__1;
  wire [3:0]out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
LUT6 #(
    .INIT(64'hEFFFFFFF00100010)) 
     mmcm_reset_i_i_1__1
       (.I0(out[3]),
        .I1(out[1]),
        .I2(out[0]),
        .I3(out[2]),
        .I4(data_out),
        .I5(GT2_RX_MMCM_RESET_OUT),
        .O(O1));
LUT6 #(
    .INIT(64'h8888BBBB88B88888)) 
     reset_time_out_i_3__5
       (.I0(n_0_reset_time_out_i_5__1),
        .I1(out[0]),
        .I2(I1),
        .I3(out[1]),
        .I4(out[2]),
        .I5(out[3]),
        .O(O2));
LUT5 #(
    .INIT(32'h1111FFFD)) 
     reset_time_out_i_5__1
       (.I0(out[2]),
        .I1(out[1]),
        .I2(data_out),
        .I3(mmcm_lock_reclocked),
        .I4(out[3]),
        .O(n_0_reset_time_out_i_5__1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_33
   (data_out,
    data_in,
    RXOUTCLK);
  output data_out;
  input data_in;
  input RXOUTCLK;

  wire RXOUTCLK;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_34
   (data_out,
    data_in,
    SYSCLK_IN);
  output data_out;
  input data_in;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_35
   (O1,
    E,
    out,
    I1,
    I2,
    I3,
    wait_time_done,
    txresetdone_s3,
    I4,
    I5,
    mmcm_lock_reclocked,
    I6,
    I7,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output O1;
  output [0:0]E;
  input [3:0]out;
  input I1;
  input I2;
  input I3;
  input wait_time_done;
  input txresetdone_s3;
  input I4;
  input I5;
  input mmcm_lock_reclocked;
  input I6;
  input I7;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire [0:0]E;
  wire GT0_QPLLLOCK_IN;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire O1;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_tx_state[3]_i_7__0 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_8__0 ;
  wire \n_0_FSM_sequential_tx_state_reg[3]_i_3__0 ;
  wire n_0_reset_time_out_i_2__0;
  wire n_0_reset_time_out_i_3__0;
  wire [3:0]out;
  wire qplllock_sync;
  wire txresetdone_s3;
  wire wait_time_done;

LUT6 #(
    .INIT(64'h4F4AEFEF4F4AEAEA)) 
     \FSM_sequential_tx_state[3]_i_1__0 
       (.I0(out[3]),
        .I1(\n_0_FSM_sequential_tx_state_reg[3]_i_3__0 ),
        .I2(out[0]),
        .I3(I1),
        .I4(I3),
        .I5(wait_time_done),
        .O(E));
LUT6 #(
    .INIT(64'hBA00BA00BAFFBA00)) 
     \FSM_sequential_tx_state[3]_i_7__0 
       (.I0(mmcm_lock_reclocked),
        .I1(I2),
        .I2(I6),
        .I3(out[2]),
        .I4(I7),
        .I5(qplllock_sync),
        .O(\n_0_FSM_sequential_tx_state[3]_i_7__0 ));
LUT6 #(
    .INIT(64'hBAFFBAFFBAFFBA00)) 
     \FSM_sequential_tx_state[3]_i_8__0 
       (.I0(txresetdone_s3),
        .I1(I2),
        .I2(I4),
        .I3(out[2]),
        .I4(I5),
        .I5(qplllock_sync),
        .O(\n_0_FSM_sequential_tx_state[3]_i_8__0 ));
MUXF7 \FSM_sequential_tx_state_reg[3]_i_3__0 
       (.I0(\n_0_FSM_sequential_tx_state[3]_i_7__0 ),
        .I1(\n_0_FSM_sequential_tx_state[3]_i_8__0 ),
        .O(\n_0_FSM_sequential_tx_state_reg[3]_i_3__0 ),
        .S(out[1]));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_QPLLLOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(qplllock_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'hD0C0FFFFD0C00000)) 
     reset_time_out_i_1__0
       (.I0(out[3]),
        .I1(out[0]),
        .I2(n_0_reset_time_out_i_2__0),
        .I3(I1),
        .I4(n_0_reset_time_out_i_3__0),
        .I5(I2),
        .O(O1));
LUT5 #(
    .INIT(32'hCFC0AFAF)) 
     reset_time_out_i_2__0
       (.I0(qplllock_sync),
        .I1(txresetdone_s3),
        .I2(out[1]),
        .I3(mmcm_lock_reclocked),
        .I4(out[2]),
        .O(n_0_reset_time_out_i_2__0));
LUT6 #(
    .INIT(64'h505040FF505040FA)) 
     reset_time_out_i_3__0
       (.I0(out[3]),
        .I1(qplllock_sync),
        .I2(out[0]),
        .I3(out[1]),
        .I4(out[2]),
        .I5(I1),
        .O(n_0_reset_time_out_i_3__0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_36
   (data_out,
    gt1_txresetdone_out,
    SYSCLK_IN);
  output data_out;
  input gt1_txresetdone_out;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_txresetdone_out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_txresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_37
   (SR,
    O1,
    mmcm_lock_reclocked,
    Q,
    I1,
    GT1_TX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output O1;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input I1;
  input GT1_TX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT1_TX_MMCM_LOCK_IN;
  wire I1;
  wire O1;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT1_TX_MMCM_LOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(mmcm_lock_i),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair35" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[7]_i_1__0 
       (.I0(mmcm_lock_i),
        .O(SR));
(* SOFT_HLUTNM = "soft_lutpair35" *) 
   LUT5 #(
    .INIT(32'hEAAA0000)) 
     mmcm_lock_reclocked_i_1__0
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(I1),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_38
   (data_out,
    data_in,
    gt1_txusrclk_in);
  output data_out;
  input data_in;
  input gt1_txusrclk_in;

  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_txusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_39
   (data_out,
    data_in,
    SYSCLK_IN);
  output data_out;
  input data_in;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_40
   (data_out,
    GT1_TX_FSM_RESET_DONE_OUT,
    gt1_txusrclk_in);
  output data_out;
  input GT1_TX_FSM_RESET_DONE_OUT;
  input gt1_txusrclk_in;

  wire GT1_TX_FSM_RESET_DONE_OUT;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_txusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(GT1_TX_FSM_RESET_DONE_OUT),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_41
   (O1,
    O2,
    out,
    I1,
    I2,
    I3,
    I4,
    rxresetdone_s3,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output O1;
  output O2;
  input [2:0]out;
  input I1;
  input I2;
  input I3;
  input I4;
  input rxresetdone_s3;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire GT0_QPLLLOCK_IN;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \n_0_FSM_sequential_rx_state[3]_i_9__0 ;
  wire [2:0]out;
  wire qplllock_sync;
  wire rxresetdone_s3;

LUT6 #(
    .INIT(64'hAA08FFFFAA080000)) 
     \FSM_sequential_rx_state[3]_i_5__0 
       (.I0(out[0]),
        .I1(I4),
        .I2(I3),
        .I3(rxresetdone_s3),
        .I4(out[1]),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_9__0 ),
        .O(O2));
LUT4 #(
    .INIT(16'h5455)) 
     \FSM_sequential_rx_state[3]_i_9__0 
       (.I0(out[2]),
        .I1(qplllock_sync),
        .I2(I4),
        .I3(out[0]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_9__0 ));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_QPLLLOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(qplllock_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFF10FFFFFF100000)) 
     reset_time_out_i_1__4
       (.I0(out[2]),
        .I1(out[1]),
        .I2(qplllock_sync),
        .I3(I1),
        .I4(I2),
        .I5(I3),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_42
   (data_out,
    gt1_rxresetdone_out,
    SYSCLK_IN);
  output data_out;
  input gt1_rxresetdone_out;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_rxresetdone_out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rxresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_43
   (O1,
    D,
    E,
    O2,
    I1,
    I2,
    DONT_RESET_ON_DATA_ERROR_IN,
    out,
    GT1_RX_FSM_RESET_DONE_OUT,
    I3,
    I4,
    I5,
    I6,
    I7,
    rx_state16_out,
    mmcm_lock_reclocked,
    rxresetdone_s3,
    I8,
    time_out_wait_bypass_s3,
    I9,
    GT1_DATA_VALID_IN,
    SYSCLK_IN);
  output O1;
  output [2:0]D;
  output [0:0]E;
  output O2;
  input I1;
  input I2;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input [3:0]out;
  input GT1_RX_FSM_RESET_DONE_OUT;
  input I3;
  input I4;
  input I5;
  input I6;
  input I7;
  input rx_state16_out;
  input mmcm_lock_reclocked;
  input rxresetdone_s3;
  input I8;
  input time_out_wait_bypass_s3;
  input I9;
  input GT1_DATA_VALID_IN;
  input SYSCLK_IN;

  wire [2:0]D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire [0:0]E;
  wire GT1_DATA_VALID_IN;
  wire GT1_RX_FSM_RESET_DONE_OUT;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire data_valid_sync;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_rx_state[3]_i_3__0 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_6__0 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_7__0 ;
  wire n_0_reset_time_out_i_4__0;
  wire n_0_rx_fsm_reset_done_int_i_3__0;
  wire [3:0]out;
  wire rx_fsm_reset_done_int;
  wire rx_state1;
  wire rx_state16_out;
  wire rxresetdone_s3;
  wire time_out_wait_bypass_s3;

LUT6 #(
    .INIT(64'h0C0C5DFD0C0C5D5D)) 
     \FSM_sequential_rx_state[0]_i_1__0 
       (.I0(out[0]),
        .I1(I4),
        .I2(out[3]),
        .I3(out[1]),
        .I4(out[2]),
        .I5(rx_state1),
        .O(D[0]));
LUT6 #(
    .INIT(64'h0000050000FF7700)) 
     \FSM_sequential_rx_state[1]_i_1__0 
       (.I0(out[2]),
        .I1(rx_state16_out),
        .I2(rx_state1),
        .I3(out[0]),
        .I4(out[1]),
        .I5(out[3]),
        .O(D[1]));
LUT4 #(
    .INIT(16'h0004)) 
     \FSM_sequential_rx_state[1]_i_2__0 
       (.I0(I1),
        .I1(I2),
        .I2(DONT_RESET_ON_DATA_ERROR_IN),
        .I3(data_valid_sync),
        .O(rx_state1));
LUT5 #(
    .INIT(32'hFEFEFEAE)) 
     \FSM_sequential_rx_state[3]_i_1__0 
       (.I0(\n_0_FSM_sequential_rx_state[3]_i_3__0 ),
        .I1(I5),
        .I2(out[0]),
        .I3(I6),
        .I4(\n_0_FSM_sequential_rx_state[3]_i_6__0 ),
        .O(E));
LUT6 #(
    .INIT(64'h55AA00A2000000A2)) 
     \FSM_sequential_rx_state[3]_i_2__0 
       (.I0(out[3]),
        .I1(time_out_wait_bypass_s3),
        .I2(out[1]),
        .I3(out[2]),
        .I4(out[0]),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_7__0 ),
        .O(D[2]));
LUT5 #(
    .INIT(32'hCCCC4430)) 
     \FSM_sequential_rx_state[3]_i_3__0 
       (.I0(data_valid_sync),
        .I1(out[3]),
        .I2(I7),
        .I3(out[1]),
        .I4(out[2]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_3__0 ));
LUT6 #(
    .INIT(64'hF0F0F0F0EFEFEFE0)) 
     \FSM_sequential_rx_state[3]_i_6__0 
       (.I0(rx_state1),
        .I1(data_valid_sync),
        .I2(out[3]),
        .I3(rx_state16_out),
        .I4(mmcm_lock_reclocked),
        .I5(out[1]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_6__0 ));
LUT5 #(
    .INIT(32'hB0B0000F)) 
     \FSM_sequential_rx_state[3]_i_7__0 
       (.I0(I1),
        .I1(I9),
        .I2(out[1]),
        .I3(rx_state1),
        .I4(out[2]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_7__0 ));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT1_DATA_VALID_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_valid_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'h8F88FFFF8F880000)) 
     reset_time_out_i_2__4
       (.I0(rxresetdone_s3),
        .I1(out[2]),
        .I2(data_valid_sync),
        .I3(out[3]),
        .I4(out[1]),
        .I5(n_0_reset_time_out_i_4__0),
        .O(O2));
LUT6 #(
    .INIT(64'hFFF3DDF333F311F3)) 
     reset_time_out_i_4__0
       (.I0(out[3]),
        .I1(out[2]),
        .I2(I8),
        .I3(out[0]),
        .I4(data_valid_sync),
        .I5(mmcm_lock_reclocked),
        .O(n_0_reset_time_out_i_4__0));
LUT5 #(
    .INIT(32'hEFFF2000)) 
     rx_fsm_reset_done_int_i_1__0
       (.I0(rx_fsm_reset_done_int),
        .I1(out[2]),
        .I2(out[3]),
        .I3(n_0_rx_fsm_reset_done_int_i_3__0),
        .I4(GT1_RX_FSM_RESET_DONE_OUT),
        .O(O1));
LUT4 #(
    .INIT(16'h0080)) 
     rx_fsm_reset_done_int_i_2__0
       (.I0(out[1]),
        .I1(data_valid_sync),
        .I2(I3),
        .I3(I1),
        .O(rx_fsm_reset_done_int));
LUT6 #(
    .INIT(64'h0C380C383C380C38)) 
     rx_fsm_reset_done_int_i_3__0
       (.I0(rx_state1),
        .I1(out[0]),
        .I2(out[1]),
        .I3(data_valid_sync),
        .I4(I3),
        .I5(I1),
        .O(n_0_rx_fsm_reset_done_int_i_3__0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_44
   (SR,
    O1,
    mmcm_lock_reclocked,
    Q,
    I1,
    GT1_RX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output O1;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input I1;
  input GT1_RX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT1_RX_MMCM_LOCK_IN;
  wire I1;
  wire O1;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT1_RX_MMCM_LOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(mmcm_lock_i),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair24" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[7]_i_1__4 
       (.I0(mmcm_lock_i),
        .O(SR));
(* SOFT_HLUTNM = "soft_lutpair24" *) 
   LUT5 #(
    .INIT(32'hEAAA0000)) 
     mmcm_lock_reclocked_i_1__4
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(I1),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_45
   (data_out,
    data_in,
    gt1_rxusrclk_in);
  output data_out;
  input data_in;
  input gt1_rxusrclk_in;

  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_rxusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_46
   (data_out,
    GT1_RX_FSM_RESET_DONE_OUT,
    gt1_rxusrclk_in);
  output data_out;
  input GT1_RX_FSM_RESET_DONE_OUT;
  input gt1_rxusrclk_in;

  wire GT1_RX_FSM_RESET_DONE_OUT;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_rxusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(GT1_RX_FSM_RESET_DONE_OUT),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_47
   (O1,
    O2,
    out,
    GT1_RX_MMCM_RESET_OUT,
    I1,
    mmcm_lock_reclocked,
    data_in,
    SYSCLK_IN);
  output O1;
  output O2;
  input [3:0]out;
  input GT1_RX_MMCM_RESET_OUT;
  input I1;
  input mmcm_lock_reclocked;
  input data_in;
  input SYSCLK_IN;

  wire GT1_RX_MMCM_RESET_OUT;
  wire I1;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_reclocked;
  wire n_0_reset_time_out_i_5__0;
  wire [3:0]out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
LUT6 #(
    .INIT(64'hEFFFFFFF00100010)) 
     mmcm_reset_i_i_1__0
       (.I0(out[3]),
        .I1(out[1]),
        .I2(out[0]),
        .I3(out[2]),
        .I4(data_out),
        .I5(GT1_RX_MMCM_RESET_OUT),
        .O(O1));
LUT6 #(
    .INIT(64'h8888BBBB88B88888)) 
     reset_time_out_i_3__4
       (.I0(n_0_reset_time_out_i_5__0),
        .I1(out[0]),
        .I2(I1),
        .I3(out[1]),
        .I4(out[2]),
        .I5(out[3]),
        .O(O2));
LUT5 #(
    .INIT(32'h1111FFFD)) 
     reset_time_out_i_5__0
       (.I0(out[2]),
        .I1(out[1]),
        .I2(data_out),
        .I3(mmcm_lock_reclocked),
        .I4(out[3]),
        .O(n_0_reset_time_out_i_5__0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_48
   (data_out,
    data_in,
    RXOUTCLK);
  output data_out;
  input data_in;
  input RXOUTCLK;

  wire RXOUTCLK;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_49
   (data_out,
    data_in,
    SYSCLK_IN);
  output data_out;
  input data_in;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_50
   (O1,
    E,
    out,
    I1,
    reset_time_out,
    I2,
    wait_time_done,
    txresetdone_s3,
    I3,
    I4,
    mmcm_lock_reclocked,
    I5,
    I6,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output O1;
  output [0:0]E;
  input [3:0]out;
  input I1;
  input reset_time_out;
  input I2;
  input wait_time_done;
  input txresetdone_s3;
  input I3;
  input I4;
  input mmcm_lock_reclocked;
  input I5;
  input I6;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire [0:0]E;
  wire GT0_QPLLLOCK_IN;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire O1;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_tx_state[3]_i_7 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_8 ;
  wire \n_0_FSM_sequential_tx_state_reg[3]_i_3 ;
  wire n_0_reset_time_out_i_2;
  wire n_0_reset_time_out_i_3;
  wire [3:0]out;
  wire qplllock_sync;
  wire reset_time_out;
  wire txresetdone_s3;
  wire wait_time_done;

LUT6 #(
    .INIT(64'h4F4AEFEF4F4AEAEA)) 
     \FSM_sequential_tx_state[3]_i_1 
       (.I0(out[3]),
        .I1(\n_0_FSM_sequential_tx_state_reg[3]_i_3 ),
        .I2(out[0]),
        .I3(I1),
        .I4(I2),
        .I5(wait_time_done),
        .O(E));
LUT6 #(
    .INIT(64'hBA00BA00BAFFBA00)) 
     \FSM_sequential_tx_state[3]_i_7 
       (.I0(mmcm_lock_reclocked),
        .I1(reset_time_out),
        .I2(I5),
        .I3(out[2]),
        .I4(I6),
        .I5(qplllock_sync),
        .O(\n_0_FSM_sequential_tx_state[3]_i_7 ));
LUT6 #(
    .INIT(64'hBAFFBAFFBAFFBA00)) 
     \FSM_sequential_tx_state[3]_i_8 
       (.I0(txresetdone_s3),
        .I1(reset_time_out),
        .I2(I3),
        .I3(out[2]),
        .I4(I4),
        .I5(qplllock_sync),
        .O(\n_0_FSM_sequential_tx_state[3]_i_8 ));
MUXF7 \FSM_sequential_tx_state_reg[3]_i_3 
       (.I0(\n_0_FSM_sequential_tx_state[3]_i_7 ),
        .I1(\n_0_FSM_sequential_tx_state[3]_i_8 ),
        .O(\n_0_FSM_sequential_tx_state_reg[3]_i_3 ),
        .S(out[1]));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_QPLLLOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(qplllock_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'hD0C0FFFFD0C00000)) 
     reset_time_out_i_1
       (.I0(out[3]),
        .I1(out[0]),
        .I2(n_0_reset_time_out_i_2),
        .I3(I1),
        .I4(n_0_reset_time_out_i_3),
        .I5(reset_time_out),
        .O(O1));
LUT5 #(
    .INIT(32'hCFC0AFAF)) 
     reset_time_out_i_2
       (.I0(qplllock_sync),
        .I1(txresetdone_s3),
        .I2(out[1]),
        .I3(mmcm_lock_reclocked),
        .I4(out[2]),
        .O(n_0_reset_time_out_i_2));
LUT6 #(
    .INIT(64'h505040FF505040FA)) 
     reset_time_out_i_3
       (.I0(out[3]),
        .I1(qplllock_sync),
        .I2(out[0]),
        .I3(out[1]),
        .I4(out[2]),
        .I5(I1),
        .O(n_0_reset_time_out_i_3));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_51
   (data_out,
    gt0_txresetdone_out,
    SYSCLK_IN);
  output data_out;
  input gt0_txresetdone_out;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_txresetdone_out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_txresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_52
   (SR,
    O1,
    mmcm_lock_reclocked,
    Q,
    I1,
    GT0_TX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output O1;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input I1;
  input GT0_TX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT0_TX_MMCM_LOCK_IN;
  wire I1;
  wire O1;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_TX_MMCM_LOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(mmcm_lock_i),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[7]_i_1 
       (.I0(mmcm_lock_i),
        .O(SR));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT5 #(
    .INIT(32'hEAAA0000)) 
     mmcm_lock_reclocked_i_1
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(I1),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_53
   (data_out,
    data_in,
    gt0_txusrclk_in);
  output data_out;
  input data_in;
  input gt0_txusrclk_in;

  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_txusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_54
   (data_out,
    data_in,
    SYSCLK_IN);
  output data_out;
  input data_in;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_55
   (data_out,
    GT0_TX_FSM_RESET_DONE_OUT,
    gt0_txusrclk_in);
  output data_out;
  input GT0_TX_FSM_RESET_DONE_OUT;
  input gt0_txusrclk_in;

  wire GT0_TX_FSM_RESET_DONE_OUT;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_txusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(GT0_TX_FSM_RESET_DONE_OUT),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_56
   (O1,
    O2,
    out,
    I1,
    I2,
    I3,
    I4,
    rxresetdone_s3,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output O1;
  output O2;
  input [2:0]out;
  input I1;
  input I2;
  input I3;
  input I4;
  input rxresetdone_s3;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire GT0_QPLLLOCK_IN;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \n_0_FSM_sequential_rx_state[3]_i_9 ;
  wire [2:0]out;
  wire qplllock_sync;
  wire rxresetdone_s3;

LUT6 #(
    .INIT(64'hAA08FFFFAA080000)) 
     \FSM_sequential_rx_state[3]_i_5 
       (.I0(out[0]),
        .I1(I4),
        .I2(I3),
        .I3(rxresetdone_s3),
        .I4(out[1]),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_9 ),
        .O(O2));
LUT4 #(
    .INIT(16'h5455)) 
     \FSM_sequential_rx_state[3]_i_9 
       (.I0(out[2]),
        .I1(qplllock_sync),
        .I2(I4),
        .I3(out[0]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_9 ));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_QPLLLOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(qplllock_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFF10FFFFFF100000)) 
     reset_time_out_i_1__3
       (.I0(out[2]),
        .I1(out[1]),
        .I2(qplllock_sync),
        .I3(I1),
        .I4(I2),
        .I5(I3),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_57
   (data_out,
    gt0_rxresetdone_out,
    SYSCLK_IN);
  output data_out;
  input gt0_rxresetdone_out;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_rxresetdone_out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rxresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_58
   (O1,
    D,
    E,
    O2,
    I1,
    I2,
    DONT_RESET_ON_DATA_ERROR_IN,
    out,
    GT0_RX_FSM_RESET_DONE_OUT,
    I3,
    I4,
    I5,
    I6,
    I7,
    rx_state16_out,
    mmcm_lock_reclocked,
    rxresetdone_s3,
    I8,
    time_out_wait_bypass_s3,
    I9,
    GT0_DATA_VALID_IN,
    SYSCLK_IN);
  output O1;
  output [2:0]D;
  output [0:0]E;
  output O2;
  input I1;
  input I2;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input [3:0]out;
  input GT0_RX_FSM_RESET_DONE_OUT;
  input I3;
  input I4;
  input I5;
  input I6;
  input I7;
  input rx_state16_out;
  input mmcm_lock_reclocked;
  input rxresetdone_s3;
  input I8;
  input time_out_wait_bypass_s3;
  input I9;
  input GT0_DATA_VALID_IN;
  input SYSCLK_IN;

  wire [2:0]D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire [0:0]E;
  wire GT0_DATA_VALID_IN;
  wire GT0_RX_FSM_RESET_DONE_OUT;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire data_valid_sync;
  wire mmcm_lock_reclocked;
  wire \n_0_FSM_sequential_rx_state[3]_i_3 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_6 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_7 ;
  wire n_0_reset_time_out_i_4;
  wire n_0_rx_fsm_reset_done_int_i_3;
  wire [3:0]out;
  wire rx_fsm_reset_done_int;
  wire rx_state1;
  wire rx_state16_out;
  wire rxresetdone_s3;
  wire time_out_wait_bypass_s3;

LUT6 #(
    .INIT(64'h0C0C5DFD0C0C5D5D)) 
     \FSM_sequential_rx_state[0]_i_1 
       (.I0(out[0]),
        .I1(I4),
        .I2(out[3]),
        .I3(out[1]),
        .I4(out[2]),
        .I5(rx_state1),
        .O(D[0]));
LUT6 #(
    .INIT(64'h0000050000FF7700)) 
     \FSM_sequential_rx_state[1]_i_1 
       (.I0(out[2]),
        .I1(rx_state16_out),
        .I2(rx_state1),
        .I3(out[0]),
        .I4(out[1]),
        .I5(out[3]),
        .O(D[1]));
LUT4 #(
    .INIT(16'h0004)) 
     \FSM_sequential_rx_state[1]_i_2 
       (.I0(I1),
        .I1(I2),
        .I2(DONT_RESET_ON_DATA_ERROR_IN),
        .I3(data_valid_sync),
        .O(rx_state1));
LUT5 #(
    .INIT(32'hFEFEFEAE)) 
     \FSM_sequential_rx_state[3]_i_1 
       (.I0(\n_0_FSM_sequential_rx_state[3]_i_3 ),
        .I1(I5),
        .I2(out[0]),
        .I3(I6),
        .I4(\n_0_FSM_sequential_rx_state[3]_i_6 ),
        .O(E));
LUT6 #(
    .INIT(64'h55AA00A2000000A2)) 
     \FSM_sequential_rx_state[3]_i_2 
       (.I0(out[3]),
        .I1(time_out_wait_bypass_s3),
        .I2(out[1]),
        .I3(out[2]),
        .I4(out[0]),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_7 ),
        .O(D[2]));
LUT5 #(
    .INIT(32'hCCCC4430)) 
     \FSM_sequential_rx_state[3]_i_3 
       (.I0(data_valid_sync),
        .I1(out[3]),
        .I2(I7),
        .I3(out[1]),
        .I4(out[2]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_3 ));
LUT6 #(
    .INIT(64'hF0F0F0F0EFEFEFE0)) 
     \FSM_sequential_rx_state[3]_i_6 
       (.I0(rx_state1),
        .I1(data_valid_sync),
        .I2(out[3]),
        .I3(rx_state16_out),
        .I4(mmcm_lock_reclocked),
        .I5(out[1]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_6 ));
LUT5 #(
    .INIT(32'hB0B0000F)) 
     \FSM_sequential_rx_state[3]_i_7 
       (.I0(I1),
        .I1(I9),
        .I2(out[1]),
        .I3(rx_state1),
        .I4(out[2]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_7 ));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_DATA_VALID_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_valid_sync),
        .R(1'b0));
LUT6 #(
    .INIT(64'h8F88FFFF8F880000)) 
     reset_time_out_i_2__3
       (.I0(rxresetdone_s3),
        .I1(out[2]),
        .I2(data_valid_sync),
        .I3(out[3]),
        .I4(out[1]),
        .I5(n_0_reset_time_out_i_4),
        .O(O2));
LUT6 #(
    .INIT(64'hFFF3DDF333F311F3)) 
     reset_time_out_i_4
       (.I0(out[3]),
        .I1(out[2]),
        .I2(I8),
        .I3(out[0]),
        .I4(data_valid_sync),
        .I5(mmcm_lock_reclocked),
        .O(n_0_reset_time_out_i_4));
LUT5 #(
    .INIT(32'hEFFF2000)) 
     rx_fsm_reset_done_int_i_1
       (.I0(rx_fsm_reset_done_int),
        .I1(out[2]),
        .I2(out[3]),
        .I3(n_0_rx_fsm_reset_done_int_i_3),
        .I4(GT0_RX_FSM_RESET_DONE_OUT),
        .O(O1));
LUT4 #(
    .INIT(16'h0080)) 
     rx_fsm_reset_done_int_i_2
       (.I0(out[1]),
        .I1(data_valid_sync),
        .I2(I3),
        .I3(I1),
        .O(rx_fsm_reset_done_int));
LUT6 #(
    .INIT(64'h0C380C383C380C38)) 
     rx_fsm_reset_done_int_i_3
       (.I0(rx_state1),
        .I1(out[0]),
        .I2(out[1]),
        .I3(data_valid_sync),
        .I4(I3),
        .I5(I1),
        .O(n_0_rx_fsm_reset_done_int_i_3));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_59
   (SR,
    O1,
    mmcm_lock_reclocked,
    Q,
    I1,
    GT0_RX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output O1;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input I1;
  input GT0_RX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT0_RX_MMCM_LOCK_IN;
  wire I1;
  wire O1;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT0_RX_MMCM_LOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(mmcm_lock_i),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[7]_i_1__3 
       (.I0(mmcm_lock_i),
        .O(SR));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT5 #(
    .INIT(32'hEAAA0000)) 
     mmcm_lock_reclocked_i_1__3
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(I1),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_6
   (data_out,
    gt3_txresetdone_out,
    SYSCLK_IN);
  output data_out;
  input gt3_txresetdone_out;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_txresetdone_out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_txresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_60
   (data_out,
    data_in,
    gt0_rxusrclk_in);
  output data_out;
  input data_in;
  input gt0_rxusrclk_in;

  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_rxusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_61
   (data_out,
    GT0_RX_FSM_RESET_DONE_OUT,
    gt0_rxusrclk_in);
  output data_out;
  input GT0_RX_FSM_RESET_DONE_OUT;
  input gt0_rxusrclk_in;

  wire GT0_RX_FSM_RESET_DONE_OUT;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_rxusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(GT0_RX_FSM_RESET_DONE_OUT),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_62
   (O1,
    O2,
    out,
    GT0_RX_MMCM_RESET_OUT,
    I1,
    mmcm_lock_reclocked,
    data_in,
    SYSCLK_IN);
  output O1;
  output O2;
  input [3:0]out;
  input GT0_RX_MMCM_RESET_OUT;
  input I1;
  input mmcm_lock_reclocked;
  input data_in;
  input SYSCLK_IN;

  wire GT0_RX_MMCM_RESET_OUT;
  wire I1;
  wire O1;
  wire O2;
  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_reclocked;
  wire n_0_reset_time_out_i_5;
  wire [3:0]out;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
LUT6 #(
    .INIT(64'hEFFFFFFF00100010)) 
     mmcm_reset_i_i_1
       (.I0(out[3]),
        .I1(out[1]),
        .I2(out[0]),
        .I3(out[2]),
        .I4(data_out),
        .I5(GT0_RX_MMCM_RESET_OUT),
        .O(O1));
LUT6 #(
    .INIT(64'h8888BBBB88B88888)) 
     reset_time_out_i_3__3
       (.I0(n_0_reset_time_out_i_5),
        .I1(out[0]),
        .I2(I1),
        .I3(out[1]),
        .I4(out[2]),
        .I5(out[3]),
        .O(O2));
LUT5 #(
    .INIT(32'h1111FFFD)) 
     reset_time_out_i_5
       (.I0(out[2]),
        .I1(out[1]),
        .I2(data_out),
        .I3(mmcm_lock_reclocked),
        .I4(out[3]),
        .O(n_0_reset_time_out_i_5));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_63
   (data_out,
    data_in,
    RXOUTCLK);
  output data_out;
  input data_in;
  input RXOUTCLK;

  wire RXOUTCLK;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(RXOUTCLK),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_64
   (data_out,
    data_in,
    SYSCLK_IN);
  output data_out;
  input data_in;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_7
   (SR,
    O1,
    mmcm_lock_reclocked,
    Q,
    I1,
    GT3_TX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output O1;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input I1;
  input GT3_TX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT3_TX_MMCM_LOCK_IN;
  wire I1;
  wire O1;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(GT3_TX_MMCM_LOCK_IN),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(mmcm_lock_i),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair83" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[7]_i_1__2 
       (.I0(mmcm_lock_i),
        .O(SR));
(* SOFT_HLUTNM = "soft_lutpair83" *) 
   LUT5 #(
    .INIT(32'hEAAA0000)) 
     mmcm_lock_reclocked_i_1__2
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(I1),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_8
   (data_out,
    data_in,
    gt3_txusrclk_in);
  output data_out;
  input data_in;
  input gt3_txusrclk_in;

  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_txusrclk_in;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block__parameterized0_9
   (data_out,
    data_in,
    SYSCLK_IN);
  output data_out;
  input data_in;
  input SYSCLK_IN;

  wire SYSCLK_IN;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
