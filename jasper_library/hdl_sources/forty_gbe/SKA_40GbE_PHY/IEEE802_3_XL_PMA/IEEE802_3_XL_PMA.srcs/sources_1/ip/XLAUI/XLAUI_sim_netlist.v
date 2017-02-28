// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Mon Nov  7 14:25:03 2016
// Host        : adam-cm running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aisaacson/work/git_work/ska_sa/projects/skarab_bsp_firmware/firmware/FRM123701U1R1/Vivado/Source/SKA_40GbE_PHY/IEEE802_3_XL_PMA/IEEE802_3_XL_PMA.srcs/sources_1/ip/XLAUI/XLAUI_sim_netlist.v
// Design      : XLAUI
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "XLAUI,gtwizard_v3_4,{protocol_file=xlaui}" *) 
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
  wire GT0_QPLLREFCLKLOST_IN;
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
  wire gt0_gtrxreset_in;
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
  wire gt1_gtrxreset_in;
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
  wire gt2_gtrxreset_in;
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
  wire gt3_gtrxreset_in;
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

  (* EXAMPLE_SIMULATION = "0" *) 
  (* EXAMPLE_SIM_GTRESET_SPEEDUP = "TRUE" *) 
  (* EXAMPLE_USE_CHIPSCOPE = "0" *) 
  (* STABLE_CLOCK_PERIOD = "6" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  XLAUI_XLAUI_init U0
       (.DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .GT0_DATA_VALID_IN(GT0_DATA_VALID_IN),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT0_QPLLREFCLKLOST_IN(GT0_QPLLREFCLKLOST_IN),
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
        .gt0_gtrxreset_in(gt0_gtrxreset_in),
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
        .gt1_gtrxreset_in(gt1_gtrxreset_in),
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
        .gt2_gtrxreset_in(gt2_gtrxreset_in),
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
        .gt3_gtrxreset_in(gt3_gtrxreset_in),
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

(* ORIG_REF_NAME = "XLAUI_GT" *) 
module XLAUI_XLAUI_GT
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
  wire gthe2_i_n_50;
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
        .TXPMARESETDONE(gthe2_i_n_50),
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
module XLAUI_XLAUI_GT_65
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
    gtrxreset_i_reg,
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
  input [0:0]gtrxreset_i_reg;
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
  wire gthe2_i_n_50;
  wire [0:0]gtrxreset_i_reg;
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
        .GTRXRESET(gtrxreset_i_reg),
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
        .TXPMARESETDONE(gthe2_i_n_50),
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
module XLAUI_XLAUI_GT_66
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
    gtrxreset_i_reg,
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
  input [0:0]gtrxreset_i_reg;
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
  wire gthe2_i_n_50;
  wire [0:0]gtrxreset_i_reg;
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
        .GTRXRESET(gtrxreset_i_reg),
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
        .TXPMARESETDONE(gthe2_i_n_50),
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
module XLAUI_XLAUI_GT_67
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
    gtrxreset_i_reg,
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
  input [0:0]gtrxreset_i_reg;
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
  wire gthe2_i_n_50;
  wire [0:0]gtrxreset_i_reg;
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
        .GTRXRESET(gtrxreset_i_reg),
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
        .TXPMARESETDONE(gthe2_i_n_50),
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
module XLAUI_XLAUI_RX_STARTUP_FSM
   (SR,
    GT0_RX_MMCM_RESET_OUT,
    GT0_RX_FSM_RESET_DONE_OUT,
    gt0_rxuserrdy_in,
    gt0_rx_cdrlocked_reg,
    RXOUTCLK,
    SYSCLK_IN,
    gt0_rxusrclk_in,
    SOFT_RESET_IN,
    DONT_RESET_ON_DATA_ERROR_IN,
    gt0_rx_cdrlocked_reg_0,
    gt0_rx_cdrlocked,
    data_in,
    gt0_rxresetdone_out,
    GT0_RX_MMCM_LOCK_IN,
    GT0_DATA_VALID_IN,
    GT0_QPLLLOCK_IN);
  output [0:0]SR;
  output GT0_RX_MMCM_RESET_OUT;
  output GT0_RX_FSM_RESET_DONE_OUT;
  output gt0_rxuserrdy_in;
  output gt0_rx_cdrlocked_reg;
  input RXOUTCLK;
  input SYSCLK_IN;
  input gt0_rxusrclk_in;
  input SOFT_RESET_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input gt0_rx_cdrlocked_reg_0;
  input gt0_rx_cdrlocked;
  input data_in;
  input gt0_rxresetdone_out;
  input GT0_RX_MMCM_LOCK_IN;
  input GT0_DATA_VALID_IN;
  input GT0_QPLLLOCK_IN;

  wire D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire \FSM_sequential_rx_state[0]_i_2_n_0 ;
  wire \FSM_sequential_rx_state[2]_i_1_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_5_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_6_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_8_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_9_n_0 ;
  wire GT0_DATA_VALID_IN;
  wire GT0_QPLLLOCK_IN;
  wire GT0_RX_FSM_RESET_DONE_OUT;
  wire GT0_RX_MMCM_LOCK_IN;
  wire GT0_RX_MMCM_RESET_OUT;
  wire RXOUTCLK;
  wire RXUSERRDY_i_1_n_0;
  wire SOFT_RESET_IN;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire check_tlock_max_i_1_n_0;
  wire check_tlock_max_reg_n_0;
  wire data_in;
  wire data_valid_sync;
  wire gt0_rx_cdrlocked;
  wire gt0_rx_cdrlocked_reg;
  wire gt0_rx_cdrlocked_reg_0;
  wire gt0_rxresetdone_out;
  wire gt0_rxuserrdy_in;
  wire gt0_rxusrclk_in;
  wire gtrxreset_i_i_1_n_0;
  wire gtrxreset_s;
  wire init_wait_count;
  wire \init_wait_count[6]_i_3__3_n_0 ;
  wire \init_wait_count[6]_i_4__3_n_0 ;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire init_wait_done_i_1__3_n_0;
  wire init_wait_done_reg_n_0;
  wire \mmcm_lock_count[7]_i_2__3_n_0 ;
  wire \mmcm_lock_count[7]_i_4__3_n_0 ;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_i_2__3_n_0;
  wire [6:0]p_0_in;
  wire [7:0]p_0_in__0;
  wire reset_time_out_i_4__3_n_0;
  wire reset_time_out_reg_n_0;
  wire run_phase_alignment_int_i_1__3_n_0;
  wire run_phase_alignment_int_reg_n_0;
  wire run_phase_alignment_int_s2;
  wire run_phase_alignment_int_s3_reg_n_0;
  wire rx_fsm_reset_done_int_s2;
  wire rx_fsm_reset_done_int_s3;
  (* RTL_KEEP = "yes" *) wire [3:0]rx_state;
  wire rx_state16_out;
  wire rxpmaresetdone_i;
  wire rxpmaresetdone_rx_s;
  wire rxresetdone_s2;
  wire rxresetdone_s3;
  wire sync_QPLLLOCK_n_0;
  wire sync_QPLLLOCK_n_1;
  wire sync_data_valid_n_1;
  wire sync_data_valid_n_2;
  wire sync_data_valid_n_3;
  wire sync_data_valid_n_4;
  wire sync_data_valid_n_5;
  wire sync_data_valid_n_6;
  wire sync_mmcm_lock_reclocked_n_0;
  wire sync_mmcm_lock_reclocked_n_1;
  wire sync_rxpmaresetdone_n_0;
  wire sync_rxpmaresetdone_n_1;
  wire time_out_1us_i_1__2_n_0;
  wire time_out_1us_i_2_n_0;
  wire time_out_1us_i_3__1_n_0;
  wire time_out_1us_i_4_n_0;
  wire time_out_1us_reg_n_0;
  wire time_out_2ms_i_1_n_0;
  wire time_out_2ms_i_2_n_0;
  wire time_out_2ms_reg_n_0;
  wire time_out_500us_i_1_n_0;
  wire time_out_500us_i_2__3_n_0;
  wire time_out_500us_i_3__3_n_0;
  wire time_out_500us_i_4_n_0;
  wire time_out_500us_i_5_n_0;
  wire time_out_500us_reg_n_0;
  wire time_out_counter;
  wire \time_out_counter[0]_i_10__3_n_0 ;
  wire \time_out_counter[0]_i_3__3_n_0 ;
  wire \time_out_counter[0]_i_4__0_n_0 ;
  wire \time_out_counter[0]_i_8_n_0 ;
  wire \time_out_counter[0]_i_9__4_n_0 ;
  wire [18:0]time_out_counter_reg;
  wire \time_out_counter_reg[0]_i_2__3_n_0 ;
  wire \time_out_counter_reg[0]_i_2__3_n_1 ;
  wire \time_out_counter_reg[0]_i_2__3_n_2 ;
  wire \time_out_counter_reg[0]_i_2__3_n_3 ;
  wire \time_out_counter_reg[0]_i_2__3_n_4 ;
  wire \time_out_counter_reg[0]_i_2__3_n_5 ;
  wire \time_out_counter_reg[0]_i_2__3_n_6 ;
  wire \time_out_counter_reg[0]_i_2__3_n_7 ;
  wire \time_out_counter_reg[12]_i_1__3_n_0 ;
  wire \time_out_counter_reg[12]_i_1__3_n_1 ;
  wire \time_out_counter_reg[12]_i_1__3_n_2 ;
  wire \time_out_counter_reg[12]_i_1__3_n_3 ;
  wire \time_out_counter_reg[12]_i_1__3_n_4 ;
  wire \time_out_counter_reg[12]_i_1__3_n_5 ;
  wire \time_out_counter_reg[12]_i_1__3_n_6 ;
  wire \time_out_counter_reg[12]_i_1__3_n_7 ;
  wire \time_out_counter_reg[16]_i_1__3_n_2 ;
  wire \time_out_counter_reg[16]_i_1__3_n_3 ;
  wire \time_out_counter_reg[16]_i_1__3_n_5 ;
  wire \time_out_counter_reg[16]_i_1__3_n_6 ;
  wire \time_out_counter_reg[16]_i_1__3_n_7 ;
  wire \time_out_counter_reg[4]_i_1__3_n_0 ;
  wire \time_out_counter_reg[4]_i_1__3_n_1 ;
  wire \time_out_counter_reg[4]_i_1__3_n_2 ;
  wire \time_out_counter_reg[4]_i_1__3_n_3 ;
  wire \time_out_counter_reg[4]_i_1__3_n_4 ;
  wire \time_out_counter_reg[4]_i_1__3_n_5 ;
  wire \time_out_counter_reg[4]_i_1__3_n_6 ;
  wire \time_out_counter_reg[4]_i_1__3_n_7 ;
  wire \time_out_counter_reg[8]_i_1__3_n_0 ;
  wire \time_out_counter_reg[8]_i_1__3_n_1 ;
  wire \time_out_counter_reg[8]_i_1__3_n_2 ;
  wire \time_out_counter_reg[8]_i_1__3_n_3 ;
  wire \time_out_counter_reg[8]_i_1__3_n_4 ;
  wire \time_out_counter_reg[8]_i_1__3_n_5 ;
  wire \time_out_counter_reg[8]_i_1__3_n_6 ;
  wire \time_out_counter_reg[8]_i_1__3_n_7 ;
  wire time_out_wait_bypass_i_1__3_n_0;
  wire time_out_wait_bypass_reg_n_0;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire time_tlock_max1;
  wire time_tlock_max1_carry__0_i_1_n_0;
  wire time_tlock_max1_carry__0_i_2_n_0;
  wire time_tlock_max1_carry__0_i_3_n_0;
  wire time_tlock_max1_carry__0_i_4_n_0;
  wire time_tlock_max1_carry__0_i_5_n_0;
  wire time_tlock_max1_carry__0_i_6__1_n_0;
  wire time_tlock_max1_carry__0_n_0;
  wire time_tlock_max1_carry__0_n_1;
  wire time_tlock_max1_carry__0_n_2;
  wire time_tlock_max1_carry__0_n_3;
  wire time_tlock_max1_carry__1_i_1_n_0;
  wire time_tlock_max1_carry__1_i_2_n_0;
  wire time_tlock_max1_carry__1_i_3_n_0;
  wire time_tlock_max1_carry__1_n_3;
  wire time_tlock_max1_carry_i_1_n_0;
  wire time_tlock_max1_carry_i_2_n_0;
  wire time_tlock_max1_carry_i_3_n_0;
  wire time_tlock_max1_carry_i_4_n_0;
  wire time_tlock_max1_carry_i_5_n_0;
  wire time_tlock_max1_carry_i_6_n_0;
  wire time_tlock_max1_carry_i_7_n_0;
  wire time_tlock_max1_carry_n_0;
  wire time_tlock_max1_carry_n_1;
  wire time_tlock_max1_carry_n_2;
  wire time_tlock_max1_carry_n_3;
  wire time_tlock_max_i_1_n_0;
  wire \wait_bypass_count[0]_i_10__3_n_0 ;
  wire \wait_bypass_count[0]_i_1__3_n_0 ;
  wire \wait_bypass_count[0]_i_2__3_n_0 ;
  wire \wait_bypass_count[0]_i_4__3_n_0 ;
  wire \wait_bypass_count[0]_i_8__3_n_0 ;
  wire \wait_bypass_count[0]_i_9__3_n_0 ;
  wire [12:0]wait_bypass_count_reg;
  wire \wait_bypass_count_reg[0]_i_3__3_n_0 ;
  wire \wait_bypass_count_reg[0]_i_3__3_n_1 ;
  wire \wait_bypass_count_reg[0]_i_3__3_n_2 ;
  wire \wait_bypass_count_reg[0]_i_3__3_n_3 ;
  wire \wait_bypass_count_reg[0]_i_3__3_n_4 ;
  wire \wait_bypass_count_reg[0]_i_3__3_n_5 ;
  wire \wait_bypass_count_reg[0]_i_3__3_n_6 ;
  wire \wait_bypass_count_reg[0]_i_3__3_n_7 ;
  wire \wait_bypass_count_reg[12]_i_1__3_n_7 ;
  wire \wait_bypass_count_reg[4]_i_1__3_n_0 ;
  wire \wait_bypass_count_reg[4]_i_1__3_n_1 ;
  wire \wait_bypass_count_reg[4]_i_1__3_n_2 ;
  wire \wait_bypass_count_reg[4]_i_1__3_n_3 ;
  wire \wait_bypass_count_reg[4]_i_1__3_n_4 ;
  wire \wait_bypass_count_reg[4]_i_1__3_n_5 ;
  wire \wait_bypass_count_reg[4]_i_1__3_n_6 ;
  wire \wait_bypass_count_reg[4]_i_1__3_n_7 ;
  wire \wait_bypass_count_reg[8]_i_1__3_n_0 ;
  wire \wait_bypass_count_reg[8]_i_1__3_n_1 ;
  wire \wait_bypass_count_reg[8]_i_1__3_n_2 ;
  wire \wait_bypass_count_reg[8]_i_1__3_n_3 ;
  wire \wait_bypass_count_reg[8]_i_1__3_n_4 ;
  wire \wait_bypass_count_reg[8]_i_1__3_n_5 ;
  wire \wait_bypass_count_reg[8]_i_1__3_n_6 ;
  wire \wait_bypass_count_reg[8]_i_1__3_n_7 ;
  wire [6:0]wait_time_cnt0;
  wire \wait_time_cnt[1]_i_1__3_n_0 ;
  wire \wait_time_cnt[4]_i_1__3_n_0 ;
  wire \wait_time_cnt[6]_i_1__3_n_0 ;
  wire \wait_time_cnt[6]_i_2__3_n_0 ;
  wire \wait_time_cnt[6]_i_4__3_n_0 ;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__3_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__3_O_UNCONNECTED ;
  wire [3:0]NLW_time_tlock_max1_carry_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max1_carry__0_O_UNCONNECTED;
  wire [3:2]NLW_time_tlock_max1_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max1_carry__1_O_UNCONNECTED;
  wire [3:0]\NLW_wait_bypass_count_reg[12]_i_1__3_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[12]_i_1__3_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h08B80888FFFFFFFF)) 
    \FSM_sequential_rx_state[0]_i_2 
       (.I0(time_out_2ms_reg_n_0),
        .I1(rx_state[1]),
        .I2(rx_state[2]),
        .I3(reset_time_out_reg_n_0),
        .I4(time_tlock_max),
        .I5(rx_state[0]),
        .O(\FSM_sequential_rx_state[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000262226AA)) 
    \FSM_sequential_rx_state[2]_i_1 
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(time_out_2ms_reg_n_0),
        .I3(rx_state[1]),
        .I4(rx_state16_out),
        .I5(rx_state[3]),
        .O(\FSM_sequential_rx_state[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_rx_state[2]_i_2 
       (.I0(time_tlock_max),
        .I1(reset_time_out_reg_n_0),
        .O(rx_state16_out));
  LUT6 #(
    .INIT(64'h00F0BBBB00F08888)) 
    \FSM_sequential_rx_state[3]_i_5 
       (.I0(gt0_rx_cdrlocked_reg_0),
        .I1(rx_state[2]),
        .I2(\FSM_sequential_rx_state[3]_i_9_n_0 ),
        .I3(wait_time_cnt_reg__0[6]),
        .I4(rx_state[1]),
        .I5(init_wait_done_reg_n_0),
        .O(\FSM_sequential_rx_state[3]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h80880000)) 
    \FSM_sequential_rx_state[3]_i_6 
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(reset_time_out_reg_n_0),
        .I3(time_out_2ms_reg_n_0),
        .I4(rx_state[0]),
        .O(\FSM_sequential_rx_state[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0EFEFAFA0EFE0)) 
    \FSM_sequential_rx_state[3]_i_8 
       (.I0(rxresetdone_s3),
        .I1(time_out_2ms_reg_n_0),
        .I2(rx_state[1]),
        .I3(mmcm_lock_reclocked),
        .I4(reset_time_out_reg_n_0),
        .I5(time_tlock_max),
        .O(\FSM_sequential_rx_state[3]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_sequential_rx_state[3]_i_9 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[4]),
        .I5(wait_time_cnt_reg__0[5]),
        .O(\FSM_sequential_rx_state[3]_i_9_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_5),
        .Q(rx_state[0]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_4),
        .Q(rx_state[1]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(\FSM_sequential_rx_state[2]_i_1_n_0 ),
        .Q(rx_state[2]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_3),
        .Q(rx_state[3]),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFD0080)) 
    RXUSERRDY_i_1
       (.I0(rx_state[0]),
        .I1(rx_state[2]),
        .I2(rx_state[1]),
        .I3(rx_state[3]),
        .I4(gt0_rxuserrdy_in),
        .O(RXUSERRDY_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    RXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(RXUSERRDY_i_1_n_0),
        .Q(gt0_rxuserrdy_in),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    check_tlock_max_i_1
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .I3(rx_state[3]),
        .I4(check_tlock_max_reg_n_0),
        .O(check_tlock_max_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    check_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(check_tlock_max_i_1_n_0),
        .Q(check_tlock_max_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT3 #(
    .INIT(8'h0E)) 
    gt0_rx_cdrlocked_i_1
       (.I0(gt0_rx_cdrlocked_reg_0),
        .I1(gt0_rx_cdrlocked),
        .I2(SR),
        .O(gt0_rx_cdrlocked_reg));
  LUT5 #(
    .INIT(32'hFFFB0010)) 
    gtrxreset_i_i_1
       (.I0(rx_state[1]),
        .I1(rx_state[2]),
        .I2(rx_state[0]),
        .I3(rx_state[3]),
        .I4(SR),
        .O(gtrxreset_i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    gtrxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gtrxreset_i_i_1_n_0),
        .Q(SR),
        .R(SOFT_RESET_IN));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \init_wait_count[0]_i_1__3 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \init_wait_count[1]_i_1__3 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \init_wait_count[2]_i_1__3 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \init_wait_count[3]_i_1__3 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \init_wait_count[4]_i_1__3 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \init_wait_count[5]_i_1__3 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
    \init_wait_count[6]_i_1__3 
       (.I0(\init_wait_count[6]_i_3__3_n_0 ),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_count));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h9AAAAAAA)) 
    \init_wait_count[6]_i_2__3 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\init_wait_count[6]_i_4__3_n_0 ),
        .I2(init_wait_count_reg__0[4]),
        .I3(init_wait_count_reg__0[3]),
        .I4(init_wait_count_reg__0[5]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \init_wait_count[6]_i_3__3 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(\init_wait_count[6]_i_3__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \init_wait_count[6]_i_4__3 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(\init_wait_count[6]_i_4__3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[0]),
        .Q(init_wait_count_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
  LUT2 #(
    .INIT(4'hE)) 
    init_wait_done_i_1__3
       (.I0(init_wait_done),
        .I1(init_wait_done_reg_n_0),
        .O(init_wait_done_i_1__3_n_0));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    init_wait_done_i_2__3
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\init_wait_count[6]_i_3__3_n_0 ),
        .O(init_wait_done));
  FDCE #(
    .INIT(1'b0)) 
    init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(init_wait_done_i_1__3_n_0),
        .Q(init_wait_done_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[0]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \mmcm_lock_count[1]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \mmcm_lock_count[2]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \mmcm_lock_count[3]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[4]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[2]),
        .I4(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \mmcm_lock_count[5]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \mmcm_lock_count[6]_i_1__3 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__3_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__0[6]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \mmcm_lock_count[7]_i_2__3 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__3_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(\mmcm_lock_count[7]_i_2__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[7]_i_3__3 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(mmcm_lock_count_reg__0[5]),
        .I2(\mmcm_lock_count[7]_i_4__3_n_0 ),
        .I3(mmcm_lock_count_reg__0[4]),
        .I4(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \mmcm_lock_count[7]_i_4__3 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .O(\mmcm_lock_count[7]_i_4__3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__3_n_0 ),
        .D(p_0_in__0[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__3_n_0 ),
        .D(p_0_in__0[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__3_n_0 ),
        .D(p_0_in__0[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__3_n_0 ),
        .D(p_0_in__0[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__3_n_0 ),
        .D(p_0_in__0[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__3_n_0 ),
        .D(p_0_in__0[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__3_n_0 ),
        .D(p_0_in__0[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__3_n_0 ),
        .D(p_0_in__0[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(sync_mmcm_lock_reclocked_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    mmcm_lock_reclocked_i_2__3
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(mmcm_lock_reclocked_i_2__3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_mmcm_lock_reclocked_n_1),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    mmcm_reset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_rxpmaresetdone_n_0),
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
        .Q(gtrxreset_s));
  LUT3 #(
    .INIT(8'h07)) 
    reset_time_out_i_4__3
       (.I0(rx_state[1]),
        .I1(rx_state[0]),
        .I2(rx_state[2]),
        .O(reset_time_out_i_4__3_n_0));
  FDSE #(
    .INIT(1'b0)) 
    reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_data_valid_n_1),
        .Q(reset_time_out_reg_n_0),
        .S(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFEFF0002)) 
    run_phase_alignment_int_i_1__3
       (.I0(rx_state[3]),
        .I1(rx_state[2]),
        .I2(rx_state[1]),
        .I3(rx_state[0]),
        .I4(run_phase_alignment_int_reg_n_0),
        .O(run_phase_alignment_int_i_1__3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(run_phase_alignment_int_i_1__3_n_0),
        .Q(run_phase_alignment_int_reg_n_0),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_s3_reg
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(run_phase_alignment_int_s2),
        .Q(run_phase_alignment_int_s3_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    rx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_data_valid_n_2),
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
        .CLR(gtrxreset_s),
        .D(rxpmaresetdone_rx_s),
        .Q(rxpmaresetdone_i));
  FDRE #(
    .INIT(1'b0)) 
    rxresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(rxresetdone_s2),
        .Q(rxresetdone_s3),
        .R(1'b0));
  XLAUI_XLAUI_sync_block_56 sync_QPLLLOCK
       (.\FSM_sequential_rx_state_reg[0] (sync_QPLLLOCK_n_0),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .data_out(data_valid_sync),
        .gt0_rx_cdrlocked_reg(gt0_rx_cdrlocked_reg_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state[2:0]),
        .reset_time_out_reg(sync_QPLLLOCK_n_1),
        .rxresetdone_s3(rxresetdone_s3),
        .rxresetdone_s3_reg(\FSM_sequential_rx_state[3]_i_8_n_0 ),
        .time_out_2ms_reg(time_out_2ms_reg_n_0));
  XLAUI_XLAUI_sync_block_57 sync_RXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(rxresetdone_s2),
        .gt0_rxresetdone_out(gt0_rxresetdone_out));
  XLAUI_XLAUI_sync_block_58 sync_data_valid
       (.D({sync_data_valid_n_3,sync_data_valid_n_4,sync_data_valid_n_5}),
        .DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .E(sync_data_valid_n_6),
        .\FSM_sequential_rx_state_reg[0] (sync_QPLLLOCK_n_1),
        .\FSM_sequential_rx_state_reg[1] (reset_time_out_i_4__3_n_0),
        .\FSM_sequential_rx_state_reg[2] (sync_QPLLLOCK_n_0),
        .\FSM_sequential_rx_state_reg[2]_0 (\FSM_sequential_rx_state[3]_i_6_n_0 ),
        .GT0_DATA_VALID_IN(GT0_DATA_VALID_IN),
        .GT0_RX_FSM_RESET_DONE_OUT(GT0_RX_FSM_RESET_DONE_OUT),
        .SYSCLK_IN(SYSCLK_IN),
        .data_out(data_valid_sync),
        .gt0_rx_cdrlocked_reg(\FSM_sequential_rx_state[3]_i_5_n_0 ),
        .mmcm_lock_reclocked_reg(sync_rxpmaresetdone_n_1),
        .out(rx_state),
        .reset_time_out_reg(sync_data_valid_n_1),
        .reset_time_out_reg_0(reset_time_out_reg_n_0),
        .rx_fsm_reset_done_int_reg(sync_data_valid_n_2),
        .rx_state16_out(rx_state16_out),
        .time_out_1us_reg(time_out_1us_reg_n_0),
        .time_out_2ms_reg(\FSM_sequential_rx_state[0]_i_2_n_0 ),
        .time_out_500us_reg(time_out_500us_reg_n_0),
        .time_out_wait_bypass_s3(time_out_wait_bypass_s3));
  XLAUI_XLAUI_sync_block_59 sync_mmcm_lock_reclocked
       (.GT0_RX_MMCM_LOCK_IN(GT0_RX_MMCM_LOCK_IN),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(sync_mmcm_lock_reclocked_n_0),
        .SYSCLK_IN(SYSCLK_IN),
        .\mmcm_lock_count_reg[5] (mmcm_lock_reclocked_i_2__3_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_lock_reclocked_reg(sync_mmcm_lock_reclocked_n_1));
  XLAUI_XLAUI_sync_block_60 sync_run_phase_alignment_int
       (.data_in(run_phase_alignment_int_reg_n_0),
        .data_out(run_phase_alignment_int_s2),
        .gt0_rxusrclk_in(gt0_rxusrclk_in));
  XLAUI_XLAUI_sync_block_61 sync_rx_fsm_reset_done_int
       (.GT0_RX_FSM_RESET_DONE_OUT(GT0_RX_FSM_RESET_DONE_OUT),
        .data_out(rx_fsm_reset_done_int_s2),
        .gt0_rxusrclk_in(gt0_rxusrclk_in));
  XLAUI_XLAUI_sync_block_62 sync_rxpmaresetdone
       (.GT0_RX_MMCM_RESET_OUT(GT0_RX_MMCM_RESET_OUT),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(rxpmaresetdone_i),
        .gt0_rx_cdrlocked_reg(gt0_rx_cdrlocked_reg_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_reset_i_reg(sync_rxpmaresetdone_n_0),
        .out(rx_state),
        .reset_time_out_reg(sync_rxpmaresetdone_n_1));
  XLAUI_XLAUI_sync_block_63 sync_rxpmaresetdone_rx_s
       (.RXOUTCLK(RXOUTCLK),
        .data_in(data_in),
        .data_out(rxpmaresetdone_rx_s));
  XLAUI_XLAUI_sync_block_64 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(time_out_wait_bypass_reg_n_0),
        .data_out(time_out_wait_bypass_s2));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000004)) 
    time_out_1us_i_1__2
       (.I0(time_out_1us_i_2_n_0),
        .I1(\time_out_counter[0]_i_4__0_n_0 ),
        .I2(time_out_counter_reg[6]),
        .I3(time_out_counter_reg[9]),
        .I4(time_out_1us_i_3__1_n_0),
        .I5(time_out_1us_reg_n_0),
        .O(time_out_1us_i_1__2_n_0));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    time_out_1us_i_2
       (.I0(time_out_500us_i_5_n_0),
        .I1(time_out_1us_i_4_n_0),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_counter_reg[5]),
        .I4(time_out_counter_reg[0]),
        .O(time_out_1us_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'hE)) 
    time_out_1us_i_3__1
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[13]),
        .O(time_out_1us_i_3__1_n_0));
  LUT4 #(
    .INIT(16'hFFFD)) 
    time_out_1us_i_4
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[16]),
        .O(time_out_1us_i_4_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_1us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_1us_i_1__2_n_0),
        .Q(time_out_1us_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000040)) 
    time_out_2ms_i_1
       (.I0(\time_out_counter[0]_i_3__3_n_0 ),
        .I1(\time_out_counter[0]_i_4__0_n_0 ),
        .I2(time_out_2ms_i_2_n_0),
        .I3(time_out_counter_reg[1]),
        .I4(time_out_counter_reg[15]),
        .I5(time_out_2ms_reg_n_0),
        .O(time_out_2ms_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h1)) 
    time_out_2ms_i_2
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(time_out_2ms_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_2ms_i_1_n_0),
        .Q(time_out_2ms_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000040)) 
    time_out_500us_i_1
       (.I0(time_out_500us_i_2__3_n_0),
        .I1(time_out_500us_i_3__3_n_0),
        .I2(time_out_500us_i_4_n_0),
        .I3(time_out_counter_reg[1]),
        .I4(time_out_counter_reg[15]),
        .I5(time_out_500us_reg_n_0),
        .O(time_out_500us_i_1_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFEF)) 
    time_out_500us_i_2__3
       (.I0(time_out_500us_i_5_n_0),
        .I1(time_out_counter_reg[18]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[17]),
        .I4(\time_out_counter[0]_i_9__4_n_0 ),
        .O(time_out_500us_i_2__3_n_0));
  LUT4 #(
    .INIT(16'h0080)) 
    time_out_500us_i_3__3
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[6]),
        .O(time_out_500us_i_3__3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    time_out_500us_i_4
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .O(time_out_500us_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hFFFD)) 
    time_out_500us_i_5
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[11]),
        .I3(time_out_counter_reg[4]),
        .O(time_out_500us_i_5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_500us_i_1_n_0),
        .Q(time_out_500us_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFB)) 
    \time_out_counter[0]_i_1 
       (.I0(\time_out_counter[0]_i_3__3_n_0 ),
        .I1(\time_out_counter[0]_i_4__0_n_0 ),
        .I2(time_out_counter_reg[6]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[1]),
        .I5(time_out_counter_reg[15]),
        .O(time_out_counter));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \time_out_counter[0]_i_10__3 
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[11]),
        .O(\time_out_counter[0]_i_10__3_n_0 ));
  LUT5 #(
    .INIT(32'hEFFFFFFF)) 
    \time_out_counter[0]_i_3__3 
       (.I0(\time_out_counter[0]_i_9__4_n_0 ),
        .I1(\time_out_counter[0]_i_10__3_n_0 ),
        .I2(time_out_counter_reg[12]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[4]),
        .O(\time_out_counter[0]_i_3__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \time_out_counter[0]_i_4__0 
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[2]),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[14]),
        .O(\time_out_counter[0]_i_4__0_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_8 
       (.I0(time_out_counter_reg[0]),
        .O(\time_out_counter[0]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hFFEF)) 
    \time_out_counter[0]_i_9__4 
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[16]),
        .I3(time_out_counter_reg[5]),
        .O(\time_out_counter[0]_i_9__4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__3_n_7 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[0]_i_2__3 
       (.CI(1'b0),
        .CO({\time_out_counter_reg[0]_i_2__3_n_0 ,\time_out_counter_reg[0]_i_2__3_n_1 ,\time_out_counter_reg[0]_i_2__3_n_2 ,\time_out_counter_reg[0]_i_2__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\time_out_counter_reg[0]_i_2__3_n_4 ,\time_out_counter_reg[0]_i_2__3_n_5 ,\time_out_counter_reg[0]_i_2__3_n_6 ,\time_out_counter_reg[0]_i_2__3_n_7 }),
        .S({time_out_counter_reg[3:1],\time_out_counter[0]_i_8_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__3_n_5 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__3_n_4 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__3_n_7 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[12]_i_1__3 
       (.CI(\time_out_counter_reg[8]_i_1__3_n_0 ),
        .CO({\time_out_counter_reg[12]_i_1__3_n_0 ,\time_out_counter_reg[12]_i_1__3_n_1 ,\time_out_counter_reg[12]_i_1__3_n_2 ,\time_out_counter_reg[12]_i_1__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[12]_i_1__3_n_4 ,\time_out_counter_reg[12]_i_1__3_n_5 ,\time_out_counter_reg[12]_i_1__3_n_6 ,\time_out_counter_reg[12]_i_1__3_n_7 }),
        .S(time_out_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__3_n_6 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__3_n_5 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__3_n_4 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__3_n_7 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[16]_i_1__3 
       (.CI(\time_out_counter_reg[12]_i_1__3_n_0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__3_CO_UNCONNECTED [3:2],\time_out_counter_reg[16]_i_1__3_n_2 ,\time_out_counter_reg[16]_i_1__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__3_O_UNCONNECTED [3],\time_out_counter_reg[16]_i_1__3_n_5 ,\time_out_counter_reg[16]_i_1__3_n_6 ,\time_out_counter_reg[16]_i_1__3_n_7 }),
        .S({1'b0,time_out_counter_reg[18:16]}));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__3_n_6 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__3_n_5 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__3_n_6 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__3_n_5 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__3_n_4 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__3_n_7 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[4]_i_1__3 
       (.CI(\time_out_counter_reg[0]_i_2__3_n_0 ),
        .CO({\time_out_counter_reg[4]_i_1__3_n_0 ,\time_out_counter_reg[4]_i_1__3_n_1 ,\time_out_counter_reg[4]_i_1__3_n_2 ,\time_out_counter_reg[4]_i_1__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[4]_i_1__3_n_4 ,\time_out_counter_reg[4]_i_1__3_n_5 ,\time_out_counter_reg[4]_i_1__3_n_6 ,\time_out_counter_reg[4]_i_1__3_n_7 }),
        .S(time_out_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__3_n_6 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__3_n_5 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__3_n_4 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__3_n_7 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[8]_i_1__3 
       (.CI(\time_out_counter_reg[4]_i_1__3_n_0 ),
        .CO({\time_out_counter_reg[8]_i_1__3_n_0 ,\time_out_counter_reg[8]_i_1__3_n_1 ,\time_out_counter_reg[8]_i_1__3_n_2 ,\time_out_counter_reg[8]_i_1__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[8]_i_1__3_n_4 ,\time_out_counter_reg[8]_i_1__3_n_5 ,\time_out_counter_reg[8]_i_1__3_n_6 ,\time_out_counter_reg[8]_i_1__3_n_7 }),
        .S(time_out_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__3_n_6 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out_reg_n_0));
  LUT4 #(
    .INIT(16'hAB00)) 
    time_out_wait_bypass_i_1__3
       (.I0(time_out_wait_bypass_reg_n_0),
        .I1(rx_fsm_reset_done_int_s3),
        .I2(\wait_bypass_count[0]_i_4__3_n_0 ),
        .I3(run_phase_alignment_int_s3_reg_n_0),
        .O(time_out_wait_bypass_i_1__3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_reg
       (.C(gt0_rxusrclk_in),
        .CE(1'b1),
        .D(time_out_wait_bypass_i_1__3_n_0),
        .Q(time_out_wait_bypass_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
  CARRY4 time_tlock_max1_carry
       (.CI(1'b0),
        .CO({time_tlock_max1_carry_n_0,time_tlock_max1_carry_n_1,time_tlock_max1_carry_n_2,time_tlock_max1_carry_n_3}),
        .CYINIT(1'b0),
        .DI({time_tlock_max1_carry_i_1_n_0,time_out_counter_reg[5],time_tlock_max1_carry_i_2_n_0,time_tlock_max1_carry_i_3_n_0}),
        .O(NLW_time_tlock_max1_carry_O_UNCONNECTED[3:0]),
        .S({time_tlock_max1_carry_i_4_n_0,time_tlock_max1_carry_i_5_n_0,time_tlock_max1_carry_i_6_n_0,time_tlock_max1_carry_i_7_n_0}));
  CARRY4 time_tlock_max1_carry__0
       (.CI(time_tlock_max1_carry_n_0),
        .CO({time_tlock_max1_carry__0_n_0,time_tlock_max1_carry__0_n_1,time_tlock_max1_carry__0_n_2,time_tlock_max1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({time_out_counter_reg[15],time_tlock_max1_carry__0_i_1_n_0,time_tlock_max1_carry__0_i_2_n_0,time_out_counter_reg[9]}),
        .O(NLW_time_tlock_max1_carry__0_O_UNCONNECTED[3:0]),
        .S({time_tlock_max1_carry__0_i_3_n_0,time_tlock_max1_carry__0_i_4_n_0,time_tlock_max1_carry__0_i_5_n_0,time_tlock_max1_carry__0_i_6__1_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__0_i_1
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .O(time_tlock_max1_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__0_i_2
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[10]),
        .O(time_tlock_max1_carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry__0_i_3
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[15]),
        .O(time_tlock_max1_carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__0_i_4
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(time_tlock_max1_carry__0_i_4_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__0_i_5
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(time_tlock_max1_carry__0_i_5_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry__0_i_6__1
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .O(time_tlock_max1_carry__0_i_6__1_n_0));
  CARRY4 time_tlock_max1_carry__1
       (.CI(time_tlock_max1_carry__0_n_0),
        .CO({NLW_time_tlock_max1_carry__1_CO_UNCONNECTED[3:2],time_tlock_max1,time_tlock_max1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,time_out_counter_reg[18],time_tlock_max1_carry__1_i_1_n_0}),
        .O(NLW_time_tlock_max1_carry__1_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,time_tlock_max1_carry__1_i_2_n_0,time_tlock_max1_carry__1_i_3_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__1_i_1
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[16]),
        .O(time_tlock_max1_carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    time_tlock_max1_carry__1_i_2
       (.I0(time_out_counter_reg[18]),
        .O(time_tlock_max1_carry__1_i_2_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__1_i_3
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(time_tlock_max1_carry__1_i_3_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry_i_1
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[6]),
        .O(time_tlock_max1_carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    time_tlock_max1_carry_i_2
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(time_tlock_max1_carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    time_tlock_max1_carry_i_3
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(time_tlock_max1_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry_i_4
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(time_tlock_max1_carry_i_4_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_5
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[5]),
        .O(time_tlock_max1_carry_i_5_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_6
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(time_tlock_max1_carry_i_6_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_7
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(time_tlock_max1_carry_i_7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    time_tlock_max_i_1
       (.I0(time_tlock_max1),
        .I1(check_tlock_max_reg_n_0),
        .I2(time_tlock_max),
        .O(time_tlock_max_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_tlock_max_i_1_n_0),
        .Q(time_tlock_max),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \wait_bypass_count[0]_i_10__3 
       (.I0(wait_bypass_count_reg[2]),
        .I1(wait_bypass_count_reg[12]),
        .I2(wait_bypass_count_reg[4]),
        .I3(wait_bypass_count_reg[10]),
        .I4(wait_bypass_count_reg[6]),
        .I5(wait_bypass_count_reg[11]),
        .O(\wait_bypass_count[0]_i_10__3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_1__3 
       (.I0(run_phase_alignment_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_1__3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \wait_bypass_count[0]_i_2__3 
       (.I0(\wait_bypass_count[0]_i_4__3_n_0 ),
        .I1(rx_fsm_reset_done_int_s3),
        .O(\wait_bypass_count[0]_i_2__3_n_0 ));
  LUT5 #(
    .INIT(32'hBFFFFFFF)) 
    \wait_bypass_count[0]_i_4__3 
       (.I0(\wait_bypass_count[0]_i_9__3_n_0 ),
        .I1(wait_bypass_count_reg[1]),
        .I2(wait_bypass_count_reg[8]),
        .I3(wait_bypass_count_reg[0]),
        .I4(\wait_bypass_count[0]_i_10__3_n_0 ),
        .O(\wait_bypass_count[0]_i_4__3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_8__3 
       (.I0(wait_bypass_count_reg[0]),
        .O(\wait_bypass_count[0]_i_8__3_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \wait_bypass_count[0]_i_9__3 
       (.I0(wait_bypass_count_reg[3]),
        .I1(wait_bypass_count_reg[5]),
        .I2(wait_bypass_count_reg[9]),
        .I3(wait_bypass_count_reg[7]),
        .O(\wait_bypass_count[0]_i_9__3_n_0 ));
  FDRE \wait_bypass_count_reg[0] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__3_n_7 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  CARRY4 \wait_bypass_count_reg[0]_i_3__3 
       (.CI(1'b0),
        .CO({\wait_bypass_count_reg[0]_i_3__3_n_0 ,\wait_bypass_count_reg[0]_i_3__3_n_1 ,\wait_bypass_count_reg[0]_i_3__3_n_2 ,\wait_bypass_count_reg[0]_i_3__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\wait_bypass_count_reg[0]_i_3__3_n_4 ,\wait_bypass_count_reg[0]_i_3__3_n_5 ,\wait_bypass_count_reg[0]_i_3__3_n_6 ,\wait_bypass_count_reg[0]_i_3__3_n_7 }),
        .S({wait_bypass_count_reg[3:1],\wait_bypass_count[0]_i_8__3_n_0 }));
  FDRE \wait_bypass_count_reg[10] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__3_n_5 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  FDRE \wait_bypass_count_reg[11] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__3_n_4 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  FDRE \wait_bypass_count_reg[12] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__3_n_7 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  CARRY4 \wait_bypass_count_reg[12]_i_1__3 
       (.CI(\wait_bypass_count_reg[8]_i_1__3_n_0 ),
        .CO(\NLW_wait_bypass_count_reg[12]_i_1__3_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[12]_i_1__3_O_UNCONNECTED [3:1],\wait_bypass_count_reg[12]_i_1__3_n_7 }),
        .S({1'b0,1'b0,1'b0,wait_bypass_count_reg[12]}));
  FDRE \wait_bypass_count_reg[1] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__3_n_6 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  FDRE \wait_bypass_count_reg[2] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__3_n_5 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  FDRE \wait_bypass_count_reg[3] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__3_n_4 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  FDRE \wait_bypass_count_reg[4] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__3_n_7 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  CARRY4 \wait_bypass_count_reg[4]_i_1__3 
       (.CI(\wait_bypass_count_reg[0]_i_3__3_n_0 ),
        .CO({\wait_bypass_count_reg[4]_i_1__3_n_0 ,\wait_bypass_count_reg[4]_i_1__3_n_1 ,\wait_bypass_count_reg[4]_i_1__3_n_2 ,\wait_bypass_count_reg[4]_i_1__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[4]_i_1__3_n_4 ,\wait_bypass_count_reg[4]_i_1__3_n_5 ,\wait_bypass_count_reg[4]_i_1__3_n_6 ,\wait_bypass_count_reg[4]_i_1__3_n_7 }),
        .S(wait_bypass_count_reg[7:4]));
  FDRE \wait_bypass_count_reg[5] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__3_n_6 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  FDRE \wait_bypass_count_reg[6] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__3_n_5 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  FDRE \wait_bypass_count_reg[7] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__3_n_4 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  FDRE \wait_bypass_count_reg[8] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__3_n_7 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  CARRY4 \wait_bypass_count_reg[8]_i_1__3 
       (.CI(\wait_bypass_count_reg[4]_i_1__3_n_0 ),
        .CO({\wait_bypass_count_reg[8]_i_1__3_n_0 ,\wait_bypass_count_reg[8]_i_1__3_n_1 ,\wait_bypass_count_reg[8]_i_1__3_n_2 ,\wait_bypass_count_reg[8]_i_1__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[8]_i_1__3_n_4 ,\wait_bypass_count_reg[8]_i_1__3_n_5 ,\wait_bypass_count_reg[8]_i_1__3_n_6 ,\wait_bypass_count_reg[8]_i_1__3_n_7 }),
        .S(wait_bypass_count_reg[11:8]));
  FDRE \wait_bypass_count_reg[9] 
       (.C(gt0_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__3_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__3_n_6 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\wait_bypass_count[0]_i_1__3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_time_cnt[0]_i_1__3 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \wait_time_cnt[1]_i_1__3 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\wait_time_cnt[1]_i_1__3_n_0 ));
  LUT3 #(
    .INIT(8'hE1)) 
    \wait_time_cnt[2]_i_1__3 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[2]),
        .O(wait_time_cnt0[2]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \wait_time_cnt[3]_i_1__3 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0[3]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \wait_time_cnt[4]_i_1__3 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\wait_time_cnt[4]_i_1__3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
    \wait_time_cnt[5]_i_1__3 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[5]));
  LUT3 #(
    .INIT(8'h10)) 
    \wait_time_cnt[6]_i_1__3 
       (.I0(rx_state[3]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .O(\wait_time_cnt[6]_i_1__3_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_2__3 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\wait_time_cnt[6]_i_4__3_n_0 ),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(wait_time_cnt_reg__0[5]),
        .O(\wait_time_cnt[6]_i_2__3_n_0 ));
  LUT4 #(
    .INIT(16'hAAA9)) 
    \wait_time_cnt[6]_i_3__3 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(\wait_time_cnt[6]_i_4__3_n_0 ),
        .O(wait_time_cnt0[6]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_4__3 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .O(\wait_time_cnt[6]_i_4__3_n_0 ));
  FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__3_n_0 ),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\wait_time_cnt[6]_i_1__3_n_0 ));
  FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__3_n_0 ),
        .D(\wait_time_cnt[1]_i_1__3_n_0 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\wait_time_cnt[6]_i_1__3_n_0 ));
  FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__3_n_0 ),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\wait_time_cnt[6]_i_1__3_n_0 ));
  FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__3_n_0 ),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\wait_time_cnt[6]_i_1__3_n_0 ));
  FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__3_n_0 ),
        .D(\wait_time_cnt[4]_i_1__3_n_0 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\wait_time_cnt[6]_i_1__3_n_0 ));
  FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__3_n_0 ),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\wait_time_cnt[6]_i_1__3_n_0 ));
  FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__3_n_0 ),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\wait_time_cnt[6]_i_1__3_n_0 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_RX_STARTUP_FSM" *) 
module XLAUI_XLAUI_RX_STARTUP_FSM_0
   (reset_sync1_rx_0,
    GT1_RX_MMCM_RESET_OUT,
    GT1_RX_FSM_RESET_DONE_OUT,
    gt1_rxuserrdy_in,
    gt1_rx_cdrlocked_reg,
    RXOUTCLK,
    SYSCLK_IN,
    gt1_rxusrclk_in,
    SOFT_RESET_IN,
    DONT_RESET_ON_DATA_ERROR_IN,
    gt1_rx_cdrlocked_reg_0,
    gt1_rx_cdrlocked,
    data_in,
    gt1_rxresetdone_out,
    GT1_RX_MMCM_LOCK_IN,
    GT1_DATA_VALID_IN,
    GT0_QPLLLOCK_IN);
  output [0:0]reset_sync1_rx_0;
  output GT1_RX_MMCM_RESET_OUT;
  output GT1_RX_FSM_RESET_DONE_OUT;
  output gt1_rxuserrdy_in;
  output gt1_rx_cdrlocked_reg;
  input RXOUTCLK;
  input SYSCLK_IN;
  input gt1_rxusrclk_in;
  input SOFT_RESET_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input gt1_rx_cdrlocked_reg_0;
  input gt1_rx_cdrlocked;
  input data_in;
  input gt1_rxresetdone_out;
  input GT1_RX_MMCM_LOCK_IN;
  input GT1_DATA_VALID_IN;
  input GT0_QPLLLOCK_IN;

  wire D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire \FSM_sequential_rx_state[0]_i_2__0_n_0 ;
  wire \FSM_sequential_rx_state[2]_i_1__0_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_5__0_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_6__0_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_8__0_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_9__0_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire GT1_DATA_VALID_IN;
  wire GT1_RX_FSM_RESET_DONE_OUT;
  wire GT1_RX_MMCM_LOCK_IN;
  wire GT1_RX_MMCM_RESET_OUT;
  wire RXOUTCLK;
  wire RXUSERRDY_i_1__0_n_0;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire check_tlock_max_i_1__0_n_0;
  wire check_tlock_max_reg_n_0;
  wire data_in;
  wire data_valid_sync;
  wire gt1_rx_cdrlocked;
  wire gt1_rx_cdrlocked_reg;
  wire gt1_rx_cdrlocked_reg_0;
  wire gt1_rxresetdone_out;
  wire gt1_rxuserrdy_in;
  wire gt1_rxusrclk_in;
  wire gtrxreset_i_i_1__0_n_0;
  wire gtrxreset_s;
  wire init_wait_count;
  wire \init_wait_count[6]_i_3__4_n_0 ;
  wire \init_wait_count[6]_i_4__4_n_0 ;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire init_wait_done_i_1__4_n_0;
  wire init_wait_done_reg_n_0;
  wire \mmcm_lock_count[7]_i_2__4_n_0 ;
  wire \mmcm_lock_count[7]_i_4__4_n_0 ;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_i_2__4_n_0;
  wire [6:0]p_0_in;
  wire [7:0]p_0_in__0;
  wire [0:0]reset_sync1_rx_0;
  wire reset_time_out_i_4__4_n_0;
  wire reset_time_out_reg_n_0;
  wire run_phase_alignment_int_i_1__4_n_0;
  wire run_phase_alignment_int_reg_n_0;
  wire run_phase_alignment_int_s2;
  wire run_phase_alignment_int_s3_reg_n_0;
  wire rx_fsm_reset_done_int_s2;
  wire rx_fsm_reset_done_int_s3_reg_n_0;
  (* RTL_KEEP = "yes" *) wire [3:0]rx_state;
  wire rx_state16_out;
  wire rxpmaresetdone_i;
  wire rxpmaresetdone_rx_s;
  wire rxresetdone_s2;
  wire rxresetdone_s3;
  wire sync_QPLLLOCK_n_0;
  wire sync_QPLLLOCK_n_1;
  wire sync_data_valid_n_1;
  wire sync_data_valid_n_2;
  wire sync_data_valid_n_3;
  wire sync_data_valid_n_4;
  wire sync_data_valid_n_5;
  wire sync_data_valid_n_6;
  wire sync_mmcm_lock_reclocked_n_0;
  wire sync_mmcm_lock_reclocked_n_1;
  wire sync_rxpmaresetdone_n_0;
  wire sync_rxpmaresetdone_n_1;
  wire time_out_1us_i_1_n_0;
  wire time_out_1us_i_2__0_n_0;
  wire time_out_1us_i_3_n_0;
  wire time_out_1us_i_4__0_n_0;
  wire time_out_1us_i_5_n_0;
  wire time_out_1us_i_6_n_0;
  wire time_out_1us_reg_n_0;
  wire time_out_2ms_i_1__0_n_0;
  wire time_out_2ms_i_2__1_n_0;
  wire time_out_2ms_i_3_n_0;
  wire time_out_2ms_reg_n_0;
  wire time_out_500us_i_1__0_n_0;
  wire time_out_500us_i_2__4_n_0;
  wire time_out_500us_i_3__4_n_0;
  wire time_out_500us_i_4__0_n_0;
  wire time_out_500us_reg_n_0;
  wire time_out_counter;
  wire \time_out_counter[0]_i_10__4_n_0 ;
  wire \time_out_counter[0]_i_3__4_n_0 ;
  wire \time_out_counter[0]_i_4_n_0 ;
  wire \time_out_counter[0]_i_8__0_n_0 ;
  wire \time_out_counter[0]_i_9__5_n_0 ;
  wire [18:0]time_out_counter_reg;
  wire \time_out_counter_reg[0]_i_2__4_n_0 ;
  wire \time_out_counter_reg[0]_i_2__4_n_1 ;
  wire \time_out_counter_reg[0]_i_2__4_n_2 ;
  wire \time_out_counter_reg[0]_i_2__4_n_3 ;
  wire \time_out_counter_reg[0]_i_2__4_n_4 ;
  wire \time_out_counter_reg[0]_i_2__4_n_5 ;
  wire \time_out_counter_reg[0]_i_2__4_n_6 ;
  wire \time_out_counter_reg[0]_i_2__4_n_7 ;
  wire \time_out_counter_reg[12]_i_1__4_n_0 ;
  wire \time_out_counter_reg[12]_i_1__4_n_1 ;
  wire \time_out_counter_reg[12]_i_1__4_n_2 ;
  wire \time_out_counter_reg[12]_i_1__4_n_3 ;
  wire \time_out_counter_reg[12]_i_1__4_n_4 ;
  wire \time_out_counter_reg[12]_i_1__4_n_5 ;
  wire \time_out_counter_reg[12]_i_1__4_n_6 ;
  wire \time_out_counter_reg[12]_i_1__4_n_7 ;
  wire \time_out_counter_reg[16]_i_1__4_n_2 ;
  wire \time_out_counter_reg[16]_i_1__4_n_3 ;
  wire \time_out_counter_reg[16]_i_1__4_n_5 ;
  wire \time_out_counter_reg[16]_i_1__4_n_6 ;
  wire \time_out_counter_reg[16]_i_1__4_n_7 ;
  wire \time_out_counter_reg[4]_i_1__4_n_0 ;
  wire \time_out_counter_reg[4]_i_1__4_n_1 ;
  wire \time_out_counter_reg[4]_i_1__4_n_2 ;
  wire \time_out_counter_reg[4]_i_1__4_n_3 ;
  wire \time_out_counter_reg[4]_i_1__4_n_4 ;
  wire \time_out_counter_reg[4]_i_1__4_n_5 ;
  wire \time_out_counter_reg[4]_i_1__4_n_6 ;
  wire \time_out_counter_reg[4]_i_1__4_n_7 ;
  wire \time_out_counter_reg[8]_i_1__4_n_0 ;
  wire \time_out_counter_reg[8]_i_1__4_n_1 ;
  wire \time_out_counter_reg[8]_i_1__4_n_2 ;
  wire \time_out_counter_reg[8]_i_1__4_n_3 ;
  wire \time_out_counter_reg[8]_i_1__4_n_4 ;
  wire \time_out_counter_reg[8]_i_1__4_n_5 ;
  wire \time_out_counter_reg[8]_i_1__4_n_6 ;
  wire \time_out_counter_reg[8]_i_1__4_n_7 ;
  wire time_out_wait_bypass_i_1__4_n_0;
  wire time_out_wait_bypass_reg_n_0;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire time_tlock_max1;
  wire time_tlock_max1_carry__0_i_1__0_n_0;
  wire time_tlock_max1_carry__0_i_2__0_n_0;
  wire time_tlock_max1_carry__0_i_3__0_n_0;
  wire time_tlock_max1_carry__0_i_4__0_n_0;
  wire time_tlock_max1_carry__0_i_5__0_n_0;
  wire time_tlock_max1_carry__0_i_6_n_0;
  wire time_tlock_max1_carry__0_n_0;
  wire time_tlock_max1_carry__0_n_1;
  wire time_tlock_max1_carry__0_n_2;
  wire time_tlock_max1_carry__0_n_3;
  wire time_tlock_max1_carry__1_i_1__0_n_0;
  wire time_tlock_max1_carry__1_i_2__0_n_0;
  wire time_tlock_max1_carry__1_i_3__0_n_0;
  wire time_tlock_max1_carry__1_n_3;
  wire time_tlock_max1_carry_i_1__0_n_0;
  wire time_tlock_max1_carry_i_2__0_n_0;
  wire time_tlock_max1_carry_i_3__0_n_0;
  wire time_tlock_max1_carry_i_4__0_n_0;
  wire time_tlock_max1_carry_i_5__0_n_0;
  wire time_tlock_max1_carry_i_6__0_n_0;
  wire time_tlock_max1_carry_i_7__0_n_0;
  wire time_tlock_max1_carry_n_0;
  wire time_tlock_max1_carry_n_1;
  wire time_tlock_max1_carry_n_2;
  wire time_tlock_max1_carry_n_3;
  wire time_tlock_max_i_1__0_n_0;
  wire \wait_bypass_count[0]_i_10__4_n_0 ;
  wire \wait_bypass_count[0]_i_1__4_n_0 ;
  wire \wait_bypass_count[0]_i_2__4_n_0 ;
  wire \wait_bypass_count[0]_i_4__4_n_0 ;
  wire \wait_bypass_count[0]_i_8__4_n_0 ;
  wire \wait_bypass_count[0]_i_9__4_n_0 ;
  wire [12:0]wait_bypass_count_reg;
  wire \wait_bypass_count_reg[0]_i_3__4_n_0 ;
  wire \wait_bypass_count_reg[0]_i_3__4_n_1 ;
  wire \wait_bypass_count_reg[0]_i_3__4_n_2 ;
  wire \wait_bypass_count_reg[0]_i_3__4_n_3 ;
  wire \wait_bypass_count_reg[0]_i_3__4_n_4 ;
  wire \wait_bypass_count_reg[0]_i_3__4_n_5 ;
  wire \wait_bypass_count_reg[0]_i_3__4_n_6 ;
  wire \wait_bypass_count_reg[0]_i_3__4_n_7 ;
  wire \wait_bypass_count_reg[12]_i_1__4_n_7 ;
  wire \wait_bypass_count_reg[4]_i_1__4_n_0 ;
  wire \wait_bypass_count_reg[4]_i_1__4_n_1 ;
  wire \wait_bypass_count_reg[4]_i_1__4_n_2 ;
  wire \wait_bypass_count_reg[4]_i_1__4_n_3 ;
  wire \wait_bypass_count_reg[4]_i_1__4_n_4 ;
  wire \wait_bypass_count_reg[4]_i_1__4_n_5 ;
  wire \wait_bypass_count_reg[4]_i_1__4_n_6 ;
  wire \wait_bypass_count_reg[4]_i_1__4_n_7 ;
  wire \wait_bypass_count_reg[8]_i_1__4_n_0 ;
  wire \wait_bypass_count_reg[8]_i_1__4_n_1 ;
  wire \wait_bypass_count_reg[8]_i_1__4_n_2 ;
  wire \wait_bypass_count_reg[8]_i_1__4_n_3 ;
  wire \wait_bypass_count_reg[8]_i_1__4_n_4 ;
  wire \wait_bypass_count_reg[8]_i_1__4_n_5 ;
  wire \wait_bypass_count_reg[8]_i_1__4_n_6 ;
  wire \wait_bypass_count_reg[8]_i_1__4_n_7 ;
  wire [6:0]wait_time_cnt0;
  wire \wait_time_cnt[1]_i_1__4_n_0 ;
  wire \wait_time_cnt[4]_i_1__4_n_0 ;
  wire \wait_time_cnt[6]_i_1__4_n_0 ;
  wire \wait_time_cnt[6]_i_2__4_n_0 ;
  wire \wait_time_cnt[6]_i_4__4_n_0 ;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__4_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__4_O_UNCONNECTED ;
  wire [3:0]NLW_time_tlock_max1_carry_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max1_carry__0_O_UNCONNECTED;
  wire [3:2]NLW_time_tlock_max1_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max1_carry__1_O_UNCONNECTED;
  wire [3:0]\NLW_wait_bypass_count_reg[12]_i_1__4_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[12]_i_1__4_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h08B80888FFFFFFFF)) 
    \FSM_sequential_rx_state[0]_i_2__0 
       (.I0(time_out_2ms_reg_n_0),
        .I1(rx_state[1]),
        .I2(rx_state[2]),
        .I3(reset_time_out_reg_n_0),
        .I4(time_tlock_max),
        .I5(rx_state[0]),
        .O(\FSM_sequential_rx_state[0]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'h00000000262226AA)) 
    \FSM_sequential_rx_state[2]_i_1__0 
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(time_out_2ms_reg_n_0),
        .I3(rx_state[1]),
        .I4(rx_state16_out),
        .I5(rx_state[3]),
        .O(\FSM_sequential_rx_state[2]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_rx_state[2]_i_2__0 
       (.I0(time_tlock_max),
        .I1(reset_time_out_reg_n_0),
        .O(rx_state16_out));
  LUT6 #(
    .INIT(64'h00F0BBBB00F08888)) 
    \FSM_sequential_rx_state[3]_i_5__0 
       (.I0(gt1_rx_cdrlocked_reg_0),
        .I1(rx_state[2]),
        .I2(\FSM_sequential_rx_state[3]_i_9__0_n_0 ),
        .I3(wait_time_cnt_reg__0[6]),
        .I4(rx_state[1]),
        .I5(init_wait_done_reg_n_0),
        .O(\FSM_sequential_rx_state[3]_i_5__0_n_0 ));
  LUT5 #(
    .INIT(32'h80880000)) 
    \FSM_sequential_rx_state[3]_i_6__0 
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(reset_time_out_reg_n_0),
        .I3(time_out_2ms_reg_n_0),
        .I4(rx_state[0]),
        .O(\FSM_sequential_rx_state[3]_i_6__0_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0EFEFAFA0EFE0)) 
    \FSM_sequential_rx_state[3]_i_8__0 
       (.I0(rxresetdone_s3),
        .I1(time_out_2ms_reg_n_0),
        .I2(rx_state[1]),
        .I3(mmcm_lock_reclocked),
        .I4(reset_time_out_reg_n_0),
        .I5(time_tlock_max),
        .O(\FSM_sequential_rx_state[3]_i_8__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_sequential_rx_state[3]_i_9__0 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[4]),
        .I5(wait_time_cnt_reg__0[5]),
        .O(\FSM_sequential_rx_state[3]_i_9__0_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_5),
        .Q(rx_state[0]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_4),
        .Q(rx_state[1]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(\FSM_sequential_rx_state[2]_i_1__0_n_0 ),
        .Q(rx_state[2]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_3),
        .Q(rx_state[3]),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFD0080)) 
    RXUSERRDY_i_1__0
       (.I0(rx_state[0]),
        .I1(rx_state[2]),
        .I2(rx_state[1]),
        .I3(rx_state[3]),
        .I4(gt1_rxuserrdy_in),
        .O(RXUSERRDY_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    RXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(RXUSERRDY_i_1__0_n_0),
        .Q(gt1_rxuserrdy_in),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    check_tlock_max_i_1__0
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .I3(rx_state[3]),
        .I4(check_tlock_max_reg_n_0),
        .O(check_tlock_max_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    check_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(check_tlock_max_i_1__0_n_0),
        .Q(check_tlock_max_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT3 #(
    .INIT(8'h0E)) 
    gt1_rx_cdrlocked_i_1
       (.I0(gt1_rx_cdrlocked_reg_0),
        .I1(gt1_rx_cdrlocked),
        .I2(reset_sync1_rx_0),
        .O(gt1_rx_cdrlocked_reg));
  LUT5 #(
    .INIT(32'hFFFB0010)) 
    gtrxreset_i_i_1__0
       (.I0(rx_state[1]),
        .I1(rx_state[2]),
        .I2(rx_state[0]),
        .I3(rx_state[3]),
        .I4(reset_sync1_rx_0),
        .O(gtrxreset_i_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    gtrxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gtrxreset_i_i_1__0_n_0),
        .Q(reset_sync1_rx_0),
        .R(SOFT_RESET_IN));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \init_wait_count[0]_i_1__4 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \init_wait_count[1]_i_1__4 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \init_wait_count[2]_i_1__4 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \init_wait_count[3]_i_1__4 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \init_wait_count[4]_i_1__4 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \init_wait_count[5]_i_1__4 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
    \init_wait_count[6]_i_1__4 
       (.I0(\init_wait_count[6]_i_3__4_n_0 ),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_count));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT5 #(
    .INIT(32'h9AAAAAAA)) 
    \init_wait_count[6]_i_2__4 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\init_wait_count[6]_i_4__4_n_0 ),
        .I2(init_wait_count_reg__0[4]),
        .I3(init_wait_count_reg__0[3]),
        .I4(init_wait_count_reg__0[5]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \init_wait_count[6]_i_3__4 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(\init_wait_count[6]_i_3__4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \init_wait_count[6]_i_4__4 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(\init_wait_count[6]_i_4__4_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[0]),
        .Q(init_wait_count_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
  LUT2 #(
    .INIT(4'hE)) 
    init_wait_done_i_1__4
       (.I0(init_wait_done),
        .I1(init_wait_done_reg_n_0),
        .O(init_wait_done_i_1__4_n_0));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    init_wait_done_i_2__4
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\init_wait_count[6]_i_3__4_n_0 ),
        .O(init_wait_done));
  FDCE #(
    .INIT(1'b0)) 
    init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(init_wait_done_i_1__4_n_0),
        .Q(init_wait_done_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[0]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \mmcm_lock_count[1]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \mmcm_lock_count[2]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \mmcm_lock_count[3]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[4]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[2]),
        .I4(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \mmcm_lock_count[5]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \mmcm_lock_count[6]_i_1__4 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__4_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__0[6]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \mmcm_lock_count[7]_i_2__4 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__4_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(\mmcm_lock_count[7]_i_2__4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[7]_i_3__4 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(mmcm_lock_count_reg__0[5]),
        .I2(\mmcm_lock_count[7]_i_4__4_n_0 ),
        .I3(mmcm_lock_count_reg__0[4]),
        .I4(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \mmcm_lock_count[7]_i_4__4 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .O(\mmcm_lock_count[7]_i_4__4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__4_n_0 ),
        .D(p_0_in__0[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__4_n_0 ),
        .D(p_0_in__0[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__4_n_0 ),
        .D(p_0_in__0[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__4_n_0 ),
        .D(p_0_in__0[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__4_n_0 ),
        .D(p_0_in__0[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__4_n_0 ),
        .D(p_0_in__0[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__4_n_0 ),
        .D(p_0_in__0[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__4_n_0 ),
        .D(p_0_in__0[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(sync_mmcm_lock_reclocked_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    mmcm_lock_reclocked_i_2__4
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(mmcm_lock_reclocked_i_2__4_n_0));
  FDRE #(
    .INIT(1'b0)) 
    mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_mmcm_lock_reclocked_n_1),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    mmcm_reset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_rxpmaresetdone_n_0),
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
        .PRE(reset_sync1_rx_0),
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
        .PRE(reset_sync1_rx_0),
        .Q(gtrxreset_s));
  LUT3 #(
    .INIT(8'h07)) 
    reset_time_out_i_4__4
       (.I0(rx_state[1]),
        .I1(rx_state[0]),
        .I2(rx_state[2]),
        .O(reset_time_out_i_4__4_n_0));
  FDSE #(
    .INIT(1'b0)) 
    reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_data_valid_n_1),
        .Q(reset_time_out_reg_n_0),
        .S(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFEFF0002)) 
    run_phase_alignment_int_i_1__4
       (.I0(rx_state[3]),
        .I1(rx_state[2]),
        .I2(rx_state[1]),
        .I3(rx_state[0]),
        .I4(run_phase_alignment_int_reg_n_0),
        .O(run_phase_alignment_int_i_1__4_n_0));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(run_phase_alignment_int_i_1__4_n_0),
        .Q(run_phase_alignment_int_reg_n_0),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_s3_reg
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(run_phase_alignment_int_s2),
        .Q(run_phase_alignment_int_s3_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    rx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_data_valid_n_2),
        .Q(GT1_RX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    rx_fsm_reset_done_int_s3_reg
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(rx_fsm_reset_done_int_s2),
        .Q(rx_fsm_reset_done_int_s3_reg_n_0),
        .R(1'b0));
  FDCE #(
    .INIT(1'b0)) 
    rxpmaresetdone_i_reg
       (.C(RXOUTCLK),
        .CE(1'b1),
        .CLR(gtrxreset_s),
        .D(rxpmaresetdone_rx_s),
        .Q(rxpmaresetdone_i));
  FDRE #(
    .INIT(1'b0)) 
    rxresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(rxresetdone_s2),
        .Q(rxresetdone_s3),
        .R(1'b0));
  XLAUI_XLAUI_sync_block_41 sync_QPLLLOCK
       (.\FSM_sequential_rx_state_reg[0] (sync_QPLLLOCK_n_0),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .data_out(data_valid_sync),
        .gt1_rx_cdrlocked_reg(gt1_rx_cdrlocked_reg_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state[2:0]),
        .reset_time_out_reg(sync_QPLLLOCK_n_1),
        .rxresetdone_s3(rxresetdone_s3),
        .rxresetdone_s3_reg(\FSM_sequential_rx_state[3]_i_8__0_n_0 ),
        .time_out_2ms_reg(time_out_2ms_reg_n_0));
  XLAUI_XLAUI_sync_block_42 sync_RXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(rxresetdone_s2),
        .gt1_rxresetdone_out(gt1_rxresetdone_out));
  XLAUI_XLAUI_sync_block_43 sync_data_valid
       (.D({sync_data_valid_n_3,sync_data_valid_n_4,sync_data_valid_n_5}),
        .DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .E(sync_data_valid_n_6),
        .\FSM_sequential_rx_state_reg[0] (sync_QPLLLOCK_n_1),
        .\FSM_sequential_rx_state_reg[1] (reset_time_out_i_4__4_n_0),
        .\FSM_sequential_rx_state_reg[2] (sync_QPLLLOCK_n_0),
        .\FSM_sequential_rx_state_reg[2]_0 (\FSM_sequential_rx_state[3]_i_6__0_n_0 ),
        .GT1_DATA_VALID_IN(GT1_DATA_VALID_IN),
        .GT1_RX_FSM_RESET_DONE_OUT(GT1_RX_FSM_RESET_DONE_OUT),
        .SYSCLK_IN(SYSCLK_IN),
        .data_out(data_valid_sync),
        .gt1_rx_cdrlocked_reg(\FSM_sequential_rx_state[3]_i_5__0_n_0 ),
        .mmcm_lock_reclocked_reg(sync_rxpmaresetdone_n_1),
        .out(rx_state),
        .reset_time_out_reg(sync_data_valid_n_1),
        .reset_time_out_reg_0(reset_time_out_reg_n_0),
        .rx_fsm_reset_done_int_reg(sync_data_valid_n_2),
        .rx_state16_out(rx_state16_out),
        .time_out_1us_reg(time_out_1us_reg_n_0),
        .time_out_2ms_reg(\FSM_sequential_rx_state[0]_i_2__0_n_0 ),
        .time_out_500us_reg(time_out_500us_reg_n_0),
        .time_out_wait_bypass_s3(time_out_wait_bypass_s3));
  XLAUI_XLAUI_sync_block_44 sync_mmcm_lock_reclocked
       (.GT1_RX_MMCM_LOCK_IN(GT1_RX_MMCM_LOCK_IN),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(sync_mmcm_lock_reclocked_n_0),
        .SYSCLK_IN(SYSCLK_IN),
        .\mmcm_lock_count_reg[5] (mmcm_lock_reclocked_i_2__4_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_lock_reclocked_reg(sync_mmcm_lock_reclocked_n_1));
  XLAUI_XLAUI_sync_block_45 sync_run_phase_alignment_int
       (.data_in(run_phase_alignment_int_reg_n_0),
        .data_out(run_phase_alignment_int_s2),
        .gt1_rxusrclk_in(gt1_rxusrclk_in));
  XLAUI_XLAUI_sync_block_46 sync_rx_fsm_reset_done_int
       (.GT1_RX_FSM_RESET_DONE_OUT(GT1_RX_FSM_RESET_DONE_OUT),
        .data_out(rx_fsm_reset_done_int_s2),
        .gt1_rxusrclk_in(gt1_rxusrclk_in));
  XLAUI_XLAUI_sync_block_47 sync_rxpmaresetdone
       (.GT1_RX_MMCM_RESET_OUT(GT1_RX_MMCM_RESET_OUT),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(rxpmaresetdone_i),
        .gt1_rx_cdrlocked_reg(gt1_rx_cdrlocked_reg_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_reset_i_reg(sync_rxpmaresetdone_n_0),
        .out(rx_state),
        .reset_time_out_reg(sync_rxpmaresetdone_n_1));
  XLAUI_XLAUI_sync_block_48 sync_rxpmaresetdone_rx_s
       (.RXOUTCLK(RXOUTCLK),
        .data_in(data_in),
        .data_out(rxpmaresetdone_rx_s));
  XLAUI_XLAUI_sync_block_49 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(time_out_wait_bypass_reg_n_0),
        .data_out(time_out_wait_bypass_s2));
  LUT4 #(
    .INIT(16'hFF10)) 
    time_out_1us_i_1
       (.I0(time_out_1us_i_2__0_n_0),
        .I1(time_out_1us_i_3_n_0),
        .I2(time_out_1us_i_4__0_n_0),
        .I3(time_out_1us_reg_n_0),
        .O(time_out_1us_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'hFFFD)) 
    time_out_1us_i_2__0
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[11]),
        .I3(time_out_counter_reg[4]),
        .O(time_out_1us_i_2__0_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFB)) 
    time_out_1us_i_3
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[5]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[6]),
        .I4(time_out_counter_reg[13]),
        .I5(time_out_1us_i_5_n_0),
        .O(time_out_1us_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    time_out_1us_i_4__0
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[16]),
        .I4(time_out_1us_i_6_n_0),
        .O(time_out_1us_i_4__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'hB)) 
    time_out_1us_i_5
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[1]),
        .O(time_out_1us_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'hFFFD)) 
    time_out_1us_i_6
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[17]),
        .O(time_out_1us_i_6_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_1us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_1us_i_1_n_0),
        .Q(time_out_1us_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00400000)) 
    time_out_2ms_i_1__0
       (.I0(\time_out_counter[0]_i_3__4_n_0 ),
        .I1(time_out_2ms_i_2__1_n_0),
        .I2(time_out_2ms_i_3_n_0),
        .I3(time_out_counter_reg[3]),
        .I4(time_out_counter_reg[16]),
        .I5(time_out_2ms_reg_n_0),
        .O(time_out_2ms_i_1__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT4 #(
    .INIT(16'h0010)) 
    time_out_2ms_i_2__1
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[8]),
        .O(time_out_2ms_i_2__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT2 #(
    .INIT(4'h1)) 
    time_out_2ms_i_3
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(time_out_2ms_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_2ms_i_1__0_n_0),
        .Q(time_out_2ms_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000001)) 
    time_out_500us_i_1__0
       (.I0(time_out_500us_i_2__4_n_0),
        .I1(time_out_500us_i_3__4_n_0),
        .I2(time_out_counter_reg[1]),
        .I3(time_out_counter_reg[15]),
        .I4(time_out_500us_i_4__0_n_0),
        .I5(time_out_500us_reg_n_0),
        .O(time_out_500us_i_1__0_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFBFFFFFF)) 
    time_out_500us_i_2__4
       (.I0(time_out_1us_i_2__0_n_0),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[6]),
        .I3(time_out_counter_reg[14]),
        .I4(time_out_counter_reg[2]),
        .I5(\time_out_counter[0]_i_9__5_n_0 ),
        .O(time_out_500us_i_2__4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'hB)) 
    time_out_500us_i_3__4
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[16]),
        .O(time_out_500us_i_3__4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'hFEFF)) 
    time_out_500us_i_4__0
       (.I0(time_out_counter_reg[18]),
        .I1(time_out_counter_reg[17]),
        .I2(time_out_counter_reg[9]),
        .I3(time_out_counter_reg[8]),
        .O(time_out_500us_i_4__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_500us_i_1__0_n_0),
        .Q(time_out_500us_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT4 #(
    .INIT(16'hDFFF)) 
    \time_out_counter[0]_i_10__4 
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[17]),
        .I2(time_out_counter_reg[9]),
        .I3(time_out_counter_reg[12]),
        .O(\time_out_counter[0]_i_10__4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFEF)) 
    \time_out_counter[0]_i_1__0 
       (.I0(\time_out_counter[0]_i_3__4_n_0 ),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[1]),
        .I4(time_out_counter_reg[15]),
        .I5(\time_out_counter[0]_i_4_n_0 ),
        .O(time_out_counter));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFEFFF)) 
    \time_out_counter[0]_i_3__4 
       (.I0(\time_out_counter[0]_i_9__5_n_0 ),
        .I1(\time_out_counter[0]_i_10__4_n_0 ),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[14]),
        .I5(time_out_counter_reg[11]),
        .O(\time_out_counter[0]_i_3__4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFD)) 
    \time_out_counter[0]_i_4 
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[6]),
        .O(\time_out_counter[0]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_8__0 
       (.I0(time_out_counter_reg[0]),
        .O(\time_out_counter[0]_i_8__0_n_0 ));
  LUT3 #(
    .INIT(8'hEF)) 
    \time_out_counter[0]_i_9__5 
       (.I0(time_out_counter_reg[5]),
        .I1(time_out_counter_reg[13]),
        .I2(time_out_counter_reg[0]),
        .O(\time_out_counter[0]_i_9__5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__4_n_7 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[0]_i_2__4 
       (.CI(1'b0),
        .CO({\time_out_counter_reg[0]_i_2__4_n_0 ,\time_out_counter_reg[0]_i_2__4_n_1 ,\time_out_counter_reg[0]_i_2__4_n_2 ,\time_out_counter_reg[0]_i_2__4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\time_out_counter_reg[0]_i_2__4_n_4 ,\time_out_counter_reg[0]_i_2__4_n_5 ,\time_out_counter_reg[0]_i_2__4_n_6 ,\time_out_counter_reg[0]_i_2__4_n_7 }),
        .S({time_out_counter_reg[3:1],\time_out_counter[0]_i_8__0_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__4_n_5 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__4_n_4 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__4_n_7 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[12]_i_1__4 
       (.CI(\time_out_counter_reg[8]_i_1__4_n_0 ),
        .CO({\time_out_counter_reg[12]_i_1__4_n_0 ,\time_out_counter_reg[12]_i_1__4_n_1 ,\time_out_counter_reg[12]_i_1__4_n_2 ,\time_out_counter_reg[12]_i_1__4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[12]_i_1__4_n_4 ,\time_out_counter_reg[12]_i_1__4_n_5 ,\time_out_counter_reg[12]_i_1__4_n_6 ,\time_out_counter_reg[12]_i_1__4_n_7 }),
        .S(time_out_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__4_n_6 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__4_n_5 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__4_n_4 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__4_n_7 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[16]_i_1__4 
       (.CI(\time_out_counter_reg[12]_i_1__4_n_0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__4_CO_UNCONNECTED [3:2],\time_out_counter_reg[16]_i_1__4_n_2 ,\time_out_counter_reg[16]_i_1__4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__4_O_UNCONNECTED [3],\time_out_counter_reg[16]_i_1__4_n_5 ,\time_out_counter_reg[16]_i_1__4_n_6 ,\time_out_counter_reg[16]_i_1__4_n_7 }),
        .S({1'b0,time_out_counter_reg[18:16]}));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__4_n_6 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__4_n_5 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__4_n_6 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__4_n_5 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__4_n_4 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__4_n_7 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[4]_i_1__4 
       (.CI(\time_out_counter_reg[0]_i_2__4_n_0 ),
        .CO({\time_out_counter_reg[4]_i_1__4_n_0 ,\time_out_counter_reg[4]_i_1__4_n_1 ,\time_out_counter_reg[4]_i_1__4_n_2 ,\time_out_counter_reg[4]_i_1__4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[4]_i_1__4_n_4 ,\time_out_counter_reg[4]_i_1__4_n_5 ,\time_out_counter_reg[4]_i_1__4_n_6 ,\time_out_counter_reg[4]_i_1__4_n_7 }),
        .S(time_out_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__4_n_6 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__4_n_5 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__4_n_4 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__4_n_7 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[8]_i_1__4 
       (.CI(\time_out_counter_reg[4]_i_1__4_n_0 ),
        .CO({\time_out_counter_reg[8]_i_1__4_n_0 ,\time_out_counter_reg[8]_i_1__4_n_1 ,\time_out_counter_reg[8]_i_1__4_n_2 ,\time_out_counter_reg[8]_i_1__4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[8]_i_1__4_n_4 ,\time_out_counter_reg[8]_i_1__4_n_5 ,\time_out_counter_reg[8]_i_1__4_n_6 ,\time_out_counter_reg[8]_i_1__4_n_7 }),
        .S(time_out_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__4_n_6 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out_reg_n_0));
  LUT4 #(
    .INIT(16'hAB00)) 
    time_out_wait_bypass_i_1__4
       (.I0(time_out_wait_bypass_reg_n_0),
        .I1(rx_fsm_reset_done_int_s3_reg_n_0),
        .I2(\wait_bypass_count[0]_i_4__4_n_0 ),
        .I3(run_phase_alignment_int_s3_reg_n_0),
        .O(time_out_wait_bypass_i_1__4_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_reg
       (.C(gt1_rxusrclk_in),
        .CE(1'b1),
        .D(time_out_wait_bypass_i_1__4_n_0),
        .Q(time_out_wait_bypass_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
  CARRY4 time_tlock_max1_carry
       (.CI(1'b0),
        .CO({time_tlock_max1_carry_n_0,time_tlock_max1_carry_n_1,time_tlock_max1_carry_n_2,time_tlock_max1_carry_n_3}),
        .CYINIT(1'b0),
        .DI({time_tlock_max1_carry_i_1__0_n_0,time_out_counter_reg[5],time_tlock_max1_carry_i_2__0_n_0,time_tlock_max1_carry_i_3__0_n_0}),
        .O(NLW_time_tlock_max1_carry_O_UNCONNECTED[3:0]),
        .S({time_tlock_max1_carry_i_4__0_n_0,time_tlock_max1_carry_i_5__0_n_0,time_tlock_max1_carry_i_6__0_n_0,time_tlock_max1_carry_i_7__0_n_0}));
  CARRY4 time_tlock_max1_carry__0
       (.CI(time_tlock_max1_carry_n_0),
        .CO({time_tlock_max1_carry__0_n_0,time_tlock_max1_carry__0_n_1,time_tlock_max1_carry__0_n_2,time_tlock_max1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({time_out_counter_reg[15],time_tlock_max1_carry__0_i_1__0_n_0,time_tlock_max1_carry__0_i_2__0_n_0,time_out_counter_reg[9]}),
        .O(NLW_time_tlock_max1_carry__0_O_UNCONNECTED[3:0]),
        .S({time_tlock_max1_carry__0_i_3__0_n_0,time_tlock_max1_carry__0_i_4__0_n_0,time_tlock_max1_carry__0_i_5__0_n_0,time_tlock_max1_carry__0_i_6_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__0_i_1__0
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .O(time_tlock_max1_carry__0_i_1__0_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__0_i_2__0
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[10]),
        .O(time_tlock_max1_carry__0_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry__0_i_3__0
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[15]),
        .O(time_tlock_max1_carry__0_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__0_i_4__0
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(time_tlock_max1_carry__0_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__0_i_5__0
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(time_tlock_max1_carry__0_i_5__0_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry__0_i_6
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .O(time_tlock_max1_carry__0_i_6_n_0));
  CARRY4 time_tlock_max1_carry__1
       (.CI(time_tlock_max1_carry__0_n_0),
        .CO({NLW_time_tlock_max1_carry__1_CO_UNCONNECTED[3:2],time_tlock_max1,time_tlock_max1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,time_out_counter_reg[18],time_tlock_max1_carry__1_i_1__0_n_0}),
        .O(NLW_time_tlock_max1_carry__1_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,time_tlock_max1_carry__1_i_2__0_n_0,time_tlock_max1_carry__1_i_3__0_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__1_i_1__0
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[16]),
        .O(time_tlock_max1_carry__1_i_1__0_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    time_tlock_max1_carry__1_i_2__0
       (.I0(time_out_counter_reg[18]),
        .O(time_tlock_max1_carry__1_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__1_i_3__0
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(time_tlock_max1_carry__1_i_3__0_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry_i_1__0
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[6]),
        .O(time_tlock_max1_carry_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    time_tlock_max1_carry_i_2__0
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(time_tlock_max1_carry_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    time_tlock_max1_carry_i_3__0
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(time_tlock_max1_carry_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry_i_4__0
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(time_tlock_max1_carry_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_5__0
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[5]),
        .O(time_tlock_max1_carry_i_5__0_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_6__0
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(time_tlock_max1_carry_i_6__0_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_7__0
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(time_tlock_max1_carry_i_7__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    time_tlock_max_i_1__0
       (.I0(time_tlock_max1),
        .I1(check_tlock_max_reg_n_0),
        .I2(time_tlock_max),
        .O(time_tlock_max_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_tlock_max_i_1__0_n_0),
        .Q(time_tlock_max),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \wait_bypass_count[0]_i_10__4 
       (.I0(wait_bypass_count_reg[2]),
        .I1(wait_bypass_count_reg[12]),
        .I2(wait_bypass_count_reg[4]),
        .I3(wait_bypass_count_reg[10]),
        .I4(wait_bypass_count_reg[6]),
        .I5(wait_bypass_count_reg[11]),
        .O(\wait_bypass_count[0]_i_10__4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_1__4 
       (.I0(run_phase_alignment_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_1__4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \wait_bypass_count[0]_i_2__4 
       (.I0(\wait_bypass_count[0]_i_4__4_n_0 ),
        .I1(rx_fsm_reset_done_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_2__4_n_0 ));
  LUT5 #(
    .INIT(32'hBFFFFFFF)) 
    \wait_bypass_count[0]_i_4__4 
       (.I0(\wait_bypass_count[0]_i_9__4_n_0 ),
        .I1(wait_bypass_count_reg[1]),
        .I2(wait_bypass_count_reg[8]),
        .I3(wait_bypass_count_reg[0]),
        .I4(\wait_bypass_count[0]_i_10__4_n_0 ),
        .O(\wait_bypass_count[0]_i_4__4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_8__4 
       (.I0(wait_bypass_count_reg[0]),
        .O(\wait_bypass_count[0]_i_8__4_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \wait_bypass_count[0]_i_9__4 
       (.I0(wait_bypass_count_reg[3]),
        .I1(wait_bypass_count_reg[5]),
        .I2(wait_bypass_count_reg[9]),
        .I3(wait_bypass_count_reg[7]),
        .O(\wait_bypass_count[0]_i_9__4_n_0 ));
  FDRE \wait_bypass_count_reg[0] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__4_n_7 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  CARRY4 \wait_bypass_count_reg[0]_i_3__4 
       (.CI(1'b0),
        .CO({\wait_bypass_count_reg[0]_i_3__4_n_0 ,\wait_bypass_count_reg[0]_i_3__4_n_1 ,\wait_bypass_count_reg[0]_i_3__4_n_2 ,\wait_bypass_count_reg[0]_i_3__4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\wait_bypass_count_reg[0]_i_3__4_n_4 ,\wait_bypass_count_reg[0]_i_3__4_n_5 ,\wait_bypass_count_reg[0]_i_3__4_n_6 ,\wait_bypass_count_reg[0]_i_3__4_n_7 }),
        .S({wait_bypass_count_reg[3:1],\wait_bypass_count[0]_i_8__4_n_0 }));
  FDRE \wait_bypass_count_reg[10] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__4_n_5 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  FDRE \wait_bypass_count_reg[11] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__4_n_4 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  FDRE \wait_bypass_count_reg[12] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__4_n_7 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  CARRY4 \wait_bypass_count_reg[12]_i_1__4 
       (.CI(\wait_bypass_count_reg[8]_i_1__4_n_0 ),
        .CO(\NLW_wait_bypass_count_reg[12]_i_1__4_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[12]_i_1__4_O_UNCONNECTED [3:1],\wait_bypass_count_reg[12]_i_1__4_n_7 }),
        .S({1'b0,1'b0,1'b0,wait_bypass_count_reg[12]}));
  FDRE \wait_bypass_count_reg[1] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__4_n_6 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  FDRE \wait_bypass_count_reg[2] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__4_n_5 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  FDRE \wait_bypass_count_reg[3] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__4_n_4 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  FDRE \wait_bypass_count_reg[4] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__4_n_7 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  CARRY4 \wait_bypass_count_reg[4]_i_1__4 
       (.CI(\wait_bypass_count_reg[0]_i_3__4_n_0 ),
        .CO({\wait_bypass_count_reg[4]_i_1__4_n_0 ,\wait_bypass_count_reg[4]_i_1__4_n_1 ,\wait_bypass_count_reg[4]_i_1__4_n_2 ,\wait_bypass_count_reg[4]_i_1__4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[4]_i_1__4_n_4 ,\wait_bypass_count_reg[4]_i_1__4_n_5 ,\wait_bypass_count_reg[4]_i_1__4_n_6 ,\wait_bypass_count_reg[4]_i_1__4_n_7 }),
        .S(wait_bypass_count_reg[7:4]));
  FDRE \wait_bypass_count_reg[5] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__4_n_6 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  FDRE \wait_bypass_count_reg[6] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__4_n_5 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  FDRE \wait_bypass_count_reg[7] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__4_n_4 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  FDRE \wait_bypass_count_reg[8] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__4_n_7 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  CARRY4 \wait_bypass_count_reg[8]_i_1__4 
       (.CI(\wait_bypass_count_reg[4]_i_1__4_n_0 ),
        .CO({\wait_bypass_count_reg[8]_i_1__4_n_0 ,\wait_bypass_count_reg[8]_i_1__4_n_1 ,\wait_bypass_count_reg[8]_i_1__4_n_2 ,\wait_bypass_count_reg[8]_i_1__4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[8]_i_1__4_n_4 ,\wait_bypass_count_reg[8]_i_1__4_n_5 ,\wait_bypass_count_reg[8]_i_1__4_n_6 ,\wait_bypass_count_reg[8]_i_1__4_n_7 }),
        .S(wait_bypass_count_reg[11:8]));
  FDRE \wait_bypass_count_reg[9] 
       (.C(gt1_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__4_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__4_n_6 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\wait_bypass_count[0]_i_1__4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_time_cnt[0]_i_1__4 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \wait_time_cnt[1]_i_1__4 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\wait_time_cnt[1]_i_1__4_n_0 ));
  LUT3 #(
    .INIT(8'hE1)) 
    \wait_time_cnt[2]_i_1__4 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[2]),
        .O(wait_time_cnt0[2]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \wait_time_cnt[3]_i_1__4 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0[3]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \wait_time_cnt[4]_i_1__4 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\wait_time_cnt[4]_i_1__4_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
    \wait_time_cnt[5]_i_1__4 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[5]));
  LUT3 #(
    .INIT(8'h10)) 
    \wait_time_cnt[6]_i_1__4 
       (.I0(rx_state[3]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .O(\wait_time_cnt[6]_i_1__4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_2__4 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\wait_time_cnt[6]_i_4__4_n_0 ),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(wait_time_cnt_reg__0[5]),
        .O(\wait_time_cnt[6]_i_2__4_n_0 ));
  LUT4 #(
    .INIT(16'hAAA9)) 
    \wait_time_cnt[6]_i_3__4 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(\wait_time_cnt[6]_i_4__4_n_0 ),
        .O(wait_time_cnt0[6]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_4__4 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .O(\wait_time_cnt[6]_i_4__4_n_0 ));
  FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__4_n_0 ),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\wait_time_cnt[6]_i_1__4_n_0 ));
  FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__4_n_0 ),
        .D(\wait_time_cnt[1]_i_1__4_n_0 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\wait_time_cnt[6]_i_1__4_n_0 ));
  FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__4_n_0 ),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\wait_time_cnt[6]_i_1__4_n_0 ));
  FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__4_n_0 ),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\wait_time_cnt[6]_i_1__4_n_0 ));
  FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__4_n_0 ),
        .D(\wait_time_cnt[4]_i_1__4_n_0 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\wait_time_cnt[6]_i_1__4_n_0 ));
  FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__4_n_0 ),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\wait_time_cnt[6]_i_1__4_n_0 ));
  FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__4_n_0 ),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\wait_time_cnt[6]_i_1__4_n_0 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_RX_STARTUP_FSM" *) 
module XLAUI_XLAUI_RX_STARTUP_FSM_2
   (reset_sync1_rx_0,
    GT2_RX_MMCM_RESET_OUT,
    GT2_RX_FSM_RESET_DONE_OUT,
    gt2_rxuserrdy_in,
    gt2_rx_cdrlocked_reg,
    RXOUTCLK,
    SYSCLK_IN,
    gt2_rxusrclk_in,
    SOFT_RESET_IN,
    DONT_RESET_ON_DATA_ERROR_IN,
    gt2_rx_cdrlocked_reg_0,
    gt2_rx_cdrlocked,
    data_in,
    gt2_rxresetdone_out,
    GT2_RX_MMCM_LOCK_IN,
    GT2_DATA_VALID_IN,
    GT0_QPLLLOCK_IN);
  output [0:0]reset_sync1_rx_0;
  output GT2_RX_MMCM_RESET_OUT;
  output GT2_RX_FSM_RESET_DONE_OUT;
  output gt2_rxuserrdy_in;
  output gt2_rx_cdrlocked_reg;
  input RXOUTCLK;
  input SYSCLK_IN;
  input gt2_rxusrclk_in;
  input SOFT_RESET_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input gt2_rx_cdrlocked_reg_0;
  input gt2_rx_cdrlocked;
  input data_in;
  input gt2_rxresetdone_out;
  input GT2_RX_MMCM_LOCK_IN;
  input GT2_DATA_VALID_IN;
  input GT0_QPLLLOCK_IN;

  wire D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire \FSM_sequential_rx_state[0]_i_2__1_n_0 ;
  wire \FSM_sequential_rx_state[2]_i_1__1_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_5__1_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_6__1_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_8__1_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_9__1_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire GT2_DATA_VALID_IN;
  wire GT2_RX_FSM_RESET_DONE_OUT;
  wire GT2_RX_MMCM_LOCK_IN;
  wire GT2_RX_MMCM_RESET_OUT;
  wire RXOUTCLK;
  wire RXUSERRDY_i_1__1_n_0;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire check_tlock_max_i_1__1_n_0;
  wire check_tlock_max_reg_n_0;
  wire data_in;
  wire data_valid_sync;
  wire gt2_rx_cdrlocked;
  wire gt2_rx_cdrlocked_reg;
  wire gt2_rx_cdrlocked_reg_0;
  wire gt2_rxresetdone_out;
  wire gt2_rxuserrdy_in;
  wire gt2_rxusrclk_in;
  wire gtrxreset_i_i_1__1_n_0;
  wire gtrxreset_s;
  wire init_wait_count;
  wire \init_wait_count[6]_i_3__5_n_0 ;
  wire \init_wait_count[6]_i_4__5_n_0 ;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire init_wait_done_i_1__5_n_0;
  wire init_wait_done_reg_n_0;
  wire \mmcm_lock_count[7]_i_2__5_n_0 ;
  wire \mmcm_lock_count[7]_i_4__5_n_0 ;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_i_2__5_n_0;
  wire [6:0]p_0_in;
  wire [7:0]p_0_in__0;
  wire [0:0]reset_sync1_rx_0;
  wire reset_time_out_i_4__5_n_0;
  wire reset_time_out_reg_n_0;
  wire run_phase_alignment_int_i_1__5_n_0;
  wire run_phase_alignment_int_reg_n_0;
  wire run_phase_alignment_int_s2;
  wire run_phase_alignment_int_s3_reg_n_0;
  wire rx_fsm_reset_done_int_s2;
  wire rx_fsm_reset_done_int_s3_reg_n_0;
  (* RTL_KEEP = "yes" *) wire [3:0]rx_state;
  wire rx_state16_out;
  wire rxpmaresetdone_i;
  wire rxpmaresetdone_rx_s;
  wire rxresetdone_s2;
  wire rxresetdone_s3;
  wire sync_QPLLLOCK_n_0;
  wire sync_QPLLLOCK_n_1;
  wire sync_data_valid_n_1;
  wire sync_data_valid_n_2;
  wire sync_data_valid_n_3;
  wire sync_data_valid_n_4;
  wire sync_data_valid_n_5;
  wire sync_data_valid_n_6;
  wire sync_mmcm_lock_reclocked_n_0;
  wire sync_mmcm_lock_reclocked_n_1;
  wire sync_rxpmaresetdone_n_0;
  wire sync_rxpmaresetdone_n_1;
  wire time_out_1us_i_1__0_n_0;
  wire time_out_1us_i_2__1_n_0;
  wire time_out_1us_i_3__2_n_0;
  wire time_out_1us_i_4__1_n_0;
  wire time_out_1us_i_5__1_n_0;
  wire time_out_1us_reg_n_0;
  wire time_out_2ms_i_1__1_n_0;
  wire time_out_2ms_i_2__2_n_0;
  wire time_out_2ms_i_3__0_n_0;
  wire time_out_2ms_i_4_n_0;
  wire time_out_2ms_reg_n_0;
  wire time_out_500us_i_1__1_n_0;
  wire time_out_500us_i_2__5_n_0;
  wire time_out_500us_i_3__5_n_0;
  wire time_out_500us_i_4__1_n_0;
  wire time_out_500us_i_5__0_n_0;
  wire time_out_500us_reg_n_0;
  wire time_out_counter;
  wire \time_out_counter[0]_i_10__5_n_0 ;
  wire \time_out_counter[0]_i_3__5_n_0 ;
  wire \time_out_counter[0]_i_4__1_n_0 ;
  wire \time_out_counter[0]_i_5_n_0 ;
  wire \time_out_counter[0]_i_9_n_0 ;
  wire [18:0]time_out_counter_reg;
  wire \time_out_counter_reg[0]_i_2__5_n_0 ;
  wire \time_out_counter_reg[0]_i_2__5_n_1 ;
  wire \time_out_counter_reg[0]_i_2__5_n_2 ;
  wire \time_out_counter_reg[0]_i_2__5_n_3 ;
  wire \time_out_counter_reg[0]_i_2__5_n_4 ;
  wire \time_out_counter_reg[0]_i_2__5_n_5 ;
  wire \time_out_counter_reg[0]_i_2__5_n_6 ;
  wire \time_out_counter_reg[0]_i_2__5_n_7 ;
  wire \time_out_counter_reg[12]_i_1__5_n_0 ;
  wire \time_out_counter_reg[12]_i_1__5_n_1 ;
  wire \time_out_counter_reg[12]_i_1__5_n_2 ;
  wire \time_out_counter_reg[12]_i_1__5_n_3 ;
  wire \time_out_counter_reg[12]_i_1__5_n_4 ;
  wire \time_out_counter_reg[12]_i_1__5_n_5 ;
  wire \time_out_counter_reg[12]_i_1__5_n_6 ;
  wire \time_out_counter_reg[12]_i_1__5_n_7 ;
  wire \time_out_counter_reg[16]_i_1__5_n_2 ;
  wire \time_out_counter_reg[16]_i_1__5_n_3 ;
  wire \time_out_counter_reg[16]_i_1__5_n_5 ;
  wire \time_out_counter_reg[16]_i_1__5_n_6 ;
  wire \time_out_counter_reg[16]_i_1__5_n_7 ;
  wire \time_out_counter_reg[4]_i_1__5_n_0 ;
  wire \time_out_counter_reg[4]_i_1__5_n_1 ;
  wire \time_out_counter_reg[4]_i_1__5_n_2 ;
  wire \time_out_counter_reg[4]_i_1__5_n_3 ;
  wire \time_out_counter_reg[4]_i_1__5_n_4 ;
  wire \time_out_counter_reg[4]_i_1__5_n_5 ;
  wire \time_out_counter_reg[4]_i_1__5_n_6 ;
  wire \time_out_counter_reg[4]_i_1__5_n_7 ;
  wire \time_out_counter_reg[8]_i_1__5_n_0 ;
  wire \time_out_counter_reg[8]_i_1__5_n_1 ;
  wire \time_out_counter_reg[8]_i_1__5_n_2 ;
  wire \time_out_counter_reg[8]_i_1__5_n_3 ;
  wire \time_out_counter_reg[8]_i_1__5_n_4 ;
  wire \time_out_counter_reg[8]_i_1__5_n_5 ;
  wire \time_out_counter_reg[8]_i_1__5_n_6 ;
  wire \time_out_counter_reg[8]_i_1__5_n_7 ;
  wire time_out_wait_bypass_i_1__5_n_0;
  wire time_out_wait_bypass_reg_n_0;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire time_tlock_max1;
  wire time_tlock_max1_carry__0_i_1__1_n_0;
  wire time_tlock_max1_carry__0_i_2__1_n_0;
  wire time_tlock_max1_carry__0_i_3__1_n_0;
  wire time_tlock_max1_carry__0_i_4__1_n_0;
  wire time_tlock_max1_carry__0_i_5__1_n_0;
  wire time_tlock_max1_carry__0_i_6__2_n_0;
  wire time_tlock_max1_carry__0_n_0;
  wire time_tlock_max1_carry__0_n_1;
  wire time_tlock_max1_carry__0_n_2;
  wire time_tlock_max1_carry__0_n_3;
  wire time_tlock_max1_carry__1_i_1__1_n_0;
  wire time_tlock_max1_carry__1_i_2__1_n_0;
  wire time_tlock_max1_carry__1_i_3__1_n_0;
  wire time_tlock_max1_carry__1_n_3;
  wire time_tlock_max1_carry_i_1__1_n_0;
  wire time_tlock_max1_carry_i_2__1_n_0;
  wire time_tlock_max1_carry_i_3__1_n_0;
  wire time_tlock_max1_carry_i_4__1_n_0;
  wire time_tlock_max1_carry_i_5__1_n_0;
  wire time_tlock_max1_carry_i_6__1_n_0;
  wire time_tlock_max1_carry_i_7__1_n_0;
  wire time_tlock_max1_carry_n_0;
  wire time_tlock_max1_carry_n_1;
  wire time_tlock_max1_carry_n_2;
  wire time_tlock_max1_carry_n_3;
  wire time_tlock_max_i_1__1_n_0;
  wire \wait_bypass_count[0]_i_10__5_n_0 ;
  wire \wait_bypass_count[0]_i_1__5_n_0 ;
  wire \wait_bypass_count[0]_i_2__5_n_0 ;
  wire \wait_bypass_count[0]_i_4__5_n_0 ;
  wire \wait_bypass_count[0]_i_8__5_n_0 ;
  wire \wait_bypass_count[0]_i_9__5_n_0 ;
  wire [12:0]wait_bypass_count_reg;
  wire \wait_bypass_count_reg[0]_i_3__5_n_0 ;
  wire \wait_bypass_count_reg[0]_i_3__5_n_1 ;
  wire \wait_bypass_count_reg[0]_i_3__5_n_2 ;
  wire \wait_bypass_count_reg[0]_i_3__5_n_3 ;
  wire \wait_bypass_count_reg[0]_i_3__5_n_4 ;
  wire \wait_bypass_count_reg[0]_i_3__5_n_5 ;
  wire \wait_bypass_count_reg[0]_i_3__5_n_6 ;
  wire \wait_bypass_count_reg[0]_i_3__5_n_7 ;
  wire \wait_bypass_count_reg[12]_i_1__5_n_7 ;
  wire \wait_bypass_count_reg[4]_i_1__5_n_0 ;
  wire \wait_bypass_count_reg[4]_i_1__5_n_1 ;
  wire \wait_bypass_count_reg[4]_i_1__5_n_2 ;
  wire \wait_bypass_count_reg[4]_i_1__5_n_3 ;
  wire \wait_bypass_count_reg[4]_i_1__5_n_4 ;
  wire \wait_bypass_count_reg[4]_i_1__5_n_5 ;
  wire \wait_bypass_count_reg[4]_i_1__5_n_6 ;
  wire \wait_bypass_count_reg[4]_i_1__5_n_7 ;
  wire \wait_bypass_count_reg[8]_i_1__5_n_0 ;
  wire \wait_bypass_count_reg[8]_i_1__5_n_1 ;
  wire \wait_bypass_count_reg[8]_i_1__5_n_2 ;
  wire \wait_bypass_count_reg[8]_i_1__5_n_3 ;
  wire \wait_bypass_count_reg[8]_i_1__5_n_4 ;
  wire \wait_bypass_count_reg[8]_i_1__5_n_5 ;
  wire \wait_bypass_count_reg[8]_i_1__5_n_6 ;
  wire \wait_bypass_count_reg[8]_i_1__5_n_7 ;
  wire [6:0]wait_time_cnt0;
  wire \wait_time_cnt[1]_i_1__5_n_0 ;
  wire \wait_time_cnt[4]_i_1__5_n_0 ;
  wire \wait_time_cnt[6]_i_1__5_n_0 ;
  wire \wait_time_cnt[6]_i_2__5_n_0 ;
  wire \wait_time_cnt[6]_i_4__5_n_0 ;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__5_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__5_O_UNCONNECTED ;
  wire [3:0]NLW_time_tlock_max1_carry_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max1_carry__0_O_UNCONNECTED;
  wire [3:2]NLW_time_tlock_max1_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max1_carry__1_O_UNCONNECTED;
  wire [3:0]\NLW_wait_bypass_count_reg[12]_i_1__5_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[12]_i_1__5_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h08B80888FFFFFFFF)) 
    \FSM_sequential_rx_state[0]_i_2__1 
       (.I0(time_out_2ms_reg_n_0),
        .I1(rx_state[1]),
        .I2(rx_state[2]),
        .I3(reset_time_out_reg_n_0),
        .I4(time_tlock_max),
        .I5(rx_state[0]),
        .O(\FSM_sequential_rx_state[0]_i_2__1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000262226AA)) 
    \FSM_sequential_rx_state[2]_i_1__1 
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(time_out_2ms_reg_n_0),
        .I3(rx_state[1]),
        .I4(rx_state16_out),
        .I5(rx_state[3]),
        .O(\FSM_sequential_rx_state[2]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_rx_state[2]_i_2__1 
       (.I0(time_tlock_max),
        .I1(reset_time_out_reg_n_0),
        .O(rx_state16_out));
  LUT6 #(
    .INIT(64'h00F0BBBB00F08888)) 
    \FSM_sequential_rx_state[3]_i_5__1 
       (.I0(gt2_rx_cdrlocked_reg_0),
        .I1(rx_state[2]),
        .I2(\FSM_sequential_rx_state[3]_i_9__1_n_0 ),
        .I3(wait_time_cnt_reg__0[6]),
        .I4(rx_state[1]),
        .I5(init_wait_done_reg_n_0),
        .O(\FSM_sequential_rx_state[3]_i_5__1_n_0 ));
  LUT5 #(
    .INIT(32'h80880000)) 
    \FSM_sequential_rx_state[3]_i_6__1 
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(reset_time_out_reg_n_0),
        .I3(time_out_2ms_reg_n_0),
        .I4(rx_state[0]),
        .O(\FSM_sequential_rx_state[3]_i_6__1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0EFEFAFA0EFE0)) 
    \FSM_sequential_rx_state[3]_i_8__1 
       (.I0(rxresetdone_s3),
        .I1(time_out_2ms_reg_n_0),
        .I2(rx_state[1]),
        .I3(mmcm_lock_reclocked),
        .I4(reset_time_out_reg_n_0),
        .I5(time_tlock_max),
        .O(\FSM_sequential_rx_state[3]_i_8__1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_sequential_rx_state[3]_i_9__1 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[4]),
        .I5(wait_time_cnt_reg__0[5]),
        .O(\FSM_sequential_rx_state[3]_i_9__1_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_5),
        .Q(rx_state[0]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_4),
        .Q(rx_state[1]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(\FSM_sequential_rx_state[2]_i_1__1_n_0 ),
        .Q(rx_state[2]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_3),
        .Q(rx_state[3]),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFD0080)) 
    RXUSERRDY_i_1__1
       (.I0(rx_state[0]),
        .I1(rx_state[2]),
        .I2(rx_state[1]),
        .I3(rx_state[3]),
        .I4(gt2_rxuserrdy_in),
        .O(RXUSERRDY_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    RXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(RXUSERRDY_i_1__1_n_0),
        .Q(gt2_rxuserrdy_in),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    check_tlock_max_i_1__1
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .I3(rx_state[3]),
        .I4(check_tlock_max_reg_n_0),
        .O(check_tlock_max_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    check_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(check_tlock_max_i_1__1_n_0),
        .Q(check_tlock_max_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT3 #(
    .INIT(8'h0E)) 
    gt2_rx_cdrlocked_i_1
       (.I0(gt2_rx_cdrlocked_reg_0),
        .I1(gt2_rx_cdrlocked),
        .I2(reset_sync1_rx_0),
        .O(gt2_rx_cdrlocked_reg));
  LUT5 #(
    .INIT(32'hFFFB0010)) 
    gtrxreset_i_i_1__1
       (.I0(rx_state[1]),
        .I1(rx_state[2]),
        .I2(rx_state[0]),
        .I3(rx_state[3]),
        .I4(reset_sync1_rx_0),
        .O(gtrxreset_i_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    gtrxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gtrxreset_i_i_1__1_n_0),
        .Q(reset_sync1_rx_0),
        .R(SOFT_RESET_IN));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \init_wait_count[0]_i_1__5 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \init_wait_count[1]_i_1__5 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \init_wait_count[2]_i_1__5 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \init_wait_count[3]_i_1__5 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \init_wait_count[4]_i_1__5 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \init_wait_count[5]_i_1__5 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
    \init_wait_count[6]_i_1__5 
       (.I0(\init_wait_count[6]_i_3__5_n_0 ),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_count));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT5 #(
    .INIT(32'h9AAAAAAA)) 
    \init_wait_count[6]_i_2__5 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\init_wait_count[6]_i_4__5_n_0 ),
        .I2(init_wait_count_reg__0[4]),
        .I3(init_wait_count_reg__0[3]),
        .I4(init_wait_count_reg__0[5]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \init_wait_count[6]_i_3__5 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(\init_wait_count[6]_i_3__5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \init_wait_count[6]_i_4__5 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(\init_wait_count[6]_i_4__5_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[0]),
        .Q(init_wait_count_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
  LUT2 #(
    .INIT(4'hE)) 
    init_wait_done_i_1__5
       (.I0(init_wait_done),
        .I1(init_wait_done_reg_n_0),
        .O(init_wait_done_i_1__5_n_0));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    init_wait_done_i_2__5
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\init_wait_count[6]_i_3__5_n_0 ),
        .O(init_wait_done));
  FDCE #(
    .INIT(1'b0)) 
    init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(init_wait_done_i_1__5_n_0),
        .Q(init_wait_done_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[0]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \mmcm_lock_count[1]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \mmcm_lock_count[2]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \mmcm_lock_count[3]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[4]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[2]),
        .I4(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \mmcm_lock_count[5]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \mmcm_lock_count[6]_i_1__5 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__5_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__0[6]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \mmcm_lock_count[7]_i_2__5 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__5_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(\mmcm_lock_count[7]_i_2__5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[7]_i_3__5 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(mmcm_lock_count_reg__0[5]),
        .I2(\mmcm_lock_count[7]_i_4__5_n_0 ),
        .I3(mmcm_lock_count_reg__0[4]),
        .I4(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \mmcm_lock_count[7]_i_4__5 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .O(\mmcm_lock_count[7]_i_4__5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__5_n_0 ),
        .D(p_0_in__0[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__5_n_0 ),
        .D(p_0_in__0[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__5_n_0 ),
        .D(p_0_in__0[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__5_n_0 ),
        .D(p_0_in__0[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__5_n_0 ),
        .D(p_0_in__0[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__5_n_0 ),
        .D(p_0_in__0[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__5_n_0 ),
        .D(p_0_in__0[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__5_n_0 ),
        .D(p_0_in__0[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(sync_mmcm_lock_reclocked_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    mmcm_lock_reclocked_i_2__5
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(mmcm_lock_reclocked_i_2__5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_mmcm_lock_reclocked_n_1),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    mmcm_reset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_rxpmaresetdone_n_0),
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
        .PRE(reset_sync1_rx_0),
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
        .PRE(reset_sync1_rx_0),
        .Q(gtrxreset_s));
  LUT3 #(
    .INIT(8'h07)) 
    reset_time_out_i_4__5
       (.I0(rx_state[1]),
        .I1(rx_state[0]),
        .I2(rx_state[2]),
        .O(reset_time_out_i_4__5_n_0));
  FDSE #(
    .INIT(1'b0)) 
    reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_data_valid_n_1),
        .Q(reset_time_out_reg_n_0),
        .S(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFEFF0002)) 
    run_phase_alignment_int_i_1__5
       (.I0(rx_state[3]),
        .I1(rx_state[2]),
        .I2(rx_state[1]),
        .I3(rx_state[0]),
        .I4(run_phase_alignment_int_reg_n_0),
        .O(run_phase_alignment_int_i_1__5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(run_phase_alignment_int_i_1__5_n_0),
        .Q(run_phase_alignment_int_reg_n_0),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_s3_reg
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(run_phase_alignment_int_s2),
        .Q(run_phase_alignment_int_s3_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    rx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_data_valid_n_2),
        .Q(GT2_RX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    rx_fsm_reset_done_int_s3_reg
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(rx_fsm_reset_done_int_s2),
        .Q(rx_fsm_reset_done_int_s3_reg_n_0),
        .R(1'b0));
  FDCE #(
    .INIT(1'b0)) 
    rxpmaresetdone_i_reg
       (.C(RXOUTCLK),
        .CE(1'b1),
        .CLR(gtrxreset_s),
        .D(rxpmaresetdone_rx_s),
        .Q(rxpmaresetdone_i));
  FDRE #(
    .INIT(1'b0)) 
    rxresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(rxresetdone_s2),
        .Q(rxresetdone_s3),
        .R(1'b0));
  XLAUI_XLAUI_sync_block_26 sync_QPLLLOCK
       (.\FSM_sequential_rx_state_reg[0] (sync_QPLLLOCK_n_0),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .data_out(data_valid_sync),
        .gt2_rx_cdrlocked_reg(gt2_rx_cdrlocked_reg_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state[2:0]),
        .reset_time_out_reg(sync_QPLLLOCK_n_1),
        .rxresetdone_s3(rxresetdone_s3),
        .rxresetdone_s3_reg(\FSM_sequential_rx_state[3]_i_8__1_n_0 ),
        .time_out_2ms_reg(time_out_2ms_reg_n_0));
  XLAUI_XLAUI_sync_block_27 sync_RXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(rxresetdone_s2),
        .gt2_rxresetdone_out(gt2_rxresetdone_out));
  XLAUI_XLAUI_sync_block_28 sync_data_valid
       (.D({sync_data_valid_n_3,sync_data_valid_n_4,sync_data_valid_n_5}),
        .DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .E(sync_data_valid_n_6),
        .\FSM_sequential_rx_state_reg[0] (sync_QPLLLOCK_n_1),
        .\FSM_sequential_rx_state_reg[1] (reset_time_out_i_4__5_n_0),
        .\FSM_sequential_rx_state_reg[2] (sync_QPLLLOCK_n_0),
        .\FSM_sequential_rx_state_reg[2]_0 (\FSM_sequential_rx_state[3]_i_6__1_n_0 ),
        .GT2_DATA_VALID_IN(GT2_DATA_VALID_IN),
        .GT2_RX_FSM_RESET_DONE_OUT(GT2_RX_FSM_RESET_DONE_OUT),
        .SYSCLK_IN(SYSCLK_IN),
        .data_out(data_valid_sync),
        .gt2_rx_cdrlocked_reg(\FSM_sequential_rx_state[3]_i_5__1_n_0 ),
        .mmcm_lock_reclocked_reg(sync_rxpmaresetdone_n_1),
        .out(rx_state),
        .reset_time_out_reg(sync_data_valid_n_1),
        .reset_time_out_reg_0(reset_time_out_reg_n_0),
        .rx_fsm_reset_done_int_reg(sync_data_valid_n_2),
        .rx_state16_out(rx_state16_out),
        .time_out_1us_reg(time_out_1us_reg_n_0),
        .time_out_2ms_reg(\FSM_sequential_rx_state[0]_i_2__1_n_0 ),
        .time_out_500us_reg(time_out_500us_reg_n_0),
        .time_out_wait_bypass_s3(time_out_wait_bypass_s3));
  XLAUI_XLAUI_sync_block_29 sync_mmcm_lock_reclocked
       (.GT2_RX_MMCM_LOCK_IN(GT2_RX_MMCM_LOCK_IN),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(sync_mmcm_lock_reclocked_n_0),
        .SYSCLK_IN(SYSCLK_IN),
        .\mmcm_lock_count_reg[5] (mmcm_lock_reclocked_i_2__5_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_lock_reclocked_reg(sync_mmcm_lock_reclocked_n_1));
  XLAUI_XLAUI_sync_block_30 sync_run_phase_alignment_int
       (.data_in(run_phase_alignment_int_reg_n_0),
        .data_out(run_phase_alignment_int_s2),
        .gt2_rxusrclk_in(gt2_rxusrclk_in));
  XLAUI_XLAUI_sync_block_31 sync_rx_fsm_reset_done_int
       (.GT2_RX_FSM_RESET_DONE_OUT(GT2_RX_FSM_RESET_DONE_OUT),
        .data_out(rx_fsm_reset_done_int_s2),
        .gt2_rxusrclk_in(gt2_rxusrclk_in));
  XLAUI_XLAUI_sync_block_32 sync_rxpmaresetdone
       (.GT2_RX_MMCM_RESET_OUT(GT2_RX_MMCM_RESET_OUT),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(rxpmaresetdone_i),
        .gt2_rx_cdrlocked_reg(gt2_rx_cdrlocked_reg_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_reset_i_reg(sync_rxpmaresetdone_n_0),
        .out(rx_state),
        .reset_time_out_reg(sync_rxpmaresetdone_n_1));
  XLAUI_XLAUI_sync_block_33 sync_rxpmaresetdone_rx_s
       (.RXOUTCLK(RXOUTCLK),
        .data_in(data_in),
        .data_out(rxpmaresetdone_rx_s));
  XLAUI_XLAUI_sync_block_34 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(time_out_wait_bypass_reg_n_0),
        .data_out(time_out_wait_bypass_s2));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000010)) 
    time_out_1us_i_1__0
       (.I0(time_out_1us_i_2__1_n_0),
        .I1(time_out_1us_i_3__2_n_0),
        .I2(time_out_counter_reg[1]),
        .I3(time_out_counter_reg[0]),
        .I4(time_out_1us_i_4__1_n_0),
        .I5(time_out_1us_reg_n_0),
        .O(time_out_1us_i_1__0_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFEF)) 
    time_out_1us_i_2__1
       (.I0(time_out_500us_i_5__0_n_0),
        .I1(time_out_1us_i_5__1_n_0),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[15]),
        .I4(time_out_counter_reg[6]),
        .O(time_out_1us_i_2__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT2 #(
    .INIT(4'hE)) 
    time_out_1us_i_3__2
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[17]),
        .O(time_out_1us_i_3__2_n_0));
  LUT4 #(
    .INIT(16'hFFFD)) 
    time_out_1us_i_4__1
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[3]),
        .O(time_out_1us_i_4__1_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    time_out_1us_i_5__1
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[16]),
        .O(time_out_1us_i_5__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_1us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_1us_i_1__0_n_0),
        .Q(time_out_1us_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000040)) 
    time_out_2ms_i_1__1
       (.I0(time_out_2ms_i_2__2_n_0),
        .I1(time_out_2ms_i_3__0_n_0),
        .I2(time_out_2ms_i_4_n_0),
        .I3(time_out_counter_reg[1]),
        .I4(time_out_counter_reg[15]),
        .I5(time_out_2ms_reg_n_0),
        .O(time_out_2ms_i_1__1_n_0));
  LUT5 #(
    .INIT(32'hEFFFFFFF)) 
    time_out_2ms_i_2__2
       (.I0(\time_out_counter[0]_i_3__5_n_0 ),
        .I1(\time_out_counter[0]_i_4__1_n_0 ),
        .I2(time_out_counter_reg[12]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[4]),
        .O(time_out_2ms_i_2__2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    time_out_2ms_i_3__0
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[14]),
        .O(time_out_2ms_i_3__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT2 #(
    .INIT(4'h1)) 
    time_out_2ms_i_4
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(time_out_2ms_i_4_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_2ms_i_1__1_n_0),
        .Q(time_out_2ms_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000040)) 
    time_out_500us_i_1__1
       (.I0(time_out_500us_i_2__5_n_0),
        .I1(time_out_500us_i_3__5_n_0),
        .I2(time_out_500us_i_4__1_n_0),
        .I3(time_out_counter_reg[1]),
        .I4(time_out_counter_reg[15]),
        .I5(time_out_500us_reg_n_0),
        .O(time_out_500us_i_1__1_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFEF)) 
    time_out_500us_i_2__5
       (.I0(time_out_500us_i_5__0_n_0),
        .I1(time_out_counter_reg[18]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[17]),
        .I4(\time_out_counter[0]_i_3__5_n_0 ),
        .O(time_out_500us_i_2__5_n_0));
  LUT4 #(
    .INIT(16'h0080)) 
    time_out_500us_i_3__5
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[6]),
        .O(time_out_500us_i_3__5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT2 #(
    .INIT(4'h2)) 
    time_out_500us_i_4__1
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .O(time_out_500us_i_4__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT4 #(
    .INIT(16'hFFFD)) 
    time_out_500us_i_5__0
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[11]),
        .I3(time_out_counter_reg[4]),
        .O(time_out_500us_i_5__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_500us_i_1__1_n_0),
        .Q(time_out_500us_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    \time_out_counter[0]_i_10__5 
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[15]),
        .O(\time_out_counter[0]_i_10__5_n_0 ));
  LUT6 #(
    .INIT(64'hEFFFFFFFFFFFFFFF)) 
    \time_out_counter[0]_i_1__1 
       (.I0(\time_out_counter[0]_i_3__5_n_0 ),
        .I1(\time_out_counter[0]_i_4__1_n_0 ),
        .I2(time_out_counter_reg[12]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[4]),
        .I5(\time_out_counter[0]_i_5_n_0 ),
        .O(time_out_counter));
  LUT4 #(
    .INIT(16'hFFEF)) 
    \time_out_counter[0]_i_3__5 
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[16]),
        .I3(time_out_counter_reg[5]),
        .O(\time_out_counter[0]_i_3__5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT4 #(
    .INIT(16'hFF7F)) 
    \time_out_counter[0]_i_4__1 
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[11]),
        .O(\time_out_counter[0]_i_4__1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000001000000)) 
    \time_out_counter[0]_i_5 
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[17]),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[2]),
        .I4(time_out_2ms_i_4_n_0),
        .I5(\time_out_counter[0]_i_10__5_n_0 ),
        .O(\time_out_counter[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_9 
       (.I0(time_out_counter_reg[0]),
        .O(\time_out_counter[0]_i_9_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__5_n_7 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[0]_i_2__5 
       (.CI(1'b0),
        .CO({\time_out_counter_reg[0]_i_2__5_n_0 ,\time_out_counter_reg[0]_i_2__5_n_1 ,\time_out_counter_reg[0]_i_2__5_n_2 ,\time_out_counter_reg[0]_i_2__5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\time_out_counter_reg[0]_i_2__5_n_4 ,\time_out_counter_reg[0]_i_2__5_n_5 ,\time_out_counter_reg[0]_i_2__5_n_6 ,\time_out_counter_reg[0]_i_2__5_n_7 }),
        .S({time_out_counter_reg[3:1],\time_out_counter[0]_i_9_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__5_n_5 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__5_n_4 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__5_n_7 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[12]_i_1__5 
       (.CI(\time_out_counter_reg[8]_i_1__5_n_0 ),
        .CO({\time_out_counter_reg[12]_i_1__5_n_0 ,\time_out_counter_reg[12]_i_1__5_n_1 ,\time_out_counter_reg[12]_i_1__5_n_2 ,\time_out_counter_reg[12]_i_1__5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[12]_i_1__5_n_4 ,\time_out_counter_reg[12]_i_1__5_n_5 ,\time_out_counter_reg[12]_i_1__5_n_6 ,\time_out_counter_reg[12]_i_1__5_n_7 }),
        .S(time_out_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__5_n_6 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__5_n_5 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__5_n_4 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__5_n_7 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[16]_i_1__5 
       (.CI(\time_out_counter_reg[12]_i_1__5_n_0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__5_CO_UNCONNECTED [3:2],\time_out_counter_reg[16]_i_1__5_n_2 ,\time_out_counter_reg[16]_i_1__5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__5_O_UNCONNECTED [3],\time_out_counter_reg[16]_i_1__5_n_5 ,\time_out_counter_reg[16]_i_1__5_n_6 ,\time_out_counter_reg[16]_i_1__5_n_7 }),
        .S({1'b0,time_out_counter_reg[18:16]}));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__5_n_6 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__5_n_5 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__5_n_6 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__5_n_5 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__5_n_4 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__5_n_7 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[4]_i_1__5 
       (.CI(\time_out_counter_reg[0]_i_2__5_n_0 ),
        .CO({\time_out_counter_reg[4]_i_1__5_n_0 ,\time_out_counter_reg[4]_i_1__5_n_1 ,\time_out_counter_reg[4]_i_1__5_n_2 ,\time_out_counter_reg[4]_i_1__5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[4]_i_1__5_n_4 ,\time_out_counter_reg[4]_i_1__5_n_5 ,\time_out_counter_reg[4]_i_1__5_n_6 ,\time_out_counter_reg[4]_i_1__5_n_7 }),
        .S(time_out_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__5_n_6 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__5_n_5 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__5_n_4 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__5_n_7 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[8]_i_1__5 
       (.CI(\time_out_counter_reg[4]_i_1__5_n_0 ),
        .CO({\time_out_counter_reg[8]_i_1__5_n_0 ,\time_out_counter_reg[8]_i_1__5_n_1 ,\time_out_counter_reg[8]_i_1__5_n_2 ,\time_out_counter_reg[8]_i_1__5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[8]_i_1__5_n_4 ,\time_out_counter_reg[8]_i_1__5_n_5 ,\time_out_counter_reg[8]_i_1__5_n_6 ,\time_out_counter_reg[8]_i_1__5_n_7 }),
        .S(time_out_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__5_n_6 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out_reg_n_0));
  LUT4 #(
    .INIT(16'hAB00)) 
    time_out_wait_bypass_i_1__5
       (.I0(time_out_wait_bypass_reg_n_0),
        .I1(rx_fsm_reset_done_int_s3_reg_n_0),
        .I2(\wait_bypass_count[0]_i_4__5_n_0 ),
        .I3(run_phase_alignment_int_s3_reg_n_0),
        .O(time_out_wait_bypass_i_1__5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_reg
       (.C(gt2_rxusrclk_in),
        .CE(1'b1),
        .D(time_out_wait_bypass_i_1__5_n_0),
        .Q(time_out_wait_bypass_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
  CARRY4 time_tlock_max1_carry
       (.CI(1'b0),
        .CO({time_tlock_max1_carry_n_0,time_tlock_max1_carry_n_1,time_tlock_max1_carry_n_2,time_tlock_max1_carry_n_3}),
        .CYINIT(1'b0),
        .DI({time_tlock_max1_carry_i_1__1_n_0,time_out_counter_reg[5],time_tlock_max1_carry_i_2__1_n_0,time_tlock_max1_carry_i_3__1_n_0}),
        .O(NLW_time_tlock_max1_carry_O_UNCONNECTED[3:0]),
        .S({time_tlock_max1_carry_i_4__1_n_0,time_tlock_max1_carry_i_5__1_n_0,time_tlock_max1_carry_i_6__1_n_0,time_tlock_max1_carry_i_7__1_n_0}));
  CARRY4 time_tlock_max1_carry__0
       (.CI(time_tlock_max1_carry_n_0),
        .CO({time_tlock_max1_carry__0_n_0,time_tlock_max1_carry__0_n_1,time_tlock_max1_carry__0_n_2,time_tlock_max1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({time_out_counter_reg[15],time_tlock_max1_carry__0_i_1__1_n_0,time_tlock_max1_carry__0_i_2__1_n_0,time_out_counter_reg[9]}),
        .O(NLW_time_tlock_max1_carry__0_O_UNCONNECTED[3:0]),
        .S({time_tlock_max1_carry__0_i_3__1_n_0,time_tlock_max1_carry__0_i_4__1_n_0,time_tlock_max1_carry__0_i_5__1_n_0,time_tlock_max1_carry__0_i_6__2_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__0_i_1__1
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .O(time_tlock_max1_carry__0_i_1__1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__0_i_2__1
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[10]),
        .O(time_tlock_max1_carry__0_i_2__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry__0_i_3__1
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[15]),
        .O(time_tlock_max1_carry__0_i_3__1_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__0_i_4__1
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(time_tlock_max1_carry__0_i_4__1_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__0_i_5__1
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(time_tlock_max1_carry__0_i_5__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry__0_i_6__2
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .O(time_tlock_max1_carry__0_i_6__2_n_0));
  CARRY4 time_tlock_max1_carry__1
       (.CI(time_tlock_max1_carry__0_n_0),
        .CO({NLW_time_tlock_max1_carry__1_CO_UNCONNECTED[3:2],time_tlock_max1,time_tlock_max1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,time_out_counter_reg[18],time_tlock_max1_carry__1_i_1__1_n_0}),
        .O(NLW_time_tlock_max1_carry__1_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,time_tlock_max1_carry__1_i_2__1_n_0,time_tlock_max1_carry__1_i_3__1_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__1_i_1__1
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[16]),
        .O(time_tlock_max1_carry__1_i_1__1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    time_tlock_max1_carry__1_i_2__1
       (.I0(time_out_counter_reg[18]),
        .O(time_tlock_max1_carry__1_i_2__1_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__1_i_3__1
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(time_tlock_max1_carry__1_i_3__1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry_i_1__1
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[6]),
        .O(time_tlock_max1_carry_i_1__1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    time_tlock_max1_carry_i_2__1
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(time_tlock_max1_carry_i_2__1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    time_tlock_max1_carry_i_3__1
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(time_tlock_max1_carry_i_3__1_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry_i_4__1
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(time_tlock_max1_carry_i_4__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_5__1
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[5]),
        .O(time_tlock_max1_carry_i_5__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_6__1
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(time_tlock_max1_carry_i_6__1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_7__1
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(time_tlock_max1_carry_i_7__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    time_tlock_max_i_1__1
       (.I0(time_tlock_max1),
        .I1(check_tlock_max_reg_n_0),
        .I2(time_tlock_max),
        .O(time_tlock_max_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_tlock_max_i_1__1_n_0),
        .Q(time_tlock_max),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \wait_bypass_count[0]_i_10__5 
       (.I0(wait_bypass_count_reg[2]),
        .I1(wait_bypass_count_reg[12]),
        .I2(wait_bypass_count_reg[4]),
        .I3(wait_bypass_count_reg[10]),
        .I4(wait_bypass_count_reg[6]),
        .I5(wait_bypass_count_reg[11]),
        .O(\wait_bypass_count[0]_i_10__5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_1__5 
       (.I0(run_phase_alignment_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_1__5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \wait_bypass_count[0]_i_2__5 
       (.I0(\wait_bypass_count[0]_i_4__5_n_0 ),
        .I1(rx_fsm_reset_done_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_2__5_n_0 ));
  LUT5 #(
    .INIT(32'hBFFFFFFF)) 
    \wait_bypass_count[0]_i_4__5 
       (.I0(\wait_bypass_count[0]_i_9__5_n_0 ),
        .I1(wait_bypass_count_reg[1]),
        .I2(wait_bypass_count_reg[8]),
        .I3(wait_bypass_count_reg[0]),
        .I4(\wait_bypass_count[0]_i_10__5_n_0 ),
        .O(\wait_bypass_count[0]_i_4__5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_8__5 
       (.I0(wait_bypass_count_reg[0]),
        .O(\wait_bypass_count[0]_i_8__5_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \wait_bypass_count[0]_i_9__5 
       (.I0(wait_bypass_count_reg[3]),
        .I1(wait_bypass_count_reg[5]),
        .I2(wait_bypass_count_reg[9]),
        .I3(wait_bypass_count_reg[7]),
        .O(\wait_bypass_count[0]_i_9__5_n_0 ));
  FDRE \wait_bypass_count_reg[0] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__5_n_7 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  CARRY4 \wait_bypass_count_reg[0]_i_3__5 
       (.CI(1'b0),
        .CO({\wait_bypass_count_reg[0]_i_3__5_n_0 ,\wait_bypass_count_reg[0]_i_3__5_n_1 ,\wait_bypass_count_reg[0]_i_3__5_n_2 ,\wait_bypass_count_reg[0]_i_3__5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\wait_bypass_count_reg[0]_i_3__5_n_4 ,\wait_bypass_count_reg[0]_i_3__5_n_5 ,\wait_bypass_count_reg[0]_i_3__5_n_6 ,\wait_bypass_count_reg[0]_i_3__5_n_7 }),
        .S({wait_bypass_count_reg[3:1],\wait_bypass_count[0]_i_8__5_n_0 }));
  FDRE \wait_bypass_count_reg[10] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__5_n_5 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  FDRE \wait_bypass_count_reg[11] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__5_n_4 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  FDRE \wait_bypass_count_reg[12] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__5_n_7 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  CARRY4 \wait_bypass_count_reg[12]_i_1__5 
       (.CI(\wait_bypass_count_reg[8]_i_1__5_n_0 ),
        .CO(\NLW_wait_bypass_count_reg[12]_i_1__5_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[12]_i_1__5_O_UNCONNECTED [3:1],\wait_bypass_count_reg[12]_i_1__5_n_7 }),
        .S({1'b0,1'b0,1'b0,wait_bypass_count_reg[12]}));
  FDRE \wait_bypass_count_reg[1] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__5_n_6 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  FDRE \wait_bypass_count_reg[2] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__5_n_5 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  FDRE \wait_bypass_count_reg[3] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__5_n_4 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  FDRE \wait_bypass_count_reg[4] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__5_n_7 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  CARRY4 \wait_bypass_count_reg[4]_i_1__5 
       (.CI(\wait_bypass_count_reg[0]_i_3__5_n_0 ),
        .CO({\wait_bypass_count_reg[4]_i_1__5_n_0 ,\wait_bypass_count_reg[4]_i_1__5_n_1 ,\wait_bypass_count_reg[4]_i_1__5_n_2 ,\wait_bypass_count_reg[4]_i_1__5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[4]_i_1__5_n_4 ,\wait_bypass_count_reg[4]_i_1__5_n_5 ,\wait_bypass_count_reg[4]_i_1__5_n_6 ,\wait_bypass_count_reg[4]_i_1__5_n_7 }),
        .S(wait_bypass_count_reg[7:4]));
  FDRE \wait_bypass_count_reg[5] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__5_n_6 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  FDRE \wait_bypass_count_reg[6] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__5_n_5 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  FDRE \wait_bypass_count_reg[7] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__5_n_4 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  FDRE \wait_bypass_count_reg[8] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__5_n_7 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  CARRY4 \wait_bypass_count_reg[8]_i_1__5 
       (.CI(\wait_bypass_count_reg[4]_i_1__5_n_0 ),
        .CO({\wait_bypass_count_reg[8]_i_1__5_n_0 ,\wait_bypass_count_reg[8]_i_1__5_n_1 ,\wait_bypass_count_reg[8]_i_1__5_n_2 ,\wait_bypass_count_reg[8]_i_1__5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[8]_i_1__5_n_4 ,\wait_bypass_count_reg[8]_i_1__5_n_5 ,\wait_bypass_count_reg[8]_i_1__5_n_6 ,\wait_bypass_count_reg[8]_i_1__5_n_7 }),
        .S(wait_bypass_count_reg[11:8]));
  FDRE \wait_bypass_count_reg[9] 
       (.C(gt2_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__5_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__5_n_6 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\wait_bypass_count[0]_i_1__5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_time_cnt[0]_i_1__5 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \wait_time_cnt[1]_i_1__5 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\wait_time_cnt[1]_i_1__5_n_0 ));
  LUT3 #(
    .INIT(8'hE1)) 
    \wait_time_cnt[2]_i_1__5 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[2]),
        .O(wait_time_cnt0[2]));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \wait_time_cnt[3]_i_1__5 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0[3]));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \wait_time_cnt[4]_i_1__5 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\wait_time_cnt[4]_i_1__5_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
    \wait_time_cnt[5]_i_1__5 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[5]));
  LUT3 #(
    .INIT(8'h10)) 
    \wait_time_cnt[6]_i_1__5 
       (.I0(rx_state[3]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .O(\wait_time_cnt[6]_i_1__5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_2__5 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\wait_time_cnt[6]_i_4__5_n_0 ),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(wait_time_cnt_reg__0[5]),
        .O(\wait_time_cnt[6]_i_2__5_n_0 ));
  LUT4 #(
    .INIT(16'hAAA9)) 
    \wait_time_cnt[6]_i_3__5 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(\wait_time_cnt[6]_i_4__5_n_0 ),
        .O(wait_time_cnt0[6]));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_4__5 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .O(\wait_time_cnt[6]_i_4__5_n_0 ));
  FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__5_n_0 ),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\wait_time_cnt[6]_i_1__5_n_0 ));
  FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__5_n_0 ),
        .D(\wait_time_cnt[1]_i_1__5_n_0 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\wait_time_cnt[6]_i_1__5_n_0 ));
  FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__5_n_0 ),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\wait_time_cnt[6]_i_1__5_n_0 ));
  FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__5_n_0 ),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\wait_time_cnt[6]_i_1__5_n_0 ));
  FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__5_n_0 ),
        .D(\wait_time_cnt[4]_i_1__5_n_0 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\wait_time_cnt[6]_i_1__5_n_0 ));
  FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__5_n_0 ),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\wait_time_cnt[6]_i_1__5_n_0 ));
  FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__5_n_0 ),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\wait_time_cnt[6]_i_1__5_n_0 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_RX_STARTUP_FSM" *) 
module XLAUI_XLAUI_RX_STARTUP_FSM_4
   (reset_sync1_rx_0,
    GT3_RX_MMCM_RESET_OUT,
    GT3_RX_FSM_RESET_DONE_OUT,
    gt3_rxuserrdy_in,
    gt3_rx_cdrlocked_reg,
    RXOUTCLK,
    SYSCLK_IN,
    gt3_rxusrclk_in,
    SOFT_RESET_IN,
    DONT_RESET_ON_DATA_ERROR_IN,
    gt3_rx_cdrlocked_reg_0,
    gt3_rx_cdrlocked,
    data_in,
    gt3_rxresetdone_out,
    GT3_RX_MMCM_LOCK_IN,
    GT3_DATA_VALID_IN,
    GT0_QPLLLOCK_IN);
  output [0:0]reset_sync1_rx_0;
  output GT3_RX_MMCM_RESET_OUT;
  output GT3_RX_FSM_RESET_DONE_OUT;
  output gt3_rxuserrdy_in;
  output gt3_rx_cdrlocked_reg;
  input RXOUTCLK;
  input SYSCLK_IN;
  input gt3_rxusrclk_in;
  input SOFT_RESET_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input gt3_rx_cdrlocked_reg_0;
  input gt3_rx_cdrlocked;
  input data_in;
  input gt3_rxresetdone_out;
  input GT3_RX_MMCM_LOCK_IN;
  input GT3_DATA_VALID_IN;
  input GT0_QPLLLOCK_IN;

  wire D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire \FSM_sequential_rx_state[0]_i_2__2_n_0 ;
  wire \FSM_sequential_rx_state[2]_i_1__2_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_5__2_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_6__2_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_8__2_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_9__2_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire GT3_DATA_VALID_IN;
  wire GT3_RX_FSM_RESET_DONE_OUT;
  wire GT3_RX_MMCM_LOCK_IN;
  wire GT3_RX_MMCM_RESET_OUT;
  wire RXOUTCLK;
  wire RXUSERRDY_i_1__2_n_0;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire check_tlock_max_i_1__2_n_0;
  wire check_tlock_max_reg_n_0;
  wire data_in;
  wire data_valid_sync;
  wire gt3_rx_cdrlocked;
  wire gt3_rx_cdrlocked_reg;
  wire gt3_rx_cdrlocked_reg_0;
  wire gt3_rxresetdone_out;
  wire gt3_rxuserrdy_in;
  wire gt3_rxusrclk_in;
  wire gtrxreset_i_i_1__2_n_0;
  wire gtrxreset_s;
  wire init_wait_count;
  wire \init_wait_count[6]_i_3__6_n_0 ;
  wire \init_wait_count[6]_i_4__6_n_0 ;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire init_wait_done_i_1__6_n_0;
  wire init_wait_done_reg_n_0;
  wire \mmcm_lock_count[7]_i_2__6_n_0 ;
  wire \mmcm_lock_count[7]_i_4__6_n_0 ;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_i_2__6_n_0;
  wire [6:0]p_0_in;
  wire [7:0]p_0_in__0;
  wire [0:0]reset_sync1_rx_0;
  wire reset_time_out_i_4__6_n_0;
  wire reset_time_out_reg_n_0;
  wire run_phase_alignment_int_i_1__6_n_0;
  wire run_phase_alignment_int_reg_n_0;
  wire run_phase_alignment_int_s2;
  wire run_phase_alignment_int_s3_reg_n_0;
  wire rx_fsm_reset_done_int_s2;
  wire rx_fsm_reset_done_int_s3_reg_n_0;
  (* RTL_KEEP = "yes" *) wire [3:0]rx_state;
  wire rx_state16_out;
  wire rxpmaresetdone_i;
  wire rxpmaresetdone_rx_s;
  wire rxresetdone_s2;
  wire rxresetdone_s3;
  wire sync_QPLLLOCK_n_0;
  wire sync_QPLLLOCK_n_1;
  wire sync_data_valid_n_1;
  wire sync_data_valid_n_2;
  wire sync_data_valid_n_3;
  wire sync_data_valid_n_4;
  wire sync_data_valid_n_5;
  wire sync_data_valid_n_6;
  wire sync_mmcm_lock_reclocked_n_0;
  wire sync_mmcm_lock_reclocked_n_1;
  wire sync_rxpmaresetdone_n_0;
  wire sync_rxpmaresetdone_n_1;
  wire time_out_1us_i_1__1_n_0;
  wire time_out_1us_i_2__2_n_0;
  wire time_out_1us_i_3__0_n_0;
  wire time_out_1us_i_4__2_n_0;
  wire time_out_1us_i_5__0_n_0;
  wire time_out_1us_i_6__0_n_0;
  wire time_out_1us_reg_n_0;
  wire time_out_2ms_i_1__2_n_0;
  wire time_out_2ms_i_2__0_n_0;
  wire time_out_2ms_reg_n_0;
  wire time_out_500us_i_1__2_n_0;
  wire time_out_500us_i_2__6_n_0;
  wire time_out_500us_i_3__6_n_0;
  wire time_out_500us_i_4__5_n_0;
  wire time_out_500us_reg_n_0;
  wire time_out_counter;
  wire \time_out_counter[0]_i_10__6_n_0 ;
  wire \time_out_counter[0]_i_3__6_n_0 ;
  wire \time_out_counter[0]_i_4__2_n_0 ;
  wire \time_out_counter[0]_i_8__1_n_0 ;
  wire \time_out_counter[0]_i_9__6_n_0 ;
  wire [18:0]time_out_counter_reg;
  wire \time_out_counter_reg[0]_i_2__6_n_0 ;
  wire \time_out_counter_reg[0]_i_2__6_n_1 ;
  wire \time_out_counter_reg[0]_i_2__6_n_2 ;
  wire \time_out_counter_reg[0]_i_2__6_n_3 ;
  wire \time_out_counter_reg[0]_i_2__6_n_4 ;
  wire \time_out_counter_reg[0]_i_2__6_n_5 ;
  wire \time_out_counter_reg[0]_i_2__6_n_6 ;
  wire \time_out_counter_reg[0]_i_2__6_n_7 ;
  wire \time_out_counter_reg[12]_i_1__6_n_0 ;
  wire \time_out_counter_reg[12]_i_1__6_n_1 ;
  wire \time_out_counter_reg[12]_i_1__6_n_2 ;
  wire \time_out_counter_reg[12]_i_1__6_n_3 ;
  wire \time_out_counter_reg[12]_i_1__6_n_4 ;
  wire \time_out_counter_reg[12]_i_1__6_n_5 ;
  wire \time_out_counter_reg[12]_i_1__6_n_6 ;
  wire \time_out_counter_reg[12]_i_1__6_n_7 ;
  wire \time_out_counter_reg[16]_i_1__6_n_2 ;
  wire \time_out_counter_reg[16]_i_1__6_n_3 ;
  wire \time_out_counter_reg[16]_i_1__6_n_5 ;
  wire \time_out_counter_reg[16]_i_1__6_n_6 ;
  wire \time_out_counter_reg[16]_i_1__6_n_7 ;
  wire \time_out_counter_reg[4]_i_1__6_n_0 ;
  wire \time_out_counter_reg[4]_i_1__6_n_1 ;
  wire \time_out_counter_reg[4]_i_1__6_n_2 ;
  wire \time_out_counter_reg[4]_i_1__6_n_3 ;
  wire \time_out_counter_reg[4]_i_1__6_n_4 ;
  wire \time_out_counter_reg[4]_i_1__6_n_5 ;
  wire \time_out_counter_reg[4]_i_1__6_n_6 ;
  wire \time_out_counter_reg[4]_i_1__6_n_7 ;
  wire \time_out_counter_reg[8]_i_1__6_n_0 ;
  wire \time_out_counter_reg[8]_i_1__6_n_1 ;
  wire \time_out_counter_reg[8]_i_1__6_n_2 ;
  wire \time_out_counter_reg[8]_i_1__6_n_3 ;
  wire \time_out_counter_reg[8]_i_1__6_n_4 ;
  wire \time_out_counter_reg[8]_i_1__6_n_5 ;
  wire \time_out_counter_reg[8]_i_1__6_n_6 ;
  wire \time_out_counter_reg[8]_i_1__6_n_7 ;
  wire time_out_wait_bypass_i_1__6_n_0;
  wire time_out_wait_bypass_reg_n_0;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire time_tlock_max1;
  wire time_tlock_max1_carry__0_i_1__2_n_0;
  wire time_tlock_max1_carry__0_i_2__2_n_0;
  wire time_tlock_max1_carry__0_i_3__2_n_0;
  wire time_tlock_max1_carry__0_i_4__2_n_0;
  wire time_tlock_max1_carry__0_i_5__2_n_0;
  wire time_tlock_max1_carry__0_i_6__0_n_0;
  wire time_tlock_max1_carry__0_n_0;
  wire time_tlock_max1_carry__0_n_1;
  wire time_tlock_max1_carry__0_n_2;
  wire time_tlock_max1_carry__0_n_3;
  wire time_tlock_max1_carry__1_i_1__2_n_0;
  wire time_tlock_max1_carry__1_i_2__2_n_0;
  wire time_tlock_max1_carry__1_i_3__2_n_0;
  wire time_tlock_max1_carry__1_n_3;
  wire time_tlock_max1_carry_i_1__2_n_0;
  wire time_tlock_max1_carry_i_2__2_n_0;
  wire time_tlock_max1_carry_i_3__2_n_0;
  wire time_tlock_max1_carry_i_4__2_n_0;
  wire time_tlock_max1_carry_i_5__2_n_0;
  wire time_tlock_max1_carry_i_6__2_n_0;
  wire time_tlock_max1_carry_i_7__2_n_0;
  wire time_tlock_max1_carry_n_0;
  wire time_tlock_max1_carry_n_1;
  wire time_tlock_max1_carry_n_2;
  wire time_tlock_max1_carry_n_3;
  wire time_tlock_max_i_1__2_n_0;
  wire \wait_bypass_count[0]_i_10__6_n_0 ;
  wire \wait_bypass_count[0]_i_1__6_n_0 ;
  wire \wait_bypass_count[0]_i_2__6_n_0 ;
  wire \wait_bypass_count[0]_i_4__6_n_0 ;
  wire \wait_bypass_count[0]_i_8__6_n_0 ;
  wire \wait_bypass_count[0]_i_9__6_n_0 ;
  wire [12:0]wait_bypass_count_reg;
  wire \wait_bypass_count_reg[0]_i_3__6_n_0 ;
  wire \wait_bypass_count_reg[0]_i_3__6_n_1 ;
  wire \wait_bypass_count_reg[0]_i_3__6_n_2 ;
  wire \wait_bypass_count_reg[0]_i_3__6_n_3 ;
  wire \wait_bypass_count_reg[0]_i_3__6_n_4 ;
  wire \wait_bypass_count_reg[0]_i_3__6_n_5 ;
  wire \wait_bypass_count_reg[0]_i_3__6_n_6 ;
  wire \wait_bypass_count_reg[0]_i_3__6_n_7 ;
  wire \wait_bypass_count_reg[12]_i_1__6_n_7 ;
  wire \wait_bypass_count_reg[4]_i_1__6_n_0 ;
  wire \wait_bypass_count_reg[4]_i_1__6_n_1 ;
  wire \wait_bypass_count_reg[4]_i_1__6_n_2 ;
  wire \wait_bypass_count_reg[4]_i_1__6_n_3 ;
  wire \wait_bypass_count_reg[4]_i_1__6_n_4 ;
  wire \wait_bypass_count_reg[4]_i_1__6_n_5 ;
  wire \wait_bypass_count_reg[4]_i_1__6_n_6 ;
  wire \wait_bypass_count_reg[4]_i_1__6_n_7 ;
  wire \wait_bypass_count_reg[8]_i_1__6_n_0 ;
  wire \wait_bypass_count_reg[8]_i_1__6_n_1 ;
  wire \wait_bypass_count_reg[8]_i_1__6_n_2 ;
  wire \wait_bypass_count_reg[8]_i_1__6_n_3 ;
  wire \wait_bypass_count_reg[8]_i_1__6_n_4 ;
  wire \wait_bypass_count_reg[8]_i_1__6_n_5 ;
  wire \wait_bypass_count_reg[8]_i_1__6_n_6 ;
  wire \wait_bypass_count_reg[8]_i_1__6_n_7 ;
  wire [6:0]wait_time_cnt0;
  wire \wait_time_cnt[1]_i_1__6_n_0 ;
  wire \wait_time_cnt[4]_i_1__6_n_0 ;
  wire \wait_time_cnt[6]_i_1__6_n_0 ;
  wire \wait_time_cnt[6]_i_2__6_n_0 ;
  wire \wait_time_cnt[6]_i_4__6_n_0 ;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__6_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__6_O_UNCONNECTED ;
  wire [3:0]NLW_time_tlock_max1_carry_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max1_carry__0_O_UNCONNECTED;
  wire [3:2]NLW_time_tlock_max1_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max1_carry__1_O_UNCONNECTED;
  wire [3:0]\NLW_wait_bypass_count_reg[12]_i_1__6_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[12]_i_1__6_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h08B80888FFFFFFFF)) 
    \FSM_sequential_rx_state[0]_i_2__2 
       (.I0(time_out_2ms_reg_n_0),
        .I1(rx_state[1]),
        .I2(rx_state[2]),
        .I3(reset_time_out_reg_n_0),
        .I4(time_tlock_max),
        .I5(rx_state[0]),
        .O(\FSM_sequential_rx_state[0]_i_2__2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000262226AA)) 
    \FSM_sequential_rx_state[2]_i_1__2 
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(time_out_2ms_reg_n_0),
        .I3(rx_state[1]),
        .I4(rx_state16_out),
        .I5(rx_state[3]),
        .O(\FSM_sequential_rx_state[2]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_rx_state[2]_i_2__2 
       (.I0(time_tlock_max),
        .I1(reset_time_out_reg_n_0),
        .O(rx_state16_out));
  LUT6 #(
    .INIT(64'h00F0BBBB00F08888)) 
    \FSM_sequential_rx_state[3]_i_5__2 
       (.I0(gt3_rx_cdrlocked_reg_0),
        .I1(rx_state[2]),
        .I2(\FSM_sequential_rx_state[3]_i_9__2_n_0 ),
        .I3(wait_time_cnt_reg__0[6]),
        .I4(rx_state[1]),
        .I5(init_wait_done_reg_n_0),
        .O(\FSM_sequential_rx_state[3]_i_5__2_n_0 ));
  LUT5 #(
    .INIT(32'h80880000)) 
    \FSM_sequential_rx_state[3]_i_6__2 
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(reset_time_out_reg_n_0),
        .I3(time_out_2ms_reg_n_0),
        .I4(rx_state[0]),
        .O(\FSM_sequential_rx_state[3]_i_6__2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0EFEFAFA0EFE0)) 
    \FSM_sequential_rx_state[3]_i_8__2 
       (.I0(rxresetdone_s3),
        .I1(time_out_2ms_reg_n_0),
        .I2(rx_state[1]),
        .I3(mmcm_lock_reclocked),
        .I4(reset_time_out_reg_n_0),
        .I5(time_tlock_max),
        .O(\FSM_sequential_rx_state[3]_i_8__2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_sequential_rx_state[3]_i_9__2 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .I4(wait_time_cnt_reg__0[4]),
        .I5(wait_time_cnt_reg__0[5]),
        .O(\FSM_sequential_rx_state[3]_i_9__2_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_5),
        .Q(rx_state[0]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_4),
        .Q(rx_state[1]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(\FSM_sequential_rx_state[2]_i_1__2_n_0 ),
        .Q(rx_state[2]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_rx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(sync_data_valid_n_6),
        .D(sync_data_valid_n_3),
        .Q(rx_state[3]),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFD0080)) 
    RXUSERRDY_i_1__2
       (.I0(rx_state[0]),
        .I1(rx_state[2]),
        .I2(rx_state[1]),
        .I3(rx_state[3]),
        .I4(gt3_rxuserrdy_in),
        .O(RXUSERRDY_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    RXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(RXUSERRDY_i_1__2_n_0),
        .Q(gt3_rxuserrdy_in),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    check_tlock_max_i_1__2
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .I3(rx_state[3]),
        .I4(check_tlock_max_reg_n_0),
        .O(check_tlock_max_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    check_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(check_tlock_max_i_1__2_n_0),
        .Q(check_tlock_max_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT3 #(
    .INIT(8'h0E)) 
    gt3_rx_cdrlocked_i_1
       (.I0(gt3_rx_cdrlocked_reg_0),
        .I1(gt3_rx_cdrlocked),
        .I2(reset_sync1_rx_0),
        .O(gt3_rx_cdrlocked_reg));
  LUT5 #(
    .INIT(32'hFFFB0010)) 
    gtrxreset_i_i_1__2
       (.I0(rx_state[1]),
        .I1(rx_state[2]),
        .I2(rx_state[0]),
        .I3(rx_state[3]),
        .I4(reset_sync1_rx_0),
        .O(gtrxreset_i_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    gtrxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gtrxreset_i_i_1__2_n_0),
        .Q(reset_sync1_rx_0),
        .R(SOFT_RESET_IN));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \init_wait_count[0]_i_1__6 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \init_wait_count[1]_i_1__6 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \init_wait_count[2]_i_1__6 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \init_wait_count[3]_i_1__6 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \init_wait_count[4]_i_1__6 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \init_wait_count[5]_i_1__6 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
    \init_wait_count[6]_i_1__6 
       (.I0(\init_wait_count[6]_i_3__6_n_0 ),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_count));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT5 #(
    .INIT(32'h9AAAAAAA)) 
    \init_wait_count[6]_i_2__6 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\init_wait_count[6]_i_4__6_n_0 ),
        .I2(init_wait_count_reg__0[4]),
        .I3(init_wait_count_reg__0[3]),
        .I4(init_wait_count_reg__0[5]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \init_wait_count[6]_i_3__6 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(\init_wait_count[6]_i_3__6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \init_wait_count[6]_i_4__6 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(\init_wait_count[6]_i_4__6_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[0]),
        .Q(init_wait_count_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
  LUT2 #(
    .INIT(4'hE)) 
    init_wait_done_i_1__6
       (.I0(init_wait_done),
        .I1(init_wait_done_reg_n_0),
        .O(init_wait_done_i_1__6_n_0));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    init_wait_done_i_2__6
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\init_wait_count[6]_i_3__6_n_0 ),
        .O(init_wait_done));
  FDCE #(
    .INIT(1'b0)) 
    init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(init_wait_done_i_1__6_n_0),
        .Q(init_wait_done_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[0]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \mmcm_lock_count[1]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \mmcm_lock_count[2]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \mmcm_lock_count[3]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[4]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[2]),
        .I4(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \mmcm_lock_count[5]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \mmcm_lock_count[6]_i_1__6 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__6_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__0[6]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \mmcm_lock_count[7]_i_2__6 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__6_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(\mmcm_lock_count[7]_i_2__6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[7]_i_3__6 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(mmcm_lock_count_reg__0[5]),
        .I2(\mmcm_lock_count[7]_i_4__6_n_0 ),
        .I3(mmcm_lock_count_reg__0[4]),
        .I4(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \mmcm_lock_count[7]_i_4__6 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .O(\mmcm_lock_count[7]_i_4__6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__6_n_0 ),
        .D(p_0_in__0[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__6_n_0 ),
        .D(p_0_in__0[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__6_n_0 ),
        .D(p_0_in__0[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__6_n_0 ),
        .D(p_0_in__0[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__6_n_0 ),
        .D(p_0_in__0[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__6_n_0 ),
        .D(p_0_in__0[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__6_n_0 ),
        .D(p_0_in__0[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__6_n_0 ),
        .D(p_0_in__0[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(sync_mmcm_lock_reclocked_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    mmcm_lock_reclocked_i_2__6
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(mmcm_lock_reclocked_i_2__6_n_0));
  FDRE #(
    .INIT(1'b0)) 
    mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_mmcm_lock_reclocked_n_1),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    mmcm_reset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_rxpmaresetdone_n_0),
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
        .PRE(reset_sync1_rx_0),
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
        .PRE(reset_sync1_rx_0),
        .Q(gtrxreset_s));
  LUT3 #(
    .INIT(8'h07)) 
    reset_time_out_i_4__6
       (.I0(rx_state[1]),
        .I1(rx_state[0]),
        .I2(rx_state[2]),
        .O(reset_time_out_i_4__6_n_0));
  FDSE #(
    .INIT(1'b0)) 
    reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_data_valid_n_1),
        .Q(reset_time_out_reg_n_0),
        .S(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFEFF0002)) 
    run_phase_alignment_int_i_1__6
       (.I0(rx_state[3]),
        .I1(rx_state[2]),
        .I2(rx_state[1]),
        .I3(rx_state[0]),
        .I4(run_phase_alignment_int_reg_n_0),
        .O(run_phase_alignment_int_i_1__6_n_0));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(run_phase_alignment_int_i_1__6_n_0),
        .Q(run_phase_alignment_int_reg_n_0),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_s3_reg
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(run_phase_alignment_int_s2),
        .Q(run_phase_alignment_int_s3_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    rx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_data_valid_n_2),
        .Q(GT3_RX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    rx_fsm_reset_done_int_s3_reg
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(rx_fsm_reset_done_int_s2),
        .Q(rx_fsm_reset_done_int_s3_reg_n_0),
        .R(1'b0));
  FDCE #(
    .INIT(1'b0)) 
    rxpmaresetdone_i_reg
       (.C(RXOUTCLK),
        .CE(1'b1),
        .CLR(gtrxreset_s),
        .D(rxpmaresetdone_rx_s),
        .Q(rxpmaresetdone_i));
  FDRE #(
    .INIT(1'b0)) 
    rxresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(rxresetdone_s2),
        .Q(rxresetdone_s3),
        .R(1'b0));
  XLAUI_XLAUI_sync_block_11 sync_QPLLLOCK
       (.\FSM_sequential_rx_state_reg[0] (sync_QPLLLOCK_n_0),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .data_out(data_valid_sync),
        .gt3_rx_cdrlocked_reg(gt3_rx_cdrlocked_reg_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(rx_state[2:0]),
        .reset_time_out_reg(sync_QPLLLOCK_n_1),
        .rxresetdone_s3(rxresetdone_s3),
        .rxresetdone_s3_reg(\FSM_sequential_rx_state[3]_i_8__2_n_0 ),
        .time_out_2ms_reg(time_out_2ms_reg_n_0));
  XLAUI_XLAUI_sync_block_12 sync_RXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(rxresetdone_s2),
        .gt3_rxresetdone_out(gt3_rxresetdone_out));
  XLAUI_XLAUI_sync_block_13 sync_data_valid
       (.D({sync_data_valid_n_3,sync_data_valid_n_4,sync_data_valid_n_5}),
        .DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .E(sync_data_valid_n_6),
        .\FSM_sequential_rx_state_reg[0] (sync_QPLLLOCK_n_1),
        .\FSM_sequential_rx_state_reg[1] (reset_time_out_i_4__6_n_0),
        .\FSM_sequential_rx_state_reg[2] (sync_QPLLLOCK_n_0),
        .\FSM_sequential_rx_state_reg[2]_0 (\FSM_sequential_rx_state[3]_i_6__2_n_0 ),
        .GT3_DATA_VALID_IN(GT3_DATA_VALID_IN),
        .GT3_RX_FSM_RESET_DONE_OUT(GT3_RX_FSM_RESET_DONE_OUT),
        .SYSCLK_IN(SYSCLK_IN),
        .data_out(data_valid_sync),
        .gt3_rx_cdrlocked_reg(\FSM_sequential_rx_state[3]_i_5__2_n_0 ),
        .mmcm_lock_reclocked_reg(sync_rxpmaresetdone_n_1),
        .out(rx_state),
        .reset_time_out_reg(sync_data_valid_n_1),
        .reset_time_out_reg_0(reset_time_out_reg_n_0),
        .rx_fsm_reset_done_int_reg(sync_data_valid_n_2),
        .rx_state16_out(rx_state16_out),
        .time_out_1us_reg(time_out_1us_reg_n_0),
        .time_out_2ms_reg(\FSM_sequential_rx_state[0]_i_2__2_n_0 ),
        .time_out_500us_reg(time_out_500us_reg_n_0),
        .time_out_wait_bypass_s3(time_out_wait_bypass_s3));
  XLAUI_XLAUI_sync_block_14 sync_mmcm_lock_reclocked
       (.GT3_RX_MMCM_LOCK_IN(GT3_RX_MMCM_LOCK_IN),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(sync_mmcm_lock_reclocked_n_0),
        .SYSCLK_IN(SYSCLK_IN),
        .\mmcm_lock_count_reg[5] (mmcm_lock_reclocked_i_2__6_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_lock_reclocked_reg(sync_mmcm_lock_reclocked_n_1));
  XLAUI_XLAUI_sync_block_15 sync_run_phase_alignment_int
       (.data_in(run_phase_alignment_int_reg_n_0),
        .data_out(run_phase_alignment_int_s2),
        .gt3_rxusrclk_in(gt3_rxusrclk_in));
  XLAUI_XLAUI_sync_block_16 sync_rx_fsm_reset_done_int
       (.GT3_RX_FSM_RESET_DONE_OUT(GT3_RX_FSM_RESET_DONE_OUT),
        .data_out(rx_fsm_reset_done_int_s2),
        .gt3_rxusrclk_in(gt3_rxusrclk_in));
  XLAUI_XLAUI_sync_block_17 sync_rxpmaresetdone
       (.GT3_RX_MMCM_RESET_OUT(GT3_RX_MMCM_RESET_OUT),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(rxpmaresetdone_i),
        .gt3_rx_cdrlocked_reg(gt3_rx_cdrlocked_reg_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_reset_i_reg(sync_rxpmaresetdone_n_0),
        .out(rx_state),
        .reset_time_out_reg(sync_rxpmaresetdone_n_1));
  XLAUI_XLAUI_sync_block_18 sync_rxpmaresetdone_rx_s
       (.RXOUTCLK(RXOUTCLK),
        .data_in(data_in),
        .data_out(rxpmaresetdone_rx_s));
  XLAUI_XLAUI_sync_block_19 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(time_out_wait_bypass_reg_n_0),
        .data_out(time_out_wait_bypass_s2));
  LUT4 #(
    .INIT(16'hFF10)) 
    time_out_1us_i_1__1
       (.I0(time_out_1us_i_2__2_n_0),
        .I1(time_out_1us_i_3__0_n_0),
        .I2(time_out_1us_i_4__2_n_0),
        .I3(time_out_1us_reg_n_0),
        .O(time_out_1us_i_1__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT4 #(
    .INIT(16'hFFFD)) 
    time_out_1us_i_2__2
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[11]),
        .I3(time_out_counter_reg[4]),
        .O(time_out_1us_i_2__2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFB)) 
    time_out_1us_i_3__0
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[5]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[6]),
        .I4(time_out_counter_reg[13]),
        .I5(time_out_1us_i_5__0_n_0),
        .O(time_out_1us_i_3__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    time_out_1us_i_4__2
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[16]),
        .I4(time_out_1us_i_6__0_n_0),
        .O(time_out_1us_i_4__2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT2 #(
    .INIT(4'hB)) 
    time_out_1us_i_5__0
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[1]),
        .O(time_out_1us_i_5__0_n_0));
  LUT4 #(
    .INIT(16'hFFFD)) 
    time_out_1us_i_6__0
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[17]),
        .O(time_out_1us_i_6__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_1us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_1us_i_1__1_n_0),
        .Q(time_out_1us_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000100)) 
    time_out_2ms_i_1__2
       (.I0(\time_out_counter[0]_i_3__6_n_0 ),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_2ms_i_2__0_n_0),
        .I4(\time_out_counter[0]_i_4__2_n_0 ),
        .I5(time_out_2ms_reg_n_0),
        .O(time_out_2ms_i_1__2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT2 #(
    .INIT(4'h1)) 
    time_out_2ms_i_2__0
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(time_out_2ms_i_2__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_2ms_i_1__2_n_0),
        .Q(time_out_2ms_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000010)) 
    time_out_500us_i_1__2
       (.I0(time_out_500us_i_2__6_n_0),
        .I1(time_out_500us_i_3__6_n_0),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[9]),
        .I4(time_out_500us_i_4__5_n_0),
        .I5(time_out_500us_reg_n_0),
        .O(time_out_500us_i_1__2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFBFFF)) 
    time_out_500us_i_2__6
       (.I0(\time_out_counter[0]_i_9__6_n_0 ),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[6]),
        .I5(time_out_1us_i_2__2_n_0),
        .O(time_out_500us_i_2__6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT2 #(
    .INIT(4'hB)) 
    time_out_500us_i_3__6
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[16]),
        .O(time_out_500us_i_3__6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    time_out_500us_i_4__5
       (.I0(time_out_counter_reg[15]),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[17]),
        .O(time_out_500us_i_4__5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_500us_i_1__2_n_0),
        .Q(time_out_500us_reg_n_0),
        .R(reset_time_out_reg_n_0));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \time_out_counter[0]_i_10__6 
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[12]),
        .I3(time_out_counter_reg[10]),
        .O(\time_out_counter[0]_i_10__6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \time_out_counter[0]_i_1__2 
       (.I0(\time_out_counter[0]_i_3__6_n_0 ),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_counter_reg[6]),
        .I4(time_out_counter_reg[7]),
        .I5(\time_out_counter[0]_i_4__2_n_0 ),
        .O(time_out_counter));
  LUT6 #(
    .INIT(64'hFFFFFFFFEFFFFFFF)) 
    \time_out_counter[0]_i_3__6 
       (.I0(\time_out_counter[0]_i_9__6_n_0 ),
        .I1(\time_out_counter[0]_i_10__6_n_0 ),
        .I2(time_out_counter_reg[9]),
        .I3(time_out_counter_reg[4]),
        .I4(time_out_counter_reg[18]),
        .I5(time_out_counter_reg[17]),
        .O(\time_out_counter[0]_i_3__6_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \time_out_counter[0]_i_4__2 
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[8]),
        .O(\time_out_counter[0]_i_4__2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_8__1 
       (.I0(time_out_counter_reg[0]),
        .O(\time_out_counter[0]_i_8__1_n_0 ));
  LUT3 #(
    .INIT(8'hEF)) 
    \time_out_counter[0]_i_9__6 
       (.I0(time_out_counter_reg[5]),
        .I1(time_out_counter_reg[13]),
        .I2(time_out_counter_reg[0]),
        .O(\time_out_counter[0]_i_9__6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__6_n_7 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[0]_i_2__6 
       (.CI(1'b0),
        .CO({\time_out_counter_reg[0]_i_2__6_n_0 ,\time_out_counter_reg[0]_i_2__6_n_1 ,\time_out_counter_reg[0]_i_2__6_n_2 ,\time_out_counter_reg[0]_i_2__6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\time_out_counter_reg[0]_i_2__6_n_4 ,\time_out_counter_reg[0]_i_2__6_n_5 ,\time_out_counter_reg[0]_i_2__6_n_6 ,\time_out_counter_reg[0]_i_2__6_n_7 }),
        .S({time_out_counter_reg[3:1],\time_out_counter[0]_i_8__1_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__6_n_5 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__6_n_4 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__6_n_7 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[12]_i_1__6 
       (.CI(\time_out_counter_reg[8]_i_1__6_n_0 ),
        .CO({\time_out_counter_reg[12]_i_1__6_n_0 ,\time_out_counter_reg[12]_i_1__6_n_1 ,\time_out_counter_reg[12]_i_1__6_n_2 ,\time_out_counter_reg[12]_i_1__6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[12]_i_1__6_n_4 ,\time_out_counter_reg[12]_i_1__6_n_5 ,\time_out_counter_reg[12]_i_1__6_n_6 ,\time_out_counter_reg[12]_i_1__6_n_7 }),
        .S(time_out_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__6_n_6 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__6_n_5 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__6_n_4 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__6_n_7 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[16]_i_1__6 
       (.CI(\time_out_counter_reg[12]_i_1__6_n_0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__6_CO_UNCONNECTED [3:2],\time_out_counter_reg[16]_i_1__6_n_2 ,\time_out_counter_reg[16]_i_1__6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__6_O_UNCONNECTED [3],\time_out_counter_reg[16]_i_1__6_n_5 ,\time_out_counter_reg[16]_i_1__6_n_6 ,\time_out_counter_reg[16]_i_1__6_n_7 }),
        .S({1'b0,time_out_counter_reg[18:16]}));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__6_n_6 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__6_n_5 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__6_n_6 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__6_n_5 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__6_n_4 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__6_n_7 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[4]_i_1__6 
       (.CI(\time_out_counter_reg[0]_i_2__6_n_0 ),
        .CO({\time_out_counter_reg[4]_i_1__6_n_0 ,\time_out_counter_reg[4]_i_1__6_n_1 ,\time_out_counter_reg[4]_i_1__6_n_2 ,\time_out_counter_reg[4]_i_1__6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[4]_i_1__6_n_4 ,\time_out_counter_reg[4]_i_1__6_n_5 ,\time_out_counter_reg[4]_i_1__6_n_6 ,\time_out_counter_reg[4]_i_1__6_n_7 }),
        .S(time_out_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__6_n_6 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__6_n_5 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__6_n_4 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__6_n_7 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[8]_i_1__6 
       (.CI(\time_out_counter_reg[4]_i_1__6_n_0 ),
        .CO({\time_out_counter_reg[8]_i_1__6_n_0 ,\time_out_counter_reg[8]_i_1__6_n_1 ,\time_out_counter_reg[8]_i_1__6_n_2 ,\time_out_counter_reg[8]_i_1__6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[8]_i_1__6_n_4 ,\time_out_counter_reg[8]_i_1__6_n_5 ,\time_out_counter_reg[8]_i_1__6_n_6 ,\time_out_counter_reg[8]_i_1__6_n_7 }),
        .S(time_out_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__6_n_6 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out_reg_n_0));
  LUT4 #(
    .INIT(16'hAB00)) 
    time_out_wait_bypass_i_1__6
       (.I0(time_out_wait_bypass_reg_n_0),
        .I1(rx_fsm_reset_done_int_s3_reg_n_0),
        .I2(\wait_bypass_count[0]_i_4__6_n_0 ),
        .I3(run_phase_alignment_int_s3_reg_n_0),
        .O(time_out_wait_bypass_i_1__6_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_reg
       (.C(gt3_rxusrclk_in),
        .CE(1'b1),
        .D(time_out_wait_bypass_i_1__6_n_0),
        .Q(time_out_wait_bypass_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
  CARRY4 time_tlock_max1_carry
       (.CI(1'b0),
        .CO({time_tlock_max1_carry_n_0,time_tlock_max1_carry_n_1,time_tlock_max1_carry_n_2,time_tlock_max1_carry_n_3}),
        .CYINIT(1'b0),
        .DI({time_tlock_max1_carry_i_1__2_n_0,time_out_counter_reg[5],time_tlock_max1_carry_i_2__2_n_0,time_tlock_max1_carry_i_3__2_n_0}),
        .O(NLW_time_tlock_max1_carry_O_UNCONNECTED[3:0]),
        .S({time_tlock_max1_carry_i_4__2_n_0,time_tlock_max1_carry_i_5__2_n_0,time_tlock_max1_carry_i_6__2_n_0,time_tlock_max1_carry_i_7__2_n_0}));
  CARRY4 time_tlock_max1_carry__0
       (.CI(time_tlock_max1_carry_n_0),
        .CO({time_tlock_max1_carry__0_n_0,time_tlock_max1_carry__0_n_1,time_tlock_max1_carry__0_n_2,time_tlock_max1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({time_out_counter_reg[15],time_tlock_max1_carry__0_i_1__2_n_0,time_tlock_max1_carry__0_i_2__2_n_0,time_out_counter_reg[9]}),
        .O(NLW_time_tlock_max1_carry__0_O_UNCONNECTED[3:0]),
        .S({time_tlock_max1_carry__0_i_3__2_n_0,time_tlock_max1_carry__0_i_4__2_n_0,time_tlock_max1_carry__0_i_5__2_n_0,time_tlock_max1_carry__0_i_6__0_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__0_i_1__2
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .O(time_tlock_max1_carry__0_i_1__2_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__0_i_2__2
       (.I0(time_out_counter_reg[11]),
        .I1(time_out_counter_reg[10]),
        .O(time_tlock_max1_carry__0_i_2__2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry__0_i_3__2
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[15]),
        .O(time_tlock_max1_carry__0_i_3__2_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__0_i_4__2
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(time_tlock_max1_carry__0_i_4__2_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__0_i_5__2
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(time_tlock_max1_carry__0_i_5__2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry__0_i_6__0
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[9]),
        .O(time_tlock_max1_carry__0_i_6__0_n_0));
  CARRY4 time_tlock_max1_carry__1
       (.CI(time_tlock_max1_carry__0_n_0),
        .CO({NLW_time_tlock_max1_carry__1_CO_UNCONNECTED[3:2],time_tlock_max1,time_tlock_max1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,time_out_counter_reg[18],time_tlock_max1_carry__1_i_1__2_n_0}),
        .O(NLW_time_tlock_max1_carry__1_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,time_tlock_max1_carry__1_i_2__2_n_0,time_tlock_max1_carry__1_i_3__2_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry__1_i_1__2
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[16]),
        .O(time_tlock_max1_carry__1_i_1__2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    time_tlock_max1_carry__1_i_2__2
       (.I0(time_out_counter_reg[18]),
        .O(time_tlock_max1_carry__1_i_2__2_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry__1_i_3__2
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(time_tlock_max1_carry__1_i_3__2_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    time_tlock_max1_carry_i_1__2
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[6]),
        .O(time_tlock_max1_carry_i_1__2_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    time_tlock_max1_carry_i_2__2
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(time_tlock_max1_carry_i_2__2_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    time_tlock_max1_carry_i_3__2
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(time_tlock_max1_carry_i_3__2_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    time_tlock_max1_carry_i_4__2
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(time_tlock_max1_carry_i_4__2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_5__2
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[5]),
        .O(time_tlock_max1_carry_i_5__2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_6__2
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(time_tlock_max1_carry_i_6__2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    time_tlock_max1_carry_i_7__2
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(time_tlock_max1_carry_i_7__2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    time_tlock_max_i_1__2
       (.I0(time_tlock_max1),
        .I1(check_tlock_max_reg_n_0),
        .I2(time_tlock_max),
        .O(time_tlock_max_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_tlock_max_i_1__2_n_0),
        .Q(time_tlock_max),
        .R(reset_time_out_reg_n_0));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \wait_bypass_count[0]_i_10__6 
       (.I0(wait_bypass_count_reg[2]),
        .I1(wait_bypass_count_reg[12]),
        .I2(wait_bypass_count_reg[4]),
        .I3(wait_bypass_count_reg[10]),
        .I4(wait_bypass_count_reg[6]),
        .I5(wait_bypass_count_reg[11]),
        .O(\wait_bypass_count[0]_i_10__6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_1__6 
       (.I0(run_phase_alignment_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_1__6_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \wait_bypass_count[0]_i_2__6 
       (.I0(\wait_bypass_count[0]_i_4__6_n_0 ),
        .I1(rx_fsm_reset_done_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_2__6_n_0 ));
  LUT5 #(
    .INIT(32'hBFFFFFFF)) 
    \wait_bypass_count[0]_i_4__6 
       (.I0(\wait_bypass_count[0]_i_9__6_n_0 ),
        .I1(wait_bypass_count_reg[1]),
        .I2(wait_bypass_count_reg[8]),
        .I3(wait_bypass_count_reg[0]),
        .I4(\wait_bypass_count[0]_i_10__6_n_0 ),
        .O(\wait_bypass_count[0]_i_4__6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_8__6 
       (.I0(wait_bypass_count_reg[0]),
        .O(\wait_bypass_count[0]_i_8__6_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \wait_bypass_count[0]_i_9__6 
       (.I0(wait_bypass_count_reg[3]),
        .I1(wait_bypass_count_reg[5]),
        .I2(wait_bypass_count_reg[9]),
        .I3(wait_bypass_count_reg[7]),
        .O(\wait_bypass_count[0]_i_9__6_n_0 ));
  FDRE \wait_bypass_count_reg[0] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__6_n_7 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  CARRY4 \wait_bypass_count_reg[0]_i_3__6 
       (.CI(1'b0),
        .CO({\wait_bypass_count_reg[0]_i_3__6_n_0 ,\wait_bypass_count_reg[0]_i_3__6_n_1 ,\wait_bypass_count_reg[0]_i_3__6_n_2 ,\wait_bypass_count_reg[0]_i_3__6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\wait_bypass_count_reg[0]_i_3__6_n_4 ,\wait_bypass_count_reg[0]_i_3__6_n_5 ,\wait_bypass_count_reg[0]_i_3__6_n_6 ,\wait_bypass_count_reg[0]_i_3__6_n_7 }),
        .S({wait_bypass_count_reg[3:1],\wait_bypass_count[0]_i_8__6_n_0 }));
  FDRE \wait_bypass_count_reg[10] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__6_n_5 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  FDRE \wait_bypass_count_reg[11] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__6_n_4 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  FDRE \wait_bypass_count_reg[12] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__6_n_7 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  CARRY4 \wait_bypass_count_reg[12]_i_1__6 
       (.CI(\wait_bypass_count_reg[8]_i_1__6_n_0 ),
        .CO(\NLW_wait_bypass_count_reg[12]_i_1__6_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[12]_i_1__6_O_UNCONNECTED [3:1],\wait_bypass_count_reg[12]_i_1__6_n_7 }),
        .S({1'b0,1'b0,1'b0,wait_bypass_count_reg[12]}));
  FDRE \wait_bypass_count_reg[1] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__6_n_6 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  FDRE \wait_bypass_count_reg[2] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__6_n_5 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  FDRE \wait_bypass_count_reg[3] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__6_n_4 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  FDRE \wait_bypass_count_reg[4] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__6_n_7 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  CARRY4 \wait_bypass_count_reg[4]_i_1__6 
       (.CI(\wait_bypass_count_reg[0]_i_3__6_n_0 ),
        .CO({\wait_bypass_count_reg[4]_i_1__6_n_0 ,\wait_bypass_count_reg[4]_i_1__6_n_1 ,\wait_bypass_count_reg[4]_i_1__6_n_2 ,\wait_bypass_count_reg[4]_i_1__6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[4]_i_1__6_n_4 ,\wait_bypass_count_reg[4]_i_1__6_n_5 ,\wait_bypass_count_reg[4]_i_1__6_n_6 ,\wait_bypass_count_reg[4]_i_1__6_n_7 }),
        .S(wait_bypass_count_reg[7:4]));
  FDRE \wait_bypass_count_reg[5] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__6_n_6 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  FDRE \wait_bypass_count_reg[6] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__6_n_5 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  FDRE \wait_bypass_count_reg[7] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__6_n_4 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  FDRE \wait_bypass_count_reg[8] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__6_n_7 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  CARRY4 \wait_bypass_count_reg[8]_i_1__6 
       (.CI(\wait_bypass_count_reg[4]_i_1__6_n_0 ),
        .CO({\wait_bypass_count_reg[8]_i_1__6_n_0 ,\wait_bypass_count_reg[8]_i_1__6_n_1 ,\wait_bypass_count_reg[8]_i_1__6_n_2 ,\wait_bypass_count_reg[8]_i_1__6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[8]_i_1__6_n_4 ,\wait_bypass_count_reg[8]_i_1__6_n_5 ,\wait_bypass_count_reg[8]_i_1__6_n_6 ,\wait_bypass_count_reg[8]_i_1__6_n_7 }),
        .S(wait_bypass_count_reg[11:8]));
  FDRE \wait_bypass_count_reg[9] 
       (.C(gt3_rxusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__6_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__6_n_6 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\wait_bypass_count[0]_i_1__6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_time_cnt[0]_i_1__6 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \wait_time_cnt[1]_i_1__6 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\wait_time_cnt[1]_i_1__6_n_0 ));
  LUT3 #(
    .INIT(8'hE1)) 
    \wait_time_cnt[2]_i_1__6 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[2]),
        .O(wait_time_cnt0[2]));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \wait_time_cnt[3]_i_1__6 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0[3]));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \wait_time_cnt[4]_i_1__6 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\wait_time_cnt[4]_i_1__6_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
    \wait_time_cnt[5]_i_1__6 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[5]));
  LUT3 #(
    .INIT(8'h10)) 
    \wait_time_cnt[6]_i_1__6 
       (.I0(rx_state[3]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .O(\wait_time_cnt[6]_i_1__6_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_2__6 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\wait_time_cnt[6]_i_4__6_n_0 ),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(wait_time_cnt_reg__0[5]),
        .O(\wait_time_cnt[6]_i_2__6_n_0 ));
  LUT4 #(
    .INIT(16'hAAA9)) 
    \wait_time_cnt[6]_i_3__6 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(\wait_time_cnt[6]_i_4__6_n_0 ),
        .O(wait_time_cnt0[6]));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_4__6 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .O(\wait_time_cnt[6]_i_4__6_n_0 ));
  FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__6_n_0 ),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\wait_time_cnt[6]_i_1__6_n_0 ));
  FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__6_n_0 ),
        .D(\wait_time_cnt[1]_i_1__6_n_0 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\wait_time_cnt[6]_i_1__6_n_0 ));
  FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__6_n_0 ),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\wait_time_cnt[6]_i_1__6_n_0 ));
  FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__6_n_0 ),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\wait_time_cnt[6]_i_1__6_n_0 ));
  FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__6_n_0 ),
        .D(\wait_time_cnt[4]_i_1__6_n_0 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\wait_time_cnt[6]_i_1__6_n_0 ));
  FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__6_n_0 ),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\wait_time_cnt[6]_i_1__6_n_0 ));
  FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__6_n_0 ),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\wait_time_cnt[6]_i_1__6_n_0 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_TX_STARTUP_FSM" *) 
module XLAUI_XLAUI_TX_STARTUP_FSM
   (gt0_gttxreset_in,
    GT0_TX_MMCM_RESET_OUT,
    GT0_QPLLRESET_OUT,
    GT0_TX_FSM_RESET_DONE_OUT,
    gt0_txuserrdy_in,
    SYSCLK_IN,
    gt0_txusrclk_in,
    SOFT_RESET_IN,
    gt0_txresetdone_out,
    GT0_TX_MMCM_LOCK_IN,
    GT0_QPLLLOCK_IN);
  output gt0_gttxreset_in;
  output GT0_TX_MMCM_RESET_OUT;
  output GT0_QPLLRESET_OUT;
  output GT0_TX_FSM_RESET_DONE_OUT;
  output gt0_txuserrdy_in;
  input SYSCLK_IN;
  input gt0_txusrclk_in;
  input SOFT_RESET_IN;
  input gt0_txresetdone_out;
  input GT0_TX_MMCM_LOCK_IN;
  input GT0_QPLLLOCK_IN;

  wire \FSM_sequential_tx_state[0]_i_1_n_0 ;
  wire \FSM_sequential_tx_state[0]_i_2_n_0 ;
  wire \FSM_sequential_tx_state[1]_i_1_n_0 ;
  wire \FSM_sequential_tx_state[2]_i_1_n_0 ;
  wire \FSM_sequential_tx_state[2]_i_2_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_2_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_5_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_6_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire GT0_QPLLRESET_OUT;
  wire GT0_TX_FSM_RESET_DONE_OUT;
  wire GT0_TX_MMCM_LOCK_IN;
  wire GT0_TX_MMCM_RESET_OUT;
  wire MMCM_RESET_i_1_n_0;
  wire QPLL_RESET_i_1_n_0;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire TXUSERRDY_i_1_n_0;
  wire clear;
  wire data_out;
  wire gt0_gttxreset_in;
  wire gt0_txresetdone_out;
  wire gt0_txuserrdy_in;
  wire gt0_txusrclk_in;
  wire gttxreset_i_i_1_n_0;
  wire init_wait_count;
  wire \init_wait_count[6]_i_3_n_0 ;
  wire \init_wait_count[6]_i_4_n_0 ;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire init_wait_done_i_1_n_0;
  wire init_wait_done_reg_n_0;
  wire \mmcm_lock_count[7]_i_2_n_0 ;
  wire \mmcm_lock_count[7]_i_4_n_0 ;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_i_2_n_0;
  wire [6:0]p_0_in;
  wire [7:0]p_0_in__0;
  wire pll_reset_asserted_i_1_n_0;
  wire pll_reset_asserted_reg_n_0;
  wire reset_time_out;
  wire reset_time_out_i_3_n_0;
  wire run_phase_alignment_int_i_1_n_0;
  wire run_phase_alignment_int_reg_n_0;
  wire run_phase_alignment_int_s3;
  wire sel;
  wire sync_QPLLLOCK_n_0;
  wire sync_QPLLLOCK_n_1;
  wire sync_mmcm_lock_reclocked_n_0;
  wire sync_mmcm_lock_reclocked_n_1;
  wire time_out_2ms;
  wire time_out_2ms_i_1__3_n_0;
  wire time_out_2ms_reg_n_0;
  wire time_out_500us_i_1__3_n_0;
  wire time_out_500us_i_2_n_0;
  wire time_out_500us_i_3_n_0;
  wire time_out_500us_i_4__2_n_0;
  wire time_out_500us_reg_n_0;
  wire time_out_counter;
  wire \time_out_counter[0]_i_10_n_0 ;
  wire \time_out_counter[0]_i_11_n_0 ;
  wire \time_out_counter[0]_i_12_n_0 ;
  wire \time_out_counter[0]_i_7_n_0 ;
  wire \time_out_counter[0]_i_8__2_n_0 ;
  wire \time_out_counter[0]_i_9__0_n_0 ;
  wire [18:0]time_out_counter_reg;
  wire \time_out_counter_reg[0]_i_2_n_0 ;
  wire \time_out_counter_reg[0]_i_2_n_1 ;
  wire \time_out_counter_reg[0]_i_2_n_2 ;
  wire \time_out_counter_reg[0]_i_2_n_3 ;
  wire \time_out_counter_reg[0]_i_2_n_4 ;
  wire \time_out_counter_reg[0]_i_2_n_5 ;
  wire \time_out_counter_reg[0]_i_2_n_6 ;
  wire \time_out_counter_reg[0]_i_2_n_7 ;
  wire \time_out_counter_reg[12]_i_1_n_0 ;
  wire \time_out_counter_reg[12]_i_1_n_1 ;
  wire \time_out_counter_reg[12]_i_1_n_2 ;
  wire \time_out_counter_reg[12]_i_1_n_3 ;
  wire \time_out_counter_reg[12]_i_1_n_4 ;
  wire \time_out_counter_reg[12]_i_1_n_5 ;
  wire \time_out_counter_reg[12]_i_1_n_6 ;
  wire \time_out_counter_reg[12]_i_1_n_7 ;
  wire \time_out_counter_reg[16]_i_1_n_2 ;
  wire \time_out_counter_reg[16]_i_1_n_3 ;
  wire \time_out_counter_reg[16]_i_1_n_5 ;
  wire \time_out_counter_reg[16]_i_1_n_6 ;
  wire \time_out_counter_reg[16]_i_1_n_7 ;
  wire \time_out_counter_reg[4]_i_1_n_0 ;
  wire \time_out_counter_reg[4]_i_1_n_1 ;
  wire \time_out_counter_reg[4]_i_1_n_2 ;
  wire \time_out_counter_reg[4]_i_1_n_3 ;
  wire \time_out_counter_reg[4]_i_1_n_4 ;
  wire \time_out_counter_reg[4]_i_1_n_5 ;
  wire \time_out_counter_reg[4]_i_1_n_6 ;
  wire \time_out_counter_reg[4]_i_1_n_7 ;
  wire \time_out_counter_reg[8]_i_1_n_0 ;
  wire \time_out_counter_reg[8]_i_1_n_1 ;
  wire \time_out_counter_reg[8]_i_1_n_2 ;
  wire \time_out_counter_reg[8]_i_1_n_3 ;
  wire \time_out_counter_reg[8]_i_1_n_4 ;
  wire \time_out_counter_reg[8]_i_1_n_5 ;
  wire \time_out_counter_reg[8]_i_1_n_6 ;
  wire \time_out_counter_reg[8]_i_1_n_7 ;
  wire time_out_wait_bypass_i_1_n_0;
  wire time_out_wait_bypass_reg_n_0;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max_i_1__3_n_0;
  wire time_tlock_max_i_2_n_0;
  wire time_tlock_max_i_3_n_0;
  wire time_tlock_max_i_4_n_0;
  wire time_tlock_max_i_5_n_0;
  wire time_tlock_max_i_6_n_0;
  wire time_tlock_max_reg_n_0;
  wire tx_fsm_reset_done_int_i_1_n_0;
  wire tx_fsm_reset_done_int_s2;
  wire tx_fsm_reset_done_int_s3;
  (* RTL_KEEP = "yes" *) wire [3:0]tx_state;
  wire tx_state13_out;
  wire txresetdone_s2;
  wire txresetdone_s3;
  wire \wait_bypass_count[0]_i_10_n_0 ;
  wire \wait_bypass_count[0]_i_11_n_0 ;
  wire \wait_bypass_count[0]_i_12_n_0 ;
  wire \wait_bypass_count[0]_i_2_n_0 ;
  wire \wait_bypass_count[0]_i_4_n_0 ;
  wire \wait_bypass_count[0]_i_8_n_0 ;
  wire \wait_bypass_count[0]_i_9_n_0 ;
  wire [16:0]wait_bypass_count_reg;
  wire \wait_bypass_count_reg[0]_i_3_n_0 ;
  wire \wait_bypass_count_reg[0]_i_3_n_1 ;
  wire \wait_bypass_count_reg[0]_i_3_n_2 ;
  wire \wait_bypass_count_reg[0]_i_3_n_3 ;
  wire \wait_bypass_count_reg[0]_i_3_n_4 ;
  wire \wait_bypass_count_reg[0]_i_3_n_5 ;
  wire \wait_bypass_count_reg[0]_i_3_n_6 ;
  wire \wait_bypass_count_reg[0]_i_3_n_7 ;
  wire \wait_bypass_count_reg[12]_i_1_n_0 ;
  wire \wait_bypass_count_reg[12]_i_1_n_1 ;
  wire \wait_bypass_count_reg[12]_i_1_n_2 ;
  wire \wait_bypass_count_reg[12]_i_1_n_3 ;
  wire \wait_bypass_count_reg[12]_i_1_n_4 ;
  wire \wait_bypass_count_reg[12]_i_1_n_5 ;
  wire \wait_bypass_count_reg[12]_i_1_n_6 ;
  wire \wait_bypass_count_reg[12]_i_1_n_7 ;
  wire \wait_bypass_count_reg[16]_i_1_n_7 ;
  wire \wait_bypass_count_reg[4]_i_1_n_0 ;
  wire \wait_bypass_count_reg[4]_i_1_n_1 ;
  wire \wait_bypass_count_reg[4]_i_1_n_2 ;
  wire \wait_bypass_count_reg[4]_i_1_n_3 ;
  wire \wait_bypass_count_reg[4]_i_1_n_4 ;
  wire \wait_bypass_count_reg[4]_i_1_n_5 ;
  wire \wait_bypass_count_reg[4]_i_1_n_6 ;
  wire \wait_bypass_count_reg[4]_i_1_n_7 ;
  wire \wait_bypass_count_reg[8]_i_1_n_0 ;
  wire \wait_bypass_count_reg[8]_i_1_n_1 ;
  wire \wait_bypass_count_reg[8]_i_1_n_2 ;
  wire \wait_bypass_count_reg[8]_i_1_n_3 ;
  wire \wait_bypass_count_reg[8]_i_1_n_4 ;
  wire \wait_bypass_count_reg[8]_i_1_n_5 ;
  wire \wait_bypass_count_reg[8]_i_1_n_6 ;
  wire \wait_bypass_count_reg[8]_i_1_n_7 ;
  wire [6:0]wait_time_cnt0;
  wire \wait_time_cnt[1]_i_1_n_0 ;
  wire \wait_time_cnt[4]_i_1_n_0 ;
  wire \wait_time_cnt[6]_i_1_n_0 ;
  wire \wait_time_cnt[6]_i_4_n_0 ;
  wire [6:0]wait_time_cnt_reg__0;
  wire wait_time_done;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1_O_UNCONNECTED ;
  wire [3:0]\NLW_wait_bypass_count_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[16]_i_1_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h2222220222220A0A)) 
    \FSM_sequential_tx_state[0]_i_1 
       (.I0(\FSM_sequential_tx_state[0]_i_2_n_0 ),
        .I1(tx_state[3]),
        .I2(tx_state[0]),
        .I3(time_out_2ms_reg_n_0),
        .I4(tx_state[2]),
        .I5(tx_state[1]),
        .O(\FSM_sequential_tx_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3B33BBBBBBBBBBBB)) 
    \FSM_sequential_tx_state[0]_i_2 
       (.I0(\FSM_sequential_tx_state[2]_i_2_n_0 ),
        .I1(tx_state[0]),
        .I2(reset_time_out),
        .I3(time_out_500us_reg_n_0),
        .I4(tx_state[1]),
        .I5(tx_state[2]),
        .O(\FSM_sequential_tx_state[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h11110444)) 
    \FSM_sequential_tx_state[1]_i_1 
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state13_out),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .O(\FSM_sequential_tx_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \FSM_sequential_tx_state[1]_i_2 
       (.I0(reset_time_out),
        .I1(time_tlock_max_reg_n_0),
        .I2(mmcm_lock_reclocked),
        .O(tx_state13_out));
  LUT6 #(
    .INIT(64'h1111004055550040)) 
    \FSM_sequential_tx_state[2]_i_1 
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .I3(time_out_2ms_reg_n_0),
        .I4(tx_state[2]),
        .I5(\FSM_sequential_tx_state[2]_i_2_n_0 ),
        .O(\FSM_sequential_tx_state[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFF04)) 
    \FSM_sequential_tx_state[2]_i_2 
       (.I0(mmcm_lock_reclocked),
        .I1(time_tlock_max_reg_n_0),
        .I2(reset_time_out),
        .I3(tx_state[1]),
        .O(\FSM_sequential_tx_state[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00A00B00)) 
    \FSM_sequential_tx_state[3]_i_2 
       (.I0(\FSM_sequential_tx_state[3]_i_6_n_0 ),
        .I1(time_out_wait_bypass_s3),
        .I2(tx_state[2]),
        .I3(tx_state[3]),
        .I4(tx_state[1]),
        .O(\FSM_sequential_tx_state[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \FSM_sequential_tx_state[3]_i_4 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(\wait_time_cnt[6]_i_4_n_0 ),
        .I3(wait_time_cnt_reg__0[6]),
        .O(wait_time_done));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_tx_state[3]_i_5 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .O(\FSM_sequential_tx_state[3]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h8A)) 
    \FSM_sequential_tx_state[3]_i_6 
       (.I0(tx_state[0]),
        .I1(reset_time_out),
        .I2(time_out_500us_reg_n_0),
        .O(\FSM_sequential_tx_state[3]_i_6_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[0]_i_1_n_0 ),
        .Q(tx_state[0]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[1]_i_1_n_0 ),
        .Q(tx_state[1]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[2]_i_1_n_0 ),
        .Q(tx_state[2]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[3]_i_2_n_0 ),
        .Q(tx_state[3]),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFF70004)) 
    MMCM_RESET_i_1
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state[3]),
        .I3(tx_state[1]),
        .I4(GT0_TX_MMCM_RESET_OUT),
        .O(MMCM_RESET_i_1_n_0));
  FDRE #(
    .INIT(1'b1)) 
    MMCM_RESET_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(MMCM_RESET_i_1_n_0),
        .Q(GT0_TX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
  LUT6 #(
    .INIT(64'hFFFFFDFF00000100)) 
    QPLL_RESET_i_1
       (.I0(pll_reset_asserted_reg_n_0),
        .I1(tx_state[3]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(tx_state[1]),
        .I5(GT0_QPLLRESET_OUT),
        .O(QPLL_RESET_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    QPLL_RESET_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(QPLL_RESET_i_1_n_0),
        .Q(GT0_QPLLRESET_OUT),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFB4000)) 
    TXUSERRDY_i_1
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .I3(tx_state[2]),
        .I4(gt0_txuserrdy_in),
        .O(TXUSERRDY_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    TXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(TXUSERRDY_i_1_n_0),
        .Q(gt0_txuserrdy_in),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFD0004)) 
    gttxreset_i_i_1
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state[3]),
        .I3(tx_state[1]),
        .I4(gt0_gttxreset_in),
        .O(gttxreset_i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    gttxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gttxreset_i_i_1_n_0),
        .Q(gt0_gttxreset_in),
        .R(SOFT_RESET_IN));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \init_wait_count[0]_i_1 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \init_wait_count[1]_i_1 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \init_wait_count[2]_i_1 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \init_wait_count[3]_i_1 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \init_wait_count[4]_i_1 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \init_wait_count[5]_i_1 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
    \init_wait_count[6]_i_1 
       (.I0(\init_wait_count[6]_i_3_n_0 ),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_count));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'h9AAAAAAA)) 
    \init_wait_count[6]_i_2 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\init_wait_count[6]_i_4_n_0 ),
        .I2(init_wait_count_reg__0[4]),
        .I3(init_wait_count_reg__0[3]),
        .I4(init_wait_count_reg__0[5]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \init_wait_count[6]_i_3 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(\init_wait_count[6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \init_wait_count[6]_i_4 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(\init_wait_count[6]_i_4_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[0]),
        .Q(init_wait_count_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
  LUT2 #(
    .INIT(4'hE)) 
    init_wait_done_i_1
       (.I0(init_wait_done),
        .I1(init_wait_done_reg_n_0),
        .O(init_wait_done_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    init_wait_done_i_2
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\init_wait_count[6]_i_3_n_0 ),
        .O(init_wait_done));
  FDCE #(
    .INIT(1'b0)) 
    init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(init_wait_done_i_1_n_0),
        .Q(init_wait_done_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[0]_i_1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \mmcm_lock_count[1]_i_1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \mmcm_lock_count[2]_i_1 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \mmcm_lock_count[3]_i_1 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[4]_i_1 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[2]),
        .I4(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \mmcm_lock_count[5]_i_1 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \mmcm_lock_count[6]_i_1 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__0[6]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \mmcm_lock_count[7]_i_2 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(\mmcm_lock_count[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[7]_i_3 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(mmcm_lock_count_reg__0[5]),
        .I2(\mmcm_lock_count[7]_i_4_n_0 ),
        .I3(mmcm_lock_count_reg__0[4]),
        .I4(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \mmcm_lock_count[7]_i_4 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .O(\mmcm_lock_count[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2_n_0 ),
        .D(p_0_in__0[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2_n_0 ),
        .D(p_0_in__0[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2_n_0 ),
        .D(p_0_in__0[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2_n_0 ),
        .D(p_0_in__0[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2_n_0 ),
        .D(p_0_in__0[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2_n_0 ),
        .D(p_0_in__0[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2_n_0 ),
        .D(p_0_in__0[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2_n_0 ),
        .D(p_0_in__0[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(sync_mmcm_lock_reclocked_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    mmcm_lock_reclocked_i_2
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(mmcm_lock_reclocked_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_mmcm_lock_reclocked_n_1),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hEF00FF10)) 
    pll_reset_asserted_i_1
       (.I0(tx_state[3]),
        .I1(tx_state[2]),
        .I2(tx_state[0]),
        .I3(pll_reset_asserted_reg_n_0),
        .I4(tx_state[1]),
        .O(pll_reset_asserted_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    pll_reset_asserted_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(pll_reset_asserted_i_1_n_0),
        .Q(pll_reset_asserted_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT3 #(
    .INIT(8'h2A)) 
    reset_time_out_i_3
       (.I0(tx_state[0]),
        .I1(tx_state[3]),
        .I2(tx_state[2]),
        .O(reset_time_out_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_QPLLLOCK_n_0),
        .Q(reset_time_out),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFB0002)) 
    run_phase_alignment_int_i_1
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[2]),
        .I3(tx_state[1]),
        .I4(run_phase_alignment_int_reg_n_0),
        .O(run_phase_alignment_int_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(run_phase_alignment_int_i_1_n_0),
        .Q(run_phase_alignment_int_reg_n_0),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_s3_reg
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(data_out),
        .Q(run_phase_alignment_int_s3),
        .R(1'b0));
  XLAUI_XLAUI_sync_block_50 sync_QPLLLOCK
       (.E(sync_QPLLLOCK_n_1),
        .\FSM_sequential_tx_state_reg[0] (reset_time_out_i_3_n_0),
        .\FSM_sequential_tx_state_reg[1] (\FSM_sequential_tx_state[3]_i_5_n_0 ),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .init_wait_done_reg(init_wait_done_reg_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(tx_state),
        .pll_reset_asserted_reg(pll_reset_asserted_reg_n_0),
        .reset_time_out(reset_time_out),
        .reset_time_out_reg(sync_QPLLLOCK_n_0),
        .time_out_2ms_reg(time_out_2ms_reg_n_0),
        .time_out_500us_reg(time_out_500us_reg_n_0),
        .time_tlock_max_reg(time_tlock_max_reg_n_0),
        .txresetdone_s3(txresetdone_s3),
        .wait_time_done(wait_time_done));
  XLAUI_XLAUI_sync_block_51 sync_TXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(txresetdone_s2),
        .gt0_txresetdone_out(gt0_txresetdone_out));
  XLAUI_XLAUI_sync_block_52 sync_mmcm_lock_reclocked
       (.GT0_TX_MMCM_LOCK_IN(GT0_TX_MMCM_LOCK_IN),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(sync_mmcm_lock_reclocked_n_0),
        .SYSCLK_IN(SYSCLK_IN),
        .\mmcm_lock_count_reg[5] (mmcm_lock_reclocked_i_2_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_lock_reclocked_reg(sync_mmcm_lock_reclocked_n_1));
  XLAUI_XLAUI_sync_block_53 sync_run_phase_alignment_int
       (.data_in(run_phase_alignment_int_reg_n_0),
        .data_out(data_out),
        .gt0_txusrclk_in(gt0_txusrclk_in));
  XLAUI_XLAUI_sync_block_54 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(time_out_wait_bypass_reg_n_0),
        .data_out(time_out_wait_bypass_s2));
  XLAUI_XLAUI_sync_block_55 sync_tx_fsm_reset_done_int
       (.GT0_TX_FSM_RESET_DONE_OUT(GT0_TX_FSM_RESET_DONE_OUT),
        .data_out(tx_fsm_reset_done_int_s2),
        .gt0_txusrclk_in(gt0_txusrclk_in));
  LUT3 #(
    .INIT(8'h0E)) 
    time_out_2ms_i_1__3
       (.I0(time_out_2ms_reg_n_0),
        .I1(time_out_2ms),
        .I2(reset_time_out),
        .O(time_out_2ms_i_1__3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_2ms_i_1__3_n_0),
        .Q(time_out_2ms_reg_n_0),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h00AE)) 
    time_out_500us_i_1__3
       (.I0(time_out_500us_reg_n_0),
        .I1(time_out_500us_i_2_n_0),
        .I2(time_out_500us_i_3_n_0),
        .I3(reset_time_out),
        .O(time_out_500us_i_1__3_n_0));
  LUT5 #(
    .INIT(32'h00000080)) 
    time_out_500us_i_2
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[0]),
        .I3(time_out_counter_reg[4]),
        .I4(time_out_500us_i_4__2_n_0),
        .O(time_out_500us_i_2_n_0));
  LUT5 #(
    .INIT(32'hFFFFBFFF)) 
    time_out_500us_i_3
       (.I0(\time_out_counter[0]_i_12_n_0 ),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[2]),
        .I4(time_tlock_max_i_5_n_0),
        .O(time_out_500us_i_3_n_0));
  LUT4 #(
    .INIT(16'hFFFB)) 
    time_out_500us_i_4__2
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[3]),
        .O(time_out_500us_i_4__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_500us_i_1__3_n_0),
        .Q(time_out_500us_reg_n_0),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hDF)) 
    \time_out_counter[0]_i_10 
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[18]),
        .O(\time_out_counter[0]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hDFFF)) 
    \time_out_counter[0]_i_11 
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[16]),
        .I3(time_out_counter_reg[4]),
        .O(\time_out_counter[0]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \time_out_counter[0]_i_12 
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[5]),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_counter_reg[1]),
        .O(\time_out_counter[0]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_1__3 
       (.I0(time_out_2ms),
        .O(time_out_counter));
  LUT5 #(
    .INIT(32'h00000004)) 
    \time_out_counter[0]_i_3 
       (.I0(\time_out_counter[0]_i_8__2_n_0 ),
        .I1(\time_out_counter[0]_i_9__0_n_0 ),
        .I2(\time_out_counter[0]_i_10_n_0 ),
        .I3(\time_out_counter[0]_i_11_n_0 ),
        .I4(\time_out_counter[0]_i_12_n_0 ),
        .O(time_out_2ms));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_7 
       (.I0(time_out_counter_reg[0]),
        .O(\time_out_counter[0]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \time_out_counter[0]_i_8__2 
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[11]),
        .O(\time_out_counter[0]_i_8__2_n_0 ));
  LUT4 #(
    .INIT(16'h4000)) 
    \time_out_counter[0]_i_9__0 
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[9]),
        .I3(time_out_counter_reg[12]),
        .O(\time_out_counter[0]_i_9__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2_n_7 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out));
  CARRY4 \time_out_counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\time_out_counter_reg[0]_i_2_n_0 ,\time_out_counter_reg[0]_i_2_n_1 ,\time_out_counter_reg[0]_i_2_n_2 ,\time_out_counter_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\time_out_counter_reg[0]_i_2_n_4 ,\time_out_counter_reg[0]_i_2_n_5 ,\time_out_counter_reg[0]_i_2_n_6 ,\time_out_counter_reg[0]_i_2_n_7 }),
        .S({time_out_counter_reg[3:1],\time_out_counter[0]_i_7_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1_n_5 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1_n_4 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1_n_7 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out));
  CARRY4 \time_out_counter_reg[12]_i_1 
       (.CI(\time_out_counter_reg[8]_i_1_n_0 ),
        .CO({\time_out_counter_reg[12]_i_1_n_0 ,\time_out_counter_reg[12]_i_1_n_1 ,\time_out_counter_reg[12]_i_1_n_2 ,\time_out_counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[12]_i_1_n_4 ,\time_out_counter_reg[12]_i_1_n_5 ,\time_out_counter_reg[12]_i_1_n_6 ,\time_out_counter_reg[12]_i_1_n_7 }),
        .S(time_out_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1_n_6 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1_n_5 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1_n_4 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1_n_7 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out));
  CARRY4 \time_out_counter_reg[16]_i_1 
       (.CI(\time_out_counter_reg[12]_i_1_n_0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1_CO_UNCONNECTED [3:2],\time_out_counter_reg[16]_i_1_n_2 ,\time_out_counter_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1_O_UNCONNECTED [3],\time_out_counter_reg[16]_i_1_n_5 ,\time_out_counter_reg[16]_i_1_n_6 ,\time_out_counter_reg[16]_i_1_n_7 }),
        .S({1'b0,time_out_counter_reg[18:16]}));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1_n_6 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1_n_5 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2_n_6 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2_n_5 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2_n_4 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1_n_7 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out));
  CARRY4 \time_out_counter_reg[4]_i_1 
       (.CI(\time_out_counter_reg[0]_i_2_n_0 ),
        .CO({\time_out_counter_reg[4]_i_1_n_0 ,\time_out_counter_reg[4]_i_1_n_1 ,\time_out_counter_reg[4]_i_1_n_2 ,\time_out_counter_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[4]_i_1_n_4 ,\time_out_counter_reg[4]_i_1_n_5 ,\time_out_counter_reg[4]_i_1_n_6 ,\time_out_counter_reg[4]_i_1_n_7 }),
        .S(time_out_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1_n_6 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1_n_5 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1_n_4 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1_n_7 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out));
  CARRY4 \time_out_counter_reg[8]_i_1 
       (.CI(\time_out_counter_reg[4]_i_1_n_0 ),
        .CO({\time_out_counter_reg[8]_i_1_n_0 ,\time_out_counter_reg[8]_i_1_n_1 ,\time_out_counter_reg[8]_i_1_n_2 ,\time_out_counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[8]_i_1_n_4 ,\time_out_counter_reg[8]_i_1_n_5 ,\time_out_counter_reg[8]_i_1_n_6 ,\time_out_counter_reg[8]_i_1_n_7 }),
        .S(time_out_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1_n_6 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out));
  LUT4 #(
    .INIT(16'hAB00)) 
    time_out_wait_bypass_i_1
       (.I0(time_out_wait_bypass_reg_n_0),
        .I1(\wait_bypass_count[0]_i_4_n_0 ),
        .I2(tx_fsm_reset_done_int_s3),
        .I3(run_phase_alignment_int_s3),
        .O(time_out_wait_bypass_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_reg
       (.C(gt0_txusrclk_in),
        .CE(1'b1),
        .D(time_out_wait_bypass_i_1_n_0),
        .Q(time_out_wait_bypass_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'h00AE)) 
    time_tlock_max_i_1__3
       (.I0(time_tlock_max_reg_n_0),
        .I1(time_tlock_max_i_2_n_0),
        .I2(time_tlock_max_i_3_n_0),
        .I3(reset_time_out),
        .O(time_tlock_max_i_1__3_n_0));
  LUT5 #(
    .INIT(32'h00000080)) 
    time_tlock_max_i_2
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[9]),
        .I4(time_tlock_max_i_4_n_0),
        .O(time_tlock_max_i_2_n_0));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    time_tlock_max_i_3
       (.I0(time_tlock_max_i_5_n_0),
        .I1(time_tlock_max_i_6_n_0),
        .I2(time_out_counter_reg[16]),
        .I3(time_out_counter_reg[1]),
        .I4(time_out_counter_reg[0]),
        .O(time_tlock_max_i_3_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    time_tlock_max_i_4
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[6]),
        .I3(time_out_counter_reg[5]),
        .O(time_tlock_max_i_4_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    time_tlock_max_i_5
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[12]),
        .O(time_tlock_max_i_5_n_0));
  LUT4 #(
    .INIT(16'hFFEF)) 
    time_tlock_max_i_6
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[2]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[15]),
        .O(time_tlock_max_i_6_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_tlock_max_i_1__3_n_0),
        .Q(time_tlock_max_reg_n_0),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFFF0008)) 
    tx_fsm_reset_done_int_i_1
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[2]),
        .I3(tx_state[1]),
        .I4(GT0_TX_FSM_RESET_DONE_OUT),
        .O(tx_fsm_reset_done_int_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    tx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_i_1_n_0),
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
        .O(clear));
  LUT5 #(
    .INIT(32'hDFFFFFFF)) 
    \wait_bypass_count[0]_i_10 
       (.I0(wait_bypass_count_reg[0]),
        .I1(wait_bypass_count_reg[15]),
        .I2(wait_bypass_count_reg[16]),
        .I3(wait_bypass_count_reg[2]),
        .I4(wait_bypass_count_reg[1]),
        .O(\wait_bypass_count[0]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hFFEF)) 
    \wait_bypass_count[0]_i_11 
       (.I0(wait_bypass_count_reg[12]),
        .I1(wait_bypass_count_reg[11]),
        .I2(wait_bypass_count_reg[13]),
        .I3(wait_bypass_count_reg[14]),
        .O(\wait_bypass_count[0]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \wait_bypass_count[0]_i_12 
       (.I0(wait_bypass_count_reg[8]),
        .I1(wait_bypass_count_reg[7]),
        .I2(wait_bypass_count_reg[10]),
        .I3(wait_bypass_count_reg[9]),
        .O(\wait_bypass_count[0]_i_12_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \wait_bypass_count[0]_i_2 
       (.I0(\wait_bypass_count[0]_i_4_n_0 ),
        .I1(tx_fsm_reset_done_int_s3),
        .O(\wait_bypass_count[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_bypass_count[0]_i_4 
       (.I0(\wait_bypass_count[0]_i_9_n_0 ),
        .I1(\wait_bypass_count[0]_i_10_n_0 ),
        .I2(\wait_bypass_count[0]_i_11_n_0 ),
        .I3(\wait_bypass_count[0]_i_12_n_0 ),
        .O(\wait_bypass_count[0]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_8 
       (.I0(wait_bypass_count_reg[0]),
        .O(\wait_bypass_count[0]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \wait_bypass_count[0]_i_9 
       (.I0(wait_bypass_count_reg[4]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[6]),
        .I3(wait_bypass_count_reg[5]),
        .O(\wait_bypass_count[0]_i_9_n_0 ));
  FDRE \wait_bypass_count_reg[0] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3_n_7 ),
        .Q(wait_bypass_count_reg[0]),
        .R(clear));
  CARRY4 \wait_bypass_count_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\wait_bypass_count_reg[0]_i_3_n_0 ,\wait_bypass_count_reg[0]_i_3_n_1 ,\wait_bypass_count_reg[0]_i_3_n_2 ,\wait_bypass_count_reg[0]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\wait_bypass_count_reg[0]_i_3_n_4 ,\wait_bypass_count_reg[0]_i_3_n_5 ,\wait_bypass_count_reg[0]_i_3_n_6 ,\wait_bypass_count_reg[0]_i_3_n_7 }),
        .S({wait_bypass_count_reg[3:1],\wait_bypass_count[0]_i_8_n_0 }));
  FDRE \wait_bypass_count_reg[10] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1_n_5 ),
        .Q(wait_bypass_count_reg[10]),
        .R(clear));
  FDRE \wait_bypass_count_reg[11] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1_n_4 ),
        .Q(wait_bypass_count_reg[11]),
        .R(clear));
  FDRE \wait_bypass_count_reg[12] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1_n_7 ),
        .Q(wait_bypass_count_reg[12]),
        .R(clear));
  CARRY4 \wait_bypass_count_reg[12]_i_1 
       (.CI(\wait_bypass_count_reg[8]_i_1_n_0 ),
        .CO({\wait_bypass_count_reg[12]_i_1_n_0 ,\wait_bypass_count_reg[12]_i_1_n_1 ,\wait_bypass_count_reg[12]_i_1_n_2 ,\wait_bypass_count_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[12]_i_1_n_4 ,\wait_bypass_count_reg[12]_i_1_n_5 ,\wait_bypass_count_reg[12]_i_1_n_6 ,\wait_bypass_count_reg[12]_i_1_n_7 }),
        .S(wait_bypass_count_reg[15:12]));
  FDRE \wait_bypass_count_reg[13] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1_n_6 ),
        .Q(wait_bypass_count_reg[13]),
        .R(clear));
  FDRE \wait_bypass_count_reg[14] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1_n_5 ),
        .Q(wait_bypass_count_reg[14]),
        .R(clear));
  FDRE \wait_bypass_count_reg[15] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1_n_4 ),
        .Q(wait_bypass_count_reg[15]),
        .R(clear));
  FDRE \wait_bypass_count_reg[16] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[16]_i_1_n_7 ),
        .Q(wait_bypass_count_reg[16]),
        .R(clear));
  CARRY4 \wait_bypass_count_reg[16]_i_1 
       (.CI(\wait_bypass_count_reg[12]_i_1_n_0 ),
        .CO(\NLW_wait_bypass_count_reg[16]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[16]_i_1_O_UNCONNECTED [3:1],\wait_bypass_count_reg[16]_i_1_n_7 }),
        .S({1'b0,1'b0,1'b0,wait_bypass_count_reg[16]}));
  FDRE \wait_bypass_count_reg[1] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3_n_6 ),
        .Q(wait_bypass_count_reg[1]),
        .R(clear));
  FDRE \wait_bypass_count_reg[2] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3_n_5 ),
        .Q(wait_bypass_count_reg[2]),
        .R(clear));
  FDRE \wait_bypass_count_reg[3] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3_n_4 ),
        .Q(wait_bypass_count_reg[3]),
        .R(clear));
  FDRE \wait_bypass_count_reg[4] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1_n_7 ),
        .Q(wait_bypass_count_reg[4]),
        .R(clear));
  CARRY4 \wait_bypass_count_reg[4]_i_1 
       (.CI(\wait_bypass_count_reg[0]_i_3_n_0 ),
        .CO({\wait_bypass_count_reg[4]_i_1_n_0 ,\wait_bypass_count_reg[4]_i_1_n_1 ,\wait_bypass_count_reg[4]_i_1_n_2 ,\wait_bypass_count_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[4]_i_1_n_4 ,\wait_bypass_count_reg[4]_i_1_n_5 ,\wait_bypass_count_reg[4]_i_1_n_6 ,\wait_bypass_count_reg[4]_i_1_n_7 }),
        .S(wait_bypass_count_reg[7:4]));
  FDRE \wait_bypass_count_reg[5] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1_n_6 ),
        .Q(wait_bypass_count_reg[5]),
        .R(clear));
  FDRE \wait_bypass_count_reg[6] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1_n_5 ),
        .Q(wait_bypass_count_reg[6]),
        .R(clear));
  FDRE \wait_bypass_count_reg[7] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1_n_4 ),
        .Q(wait_bypass_count_reg[7]),
        .R(clear));
  FDRE \wait_bypass_count_reg[8] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1_n_7 ),
        .Q(wait_bypass_count_reg[8]),
        .R(clear));
  CARRY4 \wait_bypass_count_reg[8]_i_1 
       (.CI(\wait_bypass_count_reg[4]_i_1_n_0 ),
        .CO({\wait_bypass_count_reg[8]_i_1_n_0 ,\wait_bypass_count_reg[8]_i_1_n_1 ,\wait_bypass_count_reg[8]_i_1_n_2 ,\wait_bypass_count_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[8]_i_1_n_4 ,\wait_bypass_count_reg[8]_i_1_n_5 ,\wait_bypass_count_reg[8]_i_1_n_6 ,\wait_bypass_count_reg[8]_i_1_n_7 }),
        .S(wait_bypass_count_reg[11:8]));
  FDRE \wait_bypass_count_reg[9] 
       (.C(gt0_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1_n_6 ),
        .Q(wait_bypass_count_reg[9]),
        .R(clear));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_time_cnt[0]_i_1 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \wait_time_cnt[1]_i_1 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\wait_time_cnt[1]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hE1)) 
    \wait_time_cnt[2]_i_1 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[2]),
        .O(wait_time_cnt0[2]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \wait_time_cnt[3]_i_1 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0[3]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \wait_time_cnt[4]_i_1 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\wait_time_cnt[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
    \wait_time_cnt[5]_i_1 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[5]));
  LUT4 #(
    .INIT(16'h1030)) 
    \wait_time_cnt[6]_i_1 
       (.I0(tx_state[2]),
        .I1(tx_state[3]),
        .I2(tx_state[0]),
        .I3(tx_state[1]),
        .O(\wait_time_cnt[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_2 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\wait_time_cnt[6]_i_4_n_0 ),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(wait_time_cnt_reg__0[5]),
        .O(sel));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \wait_time_cnt[6]_i_3 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(\wait_time_cnt[6]_i_4_n_0 ),
        .O(wait_time_cnt0[6]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_4 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .O(\wait_time_cnt[6]_i_4_n_0 ));
  FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(sel),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\wait_time_cnt[6]_i_1_n_0 ));
  FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(sel),
        .D(\wait_time_cnt[1]_i_1_n_0 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\wait_time_cnt[6]_i_1_n_0 ));
  FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(sel),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\wait_time_cnt[6]_i_1_n_0 ));
  FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(sel),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\wait_time_cnt[6]_i_1_n_0 ));
  FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(sel),
        .D(\wait_time_cnt[4]_i_1_n_0 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\wait_time_cnt[6]_i_1_n_0 ));
  FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(sel),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\wait_time_cnt[6]_i_1_n_0 ));
  FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(sel),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\wait_time_cnt[6]_i_1_n_0 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_TX_STARTUP_FSM" *) 
module XLAUI_XLAUI_TX_STARTUP_FSM_1
   (gt1_gttxreset_in,
    GT1_TX_MMCM_RESET_OUT,
    GT1_TX_FSM_RESET_DONE_OUT,
    gt1_txuserrdy_in,
    SYSCLK_IN,
    gt1_txusrclk_in,
    SOFT_RESET_IN,
    gt1_txresetdone_out,
    GT1_TX_MMCM_LOCK_IN,
    GT0_QPLLLOCK_IN);
  output gt1_gttxreset_in;
  output GT1_TX_MMCM_RESET_OUT;
  output GT1_TX_FSM_RESET_DONE_OUT;
  output gt1_txuserrdy_in;
  input SYSCLK_IN;
  input gt1_txusrclk_in;
  input SOFT_RESET_IN;
  input gt1_txresetdone_out;
  input GT1_TX_MMCM_LOCK_IN;
  input GT0_QPLLLOCK_IN;

  wire \FSM_sequential_tx_state[0]_i_1__0_n_0 ;
  wire \FSM_sequential_tx_state[0]_i_2__0_n_0 ;
  wire \FSM_sequential_tx_state[1]_i_1__0_n_0 ;
  wire \FSM_sequential_tx_state[2]_i_1__0_n_0 ;
  wire \FSM_sequential_tx_state[2]_i_2__0_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_2__0_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_5__0_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_6__0_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire GT1_TX_FSM_RESET_DONE_OUT;
  wire GT1_TX_MMCM_LOCK_IN;
  wire GT1_TX_MMCM_RESET_OUT;
  wire MMCM_RESET_i_1__0_n_0;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire TXUSERRDY_i_1__0_n_0;
  wire data_out;
  wire gt1_gttxreset_in;
  wire gt1_txresetdone_out;
  wire gt1_txuserrdy_in;
  wire gt1_txusrclk_in;
  wire gttxreset_i_i_1__0_n_0;
  wire init_wait_count;
  wire \init_wait_count[6]_i_3__0_n_0 ;
  wire \init_wait_count[6]_i_4__0_n_0 ;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire init_wait_done_i_1__0_n_0;
  wire init_wait_done_reg_n_0;
  wire \mmcm_lock_count[7]_i_2__0_n_0 ;
  wire \mmcm_lock_count[7]_i_4__0_n_0 ;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_i_2__0_n_0;
  wire [6:0]p_0_in;
  wire [7:0]p_0_in__0;
  wire pll_reset_asserted_i_1__0_n_0;
  wire pll_reset_asserted_reg_n_0;
  wire reset_time_out_i_3__0_n_0;
  wire reset_time_out_reg_n_0;
  wire run_phase_alignment_int_i_1__0_n_0;
  wire run_phase_alignment_int_reg_n_0;
  wire run_phase_alignment_int_s3_reg_n_0;
  wire sync_QPLLLOCK_n_0;
  wire sync_QPLLLOCK_n_1;
  wire sync_mmcm_lock_reclocked_n_0;
  wire sync_mmcm_lock_reclocked_n_1;
  wire time_out_2ms;
  wire time_out_2ms_i_1__4_n_0;
  wire time_out_2ms_reg_n_0;
  wire time_out_500us_i_1__4_n_0;
  wire time_out_500us_i_2__0_n_0;
  wire time_out_500us_i_3__0_n_0;
  wire time_out_500us_reg_n_0;
  wire time_out_counter;
  wire \time_out_counter[0]_i_10__0_n_0 ;
  wire \time_out_counter[0]_i_11__0_n_0 ;
  wire \time_out_counter[0]_i_12__0_n_0 ;
  wire \time_out_counter[0]_i_7__0_n_0 ;
  wire \time_out_counter[0]_i_8__3_n_0 ;
  wire \time_out_counter[0]_i_9__1_n_0 ;
  wire [18:0]time_out_counter_reg;
  wire \time_out_counter_reg[0]_i_2__0_n_0 ;
  wire \time_out_counter_reg[0]_i_2__0_n_1 ;
  wire \time_out_counter_reg[0]_i_2__0_n_2 ;
  wire \time_out_counter_reg[0]_i_2__0_n_3 ;
  wire \time_out_counter_reg[0]_i_2__0_n_4 ;
  wire \time_out_counter_reg[0]_i_2__0_n_5 ;
  wire \time_out_counter_reg[0]_i_2__0_n_6 ;
  wire \time_out_counter_reg[0]_i_2__0_n_7 ;
  wire \time_out_counter_reg[12]_i_1__0_n_0 ;
  wire \time_out_counter_reg[12]_i_1__0_n_1 ;
  wire \time_out_counter_reg[12]_i_1__0_n_2 ;
  wire \time_out_counter_reg[12]_i_1__0_n_3 ;
  wire \time_out_counter_reg[12]_i_1__0_n_4 ;
  wire \time_out_counter_reg[12]_i_1__0_n_5 ;
  wire \time_out_counter_reg[12]_i_1__0_n_6 ;
  wire \time_out_counter_reg[12]_i_1__0_n_7 ;
  wire \time_out_counter_reg[16]_i_1__0_n_2 ;
  wire \time_out_counter_reg[16]_i_1__0_n_3 ;
  wire \time_out_counter_reg[16]_i_1__0_n_5 ;
  wire \time_out_counter_reg[16]_i_1__0_n_6 ;
  wire \time_out_counter_reg[16]_i_1__0_n_7 ;
  wire \time_out_counter_reg[4]_i_1__0_n_0 ;
  wire \time_out_counter_reg[4]_i_1__0_n_1 ;
  wire \time_out_counter_reg[4]_i_1__0_n_2 ;
  wire \time_out_counter_reg[4]_i_1__0_n_3 ;
  wire \time_out_counter_reg[4]_i_1__0_n_4 ;
  wire \time_out_counter_reg[4]_i_1__0_n_5 ;
  wire \time_out_counter_reg[4]_i_1__0_n_6 ;
  wire \time_out_counter_reg[4]_i_1__0_n_7 ;
  wire \time_out_counter_reg[8]_i_1__0_n_0 ;
  wire \time_out_counter_reg[8]_i_1__0_n_1 ;
  wire \time_out_counter_reg[8]_i_1__0_n_2 ;
  wire \time_out_counter_reg[8]_i_1__0_n_3 ;
  wire \time_out_counter_reg[8]_i_1__0_n_4 ;
  wire \time_out_counter_reg[8]_i_1__0_n_5 ;
  wire \time_out_counter_reg[8]_i_1__0_n_6 ;
  wire \time_out_counter_reg[8]_i_1__0_n_7 ;
  wire time_out_wait_bypass_i_1__0_n_0;
  wire time_out_wait_bypass_reg_n_0;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max_i_1__4_n_0;
  wire time_tlock_max_i_2__0_n_0;
  wire time_tlock_max_i_3__0_n_0;
  wire time_tlock_max_i_4__0_n_0;
  wire time_tlock_max_i_5__0_n_0;
  wire time_tlock_max_i_6__0_n_0;
  wire time_tlock_max_reg_n_0;
  wire tx_fsm_reset_done_int_i_1__0_n_0;
  wire tx_fsm_reset_done_int_s2;
  wire tx_fsm_reset_done_int_s3_reg_n_0;
  (* RTL_KEEP = "yes" *) wire [3:0]tx_state;
  wire tx_state13_out;
  wire txresetdone_s2;
  wire txresetdone_s3;
  wire \wait_bypass_count[0]_i_10__0_n_0 ;
  wire \wait_bypass_count[0]_i_11__0_n_0 ;
  wire \wait_bypass_count[0]_i_12__0_n_0 ;
  wire \wait_bypass_count[0]_i_1__0_n_0 ;
  wire \wait_bypass_count[0]_i_2__0_n_0 ;
  wire \wait_bypass_count[0]_i_4__0_n_0 ;
  wire \wait_bypass_count[0]_i_8__0_n_0 ;
  wire \wait_bypass_count[0]_i_9__0_n_0 ;
  wire [16:0]wait_bypass_count_reg;
  wire \wait_bypass_count_reg[0]_i_3__0_n_0 ;
  wire \wait_bypass_count_reg[0]_i_3__0_n_1 ;
  wire \wait_bypass_count_reg[0]_i_3__0_n_2 ;
  wire \wait_bypass_count_reg[0]_i_3__0_n_3 ;
  wire \wait_bypass_count_reg[0]_i_3__0_n_4 ;
  wire \wait_bypass_count_reg[0]_i_3__0_n_5 ;
  wire \wait_bypass_count_reg[0]_i_3__0_n_6 ;
  wire \wait_bypass_count_reg[0]_i_3__0_n_7 ;
  wire \wait_bypass_count_reg[12]_i_1__0_n_0 ;
  wire \wait_bypass_count_reg[12]_i_1__0_n_1 ;
  wire \wait_bypass_count_reg[12]_i_1__0_n_2 ;
  wire \wait_bypass_count_reg[12]_i_1__0_n_3 ;
  wire \wait_bypass_count_reg[12]_i_1__0_n_4 ;
  wire \wait_bypass_count_reg[12]_i_1__0_n_5 ;
  wire \wait_bypass_count_reg[12]_i_1__0_n_6 ;
  wire \wait_bypass_count_reg[12]_i_1__0_n_7 ;
  wire \wait_bypass_count_reg[16]_i_1__0_n_7 ;
  wire \wait_bypass_count_reg[4]_i_1__0_n_0 ;
  wire \wait_bypass_count_reg[4]_i_1__0_n_1 ;
  wire \wait_bypass_count_reg[4]_i_1__0_n_2 ;
  wire \wait_bypass_count_reg[4]_i_1__0_n_3 ;
  wire \wait_bypass_count_reg[4]_i_1__0_n_4 ;
  wire \wait_bypass_count_reg[4]_i_1__0_n_5 ;
  wire \wait_bypass_count_reg[4]_i_1__0_n_6 ;
  wire \wait_bypass_count_reg[4]_i_1__0_n_7 ;
  wire \wait_bypass_count_reg[8]_i_1__0_n_0 ;
  wire \wait_bypass_count_reg[8]_i_1__0_n_1 ;
  wire \wait_bypass_count_reg[8]_i_1__0_n_2 ;
  wire \wait_bypass_count_reg[8]_i_1__0_n_3 ;
  wire \wait_bypass_count_reg[8]_i_1__0_n_4 ;
  wire \wait_bypass_count_reg[8]_i_1__0_n_5 ;
  wire \wait_bypass_count_reg[8]_i_1__0_n_6 ;
  wire \wait_bypass_count_reg[8]_i_1__0_n_7 ;
  wire [6:0]wait_time_cnt0;
  wire \wait_time_cnt[1]_i_1__0_n_0 ;
  wire \wait_time_cnt[4]_i_1__0_n_0 ;
  wire \wait_time_cnt[6]_i_1__0_n_0 ;
  wire \wait_time_cnt[6]_i_2__0_n_0 ;
  wire \wait_time_cnt[6]_i_4__0_n_0 ;
  wire [6:0]wait_time_cnt_reg__0;
  wire wait_time_done;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__0_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__0_O_UNCONNECTED ;
  wire [3:0]\NLW_wait_bypass_count_reg[16]_i_1__0_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[16]_i_1__0_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h2222220222220A0A)) 
    \FSM_sequential_tx_state[0]_i_1__0 
       (.I0(\FSM_sequential_tx_state[0]_i_2__0_n_0 ),
        .I1(tx_state[3]),
        .I2(tx_state[0]),
        .I3(time_out_2ms_reg_n_0),
        .I4(tx_state[2]),
        .I5(tx_state[1]),
        .O(\FSM_sequential_tx_state[0]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h3B33BBBBBBBBBBBB)) 
    \FSM_sequential_tx_state[0]_i_2__0 
       (.I0(\FSM_sequential_tx_state[2]_i_2__0_n_0 ),
        .I1(tx_state[0]),
        .I2(reset_time_out_reg_n_0),
        .I3(time_out_500us_reg_n_0),
        .I4(tx_state[1]),
        .I5(tx_state[2]),
        .O(\FSM_sequential_tx_state[0]_i_2__0_n_0 ));
  LUT5 #(
    .INIT(32'h11110444)) 
    \FSM_sequential_tx_state[1]_i_1__0 
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state13_out),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .O(\FSM_sequential_tx_state[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \FSM_sequential_tx_state[1]_i_2__0 
       (.I0(reset_time_out_reg_n_0),
        .I1(time_tlock_max_reg_n_0),
        .I2(mmcm_lock_reclocked),
        .O(tx_state13_out));
  LUT6 #(
    .INIT(64'h1111004055550040)) 
    \FSM_sequential_tx_state[2]_i_1__0 
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .I3(time_out_2ms_reg_n_0),
        .I4(tx_state[2]),
        .I5(\FSM_sequential_tx_state[2]_i_2__0_n_0 ),
        .O(\FSM_sequential_tx_state[2]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFF04)) 
    \FSM_sequential_tx_state[2]_i_2__0 
       (.I0(mmcm_lock_reclocked),
        .I1(time_tlock_max_reg_n_0),
        .I2(reset_time_out_reg_n_0),
        .I3(tx_state[1]),
        .O(\FSM_sequential_tx_state[2]_i_2__0_n_0 ));
  LUT5 #(
    .INIT(32'h00A00B00)) 
    \FSM_sequential_tx_state[3]_i_2__0 
       (.I0(\FSM_sequential_tx_state[3]_i_6__0_n_0 ),
        .I1(time_out_wait_bypass_s3),
        .I2(tx_state[2]),
        .I3(tx_state[3]),
        .I4(tx_state[1]),
        .O(\FSM_sequential_tx_state[3]_i_2__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \FSM_sequential_tx_state[3]_i_4__0 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(\wait_time_cnt[6]_i_4__0_n_0 ),
        .I3(wait_time_cnt_reg__0[6]),
        .O(wait_time_done));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_tx_state[3]_i_5__0 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .O(\FSM_sequential_tx_state[3]_i_5__0_n_0 ));
  LUT3 #(
    .INIT(8'h8A)) 
    \FSM_sequential_tx_state[3]_i_6__0 
       (.I0(tx_state[0]),
        .I1(reset_time_out_reg_n_0),
        .I2(time_out_500us_reg_n_0),
        .O(\FSM_sequential_tx_state[3]_i_6__0_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[0]_i_1__0_n_0 ),
        .Q(tx_state[0]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[1]_i_1__0_n_0 ),
        .Q(tx_state[1]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[2]_i_1__0_n_0 ),
        .Q(tx_state[2]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[3]_i_2__0_n_0 ),
        .Q(tx_state[3]),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFF70004)) 
    MMCM_RESET_i_1__0
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state[3]),
        .I3(tx_state[1]),
        .I4(GT1_TX_MMCM_RESET_OUT),
        .O(MMCM_RESET_i_1__0_n_0));
  FDRE #(
    .INIT(1'b1)) 
    MMCM_RESET_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(MMCM_RESET_i_1__0_n_0),
        .Q(GT1_TX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFB4000)) 
    TXUSERRDY_i_1__0
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .I3(tx_state[2]),
        .I4(gt1_txuserrdy_in),
        .O(TXUSERRDY_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    TXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(TXUSERRDY_i_1__0_n_0),
        .Q(gt1_txuserrdy_in),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFD0004)) 
    gttxreset_i_i_1__0
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state[3]),
        .I3(tx_state[1]),
        .I4(gt1_gttxreset_in),
        .O(gttxreset_i_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    gttxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gttxreset_i_i_1__0_n_0),
        .Q(gt1_gttxreset_in),
        .R(SOFT_RESET_IN));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \init_wait_count[0]_i_1__0 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \init_wait_count[1]_i_1__0 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \init_wait_count[2]_i_1__0 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \init_wait_count[3]_i_1__0 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \init_wait_count[4]_i_1__0 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \init_wait_count[5]_i_1__0 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
    \init_wait_count[6]_i_1__0 
       (.I0(\init_wait_count[6]_i_3__0_n_0 ),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_count));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT5 #(
    .INIT(32'h9AAAAAAA)) 
    \init_wait_count[6]_i_2__0 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\init_wait_count[6]_i_4__0_n_0 ),
        .I2(init_wait_count_reg__0[4]),
        .I3(init_wait_count_reg__0[3]),
        .I4(init_wait_count_reg__0[5]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \init_wait_count[6]_i_3__0 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(\init_wait_count[6]_i_3__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \init_wait_count[6]_i_4__0 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(\init_wait_count[6]_i_4__0_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[0]),
        .Q(init_wait_count_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
  LUT2 #(
    .INIT(4'hE)) 
    init_wait_done_i_1__0
       (.I0(init_wait_done),
        .I1(init_wait_done_reg_n_0),
        .O(init_wait_done_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    init_wait_done_i_2__0
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\init_wait_count[6]_i_3__0_n_0 ),
        .O(init_wait_done));
  FDCE #(
    .INIT(1'b0)) 
    init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(init_wait_done_i_1__0_n_0),
        .Q(init_wait_done_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[0]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \mmcm_lock_count[1]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \mmcm_lock_count[2]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \mmcm_lock_count[3]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[4]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[2]),
        .I4(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \mmcm_lock_count[5]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \mmcm_lock_count[6]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__0_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__0[6]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \mmcm_lock_count[7]_i_2__0 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__0_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(\mmcm_lock_count[7]_i_2__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[7]_i_3__0 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(mmcm_lock_count_reg__0[5]),
        .I2(\mmcm_lock_count[7]_i_4__0_n_0 ),
        .I3(mmcm_lock_count_reg__0[4]),
        .I4(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \mmcm_lock_count[7]_i_4__0 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .O(\mmcm_lock_count[7]_i_4__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__0_n_0 ),
        .D(p_0_in__0[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__0_n_0 ),
        .D(p_0_in__0[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__0_n_0 ),
        .D(p_0_in__0[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__0_n_0 ),
        .D(p_0_in__0[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__0_n_0 ),
        .D(p_0_in__0[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__0_n_0 ),
        .D(p_0_in__0[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__0_n_0 ),
        .D(p_0_in__0[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__0_n_0 ),
        .D(p_0_in__0[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(sync_mmcm_lock_reclocked_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    mmcm_lock_reclocked_i_2__0
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(mmcm_lock_reclocked_i_2__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_mmcm_lock_reclocked_n_1),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hEF00FF10)) 
    pll_reset_asserted_i_1__0
       (.I0(tx_state[3]),
        .I1(tx_state[2]),
        .I2(tx_state[0]),
        .I3(pll_reset_asserted_reg_n_0),
        .I4(tx_state[1]),
        .O(pll_reset_asserted_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    pll_reset_asserted_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(pll_reset_asserted_i_1__0_n_0),
        .Q(pll_reset_asserted_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT3 #(
    .INIT(8'h2A)) 
    reset_time_out_i_3__0
       (.I0(tx_state[0]),
        .I1(tx_state[3]),
        .I2(tx_state[2]),
        .O(reset_time_out_i_3__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_QPLLLOCK_n_0),
        .Q(reset_time_out_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFB0002)) 
    run_phase_alignment_int_i_1__0
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[2]),
        .I3(tx_state[1]),
        .I4(run_phase_alignment_int_reg_n_0),
        .O(run_phase_alignment_int_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(run_phase_alignment_int_i_1__0_n_0),
        .Q(run_phase_alignment_int_reg_n_0),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_s3_reg
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(data_out),
        .Q(run_phase_alignment_int_s3_reg_n_0),
        .R(1'b0));
  XLAUI_XLAUI_sync_block_35 sync_QPLLLOCK
       (.E(sync_QPLLLOCK_n_1),
        .\FSM_sequential_tx_state_reg[0] (reset_time_out_i_3__0_n_0),
        .\FSM_sequential_tx_state_reg[1] (\FSM_sequential_tx_state[3]_i_5__0_n_0 ),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .init_wait_done_reg(init_wait_done_reg_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(tx_state),
        .pll_reset_asserted_reg(pll_reset_asserted_reg_n_0),
        .reset_time_out_reg(sync_QPLLLOCK_n_0),
        .reset_time_out_reg_0(reset_time_out_reg_n_0),
        .time_out_2ms_reg(time_out_2ms_reg_n_0),
        .time_out_500us_reg(time_out_500us_reg_n_0),
        .time_tlock_max_reg(time_tlock_max_reg_n_0),
        .txresetdone_s3(txresetdone_s3),
        .wait_time_done(wait_time_done));
  XLAUI_XLAUI_sync_block_36 sync_TXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(txresetdone_s2),
        .gt1_txresetdone_out(gt1_txresetdone_out));
  XLAUI_XLAUI_sync_block_37 sync_mmcm_lock_reclocked
       (.GT1_TX_MMCM_LOCK_IN(GT1_TX_MMCM_LOCK_IN),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(sync_mmcm_lock_reclocked_n_0),
        .SYSCLK_IN(SYSCLK_IN),
        .\mmcm_lock_count_reg[5] (mmcm_lock_reclocked_i_2__0_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_lock_reclocked_reg(sync_mmcm_lock_reclocked_n_1));
  XLAUI_XLAUI_sync_block_38 sync_run_phase_alignment_int
       (.data_in(run_phase_alignment_int_reg_n_0),
        .data_out(data_out),
        .gt1_txusrclk_in(gt1_txusrclk_in));
  XLAUI_XLAUI_sync_block_39 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(time_out_wait_bypass_reg_n_0),
        .data_out(time_out_wait_bypass_s2));
  XLAUI_XLAUI_sync_block_40 sync_tx_fsm_reset_done_int
       (.GT1_TX_FSM_RESET_DONE_OUT(GT1_TX_FSM_RESET_DONE_OUT),
        .data_out(tx_fsm_reset_done_int_s2),
        .gt1_txusrclk_in(gt1_txusrclk_in));
  LUT3 #(
    .INIT(8'h0E)) 
    time_out_2ms_i_1__4
       (.I0(time_out_2ms_reg_n_0),
        .I1(time_out_2ms),
        .I2(reset_time_out_reg_n_0),
        .O(time_out_2ms_i_1__4_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_2ms_i_1__4_n_0),
        .Q(time_out_2ms_reg_n_0),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h00AE)) 
    time_out_500us_i_1__4
       (.I0(time_out_500us_reg_n_0),
        .I1(time_out_500us_i_2__0_n_0),
        .I2(time_out_500us_i_3__0_n_0),
        .I3(reset_time_out_reg_n_0),
        .O(time_out_500us_i_1__4_n_0));
  LUT5 #(
    .INIT(32'h00000100)) 
    time_out_500us_i_2__0
       (.I0(\time_out_counter[0]_i_8__3_n_0 ),
        .I1(time_out_counter_reg[4]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[14]),
        .I4(time_out_counter_reg[9]),
        .O(time_out_500us_i_2__0_n_0));
  LUT5 #(
    .INIT(32'hFFFFBFFF)) 
    time_out_500us_i_3__0
       (.I0(time_tlock_max_i_5__0_n_0),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[7]),
        .I3(time_out_counter_reg[0]),
        .I4(\time_out_counter[0]_i_12__0_n_0 ),
        .O(time_out_500us_i_3__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_500us_i_1__4_n_0),
        .Q(time_out_500us_reg_n_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \time_out_counter[0]_i_10__0 
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[18]),
        .O(\time_out_counter[0]_i_10__0_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \time_out_counter[0]_i_11__0 
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[12]),
        .I3(time_out_counter_reg[14]),
        .O(\time_out_counter[0]_i_11__0_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \time_out_counter[0]_i_12__0 
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[5]),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_counter_reg[1]),
        .O(\time_out_counter[0]_i_12__0_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_1__4 
       (.I0(time_out_2ms),
        .O(time_out_counter));
  LUT5 #(
    .INIT(32'h00000004)) 
    \time_out_counter[0]_i_3__0 
       (.I0(\time_out_counter[0]_i_8__3_n_0 ),
        .I1(\time_out_counter[0]_i_9__1_n_0 ),
        .I2(\time_out_counter[0]_i_10__0_n_0 ),
        .I3(\time_out_counter[0]_i_11__0_n_0 ),
        .I4(\time_out_counter[0]_i_12__0_n_0 ),
        .O(time_out_2ms));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_7__0 
       (.I0(time_out_counter_reg[0]),
        .O(\time_out_counter[0]_i_7__0_n_0 ));
  LUT4 #(
    .INIT(16'hDFFF)) 
    \time_out_counter[0]_i_8__3 
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[16]),
        .O(\time_out_counter[0]_i_8__3_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \time_out_counter[0]_i_9__1 
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[11]),
        .O(\time_out_counter[0]_i_9__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__0_n_7 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[0]_i_2__0 
       (.CI(1'b0),
        .CO({\time_out_counter_reg[0]_i_2__0_n_0 ,\time_out_counter_reg[0]_i_2__0_n_1 ,\time_out_counter_reg[0]_i_2__0_n_2 ,\time_out_counter_reg[0]_i_2__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\time_out_counter_reg[0]_i_2__0_n_4 ,\time_out_counter_reg[0]_i_2__0_n_5 ,\time_out_counter_reg[0]_i_2__0_n_6 ,\time_out_counter_reg[0]_i_2__0_n_7 }),
        .S({time_out_counter_reg[3:1],\time_out_counter[0]_i_7__0_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__0_n_5 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__0_n_4 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__0_n_7 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[12]_i_1__0 
       (.CI(\time_out_counter_reg[8]_i_1__0_n_0 ),
        .CO({\time_out_counter_reg[12]_i_1__0_n_0 ,\time_out_counter_reg[12]_i_1__0_n_1 ,\time_out_counter_reg[12]_i_1__0_n_2 ,\time_out_counter_reg[12]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[12]_i_1__0_n_4 ,\time_out_counter_reg[12]_i_1__0_n_5 ,\time_out_counter_reg[12]_i_1__0_n_6 ,\time_out_counter_reg[12]_i_1__0_n_7 }),
        .S(time_out_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__0_n_6 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__0_n_5 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__0_n_4 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__0_n_7 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[16]_i_1__0 
       (.CI(\time_out_counter_reg[12]_i_1__0_n_0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__0_CO_UNCONNECTED [3:2],\time_out_counter_reg[16]_i_1__0_n_2 ,\time_out_counter_reg[16]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__0_O_UNCONNECTED [3],\time_out_counter_reg[16]_i_1__0_n_5 ,\time_out_counter_reg[16]_i_1__0_n_6 ,\time_out_counter_reg[16]_i_1__0_n_7 }),
        .S({1'b0,time_out_counter_reg[18:16]}));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__0_n_6 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__0_n_5 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__0_n_6 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__0_n_5 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__0_n_4 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__0_n_7 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[4]_i_1__0 
       (.CI(\time_out_counter_reg[0]_i_2__0_n_0 ),
        .CO({\time_out_counter_reg[4]_i_1__0_n_0 ,\time_out_counter_reg[4]_i_1__0_n_1 ,\time_out_counter_reg[4]_i_1__0_n_2 ,\time_out_counter_reg[4]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[4]_i_1__0_n_4 ,\time_out_counter_reg[4]_i_1__0_n_5 ,\time_out_counter_reg[4]_i_1__0_n_6 ,\time_out_counter_reg[4]_i_1__0_n_7 }),
        .S(time_out_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__0_n_6 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__0_n_5 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__0_n_4 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__0_n_7 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[8]_i_1__0 
       (.CI(\time_out_counter_reg[4]_i_1__0_n_0 ),
        .CO({\time_out_counter_reg[8]_i_1__0_n_0 ,\time_out_counter_reg[8]_i_1__0_n_1 ,\time_out_counter_reg[8]_i_1__0_n_2 ,\time_out_counter_reg[8]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[8]_i_1__0_n_4 ,\time_out_counter_reg[8]_i_1__0_n_5 ,\time_out_counter_reg[8]_i_1__0_n_6 ,\time_out_counter_reg[8]_i_1__0_n_7 }),
        .S(time_out_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__0_n_6 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out_reg_n_0));
  LUT4 #(
    .INIT(16'hAB00)) 
    time_out_wait_bypass_i_1__0
       (.I0(time_out_wait_bypass_reg_n_0),
        .I1(\wait_bypass_count[0]_i_4__0_n_0 ),
        .I2(tx_fsm_reset_done_int_s3_reg_n_0),
        .I3(run_phase_alignment_int_s3_reg_n_0),
        .O(time_out_wait_bypass_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_reg
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(time_out_wait_bypass_i_1__0_n_0),
        .Q(time_out_wait_bypass_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT4 #(
    .INIT(16'h00AE)) 
    time_tlock_max_i_1__4
       (.I0(time_tlock_max_reg_n_0),
        .I1(time_tlock_max_i_2__0_n_0),
        .I2(time_tlock_max_i_3__0_n_0),
        .I3(reset_time_out_reg_n_0),
        .O(time_tlock_max_i_1__4_n_0));
  LUT5 #(
    .INIT(32'h00000010)) 
    time_tlock_max_i_2__0
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[9]),
        .I4(time_tlock_max_i_4__0_n_0),
        .O(time_tlock_max_i_2__0_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFEF)) 
    time_tlock_max_i_3__0
       (.I0(time_tlock_max_i_5__0_n_0),
        .I1(time_tlock_max_i_6__0_n_0),
        .I2(time_out_counter_reg[1]),
        .I3(time_out_counter_reg[15]),
        .I4(time_out_counter_reg[2]),
        .O(time_tlock_max_i_3__0_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    time_tlock_max_i_4__0
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[6]),
        .I3(time_out_counter_reg[5]),
        .O(time_tlock_max_i_4__0_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    time_tlock_max_i_5__0
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[18]),
        .I3(time_out_counter_reg[12]),
        .O(time_tlock_max_i_5__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT4 #(
    .INIT(16'hFF7F)) 
    time_tlock_max_i_6__0
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[4]),
        .I3(time_out_counter_reg[10]),
        .O(time_tlock_max_i_6__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_tlock_max_i_1__4_n_0),
        .Q(time_tlock_max_reg_n_0),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFFF0008)) 
    tx_fsm_reset_done_int_i_1__0
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[2]),
        .I3(tx_state[1]),
        .I4(GT1_TX_FSM_RESET_DONE_OUT),
        .O(tx_fsm_reset_done_int_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    tx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_i_1__0_n_0),
        .Q(GT1_TX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    tx_fsm_reset_done_int_s3_reg
       (.C(gt1_txusrclk_in),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_s2),
        .Q(tx_fsm_reset_done_int_s3_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    txresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(txresetdone_s2),
        .Q(txresetdone_s3),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hDFFFFFFF)) 
    \wait_bypass_count[0]_i_10__0 
       (.I0(wait_bypass_count_reg[0]),
        .I1(wait_bypass_count_reg[15]),
        .I2(wait_bypass_count_reg[16]),
        .I3(wait_bypass_count_reg[2]),
        .I4(wait_bypass_count_reg[1]),
        .O(\wait_bypass_count[0]_i_10__0_n_0 ));
  LUT4 #(
    .INIT(16'hFFEF)) 
    \wait_bypass_count[0]_i_11__0 
       (.I0(wait_bypass_count_reg[12]),
        .I1(wait_bypass_count_reg[11]),
        .I2(wait_bypass_count_reg[13]),
        .I3(wait_bypass_count_reg[14]),
        .O(\wait_bypass_count[0]_i_11__0_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \wait_bypass_count[0]_i_12__0 
       (.I0(wait_bypass_count_reg[8]),
        .I1(wait_bypass_count_reg[7]),
        .I2(wait_bypass_count_reg[10]),
        .I3(wait_bypass_count_reg[9]),
        .O(\wait_bypass_count[0]_i_12__0_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_1__0 
       (.I0(run_phase_alignment_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_1__0_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \wait_bypass_count[0]_i_2__0 
       (.I0(\wait_bypass_count[0]_i_4__0_n_0 ),
        .I1(tx_fsm_reset_done_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_2__0_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_bypass_count[0]_i_4__0 
       (.I0(\wait_bypass_count[0]_i_9__0_n_0 ),
        .I1(\wait_bypass_count[0]_i_10__0_n_0 ),
        .I2(\wait_bypass_count[0]_i_11__0_n_0 ),
        .I3(\wait_bypass_count[0]_i_12__0_n_0 ),
        .O(\wait_bypass_count[0]_i_4__0_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_8__0 
       (.I0(wait_bypass_count_reg[0]),
        .O(\wait_bypass_count[0]_i_8__0_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \wait_bypass_count[0]_i_9__0 
       (.I0(wait_bypass_count_reg[4]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[6]),
        .I3(wait_bypass_count_reg[5]),
        .O(\wait_bypass_count[0]_i_9__0_n_0 ));
  FDRE \wait_bypass_count_reg[0] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__0_n_7 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  CARRY4 \wait_bypass_count_reg[0]_i_3__0 
       (.CI(1'b0),
        .CO({\wait_bypass_count_reg[0]_i_3__0_n_0 ,\wait_bypass_count_reg[0]_i_3__0_n_1 ,\wait_bypass_count_reg[0]_i_3__0_n_2 ,\wait_bypass_count_reg[0]_i_3__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\wait_bypass_count_reg[0]_i_3__0_n_4 ,\wait_bypass_count_reg[0]_i_3__0_n_5 ,\wait_bypass_count_reg[0]_i_3__0_n_6 ,\wait_bypass_count_reg[0]_i_3__0_n_7 }),
        .S({wait_bypass_count_reg[3:1],\wait_bypass_count[0]_i_8__0_n_0 }));
  FDRE \wait_bypass_count_reg[10] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__0_n_5 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[11] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__0_n_4 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[12] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__0_n_7 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  CARRY4 \wait_bypass_count_reg[12]_i_1__0 
       (.CI(\wait_bypass_count_reg[8]_i_1__0_n_0 ),
        .CO({\wait_bypass_count_reg[12]_i_1__0_n_0 ,\wait_bypass_count_reg[12]_i_1__0_n_1 ,\wait_bypass_count_reg[12]_i_1__0_n_2 ,\wait_bypass_count_reg[12]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[12]_i_1__0_n_4 ,\wait_bypass_count_reg[12]_i_1__0_n_5 ,\wait_bypass_count_reg[12]_i_1__0_n_6 ,\wait_bypass_count_reg[12]_i_1__0_n_7 }),
        .S(wait_bypass_count_reg[15:12]));
  FDRE \wait_bypass_count_reg[13] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__0_n_6 ),
        .Q(wait_bypass_count_reg[13]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[14] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__0_n_5 ),
        .Q(wait_bypass_count_reg[14]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[15] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__0_n_4 ),
        .Q(wait_bypass_count_reg[15]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[16] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[16]_i_1__0_n_7 ),
        .Q(wait_bypass_count_reg[16]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  CARRY4 \wait_bypass_count_reg[16]_i_1__0 
       (.CI(\wait_bypass_count_reg[12]_i_1__0_n_0 ),
        .CO(\NLW_wait_bypass_count_reg[16]_i_1__0_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[16]_i_1__0_O_UNCONNECTED [3:1],\wait_bypass_count_reg[16]_i_1__0_n_7 }),
        .S({1'b0,1'b0,1'b0,wait_bypass_count_reg[16]}));
  FDRE \wait_bypass_count_reg[1] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__0_n_6 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[2] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__0_n_5 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[3] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__0_n_4 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[4] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__0_n_7 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  CARRY4 \wait_bypass_count_reg[4]_i_1__0 
       (.CI(\wait_bypass_count_reg[0]_i_3__0_n_0 ),
        .CO({\wait_bypass_count_reg[4]_i_1__0_n_0 ,\wait_bypass_count_reg[4]_i_1__0_n_1 ,\wait_bypass_count_reg[4]_i_1__0_n_2 ,\wait_bypass_count_reg[4]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[4]_i_1__0_n_4 ,\wait_bypass_count_reg[4]_i_1__0_n_5 ,\wait_bypass_count_reg[4]_i_1__0_n_6 ,\wait_bypass_count_reg[4]_i_1__0_n_7 }),
        .S(wait_bypass_count_reg[7:4]));
  FDRE \wait_bypass_count_reg[5] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__0_n_6 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[6] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__0_n_5 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[7] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__0_n_4 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  FDRE \wait_bypass_count_reg[8] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__0_n_7 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  CARRY4 \wait_bypass_count_reg[8]_i_1__0 
       (.CI(\wait_bypass_count_reg[4]_i_1__0_n_0 ),
        .CO({\wait_bypass_count_reg[8]_i_1__0_n_0 ,\wait_bypass_count_reg[8]_i_1__0_n_1 ,\wait_bypass_count_reg[8]_i_1__0_n_2 ,\wait_bypass_count_reg[8]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[8]_i_1__0_n_4 ,\wait_bypass_count_reg[8]_i_1__0_n_5 ,\wait_bypass_count_reg[8]_i_1__0_n_6 ,\wait_bypass_count_reg[8]_i_1__0_n_7 }),
        .S(wait_bypass_count_reg[11:8]));
  FDRE \wait_bypass_count_reg[9] 
       (.C(gt1_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__0_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__0_n_6 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\wait_bypass_count[0]_i_1__0_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_time_cnt[0]_i_1__0 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \wait_time_cnt[1]_i_1__0 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\wait_time_cnt[1]_i_1__0_n_0 ));
  LUT3 #(
    .INIT(8'hE1)) 
    \wait_time_cnt[2]_i_1__0 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[2]),
        .O(wait_time_cnt0[2]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \wait_time_cnt[3]_i_1__0 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0[3]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \wait_time_cnt[4]_i_1__0 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\wait_time_cnt[4]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
    \wait_time_cnt[5]_i_1__0 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[5]));
  LUT4 #(
    .INIT(16'h1030)) 
    \wait_time_cnt[6]_i_1__0 
       (.I0(tx_state[2]),
        .I1(tx_state[3]),
        .I2(tx_state[0]),
        .I3(tx_state[1]),
        .O(\wait_time_cnt[6]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_2__0 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\wait_time_cnt[6]_i_4__0_n_0 ),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(wait_time_cnt_reg__0[5]),
        .O(\wait_time_cnt[6]_i_2__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \wait_time_cnt[6]_i_3__0 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(\wait_time_cnt[6]_i_4__0_n_0 ),
        .O(wait_time_cnt0[6]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_4__0 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .O(\wait_time_cnt[6]_i_4__0_n_0 ));
  FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__0_n_0 ),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\wait_time_cnt[6]_i_1__0_n_0 ));
  FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__0_n_0 ),
        .D(\wait_time_cnt[1]_i_1__0_n_0 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\wait_time_cnt[6]_i_1__0_n_0 ));
  FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__0_n_0 ),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\wait_time_cnt[6]_i_1__0_n_0 ));
  FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__0_n_0 ),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\wait_time_cnt[6]_i_1__0_n_0 ));
  FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__0_n_0 ),
        .D(\wait_time_cnt[4]_i_1__0_n_0 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\wait_time_cnt[6]_i_1__0_n_0 ));
  FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__0_n_0 ),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\wait_time_cnt[6]_i_1__0_n_0 ));
  FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__0_n_0 ),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\wait_time_cnt[6]_i_1__0_n_0 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_TX_STARTUP_FSM" *) 
module XLAUI_XLAUI_TX_STARTUP_FSM_3
   (gt2_gttxreset_in,
    GT2_TX_MMCM_RESET_OUT,
    GT2_TX_FSM_RESET_DONE_OUT,
    gt2_txuserrdy_in,
    SYSCLK_IN,
    gt2_txusrclk_in,
    SOFT_RESET_IN,
    gt2_txresetdone_out,
    GT2_TX_MMCM_LOCK_IN,
    GT0_QPLLLOCK_IN);
  output gt2_gttxreset_in;
  output GT2_TX_MMCM_RESET_OUT;
  output GT2_TX_FSM_RESET_DONE_OUT;
  output gt2_txuserrdy_in;
  input SYSCLK_IN;
  input gt2_txusrclk_in;
  input SOFT_RESET_IN;
  input gt2_txresetdone_out;
  input GT2_TX_MMCM_LOCK_IN;
  input GT0_QPLLLOCK_IN;

  wire \FSM_sequential_tx_state[0]_i_1__1_n_0 ;
  wire \FSM_sequential_tx_state[0]_i_2__1_n_0 ;
  wire \FSM_sequential_tx_state[1]_i_1__1_n_0 ;
  wire \FSM_sequential_tx_state[2]_i_1__1_n_0 ;
  wire \FSM_sequential_tx_state[2]_i_2__1_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_2__1_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_5__1_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_6__1_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire GT2_TX_FSM_RESET_DONE_OUT;
  wire GT2_TX_MMCM_LOCK_IN;
  wire GT2_TX_MMCM_RESET_OUT;
  wire MMCM_RESET_i_1__1_n_0;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire TXUSERRDY_i_1__1_n_0;
  wire data_out;
  wire gt2_gttxreset_in;
  wire gt2_txresetdone_out;
  wire gt2_txuserrdy_in;
  wire gt2_txusrclk_in;
  wire gttxreset_i_i_1__1_n_0;
  wire init_wait_count;
  wire \init_wait_count[6]_i_3__1_n_0 ;
  wire \init_wait_count[6]_i_4__1_n_0 ;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire init_wait_done_i_1__1_n_0;
  wire init_wait_done_reg_n_0;
  wire \mmcm_lock_count[7]_i_2__1_n_0 ;
  wire \mmcm_lock_count[7]_i_4__1_n_0 ;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_i_2__1_n_0;
  wire [6:0]p_0_in;
  wire [7:0]p_0_in__0;
  wire pll_reset_asserted_i_1__1_n_0;
  wire pll_reset_asserted_reg_n_0;
  wire reset_time_out_i_3__1_n_0;
  wire reset_time_out_reg_n_0;
  wire run_phase_alignment_int_i_1__1_n_0;
  wire run_phase_alignment_int_reg_n_0;
  wire run_phase_alignment_int_s3_reg_n_0;
  wire sync_QPLLLOCK_n_0;
  wire sync_QPLLLOCK_n_1;
  wire sync_mmcm_lock_reclocked_n_0;
  wire sync_mmcm_lock_reclocked_n_1;
  wire time_out_2ms;
  wire time_out_2ms_i_1__5_n_0;
  wire time_out_2ms_reg_n_0;
  wire time_out_500us_i_1__5_n_0;
  wire time_out_500us_i_2__1_n_0;
  wire time_out_500us_i_3__1_n_0;
  wire time_out_500us_i_4__3_n_0;
  wire time_out_500us_reg_n_0;
  wire time_out_counter;
  wire \time_out_counter[0]_i_10__1_n_0 ;
  wire \time_out_counter[0]_i_11__1_n_0 ;
  wire \time_out_counter[0]_i_12__1_n_0 ;
  wire \time_out_counter[0]_i_7__1_n_0 ;
  wire \time_out_counter[0]_i_8__4_n_0 ;
  wire \time_out_counter[0]_i_9__2_n_0 ;
  wire [18:0]time_out_counter_reg;
  wire \time_out_counter_reg[0]_i_2__1_n_0 ;
  wire \time_out_counter_reg[0]_i_2__1_n_1 ;
  wire \time_out_counter_reg[0]_i_2__1_n_2 ;
  wire \time_out_counter_reg[0]_i_2__1_n_3 ;
  wire \time_out_counter_reg[0]_i_2__1_n_4 ;
  wire \time_out_counter_reg[0]_i_2__1_n_5 ;
  wire \time_out_counter_reg[0]_i_2__1_n_6 ;
  wire \time_out_counter_reg[0]_i_2__1_n_7 ;
  wire \time_out_counter_reg[12]_i_1__1_n_0 ;
  wire \time_out_counter_reg[12]_i_1__1_n_1 ;
  wire \time_out_counter_reg[12]_i_1__1_n_2 ;
  wire \time_out_counter_reg[12]_i_1__1_n_3 ;
  wire \time_out_counter_reg[12]_i_1__1_n_4 ;
  wire \time_out_counter_reg[12]_i_1__1_n_5 ;
  wire \time_out_counter_reg[12]_i_1__1_n_6 ;
  wire \time_out_counter_reg[12]_i_1__1_n_7 ;
  wire \time_out_counter_reg[16]_i_1__1_n_2 ;
  wire \time_out_counter_reg[16]_i_1__1_n_3 ;
  wire \time_out_counter_reg[16]_i_1__1_n_5 ;
  wire \time_out_counter_reg[16]_i_1__1_n_6 ;
  wire \time_out_counter_reg[16]_i_1__1_n_7 ;
  wire \time_out_counter_reg[4]_i_1__1_n_0 ;
  wire \time_out_counter_reg[4]_i_1__1_n_1 ;
  wire \time_out_counter_reg[4]_i_1__1_n_2 ;
  wire \time_out_counter_reg[4]_i_1__1_n_3 ;
  wire \time_out_counter_reg[4]_i_1__1_n_4 ;
  wire \time_out_counter_reg[4]_i_1__1_n_5 ;
  wire \time_out_counter_reg[4]_i_1__1_n_6 ;
  wire \time_out_counter_reg[4]_i_1__1_n_7 ;
  wire \time_out_counter_reg[8]_i_1__1_n_0 ;
  wire \time_out_counter_reg[8]_i_1__1_n_1 ;
  wire \time_out_counter_reg[8]_i_1__1_n_2 ;
  wire \time_out_counter_reg[8]_i_1__1_n_3 ;
  wire \time_out_counter_reg[8]_i_1__1_n_4 ;
  wire \time_out_counter_reg[8]_i_1__1_n_5 ;
  wire \time_out_counter_reg[8]_i_1__1_n_6 ;
  wire \time_out_counter_reg[8]_i_1__1_n_7 ;
  wire time_out_wait_bypass_i_1__1_n_0;
  wire time_out_wait_bypass_reg_n_0;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max_i_1__5_n_0;
  wire time_tlock_max_i_2__1_n_0;
  wire time_tlock_max_i_3__1_n_0;
  wire time_tlock_max_i_4__1_n_0;
  wire time_tlock_max_i_5__1_n_0;
  wire time_tlock_max_i_6__1_n_0;
  wire time_tlock_max_reg_n_0;
  wire tx_fsm_reset_done_int_i_1__1_n_0;
  wire tx_fsm_reset_done_int_s2;
  wire tx_fsm_reset_done_int_s3_reg_n_0;
  (* RTL_KEEP = "yes" *) wire [3:0]tx_state;
  wire tx_state13_out;
  wire txresetdone_s2;
  wire txresetdone_s3;
  wire \wait_bypass_count[0]_i_10__1_n_0 ;
  wire \wait_bypass_count[0]_i_11__1_n_0 ;
  wire \wait_bypass_count[0]_i_12__1_n_0 ;
  wire \wait_bypass_count[0]_i_1__1_n_0 ;
  wire \wait_bypass_count[0]_i_2__1_n_0 ;
  wire \wait_bypass_count[0]_i_4__1_n_0 ;
  wire \wait_bypass_count[0]_i_8__1_n_0 ;
  wire \wait_bypass_count[0]_i_9__1_n_0 ;
  wire [16:0]wait_bypass_count_reg;
  wire \wait_bypass_count_reg[0]_i_3__1_n_0 ;
  wire \wait_bypass_count_reg[0]_i_3__1_n_1 ;
  wire \wait_bypass_count_reg[0]_i_3__1_n_2 ;
  wire \wait_bypass_count_reg[0]_i_3__1_n_3 ;
  wire \wait_bypass_count_reg[0]_i_3__1_n_4 ;
  wire \wait_bypass_count_reg[0]_i_3__1_n_5 ;
  wire \wait_bypass_count_reg[0]_i_3__1_n_6 ;
  wire \wait_bypass_count_reg[0]_i_3__1_n_7 ;
  wire \wait_bypass_count_reg[12]_i_1__1_n_0 ;
  wire \wait_bypass_count_reg[12]_i_1__1_n_1 ;
  wire \wait_bypass_count_reg[12]_i_1__1_n_2 ;
  wire \wait_bypass_count_reg[12]_i_1__1_n_3 ;
  wire \wait_bypass_count_reg[12]_i_1__1_n_4 ;
  wire \wait_bypass_count_reg[12]_i_1__1_n_5 ;
  wire \wait_bypass_count_reg[12]_i_1__1_n_6 ;
  wire \wait_bypass_count_reg[12]_i_1__1_n_7 ;
  wire \wait_bypass_count_reg[16]_i_1__1_n_7 ;
  wire \wait_bypass_count_reg[4]_i_1__1_n_0 ;
  wire \wait_bypass_count_reg[4]_i_1__1_n_1 ;
  wire \wait_bypass_count_reg[4]_i_1__1_n_2 ;
  wire \wait_bypass_count_reg[4]_i_1__1_n_3 ;
  wire \wait_bypass_count_reg[4]_i_1__1_n_4 ;
  wire \wait_bypass_count_reg[4]_i_1__1_n_5 ;
  wire \wait_bypass_count_reg[4]_i_1__1_n_6 ;
  wire \wait_bypass_count_reg[4]_i_1__1_n_7 ;
  wire \wait_bypass_count_reg[8]_i_1__1_n_0 ;
  wire \wait_bypass_count_reg[8]_i_1__1_n_1 ;
  wire \wait_bypass_count_reg[8]_i_1__1_n_2 ;
  wire \wait_bypass_count_reg[8]_i_1__1_n_3 ;
  wire \wait_bypass_count_reg[8]_i_1__1_n_4 ;
  wire \wait_bypass_count_reg[8]_i_1__1_n_5 ;
  wire \wait_bypass_count_reg[8]_i_1__1_n_6 ;
  wire \wait_bypass_count_reg[8]_i_1__1_n_7 ;
  wire [6:0]wait_time_cnt0;
  wire \wait_time_cnt[1]_i_1__1_n_0 ;
  wire \wait_time_cnt[4]_i_1__1_n_0 ;
  wire \wait_time_cnt[6]_i_1__1_n_0 ;
  wire \wait_time_cnt[6]_i_2__1_n_0 ;
  wire \wait_time_cnt[6]_i_4__1_n_0 ;
  wire [6:0]wait_time_cnt_reg__0;
  wire wait_time_done;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__1_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__1_O_UNCONNECTED ;
  wire [3:0]\NLW_wait_bypass_count_reg[16]_i_1__1_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[16]_i_1__1_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h2222220222220A0A)) 
    \FSM_sequential_tx_state[0]_i_1__1 
       (.I0(\FSM_sequential_tx_state[0]_i_2__1_n_0 ),
        .I1(tx_state[3]),
        .I2(tx_state[0]),
        .I3(time_out_2ms_reg_n_0),
        .I4(tx_state[2]),
        .I5(tx_state[1]),
        .O(\FSM_sequential_tx_state[0]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h3B33BBBBBBBBBBBB)) 
    \FSM_sequential_tx_state[0]_i_2__1 
       (.I0(\FSM_sequential_tx_state[2]_i_2__1_n_0 ),
        .I1(tx_state[0]),
        .I2(reset_time_out_reg_n_0),
        .I3(time_out_500us_reg_n_0),
        .I4(tx_state[1]),
        .I5(tx_state[2]),
        .O(\FSM_sequential_tx_state[0]_i_2__1_n_0 ));
  LUT5 #(
    .INIT(32'h11110444)) 
    \FSM_sequential_tx_state[1]_i_1__1 
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state13_out),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .O(\FSM_sequential_tx_state[1]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \FSM_sequential_tx_state[1]_i_2__1 
       (.I0(reset_time_out_reg_n_0),
        .I1(time_tlock_max_reg_n_0),
        .I2(mmcm_lock_reclocked),
        .O(tx_state13_out));
  LUT6 #(
    .INIT(64'h1111004055550040)) 
    \FSM_sequential_tx_state[2]_i_1__1 
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .I3(time_out_2ms_reg_n_0),
        .I4(tx_state[2]),
        .I5(\FSM_sequential_tx_state[2]_i_2__1_n_0 ),
        .O(\FSM_sequential_tx_state[2]_i_1__1_n_0 ));
  LUT4 #(
    .INIT(16'hFF04)) 
    \FSM_sequential_tx_state[2]_i_2__1 
       (.I0(mmcm_lock_reclocked),
        .I1(time_tlock_max_reg_n_0),
        .I2(reset_time_out_reg_n_0),
        .I3(tx_state[1]),
        .O(\FSM_sequential_tx_state[2]_i_2__1_n_0 ));
  LUT5 #(
    .INIT(32'h00A00B00)) 
    \FSM_sequential_tx_state[3]_i_2__1 
       (.I0(\FSM_sequential_tx_state[3]_i_6__1_n_0 ),
        .I1(time_out_wait_bypass_s3),
        .I2(tx_state[2]),
        .I3(tx_state[3]),
        .I4(tx_state[1]),
        .O(\FSM_sequential_tx_state[3]_i_2__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \FSM_sequential_tx_state[3]_i_4__1 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(\wait_time_cnt[6]_i_4__1_n_0 ),
        .I3(wait_time_cnt_reg__0[6]),
        .O(wait_time_done));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_tx_state[3]_i_5__1 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .O(\FSM_sequential_tx_state[3]_i_5__1_n_0 ));
  LUT3 #(
    .INIT(8'h8A)) 
    \FSM_sequential_tx_state[3]_i_6__1 
       (.I0(tx_state[0]),
        .I1(reset_time_out_reg_n_0),
        .I2(time_out_500us_reg_n_0),
        .O(\FSM_sequential_tx_state[3]_i_6__1_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[0]_i_1__1_n_0 ),
        .Q(tx_state[0]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[1]_i_1__1_n_0 ),
        .Q(tx_state[1]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[2]_i_1__1_n_0 ),
        .Q(tx_state[2]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[3]_i_2__1_n_0 ),
        .Q(tx_state[3]),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFF70004)) 
    MMCM_RESET_i_1__1
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state[3]),
        .I3(tx_state[1]),
        .I4(GT2_TX_MMCM_RESET_OUT),
        .O(MMCM_RESET_i_1__1_n_0));
  FDRE #(
    .INIT(1'b1)) 
    MMCM_RESET_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(MMCM_RESET_i_1__1_n_0),
        .Q(GT2_TX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFB4000)) 
    TXUSERRDY_i_1__1
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .I3(tx_state[2]),
        .I4(gt2_txuserrdy_in),
        .O(TXUSERRDY_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    TXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(TXUSERRDY_i_1__1_n_0),
        .Q(gt2_txuserrdy_in),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFD0004)) 
    gttxreset_i_i_1__1
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state[3]),
        .I3(tx_state[1]),
        .I4(gt2_gttxreset_in),
        .O(gttxreset_i_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    gttxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gttxreset_i_i_1__1_n_0),
        .Q(gt2_gttxreset_in),
        .R(SOFT_RESET_IN));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \init_wait_count[0]_i_1__1 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \init_wait_count[1]_i_1__1 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \init_wait_count[2]_i_1__1 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \init_wait_count[3]_i_1__1 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \init_wait_count[4]_i_1__1 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \init_wait_count[5]_i_1__1 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
    \init_wait_count[6]_i_1__1 
       (.I0(\init_wait_count[6]_i_3__1_n_0 ),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_count));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT5 #(
    .INIT(32'h9AAAAAAA)) 
    \init_wait_count[6]_i_2__1 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\init_wait_count[6]_i_4__1_n_0 ),
        .I2(init_wait_count_reg__0[4]),
        .I3(init_wait_count_reg__0[3]),
        .I4(init_wait_count_reg__0[5]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \init_wait_count[6]_i_3__1 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(\init_wait_count[6]_i_3__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \init_wait_count[6]_i_4__1 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(\init_wait_count[6]_i_4__1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[0]),
        .Q(init_wait_count_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
  LUT2 #(
    .INIT(4'hE)) 
    init_wait_done_i_1__1
       (.I0(init_wait_done),
        .I1(init_wait_done_reg_n_0),
        .O(init_wait_done_i_1__1_n_0));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    init_wait_done_i_2__1
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\init_wait_count[6]_i_3__1_n_0 ),
        .O(init_wait_done));
  FDCE #(
    .INIT(1'b0)) 
    init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(init_wait_done_i_1__1_n_0),
        .Q(init_wait_done_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[0]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \mmcm_lock_count[1]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \mmcm_lock_count[2]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \mmcm_lock_count[3]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[4]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[2]),
        .I4(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \mmcm_lock_count[5]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \mmcm_lock_count[6]_i_1__1 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__1_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__0[6]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \mmcm_lock_count[7]_i_2__1 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__1_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(\mmcm_lock_count[7]_i_2__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[7]_i_3__1 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(mmcm_lock_count_reg__0[5]),
        .I2(\mmcm_lock_count[7]_i_4__1_n_0 ),
        .I3(mmcm_lock_count_reg__0[4]),
        .I4(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \mmcm_lock_count[7]_i_4__1 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .O(\mmcm_lock_count[7]_i_4__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__1_n_0 ),
        .D(p_0_in__0[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__1_n_0 ),
        .D(p_0_in__0[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__1_n_0 ),
        .D(p_0_in__0[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__1_n_0 ),
        .D(p_0_in__0[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__1_n_0 ),
        .D(p_0_in__0[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__1_n_0 ),
        .D(p_0_in__0[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__1_n_0 ),
        .D(p_0_in__0[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__1_n_0 ),
        .D(p_0_in__0[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(sync_mmcm_lock_reclocked_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    mmcm_lock_reclocked_i_2__1
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(mmcm_lock_reclocked_i_2__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_mmcm_lock_reclocked_n_1),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hEF00FF10)) 
    pll_reset_asserted_i_1__1
       (.I0(tx_state[3]),
        .I1(tx_state[2]),
        .I2(tx_state[0]),
        .I3(pll_reset_asserted_reg_n_0),
        .I4(tx_state[1]),
        .O(pll_reset_asserted_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    pll_reset_asserted_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(pll_reset_asserted_i_1__1_n_0),
        .Q(pll_reset_asserted_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT3 #(
    .INIT(8'h2A)) 
    reset_time_out_i_3__1
       (.I0(tx_state[0]),
        .I1(tx_state[3]),
        .I2(tx_state[2]),
        .O(reset_time_out_i_3__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_QPLLLOCK_n_0),
        .Q(reset_time_out_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFB0002)) 
    run_phase_alignment_int_i_1__1
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[2]),
        .I3(tx_state[1]),
        .I4(run_phase_alignment_int_reg_n_0),
        .O(run_phase_alignment_int_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(run_phase_alignment_int_i_1__1_n_0),
        .Q(run_phase_alignment_int_reg_n_0),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_s3_reg
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(data_out),
        .Q(run_phase_alignment_int_s3_reg_n_0),
        .R(1'b0));
  XLAUI_XLAUI_sync_block_20 sync_QPLLLOCK
       (.E(sync_QPLLLOCK_n_1),
        .\FSM_sequential_tx_state_reg[0] (reset_time_out_i_3__1_n_0),
        .\FSM_sequential_tx_state_reg[1] (\FSM_sequential_tx_state[3]_i_5__1_n_0 ),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .init_wait_done_reg(init_wait_done_reg_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(tx_state),
        .pll_reset_asserted_reg(pll_reset_asserted_reg_n_0),
        .reset_time_out_reg(sync_QPLLLOCK_n_0),
        .reset_time_out_reg_0(reset_time_out_reg_n_0),
        .time_out_2ms_reg(time_out_2ms_reg_n_0),
        .time_out_500us_reg(time_out_500us_reg_n_0),
        .time_tlock_max_reg(time_tlock_max_reg_n_0),
        .txresetdone_s3(txresetdone_s3),
        .wait_time_done(wait_time_done));
  XLAUI_XLAUI_sync_block_21 sync_TXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(txresetdone_s2),
        .gt2_txresetdone_out(gt2_txresetdone_out));
  XLAUI_XLAUI_sync_block_22 sync_mmcm_lock_reclocked
       (.GT2_TX_MMCM_LOCK_IN(GT2_TX_MMCM_LOCK_IN),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(sync_mmcm_lock_reclocked_n_0),
        .SYSCLK_IN(SYSCLK_IN),
        .\mmcm_lock_count_reg[5] (mmcm_lock_reclocked_i_2__1_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_lock_reclocked_reg(sync_mmcm_lock_reclocked_n_1));
  XLAUI_XLAUI_sync_block_23 sync_run_phase_alignment_int
       (.data_in(run_phase_alignment_int_reg_n_0),
        .data_out(data_out),
        .gt2_txusrclk_in(gt2_txusrclk_in));
  XLAUI_XLAUI_sync_block_24 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(time_out_wait_bypass_reg_n_0),
        .data_out(time_out_wait_bypass_s2));
  XLAUI_XLAUI_sync_block_25 sync_tx_fsm_reset_done_int
       (.GT2_TX_FSM_RESET_DONE_OUT(GT2_TX_FSM_RESET_DONE_OUT),
        .data_out(tx_fsm_reset_done_int_s2),
        .gt2_txusrclk_in(gt2_txusrclk_in));
  LUT3 #(
    .INIT(8'h0E)) 
    time_out_2ms_i_1__5
       (.I0(time_out_2ms_reg_n_0),
        .I1(time_out_2ms),
        .I2(reset_time_out_reg_n_0),
        .O(time_out_2ms_i_1__5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_2ms_i_1__5_n_0),
        .Q(time_out_2ms_reg_n_0),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h00AE)) 
    time_out_500us_i_1__5
       (.I0(time_out_500us_reg_n_0),
        .I1(time_out_500us_i_2__1_n_0),
        .I2(time_out_500us_i_3__1_n_0),
        .I3(reset_time_out_reg_n_0),
        .O(time_out_500us_i_1__5_n_0));
  LUT5 #(
    .INIT(32'h00000040)) 
    time_out_500us_i_2__1
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[16]),
        .I3(time_out_counter_reg[13]),
        .I4(time_out_500us_i_4__3_n_0),
        .O(time_out_500us_i_2__1_n_0));
  LUT5 #(
    .INIT(32'hFFFFFBFF)) 
    time_out_500us_i_3__1
       (.I0(time_tlock_max_i_5__1_n_0),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[8]),
        .I4(\time_out_counter[0]_i_12__1_n_0 ),
        .O(time_out_500us_i_3__1_n_0));
  LUT4 #(
    .INIT(16'hFF7F)) 
    time_out_500us_i_4__3
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[2]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[9]),
        .O(time_out_500us_i_4__3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_500us_i_1__5_n_0),
        .Q(time_out_500us_reg_n_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \time_out_counter[0]_i_10__1 
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[18]),
        .O(\time_out_counter[0]_i_10__1_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \time_out_counter[0]_i_11__1 
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[9]),
        .I3(time_out_counter_reg[11]),
        .O(\time_out_counter[0]_i_11__1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \time_out_counter[0]_i_12__1 
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[5]),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_counter_reg[1]),
        .O(\time_out_counter[0]_i_12__1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_1__5 
       (.I0(time_out_2ms),
        .O(time_out_counter));
  LUT5 #(
    .INIT(32'h00000004)) 
    \time_out_counter[0]_i_3__1 
       (.I0(\time_out_counter[0]_i_8__4_n_0 ),
        .I1(\time_out_counter[0]_i_9__2_n_0 ),
        .I2(\time_out_counter[0]_i_10__1_n_0 ),
        .I3(\time_out_counter[0]_i_11__1_n_0 ),
        .I4(\time_out_counter[0]_i_12__1_n_0 ),
        .O(time_out_2ms));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_7__1 
       (.I0(time_out_counter_reg[0]),
        .O(\time_out_counter[0]_i_7__1_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \time_out_counter[0]_i_8__4 
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[0]),
        .I3(time_out_counter_reg[2]),
        .O(\time_out_counter[0]_i_8__4_n_0 ));
  LUT4 #(
    .INIT(16'h0008)) 
    \time_out_counter[0]_i_9__2 
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[4]),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[17]),
        .O(\time_out_counter[0]_i_9__2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__1_n_7 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[0]_i_2__1 
       (.CI(1'b0),
        .CO({\time_out_counter_reg[0]_i_2__1_n_0 ,\time_out_counter_reg[0]_i_2__1_n_1 ,\time_out_counter_reg[0]_i_2__1_n_2 ,\time_out_counter_reg[0]_i_2__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\time_out_counter_reg[0]_i_2__1_n_4 ,\time_out_counter_reg[0]_i_2__1_n_5 ,\time_out_counter_reg[0]_i_2__1_n_6 ,\time_out_counter_reg[0]_i_2__1_n_7 }),
        .S({time_out_counter_reg[3:1],\time_out_counter[0]_i_7__1_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__1_n_5 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__1_n_4 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__1_n_7 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[12]_i_1__1 
       (.CI(\time_out_counter_reg[8]_i_1__1_n_0 ),
        .CO({\time_out_counter_reg[12]_i_1__1_n_0 ,\time_out_counter_reg[12]_i_1__1_n_1 ,\time_out_counter_reg[12]_i_1__1_n_2 ,\time_out_counter_reg[12]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[12]_i_1__1_n_4 ,\time_out_counter_reg[12]_i_1__1_n_5 ,\time_out_counter_reg[12]_i_1__1_n_6 ,\time_out_counter_reg[12]_i_1__1_n_7 }),
        .S(time_out_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__1_n_6 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__1_n_5 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__1_n_4 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__1_n_7 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[16]_i_1__1 
       (.CI(\time_out_counter_reg[12]_i_1__1_n_0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__1_CO_UNCONNECTED [3:2],\time_out_counter_reg[16]_i_1__1_n_2 ,\time_out_counter_reg[16]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__1_O_UNCONNECTED [3],\time_out_counter_reg[16]_i_1__1_n_5 ,\time_out_counter_reg[16]_i_1__1_n_6 ,\time_out_counter_reg[16]_i_1__1_n_7 }),
        .S({1'b0,time_out_counter_reg[18:16]}));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__1_n_6 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__1_n_5 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__1_n_6 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__1_n_5 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__1_n_4 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__1_n_7 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[4]_i_1__1 
       (.CI(\time_out_counter_reg[0]_i_2__1_n_0 ),
        .CO({\time_out_counter_reg[4]_i_1__1_n_0 ,\time_out_counter_reg[4]_i_1__1_n_1 ,\time_out_counter_reg[4]_i_1__1_n_2 ,\time_out_counter_reg[4]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[4]_i_1__1_n_4 ,\time_out_counter_reg[4]_i_1__1_n_5 ,\time_out_counter_reg[4]_i_1__1_n_6 ,\time_out_counter_reg[4]_i_1__1_n_7 }),
        .S(time_out_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__1_n_6 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__1_n_5 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__1_n_4 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__1_n_7 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[8]_i_1__1 
       (.CI(\time_out_counter_reg[4]_i_1__1_n_0 ),
        .CO({\time_out_counter_reg[8]_i_1__1_n_0 ,\time_out_counter_reg[8]_i_1__1_n_1 ,\time_out_counter_reg[8]_i_1__1_n_2 ,\time_out_counter_reg[8]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[8]_i_1__1_n_4 ,\time_out_counter_reg[8]_i_1__1_n_5 ,\time_out_counter_reg[8]_i_1__1_n_6 ,\time_out_counter_reg[8]_i_1__1_n_7 }),
        .S(time_out_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__1_n_6 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out_reg_n_0));
  LUT4 #(
    .INIT(16'hAB00)) 
    time_out_wait_bypass_i_1__1
       (.I0(time_out_wait_bypass_reg_n_0),
        .I1(\wait_bypass_count[0]_i_4__1_n_0 ),
        .I2(tx_fsm_reset_done_int_s3_reg_n_0),
        .I3(run_phase_alignment_int_s3_reg_n_0),
        .O(time_out_wait_bypass_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_reg
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(time_out_wait_bypass_i_1__1_n_0),
        .Q(time_out_wait_bypass_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT4 #(
    .INIT(16'h00AE)) 
    time_tlock_max_i_1__5
       (.I0(time_tlock_max_reg_n_0),
        .I1(time_tlock_max_i_2__1_n_0),
        .I2(time_tlock_max_i_3__1_n_0),
        .I3(reset_time_out_reg_n_0),
        .O(time_tlock_max_i_1__5_n_0));
  LUT5 #(
    .INIT(32'h00000010)) 
    time_tlock_max_i_2__1
       (.I0(time_out_counter_reg[5]),
        .I1(time_out_counter_reg[6]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[2]),
        .I4(time_tlock_max_i_4__1_n_0),
        .O(time_tlock_max_i_2__1_n_0));
  LUT5 #(
    .INIT(32'hFFEFFFFF)) 
    time_tlock_max_i_3__1
       (.I0(time_tlock_max_i_5__1_n_0),
        .I1(time_tlock_max_i_6__1_n_0),
        .I2(time_out_counter_reg[1]),
        .I3(time_out_counter_reg[15]),
        .I4(time_out_counter_reg[4]),
        .O(time_tlock_max_i_3__1_n_0));
  LUT4 #(
    .INIT(16'hFFEF)) 
    time_tlock_max_i_4__1
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[9]),
        .O(time_tlock_max_i_4__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    time_tlock_max_i_5__1
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[18]),
        .O(time_tlock_max_i_5__1_n_0));
  LUT4 #(
    .INIT(16'hFFFD)) 
    time_tlock_max_i_6__1
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[0]),
        .I3(time_out_counter_reg[16]),
        .O(time_tlock_max_i_6__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_tlock_max_i_1__5_n_0),
        .Q(time_tlock_max_reg_n_0),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFFF0008)) 
    tx_fsm_reset_done_int_i_1__1
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[2]),
        .I3(tx_state[1]),
        .I4(GT2_TX_FSM_RESET_DONE_OUT),
        .O(tx_fsm_reset_done_int_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    tx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_i_1__1_n_0),
        .Q(GT2_TX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    tx_fsm_reset_done_int_s3_reg
       (.C(gt2_txusrclk_in),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_s2),
        .Q(tx_fsm_reset_done_int_s3_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    txresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(txresetdone_s2),
        .Q(txresetdone_s3),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hDFFFFFFF)) 
    \wait_bypass_count[0]_i_10__1 
       (.I0(wait_bypass_count_reg[0]),
        .I1(wait_bypass_count_reg[15]),
        .I2(wait_bypass_count_reg[16]),
        .I3(wait_bypass_count_reg[2]),
        .I4(wait_bypass_count_reg[1]),
        .O(\wait_bypass_count[0]_i_10__1_n_0 ));
  LUT4 #(
    .INIT(16'hFFEF)) 
    \wait_bypass_count[0]_i_11__1 
       (.I0(wait_bypass_count_reg[12]),
        .I1(wait_bypass_count_reg[11]),
        .I2(wait_bypass_count_reg[13]),
        .I3(wait_bypass_count_reg[14]),
        .O(\wait_bypass_count[0]_i_11__1_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \wait_bypass_count[0]_i_12__1 
       (.I0(wait_bypass_count_reg[8]),
        .I1(wait_bypass_count_reg[7]),
        .I2(wait_bypass_count_reg[10]),
        .I3(wait_bypass_count_reg[9]),
        .O(\wait_bypass_count[0]_i_12__1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_1__1 
       (.I0(run_phase_alignment_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_1__1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \wait_bypass_count[0]_i_2__1 
       (.I0(\wait_bypass_count[0]_i_4__1_n_0 ),
        .I1(tx_fsm_reset_done_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_2__1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_bypass_count[0]_i_4__1 
       (.I0(\wait_bypass_count[0]_i_9__1_n_0 ),
        .I1(\wait_bypass_count[0]_i_10__1_n_0 ),
        .I2(\wait_bypass_count[0]_i_11__1_n_0 ),
        .I3(\wait_bypass_count[0]_i_12__1_n_0 ),
        .O(\wait_bypass_count[0]_i_4__1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_8__1 
       (.I0(wait_bypass_count_reg[0]),
        .O(\wait_bypass_count[0]_i_8__1_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \wait_bypass_count[0]_i_9__1 
       (.I0(wait_bypass_count_reg[4]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[6]),
        .I3(wait_bypass_count_reg[5]),
        .O(\wait_bypass_count[0]_i_9__1_n_0 ));
  FDRE \wait_bypass_count_reg[0] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__1_n_7 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  CARRY4 \wait_bypass_count_reg[0]_i_3__1 
       (.CI(1'b0),
        .CO({\wait_bypass_count_reg[0]_i_3__1_n_0 ,\wait_bypass_count_reg[0]_i_3__1_n_1 ,\wait_bypass_count_reg[0]_i_3__1_n_2 ,\wait_bypass_count_reg[0]_i_3__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\wait_bypass_count_reg[0]_i_3__1_n_4 ,\wait_bypass_count_reg[0]_i_3__1_n_5 ,\wait_bypass_count_reg[0]_i_3__1_n_6 ,\wait_bypass_count_reg[0]_i_3__1_n_7 }),
        .S({wait_bypass_count_reg[3:1],\wait_bypass_count[0]_i_8__1_n_0 }));
  FDRE \wait_bypass_count_reg[10] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__1_n_5 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[11] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__1_n_4 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[12] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__1_n_7 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  CARRY4 \wait_bypass_count_reg[12]_i_1__1 
       (.CI(\wait_bypass_count_reg[8]_i_1__1_n_0 ),
        .CO({\wait_bypass_count_reg[12]_i_1__1_n_0 ,\wait_bypass_count_reg[12]_i_1__1_n_1 ,\wait_bypass_count_reg[12]_i_1__1_n_2 ,\wait_bypass_count_reg[12]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[12]_i_1__1_n_4 ,\wait_bypass_count_reg[12]_i_1__1_n_5 ,\wait_bypass_count_reg[12]_i_1__1_n_6 ,\wait_bypass_count_reg[12]_i_1__1_n_7 }),
        .S(wait_bypass_count_reg[15:12]));
  FDRE \wait_bypass_count_reg[13] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__1_n_6 ),
        .Q(wait_bypass_count_reg[13]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[14] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__1_n_5 ),
        .Q(wait_bypass_count_reg[14]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[15] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__1_n_4 ),
        .Q(wait_bypass_count_reg[15]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[16] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[16]_i_1__1_n_7 ),
        .Q(wait_bypass_count_reg[16]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  CARRY4 \wait_bypass_count_reg[16]_i_1__1 
       (.CI(\wait_bypass_count_reg[12]_i_1__1_n_0 ),
        .CO(\NLW_wait_bypass_count_reg[16]_i_1__1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[16]_i_1__1_O_UNCONNECTED [3:1],\wait_bypass_count_reg[16]_i_1__1_n_7 }),
        .S({1'b0,1'b0,1'b0,wait_bypass_count_reg[16]}));
  FDRE \wait_bypass_count_reg[1] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__1_n_6 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[2] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__1_n_5 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[3] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__1_n_4 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[4] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__1_n_7 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  CARRY4 \wait_bypass_count_reg[4]_i_1__1 
       (.CI(\wait_bypass_count_reg[0]_i_3__1_n_0 ),
        .CO({\wait_bypass_count_reg[4]_i_1__1_n_0 ,\wait_bypass_count_reg[4]_i_1__1_n_1 ,\wait_bypass_count_reg[4]_i_1__1_n_2 ,\wait_bypass_count_reg[4]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[4]_i_1__1_n_4 ,\wait_bypass_count_reg[4]_i_1__1_n_5 ,\wait_bypass_count_reg[4]_i_1__1_n_6 ,\wait_bypass_count_reg[4]_i_1__1_n_7 }),
        .S(wait_bypass_count_reg[7:4]));
  FDRE \wait_bypass_count_reg[5] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__1_n_6 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[6] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__1_n_5 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[7] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__1_n_4 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  FDRE \wait_bypass_count_reg[8] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__1_n_7 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  CARRY4 \wait_bypass_count_reg[8]_i_1__1 
       (.CI(\wait_bypass_count_reg[4]_i_1__1_n_0 ),
        .CO({\wait_bypass_count_reg[8]_i_1__1_n_0 ,\wait_bypass_count_reg[8]_i_1__1_n_1 ,\wait_bypass_count_reg[8]_i_1__1_n_2 ,\wait_bypass_count_reg[8]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[8]_i_1__1_n_4 ,\wait_bypass_count_reg[8]_i_1__1_n_5 ,\wait_bypass_count_reg[8]_i_1__1_n_6 ,\wait_bypass_count_reg[8]_i_1__1_n_7 }),
        .S(wait_bypass_count_reg[11:8]));
  FDRE \wait_bypass_count_reg[9] 
       (.C(gt2_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__1_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__1_n_6 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\wait_bypass_count[0]_i_1__1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_time_cnt[0]_i_1__1 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \wait_time_cnt[1]_i_1__1 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\wait_time_cnt[1]_i_1__1_n_0 ));
  LUT3 #(
    .INIT(8'hE1)) 
    \wait_time_cnt[2]_i_1__1 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[2]),
        .O(wait_time_cnt0[2]));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \wait_time_cnt[3]_i_1__1 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0[3]));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \wait_time_cnt[4]_i_1__1 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\wait_time_cnt[4]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
    \wait_time_cnt[5]_i_1__1 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[5]));
  LUT4 #(
    .INIT(16'h1030)) 
    \wait_time_cnt[6]_i_1__1 
       (.I0(tx_state[2]),
        .I1(tx_state[3]),
        .I2(tx_state[0]),
        .I3(tx_state[1]),
        .O(\wait_time_cnt[6]_i_1__1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_2__1 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\wait_time_cnt[6]_i_4__1_n_0 ),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(wait_time_cnt_reg__0[5]),
        .O(\wait_time_cnt[6]_i_2__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \wait_time_cnt[6]_i_3__1 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(\wait_time_cnt[6]_i_4__1_n_0 ),
        .O(wait_time_cnt0[6]));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_4__1 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .O(\wait_time_cnt[6]_i_4__1_n_0 ));
  FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__1_n_0 ),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\wait_time_cnt[6]_i_1__1_n_0 ));
  FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__1_n_0 ),
        .D(\wait_time_cnt[1]_i_1__1_n_0 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\wait_time_cnt[6]_i_1__1_n_0 ));
  FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__1_n_0 ),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\wait_time_cnt[6]_i_1__1_n_0 ));
  FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__1_n_0 ),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\wait_time_cnt[6]_i_1__1_n_0 ));
  FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__1_n_0 ),
        .D(\wait_time_cnt[4]_i_1__1_n_0 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\wait_time_cnt[6]_i_1__1_n_0 ));
  FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__1_n_0 ),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\wait_time_cnt[6]_i_1__1_n_0 ));
  FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__1_n_0 ),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\wait_time_cnt[6]_i_1__1_n_0 ));
endmodule

(* ORIG_REF_NAME = "XLAUI_TX_STARTUP_FSM" *) 
module XLAUI_XLAUI_TX_STARTUP_FSM_5
   (gt3_gttxreset_in,
    GT3_TX_MMCM_RESET_OUT,
    GT3_TX_FSM_RESET_DONE_OUT,
    gt3_txuserrdy_in,
    SYSCLK_IN,
    gt3_txusrclk_in,
    SOFT_RESET_IN,
    gt3_txresetdone_out,
    GT3_TX_MMCM_LOCK_IN,
    GT0_QPLLLOCK_IN);
  output gt3_gttxreset_in;
  output GT3_TX_MMCM_RESET_OUT;
  output GT3_TX_FSM_RESET_DONE_OUT;
  output gt3_txuserrdy_in;
  input SYSCLK_IN;
  input gt3_txusrclk_in;
  input SOFT_RESET_IN;
  input gt3_txresetdone_out;
  input GT3_TX_MMCM_LOCK_IN;
  input GT0_QPLLLOCK_IN;

  wire \FSM_sequential_tx_state[0]_i_1__2_n_0 ;
  wire \FSM_sequential_tx_state[0]_i_2__2_n_0 ;
  wire \FSM_sequential_tx_state[1]_i_1__2_n_0 ;
  wire \FSM_sequential_tx_state[2]_i_1__2_n_0 ;
  wire \FSM_sequential_tx_state[2]_i_2__2_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_2__2_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_5__2_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_6__2_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire GT3_TX_FSM_RESET_DONE_OUT;
  wire GT3_TX_MMCM_LOCK_IN;
  wire GT3_TX_MMCM_RESET_OUT;
  wire MMCM_RESET_i_1__2_n_0;
  wire SOFT_RESET_IN;
  wire SYSCLK_IN;
  wire TXUSERRDY_i_1__2_n_0;
  wire data_out;
  wire gt3_gttxreset_in;
  wire gt3_txresetdone_out;
  wire gt3_txuserrdy_in;
  wire gt3_txusrclk_in;
  wire gttxreset_i_i_1__2_n_0;
  wire init_wait_count;
  wire \init_wait_count[6]_i_3__2_n_0 ;
  wire \init_wait_count[6]_i_4__2_n_0 ;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire init_wait_done_i_1__2_n_0;
  wire init_wait_done_reg_n_0;
  wire \mmcm_lock_count[7]_i_2__2_n_0 ;
  wire \mmcm_lock_count[7]_i_4__2_n_0 ;
  wire [7:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_i_2__2_n_0;
  wire [6:0]p_0_in;
  wire [7:0]p_0_in__0;
  wire pll_reset_asserted_i_1__2_n_0;
  wire pll_reset_asserted_reg_n_0;
  wire reset_time_out_i_3__2_n_0;
  wire reset_time_out_reg_n_0;
  wire run_phase_alignment_int_i_1__2_n_0;
  wire run_phase_alignment_int_reg_n_0;
  wire run_phase_alignment_int_s3_reg_n_0;
  wire sync_QPLLLOCK_n_0;
  wire sync_QPLLLOCK_n_1;
  wire sync_mmcm_lock_reclocked_n_0;
  wire sync_mmcm_lock_reclocked_n_1;
  wire time_out_2ms;
  wire time_out_2ms_i_1__6_n_0;
  wire time_out_2ms_reg_n_0;
  wire time_out_500us_i_1__6_n_0;
  wire time_out_500us_i_2__2_n_0;
  wire time_out_500us_i_3__2_n_0;
  wire time_out_500us_i_4__4_n_0;
  wire time_out_500us_reg_n_0;
  wire time_out_counter;
  wire \time_out_counter[0]_i_10__2_n_0 ;
  wire \time_out_counter[0]_i_11__2_n_0 ;
  wire \time_out_counter[0]_i_12__2_n_0 ;
  wire \time_out_counter[0]_i_7__2_n_0 ;
  wire \time_out_counter[0]_i_8__5_n_0 ;
  wire \time_out_counter[0]_i_9__3_n_0 ;
  wire [18:0]time_out_counter_reg;
  wire \time_out_counter_reg[0]_i_2__2_n_0 ;
  wire \time_out_counter_reg[0]_i_2__2_n_1 ;
  wire \time_out_counter_reg[0]_i_2__2_n_2 ;
  wire \time_out_counter_reg[0]_i_2__2_n_3 ;
  wire \time_out_counter_reg[0]_i_2__2_n_4 ;
  wire \time_out_counter_reg[0]_i_2__2_n_5 ;
  wire \time_out_counter_reg[0]_i_2__2_n_6 ;
  wire \time_out_counter_reg[0]_i_2__2_n_7 ;
  wire \time_out_counter_reg[12]_i_1__2_n_0 ;
  wire \time_out_counter_reg[12]_i_1__2_n_1 ;
  wire \time_out_counter_reg[12]_i_1__2_n_2 ;
  wire \time_out_counter_reg[12]_i_1__2_n_3 ;
  wire \time_out_counter_reg[12]_i_1__2_n_4 ;
  wire \time_out_counter_reg[12]_i_1__2_n_5 ;
  wire \time_out_counter_reg[12]_i_1__2_n_6 ;
  wire \time_out_counter_reg[12]_i_1__2_n_7 ;
  wire \time_out_counter_reg[16]_i_1__2_n_2 ;
  wire \time_out_counter_reg[16]_i_1__2_n_3 ;
  wire \time_out_counter_reg[16]_i_1__2_n_5 ;
  wire \time_out_counter_reg[16]_i_1__2_n_6 ;
  wire \time_out_counter_reg[16]_i_1__2_n_7 ;
  wire \time_out_counter_reg[4]_i_1__2_n_0 ;
  wire \time_out_counter_reg[4]_i_1__2_n_1 ;
  wire \time_out_counter_reg[4]_i_1__2_n_2 ;
  wire \time_out_counter_reg[4]_i_1__2_n_3 ;
  wire \time_out_counter_reg[4]_i_1__2_n_4 ;
  wire \time_out_counter_reg[4]_i_1__2_n_5 ;
  wire \time_out_counter_reg[4]_i_1__2_n_6 ;
  wire \time_out_counter_reg[4]_i_1__2_n_7 ;
  wire \time_out_counter_reg[8]_i_1__2_n_0 ;
  wire \time_out_counter_reg[8]_i_1__2_n_1 ;
  wire \time_out_counter_reg[8]_i_1__2_n_2 ;
  wire \time_out_counter_reg[8]_i_1__2_n_3 ;
  wire \time_out_counter_reg[8]_i_1__2_n_4 ;
  wire \time_out_counter_reg[8]_i_1__2_n_5 ;
  wire \time_out_counter_reg[8]_i_1__2_n_6 ;
  wire \time_out_counter_reg[8]_i_1__2_n_7 ;
  wire time_out_wait_bypass_i_1__2_n_0;
  wire time_out_wait_bypass_reg_n_0;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max_i_1__6_n_0;
  wire time_tlock_max_i_2__2_n_0;
  wire time_tlock_max_i_3__2_n_0;
  wire time_tlock_max_i_4__2_n_0;
  wire time_tlock_max_i_5__2_n_0;
  wire time_tlock_max_i_6__2_n_0;
  wire time_tlock_max_reg_n_0;
  wire tx_fsm_reset_done_int_i_1__2_n_0;
  wire tx_fsm_reset_done_int_s2;
  wire tx_fsm_reset_done_int_s3_reg_n_0;
  (* RTL_KEEP = "yes" *) wire [3:0]tx_state;
  wire tx_state13_out;
  wire txresetdone_s2;
  wire txresetdone_s3;
  wire \wait_bypass_count[0]_i_10__2_n_0 ;
  wire \wait_bypass_count[0]_i_11__2_n_0 ;
  wire \wait_bypass_count[0]_i_12__2_n_0 ;
  wire \wait_bypass_count[0]_i_1__2_n_0 ;
  wire \wait_bypass_count[0]_i_2__2_n_0 ;
  wire \wait_bypass_count[0]_i_4__2_n_0 ;
  wire \wait_bypass_count[0]_i_8__2_n_0 ;
  wire \wait_bypass_count[0]_i_9__2_n_0 ;
  wire [16:0]wait_bypass_count_reg;
  wire \wait_bypass_count_reg[0]_i_3__2_n_0 ;
  wire \wait_bypass_count_reg[0]_i_3__2_n_1 ;
  wire \wait_bypass_count_reg[0]_i_3__2_n_2 ;
  wire \wait_bypass_count_reg[0]_i_3__2_n_3 ;
  wire \wait_bypass_count_reg[0]_i_3__2_n_4 ;
  wire \wait_bypass_count_reg[0]_i_3__2_n_5 ;
  wire \wait_bypass_count_reg[0]_i_3__2_n_6 ;
  wire \wait_bypass_count_reg[0]_i_3__2_n_7 ;
  wire \wait_bypass_count_reg[12]_i_1__2_n_0 ;
  wire \wait_bypass_count_reg[12]_i_1__2_n_1 ;
  wire \wait_bypass_count_reg[12]_i_1__2_n_2 ;
  wire \wait_bypass_count_reg[12]_i_1__2_n_3 ;
  wire \wait_bypass_count_reg[12]_i_1__2_n_4 ;
  wire \wait_bypass_count_reg[12]_i_1__2_n_5 ;
  wire \wait_bypass_count_reg[12]_i_1__2_n_6 ;
  wire \wait_bypass_count_reg[12]_i_1__2_n_7 ;
  wire \wait_bypass_count_reg[16]_i_1__2_n_7 ;
  wire \wait_bypass_count_reg[4]_i_1__2_n_0 ;
  wire \wait_bypass_count_reg[4]_i_1__2_n_1 ;
  wire \wait_bypass_count_reg[4]_i_1__2_n_2 ;
  wire \wait_bypass_count_reg[4]_i_1__2_n_3 ;
  wire \wait_bypass_count_reg[4]_i_1__2_n_4 ;
  wire \wait_bypass_count_reg[4]_i_1__2_n_5 ;
  wire \wait_bypass_count_reg[4]_i_1__2_n_6 ;
  wire \wait_bypass_count_reg[4]_i_1__2_n_7 ;
  wire \wait_bypass_count_reg[8]_i_1__2_n_0 ;
  wire \wait_bypass_count_reg[8]_i_1__2_n_1 ;
  wire \wait_bypass_count_reg[8]_i_1__2_n_2 ;
  wire \wait_bypass_count_reg[8]_i_1__2_n_3 ;
  wire \wait_bypass_count_reg[8]_i_1__2_n_4 ;
  wire \wait_bypass_count_reg[8]_i_1__2_n_5 ;
  wire \wait_bypass_count_reg[8]_i_1__2_n_6 ;
  wire \wait_bypass_count_reg[8]_i_1__2_n_7 ;
  wire [6:0]wait_time_cnt0;
  wire \wait_time_cnt[1]_i_1__2_n_0 ;
  wire \wait_time_cnt[4]_i_1__2_n_0 ;
  wire \wait_time_cnt[6]_i_1__2_n_0 ;
  wire \wait_time_cnt[6]_i_2__2_n_0 ;
  wire \wait_time_cnt[6]_i_4__2_n_0 ;
  wire [6:0]wait_time_cnt_reg__0;
  wire wait_time_done;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1__2_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__2_O_UNCONNECTED ;
  wire [3:0]\NLW_wait_bypass_count_reg[16]_i_1__2_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[16]_i_1__2_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h2222220222220A0A)) 
    \FSM_sequential_tx_state[0]_i_1__2 
       (.I0(\FSM_sequential_tx_state[0]_i_2__2_n_0 ),
        .I1(tx_state[3]),
        .I2(tx_state[0]),
        .I3(time_out_2ms_reg_n_0),
        .I4(tx_state[2]),
        .I5(tx_state[1]),
        .O(\FSM_sequential_tx_state[0]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'h3B33BBBBBBBBBBBB)) 
    \FSM_sequential_tx_state[0]_i_2__2 
       (.I0(\FSM_sequential_tx_state[2]_i_2__2_n_0 ),
        .I1(tx_state[0]),
        .I2(reset_time_out_reg_n_0),
        .I3(time_out_500us_reg_n_0),
        .I4(tx_state[1]),
        .I5(tx_state[2]),
        .O(\FSM_sequential_tx_state[0]_i_2__2_n_0 ));
  LUT5 #(
    .INIT(32'h11110444)) 
    \FSM_sequential_tx_state[1]_i_1__2 
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state13_out),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .O(\FSM_sequential_tx_state[1]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \FSM_sequential_tx_state[1]_i_2__2 
       (.I0(reset_time_out_reg_n_0),
        .I1(time_tlock_max_reg_n_0),
        .I2(mmcm_lock_reclocked),
        .O(tx_state13_out));
  LUT6 #(
    .INIT(64'h1111004055550040)) 
    \FSM_sequential_tx_state[2]_i_1__2 
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .I3(time_out_2ms_reg_n_0),
        .I4(tx_state[2]),
        .I5(\FSM_sequential_tx_state[2]_i_2__2_n_0 ),
        .O(\FSM_sequential_tx_state[2]_i_1__2_n_0 ));
  LUT4 #(
    .INIT(16'hFF04)) 
    \FSM_sequential_tx_state[2]_i_2__2 
       (.I0(mmcm_lock_reclocked),
        .I1(time_tlock_max_reg_n_0),
        .I2(reset_time_out_reg_n_0),
        .I3(tx_state[1]),
        .O(\FSM_sequential_tx_state[2]_i_2__2_n_0 ));
  LUT5 #(
    .INIT(32'h00A00B00)) 
    \FSM_sequential_tx_state[3]_i_2__2 
       (.I0(\FSM_sequential_tx_state[3]_i_6__2_n_0 ),
        .I1(time_out_wait_bypass_s3),
        .I2(tx_state[2]),
        .I3(tx_state[3]),
        .I4(tx_state[1]),
        .O(\FSM_sequential_tx_state[3]_i_2__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \FSM_sequential_tx_state[3]_i_4__2 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[4]),
        .I2(\wait_time_cnt[6]_i_4__2_n_0 ),
        .I3(wait_time_cnt_reg__0[6]),
        .O(wait_time_done));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_tx_state[3]_i_5__2 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .O(\FSM_sequential_tx_state[3]_i_5__2_n_0 ));
  LUT3 #(
    .INIT(8'h8A)) 
    \FSM_sequential_tx_state[3]_i_6__2 
       (.I0(tx_state[0]),
        .I1(reset_time_out_reg_n_0),
        .I2(time_out_500us_reg_n_0),
        .O(\FSM_sequential_tx_state[3]_i_6__2_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[0] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[0]_i_1__2_n_0 ),
        .Q(tx_state[0]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[1] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[1]_i_1__2_n_0 ),
        .Q(tx_state[1]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[2] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[2]_i_1__2_n_0 ),
        .Q(tx_state[2]),
        .R(SOFT_RESET_IN));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_tx_state_reg[3] 
       (.C(SYSCLK_IN),
        .CE(sync_QPLLLOCK_n_1),
        .D(\FSM_sequential_tx_state[3]_i_2__2_n_0 ),
        .Q(tx_state[3]),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFF70004)) 
    MMCM_RESET_i_1__2
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state[3]),
        .I3(tx_state[1]),
        .I4(GT3_TX_MMCM_RESET_OUT),
        .O(MMCM_RESET_i_1__2_n_0));
  FDRE #(
    .INIT(1'b1)) 
    MMCM_RESET_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(MMCM_RESET_i_1__2_n_0),
        .Q(GT3_TX_MMCM_RESET_OUT),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFB4000)) 
    TXUSERRDY_i_1__2
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .I3(tx_state[2]),
        .I4(gt3_txuserrdy_in),
        .O(TXUSERRDY_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    TXUSERRDY_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(TXUSERRDY_i_1__2_n_0),
        .Q(gt3_txuserrdy_in),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFD0004)) 
    gttxreset_i_i_1__2
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state[3]),
        .I3(tx_state[1]),
        .I4(gt3_gttxreset_in),
        .O(gttxreset_i_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    gttxreset_i_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gttxreset_i_i_1__2_n_0),
        .Q(gt3_gttxreset_in),
        .R(SOFT_RESET_IN));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \init_wait_count[0]_i_1__2 
       (.I0(init_wait_count_reg__0[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \init_wait_count[1]_i_1__2 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \init_wait_count[2]_i_1__2 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \init_wait_count[3]_i_1__2 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \init_wait_count[4]_i_1__2 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[3]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \init_wait_count[5]_i_1__2 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
    \init_wait_count[6]_i_1__2 
       (.I0(\init_wait_count[6]_i_3__2_n_0 ),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[6]),
        .I5(init_wait_count_reg__0[5]),
        .O(init_wait_count));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT5 #(
    .INIT(32'h9AAAAAAA)) 
    \init_wait_count[6]_i_2__2 
       (.I0(init_wait_count_reg__0[6]),
        .I1(\init_wait_count[6]_i_4__2_n_0 ),
        .I2(init_wait_count_reg__0[4]),
        .I3(init_wait_count_reg__0[3]),
        .I4(init_wait_count_reg__0[5]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \init_wait_count[6]_i_3__2 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(\init_wait_count[6]_i_3__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \init_wait_count[6]_i_4__2 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(\init_wait_count[6]_i_4__2_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[0]),
        .Q(init_wait_count_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \init_wait_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(init_wait_count),
        .CLR(SOFT_RESET_IN),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
  LUT2 #(
    .INIT(4'hE)) 
    init_wait_done_i_1__2
       (.I0(init_wait_done),
        .I1(init_wait_done_reg_n_0),
        .O(init_wait_done_i_1__2_n_0));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    init_wait_done_i_2__2
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[0]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\init_wait_count[6]_i_3__2_n_0 ),
        .O(init_wait_done));
  FDCE #(
    .INIT(1'b0)) 
    init_wait_done_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .CLR(SOFT_RESET_IN),
        .D(init_wait_done_i_1__2_n_0),
        .Q(init_wait_done_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[0]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \mmcm_lock_count[1]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \mmcm_lock_count[2]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \mmcm_lock_count[3]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[4]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[2]),
        .I4(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \mmcm_lock_count[5]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \mmcm_lock_count[6]_i_1__2 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__2_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__0[6]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \mmcm_lock_count[7]_i_2__2 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(mmcm_lock_count_reg__0[4]),
        .I2(\mmcm_lock_count[7]_i_4__2_n_0 ),
        .I3(mmcm_lock_count_reg__0[5]),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(\mmcm_lock_count[7]_i_2__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \mmcm_lock_count[7]_i_3__2 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(mmcm_lock_count_reg__0[5]),
        .I2(\mmcm_lock_count[7]_i_4__2_n_0 ),
        .I3(mmcm_lock_count_reg__0[4]),
        .I4(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \mmcm_lock_count[7]_i_4__2 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .O(\mmcm_lock_count[7]_i_4__2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__2_n_0 ),
        .D(p_0_in__0[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__2_n_0 ),
        .D(p_0_in__0[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__2_n_0 ),
        .D(p_0_in__0[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__2_n_0 ),
        .D(p_0_in__0[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__2_n_0 ),
        .D(p_0_in__0[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__2_n_0 ),
        .D(p_0_in__0[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__2_n_0 ),
        .D(p_0_in__0[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(sync_mmcm_lock_reclocked_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \mmcm_lock_count_reg[7] 
       (.C(SYSCLK_IN),
        .CE(\mmcm_lock_count[7]_i_2__2_n_0 ),
        .D(p_0_in__0[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(sync_mmcm_lock_reclocked_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    mmcm_lock_reclocked_i_2__2
       (.I0(mmcm_lock_count_reg__0[5]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[4]),
        .O(mmcm_lock_reclocked_i_2__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    mmcm_lock_reclocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_mmcm_lock_reclocked_n_1),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hEF00FF10)) 
    pll_reset_asserted_i_1__2
       (.I0(tx_state[3]),
        .I1(tx_state[2]),
        .I2(tx_state[0]),
        .I3(pll_reset_asserted_reg_n_0),
        .I4(tx_state[1]),
        .O(pll_reset_asserted_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    pll_reset_asserted_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(pll_reset_asserted_i_1__2_n_0),
        .Q(pll_reset_asserted_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT3 #(
    .INIT(8'h2A)) 
    reset_time_out_i_3__2
       (.I0(tx_state[0]),
        .I1(tx_state[3]),
        .I2(tx_state[2]),
        .O(reset_time_out_i_3__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    reset_time_out_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(sync_QPLLLOCK_n_0),
        .Q(reset_time_out_reg_n_0),
        .R(SOFT_RESET_IN));
  LUT5 #(
    .INIT(32'hFFFB0002)) 
    run_phase_alignment_int_i_1__2
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[2]),
        .I3(tx_state[1]),
        .I4(run_phase_alignment_int_reg_n_0),
        .O(run_phase_alignment_int_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(run_phase_alignment_int_i_1__2_n_0),
        .Q(run_phase_alignment_int_reg_n_0),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    run_phase_alignment_int_s3_reg
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(data_out),
        .Q(run_phase_alignment_int_s3_reg_n_0),
        .R(1'b0));
  XLAUI_XLAUI_sync_block sync_QPLLLOCK
       (.E(sync_QPLLLOCK_n_1),
        .\FSM_sequential_tx_state_reg[0] (reset_time_out_i_3__2_n_0),
        .\FSM_sequential_tx_state_reg[1] (\FSM_sequential_tx_state[3]_i_5__2_n_0 ),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .init_wait_done_reg(init_wait_done_reg_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .out(tx_state),
        .pll_reset_asserted_reg(pll_reset_asserted_reg_n_0),
        .reset_time_out_reg(sync_QPLLLOCK_n_0),
        .reset_time_out_reg_0(reset_time_out_reg_n_0),
        .time_out_2ms_reg(time_out_2ms_reg_n_0),
        .time_out_500us_reg(time_out_500us_reg_n_0),
        .time_tlock_max_reg(time_tlock_max_reg_n_0),
        .txresetdone_s3(txresetdone_s3),
        .wait_time_done(wait_time_done));
  XLAUI_XLAUI_sync_block_6 sync_TXRESETDONE
       (.SYSCLK_IN(SYSCLK_IN),
        .data_out(txresetdone_s2),
        .gt3_txresetdone_out(gt3_txresetdone_out));
  XLAUI_XLAUI_sync_block_7 sync_mmcm_lock_reclocked
       (.GT3_TX_MMCM_LOCK_IN(GT3_TX_MMCM_LOCK_IN),
        .Q(mmcm_lock_count_reg__0[7:6]),
        .SR(sync_mmcm_lock_reclocked_n_0),
        .SYSCLK_IN(SYSCLK_IN),
        .\mmcm_lock_count_reg[5] (mmcm_lock_reclocked_i_2__2_n_0),
        .mmcm_lock_reclocked(mmcm_lock_reclocked),
        .mmcm_lock_reclocked_reg(sync_mmcm_lock_reclocked_n_1));
  XLAUI_XLAUI_sync_block_8 sync_run_phase_alignment_int
       (.data_in(run_phase_alignment_int_reg_n_0),
        .data_out(data_out),
        .gt3_txusrclk_in(gt3_txusrclk_in));
  XLAUI_XLAUI_sync_block_9 sync_time_out_wait_bypass
       (.SYSCLK_IN(SYSCLK_IN),
        .data_in(time_out_wait_bypass_reg_n_0),
        .data_out(time_out_wait_bypass_s2));
  XLAUI_XLAUI_sync_block_10 sync_tx_fsm_reset_done_int
       (.GT3_TX_FSM_RESET_DONE_OUT(GT3_TX_FSM_RESET_DONE_OUT),
        .data_out(tx_fsm_reset_done_int_s2),
        .gt3_txusrclk_in(gt3_txusrclk_in));
  LUT3 #(
    .INIT(8'h0E)) 
    time_out_2ms_i_1__6
       (.I0(time_out_2ms_reg_n_0),
        .I1(time_out_2ms),
        .I2(reset_time_out_reg_n_0),
        .O(time_out_2ms_i_1__6_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_2ms_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_2ms_i_1__6_n_0),
        .Q(time_out_2ms_reg_n_0),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h00AE)) 
    time_out_500us_i_1__6
       (.I0(time_out_500us_reg_n_0),
        .I1(time_out_500us_i_2__2_n_0),
        .I2(time_out_500us_i_3__2_n_0),
        .I3(reset_time_out_reg_n_0),
        .O(time_out_500us_i_1__6_n_0));
  LUT5 #(
    .INIT(32'h00000040)) 
    time_out_500us_i_2__2
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[16]),
        .I3(time_out_counter_reg[13]),
        .I4(time_out_500us_i_4__4_n_0),
        .O(time_out_500us_i_2__2_n_0));
  LUT5 #(
    .INIT(32'hFFFFFBFF)) 
    time_out_500us_i_3__2
       (.I0(time_tlock_max_i_5__2_n_0),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[8]),
        .I4(\time_out_counter[0]_i_12__2_n_0 ),
        .O(time_out_500us_i_3__2_n_0));
  LUT4 #(
    .INIT(16'hFF7F)) 
    time_out_500us_i_4__4
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[2]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[9]),
        .O(time_out_500us_i_4__4_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_500us_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_500us_i_1__6_n_0),
        .Q(time_out_500us_reg_n_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \time_out_counter[0]_i_10__2 
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[18]),
        .O(\time_out_counter[0]_i_10__2_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \time_out_counter[0]_i_11__2 
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[3]),
        .I2(time_out_counter_reg[9]),
        .I3(time_out_counter_reg[11]),
        .O(\time_out_counter[0]_i_11__2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \time_out_counter[0]_i_12__2 
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[5]),
        .I2(time_out_counter_reg[15]),
        .I3(time_out_counter_reg[1]),
        .O(\time_out_counter[0]_i_12__2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_1__6 
       (.I0(time_out_2ms),
        .O(time_out_counter));
  LUT5 #(
    .INIT(32'h00000004)) 
    \time_out_counter[0]_i_3__2 
       (.I0(\time_out_counter[0]_i_8__5_n_0 ),
        .I1(\time_out_counter[0]_i_9__3_n_0 ),
        .I2(\time_out_counter[0]_i_10__2_n_0 ),
        .I3(\time_out_counter[0]_i_11__2_n_0 ),
        .I4(\time_out_counter[0]_i_12__2_n_0 ),
        .O(time_out_2ms));
  LUT1 #(
    .INIT(2'h1)) 
    \time_out_counter[0]_i_7__2 
       (.I0(time_out_counter_reg[0]),
        .O(\time_out_counter[0]_i_7__2_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \time_out_counter[0]_i_8__5 
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[0]),
        .I3(time_out_counter_reg[2]),
        .O(\time_out_counter[0]_i_8__5_n_0 ));
  LUT4 #(
    .INIT(16'h0008)) 
    \time_out_counter[0]_i_9__3 
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[4]),
        .I2(time_out_counter_reg[8]),
        .I3(time_out_counter_reg[17]),
        .O(\time_out_counter[0]_i_9__3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__2_n_7 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[0]_i_2__2 
       (.CI(1'b0),
        .CO({\time_out_counter_reg[0]_i_2__2_n_0 ,\time_out_counter_reg[0]_i_2__2_n_1 ,\time_out_counter_reg[0]_i_2__2_n_2 ,\time_out_counter_reg[0]_i_2__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\time_out_counter_reg[0]_i_2__2_n_4 ,\time_out_counter_reg[0]_i_2__2_n_5 ,\time_out_counter_reg[0]_i_2__2_n_6 ,\time_out_counter_reg[0]_i_2__2_n_7 }),
        .S({time_out_counter_reg[3:1],\time_out_counter[0]_i_7__2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[10] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__2_n_5 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[11] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__2_n_4 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[12] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__2_n_7 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[12]_i_1__2 
       (.CI(\time_out_counter_reg[8]_i_1__2_n_0 ),
        .CO({\time_out_counter_reg[12]_i_1__2_n_0 ,\time_out_counter_reg[12]_i_1__2_n_1 ,\time_out_counter_reg[12]_i_1__2_n_2 ,\time_out_counter_reg[12]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[12]_i_1__2_n_4 ,\time_out_counter_reg[12]_i_1__2_n_5 ,\time_out_counter_reg[12]_i_1__2_n_6 ,\time_out_counter_reg[12]_i_1__2_n_7 }),
        .S(time_out_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[13] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__2_n_6 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[14] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__2_n_5 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[15] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[12]_i_1__2_n_4 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[16] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__2_n_7 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[16]_i_1__2 
       (.CI(\time_out_counter_reg[12]_i_1__2_n_0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__2_CO_UNCONNECTED [3:2],\time_out_counter_reg[16]_i_1__2_n_2 ,\time_out_counter_reg[16]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1__2_O_UNCONNECTED [3],\time_out_counter_reg[16]_i_1__2_n_5 ,\time_out_counter_reg[16]_i_1__2_n_6 ,\time_out_counter_reg[16]_i_1__2_n_7 }),
        .S({1'b0,time_out_counter_reg[18:16]}));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[17] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__2_n_6 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[18] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[16]_i_1__2_n_5 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__2_n_6 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__2_n_5 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[0]_i_2__2_n_4 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__2_n_7 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[4]_i_1__2 
       (.CI(\time_out_counter_reg[0]_i_2__2_n_0 ),
        .CO({\time_out_counter_reg[4]_i_1__2_n_0 ,\time_out_counter_reg[4]_i_1__2_n_1 ,\time_out_counter_reg[4]_i_1__2_n_2 ,\time_out_counter_reg[4]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[4]_i_1__2_n_4 ,\time_out_counter_reg[4]_i_1__2_n_5 ,\time_out_counter_reg[4]_i_1__2_n_6 ,\time_out_counter_reg[4]_i_1__2_n_7 }),
        .S(time_out_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__2_n_6 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__2_n_5 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[4]_i_1__2_n_4 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__2_n_7 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out_reg_n_0));
  CARRY4 \time_out_counter_reg[8]_i_1__2 
       (.CI(\time_out_counter_reg[4]_i_1__2_n_0 ),
        .CO({\time_out_counter_reg[8]_i_1__2_n_0 ,\time_out_counter_reg[8]_i_1__2_n_1 ,\time_out_counter_reg[8]_i_1__2_n_2 ,\time_out_counter_reg[8]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\time_out_counter_reg[8]_i_1__2_n_4 ,\time_out_counter_reg[8]_i_1__2_n_5 ,\time_out_counter_reg[8]_i_1__2_n_6 ,\time_out_counter_reg[8]_i_1__2_n_7 }),
        .S(time_out_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \time_out_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(time_out_counter),
        .D(\time_out_counter_reg[8]_i_1__2_n_6 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out_reg_n_0));
  LUT4 #(
    .INIT(16'hAB00)) 
    time_out_wait_bypass_i_1__2
       (.I0(time_out_wait_bypass_reg_n_0),
        .I1(\wait_bypass_count[0]_i_4__2_n_0 ),
        .I2(tx_fsm_reset_done_int_s3_reg_n_0),
        .I3(run_phase_alignment_int_s3_reg_n_0),
        .O(time_out_wait_bypass_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_reg
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(time_out_wait_bypass_i_1__2_n_0),
        .Q(time_out_wait_bypass_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    time_out_wait_bypass_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT4 #(
    .INIT(16'h00AE)) 
    time_tlock_max_i_1__6
       (.I0(time_tlock_max_reg_n_0),
        .I1(time_tlock_max_i_2__2_n_0),
        .I2(time_tlock_max_i_3__2_n_0),
        .I3(reset_time_out_reg_n_0),
        .O(time_tlock_max_i_1__6_n_0));
  LUT5 #(
    .INIT(32'h00000010)) 
    time_tlock_max_i_2__2
       (.I0(time_out_counter_reg[5]),
        .I1(time_out_counter_reg[6]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[2]),
        .I4(time_tlock_max_i_4__2_n_0),
        .O(time_tlock_max_i_2__2_n_0));
  LUT5 #(
    .INIT(32'hFFEFFFFF)) 
    time_tlock_max_i_3__2
       (.I0(time_tlock_max_i_5__2_n_0),
        .I1(time_tlock_max_i_6__2_n_0),
        .I2(time_out_counter_reg[1]),
        .I3(time_out_counter_reg[15]),
        .I4(time_out_counter_reg[4]),
        .O(time_tlock_max_i_3__2_n_0));
  LUT4 #(
    .INIT(16'hFFEF)) 
    time_tlock_max_i_4__2
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[7]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[9]),
        .O(time_tlock_max_i_4__2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    time_tlock_max_i_5__2
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[11]),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[18]),
        .O(time_tlock_max_i_5__2_n_0));
  LUT4 #(
    .INIT(16'hFFFD)) 
    time_tlock_max_i_6__2
       (.I0(time_out_counter_reg[8]),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[0]),
        .I3(time_out_counter_reg[16]),
        .O(time_tlock_max_i_6__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    time_tlock_max_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(time_tlock_max_i_1__6_n_0),
        .Q(time_tlock_max_reg_n_0),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFFF0008)) 
    tx_fsm_reset_done_int_i_1__2
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(tx_state[2]),
        .I3(tx_state[1]),
        .I4(GT3_TX_FSM_RESET_DONE_OUT),
        .O(tx_fsm_reset_done_int_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    tx_fsm_reset_done_int_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_i_1__2_n_0),
        .Q(GT3_TX_FSM_RESET_DONE_OUT),
        .R(SOFT_RESET_IN));
  FDRE #(
    .INIT(1'b0)) 
    tx_fsm_reset_done_int_s3_reg
       (.C(gt3_txusrclk_in),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_s2),
        .Q(tx_fsm_reset_done_int_s3_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    txresetdone_s3_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(txresetdone_s2),
        .Q(txresetdone_s3),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hDFFFFFFF)) 
    \wait_bypass_count[0]_i_10__2 
       (.I0(wait_bypass_count_reg[0]),
        .I1(wait_bypass_count_reg[15]),
        .I2(wait_bypass_count_reg[16]),
        .I3(wait_bypass_count_reg[2]),
        .I4(wait_bypass_count_reg[1]),
        .O(\wait_bypass_count[0]_i_10__2_n_0 ));
  LUT4 #(
    .INIT(16'hFFEF)) 
    \wait_bypass_count[0]_i_11__2 
       (.I0(wait_bypass_count_reg[12]),
        .I1(wait_bypass_count_reg[11]),
        .I2(wait_bypass_count_reg[13]),
        .I3(wait_bypass_count_reg[14]),
        .O(\wait_bypass_count[0]_i_11__2_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \wait_bypass_count[0]_i_12__2 
       (.I0(wait_bypass_count_reg[8]),
        .I1(wait_bypass_count_reg[7]),
        .I2(wait_bypass_count_reg[10]),
        .I3(wait_bypass_count_reg[9]),
        .O(\wait_bypass_count[0]_i_12__2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_1__2 
       (.I0(run_phase_alignment_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_1__2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \wait_bypass_count[0]_i_2__2 
       (.I0(\wait_bypass_count[0]_i_4__2_n_0 ),
        .I1(tx_fsm_reset_done_int_s3_reg_n_0),
        .O(\wait_bypass_count[0]_i_2__2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_bypass_count[0]_i_4__2 
       (.I0(\wait_bypass_count[0]_i_9__2_n_0 ),
        .I1(\wait_bypass_count[0]_i_10__2_n_0 ),
        .I2(\wait_bypass_count[0]_i_11__2_n_0 ),
        .I3(\wait_bypass_count[0]_i_12__2_n_0 ),
        .O(\wait_bypass_count[0]_i_4__2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_bypass_count[0]_i_8__2 
       (.I0(wait_bypass_count_reg[0]),
        .O(\wait_bypass_count[0]_i_8__2_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \wait_bypass_count[0]_i_9__2 
       (.I0(wait_bypass_count_reg[4]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[6]),
        .I3(wait_bypass_count_reg[5]),
        .O(\wait_bypass_count[0]_i_9__2_n_0 ));
  FDRE \wait_bypass_count_reg[0] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__2_n_7 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  CARRY4 \wait_bypass_count_reg[0]_i_3__2 
       (.CI(1'b0),
        .CO({\wait_bypass_count_reg[0]_i_3__2_n_0 ,\wait_bypass_count_reg[0]_i_3__2_n_1 ,\wait_bypass_count_reg[0]_i_3__2_n_2 ,\wait_bypass_count_reg[0]_i_3__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\wait_bypass_count_reg[0]_i_3__2_n_4 ,\wait_bypass_count_reg[0]_i_3__2_n_5 ,\wait_bypass_count_reg[0]_i_3__2_n_6 ,\wait_bypass_count_reg[0]_i_3__2_n_7 }),
        .S({wait_bypass_count_reg[3:1],\wait_bypass_count[0]_i_8__2_n_0 }));
  FDRE \wait_bypass_count_reg[10] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__2_n_5 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[11] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__2_n_4 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[12] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__2_n_7 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  CARRY4 \wait_bypass_count_reg[12]_i_1__2 
       (.CI(\wait_bypass_count_reg[8]_i_1__2_n_0 ),
        .CO({\wait_bypass_count_reg[12]_i_1__2_n_0 ,\wait_bypass_count_reg[12]_i_1__2_n_1 ,\wait_bypass_count_reg[12]_i_1__2_n_2 ,\wait_bypass_count_reg[12]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[12]_i_1__2_n_4 ,\wait_bypass_count_reg[12]_i_1__2_n_5 ,\wait_bypass_count_reg[12]_i_1__2_n_6 ,\wait_bypass_count_reg[12]_i_1__2_n_7 }),
        .S(wait_bypass_count_reg[15:12]));
  FDRE \wait_bypass_count_reg[13] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__2_n_6 ),
        .Q(wait_bypass_count_reg[13]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[14] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__2_n_5 ),
        .Q(wait_bypass_count_reg[14]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[15] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[12]_i_1__2_n_4 ),
        .Q(wait_bypass_count_reg[15]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[16] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[16]_i_1__2_n_7 ),
        .Q(wait_bypass_count_reg[16]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  CARRY4 \wait_bypass_count_reg[16]_i_1__2 
       (.CI(\wait_bypass_count_reg[12]_i_1__2_n_0 ),
        .CO(\NLW_wait_bypass_count_reg[16]_i_1__2_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[16]_i_1__2_O_UNCONNECTED [3:1],\wait_bypass_count_reg[16]_i_1__2_n_7 }),
        .S({1'b0,1'b0,1'b0,wait_bypass_count_reg[16]}));
  FDRE \wait_bypass_count_reg[1] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__2_n_6 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[2] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__2_n_5 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[3] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[0]_i_3__2_n_4 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[4] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__2_n_7 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  CARRY4 \wait_bypass_count_reg[4]_i_1__2 
       (.CI(\wait_bypass_count_reg[0]_i_3__2_n_0 ),
        .CO({\wait_bypass_count_reg[4]_i_1__2_n_0 ,\wait_bypass_count_reg[4]_i_1__2_n_1 ,\wait_bypass_count_reg[4]_i_1__2_n_2 ,\wait_bypass_count_reg[4]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[4]_i_1__2_n_4 ,\wait_bypass_count_reg[4]_i_1__2_n_5 ,\wait_bypass_count_reg[4]_i_1__2_n_6 ,\wait_bypass_count_reg[4]_i_1__2_n_7 }),
        .S(wait_bypass_count_reg[7:4]));
  FDRE \wait_bypass_count_reg[5] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__2_n_6 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[6] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__2_n_5 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[7] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[4]_i_1__2_n_4 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  FDRE \wait_bypass_count_reg[8] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__2_n_7 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  CARRY4 \wait_bypass_count_reg[8]_i_1__2 
       (.CI(\wait_bypass_count_reg[4]_i_1__2_n_0 ),
        .CO({\wait_bypass_count_reg[8]_i_1__2_n_0 ,\wait_bypass_count_reg[8]_i_1__2_n_1 ,\wait_bypass_count_reg[8]_i_1__2_n_2 ,\wait_bypass_count_reg[8]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\wait_bypass_count_reg[8]_i_1__2_n_4 ,\wait_bypass_count_reg[8]_i_1__2_n_5 ,\wait_bypass_count_reg[8]_i_1__2_n_6 ,\wait_bypass_count_reg[8]_i_1__2_n_7 }),
        .S(wait_bypass_count_reg[11:8]));
  FDRE \wait_bypass_count_reg[9] 
       (.C(gt3_txusrclk_in),
        .CE(\wait_bypass_count[0]_i_2__2_n_0 ),
        .D(\wait_bypass_count_reg[8]_i_1__2_n_6 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\wait_bypass_count[0]_i_1__2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \wait_time_cnt[0]_i_1__2 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \wait_time_cnt[1]_i_1__2 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .O(\wait_time_cnt[1]_i_1__2_n_0 ));
  LUT3 #(
    .INIT(8'hE1)) 
    \wait_time_cnt[2]_i_1__2 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[2]),
        .O(wait_time_cnt0[2]));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \wait_time_cnt[3]_i_1__2 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0[3]));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \wait_time_cnt[4]_i_1__2 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(\wait_time_cnt[4]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
    \wait_time_cnt[5]_i_1__2 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[5]));
  LUT4 #(
    .INIT(16'h1030)) 
    \wait_time_cnt[6]_i_1__2 
       (.I0(tx_state[2]),
        .I1(tx_state[3]),
        .I2(tx_state[0]),
        .I3(tx_state[1]),
        .O(\wait_time_cnt[6]_i_1__2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_2__2 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\wait_time_cnt[6]_i_4__2_n_0 ),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(wait_time_cnt_reg__0[5]),
        .O(\wait_time_cnt[6]_i_2__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \wait_time_cnt[6]_i_3__2 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(wait_time_cnt_reg__0[5]),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(\wait_time_cnt[6]_i_4__2_n_0 ),
        .O(wait_time_cnt0[6]));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \wait_time_cnt[6]_i_4__2 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[2]),
        .O(\wait_time_cnt[6]_i_4__2_n_0 ));
  FDRE \wait_time_cnt_reg[0] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__2_n_0 ),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\wait_time_cnt[6]_i_1__2_n_0 ));
  FDRE \wait_time_cnt_reg[1] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__2_n_0 ),
        .D(\wait_time_cnt[1]_i_1__2_n_0 ),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\wait_time_cnt[6]_i_1__2_n_0 ));
  FDSE \wait_time_cnt_reg[2] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__2_n_0 ),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\wait_time_cnt[6]_i_1__2_n_0 ));
  FDRE \wait_time_cnt_reg[3] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__2_n_0 ),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\wait_time_cnt[6]_i_1__2_n_0 ));
  FDRE \wait_time_cnt_reg[4] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__2_n_0 ),
        .D(\wait_time_cnt[4]_i_1__2_n_0 ),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\wait_time_cnt[6]_i_1__2_n_0 ));
  FDSE \wait_time_cnt_reg[5] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__2_n_0 ),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\wait_time_cnt[6]_i_1__2_n_0 ));
  FDSE \wait_time_cnt_reg[6] 
       (.C(SYSCLK_IN),
        .CE(\wait_time_cnt[6]_i_2__2_n_0 ),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\wait_time_cnt[6]_i_1__2_n_0 ));
endmodule

(* EXAMPLE_SIMULATION = "0" *) (* EXAMPLE_SIM_GTRESET_SPEEDUP = "TRUE" *) (* EXAMPLE_USE_CHIPSCOPE = "0" *) 
(* ORIG_REF_NAME = "XLAUI_init" *) (* STABLE_CLOCK_PERIOD = "6" *) (* downgradeipidentifiedwarnings = "yes" *) 
module XLAUI_XLAUI_init
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
  wire RXOUTCLK;
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
  wire gt0_gtrxreset_t;
  wire gt0_gttxreset_t;
  wire [2:0]gt0_loopback_in;
  wire gt0_rx_cdrlock_counter;
  wire \gt0_rx_cdrlock_counter[0]_i_1_n_0 ;
  wire \gt0_rx_cdrlock_counter[9]_i_3_n_0 ;
  wire \gt0_rx_cdrlock_counter[9]_i_4_n_0 ;
  wire [9:0]gt0_rx_cdrlock_counter_reg__0;
  wire gt0_rx_cdrlocked;
  wire gt0_rx_cdrlocked_reg_n_0;
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
  wire gt0_rxpmaresetdone_i;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire gt0_rxresetdone_out;
  wire gt0_rxresetfsm_i_n_4;
  wire gt0_rxuserrdy_t;
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
  wire gt0_txuserrdy_t;
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
  wire gt1_gtrxreset_t;
  wire gt1_gttxreset_t;
  wire [2:0]gt1_loopback_in;
  wire gt1_rx_cdrlock_counter;
  wire \gt1_rx_cdrlock_counter[0]_i_1_n_0 ;
  wire \gt1_rx_cdrlock_counter[9]_i_3_n_0 ;
  wire \gt1_rx_cdrlock_counter[9]_i_4_n_0 ;
  wire [9:0]gt1_rx_cdrlock_counter_reg__0;
  wire gt1_rx_cdrlocked;
  wire gt1_rx_cdrlocked_reg_n_0;
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
  wire gt1_rxpmaresetdone_i;
  wire gt1_rxprbscntreset_in;
  wire gt1_rxprbserr_out;
  wire [2:0]gt1_rxprbssel_in;
  wire gt1_rxresetdone_out;
  wire gt1_rxresetfsm_i_n_4;
  wire gt1_rxuserrdy_t;
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
  wire gt1_txuserrdy_t;
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
  wire gt2_gtrxreset_t;
  wire gt2_gttxreset_t;
  wire [2:0]gt2_loopback_in;
  wire gt2_rx_cdrlock_counter;
  wire \gt2_rx_cdrlock_counter[0]_i_1_n_0 ;
  wire \gt2_rx_cdrlock_counter[9]_i_3_n_0 ;
  wire \gt2_rx_cdrlock_counter[9]_i_4_n_0 ;
  wire [9:0]gt2_rx_cdrlock_counter_reg__0;
  wire gt2_rx_cdrlocked;
  wire gt2_rx_cdrlocked_reg_n_0;
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
  wire gt2_rxpmaresetdone_i;
  wire gt2_rxprbscntreset_in;
  wire gt2_rxprbserr_out;
  wire [2:0]gt2_rxprbssel_in;
  wire gt2_rxresetdone_out;
  wire gt2_rxresetfsm_i_n_4;
  wire gt2_rxuserrdy_t;
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
  wire gt2_txuserrdy_t;
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
  wire gt3_gtrxreset_t;
  wire gt3_gttxreset_t;
  wire [2:0]gt3_loopback_in;
  wire gt3_rx_cdrlock_counter;
  wire \gt3_rx_cdrlock_counter[0]_i_1_n_0 ;
  wire \gt3_rx_cdrlock_counter[9]_i_3_n_0 ;
  wire \gt3_rx_cdrlock_counter[9]_i_4_n_0 ;
  wire [9:0]gt3_rx_cdrlock_counter_reg__0;
  wire gt3_rx_cdrlocked;
  wire gt3_rx_cdrlocked_reg_n_0;
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
  wire gt3_rxpmaresetdone_i;
  wire gt3_rxprbscntreset_in;
  wire gt3_rxprbserr_out;
  wire [2:0]gt3_rxprbssel_in;
  wire gt3_rxresetdone_out;
  wire gt3_rxresetfsm_i_n_4;
  wire gt3_rxuserrdy_t;
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
  wire gt3_txuserrdy_t;
  wire gt3_txusrclk2_in;
  wire gt3_txusrclk_in;
  wire [9:1]p_0_in;
  wire [9:1]p_0_in__0;
  wire [9:1]p_0_in__1;
  wire [9:1]p_0_in__2;

  XLAUI_XLAUI_multi_gt XLAUI_i
       (.GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT0_RXPMARESETDONE_OUT(gt0_rxpmaresetdone_i),
        .GT1_RXPMARESETDONE_OUT(gt1_rxpmaresetdone_i),
        .GT2_RXPMARESETDONE_OUT(gt2_rxpmaresetdone_i),
        .GT3_RXPMARESETDONE_OUT(gt3_rxpmaresetdone_i),
        .SR(gt0_gtrxreset_t),
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
        .gt0_gttxreset_in(gt0_gttxreset_t),
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
        .gt0_rxuserrdy_in(gt0_rxuserrdy_t),
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
        .gt0_txuserrdy_in(gt0_txuserrdy_t),
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
        .gt1_gttxreset_in(gt1_gttxreset_t),
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
        .gt1_rxuserrdy_in(gt1_rxuserrdy_t),
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
        .gt1_txuserrdy_in(gt1_txuserrdy_t),
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
        .gt2_gttxreset_in(gt2_gttxreset_t),
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
        .gt2_rxuserrdy_in(gt2_rxuserrdy_t),
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
        .gt2_txuserrdy_in(gt2_txuserrdy_t),
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
        .gt3_gttxreset_in(gt3_gttxreset_t),
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
        .gt3_rxuserrdy_in(gt3_rxuserrdy_t),
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
        .gt3_txuserrdy_in(gt3_txuserrdy_t),
        .gt3_txusrclk2_in(gt3_txusrclk2_in),
        .gt3_txusrclk_in(gt3_txusrclk_in),
        .gtrxreset_i_reg(gt1_gtrxreset_t),
        .gtrxreset_i_reg_0(gt2_gtrxreset_t),
        .gtrxreset_i_reg_1(gt3_gtrxreset_t));
  (* SOFT_HLUTNM = "soft_lutpair135" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \gt0_rx_cdrlock_counter[0]_i_1 
       (.I0(gt0_rx_cdrlock_counter_reg__0[0]),
        .O(\gt0_rx_cdrlock_counter[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair135" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \gt0_rx_cdrlock_counter[1]_i_1 
       (.I0(gt0_rx_cdrlock_counter_reg__0[1]),
        .I1(gt0_rx_cdrlock_counter_reg__0[0]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \gt0_rx_cdrlock_counter[2]_i_1 
       (.I0(gt0_rx_cdrlock_counter_reg__0[2]),
        .I1(gt0_rx_cdrlock_counter_reg__0[1]),
        .I2(gt0_rx_cdrlock_counter_reg__0[0]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gt0_rx_cdrlock_counter[3]_i_1 
       (.I0(gt0_rx_cdrlock_counter_reg__0[3]),
        .I1(gt0_rx_cdrlock_counter_reg__0[0]),
        .I2(gt0_rx_cdrlock_counter_reg__0[1]),
        .I3(gt0_rx_cdrlock_counter_reg__0[2]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \gt0_rx_cdrlock_counter[4]_i_1 
       (.I0(gt0_rx_cdrlock_counter_reg__0[2]),
        .I1(gt0_rx_cdrlock_counter_reg__0[1]),
        .I2(gt0_rx_cdrlock_counter_reg__0[0]),
        .I3(gt0_rx_cdrlock_counter_reg__0[3]),
        .I4(gt0_rx_cdrlock_counter_reg__0[4]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \gt0_rx_cdrlock_counter[5]_i_1 
       (.I0(gt0_rx_cdrlock_counter_reg__0[5]),
        .I1(gt0_rx_cdrlock_counter_reg__0[2]),
        .I2(gt0_rx_cdrlock_counter_reg__0[1]),
        .I3(gt0_rx_cdrlock_counter_reg__0[0]),
        .I4(gt0_rx_cdrlock_counter_reg__0[3]),
        .I5(gt0_rx_cdrlock_counter_reg__0[4]),
        .O(p_0_in[5]));
  LUT3 #(
    .INIT(8'h6A)) 
    \gt0_rx_cdrlock_counter[6]_i_1 
       (.I0(gt0_rx_cdrlock_counter_reg__0[6]),
        .I1(\gt0_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I2(gt0_rx_cdrlock_counter_reg__0[5]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gt0_rx_cdrlock_counter[7]_i_1 
       (.I0(gt0_rx_cdrlock_counter_reg__0[7]),
        .I1(gt0_rx_cdrlock_counter_reg__0[5]),
        .I2(\gt0_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I3(gt0_rx_cdrlock_counter_reg__0[6]),
        .O(p_0_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \gt0_rx_cdrlock_counter[8]_i_1 
       (.I0(gt0_rx_cdrlock_counter_reg__0[8]),
        .I1(gt0_rx_cdrlock_counter_reg__0[6]),
        .I2(\gt0_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I3(gt0_rx_cdrlock_counter_reg__0[5]),
        .I4(gt0_rx_cdrlock_counter_reg__0[7]),
        .O(p_0_in[8]));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \gt0_rx_cdrlock_counter[9]_i_1 
       (.I0(\gt0_rx_cdrlock_counter[9]_i_3_n_0 ),
        .I1(gt0_rx_cdrlock_counter_reg__0[4]),
        .I2(gt0_rx_cdrlock_counter_reg__0[3]),
        .I3(gt0_rx_cdrlock_counter_reg__0[8]),
        .I4(gt0_rx_cdrlock_counter_reg__0[2]),
        .O(gt0_rx_cdrlock_counter));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \gt0_rx_cdrlock_counter[9]_i_2 
       (.I0(gt0_rx_cdrlock_counter_reg__0[9]),
        .I1(gt0_rx_cdrlock_counter_reg__0[7]),
        .I2(gt0_rx_cdrlock_counter_reg__0[5]),
        .I3(\gt0_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I4(gt0_rx_cdrlock_counter_reg__0[6]),
        .I5(gt0_rx_cdrlock_counter_reg__0[8]),
        .O(p_0_in[9]));
  LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
    \gt0_rx_cdrlock_counter[9]_i_3 
       (.I0(gt0_rx_cdrlock_counter_reg__0[9]),
        .I1(gt0_rx_cdrlock_counter_reg__0[7]),
        .I2(gt0_rx_cdrlock_counter_reg__0[5]),
        .I3(gt0_rx_cdrlock_counter_reg__0[0]),
        .I4(gt0_rx_cdrlock_counter_reg__0[1]),
        .I5(gt0_rx_cdrlock_counter_reg__0[6]),
        .O(\gt0_rx_cdrlock_counter[9]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \gt0_rx_cdrlock_counter[9]_i_4 
       (.I0(gt0_rx_cdrlock_counter_reg__0[4]),
        .I1(gt0_rx_cdrlock_counter_reg__0[3]),
        .I2(gt0_rx_cdrlock_counter_reg__0[0]),
        .I3(gt0_rx_cdrlock_counter_reg__0[1]),
        .I4(gt0_rx_cdrlock_counter_reg__0[2]),
        .O(\gt0_rx_cdrlock_counter[9]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gt0_rx_cdrlock_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(gt0_rx_cdrlock_counter),
        .D(\gt0_rx_cdrlock_counter[0]_i_1_n_0 ),
        .Q(gt0_rx_cdrlock_counter_reg__0[0]),
        .R(gt0_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt0_rx_cdrlock_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(gt0_rx_cdrlock_counter),
        .D(p_0_in[1]),
        .Q(gt0_rx_cdrlock_counter_reg__0[1]),
        .R(gt0_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt0_rx_cdrlock_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(gt0_rx_cdrlock_counter),
        .D(p_0_in[2]),
        .Q(gt0_rx_cdrlock_counter_reg__0[2]),
        .R(gt0_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt0_rx_cdrlock_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(gt0_rx_cdrlock_counter),
        .D(p_0_in[3]),
        .Q(gt0_rx_cdrlock_counter_reg__0[3]),
        .R(gt0_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt0_rx_cdrlock_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(gt0_rx_cdrlock_counter),
        .D(p_0_in[4]),
        .Q(gt0_rx_cdrlock_counter_reg__0[4]),
        .R(gt0_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt0_rx_cdrlock_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(gt0_rx_cdrlock_counter),
        .D(p_0_in[5]),
        .Q(gt0_rx_cdrlock_counter_reg__0[5]),
        .R(gt0_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt0_rx_cdrlock_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(gt0_rx_cdrlock_counter),
        .D(p_0_in[6]),
        .Q(gt0_rx_cdrlock_counter_reg__0[6]),
        .R(gt0_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt0_rx_cdrlock_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(gt0_rx_cdrlock_counter),
        .D(p_0_in[7]),
        .Q(gt0_rx_cdrlock_counter_reg__0[7]),
        .R(gt0_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt0_rx_cdrlock_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(gt0_rx_cdrlock_counter),
        .D(p_0_in[8]),
        .Q(gt0_rx_cdrlock_counter_reg__0[8]),
        .R(gt0_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt0_rx_cdrlock_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(gt0_rx_cdrlock_counter),
        .D(p_0_in[9]),
        .Q(gt0_rx_cdrlock_counter_reg__0[9]),
        .R(gt0_gtrxreset_t));
  LUT5 #(
    .INIT(32'h00000004)) 
    gt0_rx_cdrlocked_i_2
       (.I0(gt0_rx_cdrlock_counter_reg__0[2]),
        .I1(gt0_rx_cdrlock_counter_reg__0[8]),
        .I2(gt0_rx_cdrlock_counter_reg__0[3]),
        .I3(gt0_rx_cdrlock_counter_reg__0[4]),
        .I4(\gt0_rx_cdrlock_counter[9]_i_3_n_0 ),
        .O(gt0_rx_cdrlocked));
  FDRE gt0_rx_cdrlocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt0_rxresetfsm_i_n_4),
        .Q(gt0_rx_cdrlocked_reg_n_0),
        .R(1'b0));
  XLAUI_XLAUI_RX_STARTUP_FSM gt0_rxresetfsm_i
       (.DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .GT0_DATA_VALID_IN(GT0_DATA_VALID_IN),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT0_RX_FSM_RESET_DONE_OUT(GT0_RX_FSM_RESET_DONE_OUT),
        .GT0_RX_MMCM_LOCK_IN(GT0_RX_MMCM_LOCK_IN),
        .GT0_RX_MMCM_RESET_OUT(GT0_RX_MMCM_RESET_OUT),
        .RXOUTCLK(RXOUTCLK),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SR(gt0_gtrxreset_t),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(gt0_rxpmaresetdone_i),
        .gt0_rx_cdrlocked(gt0_rx_cdrlocked),
        .gt0_rx_cdrlocked_reg(gt0_rxresetfsm_i_n_4),
        .gt0_rx_cdrlocked_reg_0(gt0_rx_cdrlocked_reg_n_0),
        .gt0_rxresetdone_out(gt0_rxresetdone_out),
        .gt0_rxuserrdy_in(gt0_rxuserrdy_t),
        .gt0_rxusrclk_in(gt0_rxusrclk_in));
  XLAUI_XLAUI_TX_STARTUP_FSM gt0_txresetfsm_i
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT0_QPLLRESET_OUT(GT0_QPLLRESET_OUT),
        .GT0_TX_FSM_RESET_DONE_OUT(GT0_TX_FSM_RESET_DONE_OUT),
        .GT0_TX_MMCM_LOCK_IN(GT0_TX_MMCM_LOCK_IN),
        .GT0_TX_MMCM_RESET_OUT(GT0_TX_MMCM_RESET_OUT),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .gt0_gttxreset_in(gt0_gttxreset_t),
        .gt0_txresetdone_out(gt0_txresetdone_out),
        .gt0_txuserrdy_in(gt0_txuserrdy_t),
        .gt0_txusrclk_in(gt0_txusrclk_in));
  (* SOFT_HLUTNM = "soft_lutpair133" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \gt1_rx_cdrlock_counter[0]_i_1 
       (.I0(gt1_rx_cdrlock_counter_reg__0[0]),
        .O(\gt1_rx_cdrlock_counter[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair133" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \gt1_rx_cdrlock_counter[1]_i_1 
       (.I0(gt1_rx_cdrlock_counter_reg__0[1]),
        .I1(gt1_rx_cdrlock_counter_reg__0[0]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair131" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \gt1_rx_cdrlock_counter[2]_i_1 
       (.I0(gt1_rx_cdrlock_counter_reg__0[2]),
        .I1(gt1_rx_cdrlock_counter_reg__0[1]),
        .I2(gt1_rx_cdrlock_counter_reg__0[0]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair131" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gt1_rx_cdrlock_counter[3]_i_1 
       (.I0(gt1_rx_cdrlock_counter_reg__0[3]),
        .I1(gt1_rx_cdrlock_counter_reg__0[0]),
        .I2(gt1_rx_cdrlock_counter_reg__0[1]),
        .I3(gt1_rx_cdrlock_counter_reg__0[2]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \gt1_rx_cdrlock_counter[4]_i_1 
       (.I0(gt1_rx_cdrlock_counter_reg__0[2]),
        .I1(gt1_rx_cdrlock_counter_reg__0[1]),
        .I2(gt1_rx_cdrlock_counter_reg__0[0]),
        .I3(gt1_rx_cdrlock_counter_reg__0[3]),
        .I4(gt1_rx_cdrlock_counter_reg__0[4]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \gt1_rx_cdrlock_counter[5]_i_1 
       (.I0(gt1_rx_cdrlock_counter_reg__0[5]),
        .I1(gt1_rx_cdrlock_counter_reg__0[2]),
        .I2(gt1_rx_cdrlock_counter_reg__0[1]),
        .I3(gt1_rx_cdrlock_counter_reg__0[0]),
        .I4(gt1_rx_cdrlock_counter_reg__0[3]),
        .I5(gt1_rx_cdrlock_counter_reg__0[4]),
        .O(p_0_in__0[5]));
  LUT3 #(
    .INIT(8'h6A)) 
    \gt1_rx_cdrlock_counter[6]_i_1 
       (.I0(gt1_rx_cdrlock_counter_reg__0[6]),
        .I1(\gt1_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I2(gt1_rx_cdrlock_counter_reg__0[5]),
        .O(p_0_in__0[6]));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gt1_rx_cdrlock_counter[7]_i_1 
       (.I0(gt1_rx_cdrlock_counter_reg__0[7]),
        .I1(gt1_rx_cdrlock_counter_reg__0[5]),
        .I2(\gt1_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I3(gt1_rx_cdrlock_counter_reg__0[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \gt1_rx_cdrlock_counter[8]_i_1 
       (.I0(gt1_rx_cdrlock_counter_reg__0[8]),
        .I1(gt1_rx_cdrlock_counter_reg__0[6]),
        .I2(\gt1_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I3(gt1_rx_cdrlock_counter_reg__0[5]),
        .I4(gt1_rx_cdrlock_counter_reg__0[7]),
        .O(p_0_in__0[8]));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \gt1_rx_cdrlock_counter[9]_i_1 
       (.I0(\gt1_rx_cdrlock_counter[9]_i_3_n_0 ),
        .I1(gt1_rx_cdrlock_counter_reg__0[4]),
        .I2(gt1_rx_cdrlock_counter_reg__0[3]),
        .I3(gt1_rx_cdrlock_counter_reg__0[8]),
        .I4(gt1_rx_cdrlock_counter_reg__0[2]),
        .O(gt1_rx_cdrlock_counter));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \gt1_rx_cdrlock_counter[9]_i_2 
       (.I0(gt1_rx_cdrlock_counter_reg__0[9]),
        .I1(gt1_rx_cdrlock_counter_reg__0[7]),
        .I2(gt1_rx_cdrlock_counter_reg__0[5]),
        .I3(\gt1_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I4(gt1_rx_cdrlock_counter_reg__0[6]),
        .I5(gt1_rx_cdrlock_counter_reg__0[8]),
        .O(p_0_in__0[9]));
  LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
    \gt1_rx_cdrlock_counter[9]_i_3 
       (.I0(gt1_rx_cdrlock_counter_reg__0[9]),
        .I1(gt1_rx_cdrlock_counter_reg__0[7]),
        .I2(gt1_rx_cdrlock_counter_reg__0[5]),
        .I3(gt1_rx_cdrlock_counter_reg__0[0]),
        .I4(gt1_rx_cdrlock_counter_reg__0[1]),
        .I5(gt1_rx_cdrlock_counter_reg__0[6]),
        .O(\gt1_rx_cdrlock_counter[9]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \gt1_rx_cdrlock_counter[9]_i_4 
       (.I0(gt1_rx_cdrlock_counter_reg__0[4]),
        .I1(gt1_rx_cdrlock_counter_reg__0[3]),
        .I2(gt1_rx_cdrlock_counter_reg__0[0]),
        .I3(gt1_rx_cdrlock_counter_reg__0[1]),
        .I4(gt1_rx_cdrlock_counter_reg__0[2]),
        .O(\gt1_rx_cdrlock_counter[9]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gt1_rx_cdrlock_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(gt1_rx_cdrlock_counter),
        .D(\gt1_rx_cdrlock_counter[0]_i_1_n_0 ),
        .Q(gt1_rx_cdrlock_counter_reg__0[0]),
        .R(gt1_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt1_rx_cdrlock_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(gt1_rx_cdrlock_counter),
        .D(p_0_in__0[1]),
        .Q(gt1_rx_cdrlock_counter_reg__0[1]),
        .R(gt1_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt1_rx_cdrlock_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(gt1_rx_cdrlock_counter),
        .D(p_0_in__0[2]),
        .Q(gt1_rx_cdrlock_counter_reg__0[2]),
        .R(gt1_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt1_rx_cdrlock_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(gt1_rx_cdrlock_counter),
        .D(p_0_in__0[3]),
        .Q(gt1_rx_cdrlock_counter_reg__0[3]),
        .R(gt1_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt1_rx_cdrlock_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(gt1_rx_cdrlock_counter),
        .D(p_0_in__0[4]),
        .Q(gt1_rx_cdrlock_counter_reg__0[4]),
        .R(gt1_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt1_rx_cdrlock_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(gt1_rx_cdrlock_counter),
        .D(p_0_in__0[5]),
        .Q(gt1_rx_cdrlock_counter_reg__0[5]),
        .R(gt1_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt1_rx_cdrlock_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(gt1_rx_cdrlock_counter),
        .D(p_0_in__0[6]),
        .Q(gt1_rx_cdrlock_counter_reg__0[6]),
        .R(gt1_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt1_rx_cdrlock_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(gt1_rx_cdrlock_counter),
        .D(p_0_in__0[7]),
        .Q(gt1_rx_cdrlock_counter_reg__0[7]),
        .R(gt1_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt1_rx_cdrlock_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(gt1_rx_cdrlock_counter),
        .D(p_0_in__0[8]),
        .Q(gt1_rx_cdrlock_counter_reg__0[8]),
        .R(gt1_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt1_rx_cdrlock_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(gt1_rx_cdrlock_counter),
        .D(p_0_in__0[9]),
        .Q(gt1_rx_cdrlock_counter_reg__0[9]),
        .R(gt1_gtrxreset_t));
  LUT5 #(
    .INIT(32'h00000004)) 
    gt1_rx_cdrlocked_i_2
       (.I0(gt1_rx_cdrlock_counter_reg__0[2]),
        .I1(gt1_rx_cdrlock_counter_reg__0[8]),
        .I2(gt1_rx_cdrlock_counter_reg__0[3]),
        .I3(gt1_rx_cdrlock_counter_reg__0[4]),
        .I4(\gt1_rx_cdrlock_counter[9]_i_3_n_0 ),
        .O(gt1_rx_cdrlocked));
  FDRE gt1_rx_cdrlocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt1_rxresetfsm_i_n_4),
        .Q(gt1_rx_cdrlocked_reg_n_0),
        .R(1'b0));
  XLAUI_XLAUI_RX_STARTUP_FSM_0 gt1_rxresetfsm_i
       (.DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT1_DATA_VALID_IN(GT1_DATA_VALID_IN),
        .GT1_RX_FSM_RESET_DONE_OUT(GT1_RX_FSM_RESET_DONE_OUT),
        .GT1_RX_MMCM_LOCK_IN(GT1_RX_MMCM_LOCK_IN),
        .GT1_RX_MMCM_RESET_OUT(GT1_RX_MMCM_RESET_OUT),
        .RXOUTCLK(RXOUTCLK),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(gt1_rxpmaresetdone_i),
        .gt1_rx_cdrlocked(gt1_rx_cdrlocked),
        .gt1_rx_cdrlocked_reg(gt1_rxresetfsm_i_n_4),
        .gt1_rx_cdrlocked_reg_0(gt1_rx_cdrlocked_reg_n_0),
        .gt1_rxresetdone_out(gt1_rxresetdone_out),
        .gt1_rxuserrdy_in(gt1_rxuserrdy_t),
        .gt1_rxusrclk_in(gt1_rxusrclk_in),
        .reset_sync1_rx_0(gt1_gtrxreset_t));
  XLAUI_XLAUI_TX_STARTUP_FSM_1 gt1_txresetfsm_i
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT1_TX_FSM_RESET_DONE_OUT(GT1_TX_FSM_RESET_DONE_OUT),
        .GT1_TX_MMCM_LOCK_IN(GT1_TX_MMCM_LOCK_IN),
        .GT1_TX_MMCM_RESET_OUT(GT1_TX_MMCM_RESET_OUT),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .gt1_gttxreset_in(gt1_gttxreset_t),
        .gt1_txresetdone_out(gt1_txresetdone_out),
        .gt1_txuserrdy_in(gt1_txuserrdy_t),
        .gt1_txusrclk_in(gt1_txusrclk_in));
  (* SOFT_HLUTNM = "soft_lutpair132" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \gt2_rx_cdrlock_counter[0]_i_1 
       (.I0(gt2_rx_cdrlock_counter_reg__0[0]),
        .O(\gt2_rx_cdrlock_counter[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair132" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \gt2_rx_cdrlock_counter[1]_i_1 
       (.I0(gt2_rx_cdrlock_counter_reg__0[1]),
        .I1(gt2_rx_cdrlock_counter_reg__0[0]),
        .O(p_0_in__1[1]));
  (* SOFT_HLUTNM = "soft_lutpair130" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \gt2_rx_cdrlock_counter[2]_i_1 
       (.I0(gt2_rx_cdrlock_counter_reg__0[2]),
        .I1(gt2_rx_cdrlock_counter_reg__0[1]),
        .I2(gt2_rx_cdrlock_counter_reg__0[0]),
        .O(p_0_in__1[2]));
  (* SOFT_HLUTNM = "soft_lutpair130" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gt2_rx_cdrlock_counter[3]_i_1 
       (.I0(gt2_rx_cdrlock_counter_reg__0[3]),
        .I1(gt2_rx_cdrlock_counter_reg__0[0]),
        .I2(gt2_rx_cdrlock_counter_reg__0[1]),
        .I3(gt2_rx_cdrlock_counter_reg__0[2]),
        .O(p_0_in__1[3]));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \gt2_rx_cdrlock_counter[4]_i_1 
       (.I0(gt2_rx_cdrlock_counter_reg__0[2]),
        .I1(gt2_rx_cdrlock_counter_reg__0[1]),
        .I2(gt2_rx_cdrlock_counter_reg__0[0]),
        .I3(gt2_rx_cdrlock_counter_reg__0[3]),
        .I4(gt2_rx_cdrlock_counter_reg__0[4]),
        .O(p_0_in__1[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \gt2_rx_cdrlock_counter[5]_i_1 
       (.I0(gt2_rx_cdrlock_counter_reg__0[5]),
        .I1(gt2_rx_cdrlock_counter_reg__0[2]),
        .I2(gt2_rx_cdrlock_counter_reg__0[1]),
        .I3(gt2_rx_cdrlock_counter_reg__0[0]),
        .I4(gt2_rx_cdrlock_counter_reg__0[3]),
        .I5(gt2_rx_cdrlock_counter_reg__0[4]),
        .O(p_0_in__1[5]));
  LUT3 #(
    .INIT(8'h6A)) 
    \gt2_rx_cdrlock_counter[6]_i_1 
       (.I0(gt2_rx_cdrlock_counter_reg__0[6]),
        .I1(\gt2_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I2(gt2_rx_cdrlock_counter_reg__0[5]),
        .O(p_0_in__1[6]));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gt2_rx_cdrlock_counter[7]_i_1 
       (.I0(gt2_rx_cdrlock_counter_reg__0[7]),
        .I1(gt2_rx_cdrlock_counter_reg__0[5]),
        .I2(\gt2_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I3(gt2_rx_cdrlock_counter_reg__0[6]),
        .O(p_0_in__1[7]));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \gt2_rx_cdrlock_counter[8]_i_1 
       (.I0(gt2_rx_cdrlock_counter_reg__0[8]),
        .I1(gt2_rx_cdrlock_counter_reg__0[6]),
        .I2(\gt2_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I3(gt2_rx_cdrlock_counter_reg__0[5]),
        .I4(gt2_rx_cdrlock_counter_reg__0[7]),
        .O(p_0_in__1[8]));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \gt2_rx_cdrlock_counter[9]_i_1 
       (.I0(\gt2_rx_cdrlock_counter[9]_i_3_n_0 ),
        .I1(gt2_rx_cdrlock_counter_reg__0[4]),
        .I2(gt2_rx_cdrlock_counter_reg__0[3]),
        .I3(gt2_rx_cdrlock_counter_reg__0[8]),
        .I4(gt2_rx_cdrlock_counter_reg__0[2]),
        .O(gt2_rx_cdrlock_counter));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \gt2_rx_cdrlock_counter[9]_i_2 
       (.I0(gt2_rx_cdrlock_counter_reg__0[9]),
        .I1(gt2_rx_cdrlock_counter_reg__0[7]),
        .I2(gt2_rx_cdrlock_counter_reg__0[5]),
        .I3(\gt2_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I4(gt2_rx_cdrlock_counter_reg__0[6]),
        .I5(gt2_rx_cdrlock_counter_reg__0[8]),
        .O(p_0_in__1[9]));
  LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
    \gt2_rx_cdrlock_counter[9]_i_3 
       (.I0(gt2_rx_cdrlock_counter_reg__0[9]),
        .I1(gt2_rx_cdrlock_counter_reg__0[7]),
        .I2(gt2_rx_cdrlock_counter_reg__0[5]),
        .I3(gt2_rx_cdrlock_counter_reg__0[0]),
        .I4(gt2_rx_cdrlock_counter_reg__0[1]),
        .I5(gt2_rx_cdrlock_counter_reg__0[6]),
        .O(\gt2_rx_cdrlock_counter[9]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \gt2_rx_cdrlock_counter[9]_i_4 
       (.I0(gt2_rx_cdrlock_counter_reg__0[4]),
        .I1(gt2_rx_cdrlock_counter_reg__0[3]),
        .I2(gt2_rx_cdrlock_counter_reg__0[0]),
        .I3(gt2_rx_cdrlock_counter_reg__0[1]),
        .I4(gt2_rx_cdrlock_counter_reg__0[2]),
        .O(\gt2_rx_cdrlock_counter[9]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gt2_rx_cdrlock_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(gt2_rx_cdrlock_counter),
        .D(\gt2_rx_cdrlock_counter[0]_i_1_n_0 ),
        .Q(gt2_rx_cdrlock_counter_reg__0[0]),
        .R(gt2_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt2_rx_cdrlock_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(gt2_rx_cdrlock_counter),
        .D(p_0_in__1[1]),
        .Q(gt2_rx_cdrlock_counter_reg__0[1]),
        .R(gt2_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt2_rx_cdrlock_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(gt2_rx_cdrlock_counter),
        .D(p_0_in__1[2]),
        .Q(gt2_rx_cdrlock_counter_reg__0[2]),
        .R(gt2_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt2_rx_cdrlock_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(gt2_rx_cdrlock_counter),
        .D(p_0_in__1[3]),
        .Q(gt2_rx_cdrlock_counter_reg__0[3]),
        .R(gt2_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt2_rx_cdrlock_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(gt2_rx_cdrlock_counter),
        .D(p_0_in__1[4]),
        .Q(gt2_rx_cdrlock_counter_reg__0[4]),
        .R(gt2_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt2_rx_cdrlock_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(gt2_rx_cdrlock_counter),
        .D(p_0_in__1[5]),
        .Q(gt2_rx_cdrlock_counter_reg__0[5]),
        .R(gt2_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt2_rx_cdrlock_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(gt2_rx_cdrlock_counter),
        .D(p_0_in__1[6]),
        .Q(gt2_rx_cdrlock_counter_reg__0[6]),
        .R(gt2_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt2_rx_cdrlock_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(gt2_rx_cdrlock_counter),
        .D(p_0_in__1[7]),
        .Q(gt2_rx_cdrlock_counter_reg__0[7]),
        .R(gt2_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt2_rx_cdrlock_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(gt2_rx_cdrlock_counter),
        .D(p_0_in__1[8]),
        .Q(gt2_rx_cdrlock_counter_reg__0[8]),
        .R(gt2_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt2_rx_cdrlock_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(gt2_rx_cdrlock_counter),
        .D(p_0_in__1[9]),
        .Q(gt2_rx_cdrlock_counter_reg__0[9]),
        .R(gt2_gtrxreset_t));
  LUT5 #(
    .INIT(32'h00000004)) 
    gt2_rx_cdrlocked_i_2
       (.I0(gt2_rx_cdrlock_counter_reg__0[2]),
        .I1(gt2_rx_cdrlock_counter_reg__0[8]),
        .I2(gt2_rx_cdrlock_counter_reg__0[3]),
        .I3(gt2_rx_cdrlock_counter_reg__0[4]),
        .I4(\gt2_rx_cdrlock_counter[9]_i_3_n_0 ),
        .O(gt2_rx_cdrlocked));
  FDRE gt2_rx_cdrlocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt2_rxresetfsm_i_n_4),
        .Q(gt2_rx_cdrlocked_reg_n_0),
        .R(1'b0));
  XLAUI_XLAUI_RX_STARTUP_FSM_2 gt2_rxresetfsm_i
       (.DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT2_DATA_VALID_IN(GT2_DATA_VALID_IN),
        .GT2_RX_FSM_RESET_DONE_OUT(GT2_RX_FSM_RESET_DONE_OUT),
        .GT2_RX_MMCM_LOCK_IN(GT2_RX_MMCM_LOCK_IN),
        .GT2_RX_MMCM_RESET_OUT(GT2_RX_MMCM_RESET_OUT),
        .RXOUTCLK(RXOUTCLK),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(gt2_rxpmaresetdone_i),
        .gt2_rx_cdrlocked(gt2_rx_cdrlocked),
        .gt2_rx_cdrlocked_reg(gt2_rxresetfsm_i_n_4),
        .gt2_rx_cdrlocked_reg_0(gt2_rx_cdrlocked_reg_n_0),
        .gt2_rxresetdone_out(gt2_rxresetdone_out),
        .gt2_rxuserrdy_in(gt2_rxuserrdy_t),
        .gt2_rxusrclk_in(gt2_rxusrclk_in),
        .reset_sync1_rx_0(gt2_gtrxreset_t));
  XLAUI_XLAUI_TX_STARTUP_FSM_3 gt2_txresetfsm_i
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT2_TX_FSM_RESET_DONE_OUT(GT2_TX_FSM_RESET_DONE_OUT),
        .GT2_TX_MMCM_LOCK_IN(GT2_TX_MMCM_LOCK_IN),
        .GT2_TX_MMCM_RESET_OUT(GT2_TX_MMCM_RESET_OUT),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .gt2_gttxreset_in(gt2_gttxreset_t),
        .gt2_txresetdone_out(gt2_txresetdone_out),
        .gt2_txuserrdy_in(gt2_txuserrdy_t),
        .gt2_txusrclk_in(gt2_txusrclk_in));
  (* SOFT_HLUTNM = "soft_lutpair134" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \gt3_rx_cdrlock_counter[0]_i_1 
       (.I0(gt3_rx_cdrlock_counter_reg__0[0]),
        .O(\gt3_rx_cdrlock_counter[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair134" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \gt3_rx_cdrlock_counter[1]_i_1 
       (.I0(gt3_rx_cdrlock_counter_reg__0[1]),
        .I1(gt3_rx_cdrlock_counter_reg__0[0]),
        .O(p_0_in__2[1]));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \gt3_rx_cdrlock_counter[2]_i_1 
       (.I0(gt3_rx_cdrlock_counter_reg__0[2]),
        .I1(gt3_rx_cdrlock_counter_reg__0[1]),
        .I2(gt3_rx_cdrlock_counter_reg__0[0]),
        .O(p_0_in__2[2]));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gt3_rx_cdrlock_counter[3]_i_1 
       (.I0(gt3_rx_cdrlock_counter_reg__0[3]),
        .I1(gt3_rx_cdrlock_counter_reg__0[0]),
        .I2(gt3_rx_cdrlock_counter_reg__0[1]),
        .I3(gt3_rx_cdrlock_counter_reg__0[2]),
        .O(p_0_in__2[3]));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \gt3_rx_cdrlock_counter[4]_i_1 
       (.I0(gt3_rx_cdrlock_counter_reg__0[2]),
        .I1(gt3_rx_cdrlock_counter_reg__0[1]),
        .I2(gt3_rx_cdrlock_counter_reg__0[0]),
        .I3(gt3_rx_cdrlock_counter_reg__0[3]),
        .I4(gt3_rx_cdrlock_counter_reg__0[4]),
        .O(p_0_in__2[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \gt3_rx_cdrlock_counter[5]_i_1 
       (.I0(gt3_rx_cdrlock_counter_reg__0[5]),
        .I1(gt3_rx_cdrlock_counter_reg__0[2]),
        .I2(gt3_rx_cdrlock_counter_reg__0[1]),
        .I3(gt3_rx_cdrlock_counter_reg__0[0]),
        .I4(gt3_rx_cdrlock_counter_reg__0[3]),
        .I5(gt3_rx_cdrlock_counter_reg__0[4]),
        .O(p_0_in__2[5]));
  LUT3 #(
    .INIT(8'h6A)) 
    \gt3_rx_cdrlock_counter[6]_i_1 
       (.I0(gt3_rx_cdrlock_counter_reg__0[6]),
        .I1(\gt3_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I2(gt3_rx_cdrlock_counter_reg__0[5]),
        .O(p_0_in__2[6]));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gt3_rx_cdrlock_counter[7]_i_1 
       (.I0(gt3_rx_cdrlock_counter_reg__0[7]),
        .I1(gt3_rx_cdrlock_counter_reg__0[5]),
        .I2(\gt3_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I3(gt3_rx_cdrlock_counter_reg__0[6]),
        .O(p_0_in__2[7]));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \gt3_rx_cdrlock_counter[8]_i_1 
       (.I0(gt3_rx_cdrlock_counter_reg__0[8]),
        .I1(gt3_rx_cdrlock_counter_reg__0[6]),
        .I2(\gt3_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I3(gt3_rx_cdrlock_counter_reg__0[5]),
        .I4(gt3_rx_cdrlock_counter_reg__0[7]),
        .O(p_0_in__2[8]));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \gt3_rx_cdrlock_counter[9]_i_1 
       (.I0(\gt3_rx_cdrlock_counter[9]_i_3_n_0 ),
        .I1(gt3_rx_cdrlock_counter_reg__0[4]),
        .I2(gt3_rx_cdrlock_counter_reg__0[3]),
        .I3(gt3_rx_cdrlock_counter_reg__0[8]),
        .I4(gt3_rx_cdrlock_counter_reg__0[2]),
        .O(gt3_rx_cdrlock_counter));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \gt3_rx_cdrlock_counter[9]_i_2 
       (.I0(gt3_rx_cdrlock_counter_reg__0[9]),
        .I1(gt3_rx_cdrlock_counter_reg__0[7]),
        .I2(gt3_rx_cdrlock_counter_reg__0[5]),
        .I3(\gt3_rx_cdrlock_counter[9]_i_4_n_0 ),
        .I4(gt3_rx_cdrlock_counter_reg__0[6]),
        .I5(gt3_rx_cdrlock_counter_reg__0[8]),
        .O(p_0_in__2[9]));
  LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
    \gt3_rx_cdrlock_counter[9]_i_3 
       (.I0(gt3_rx_cdrlock_counter_reg__0[9]),
        .I1(gt3_rx_cdrlock_counter_reg__0[7]),
        .I2(gt3_rx_cdrlock_counter_reg__0[5]),
        .I3(gt3_rx_cdrlock_counter_reg__0[0]),
        .I4(gt3_rx_cdrlock_counter_reg__0[1]),
        .I5(gt3_rx_cdrlock_counter_reg__0[6]),
        .O(\gt3_rx_cdrlock_counter[9]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \gt3_rx_cdrlock_counter[9]_i_4 
       (.I0(gt3_rx_cdrlock_counter_reg__0[4]),
        .I1(gt3_rx_cdrlock_counter_reg__0[3]),
        .I2(gt3_rx_cdrlock_counter_reg__0[0]),
        .I3(gt3_rx_cdrlock_counter_reg__0[1]),
        .I4(gt3_rx_cdrlock_counter_reg__0[2]),
        .O(\gt3_rx_cdrlock_counter[9]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gt3_rx_cdrlock_counter_reg[0] 
       (.C(SYSCLK_IN),
        .CE(gt3_rx_cdrlock_counter),
        .D(\gt3_rx_cdrlock_counter[0]_i_1_n_0 ),
        .Q(gt3_rx_cdrlock_counter_reg__0[0]),
        .R(gt3_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt3_rx_cdrlock_counter_reg[1] 
       (.C(SYSCLK_IN),
        .CE(gt3_rx_cdrlock_counter),
        .D(p_0_in__2[1]),
        .Q(gt3_rx_cdrlock_counter_reg__0[1]),
        .R(gt3_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt3_rx_cdrlock_counter_reg[2] 
       (.C(SYSCLK_IN),
        .CE(gt3_rx_cdrlock_counter),
        .D(p_0_in__2[2]),
        .Q(gt3_rx_cdrlock_counter_reg__0[2]),
        .R(gt3_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt3_rx_cdrlock_counter_reg[3] 
       (.C(SYSCLK_IN),
        .CE(gt3_rx_cdrlock_counter),
        .D(p_0_in__2[3]),
        .Q(gt3_rx_cdrlock_counter_reg__0[3]),
        .R(gt3_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt3_rx_cdrlock_counter_reg[4] 
       (.C(SYSCLK_IN),
        .CE(gt3_rx_cdrlock_counter),
        .D(p_0_in__2[4]),
        .Q(gt3_rx_cdrlock_counter_reg__0[4]),
        .R(gt3_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt3_rx_cdrlock_counter_reg[5] 
       (.C(SYSCLK_IN),
        .CE(gt3_rx_cdrlock_counter),
        .D(p_0_in__2[5]),
        .Q(gt3_rx_cdrlock_counter_reg__0[5]),
        .R(gt3_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt3_rx_cdrlock_counter_reg[6] 
       (.C(SYSCLK_IN),
        .CE(gt3_rx_cdrlock_counter),
        .D(p_0_in__2[6]),
        .Q(gt3_rx_cdrlock_counter_reg__0[6]),
        .R(gt3_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt3_rx_cdrlock_counter_reg[7] 
       (.C(SYSCLK_IN),
        .CE(gt3_rx_cdrlock_counter),
        .D(p_0_in__2[7]),
        .Q(gt3_rx_cdrlock_counter_reg__0[7]),
        .R(gt3_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt3_rx_cdrlock_counter_reg[8] 
       (.C(SYSCLK_IN),
        .CE(gt3_rx_cdrlock_counter),
        .D(p_0_in__2[8]),
        .Q(gt3_rx_cdrlock_counter_reg__0[8]),
        .R(gt3_gtrxreset_t));
  FDRE #(
    .INIT(1'b0)) 
    \gt3_rx_cdrlock_counter_reg[9] 
       (.C(SYSCLK_IN),
        .CE(gt3_rx_cdrlock_counter),
        .D(p_0_in__2[9]),
        .Q(gt3_rx_cdrlock_counter_reg__0[9]),
        .R(gt3_gtrxreset_t));
  LUT5 #(
    .INIT(32'h00000004)) 
    gt3_rx_cdrlocked_i_2
       (.I0(gt3_rx_cdrlock_counter_reg__0[2]),
        .I1(gt3_rx_cdrlock_counter_reg__0[8]),
        .I2(gt3_rx_cdrlock_counter_reg__0[3]),
        .I3(gt3_rx_cdrlock_counter_reg__0[4]),
        .I4(\gt3_rx_cdrlock_counter[9]_i_3_n_0 ),
        .O(gt3_rx_cdrlocked));
  FDRE gt3_rx_cdrlocked_reg
       (.C(SYSCLK_IN),
        .CE(1'b1),
        .D(gt3_rxresetfsm_i_n_4),
        .Q(gt3_rx_cdrlocked_reg_n_0),
        .R(1'b0));
  XLAUI_XLAUI_RX_STARTUP_FSM_4 gt3_rxresetfsm_i
       (.DONT_RESET_ON_DATA_ERROR_IN(DONT_RESET_ON_DATA_ERROR_IN),
        .GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT3_DATA_VALID_IN(GT3_DATA_VALID_IN),
        .GT3_RX_FSM_RESET_DONE_OUT(GT3_RX_FSM_RESET_DONE_OUT),
        .GT3_RX_MMCM_LOCK_IN(GT3_RX_MMCM_LOCK_IN),
        .GT3_RX_MMCM_RESET_OUT(GT3_RX_MMCM_RESET_OUT),
        .RXOUTCLK(RXOUTCLK),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .data_in(gt3_rxpmaresetdone_i),
        .gt3_rx_cdrlocked(gt3_rx_cdrlocked),
        .gt3_rx_cdrlocked_reg(gt3_rxresetfsm_i_n_4),
        .gt3_rx_cdrlocked_reg_0(gt3_rx_cdrlocked_reg_n_0),
        .gt3_rxresetdone_out(gt3_rxresetdone_out),
        .gt3_rxuserrdy_in(gt3_rxuserrdy_t),
        .gt3_rxusrclk_in(gt3_rxusrclk_in),
        .reset_sync1_rx_0(gt3_gtrxreset_t));
  XLAUI_XLAUI_TX_STARTUP_FSM_5 gt3_txresetfsm_i
       (.GT0_QPLLLOCK_IN(GT0_QPLLLOCK_IN),
        .GT3_TX_FSM_RESET_DONE_OUT(GT3_TX_FSM_RESET_DONE_OUT),
        .GT3_TX_MMCM_LOCK_IN(GT3_TX_MMCM_LOCK_IN),
        .GT3_TX_MMCM_RESET_OUT(GT3_TX_MMCM_RESET_OUT),
        .SOFT_RESET_IN(SOFT_RESET_IN),
        .SYSCLK_IN(SYSCLK_IN),
        .gt3_gttxreset_in(gt3_gttxreset_t),
        .gt3_txresetdone_out(gt3_txresetdone_out),
        .gt3_txuserrdy_in(gt3_txuserrdy_t),
        .gt3_txusrclk_in(gt3_txusrclk_in));
  (* box_type = "PRIMITIVE" *) 
  BUFH rxout0_i
       (.I(gt0_rxoutclk_out),
        .O(RXOUTCLK));
endmodule

(* ORIG_REF_NAME = "XLAUI_multi_gt" *) 
module XLAUI_XLAUI_multi_gt
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
    gtrxreset_i_reg,
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
    gtrxreset_i_reg_0,
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
    gtrxreset_i_reg_1,
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
  input [0:0]gtrxreset_i_reg;
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
  input [0:0]gtrxreset_i_reg_0;
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
  input [0:0]gtrxreset_i_reg_1;
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
  wire [0:0]gtrxreset_i_reg;
  wire [0:0]gtrxreset_i_reg_0;
  wire [0:0]gtrxreset_i_reg_1;

  XLAUI_XLAUI_GT gt0_XLAUI_i
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
  XLAUI_XLAUI_GT_65 gt1_XLAUI_i
       (.GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT1_RXPMARESETDONE_OUT(GT1_RXPMARESETDONE_OUT),
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
        .gt1_txusrclk_in(gt1_txusrclk_in),
        .gtrxreset_i_reg(gtrxreset_i_reg));
  XLAUI_XLAUI_GT_66 gt2_XLAUI_i
       (.GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT2_RXPMARESETDONE_OUT(GT2_RXPMARESETDONE_OUT),
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
        .gt2_txusrclk_in(gt2_txusrclk_in),
        .gtrxreset_i_reg(gtrxreset_i_reg_0));
  XLAUI_XLAUI_GT_67 gt3_XLAUI_i
       (.GT0_QPLLOUTCLK_IN(GT0_QPLLOUTCLK_IN),
        .GT0_QPLLOUTREFCLK_IN(GT0_QPLLOUTREFCLK_IN),
        .GT3_RXPMARESETDONE_OUT(GT3_RXPMARESETDONE_OUT),
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
        .gt3_txusrclk_in(gt3_txusrclk_in),
        .gtrxreset_i_reg(gtrxreset_i_reg_1));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block
   (reset_time_out_reg,
    E,
    \FSM_sequential_tx_state_reg[0] ,
    init_wait_done_reg,
    out,
    reset_time_out_reg_0,
    wait_time_done,
    \FSM_sequential_tx_state_reg[1] ,
    mmcm_lock_reclocked,
    time_tlock_max_reg,
    pll_reset_asserted_reg,
    txresetdone_s3,
    time_out_500us_reg,
    time_out_2ms_reg,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output reset_time_out_reg;
  output [0:0]E;
  input \FSM_sequential_tx_state_reg[0] ;
  input init_wait_done_reg;
  input [3:0]out;
  input reset_time_out_reg_0;
  input wait_time_done;
  input \FSM_sequential_tx_state_reg[1] ;
  input mmcm_lock_reclocked;
  input time_tlock_max_reg;
  input pll_reset_asserted_reg;
  input txresetdone_s3;
  input time_out_500us_reg;
  input time_out_2ms_reg;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire [0:0]E;
  wire \FSM_sequential_tx_state[3]_i_7__2_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_8__2_n_0 ;
  wire \FSM_sequential_tx_state_reg[0] ;
  wire \FSM_sequential_tx_state_reg[1] ;
  wire \FSM_sequential_tx_state_reg[3]_i_3__2_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire init_wait_done_reg;
  wire mmcm_lock_reclocked;
  wire [3:0]out;
  wire pll_reset_asserted_reg;
  wire qplllock_sync;
  wire reset_time_out_i_2__2_n_0;
  wire reset_time_out_i_4__2_n_0;
  wire reset_time_out_reg;
  wire reset_time_out_reg_0;
  wire time_out_2ms_reg;
  wire time_out_500us_reg;
  wire time_tlock_max_reg;
  wire txresetdone_s3;
  wire wait_time_done;

  LUT6 #(
    .INIT(64'h0033B8BB0033B888)) 
    \FSM_sequential_tx_state[3]_i_1__2 
       (.I0(\FSM_sequential_tx_state_reg[3]_i_3__2_n_0 ),
        .I1(out[0]),
        .I2(wait_time_done),
        .I3(\FSM_sequential_tx_state_reg[1] ),
        .I4(out[3]),
        .I5(init_wait_done_reg),
        .O(E));
  LUT6 #(
    .INIT(64'hBA00BA00BAFFBA00)) 
    \FSM_sequential_tx_state[3]_i_7__2 
       (.I0(mmcm_lock_reclocked),
        .I1(reset_time_out_reg_0),
        .I2(time_tlock_max_reg),
        .I3(out[2]),
        .I4(pll_reset_asserted_reg),
        .I5(qplllock_sync),
        .O(\FSM_sequential_tx_state[3]_i_7__2_n_0 ));
  LUT6 #(
    .INIT(64'hBAFFBAFFBAFFBA00)) 
    \FSM_sequential_tx_state[3]_i_8__2 
       (.I0(txresetdone_s3),
        .I1(reset_time_out_reg_0),
        .I2(time_out_500us_reg),
        .I3(out[2]),
        .I4(time_out_2ms_reg),
        .I5(qplllock_sync),
        .O(\FSM_sequential_tx_state[3]_i_8__2_n_0 ));
  MUXF7 \FSM_sequential_tx_state_reg[3]_i_3__2 
       (.I0(\FSM_sequential_tx_state[3]_i_7__2_n_0 ),
        .I1(\FSM_sequential_tx_state[3]_i_8__2_n_0 ),
        .O(\FSM_sequential_tx_state_reg[3]_i_3__2_n_0 ),
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
    .INIT(64'h88B8FFFF88B80000)) 
    reset_time_out_i_1__2
       (.I0(reset_time_out_i_2__2_n_0),
        .I1(\FSM_sequential_tx_state_reg[0] ),
        .I2(init_wait_done_reg),
        .I3(out[3]),
        .I4(reset_time_out_i_4__2_n_0),
        .I5(reset_time_out_reg_0),
        .O(reset_time_out_reg));
  LUT6 #(
    .INIT(64'hF4F4FF0F0404FF0F)) 
    reset_time_out_i_2__2
       (.I0(out[3]),
        .I1(qplllock_sync),
        .I2(out[2]),
        .I3(mmcm_lock_reclocked),
        .I4(out[1]),
        .I5(txresetdone_s3),
        .O(reset_time_out_i_2__2_n_0));
  LUT6 #(
    .INIT(64'h303030302020FFFC)) 
    reset_time_out_i_4__2
       (.I0(qplllock_sync),
        .I1(out[3]),
        .I2(out[0]),
        .I3(init_wait_done_reg),
        .I4(out[1]),
        .I5(out[2]),
        .O(reset_time_out_i_4__2_n_0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_10
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
module XLAUI_XLAUI_sync_block_11
   (\FSM_sequential_rx_state_reg[0] ,
    reset_time_out_reg,
    rxresetdone_s3_reg,
    out,
    time_out_2ms_reg,
    rxresetdone_s3,
    mmcm_lock_reclocked,
    gt3_rx_cdrlocked_reg,
    data_out,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output \FSM_sequential_rx_state_reg[0] ;
  output reset_time_out_reg;
  input rxresetdone_s3_reg;
  input [2:0]out;
  input time_out_2ms_reg;
  input rxresetdone_s3;
  input mmcm_lock_reclocked;
  input gt3_rx_cdrlocked_reg;
  input data_out;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire \FSM_sequential_rx_state_reg[0] ;
  wire GT0_QPLLLOCK_IN;
  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked;
  wire [2:0]out;
  wire qplllock_sync;
  wire reset_time_out_i_6__2_n_0;
  wire reset_time_out_i_7__2_n_0;
  wire reset_time_out_reg;
  wire rxresetdone_s3;
  wire rxresetdone_s3_reg;
  wire time_out_2ms_reg;

  LUT5 #(
    .INIT(32'hBBB8BBBB)) 
    \FSM_sequential_rx_state[3]_i_4__2 
       (.I0(rxresetdone_s3_reg),
        .I1(out[2]),
        .I2(time_out_2ms_reg),
        .I3(qplllock_sync),
        .I4(out[1]),
        .O(\FSM_sequential_rx_state_reg[0] ));
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
    .INIT(64'hAFCFA0CFAFCFAFCF)) 
    reset_time_out_i_6__2
       (.I0(rxresetdone_s3),
        .I1(gt3_rx_cdrlocked_reg),
        .I2(out[2]),
        .I3(out[1]),
        .I4(qplllock_sync),
        .I5(data_out),
        .O(reset_time_out_i_6__2_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    reset_time_out_i_7__2
       (.I0(rxresetdone_s3),
        .I1(mmcm_lock_reclocked),
        .I2(out[2]),
        .I3(qplllock_sync),
        .I4(out[1]),
        .O(reset_time_out_i_7__2_n_0));
  MUXF7 reset_time_out_reg_i_3__2
       (.I0(reset_time_out_i_6__2_n_0),
        .I1(reset_time_out_i_7__2_n_0),
        .O(reset_time_out_reg),
        .S(out[0]));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_12
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
module XLAUI_XLAUI_sync_block_13
   (data_out,
    reset_time_out_reg,
    rx_fsm_reset_done_int_reg,
    D,
    E,
    DONT_RESET_ON_DATA_ERROR_IN,
    time_out_500us_reg,
    reset_time_out_reg_0,
    \FSM_sequential_rx_state_reg[0] ,
    \FSM_sequential_rx_state_reg[1] ,
    out,
    mmcm_lock_reclocked_reg,
    GT3_RX_FSM_RESET_DONE_OUT,
    time_out_2ms_reg,
    \FSM_sequential_rx_state_reg[2] ,
    gt3_rx_cdrlocked_reg,
    rx_state16_out,
    time_out_1us_reg,
    \FSM_sequential_rx_state_reg[2]_0 ,
    time_out_wait_bypass_s3,
    GT3_DATA_VALID_IN,
    SYSCLK_IN);
  output data_out;
  output reset_time_out_reg;
  output rx_fsm_reset_done_int_reg;
  output [2:0]D;
  output [0:0]E;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input time_out_500us_reg;
  input reset_time_out_reg_0;
  input \FSM_sequential_rx_state_reg[0] ;
  input \FSM_sequential_rx_state_reg[1] ;
  input [3:0]out;
  input mmcm_lock_reclocked_reg;
  input GT3_RX_FSM_RESET_DONE_OUT;
  input time_out_2ms_reg;
  input \FSM_sequential_rx_state_reg[2] ;
  input gt3_rx_cdrlocked_reg;
  input rx_state16_out;
  input time_out_1us_reg;
  input \FSM_sequential_rx_state_reg[2]_0 ;
  input time_out_wait_bypass_s3;
  input GT3_DATA_VALID_IN;
  input SYSCLK_IN;

  wire [2:0]D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire [0:0]E;
  wire \FSM_sequential_rx_state[3]_i_3__2_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_7__2_n_0 ;
  wire \FSM_sequential_rx_state_reg[0] ;
  wire \FSM_sequential_rx_state_reg[1] ;
  wire \FSM_sequential_rx_state_reg[2] ;
  wire \FSM_sequential_rx_state_reg[2]_0 ;
  wire GT3_DATA_VALID_IN;
  wire GT3_RX_FSM_RESET_DONE_OUT;
  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked_reg;
  wire [3:0]out;
  wire reset_time_out_i_2__6_n_0;
  wire reset_time_out_reg;
  wire reset_time_out_reg_0;
  wire rx_fsm_reset_done_int;
  wire rx_fsm_reset_done_int_i_3__2_n_0;
  wire rx_fsm_reset_done_int_i_4__2_n_0;
  wire rx_fsm_reset_done_int_reg;
  wire rx_state1;
  wire rx_state16_out;
  wire time_out_1us_reg;
  wire time_out_2ms_reg;
  wire time_out_500us_reg;
  wire time_out_wait_bypass_s3;

  LUT6 #(
    .INIT(64'h004FFFFF004F0000)) 
    \FSM_sequential_rx_state[0]_i_1__2 
       (.I0(out[1]),
        .I1(rx_state1),
        .I2(out[0]),
        .I3(out[2]),
        .I4(out[3]),
        .I5(time_out_2ms_reg),
        .O(D[0]));
  LUT6 #(
    .INIT(64'h0000333303770000)) 
    \FSM_sequential_rx_state[1]_i_1__2 
       (.I0(rx_state1),
        .I1(out[3]),
        .I2(rx_state16_out),
        .I3(out[2]),
        .I4(out[0]),
        .I5(out[1]),
        .O(D[1]));
  LUT4 #(
    .INIT(16'h0004)) 
    \FSM_sequential_rx_state[1]_i_2__2 
       (.I0(DONT_RESET_ON_DATA_ERROR_IN),
        .I1(time_out_500us_reg),
        .I2(data_out),
        .I3(reset_time_out_reg_0),
        .O(rx_state1));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \FSM_sequential_rx_state[3]_i_1__2 
       (.I0(rx_fsm_reset_done_int_i_4__2_n_0),
        .I1(\FSM_sequential_rx_state[3]_i_3__2_n_0 ),
        .I2(out[3]),
        .I3(\FSM_sequential_rx_state_reg[2] ),
        .I4(out[0]),
        .I5(gt3_rx_cdrlocked_reg),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'h07)) 
    \FSM_sequential_rx_state[3]_i_3__2 
       (.I0(data_out),
        .I1(out[1]),
        .I2(out[2]),
        .O(\FSM_sequential_rx_state[3]_i_3__2_n_0 ));
  LUT5 #(
    .INIT(32'h00003347)) 
    \FSM_sequential_rx_state[3]_i_7__2 
       (.I0(rx_state1),
        .I1(out[0]),
        .I2(time_out_wait_bypass_s3),
        .I3(out[1]),
        .I4(out[2]),
        .O(\FSM_sequential_rx_state[3]_i_7__2_n_0 ));
  MUXF7 \FSM_sequential_rx_state_reg[3]_i_2__2 
       (.I0(\FSM_sequential_rx_state_reg[2]_0 ),
        .I1(\FSM_sequential_rx_state[3]_i_7__2_n_0 ),
        .O(D[2]),
        .S(out[3]));
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
        .Q(data_out),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAFCCAFFFA0CCA000)) 
    reset_time_out_i_1__6
       (.I0(reset_time_out_i_2__6_n_0),
        .I1(\FSM_sequential_rx_state_reg[0] ),
        .I2(\FSM_sequential_rx_state_reg[1] ),
        .I3(out[3]),
        .I4(mmcm_lock_reclocked_reg),
        .I5(reset_time_out_reg_0),
        .O(reset_time_out_reg));
  LUT4 #(
    .INIT(16'h001D)) 
    reset_time_out_i_2__6
       (.I0(out[0]),
        .I1(data_out),
        .I2(out[1]),
        .I3(out[2]),
        .O(reset_time_out_i_2__6_n_0));
  LUT6 #(
    .INIT(64'hABFBFFFFA8080000)) 
    rx_fsm_reset_done_int_i_1__2
       (.I0(rx_fsm_reset_done_int),
        .I1(rx_fsm_reset_done_int_i_3__2_n_0),
        .I2(out[0]),
        .I3(rx_fsm_reset_done_int_i_4__2_n_0),
        .I4(out[3]),
        .I5(GT3_RX_FSM_RESET_DONE_OUT),
        .O(rx_fsm_reset_done_int_reg));
  LUT5 #(
    .INIT(32'h00001000)) 
    rx_fsm_reset_done_int_i_2__2
       (.I0(out[0]),
        .I1(out[2]),
        .I2(data_out),
        .I3(time_out_1us_reg),
        .I4(reset_time_out_reg_0),
        .O(rx_fsm_reset_done_int));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT5 #(
    .INIT(32'h000020AA)) 
    rx_fsm_reset_done_int_i_3__2
       (.I0(out[1]),
        .I1(reset_time_out_reg_0),
        .I2(time_out_1us_reg),
        .I3(data_out),
        .I4(out[2]),
        .O(rx_fsm_reset_done_int_i_3__2_n_0));
  LUT6 #(
    .INIT(64'h0000000050505150)) 
    rx_fsm_reset_done_int_i_4__2
       (.I0(out[1]),
        .I1(reset_time_out_reg_0),
        .I2(data_out),
        .I3(time_out_500us_reg),
        .I4(DONT_RESET_ON_DATA_ERROR_IN),
        .I5(out[2]),
        .O(rx_fsm_reset_done_int_i_4__2_n_0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_14
   (SR,
    mmcm_lock_reclocked_reg,
    mmcm_lock_reclocked,
    Q,
    \mmcm_lock_count_reg[5] ,
    GT3_RX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output mmcm_lock_reclocked_reg;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input \mmcm_lock_count_reg[5] ;
  input GT3_RX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT3_RX_MMCM_LOCK_IN;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \mmcm_lock_count_reg[5] ;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_reg;

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
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[7]_i_1__6 
       (.I0(mmcm_lock_i),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT5 #(
    .INIT(32'hEAAA0000)) 
    mmcm_lock_reclocked_i_1__6
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(\mmcm_lock_count_reg[5] ),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(mmcm_lock_reclocked_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_15
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
module XLAUI_XLAUI_sync_block_16
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
module XLAUI_XLAUI_sync_block_17
   (mmcm_reset_i_reg,
    reset_time_out_reg,
    out,
    GT3_RX_MMCM_RESET_OUT,
    mmcm_lock_reclocked,
    gt3_rx_cdrlocked_reg,
    data_in,
    SYSCLK_IN);
  output mmcm_reset_i_reg;
  output reset_time_out_reg;
  input [3:0]out;
  input GT3_RX_MMCM_RESET_OUT;
  input mmcm_lock_reclocked;
  input gt3_rx_cdrlocked_reg;
  input data_in;
  input SYSCLK_IN;

  wire GT3_RX_MMCM_RESET_OUT;
  wire SYSCLK_IN;
  wire data_in;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked;
  wire mmcm_reset_i_reg;
  wire [3:0]out;
  wire reset_time_out_reg;
  wire rxpmaresetdone_sync;

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
        .Q(rxpmaresetdone_sync),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFF7FF0000000A)) 
    mmcm_reset_i_i_1__2
       (.I0(out[0]),
        .I1(rxpmaresetdone_sync),
        .I2(out[1]),
        .I3(out[2]),
        .I4(out[3]),
        .I5(GT3_RX_MMCM_RESET_OUT),
        .O(mmcm_reset_i_reg));
  LUT6 #(
    .INIT(64'hF0EFF0E0F0F0F0F0)) 
    reset_time_out_i_5__2
       (.I0(mmcm_lock_reclocked),
        .I1(rxpmaresetdone_sync),
        .I2(out[0]),
        .I3(out[1]),
        .I4(gt3_rx_cdrlocked_reg),
        .I5(out[2]),
        .O(reset_time_out_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_18
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
module XLAUI_XLAUI_sync_block_19
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
module XLAUI_XLAUI_sync_block_20
   (reset_time_out_reg,
    E,
    \FSM_sequential_tx_state_reg[0] ,
    init_wait_done_reg,
    out,
    reset_time_out_reg_0,
    wait_time_done,
    \FSM_sequential_tx_state_reg[1] ,
    mmcm_lock_reclocked,
    time_tlock_max_reg,
    pll_reset_asserted_reg,
    txresetdone_s3,
    time_out_500us_reg,
    time_out_2ms_reg,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output reset_time_out_reg;
  output [0:0]E;
  input \FSM_sequential_tx_state_reg[0] ;
  input init_wait_done_reg;
  input [3:0]out;
  input reset_time_out_reg_0;
  input wait_time_done;
  input \FSM_sequential_tx_state_reg[1] ;
  input mmcm_lock_reclocked;
  input time_tlock_max_reg;
  input pll_reset_asserted_reg;
  input txresetdone_s3;
  input time_out_500us_reg;
  input time_out_2ms_reg;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire [0:0]E;
  wire \FSM_sequential_tx_state[3]_i_7__1_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_8__1_n_0 ;
  wire \FSM_sequential_tx_state_reg[0] ;
  wire \FSM_sequential_tx_state_reg[1] ;
  wire \FSM_sequential_tx_state_reg[3]_i_3__1_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire init_wait_done_reg;
  wire mmcm_lock_reclocked;
  wire [3:0]out;
  wire pll_reset_asserted_reg;
  wire qplllock_sync;
  wire reset_time_out_i_2__1_n_0;
  wire reset_time_out_i_4__1_n_0;
  wire reset_time_out_reg;
  wire reset_time_out_reg_0;
  wire time_out_2ms_reg;
  wire time_out_500us_reg;
  wire time_tlock_max_reg;
  wire txresetdone_s3;
  wire wait_time_done;

  LUT6 #(
    .INIT(64'h0033B8BB0033B888)) 
    \FSM_sequential_tx_state[3]_i_1__1 
       (.I0(\FSM_sequential_tx_state_reg[3]_i_3__1_n_0 ),
        .I1(out[0]),
        .I2(wait_time_done),
        .I3(\FSM_sequential_tx_state_reg[1] ),
        .I4(out[3]),
        .I5(init_wait_done_reg),
        .O(E));
  LUT6 #(
    .INIT(64'hBA00BA00BAFFBA00)) 
    \FSM_sequential_tx_state[3]_i_7__1 
       (.I0(mmcm_lock_reclocked),
        .I1(reset_time_out_reg_0),
        .I2(time_tlock_max_reg),
        .I3(out[2]),
        .I4(pll_reset_asserted_reg),
        .I5(qplllock_sync),
        .O(\FSM_sequential_tx_state[3]_i_7__1_n_0 ));
  LUT6 #(
    .INIT(64'hBAFFBAFFBAFFBA00)) 
    \FSM_sequential_tx_state[3]_i_8__1 
       (.I0(txresetdone_s3),
        .I1(reset_time_out_reg_0),
        .I2(time_out_500us_reg),
        .I3(out[2]),
        .I4(time_out_2ms_reg),
        .I5(qplllock_sync),
        .O(\FSM_sequential_tx_state[3]_i_8__1_n_0 ));
  MUXF7 \FSM_sequential_tx_state_reg[3]_i_3__1 
       (.I0(\FSM_sequential_tx_state[3]_i_7__1_n_0 ),
        .I1(\FSM_sequential_tx_state[3]_i_8__1_n_0 ),
        .O(\FSM_sequential_tx_state_reg[3]_i_3__1_n_0 ),
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
    .INIT(64'h88B8FFFF88B80000)) 
    reset_time_out_i_1__1
       (.I0(reset_time_out_i_2__1_n_0),
        .I1(\FSM_sequential_tx_state_reg[0] ),
        .I2(init_wait_done_reg),
        .I3(out[3]),
        .I4(reset_time_out_i_4__1_n_0),
        .I5(reset_time_out_reg_0),
        .O(reset_time_out_reg));
  LUT6 #(
    .INIT(64'hF4F4FF0F0404FF0F)) 
    reset_time_out_i_2__1
       (.I0(out[3]),
        .I1(qplllock_sync),
        .I2(out[2]),
        .I3(mmcm_lock_reclocked),
        .I4(out[1]),
        .I5(txresetdone_s3),
        .O(reset_time_out_i_2__1_n_0));
  LUT6 #(
    .INIT(64'h303030302020FFFC)) 
    reset_time_out_i_4__1
       (.I0(qplllock_sync),
        .I1(out[3]),
        .I2(out[0]),
        .I3(init_wait_done_reg),
        .I4(out[1]),
        .I5(out[2]),
        .O(reset_time_out_i_4__1_n_0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_21
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
module XLAUI_XLAUI_sync_block_22
   (SR,
    mmcm_lock_reclocked_reg,
    mmcm_lock_reclocked,
    Q,
    \mmcm_lock_count_reg[5] ,
    GT2_TX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output mmcm_lock_reclocked_reg;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input \mmcm_lock_count_reg[5] ;
  input GT2_TX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT2_TX_MMCM_LOCK_IN;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \mmcm_lock_count_reg[5] ;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_reg;

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
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[7]_i_1__1 
       (.I0(mmcm_lock_i),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT5 #(
    .INIT(32'hEAAA0000)) 
    mmcm_lock_reclocked_i_1__1
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(\mmcm_lock_count_reg[5] ),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(mmcm_lock_reclocked_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_23
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
module XLAUI_XLAUI_sync_block_24
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
module XLAUI_XLAUI_sync_block_25
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
module XLAUI_XLAUI_sync_block_26
   (\FSM_sequential_rx_state_reg[0] ,
    reset_time_out_reg,
    rxresetdone_s3_reg,
    out,
    time_out_2ms_reg,
    rxresetdone_s3,
    mmcm_lock_reclocked,
    gt2_rx_cdrlocked_reg,
    data_out,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output \FSM_sequential_rx_state_reg[0] ;
  output reset_time_out_reg;
  input rxresetdone_s3_reg;
  input [2:0]out;
  input time_out_2ms_reg;
  input rxresetdone_s3;
  input mmcm_lock_reclocked;
  input gt2_rx_cdrlocked_reg;
  input data_out;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire \FSM_sequential_rx_state_reg[0] ;
  wire GT0_QPLLLOCK_IN;
  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked;
  wire [2:0]out;
  wire qplllock_sync;
  wire reset_time_out_i_6__1_n_0;
  wire reset_time_out_i_7__1_n_0;
  wire reset_time_out_reg;
  wire rxresetdone_s3;
  wire rxresetdone_s3_reg;
  wire time_out_2ms_reg;

  LUT5 #(
    .INIT(32'hBBB8BBBB)) 
    \FSM_sequential_rx_state[3]_i_4__1 
       (.I0(rxresetdone_s3_reg),
        .I1(out[2]),
        .I2(time_out_2ms_reg),
        .I3(qplllock_sync),
        .I4(out[1]),
        .O(\FSM_sequential_rx_state_reg[0] ));
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
    .INIT(64'hAFCFA0CFAFCFAFCF)) 
    reset_time_out_i_6__1
       (.I0(rxresetdone_s3),
        .I1(gt2_rx_cdrlocked_reg),
        .I2(out[2]),
        .I3(out[1]),
        .I4(qplllock_sync),
        .I5(data_out),
        .O(reset_time_out_i_6__1_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    reset_time_out_i_7__1
       (.I0(rxresetdone_s3),
        .I1(mmcm_lock_reclocked),
        .I2(out[2]),
        .I3(qplllock_sync),
        .I4(out[1]),
        .O(reset_time_out_i_7__1_n_0));
  MUXF7 reset_time_out_reg_i_3__1
       (.I0(reset_time_out_i_6__1_n_0),
        .I1(reset_time_out_i_7__1_n_0),
        .O(reset_time_out_reg),
        .S(out[0]));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_27
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
module XLAUI_XLAUI_sync_block_28
   (data_out,
    reset_time_out_reg,
    rx_fsm_reset_done_int_reg,
    D,
    E,
    DONT_RESET_ON_DATA_ERROR_IN,
    time_out_500us_reg,
    reset_time_out_reg_0,
    \FSM_sequential_rx_state_reg[0] ,
    \FSM_sequential_rx_state_reg[1] ,
    out,
    mmcm_lock_reclocked_reg,
    GT2_RX_FSM_RESET_DONE_OUT,
    time_out_2ms_reg,
    \FSM_sequential_rx_state_reg[2] ,
    gt2_rx_cdrlocked_reg,
    rx_state16_out,
    time_out_1us_reg,
    \FSM_sequential_rx_state_reg[2]_0 ,
    time_out_wait_bypass_s3,
    GT2_DATA_VALID_IN,
    SYSCLK_IN);
  output data_out;
  output reset_time_out_reg;
  output rx_fsm_reset_done_int_reg;
  output [2:0]D;
  output [0:0]E;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input time_out_500us_reg;
  input reset_time_out_reg_0;
  input \FSM_sequential_rx_state_reg[0] ;
  input \FSM_sequential_rx_state_reg[1] ;
  input [3:0]out;
  input mmcm_lock_reclocked_reg;
  input GT2_RX_FSM_RESET_DONE_OUT;
  input time_out_2ms_reg;
  input \FSM_sequential_rx_state_reg[2] ;
  input gt2_rx_cdrlocked_reg;
  input rx_state16_out;
  input time_out_1us_reg;
  input \FSM_sequential_rx_state_reg[2]_0 ;
  input time_out_wait_bypass_s3;
  input GT2_DATA_VALID_IN;
  input SYSCLK_IN;

  wire [2:0]D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire [0:0]E;
  wire \FSM_sequential_rx_state[3]_i_3__1_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_7__1_n_0 ;
  wire \FSM_sequential_rx_state_reg[0] ;
  wire \FSM_sequential_rx_state_reg[1] ;
  wire \FSM_sequential_rx_state_reg[2] ;
  wire \FSM_sequential_rx_state_reg[2]_0 ;
  wire GT2_DATA_VALID_IN;
  wire GT2_RX_FSM_RESET_DONE_OUT;
  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked_reg;
  wire [3:0]out;
  wire reset_time_out_i_2__5_n_0;
  wire reset_time_out_reg;
  wire reset_time_out_reg_0;
  wire rx_fsm_reset_done_int;
  wire rx_fsm_reset_done_int_i_3__1_n_0;
  wire rx_fsm_reset_done_int_i_4__1_n_0;
  wire rx_fsm_reset_done_int_reg;
  wire rx_state1;
  wire rx_state16_out;
  wire time_out_1us_reg;
  wire time_out_2ms_reg;
  wire time_out_500us_reg;
  wire time_out_wait_bypass_s3;

  LUT6 #(
    .INIT(64'h004FFFFF004F0000)) 
    \FSM_sequential_rx_state[0]_i_1__1 
       (.I0(out[1]),
        .I1(rx_state1),
        .I2(out[0]),
        .I3(out[2]),
        .I4(out[3]),
        .I5(time_out_2ms_reg),
        .O(D[0]));
  LUT6 #(
    .INIT(64'h0000333303770000)) 
    \FSM_sequential_rx_state[1]_i_1__1 
       (.I0(rx_state1),
        .I1(out[3]),
        .I2(rx_state16_out),
        .I3(out[2]),
        .I4(out[0]),
        .I5(out[1]),
        .O(D[1]));
  LUT4 #(
    .INIT(16'h0004)) 
    \FSM_sequential_rx_state[1]_i_2__1 
       (.I0(DONT_RESET_ON_DATA_ERROR_IN),
        .I1(time_out_500us_reg),
        .I2(data_out),
        .I3(reset_time_out_reg_0),
        .O(rx_state1));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \FSM_sequential_rx_state[3]_i_1__1 
       (.I0(rx_fsm_reset_done_int_i_4__1_n_0),
        .I1(\FSM_sequential_rx_state[3]_i_3__1_n_0 ),
        .I2(out[3]),
        .I3(\FSM_sequential_rx_state_reg[2] ),
        .I4(out[0]),
        .I5(gt2_rx_cdrlocked_reg),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'h07)) 
    \FSM_sequential_rx_state[3]_i_3__1 
       (.I0(data_out),
        .I1(out[1]),
        .I2(out[2]),
        .O(\FSM_sequential_rx_state[3]_i_3__1_n_0 ));
  LUT5 #(
    .INIT(32'h00003347)) 
    \FSM_sequential_rx_state[3]_i_7__1 
       (.I0(rx_state1),
        .I1(out[0]),
        .I2(time_out_wait_bypass_s3),
        .I3(out[1]),
        .I4(out[2]),
        .O(\FSM_sequential_rx_state[3]_i_7__1_n_0 ));
  MUXF7 \FSM_sequential_rx_state_reg[3]_i_2__1 
       (.I0(\FSM_sequential_rx_state_reg[2]_0 ),
        .I1(\FSM_sequential_rx_state[3]_i_7__1_n_0 ),
        .O(D[2]),
        .S(out[3]));
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
        .Q(data_out),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAFCCAFFFA0CCA000)) 
    reset_time_out_i_1__5
       (.I0(reset_time_out_i_2__5_n_0),
        .I1(\FSM_sequential_rx_state_reg[0] ),
        .I2(\FSM_sequential_rx_state_reg[1] ),
        .I3(out[3]),
        .I4(mmcm_lock_reclocked_reg),
        .I5(reset_time_out_reg_0),
        .O(reset_time_out_reg));
  LUT4 #(
    .INIT(16'h001D)) 
    reset_time_out_i_2__5
       (.I0(out[0]),
        .I1(data_out),
        .I2(out[1]),
        .I3(out[2]),
        .O(reset_time_out_i_2__5_n_0));
  LUT6 #(
    .INIT(64'hABFBFFFFA8080000)) 
    rx_fsm_reset_done_int_i_1__1
       (.I0(rx_fsm_reset_done_int),
        .I1(rx_fsm_reset_done_int_i_3__1_n_0),
        .I2(out[0]),
        .I3(rx_fsm_reset_done_int_i_4__1_n_0),
        .I4(out[3]),
        .I5(GT2_RX_FSM_RESET_DONE_OUT),
        .O(rx_fsm_reset_done_int_reg));
  LUT5 #(
    .INIT(32'h00001000)) 
    rx_fsm_reset_done_int_i_2__1
       (.I0(out[0]),
        .I1(out[2]),
        .I2(data_out),
        .I3(time_out_1us_reg),
        .I4(reset_time_out_reg_0),
        .O(rx_fsm_reset_done_int));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT5 #(
    .INIT(32'h000020AA)) 
    rx_fsm_reset_done_int_i_3__1
       (.I0(out[1]),
        .I1(reset_time_out_reg_0),
        .I2(time_out_1us_reg),
        .I3(data_out),
        .I4(out[2]),
        .O(rx_fsm_reset_done_int_i_3__1_n_0));
  LUT6 #(
    .INIT(64'h0000000050505150)) 
    rx_fsm_reset_done_int_i_4__1
       (.I0(out[1]),
        .I1(reset_time_out_reg_0),
        .I2(data_out),
        .I3(time_out_500us_reg),
        .I4(DONT_RESET_ON_DATA_ERROR_IN),
        .I5(out[2]),
        .O(rx_fsm_reset_done_int_i_4__1_n_0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_29
   (SR,
    mmcm_lock_reclocked_reg,
    mmcm_lock_reclocked,
    Q,
    \mmcm_lock_count_reg[5] ,
    GT2_RX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output mmcm_lock_reclocked_reg;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input \mmcm_lock_count_reg[5] ;
  input GT2_RX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT2_RX_MMCM_LOCK_IN;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \mmcm_lock_count_reg[5] ;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_reg;

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
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[7]_i_1__5 
       (.I0(mmcm_lock_i),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT5 #(
    .INIT(32'hEAAA0000)) 
    mmcm_lock_reclocked_i_1__5
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(\mmcm_lock_count_reg[5] ),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(mmcm_lock_reclocked_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_30
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
module XLAUI_XLAUI_sync_block_31
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
module XLAUI_XLAUI_sync_block_32
   (mmcm_reset_i_reg,
    reset_time_out_reg,
    out,
    GT2_RX_MMCM_RESET_OUT,
    mmcm_lock_reclocked,
    gt2_rx_cdrlocked_reg,
    data_in,
    SYSCLK_IN);
  output mmcm_reset_i_reg;
  output reset_time_out_reg;
  input [3:0]out;
  input GT2_RX_MMCM_RESET_OUT;
  input mmcm_lock_reclocked;
  input gt2_rx_cdrlocked_reg;
  input data_in;
  input SYSCLK_IN;

  wire GT2_RX_MMCM_RESET_OUT;
  wire SYSCLK_IN;
  wire data_in;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked;
  wire mmcm_reset_i_reg;
  wire [3:0]out;
  wire reset_time_out_reg;
  wire rxpmaresetdone_sync;

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
        .Q(rxpmaresetdone_sync),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFF7FF0000000A)) 
    mmcm_reset_i_i_1__1
       (.I0(out[0]),
        .I1(rxpmaresetdone_sync),
        .I2(out[1]),
        .I3(out[2]),
        .I4(out[3]),
        .I5(GT2_RX_MMCM_RESET_OUT),
        .O(mmcm_reset_i_reg));
  LUT6 #(
    .INIT(64'hF0EFF0E0F0F0F0F0)) 
    reset_time_out_i_5__1
       (.I0(mmcm_lock_reclocked),
        .I1(rxpmaresetdone_sync),
        .I2(out[0]),
        .I3(out[1]),
        .I4(gt2_rx_cdrlocked_reg),
        .I5(out[2]),
        .O(reset_time_out_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_33
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
module XLAUI_XLAUI_sync_block_34
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
module XLAUI_XLAUI_sync_block_35
   (reset_time_out_reg,
    E,
    \FSM_sequential_tx_state_reg[0] ,
    init_wait_done_reg,
    out,
    reset_time_out_reg_0,
    wait_time_done,
    \FSM_sequential_tx_state_reg[1] ,
    mmcm_lock_reclocked,
    time_tlock_max_reg,
    pll_reset_asserted_reg,
    txresetdone_s3,
    time_out_500us_reg,
    time_out_2ms_reg,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output reset_time_out_reg;
  output [0:0]E;
  input \FSM_sequential_tx_state_reg[0] ;
  input init_wait_done_reg;
  input [3:0]out;
  input reset_time_out_reg_0;
  input wait_time_done;
  input \FSM_sequential_tx_state_reg[1] ;
  input mmcm_lock_reclocked;
  input time_tlock_max_reg;
  input pll_reset_asserted_reg;
  input txresetdone_s3;
  input time_out_500us_reg;
  input time_out_2ms_reg;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire [0:0]E;
  wire \FSM_sequential_tx_state[3]_i_7__0_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_8__0_n_0 ;
  wire \FSM_sequential_tx_state_reg[0] ;
  wire \FSM_sequential_tx_state_reg[1] ;
  wire \FSM_sequential_tx_state_reg[3]_i_3__0_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire init_wait_done_reg;
  wire mmcm_lock_reclocked;
  wire [3:0]out;
  wire pll_reset_asserted_reg;
  wire qplllock_sync;
  wire reset_time_out_i_2__0_n_0;
  wire reset_time_out_i_4__0_n_0;
  wire reset_time_out_reg;
  wire reset_time_out_reg_0;
  wire time_out_2ms_reg;
  wire time_out_500us_reg;
  wire time_tlock_max_reg;
  wire txresetdone_s3;
  wire wait_time_done;

  LUT6 #(
    .INIT(64'h0033B8BB0033B888)) 
    \FSM_sequential_tx_state[3]_i_1__0 
       (.I0(\FSM_sequential_tx_state_reg[3]_i_3__0_n_0 ),
        .I1(out[0]),
        .I2(wait_time_done),
        .I3(\FSM_sequential_tx_state_reg[1] ),
        .I4(out[3]),
        .I5(init_wait_done_reg),
        .O(E));
  LUT6 #(
    .INIT(64'hBA00BA00BAFFBA00)) 
    \FSM_sequential_tx_state[3]_i_7__0 
       (.I0(mmcm_lock_reclocked),
        .I1(reset_time_out_reg_0),
        .I2(time_tlock_max_reg),
        .I3(out[2]),
        .I4(pll_reset_asserted_reg),
        .I5(qplllock_sync),
        .O(\FSM_sequential_tx_state[3]_i_7__0_n_0 ));
  LUT6 #(
    .INIT(64'hBAFFBAFFBAFFBA00)) 
    \FSM_sequential_tx_state[3]_i_8__0 
       (.I0(txresetdone_s3),
        .I1(reset_time_out_reg_0),
        .I2(time_out_500us_reg),
        .I3(out[2]),
        .I4(time_out_2ms_reg),
        .I5(qplllock_sync),
        .O(\FSM_sequential_tx_state[3]_i_8__0_n_0 ));
  MUXF7 \FSM_sequential_tx_state_reg[3]_i_3__0 
       (.I0(\FSM_sequential_tx_state[3]_i_7__0_n_0 ),
        .I1(\FSM_sequential_tx_state[3]_i_8__0_n_0 ),
        .O(\FSM_sequential_tx_state_reg[3]_i_3__0_n_0 ),
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
    .INIT(64'h88B8FFFF88B80000)) 
    reset_time_out_i_1__0
       (.I0(reset_time_out_i_2__0_n_0),
        .I1(\FSM_sequential_tx_state_reg[0] ),
        .I2(init_wait_done_reg),
        .I3(out[3]),
        .I4(reset_time_out_i_4__0_n_0),
        .I5(reset_time_out_reg_0),
        .O(reset_time_out_reg));
  LUT6 #(
    .INIT(64'hF4F4FF0F0404FF0F)) 
    reset_time_out_i_2__0
       (.I0(out[3]),
        .I1(qplllock_sync),
        .I2(out[2]),
        .I3(mmcm_lock_reclocked),
        .I4(out[1]),
        .I5(txresetdone_s3),
        .O(reset_time_out_i_2__0_n_0));
  LUT6 #(
    .INIT(64'h303030302020FFFC)) 
    reset_time_out_i_4__0
       (.I0(qplllock_sync),
        .I1(out[3]),
        .I2(out[0]),
        .I3(init_wait_done_reg),
        .I4(out[1]),
        .I5(out[2]),
        .O(reset_time_out_i_4__0_n_0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_36
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
module XLAUI_XLAUI_sync_block_37
   (SR,
    mmcm_lock_reclocked_reg,
    mmcm_lock_reclocked,
    Q,
    \mmcm_lock_count_reg[5] ,
    GT1_TX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output mmcm_lock_reclocked_reg;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input \mmcm_lock_count_reg[5] ;
  input GT1_TX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT1_TX_MMCM_LOCK_IN;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \mmcm_lock_count_reg[5] ;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_reg;

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
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[7]_i_1__0 
       (.I0(mmcm_lock_i),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT5 #(
    .INIT(32'hEAAA0000)) 
    mmcm_lock_reclocked_i_1__0
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(\mmcm_lock_count_reg[5] ),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(mmcm_lock_reclocked_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_38
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
module XLAUI_XLAUI_sync_block_39
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
module XLAUI_XLAUI_sync_block_40
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
module XLAUI_XLAUI_sync_block_41
   (\FSM_sequential_rx_state_reg[0] ,
    reset_time_out_reg,
    rxresetdone_s3_reg,
    out,
    time_out_2ms_reg,
    rxresetdone_s3,
    mmcm_lock_reclocked,
    gt1_rx_cdrlocked_reg,
    data_out,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output \FSM_sequential_rx_state_reg[0] ;
  output reset_time_out_reg;
  input rxresetdone_s3_reg;
  input [2:0]out;
  input time_out_2ms_reg;
  input rxresetdone_s3;
  input mmcm_lock_reclocked;
  input gt1_rx_cdrlocked_reg;
  input data_out;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire \FSM_sequential_rx_state_reg[0] ;
  wire GT0_QPLLLOCK_IN;
  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked;
  wire [2:0]out;
  wire qplllock_sync;
  wire reset_time_out_i_6__0_n_0;
  wire reset_time_out_i_7__0_n_0;
  wire reset_time_out_reg;
  wire rxresetdone_s3;
  wire rxresetdone_s3_reg;
  wire time_out_2ms_reg;

  LUT5 #(
    .INIT(32'hBBB8BBBB)) 
    \FSM_sequential_rx_state[3]_i_4__0 
       (.I0(rxresetdone_s3_reg),
        .I1(out[2]),
        .I2(time_out_2ms_reg),
        .I3(qplllock_sync),
        .I4(out[1]),
        .O(\FSM_sequential_rx_state_reg[0] ));
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
    .INIT(64'hAFCFA0CFAFCFAFCF)) 
    reset_time_out_i_6__0
       (.I0(rxresetdone_s3),
        .I1(gt1_rx_cdrlocked_reg),
        .I2(out[2]),
        .I3(out[1]),
        .I4(qplllock_sync),
        .I5(data_out),
        .O(reset_time_out_i_6__0_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    reset_time_out_i_7__0
       (.I0(rxresetdone_s3),
        .I1(mmcm_lock_reclocked),
        .I2(out[2]),
        .I3(qplllock_sync),
        .I4(out[1]),
        .O(reset_time_out_i_7__0_n_0));
  MUXF7 reset_time_out_reg_i_3__0
       (.I0(reset_time_out_i_6__0_n_0),
        .I1(reset_time_out_i_7__0_n_0),
        .O(reset_time_out_reg),
        .S(out[0]));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_42
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
module XLAUI_XLAUI_sync_block_43
   (data_out,
    reset_time_out_reg,
    rx_fsm_reset_done_int_reg,
    D,
    E,
    DONT_RESET_ON_DATA_ERROR_IN,
    time_out_500us_reg,
    reset_time_out_reg_0,
    \FSM_sequential_rx_state_reg[0] ,
    \FSM_sequential_rx_state_reg[1] ,
    out,
    mmcm_lock_reclocked_reg,
    GT1_RX_FSM_RESET_DONE_OUT,
    time_out_2ms_reg,
    \FSM_sequential_rx_state_reg[2] ,
    gt1_rx_cdrlocked_reg,
    rx_state16_out,
    time_out_1us_reg,
    \FSM_sequential_rx_state_reg[2]_0 ,
    time_out_wait_bypass_s3,
    GT1_DATA_VALID_IN,
    SYSCLK_IN);
  output data_out;
  output reset_time_out_reg;
  output rx_fsm_reset_done_int_reg;
  output [2:0]D;
  output [0:0]E;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input time_out_500us_reg;
  input reset_time_out_reg_0;
  input \FSM_sequential_rx_state_reg[0] ;
  input \FSM_sequential_rx_state_reg[1] ;
  input [3:0]out;
  input mmcm_lock_reclocked_reg;
  input GT1_RX_FSM_RESET_DONE_OUT;
  input time_out_2ms_reg;
  input \FSM_sequential_rx_state_reg[2] ;
  input gt1_rx_cdrlocked_reg;
  input rx_state16_out;
  input time_out_1us_reg;
  input \FSM_sequential_rx_state_reg[2]_0 ;
  input time_out_wait_bypass_s3;
  input GT1_DATA_VALID_IN;
  input SYSCLK_IN;

  wire [2:0]D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire [0:0]E;
  wire \FSM_sequential_rx_state[3]_i_3__0_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_7__0_n_0 ;
  wire \FSM_sequential_rx_state_reg[0] ;
  wire \FSM_sequential_rx_state_reg[1] ;
  wire \FSM_sequential_rx_state_reg[2] ;
  wire \FSM_sequential_rx_state_reg[2]_0 ;
  wire GT1_DATA_VALID_IN;
  wire GT1_RX_FSM_RESET_DONE_OUT;
  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked_reg;
  wire [3:0]out;
  wire reset_time_out_i_2__4_n_0;
  wire reset_time_out_reg;
  wire reset_time_out_reg_0;
  wire rx_fsm_reset_done_int;
  wire rx_fsm_reset_done_int_i_3__0_n_0;
  wire rx_fsm_reset_done_int_i_4__0_n_0;
  wire rx_fsm_reset_done_int_reg;
  wire rx_state1;
  wire rx_state16_out;
  wire time_out_1us_reg;
  wire time_out_2ms_reg;
  wire time_out_500us_reg;
  wire time_out_wait_bypass_s3;

  LUT6 #(
    .INIT(64'h004FFFFF004F0000)) 
    \FSM_sequential_rx_state[0]_i_1__0 
       (.I0(out[1]),
        .I1(rx_state1),
        .I2(out[0]),
        .I3(out[2]),
        .I4(out[3]),
        .I5(time_out_2ms_reg),
        .O(D[0]));
  LUT6 #(
    .INIT(64'h0000333303770000)) 
    \FSM_sequential_rx_state[1]_i_1__0 
       (.I0(rx_state1),
        .I1(out[3]),
        .I2(rx_state16_out),
        .I3(out[2]),
        .I4(out[0]),
        .I5(out[1]),
        .O(D[1]));
  LUT4 #(
    .INIT(16'h0004)) 
    \FSM_sequential_rx_state[1]_i_2__0 
       (.I0(DONT_RESET_ON_DATA_ERROR_IN),
        .I1(time_out_500us_reg),
        .I2(data_out),
        .I3(reset_time_out_reg_0),
        .O(rx_state1));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \FSM_sequential_rx_state[3]_i_1__0 
       (.I0(rx_fsm_reset_done_int_i_4__0_n_0),
        .I1(\FSM_sequential_rx_state[3]_i_3__0_n_0 ),
        .I2(out[3]),
        .I3(\FSM_sequential_rx_state_reg[2] ),
        .I4(out[0]),
        .I5(gt1_rx_cdrlocked_reg),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h07)) 
    \FSM_sequential_rx_state[3]_i_3__0 
       (.I0(data_out),
        .I1(out[1]),
        .I2(out[2]),
        .O(\FSM_sequential_rx_state[3]_i_3__0_n_0 ));
  LUT5 #(
    .INIT(32'h00003347)) 
    \FSM_sequential_rx_state[3]_i_7__0 
       (.I0(rx_state1),
        .I1(out[0]),
        .I2(time_out_wait_bypass_s3),
        .I3(out[1]),
        .I4(out[2]),
        .O(\FSM_sequential_rx_state[3]_i_7__0_n_0 ));
  MUXF7 \FSM_sequential_rx_state_reg[3]_i_2__0 
       (.I0(\FSM_sequential_rx_state_reg[2]_0 ),
        .I1(\FSM_sequential_rx_state[3]_i_7__0_n_0 ),
        .O(D[2]),
        .S(out[3]));
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
        .Q(data_out),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAFCCAFFFA0CCA000)) 
    reset_time_out_i_1__4
       (.I0(reset_time_out_i_2__4_n_0),
        .I1(\FSM_sequential_rx_state_reg[0] ),
        .I2(\FSM_sequential_rx_state_reg[1] ),
        .I3(out[3]),
        .I4(mmcm_lock_reclocked_reg),
        .I5(reset_time_out_reg_0),
        .O(reset_time_out_reg));
  LUT4 #(
    .INIT(16'h001D)) 
    reset_time_out_i_2__4
       (.I0(out[0]),
        .I1(data_out),
        .I2(out[1]),
        .I3(out[2]),
        .O(reset_time_out_i_2__4_n_0));
  LUT6 #(
    .INIT(64'hABFBFFFFA8080000)) 
    rx_fsm_reset_done_int_i_1__0
       (.I0(rx_fsm_reset_done_int),
        .I1(rx_fsm_reset_done_int_i_3__0_n_0),
        .I2(out[0]),
        .I3(rx_fsm_reset_done_int_i_4__0_n_0),
        .I4(out[3]),
        .I5(GT1_RX_FSM_RESET_DONE_OUT),
        .O(rx_fsm_reset_done_int_reg));
  LUT5 #(
    .INIT(32'h00001000)) 
    rx_fsm_reset_done_int_i_2__0
       (.I0(out[0]),
        .I1(out[2]),
        .I2(data_out),
        .I3(time_out_1us_reg),
        .I4(reset_time_out_reg_0),
        .O(rx_fsm_reset_done_int));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT5 #(
    .INIT(32'h000020AA)) 
    rx_fsm_reset_done_int_i_3__0
       (.I0(out[1]),
        .I1(reset_time_out_reg_0),
        .I2(time_out_1us_reg),
        .I3(data_out),
        .I4(out[2]),
        .O(rx_fsm_reset_done_int_i_3__0_n_0));
  LUT6 #(
    .INIT(64'h0000000050505150)) 
    rx_fsm_reset_done_int_i_4__0
       (.I0(out[1]),
        .I1(reset_time_out_reg_0),
        .I2(data_out),
        .I3(time_out_500us_reg),
        .I4(DONT_RESET_ON_DATA_ERROR_IN),
        .I5(out[2]),
        .O(rx_fsm_reset_done_int_i_4__0_n_0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_44
   (SR,
    mmcm_lock_reclocked_reg,
    mmcm_lock_reclocked,
    Q,
    \mmcm_lock_count_reg[5] ,
    GT1_RX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output mmcm_lock_reclocked_reg;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input \mmcm_lock_count_reg[5] ;
  input GT1_RX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT1_RX_MMCM_LOCK_IN;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \mmcm_lock_count_reg[5] ;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_reg;

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
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[7]_i_1__4 
       (.I0(mmcm_lock_i),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT5 #(
    .INIT(32'hEAAA0000)) 
    mmcm_lock_reclocked_i_1__4
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(\mmcm_lock_count_reg[5] ),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(mmcm_lock_reclocked_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_45
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
module XLAUI_XLAUI_sync_block_46
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
module XLAUI_XLAUI_sync_block_47
   (mmcm_reset_i_reg,
    reset_time_out_reg,
    out,
    GT1_RX_MMCM_RESET_OUT,
    mmcm_lock_reclocked,
    gt1_rx_cdrlocked_reg,
    data_in,
    SYSCLK_IN);
  output mmcm_reset_i_reg;
  output reset_time_out_reg;
  input [3:0]out;
  input GT1_RX_MMCM_RESET_OUT;
  input mmcm_lock_reclocked;
  input gt1_rx_cdrlocked_reg;
  input data_in;
  input SYSCLK_IN;

  wire GT1_RX_MMCM_RESET_OUT;
  wire SYSCLK_IN;
  wire data_in;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked;
  wire mmcm_reset_i_reg;
  wire [3:0]out;
  wire reset_time_out_reg;
  wire rxpmaresetdone_sync;

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
        .Q(rxpmaresetdone_sync),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFF7FF0000000A)) 
    mmcm_reset_i_i_1__0
       (.I0(out[0]),
        .I1(rxpmaresetdone_sync),
        .I2(out[1]),
        .I3(out[2]),
        .I4(out[3]),
        .I5(GT1_RX_MMCM_RESET_OUT),
        .O(mmcm_reset_i_reg));
  LUT6 #(
    .INIT(64'hF0EFF0E0F0F0F0F0)) 
    reset_time_out_i_5__0
       (.I0(mmcm_lock_reclocked),
        .I1(rxpmaresetdone_sync),
        .I2(out[0]),
        .I3(out[1]),
        .I4(gt1_rx_cdrlocked_reg),
        .I5(out[2]),
        .O(reset_time_out_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_48
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
module XLAUI_XLAUI_sync_block_49
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
module XLAUI_XLAUI_sync_block_50
   (reset_time_out_reg,
    E,
    \FSM_sequential_tx_state_reg[0] ,
    init_wait_done_reg,
    out,
    reset_time_out,
    wait_time_done,
    \FSM_sequential_tx_state_reg[1] ,
    mmcm_lock_reclocked,
    time_tlock_max_reg,
    pll_reset_asserted_reg,
    txresetdone_s3,
    time_out_500us_reg,
    time_out_2ms_reg,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output reset_time_out_reg;
  output [0:0]E;
  input \FSM_sequential_tx_state_reg[0] ;
  input init_wait_done_reg;
  input [3:0]out;
  input reset_time_out;
  input wait_time_done;
  input \FSM_sequential_tx_state_reg[1] ;
  input mmcm_lock_reclocked;
  input time_tlock_max_reg;
  input pll_reset_asserted_reg;
  input txresetdone_s3;
  input time_out_500us_reg;
  input time_out_2ms_reg;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire [0:0]E;
  wire \FSM_sequential_tx_state[3]_i_7_n_0 ;
  wire \FSM_sequential_tx_state[3]_i_8_n_0 ;
  wire \FSM_sequential_tx_state_reg[0] ;
  wire \FSM_sequential_tx_state_reg[1] ;
  wire \FSM_sequential_tx_state_reg[3]_i_3_n_0 ;
  wire GT0_QPLLLOCK_IN;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire init_wait_done_reg;
  wire mmcm_lock_reclocked;
  wire [3:0]out;
  wire pll_reset_asserted_reg;
  wire qplllock_sync;
  wire reset_time_out;
  wire reset_time_out_i_2_n_0;
  wire reset_time_out_i_4_n_0;
  wire reset_time_out_reg;
  wire time_out_2ms_reg;
  wire time_out_500us_reg;
  wire time_tlock_max_reg;
  wire txresetdone_s3;
  wire wait_time_done;

  LUT6 #(
    .INIT(64'h0033B8BB0033B888)) 
    \FSM_sequential_tx_state[3]_i_1 
       (.I0(\FSM_sequential_tx_state_reg[3]_i_3_n_0 ),
        .I1(out[0]),
        .I2(wait_time_done),
        .I3(\FSM_sequential_tx_state_reg[1] ),
        .I4(out[3]),
        .I5(init_wait_done_reg),
        .O(E));
  LUT6 #(
    .INIT(64'hBA00BA00BAFFBA00)) 
    \FSM_sequential_tx_state[3]_i_7 
       (.I0(mmcm_lock_reclocked),
        .I1(reset_time_out),
        .I2(time_tlock_max_reg),
        .I3(out[2]),
        .I4(pll_reset_asserted_reg),
        .I5(qplllock_sync),
        .O(\FSM_sequential_tx_state[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hBAFFBAFFBAFFBA00)) 
    \FSM_sequential_tx_state[3]_i_8 
       (.I0(txresetdone_s3),
        .I1(reset_time_out),
        .I2(time_out_500us_reg),
        .I3(out[2]),
        .I4(time_out_2ms_reg),
        .I5(qplllock_sync),
        .O(\FSM_sequential_tx_state[3]_i_8_n_0 ));
  MUXF7 \FSM_sequential_tx_state_reg[3]_i_3 
       (.I0(\FSM_sequential_tx_state[3]_i_7_n_0 ),
        .I1(\FSM_sequential_tx_state[3]_i_8_n_0 ),
        .O(\FSM_sequential_tx_state_reg[3]_i_3_n_0 ),
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
    .INIT(64'h88B8FFFF88B80000)) 
    reset_time_out_i_1
       (.I0(reset_time_out_i_2_n_0),
        .I1(\FSM_sequential_tx_state_reg[0] ),
        .I2(init_wait_done_reg),
        .I3(out[3]),
        .I4(reset_time_out_i_4_n_0),
        .I5(reset_time_out),
        .O(reset_time_out_reg));
  LUT6 #(
    .INIT(64'hF4F4FF0F0404FF0F)) 
    reset_time_out_i_2
       (.I0(out[3]),
        .I1(qplllock_sync),
        .I2(out[2]),
        .I3(mmcm_lock_reclocked),
        .I4(out[1]),
        .I5(txresetdone_s3),
        .O(reset_time_out_i_2_n_0));
  LUT6 #(
    .INIT(64'h303030302020FFFC)) 
    reset_time_out_i_4
       (.I0(qplllock_sync),
        .I1(out[3]),
        .I2(out[0]),
        .I3(init_wait_done_reg),
        .I4(out[1]),
        .I5(out[2]),
        .O(reset_time_out_i_4_n_0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_51
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
module XLAUI_XLAUI_sync_block_52
   (SR,
    mmcm_lock_reclocked_reg,
    mmcm_lock_reclocked,
    Q,
    \mmcm_lock_count_reg[5] ,
    GT0_TX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output mmcm_lock_reclocked_reg;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input \mmcm_lock_count_reg[5] ;
  input GT0_TX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT0_TX_MMCM_LOCK_IN;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \mmcm_lock_count_reg[5] ;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_reg;

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
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[7]_i_1 
       (.I0(mmcm_lock_i),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'hEAAA0000)) 
    mmcm_lock_reclocked_i_1
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(\mmcm_lock_count_reg[5] ),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(mmcm_lock_reclocked_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_53
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
module XLAUI_XLAUI_sync_block_54
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
module XLAUI_XLAUI_sync_block_55
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
module XLAUI_XLAUI_sync_block_56
   (\FSM_sequential_rx_state_reg[0] ,
    reset_time_out_reg,
    rxresetdone_s3_reg,
    out,
    time_out_2ms_reg,
    rxresetdone_s3,
    mmcm_lock_reclocked,
    gt0_rx_cdrlocked_reg,
    data_out,
    GT0_QPLLLOCK_IN,
    SYSCLK_IN);
  output \FSM_sequential_rx_state_reg[0] ;
  output reset_time_out_reg;
  input rxresetdone_s3_reg;
  input [2:0]out;
  input time_out_2ms_reg;
  input rxresetdone_s3;
  input mmcm_lock_reclocked;
  input gt0_rx_cdrlocked_reg;
  input data_out;
  input GT0_QPLLLOCK_IN;
  input SYSCLK_IN;

  wire \FSM_sequential_rx_state_reg[0] ;
  wire GT0_QPLLLOCK_IN;
  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked;
  wire [2:0]out;
  wire qplllock_sync;
  wire reset_time_out_i_6_n_0;
  wire reset_time_out_i_7_n_0;
  wire reset_time_out_reg;
  wire rxresetdone_s3;
  wire rxresetdone_s3_reg;
  wire time_out_2ms_reg;

  LUT5 #(
    .INIT(32'hBBB8BBBB)) 
    \FSM_sequential_rx_state[3]_i_4 
       (.I0(rxresetdone_s3_reg),
        .I1(out[2]),
        .I2(time_out_2ms_reg),
        .I3(qplllock_sync),
        .I4(out[1]),
        .O(\FSM_sequential_rx_state_reg[0] ));
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
    .INIT(64'hAFCFA0CFAFCFAFCF)) 
    reset_time_out_i_6
       (.I0(rxresetdone_s3),
        .I1(gt0_rx_cdrlocked_reg),
        .I2(out[2]),
        .I3(out[1]),
        .I4(qplllock_sync),
        .I5(data_out),
        .O(reset_time_out_i_6_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    reset_time_out_i_7
       (.I0(rxresetdone_s3),
        .I1(mmcm_lock_reclocked),
        .I2(out[2]),
        .I3(qplllock_sync),
        .I4(out[1]),
        .O(reset_time_out_i_7_n_0));
  MUXF7 reset_time_out_reg_i_3
       (.I0(reset_time_out_i_6_n_0),
        .I1(reset_time_out_i_7_n_0),
        .O(reset_time_out_reg),
        .S(out[0]));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_57
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
module XLAUI_XLAUI_sync_block_58
   (data_out,
    reset_time_out_reg,
    rx_fsm_reset_done_int_reg,
    D,
    E,
    DONT_RESET_ON_DATA_ERROR_IN,
    time_out_500us_reg,
    reset_time_out_reg_0,
    \FSM_sequential_rx_state_reg[0] ,
    \FSM_sequential_rx_state_reg[1] ,
    out,
    mmcm_lock_reclocked_reg,
    GT0_RX_FSM_RESET_DONE_OUT,
    time_out_2ms_reg,
    \FSM_sequential_rx_state_reg[2] ,
    gt0_rx_cdrlocked_reg,
    rx_state16_out,
    time_out_1us_reg,
    \FSM_sequential_rx_state_reg[2]_0 ,
    time_out_wait_bypass_s3,
    GT0_DATA_VALID_IN,
    SYSCLK_IN);
  output data_out;
  output reset_time_out_reg;
  output rx_fsm_reset_done_int_reg;
  output [2:0]D;
  output [0:0]E;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input time_out_500us_reg;
  input reset_time_out_reg_0;
  input \FSM_sequential_rx_state_reg[0] ;
  input \FSM_sequential_rx_state_reg[1] ;
  input [3:0]out;
  input mmcm_lock_reclocked_reg;
  input GT0_RX_FSM_RESET_DONE_OUT;
  input time_out_2ms_reg;
  input \FSM_sequential_rx_state_reg[2] ;
  input gt0_rx_cdrlocked_reg;
  input rx_state16_out;
  input time_out_1us_reg;
  input \FSM_sequential_rx_state_reg[2]_0 ;
  input time_out_wait_bypass_s3;
  input GT0_DATA_VALID_IN;
  input SYSCLK_IN;

  wire [2:0]D;
  wire DONT_RESET_ON_DATA_ERROR_IN;
  wire [0:0]E;
  wire \FSM_sequential_rx_state[3]_i_3_n_0 ;
  wire \FSM_sequential_rx_state[3]_i_7_n_0 ;
  wire \FSM_sequential_rx_state_reg[0] ;
  wire \FSM_sequential_rx_state_reg[1] ;
  wire \FSM_sequential_rx_state_reg[2] ;
  wire \FSM_sequential_rx_state_reg[2]_0 ;
  wire GT0_DATA_VALID_IN;
  wire GT0_RX_FSM_RESET_DONE_OUT;
  wire SYSCLK_IN;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked_reg;
  wire [3:0]out;
  wire reset_time_out_i_2__3_n_0;
  wire reset_time_out_reg;
  wire reset_time_out_reg_0;
  wire rx_fsm_reset_done_int;
  wire rx_fsm_reset_done_int_i_3_n_0;
  wire rx_fsm_reset_done_int_i_4_n_0;
  wire rx_fsm_reset_done_int_reg;
  wire rx_state1;
  wire rx_state16_out;
  wire time_out_1us_reg;
  wire time_out_2ms_reg;
  wire time_out_500us_reg;
  wire time_out_wait_bypass_s3;

  LUT6 #(
    .INIT(64'h004FFFFF004F0000)) 
    \FSM_sequential_rx_state[0]_i_1 
       (.I0(out[1]),
        .I1(rx_state1),
        .I2(out[0]),
        .I3(out[2]),
        .I4(out[3]),
        .I5(time_out_2ms_reg),
        .O(D[0]));
  LUT6 #(
    .INIT(64'h0000333303770000)) 
    \FSM_sequential_rx_state[1]_i_1 
       (.I0(rx_state1),
        .I1(out[3]),
        .I2(rx_state16_out),
        .I3(out[2]),
        .I4(out[0]),
        .I5(out[1]),
        .O(D[1]));
  LUT4 #(
    .INIT(16'h0004)) 
    \FSM_sequential_rx_state[1]_i_2 
       (.I0(DONT_RESET_ON_DATA_ERROR_IN),
        .I1(time_out_500us_reg),
        .I2(data_out),
        .I3(reset_time_out_reg_0),
        .O(rx_state1));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \FSM_sequential_rx_state[3]_i_1 
       (.I0(rx_fsm_reset_done_int_i_4_n_0),
        .I1(\FSM_sequential_rx_state[3]_i_3_n_0 ),
        .I2(out[3]),
        .I3(\FSM_sequential_rx_state_reg[2] ),
        .I4(out[0]),
        .I5(gt0_rx_cdrlocked_reg),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h07)) 
    \FSM_sequential_rx_state[3]_i_3 
       (.I0(data_out),
        .I1(out[1]),
        .I2(out[2]),
        .O(\FSM_sequential_rx_state[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00003347)) 
    \FSM_sequential_rx_state[3]_i_7 
       (.I0(rx_state1),
        .I1(out[0]),
        .I2(time_out_wait_bypass_s3),
        .I3(out[1]),
        .I4(out[2]),
        .O(\FSM_sequential_rx_state[3]_i_7_n_0 ));
  MUXF7 \FSM_sequential_rx_state_reg[3]_i_2 
       (.I0(\FSM_sequential_rx_state_reg[2]_0 ),
        .I1(\FSM_sequential_rx_state[3]_i_7_n_0 ),
        .O(D[2]),
        .S(out[3]));
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
        .Q(data_out),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAFCCAFFFA0CCA000)) 
    reset_time_out_i_1__3
       (.I0(reset_time_out_i_2__3_n_0),
        .I1(\FSM_sequential_rx_state_reg[0] ),
        .I2(\FSM_sequential_rx_state_reg[1] ),
        .I3(out[3]),
        .I4(mmcm_lock_reclocked_reg),
        .I5(reset_time_out_reg_0),
        .O(reset_time_out_reg));
  LUT4 #(
    .INIT(16'h001D)) 
    reset_time_out_i_2__3
       (.I0(out[0]),
        .I1(data_out),
        .I2(out[1]),
        .I3(out[2]),
        .O(reset_time_out_i_2__3_n_0));
  LUT6 #(
    .INIT(64'hABFBFFFFA8080000)) 
    rx_fsm_reset_done_int_i_1
       (.I0(rx_fsm_reset_done_int),
        .I1(rx_fsm_reset_done_int_i_3_n_0),
        .I2(out[0]),
        .I3(rx_fsm_reset_done_int_i_4_n_0),
        .I4(out[3]),
        .I5(GT0_RX_FSM_RESET_DONE_OUT),
        .O(rx_fsm_reset_done_int_reg));
  LUT5 #(
    .INIT(32'h00001000)) 
    rx_fsm_reset_done_int_i_2
       (.I0(out[0]),
        .I1(out[2]),
        .I2(data_out),
        .I3(time_out_1us_reg),
        .I4(reset_time_out_reg_0),
        .O(rx_fsm_reset_done_int));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h000020AA)) 
    rx_fsm_reset_done_int_i_3
       (.I0(out[1]),
        .I1(reset_time_out_reg_0),
        .I2(time_out_1us_reg),
        .I3(data_out),
        .I4(out[2]),
        .O(rx_fsm_reset_done_int_i_3_n_0));
  LUT6 #(
    .INIT(64'h0000000050505150)) 
    rx_fsm_reset_done_int_i_4
       (.I0(out[1]),
        .I1(reset_time_out_reg_0),
        .I2(data_out),
        .I3(time_out_500us_reg),
        .I4(DONT_RESET_ON_DATA_ERROR_IN),
        .I5(out[2]),
        .O(rx_fsm_reset_done_int_i_4_n_0));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_59
   (SR,
    mmcm_lock_reclocked_reg,
    mmcm_lock_reclocked,
    Q,
    \mmcm_lock_count_reg[5] ,
    GT0_RX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output mmcm_lock_reclocked_reg;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input \mmcm_lock_count_reg[5] ;
  input GT0_RX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT0_RX_MMCM_LOCK_IN;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \mmcm_lock_count_reg[5] ;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_reg;

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
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[7]_i_1__3 
       (.I0(mmcm_lock_i),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hEAAA0000)) 
    mmcm_lock_reclocked_i_1__3
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(\mmcm_lock_count_reg[5] ),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(mmcm_lock_reclocked_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_6
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
module XLAUI_XLAUI_sync_block_60
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
module XLAUI_XLAUI_sync_block_61
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
module XLAUI_XLAUI_sync_block_62
   (mmcm_reset_i_reg,
    reset_time_out_reg,
    out,
    GT0_RX_MMCM_RESET_OUT,
    mmcm_lock_reclocked,
    gt0_rx_cdrlocked_reg,
    data_in,
    SYSCLK_IN);
  output mmcm_reset_i_reg;
  output reset_time_out_reg;
  input [3:0]out;
  input GT0_RX_MMCM_RESET_OUT;
  input mmcm_lock_reclocked;
  input gt0_rx_cdrlocked_reg;
  input data_in;
  input SYSCLK_IN;

  wire GT0_RX_MMCM_RESET_OUT;
  wire SYSCLK_IN;
  wire data_in;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_rx_cdrlocked_reg;
  wire mmcm_lock_reclocked;
  wire mmcm_reset_i_reg;
  wire [3:0]out;
  wire reset_time_out_reg;
  wire rxpmaresetdone_sync;

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
        .Q(rxpmaresetdone_sync),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFF7FF0000000A)) 
    mmcm_reset_i_i_1
       (.I0(out[0]),
        .I1(rxpmaresetdone_sync),
        .I2(out[1]),
        .I3(out[2]),
        .I4(out[3]),
        .I5(GT0_RX_MMCM_RESET_OUT),
        .O(mmcm_reset_i_reg));
  LUT6 #(
    .INIT(64'hF0EFF0E0F0F0F0F0)) 
    reset_time_out_i_5
       (.I0(mmcm_lock_reclocked),
        .I1(rxpmaresetdone_sync),
        .I2(out[0]),
        .I3(out[1]),
        .I4(gt0_rx_cdrlocked_reg),
        .I5(out[2]),
        .O(reset_time_out_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_63
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
module XLAUI_XLAUI_sync_block_64
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
module XLAUI_XLAUI_sync_block_7
   (SR,
    mmcm_lock_reclocked_reg,
    mmcm_lock_reclocked,
    Q,
    \mmcm_lock_count_reg[5] ,
    GT3_TX_MMCM_LOCK_IN,
    SYSCLK_IN);
  output [0:0]SR;
  output mmcm_lock_reclocked_reg;
  input mmcm_lock_reclocked;
  input [1:0]Q;
  input \mmcm_lock_count_reg[5] ;
  input GT3_TX_MMCM_LOCK_IN;
  input SYSCLK_IN;

  wire GT3_TX_MMCM_LOCK_IN;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SYSCLK_IN;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire \mmcm_lock_count_reg[5] ;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_lock_reclocked_reg;

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
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mmcm_lock_count[7]_i_1__2 
       (.I0(mmcm_lock_i),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT5 #(
    .INIT(32'hEAAA0000)) 
    mmcm_lock_reclocked_i_1__2
       (.I0(mmcm_lock_reclocked),
        .I1(Q[1]),
        .I2(\mmcm_lock_count_reg[5] ),
        .I3(Q[0]),
        .I4(mmcm_lock_i),
        .O(mmcm_lock_reclocked_reg));
endmodule

(* ORIG_REF_NAME = "XLAUI_sync_block" *) 
module XLAUI_XLAUI_sync_block_8
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
module XLAUI_XLAUI_sync_block_9
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
