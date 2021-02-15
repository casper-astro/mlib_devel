// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1.1 (lin64) Build 2580384 Sat Jun 29 08:04:45 MDT 2019
// Date        : Mon Jul 15 17:26:03 2019
// Host        : casper1 running 64-bit Ubuntu 16.04.6 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/hpw1/work/tutorials_devel/vivado_2018/skarab/tut_intro/skarab_tut_intro/myproj/myproj.srcs/sources_1/ip/tx_fifo_ext/tx_fifo_ext_sim_netlist.v
// Design      : tx_fifo_ext
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "tx_fifo_ext,fifo_generator_v13_2_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v13_2_4,Vivado 2019.1.1" *) 
(* NotValidForBitStream *)
module tx_fifo_ext
   (clk,
    rst,
    din,
    wr_en,
    rd_en,
    dout,
    full,
    empty,
    prog_full);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 core_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME core_clk, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input clk;
  input rst;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_DATA" *) input [63:0]din;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *) input wr_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *) input rd_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_DATA" *) output [63:0]dout;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *) output full;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ EMPTY" *) output empty;
  output prog_full;

  wire clk;
  wire [63:0]din;
  wire [63:0]dout;
  wire empty;
  wire full;
  wire prog_full;
  wire rd_en;
  wire rst;
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
  wire [6:0]NLW_U0_data_count_UNCONNECTED;
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
  wire [6:0]NLW_U0_rd_data_count_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_buser_UNCONNECTED;
  wire [63:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_ruser_UNCONNECTED;
  wire [6:0]NLW_U0_wr_data_count_UNCONNECTED;

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
  (* C_COMMON_CLOCK = "1" *) 
  (* C_COUNT_TYPE = "0" *) 
  (* C_DATA_COUNT_WIDTH = "7" *) 
  (* C_DEFAULT_VALUE = "BlankString" *) 
  (* C_DIN_WIDTH = "64" *) 
  (* C_DIN_WIDTH_AXIS = "1" *) 
  (* C_DIN_WIDTH_RACH = "32" *) 
  (* C_DIN_WIDTH_RDCH = "64" *) 
  (* C_DIN_WIDTH_WACH = "1" *) 
  (* C_DIN_WIDTH_WDCH = "64" *) 
  (* C_DIN_WIDTH_WRCH = "2" *) 
  (* C_DOUT_RST_VAL = "0" *) 
  (* C_DOUT_WIDTH = "64" *) 
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
  (* C_IMPLEMENTATION_TYPE = "0" *) 
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
  (* C_PRELOAD_LATENCY = "0" *) 
  (* C_PRELOAD_REGS = "1" *) 
  (* C_PRIM_FIFO_TYPE = "512x72" *) 
  (* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) 
  (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) 
  (* C_PRIM_FIFO_TYPE_WACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) 
  (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL = "4" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "5" *) 
  (* C_PROG_EMPTY_TYPE = "0" *) 
  (* C_PROG_EMPTY_TYPE_AXIS = "0" *) 
  (* C_PROG_EMPTY_TYPE_RACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL = "62" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
  (* C_PROG_FULL_THRESH_NEGATE_VAL = "61" *) 
  (* C_PROG_FULL_TYPE = "1" *) 
  (* C_PROG_FULL_TYPE_AXIS = "0" *) 
  (* C_PROG_FULL_TYPE_RACH = "0" *) 
  (* C_PROG_FULL_TYPE_RDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WACH = "0" *) 
  (* C_PROG_FULL_TYPE_WDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WRCH = "0" *) 
  (* C_RACH_TYPE = "0" *) 
  (* C_RDCH_TYPE = "0" *) 
  (* C_RD_DATA_COUNT_WIDTH = "7" *) 
  (* C_RD_DEPTH = "64" *) 
  (* C_RD_FREQ = "1" *) 
  (* C_RD_PNTR_WIDTH = "6" *) 
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
  (* C_USE_FWFT_DATA_COUNT = "1" *) 
  (* C_USE_PIPELINE_REG = "0" *) 
  (* C_VALID_LOW = "0" *) 
  (* C_WACH_TYPE = "0" *) 
  (* C_WDCH_TYPE = "0" *) 
  (* C_WRCH_TYPE = "0" *) 
  (* C_WR_ACK_LOW = "0" *) 
  (* C_WR_DATA_COUNT_WIDTH = "7" *) 
  (* C_WR_DEPTH = "64" *) 
  (* C_WR_DEPTH_AXIS = "1024" *) 
  (* C_WR_DEPTH_RACH = "16" *) 
  (* C_WR_DEPTH_RDCH = "1024" *) 
  (* C_WR_DEPTH_WACH = "16" *) 
  (* C_WR_DEPTH_WDCH = "1024" *) 
  (* C_WR_DEPTH_WRCH = "16" *) 
  (* C_WR_FREQ = "1" *) 
  (* C_WR_PNTR_WIDTH = "6" *) 
  (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
  (* C_WR_PNTR_WIDTH_RACH = "4" *) 
  (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WACH = "4" *) 
  (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
  (* C_WR_RESPONSE_LATENCY = "1" *) 
  tx_fifo_ext_fifo_generator_v13_2_4 U0
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
        .clk(clk),
        .data_count(NLW_U0_data_count_UNCONNECTED[6:0]),
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
        .prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full(prog_full),
        .prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .rd_clk(1'b0),
        .rd_data_count(NLW_U0_rd_data_count_UNCONNECTED[6:0]),
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
        .wr_clk(1'b0),
        .wr_data_count(NLW_U0_wr_data_count_UNCONNECTED[6:0]),
        .wr_en(wr_en),
        .wr_rst(1'b0),
        .wr_rst_busy(NLW_U0_wr_rst_busy_UNCONNECTED));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) 
(* INV_DEF_VAL = "1'b1" *) (* ORIG_REF_NAME = "xpm_cdc_async_rst" *) (* RST_ACTIVE_HIGH = "1" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* xpm_cdc = "ASYNC_RST" *) 
module tx_fifo_ext_xpm_cdc_async_rst
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

(* ORIG_REF_NAME = "dmem" *) 
module tx_fifo_ext_dmem
   (\gpr1.dout_i_reg[63]_0 ,
    clk,
    din,
    E,
    Q,
    \gpr1.dout_i_reg[0]_0 ,
    \gpr1.dout_i_reg[0]_1 ,
    AR);
  output [63:0]\gpr1.dout_i_reg[63]_0 ;
  input clk;
  input [63:0]din;
  input [0:0]E;
  input [5:0]Q;
  input [5:0]\gpr1.dout_i_reg[0]_0 ;
  input [0:0]\gpr1.dout_i_reg[0]_1 ;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [5:0]Q;
  wire clk;
  wire [63:0]din;
  wire [5:0]\gpr1.dout_i_reg[0]_0 ;
  wire [0:0]\gpr1.dout_i_reg[0]_1 ;
  wire [63:0]\gpr1.dout_i_reg[63]_0 ;
  wire [63:0]p_0_out;
  wire NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_12_14_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_15_17_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_18_20_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_21_23_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_24_26_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_27_29_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_30_32_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_33_35_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_36_38_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_39_41_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_3_5_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_42_44_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_45_47_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_48_50_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_51_53_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_54_56_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_57_59_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_60_62_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_63_63_DOB_UNCONNECTED;
  wire NLW_RAM_reg_0_63_63_63_DOC_UNCONNECTED;
  wire NLW_RAM_reg_0_63_63_63_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED;

  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "2" *) 
  RAM64M RAM_reg_0_63_0_2
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[0]),
        .DIB(din[1]),
        .DIC(din[2]),
        .DID(1'b0),
        .DOA(p_0_out[0]),
        .DOB(p_0_out[1]),
        .DOC(p_0_out[2]),
        .DOD(NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "14" *) 
  RAM64M RAM_reg_0_63_12_14
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[12]),
        .DIB(din[13]),
        .DIC(din[14]),
        .DID(1'b0),
        .DOA(p_0_out[12]),
        .DOB(p_0_out[13]),
        .DOC(p_0_out[14]),
        .DOD(NLW_RAM_reg_0_63_12_14_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "17" *) 
  RAM64M RAM_reg_0_63_15_17
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[15]),
        .DIB(din[16]),
        .DIC(din[17]),
        .DID(1'b0),
        .DOA(p_0_out[15]),
        .DOB(p_0_out[16]),
        .DOC(p_0_out[17]),
        .DOD(NLW_RAM_reg_0_63_15_17_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "20" *) 
  RAM64M RAM_reg_0_63_18_20
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[18]),
        .DIB(din[19]),
        .DIC(din[20]),
        .DID(1'b0),
        .DOA(p_0_out[18]),
        .DOB(p_0_out[19]),
        .DOC(p_0_out[20]),
        .DOD(NLW_RAM_reg_0_63_18_20_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "23" *) 
  RAM64M RAM_reg_0_63_21_23
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[21]),
        .DIB(din[22]),
        .DIC(din[23]),
        .DID(1'b0),
        .DOA(p_0_out[21]),
        .DOB(p_0_out[22]),
        .DOC(p_0_out[23]),
        .DOD(NLW_RAM_reg_0_63_21_23_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "26" *) 
  RAM64M RAM_reg_0_63_24_26
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[24]),
        .DIB(din[25]),
        .DIC(din[26]),
        .DID(1'b0),
        .DOA(p_0_out[24]),
        .DOB(p_0_out[25]),
        .DOC(p_0_out[26]),
        .DOD(NLW_RAM_reg_0_63_24_26_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "29" *) 
  RAM64M RAM_reg_0_63_27_29
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[27]),
        .DIB(din[28]),
        .DIC(din[29]),
        .DID(1'b0),
        .DOA(p_0_out[27]),
        .DOB(p_0_out[28]),
        .DOC(p_0_out[29]),
        .DOD(NLW_RAM_reg_0_63_27_29_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "32" *) 
  RAM64M RAM_reg_0_63_30_32
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[30]),
        .DIB(din[31]),
        .DIC(din[32]),
        .DID(1'b0),
        .DOA(p_0_out[30]),
        .DOB(p_0_out[31]),
        .DOC(p_0_out[32]),
        .DOD(NLW_RAM_reg_0_63_30_32_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "33" *) 
  (* ram_slice_end = "35" *) 
  RAM64M RAM_reg_0_63_33_35
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[33]),
        .DIB(din[34]),
        .DIC(din[35]),
        .DID(1'b0),
        .DOA(p_0_out[33]),
        .DOB(p_0_out[34]),
        .DOC(p_0_out[35]),
        .DOD(NLW_RAM_reg_0_63_33_35_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "36" *) 
  (* ram_slice_end = "38" *) 
  RAM64M RAM_reg_0_63_36_38
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[36]),
        .DIB(din[37]),
        .DIC(din[38]),
        .DID(1'b0),
        .DOA(p_0_out[36]),
        .DOB(p_0_out[37]),
        .DOC(p_0_out[38]),
        .DOD(NLW_RAM_reg_0_63_36_38_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "39" *) 
  (* ram_slice_end = "41" *) 
  RAM64M RAM_reg_0_63_39_41
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[39]),
        .DIB(din[40]),
        .DIC(din[41]),
        .DID(1'b0),
        .DOA(p_0_out[39]),
        .DOB(p_0_out[40]),
        .DOC(p_0_out[41]),
        .DOD(NLW_RAM_reg_0_63_39_41_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "5" *) 
  RAM64M RAM_reg_0_63_3_5
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[3]),
        .DIB(din[4]),
        .DIC(din[5]),
        .DID(1'b0),
        .DOA(p_0_out[3]),
        .DOB(p_0_out[4]),
        .DOC(p_0_out[5]),
        .DOD(NLW_RAM_reg_0_63_3_5_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "42" *) 
  (* ram_slice_end = "44" *) 
  RAM64M RAM_reg_0_63_42_44
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[42]),
        .DIB(din[43]),
        .DIC(din[44]),
        .DID(1'b0),
        .DOA(p_0_out[42]),
        .DOB(p_0_out[43]),
        .DOC(p_0_out[44]),
        .DOD(NLW_RAM_reg_0_63_42_44_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "45" *) 
  (* ram_slice_end = "47" *) 
  RAM64M RAM_reg_0_63_45_47
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[45]),
        .DIB(din[46]),
        .DIC(din[47]),
        .DID(1'b0),
        .DOA(p_0_out[45]),
        .DOB(p_0_out[46]),
        .DOC(p_0_out[47]),
        .DOD(NLW_RAM_reg_0_63_45_47_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "48" *) 
  (* ram_slice_end = "50" *) 
  RAM64M RAM_reg_0_63_48_50
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[48]),
        .DIB(din[49]),
        .DIC(din[50]),
        .DID(1'b0),
        .DOA(p_0_out[48]),
        .DOB(p_0_out[49]),
        .DOC(p_0_out[50]),
        .DOD(NLW_RAM_reg_0_63_48_50_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "51" *) 
  (* ram_slice_end = "53" *) 
  RAM64M RAM_reg_0_63_51_53
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[51]),
        .DIB(din[52]),
        .DIC(din[53]),
        .DID(1'b0),
        .DOA(p_0_out[51]),
        .DOB(p_0_out[52]),
        .DOC(p_0_out[53]),
        .DOD(NLW_RAM_reg_0_63_51_53_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "54" *) 
  (* ram_slice_end = "56" *) 
  RAM64M RAM_reg_0_63_54_56
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[54]),
        .DIB(din[55]),
        .DIC(din[56]),
        .DID(1'b0),
        .DOA(p_0_out[54]),
        .DOB(p_0_out[55]),
        .DOC(p_0_out[56]),
        .DOD(NLW_RAM_reg_0_63_54_56_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "57" *) 
  (* ram_slice_end = "59" *) 
  RAM64M RAM_reg_0_63_57_59
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[57]),
        .DIB(din[58]),
        .DIC(din[59]),
        .DID(1'b0),
        .DOA(p_0_out[57]),
        .DOB(p_0_out[58]),
        .DOC(p_0_out[59]),
        .DOD(NLW_RAM_reg_0_63_57_59_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "60" *) 
  (* ram_slice_end = "62" *) 
  RAM64M RAM_reg_0_63_60_62
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[60]),
        .DIB(din[61]),
        .DIC(din[62]),
        .DID(1'b0),
        .DOA(p_0_out[60]),
        .DOB(p_0_out[61]),
        .DOC(p_0_out[62]),
        .DOD(NLW_RAM_reg_0_63_60_62_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "63" *) 
  (* ram_slice_end = "63" *) 
  RAM64M RAM_reg_0_63_63_63
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[63]),
        .DIB(1'b0),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(p_0_out[63]),
        .DOB(NLW_RAM_reg_0_63_63_63_DOB_UNCONNECTED),
        .DOC(NLW_RAM_reg_0_63_63_63_DOC_UNCONNECTED),
        .DOD(NLW_RAM_reg_0_63_63_63_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "8" *) 
  RAM64M RAM_reg_0_63_6_8
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[6]),
        .DIB(din[7]),
        .DIC(din[8]),
        .DID(1'b0),
        .DOA(p_0_out[6]),
        .DOB(p_0_out[7]),
        .DOC(p_0_out[8]),
        .DOD(NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "11" *) 
  RAM64M RAM_reg_0_63_9_11
       (.ADDRA(Q),
        .ADDRB(Q),
        .ADDRC(Q),
        .ADDRD(\gpr1.dout_i_reg[0]_0 ),
        .DIA(din[9]),
        .DIB(din[10]),
        .DIC(din[11]),
        .DID(1'b0),
        .DOA(p_0_out[9]),
        .DOB(p_0_out[10]),
        .DOC(p_0_out[11]),
        .DOD(NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(E));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[0] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[0]),
        .Q(\gpr1.dout_i_reg[63]_0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[10] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[10]),
        .Q(\gpr1.dout_i_reg[63]_0 [10]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[11] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[11]),
        .Q(\gpr1.dout_i_reg[63]_0 [11]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[12] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[12]),
        .Q(\gpr1.dout_i_reg[63]_0 [12]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[13] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[13]),
        .Q(\gpr1.dout_i_reg[63]_0 [13]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[14] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[14]),
        .Q(\gpr1.dout_i_reg[63]_0 [14]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[15] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[15]),
        .Q(\gpr1.dout_i_reg[63]_0 [15]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[16] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[16]),
        .Q(\gpr1.dout_i_reg[63]_0 [16]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[17] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[17]),
        .Q(\gpr1.dout_i_reg[63]_0 [17]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[18] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[18]),
        .Q(\gpr1.dout_i_reg[63]_0 [18]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[19] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[19]),
        .Q(\gpr1.dout_i_reg[63]_0 [19]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[1] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[1]),
        .Q(\gpr1.dout_i_reg[63]_0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[20] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[20]),
        .Q(\gpr1.dout_i_reg[63]_0 [20]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[21] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[21]),
        .Q(\gpr1.dout_i_reg[63]_0 [21]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[22] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[22]),
        .Q(\gpr1.dout_i_reg[63]_0 [22]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[23] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[23]),
        .Q(\gpr1.dout_i_reg[63]_0 [23]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[24] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[24]),
        .Q(\gpr1.dout_i_reg[63]_0 [24]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[25] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[25]),
        .Q(\gpr1.dout_i_reg[63]_0 [25]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[26] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[26]),
        .Q(\gpr1.dout_i_reg[63]_0 [26]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[27] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[27]),
        .Q(\gpr1.dout_i_reg[63]_0 [27]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[28] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[28]),
        .Q(\gpr1.dout_i_reg[63]_0 [28]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[29] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[29]),
        .Q(\gpr1.dout_i_reg[63]_0 [29]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[2] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[2]),
        .Q(\gpr1.dout_i_reg[63]_0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[30] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[30]),
        .Q(\gpr1.dout_i_reg[63]_0 [30]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[31] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[31]),
        .Q(\gpr1.dout_i_reg[63]_0 [31]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[32] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[32]),
        .Q(\gpr1.dout_i_reg[63]_0 [32]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[33] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[33]),
        .Q(\gpr1.dout_i_reg[63]_0 [33]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[34] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[34]),
        .Q(\gpr1.dout_i_reg[63]_0 [34]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[35] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[35]),
        .Q(\gpr1.dout_i_reg[63]_0 [35]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[36] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[36]),
        .Q(\gpr1.dout_i_reg[63]_0 [36]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[37] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[37]),
        .Q(\gpr1.dout_i_reg[63]_0 [37]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[38] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[38]),
        .Q(\gpr1.dout_i_reg[63]_0 [38]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[39] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[39]),
        .Q(\gpr1.dout_i_reg[63]_0 [39]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[3] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[3]),
        .Q(\gpr1.dout_i_reg[63]_0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[40] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[40]),
        .Q(\gpr1.dout_i_reg[63]_0 [40]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[41] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[41]),
        .Q(\gpr1.dout_i_reg[63]_0 [41]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[42] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[42]),
        .Q(\gpr1.dout_i_reg[63]_0 [42]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[43] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[43]),
        .Q(\gpr1.dout_i_reg[63]_0 [43]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[44] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[44]),
        .Q(\gpr1.dout_i_reg[63]_0 [44]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[45] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[45]),
        .Q(\gpr1.dout_i_reg[63]_0 [45]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[46] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[46]),
        .Q(\gpr1.dout_i_reg[63]_0 [46]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[47] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[47]),
        .Q(\gpr1.dout_i_reg[63]_0 [47]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[48] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[48]),
        .Q(\gpr1.dout_i_reg[63]_0 [48]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[49] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[49]),
        .Q(\gpr1.dout_i_reg[63]_0 [49]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[4] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[4]),
        .Q(\gpr1.dout_i_reg[63]_0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[50] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[50]),
        .Q(\gpr1.dout_i_reg[63]_0 [50]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[51] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[51]),
        .Q(\gpr1.dout_i_reg[63]_0 [51]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[52] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[52]),
        .Q(\gpr1.dout_i_reg[63]_0 [52]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[53] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[53]),
        .Q(\gpr1.dout_i_reg[63]_0 [53]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[54] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[54]),
        .Q(\gpr1.dout_i_reg[63]_0 [54]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[55] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[55]),
        .Q(\gpr1.dout_i_reg[63]_0 [55]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[56] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[56]),
        .Q(\gpr1.dout_i_reg[63]_0 [56]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[57] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[57]),
        .Q(\gpr1.dout_i_reg[63]_0 [57]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[58] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[58]),
        .Q(\gpr1.dout_i_reg[63]_0 [58]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[59] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[59]),
        .Q(\gpr1.dout_i_reg[63]_0 [59]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[5] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[5]),
        .Q(\gpr1.dout_i_reg[63]_0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[60] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[60]),
        .Q(\gpr1.dout_i_reg[63]_0 [60]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[61] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[61]),
        .Q(\gpr1.dout_i_reg[63]_0 [61]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[62] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[62]),
        .Q(\gpr1.dout_i_reg[63]_0 [62]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[63] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[63]),
        .Q(\gpr1.dout_i_reg[63]_0 [63]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[6] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[6]),
        .Q(\gpr1.dout_i_reg[63]_0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[7] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[7]),
        .Q(\gpr1.dout_i_reg[63]_0 [7]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[8] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[8]),
        .Q(\gpr1.dout_i_reg[63]_0 [8]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[9] 
       (.C(clk),
        .CE(\gpr1.dout_i_reg[0]_1 ),
        .CLR(AR),
        .D(p_0_out[9]),
        .Q(\gpr1.dout_i_reg[63]_0 [9]));
endmodule

(* ORIG_REF_NAME = "fifo_generator_ramfifo" *) 
module tx_fifo_ext_fifo_generator_ramfifo
   (empty,
    full,
    wr_rst_busy,
    dout,
    prog_full,
    rst,
    clk,
    din,
    rd_en,
    wr_en);
  output empty;
  output full;
  output wr_rst_busy;
  output [63:0]dout;
  output prog_full;
  input rst;
  input clk;
  input [63:0]din;
  input rd_en;
  input wr_en;

  wire clk;
  wire [63:0]din;
  wire [63:0]dout;
  wire empty;
  wire full;
  wire \gntv_or_sync_fifo.gl0.rd_n_1 ;
  wire \gntv_or_sync_fifo.gl0.rd_n_11 ;
  wire \gntv_or_sync_fifo.gl0.rd_n_12 ;
  wire \gntv_or_sync_fifo.gl0.rd_n_2 ;
  wire \gntv_or_sync_fifo.gl0.rd_n_3 ;
  wire \gntv_or_sync_fifo.gl0.rd_n_4 ;
  wire \gntv_or_sync_fifo.gl0.wr_n_0 ;
  wire \gwss.gpf.wrpf/p_3_out ;
  wire \gwss.wsts/ram_full_comb ;
  wire [5:0]p_0_out_0;
  wire [5:0]p_12_out;
  wire [5:0]p_13_out;
  wire p_19_out;
  wire p_6_out;
  wire p_8_out;
  wire prog_full;
  wire ram_rd_en_i;
  wire rd_en;
  wire rst;
  wire rst_full_ff_i;
  wire rst_full_gen_i;
  wire rstblk_n_3;
  wire wr_en;
  wire wr_rst_busy;

  tx_fifo_ext_rd_logic \gntv_or_sync_fifo.gl0.rd 
       (.E(ram_rd_en_i),
        .Q(p_0_out_0),
        .S({\gntv_or_sync_fifo.gl0.rd_n_1 ,\gntv_or_sync_fifo.gl0.rd_n_2 ,\gntv_or_sync_fifo.gl0.rd_n_3 ,\gntv_or_sync_fifo.gl0.rd_n_4 }),
        .clk(clk),
        .empty(empty),
        .\gc0.count_d1_reg[0] (rstblk_n_3),
        .\gc0.count_d1_reg[5] ({\gntv_or_sync_fifo.gl0.rd_n_11 ,\gntv_or_sync_fifo.gl0.rd_n_12 }),
        .\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] (p_13_out),
        .\gpregsm1.curr_fwft_state_reg[1] (p_6_out),
        .out(rst_full_gen_i),
        .p_3_out(\gwss.gpf.wrpf/p_3_out ),
        .ram_empty_fb_i_i_3(p_12_out),
        .ram_empty_fb_i_reg(p_8_out),
        .ram_empty_fb_i_reg_0(\gntv_or_sync_fifo.gl0.wr_n_0 ),
        .ram_full_comb(\gwss.wsts/ram_full_comb ),
        .rd_en(rd_en),
        .wr_en(wr_en));
  tx_fifo_ext_wr_logic \gntv_or_sync_fifo.gl0.wr 
       (.AR(rstblk_n_3),
        .E(p_19_out),
        .Q(p_13_out),
        .S({\gntv_or_sync_fifo.gl0.rd_n_1 ,\gntv_or_sync_fifo.gl0.rd_n_2 ,\gntv_or_sync_fifo.gl0.rd_n_3 ,\gntv_or_sync_fifo.gl0.rd_n_4 }),
        .clk(clk),
        .full(full),
        .\gcc0.gc0.count_d1_reg[5] (p_12_out),
        .\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ({\gntv_or_sync_fifo.gl0.rd_n_11 ,\gntv_or_sync_fifo.gl0.rd_n_12 }),
        .\gpfs.prog_full_i_reg (rst_full_gen_i),
        .\greg.ram_rd_en_i_reg (p_8_out),
        .out(\gntv_or_sync_fifo.gl0.wr_n_0 ),
        .p_3_out(\gwss.gpf.wrpf/p_3_out ),
        .prog_full(prog_full),
        .ram_full_comb(\gwss.wsts/ram_full_comb ),
        .ram_full_i_reg(rst_full_ff_i),
        .wr_en(wr_en));
  tx_fifo_ext_memory \gntv_or_sync_fifo.mem 
       (.AR(rstblk_n_3),
        .E(p_19_out),
        .Q(p_0_out_0),
        .clk(clk),
        .din(din),
        .dout(dout),
        .\goreg_dm.dout_i_reg[63]_0 (p_6_out),
        .\gpr1.dout_i_reg[0] (p_12_out),
        .\gpr1.dout_i_reg[0]_0 (ram_rd_en_i));
  tx_fifo_ext_reset_blk_ramfifo rstblk
       (.AR(rstblk_n_3),
        .clk(clk),
        .\grstd1.grst_full.grst_f.rst_d3_reg_0 (rst_full_gen_i),
        .out(rst_full_ff_i),
        .rst(rst),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* ORIG_REF_NAME = "fifo_generator_top" *) 
module tx_fifo_ext_fifo_generator_top
   (empty,
    full,
    wr_rst_busy,
    dout,
    prog_full,
    rst,
    clk,
    din,
    rd_en,
    wr_en);
  output empty;
  output full;
  output wr_rst_busy;
  output [63:0]dout;
  output prog_full;
  input rst;
  input clk;
  input [63:0]din;
  input rd_en;
  input wr_en;

  wire clk;
  wire [63:0]din;
  wire [63:0]dout;
  wire empty;
  wire full;
  wire prog_full;
  wire rd_en;
  wire rst;
  wire wr_en;
  wire wr_rst_busy;

  tx_fifo_ext_fifo_generator_ramfifo \grf.rf 
       (.clk(clk),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_full(prog_full),
        .rd_en(rd_en),
        .rst(rst),
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
(* C_AXI_WUSER_WIDTH = "1" *) (* C_COMMON_CLOCK = "1" *) (* C_COUNT_TYPE = "0" *) 
(* C_DATA_COUNT_WIDTH = "7" *) (* C_DEFAULT_VALUE = "BlankString" *) (* C_DIN_WIDTH = "64" *) 
(* C_DIN_WIDTH_AXIS = "1" *) (* C_DIN_WIDTH_RACH = "32" *) (* C_DIN_WIDTH_RDCH = "64" *) 
(* C_DIN_WIDTH_WACH = "1" *) (* C_DIN_WIDTH_WDCH = "64" *) (* C_DIN_WIDTH_WRCH = "2" *) 
(* C_DOUT_RST_VAL = "0" *) (* C_DOUT_WIDTH = "64" *) (* C_ENABLE_RLOCS = "0" *) 
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
(* C_IMPLEMENTATION_TYPE = "0" *) (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
(* C_IMPLEMENTATION_TYPE_RDCH = "1" *) (* C_IMPLEMENTATION_TYPE_WACH = "1" *) (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
(* C_IMPLEMENTATION_TYPE_WRCH = "1" *) (* C_INIT_WR_PNTR_VAL = "0" *) (* C_INTERFACE_TYPE = "0" *) 
(* C_MEMORY_TYPE = "2" *) (* C_MIF_FILE_NAME = "BlankString" *) (* C_MSGON_VAL = "1" *) 
(* C_OPTIMIZATION_MODE = "0" *) (* C_OVERFLOW_LOW = "0" *) (* C_POWER_SAVING_MODE = "0" *) 
(* C_PRELOAD_LATENCY = "0" *) (* C_PRELOAD_REGS = "1" *) (* C_PRIM_FIFO_TYPE = "512x72" *) 
(* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) 
(* C_PRIM_FIFO_TYPE_WACH = "512x36" *) (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL = "4" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "5" *) (* C_PROG_EMPTY_TYPE = "0" *) 
(* C_PROG_EMPTY_TYPE_AXIS = "0" *) (* C_PROG_EMPTY_TYPE_RACH = "0" *) (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
(* C_PROG_EMPTY_TYPE_WACH = "0" *) (* C_PROG_EMPTY_TYPE_WDCH = "0" *) (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL = "62" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) (* C_PROG_FULL_THRESH_NEGATE_VAL = "61" *) (* C_PROG_FULL_TYPE = "1" *) 
(* C_PROG_FULL_TYPE_AXIS = "0" *) (* C_PROG_FULL_TYPE_RACH = "0" *) (* C_PROG_FULL_TYPE_RDCH = "0" *) 
(* C_PROG_FULL_TYPE_WACH = "0" *) (* C_PROG_FULL_TYPE_WDCH = "0" *) (* C_PROG_FULL_TYPE_WRCH = "0" *) 
(* C_RACH_TYPE = "0" *) (* C_RDCH_TYPE = "0" *) (* C_RD_DATA_COUNT_WIDTH = "7" *) 
(* C_RD_DEPTH = "64" *) (* C_RD_FREQ = "1" *) (* C_RD_PNTR_WIDTH = "6" *) 
(* C_REG_SLICE_MODE_AXIS = "0" *) (* C_REG_SLICE_MODE_RACH = "0" *) (* C_REG_SLICE_MODE_RDCH = "0" *) 
(* C_REG_SLICE_MODE_WACH = "0" *) (* C_REG_SLICE_MODE_WDCH = "0" *) (* C_REG_SLICE_MODE_WRCH = "0" *) 
(* C_SELECT_XPM = "0" *) (* C_SYNCHRONIZER_STAGE = "2" *) (* C_UNDERFLOW_LOW = "0" *) 
(* C_USE_COMMON_OVERFLOW = "0" *) (* C_USE_COMMON_UNDERFLOW = "0" *) (* C_USE_DEFAULT_SETTINGS = "0" *) 
(* C_USE_DOUT_RST = "1" *) (* C_USE_ECC = "0" *) (* C_USE_ECC_AXIS = "0" *) 
(* C_USE_ECC_RACH = "0" *) (* C_USE_ECC_RDCH = "0" *) (* C_USE_ECC_WACH = "0" *) 
(* C_USE_ECC_WDCH = "0" *) (* C_USE_ECC_WRCH = "0" *) (* C_USE_EMBEDDED_REG = "0" *) 
(* C_USE_FIFO16_FLAGS = "0" *) (* C_USE_FWFT_DATA_COUNT = "1" *) (* C_USE_PIPELINE_REG = "0" *) 
(* C_VALID_LOW = "0" *) (* C_WACH_TYPE = "0" *) (* C_WDCH_TYPE = "0" *) 
(* C_WRCH_TYPE = "0" *) (* C_WR_ACK_LOW = "0" *) (* C_WR_DATA_COUNT_WIDTH = "7" *) 
(* C_WR_DEPTH = "64" *) (* C_WR_DEPTH_AXIS = "1024" *) (* C_WR_DEPTH_RACH = "16" *) 
(* C_WR_DEPTH_RDCH = "1024" *) (* C_WR_DEPTH_WACH = "16" *) (* C_WR_DEPTH_WDCH = "1024" *) 
(* C_WR_DEPTH_WRCH = "16" *) (* C_WR_FREQ = "1" *) (* C_WR_PNTR_WIDTH = "6" *) 
(* C_WR_PNTR_WIDTH_AXIS = "10" *) (* C_WR_PNTR_WIDTH_RACH = "4" *) (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
(* C_WR_PNTR_WIDTH_WACH = "4" *) (* C_WR_PNTR_WIDTH_WDCH = "10" *) (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
(* C_WR_RESPONSE_LATENCY = "1" *) (* ORIG_REF_NAME = "fifo_generator_v13_2_4" *) 
module tx_fifo_ext_fifo_generator_v13_2_4
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
  input [63:0]din;
  input wr_en;
  input rd_en;
  input [5:0]prog_empty_thresh;
  input [5:0]prog_empty_thresh_assert;
  input [5:0]prog_empty_thresh_negate;
  input [5:0]prog_full_thresh;
  input [5:0]prog_full_thresh_assert;
  input [5:0]prog_full_thresh_negate;
  input int_clk;
  input injectdbiterr;
  input injectsbiterr;
  input sleep;
  output [63:0]dout;
  output full;
  output almost_full;
  output wr_ack;
  output overflow;
  output empty;
  output almost_empty;
  output valid;
  output underflow;
  output [6:0]data_count;
  output [6:0]rd_data_count;
  output [6:0]wr_data_count;
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
  wire clk;
  wire [63:0]din;
  wire [63:0]dout;
  wire empty;
  wire full;
  wire prog_full;
  wire rd_en;
  wire rst;
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
  assign data_count[6] = \<const0> ;
  assign data_count[5] = \<const0> ;
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
  assign rd_data_count[6] = \<const0> ;
  assign rd_data_count[5] = \<const0> ;
  assign rd_data_count[4] = \<const0> ;
  assign rd_data_count[3] = \<const0> ;
  assign rd_data_count[2] = \<const0> ;
  assign rd_data_count[1] = \<const0> ;
  assign rd_data_count[0] = \<const0> ;
  assign rd_rst_busy = wr_rst_busy;
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
  assign wr_data_count[6] = \<const0> ;
  assign wr_data_count[5] = \<const0> ;
  assign wr_data_count[4] = \<const0> ;
  assign wr_data_count[3] = \<const0> ;
  assign wr_data_count[2] = \<const0> ;
  assign wr_data_count[1] = \<const0> ;
  assign wr_data_count[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  tx_fifo_ext_fifo_generator_v13_2_4_synth inst_fifo_gen
       (.clk(clk),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_full(prog_full),
        .rd_en(rd_en),
        .rst(rst),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* ORIG_REF_NAME = "fifo_generator_v13_2_4_synth" *) 
module tx_fifo_ext_fifo_generator_v13_2_4_synth
   (empty,
    full,
    wr_rst_busy,
    dout,
    prog_full,
    rst,
    clk,
    din,
    rd_en,
    wr_en);
  output empty;
  output full;
  output wr_rst_busy;
  output [63:0]dout;
  output prog_full;
  input rst;
  input clk;
  input [63:0]din;
  input rd_en;
  input wr_en;

  wire clk;
  wire [63:0]din;
  wire [63:0]dout;
  wire empty;
  wire full;
  wire prog_full;
  wire rd_en;
  wire rst;
  wire wr_en;
  wire wr_rst_busy;

  tx_fifo_ext_fifo_generator_top \gconvfifo.rf 
       (.clk(clk),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_full(prog_full),
        .rd_en(rd_en),
        .rst(rst),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* ORIG_REF_NAME = "memory" *) 
module tx_fifo_ext_memory
   (dout,
    clk,
    din,
    E,
    Q,
    \gpr1.dout_i_reg[0] ,
    \gpr1.dout_i_reg[0]_0 ,
    AR,
    \goreg_dm.dout_i_reg[63]_0 );
  output [63:0]dout;
  input clk;
  input [63:0]din;
  input [0:0]E;
  input [5:0]Q;
  input [5:0]\gpr1.dout_i_reg[0] ;
  input [0:0]\gpr1.dout_i_reg[0]_0 ;
  input [0:0]AR;
  input [0:0]\goreg_dm.dout_i_reg[63]_0 ;

  wire [0:0]AR;
  wire [0:0]E;
  wire [5:0]Q;
  wire clk;
  wire [63:0]din;
  wire [63:0]dout;
  wire [63:0]dout_i;
  wire [0:0]\goreg_dm.dout_i_reg[63]_0 ;
  wire [5:0]\gpr1.dout_i_reg[0] ;
  wire [0:0]\gpr1.dout_i_reg[0]_0 ;

  tx_fifo_ext_dmem \gdm.dm_gen.dm 
       (.AR(AR),
        .E(E),
        .Q(Q),
        .clk(clk),
        .din(din),
        .\gpr1.dout_i_reg[0]_0 (\gpr1.dout_i_reg[0] ),
        .\gpr1.dout_i_reg[0]_1 (\gpr1.dout_i_reg[0]_0 ),
        .\gpr1.dout_i_reg[63]_0 (dout_i));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[0] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[0]),
        .Q(dout[0]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[10] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[10]),
        .Q(dout[10]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[11] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[11]),
        .Q(dout[11]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[12] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[12]),
        .Q(dout[12]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[13] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[13]),
        .Q(dout[13]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[14] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[14]),
        .Q(dout[14]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[15] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[15]),
        .Q(dout[15]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[16] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[16]),
        .Q(dout[16]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[17] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[17]),
        .Q(dout[17]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[18] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[18]),
        .Q(dout[18]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[19] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[19]),
        .Q(dout[19]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[1] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[1]),
        .Q(dout[1]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[20] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[20]),
        .Q(dout[20]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[21] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[21]),
        .Q(dout[21]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[22] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[22]),
        .Q(dout[22]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[23] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[23]),
        .Q(dout[23]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[24] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[24]),
        .Q(dout[24]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[25] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[25]),
        .Q(dout[25]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[26] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[26]),
        .Q(dout[26]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[27] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[27]),
        .Q(dout[27]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[28] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[28]),
        .Q(dout[28]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[29] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[29]),
        .Q(dout[29]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[2] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[2]),
        .Q(dout[2]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[30] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[30]),
        .Q(dout[30]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[31] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[31]),
        .Q(dout[31]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[32] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[32]),
        .Q(dout[32]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[33] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[33]),
        .Q(dout[33]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[34] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[34]),
        .Q(dout[34]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[35] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[35]),
        .Q(dout[35]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[36] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[36]),
        .Q(dout[36]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[37] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[37]),
        .Q(dout[37]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[38] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[38]),
        .Q(dout[38]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[39] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[39]),
        .Q(dout[39]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[3] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[3]),
        .Q(dout[3]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[40] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[40]),
        .Q(dout[40]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[41] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[41]),
        .Q(dout[41]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[42] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[42]),
        .Q(dout[42]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[43] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[43]),
        .Q(dout[43]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[44] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[44]),
        .Q(dout[44]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[45] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[45]),
        .Q(dout[45]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[46] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[46]),
        .Q(dout[46]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[47] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[47]),
        .Q(dout[47]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[48] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[48]),
        .Q(dout[48]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[49] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[49]),
        .Q(dout[49]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[4] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[4]),
        .Q(dout[4]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[50] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[50]),
        .Q(dout[50]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[51] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[51]),
        .Q(dout[51]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[52] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[52]),
        .Q(dout[52]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[53] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[53]),
        .Q(dout[53]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[54] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[54]),
        .Q(dout[54]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[55] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[55]),
        .Q(dout[55]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[56] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[56]),
        .Q(dout[56]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[57] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[57]),
        .Q(dout[57]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[58] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[58]),
        .Q(dout[58]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[59] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[59]),
        .Q(dout[59]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[5] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[5]),
        .Q(dout[5]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[60] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[60]),
        .Q(dout[60]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[61] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[61]),
        .Q(dout[61]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[62] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[62]),
        .Q(dout[62]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[63] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[63]),
        .Q(dout[63]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[6] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[6]),
        .Q(dout[6]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[7] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[7]),
        .Q(dout[7]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[8] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[8]),
        .Q(dout[8]));
  FDCE #(
    .INIT(1'b0)) 
    \goreg_dm.dout_i_reg[9] 
       (.C(clk),
        .CE(\goreg_dm.dout_i_reg[63]_0 ),
        .CLR(AR),
        .D(dout_i[9]),
        .Q(dout[9]));
endmodule

(* ORIG_REF_NAME = "rd_bin_cntr" *) 
module tx_fifo_ext_rd_bin_cntr
   (S,
    Q,
    \gc0.count_d1_reg[5]_0 ,
    ram_full_comb,
    ram_full_fb_i_reg,
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ,
    wr_en,
    E,
    out,
    ram_empty_fb_i_reg,
    ram_empty_fb_i_reg_0,
    ram_empty_fb_i_i_3_0,
    clk,
    \gc0.count_d1_reg[0]_0 );
  output [3:0]S;
  output [5:0]Q;
  output [1:0]\gc0.count_d1_reg[5]_0 ;
  output ram_full_comb;
  output ram_full_fb_i_reg;
  input [5:0]\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ;
  input wr_en;
  input [0:0]E;
  input out;
  input ram_empty_fb_i_reg;
  input ram_empty_fb_i_reg_0;
  input [5:0]ram_empty_fb_i_i_3_0;
  input clk;
  input \gc0.count_d1_reg[0]_0 ;

  wire [0:0]E;
  wire [5:0]Q;
  wire [3:0]S;
  wire clk;
  wire \gc0.count_d1_reg[0]_0 ;
  wire [1:0]\gc0.count_d1_reg[5]_0 ;
  wire [5:0]\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ;
  wire \gntv_or_sync_fifo.gl0.wr/gwss.wsts/comp0 ;
  wire \gntv_or_sync_fifo.gl0.wr/gwss.wsts/comp1 ;
  wire \grss.rsts/comp1 ;
  wire out;
  wire [5:0]plusOp__0;
  wire [5:0]ram_empty_fb_i_i_3_0;
  wire ram_empty_fb_i_i_4_n_0;
  wire ram_empty_fb_i_i_5_n_0;
  wire ram_empty_fb_i_i_6_n_0;
  wire ram_empty_fb_i_i_7_n_0;
  wire ram_empty_fb_i_reg;
  wire ram_empty_fb_i_reg_0;
  wire ram_full_comb;
  wire ram_full_fb_i_i_3_n_0;
  wire ram_full_fb_i_i_4_n_0;
  wire ram_full_fb_i_reg;
  wire [5:0]rd_pntr_plus1;
  wire wr_en;

  LUT1 #(
    .INIT(2'h1)) 
    \gc0.count[0]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .O(plusOp__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \gc0.count[1]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .I1(rd_pntr_plus1[1]),
        .O(plusOp__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \gc0.count[2]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .I1(rd_pntr_plus1[1]),
        .I2(rd_pntr_plus1[2]),
        .O(plusOp__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \gc0.count[3]_i_1 
       (.I0(rd_pntr_plus1[1]),
        .I1(rd_pntr_plus1[0]),
        .I2(rd_pntr_plus1[2]),
        .I3(rd_pntr_plus1[3]),
        .O(plusOp__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \gc0.count[4]_i_1 
       (.I0(rd_pntr_plus1[2]),
        .I1(rd_pntr_plus1[0]),
        .I2(rd_pntr_plus1[1]),
        .I3(rd_pntr_plus1[3]),
        .I4(rd_pntr_plus1[4]),
        .O(plusOp__0[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \gc0.count[5]_i_1 
       (.I0(rd_pntr_plus1[3]),
        .I1(rd_pntr_plus1[1]),
        .I2(rd_pntr_plus1[0]),
        .I3(rd_pntr_plus1[2]),
        .I4(rd_pntr_plus1[4]),
        .I5(rd_pntr_plus1[5]),
        .O(plusOp__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[0] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(rd_pntr_plus1[0]),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[1] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(rd_pntr_plus1[1]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[2] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(rd_pntr_plus1[2]),
        .Q(Q[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[3] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(rd_pntr_plus1[3]),
        .Q(Q[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[4] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(rd_pntr_plus1[4]),
        .Q(Q[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[5] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(rd_pntr_plus1[5]),
        .Q(Q[5]));
  FDPE #(
    .INIT(1'b1)) 
    \gc0.count_reg[0] 
       (.C(clk),
        .CE(E),
        .D(plusOp__0[0]),
        .PRE(\gc0.count_d1_reg[0]_0 ),
        .Q(rd_pntr_plus1[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[1] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(plusOp__0[1]),
        .Q(rd_pntr_plus1[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[2] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(plusOp__0[2]),
        .Q(rd_pntr_plus1[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[3] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(plusOp__0[3]),
        .Q(rd_pntr_plus1[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[4] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(plusOp__0[4]),
        .Q(rd_pntr_plus1[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[5] 
       (.C(clk),
        .CE(E),
        .CLR(\gc0.count_d1_reg[0]_0 ),
        .D(plusOp__0[5]),
        .Q(rd_pntr_plus1[5]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry__0_i_1
       (.I0(Q[5]),
        .I1(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [5]),
        .O(\gc0.count_d1_reg[5]_0 [1]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry__0_i_2
       (.I0(Q[4]),
        .I1(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [4]),
        .O(\gc0.count_d1_reg[5]_0 [0]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry_i_2
       (.I0(Q[3]),
        .I1(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [3]),
        .O(S[3]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry_i_3
       (.I0(Q[2]),
        .I1(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [2]),
        .O(S[2]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry_i_4
       (.I0(Q[1]),
        .I1(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [1]),
        .O(S[1]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry_i_5
       (.I0(Q[0]),
        .I1(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [0]),
        .O(S[0]));
  LUT6 #(
    .INIT(64'hFF0FFFFF88008888)) 
    ram_empty_fb_i_i_1
       (.I0(E),
        .I1(\grss.rsts/comp1 ),
        .I2(\gntv_or_sync_fifo.gl0.wr/gwss.wsts/comp0 ),
        .I3(ram_empty_fb_i_reg),
        .I4(wr_en),
        .I5(ram_empty_fb_i_reg_0),
        .O(ram_full_fb_i_reg));
  LUT6 #(
    .INIT(64'h9009000000000000)) 
    ram_empty_fb_i_i_2
       (.I0(ram_empty_fb_i_i_3_0[1]),
        .I1(rd_pntr_plus1[1]),
        .I2(ram_empty_fb_i_i_3_0[0]),
        .I3(rd_pntr_plus1[0]),
        .I4(ram_empty_fb_i_i_4_n_0),
        .I5(ram_empty_fb_i_i_5_n_0),
        .O(\grss.rsts/comp1 ));
  LUT6 #(
    .INIT(64'h9009000000000000)) 
    ram_empty_fb_i_i_3
       (.I0(ram_empty_fb_i_i_3_0[1]),
        .I1(Q[1]),
        .I2(ram_empty_fb_i_i_3_0[0]),
        .I3(Q[0]),
        .I4(ram_empty_fb_i_i_6_n_0),
        .I5(ram_empty_fb_i_i_7_n_0),
        .O(\gntv_or_sync_fifo.gl0.wr/gwss.wsts/comp0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_empty_fb_i_i_4
       (.I0(rd_pntr_plus1[4]),
        .I1(ram_empty_fb_i_i_3_0[4]),
        .I2(rd_pntr_plus1[5]),
        .I3(ram_empty_fb_i_i_3_0[5]),
        .O(ram_empty_fb_i_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_empty_fb_i_i_5
       (.I0(rd_pntr_plus1[2]),
        .I1(ram_empty_fb_i_i_3_0[2]),
        .I2(rd_pntr_plus1[3]),
        .I3(ram_empty_fb_i_i_3_0[3]),
        .O(ram_empty_fb_i_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_empty_fb_i_i_6
       (.I0(Q[4]),
        .I1(ram_empty_fb_i_i_3_0[4]),
        .I2(Q[5]),
        .I3(ram_empty_fb_i_i_3_0[5]),
        .O(ram_empty_fb_i_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_empty_fb_i_i_7
       (.I0(Q[2]),
        .I1(ram_empty_fb_i_i_3_0[2]),
        .I2(Q[3]),
        .I3(ram_empty_fb_i_i_3_0[3]),
        .O(ram_empty_fb_i_i_7_n_0));
  LUT6 #(
    .INIT(64'h00000FFF08080808)) 
    ram_full_fb_i_i_1
       (.I0(wr_en),
        .I1(\gntv_or_sync_fifo.gl0.wr/gwss.wsts/comp1 ),
        .I2(E),
        .I3(\gntv_or_sync_fifo.gl0.wr/gwss.wsts/comp0 ),
        .I4(out),
        .I5(ram_empty_fb_i_reg),
        .O(ram_full_comb));
  LUT6 #(
    .INIT(64'h9009000000000000)) 
    ram_full_fb_i_i_2
       (.I0(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [1]),
        .I1(Q[1]),
        .I2(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [0]),
        .I3(Q[0]),
        .I4(ram_full_fb_i_i_3_n_0),
        .I5(ram_full_fb_i_i_4_n_0),
        .O(\gntv_or_sync_fifo.gl0.wr/gwss.wsts/comp1 ));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_full_fb_i_i_3
       (.I0(Q[4]),
        .I1(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [4]),
        .I2(Q[5]),
        .I3(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [5]),
        .O(ram_full_fb_i_i_3_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_full_fb_i_i_4
       (.I0(Q[2]),
        .I1(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [2]),
        .I2(Q[3]),
        .I3(\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] [3]),
        .O(ram_full_fb_i_i_4_n_0));
endmodule

(* ORIG_REF_NAME = "rd_fwft" *) 
module tx_fifo_ext_rd_fwft
   (empty,
    E,
    p_3_out,
    \gpregsm1.curr_fwft_state_reg[1]_0 ,
    ram_empty_fb_i_reg,
    clk,
    \gpregsm1.user_valid_reg_0 ,
    rd_en,
    out,
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[4] ,
    wr_en);
  output empty;
  output [0:0]E;
  output p_3_out;
  output [0:0]\gpregsm1.curr_fwft_state_reg[1]_0 ;
  output [0:0]ram_empty_fb_i_reg;
  input clk;
  input \gpregsm1.user_valid_reg_0 ;
  input rd_en;
  input out;
  input \gdiff.gcry_1_sym.diff_pntr_pad_reg[4] ;
  input wr_en;

  wire [0:0]E;
  (* DONT_TOUCH *) wire aempty_fwft_fb_i;
  (* DONT_TOUCH *) wire aempty_fwft_i;
  wire aempty_fwft_i0;
  wire clk;
  (* DONT_TOUCH *) wire [1:0]curr_fwft_state;
  (* DONT_TOUCH *) wire empty_fwft_fb_i;
  (* DONT_TOUCH *) wire empty_fwft_fb_o_i;
  wire empty_fwft_fb_o_i0;
  (* DONT_TOUCH *) wire empty_fwft_i;
  wire empty_fwft_i0;
  wire \gdiff.gcry_1_sym.diff_pntr_pad_reg[4] ;
  wire [0:0]\gpregsm1.curr_fwft_state_reg[1]_0 ;
  wire \gpregsm1.user_valid_reg_0 ;
  wire [1:0]next_fwft_state;
  wire out;
  wire p_3_out;
  wire [0:0]ram_empty_fb_i_reg;
  wire rd_en;
  (* DONT_TOUCH *) wire user_valid;
  wire wr_en;

  assign empty = empty_fwft_i;
  LUT5 #(
    .INIT(32'hFFCB8000)) 
    aempty_fwft_fb_i_i_1
       (.I0(rd_en),
        .I1(curr_fwft_state[0]),
        .I2(curr_fwft_state[1]),
        .I3(out),
        .I4(aempty_fwft_fb_i),
        .O(aempty_fwft_i0));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    aempty_fwft_fb_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(aempty_fwft_i0),
        .PRE(\gpregsm1.user_valid_reg_0 ),
        .Q(aempty_fwft_fb_i));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    aempty_fwft_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(aempty_fwft_i0),
        .PRE(\gpregsm1.user_valid_reg_0 ),
        .Q(aempty_fwft_i));
  LUT4 #(
    .INIT(16'hF320)) 
    empty_fwft_fb_i_i_1
       (.I0(rd_en),
        .I1(curr_fwft_state[1]),
        .I2(curr_fwft_state[0]),
        .I3(empty_fwft_fb_i),
        .O(empty_fwft_i0));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    empty_fwft_fb_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(empty_fwft_i0),
        .PRE(\gpregsm1.user_valid_reg_0 ),
        .Q(empty_fwft_fb_i));
  LUT4 #(
    .INIT(16'hF320)) 
    empty_fwft_fb_o_i_i_1
       (.I0(rd_en),
        .I1(curr_fwft_state[1]),
        .I2(curr_fwft_state[0]),
        .I3(empty_fwft_fb_o_i),
        .O(empty_fwft_fb_o_i0));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    empty_fwft_fb_o_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(empty_fwft_fb_o_i0),
        .PRE(\gpregsm1.user_valid_reg_0 ),
        .Q(empty_fwft_fb_o_i));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    empty_fwft_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(empty_fwft_i0),
        .PRE(\gpregsm1.user_valid_reg_0 ),
        .Q(empty_fwft_i));
  LUT4 #(
    .INIT(16'h4555)) 
    \gc0.count_d1[5]_i_1 
       (.I0(out),
        .I1(rd_en),
        .I2(curr_fwft_state[1]),
        .I3(curr_fwft_state[0]),
        .O(ram_empty_fb_i_reg));
  LUT3 #(
    .INIT(8'hA2)) 
    \goreg_dm.dout_i[63]_i_1 
       (.I0(curr_fwft_state[1]),
        .I1(curr_fwft_state[0]),
        .I2(rd_en),
        .O(\gpregsm1.curr_fwft_state_reg[1]_0 ));
  LUT4 #(
    .INIT(16'h00F7)) 
    \gpr1.dout_i[63]_i_1 
       (.I0(curr_fwft_state[0]),
        .I1(curr_fwft_state[1]),
        .I2(rd_en),
        .I3(out),
        .O(E));
  LUT3 #(
    .INIT(8'hBA)) 
    \gpregsm1.curr_fwft_state[0]_i_1 
       (.I0(curr_fwft_state[1]),
        .I1(rd_en),
        .I2(curr_fwft_state[0]),
        .O(next_fwft_state[0]));
  LUT4 #(
    .INIT(16'h20FF)) 
    \gpregsm1.curr_fwft_state[1]_i_1 
       (.I0(curr_fwft_state[1]),
        .I1(rd_en),
        .I2(curr_fwft_state[0]),
        .I3(out),
        .O(next_fwft_state[1]));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \gpregsm1.curr_fwft_state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\gpregsm1.user_valid_reg_0 ),
        .D(next_fwft_state[0]),
        .Q(curr_fwft_state[0]));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \gpregsm1.curr_fwft_state_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\gpregsm1.user_valid_reg_0 ),
        .D(next_fwft_state[1]),
        .Q(curr_fwft_state[1]));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \gpregsm1.user_valid_reg 
       (.C(clk),
        .CE(1'b1),
        .CLR(\gpregsm1.user_valid_reg_0 ),
        .D(next_fwft_state[0]),
        .Q(user_valid));
  LUT6 #(
    .INIT(64'h4444444400004000)) 
    plusOp_carry_i_1
       (.I0(\gdiff.gcry_1_sym.diff_pntr_pad_reg[4] ),
        .I1(wr_en),
        .I2(curr_fwft_state[0]),
        .I3(curr_fwft_state[1]),
        .I4(rd_en),
        .I5(out),
        .O(p_3_out));
endmodule

(* ORIG_REF_NAME = "rd_logic" *) 
module tx_fifo_ext_rd_logic
   (empty,
    S,
    Q,
    \gc0.count_d1_reg[5] ,
    E,
    ram_full_comb,
    ram_empty_fb_i_reg,
    p_3_out,
    \gpregsm1.curr_fwft_state_reg[1] ,
    clk,
    \gc0.count_d1_reg[0] ,
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ,
    rd_en,
    wr_en,
    out,
    ram_empty_fb_i_reg_0,
    ram_empty_fb_i_i_3);
  output empty;
  output [3:0]S;
  output [5:0]Q;
  output [1:0]\gc0.count_d1_reg[5] ;
  output [0:0]E;
  output ram_full_comb;
  output [0:0]ram_empty_fb_i_reg;
  output p_3_out;
  output [0:0]\gpregsm1.curr_fwft_state_reg[1] ;
  input clk;
  input \gc0.count_d1_reg[0] ;
  input [5:0]\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ;
  input rd_en;
  input wr_en;
  input out;
  input ram_empty_fb_i_reg_0;
  input [5:0]ram_empty_fb_i_i_3;

  wire [0:0]E;
  wire [5:0]Q;
  wire [3:0]S;
  wire clk;
  wire empty;
  wire \gc0.count_d1_reg[0] ;
  wire [1:0]\gc0.count_d1_reg[5] ;
  wire [5:0]\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ;
  wire [0:0]\gpregsm1.curr_fwft_state_reg[1] ;
  wire out;
  wire p_2_out;
  wire p_3_out;
  wire [5:0]ram_empty_fb_i_i_3;
  wire [0:0]ram_empty_fb_i_reg;
  wire ram_empty_fb_i_reg_0;
  wire ram_full_comb;
  wire rd_en;
  wire rpntr_n_13;
  wire wr_en;

  tx_fifo_ext_rd_fwft \gr1.gr1_int.rfwft 
       (.E(E),
        .clk(clk),
        .empty(empty),
        .\gdiff.gcry_1_sym.diff_pntr_pad_reg[4] (ram_empty_fb_i_reg_0),
        .\gpregsm1.curr_fwft_state_reg[1]_0 (\gpregsm1.curr_fwft_state_reg[1] ),
        .\gpregsm1.user_valid_reg_0 (\gc0.count_d1_reg[0] ),
        .out(p_2_out),
        .p_3_out(p_3_out),
        .ram_empty_fb_i_reg(ram_empty_fb_i_reg),
        .rd_en(rd_en),
        .wr_en(wr_en));
  tx_fifo_ext_rd_status_flags_ss \grss.rsts 
       (.clk(clk),
        .out(p_2_out),
        .ram_empty_fb_i_reg_0(rpntr_n_13),
        .ram_empty_fb_i_reg_1(\gc0.count_d1_reg[0] ));
  tx_fifo_ext_rd_bin_cntr rpntr
       (.E(ram_empty_fb_i_reg),
        .Q(Q),
        .S(S),
        .clk(clk),
        .\gc0.count_d1_reg[0]_0 (\gc0.count_d1_reg[0] ),
        .\gc0.count_d1_reg[5]_0 (\gc0.count_d1_reg[5] ),
        .\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] (\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ),
        .out(out),
        .ram_empty_fb_i_i_3_0(ram_empty_fb_i_i_3),
        .ram_empty_fb_i_reg(ram_empty_fb_i_reg_0),
        .ram_empty_fb_i_reg_0(p_2_out),
        .ram_full_comb(ram_full_comb),
        .ram_full_fb_i_reg(rpntr_n_13),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "rd_status_flags_ss" *) 
module tx_fifo_ext_rd_status_flags_ss
   (out,
    ram_empty_fb_i_reg_0,
    clk,
    ram_empty_fb_i_reg_1);
  output out;
  input ram_empty_fb_i_reg_0;
  input clk;
  input ram_empty_fb_i_reg_1;

  wire clk;
  (* DONT_TOUCH *) wire ram_empty_fb_i;
  wire ram_empty_fb_i_reg_0;
  wire ram_empty_fb_i_reg_1;
  (* DONT_TOUCH *) wire ram_empty_i;

  assign out = ram_empty_fb_i;
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_empty_fb_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(ram_empty_fb_i_reg_0),
        .PRE(ram_empty_fb_i_reg_1),
        .Q(ram_empty_fb_i));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_empty_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(ram_empty_fb_i_reg_0),
        .PRE(ram_empty_fb_i_reg_1),
        .Q(ram_empty_i));
endmodule

(* ORIG_REF_NAME = "reset_blk_ramfifo" *) 
module tx_fifo_ext_reset_blk_ramfifo
   (out,
    \grstd1.grst_full.grst_f.rst_d3_reg_0 ,
    wr_rst_busy,
    AR,
    rst,
    clk);
  output out;
  output \grstd1.grst_full.grst_f.rst_d3_reg_0 ;
  output wr_rst_busy;
  output [0:0]AR;
  input rst;
  input clk;

  wire [0:0]AR;
  wire clk;
  wire \ngwrdrst.grst.g7serrst.gnsckt_wrst.gcc_rst.sckt_wr_rst_cc_reg_n_0_[3] ;
  wire [3:1]p_0_in;
  wire p_2_out;
  wire rst;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d1;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d2;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d3;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_wr_reg2;
  wire wr_rst_busy;

  assign \grstd1.grst_full.grst_f.rst_d3_reg_0  = rst_d3;
  assign out = rst_d2;
  LUT3 #(
    .INIT(8'hFE)) 
    \goreg_dm.dout_i[63]_i_2 
       (.I0(p_0_in[2]),
        .I1(p_0_in[1]),
        .I2(rst_wr_reg2),
        .O(AR));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d1_reg 
       (.C(clk),
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
       (.C(clk),
        .CE(1'b1),
        .D(rst_d1),
        .PRE(rst_wr_reg2),
        .Q(rst_d2));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \grstd1.grst_full.grst_f.rst_d3_i_1 
       (.I0(p_0_in[2]),
        .I1(p_0_in[1]),
        .I2(rst_wr_reg2),
        .I3(rst_d2),
        .O(p_2_out));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d3_reg 
       (.C(clk),
        .CE(1'b1),
        .D(p_2_out),
        .PRE(rst_wr_reg2),
        .Q(rst_d3));
  FDRE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gcc_rst.sckt_wr_rst_cc_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(rst_wr_reg2),
        .Q(p_0_in[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gcc_rst.sckt_wr_rst_cc_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in[1]),
        .Q(p_0_in[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gcc_rst.sckt_wr_rst_cc_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in[2]),
        .Q(p_0_in[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gcc_rst.sckt_wr_rst_cc_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in[3]),
        .Q(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gcc_rst.sckt_wr_rst_cc_reg_n_0_[3] ),
        .R(1'b0));
  (* DEF_VAL = "1'b0" *) 
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* INV_DEF_VAL = "1'b1" *) 
  (* RST_ACTIVE_HIGH = "1" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  (* XPM_MODULE = "TRUE" *) 
  tx_fifo_ext_xpm_cdc_async_rst \ngwrdrst.grst.g7serrst.gnsckt_wrst.rst_wr_reg2_inst 
       (.dest_arst(rst_wr_reg2),
        .dest_clk(clk),
        .src_arst(rst));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    rd_rst_busy_INST_0
       (.I0(p_0_in[3]),
        .I1(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gcc_rst.sckt_wr_rst_cc_reg_n_0_[3] ),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(rst_wr_reg2),
        .O(wr_rst_busy));
endmodule

(* ORIG_REF_NAME = "wr_bin_cntr" *) 
module tx_fifo_ext_wr_bin_cntr
   (Q,
    \gcc0.gc0.count_d1_reg[5]_0 ,
    E,
    clk,
    AR);
  output [5:0]Q;
  output [5:0]\gcc0.gc0.count_d1_reg[5]_0 ;
  input [0:0]E;
  input clk;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [5:0]Q;
  wire clk;
  wire [5:0]\gcc0.gc0.count_d1_reg[5]_0 ;
  wire [5:0]plusOp__1;

  LUT1 #(
    .INIT(2'h1)) 
    \gcc0.gc0.count[0]_i_1 
       (.I0(Q[0]),
        .O(plusOp__1[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \gcc0.gc0.count[1]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(plusOp__1[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \gcc0.gc0.count[2]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(plusOp__1[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \gcc0.gc0.count[3]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(plusOp__1[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \gcc0.gc0.count[4]_i_1 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(plusOp__1[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \gcc0.gc0.count[5]_i_1 
       (.I0(Q[3]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[2]),
        .I4(Q[4]),
        .I5(Q[5]),
        .O(plusOp__1[5]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_d1_reg[0] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[0]),
        .Q(\gcc0.gc0.count_d1_reg[5]_0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_d1_reg[1] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[1]),
        .Q(\gcc0.gc0.count_d1_reg[5]_0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_d1_reg[2] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[2]),
        .Q(\gcc0.gc0.count_d1_reg[5]_0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_d1_reg[3] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[3]),
        .Q(\gcc0.gc0.count_d1_reg[5]_0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_d1_reg[4] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[4]),
        .Q(\gcc0.gc0.count_d1_reg[5]_0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_d1_reg[5] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[5]),
        .Q(\gcc0.gc0.count_d1_reg[5]_0 [5]));
  FDPE #(
    .INIT(1'b1)) 
    \gcc0.gc0.count_reg[0] 
       (.C(clk),
        .CE(E),
        .D(plusOp__1[0]),
        .PRE(AR),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_reg[1] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__1[1]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_reg[2] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__1[2]),
        .Q(Q[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_reg[3] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__1[3]),
        .Q(Q[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_reg[4] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__1[4]),
        .Q(Q[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_reg[5] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__1[5]),
        .Q(Q[5]));
endmodule

(* ORIG_REF_NAME = "wr_logic" *) 
module tx_fifo_ext_wr_logic
   (out,
    full,
    E,
    Q,
    prog_full,
    \gcc0.gc0.count_d1_reg[5] ,
    ram_full_comb,
    clk,
    ram_full_i_reg,
    \greg.ram_rd_en_i_reg ,
    AR,
    p_3_out,
    S,
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ,
    wr_en,
    \gpfs.prog_full_i_reg );
  output out;
  output full;
  output [0:0]E;
  output [5:0]Q;
  output prog_full;
  output [5:0]\gcc0.gc0.count_d1_reg[5] ;
  input ram_full_comb;
  input clk;
  input ram_full_i_reg;
  input [0:0]\greg.ram_rd_en_i_reg ;
  input [0:0]AR;
  input p_3_out;
  input [3:0]S;
  input [1:0]\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ;
  input wr_en;
  input \gpfs.prog_full_i_reg ;

  wire [0:0]AR;
  wire [0:0]E;
  wire [5:0]Q;
  wire [3:0]S;
  wire clk;
  wire full;
  wire [5:0]\gcc0.gc0.count_d1_reg[5] ;
  wire [1:0]\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ;
  wire \gpfs.prog_full_i_reg ;
  wire [0:0]\greg.ram_rd_en_i_reg ;
  wire out;
  wire p_3_out;
  wire prog_full;
  wire ram_full_comb;
  wire ram_full_i_reg;
  wire wr_en;

  tx_fifo_ext_wr_pf_ss \gwss.gpf.wrpf 
       (.AR(AR),
        .E(E),
        .Q(Q[4:0]),
        .S(S),
        .clk(clk),
        .\gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_0 (\gdiff.gcry_1_sym.diff_pntr_pad_reg[6] ),
        .\gpfs.prog_full_i_reg_0 (ram_full_i_reg),
        .\gpfs.prog_full_i_reg_1 (\gpfs.prog_full_i_reg ),
        .\greg.ram_rd_en_i_reg_0 (\greg.ram_rd_en_i_reg ),
        .p_3_out(p_3_out),
        .prog_full(prog_full));
  tx_fifo_ext_wr_status_flags_ss \gwss.wsts 
       (.E(E),
        .clk(clk),
        .full(full),
        .out(out),
        .ram_full_comb(ram_full_comb),
        .ram_full_i_reg_0(ram_full_i_reg),
        .wr_en(wr_en));
  tx_fifo_ext_wr_bin_cntr wpntr
       (.AR(AR),
        .E(E),
        .Q(Q),
        .clk(clk),
        .\gcc0.gc0.count_d1_reg[5]_0 (\gcc0.gc0.count_d1_reg[5] ));
endmodule

(* ORIG_REF_NAME = "wr_pf_ss" *) 
module tx_fifo_ext_wr_pf_ss
   (prog_full,
    \greg.ram_rd_en_i_reg_0 ,
    clk,
    AR,
    E,
    p_3_out,
    Q,
    S,
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_0 ,
    \gpfs.prog_full_i_reg_0 ,
    \gpfs.prog_full_i_reg_1 );
  output prog_full;
  input [0:0]\greg.ram_rd_en_i_reg_0 ;
  input clk;
  input [0:0]AR;
  input [0:0]E;
  input p_3_out;
  input [4:0]Q;
  input [3:0]S;
  input [1:0]\gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_0 ;
  input \gpfs.prog_full_i_reg_0 ;
  input \gpfs.prog_full_i_reg_1 ;

  wire [0:0]AR;
  wire [0:0]E;
  wire [4:0]Q;
  wire [3:0]S;
  wire clk;
  wire [6:1]diff_pntr_pad;
  wire eqOp__4;
  wire [1:0]\gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_0 ;
  wire \gpfs.prog_full_i_i_1_n_0 ;
  wire \gpfs.prog_full_i_reg_0 ;
  wire \gpfs.prog_full_i_reg_1 ;
  wire [0:0]\greg.ram_rd_en_i_reg_0 ;
  wire p_3_out;
  wire [6:1]plusOp;
  wire plusOp_carry__0_n_3;
  wire plusOp_carry_n_0;
  wire plusOp_carry_n_1;
  wire plusOp_carry_n_2;
  wire plusOp_carry_n_3;
  wire prog_full;
  wire ram_rd_en_i;
  wire ram_wr_en_i;
  wire [3:1]NLW_plusOp_carry__0_CO_UNCONNECTED;
  wire [3:2]NLW_plusOp_carry__0_O_UNCONNECTED;

  FDCE #(
    .INIT(1'b0)) 
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(AR),
        .D(plusOp[1]),
        .Q(diff_pntr_pad[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(AR),
        .D(plusOp[2]),
        .Q(diff_pntr_pad[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(AR),
        .D(plusOp[3]),
        .Q(diff_pntr_pad[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(AR),
        .D(plusOp[4]),
        .Q(diff_pntr_pad[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(AR),
        .D(plusOp[5]),
        .Q(diff_pntr_pad[5]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.gcry_1_sym.diff_pntr_pad_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(AR),
        .D(plusOp[6]),
        .Q(diff_pntr_pad[6]));
  LUT5 #(
    .INIT(32'h51550040)) 
    \gpfs.prog_full_i_i_1 
       (.I0(\gpfs.prog_full_i_reg_1 ),
        .I1(eqOp__4),
        .I2(ram_wr_en_i),
        .I3(ram_rd_en_i),
        .I4(prog_full),
        .O(\gpfs.prog_full_i_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0008000000000000)) 
    \gpfs.prog_full_i_i_2 
       (.I0(diff_pntr_pad[6]),
        .I1(diff_pntr_pad[4]),
        .I2(diff_pntr_pad[2]),
        .I3(diff_pntr_pad[1]),
        .I4(diff_pntr_pad[5]),
        .I5(diff_pntr_pad[3]),
        .O(eqOp__4));
  FDPE #(
    .INIT(1'b1)) 
    \gpfs.prog_full_i_reg 
       (.C(clk),
        .CE(1'b1),
        .D(\gpfs.prog_full_i_i_1_n_0 ),
        .PRE(\gpfs.prog_full_i_reg_0 ),
        .Q(prog_full));
  FDCE #(
    .INIT(1'b0)) 
    \greg.ram_rd_en_i_reg 
       (.C(clk),
        .CE(1'b1),
        .CLR(AR),
        .D(\greg.ram_rd_en_i_reg_0 ),
        .Q(ram_rd_en_i));
  FDCE #(
    .INIT(1'b0)) 
    \greg.ram_wr_en_i_reg 
       (.C(clk),
        .CE(1'b1),
        .CLR(AR),
        .D(E),
        .Q(ram_wr_en_i));
  CARRY4 plusOp_carry
       (.CI(1'b0),
        .CO({plusOp_carry_n_0,plusOp_carry_n_1,plusOp_carry_n_2,plusOp_carry_n_3}),
        .CYINIT(p_3_out),
        .DI(Q[3:0]),
        .O(plusOp[4:1]),
        .S(S));
  CARRY4 plusOp_carry__0
       (.CI(plusOp_carry_n_0),
        .CO({NLW_plusOp_carry__0_CO_UNCONNECTED[3:1],plusOp_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,Q[4]}),
        .O({NLW_plusOp_carry__0_O_UNCONNECTED[3:2],plusOp[6:5]}),
        .S({1'b0,1'b0,\gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_0 }));
endmodule

(* ORIG_REF_NAME = "wr_status_flags_ss" *) 
module tx_fifo_ext_wr_status_flags_ss
   (out,
    full,
    E,
    ram_full_comb,
    clk,
    ram_full_i_reg_0,
    wr_en);
  output out;
  output full;
  output [0:0]E;
  input ram_full_comb;
  input clk;
  input ram_full_i_reg_0;
  input wr_en;

  wire [0:0]E;
  wire clk;
  (* DONT_TOUCH *) wire ram_afull_fb;
  (* DONT_TOUCH *) wire ram_afull_i;
  wire ram_full_comb;
  (* DONT_TOUCH *) wire ram_full_fb_i;
  (* DONT_TOUCH *) wire ram_full_i;
  wire ram_full_i_reg_0;
  wire wr_en;

  assign full = ram_full_i;
  assign out = ram_full_fb_i;
  LUT2 #(
    .INIT(4'h2)) 
    \gcc0.gc0.count_d1[5]_i_1 
       (.I0(wr_en),
        .I1(ram_full_fb_i),
        .O(E));
  LUT1 #(
    .INIT(2'h2)) 
    i_0
       (.I0(1'b1),
        .O(ram_afull_i));
  LUT1 #(
    .INIT(2'h2)) 
    i_1
       (.I0(1'b1),
        .O(ram_afull_fb));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_full_fb_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(ram_full_comb),
        .PRE(ram_full_i_reg_0),
        .Q(ram_full_fb_i));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_full_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(ram_full_comb),
        .PRE(ram_full_i_reg_0),
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
