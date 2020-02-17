// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1.1 (lin64) Build 2580384 Sat Jun 29 08:04:45 MDT 2019
// Date        : Mon Jul 15 17:22:23 2019
// Host        : casper1 running 64-bit Ubuntu 16.04.6 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/hpw1/work/tutorials_devel/vivado_2018/skarab/tut_intro/skarab_tut_intro/myproj/myproj.srcs/sources_1/ip/XGMII_FIFO_DUAL_SYNC/XGMII_FIFO_DUAL_SYNC_sim_netlist.v
// Design      : XGMII_FIFO_DUAL_SYNC
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "XGMII_FIFO_DUAL_SYNC,fifo_generator_v13_2_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v13_2_4,Vivado 2019.1.1" *) 
(* NotValidForBitStream *)
module XGMII_FIFO_DUAL_SYNC
   (rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en,
    dout,
    full,
    empty);
  input rst;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 write_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME write_clk, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input wr_clk;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 read_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME read_clk, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input rd_clk;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_DATA" *) input [287:0]din;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *) input wr_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *) input rd_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_DATA" *) output [287:0]dout;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *) output full;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ EMPTY" *) output empty;

  wire [287:0]din;
  wire [287:0]dout;
  wire empty;
  wire full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;
  wire NLW_U0_almost_empty_UNCONNECTED;
  wire NLW_U0_almost_full_UNCONNECTED;
  wire NLW_U0_axi_ar_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_overflow_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_full_UNCONNECTED;
  wire NLW_U0_axi_ar_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_underflow_UNCONNECTED;
  wire NLW_U0_axi_aw_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_overflow_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_full_UNCONNECTED;
  wire NLW_U0_axi_aw_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_underflow_UNCONNECTED;
  wire NLW_U0_axi_b_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_overflow_UNCONNECTED;
  wire NLW_U0_axi_b_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_b_prog_full_UNCONNECTED;
  wire NLW_U0_axi_b_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_underflow_UNCONNECTED;
  wire NLW_U0_axi_r_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_overflow_UNCONNECTED;
  wire NLW_U0_axi_r_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_r_prog_full_UNCONNECTED;
  wire NLW_U0_axi_r_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_underflow_UNCONNECTED;
  wire NLW_U0_axi_w_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_overflow_UNCONNECTED;
  wire NLW_U0_axi_w_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_w_prog_full_UNCONNECTED;
  wire NLW_U0_axi_w_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_underflow_UNCONNECTED;
  wire NLW_U0_axis_dbiterr_UNCONNECTED;
  wire NLW_U0_axis_overflow_UNCONNECTED;
  wire NLW_U0_axis_prog_empty_UNCONNECTED;
  wire NLW_U0_axis_prog_full_UNCONNECTED;
  wire NLW_U0_axis_sbiterr_UNCONNECTED;
  wire NLW_U0_axis_underflow_UNCONNECTED;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_m_axi_arvalid_UNCONNECTED;
  wire NLW_U0_m_axi_awvalid_UNCONNECTED;
  wire NLW_U0_m_axi_bready_UNCONNECTED;
  wire NLW_U0_m_axi_rready_UNCONNECTED;
  wire NLW_U0_m_axi_wlast_UNCONNECTED;
  wire NLW_U0_m_axi_wvalid_UNCONNECTED;
  wire NLW_U0_m_axis_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_tvalid_UNCONNECTED;
  wire NLW_U0_overflow_UNCONNECTED;
  wire NLW_U0_prog_empty_UNCONNECTED;
  wire NLW_U0_prog_full_UNCONNECTED;
  wire NLW_U0_rd_rst_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_s_axis_tready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire NLW_U0_underflow_UNCONNECTED;
  wire NLW_U0_valid_UNCONNECTED;
  wire NLW_U0_wr_ack_UNCONNECTED;
  wire NLW_U0_wr_rst_busy_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_data_count_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_araddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_arburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_arlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_aruser_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_awaddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_awburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_awlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awuser_UNCONNECTED;
  wire [63:0]NLW_U0_m_axi_wdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_wstrb_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wuser_UNCONNECTED;
  wire [7:0]NLW_U0_m_axis_tdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tdest_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tid_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tkeep_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tstrb_UNCONNECTED;
  wire [3:0]NLW_U0_m_axis_tuser_UNCONNECTED;
  wire [4:0]NLW_U0_rd_data_count_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_buser_UNCONNECTED;
  wire [63:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_ruser_UNCONNECTED;
  wire [4:0]NLW_U0_wr_data_count_UNCONNECTED;

  (* C_ADD_NGC_CONSTRAINT = "0" *) 
  (* C_APPLICATION_TYPE_AXIS = "0" *) 
  (* C_APPLICATION_TYPE_RACH = "0" *) 
  (* C_APPLICATION_TYPE_RDCH = "0" *) 
  (* C_APPLICATION_TYPE_WACH = "0" *) 
  (* C_APPLICATION_TYPE_WDCH = "0" *) 
  (* C_APPLICATION_TYPE_WRCH = "0" *) 
  (* C_AXIS_TDATA_WIDTH = "8" *) 
  (* C_AXIS_TDEST_WIDTH = "1" *) 
  (* C_AXIS_TID_WIDTH = "1" *) 
  (* C_AXIS_TKEEP_WIDTH = "1" *) 
  (* C_AXIS_TSTRB_WIDTH = "1" *) 
  (* C_AXIS_TUSER_WIDTH = "4" *) 
  (* C_AXIS_TYPE = "0" *) 
  (* C_AXI_ADDR_WIDTH = "32" *) 
  (* C_AXI_ARUSER_WIDTH = "1" *) 
  (* C_AXI_AWUSER_WIDTH = "1" *) 
  (* C_AXI_BUSER_WIDTH = "1" *) 
  (* C_AXI_DATA_WIDTH = "64" *) 
  (* C_AXI_ID_WIDTH = "1" *) 
  (* C_AXI_LEN_WIDTH = "8" *) 
  (* C_AXI_LOCK_WIDTH = "1" *) 
  (* C_AXI_RUSER_WIDTH = "1" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_AXI_WUSER_WIDTH = "1" *) 
  (* C_COMMON_CLOCK = "0" *) 
  (* C_COUNT_TYPE = "0" *) 
  (* C_DATA_COUNT_WIDTH = "5" *) 
  (* C_DEFAULT_VALUE = "BlankString" *) 
  (* C_DIN_WIDTH = "288" *) 
  (* C_DIN_WIDTH_AXIS = "1" *) 
  (* C_DIN_WIDTH_RACH = "32" *) 
  (* C_DIN_WIDTH_RDCH = "64" *) 
  (* C_DIN_WIDTH_WACH = "1" *) 
  (* C_DIN_WIDTH_WDCH = "64" *) 
  (* C_DIN_WIDTH_WRCH = "2" *) 
  (* C_DOUT_RST_VAL = "0" *) 
  (* C_DOUT_WIDTH = "288" *) 
  (* C_ENABLE_RLOCS = "0" *) 
  (* C_ENABLE_RST_SYNC = "1" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_ERROR_INJECTION_TYPE = "0" *) 
  (* C_ERROR_INJECTION_TYPE_AXIS = "0" *) 
  (* C_ERROR_INJECTION_TYPE_RACH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WACH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WRCH = "0" *) 
  (* C_FAMILY = "virtex7" *) 
  (* C_FULL_FLAGS_RST_VAL = "1" *) 
  (* C_HAS_ALMOST_EMPTY = "0" *) 
  (* C_HAS_ALMOST_FULL = "0" *) 
  (* C_HAS_AXIS_TDATA = "1" *) 
  (* C_HAS_AXIS_TDEST = "0" *) 
  (* C_HAS_AXIS_TID = "0" *) 
  (* C_HAS_AXIS_TKEEP = "0" *) 
  (* C_HAS_AXIS_TLAST = "0" *) 
  (* C_HAS_AXIS_TREADY = "1" *) 
  (* C_HAS_AXIS_TSTRB = "0" *) 
  (* C_HAS_AXIS_TUSER = "1" *) 
  (* C_HAS_AXI_ARUSER = "0" *) 
  (* C_HAS_AXI_AWUSER = "0" *) 
  (* C_HAS_AXI_BUSER = "0" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_AXI_RD_CHANNEL = "1" *) 
  (* C_HAS_AXI_RUSER = "0" *) 
  (* C_HAS_AXI_WR_CHANNEL = "1" *) 
  (* C_HAS_AXI_WUSER = "0" *) 
  (* C_HAS_BACKUP = "0" *) 
  (* C_HAS_DATA_COUNT = "0" *) 
  (* C_HAS_DATA_COUNTS_AXIS = "0" *) 
  (* C_HAS_DATA_COUNTS_RACH = "0" *) 
  (* C_HAS_DATA_COUNTS_RDCH = "0" *) 
  (* C_HAS_DATA_COUNTS_WACH = "0" *) 
  (* C_HAS_DATA_COUNTS_WDCH = "0" *) 
  (* C_HAS_DATA_COUNTS_WRCH = "0" *) 
  (* C_HAS_INT_CLK = "0" *) 
  (* C_HAS_MASTER_CE = "0" *) 
  (* C_HAS_MEMINIT_FILE = "0" *) 
  (* C_HAS_OVERFLOW = "0" *) 
  (* C_HAS_PROG_FLAGS_AXIS = "0" *) 
  (* C_HAS_PROG_FLAGS_RACH = "0" *) 
  (* C_HAS_PROG_FLAGS_RDCH = "0" *) 
  (* C_HAS_PROG_FLAGS_WACH = "0" *) 
  (* C_HAS_PROG_FLAGS_WDCH = "0" *) 
  (* C_HAS_PROG_FLAGS_WRCH = "0" *) 
  (* C_HAS_RD_DATA_COUNT = "0" *) 
  (* C_HAS_RD_RST = "0" *) 
  (* C_HAS_RST = "1" *) 
  (* C_HAS_SLAVE_CE = "0" *) 
  (* C_HAS_SRST = "0" *) 
  (* C_HAS_UNDERFLOW = "0" *) 
  (* C_HAS_VALID = "0" *) 
  (* C_HAS_WR_ACK = "0" *) 
  (* C_HAS_WR_DATA_COUNT = "0" *) 
  (* C_HAS_WR_RST = "0" *) 
  (* C_IMPLEMENTATION_TYPE = "2" *) 
  (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) 
  (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_RDCH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WACH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WRCH = "1" *) 
  (* C_INIT_WR_PNTR_VAL = "0" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_MEMORY_TYPE = "2" *) 
  (* C_MIF_FILE_NAME = "BlankString" *) 
  (* C_MSGON_VAL = "1" *) 
  (* C_OPTIMIZATION_MODE = "0" *) 
  (* C_OVERFLOW_LOW = "0" *) 
  (* C_POWER_SAVING_MODE = "0" *) 
  (* C_PRELOAD_LATENCY = "1" *) 
  (* C_PRELOAD_REGS = "0" *) 
  (* C_PRIM_FIFO_TYPE = "512x72" *) 
  (* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) 
  (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) 
  (* C_PRIM_FIFO_TYPE_WACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) 
  (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL = "2" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "3" *) 
  (* C_PROG_EMPTY_TYPE = "0" *) 
  (* C_PROG_EMPTY_TYPE_AXIS = "0" *) 
  (* C_PROG_EMPTY_TYPE_RACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL = "29" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
  (* C_PROG_FULL_THRESH_NEGATE_VAL = "28" *) 
  (* C_PROG_FULL_TYPE = "0" *) 
  (* C_PROG_FULL_TYPE_AXIS = "0" *) 
  (* C_PROG_FULL_TYPE_RACH = "0" *) 
  (* C_PROG_FULL_TYPE_RDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WACH = "0" *) 
  (* C_PROG_FULL_TYPE_WDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WRCH = "0" *) 
  (* C_RACH_TYPE = "0" *) 
  (* C_RDCH_TYPE = "0" *) 
  (* C_RD_DATA_COUNT_WIDTH = "5" *) 
  (* C_RD_DEPTH = "32" *) 
  (* C_RD_FREQ = "1" *) 
  (* C_RD_PNTR_WIDTH = "5" *) 
  (* C_REG_SLICE_MODE_AXIS = "0" *) 
  (* C_REG_SLICE_MODE_RACH = "0" *) 
  (* C_REG_SLICE_MODE_RDCH = "0" *) 
  (* C_REG_SLICE_MODE_WACH = "0" *) 
  (* C_REG_SLICE_MODE_WDCH = "0" *) 
  (* C_REG_SLICE_MODE_WRCH = "0" *) 
  (* C_SELECT_XPM = "0" *) 
  (* C_SYNCHRONIZER_STAGE = "2" *) 
  (* C_UNDERFLOW_LOW = "0" *) 
  (* C_USE_COMMON_OVERFLOW = "0" *) 
  (* C_USE_COMMON_UNDERFLOW = "0" *) 
  (* C_USE_DEFAULT_SETTINGS = "0" *) 
  (* C_USE_DOUT_RST = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_ECC_AXIS = "0" *) 
  (* C_USE_ECC_RACH = "0" *) 
  (* C_USE_ECC_RDCH = "0" *) 
  (* C_USE_ECC_WACH = "0" *) 
  (* C_USE_ECC_WDCH = "0" *) 
  (* C_USE_ECC_WRCH = "0" *) 
  (* C_USE_EMBEDDED_REG = "0" *) 
  (* C_USE_FIFO16_FLAGS = "0" *) 
  (* C_USE_FWFT_DATA_COUNT = "0" *) 
  (* C_USE_PIPELINE_REG = "0" *) 
  (* C_VALID_LOW = "0" *) 
  (* C_WACH_TYPE = "0" *) 
  (* C_WDCH_TYPE = "0" *) 
  (* C_WRCH_TYPE = "0" *) 
  (* C_WR_ACK_LOW = "0" *) 
  (* C_WR_DATA_COUNT_WIDTH = "5" *) 
  (* C_WR_DEPTH = "32" *) 
  (* C_WR_DEPTH_AXIS = "1024" *) 
  (* C_WR_DEPTH_RACH = "16" *) 
  (* C_WR_DEPTH_RDCH = "1024" *) 
  (* C_WR_DEPTH_WACH = "16" *) 
  (* C_WR_DEPTH_WDCH = "1024" *) 
  (* C_WR_DEPTH_WRCH = "16" *) 
  (* C_WR_FREQ = "1" *) 
  (* C_WR_PNTR_WIDTH = "5" *) 
  (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
  (* C_WR_PNTR_WIDTH_RACH = "4" *) 
  (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WACH = "4" *) 
  (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
  (* C_WR_RESPONSE_LATENCY = "1" *) 
  XGMII_FIFO_DUAL_SYNC_fifo_generator_v13_2_4 U0
       (.almost_empty(NLW_U0_almost_empty_UNCONNECTED),
        .almost_full(NLW_U0_almost_full_UNCONNECTED),
        .axi_ar_data_count(NLW_U0_axi_ar_data_count_UNCONNECTED[4:0]),
        .axi_ar_dbiterr(NLW_U0_axi_ar_dbiterr_UNCONNECTED),
        .axi_ar_injectdbiterr(1'b0),
        .axi_ar_injectsbiterr(1'b0),
        .axi_ar_overflow(NLW_U0_axi_ar_overflow_UNCONNECTED),
        .axi_ar_prog_empty(NLW_U0_axi_ar_prog_empty_UNCONNECTED),
        .axi_ar_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_ar_prog_full(NLW_U0_axi_ar_prog_full_UNCONNECTED),
        .axi_ar_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_ar_rd_data_count(NLW_U0_axi_ar_rd_data_count_UNCONNECTED[4:0]),
        .axi_ar_sbiterr(NLW_U0_axi_ar_sbiterr_UNCONNECTED),
        .axi_ar_underflow(NLW_U0_axi_ar_underflow_UNCONNECTED),
        .axi_ar_wr_data_count(NLW_U0_axi_ar_wr_data_count_UNCONNECTED[4:0]),
        .axi_aw_data_count(NLW_U0_axi_aw_data_count_UNCONNECTED[4:0]),
        .axi_aw_dbiterr(NLW_U0_axi_aw_dbiterr_UNCONNECTED),
        .axi_aw_injectdbiterr(1'b0),
        .axi_aw_injectsbiterr(1'b0),
        .axi_aw_overflow(NLW_U0_axi_aw_overflow_UNCONNECTED),
        .axi_aw_prog_empty(NLW_U0_axi_aw_prog_empty_UNCONNECTED),
        .axi_aw_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_aw_prog_full(NLW_U0_axi_aw_prog_full_UNCONNECTED),
        .axi_aw_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_aw_rd_data_count(NLW_U0_axi_aw_rd_data_count_UNCONNECTED[4:0]),
        .axi_aw_sbiterr(NLW_U0_axi_aw_sbiterr_UNCONNECTED),
        .axi_aw_underflow(NLW_U0_axi_aw_underflow_UNCONNECTED),
        .axi_aw_wr_data_count(NLW_U0_axi_aw_wr_data_count_UNCONNECTED[4:0]),
        .axi_b_data_count(NLW_U0_axi_b_data_count_UNCONNECTED[4:0]),
        .axi_b_dbiterr(NLW_U0_axi_b_dbiterr_UNCONNECTED),
        .axi_b_injectdbiterr(1'b0),
        .axi_b_injectsbiterr(1'b0),
        .axi_b_overflow(NLW_U0_axi_b_overflow_UNCONNECTED),
        .axi_b_prog_empty(NLW_U0_axi_b_prog_empty_UNCONNECTED),
        .axi_b_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_b_prog_full(NLW_U0_axi_b_prog_full_UNCONNECTED),
        .axi_b_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_b_rd_data_count(NLW_U0_axi_b_rd_data_count_UNCONNECTED[4:0]),
        .axi_b_sbiterr(NLW_U0_axi_b_sbiterr_UNCONNECTED),
        .axi_b_underflow(NLW_U0_axi_b_underflow_UNCONNECTED),
        .axi_b_wr_data_count(NLW_U0_axi_b_wr_data_count_UNCONNECTED[4:0]),
        .axi_r_data_count(NLW_U0_axi_r_data_count_UNCONNECTED[10:0]),
        .axi_r_dbiterr(NLW_U0_axi_r_dbiterr_UNCONNECTED),
        .axi_r_injectdbiterr(1'b0),
        .axi_r_injectsbiterr(1'b0),
        .axi_r_overflow(NLW_U0_axi_r_overflow_UNCONNECTED),
        .axi_r_prog_empty(NLW_U0_axi_r_prog_empty_UNCONNECTED),
        .axi_r_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_r_prog_full(NLW_U0_axi_r_prog_full_UNCONNECTED),
        .axi_r_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_r_rd_data_count(NLW_U0_axi_r_rd_data_count_UNCONNECTED[10:0]),
        .axi_r_sbiterr(NLW_U0_axi_r_sbiterr_UNCONNECTED),
        .axi_r_underflow(NLW_U0_axi_r_underflow_UNCONNECTED),
        .axi_r_wr_data_count(NLW_U0_axi_r_wr_data_count_UNCONNECTED[10:0]),
        .axi_w_data_count(NLW_U0_axi_w_data_count_UNCONNECTED[10:0]),
        .axi_w_dbiterr(NLW_U0_axi_w_dbiterr_UNCONNECTED),
        .axi_w_injectdbiterr(1'b0),
        .axi_w_injectsbiterr(1'b0),
        .axi_w_overflow(NLW_U0_axi_w_overflow_UNCONNECTED),
        .axi_w_prog_empty(NLW_U0_axi_w_prog_empty_UNCONNECTED),
        .axi_w_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_w_prog_full(NLW_U0_axi_w_prog_full_UNCONNECTED),
        .axi_w_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_w_rd_data_count(NLW_U0_axi_w_rd_data_count_UNCONNECTED[10:0]),
        .axi_w_sbiterr(NLW_U0_axi_w_sbiterr_UNCONNECTED),
        .axi_w_underflow(NLW_U0_axi_w_underflow_UNCONNECTED),
        .axi_w_wr_data_count(NLW_U0_axi_w_wr_data_count_UNCONNECTED[10:0]),
        .axis_data_count(NLW_U0_axis_data_count_UNCONNECTED[10:0]),
        .axis_dbiterr(NLW_U0_axis_dbiterr_UNCONNECTED),
        .axis_injectdbiterr(1'b0),
        .axis_injectsbiterr(1'b0),
        .axis_overflow(NLW_U0_axis_overflow_UNCONNECTED),
        .axis_prog_empty(NLW_U0_axis_prog_empty_UNCONNECTED),
        .axis_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axis_prog_full(NLW_U0_axis_prog_full_UNCONNECTED),
        .axis_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axis_rd_data_count(NLW_U0_axis_rd_data_count_UNCONNECTED[10:0]),
        .axis_sbiterr(NLW_U0_axis_sbiterr_UNCONNECTED),
        .axis_underflow(NLW_U0_axis_underflow_UNCONNECTED),
        .axis_wr_data_count(NLW_U0_axis_wr_data_count_UNCONNECTED[10:0]),
        .backup(1'b0),
        .backup_marker(1'b0),
        .clk(1'b0),
        .data_count(NLW_U0_data_count_UNCONNECTED[4:0]),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .int_clk(1'b0),
        .m_aclk(1'b0),
        .m_aclk_en(1'b0),
        .m_axi_araddr(NLW_U0_m_axi_araddr_UNCONNECTED[31:0]),
        .m_axi_arburst(NLW_U0_m_axi_arburst_UNCONNECTED[1:0]),
        .m_axi_arcache(NLW_U0_m_axi_arcache_UNCONNECTED[3:0]),
        .m_axi_arid(NLW_U0_m_axi_arid_UNCONNECTED[0]),
        .m_axi_arlen(NLW_U0_m_axi_arlen_UNCONNECTED[7:0]),
        .m_axi_arlock(NLW_U0_m_axi_arlock_UNCONNECTED[0]),
        .m_axi_arprot(NLW_U0_m_axi_arprot_UNCONNECTED[2:0]),
        .m_axi_arqos(NLW_U0_m_axi_arqos_UNCONNECTED[3:0]),
        .m_axi_arready(1'b0),
        .m_axi_arregion(NLW_U0_m_axi_arregion_UNCONNECTED[3:0]),
        .m_axi_arsize(NLW_U0_m_axi_arsize_UNCONNECTED[2:0]),
        .m_axi_aruser(NLW_U0_m_axi_aruser_UNCONNECTED[0]),
        .m_axi_arvalid(NLW_U0_m_axi_arvalid_UNCONNECTED),
        .m_axi_awaddr(NLW_U0_m_axi_awaddr_UNCONNECTED[31:0]),
        .m_axi_awburst(NLW_U0_m_axi_awburst_UNCONNECTED[1:0]),
        .m_axi_awcache(NLW_U0_m_axi_awcache_UNCONNECTED[3:0]),
        .m_axi_awid(NLW_U0_m_axi_awid_UNCONNECTED[0]),
        .m_axi_awlen(NLW_U0_m_axi_awlen_UNCONNECTED[7:0]),
        .m_axi_awlock(NLW_U0_m_axi_awlock_UNCONNECTED[0]),
        .m_axi_awprot(NLW_U0_m_axi_awprot_UNCONNECTED[2:0]),
        .m_axi_awqos(NLW_U0_m_axi_awqos_UNCONNECTED[3:0]),
        .m_axi_awready(1'b0),
        .m_axi_awregion(NLW_U0_m_axi_awregion_UNCONNECTED[3:0]),
        .m_axi_awsize(NLW_U0_m_axi_awsize_UNCONNECTED[2:0]),
        .m_axi_awuser(NLW_U0_m_axi_awuser_UNCONNECTED[0]),
        .m_axi_awvalid(NLW_U0_m_axi_awvalid_UNCONNECTED),
        .m_axi_bid(1'b0),
        .m_axi_bready(NLW_U0_m_axi_bready_UNCONNECTED),
        .m_axi_bresp({1'b0,1'b0}),
        .m_axi_buser(1'b0),
        .m_axi_bvalid(1'b0),
        .m_axi_rdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_rid(1'b0),
        .m_axi_rlast(1'b0),
        .m_axi_rready(NLW_U0_m_axi_rready_UNCONNECTED),
        .m_axi_rresp({1'b0,1'b0}),
        .m_axi_ruser(1'b0),
        .m_axi_rvalid(1'b0),
        .m_axi_wdata(NLW_U0_m_axi_wdata_UNCONNECTED[63:0]),
        .m_axi_wid(NLW_U0_m_axi_wid_UNCONNECTED[0]),
        .m_axi_wlast(NLW_U0_m_axi_wlast_UNCONNECTED),
        .m_axi_wready(1'b0),
        .m_axi_wstrb(NLW_U0_m_axi_wstrb_UNCONNECTED[7:0]),
        .m_axi_wuser(NLW_U0_m_axi_wuser_UNCONNECTED[0]),
        .m_axi_wvalid(NLW_U0_m_axi_wvalid_UNCONNECTED),
        .m_axis_tdata(NLW_U0_m_axis_tdata_UNCONNECTED[7:0]),
        .m_axis_tdest(NLW_U0_m_axis_tdest_UNCONNECTED[0]),
        .m_axis_tid(NLW_U0_m_axis_tid_UNCONNECTED[0]),
        .m_axis_tkeep(NLW_U0_m_axis_tkeep_UNCONNECTED[0]),
        .m_axis_tlast(NLW_U0_m_axis_tlast_UNCONNECTED),
        .m_axis_tready(1'b0),
        .m_axis_tstrb(NLW_U0_m_axis_tstrb_UNCONNECTED[0]),
        .m_axis_tuser(NLW_U0_m_axis_tuser_UNCONNECTED[3:0]),
        .m_axis_tvalid(NLW_U0_m_axis_tvalid_UNCONNECTED),
        .overflow(NLW_U0_overflow_UNCONNECTED),
        .prog_empty(NLW_U0_prog_empty_UNCONNECTED),
        .prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full(NLW_U0_prog_full_UNCONNECTED),
        .prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .rd_clk(rd_clk),
        .rd_data_count(NLW_U0_rd_data_count_UNCONNECTED[4:0]),
        .rd_en(rd_en),
        .rd_rst(1'b0),
        .rd_rst_busy(NLW_U0_rd_rst_busy_UNCONNECTED),
        .rst(rst),
        .s_aclk(1'b0),
        .s_aclk_en(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arid(1'b0),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlock(1'b0),
        .s_axi_arprot({1'b0,1'b0,1'b0}),
        .s_axi_arqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_aruser(1'b0),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awid(1'b0),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlock(1'b0),
        .s_axi_awprot({1'b0,1'b0,1'b0}),
        .s_axi_awqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awuser(1'b0),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_buser(NLW_U0_s_axi_buser_UNCONNECTED[0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[63:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_ruser(NLW_U0_s_axi_ruser_UNCONNECTED[0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wid(1'b0),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wuser(1'b0),
        .s_axi_wvalid(1'b0),
        .s_axis_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tdest(1'b0),
        .s_axis_tid(1'b0),
        .s_axis_tkeep(1'b0),
        .s_axis_tlast(1'b0),
        .s_axis_tready(NLW_U0_s_axis_tready_UNCONNECTED),
        .s_axis_tstrb(1'b0),
        .s_axis_tuser({1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .sleep(1'b0),
        .srst(1'b0),
        .underflow(NLW_U0_underflow_UNCONNECTED),
        .valid(NLW_U0_valid_UNCONNECTED),
        .wr_ack(NLW_U0_wr_ack_UNCONNECTED),
        .wr_clk(wr_clk),
        .wr_data_count(NLW_U0_wr_data_count_UNCONNECTED[4:0]),
        .wr_en(wr_en),
        .wr_rst(1'b0),
        .wr_rst_busy(NLW_U0_wr_rst_busy_UNCONNECTED));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) 
(* INV_DEF_VAL = "1'b1" *) (* ORIG_REF_NAME = "xpm_cdc_async_rst" *) (* RST_ACTIVE_HIGH = "1" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* xpm_cdc = "ASYNC_RST" *) 
module XGMII_FIFO_DUAL_SYNC_xpm_cdc_async_rst
   (src_arst,
    dest_clk,
    dest_arst);
  input src_arst;
  input dest_clk;
  output dest_arst;

  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "ASYNC_RST" *) wire [1:0]arststages_ff;
  wire dest_clk;
  wire src_arst;

  assign dest_arst = arststages_ff[1];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  FDPE #(
    .INIT(1'b0)) 
    \arststages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(src_arst),
        .Q(arststages_ff[0]));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  FDPE #(
    .INIT(1'b0)) 
    \arststages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(arststages_ff[0]),
        .PRE(src_arst),
        .Q(arststages_ff[1]));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) 
(* INV_DEF_VAL = "1'b1" *) (* ORIG_REF_NAME = "xpm_cdc_async_rst" *) (* RST_ACTIVE_HIGH = "1" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* xpm_cdc = "ASYNC_RST" *) 
module XGMII_FIFO_DUAL_SYNC_xpm_cdc_async_rst__2
   (src_arst,
    dest_clk,
    dest_arst);
  input src_arst;
  input dest_clk;
  output dest_arst;

  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "ASYNC_RST" *) wire [1:0]arststages_ff;
  wire dest_clk;
  wire src_arst;

  assign dest_arst = arststages_ff[1];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  FDPE #(
    .INIT(1'b0)) 
    \arststages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(src_arst),
        .Q(arststages_ff[0]));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  FDPE #(
    .INIT(1'b0)) 
    \arststages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(arststages_ff[0]),
        .PRE(src_arst),
        .Q(arststages_ff[1]));
endmodule

(* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "1" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "5" *) (* XPM_MODULE = "TRUE" *) 
(* xpm_cdc = "GRAY" *) 
module XGMII_FIFO_DUAL_SYNC_xpm_cdc_gray
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [4:0]src_in_bin;
  input dest_clk;
  output [4:0]dest_out_bin;

  wire [4:0]async_path;
  wire [3:0]binval;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [4:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [4:0]\dest_graysync_ff[1] ;
  wire [4:0]dest_out_bin;
  wire [3:0]gray_enc;
  wire src_clk;
  wire [4:0]src_in_bin;

  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin_ff[0]_i_1 
       (.I0(\dest_graysync_ff[1] [0]),
        .I1(\dest_graysync_ff[1] [2]),
        .I2(\dest_graysync_ff[1] [4]),
        .I3(\dest_graysync_ff[1] [3]),
        .I4(\dest_graysync_ff[1] [1]),
        .O(binval[0]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin_ff[1]_i_1 
       (.I0(\dest_graysync_ff[1] [1]),
        .I1(\dest_graysync_ff[1] [3]),
        .I2(\dest_graysync_ff[1] [4]),
        .I3(\dest_graysync_ff[1] [2]),
        .O(binval[1]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin_ff[2]_i_1 
       (.I0(\dest_graysync_ff[1] [2]),
        .I1(\dest_graysync_ff[1] [4]),
        .I2(\dest_graysync_ff[1] [3]),
        .O(binval[2]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin_ff[3]_i_1 
       (.I0(\dest_graysync_ff[1] [3]),
        .I1(\dest_graysync_ff[1] [4]),
        .O(binval[3]));
  FDRE \dest_out_bin_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[0]),
        .Q(dest_out_bin[0]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[1]),
        .Q(dest_out_bin[1]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[2]),
        .Q(dest_out_bin[2]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[3]),
        .Q(dest_out_bin[3]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [4]),
        .Q(dest_out_bin[4]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[0]),
        .O(gray_enc[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[1]),
        .O(gray_enc[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[2]),
        .O(gray_enc[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[3]),
        .O(gray_enc[3]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[4]),
        .Q(async_path[4]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "1" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "5" *) (* XPM_MODULE = "TRUE" *) 
(* xpm_cdc = "GRAY" *) 
module XGMII_FIFO_DUAL_SYNC_xpm_cdc_gray__2
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [4:0]src_in_bin;
  input dest_clk;
  output [4:0]dest_out_bin;

  wire [4:0]async_path;
  wire [3:0]binval;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [4:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [4:0]\dest_graysync_ff[1] ;
  wire [4:0]dest_out_bin;
  wire [3:0]gray_enc;
  wire src_clk;
  wire [4:0]src_in_bin;

  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin_ff[0]_i_1 
       (.I0(\dest_graysync_ff[1] [0]),
        .I1(\dest_graysync_ff[1] [2]),
        .I2(\dest_graysync_ff[1] [4]),
        .I3(\dest_graysync_ff[1] [3]),
        .I4(\dest_graysync_ff[1] [1]),
        .O(binval[0]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin_ff[1]_i_1 
       (.I0(\dest_graysync_ff[1] [1]),
        .I1(\dest_graysync_ff[1] [3]),
        .I2(\dest_graysync_ff[1] [4]),
        .I3(\dest_graysync_ff[1] [2]),
        .O(binval[1]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin_ff[2]_i_1 
       (.I0(\dest_graysync_ff[1] [2]),
        .I1(\dest_graysync_ff[1] [4]),
        .I2(\dest_graysync_ff[1] [3]),
        .O(binval[2]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin_ff[3]_i_1 
       (.I0(\dest_graysync_ff[1] [3]),
        .I1(\dest_graysync_ff[1] [4]),
        .O(binval[3]));
  FDRE \dest_out_bin_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[0]),
        .Q(dest_out_bin[0]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[1]),
        .Q(dest_out_bin[1]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[2]),
        .Q(dest_out_bin[2]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[3]),
        .Q(dest_out_bin[3]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [4]),
        .Q(dest_out_bin[4]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[0]),
        .O(gray_enc[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[1]),
        .O(gray_enc[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[2]),
        .O(gray_enc[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[3]),
        .O(gray_enc[3]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[4]),
        .Q(async_path[4]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "4" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_single" *) 
(* SIM_ASSERT_CHK = "0" *) (* SRC_INPUT_REG = "0" *) (* VERSION = "0" *) 
(* XPM_MODULE = "TRUE" *) (* xpm_cdc = "SINGLE" *) 
module XGMII_FIFO_DUAL_SYNC_xpm_cdc_single
   (src_clk,
    src_in,
    dest_clk,
    dest_out);
  input src_clk;
  input src_in;
  input dest_clk;
  output dest_out;

  wire dest_clk;
  wire src_in;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SINGLE" *) wire [3:0]syncstages_ff;

  assign dest_out = syncstages_ff[3];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_in),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "4" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_single" *) 
(* SIM_ASSERT_CHK = "0" *) (* SRC_INPUT_REG = "0" *) (* VERSION = "0" *) 
(* XPM_MODULE = "TRUE" *) (* xpm_cdc = "SINGLE" *) 
module XGMII_FIFO_DUAL_SYNC_xpm_cdc_single__2
   (src_clk,
    src_in,
    dest_clk,
    dest_out);
  input src_clk;
  input src_in;
  input dest_clk;
  output dest_out;

  wire dest_clk;
  wire src_in;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SINGLE" *) wire [3:0]syncstages_ff;

  assign dest_out = syncstages_ff[3];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_in),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "clk_x_pntrs" *) 
module XGMII_FIFO_DUAL_SYNC_clk_x_pntrs
   (\dest_out_bin_ff_reg[0] ,
    RD_PNTR_WR,
    \dest_out_bin_ff_reg[0]_0 ,
    \dest_out_bin_ff_reg[3] ,
    WR_PNTR_RD,
    \dest_out_bin_ff_reg[3]_0 ,
    Q,
    ram_full_i_reg,
    \src_gray_ff_reg[4] ,
    ram_empty_i_reg,
    wr_clk,
    \src_gray_ff_reg[4]_0 ,
    rd_clk);
  output \dest_out_bin_ff_reg[0] ;
  output [2:0]RD_PNTR_WR;
  output \dest_out_bin_ff_reg[0]_0 ;
  output \dest_out_bin_ff_reg[3] ;
  output [1:0]WR_PNTR_RD;
  output \dest_out_bin_ff_reg[3]_0 ;
  input [1:0]Q;
  input [1:0]ram_full_i_reg;
  input [4:0]\src_gray_ff_reg[4] ;
  input [2:0]ram_empty_i_reg;
  input wr_clk;
  input [4:0]\src_gray_ff_reg[4]_0 ;
  input rd_clk;

  wire [1:0]Q;
  wire [2:0]RD_PNTR_WR;
  wire [1:0]WR_PNTR_RD;
  wire \dest_out_bin_ff_reg[0] ;
  wire \dest_out_bin_ff_reg[0]_0 ;
  wire \dest_out_bin_ff_reg[3] ;
  wire \dest_out_bin_ff_reg[3]_0 ;
  wire [4:2]p_24_out;
  wire [1:0]p_25_out;
  wire [2:0]ram_empty_i_reg;
  wire [1:0]ram_full_i_reg;
  wire rd_clk;
  wire [4:0]\src_gray_ff_reg[4] ;
  wire [4:0]\src_gray_ff_reg[4]_0 ;
  wire wr_clk;

  LUT6 #(
    .INIT(64'h9009000000009009)) 
    ram_empty_i_i_2
       (.I0(p_24_out[3]),
        .I1(\src_gray_ff_reg[4] [3]),
        .I2(p_24_out[2]),
        .I3(\src_gray_ff_reg[4] [2]),
        .I4(\src_gray_ff_reg[4] [4]),
        .I5(p_24_out[4]),
        .O(\dest_out_bin_ff_reg[3] ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    ram_empty_i_i_5
       (.I0(p_24_out[3]),
        .I1(ram_empty_i_reg[1]),
        .I2(p_24_out[2]),
        .I3(ram_empty_i_reg[0]),
        .I4(ram_empty_i_reg[2]),
        .I5(p_24_out[4]),
        .O(\dest_out_bin_ff_reg[3]_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_full_i_i_3
       (.I0(p_25_out[0]),
        .I1(ram_full_i_reg[0]),
        .I2(p_25_out[1]),
        .I3(ram_full_i_reg[1]),
        .O(\dest_out_bin_ff_reg[0]_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_full_i_i_4
       (.I0(p_25_out[0]),
        .I1(Q[0]),
        .I2(p_25_out[1]),
        .I3(Q[1]),
        .O(\dest_out_bin_ff_reg[0] ));
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* REG_OUTPUT = "1" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "5" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  XGMII_FIFO_DUAL_SYNC_xpm_cdc_gray rd_pntr_cdc_inst
       (.dest_clk(wr_clk),
        .dest_out_bin({RD_PNTR_WR,p_25_out}),
        .src_clk(rd_clk),
        .src_in_bin(\src_gray_ff_reg[4] ));
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* REG_OUTPUT = "1" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "5" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  XGMII_FIFO_DUAL_SYNC_xpm_cdc_gray__2 wr_pntr_cdc_inst
       (.dest_clk(rd_clk),
        .dest_out_bin({p_24_out,WR_PNTR_RD}),
        .src_clk(wr_clk),
        .src_in_bin(\src_gray_ff_reg[4]_0 ));
endmodule

(* ORIG_REF_NAME = "dmem" *) 
module XGMII_FIFO_DUAL_SYNC_dmem
   (dout,
    wr_clk,
    E,
    din,
    \gpr1.dout_i_reg[1]_0 ,
    \gpr1.dout_i_reg[1]_1 ,
    \gpr1.dout_i_reg[0]_0 ,
    rd_clk,
    AR);
  output [287:0]dout;
  input wr_clk;
  input [0:0]E;
  input [287:0]din;
  input [4:0]\gpr1.dout_i_reg[1]_0 ;
  input [4:0]\gpr1.dout_i_reg[1]_1 ;
  input [0:0]\gpr1.dout_i_reg[0]_0 ;
  input rd_clk;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [287:0]din;
  wire [287:0]dout;
  wire [0:0]\gpr1.dout_i_reg[0]_0 ;
  wire [4:0]\gpr1.dout_i_reg[1]_0 ;
  wire [4:0]\gpr1.dout_i_reg[1]_1 ;
  wire [287:0]p_0_out;
  wire rd_clk;
  wire wr_clk;
  wire [1:0]NLW_RAM_reg_0_31_0_5_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_102_107_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_108_113_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_114_119_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_120_125_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_126_131_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_12_17_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_132_137_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_138_143_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_144_149_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_150_155_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_156_161_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_162_167_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_168_173_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_174_179_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_180_185_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_186_191_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_18_23_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_192_197_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_198_203_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_204_209_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_210_215_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_216_221_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_222_227_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_228_233_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_234_239_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_240_245_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_246_251_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_24_29_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_252_257_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_258_263_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_264_269_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_270_275_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_276_281_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_282_287_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_30_35_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_36_41_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_42_47_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_48_53_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_54_59_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_60_65_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_66_71_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_6_11_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_72_77_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_78_83_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_84_89_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_90_95_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_31_96_101_DOD_UNCONNECTED;

  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M RAM_reg_0_31_0_5
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[1:0]),
        .DIB(din[3:2]),
        .DIC(din[5:4]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[1:0]),
        .DOB(p_0_out[3:2]),
        .DOC(p_0_out[5:4]),
        .DOD(NLW_RAM_reg_0_31_0_5_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "102" *) 
  (* ram_slice_end = "107" *) 
  RAM32M RAM_reg_0_31_102_107
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[103:102]),
        .DIB(din[105:104]),
        .DIC(din[107:106]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[103:102]),
        .DOB(p_0_out[105:104]),
        .DOC(p_0_out[107:106]),
        .DOD(NLW_RAM_reg_0_31_102_107_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "108" *) 
  (* ram_slice_end = "113" *) 
  RAM32M RAM_reg_0_31_108_113
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[109:108]),
        .DIB(din[111:110]),
        .DIC(din[113:112]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[109:108]),
        .DOB(p_0_out[111:110]),
        .DOC(p_0_out[113:112]),
        .DOD(NLW_RAM_reg_0_31_108_113_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "114" *) 
  (* ram_slice_end = "119" *) 
  RAM32M RAM_reg_0_31_114_119
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[115:114]),
        .DIB(din[117:116]),
        .DIC(din[119:118]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[115:114]),
        .DOB(p_0_out[117:116]),
        .DOC(p_0_out[119:118]),
        .DOD(NLW_RAM_reg_0_31_114_119_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "120" *) 
  (* ram_slice_end = "125" *) 
  RAM32M RAM_reg_0_31_120_125
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[121:120]),
        .DIB(din[123:122]),
        .DIC(din[125:124]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[121:120]),
        .DOB(p_0_out[123:122]),
        .DOC(p_0_out[125:124]),
        .DOD(NLW_RAM_reg_0_31_120_125_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "126" *) 
  (* ram_slice_end = "131" *) 
  RAM32M RAM_reg_0_31_126_131
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[127:126]),
        .DIB(din[129:128]),
        .DIC(din[131:130]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[127:126]),
        .DOB(p_0_out[129:128]),
        .DOC(p_0_out[131:130]),
        .DOD(NLW_RAM_reg_0_31_126_131_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "17" *) 
  RAM32M RAM_reg_0_31_12_17
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[13:12]),
        .DIB(din[15:14]),
        .DIC(din[17:16]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[13:12]),
        .DOB(p_0_out[15:14]),
        .DOC(p_0_out[17:16]),
        .DOD(NLW_RAM_reg_0_31_12_17_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "132" *) 
  (* ram_slice_end = "137" *) 
  RAM32M RAM_reg_0_31_132_137
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[133:132]),
        .DIB(din[135:134]),
        .DIC(din[137:136]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[133:132]),
        .DOB(p_0_out[135:134]),
        .DOC(p_0_out[137:136]),
        .DOD(NLW_RAM_reg_0_31_132_137_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "138" *) 
  (* ram_slice_end = "143" *) 
  RAM32M RAM_reg_0_31_138_143
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[139:138]),
        .DIB(din[141:140]),
        .DIC(din[143:142]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[139:138]),
        .DOB(p_0_out[141:140]),
        .DOC(p_0_out[143:142]),
        .DOD(NLW_RAM_reg_0_31_138_143_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "144" *) 
  (* ram_slice_end = "149" *) 
  RAM32M RAM_reg_0_31_144_149
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[145:144]),
        .DIB(din[147:146]),
        .DIC(din[149:148]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[145:144]),
        .DOB(p_0_out[147:146]),
        .DOC(p_0_out[149:148]),
        .DOD(NLW_RAM_reg_0_31_144_149_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "150" *) 
  (* ram_slice_end = "155" *) 
  RAM32M RAM_reg_0_31_150_155
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[151:150]),
        .DIB(din[153:152]),
        .DIC(din[155:154]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[151:150]),
        .DOB(p_0_out[153:152]),
        .DOC(p_0_out[155:154]),
        .DOD(NLW_RAM_reg_0_31_150_155_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "156" *) 
  (* ram_slice_end = "161" *) 
  RAM32M RAM_reg_0_31_156_161
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[157:156]),
        .DIB(din[159:158]),
        .DIC(din[161:160]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[157:156]),
        .DOB(p_0_out[159:158]),
        .DOC(p_0_out[161:160]),
        .DOD(NLW_RAM_reg_0_31_156_161_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "162" *) 
  (* ram_slice_end = "167" *) 
  RAM32M RAM_reg_0_31_162_167
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[163:162]),
        .DIB(din[165:164]),
        .DIC(din[167:166]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[163:162]),
        .DOB(p_0_out[165:164]),
        .DOC(p_0_out[167:166]),
        .DOD(NLW_RAM_reg_0_31_162_167_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "168" *) 
  (* ram_slice_end = "173" *) 
  RAM32M RAM_reg_0_31_168_173
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[169:168]),
        .DIB(din[171:170]),
        .DIC(din[173:172]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[169:168]),
        .DOB(p_0_out[171:170]),
        .DOC(p_0_out[173:172]),
        .DOD(NLW_RAM_reg_0_31_168_173_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "174" *) 
  (* ram_slice_end = "179" *) 
  RAM32M RAM_reg_0_31_174_179
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[175:174]),
        .DIB(din[177:176]),
        .DIC(din[179:178]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[175:174]),
        .DOB(p_0_out[177:176]),
        .DOC(p_0_out[179:178]),
        .DOD(NLW_RAM_reg_0_31_174_179_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "180" *) 
  (* ram_slice_end = "185" *) 
  RAM32M RAM_reg_0_31_180_185
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[181:180]),
        .DIB(din[183:182]),
        .DIC(din[185:184]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[181:180]),
        .DOB(p_0_out[183:182]),
        .DOC(p_0_out[185:184]),
        .DOD(NLW_RAM_reg_0_31_180_185_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "186" *) 
  (* ram_slice_end = "191" *) 
  RAM32M RAM_reg_0_31_186_191
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[187:186]),
        .DIB(din[189:188]),
        .DIC(din[191:190]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[187:186]),
        .DOB(p_0_out[189:188]),
        .DOC(p_0_out[191:190]),
        .DOD(NLW_RAM_reg_0_31_186_191_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "23" *) 
  RAM32M RAM_reg_0_31_18_23
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[19:18]),
        .DIB(din[21:20]),
        .DIC(din[23:22]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[19:18]),
        .DOB(p_0_out[21:20]),
        .DOC(p_0_out[23:22]),
        .DOD(NLW_RAM_reg_0_31_18_23_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "192" *) 
  (* ram_slice_end = "197" *) 
  RAM32M RAM_reg_0_31_192_197
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[193:192]),
        .DIB(din[195:194]),
        .DIC(din[197:196]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[193:192]),
        .DOB(p_0_out[195:194]),
        .DOC(p_0_out[197:196]),
        .DOD(NLW_RAM_reg_0_31_192_197_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "198" *) 
  (* ram_slice_end = "203" *) 
  RAM32M RAM_reg_0_31_198_203
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[199:198]),
        .DIB(din[201:200]),
        .DIC(din[203:202]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[199:198]),
        .DOB(p_0_out[201:200]),
        .DOC(p_0_out[203:202]),
        .DOD(NLW_RAM_reg_0_31_198_203_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "204" *) 
  (* ram_slice_end = "209" *) 
  RAM32M RAM_reg_0_31_204_209
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[205:204]),
        .DIB(din[207:206]),
        .DIC(din[209:208]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[205:204]),
        .DOB(p_0_out[207:206]),
        .DOC(p_0_out[209:208]),
        .DOD(NLW_RAM_reg_0_31_204_209_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "210" *) 
  (* ram_slice_end = "215" *) 
  RAM32M RAM_reg_0_31_210_215
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[211:210]),
        .DIB(din[213:212]),
        .DIC(din[215:214]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[211:210]),
        .DOB(p_0_out[213:212]),
        .DOC(p_0_out[215:214]),
        .DOD(NLW_RAM_reg_0_31_210_215_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "216" *) 
  (* ram_slice_end = "221" *) 
  RAM32M RAM_reg_0_31_216_221
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[217:216]),
        .DIB(din[219:218]),
        .DIC(din[221:220]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[217:216]),
        .DOB(p_0_out[219:218]),
        .DOC(p_0_out[221:220]),
        .DOD(NLW_RAM_reg_0_31_216_221_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "222" *) 
  (* ram_slice_end = "227" *) 
  RAM32M RAM_reg_0_31_222_227
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[223:222]),
        .DIB(din[225:224]),
        .DIC(din[227:226]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[223:222]),
        .DOB(p_0_out[225:224]),
        .DOC(p_0_out[227:226]),
        .DOD(NLW_RAM_reg_0_31_222_227_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "228" *) 
  (* ram_slice_end = "233" *) 
  RAM32M RAM_reg_0_31_228_233
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[229:228]),
        .DIB(din[231:230]),
        .DIC(din[233:232]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[229:228]),
        .DOB(p_0_out[231:230]),
        .DOC(p_0_out[233:232]),
        .DOD(NLW_RAM_reg_0_31_228_233_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "234" *) 
  (* ram_slice_end = "239" *) 
  RAM32M RAM_reg_0_31_234_239
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[235:234]),
        .DIB(din[237:236]),
        .DIC(din[239:238]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[235:234]),
        .DOB(p_0_out[237:236]),
        .DOC(p_0_out[239:238]),
        .DOD(NLW_RAM_reg_0_31_234_239_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "240" *) 
  (* ram_slice_end = "245" *) 
  RAM32M RAM_reg_0_31_240_245
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[241:240]),
        .DIB(din[243:242]),
        .DIC(din[245:244]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[241:240]),
        .DOB(p_0_out[243:242]),
        .DOC(p_0_out[245:244]),
        .DOD(NLW_RAM_reg_0_31_240_245_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "246" *) 
  (* ram_slice_end = "251" *) 
  RAM32M RAM_reg_0_31_246_251
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[247:246]),
        .DIB(din[249:248]),
        .DIC(din[251:250]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[247:246]),
        .DOB(p_0_out[249:248]),
        .DOC(p_0_out[251:250]),
        .DOD(NLW_RAM_reg_0_31_246_251_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "29" *) 
  RAM32M RAM_reg_0_31_24_29
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[25:24]),
        .DIB(din[27:26]),
        .DIC(din[29:28]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[25:24]),
        .DOB(p_0_out[27:26]),
        .DOC(p_0_out[29:28]),
        .DOD(NLW_RAM_reg_0_31_24_29_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "252" *) 
  (* ram_slice_end = "257" *) 
  RAM32M RAM_reg_0_31_252_257
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[253:252]),
        .DIB(din[255:254]),
        .DIC(din[257:256]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[253:252]),
        .DOB(p_0_out[255:254]),
        .DOC(p_0_out[257:256]),
        .DOD(NLW_RAM_reg_0_31_252_257_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "258" *) 
  (* ram_slice_end = "263" *) 
  RAM32M RAM_reg_0_31_258_263
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[259:258]),
        .DIB(din[261:260]),
        .DIC(din[263:262]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[259:258]),
        .DOB(p_0_out[261:260]),
        .DOC(p_0_out[263:262]),
        .DOD(NLW_RAM_reg_0_31_258_263_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "264" *) 
  (* ram_slice_end = "269" *) 
  RAM32M RAM_reg_0_31_264_269
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[265:264]),
        .DIB(din[267:266]),
        .DIC(din[269:268]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[265:264]),
        .DOB(p_0_out[267:266]),
        .DOC(p_0_out[269:268]),
        .DOD(NLW_RAM_reg_0_31_264_269_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "270" *) 
  (* ram_slice_end = "275" *) 
  RAM32M RAM_reg_0_31_270_275
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[271:270]),
        .DIB(din[273:272]),
        .DIC(din[275:274]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[271:270]),
        .DOB(p_0_out[273:272]),
        .DOC(p_0_out[275:274]),
        .DOD(NLW_RAM_reg_0_31_270_275_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "276" *) 
  (* ram_slice_end = "281" *) 
  RAM32M RAM_reg_0_31_276_281
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[277:276]),
        .DIB(din[279:278]),
        .DIC(din[281:280]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[277:276]),
        .DOB(p_0_out[279:278]),
        .DOC(p_0_out[281:280]),
        .DOD(NLW_RAM_reg_0_31_276_281_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "282" *) 
  (* ram_slice_end = "287" *) 
  RAM32M RAM_reg_0_31_282_287
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[283:282]),
        .DIB(din[285:284]),
        .DIC(din[287:286]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[283:282]),
        .DOB(p_0_out[285:284]),
        .DOC(p_0_out[287:286]),
        .DOD(NLW_RAM_reg_0_31_282_287_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "35" *) 
  RAM32M RAM_reg_0_31_30_35
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[31:30]),
        .DIB(din[33:32]),
        .DIC(din[35:34]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[31:30]),
        .DOB(p_0_out[33:32]),
        .DOC(p_0_out[35:34]),
        .DOD(NLW_RAM_reg_0_31_30_35_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "36" *) 
  (* ram_slice_end = "41" *) 
  RAM32M RAM_reg_0_31_36_41
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[37:36]),
        .DIB(din[39:38]),
        .DIC(din[41:40]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[37:36]),
        .DOB(p_0_out[39:38]),
        .DOC(p_0_out[41:40]),
        .DOD(NLW_RAM_reg_0_31_36_41_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "42" *) 
  (* ram_slice_end = "47" *) 
  RAM32M RAM_reg_0_31_42_47
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[43:42]),
        .DIB(din[45:44]),
        .DIC(din[47:46]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[43:42]),
        .DOB(p_0_out[45:44]),
        .DOC(p_0_out[47:46]),
        .DOD(NLW_RAM_reg_0_31_42_47_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "48" *) 
  (* ram_slice_end = "53" *) 
  RAM32M RAM_reg_0_31_48_53
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[49:48]),
        .DIB(din[51:50]),
        .DIC(din[53:52]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[49:48]),
        .DOB(p_0_out[51:50]),
        .DOC(p_0_out[53:52]),
        .DOD(NLW_RAM_reg_0_31_48_53_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "54" *) 
  (* ram_slice_end = "59" *) 
  RAM32M RAM_reg_0_31_54_59
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[55:54]),
        .DIB(din[57:56]),
        .DIC(din[59:58]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[55:54]),
        .DOB(p_0_out[57:56]),
        .DOC(p_0_out[59:58]),
        .DOD(NLW_RAM_reg_0_31_54_59_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "60" *) 
  (* ram_slice_end = "65" *) 
  RAM32M RAM_reg_0_31_60_65
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[61:60]),
        .DIB(din[63:62]),
        .DIC(din[65:64]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[61:60]),
        .DOB(p_0_out[63:62]),
        .DOC(p_0_out[65:64]),
        .DOD(NLW_RAM_reg_0_31_60_65_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "66" *) 
  (* ram_slice_end = "71" *) 
  RAM32M RAM_reg_0_31_66_71
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[67:66]),
        .DIB(din[69:68]),
        .DIC(din[71:70]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[67:66]),
        .DOB(p_0_out[69:68]),
        .DOC(p_0_out[71:70]),
        .DOD(NLW_RAM_reg_0_31_66_71_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "11" *) 
  RAM32M RAM_reg_0_31_6_11
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[7:6]),
        .DIB(din[9:8]),
        .DIC(din[11:10]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[7:6]),
        .DOB(p_0_out[9:8]),
        .DOC(p_0_out[11:10]),
        .DOD(NLW_RAM_reg_0_31_6_11_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "72" *) 
  (* ram_slice_end = "77" *) 
  RAM32M RAM_reg_0_31_72_77
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[73:72]),
        .DIB(din[75:74]),
        .DIC(din[77:76]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[73:72]),
        .DOB(p_0_out[75:74]),
        .DOC(p_0_out[77:76]),
        .DOD(NLW_RAM_reg_0_31_72_77_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "78" *) 
  (* ram_slice_end = "83" *) 
  RAM32M RAM_reg_0_31_78_83
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[79:78]),
        .DIB(din[81:80]),
        .DIC(din[83:82]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[79:78]),
        .DOB(p_0_out[81:80]),
        .DOC(p_0_out[83:82]),
        .DOD(NLW_RAM_reg_0_31_78_83_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "84" *) 
  (* ram_slice_end = "89" *) 
  RAM32M RAM_reg_0_31_84_89
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[85:84]),
        .DIB(din[87:86]),
        .DIC(din[89:88]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[85:84]),
        .DOB(p_0_out[87:86]),
        .DOC(p_0_out[89:88]),
        .DOD(NLW_RAM_reg_0_31_84_89_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "90" *) 
  (* ram_slice_end = "95" *) 
  RAM32M RAM_reg_0_31_90_95
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[91:90]),
        .DIB(din[93:92]),
        .DIC(din[95:94]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[91:90]),
        .DOB(p_0_out[93:92]),
        .DOC(p_0_out[95:94]),
        .DOD(NLW_RAM_reg_0_31_90_95_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "9216" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "31" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "96" *) 
  (* ram_slice_end = "101" *) 
  RAM32M RAM_reg_0_31_96_101
       (.ADDRA(\gpr1.dout_i_reg[1]_0 ),
        .ADDRB(\gpr1.dout_i_reg[1]_0 ),
        .ADDRC(\gpr1.dout_i_reg[1]_0 ),
        .ADDRD(\gpr1.dout_i_reg[1]_1 ),
        .DIA(din[97:96]),
        .DIB(din[99:98]),
        .DIC(din[101:100]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[97:96]),
        .DOB(p_0_out[99:98]),
        .DOC(p_0_out[101:100]),
        .DOD(NLW_RAM_reg_0_31_96_101_DOD_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[0] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[0]),
        .Q(dout[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[100] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[100]),
        .Q(dout[100]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[101] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[101]),
        .Q(dout[101]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[102] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[102]),
        .Q(dout[102]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[103] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[103]),
        .Q(dout[103]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[104] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[104]),
        .Q(dout[104]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[105] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[105]),
        .Q(dout[105]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[106] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[106]),
        .Q(dout[106]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[107] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[107]),
        .Q(dout[107]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[108] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[108]),
        .Q(dout[108]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[109] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[109]),
        .Q(dout[109]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[10] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[10]),
        .Q(dout[10]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[110] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[110]),
        .Q(dout[110]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[111] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[111]),
        .Q(dout[111]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[112] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[112]),
        .Q(dout[112]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[113] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[113]),
        .Q(dout[113]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[114] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[114]),
        .Q(dout[114]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[115] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[115]),
        .Q(dout[115]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[116] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[116]),
        .Q(dout[116]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[117] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[117]),
        .Q(dout[117]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[118] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[118]),
        .Q(dout[118]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[119] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[119]),
        .Q(dout[119]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[11] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[11]),
        .Q(dout[11]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[120] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[120]),
        .Q(dout[120]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[121] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[121]),
        .Q(dout[121]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[122] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[122]),
        .Q(dout[122]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[123] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[123]),
        .Q(dout[123]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[124] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[124]),
        .Q(dout[124]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[125] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[125]),
        .Q(dout[125]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[126] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[126]),
        .Q(dout[126]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[127] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[127]),
        .Q(dout[127]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[128] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[128]),
        .Q(dout[128]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[129] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[129]),
        .Q(dout[129]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[12] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[12]),
        .Q(dout[12]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[130] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[130]),
        .Q(dout[130]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[131] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[131]),
        .Q(dout[131]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[132] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[132]),
        .Q(dout[132]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[133] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[133]),
        .Q(dout[133]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[134] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[134]),
        .Q(dout[134]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[135] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[135]),
        .Q(dout[135]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[136] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[136]),
        .Q(dout[136]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[137] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[137]),
        .Q(dout[137]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[138] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[138]),
        .Q(dout[138]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[139] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[139]),
        .Q(dout[139]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[13] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[13]),
        .Q(dout[13]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[140] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[140]),
        .Q(dout[140]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[141] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[141]),
        .Q(dout[141]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[142] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[142]),
        .Q(dout[142]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[143] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[143]),
        .Q(dout[143]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[144] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[144]),
        .Q(dout[144]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[145] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[145]),
        .Q(dout[145]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[146] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[146]),
        .Q(dout[146]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[147] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[147]),
        .Q(dout[147]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[148] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[148]),
        .Q(dout[148]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[149] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[149]),
        .Q(dout[149]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[14] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[14]),
        .Q(dout[14]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[150] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[150]),
        .Q(dout[150]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[151] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[151]),
        .Q(dout[151]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[152] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[152]),
        .Q(dout[152]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[153] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[153]),
        .Q(dout[153]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[154] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[154]),
        .Q(dout[154]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[155] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[155]),
        .Q(dout[155]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[156] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[156]),
        .Q(dout[156]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[157] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[157]),
        .Q(dout[157]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[158] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[158]),
        .Q(dout[158]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[159] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[159]),
        .Q(dout[159]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[15] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[15]),
        .Q(dout[15]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[160] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[160]),
        .Q(dout[160]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[161] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[161]),
        .Q(dout[161]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[162] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[162]),
        .Q(dout[162]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[163] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[163]),
        .Q(dout[163]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[164] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[164]),
        .Q(dout[164]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[165] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[165]),
        .Q(dout[165]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[166] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[166]),
        .Q(dout[166]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[167] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[167]),
        .Q(dout[167]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[168] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[168]),
        .Q(dout[168]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[169] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[169]),
        .Q(dout[169]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[16] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[16]),
        .Q(dout[16]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[170] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[170]),
        .Q(dout[170]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[171] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[171]),
        .Q(dout[171]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[172] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[172]),
        .Q(dout[172]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[173] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[173]),
        .Q(dout[173]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[174] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[174]),
        .Q(dout[174]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[175] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[175]),
        .Q(dout[175]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[176] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[176]),
        .Q(dout[176]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[177] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[177]),
        .Q(dout[177]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[178] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[178]),
        .Q(dout[178]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[179] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[179]),
        .Q(dout[179]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[17] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[17]),
        .Q(dout[17]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[180] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[180]),
        .Q(dout[180]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[181] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[181]),
        .Q(dout[181]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[182] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[182]),
        .Q(dout[182]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[183] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[183]),
        .Q(dout[183]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[184] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[184]),
        .Q(dout[184]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[185] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[185]),
        .Q(dout[185]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[186] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[186]),
        .Q(dout[186]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[187] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[187]),
        .Q(dout[187]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[188] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[188]),
        .Q(dout[188]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[189] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[189]),
        .Q(dout[189]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[18] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[18]),
        .Q(dout[18]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[190] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[190]),
        .Q(dout[190]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[191] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[191]),
        .Q(dout[191]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[192] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[192]),
        .Q(dout[192]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[193] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[193]),
        .Q(dout[193]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[194] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[194]),
        .Q(dout[194]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[195] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[195]),
        .Q(dout[195]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[196] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[196]),
        .Q(dout[196]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[197] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[197]),
        .Q(dout[197]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[198] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[198]),
        .Q(dout[198]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[199] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[199]),
        .Q(dout[199]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[19] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[19]),
        .Q(dout[19]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[1] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[1]),
        .Q(dout[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[200] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[200]),
        .Q(dout[200]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[201] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[201]),
        .Q(dout[201]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[202] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[202]),
        .Q(dout[202]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[203] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[203]),
        .Q(dout[203]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[204] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[204]),
        .Q(dout[204]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[205] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[205]),
        .Q(dout[205]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[206] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[206]),
        .Q(dout[206]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[207] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[207]),
        .Q(dout[207]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[208] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[208]),
        .Q(dout[208]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[209] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[209]),
        .Q(dout[209]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[20] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[20]),
        .Q(dout[20]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[210] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[210]),
        .Q(dout[210]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[211] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[211]),
        .Q(dout[211]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[212] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[212]),
        .Q(dout[212]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[213] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[213]),
        .Q(dout[213]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[214] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[214]),
        .Q(dout[214]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[215] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[215]),
        .Q(dout[215]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[216] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[216]),
        .Q(dout[216]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[217] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[217]),
        .Q(dout[217]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[218] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[218]),
        .Q(dout[218]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[219] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[219]),
        .Q(dout[219]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[21] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[21]),
        .Q(dout[21]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[220] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[220]),
        .Q(dout[220]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[221] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[221]),
        .Q(dout[221]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[222] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[222]),
        .Q(dout[222]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[223] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[223]),
        .Q(dout[223]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[224] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[224]),
        .Q(dout[224]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[225] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[225]),
        .Q(dout[225]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[226] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[226]),
        .Q(dout[226]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[227] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[227]),
        .Q(dout[227]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[228] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[228]),
        .Q(dout[228]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[229] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[229]),
        .Q(dout[229]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[22] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[22]),
        .Q(dout[22]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[230] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[230]),
        .Q(dout[230]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[231] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[231]),
        .Q(dout[231]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[232] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[232]),
        .Q(dout[232]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[233] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[233]),
        .Q(dout[233]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[234] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[234]),
        .Q(dout[234]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[235] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[235]),
        .Q(dout[235]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[236] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[236]),
        .Q(dout[236]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[237] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[237]),
        .Q(dout[237]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[238] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[238]),
        .Q(dout[238]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[239] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[239]),
        .Q(dout[239]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[23] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[23]),
        .Q(dout[23]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[240] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[240]),
        .Q(dout[240]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[241] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[241]),
        .Q(dout[241]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[242] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[242]),
        .Q(dout[242]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[243] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[243]),
        .Q(dout[243]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[244] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[244]),
        .Q(dout[244]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[245] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[245]),
        .Q(dout[245]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[246] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[246]),
        .Q(dout[246]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[247] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[247]),
        .Q(dout[247]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[248] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[248]),
        .Q(dout[248]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[249] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[249]),
        .Q(dout[249]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[24] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[24]),
        .Q(dout[24]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[250] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[250]),
        .Q(dout[250]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[251] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[251]),
        .Q(dout[251]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[252] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[252]),
        .Q(dout[252]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[253] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[253]),
        .Q(dout[253]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[254] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[254]),
        .Q(dout[254]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[255] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[255]),
        .Q(dout[255]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[256] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[256]),
        .Q(dout[256]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[257] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[257]),
        .Q(dout[257]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[258] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[258]),
        .Q(dout[258]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[259] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[259]),
        .Q(dout[259]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[25] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[25]),
        .Q(dout[25]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[260] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[260]),
        .Q(dout[260]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[261] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[261]),
        .Q(dout[261]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[262] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[262]),
        .Q(dout[262]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[263] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[263]),
        .Q(dout[263]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[264] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[264]),
        .Q(dout[264]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[265] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[265]),
        .Q(dout[265]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[266] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[266]),
        .Q(dout[266]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[267] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[267]),
        .Q(dout[267]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[268] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[268]),
        .Q(dout[268]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[269] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[269]),
        .Q(dout[269]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[26] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[26]),
        .Q(dout[26]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[270] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[270]),
        .Q(dout[270]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[271] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[271]),
        .Q(dout[271]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[272] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[272]),
        .Q(dout[272]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[273] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[273]),
        .Q(dout[273]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[274] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[274]),
        .Q(dout[274]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[275] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[275]),
        .Q(dout[275]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[276] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[276]),
        .Q(dout[276]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[277] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[277]),
        .Q(dout[277]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[278] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[278]),
        .Q(dout[278]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[279] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[279]),
        .Q(dout[279]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[27] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[27]),
        .Q(dout[27]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[280] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[280]),
        .Q(dout[280]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[281] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[281]),
        .Q(dout[281]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[282] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[282]),
        .Q(dout[282]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[283] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[283]),
        .Q(dout[283]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[284] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[284]),
        .Q(dout[284]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[285] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[285]),
        .Q(dout[285]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[286] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[286]),
        .Q(dout[286]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[287] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[287]),
        .Q(dout[287]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[28] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[28]),
        .Q(dout[28]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[29] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[29]),
        .Q(dout[29]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[2] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[2]),
        .Q(dout[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[30] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[30]),
        .Q(dout[30]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[31] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[31]),
        .Q(dout[31]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[32] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[32]),
        .Q(dout[32]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[33] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[33]),
        .Q(dout[33]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[34] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[34]),
        .Q(dout[34]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[35] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[35]),
        .Q(dout[35]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[36] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[36]),
        .Q(dout[36]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[37] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[37]),
        .Q(dout[37]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[38] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[38]),
        .Q(dout[38]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[39] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[39]),
        .Q(dout[39]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[3] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[3]),
        .Q(dout[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[40] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[40]),
        .Q(dout[40]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[41] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[41]),
        .Q(dout[41]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[42] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[42]),
        .Q(dout[42]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[43] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[43]),
        .Q(dout[43]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[44] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[44]),
        .Q(dout[44]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[45] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[45]),
        .Q(dout[45]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[46] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[46]),
        .Q(dout[46]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[47] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[47]),
        .Q(dout[47]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[48] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[48]),
        .Q(dout[48]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[49] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[49]),
        .Q(dout[49]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[4] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[4]),
        .Q(dout[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[50] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[50]),
        .Q(dout[50]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[51] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[51]),
        .Q(dout[51]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[52] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[52]),
        .Q(dout[52]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[53] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[53]),
        .Q(dout[53]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[54] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[54]),
        .Q(dout[54]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[55] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[55]),
        .Q(dout[55]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[56] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[56]),
        .Q(dout[56]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[57] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[57]),
        .Q(dout[57]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[58] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[58]),
        .Q(dout[58]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[59] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[59]),
        .Q(dout[59]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[5] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[5]),
        .Q(dout[5]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[60] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[60]),
        .Q(dout[60]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[61] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[61]),
        .Q(dout[61]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[62] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[62]),
        .Q(dout[62]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[63] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[63]),
        .Q(dout[63]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[64] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[64]),
        .Q(dout[64]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[65] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[65]),
        .Q(dout[65]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[66] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[66]),
        .Q(dout[66]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[67] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[67]),
        .Q(dout[67]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[68] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[68]),
        .Q(dout[68]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[69] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[69]),
        .Q(dout[69]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[6] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[6]),
        .Q(dout[6]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[70] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[70]),
        .Q(dout[70]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[71] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[71]),
        .Q(dout[71]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[72] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[72]),
        .Q(dout[72]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[73] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[73]),
        .Q(dout[73]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[74] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[74]),
        .Q(dout[74]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[75] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[75]),
        .Q(dout[75]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[76] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[76]),
        .Q(dout[76]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[77] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[77]),
        .Q(dout[77]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[78] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[78]),
        .Q(dout[78]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[79] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[79]),
        .Q(dout[79]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[7] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[7]),
        .Q(dout[7]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[80] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[80]),
        .Q(dout[80]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[81] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[81]),
        .Q(dout[81]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[82] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[82]),
        .Q(dout[82]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[83] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[83]),
        .Q(dout[83]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[84] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[84]),
        .Q(dout[84]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[85] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[85]),
        .Q(dout[85]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[86] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[86]),
        .Q(dout[86]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[87] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[87]),
        .Q(dout[87]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[88] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[88]),
        .Q(dout[88]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[89] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[89]),
        .Q(dout[89]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[8] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[8]),
        .Q(dout[8]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[90] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[90]),
        .Q(dout[90]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[91] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[91]),
        .Q(dout[91]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[92] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[92]),
        .Q(dout[92]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[93] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[93]),
        .Q(dout[93]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[94] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[94]),
        .Q(dout[94]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[95] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[95]),
        .Q(dout[95]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[96] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[96]),
        .Q(dout[96]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[97] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[97]),
        .Q(dout[97]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[98] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[98]),
        .Q(dout[98]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[99] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[99]),
        .Q(dout[99]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[9] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(p_0_out[9]),
        .Q(dout[9]));
endmodule

(* ORIG_REF_NAME = "fifo_generator_ramfifo" *) 
module XGMII_FIFO_DUAL_SYNC_fifo_generator_ramfifo
   (wr_rst_busy,
    AR,
    empty,
    full,
    dout,
    rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en);
  output wr_rst_busy;
  output [0:0]AR;
  output empty;
  output full;
  output [287:0]dout;
  input rst;
  input wr_clk;
  input rd_clk;
  input [287:0]din;
  input wr_en;
  input rd_en;

  wire [0:0]AR;
  wire [287:0]din;
  wire [287:0]dout;
  wire empty;
  wire full;
  wire \gntv_or_sync_fifo.gcx.clkx_n_0 ;
  wire \gntv_or_sync_fifo.gcx.clkx_n_4 ;
  wire \gntv_or_sync_fifo.gcx.clkx_n_5 ;
  wire \gntv_or_sync_fifo.gcx.clkx_n_8 ;
  wire [4:0]p_0_out_0;
  wire [4:0]p_13_out;
  wire [1:0]p_14_out;
  wire p_20_out;
  wire [1:0]p_24_out;
  wire [4:2]p_25_out;
  wire ram_rd_en_i;
  wire rd_clk;
  wire rd_en;
  wire [4:2]rd_pntr_plus1;
  wire rst;
  wire rst_full_ff_i;
  wire rst_full_gen_i;
  wire rstblk_n_0;
  wire wr_clk;
  wire wr_en;
  wire [1:0]wr_pntr_plus2;
  wire wr_rst_busy;

  XGMII_FIFO_DUAL_SYNC_clk_x_pntrs \gntv_or_sync_fifo.gcx.clkx 
       (.Q(p_14_out),
        .RD_PNTR_WR(p_25_out),
        .WR_PNTR_RD(p_24_out),
        .\dest_out_bin_ff_reg[0] (\gntv_or_sync_fifo.gcx.clkx_n_0 ),
        .\dest_out_bin_ff_reg[0]_0 (\gntv_or_sync_fifo.gcx.clkx_n_4 ),
        .\dest_out_bin_ff_reg[3] (\gntv_or_sync_fifo.gcx.clkx_n_5 ),
        .\dest_out_bin_ff_reg[3]_0 (\gntv_or_sync_fifo.gcx.clkx_n_8 ),
        .ram_empty_i_reg(rd_pntr_plus1),
        .ram_full_i_reg(wr_pntr_plus2),
        .rd_clk(rd_clk),
        .\src_gray_ff_reg[4] (p_0_out_0),
        .\src_gray_ff_reg[4]_0 (p_13_out),
        .wr_clk(wr_clk));
  XGMII_FIFO_DUAL_SYNC_rd_logic \gntv_or_sync_fifo.gl0.rd 
       (.AR(AR),
        .E(ram_rd_en_i),
        .Q(rd_pntr_plus1),
        .WR_PNTR_RD(p_24_out),
        .empty(empty),
        .\gc0.count_d1_reg[4] (p_0_out_0),
        .ram_empty_i_reg(\gntv_or_sync_fifo.gcx.clkx_n_5 ),
        .ram_empty_i_reg_0(\gntv_or_sync_fifo.gcx.clkx_n_8 ),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
  XGMII_FIFO_DUAL_SYNC_wr_logic \gntv_or_sync_fifo.gl0.wr 
       (.AR(rstblk_n_0),
        .E(p_20_out),
        .Q(wr_pntr_plus2),
        .RD_PNTR_WR(p_25_out),
        .full(full),
        .\gic0.gc0.count_d1_reg[1] (p_14_out),
        .\gic0.gc0.count_d2_reg[4] (p_13_out),
        .out(rst_full_ff_i),
        .ram_full_i_reg(\gntv_or_sync_fifo.gcx.clkx_n_4 ),
        .ram_full_i_reg_0(\gntv_or_sync_fifo.gcx.clkx_n_0 ),
        .ram_full_i_reg_1(rst_full_gen_i),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
  XGMII_FIFO_DUAL_SYNC_memory \gntv_or_sync_fifo.mem 
       (.AR(AR),
        .E(p_20_out),
        .din(din),
        .dout(dout),
        .\gpr1.dout_i_reg[0] (ram_rd_en_i),
        .\gpr1.dout_i_reg[1] (p_0_out_0),
        .\gpr1.dout_i_reg[1]_0 (p_13_out),
        .rd_clk(rd_clk),
        .wr_clk(wr_clk));
  XGMII_FIFO_DUAL_SYNC_reset_blk_ramfifo rstblk
       (.AR(rstblk_n_0),
        .\grstd1.grst_full.grst_f.rst_d3_reg_0 (rst_full_gen_i),
        .\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 (AR),
        .out(rst_full_ff_i),
        .rd_clk(rd_clk),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* ORIG_REF_NAME = "fifo_generator_top" *) 
module XGMII_FIFO_DUAL_SYNC_fifo_generator_top
   (wr_rst_busy,
    AR,
    empty,
    full,
    dout,
    rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en);
  output wr_rst_busy;
  output [0:0]AR;
  output empty;
  output full;
  output [287:0]dout;
  input rst;
  input wr_clk;
  input rd_clk;
  input [287:0]din;
  input wr_en;
  input rd_en;

  wire [0:0]AR;
  wire [287:0]din;
  wire [287:0]dout;
  wire empty;
  wire full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;
  wire wr_rst_busy;

  XGMII_FIFO_DUAL_SYNC_fifo_generator_ramfifo \grf.rf 
       (.AR(AR),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* C_ADD_NGC_CONSTRAINT = "0" *) (* C_APPLICATION_TYPE_AXIS = "0" *) (* C_APPLICATION_TYPE_RACH = "0" *) 
(* C_APPLICATION_TYPE_RDCH = "0" *) (* C_APPLICATION_TYPE_WACH = "0" *) (* C_APPLICATION_TYPE_WDCH = "0" *) 
(* C_APPLICATION_TYPE_WRCH = "0" *) (* C_AXIS_TDATA_WIDTH = "8" *) (* C_AXIS_TDEST_WIDTH = "1" *) 
(* C_AXIS_TID_WIDTH = "1" *) (* C_AXIS_TKEEP_WIDTH = "1" *) (* C_AXIS_TSTRB_WIDTH = "1" *) 
(* C_AXIS_TUSER_WIDTH = "4" *) (* C_AXIS_TYPE = "0" *) (* C_AXI_ADDR_WIDTH = "32" *) 
(* C_AXI_ARUSER_WIDTH = "1" *) (* C_AXI_AWUSER_WIDTH = "1" *) (* C_AXI_BUSER_WIDTH = "1" *) 
(* C_AXI_DATA_WIDTH = "64" *) (* C_AXI_ID_WIDTH = "1" *) (* C_AXI_LEN_WIDTH = "8" *) 
(* C_AXI_LOCK_WIDTH = "1" *) (* C_AXI_RUSER_WIDTH = "1" *) (* C_AXI_TYPE = "1" *) 
(* C_AXI_WUSER_WIDTH = "1" *) (* C_COMMON_CLOCK = "0" *) (* C_COUNT_TYPE = "0" *) 
(* C_DATA_COUNT_WIDTH = "5" *) (* C_DEFAULT_VALUE = "BlankString" *) (* C_DIN_WIDTH = "288" *) 
(* C_DIN_WIDTH_AXIS = "1" *) (* C_DIN_WIDTH_RACH = "32" *) (* C_DIN_WIDTH_RDCH = "64" *) 
(* C_DIN_WIDTH_WACH = "1" *) (* C_DIN_WIDTH_WDCH = "64" *) (* C_DIN_WIDTH_WRCH = "2" *) 
(* C_DOUT_RST_VAL = "0" *) (* C_DOUT_WIDTH = "288" *) (* C_ENABLE_RLOCS = "0" *) 
(* C_ENABLE_RST_SYNC = "1" *) (* C_EN_SAFETY_CKT = "0" *) (* C_ERROR_INJECTION_TYPE = "0" *) 
(* C_ERROR_INJECTION_TYPE_AXIS = "0" *) (* C_ERROR_INJECTION_TYPE_RACH = "0" *) (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) 
(* C_ERROR_INJECTION_TYPE_WACH = "0" *) (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) (* C_ERROR_INJECTION_TYPE_WRCH = "0" *) 
(* C_FAMILY = "virtex7" *) (* C_FULL_FLAGS_RST_VAL = "1" *) (* C_HAS_ALMOST_EMPTY = "0" *) 
(* C_HAS_ALMOST_FULL = "0" *) (* C_HAS_AXIS_TDATA = "1" *) (* C_HAS_AXIS_TDEST = "0" *) 
(* C_HAS_AXIS_TID = "0" *) (* C_HAS_AXIS_TKEEP = "0" *) (* C_HAS_AXIS_TLAST = "0" *) 
(* C_HAS_AXIS_TREADY = "1" *) (* C_HAS_AXIS_TSTRB = "0" *) (* C_HAS_AXIS_TUSER = "1" *) 
(* C_HAS_AXI_ARUSER = "0" *) (* C_HAS_AXI_AWUSER = "0" *) (* C_HAS_AXI_BUSER = "0" *) 
(* C_HAS_AXI_ID = "0" *) (* C_HAS_AXI_RD_CHANNEL = "1" *) (* C_HAS_AXI_RUSER = "0" *) 
(* C_HAS_AXI_WR_CHANNEL = "1" *) (* C_HAS_AXI_WUSER = "0" *) (* C_HAS_BACKUP = "0" *) 
(* C_HAS_DATA_COUNT = "0" *) (* C_HAS_DATA_COUNTS_AXIS = "0" *) (* C_HAS_DATA_COUNTS_RACH = "0" *) 
(* C_HAS_DATA_COUNTS_RDCH = "0" *) (* C_HAS_DATA_COUNTS_WACH = "0" *) (* C_HAS_DATA_COUNTS_WDCH = "0" *) 
(* C_HAS_DATA_COUNTS_WRCH = "0" *) (* C_HAS_INT_CLK = "0" *) (* C_HAS_MASTER_CE = "0" *) 
(* C_HAS_MEMINIT_FILE = "0" *) (* C_HAS_OVERFLOW = "0" *) (* C_HAS_PROG_FLAGS_AXIS = "0" *) 
(* C_HAS_PROG_FLAGS_RACH = "0" *) (* C_HAS_PROG_FLAGS_RDCH = "0" *) (* C_HAS_PROG_FLAGS_WACH = "0" *) 
(* C_HAS_PROG_FLAGS_WDCH = "0" *) (* C_HAS_PROG_FLAGS_WRCH = "0" *) (* C_HAS_RD_DATA_COUNT = "0" *) 
(* C_HAS_RD_RST = "0" *) (* C_HAS_RST = "1" *) (* C_HAS_SLAVE_CE = "0" *) 
(* C_HAS_SRST = "0" *) (* C_HAS_UNDERFLOW = "0" *) (* C_HAS_VALID = "0" *) 
(* C_HAS_WR_ACK = "0" *) (* C_HAS_WR_DATA_COUNT = "0" *) (* C_HAS_WR_RST = "0" *) 
(* C_IMPLEMENTATION_TYPE = "2" *) (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
(* C_IMPLEMENTATION_TYPE_RDCH = "1" *) (* C_IMPLEMENTATION_TYPE_WACH = "1" *) (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
(* C_IMPLEMENTATION_TYPE_WRCH = "1" *) (* C_INIT_WR_PNTR_VAL = "0" *) (* C_INTERFACE_TYPE = "0" *) 
(* C_MEMORY_TYPE = "2" *) (* C_MIF_FILE_NAME = "BlankString" *) (* C_MSGON_VAL = "1" *) 
(* C_OPTIMIZATION_MODE = "0" *) (* C_OVERFLOW_LOW = "0" *) (* C_POWER_SAVING_MODE = "0" *) 
(* C_PRELOAD_LATENCY = "1" *) (* C_PRELOAD_REGS = "0" *) (* C_PRIM_FIFO_TYPE = "512x72" *) 
(* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) 
(* C_PRIM_FIFO_TYPE_WACH = "512x36" *) (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL = "2" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "3" *) (* C_PROG_EMPTY_TYPE = "0" *) 
(* C_PROG_EMPTY_TYPE_AXIS = "0" *) (* C_PROG_EMPTY_TYPE_RACH = "0" *) (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
(* C_PROG_EMPTY_TYPE_WACH = "0" *) (* C_PROG_EMPTY_TYPE_WDCH = "0" *) (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL = "29" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) (* C_PROG_FULL_THRESH_NEGATE_VAL = "28" *) (* C_PROG_FULL_TYPE = "0" *) 
(* C_PROG_FULL_TYPE_AXIS = "0" *) (* C_PROG_FULL_TYPE_RACH = "0" *) (* C_PROG_FULL_TYPE_RDCH = "0" *) 
(* C_PROG_FULL_TYPE_WACH = "0" *) (* C_PROG_FULL_TYPE_WDCH = "0" *) (* C_PROG_FULL_TYPE_WRCH = "0" *) 
(* C_RACH_TYPE = "0" *) (* C_RDCH_TYPE = "0" *) (* C_RD_DATA_COUNT_WIDTH = "5" *) 
(* C_RD_DEPTH = "32" *) (* C_RD_FREQ = "1" *) (* C_RD_PNTR_WIDTH = "5" *) 
(* C_REG_SLICE_MODE_AXIS = "0" *) (* C_REG_SLICE_MODE_RACH = "0" *) (* C_REG_SLICE_MODE_RDCH = "0" *) 
(* C_REG_SLICE_MODE_WACH = "0" *) (* C_REG_SLICE_MODE_WDCH = "0" *) (* C_REG_SLICE_MODE_WRCH = "0" *) 
(* C_SELECT_XPM = "0" *) (* C_SYNCHRONIZER_STAGE = "2" *) (* C_UNDERFLOW_LOW = "0" *) 
(* C_USE_COMMON_OVERFLOW = "0" *) (* C_USE_COMMON_UNDERFLOW = "0" *) (* C_USE_DEFAULT_SETTINGS = "0" *) 
(* C_USE_DOUT_RST = "1" *) (* C_USE_ECC = "0" *) (* C_USE_ECC_AXIS = "0" *) 
(* C_USE_ECC_RACH = "0" *) (* C_USE_ECC_RDCH = "0" *) (* C_USE_ECC_WACH = "0" *) 
(* C_USE_ECC_WDCH = "0" *) (* C_USE_ECC_WRCH = "0" *) (* C_USE_EMBEDDED_REG = "0" *) 
(* C_USE_FIFO16_FLAGS = "0" *) (* C_USE_FWFT_DATA_COUNT = "0" *) (* C_USE_PIPELINE_REG = "0" *) 
(* C_VALID_LOW = "0" *) (* C_WACH_TYPE = "0" *) (* C_WDCH_TYPE = "0" *) 
(* C_WRCH_TYPE = "0" *) (* C_WR_ACK_LOW = "0" *) (* C_WR_DATA_COUNT_WIDTH = "5" *) 
(* C_WR_DEPTH = "32" *) (* C_WR_DEPTH_AXIS = "1024" *) (* C_WR_DEPTH_RACH = "16" *) 
(* C_WR_DEPTH_RDCH = "1024" *) (* C_WR_DEPTH_WACH = "16" *) (* C_WR_DEPTH_WDCH = "1024" *) 
(* C_WR_DEPTH_WRCH = "16" *) (* C_WR_FREQ = "1" *) (* C_WR_PNTR_WIDTH = "5" *) 
(* C_WR_PNTR_WIDTH_AXIS = "10" *) (* C_WR_PNTR_WIDTH_RACH = "4" *) (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
(* C_WR_PNTR_WIDTH_WACH = "4" *) (* C_WR_PNTR_WIDTH_WDCH = "10" *) (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
(* C_WR_RESPONSE_LATENCY = "1" *) (* ORIG_REF_NAME = "fifo_generator_v13_2_4" *) 
module XGMII_FIFO_DUAL_SYNC_fifo_generator_v13_2_4
   (backup,
    backup_marker,
    clk,
    rst,
    srst,
    wr_clk,
    wr_rst,
    rd_clk,
    rd_rst,
    din,
    wr_en,
    rd_en,
    prog_empty_thresh,
    prog_empty_thresh_assert,
    prog_empty_thresh_negate,
    prog_full_thresh,
    prog_full_thresh_assert,
    prog_full_thresh_negate,
    int_clk,
    injectdbiterr,
    injectsbiterr,
    sleep,
    dout,
    full,
    almost_full,
    wr_ack,
    overflow,
    empty,
    almost_empty,
    valid,
    underflow,
    data_count,
    rd_data_count,
    wr_data_count,
    prog_full,
    prog_empty,
    sbiterr,
    dbiterr,
    wr_rst_busy,
    rd_rst_busy,
    m_aclk,
    s_aclk,
    s_aresetn,
    m_aclk_en,
    s_aclk_en,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awlock,
    s_axi_awcache,
    s_axi_awprot,
    s_axi_awqos,
    s_axi_awregion,
    s_axi_awuser,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wid,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wuser,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_buser,
    s_axi_bvalid,
    s_axi_bready,
    m_axi_awid,
    m_axi_awaddr,
    m_axi_awlen,
    m_axi_awsize,
    m_axi_awburst,
    m_axi_awlock,
    m_axi_awcache,
    m_axi_awprot,
    m_axi_awqos,
    m_axi_awregion,
    m_axi_awuser,
    m_axi_awvalid,
    m_axi_awready,
    m_axi_wid,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_wlast,
    m_axi_wuser,
    m_axi_wvalid,
    m_axi_wready,
    m_axi_bid,
    m_axi_bresp,
    m_axi_buser,
    m_axi_bvalid,
    m_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arqos,
    s_axi_arregion,
    s_axi_aruser,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_ruser,
    s_axi_rvalid,
    s_axi_rready,
    m_axi_arid,
    m_axi_araddr,
    m_axi_arlen,
    m_axi_arsize,
    m_axi_arburst,
    m_axi_arlock,
    m_axi_arcache,
    m_axi_arprot,
    m_axi_arqos,
    m_axi_arregion,
    m_axi_aruser,
    m_axi_arvalid,
    m_axi_arready,
    m_axi_rid,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rlast,
    m_axi_ruser,
    m_axi_rvalid,
    m_axi_rready,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tdata,
    s_axis_tstrb,
    s_axis_tkeep,
    s_axis_tlast,
    s_axis_tid,
    s_axis_tdest,
    s_axis_tuser,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tdata,
    m_axis_tstrb,
    m_axis_tkeep,
    m_axis_tlast,
    m_axis_tid,
    m_axis_tdest,
    m_axis_tuser,
    axi_aw_injectsbiterr,
    axi_aw_injectdbiterr,
    axi_aw_prog_full_thresh,
    axi_aw_prog_empty_thresh,
    axi_aw_data_count,
    axi_aw_wr_data_count,
    axi_aw_rd_data_count,
    axi_aw_sbiterr,
    axi_aw_dbiterr,
    axi_aw_overflow,
    axi_aw_underflow,
    axi_aw_prog_full,
    axi_aw_prog_empty,
    axi_w_injectsbiterr,
    axi_w_injectdbiterr,
    axi_w_prog_full_thresh,
    axi_w_prog_empty_thresh,
    axi_w_data_count,
    axi_w_wr_data_count,
    axi_w_rd_data_count,
    axi_w_sbiterr,
    axi_w_dbiterr,
    axi_w_overflow,
    axi_w_underflow,
    axi_w_prog_full,
    axi_w_prog_empty,
    axi_b_injectsbiterr,
    axi_b_injectdbiterr,
    axi_b_prog_full_thresh,
    axi_b_prog_empty_thresh,
    axi_b_data_count,
    axi_b_wr_data_count,
    axi_b_rd_data_count,
    axi_b_sbiterr,
    axi_b_dbiterr,
    axi_b_overflow,
    axi_b_underflow,
    axi_b_prog_full,
    axi_b_prog_empty,
    axi_ar_injectsbiterr,
    axi_ar_injectdbiterr,
    axi_ar_prog_full_thresh,
    axi_ar_prog_empty_thresh,
    axi_ar_data_count,
    axi_ar_wr_data_count,
    axi_ar_rd_data_count,
    axi_ar_sbiterr,
    axi_ar_dbiterr,
    axi_ar_overflow,
    axi_ar_underflow,
    axi_ar_prog_full,
    axi_ar_prog_empty,
    axi_r_injectsbiterr,
    axi_r_injectdbiterr,
    axi_r_prog_full_thresh,
    axi_r_prog_empty_thresh,
    axi_r_data_count,
    axi_r_wr_data_count,
    axi_r_rd_data_count,
    axi_r_sbiterr,
    axi_r_dbiterr,
    axi_r_overflow,
    axi_r_underflow,
    axi_r_prog_full,
    axi_r_prog_empty,
    axis_injectsbiterr,
    axis_injectdbiterr,
    axis_prog_full_thresh,
    axis_prog_empty_thresh,
    axis_data_count,
    axis_wr_data_count,
    axis_rd_data_count,
    axis_sbiterr,
    axis_dbiterr,
    axis_overflow,
    axis_underflow,
    axis_prog_full,
    axis_prog_empty);
  input backup;
  input backup_marker;
  input clk;
  input rst;
  input srst;
  input wr_clk;
  input wr_rst;
  input rd_clk;
  input rd_rst;
  input [287:0]din;
  input wr_en;
  input rd_en;
  input [4:0]prog_empty_thresh;
  input [4:0]prog_empty_thresh_assert;
  input [4:0]prog_empty_thresh_negate;
  input [4:0]prog_full_thresh;
  input [4:0]prog_full_thresh_assert;
  input [4:0]prog_full_thresh_negate;
  input int_clk;
  input injectdbiterr;
  input injectsbiterr;
  input sleep;
  output [287:0]dout;
  output full;
  output almost_full;
  output wr_ack;
  output overflow;
  output empty;
  output almost_empty;
  output valid;
  output underflow;
  output [4:0]data_count;
  output [4:0]rd_data_count;
  output [4:0]wr_data_count;
  output prog_full;
  output prog_empty;
  output sbiterr;
  output dbiterr;
  output wr_rst_busy;
  output rd_rst_busy;
  input m_aclk;
  input s_aclk;
  input s_aresetn;
  input m_aclk_en;
  input s_aclk_en;
  input [0:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input [0:0]s_axi_awlock;
  input [3:0]s_axi_awcache;
  input [2:0]s_axi_awprot;
  input [3:0]s_axi_awqos;
  input [3:0]s_axi_awregion;
  input [0:0]s_axi_awuser;
  input s_axi_awvalid;
  output s_axi_awready;
  input [0:0]s_axi_wid;
  input [63:0]s_axi_wdata;
  input [7:0]s_axi_wstrb;
  input s_axi_wlast;
  input [0:0]s_axi_wuser;
  input s_axi_wvalid;
  output s_axi_wready;
  output [0:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output [0:0]s_axi_buser;
  output s_axi_bvalid;
  input s_axi_bready;
  output [0:0]m_axi_awid;
  output [31:0]m_axi_awaddr;
  output [7:0]m_axi_awlen;
  output [2:0]m_axi_awsize;
  output [1:0]m_axi_awburst;
  output [0:0]m_axi_awlock;
  output [3:0]m_axi_awcache;
  output [2:0]m_axi_awprot;
  output [3:0]m_axi_awqos;
  output [3:0]m_axi_awregion;
  output [0:0]m_axi_awuser;
  output m_axi_awvalid;
  input m_axi_awready;
  output [0:0]m_axi_wid;
  output [63:0]m_axi_wdata;
  output [7:0]m_axi_wstrb;
  output m_axi_wlast;
  output [0:0]m_axi_wuser;
  output m_axi_wvalid;
  input m_axi_wready;
  input [0:0]m_axi_bid;
  input [1:0]m_axi_bresp;
  input [0:0]m_axi_buser;
  input m_axi_bvalid;
  output m_axi_bready;
  input [0:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input [0:0]s_axi_arlock;
  input [3:0]s_axi_arcache;
  input [2:0]s_axi_arprot;
  input [3:0]s_axi_arqos;
  input [3:0]s_axi_arregion;
  input [0:0]s_axi_aruser;
  input s_axi_arvalid;
  output s_axi_arready;
  output [0:0]s_axi_rid;
  output [63:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output [0:0]s_axi_ruser;
  output s_axi_rvalid;
  input s_axi_rready;
  output [0:0]m_axi_arid;
  output [31:0]m_axi_araddr;
  output [7:0]m_axi_arlen;
  output [2:0]m_axi_arsize;
  output [1:0]m_axi_arburst;
  output [0:0]m_axi_arlock;
  output [3:0]m_axi_arcache;
  output [2:0]m_axi_arprot;
  output [3:0]m_axi_arqos;
  output [3:0]m_axi_arregion;
  output [0:0]m_axi_aruser;
  output m_axi_arvalid;
  input m_axi_arready;
  input [0:0]m_axi_rid;
  input [63:0]m_axi_rdata;
  input [1:0]m_axi_rresp;
  input m_axi_rlast;
  input [0:0]m_axi_ruser;
  input m_axi_rvalid;
  output m_axi_rready;
  input s_axis_tvalid;
  output s_axis_tready;
  input [7:0]s_axis_tdata;
  input [0:0]s_axis_tstrb;
  input [0:0]s_axis_tkeep;
  input s_axis_tlast;
  input [0:0]s_axis_tid;
  input [0:0]s_axis_tdest;
  input [3:0]s_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output [7:0]m_axis_tdata;
  output [0:0]m_axis_tstrb;
  output [0:0]m_axis_tkeep;
  output m_axis_tlast;
  output [0:0]m_axis_tid;
  output [0:0]m_axis_tdest;
  output [3:0]m_axis_tuser;
  input axi_aw_injectsbiterr;
  input axi_aw_injectdbiterr;
  input [3:0]axi_aw_prog_full_thresh;
  input [3:0]axi_aw_prog_empty_thresh;
  output [4:0]axi_aw_data_count;
  output [4:0]axi_aw_wr_data_count;
  output [4:0]axi_aw_rd_data_count;
  output axi_aw_sbiterr;
  output axi_aw_dbiterr;
  output axi_aw_overflow;
  output axi_aw_underflow;
  output axi_aw_prog_full;
  output axi_aw_prog_empty;
  input axi_w_injectsbiterr;
  input axi_w_injectdbiterr;
  input [9:0]axi_w_prog_full_thresh;
  input [9:0]axi_w_prog_empty_thresh;
  output [10:0]axi_w_data_count;
  output [10:0]axi_w_wr_data_count;
  output [10:0]axi_w_rd_data_count;
  output axi_w_sbiterr;
  output axi_w_dbiterr;
  output axi_w_overflow;
  output axi_w_underflow;
  output axi_w_prog_full;
  output axi_w_prog_empty;
  input axi_b_injectsbiterr;
  input axi_b_injectdbiterr;
  input [3:0]axi_b_prog_full_thresh;
  input [3:0]axi_b_prog_empty_thresh;
  output [4:0]axi_b_data_count;
  output [4:0]axi_b_wr_data_count;
  output [4:0]axi_b_rd_data_count;
  output axi_b_sbiterr;
  output axi_b_dbiterr;
  output axi_b_overflow;
  output axi_b_underflow;
  output axi_b_prog_full;
  output axi_b_prog_empty;
  input axi_ar_injectsbiterr;
  input axi_ar_injectdbiterr;
  input [3:0]axi_ar_prog_full_thresh;
  input [3:0]axi_ar_prog_empty_thresh;
  output [4:0]axi_ar_data_count;
  output [4:0]axi_ar_wr_data_count;
  output [4:0]axi_ar_rd_data_count;
  output axi_ar_sbiterr;
  output axi_ar_dbiterr;
  output axi_ar_overflow;
  output axi_ar_underflow;
  output axi_ar_prog_full;
  output axi_ar_prog_empty;
  input axi_r_injectsbiterr;
  input axi_r_injectdbiterr;
  input [9:0]axi_r_prog_full_thresh;
  input [9:0]axi_r_prog_empty_thresh;
  output [10:0]axi_r_data_count;
  output [10:0]axi_r_wr_data_count;
  output [10:0]axi_r_rd_data_count;
  output axi_r_sbiterr;
  output axi_r_dbiterr;
  output axi_r_overflow;
  output axi_r_underflow;
  output axi_r_prog_full;
  output axi_r_prog_empty;
  input axis_injectsbiterr;
  input axis_injectdbiterr;
  input [9:0]axis_prog_full_thresh;
  input [9:0]axis_prog_empty_thresh;
  output [10:0]axis_data_count;
  output [10:0]axis_wr_data_count;
  output [10:0]axis_rd_data_count;
  output axis_sbiterr;
  output axis_dbiterr;
  output axis_overflow;
  output axis_underflow;
  output axis_prog_full;
  output axis_prog_empty;

  wire \<const0> ;
  wire \<const1> ;
  wire [287:0]din;
  wire [287:0]dout;
  wire empty;
  wire full;
  wire rd_clk;
  wire rd_en;
  wire rd_rst_busy;
  wire rst;
  wire wr_clk;
  wire wr_en;
  wire wr_rst_busy;

  assign almost_empty = \<const0> ;
  assign almost_full = \<const0> ;
  assign axi_ar_data_count[4] = \<const0> ;
  assign axi_ar_data_count[3] = \<const0> ;
  assign axi_ar_data_count[2] = \<const0> ;
  assign axi_ar_data_count[1] = \<const0> ;
  assign axi_ar_data_count[0] = \<const0> ;
  assign axi_ar_dbiterr = \<const0> ;
  assign axi_ar_overflow = \<const0> ;
  assign axi_ar_prog_empty = \<const1> ;
  assign axi_ar_prog_full = \<const0> ;
  assign axi_ar_rd_data_count[4] = \<const0> ;
  assign axi_ar_rd_data_count[3] = \<const0> ;
  assign axi_ar_rd_data_count[2] = \<const0> ;
  assign axi_ar_rd_data_count[1] = \<const0> ;
  assign axi_ar_rd_data_count[0] = \<const0> ;
  assign axi_ar_sbiterr = \<const0> ;
  assign axi_ar_underflow = \<const0> ;
  assign axi_ar_wr_data_count[4] = \<const0> ;
  assign axi_ar_wr_data_count[3] = \<const0> ;
  assign axi_ar_wr_data_count[2] = \<const0> ;
  assign axi_ar_wr_data_count[1] = \<const0> ;
  assign axi_ar_wr_data_count[0] = \<const0> ;
  assign axi_aw_data_count[4] = \<const0> ;
  assign axi_aw_data_count[3] = \<const0> ;
  assign axi_aw_data_count[2] = \<const0> ;
  assign axi_aw_data_count[1] = \<const0> ;
  assign axi_aw_data_count[0] = \<const0> ;
  assign axi_aw_dbiterr = \<const0> ;
  assign axi_aw_overflow = \<const0> ;
  assign axi_aw_prog_empty = \<const1> ;
  assign axi_aw_prog_full = \<const0> ;
  assign axi_aw_rd_data_count[4] = \<const0> ;
  assign axi_aw_rd_data_count[3] = \<const0> ;
  assign axi_aw_rd_data_count[2] = \<const0> ;
  assign axi_aw_rd_data_count[1] = \<const0> ;
  assign axi_aw_rd_data_count[0] = \<const0> ;
  assign axi_aw_sbiterr = \<const0> ;
  assign axi_aw_underflow = \<const0> ;
  assign axi_aw_wr_data_count[4] = \<const0> ;
  assign axi_aw_wr_data_count[3] = \<const0> ;
  assign axi_aw_wr_data_count[2] = \<const0> ;
  assign axi_aw_wr_data_count[1] = \<const0> ;
  assign axi_aw_wr_data_count[0] = \<const0> ;
  assign axi_b_data_count[4] = \<const0> ;
  assign axi_b_data_count[3] = \<const0> ;
  assign axi_b_data_count[2] = \<const0> ;
  assign axi_b_data_count[1] = \<const0> ;
  assign axi_b_data_count[0] = \<const0> ;
  assign axi_b_dbiterr = \<const0> ;
  assign axi_b_overflow = \<const0> ;
  assign axi_b_prog_empty = \<const1> ;
  assign axi_b_prog_full = \<const0> ;
  assign axi_b_rd_data_count[4] = \<const0> ;
  assign axi_b_rd_data_count[3] = \<const0> ;
  assign axi_b_rd_data_count[2] = \<const0> ;
  assign axi_b_rd_data_count[1] = \<const0> ;
  assign axi_b_rd_data_count[0] = \<const0> ;
  assign axi_b_sbiterr = \<const0> ;
  assign axi_b_underflow = \<const0> ;
  assign axi_b_wr_data_count[4] = \<const0> ;
  assign axi_b_wr_data_count[3] = \<const0> ;
  assign axi_b_wr_data_count[2] = \<const0> ;
  assign axi_b_wr_data_count[1] = \<const0> ;
  assign axi_b_wr_data_count[0] = \<const0> ;
  assign axi_r_data_count[10] = \<const0> ;
  assign axi_r_data_count[9] = \<const0> ;
  assign axi_r_data_count[8] = \<const0> ;
  assign axi_r_data_count[7] = \<const0> ;
  assign axi_r_data_count[6] = \<const0> ;
  assign axi_r_data_count[5] = \<const0> ;
  assign axi_r_data_count[4] = \<const0> ;
  assign axi_r_data_count[3] = \<const0> ;
  assign axi_r_data_count[2] = \<const0> ;
  assign axi_r_data_count[1] = \<const0> ;
  assign axi_r_data_count[0] = \<const0> ;
  assign axi_r_dbiterr = \<const0> ;
  assign axi_r_overflow = \<const0> ;
  assign axi_r_prog_empty = \<const1> ;
  assign axi_r_prog_full = \<const0> ;
  assign axi_r_rd_data_count[10] = \<const0> ;
  assign axi_r_rd_data_count[9] = \<const0> ;
  assign axi_r_rd_data_count[8] = \<const0> ;
  assign axi_r_rd_data_count[7] = \<const0> ;
  assign axi_r_rd_data_count[6] = \<const0> ;
  assign axi_r_rd_data_count[5] = \<const0> ;
  assign axi_r_rd_data_count[4] = \<const0> ;
  assign axi_r_rd_data_count[3] = \<const0> ;
  assign axi_r_rd_data_count[2] = \<const0> ;
  assign axi_r_rd_data_count[1] = \<const0> ;
  assign axi_r_rd_data_count[0] = \<const0> ;
  assign axi_r_sbiterr = \<const0> ;
  assign axi_r_underflow = \<const0> ;
  assign axi_r_wr_data_count[10] = \<const0> ;
  assign axi_r_wr_data_count[9] = \<const0> ;
  assign axi_r_wr_data_count[8] = \<const0> ;
  assign axi_r_wr_data_count[7] = \<const0> ;
  assign axi_r_wr_data_count[6] = \<const0> ;
  assign axi_r_wr_data_count[5] = \<const0> ;
  assign axi_r_wr_data_count[4] = \<const0> ;
  assign axi_r_wr_data_count[3] = \<const0> ;
  assign axi_r_wr_data_count[2] = \<const0> ;
  assign axi_r_wr_data_count[1] = \<const0> ;
  assign axi_r_wr_data_count[0] = \<const0> ;
  assign axi_w_data_count[10] = \<const0> ;
  assign axi_w_data_count[9] = \<const0> ;
  assign axi_w_data_count[8] = \<const0> ;
  assign axi_w_data_count[7] = \<const0> ;
  assign axi_w_data_count[6] = \<const0> ;
  assign axi_w_data_count[5] = \<const0> ;
  assign axi_w_data_count[4] = \<const0> ;
  assign axi_w_data_count[3] = \<const0> ;
  assign axi_w_data_count[2] = \<const0> ;
  assign axi_w_data_count[1] = \<const0> ;
  assign axi_w_data_count[0] = \<const0> ;
  assign axi_w_dbiterr = \<const0> ;
  assign axi_w_overflow = \<const0> ;
  assign axi_w_prog_empty = \<const1> ;
  assign axi_w_prog_full = \<const0> ;
  assign axi_w_rd_data_count[10] = \<const0> ;
  assign axi_w_rd_data_count[9] = \<const0> ;
  assign axi_w_rd_data_count[8] = \<const0> ;
  assign axi_w_rd_data_count[7] = \<const0> ;
  assign axi_w_rd_data_count[6] = \<const0> ;
  assign axi_w_rd_data_count[5] = \<const0> ;
  assign axi_w_rd_data_count[4] = \<const0> ;
  assign axi_w_rd_data_count[3] = \<const0> ;
  assign axi_w_rd_data_count[2] = \<const0> ;
  assign axi_w_rd_data_count[1] = \<const0> ;
  assign axi_w_rd_data_count[0] = \<const0> ;
  assign axi_w_sbiterr = \<const0> ;
  assign axi_w_underflow = \<const0> ;
  assign axi_w_wr_data_count[10] = \<const0> ;
  assign axi_w_wr_data_count[9] = \<const0> ;
  assign axi_w_wr_data_count[8] = \<const0> ;
  assign axi_w_wr_data_count[7] = \<const0> ;
  assign axi_w_wr_data_count[6] = \<const0> ;
  assign axi_w_wr_data_count[5] = \<const0> ;
  assign axi_w_wr_data_count[4] = \<const0> ;
  assign axi_w_wr_data_count[3] = \<const0> ;
  assign axi_w_wr_data_count[2] = \<const0> ;
  assign axi_w_wr_data_count[1] = \<const0> ;
  assign axi_w_wr_data_count[0] = \<const0> ;
  assign axis_data_count[10] = \<const0> ;
  assign axis_data_count[9] = \<const0> ;
  assign axis_data_count[8] = \<const0> ;
  assign axis_data_count[7] = \<const0> ;
  assign axis_data_count[6] = \<const0> ;
  assign axis_data_count[5] = \<const0> ;
  assign axis_data_count[4] = \<const0> ;
  assign axis_data_count[3] = \<const0> ;
  assign axis_data_count[2] = \<const0> ;
  assign axis_data_count[1] = \<const0> ;
  assign axis_data_count[0] = \<const0> ;
  assign axis_dbiterr = \<const0> ;
  assign axis_overflow = \<const0> ;
  assign axis_prog_empty = \<const1> ;
  assign axis_prog_full = \<const0> ;
  assign axis_rd_data_count[10] = \<const0> ;
  assign axis_rd_data_count[9] = \<const0> ;
  assign axis_rd_data_count[8] = \<const0> ;
  assign axis_rd_data_count[7] = \<const0> ;
  assign axis_rd_data_count[6] = \<const0> ;
  assign axis_rd_data_count[5] = \<const0> ;
  assign axis_rd_data_count[4] = \<const0> ;
  assign axis_rd_data_count[3] = \<const0> ;
  assign axis_rd_data_count[2] = \<const0> ;
  assign axis_rd_data_count[1] = \<const0> ;
  assign axis_rd_data_count[0] = \<const0> ;
  assign axis_sbiterr = \<const0> ;
  assign axis_underflow = \<const0> ;
  assign axis_wr_data_count[10] = \<const0> ;
  assign axis_wr_data_count[9] = \<const0> ;
  assign axis_wr_data_count[8] = \<const0> ;
  assign axis_wr_data_count[7] = \<const0> ;
  assign axis_wr_data_count[6] = \<const0> ;
  assign axis_wr_data_count[5] = \<const0> ;
  assign axis_wr_data_count[4] = \<const0> ;
  assign axis_wr_data_count[3] = \<const0> ;
  assign axis_wr_data_count[2] = \<const0> ;
  assign axis_wr_data_count[1] = \<const0> ;
  assign axis_wr_data_count[0] = \<const0> ;
  assign data_count[4] = \<const0> ;
  assign data_count[3] = \<const0> ;
  assign data_count[2] = \<const0> ;
  assign data_count[1] = \<const0> ;
  assign data_count[0] = \<const0> ;
  assign dbiterr = \<const0> ;
  assign m_axi_araddr[31] = \<const0> ;
  assign m_axi_araddr[30] = \<const0> ;
  assign m_axi_araddr[29] = \<const0> ;
  assign m_axi_araddr[28] = \<const0> ;
  assign m_axi_araddr[27] = \<const0> ;
  assign m_axi_araddr[26] = \<const0> ;
  assign m_axi_araddr[25] = \<const0> ;
  assign m_axi_araddr[24] = \<const0> ;
  assign m_axi_araddr[23] = \<const0> ;
  assign m_axi_araddr[22] = \<const0> ;
  assign m_axi_araddr[21] = \<const0> ;
  assign m_axi_araddr[20] = \<const0> ;
  assign m_axi_araddr[19] = \<const0> ;
  assign m_axi_araddr[18] = \<const0> ;
  assign m_axi_araddr[17] = \<const0> ;
  assign m_axi_araddr[16] = \<const0> ;
  assign m_axi_araddr[15] = \<const0> ;
  assign m_axi_araddr[14] = \<const0> ;
  assign m_axi_araddr[13] = \<const0> ;
  assign m_axi_araddr[12] = \<const0> ;
  assign m_axi_araddr[11] = \<const0> ;
  assign m_axi_araddr[10] = \<const0> ;
  assign m_axi_araddr[9] = \<const0> ;
  assign m_axi_araddr[8] = \<const0> ;
  assign m_axi_araddr[7] = \<const0> ;
  assign m_axi_araddr[6] = \<const0> ;
  assign m_axi_araddr[5] = \<const0> ;
  assign m_axi_araddr[4] = \<const0> ;
  assign m_axi_araddr[3] = \<const0> ;
  assign m_axi_araddr[2] = \<const0> ;
  assign m_axi_araddr[1] = \<const0> ;
  assign m_axi_araddr[0] = \<const0> ;
  assign m_axi_arburst[1] = \<const0> ;
  assign m_axi_arburst[0] = \<const0> ;
  assign m_axi_arcache[3] = \<const0> ;
  assign m_axi_arcache[2] = \<const0> ;
  assign m_axi_arcache[1] = \<const0> ;
  assign m_axi_arcache[0] = \<const0> ;
  assign m_axi_arid[0] = \<const0> ;
  assign m_axi_arlen[7] = \<const0> ;
  assign m_axi_arlen[6] = \<const0> ;
  assign m_axi_arlen[5] = \<const0> ;
  assign m_axi_arlen[4] = \<const0> ;
  assign m_axi_arlen[3] = \<const0> ;
  assign m_axi_arlen[2] = \<const0> ;
  assign m_axi_arlen[1] = \<const0> ;
  assign m_axi_arlen[0] = \<const0> ;
  assign m_axi_arlock[0] = \<const0> ;
  assign m_axi_arprot[2] = \<const0> ;
  assign m_axi_arprot[1] = \<const0> ;
  assign m_axi_arprot[0] = \<const0> ;
  assign m_axi_arqos[3] = \<const0> ;
  assign m_axi_arqos[2] = \<const0> ;
  assign m_axi_arqos[1] = \<const0> ;
  assign m_axi_arqos[0] = \<const0> ;
  assign m_axi_arregion[3] = \<const0> ;
  assign m_axi_arregion[2] = \<const0> ;
  assign m_axi_arregion[1] = \<const0> ;
  assign m_axi_arregion[0] = \<const0> ;
  assign m_axi_arsize[2] = \<const0> ;
  assign m_axi_arsize[1] = \<const0> ;
  assign m_axi_arsize[0] = \<const0> ;
  assign m_axi_aruser[0] = \<const0> ;
  assign m_axi_arvalid = \<const0> ;
  assign m_axi_awaddr[31] = \<const0> ;
  assign m_axi_awaddr[30] = \<const0> ;
  assign m_axi_awaddr[29] = \<const0> ;
  assign m_axi_awaddr[28] = \<const0> ;
  assign m_axi_awaddr[27] = \<const0> ;
  assign m_axi_awaddr[26] = \<const0> ;
  assign m_axi_awaddr[25] = \<const0> ;
  assign m_axi_awaddr[24] = \<const0> ;
  assign m_axi_awaddr[23] = \<const0> ;
  assign m_axi_awaddr[22] = \<const0> ;
  assign m_axi_awaddr[21] = \<const0> ;
  assign m_axi_awaddr[20] = \<const0> ;
  assign m_axi_awaddr[19] = \<const0> ;
  assign m_axi_awaddr[18] = \<const0> ;
  assign m_axi_awaddr[17] = \<const0> ;
  assign m_axi_awaddr[16] = \<const0> ;
  assign m_axi_awaddr[15] = \<const0> ;
  assign m_axi_awaddr[14] = \<const0> ;
  assign m_axi_awaddr[13] = \<const0> ;
  assign m_axi_awaddr[12] = \<const0> ;
  assign m_axi_awaddr[11] = \<const0> ;
  assign m_axi_awaddr[10] = \<const0> ;
  assign m_axi_awaddr[9] = \<const0> ;
  assign m_axi_awaddr[8] = \<const0> ;
  assign m_axi_awaddr[7] = \<const0> ;
  assign m_axi_awaddr[6] = \<const0> ;
  assign m_axi_awaddr[5] = \<const0> ;
  assign m_axi_awaddr[4] = \<const0> ;
  assign m_axi_awaddr[3] = \<const0> ;
  assign m_axi_awaddr[2] = \<const0> ;
  assign m_axi_awaddr[1] = \<const0> ;
  assign m_axi_awaddr[0] = \<const0> ;
  assign m_axi_awburst[1] = \<const0> ;
  assign m_axi_awburst[0] = \<const0> ;
  assign m_axi_awcache[3] = \<const0> ;
  assign m_axi_awcache[2] = \<const0> ;
  assign m_axi_awcache[1] = \<const0> ;
  assign m_axi_awcache[0] = \<const0> ;
  assign m_axi_awid[0] = \<const0> ;
  assign m_axi_awlen[7] = \<const0> ;
  assign m_axi_awlen[6] = \<const0> ;
  assign m_axi_awlen[5] = \<const0> ;
  assign m_axi_awlen[4] = \<const0> ;
  assign m_axi_awlen[3] = \<const0> ;
  assign m_axi_awlen[2] = \<const0> ;
  assign m_axi_awlen[1] = \<const0> ;
  assign m_axi_awlen[0] = \<const0> ;
  assign m_axi_awlock[0] = \<const0> ;
  assign m_axi_awprot[2] = \<const0> ;
  assign m_axi_awprot[1] = \<const0> ;
  assign m_axi_awprot[0] = \<const0> ;
  assign m_axi_awqos[3] = \<const0> ;
  assign m_axi_awqos[2] = \<const0> ;
  assign m_axi_awqos[1] = \<const0> ;
  assign m_axi_awqos[0] = \<const0> ;
  assign m_axi_awregion[3] = \<const0> ;
  assign m_axi_awregion[2] = \<const0> ;
  assign m_axi_awregion[1] = \<const0> ;
  assign m_axi_awregion[0] = \<const0> ;
  assign m_axi_awsize[2] = \<const0> ;
  assign m_axi_awsize[1] = \<const0> ;
  assign m_axi_awsize[0] = \<const0> ;
  assign m_axi_awuser[0] = \<const0> ;
  assign m_axi_awvalid = \<const0> ;
  assign m_axi_bready = \<const0> ;
  assign m_axi_rready = \<const0> ;
  assign m_axi_wdata[63] = \<const0> ;
  assign m_axi_wdata[62] = \<const0> ;
  assign m_axi_wdata[61] = \<const0> ;
  assign m_axi_wdata[60] = \<const0> ;
  assign m_axi_wdata[59] = \<const0> ;
  assign m_axi_wdata[58] = \<const0> ;
  assign m_axi_wdata[57] = \<const0> ;
  assign m_axi_wdata[56] = \<const0> ;
  assign m_axi_wdata[55] = \<const0> ;
  assign m_axi_wdata[54] = \<const0> ;
  assign m_axi_wdata[53] = \<const0> ;
  assign m_axi_wdata[52] = \<const0> ;
  assign m_axi_wdata[51] = \<const0> ;
  assign m_axi_wdata[50] = \<const0> ;
  assign m_axi_wdata[49] = \<const0> ;
  assign m_axi_wdata[48] = \<const0> ;
  assign m_axi_wdata[47] = \<const0> ;
  assign m_axi_wdata[46] = \<const0> ;
  assign m_axi_wdata[45] = \<const0> ;
  assign m_axi_wdata[44] = \<const0> ;
  assign m_axi_wdata[43] = \<const0> ;
  assign m_axi_wdata[42] = \<const0> ;
  assign m_axi_wdata[41] = \<const0> ;
  assign m_axi_wdata[40] = \<const0> ;
  assign m_axi_wdata[39] = \<const0> ;
  assign m_axi_wdata[38] = \<const0> ;
  assign m_axi_wdata[37] = \<const0> ;
  assign m_axi_wdata[36] = \<const0> ;
  assign m_axi_wdata[35] = \<const0> ;
  assign m_axi_wdata[34] = \<const0> ;
  assign m_axi_wdata[33] = \<const0> ;
  assign m_axi_wdata[32] = \<const0> ;
  assign m_axi_wdata[31] = \<const0> ;
  assign m_axi_wdata[30] = \<const0> ;
  assign m_axi_wdata[29] = \<const0> ;
  assign m_axi_wdata[28] = \<const0> ;
  assign m_axi_wdata[27] = \<const0> ;
  assign m_axi_wdata[26] = \<const0> ;
  assign m_axi_wdata[25] = \<const0> ;
  assign m_axi_wdata[24] = \<const0> ;
  assign m_axi_wdata[23] = \<const0> ;
  assign m_axi_wdata[22] = \<const0> ;
  assign m_axi_wdata[21] = \<const0> ;
  assign m_axi_wdata[20] = \<const0> ;
  assign m_axi_wdata[19] = \<const0> ;
  assign m_axi_wdata[18] = \<const0> ;
  assign m_axi_wdata[17] = \<const0> ;
  assign m_axi_wdata[16] = \<const0> ;
  assign m_axi_wdata[15] = \<const0> ;
  assign m_axi_wdata[14] = \<const0> ;
  assign m_axi_wdata[13] = \<const0> ;
  assign m_axi_wdata[12] = \<const0> ;
  assign m_axi_wdata[11] = \<const0> ;
  assign m_axi_wdata[10] = \<const0> ;
  assign m_axi_wdata[9] = \<const0> ;
  assign m_axi_wdata[8] = \<const0> ;
  assign m_axi_wdata[7] = \<const0> ;
  assign m_axi_wdata[6] = \<const0> ;
  assign m_axi_wdata[5] = \<const0> ;
  assign m_axi_wdata[4] = \<const0> ;
  assign m_axi_wdata[3] = \<const0> ;
  assign m_axi_wdata[2] = \<const0> ;
  assign m_axi_wdata[1] = \<const0> ;
  assign m_axi_wdata[0] = \<const0> ;
  assign m_axi_wid[0] = \<const0> ;
  assign m_axi_wlast = \<const0> ;
  assign m_axi_wstrb[7] = \<const0> ;
  assign m_axi_wstrb[6] = \<const0> ;
  assign m_axi_wstrb[5] = \<const0> ;
  assign m_axi_wstrb[4] = \<const0> ;
  assign m_axi_wstrb[3] = \<const0> ;
  assign m_axi_wstrb[2] = \<const0> ;
  assign m_axi_wstrb[1] = \<const0> ;
  assign m_axi_wstrb[0] = \<const0> ;
  assign m_axi_wuser[0] = \<const0> ;
  assign m_axi_wvalid = \<const0> ;
  assign m_axis_tdata[7] = \<const0> ;
  assign m_axis_tdata[6] = \<const0> ;
  assign m_axis_tdata[5] = \<const0> ;
  assign m_axis_tdata[4] = \<const0> ;
  assign m_axis_tdata[3] = \<const0> ;
  assign m_axis_tdata[2] = \<const0> ;
  assign m_axis_tdata[1] = \<const0> ;
  assign m_axis_tdata[0] = \<const0> ;
  assign m_axis_tdest[0] = \<const0> ;
  assign m_axis_tid[0] = \<const0> ;
  assign m_axis_tkeep[0] = \<const0> ;
  assign m_axis_tlast = \<const0> ;
  assign m_axis_tstrb[0] = \<const0> ;
  assign m_axis_tuser[3] = \<const0> ;
  assign m_axis_tuser[2] = \<const0> ;
  assign m_axis_tuser[1] = \<const0> ;
  assign m_axis_tuser[0] = \<const0> ;
  assign m_axis_tvalid = \<const0> ;
  assign overflow = \<const0> ;
  assign prog_empty = \<const0> ;
  assign prog_full = \<const0> ;
  assign rd_data_count[4] = \<const0> ;
  assign rd_data_count[3] = \<const0> ;
  assign rd_data_count[2] = \<const0> ;
  assign rd_data_count[1] = \<const0> ;
  assign rd_data_count[0] = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_buser[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_rdata[63] = \<const0> ;
  assign s_axi_rdata[62] = \<const0> ;
  assign s_axi_rdata[61] = \<const0> ;
  assign s_axi_rdata[60] = \<const0> ;
  assign s_axi_rdata[59] = \<const0> ;
  assign s_axi_rdata[58] = \<const0> ;
  assign s_axi_rdata[57] = \<const0> ;
  assign s_axi_rdata[56] = \<const0> ;
  assign s_axi_rdata[55] = \<const0> ;
  assign s_axi_rdata[54] = \<const0> ;
  assign s_axi_rdata[53] = \<const0> ;
  assign s_axi_rdata[52] = \<const0> ;
  assign s_axi_rdata[51] = \<const0> ;
  assign s_axi_rdata[50] = \<const0> ;
  assign s_axi_rdata[49] = \<const0> ;
  assign s_axi_rdata[48] = \<const0> ;
  assign s_axi_rdata[47] = \<const0> ;
  assign s_axi_rdata[46] = \<const0> ;
  assign s_axi_rdata[45] = \<const0> ;
  assign s_axi_rdata[44] = \<const0> ;
  assign s_axi_rdata[43] = \<const0> ;
  assign s_axi_rdata[42] = \<const0> ;
  assign s_axi_rdata[41] = \<const0> ;
  assign s_axi_rdata[40] = \<const0> ;
  assign s_axi_rdata[39] = \<const0> ;
  assign s_axi_rdata[38] = \<const0> ;
  assign s_axi_rdata[37] = \<const0> ;
  assign s_axi_rdata[36] = \<const0> ;
  assign s_axi_rdata[35] = \<const0> ;
  assign s_axi_rdata[34] = \<const0> ;
  assign s_axi_rdata[33] = \<const0> ;
  assign s_axi_rdata[32] = \<const0> ;
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_ruser[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign s_axis_tready = \<const0> ;
  assign sbiterr = \<const0> ;
  assign underflow = \<const0> ;
  assign valid = \<const0> ;
  assign wr_ack = \<const0> ;
  assign wr_data_count[4] = \<const0> ;
  assign wr_data_count[3] = \<const0> ;
  assign wr_data_count[2] = \<const0> ;
  assign wr_data_count[1] = \<const0> ;
  assign wr_data_count[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  XGMII_FIFO_DUAL_SYNC_fifo_generator_v13_2_4_synth inst_fifo_gen
       (.AR(rd_rst_busy),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* ORIG_REF_NAME = "fifo_generator_v13_2_4_synth" *) 
module XGMII_FIFO_DUAL_SYNC_fifo_generator_v13_2_4_synth
   (wr_rst_busy,
    AR,
    empty,
    full,
    dout,
    rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en);
  output wr_rst_busy;
  output [0:0]AR;
  output empty;
  output full;
  output [287:0]dout;
  input rst;
  input wr_clk;
  input rd_clk;
  input [287:0]din;
  input wr_en;
  input rd_en;

  wire [0:0]AR;
  wire [287:0]din;
  wire [287:0]dout;
  wire empty;
  wire full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;
  wire wr_rst_busy;

  XGMII_FIFO_DUAL_SYNC_fifo_generator_top \gconvfifo.rf 
       (.AR(AR),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* ORIG_REF_NAME = "memory" *) 
module XGMII_FIFO_DUAL_SYNC_memory
   (dout,
    wr_clk,
    E,
    din,
    \gpr1.dout_i_reg[1] ,
    \gpr1.dout_i_reg[1]_0 ,
    \gpr1.dout_i_reg[0] ,
    rd_clk,
    AR);
  output [287:0]dout;
  input wr_clk;
  input [0:0]E;
  input [287:0]din;
  input [4:0]\gpr1.dout_i_reg[1] ;
  input [4:0]\gpr1.dout_i_reg[1]_0 ;
  input [0:0]\gpr1.dout_i_reg[0] ;
  input rd_clk;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [287:0]din;
  wire [287:0]dout;
  wire [0:0]\gpr1.dout_i_reg[0] ;
  wire [4:0]\gpr1.dout_i_reg[1] ;
  wire [4:0]\gpr1.dout_i_reg[1]_0 ;
  wire rd_clk;
  wire wr_clk;

  XGMII_FIFO_DUAL_SYNC_dmem \gdm.dm_gen.dm 
       (.AR(AR),
        .E(E),
        .din(din),
        .dout(dout),
        .\gpr1.dout_i_reg[0]_0 (\gpr1.dout_i_reg[0] ),
        .\gpr1.dout_i_reg[1]_0 (\gpr1.dout_i_reg[1] ),
        .\gpr1.dout_i_reg[1]_1 (\gpr1.dout_i_reg[1]_0 ),
        .rd_clk(rd_clk),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "rd_bin_cntr" *) 
module XGMII_FIFO_DUAL_SYNC_rd_bin_cntr
   (rd_en_0,
    Q,
    \gc0.count_d1_reg[4]_0 ,
    ram_empty_i_reg,
    rd_en,
    out,
    ram_empty_i_reg_0,
    WR_PNTR_RD,
    E,
    rd_clk,
    AR);
  output rd_en_0;
  output [2:0]Q;
  output [4:0]\gc0.count_d1_reg[4]_0 ;
  input ram_empty_i_reg;
  input rd_en;
  input out;
  input ram_empty_i_reg_0;
  input [1:0]WR_PNTR_RD;
  input [0:0]E;
  input rd_clk;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [2:0]Q;
  wire [1:0]WR_PNTR_RD;
  wire [4:0]\gc0.count_d1_reg[4]_0 ;
  wire out;
  wire [4:0]plusOp__0;
  wire ram_empty_i_i_3_n_0;
  wire ram_empty_i_i_4_n_0;
  wire ram_empty_i_reg;
  wire ram_empty_i_reg_0;
  wire rd_clk;
  wire rd_en;
  wire rd_en_0;
  wire [1:0]rd_pntr_plus1;

  LUT1 #(
    .INIT(2'h1)) 
    \gc0.count[0]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .O(plusOp__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \gc0.count[1]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .I1(rd_pntr_plus1[1]),
        .O(plusOp__0[1]));
  LUT3 #(
    .INIT(8'h78)) 
    \gc0.count[2]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .I1(rd_pntr_plus1[1]),
        .I2(Q[0]),
        .O(plusOp__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \gc0.count[3]_i_1 
       (.I0(rd_pntr_plus1[1]),
        .I1(rd_pntr_plus1[0]),
        .I2(Q[0]),
        .I3(Q[1]),
        .O(plusOp__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \gc0.count[4]_i_1 
       (.I0(Q[0]),
        .I1(rd_pntr_plus1[0]),
        .I2(rd_pntr_plus1[1]),
        .I3(Q[1]),
        .I4(Q[2]),
        .O(plusOp__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(rd_pntr_plus1[0]),
        .Q(\gc0.count_d1_reg[4]_0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(rd_pntr_plus1[1]),
        .Q(\gc0.count_d1_reg[4]_0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(Q[0]),
        .Q(\gc0.count_d1_reg[4]_0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(Q[1]),
        .Q(\gc0.count_d1_reg[4]_0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(Q[2]),
        .Q(\gc0.count_d1_reg[4]_0 [4]));
  FDPE #(
    .INIT(1'b1)) 
    \gc0.count_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .D(plusOp__0[0]),
        .PRE(AR),
        .Q(rd_pntr_plus1[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__0[1]),
        .Q(rd_pntr_plus1[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__0[2]),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__0[3]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__0[4]),
        .Q(Q[2]));
  LUT6 #(
    .INIT(64'h88F8888888888888)) 
    ram_empty_i_i_1
       (.I0(ram_empty_i_reg),
        .I1(ram_empty_i_i_3_n_0),
        .I2(rd_en),
        .I3(out),
        .I4(ram_empty_i_i_4_n_0),
        .I5(ram_empty_i_reg_0),
        .O(rd_en_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_empty_i_i_3
       (.I0(\gc0.count_d1_reg[4]_0 [0]),
        .I1(WR_PNTR_RD[0]),
        .I2(\gc0.count_d1_reg[4]_0 [1]),
        .I3(WR_PNTR_RD[1]),
        .O(ram_empty_i_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h9009)) 
    ram_empty_i_i_4
       (.I0(rd_pntr_plus1[0]),
        .I1(WR_PNTR_RD[0]),
        .I2(rd_pntr_plus1[1]),
        .I3(WR_PNTR_RD[1]),
        .O(ram_empty_i_i_4_n_0));
endmodule

(* ORIG_REF_NAME = "rd_logic" *) 
module XGMII_FIFO_DUAL_SYNC_rd_logic
   (empty,
    E,
    Q,
    \gc0.count_d1_reg[4] ,
    rd_clk,
    AR,
    rd_en,
    ram_empty_i_reg,
    ram_empty_i_reg_0,
    WR_PNTR_RD);
  output empty;
  output [0:0]E;
  output [2:0]Q;
  output [4:0]\gc0.count_d1_reg[4] ;
  input rd_clk;
  input [0:0]AR;
  input rd_en;
  input ram_empty_i_reg;
  input ram_empty_i_reg_0;
  input [1:0]WR_PNTR_RD;

  wire [0:0]AR;
  wire [0:0]E;
  wire [2:0]Q;
  wire [1:0]WR_PNTR_RD;
  wire empty;
  wire [4:0]\gc0.count_d1_reg[4] ;
  wire p_2_out;
  wire ram_empty_i_reg;
  wire ram_empty_i_reg_0;
  wire rd_clk;
  wire rd_en;
  wire rpntr_n_0;

  XGMII_FIFO_DUAL_SYNC_rd_status_flags_as \gras.rsts 
       (.AR(AR),
        .E(E),
        .empty(empty),
        .out(p_2_out),
        .ram_empty_i_reg_0(rpntr_n_0),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
  XGMII_FIFO_DUAL_SYNC_rd_bin_cntr rpntr
       (.AR(AR),
        .E(E),
        .Q(Q),
        .WR_PNTR_RD(WR_PNTR_RD),
        .\gc0.count_d1_reg[4]_0 (\gc0.count_d1_reg[4] ),
        .out(p_2_out),
        .ram_empty_i_reg(ram_empty_i_reg),
        .ram_empty_i_reg_0(ram_empty_i_reg_0),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rd_en_0(rpntr_n_0));
endmodule

(* ORIG_REF_NAME = "rd_status_flags_as" *) 
module XGMII_FIFO_DUAL_SYNC_rd_status_flags_as
   (empty,
    out,
    E,
    ram_empty_i_reg_0,
    rd_clk,
    AR,
    rd_en);
  output empty;
  output out;
  output [0:0]E;
  input ram_empty_i_reg_0;
  input rd_clk;
  input [0:0]AR;
  input rd_en;

  wire [0:0]AR;
  wire [0:0]E;
  (* DONT_TOUCH *) wire ram_empty_fb_i;
  (* DONT_TOUCH *) wire ram_empty_i;
  wire ram_empty_i_reg_0;
  wire rd_clk;
  wire rd_en;

  assign empty = ram_empty_i;
  assign out = ram_empty_fb_i;
  LUT2 #(
    .INIT(4'h2)) 
    \gpr1.dout_i[287]_i_1 
       (.I0(rd_en),
        .I1(ram_empty_fb_i),
        .O(E));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_empty_fb_i_reg
       (.C(rd_clk),
        .CE(1'b1),
        .D(ram_empty_i_reg_0),
        .PRE(AR),
        .Q(ram_empty_fb_i));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_empty_i_reg
       (.C(rd_clk),
        .CE(1'b1),
        .D(ram_empty_i_reg_0),
        .PRE(AR),
        .Q(ram_empty_i));
endmodule

(* ORIG_REF_NAME = "reset_blk_ramfifo" *) 
module XGMII_FIFO_DUAL_SYNC_reset_blk_ramfifo
   (AR,
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ,
    out,
    \grstd1.grst_full.grst_f.rst_d3_reg_0 ,
    wr_rst_busy,
    rst,
    wr_clk,
    rd_clk);
  output [0:0]AR;
  output [0:0]\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ;
  output out;
  output \grstd1.grst_full.grst_f.rst_d3_reg_0 ;
  output wr_rst_busy;
  input rst;
  input wr_clk;
  input rd_clk;

  wire [0:0]AR;
  wire dest_out;
  wire \grstd1.grst_full.grst_f.rst_d3_i_1_n_0 ;
  wire \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_i_1_n_0 ;
  wire [0:0]\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ;
  wire \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_i_1_n_0 ;
  wire \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_i_1_n_0 ;
  wire rd_clk;
  wire [3:0]rd_rst_wr_ext;
  wire rst;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d1;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d2;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d3;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_rd_reg2;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_wr_reg2;
  wire sckt_rd_rst_wr;
  wire wr_clk;
  wire wr_rst_busy;
  wire [1:0]wr_rst_rd_ext;

  assign \grstd1.grst_full.grst_f.rst_d3_reg_0  = rst_d3;
  assign out = rst_d2;
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d1_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(wr_rst_busy),
        .PRE(rst_wr_reg2),
        .Q(rst_d1));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d2_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(rst_d1),
        .PRE(rst_wr_reg2),
        .Q(rst_d2));
  LUT2 #(
    .INIT(4'hE)) 
    \grstd1.grst_full.grst_f.rst_d3_i_1 
       (.I0(rst_d2),
        .I1(AR),
        .O(\grstd1.grst_full.grst_f.rst_d3_i_1_n_0 ));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d3_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\grstd1.grst_full.grst_f.rst_d3_i_1_n_0 ),
        .PRE(rst_wr_reg2),
        .Q(rst_d3));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rd_rst_wr_ext_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(rst_wr_reg2),
        .D(sckt_rd_rst_wr),
        .Q(rd_rst_wr_ext[0]));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rd_rst_wr_ext_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(rst_wr_reg2),
        .D(rd_rst_wr_ext[0]),
        .Q(rd_rst_wr_ext[1]));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rd_rst_wr_ext_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(rst_wr_reg2),
        .D(rd_rst_wr_ext[1]),
        .Q(rd_rst_wr_ext[2]));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rd_rst_wr_ext_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(rst_wr_reg2),
        .D(rd_rst_wr_ext[2]),
        .Q(rd_rst_wr_ext[3]));
  (* DEF_VAL = "1'b0" *) 
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* INV_DEF_VAL = "1'b1" *) 
  (* RST_ACTIVE_HIGH = "1" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  (* XPM_MODULE = "TRUE" *) 
  XGMII_FIFO_DUAL_SYNC_xpm_cdc_async_rst \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rst_rd_reg2_inst 
       (.dest_arst(rst_rd_reg2),
        .dest_clk(rd_clk),
        .src_arst(rst));
  LUT2 #(
    .INIT(4'h2)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_i_1 
       (.I0(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ),
        .I1(wr_rst_rd_ext[1]),
        .O(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_i_1_n_0 ));
  FDPE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_i_1_n_0 ),
        .PRE(rst_rd_reg2),
        .Q(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ));
  LUT3 #(
    .INIT(8'h8A)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_i_1 
       (.I0(AR),
        .I1(rd_rst_wr_ext[0]),
        .I2(rd_rst_wr_ext[1]),
        .O(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_i_1_n_0 ));
  FDPE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_i_1_n_0 ),
        .PRE(rst_wr_reg2),
        .Q(AR));
  LUT5 #(
    .INIT(32'hAAAA08AA)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_i_1 
       (.I0(wr_rst_busy),
        .I1(rd_rst_wr_ext[1]),
        .I2(rd_rst_wr_ext[0]),
        .I3(rd_rst_wr_ext[3]),
        .I4(rd_rst_wr_ext[2]),
        .O(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_i_1_n_0 ));
  FDPE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_i_1_n_0 ),
        .PRE(rst_wr_reg2),
        .Q(wr_rst_busy));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_rd_ext_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(rst_rd_reg2),
        .D(dest_out),
        .Q(wr_rst_rd_ext[0]));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_rd_ext_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(rst_rd_reg2),
        .D(wr_rst_rd_ext[0]),
        .Q(wr_rst_rd_ext[1]));
  (* DEST_SYNC_FF = "4" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SRC_INPUT_REG = "0" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SINGLE" *) 
  (* XPM_MODULE = "TRUE" *) 
  XGMII_FIFO_DUAL_SYNC_xpm_cdc_single \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr 
       (.dest_clk(wr_clk),
        .dest_out(sckt_rd_rst_wr),
        .src_clk(rd_clk),
        .src_in(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ));
  (* DEST_SYNC_FF = "4" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SRC_INPUT_REG = "0" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SINGLE" *) 
  (* XPM_MODULE = "TRUE" *) 
  XGMII_FIFO_DUAL_SYNC_xpm_cdc_single__2 \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd 
       (.dest_clk(rd_clk),
        .dest_out(dest_out),
        .src_clk(wr_clk),
        .src_in(AR));
  (* DEF_VAL = "1'b0" *) 
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* INV_DEF_VAL = "1'b1" *) 
  (* RST_ACTIVE_HIGH = "1" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  (* XPM_MODULE = "TRUE" *) 
  XGMII_FIFO_DUAL_SYNC_xpm_cdc_async_rst__2 \ngwrdrst.grst.g7serrst.gnsckt_wrst.rst_wr_reg2_inst 
       (.dest_arst(rst_wr_reg2),
        .dest_clk(wr_clk),
        .src_arst(rst));
endmodule

(* ORIG_REF_NAME = "wr_bin_cntr" *) 
module XGMII_FIFO_DUAL_SYNC_wr_bin_cntr
   (\grstd1.grst_full.grst_f.rst_d3_reg ,
    Q,
    \gic0.gc0.count_d1_reg[1]_0 ,
    \gic0.gc0.count_d2_reg[4]_0 ,
    ram_full_i_reg,
    E,
    ram_full_i_reg_0,
    ram_full_i_reg_1,
    RD_PNTR_WR,
    wr_clk,
    AR);
  output \grstd1.grst_full.grst_f.rst_d3_reg ;
  output [1:0]Q;
  output [1:0]\gic0.gc0.count_d1_reg[1]_0 ;
  output [4:0]\gic0.gc0.count_d2_reg[4]_0 ;
  input ram_full_i_reg;
  input [0:0]E;
  input ram_full_i_reg_0;
  input ram_full_i_reg_1;
  input [2:0]RD_PNTR_WR;
  input wr_clk;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [1:0]Q;
  wire [2:0]RD_PNTR_WR;
  wire [1:0]\gic0.gc0.count_d1_reg[1]_0 ;
  wire [4:0]\gic0.gc0.count_d2_reg[4]_0 ;
  wire \grstd1.grst_full.grst_f.rst_d3_reg ;
  wire [4:2]p_14_out;
  wire [4:0]plusOp;
  wire ram_full_i_i_2_n_0;
  wire ram_full_i_i_5_n_0;
  wire ram_full_i_reg;
  wire ram_full_i_reg_0;
  wire ram_full_i_reg_1;
  wire wr_clk;
  wire [4:2]wr_pntr_plus2;

  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \gic0.gc0.count[0]_i_1 
       (.I0(Q[0]),
        .O(plusOp[0]));
  LUT2 #(
    .INIT(4'h6)) 
    \gic0.gc0.count[1]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \gic0.gc0.count[2]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(wr_pntr_plus2[2]),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \gic0.gc0.count[3]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(wr_pntr_plus2[2]),
        .I3(wr_pntr_plus2[3]),
        .O(plusOp[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \gic0.gc0.count[4]_i_1 
       (.I0(wr_pntr_plus2[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(wr_pntr_plus2[3]),
        .I4(wr_pntr_plus2[4]),
        .O(plusOp[4]));
  FDPE #(
    .INIT(1'b1)) 
    \gic0.gc0.count_d1_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .D(Q[0]),
        .PRE(AR),
        .Q(\gic0.gc0.count_d1_reg[1]_0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(Q[1]),
        .Q(\gic0.gc0.count_d1_reg[1]_0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(wr_pntr_plus2[2]),
        .Q(p_14_out[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(wr_pntr_plus2[3]),
        .Q(p_14_out[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(wr_pntr_plus2[4]),
        .Q(p_14_out[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(\gic0.gc0.count_d1_reg[1]_0 [0]),
        .Q(\gic0.gc0.count_d2_reg[4]_0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(\gic0.gc0.count_d1_reg[1]_0 [1]),
        .Q(\gic0.gc0.count_d2_reg[4]_0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(p_14_out[2]),
        .Q(\gic0.gc0.count_d2_reg[4]_0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(p_14_out[3]),
        .Q(\gic0.gc0.count_d2_reg[4]_0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(p_14_out[4]),
        .Q(\gic0.gc0.count_d2_reg[4]_0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp[0]),
        .Q(Q[0]));
  FDPE #(
    .INIT(1'b1)) 
    \gic0.gc0.count_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .D(plusOp[1]),
        .PRE(AR),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp[2]),
        .Q(wr_pntr_plus2[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp[3]),
        .Q(wr_pntr_plus2[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp[4]),
        .Q(wr_pntr_plus2[4]));
  LUT6 #(
    .INIT(64'h00000000FF808080)) 
    ram_full_i_i_1
       (.I0(ram_full_i_i_2_n_0),
        .I1(ram_full_i_reg),
        .I2(E),
        .I3(ram_full_i_reg_0),
        .I4(ram_full_i_i_5_n_0),
        .I5(ram_full_i_reg_1),
        .O(\grstd1.grst_full.grst_f.rst_d3_reg ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    ram_full_i_i_2
       (.I0(wr_pntr_plus2[3]),
        .I1(RD_PNTR_WR[1]),
        .I2(wr_pntr_plus2[2]),
        .I3(RD_PNTR_WR[0]),
        .I4(RD_PNTR_WR[2]),
        .I5(wr_pntr_plus2[4]),
        .O(ram_full_i_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    ram_full_i_i_5
       (.I0(p_14_out[3]),
        .I1(RD_PNTR_WR[1]),
        .I2(p_14_out[2]),
        .I3(RD_PNTR_WR[0]),
        .I4(RD_PNTR_WR[2]),
        .I5(p_14_out[4]),
        .O(ram_full_i_i_5_n_0));
endmodule

(* ORIG_REF_NAME = "wr_logic" *) 
module XGMII_FIFO_DUAL_SYNC_wr_logic
   (full,
    E,
    Q,
    \gic0.gc0.count_d1_reg[1] ,
    \gic0.gc0.count_d2_reg[4] ,
    wr_clk,
    out,
    ram_full_i_reg,
    ram_full_i_reg_0,
    ram_full_i_reg_1,
    wr_en,
    RD_PNTR_WR,
    AR);
  output full;
  output [0:0]E;
  output [1:0]Q;
  output [1:0]\gic0.gc0.count_d1_reg[1] ;
  output [4:0]\gic0.gc0.count_d2_reg[4] ;
  input wr_clk;
  input out;
  input ram_full_i_reg;
  input ram_full_i_reg_0;
  input ram_full_i_reg_1;
  input wr_en;
  input [2:0]RD_PNTR_WR;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [1:0]Q;
  wire [2:0]RD_PNTR_WR;
  wire full;
  wire [1:0]\gic0.gc0.count_d1_reg[1] ;
  wire [4:0]\gic0.gc0.count_d2_reg[4] ;
  wire out;
  wire ram_full_i_reg;
  wire ram_full_i_reg_0;
  wire ram_full_i_reg_1;
  wire wpntr_n_0;
  wire wr_clk;
  wire wr_en;

  XGMII_FIFO_DUAL_SYNC_wr_status_flags_as \gwas.wsts 
       (.E(E),
        .full(full),
        .out(out),
        .ram_full_i_reg_0(wpntr_n_0),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
  XGMII_FIFO_DUAL_SYNC_wr_bin_cntr wpntr
       (.AR(AR),
        .E(E),
        .Q(Q),
        .RD_PNTR_WR(RD_PNTR_WR),
        .\gic0.gc0.count_d1_reg[1]_0 (\gic0.gc0.count_d1_reg[1] ),
        .\gic0.gc0.count_d2_reg[4]_0 (\gic0.gc0.count_d2_reg[4] ),
        .\grstd1.grst_full.grst_f.rst_d3_reg (wpntr_n_0),
        .ram_full_i_reg(ram_full_i_reg),
        .ram_full_i_reg_0(ram_full_i_reg_0),
        .ram_full_i_reg_1(ram_full_i_reg_1),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "wr_status_flags_as" *) 
module XGMII_FIFO_DUAL_SYNC_wr_status_flags_as
   (full,
    E,
    ram_full_i_reg_0,
    wr_clk,
    out,
    wr_en);
  output full;
  output [0:0]E;
  input ram_full_i_reg_0;
  input wr_clk;
  input out;
  input wr_en;

  wire [0:0]E;
  wire out;
  (* DONT_TOUCH *) wire ram_full_fb_i;
  (* DONT_TOUCH *) wire ram_full_i;
  wire ram_full_i_reg_0;
  wire wr_clk;
  wire wr_en;

  assign full = ram_full_i;
  LUT2 #(
    .INIT(4'h2)) 
    \gic0.gc0.count_d1[4]_i_1 
       (.I0(wr_en),
        .I1(ram_full_fb_i),
        .O(E));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_full_fb_i_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_full_i_reg_0),
        .PRE(out),
        .Q(ram_full_fb_i));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_full_i_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_full_i_reg_0),
        .PRE(out),
        .Q(ram_full_i));
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

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
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
