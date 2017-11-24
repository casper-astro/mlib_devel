// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Wed Nov  1 16:14:35 2017
// Host        : adam-cm running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aisaacson/work/git_work/ska_sa/projects/mlib_devel/jasper_library/test_models/s_c856m32k/myproj/myproj.srcs/sources_1/ip/ska_tx_packet_fifo/ska_tx_packet_fifo_sim_netlist.v
// Design      : ska_tx_packet_fifo
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "ska_tx_packet_fifo,fifo_generator_v13_1_1,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v13_1_1,Vivado 2016.2" *) 
(* NotValidForBitStream *)
module ska_tx_packet_fifo
   (rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en,
    dout,
    full,
    overflow,
    empty,
    prog_full);
  input rst;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 write_clk CLK" *) input wr_clk;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 read_clk CLK" *) input rd_clk;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_DATA" *) input [263:0]din;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *) input wr_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *) input rd_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_DATA" *) output [263:0]dout;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *) output full;
  output overflow;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ EMPTY" *) output empty;
  output prog_full;

  wire [263:0]din;
  wire [263:0]dout;
  wire empty;
  wire full;
  wire overflow;
  wire prog_full;
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
  wire [8:0]NLW_U0_data_count_UNCONNECTED;
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
  wire [8:0]NLW_U0_rd_data_count_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_buser_UNCONNECTED;
  wire [63:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_ruser_UNCONNECTED;
  wire [8:0]NLW_U0_wr_data_count_UNCONNECTED;

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
  (* C_DATA_COUNT_WIDTH = "9" *) 
  (* C_DEFAULT_VALUE = "BlankString" *) 
  (* C_DIN_WIDTH = "264" *) 
  (* C_DIN_WIDTH_AXIS = "1" *) 
  (* C_DIN_WIDTH_RACH = "32" *) 
  (* C_DIN_WIDTH_RDCH = "64" *) 
  (* C_DIN_WIDTH_WACH = "1" *) 
  (* C_DIN_WIDTH_WDCH = "64" *) 
  (* C_DIN_WIDTH_WRCH = "2" *) 
  (* C_DOUT_RST_VAL = "0" *) 
  (* C_DOUT_WIDTH = "264" *) 
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
  (* C_HAS_OVERFLOW = "1" *) 
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
  (* C_MEMORY_TYPE = "1" *) 
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
  (* C_PROG_FULL_THRESH_ASSERT_VAL = "511" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
  (* C_PROG_FULL_THRESH_NEGATE_VAL = "510" *) 
  (* C_PROG_FULL_TYPE = "1" *) 
  (* C_PROG_FULL_TYPE_AXIS = "0" *) 
  (* C_PROG_FULL_TYPE_RACH = "0" *) 
  (* C_PROG_FULL_TYPE_RDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WACH = "0" *) 
  (* C_PROG_FULL_TYPE_WDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WRCH = "0" *) 
  (* C_RACH_TYPE = "0" *) 
  (* C_RDCH_TYPE = "0" *) 
  (* C_RD_DATA_COUNT_WIDTH = "9" *) 
  (* C_RD_DEPTH = "512" *) 
  (* C_RD_FREQ = "1" *) 
  (* C_RD_PNTR_WIDTH = "9" *) 
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
  (* C_WR_DATA_COUNT_WIDTH = "9" *) 
  (* C_WR_DEPTH = "512" *) 
  (* C_WR_DEPTH_AXIS = "1024" *) 
  (* C_WR_DEPTH_RACH = "16" *) 
  (* C_WR_DEPTH_RDCH = "1024" *) 
  (* C_WR_DEPTH_WACH = "16" *) 
  (* C_WR_DEPTH_WDCH = "1024" *) 
  (* C_WR_DEPTH_WRCH = "16" *) 
  (* C_WR_FREQ = "1" *) 
  (* C_WR_PNTR_WIDTH = "9" *) 
  (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
  (* C_WR_PNTR_WIDTH_RACH = "4" *) 
  (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WACH = "4" *) 
  (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
  (* C_WR_RESPONSE_LATENCY = "1" *) 
  (* KEEP_HIERARCHY = "true" *) 
  ska_tx_packet_fifo_fifo_generator_v13_1_1 U0
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
        .data_count(NLW_U0_data_count_UNCONNECTED[8:0]),
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
        .overflow(overflow),
        .prog_empty(NLW_U0_prog_empty_UNCONNECTED),
        .prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full(prog_full),
        .prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .rd_clk(rd_clk),
        .rd_data_count(NLW_U0_rd_data_count_UNCONNECTED[8:0]),
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
        .wr_data_count(NLW_U0_wr_data_count_UNCONNECTED[8:0]),
        .wr_en(wr_en),
        .wr_rst(1'b0),
        .wr_rst_busy(NLW_U0_wr_rst_busy_UNCONNECTED));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module ska_tx_packet_fifo_blk_mem_gen_generic_cstr
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [263:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [263:0]din;

  wire [263:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [263:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

  ska_tx_packet_fifo_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.D(D[71:0]),
        .E(E),
        .Q(Q),
        .din(din[71:0]),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
  ska_tx_packet_fifo_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.D(D[143:72]),
        .E(E),
        .Q(Q),
        .din(din[143:72]),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
  ska_tx_packet_fifo_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.D(D[215:144]),
        .E(E),
        .Q(Q),
        .din(din[215:144]),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
  ska_tx_packet_fifo_blk_mem_gen_prim_width__parameterized2 \ramloop[3].ram.r 
       (.D(D[263:216]),
        .E(E),
        .Q(Q),
        .din(din[263:216]),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ska_tx_packet_fifo_blk_mem_gen_prim_width
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [71:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [71:0]din;

  wire [71:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [71:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

  ska_tx_packet_fifo_blk_mem_gen_prim_wrapper \prim_noinit.ram 
       (.D(D),
        .E(E),
        .Q(Q),
        .din(din),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ska_tx_packet_fifo_blk_mem_gen_prim_width__parameterized0
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [71:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [71:0]din;

  wire [71:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [71:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

  ska_tx_packet_fifo_blk_mem_gen_prim_wrapper__parameterized0 \prim_noinit.ram 
       (.D(D),
        .E(E),
        .Q(Q),
        .din(din),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ska_tx_packet_fifo_blk_mem_gen_prim_width__parameterized1
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [71:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [71:0]din;

  wire [71:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [71:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

  ska_tx_packet_fifo_blk_mem_gen_prim_wrapper__parameterized1 \prim_noinit.ram 
       (.D(D),
        .E(E),
        .Q(Q),
        .din(din),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module ska_tx_packet_fifo_blk_mem_gen_prim_width__parameterized2
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [47:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [47:0]din;

  wire [47:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [47:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

  ska_tx_packet_fifo_blk_mem_gen_prim_wrapper__parameterized2 \prim_noinit.ram 
       (.D(D),
        .E(E),
        .Q(Q),
        .din(din),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module ska_tx_packet_fifo_blk_mem_gen_prim_wrapper
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [71:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [71:0]din;

  wire [71:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [71:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_RDADDRECC_UNCONNECTED ;

  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram 
       (.ADDRARDADDR({1'b1,\gc0.count_d1_reg[8] ,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,\gic0.gc0.count_d2_reg[8] ,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_DBITERR_UNCONNECTED ),
        .DIADI({din[34:27],din[25:18],din[16:9],din[7:0]}),
        .DIBDI({din[70:63],din[61:54],din[52:45],din[43:36]}),
        .DIPADIP({din[35],din[26],din[17],din[8]}),
        .DIPBDIP({din[71],din[62],din[53],din[44]}),
        .DOADO({D[34:27],D[25:18],D[16:9],D[7:0]}),
        .DOBDO({D[70:63],D[61:54],D[52:45],D[43:36]}),
        .DOPADOP({D[35],D[26],D[17],D[8]}),
        .DOPBDOP({D[71],D[62],D[53],D[44]}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({E,E,E,E,E,E,E,E}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module ska_tx_packet_fifo_blk_mem_gen_prim_wrapper__parameterized0
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [71:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [71:0]din;

  wire [71:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [71:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_RDADDRECC_UNCONNECTED ;

  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram 
       (.ADDRARDADDR({1'b1,\gc0.count_d1_reg[8] ,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,\gic0.gc0.count_d2_reg[8] ,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_DBITERR_UNCONNECTED ),
        .DIADI({din[34:27],din[25:18],din[16:9],din[7:0]}),
        .DIBDI({din[70:63],din[61:54],din[52:45],din[43:36]}),
        .DIPADIP({din[35],din[26],din[17],din[8]}),
        .DIPBDIP({din[71],din[62],din[53],din[44]}),
        .DOADO({D[34:27],D[25:18],D[16:9],D[7:0]}),
        .DOBDO({D[70:63],D[61:54],D[52:45],D[43:36]}),
        .DOPADOP({D[35],D[26],D[17],D[8]}),
        .DOPBDOP({D[71],D[62],D[53],D[44]}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({E,E,E,E,E,E,E,E}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module ska_tx_packet_fifo_blk_mem_gen_prim_wrapper__parameterized1
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [71:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [71:0]din;

  wire [71:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [71:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_RDADDRECC_UNCONNECTED ;

  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram 
       (.ADDRARDADDR({1'b1,\gc0.count_d1_reg[8] ,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,\gic0.gc0.count_d2_reg[8] ,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_DBITERR_UNCONNECTED ),
        .DIADI({din[34:27],din[25:18],din[16:9],din[7:0]}),
        .DIBDI({din[70:63],din[61:54],din[52:45],din[43:36]}),
        .DIPADIP({din[35],din[26],din[17],din[8]}),
        .DIPBDIP({din[71],din[62],din[53],din[44]}),
        .DOADO({D[34:27],D[25:18],D[16:9],D[7:0]}),
        .DOBDO({D[70:63],D[61:54],D[52:45],D[43:36]}),
        .DOPADOP({D[35],D[26],D[17],D[8]}),
        .DOPBDOP({D[71],D[62],D[53],D[44]}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({E,E,E,E,E,E,E,E}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module ska_tx_packet_fifo_blk_mem_gen_prim_wrapper__parameterized2
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [47:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [47:0]din;

  wire [47:0]D;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_21 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_22 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_29 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_30 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_37 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_38 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_45 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_46 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_53 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_54 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_61 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_62 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_69 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_70 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_77 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_78 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_85 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_86 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_87 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_88 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_89 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_90 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_91 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_92 ;
  wire [0:0]E;
  wire [0:0]Q;
  wire [47:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_RDADDRECC_UNCONNECTED ;

  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram 
       (.ADDRARDADDR({1'b1,\gc0.count_d1_reg[8] ,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,\gic0.gc0.count_d2_reg[8] ,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,din[23:18],1'b0,1'b0,din[17:12],1'b0,1'b0,din[11:6],1'b0,1'b0,din[5:0]}),
        .DIBDI({1'b0,1'b0,din[47:42],1'b0,1'b0,din[41:36],1'b0,1'b0,din[35:30],1'b0,1'b0,din[29:24]}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_21 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_22 ,D[23:18],\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_29 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_30 ,D[17:12],\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_37 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_38 ,D[11:6],\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_45 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_46 ,D[5:0]}),
        .DOBDO({\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_53 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_54 ,D[47:42],\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_61 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_62 ,D[41:36],\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_69 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_70 ,D[35:30],\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_77 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_78 ,D[29:24]}),
        .DOPADOP({\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_85 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_86 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_87 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_88 }),
        .DOPBDOP({\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_89 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_90 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_91 ,\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_n_92 }),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({E,E,E,E,E,E,E,E}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_top" *) 
module ska_tx_packet_fifo_blk_mem_gen_top
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [263:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [263:0]din;

  wire [263:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [263:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

  ska_tx_packet_fifo_blk_mem_gen_generic_cstr \valid.cstr 
       (.D(D),
        .E(E),
        .Q(Q),
        .din(din),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_3_3" *) 
module ska_tx_packet_fifo_blk_mem_gen_v8_3_3
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [263:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [263:0]din;

  wire [263:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [263:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

  ska_tx_packet_fifo_blk_mem_gen_v8_3_3_synth inst_blk_mem_gen
       (.D(D),
        .E(E),
        .Q(Q),
        .din(din),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_3_3_synth" *) 
module ska_tx_packet_fifo_blk_mem_gen_v8_3_3_synth
   (D,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din);
  output [263:0]D;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [263:0]din;

  wire [263:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [263:0]din;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

  ska_tx_packet_fifo_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
       (.D(D),
        .E(E),
        .Q(Q),
        .din(din),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "clk_x_pntrs" *) 
module ska_tx_packet_fifo_clk_x_pntrs
   (ram_full_fb_i_reg,
    RD_PNTR_WR,
    ram_full_fb_i_reg_0,
    v1_reg,
    WR_PNTR_RD,
    v1_reg_0,
    Q,
    D,
    \gc0.count_d1_reg[8] ,
    \gc0.count_reg[7] ,
    \gic0.gc0.count_d2_reg[8] ,
    wr_clk,
    \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ,
    rd_clk,
    \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] );
  output ram_full_fb_i_reg;
  output [8:0]RD_PNTR_WR;
  output ram_full_fb_i_reg_0;
  output [3:0]v1_reg;
  output [0:0]WR_PNTR_RD;
  output [3:0]v1_reg_0;
  input [0:0]Q;
  input [0:0]D;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [7:0]\gc0.count_reg[7] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input wr_clk;
  input [0:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ;
  input rd_clk;
  input [0:0]\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ;

  wire [0:0]D;
  wire [0:0]Q;
  wire [8:0]RD_PNTR_WR;
  wire [0:0]WR_PNTR_RD;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [7:0]\gc0.count_reg[7] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire \gsync_stage[2].wr_stg_inst_n_1 ;
  wire \gsync_stage[2].wr_stg_inst_n_2 ;
  wire \gsync_stage[2].wr_stg_inst_n_3 ;
  wire \gsync_stage[2].wr_stg_inst_n_4 ;
  wire \gsync_stage[2].wr_stg_inst_n_5 ;
  wire \gsync_stage[2].wr_stg_inst_n_6 ;
  wire \gsync_stage[2].wr_stg_inst_n_7 ;
  wire \gsync_stage[2].wr_stg_inst_n_8 ;
  wire [0:0]\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ;
  wire [0:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ;
  wire [7:0]p_0_in;
  wire [7:0]p_0_in7_out;
  wire [8:8]p_0_out;
  wire [8:8]p_1_out;
  wire [7:0]p_22_out;
  wire [8:0]p_2_out;
  wire [8:0]p_3_out;
  wire ram_full_fb_i_reg;
  wire ram_full_fb_i_reg_0;
  wire rd_clk;
  wire [8:0]rd_pntr_gc;
  wire \rd_pntr_gc[0]_i_1_n_0 ;
  wire \rd_pntr_gc[1]_i_1_n_0 ;
  wire \rd_pntr_gc[2]_i_1_n_0 ;
  wire \rd_pntr_gc[3]_i_1_n_0 ;
  wire \rd_pntr_gc[4]_i_1_n_0 ;
  wire \rd_pntr_gc[5]_i_1_n_0 ;
  wire \rd_pntr_gc[6]_i_1_n_0 ;
  wire \rd_pntr_gc[7]_i_1_n_0 ;
  wire [3:0]v1_reg;
  wire [3:0]v1_reg_0;
  wire wr_clk;
  wire [8:0]wr_pntr_gc;

  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[0].gm1.m1_i_1 
       (.I0(p_22_out[0]),
        .I1(\gc0.count_d1_reg[8] [0]),
        .I2(p_22_out[1]),
        .I3(\gc0.count_d1_reg[8] [1]),
        .O(v1_reg[0]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[0].gm1.m1_i_1__0 
       (.I0(p_22_out[0]),
        .I1(\gc0.count_reg[7] [0]),
        .I2(p_22_out[1]),
        .I3(\gc0.count_reg[7] [1]),
        .O(v1_reg_0[0]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[1].gms.ms_i_1 
       (.I0(p_22_out[2]),
        .I1(\gc0.count_d1_reg[8] [2]),
        .I2(p_22_out[3]),
        .I3(\gc0.count_d1_reg[8] [3]),
        .O(v1_reg[1]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[1].gms.ms_i_1__0 
       (.I0(p_22_out[2]),
        .I1(\gc0.count_reg[7] [2]),
        .I2(p_22_out[3]),
        .I3(\gc0.count_reg[7] [3]),
        .O(v1_reg_0[1]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[2].gms.ms_i_1 
       (.I0(p_22_out[4]),
        .I1(\gc0.count_d1_reg[8] [4]),
        .I2(p_22_out[5]),
        .I3(\gc0.count_d1_reg[8] [5]),
        .O(v1_reg[2]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[2].gms.ms_i_1__0 
       (.I0(p_22_out[4]),
        .I1(\gc0.count_reg[7] [4]),
        .I2(p_22_out[5]),
        .I3(\gc0.count_reg[7] [5]),
        .O(v1_reg_0[2]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[3].gms.ms_i_1 
       (.I0(p_22_out[6]),
        .I1(\gc0.count_d1_reg[8] [6]),
        .I2(p_22_out[7]),
        .I3(\gc0.count_d1_reg[8] [7]),
        .O(v1_reg[3]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[3].gms.ms_i_1__0 
       (.I0(p_22_out[6]),
        .I1(\gc0.count_reg[7] [6]),
        .I2(p_22_out[7]),
        .I3(\gc0.count_reg[7] [7]),
        .O(v1_reg_0[3]));
  LUT2 #(
    .INIT(4'h9)) 
    \gmux.gm[4].gms.ms_i_1__1 
       (.I0(RD_PNTR_WR[8]),
        .I1(Q),
        .O(ram_full_fb_i_reg));
  LUT2 #(
    .INIT(4'h9)) 
    \gmux.gm[4].gms.ms_i_1__2 
       (.I0(RD_PNTR_WR[8]),
        .I1(D),
        .O(ram_full_fb_i_reg_0));
  ska_tx_packet_fifo_synchronizer_ff \gsync_stage[1].rd_stg_inst 
       (.D(p_3_out),
        .Q(wr_pntr_gc),
        .\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] (\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .rd_clk(rd_clk));
  ska_tx_packet_fifo_synchronizer_ff_3 \gsync_stage[1].wr_stg_inst 
       (.D(p_2_out),
        .Q(rd_pntr_gc),
        .\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] (\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .wr_clk(wr_clk));
  ska_tx_packet_fifo_synchronizer_ff_4 \gsync_stage[2].rd_stg_inst 
       (.D(p_3_out),
        .\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] (\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .out(p_1_out),
        .rd_clk(rd_clk),
        .\wr_pntr_bin_reg[7] (p_0_in));
  ska_tx_packet_fifo_synchronizer_ff_5 \gsync_stage[2].wr_stg_inst 
       (.D(p_2_out),
        .\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] (\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .out(p_0_out),
        .\rd_pntr_bin_reg[7] ({\gsync_stage[2].wr_stg_inst_n_1 ,\gsync_stage[2].wr_stg_inst_n_2 ,\gsync_stage[2].wr_stg_inst_n_3 ,\gsync_stage[2].wr_stg_inst_n_4 ,\gsync_stage[2].wr_stg_inst_n_5 ,\gsync_stage[2].wr_stg_inst_n_6 ,\gsync_stage[2].wr_stg_inst_n_7 ,\gsync_stage[2].wr_stg_inst_n_8 }),
        .wr_clk(wr_clk));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_bin_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(\gsync_stage[2].wr_stg_inst_n_8 ),
        .Q(RD_PNTR_WR[0]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_bin_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(\gsync_stage[2].wr_stg_inst_n_7 ),
        .Q(RD_PNTR_WR[1]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_bin_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(\gsync_stage[2].wr_stg_inst_n_6 ),
        .Q(RD_PNTR_WR[2]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_bin_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(\gsync_stage[2].wr_stg_inst_n_5 ),
        .Q(RD_PNTR_WR[3]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_bin_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(\gsync_stage[2].wr_stg_inst_n_4 ),
        .Q(RD_PNTR_WR[4]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_bin_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(\gsync_stage[2].wr_stg_inst_n_3 ),
        .Q(RD_PNTR_WR[5]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_bin_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(\gsync_stage[2].wr_stg_inst_n_2 ),
        .Q(RD_PNTR_WR[6]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_bin_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(\gsync_stage[2].wr_stg_inst_n_1 ),
        .Q(RD_PNTR_WR[7]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_bin_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(p_0_out),
        .Q(RD_PNTR_WR[8]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_pntr_gc[0]_i_1 
       (.I0(\gc0.count_d1_reg[8] [0]),
        .I1(\gc0.count_d1_reg[8] [1]),
        .O(\rd_pntr_gc[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_pntr_gc[1]_i_1 
       (.I0(\gc0.count_d1_reg[8] [1]),
        .I1(\gc0.count_d1_reg[8] [2]),
        .O(\rd_pntr_gc[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_pntr_gc[2]_i_1 
       (.I0(\gc0.count_d1_reg[8] [2]),
        .I1(\gc0.count_d1_reg[8] [3]),
        .O(\rd_pntr_gc[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_pntr_gc[3]_i_1 
       (.I0(\gc0.count_d1_reg[8] [3]),
        .I1(\gc0.count_d1_reg[8] [4]),
        .O(\rd_pntr_gc[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_pntr_gc[4]_i_1 
       (.I0(\gc0.count_d1_reg[8] [4]),
        .I1(\gc0.count_d1_reg[8] [5]),
        .O(\rd_pntr_gc[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_pntr_gc[5]_i_1 
       (.I0(\gc0.count_d1_reg[8] [5]),
        .I1(\gc0.count_d1_reg[8] [6]),
        .O(\rd_pntr_gc[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_pntr_gc[6]_i_1 
       (.I0(\gc0.count_d1_reg[8] [6]),
        .I1(\gc0.count_d1_reg[8] [7]),
        .O(\rd_pntr_gc[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_pntr_gc[7]_i_1 
       (.I0(\gc0.count_d1_reg[8] [7]),
        .I1(\gc0.count_d1_reg[8] [8]),
        .O(\rd_pntr_gc[7]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_gc_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(\rd_pntr_gc[0]_i_1_n_0 ),
        .Q(rd_pntr_gc[0]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_gc_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(\rd_pntr_gc[1]_i_1_n_0 ),
        .Q(rd_pntr_gc[1]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_gc_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(\rd_pntr_gc[2]_i_1_n_0 ),
        .Q(rd_pntr_gc[2]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_gc_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(\rd_pntr_gc[3]_i_1_n_0 ),
        .Q(rd_pntr_gc[3]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_gc_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(\rd_pntr_gc[4]_i_1_n_0 ),
        .Q(rd_pntr_gc[4]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_gc_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(\rd_pntr_gc[5]_i_1_n_0 ),
        .Q(rd_pntr_gc[5]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_gc_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(\rd_pntr_gc[6]_i_1_n_0 ),
        .Q(rd_pntr_gc[6]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_gc_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(\rd_pntr_gc[7]_i_1_n_0 ),
        .Q(rd_pntr_gc[7]));
  FDCE #(
    .INIT(1'b0)) 
    \rd_pntr_gc_reg[8] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(\gc0.count_d1_reg[8] [8]),
        .Q(rd_pntr_gc[8]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_bin_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(p_0_in[0]),
        .Q(p_22_out[0]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_bin_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(p_0_in[1]),
        .Q(p_22_out[1]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_bin_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(p_0_in[2]),
        .Q(p_22_out[2]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_bin_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(p_0_in[3]),
        .Q(p_22_out[3]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_bin_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(p_0_in[4]),
        .Q(p_22_out[4]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_bin_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(p_0_in[5]),
        .Q(p_22_out[5]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_bin_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(p_0_in[6]),
        .Q(p_22_out[6]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_bin_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(p_0_in[7]),
        .Q(p_22_out[7]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_bin_reg[8] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(p_1_out),
        .Q(WR_PNTR_RD));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \wr_pntr_gc[0]_i_1 
       (.I0(\gic0.gc0.count_d2_reg[8] [0]),
        .I1(\gic0.gc0.count_d2_reg[8] [1]),
        .O(p_0_in7_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \wr_pntr_gc[1]_i_1 
       (.I0(\gic0.gc0.count_d2_reg[8] [1]),
        .I1(\gic0.gc0.count_d2_reg[8] [2]),
        .O(p_0_in7_out[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \wr_pntr_gc[2]_i_1 
       (.I0(\gic0.gc0.count_d2_reg[8] [2]),
        .I1(\gic0.gc0.count_d2_reg[8] [3]),
        .O(p_0_in7_out[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \wr_pntr_gc[3]_i_1 
       (.I0(\gic0.gc0.count_d2_reg[8] [3]),
        .I1(\gic0.gc0.count_d2_reg[8] [4]),
        .O(p_0_in7_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \wr_pntr_gc[4]_i_1 
       (.I0(\gic0.gc0.count_d2_reg[8] [4]),
        .I1(\gic0.gc0.count_d2_reg[8] [5]),
        .O(p_0_in7_out[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \wr_pntr_gc[5]_i_1 
       (.I0(\gic0.gc0.count_d2_reg[8] [5]),
        .I1(\gic0.gc0.count_d2_reg[8] [6]),
        .O(p_0_in7_out[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \wr_pntr_gc[6]_i_1 
       (.I0(\gic0.gc0.count_d2_reg[8] [6]),
        .I1(\gic0.gc0.count_d2_reg[8] [7]),
        .O(p_0_in7_out[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \wr_pntr_gc[7]_i_1 
       (.I0(\gic0.gc0.count_d2_reg[8] [7]),
        .I1(\gic0.gc0.count_d2_reg[8] [8]),
        .O(p_0_in7_out[7]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_gc_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(p_0_in7_out[0]),
        .Q(wr_pntr_gc[0]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_gc_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(p_0_in7_out[1]),
        .Q(wr_pntr_gc[1]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_gc_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(p_0_in7_out[2]),
        .Q(wr_pntr_gc[2]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_gc_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(p_0_in7_out[3]),
        .Q(wr_pntr_gc[3]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_gc_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(p_0_in7_out[4]),
        .Q(wr_pntr_gc[4]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_gc_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(p_0_in7_out[5]),
        .Q(wr_pntr_gc[5]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_gc_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(p_0_in7_out[6]),
        .Q(wr_pntr_gc[6]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_gc_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(p_0_in7_out[7]),
        .Q(wr_pntr_gc[7]));
  FDCE #(
    .INIT(1'b0)) 
    \wr_pntr_gc_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(\gic0.gc0.count_d2_reg[8] [8]),
        .Q(wr_pntr_gc[8]));
endmodule

(* ORIG_REF_NAME = "compare" *) 
module ska_tx_packet_fifo_compare
   (comp1,
    v1_reg,
    \rd_pntr_bin_reg[8] );
  output comp1;
  input [3:0]v1_reg;
  input \rd_pntr_bin_reg[8] ;

  wire CI;
  wire comp1;
  wire \gmux.gm[1].gms.ms_n_0 ;
  wire \gmux.gm[2].gms.ms_n_0 ;
  wire \gmux.gm[3].gms.ms_n_0 ;
  wire \rd_pntr_bin_reg[8] ;
  wire [3:0]v1_reg;
  wire [3:0]\NLW_gmux.gm[0].gm1.m1_CARRY4_O_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_CO_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_DI_UNCONNECTED ;
  wire [3:0]\NLW_gmux.gm[4].gms.ms_CARRY4_O_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_S_UNCONNECTED ;

  (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
  (* box_type = "PRIMITIVE" *) 
  CARRY4 \gmux.gm[0].gm1.m1_CARRY4 
       (.CI(1'b0),
        .CO({\gmux.gm[3].gms.ms_n_0 ,\gmux.gm[2].gms.ms_n_0 ,\gmux.gm[1].gms.ms_n_0 ,CI}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_gmux.gm[0].gm1.m1_CARRY4_O_UNCONNECTED [3:0]),
        .S(v1_reg));
  (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
  (* box_type = "PRIMITIVE" *) 
  CARRY4 \gmux.gm[4].gms.ms_CARRY4 
       (.CI(\gmux.gm[3].gms.ms_n_0 ),
        .CO({\NLW_gmux.gm[4].gms.ms_CARRY4_CO_UNCONNECTED [3:1],comp1}),
        .CYINIT(1'b0),
        .DI({\NLW_gmux.gm[4].gms.ms_CARRY4_DI_UNCONNECTED [3:1],1'b0}),
        .O(\NLW_gmux.gm[4].gms.ms_CARRY4_O_UNCONNECTED [3:0]),
        .S({\NLW_gmux.gm[4].gms.ms_CARRY4_S_UNCONNECTED [3:1],\rd_pntr_bin_reg[8] }));
endmodule

(* ORIG_REF_NAME = "compare" *) 
module ska_tx_packet_fifo_compare_0
   (ram_full_i,
    v1_reg_0,
    \rd_pntr_bin_reg[8] ,
    \grstd1.grst_full.grst_f.rst_d3_reg ,
    ram_full_fb_i_reg,
    wr_en,
    comp1);
  output ram_full_i;
  input [3:0]v1_reg_0;
  input \rd_pntr_bin_reg[8] ;
  input \grstd1.grst_full.grst_f.rst_d3_reg ;
  input ram_full_fb_i_reg;
  input wr_en;
  input comp1;

  wire CI;
  wire comp1;
  wire comp2;
  wire \gmux.gm[1].gms.ms_n_0 ;
  wire \gmux.gm[2].gms.ms_n_0 ;
  wire \gmux.gm[3].gms.ms_n_0 ;
  wire \grstd1.grst_full.grst_f.rst_d3_reg ;
  wire ram_full_fb_i_reg;
  wire ram_full_i;
  wire \rd_pntr_bin_reg[8] ;
  wire [3:0]v1_reg_0;
  wire wr_en;
  wire [3:0]\NLW_gmux.gm[0].gm1.m1_CARRY4_O_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_CO_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_DI_UNCONNECTED ;
  wire [3:0]\NLW_gmux.gm[4].gms.ms_CARRY4_O_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_S_UNCONNECTED ;

  (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
  (* box_type = "PRIMITIVE" *) 
  CARRY4 \gmux.gm[0].gm1.m1_CARRY4 
       (.CI(1'b0),
        .CO({\gmux.gm[3].gms.ms_n_0 ,\gmux.gm[2].gms.ms_n_0 ,\gmux.gm[1].gms.ms_n_0 ,CI}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_gmux.gm[0].gm1.m1_CARRY4_O_UNCONNECTED [3:0]),
        .S(v1_reg_0));
  (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
  (* box_type = "PRIMITIVE" *) 
  CARRY4 \gmux.gm[4].gms.ms_CARRY4 
       (.CI(\gmux.gm[3].gms.ms_n_0 ),
        .CO({\NLW_gmux.gm[4].gms.ms_CARRY4_CO_UNCONNECTED [3:1],comp2}),
        .CYINIT(1'b0),
        .DI({\NLW_gmux.gm[4].gms.ms_CARRY4_DI_UNCONNECTED [3:1],1'b0}),
        .O(\NLW_gmux.gm[4].gms.ms_CARRY4_O_UNCONNECTED [3:0]),
        .S({\NLW_gmux.gm[4].gms.ms_CARRY4_S_UNCONNECTED [3:1],\rd_pntr_bin_reg[8] }));
  LUT5 #(
    .INIT(32'h55550400)) 
    ram_full_i_i_1
       (.I0(\grstd1.grst_full.grst_f.rst_d3_reg ),
        .I1(comp2),
        .I2(ram_full_fb_i_reg),
        .I3(wr_en),
        .I4(comp1),
        .O(ram_full_i));
endmodule

(* ORIG_REF_NAME = "compare" *) 
module ska_tx_packet_fifo_compare_1
   (ram_empty_fb_i_reg,
    v1_reg,
    \gc0.count_d1_reg[8] ,
    rd_en,
    \gpregsm1.curr_fwft_state_reg[1] ,
    p_2_out,
    comp1);
  output ram_empty_fb_i_reg;
  input [3:0]v1_reg;
  input \gc0.count_d1_reg[8] ;
  input rd_en;
  input [1:0]\gpregsm1.curr_fwft_state_reg[1] ;
  input p_2_out;
  input comp1;

  wire CI;
  wire comp0;
  wire comp1;
  wire \gc0.count_d1_reg[8] ;
  wire \gmux.gm[1].gms.ms_n_0 ;
  wire \gmux.gm[2].gms.ms_n_0 ;
  wire \gmux.gm[3].gms.ms_n_0 ;
  wire [1:0]\gpregsm1.curr_fwft_state_reg[1] ;
  wire p_2_out;
  wire ram_empty_fb_i_reg;
  wire rd_en;
  wire [3:0]v1_reg;
  wire [3:0]\NLW_gmux.gm[0].gm1.m1_CARRY4_O_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_CO_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_DI_UNCONNECTED ;
  wire [3:0]\NLW_gmux.gm[4].gms.ms_CARRY4_O_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_S_UNCONNECTED ;

  (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
  (* box_type = "PRIMITIVE" *) 
  CARRY4 \gmux.gm[0].gm1.m1_CARRY4 
       (.CI(1'b0),
        .CO({\gmux.gm[3].gms.ms_n_0 ,\gmux.gm[2].gms.ms_n_0 ,\gmux.gm[1].gms.ms_n_0 ,CI}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_gmux.gm[0].gm1.m1_CARRY4_O_UNCONNECTED [3:0]),
        .S(v1_reg));
  (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
  (* box_type = "PRIMITIVE" *) 
  CARRY4 \gmux.gm[4].gms.ms_CARRY4 
       (.CI(\gmux.gm[3].gms.ms_n_0 ),
        .CO({\NLW_gmux.gm[4].gms.ms_CARRY4_CO_UNCONNECTED [3:1],comp0}),
        .CYINIT(1'b0),
        .DI({\NLW_gmux.gm[4].gms.ms_CARRY4_DI_UNCONNECTED [3:1],1'b0}),
        .O(\NLW_gmux.gm[4].gms.ms_CARRY4_O_UNCONNECTED [3:0]),
        .S({\NLW_gmux.gm[4].gms.ms_CARRY4_S_UNCONNECTED [3:1],\gc0.count_d1_reg[8] }));
  LUT6 #(
    .INIT(64'hAAAAEFFFAAAAAAAA)) 
    ram_empty_fb_i_i_1
       (.I0(comp0),
        .I1(rd_en),
        .I2(\gpregsm1.curr_fwft_state_reg[1] [0]),
        .I3(\gpregsm1.curr_fwft_state_reg[1] [1]),
        .I4(p_2_out),
        .I5(comp1),
        .O(ram_empty_fb_i_reg));
endmodule

(* ORIG_REF_NAME = "compare" *) 
module ska_tx_packet_fifo_compare_2
   (comp1,
    v1_reg_0,
    \gc0.count_reg[8] );
  output comp1;
  input [3:0]v1_reg_0;
  input \gc0.count_reg[8] ;

  wire CI;
  wire comp1;
  wire \gc0.count_reg[8] ;
  wire \gmux.gm[1].gms.ms_n_0 ;
  wire \gmux.gm[2].gms.ms_n_0 ;
  wire \gmux.gm[3].gms.ms_n_0 ;
  wire [3:0]v1_reg_0;
  wire [3:0]\NLW_gmux.gm[0].gm1.m1_CARRY4_O_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_CO_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_DI_UNCONNECTED ;
  wire [3:0]\NLW_gmux.gm[4].gms.ms_CARRY4_O_UNCONNECTED ;
  wire [3:1]\NLW_gmux.gm[4].gms.ms_CARRY4_S_UNCONNECTED ;

  (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
  (* box_type = "PRIMITIVE" *) 
  CARRY4 \gmux.gm[0].gm1.m1_CARRY4 
       (.CI(1'b0),
        .CO({\gmux.gm[3].gms.ms_n_0 ,\gmux.gm[2].gms.ms_n_0 ,\gmux.gm[1].gms.ms_n_0 ,CI}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_gmux.gm[0].gm1.m1_CARRY4_O_UNCONNECTED [3:0]),
        .S(v1_reg_0));
  (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
  (* box_type = "PRIMITIVE" *) 
  CARRY4 \gmux.gm[4].gms.ms_CARRY4 
       (.CI(\gmux.gm[3].gms.ms_n_0 ),
        .CO({\NLW_gmux.gm[4].gms.ms_CARRY4_CO_UNCONNECTED [3:1],comp1}),
        .CYINIT(1'b0),
        .DI({\NLW_gmux.gm[4].gms.ms_CARRY4_DI_UNCONNECTED [3:1],1'b0}),
        .O(\NLW_gmux.gm[4].gms.ms_CARRY4_O_UNCONNECTED [3:0]),
        .S({\NLW_gmux.gm[4].gms.ms_CARRY4_S_UNCONNECTED [3:1],\gc0.count_reg[8] }));
endmodule

(* ORIG_REF_NAME = "fifo_generator_ramfifo" *) 
module ska_tx_packet_fifo_fifo_generator_ramfifo
   (dout,
    empty,
    full,
    overflow,
    prog_full,
    wr_en,
    rd_clk,
    wr_clk,
    din,
    rst,
    rd_en);
  output [263:0]dout;
  output empty;
  output full;
  output overflow;
  output prog_full;
  input wr_en;
  input rd_clk;
  input wr_clk;
  input [263:0]din;
  input rst;
  input rd_en;

  wire RD_RST;
  wire RST;
  wire WR_RST;
  wire [263:0]din;
  wire [263:0]dout;
  wire empty;
  wire full;
  wire \gntv_or_sync_fifo.gcx.clkx_n_0 ;
  wire \gntv_or_sync_fifo.gcx.clkx_n_10 ;
  wire \gntv_or_sync_fifo.gl0.wr_n_4 ;
  wire [3:0]\gras.rsts/c0/v1_reg ;
  wire [3:0]\gras.rsts/c1/v1_reg ;
  wire overflow;
  wire [8:0]p_0_out;
  wire [8:0]p_12_out;
  wire [8:8]p_13_out;
  wire [8:8]p_22_out;
  wire [8:0]p_23_out;
  wire p_5_out;
  wire prog_full;
  wire rd_clk;
  wire rd_en;
  wire [7:0]rd_pntr_plus1;
  wire [1:0]rd_rst_i;
  wire rst;
  wire rst_full_ff_i;
  wire rst_full_gen_i;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire wr_en;
  wire [8:8]wr_pntr_plus2;
  wire [0:0]wr_rst_i;

  ska_tx_packet_fifo_clk_x_pntrs \gntv_or_sync_fifo.gcx.clkx 
       (.D(wr_pntr_plus2),
        .Q(p_13_out),
        .RD_PNTR_WR(p_23_out),
        .WR_PNTR_RD(p_22_out),
        .\gc0.count_d1_reg[8] (p_0_out),
        .\gc0.count_reg[7] (rd_pntr_plus1),
        .\gic0.gc0.count_d2_reg[8] (p_12_out),
        .\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] (rd_rst_i[1]),
        .\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] (wr_rst_i),
        .ram_full_fb_i_reg(\gntv_or_sync_fifo.gcx.clkx_n_0 ),
        .ram_full_fb_i_reg_0(\gntv_or_sync_fifo.gcx.clkx_n_10 ),
        .rd_clk(rd_clk),
        .v1_reg(\gras.rsts/c0/v1_reg ),
        .v1_reg_0(\gras.rsts/c1/v1_reg ),
        .wr_clk(wr_clk));
  ska_tx_packet_fifo_rd_logic \gntv_or_sync_fifo.gl0.rd 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram (p_0_out),
        .E(p_5_out),
        .Q({RD_RST,rd_rst_i[0]}),
        .WR_PNTR_RD(p_22_out),
        .empty(empty),
        .\gc0.count_d1_reg[7] (rd_pntr_plus1),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .v1_reg(\gras.rsts/c0/v1_reg ),
        .v1_reg_0(\gras.rsts/c1/v1_reg ));
  ska_tx_packet_fifo_wr_logic \gntv_or_sync_fifo.gl0.wr 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram (p_12_out),
        .E(\gntv_or_sync_fifo.gl0.wr_n_4 ),
        .Q(p_13_out),
        .RD_PNTR_WR(p_23_out),
        .full(full),
        .\gic0.gc0.count_d1_reg[8] (wr_pntr_plus2),
        .\grstd1.grst_full.grst_f.rst_d3_reg (rst_full_gen_i),
        .\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ({RST,WR_RST}),
        .out(rst_full_ff_i),
        .overflow(overflow),
        .prog_full(prog_full),
        .\rd_pntr_bin_reg[8] (\gntv_or_sync_fifo.gcx.clkx_n_0 ),
        .\rd_pntr_bin_reg[8]_0 (\gntv_or_sync_fifo.gcx.clkx_n_10 ),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
  ska_tx_packet_fifo_memory \gntv_or_sync_fifo.mem 
       (.E(\gntv_or_sync_fifo.gl0.wr_n_4 ),
        .Q(rd_rst_i[0]),
        .din(din),
        .dout(dout),
        .\gc0.count_d1_reg[8] (p_0_out),
        .\gic0.gc0.count_d2_reg[8] (p_12_out),
        .\gpregsm1.curr_fwft_state_reg[1] (p_5_out),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
  ska_tx_packet_fifo_reset_blk_ramfifo rstblk
       (.Q({RST,WR_RST,wr_rst_i}),
        .out(rst_full_ff_i),
        .ram_empty_fb_i_reg({RD_RST,rd_rst_i}),
        .ram_full_fb_i_reg(rst_full_gen_i),
        .rd_clk(rd_clk),
        .rst(rst),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "fifo_generator_top" *) 
module ska_tx_packet_fifo_fifo_generator_top
   (dout,
    empty,
    full,
    overflow,
    prog_full,
    wr_en,
    rd_clk,
    wr_clk,
    din,
    rst,
    rd_en);
  output [263:0]dout;
  output empty;
  output full;
  output overflow;
  output prog_full;
  input wr_en;
  input rd_clk;
  input wr_clk;
  input [263:0]din;
  input rst;
  input rd_en;

  wire [263:0]din;
  wire [263:0]dout;
  wire empty;
  wire full;
  wire overflow;
  wire prog_full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;

  ska_tx_packet_fifo_fifo_generator_ramfifo \grf.rf 
       (.din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .overflow(overflow),
        .prog_full(prog_full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
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
(* C_DATA_COUNT_WIDTH = "9" *) (* C_DEFAULT_VALUE = "BlankString" *) (* C_DIN_WIDTH = "264" *) 
(* C_DIN_WIDTH_AXIS = "1" *) (* C_DIN_WIDTH_RACH = "32" *) (* C_DIN_WIDTH_RDCH = "64" *) 
(* C_DIN_WIDTH_WACH = "1" *) (* C_DIN_WIDTH_WDCH = "64" *) (* C_DIN_WIDTH_WRCH = "2" *) 
(* C_DOUT_RST_VAL = "0" *) (* C_DOUT_WIDTH = "264" *) (* C_ENABLE_RLOCS = "0" *) 
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
(* C_HAS_MEMINIT_FILE = "0" *) (* C_HAS_OVERFLOW = "1" *) (* C_HAS_PROG_FLAGS_AXIS = "0" *) 
(* C_HAS_PROG_FLAGS_RACH = "0" *) (* C_HAS_PROG_FLAGS_RDCH = "0" *) (* C_HAS_PROG_FLAGS_WACH = "0" *) 
(* C_HAS_PROG_FLAGS_WDCH = "0" *) (* C_HAS_PROG_FLAGS_WRCH = "0" *) (* C_HAS_RD_DATA_COUNT = "0" *) 
(* C_HAS_RD_RST = "0" *) (* C_HAS_RST = "1" *) (* C_HAS_SLAVE_CE = "0" *) 
(* C_HAS_SRST = "0" *) (* C_HAS_UNDERFLOW = "0" *) (* C_HAS_VALID = "0" *) 
(* C_HAS_WR_ACK = "0" *) (* C_HAS_WR_DATA_COUNT = "0" *) (* C_HAS_WR_RST = "0" *) 
(* C_IMPLEMENTATION_TYPE = "2" *) (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
(* C_IMPLEMENTATION_TYPE_RDCH = "1" *) (* C_IMPLEMENTATION_TYPE_WACH = "1" *) (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
(* C_IMPLEMENTATION_TYPE_WRCH = "1" *) (* C_INIT_WR_PNTR_VAL = "0" *) (* C_INTERFACE_TYPE = "0" *) 
(* C_MEMORY_TYPE = "1" *) (* C_MIF_FILE_NAME = "BlankString" *) (* C_MSGON_VAL = "1" *) 
(* C_OPTIMIZATION_MODE = "0" *) (* C_OVERFLOW_LOW = "0" *) (* C_POWER_SAVING_MODE = "0" *) 
(* C_PRELOAD_LATENCY = "0" *) (* C_PRELOAD_REGS = "1" *) (* C_PRIM_FIFO_TYPE = "512x72" *) 
(* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) 
(* C_PRIM_FIFO_TYPE_WACH = "512x36" *) (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL = "4" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "5" *) (* C_PROG_EMPTY_TYPE = "0" *) 
(* C_PROG_EMPTY_TYPE_AXIS = "0" *) (* C_PROG_EMPTY_TYPE_RACH = "0" *) (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
(* C_PROG_EMPTY_TYPE_WACH = "0" *) (* C_PROG_EMPTY_TYPE_WDCH = "0" *) (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL = "511" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) (* C_PROG_FULL_THRESH_NEGATE_VAL = "510" *) (* C_PROG_FULL_TYPE = "1" *) 
(* C_PROG_FULL_TYPE_AXIS = "0" *) (* C_PROG_FULL_TYPE_RACH = "0" *) (* C_PROG_FULL_TYPE_RDCH = "0" *) 
(* C_PROG_FULL_TYPE_WACH = "0" *) (* C_PROG_FULL_TYPE_WDCH = "0" *) (* C_PROG_FULL_TYPE_WRCH = "0" *) 
(* C_RACH_TYPE = "0" *) (* C_RDCH_TYPE = "0" *) (* C_RD_DATA_COUNT_WIDTH = "9" *) 
(* C_RD_DEPTH = "512" *) (* C_RD_FREQ = "1" *) (* C_RD_PNTR_WIDTH = "9" *) 
(* C_REG_SLICE_MODE_AXIS = "0" *) (* C_REG_SLICE_MODE_RACH = "0" *) (* C_REG_SLICE_MODE_RDCH = "0" *) 
(* C_REG_SLICE_MODE_WACH = "0" *) (* C_REG_SLICE_MODE_WDCH = "0" *) (* C_REG_SLICE_MODE_WRCH = "0" *) 
(* C_SELECT_XPM = "0" *) (* C_SYNCHRONIZER_STAGE = "2" *) (* C_UNDERFLOW_LOW = "0" *) 
(* C_USE_COMMON_OVERFLOW = "0" *) (* C_USE_COMMON_UNDERFLOW = "0" *) (* C_USE_DEFAULT_SETTINGS = "0" *) 
(* C_USE_DOUT_RST = "1" *) (* C_USE_ECC = "0" *) (* C_USE_ECC_AXIS = "0" *) 
(* C_USE_ECC_RACH = "0" *) (* C_USE_ECC_RDCH = "0" *) (* C_USE_ECC_WACH = "0" *) 
(* C_USE_ECC_WDCH = "0" *) (* C_USE_ECC_WRCH = "0" *) (* C_USE_EMBEDDED_REG = "0" *) 
(* C_USE_FIFO16_FLAGS = "0" *) (* C_USE_FWFT_DATA_COUNT = "0" *) (* C_USE_PIPELINE_REG = "0" *) 
(* C_VALID_LOW = "0" *) (* C_WACH_TYPE = "0" *) (* C_WDCH_TYPE = "0" *) 
(* C_WRCH_TYPE = "0" *) (* C_WR_ACK_LOW = "0" *) (* C_WR_DATA_COUNT_WIDTH = "9" *) 
(* C_WR_DEPTH = "512" *) (* C_WR_DEPTH_AXIS = "1024" *) (* C_WR_DEPTH_RACH = "16" *) 
(* C_WR_DEPTH_RDCH = "1024" *) (* C_WR_DEPTH_WACH = "16" *) (* C_WR_DEPTH_WDCH = "1024" *) 
(* C_WR_DEPTH_WRCH = "16" *) (* C_WR_FREQ = "1" *) (* C_WR_PNTR_WIDTH = "9" *) 
(* C_WR_PNTR_WIDTH_AXIS = "10" *) (* C_WR_PNTR_WIDTH_RACH = "4" *) (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
(* C_WR_PNTR_WIDTH_WACH = "4" *) (* C_WR_PNTR_WIDTH_WDCH = "10" *) (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
(* C_WR_RESPONSE_LATENCY = "1" *) (* ORIG_REF_NAME = "fifo_generator_v13_1_1" *) 
module ska_tx_packet_fifo_fifo_generator_v13_1_1
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
  input [263:0]din;
  input wr_en;
  input rd_en;
  input [8:0]prog_empty_thresh;
  input [8:0]prog_empty_thresh_assert;
  input [8:0]prog_empty_thresh_negate;
  input [8:0]prog_full_thresh;
  input [8:0]prog_full_thresh_assert;
  input [8:0]prog_full_thresh_negate;
  input int_clk;
  input injectdbiterr;
  input injectsbiterr;
  input sleep;
  output [263:0]dout;
  output full;
  output almost_full;
  output wr_ack;
  output overflow;
  output empty;
  output almost_empty;
  output valid;
  output underflow;
  output [8:0]data_count;
  output [8:0]rd_data_count;
  output [8:0]wr_data_count;
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
  wire [263:0]din;
  wire [263:0]dout;
  wire empty;
  wire full;
  wire overflow;
  wire prog_full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;

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
  assign data_count[8] = \<const0> ;
  assign data_count[7] = \<const0> ;
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
  assign prog_empty = \<const0> ;
  assign rd_data_count[8] = \<const0> ;
  assign rd_data_count[7] = \<const0> ;
  assign rd_data_count[6] = \<const0> ;
  assign rd_data_count[5] = \<const0> ;
  assign rd_data_count[4] = \<const0> ;
  assign rd_data_count[3] = \<const0> ;
  assign rd_data_count[2] = \<const0> ;
  assign rd_data_count[1] = \<const0> ;
  assign rd_data_count[0] = \<const0> ;
  assign rd_rst_busy = \<const0> ;
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
  assign wr_data_count[8] = \<const0> ;
  assign wr_data_count[7] = \<const0> ;
  assign wr_data_count[6] = \<const0> ;
  assign wr_data_count[5] = \<const0> ;
  assign wr_data_count[4] = \<const0> ;
  assign wr_data_count[3] = \<const0> ;
  assign wr_data_count[2] = \<const0> ;
  assign wr_data_count[1] = \<const0> ;
  assign wr_data_count[0] = \<const0> ;
  assign wr_rst_busy = \<const0> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  ska_tx_packet_fifo_fifo_generator_v13_1_1_synth inst_fifo_gen
       (.din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .overflow(overflow),
        .prog_full(prog_full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "fifo_generator_v13_1_1_synth" *) 
module ska_tx_packet_fifo_fifo_generator_v13_1_1_synth
   (dout,
    empty,
    full,
    overflow,
    prog_full,
    wr_en,
    rd_clk,
    wr_clk,
    din,
    rst,
    rd_en);
  output [263:0]dout;
  output empty;
  output full;
  output overflow;
  output prog_full;
  input wr_en;
  input rd_clk;
  input wr_clk;
  input [263:0]din;
  input rst;
  input rd_en;

  wire [263:0]din;
  wire [263:0]dout;
  wire empty;
  wire full;
  wire overflow;
  wire prog_full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;

  ska_tx_packet_fifo_fifo_generator_top \gconvfifo.rf 
       (.din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .overflow(overflow),
        .prog_full(prog_full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "memory" *) 
module ska_tx_packet_fifo_memory
   (dout,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    E,
    Q,
    \gc0.count_d1_reg[8] ,
    \gic0.gc0.count_d2_reg[8] ,
    din,
    \gpregsm1.curr_fwft_state_reg[1] );
  output [263:0]dout;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input [0:0]E;
  input [0:0]Q;
  input [8:0]\gc0.count_d1_reg[8] ;
  input [8:0]\gic0.gc0.count_d2_reg[8] ;
  input [263:0]din;
  input [0:0]\gpregsm1.curr_fwft_state_reg[1] ;

  wire [0:0]E;
  wire [0:0]Q;
  wire [263:0]din;
  wire [263:0]dout;
  wire [263:0]doutb;
  wire [8:0]\gc0.count_d1_reg[8] ;
  wire [8:0]\gic0.gc0.count_d2_reg[8] ;
  wire [0:0]\gpregsm1.curr_fwft_state_reg[1] ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

  ska_tx_packet_fifo_blk_mem_gen_v8_3_3 \gbm.gbmg.gbmga.ngecc.bmg 
       (.D(doutb),
        .E(E),
        .Q(Q),
        .din(din),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gic0.gc0.count_d2_reg[8] (\gic0.gc0.count_d2_reg[8] ),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[0] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[0]),
        .Q(dout[0]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[100] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[100]),
        .Q(dout[100]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[101] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[101]),
        .Q(dout[101]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[102] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[102]),
        .Q(dout[102]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[103] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[103]),
        .Q(dout[103]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[104] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[104]),
        .Q(dout[104]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[105] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[105]),
        .Q(dout[105]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[106] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[106]),
        .Q(dout[106]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[107] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[107]),
        .Q(dout[107]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[108] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[108]),
        .Q(dout[108]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[109] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[109]),
        .Q(dout[109]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[10] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[10]),
        .Q(dout[10]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[110] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[110]),
        .Q(dout[110]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[111] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[111]),
        .Q(dout[111]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[112] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[112]),
        .Q(dout[112]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[113] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[113]),
        .Q(dout[113]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[114] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[114]),
        .Q(dout[114]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[115] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[115]),
        .Q(dout[115]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[116] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[116]),
        .Q(dout[116]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[117] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[117]),
        .Q(dout[117]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[118] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[118]),
        .Q(dout[118]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[119] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[119]),
        .Q(dout[119]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[11] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[11]),
        .Q(dout[11]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[120] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[120]),
        .Q(dout[120]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[121] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[121]),
        .Q(dout[121]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[122] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[122]),
        .Q(dout[122]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[123] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[123]),
        .Q(dout[123]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[124] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[124]),
        .Q(dout[124]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[125] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[125]),
        .Q(dout[125]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[126] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[126]),
        .Q(dout[126]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[127] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[127]),
        .Q(dout[127]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[128] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[128]),
        .Q(dout[128]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[129] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[129]),
        .Q(dout[129]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[12] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[12]),
        .Q(dout[12]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[130] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[130]),
        .Q(dout[130]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[131] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[131]),
        .Q(dout[131]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[132] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[132]),
        .Q(dout[132]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[133] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[133]),
        .Q(dout[133]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[134] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[134]),
        .Q(dout[134]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[135] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[135]),
        .Q(dout[135]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[136] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[136]),
        .Q(dout[136]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[137] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[137]),
        .Q(dout[137]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[138] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[138]),
        .Q(dout[138]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[139] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[139]),
        .Q(dout[139]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[13] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[13]),
        .Q(dout[13]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[140] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[140]),
        .Q(dout[140]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[141] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[141]),
        .Q(dout[141]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[142] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[142]),
        .Q(dout[142]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[143] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[143]),
        .Q(dout[143]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[144] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[144]),
        .Q(dout[144]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[145] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[145]),
        .Q(dout[145]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[146] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[146]),
        .Q(dout[146]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[147] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[147]),
        .Q(dout[147]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[148] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[148]),
        .Q(dout[148]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[149] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[149]),
        .Q(dout[149]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[14] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[14]),
        .Q(dout[14]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[150] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[150]),
        .Q(dout[150]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[151] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[151]),
        .Q(dout[151]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[152] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[152]),
        .Q(dout[152]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[153] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[153]),
        .Q(dout[153]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[154] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[154]),
        .Q(dout[154]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[155] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[155]),
        .Q(dout[155]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[156] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[156]),
        .Q(dout[156]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[157] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[157]),
        .Q(dout[157]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[158] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[158]),
        .Q(dout[158]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[159] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[159]),
        .Q(dout[159]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[15] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[15]),
        .Q(dout[15]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[160] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[160]),
        .Q(dout[160]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[161] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[161]),
        .Q(dout[161]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[162] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[162]),
        .Q(dout[162]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[163] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[163]),
        .Q(dout[163]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[164] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[164]),
        .Q(dout[164]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[165] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[165]),
        .Q(dout[165]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[166] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[166]),
        .Q(dout[166]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[167] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[167]),
        .Q(dout[167]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[168] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[168]),
        .Q(dout[168]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[169] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[169]),
        .Q(dout[169]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[16] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[16]),
        .Q(dout[16]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[170] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[170]),
        .Q(dout[170]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[171] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[171]),
        .Q(dout[171]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[172] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[172]),
        .Q(dout[172]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[173] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[173]),
        .Q(dout[173]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[174] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[174]),
        .Q(dout[174]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[175] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[175]),
        .Q(dout[175]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[176] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[176]),
        .Q(dout[176]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[177] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[177]),
        .Q(dout[177]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[178] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[178]),
        .Q(dout[178]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[179] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[179]),
        .Q(dout[179]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[17] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[17]),
        .Q(dout[17]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[180] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[180]),
        .Q(dout[180]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[181] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[181]),
        .Q(dout[181]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[182] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[182]),
        .Q(dout[182]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[183] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[183]),
        .Q(dout[183]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[184] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[184]),
        .Q(dout[184]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[185] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[185]),
        .Q(dout[185]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[186] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[186]),
        .Q(dout[186]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[187] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[187]),
        .Q(dout[187]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[188] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[188]),
        .Q(dout[188]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[189] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[189]),
        .Q(dout[189]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[18] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[18]),
        .Q(dout[18]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[190] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[190]),
        .Q(dout[190]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[191] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[191]),
        .Q(dout[191]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[192] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[192]),
        .Q(dout[192]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[193] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[193]),
        .Q(dout[193]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[194] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[194]),
        .Q(dout[194]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[195] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[195]),
        .Q(dout[195]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[196] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[196]),
        .Q(dout[196]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[197] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[197]),
        .Q(dout[197]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[198] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[198]),
        .Q(dout[198]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[199] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[199]),
        .Q(dout[199]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[19] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[19]),
        .Q(dout[19]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[1] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[1]),
        .Q(dout[1]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[200] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[200]),
        .Q(dout[200]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[201] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[201]),
        .Q(dout[201]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[202] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[202]),
        .Q(dout[202]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[203] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[203]),
        .Q(dout[203]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[204] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[204]),
        .Q(dout[204]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[205] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[205]),
        .Q(dout[205]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[206] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[206]),
        .Q(dout[206]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[207] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[207]),
        .Q(dout[207]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[208] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[208]),
        .Q(dout[208]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[209] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[209]),
        .Q(dout[209]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[20] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[20]),
        .Q(dout[20]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[210] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[210]),
        .Q(dout[210]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[211] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[211]),
        .Q(dout[211]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[212] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[212]),
        .Q(dout[212]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[213] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[213]),
        .Q(dout[213]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[214] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[214]),
        .Q(dout[214]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[215] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[215]),
        .Q(dout[215]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[216] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[216]),
        .Q(dout[216]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[217] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[217]),
        .Q(dout[217]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[218] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[218]),
        .Q(dout[218]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[219] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[219]),
        .Q(dout[219]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[21] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[21]),
        .Q(dout[21]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[220] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[220]),
        .Q(dout[220]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[221] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[221]),
        .Q(dout[221]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[222] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[222]),
        .Q(dout[222]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[223] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[223]),
        .Q(dout[223]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[224] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[224]),
        .Q(dout[224]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[225] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[225]),
        .Q(dout[225]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[226] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[226]),
        .Q(dout[226]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[227] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[227]),
        .Q(dout[227]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[228] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[228]),
        .Q(dout[228]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[229] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[229]),
        .Q(dout[229]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[22] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[22]),
        .Q(dout[22]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[230] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[230]),
        .Q(dout[230]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[231] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[231]),
        .Q(dout[231]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[232] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[232]),
        .Q(dout[232]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[233] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[233]),
        .Q(dout[233]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[234] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[234]),
        .Q(dout[234]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[235] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[235]),
        .Q(dout[235]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[236] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[236]),
        .Q(dout[236]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[237] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[237]),
        .Q(dout[237]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[238] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[238]),
        .Q(dout[238]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[239] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[239]),
        .Q(dout[239]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[23] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[23]),
        .Q(dout[23]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[240] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[240]),
        .Q(dout[240]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[241] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[241]),
        .Q(dout[241]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[242] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[242]),
        .Q(dout[242]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[243] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[243]),
        .Q(dout[243]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[244] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[244]),
        .Q(dout[244]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[245] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[245]),
        .Q(dout[245]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[246] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[246]),
        .Q(dout[246]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[247] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[247]),
        .Q(dout[247]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[248] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[248]),
        .Q(dout[248]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[249] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[249]),
        .Q(dout[249]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[24] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[24]),
        .Q(dout[24]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[250] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[250]),
        .Q(dout[250]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[251] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[251]),
        .Q(dout[251]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[252] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[252]),
        .Q(dout[252]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[253] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[253]),
        .Q(dout[253]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[254] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[254]),
        .Q(dout[254]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[255] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[255]),
        .Q(dout[255]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[256] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[256]),
        .Q(dout[256]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[257] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[257]),
        .Q(dout[257]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[258] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[258]),
        .Q(dout[258]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[259] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[259]),
        .Q(dout[259]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[25] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[25]),
        .Q(dout[25]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[260] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[260]),
        .Q(dout[260]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[261] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[261]),
        .Q(dout[261]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[262] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[262]),
        .Q(dout[262]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[263] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[263]),
        .Q(dout[263]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[26] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[26]),
        .Q(dout[26]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[27] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[27]),
        .Q(dout[27]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[28] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[28]),
        .Q(dout[28]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[29] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[29]),
        .Q(dout[29]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[2] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[2]),
        .Q(dout[2]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[30] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[30]),
        .Q(dout[30]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[31] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[31]),
        .Q(dout[31]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[32] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[32]),
        .Q(dout[32]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[33] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[33]),
        .Q(dout[33]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[34] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[34]),
        .Q(dout[34]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[35] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[35]),
        .Q(dout[35]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[36] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[36]),
        .Q(dout[36]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[37] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[37]),
        .Q(dout[37]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[38] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[38]),
        .Q(dout[38]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[39] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[39]),
        .Q(dout[39]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[3] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[3]),
        .Q(dout[3]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[40] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[40]),
        .Q(dout[40]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[41] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[41]),
        .Q(dout[41]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[42] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[42]),
        .Q(dout[42]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[43] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[43]),
        .Q(dout[43]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[44] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[44]),
        .Q(dout[44]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[45] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[45]),
        .Q(dout[45]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[46] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[46]),
        .Q(dout[46]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[47] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[47]),
        .Q(dout[47]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[48] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[48]),
        .Q(dout[48]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[49] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[49]),
        .Q(dout[49]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[4] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[4]),
        .Q(dout[4]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[50] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[50]),
        .Q(dout[50]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[51] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[51]),
        .Q(dout[51]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[52] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[52]),
        .Q(dout[52]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[53] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[53]),
        .Q(dout[53]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[54] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[54]),
        .Q(dout[54]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[55] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[55]),
        .Q(dout[55]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[56] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[56]),
        .Q(dout[56]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[57] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[57]),
        .Q(dout[57]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[58] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[58]),
        .Q(dout[58]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[59] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[59]),
        .Q(dout[59]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[5] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[5]),
        .Q(dout[5]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[60] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[60]),
        .Q(dout[60]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[61] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[61]),
        .Q(dout[61]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[62] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[62]),
        .Q(dout[62]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[63] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[63]),
        .Q(dout[63]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[64] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[64]),
        .Q(dout[64]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[65] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[65]),
        .Q(dout[65]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[66] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[66]),
        .Q(dout[66]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[67] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[67]),
        .Q(dout[67]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[68] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[68]),
        .Q(dout[68]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[69] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[69]),
        .Q(dout[69]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[6] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[6]),
        .Q(dout[6]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[70] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[70]),
        .Q(dout[70]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[71] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[71]),
        .Q(dout[71]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[72] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[72]),
        .Q(dout[72]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[73] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[73]),
        .Q(dout[73]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[74] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[74]),
        .Q(dout[74]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[75] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[75]),
        .Q(dout[75]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[76] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[76]),
        .Q(dout[76]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[77] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[77]),
        .Q(dout[77]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[78] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[78]),
        .Q(dout[78]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[79] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[79]),
        .Q(dout[79]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[7] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[7]),
        .Q(dout[7]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[80] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[80]),
        .Q(dout[80]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[81] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[81]),
        .Q(dout[81]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[82] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[82]),
        .Q(dout[82]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[83] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[83]),
        .Q(dout[83]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[84] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[84]),
        .Q(dout[84]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[85] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[85]),
        .Q(dout[85]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[86] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[86]),
        .Q(dout[86]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[87] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[87]),
        .Q(dout[87]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[88] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[88]),
        .Q(dout[88]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[89] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[89]),
        .Q(dout[89]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[8] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[8]),
        .Q(dout[8]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[90] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[90]),
        .Q(dout[90]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[91] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[91]),
        .Q(dout[91]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[92] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[92]),
        .Q(dout[92]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[93] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[93]),
        .Q(dout[93]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[94] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[94]),
        .Q(dout[94]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[95] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[95]),
        .Q(dout[95]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[96] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[96]),
        .Q(dout[96]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[97] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[97]),
        .Q(dout[97]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[98] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[98]),
        .Q(dout[98]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[99] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[99]),
        .Q(dout[99]),
        .R(Q));
  FDRE #(
    .INIT(1'b0)) 
    \goreg_bm.dout_i_reg[9] 
       (.C(rd_clk),
        .CE(\gpregsm1.curr_fwft_state_reg[1] ),
        .D(doutb[9]),
        .Q(dout[9]),
        .R(Q));
endmodule

(* ORIG_REF_NAME = "rd_bin_cntr" *) 
module ska_tx_packet_fifo_rd_bin_cntr
   (ram_empty_fb_i_reg,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ,
    ram_empty_fb_i_reg_0,
    Q,
    WR_PNTR_RD,
    E,
    rd_clk,
    \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] );
  output ram_empty_fb_i_reg;
  output [8:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ;
  output ram_empty_fb_i_reg_0;
  output [7:0]Q;
  input [0:0]WR_PNTR_RD;
  input [0:0]E;
  input rd_clk;
  input [0:0]\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ;

  wire [8:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ;
  wire [0:0]E;
  wire [7:0]Q;
  wire [0:0]WR_PNTR_RD;
  wire \gc0.count[8]_i_2_n_0 ;
  wire [0:0]\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ;
  wire [8:0]plusOp__0;
  wire ram_empty_fb_i_reg;
  wire ram_empty_fb_i_reg_0;
  wire rd_clk;
  wire [8:8]rd_pntr_plus1;

  LUT1 #(
    .INIT(2'h1)) 
    \gc0.count[0]_i_1 
       (.I0(Q[0]),
        .O(plusOp__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \gc0.count[1]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(plusOp__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \gc0.count[2]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(plusOp__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \gc0.count[3]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(plusOp__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \gc0.count[4]_i_1 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(plusOp__0[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \gc0.count[5]_i_1 
       (.I0(Q[3]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[2]),
        .I4(Q[4]),
        .I5(Q[5]),
        .O(plusOp__0[5]));
  LUT2 #(
    .INIT(4'h6)) 
    \gc0.count[6]_i_1 
       (.I0(\gc0.count[8]_i_2_n_0 ),
        .I1(Q[6]),
        .O(plusOp__0[6]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \gc0.count[7]_i_1 
       (.I0(\gc0.count[8]_i_2_n_0 ),
        .I1(Q[6]),
        .I2(Q[7]),
        .O(plusOp__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \gc0.count[8]_i_1 
       (.I0(Q[6]),
        .I1(\gc0.count[8]_i_2_n_0 ),
        .I2(Q[7]),
        .I3(rd_pntr_plus1),
        .O(plusOp__0[8]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \gc0.count[8]_i_2 
       (.I0(Q[5]),
        .I1(Q[3]),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[2]),
        .I5(Q[4]),
        .O(\gc0.count[8]_i_2_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(Q[0]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [0]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(Q[1]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [1]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(Q[2]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [2]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(Q[3]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [3]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(Q[4]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [4]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[5] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(Q[5]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [5]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[6] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(Q[6]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [6]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[7] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(Q[7]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [7]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[8] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(rd_pntr_plus1),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [8]));
  FDPE #(
    .INIT(1'b1)) 
    \gc0.count_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .D(plusOp__0[0]),
        .PRE(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(plusOp__0[1]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(plusOp__0[2]),
        .Q(Q[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(plusOp__0[3]),
        .Q(Q[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(plusOp__0[4]),
        .Q(Q[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[5] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(plusOp__0[5]),
        .Q(Q[5]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[6] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(plusOp__0[6]),
        .Q(Q[6]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[7] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(plusOp__0[7]),
        .Q(Q[7]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[8] 
       (.C(rd_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] ),
        .D(plusOp__0[8]),
        .Q(rd_pntr_plus1));
  LUT2 #(
    .INIT(4'h9)) 
    \gmux.gm[4].gms.ms_i_1 
       (.I0(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [8]),
        .I1(WR_PNTR_RD),
        .O(ram_empty_fb_i_reg));
  LUT2 #(
    .INIT(4'h9)) 
    \gmux.gm[4].gms.ms_i_1__0 
       (.I0(rd_pntr_plus1),
        .I1(WR_PNTR_RD),
        .O(ram_empty_fb_i_reg_0));
endmodule

(* ORIG_REF_NAME = "rd_fwft" *) 
module ska_tx_packet_fifo_rd_fwft
   (empty,
    \gpregsm1.curr_fwft_state_reg[1]_0 ,
    tmp_ram_rd_en,
    E,
    \goreg_bm.dout_i_reg[263] ,
    rd_clk,
    Q,
    rd_en,
    p_2_out);
  output empty;
  output [1:0]\gpregsm1.curr_fwft_state_reg[1]_0 ;
  output tmp_ram_rd_en;
  output [0:0]E;
  output [0:0]\goreg_bm.dout_i_reg[263] ;
  input rd_clk;
  input [1:0]Q;
  input rd_en;
  input p_2_out;

  wire [0:0]E;
  wire [1:0]Q;
  wire empty;
  wire empty_fwft_fb;
  wire empty_fwft_i0;
  wire [0:0]\goreg_bm.dout_i_reg[263] ;
  wire [1:0]\gpregsm1.curr_fwft_state_reg[1]_0 ;
  wire [1:0]next_fwft_state;
  wire p_2_out;
  wire rd_clk;
  wire rd_en;
  wire tmp_ram_rd_en;

  LUT5 #(
    .INIT(32'hBABBBBBB)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_i_1 
       (.I0(Q[0]),
        .I1(p_2_out),
        .I2(rd_en),
        .I3(\gpregsm1.curr_fwft_state_reg[1]_0 [0]),
        .I4(\gpregsm1.curr_fwft_state_reg[1]_0 [1]),
        .O(tmp_ram_rd_en));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    empty_fwft_fb_reg
       (.C(rd_clk),
        .CE(1'b1),
        .D(empty_fwft_i0),
        .PRE(Q[1]),
        .Q(empty_fwft_fb));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hBA22)) 
    empty_fwft_i_i_1
       (.I0(empty_fwft_fb),
        .I1(\gpregsm1.curr_fwft_state_reg[1]_0 [1]),
        .I2(rd_en),
        .I3(\gpregsm1.curr_fwft_state_reg[1]_0 [0]),
        .O(empty_fwft_i0));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    empty_fwft_i_reg
       (.C(rd_clk),
        .CE(1'b1),
        .D(empty_fwft_i0),
        .PRE(Q[1]),
        .Q(empty));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h00BF)) 
    \gc0.count_d1[8]_i_1 
       (.I0(rd_en),
        .I1(\gpregsm1.curr_fwft_state_reg[1]_0 [0]),
        .I2(\gpregsm1.curr_fwft_state_reg[1]_0 [1]),
        .I3(p_2_out),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hA2)) 
    \goreg_bm.dout_i[263]_i_1 
       (.I0(\gpregsm1.curr_fwft_state_reg[1]_0 [1]),
        .I1(\gpregsm1.curr_fwft_state_reg[1]_0 [0]),
        .I2(rd_en),
        .O(\goreg_bm.dout_i_reg[263] ));
  LUT3 #(
    .INIT(8'hBA)) 
    \gpregsm1.curr_fwft_state[0]_i_1 
       (.I0(\gpregsm1.curr_fwft_state_reg[1]_0 [1]),
        .I1(rd_en),
        .I2(\gpregsm1.curr_fwft_state_reg[1]_0 [0]),
        .O(next_fwft_state[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h20FF)) 
    \gpregsm1.curr_fwft_state[1]_i_1 
       (.I0(\gpregsm1.curr_fwft_state_reg[1]_0 [1]),
        .I1(rd_en),
        .I2(\gpregsm1.curr_fwft_state_reg[1]_0 [0]),
        .I3(p_2_out),
        .O(next_fwft_state[1]));
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \gpregsm1.curr_fwft_state_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(Q[1]),
        .D(next_fwft_state[0]),
        .Q(\gpregsm1.curr_fwft_state_reg[1]_0 [0]));
  (* equivalent_register_removal = "no" *) 
  FDCE #(
    .INIT(1'b0)) 
    \gpregsm1.curr_fwft_state_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(Q[1]),
        .D(next_fwft_state[1]),
        .Q(\gpregsm1.curr_fwft_state_reg[1]_0 [1]));
endmodule

(* ORIG_REF_NAME = "rd_logic" *) 
module ska_tx_packet_fifo_rd_logic
   (empty,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ,
    \gc0.count_d1_reg[7] ,
    tmp_ram_rd_en,
    E,
    v1_reg,
    v1_reg_0,
    rd_clk,
    Q,
    WR_PNTR_RD,
    rd_en);
  output empty;
  output [8:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ;
  output [7:0]\gc0.count_d1_reg[7] ;
  output tmp_ram_rd_en;
  output [0:0]E;
  input [3:0]v1_reg;
  input [3:0]v1_reg_0;
  input rd_clk;
  input [1:0]Q;
  input [0:0]WR_PNTR_RD;
  input rd_en;

  wire [8:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ;
  wire [0:0]E;
  wire [1:0]Q;
  wire [0:0]WR_PNTR_RD;
  wire [0:0]curr_fwft_state;
  wire empty;
  wire [7:0]\gc0.count_d1_reg[7] ;
  wire \gr1.gr1_int.rfwft_n_1 ;
  wire p_2_out;
  wire p_7_out;
  wire rd_clk;
  wire rd_en;
  wire rpntr_n_0;
  wire rpntr_n_10;
  wire tmp_ram_rd_en;
  wire [3:0]v1_reg;
  wire [3:0]v1_reg_0;

  ska_tx_packet_fifo_rd_fwft \gr1.gr1_int.rfwft 
       (.E(p_7_out),
        .Q(Q),
        .empty(empty),
        .\goreg_bm.dout_i_reg[263] (E),
        .\gpregsm1.curr_fwft_state_reg[1]_0 ({\gr1.gr1_int.rfwft_n_1 ,curr_fwft_state}),
        .p_2_out(p_2_out),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .tmp_ram_rd_en(tmp_ram_rd_en));
  ska_tx_packet_fifo_rd_status_flags_as \gras.rsts 
       (.Q(Q[1]),
        .\gc0.count_d1_reg[8] (rpntr_n_0),
        .\gc0.count_reg[8] (rpntr_n_10),
        .\gpregsm1.curr_fwft_state_reg[1] ({\gr1.gr1_int.rfwft_n_1 ,curr_fwft_state}),
        .p_2_out(p_2_out),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .v1_reg(v1_reg),
        .v1_reg_0(v1_reg_0));
  ska_tx_packet_fifo_rd_bin_cntr rpntr
       (.\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram (\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ),
        .E(p_7_out),
        .Q(\gc0.count_d1_reg[7] ),
        .WR_PNTR_RD(WR_PNTR_RD),
        .\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] (Q[0]),
        .ram_empty_fb_i_reg(rpntr_n_0),
        .ram_empty_fb_i_reg_0(rpntr_n_10),
        .rd_clk(rd_clk));
endmodule

(* ORIG_REF_NAME = "rd_status_flags_as" *) 
module ska_tx_packet_fifo_rd_status_flags_as
   (p_2_out,
    v1_reg,
    \gc0.count_d1_reg[8] ,
    v1_reg_0,
    \gc0.count_reg[8] ,
    rd_clk,
    Q,
    rd_en,
    \gpregsm1.curr_fwft_state_reg[1] );
  output p_2_out;
  input [3:0]v1_reg;
  input \gc0.count_d1_reg[8] ;
  input [3:0]v1_reg_0;
  input \gc0.count_reg[8] ;
  input rd_clk;
  input [0:0]Q;
  input rd_en;
  input [1:0]\gpregsm1.curr_fwft_state_reg[1] ;

  wire [0:0]Q;
  wire c0_n_0;
  wire comp1;
  wire \gc0.count_d1_reg[8] ;
  wire \gc0.count_reg[8] ;
  wire [1:0]\gpregsm1.curr_fwft_state_reg[1] ;
  wire p_2_out;
  wire rd_clk;
  wire rd_en;
  wire [3:0]v1_reg;
  wire [3:0]v1_reg_0;

  ska_tx_packet_fifo_compare_1 c0
       (.comp1(comp1),
        .\gc0.count_d1_reg[8] (\gc0.count_d1_reg[8] ),
        .\gpregsm1.curr_fwft_state_reg[1] (\gpregsm1.curr_fwft_state_reg[1] ),
        .p_2_out(p_2_out),
        .ram_empty_fb_i_reg(c0_n_0),
        .rd_en(rd_en),
        .v1_reg(v1_reg));
  ska_tx_packet_fifo_compare_2 c1
       (.comp1(comp1),
        .\gc0.count_reg[8] (\gc0.count_reg[8] ),
        .v1_reg_0(v1_reg_0));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_empty_fb_i_reg
       (.C(rd_clk),
        .CE(1'b1),
        .D(c0_n_0),
        .PRE(Q),
        .Q(p_2_out));
endmodule

(* ORIG_REF_NAME = "reset_blk_ramfifo" *) 
module ska_tx_packet_fifo_reset_blk_ramfifo
   (out,
    ram_full_fb_i_reg,
    Q,
    ram_empty_fb_i_reg,
    wr_clk,
    rst,
    rd_clk);
  output out;
  output ram_full_fb_i_reg;
  output [2:0]Q;
  output [2:0]ram_empty_fb_i_reg;
  input wr_clk;
  input rst;
  input rd_clk;

  wire [2:0]Q;
  wire \ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1_n_0 ;
  wire \ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1_n_0 ;
  wire \ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1_n_0 ;
  wire \ngwrdrst.grst.g7serrst.wr_rst_reg[2]_i_1_n_0 ;
  wire [2:0]ram_empty_fb_i_reg;
  wire rd_clk;
  wire rd_rst_asreg;
  wire rd_rst_asreg_d1;
  wire rd_rst_asreg_d2;
  wire rst;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d1;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d2;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d3;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_rd_reg1;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_rd_reg2;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_wr_reg1;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_wr_reg2;
  wire wr_clk;
  wire wr_rst_asreg;
  wire wr_rst_asreg_d1;
  wire wr_rst_asreg_d2;

  assign out = rst_d2;
  assign ram_full_fb_i_reg = rst_d3;
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d1_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(rst),
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
        .PRE(rst),
        .Q(rst_d2));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d3_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(rst_d2),
        .PRE(rst),
        .Q(rst_d3));
  FDRE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(rd_rst_asreg),
        .Q(rd_rst_asreg_d1),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(rd_rst_asreg_d1),
        .Q(rd_rst_asreg_d2),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    \ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1 
       (.I0(rd_rst_asreg),
        .I1(rd_rst_asreg_d1),
        .O(\ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1_n_0 ));
  FDPE #(
    .INIT(1'b1)) 
    \ngwrdrst.grst.g7serrst.rd_rst_asreg_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1_n_0 ),
        .PRE(rst_rd_reg2),
        .Q(rd_rst_asreg));
  LUT2 #(
    .INIT(4'h2)) 
    \ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 
       (.I0(rd_rst_asreg),
        .I1(rd_rst_asreg_d2),
        .O(\ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1_n_0 ));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1_n_0 ),
        .Q(ram_empty_fb_i_reg[0]));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1_n_0 ),
        .Q(ram_empty_fb_i_reg[1]));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1_n_0 ),
        .Q(ram_empty_fb_i_reg[2]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.rst_rd_reg1_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(rst),
        .Q(rst_rd_reg1));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.rst_rd_reg2_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(rst_rd_reg1),
        .PRE(rst),
        .Q(rst_rd_reg2));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.rst_wr_reg1_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(rst),
        .Q(rst_wr_reg1));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.rst_wr_reg2_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(rst_wr_reg1),
        .PRE(rst),
        .Q(rst_wr_reg2));
  FDRE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(wr_rst_asreg),
        .Q(wr_rst_asreg_d1),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(wr_rst_asreg_d1),
        .Q(wr_rst_asreg_d2),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    \ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1 
       (.I0(wr_rst_asreg),
        .I1(wr_rst_asreg_d1),
        .O(\ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1_n_0 ));
  FDPE #(
    .INIT(1'b1)) 
    \ngwrdrst.grst.g7serrst.wr_rst_asreg_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1_n_0 ),
        .PRE(rst_wr_reg2),
        .Q(wr_rst_asreg));
  LUT2 #(
    .INIT(4'h2)) 
    \ngwrdrst.grst.g7serrst.wr_rst_reg[2]_i_1 
       (.I0(wr_rst_asreg),
        .I1(wr_rst_asreg_d2),
        .O(\ngwrdrst.grst.g7serrst.wr_rst_reg[2]_i_1_n_0 ));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\ngwrdrst.grst.g7serrst.wr_rst_reg[2]_i_1_n_0 ),
        .Q(Q[0]));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\ngwrdrst.grst.g7serrst.wr_rst_reg[2]_i_1_n_0 ),
        .Q(Q[1]));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\ngwrdrst.grst.g7serrst.wr_rst_reg[2]_i_1_n_0 ),
        .Q(Q[2]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module ska_tx_packet_fifo_synchronizer_ff
   (D,
    Q,
    rd_clk,
    \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] );
  output [8:0]D;
  input [8:0]Q;
  input rd_clk;
  input [0:0]\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ;

  wire [8:0]Q;
  (* async_reg = "true" *) (* msgon = "true" *) wire [8:0]Q_reg;
  wire [0:0]\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ;
  wire rd_clk;

  assign D[8:0] = Q_reg;
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(Q[0]),
        .Q(Q_reg[0]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(Q[1]),
        .Q(Q_reg[1]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(Q[2]),
        .Q(Q_reg[2]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(Q[3]),
        .Q(Q_reg[3]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(Q[4]),
        .Q(Q_reg[4]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(Q[5]),
        .Q(Q_reg[5]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(Q[6]),
        .Q(Q_reg[6]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(Q[7]),
        .Q(Q_reg[7]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[8] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(Q[8]),
        .Q(Q_reg[8]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module ska_tx_packet_fifo_synchronizer_ff_3
   (D,
    Q,
    wr_clk,
    \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] );
  output [8:0]D;
  input [8:0]Q;
  input wr_clk;
  input [0:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ;

  wire [8:0]Q;
  (* async_reg = "true" *) (* msgon = "true" *) wire [8:0]Q_reg;
  wire [0:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ;
  wire wr_clk;

  assign D[8:0] = Q_reg;
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(Q[0]),
        .Q(Q_reg[0]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(Q[1]),
        .Q(Q_reg[1]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(Q[2]),
        .Q(Q_reg[2]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(Q[3]),
        .Q(Q_reg[3]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(Q[4]),
        .Q(Q_reg[4]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(Q[5]),
        .Q(Q_reg[5]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(Q[6]),
        .Q(Q_reg[6]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(Q[7]),
        .Q(Q_reg[7]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(Q[8]),
        .Q(Q_reg[8]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module ska_tx_packet_fifo_synchronizer_ff_4
   (out,
    \wr_pntr_bin_reg[7] ,
    D,
    rd_clk,
    \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] );
  output [0:0]out;
  output [7:0]\wr_pntr_bin_reg[7] ;
  input [8:0]D;
  input rd_clk;
  input [0:0]\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ;

  wire [8:0]D;
  (* async_reg = "true" *) (* msgon = "true" *) wire [8:0]Q_reg;
  wire [0:0]\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ;
  wire rd_clk;
  wire \wr_pntr_bin[1]_i_2_n_0 ;
  wire \wr_pntr_bin[2]_i_2_n_0 ;
  wire [7:0]\wr_pntr_bin_reg[7] ;

  assign out[0] = Q_reg[8];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(D[0]),
        .Q(Q_reg[0]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(D[1]),
        .Q(Q_reg[1]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(D[2]),
        .Q(Q_reg[2]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(D[3]),
        .Q(Q_reg[3]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(D[4]),
        .Q(Q_reg[4]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(D[5]),
        .Q(Q_reg[5]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(D[6]),
        .Q(Q_reg[6]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(D[7]),
        .Q(Q_reg[7]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[8] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] ),
        .D(D[8]),
        .Q(Q_reg[8]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \wr_pntr_bin[0]_i_1 
       (.I0(Q_reg[1]),
        .I1(Q_reg[0]),
        .I2(\wr_pntr_bin[1]_i_2_n_0 ),
        .I3(Q_reg[3]),
        .I4(Q_reg[2]),
        .I5(Q_reg[8]),
        .O(\wr_pntr_bin_reg[7] [0]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \wr_pntr_bin[1]_i_1 
       (.I0(\wr_pntr_bin[1]_i_2_n_0 ),
        .I1(Q_reg[3]),
        .I2(Q_reg[2]),
        .I3(Q_reg[8]),
        .I4(Q_reg[1]),
        .O(\wr_pntr_bin_reg[7] [1]));
  LUT4 #(
    .INIT(16'h6996)) 
    \wr_pntr_bin[1]_i_2 
       (.I0(Q_reg[7]),
        .I1(Q_reg[6]),
        .I2(Q_reg[5]),
        .I3(Q_reg[4]),
        .O(\wr_pntr_bin[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \wr_pntr_bin[2]_i_1 
       (.I0(Q_reg[8]),
        .I1(Q_reg[2]),
        .I2(Q_reg[3]),
        .I3(\wr_pntr_bin[2]_i_2_n_0 ),
        .I4(Q_reg[6]),
        .I5(Q_reg[7]),
        .O(\wr_pntr_bin_reg[7] [2]));
  LUT2 #(
    .INIT(4'h6)) 
    \wr_pntr_bin[2]_i_2 
       (.I0(Q_reg[4]),
        .I1(Q_reg[5]),
        .O(\wr_pntr_bin[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \wr_pntr_bin[3]_i_1 
       (.I0(Q_reg[5]),
        .I1(Q_reg[3]),
        .I2(Q_reg[4]),
        .I3(Q_reg[8]),
        .I4(Q_reg[6]),
        .I5(Q_reg[7]),
        .O(\wr_pntr_bin_reg[7] [3]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \wr_pntr_bin[4]_i_1 
       (.I0(Q_reg[6]),
        .I1(Q_reg[4]),
        .I2(Q_reg[5]),
        .I3(Q_reg[8]),
        .I4(Q_reg[7]),
        .O(\wr_pntr_bin_reg[7] [4]));
  LUT4 #(
    .INIT(16'h6996)) 
    \wr_pntr_bin[5]_i_1 
       (.I0(Q_reg[6]),
        .I1(Q_reg[5]),
        .I2(Q_reg[8]),
        .I3(Q_reg[7]),
        .O(\wr_pntr_bin_reg[7] [5]));
  LUT3 #(
    .INIT(8'h96)) 
    \wr_pntr_bin[6]_i_1 
       (.I0(Q_reg[7]),
        .I1(Q_reg[6]),
        .I2(Q_reg[8]),
        .O(\wr_pntr_bin_reg[7] [6]));
  LUT2 #(
    .INIT(4'h6)) 
    \wr_pntr_bin[7]_i_1 
       (.I0(Q_reg[7]),
        .I1(Q_reg[8]),
        .O(\wr_pntr_bin_reg[7] [7]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module ska_tx_packet_fifo_synchronizer_ff_5
   (out,
    \rd_pntr_bin_reg[7] ,
    D,
    wr_clk,
    \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] );
  output [0:0]out;
  output [7:0]\rd_pntr_bin_reg[7] ;
  input [8:0]D;
  input wr_clk;
  input [0:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ;

  wire [8:0]D;
  (* async_reg = "true" *) (* msgon = "true" *) wire [8:0]Q_reg;
  wire [0:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ;
  wire \rd_pntr_bin[1]_i_2_n_0 ;
  wire \rd_pntr_bin[2]_i_2_n_0 ;
  wire [7:0]\rd_pntr_bin_reg[7] ;
  wire wr_clk;

  assign out[0] = Q_reg[8];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(D[0]),
        .Q(Q_reg[0]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(D[1]),
        .Q(Q_reg[1]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(D[2]),
        .Q(Q_reg[2]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(D[3]),
        .Q(Q_reg[3]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(D[4]),
        .Q(Q_reg[4]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(D[5]),
        .Q(Q_reg[5]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(D[6]),
        .Q(Q_reg[6]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(D[7]),
        .Q(Q_reg[7]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDCE #(
    .INIT(1'b0)) 
    \Q_reg_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] ),
        .D(D[8]),
        .Q(Q_reg[8]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \rd_pntr_bin[0]_i_1 
       (.I0(Q_reg[1]),
        .I1(Q_reg[0]),
        .I2(\rd_pntr_bin[1]_i_2_n_0 ),
        .I3(Q_reg[3]),
        .I4(Q_reg[2]),
        .I5(Q_reg[8]),
        .O(\rd_pntr_bin_reg[7] [0]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \rd_pntr_bin[1]_i_1 
       (.I0(\rd_pntr_bin[1]_i_2_n_0 ),
        .I1(Q_reg[3]),
        .I2(Q_reg[2]),
        .I3(Q_reg[8]),
        .I4(Q_reg[1]),
        .O(\rd_pntr_bin_reg[7] [1]));
  LUT4 #(
    .INIT(16'h6996)) 
    \rd_pntr_bin[1]_i_2 
       (.I0(Q_reg[7]),
        .I1(Q_reg[6]),
        .I2(Q_reg[5]),
        .I3(Q_reg[4]),
        .O(\rd_pntr_bin[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \rd_pntr_bin[2]_i_1 
       (.I0(Q_reg[8]),
        .I1(Q_reg[2]),
        .I2(Q_reg[3]),
        .I3(\rd_pntr_bin[2]_i_2_n_0 ),
        .I4(Q_reg[6]),
        .I5(Q_reg[7]),
        .O(\rd_pntr_bin_reg[7] [2]));
  LUT2 #(
    .INIT(4'h6)) 
    \rd_pntr_bin[2]_i_2 
       (.I0(Q_reg[4]),
        .I1(Q_reg[5]),
        .O(\rd_pntr_bin[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \rd_pntr_bin[3]_i_1 
       (.I0(Q_reg[5]),
        .I1(Q_reg[3]),
        .I2(Q_reg[4]),
        .I3(Q_reg[8]),
        .I4(Q_reg[6]),
        .I5(Q_reg[7]),
        .O(\rd_pntr_bin_reg[7] [3]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \rd_pntr_bin[4]_i_1 
       (.I0(Q_reg[6]),
        .I1(Q_reg[4]),
        .I2(Q_reg[5]),
        .I3(Q_reg[8]),
        .I4(Q_reg[7]),
        .O(\rd_pntr_bin_reg[7] [4]));
  LUT4 #(
    .INIT(16'h6996)) 
    \rd_pntr_bin[5]_i_1 
       (.I0(Q_reg[6]),
        .I1(Q_reg[5]),
        .I2(Q_reg[8]),
        .I3(Q_reg[7]),
        .O(\rd_pntr_bin_reg[7] [5]));
  LUT3 #(
    .INIT(8'h96)) 
    \rd_pntr_bin[6]_i_1 
       (.I0(Q_reg[7]),
        .I1(Q_reg[6]),
        .I2(Q_reg[8]),
        .O(\rd_pntr_bin_reg[7] [6]));
  LUT2 #(
    .INIT(4'h6)) 
    \rd_pntr_bin[7]_i_1 
       (.I0(Q_reg[7]),
        .I1(Q_reg[8]),
        .O(\rd_pntr_bin_reg[7] [7]));
endmodule

(* ORIG_REF_NAME = "wr_bin_cntr" *) 
module ska_tx_packet_fifo_wr_bin_cntr
   (S,
    Q,
    \gdiff.diff_pntr_pad_reg[8] ,
    \gdiff.diff_pntr_pad_reg[9] ,
    \gic0.gc0.count_d1_reg[8]_0 ,
    v1_reg,
    v1_reg_0,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ,
    RD_PNTR_WR,
    E,
    wr_clk,
    \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] );
  output [3:0]S;
  output [8:0]Q;
  output [3:0]\gdiff.diff_pntr_pad_reg[8] ;
  output [0:0]\gdiff.diff_pntr_pad_reg[9] ;
  output [0:0]\gic0.gc0.count_d1_reg[8]_0 ;
  output [3:0]v1_reg;
  output [3:0]v1_reg_0;
  output [8:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ;
  input [8:0]RD_PNTR_WR;
  input [0:0]E;
  input wr_clk;
  input [0:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ;

  wire [8:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ;
  wire [0:0]E;
  wire [8:0]Q;
  wire [8:0]RD_PNTR_WR;
  wire [3:0]S;
  wire [3:0]\gdiff.diff_pntr_pad_reg[8] ;
  wire [0:0]\gdiff.diff_pntr_pad_reg[9] ;
  wire \gic0.gc0.count[8]_i_2_n_0 ;
  wire [0:0]\gic0.gc0.count_d1_reg[8]_0 ;
  wire [0:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ;
  wire [8:0]plusOp__1;
  wire [3:0]v1_reg;
  wire [3:0]v1_reg_0;
  wire wr_clk;
  wire [7:0]wr_pntr_plus2;

  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \gic0.gc0.count[0]_i_1 
       (.I0(wr_pntr_plus2[0]),
        .O(plusOp__1[0]));
  LUT2 #(
    .INIT(4'h6)) 
    \gic0.gc0.count[1]_i_1 
       (.I0(wr_pntr_plus2[0]),
        .I1(wr_pntr_plus2[1]),
        .O(plusOp__1[1]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \gic0.gc0.count[2]_i_1 
       (.I0(wr_pntr_plus2[0]),
        .I1(wr_pntr_plus2[1]),
        .I2(wr_pntr_plus2[2]),
        .O(plusOp__1[2]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \gic0.gc0.count[3]_i_1 
       (.I0(wr_pntr_plus2[1]),
        .I1(wr_pntr_plus2[0]),
        .I2(wr_pntr_plus2[2]),
        .I3(wr_pntr_plus2[3]),
        .O(plusOp__1[3]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \gic0.gc0.count[4]_i_1 
       (.I0(wr_pntr_plus2[2]),
        .I1(wr_pntr_plus2[0]),
        .I2(wr_pntr_plus2[1]),
        .I3(wr_pntr_plus2[3]),
        .I4(wr_pntr_plus2[4]),
        .O(plusOp__1[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \gic0.gc0.count[5]_i_1 
       (.I0(wr_pntr_plus2[3]),
        .I1(wr_pntr_plus2[1]),
        .I2(wr_pntr_plus2[0]),
        .I3(wr_pntr_plus2[2]),
        .I4(wr_pntr_plus2[4]),
        .I5(wr_pntr_plus2[5]),
        .O(plusOp__1[5]));
  LUT2 #(
    .INIT(4'h6)) 
    \gic0.gc0.count[6]_i_1 
       (.I0(\gic0.gc0.count[8]_i_2_n_0 ),
        .I1(wr_pntr_plus2[6]),
        .O(plusOp__1[6]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \gic0.gc0.count[7]_i_1 
       (.I0(\gic0.gc0.count[8]_i_2_n_0 ),
        .I1(wr_pntr_plus2[6]),
        .I2(wr_pntr_plus2[7]),
        .O(plusOp__1[7]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \gic0.gc0.count[8]_i_1 
       (.I0(wr_pntr_plus2[6]),
        .I1(\gic0.gc0.count[8]_i_2_n_0 ),
        .I2(wr_pntr_plus2[7]),
        .I3(\gic0.gc0.count_d1_reg[8]_0 ),
        .O(plusOp__1[8]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \gic0.gc0.count[8]_i_2 
       (.I0(wr_pntr_plus2[5]),
        .I1(wr_pntr_plus2[3]),
        .I2(wr_pntr_plus2[1]),
        .I3(wr_pntr_plus2[0]),
        .I4(wr_pntr_plus2[2]),
        .I5(wr_pntr_plus2[4]),
        .O(\gic0.gc0.count[8]_i_2_n_0 ));
  FDPE #(
    .INIT(1'b1)) 
    \gic0.gc0.count_d1_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .D(wr_pntr_plus2[0]),
        .PRE(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(wr_pntr_plus2[1]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(wr_pntr_plus2[2]),
        .Q(Q[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(wr_pntr_plus2[3]),
        .Q(Q[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(wr_pntr_plus2[4]),
        .Q(Q[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[5] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(wr_pntr_plus2[5]),
        .Q(Q[5]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[6] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(wr_pntr_plus2[6]),
        .Q(Q[6]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[7] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(wr_pntr_plus2[7]),
        .Q(Q[7]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[8] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(\gic0.gc0.count_d1_reg[8]_0 ),
        .Q(Q[8]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(Q[0]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [0]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(Q[1]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [1]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(Q[2]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [2]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(Q[3]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [3]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(Q[4]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [4]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[5] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(Q[5]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [5]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[6] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(Q[6]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [6]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[7] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(Q[7]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [7]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[8] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(Q[8]),
        .Q(\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram [8]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(plusOp__1[0]),
        .Q(wr_pntr_plus2[0]));
  FDPE #(
    .INIT(1'b1)) 
    \gic0.gc0.count_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .D(plusOp__1[1]),
        .PRE(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .Q(wr_pntr_plus2[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(plusOp__1[2]),
        .Q(wr_pntr_plus2[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(plusOp__1[3]),
        .Q(wr_pntr_plus2[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(plusOp__1[4]),
        .Q(wr_pntr_plus2[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[5] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(plusOp__1[5]),
        .Q(wr_pntr_plus2[5]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[6] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(plusOp__1[6]),
        .Q(wr_pntr_plus2[6]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[7] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(plusOp__1[7]),
        .Q(wr_pntr_plus2[7]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[8] 
       (.C(wr_clk),
        .CE(E),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ),
        .D(plusOp__1[8]),
        .Q(\gic0.gc0.count_d1_reg[8]_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[0].gm1.m1_i_1__1 
       (.I0(Q[0]),
        .I1(RD_PNTR_WR[0]),
        .I2(Q[1]),
        .I3(RD_PNTR_WR[1]),
        .O(v1_reg[0]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[0].gm1.m1_i_1__2 
       (.I0(wr_pntr_plus2[0]),
        .I1(RD_PNTR_WR[0]),
        .I2(wr_pntr_plus2[1]),
        .I3(RD_PNTR_WR[1]),
        .O(v1_reg_0[0]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[1].gms.ms_i_1__1 
       (.I0(Q[2]),
        .I1(RD_PNTR_WR[2]),
        .I2(Q[3]),
        .I3(RD_PNTR_WR[3]),
        .O(v1_reg[1]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[1].gms.ms_i_1__2 
       (.I0(wr_pntr_plus2[2]),
        .I1(RD_PNTR_WR[2]),
        .I2(wr_pntr_plus2[3]),
        .I3(RD_PNTR_WR[3]),
        .O(v1_reg_0[1]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[2].gms.ms_i_1__1 
       (.I0(Q[4]),
        .I1(RD_PNTR_WR[4]),
        .I2(Q[5]),
        .I3(RD_PNTR_WR[5]),
        .O(v1_reg[2]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[2].gms.ms_i_1__2 
       (.I0(wr_pntr_plus2[4]),
        .I1(RD_PNTR_WR[4]),
        .I2(wr_pntr_plus2[5]),
        .I3(RD_PNTR_WR[5]),
        .O(v1_reg_0[2]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[3].gms.ms_i_1__1 
       (.I0(Q[6]),
        .I1(RD_PNTR_WR[6]),
        .I2(Q[7]),
        .I3(RD_PNTR_WR[7]),
        .O(v1_reg[3]));
  LUT4 #(
    .INIT(16'h9009)) 
    \gmux.gm[3].gms.ms_i_1__2 
       (.I0(wr_pntr_plus2[6]),
        .I1(RD_PNTR_WR[6]),
        .I2(wr_pntr_plus2[7]),
        .I3(RD_PNTR_WR[7]),
        .O(v1_reg_0[3]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry__0_i_1
       (.I0(Q[7]),
        .I1(RD_PNTR_WR[7]),
        .O(\gdiff.diff_pntr_pad_reg[8] [3]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry__0_i_2
       (.I0(Q[6]),
        .I1(RD_PNTR_WR[6]),
        .O(\gdiff.diff_pntr_pad_reg[8] [2]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry__0_i_3
       (.I0(Q[5]),
        .I1(RD_PNTR_WR[5]),
        .O(\gdiff.diff_pntr_pad_reg[8] [1]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry__0_i_4
       (.I0(Q[4]),
        .I1(RD_PNTR_WR[4]),
        .O(\gdiff.diff_pntr_pad_reg[8] [0]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry__1_i_1
       (.I0(Q[8]),
        .I1(RD_PNTR_WR[8]),
        .O(\gdiff.diff_pntr_pad_reg[9] ));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry_i_1
       (.I0(Q[3]),
        .I1(RD_PNTR_WR[3]),
        .O(S[3]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry_i_2
       (.I0(Q[2]),
        .I1(RD_PNTR_WR[2]),
        .O(S[2]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry_i_3
       (.I0(Q[1]),
        .I1(RD_PNTR_WR[1]),
        .O(S[1]));
  LUT2 #(
    .INIT(4'h9)) 
    plusOp_carry_i_4
       (.I0(Q[0]),
        .I1(RD_PNTR_WR[0]),
        .O(S[0]));
endmodule

(* ORIG_REF_NAME = "wr_handshaking_flags" *) 
module ska_tx_packet_fifo_wr_handshaking_flags
   (overflow,
    ram_full_fb_i_reg,
    wr_clk);
  output overflow;
  input ram_full_fb_i_reg;
  input wr_clk;

  wire overflow;
  wire ram_full_fb_i_reg;
  wire wr_clk;

  FDRE #(
    .INIT(1'b0)) 
    \gof.gof1.overflow_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_full_fb_i_reg),
        .Q(overflow),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "wr_logic" *) 
module ska_tx_packet_fifo_wr_logic
   (full,
    overflow,
    prog_full,
    Q,
    E,
    \gic0.gc0.count_d1_reg[8] ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ,
    \rd_pntr_bin_reg[8] ,
    \rd_pntr_bin_reg[8]_0 ,
    wr_clk,
    out,
    RD_PNTR_WR,
    wr_en,
    \grstd1.grst_full.grst_f.rst_d3_reg ,
    \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] );
  output full;
  output overflow;
  output prog_full;
  output [0:0]Q;
  output [0:0]E;
  output [0:0]\gic0.gc0.count_d1_reg[8] ;
  output [8:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ;
  input \rd_pntr_bin_reg[8] ;
  input \rd_pntr_bin_reg[8]_0 ;
  input wr_clk;
  input out;
  input [8:0]RD_PNTR_WR;
  input wr_en;
  input \grstd1.grst_full.grst_f.rst_d3_reg ;
  input [1:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ;

  wire [8:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ;
  wire [0:0]E;
  wire [0:0]Q;
  wire [8:0]RD_PNTR_WR;
  wire [3:0]\c1/v1_reg ;
  wire [3:0]\c2/v1_reg ;
  wire full;
  wire [0:0]\gic0.gc0.count_d1_reg[8] ;
  wire \grstd1.grst_full.grst_f.rst_d3_reg ;
  wire \gwas.wsts_n_3 ;
  wire [1:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] ;
  wire out;
  wire overflow;
  wire [7:0]p_13_out;
  wire p_1_out;
  wire prog_full;
  wire \rd_pntr_bin_reg[8] ;
  wire \rd_pntr_bin_reg[8]_0 ;
  wire wpntr_n_0;
  wire wpntr_n_1;
  wire wpntr_n_13;
  wire wpntr_n_14;
  wire wpntr_n_15;
  wire wpntr_n_16;
  wire wpntr_n_17;
  wire wpntr_n_2;
  wire wpntr_n_3;
  wire wr_clk;
  wire wr_en;

  ska_tx_packet_fifo_wr_pf_as \gwas.gpf.wrpf 
       (.E(E),
        .Q(p_13_out),
        .S({wpntr_n_0,wpntr_n_1,wpntr_n_2,wpntr_n_3}),
        .\gic0.gc0.count_d1_reg[7] ({wpntr_n_13,wpntr_n_14,wpntr_n_15,wpntr_n_16}),
        .\gic0.gc0.count_d1_reg[8] (wpntr_n_17),
        .\grstd1.grst_full.grst_f.rst_d3_reg (\grstd1.grst_full.grst_f.rst_d3_reg ),
        .\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] (\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] [0]),
        .out(out),
        .p_1_out(p_1_out),
        .prog_full(prog_full),
        .wr_clk(wr_clk));
  ska_tx_packet_fifo_wr_status_flags_as \gwas.wsts 
       (.E(E),
        .full(full),
        .\gof.gof1.overflow_i_reg (\gwas.wsts_n_3 ),
        .\grstd1.grst_full.grst_f.rst_d3_reg (\grstd1.grst_full.grst_f.rst_d3_reg ),
        .out(out),
        .p_1_out(p_1_out),
        .\rd_pntr_bin_reg[8] (\rd_pntr_bin_reg[8] ),
        .\rd_pntr_bin_reg[8]_0 (\rd_pntr_bin_reg[8]_0 ),
        .v1_reg(\c1/v1_reg ),
        .v1_reg_0(\c2/v1_reg ),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
  ska_tx_packet_fifo_wr_handshaking_flags \gwhf.whf 
       (.overflow(overflow),
        .ram_full_fb_i_reg(\gwas.wsts_n_3 ),
        .wr_clk(wr_clk));
  ska_tx_packet_fifo_wr_bin_cntr wpntr
       (.\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram (\DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram ),
        .E(E),
        .Q({Q,p_13_out}),
        .RD_PNTR_WR(RD_PNTR_WR),
        .S({wpntr_n_0,wpntr_n_1,wpntr_n_2,wpntr_n_3}),
        .\gdiff.diff_pntr_pad_reg[8] ({wpntr_n_13,wpntr_n_14,wpntr_n_15,wpntr_n_16}),
        .\gdiff.diff_pntr_pad_reg[9] (wpntr_n_17),
        .\gic0.gc0.count_d1_reg[8]_0 (\gic0.gc0.count_d1_reg[8] ),
        .\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] (\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[2] [1]),
        .v1_reg(\c1/v1_reg ),
        .v1_reg_0(\c2/v1_reg ),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "wr_pf_as" *) 
module ska_tx_packet_fifo_wr_pf_as
   (prog_full,
    wr_clk,
    out,
    E,
    Q,
    S,
    \gic0.gc0.count_d1_reg[7] ,
    \gic0.gc0.count_d1_reg[8] ,
    \grstd1.grst_full.grst_f.rst_d3_reg ,
    p_1_out,
    \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] );
  output prog_full;
  input wr_clk;
  input out;
  input [0:0]E;
  input [7:0]Q;
  input [3:0]S;
  input [3:0]\gic0.gc0.count_d1_reg[7] ;
  input [0:0]\gic0.gc0.count_d1_reg[8] ;
  input \grstd1.grst_full.grst_f.rst_d3_reg ;
  input p_1_out;
  input [0:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ;

  wire [0:0]E;
  wire [7:0]Q;
  wire [3:0]S;
  wire [8:0]diff_pntr;
  wire [3:0]\gic0.gc0.count_d1_reg[7] ;
  wire [0:0]\gic0.gc0.count_d1_reg[8] ;
  wire \gpf1.prog_full_i_i_1_n_0 ;
  wire \gpf1.prog_full_i_i_2_n_0 ;
  wire \gpf1.prog_full_i_i_3_n_0 ;
  wire \grstd1.grst_full.grst_f.rst_d3_reg ;
  wire [0:0]\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ;
  wire out;
  wire p_1_out;
  wire [9:1]plusOp;
  wire plusOp_carry__0_n_0;
  wire plusOp_carry__0_n_1;
  wire plusOp_carry__0_n_2;
  wire plusOp_carry__0_n_3;
  wire plusOp_carry_n_0;
  wire plusOp_carry_n_1;
  wire plusOp_carry_n_2;
  wire plusOp_carry_n_3;
  wire prog_full;
  wire wr_clk;
  wire [3:0]NLW_plusOp_carry__1_CO_UNCONNECTED;
  wire [3:1]NLW_plusOp_carry__1_O_UNCONNECTED;

  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ),
        .D(plusOp[1]),
        .Q(diff_pntr[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ),
        .D(plusOp[2]),
        .Q(diff_pntr[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ),
        .D(plusOp[3]),
        .Q(diff_pntr[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ),
        .D(plusOp[4]),
        .Q(diff_pntr[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ),
        .D(plusOp[5]),
        .Q(diff_pntr[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ),
        .D(plusOp[6]),
        .Q(diff_pntr[5]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ),
        .D(plusOp[7]),
        .Q(diff_pntr[6]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ),
        .D(plusOp[8]),
        .Q(diff_pntr[7]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[9] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] ),
        .D(plusOp[9]),
        .Q(diff_pntr[8]));
  LUT5 #(
    .INIT(32'h0F010001)) 
    \gpf1.prog_full_i_i_1 
       (.I0(\gpf1.prog_full_i_i_2_n_0 ),
        .I1(\gpf1.prog_full_i_i_3_n_0 ),
        .I2(\grstd1.grst_full.grst_f.rst_d3_reg ),
        .I3(p_1_out),
        .I4(prog_full),
        .O(\gpf1.prog_full_i_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h777FFFFF)) 
    \gpf1.prog_full_i_i_2 
       (.I0(diff_pntr[2]),
        .I1(diff_pntr[3]),
        .I2(diff_pntr[0]),
        .I3(diff_pntr[1]),
        .I4(diff_pntr[6]),
        .O(\gpf1.prog_full_i_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \gpf1.prog_full_i_i_3 
       (.I0(diff_pntr[7]),
        .I1(diff_pntr[8]),
        .I2(diff_pntr[4]),
        .I3(diff_pntr[5]),
        .O(\gpf1.prog_full_i_i_3_n_0 ));
  FDPE #(
    .INIT(1'b1)) 
    \gpf1.prog_full_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gpf1.prog_full_i_i_1_n_0 ),
        .PRE(out),
        .Q(prog_full));
  CARRY4 plusOp_carry
       (.CI(1'b0),
        .CO({plusOp_carry_n_0,plusOp_carry_n_1,plusOp_carry_n_2,plusOp_carry_n_3}),
        .CYINIT(E),
        .DI(Q[3:0]),
        .O(plusOp[4:1]),
        .S(S));
  CARRY4 plusOp_carry__0
       (.CI(plusOp_carry_n_0),
        .CO({plusOp_carry__0_n_0,plusOp_carry__0_n_1,plusOp_carry__0_n_2,plusOp_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(Q[7:4]),
        .O(plusOp[8:5]),
        .S(\gic0.gc0.count_d1_reg[7] ));
  CARRY4 plusOp_carry__1
       (.CI(plusOp_carry__0_n_0),
        .CO(NLW_plusOp_carry__1_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_plusOp_carry__1_O_UNCONNECTED[3:1],plusOp[9]}),
        .S({1'b0,1'b0,1'b0,\gic0.gc0.count_d1_reg[8] }));
endmodule

(* ORIG_REF_NAME = "wr_status_flags_as" *) 
module ska_tx_packet_fifo_wr_status_flags_as
   (full,
    p_1_out,
    E,
    \gof.gof1.overflow_i_reg ,
    v1_reg,
    \rd_pntr_bin_reg[8] ,
    v1_reg_0,
    \rd_pntr_bin_reg[8]_0 ,
    wr_clk,
    out,
    wr_en,
    \grstd1.grst_full.grst_f.rst_d3_reg );
  output full;
  output p_1_out;
  output [0:0]E;
  output \gof.gof1.overflow_i_reg ;
  input [3:0]v1_reg;
  input \rd_pntr_bin_reg[8] ;
  input [3:0]v1_reg_0;
  input \rd_pntr_bin_reg[8]_0 ;
  input wr_clk;
  input out;
  input wr_en;
  input \grstd1.grst_full.grst_f.rst_d3_reg ;

  wire [0:0]E;
  wire comp1;
  wire full;
  wire \gof.gof1.overflow_i_reg ;
  wire \grstd1.grst_full.grst_f.rst_d3_reg ;
  wire out;
  wire p_1_out;
  wire ram_full_i;
  wire \rd_pntr_bin_reg[8] ;
  wire \rd_pntr_bin_reg[8]_0 ;
  wire [3:0]v1_reg;
  wire [3:0]v1_reg_0;
  wire wr_clk;
  wire wr_en;

  LUT2 #(
    .INIT(4'h2)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_i_2 
       (.I0(wr_en),
        .I1(p_1_out),
        .O(E));
  ska_tx_packet_fifo_compare c1
       (.comp1(comp1),
        .\rd_pntr_bin_reg[8] (\rd_pntr_bin_reg[8] ),
        .v1_reg(v1_reg));
  ska_tx_packet_fifo_compare_0 c2
       (.comp1(comp1),
        .\grstd1.grst_full.grst_f.rst_d3_reg (\grstd1.grst_full.grst_f.rst_d3_reg ),
        .ram_full_fb_i_reg(p_1_out),
        .ram_full_i(ram_full_i),
        .\rd_pntr_bin_reg[8] (\rd_pntr_bin_reg[8]_0 ),
        .v1_reg_0(v1_reg_0),
        .wr_en(wr_en));
  LUT2 #(
    .INIT(4'h8)) 
    \gof.gof1.overflow_i_i_1 
       (.I0(wr_en),
        .I1(p_1_out),
        .O(\gof.gof1.overflow_i_reg ));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_full_fb_i_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_full_i),
        .PRE(out),
        .Q(p_1_out));
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_full_i_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_full_i),
        .PRE(out),
        .Q(full));
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
