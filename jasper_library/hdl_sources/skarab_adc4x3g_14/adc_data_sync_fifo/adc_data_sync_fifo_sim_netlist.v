// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Fri Nov  2 13:30:45 2018
// Host        : adam-cm running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aisaacson/work/git_work/ska_sa/projects/mlib_devel/jasper_library/test_models/test_skarab_adc/myproj/myproj.srcs/sources_1/ip/adc_data_sync_fifo/adc_data_sync_fifo_sim_netlist.v
// Design      : adc_data_sync_fifo
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "adc_data_sync_fifo,fifo_generator_v13_2_2,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v13_2_2,Vivado 2018.2" *) 
(* NotValidForBitStream *)
module adc_data_sync_fifo
   (clk,
    srst,
    din,
    wr_en,
    rd_en,
    dout,
    full,
    empty);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 core_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME core_clk, FREQ_HZ 100000000, PHASE 0.000" *) input clk;
  input srst;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_DATA" *) input [128:0]din;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *) input wr_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *) input rd_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_DATA" *) output [128:0]dout;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *) output full;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ EMPTY" *) output empty;

  wire clk;
  wire [128:0]din;
  wire [128:0]dout;
  wire empty;
  wire full;
  wire rd_en;
  wire srst;
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
  wire [3:0]NLW_U0_data_count_UNCONNECTED;
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
  wire [3:0]NLW_U0_rd_data_count_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_buser_UNCONNECTED;
  wire [63:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_ruser_UNCONNECTED;
  wire [3:0]NLW_U0_wr_data_count_UNCONNECTED;

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
  (* C_DATA_COUNT_WIDTH = "4" *) 
  (* C_DEFAULT_VALUE = "BlankString" *) 
  (* C_DIN_WIDTH = "129" *) 
  (* C_DIN_WIDTH_AXIS = "1" *) 
  (* C_DIN_WIDTH_RACH = "32" *) 
  (* C_DIN_WIDTH_RDCH = "64" *) 
  (* C_DIN_WIDTH_WACH = "1" *) 
  (* C_DIN_WIDTH_WDCH = "64" *) 
  (* C_DIN_WIDTH_WRCH = "2" *) 
  (* C_DOUT_RST_VAL = "0" *) 
  (* C_DOUT_WIDTH = "129" *) 
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
  (* C_FULL_FLAGS_RST_VAL = "0" *) 
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
  (* C_HAS_RST = "0" *) 
  (* C_HAS_SLAVE_CE = "0" *) 
  (* C_HAS_SRST = "1" *) 
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
  (* C_PROG_FULL_THRESH_ASSERT_VAL = "14" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
  (* C_PROG_FULL_THRESH_NEGATE_VAL = "13" *) 
  (* C_PROG_FULL_TYPE = "0" *) 
  (* C_PROG_FULL_TYPE_AXIS = "0" *) 
  (* C_PROG_FULL_TYPE_RACH = "0" *) 
  (* C_PROG_FULL_TYPE_RDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WACH = "0" *) 
  (* C_PROG_FULL_TYPE_WDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WRCH = "0" *) 
  (* C_RACH_TYPE = "0" *) 
  (* C_RDCH_TYPE = "0" *) 
  (* C_RD_DATA_COUNT_WIDTH = "4" *) 
  (* C_RD_DEPTH = "16" *) 
  (* C_RD_FREQ = "1" *) 
  (* C_RD_PNTR_WIDTH = "4" *) 
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
  (* C_WR_DATA_COUNT_WIDTH = "4" *) 
  (* C_WR_DEPTH = "16" *) 
  (* C_WR_DEPTH_AXIS = "1024" *) 
  (* C_WR_DEPTH_RACH = "16" *) 
  (* C_WR_DEPTH_RDCH = "1024" *) 
  (* C_WR_DEPTH_WACH = "16" *) 
  (* C_WR_DEPTH_WDCH = "1024" *) 
  (* C_WR_DEPTH_WRCH = "16" *) 
  (* C_WR_FREQ = "1" *) 
  (* C_WR_PNTR_WIDTH = "4" *) 
  (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
  (* C_WR_PNTR_WIDTH_RACH = "4" *) 
  (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WACH = "4" *) 
  (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
  (* C_WR_RESPONSE_LATENCY = "1" *) 
  adc_data_sync_fifo_fifo_generator_v13_2_2 U0
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
        .data_count(NLW_U0_data_count_UNCONNECTED[3:0]),
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
        .prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_assert({1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_negate({1'b0,1'b0,1'b0,1'b0}),
        .prog_full(NLW_U0_prog_full_UNCONNECTED),
        .prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_assert({1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_negate({1'b0,1'b0,1'b0,1'b0}),
        .rd_clk(1'b0),
        .rd_data_count(NLW_U0_rd_data_count_UNCONNECTED[3:0]),
        .rd_en(rd_en),
        .rd_rst(1'b0),
        .rd_rst_busy(NLW_U0_rd_rst_busy_UNCONNECTED),
        .rst(1'b0),
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
        .srst(srst),
        .underflow(NLW_U0_underflow_UNCONNECTED),
        .valid(NLW_U0_valid_UNCONNECTED),
        .wr_ack(NLW_U0_wr_ack_UNCONNECTED),
        .wr_clk(1'b0),
        .wr_data_count(NLW_U0_wr_data_count_UNCONNECTED[3:0]),
        .wr_en(wr_en),
        .wr_rst(1'b0),
        .wr_rst_busy(NLW_U0_wr_rst_busy_UNCONNECTED));
endmodule

(* ORIG_REF_NAME = "dmem" *) 
module adc_data_sync_fifo_dmem
   (dout,
    clk,
    E,
    din,
    \gc0.count_d1_reg[3] ,
    Q,
    srst,
    ram_empty_fb_i_reg);
  output [128:0]dout;
  input clk;
  input [0:0]E;
  input [128:0]din;
  input [3:0]\gc0.count_d1_reg[3] ;
  input [3:0]Q;
  input srst;
  input [0:0]ram_empty_fb_i_reg;

  wire [0:0]E;
  wire [3:0]Q;
  wire clk;
  wire [128:0]din;
  wire [128:0]dout;
  wire [3:0]\gc0.count_d1_reg[3] ;
  wire [128:0]p_0_out;
  wire [0:0]ram_empty_fb_i_reg;
  wire srst;
  wire [1:0]NLW_RAM_reg_0_15_0_5_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_102_107_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_108_113_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_114_119_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_120_125_DOD_UNCONNECTED;
  wire [1:1]NLW_RAM_reg_0_15_126_128_DOB_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_126_128_DOC_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_126_128_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_12_17_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_18_23_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_24_29_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_30_35_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_36_41_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_42_47_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_48_53_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_54_59_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_60_65_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_66_71_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_6_11_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_72_77_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_78_83_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_84_89_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_90_95_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_96_101_DOD_UNCONNECTED;

  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_0_5
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[1:0]),
        .DIB(din[3:2]),
        .DIC(din[5:4]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[1:0]),
        .DOB(p_0_out[3:2]),
        .DOC(p_0_out[5:4]),
        .DOD(NLW_RAM_reg_0_15_0_5_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_102_107
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[103:102]),
        .DIB(din[105:104]),
        .DIC(din[107:106]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[103:102]),
        .DOB(p_0_out[105:104]),
        .DOC(p_0_out[107:106]),
        .DOD(NLW_RAM_reg_0_15_102_107_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_108_113
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[109:108]),
        .DIB(din[111:110]),
        .DIC(din[113:112]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[109:108]),
        .DOB(p_0_out[111:110]),
        .DOC(p_0_out[113:112]),
        .DOD(NLW_RAM_reg_0_15_108_113_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_114_119
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[115:114]),
        .DIB(din[117:116]),
        .DIC(din[119:118]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[115:114]),
        .DOB(p_0_out[117:116]),
        .DOC(p_0_out[119:118]),
        .DOD(NLW_RAM_reg_0_15_114_119_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_120_125
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[121:120]),
        .DIB(din[123:122]),
        .DIC(din[125:124]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[121:120]),
        .DOB(p_0_out[123:122]),
        .DOC(p_0_out[125:124]),
        .DOD(NLW_RAM_reg_0_15_120_125_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_126_128
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[127:126]),
        .DIB({1'b0,din[128]}),
        .DIC({1'b0,1'b0}),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[127:126]),
        .DOB({NLW_RAM_reg_0_15_126_128_DOB_UNCONNECTED[1],p_0_out[128]}),
        .DOC(NLW_RAM_reg_0_15_126_128_DOC_UNCONNECTED[1:0]),
        .DOD(NLW_RAM_reg_0_15_126_128_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_12_17
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[13:12]),
        .DIB(din[15:14]),
        .DIC(din[17:16]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[13:12]),
        .DOB(p_0_out[15:14]),
        .DOC(p_0_out[17:16]),
        .DOD(NLW_RAM_reg_0_15_12_17_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_18_23
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[19:18]),
        .DIB(din[21:20]),
        .DIC(din[23:22]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[19:18]),
        .DOB(p_0_out[21:20]),
        .DOC(p_0_out[23:22]),
        .DOD(NLW_RAM_reg_0_15_18_23_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_24_29
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[25:24]),
        .DIB(din[27:26]),
        .DIC(din[29:28]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[25:24]),
        .DOB(p_0_out[27:26]),
        .DOC(p_0_out[29:28]),
        .DOD(NLW_RAM_reg_0_15_24_29_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_30_35
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[31:30]),
        .DIB(din[33:32]),
        .DIC(din[35:34]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[31:30]),
        .DOB(p_0_out[33:32]),
        .DOC(p_0_out[35:34]),
        .DOD(NLW_RAM_reg_0_15_30_35_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_36_41
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[37:36]),
        .DIB(din[39:38]),
        .DIC(din[41:40]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[37:36]),
        .DOB(p_0_out[39:38]),
        .DOC(p_0_out[41:40]),
        .DOD(NLW_RAM_reg_0_15_36_41_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_42_47
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[43:42]),
        .DIB(din[45:44]),
        .DIC(din[47:46]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[43:42]),
        .DOB(p_0_out[45:44]),
        .DOC(p_0_out[47:46]),
        .DOD(NLW_RAM_reg_0_15_42_47_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_48_53
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[49:48]),
        .DIB(din[51:50]),
        .DIC(din[53:52]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[49:48]),
        .DOB(p_0_out[51:50]),
        .DOC(p_0_out[53:52]),
        .DOD(NLW_RAM_reg_0_15_48_53_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_54_59
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[55:54]),
        .DIB(din[57:56]),
        .DIC(din[59:58]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[55:54]),
        .DOB(p_0_out[57:56]),
        .DOC(p_0_out[59:58]),
        .DOD(NLW_RAM_reg_0_15_54_59_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_60_65
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[61:60]),
        .DIB(din[63:62]),
        .DIC(din[65:64]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[61:60]),
        .DOB(p_0_out[63:62]),
        .DOC(p_0_out[65:64]),
        .DOD(NLW_RAM_reg_0_15_60_65_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_66_71
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[67:66]),
        .DIB(din[69:68]),
        .DIC(din[71:70]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[67:66]),
        .DOB(p_0_out[69:68]),
        .DOC(p_0_out[71:70]),
        .DOD(NLW_RAM_reg_0_15_66_71_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_6_11
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[7:6]),
        .DIB(din[9:8]),
        .DIC(din[11:10]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[7:6]),
        .DOB(p_0_out[9:8]),
        .DOC(p_0_out[11:10]),
        .DOD(NLW_RAM_reg_0_15_6_11_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_72_77
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[73:72]),
        .DIB(din[75:74]),
        .DIC(din[77:76]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[73:72]),
        .DOB(p_0_out[75:74]),
        .DOC(p_0_out[77:76]),
        .DOD(NLW_RAM_reg_0_15_72_77_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_78_83
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[79:78]),
        .DIB(din[81:80]),
        .DIC(din[83:82]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[79:78]),
        .DOB(p_0_out[81:80]),
        .DOC(p_0_out[83:82]),
        .DOD(NLW_RAM_reg_0_15_78_83_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_84_89
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[85:84]),
        .DIB(din[87:86]),
        .DIC(din[89:88]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[85:84]),
        .DOB(p_0_out[87:86]),
        .DOC(p_0_out[89:88]),
        .DOD(NLW_RAM_reg_0_15_84_89_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_90_95
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[91:90]),
        .DIB(din[93:92]),
        .DIC(din[95:94]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[91:90]),
        .DOB(p_0_out[93:92]),
        .DOC(p_0_out[95:94]),
        .DOD(NLW_RAM_reg_0_15_90_95_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M RAM_reg_0_15_96_101
       (.ADDRA({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRB({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRC({1'b0,\gc0.count_d1_reg[3] }),
        .ADDRD({1'b0,Q}),
        .DIA(din[97:96]),
        .DIB(din[99:98]),
        .DIC(din[101:100]),
        .DID({1'b0,1'b0}),
        .DOA(p_0_out[97:96]),
        .DOB(p_0_out[99:98]),
        .DOC(p_0_out[101:100]),
        .DOD(NLW_RAM_reg_0_15_96_101_DOD_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(E));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[0] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[0]),
        .Q(dout[0]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[100] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[100]),
        .Q(dout[100]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[101] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[101]),
        .Q(dout[101]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[102] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[102]),
        .Q(dout[102]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[103] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[103]),
        .Q(dout[103]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[104] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[104]),
        .Q(dout[104]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[105] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[105]),
        .Q(dout[105]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[106] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[106]),
        .Q(dout[106]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[107] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[107]),
        .Q(dout[107]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[108] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[108]),
        .Q(dout[108]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[109] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[109]),
        .Q(dout[109]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[10] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[10]),
        .Q(dout[10]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[110] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[110]),
        .Q(dout[110]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[111] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[111]),
        .Q(dout[111]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[112] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[112]),
        .Q(dout[112]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[113] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[113]),
        .Q(dout[113]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[114] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[114]),
        .Q(dout[114]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[115] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[115]),
        .Q(dout[115]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[116] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[116]),
        .Q(dout[116]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[117] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[117]),
        .Q(dout[117]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[118] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[118]),
        .Q(dout[118]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[119] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[119]),
        .Q(dout[119]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[11] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[11]),
        .Q(dout[11]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[120] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[120]),
        .Q(dout[120]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[121] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[121]),
        .Q(dout[121]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[122] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[122]),
        .Q(dout[122]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[123] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[123]),
        .Q(dout[123]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[124] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[124]),
        .Q(dout[124]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[125] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[125]),
        .Q(dout[125]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[126] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[126]),
        .Q(dout[126]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[127] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[127]),
        .Q(dout[127]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[128] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[128]),
        .Q(dout[128]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[12] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[12]),
        .Q(dout[12]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[13] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[13]),
        .Q(dout[13]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[14] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[14]),
        .Q(dout[14]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[15] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[15]),
        .Q(dout[15]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[16] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[16]),
        .Q(dout[16]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[17] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[17]),
        .Q(dout[17]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[18] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[18]),
        .Q(dout[18]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[19] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[19]),
        .Q(dout[19]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[1] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[1]),
        .Q(dout[1]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[20] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[20]),
        .Q(dout[20]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[21] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[21]),
        .Q(dout[21]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[22] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[22]),
        .Q(dout[22]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[23] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[23]),
        .Q(dout[23]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[24] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[24]),
        .Q(dout[24]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[25] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[25]),
        .Q(dout[25]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[26] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[26]),
        .Q(dout[26]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[27] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[27]),
        .Q(dout[27]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[28] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[28]),
        .Q(dout[28]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[29] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[29]),
        .Q(dout[29]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[2] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[2]),
        .Q(dout[2]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[30] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[30]),
        .Q(dout[30]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[31] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[31]),
        .Q(dout[31]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[32] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[32]),
        .Q(dout[32]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[33] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[33]),
        .Q(dout[33]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[34] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[34]),
        .Q(dout[34]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[35] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[35]),
        .Q(dout[35]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[36] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[36]),
        .Q(dout[36]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[37] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[37]),
        .Q(dout[37]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[38] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[38]),
        .Q(dout[38]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[39] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[39]),
        .Q(dout[39]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[3] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[3]),
        .Q(dout[3]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[40] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[40]),
        .Q(dout[40]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[41] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[41]),
        .Q(dout[41]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[42] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[42]),
        .Q(dout[42]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[43] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[43]),
        .Q(dout[43]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[44] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[44]),
        .Q(dout[44]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[45] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[45]),
        .Q(dout[45]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[46] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[46]),
        .Q(dout[46]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[47] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[47]),
        .Q(dout[47]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[48] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[48]),
        .Q(dout[48]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[49] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[49]),
        .Q(dout[49]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[4] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[4]),
        .Q(dout[4]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[50] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[50]),
        .Q(dout[50]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[51] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[51]),
        .Q(dout[51]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[52] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[52]),
        .Q(dout[52]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[53] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[53]),
        .Q(dout[53]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[54] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[54]),
        .Q(dout[54]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[55] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[55]),
        .Q(dout[55]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[56] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[56]),
        .Q(dout[56]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[57] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[57]),
        .Q(dout[57]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[58] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[58]),
        .Q(dout[58]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[59] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[59]),
        .Q(dout[59]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[5] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[5]),
        .Q(dout[5]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[60] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[60]),
        .Q(dout[60]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[61] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[61]),
        .Q(dout[61]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[62] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[62]),
        .Q(dout[62]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[63] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[63]),
        .Q(dout[63]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[64] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[64]),
        .Q(dout[64]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[65] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[65]),
        .Q(dout[65]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[66] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[66]),
        .Q(dout[66]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[67] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[67]),
        .Q(dout[67]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[68] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[68]),
        .Q(dout[68]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[69] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[69]),
        .Q(dout[69]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[6] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[6]),
        .Q(dout[6]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[70] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[70]),
        .Q(dout[70]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[71] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[71]),
        .Q(dout[71]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[72] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[72]),
        .Q(dout[72]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[73] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[73]),
        .Q(dout[73]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[74] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[74]),
        .Q(dout[74]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[75] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[75]),
        .Q(dout[75]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[76] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[76]),
        .Q(dout[76]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[77] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[77]),
        .Q(dout[77]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[78] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[78]),
        .Q(dout[78]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[79] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[79]),
        .Q(dout[79]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[7] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[7]),
        .Q(dout[7]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[80] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[80]),
        .Q(dout[80]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[81] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[81]),
        .Q(dout[81]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[82] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[82]),
        .Q(dout[82]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[83] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[83]),
        .Q(dout[83]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[84] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[84]),
        .Q(dout[84]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[85] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[85]),
        .Q(dout[85]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[86] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[86]),
        .Q(dout[86]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[87] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[87]),
        .Q(dout[87]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[88] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[88]),
        .Q(dout[88]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[89] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[89]),
        .Q(dout[89]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[8] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[8]),
        .Q(dout[8]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[90] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[90]),
        .Q(dout[90]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[91] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[91]),
        .Q(dout[91]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[92] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[92]),
        .Q(dout[92]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[93] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[93]),
        .Q(dout[93]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[94] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[94]),
        .Q(dout[94]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[95] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[95]),
        .Q(dout[95]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[96] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[96]),
        .Q(dout[96]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[97] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[97]),
        .Q(dout[97]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[98] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[98]),
        .Q(dout[98]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[99] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[99]),
        .Q(dout[99]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[9] 
       (.C(clk),
        .CE(ram_empty_fb_i_reg),
        .D(p_0_out[9]),
        .Q(dout[9]),
        .R(srst));
endmodule

(* ORIG_REF_NAME = "fifo_generator_ramfifo" *) 
module adc_data_sync_fifo_fifo_generator_ramfifo
   (empty,
    full,
    dout,
    srst,
    clk,
    din,
    rd_en,
    wr_en);
  output empty;
  output full;
  output [128:0]dout;
  input srst;
  input clk;
  input [128:0]din;
  input rd_en;
  input wr_en;

  wire clk;
  wire [128:0]din;
  wire [128:0]dout;
  wire empty;
  wire full;
  wire \gntv_or_sync_fifo.gl0.wr_n_1 ;
  wire [3:0]p_0_out_0;
  wire [3:0]p_11_out;
  wire p_17_out;
  wire p_2_out;
  wire ram_rd_en_i;
  wire rd_en;
  wire [3:0]rd_pntr_plus1;
  wire srst;
  wire wr_en;

  adc_data_sync_fifo_rd_logic \gntv_or_sync_fifo.gl0.rd 
       (.E(ram_rd_en_i),
        .Q(rd_pntr_plus1),
        .clk(clk),
        .empty(empty),
        .\gpr1.dout_i_reg[1] (p_0_out_0),
        .out(p_2_out),
        .ram_empty_fb_i_reg(\gntv_or_sync_fifo.gl0.wr_n_1 ),
        .rd_en(rd_en),
        .srst(srst));
  adc_data_sync_fifo_wr_logic \gntv_or_sync_fifo.gl0.wr 
       (.E(p_17_out),
        .Q(p_11_out),
        .clk(clk),
        .full(full),
        .\gc0.count_d1_reg[3] (p_0_out_0),
        .\gc0.count_reg[3] (rd_pntr_plus1),
        .out(p_2_out),
        .ram_empty_i_reg(\gntv_or_sync_fifo.gl0.wr_n_1 ),
        .rd_en(rd_en),
        .srst(srst),
        .wr_en(wr_en));
  adc_data_sync_fifo_memory \gntv_or_sync_fifo.mem 
       (.E(p_17_out),
        .Q(p_11_out),
        .clk(clk),
        .din(din),
        .dout(dout),
        .\gc0.count_d1_reg[3] (p_0_out_0),
        .ram_empty_fb_i_reg(ram_rd_en_i),
        .srst(srst));
endmodule

(* ORIG_REF_NAME = "fifo_generator_top" *) 
module adc_data_sync_fifo_fifo_generator_top
   (empty,
    full,
    dout,
    srst,
    clk,
    din,
    rd_en,
    wr_en);
  output empty;
  output full;
  output [128:0]dout;
  input srst;
  input clk;
  input [128:0]din;
  input rd_en;
  input wr_en;

  wire clk;
  wire [128:0]din;
  wire [128:0]dout;
  wire empty;
  wire full;
  wire rd_en;
  wire srst;
  wire wr_en;

  adc_data_sync_fifo_fifo_generator_ramfifo \grf.rf 
       (.clk(clk),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_en(rd_en),
        .srst(srst),
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
(* C_AXI_WUSER_WIDTH = "1" *) (* C_COMMON_CLOCK = "1" *) (* C_COUNT_TYPE = "0" *) 
(* C_DATA_COUNT_WIDTH = "4" *) (* C_DEFAULT_VALUE = "BlankString" *) (* C_DIN_WIDTH = "129" *) 
(* C_DIN_WIDTH_AXIS = "1" *) (* C_DIN_WIDTH_RACH = "32" *) (* C_DIN_WIDTH_RDCH = "64" *) 
(* C_DIN_WIDTH_WACH = "1" *) (* C_DIN_WIDTH_WDCH = "64" *) (* C_DIN_WIDTH_WRCH = "2" *) 
(* C_DOUT_RST_VAL = "0" *) (* C_DOUT_WIDTH = "129" *) (* C_ENABLE_RLOCS = "0" *) 
(* C_ENABLE_RST_SYNC = "1" *) (* C_EN_SAFETY_CKT = "0" *) (* C_ERROR_INJECTION_TYPE = "0" *) 
(* C_ERROR_INJECTION_TYPE_AXIS = "0" *) (* C_ERROR_INJECTION_TYPE_RACH = "0" *) (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) 
(* C_ERROR_INJECTION_TYPE_WACH = "0" *) (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) (* C_ERROR_INJECTION_TYPE_WRCH = "0" *) 
(* C_FAMILY = "virtex7" *) (* C_FULL_FLAGS_RST_VAL = "0" *) (* C_HAS_ALMOST_EMPTY = "0" *) 
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
(* C_HAS_RD_RST = "0" *) (* C_HAS_RST = "0" *) (* C_HAS_SLAVE_CE = "0" *) 
(* C_HAS_SRST = "1" *) (* C_HAS_UNDERFLOW = "0" *) (* C_HAS_VALID = "0" *) 
(* C_HAS_WR_ACK = "0" *) (* C_HAS_WR_DATA_COUNT = "0" *) (* C_HAS_WR_RST = "0" *) 
(* C_IMPLEMENTATION_TYPE = "0" *) (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
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
(* C_PROG_FULL_THRESH_ASSERT_VAL = "14" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) (* C_PROG_FULL_THRESH_NEGATE_VAL = "13" *) (* C_PROG_FULL_TYPE = "0" *) 
(* C_PROG_FULL_TYPE_AXIS = "0" *) (* C_PROG_FULL_TYPE_RACH = "0" *) (* C_PROG_FULL_TYPE_RDCH = "0" *) 
(* C_PROG_FULL_TYPE_WACH = "0" *) (* C_PROG_FULL_TYPE_WDCH = "0" *) (* C_PROG_FULL_TYPE_WRCH = "0" *) 
(* C_RACH_TYPE = "0" *) (* C_RDCH_TYPE = "0" *) (* C_RD_DATA_COUNT_WIDTH = "4" *) 
(* C_RD_DEPTH = "16" *) (* C_RD_FREQ = "1" *) (* C_RD_PNTR_WIDTH = "4" *) 
(* C_REG_SLICE_MODE_AXIS = "0" *) (* C_REG_SLICE_MODE_RACH = "0" *) (* C_REG_SLICE_MODE_RDCH = "0" *) 
(* C_REG_SLICE_MODE_WACH = "0" *) (* C_REG_SLICE_MODE_WDCH = "0" *) (* C_REG_SLICE_MODE_WRCH = "0" *) 
(* C_SELECT_XPM = "0" *) (* C_SYNCHRONIZER_STAGE = "2" *) (* C_UNDERFLOW_LOW = "0" *) 
(* C_USE_COMMON_OVERFLOW = "0" *) (* C_USE_COMMON_UNDERFLOW = "0" *) (* C_USE_DEFAULT_SETTINGS = "0" *) 
(* C_USE_DOUT_RST = "1" *) (* C_USE_ECC = "0" *) (* C_USE_ECC_AXIS = "0" *) 
(* C_USE_ECC_RACH = "0" *) (* C_USE_ECC_RDCH = "0" *) (* C_USE_ECC_WACH = "0" *) 
(* C_USE_ECC_WDCH = "0" *) (* C_USE_ECC_WRCH = "0" *) (* C_USE_EMBEDDED_REG = "0" *) 
(* C_USE_FIFO16_FLAGS = "0" *) (* C_USE_FWFT_DATA_COUNT = "0" *) (* C_USE_PIPELINE_REG = "0" *) 
(* C_VALID_LOW = "0" *) (* C_WACH_TYPE = "0" *) (* C_WDCH_TYPE = "0" *) 
(* C_WRCH_TYPE = "0" *) (* C_WR_ACK_LOW = "0" *) (* C_WR_DATA_COUNT_WIDTH = "4" *) 
(* C_WR_DEPTH = "16" *) (* C_WR_DEPTH_AXIS = "1024" *) (* C_WR_DEPTH_RACH = "16" *) 
(* C_WR_DEPTH_RDCH = "1024" *) (* C_WR_DEPTH_WACH = "16" *) (* C_WR_DEPTH_WDCH = "1024" *) 
(* C_WR_DEPTH_WRCH = "16" *) (* C_WR_FREQ = "1" *) (* C_WR_PNTR_WIDTH = "4" *) 
(* C_WR_PNTR_WIDTH_AXIS = "10" *) (* C_WR_PNTR_WIDTH_RACH = "4" *) (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
(* C_WR_PNTR_WIDTH_WACH = "4" *) (* C_WR_PNTR_WIDTH_WDCH = "10" *) (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
(* C_WR_RESPONSE_LATENCY = "1" *) (* ORIG_REF_NAME = "fifo_generator_v13_2_2" *) 
module adc_data_sync_fifo_fifo_generator_v13_2_2
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
  input [128:0]din;
  input wr_en;
  input rd_en;
  input [3:0]prog_empty_thresh;
  input [3:0]prog_empty_thresh_assert;
  input [3:0]prog_empty_thresh_negate;
  input [3:0]prog_full_thresh;
  input [3:0]prog_full_thresh_assert;
  input [3:0]prog_full_thresh_negate;
  input int_clk;
  input injectdbiterr;
  input injectsbiterr;
  input sleep;
  output [128:0]dout;
  output full;
  output almost_full;
  output wr_ack;
  output overflow;
  output empty;
  output almost_empty;
  output valid;
  output underflow;
  output [3:0]data_count;
  output [3:0]rd_data_count;
  output [3:0]wr_data_count;
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
  wire [128:0]din;
  wire [128:0]dout;
  wire empty;
  wire full;
  wire rd_en;
  wire srst;
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
  assign wr_data_count[3] = \<const0> ;
  assign wr_data_count[2] = \<const0> ;
  assign wr_data_count[1] = \<const0> ;
  assign wr_data_count[0] = \<const0> ;
  assign wr_rst_busy = \<const0> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  adc_data_sync_fifo_fifo_generator_v13_2_2_synth inst_fifo_gen
       (.clk(clk),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_en(rd_en),
        .srst(srst),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "fifo_generator_v13_2_2_synth" *) 
module adc_data_sync_fifo_fifo_generator_v13_2_2_synth
   (empty,
    full,
    dout,
    srst,
    clk,
    din,
    rd_en,
    wr_en);
  output empty;
  output full;
  output [128:0]dout;
  input srst;
  input clk;
  input [128:0]din;
  input rd_en;
  input wr_en;

  wire clk;
  wire [128:0]din;
  wire [128:0]dout;
  wire empty;
  wire full;
  wire rd_en;
  wire srst;
  wire wr_en;

  adc_data_sync_fifo_fifo_generator_top \gconvfifo.rf 
       (.clk(clk),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_en(rd_en),
        .srst(srst),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "memory" *) 
module adc_data_sync_fifo_memory
   (dout,
    clk,
    E,
    din,
    \gc0.count_d1_reg[3] ,
    Q,
    srst,
    ram_empty_fb_i_reg);
  output [128:0]dout;
  input clk;
  input [0:0]E;
  input [128:0]din;
  input [3:0]\gc0.count_d1_reg[3] ;
  input [3:0]Q;
  input srst;
  input [0:0]ram_empty_fb_i_reg;

  wire [0:0]E;
  wire [3:0]Q;
  wire clk;
  wire [128:0]din;
  wire [128:0]dout;
  wire [3:0]\gc0.count_d1_reg[3] ;
  wire [0:0]ram_empty_fb_i_reg;
  wire srst;

  adc_data_sync_fifo_dmem \gdm.dm_gen.dm 
       (.E(E),
        .Q(Q),
        .clk(clk),
        .din(din),
        .dout(dout),
        .\gc0.count_d1_reg[3] (\gc0.count_d1_reg[3] ),
        .ram_empty_fb_i_reg(ram_empty_fb_i_reg),
        .srst(srst));
endmodule

(* ORIG_REF_NAME = "rd_bin_cntr" *) 
module adc_data_sync_fifo_rd_bin_cntr
   (Q,
    \gpr1.dout_i_reg[1] ,
    srst,
    E,
    clk);
  output [3:0]Q;
  output [3:0]\gpr1.dout_i_reg[1] ;
  input srst;
  input [0:0]E;
  input clk;

  wire [0:0]E;
  wire [3:0]Q;
  wire clk;
  wire [3:0]\gpr1.dout_i_reg[1] ;
  wire [3:0]plusOp;
  wire srst;

  LUT1 #(
    .INIT(2'h1)) 
    \gc0.count[0]_i_1 
       (.I0(Q[0]),
        .O(plusOp[0]));
  LUT2 #(
    .INIT(4'h6)) 
    \gc0.count[1]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \gc0.count[2]_i_1 
       (.I0(Q[2]),
        .I1(Q[1]),
        .I2(Q[0]),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gc0.count[3]_i_1 
       (.I0(Q[3]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[2]),
        .O(plusOp[3]));
  FDRE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[0] 
       (.C(clk),
        .CE(E),
        .D(Q[0]),
        .Q(\gpr1.dout_i_reg[1] [0]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[1] 
       (.C(clk),
        .CE(E),
        .D(Q[1]),
        .Q(\gpr1.dout_i_reg[1] [1]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[2] 
       (.C(clk),
        .CE(E),
        .D(Q[2]),
        .Q(\gpr1.dout_i_reg[1] [2]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[3] 
       (.C(clk),
        .CE(E),
        .D(Q[3]),
        .Q(\gpr1.dout_i_reg[1] [3]),
        .R(srst));
  FDSE #(
    .INIT(1'b1)) 
    \gc0.count_reg[0] 
       (.C(clk),
        .CE(E),
        .D(plusOp[0]),
        .Q(Q[0]),
        .S(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gc0.count_reg[1] 
       (.C(clk),
        .CE(E),
        .D(plusOp[1]),
        .Q(Q[1]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gc0.count_reg[2] 
       (.C(clk),
        .CE(E),
        .D(plusOp[2]),
        .Q(Q[2]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gc0.count_reg[3] 
       (.C(clk),
        .CE(E),
        .D(plusOp[3]),
        .Q(Q[3]),
        .R(srst));
endmodule

(* ORIG_REF_NAME = "rd_logic" *) 
module adc_data_sync_fifo_rd_logic
   (out,
    empty,
    E,
    Q,
    \gpr1.dout_i_reg[1] ,
    srst,
    ram_empty_fb_i_reg,
    clk,
    rd_en);
  output out;
  output empty;
  output [0:0]E;
  output [3:0]Q;
  output [3:0]\gpr1.dout_i_reg[1] ;
  input srst;
  input ram_empty_fb_i_reg;
  input clk;
  input rd_en;

  wire [0:0]E;
  wire [3:0]Q;
  wire clk;
  wire empty;
  wire [3:0]\gpr1.dout_i_reg[1] ;
  wire out;
  wire ram_empty_fb_i_reg;
  wire rd_en;
  wire srst;

  adc_data_sync_fifo_rd_status_flags_ss \grss.rsts 
       (.E(E),
        .clk(clk),
        .empty(empty),
        .out(out),
        .ram_empty_fb_i_reg_0(ram_empty_fb_i_reg),
        .rd_en(rd_en),
        .srst(srst));
  adc_data_sync_fifo_rd_bin_cntr rpntr
       (.E(E),
        .Q(Q),
        .clk(clk),
        .\gpr1.dout_i_reg[1] (\gpr1.dout_i_reg[1] ),
        .srst(srst));
endmodule

(* ORIG_REF_NAME = "rd_status_flags_ss" *) 
module adc_data_sync_fifo_rd_status_flags_ss
   (out,
    empty,
    E,
    srst,
    ram_empty_fb_i_reg_0,
    clk,
    rd_en);
  output out;
  output empty;
  output [0:0]E;
  input srst;
  input ram_empty_fb_i_reg_0;
  input clk;
  input rd_en;

  wire [0:0]E;
  wire clk;
  (* DONT_TOUCH *) wire ram_empty_fb_i;
  wire ram_empty_fb_i_reg_0;
  (* DONT_TOUCH *) wire ram_empty_i;
  wire rd_en;
  wire srst;

  assign empty = ram_empty_i;
  assign out = ram_empty_fb_i;
  LUT2 #(
    .INIT(4'h2)) 
    \gpr1.dout_i[128]_i_1 
       (.I0(rd_en),
        .I1(ram_empty_fb_i),
        .O(E));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDSE #(
    .INIT(1'b1)) 
    ram_empty_fb_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(ram_empty_fb_i_reg_0),
        .Q(ram_empty_fb_i),
        .S(srst));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDSE #(
    .INIT(1'b1)) 
    ram_empty_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(ram_empty_fb_i_reg_0),
        .Q(ram_empty_i),
        .S(srst));
endmodule

(* ORIG_REF_NAME = "wr_bin_cntr" *) 
module adc_data_sync_fifo_wr_bin_cntr
   (ram_full_fb_i_reg,
    ram_empty_i_reg,
    Q,
    out,
    ram_full_fb_i_reg_0,
    rd_en,
    wr_en,
    \gc0.count_d1_reg[3] ,
    \gc0.count_reg[3] ,
    srst,
    E,
    clk);
  output ram_full_fb_i_reg;
  output ram_empty_i_reg;
  output [3:0]Q;
  input out;
  input ram_full_fb_i_reg_0;
  input rd_en;
  input wr_en;
  input [3:0]\gc0.count_d1_reg[3] ;
  input [3:0]\gc0.count_reg[3] ;
  input srst;
  input [0:0]E;
  input clk;

  wire [0:0]E;
  wire [3:0]Q;
  wire clk;
  wire [3:0]\gc0.count_d1_reg[3] ;
  wire [3:0]\gc0.count_reg[3] ;
  wire out;
  wire [3:0]p_12_out;
  wire [3:0]plusOp__0;
  wire ram_empty_fb_i_i_2_n_0;
  wire ram_empty_fb_i_i_3_n_0;
  wire ram_empty_i_reg;
  wire ram_full_fb_i_i_2_n_0;
  wire ram_full_fb_i_i_3_n_0;
  wire ram_full_fb_i_i_4_n_0;
  wire ram_full_fb_i_i_5_n_0;
  wire ram_full_fb_i_reg;
  wire ram_full_fb_i_reg_0;
  wire rd_en;
  wire srst;
  wire wr_en;

  LUT1 #(
    .INIT(2'h1)) 
    \gcc0.gc0.count[0]_i_1 
       (.I0(p_12_out[0]),
        .O(plusOp__0[0]));
  LUT2 #(
    .INIT(4'h6)) 
    \gcc0.gc0.count[1]_i_1 
       (.I0(p_12_out[0]),
        .I1(p_12_out[1]),
        .O(plusOp__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \gcc0.gc0.count[2]_i_1 
       (.I0(p_12_out[2]),
        .I1(p_12_out[0]),
        .I2(p_12_out[1]),
        .O(plusOp__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gcc0.gc0.count[3]_i_1 
       (.I0(p_12_out[3]),
        .I1(p_12_out[0]),
        .I2(p_12_out[1]),
        .I3(p_12_out[2]),
        .O(plusOp__0[3]));
  FDRE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_d1_reg[0] 
       (.C(clk),
        .CE(E),
        .D(p_12_out[0]),
        .Q(Q[0]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_d1_reg[1] 
       (.C(clk),
        .CE(E),
        .D(p_12_out[1]),
        .Q(Q[1]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_d1_reg[2] 
       (.C(clk),
        .CE(E),
        .D(p_12_out[2]),
        .Q(Q[2]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_d1_reg[3] 
       (.C(clk),
        .CE(E),
        .D(p_12_out[3]),
        .Q(Q[3]),
        .R(srst));
  FDSE #(
    .INIT(1'b1)) 
    \gcc0.gc0.count_reg[0] 
       (.C(clk),
        .CE(E),
        .D(plusOp__0[0]),
        .Q(p_12_out[0]),
        .S(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_reg[1] 
       (.C(clk),
        .CE(E),
        .D(plusOp__0[1]),
        .Q(p_12_out[1]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_reg[2] 
       (.C(clk),
        .CE(E),
        .D(plusOp__0[2]),
        .Q(p_12_out[2]),
        .R(srst));
  FDRE #(
    .INIT(1'b0)) 
    \gcc0.gc0.count_reg[3] 
       (.C(clk),
        .CE(E),
        .D(plusOp__0[3]),
        .Q(p_12_out[3]),
        .R(srst));
  LUT6 #(
    .INIT(64'hFFCC8F8CCCCC8C8C)) 
    ram_empty_fb_i_i_1
       (.I0(ram_full_fb_i_i_2_n_0),
        .I1(out),
        .I2(wr_en),
        .I3(ram_empty_fb_i_i_2_n_0),
        .I4(ram_full_fb_i_reg_0),
        .I5(rd_en),
        .O(ram_empty_i_reg));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h84)) 
    ram_empty_fb_i_i_2
       (.I0(Q[3]),
        .I1(ram_empty_fb_i_i_3_n_0),
        .I2(\gc0.count_reg[3] [3]),
        .O(ram_empty_fb_i_i_2_n_0));
  LUT6 #(
    .INIT(64'h8008200240041001)) 
    ram_empty_fb_i_i_3
       (.I0(Q[2]),
        .I1(\gc0.count_reg[3] [1]),
        .I2(Q[0]),
        .I3(\gc0.count_reg[3] [0]),
        .I4(Q[1]),
        .I5(\gc0.count_reg[3] [2]),
        .O(ram_empty_fb_i_i_3_n_0));
  LUT5 #(
    .INIT(32'hEAFF4000)) 
    ram_full_fb_i_i_1
       (.I0(out),
        .I1(ram_full_fb_i_i_2_n_0),
        .I2(ram_full_fb_i_reg_0),
        .I3(rd_en),
        .I4(ram_full_fb_i_i_3_n_0),
        .O(ram_full_fb_i_reg));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hDE)) 
    ram_full_fb_i_i_2
       (.I0(Q[3]),
        .I1(ram_full_fb_i_i_4_n_0),
        .I2(\gc0.count_d1_reg[3] [3]),
        .O(ram_full_fb_i_i_2_n_0));
  LUT5 #(
    .INIT(32'hFFFF8020)) 
    ram_full_fb_i_i_3
       (.I0(wr_en),
        .I1(\gc0.count_d1_reg[3] [3]),
        .I2(ram_full_fb_i_i_5_n_0),
        .I3(p_12_out[3]),
        .I4(ram_full_fb_i_reg_0),
        .O(ram_full_fb_i_i_3_n_0));
  LUT6 #(
    .INIT(64'h7FDFF7FDBFEFFBFE)) 
    ram_full_fb_i_i_4
       (.I0(Q[2]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(\gc0.count_d1_reg[3] [1]),
        .I4(\gc0.count_d1_reg[3] [0]),
        .I5(\gc0.count_d1_reg[3] [2]),
        .O(ram_full_fb_i_i_4_n_0));
  LUT6 #(
    .INIT(64'h8008200240041001)) 
    ram_full_fb_i_i_5
       (.I0(p_12_out[2]),
        .I1(\gc0.count_d1_reg[3] [0]),
        .I2(p_12_out[1]),
        .I3(\gc0.count_d1_reg[3] [1]),
        .I4(p_12_out[0]),
        .I5(\gc0.count_d1_reg[3] [2]),
        .O(ram_full_fb_i_i_5_n_0));
endmodule

(* ORIG_REF_NAME = "wr_logic" *) 
module adc_data_sync_fifo_wr_logic
   (full,
    ram_empty_i_reg,
    Q,
    E,
    srst,
    clk,
    out,
    rd_en,
    wr_en,
    \gc0.count_d1_reg[3] ,
    \gc0.count_reg[3] );
  output full;
  output ram_empty_i_reg;
  output [3:0]Q;
  output [0:0]E;
  input srst;
  input clk;
  input out;
  input rd_en;
  input wr_en;
  input [3:0]\gc0.count_d1_reg[3] ;
  input [3:0]\gc0.count_reg[3] ;

  wire [0:0]E;
  wire [3:0]Q;
  wire clk;
  wire full;
  wire [3:0]\gc0.count_d1_reg[3] ;
  wire [3:0]\gc0.count_reg[3] ;
  wire \gwss.wsts_n_0 ;
  wire out;
  wire ram_empty_i_reg;
  wire rd_en;
  wire srst;
  wire wpntr_n_0;
  wire wr_en;

  adc_data_sync_fifo_wr_status_flags_ss \gwss.wsts 
       (.E(E),
        .clk(clk),
        .full(full),
        .out(\gwss.wsts_n_0 ),
        .ram_empty_fb_i_reg(wpntr_n_0),
        .srst(srst),
        .wr_en(wr_en));
  adc_data_sync_fifo_wr_bin_cntr wpntr
       (.E(E),
        .Q(Q),
        .clk(clk),
        .\gc0.count_d1_reg[3] (\gc0.count_d1_reg[3] ),
        .\gc0.count_reg[3] (\gc0.count_reg[3] ),
        .out(out),
        .ram_empty_i_reg(ram_empty_i_reg),
        .ram_full_fb_i_reg(wpntr_n_0),
        .ram_full_fb_i_reg_0(\gwss.wsts_n_0 ),
        .rd_en(rd_en),
        .srst(srst),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "wr_status_flags_ss" *) 
module adc_data_sync_fifo_wr_status_flags_ss
   (out,
    full,
    E,
    srst,
    ram_empty_fb_i_reg,
    clk,
    wr_en);
  output out;
  output full;
  output [0:0]E;
  input srst;
  input ram_empty_fb_i_reg;
  input clk;
  input wr_en;

  wire [0:0]E;
  wire clk;
  (* DONT_TOUCH *) wire ram_afull_fb;
  (* DONT_TOUCH *) wire ram_afull_i;
  wire ram_empty_fb_i_reg;
  (* DONT_TOUCH *) wire ram_full_fb_i;
  (* DONT_TOUCH *) wire ram_full_i;
  wire srst;
  wire wr_en;

  assign full = ram_full_i;
  assign out = ram_full_fb_i;
  LUT2 #(
    .INIT(4'h2)) 
    \gcc0.gc0.count_d1[3]_i_1 
       (.I0(wr_en),
        .I1(ram_full_fb_i),
        .O(E));
  LUT1 #(
    .INIT(2'h2)) 
    i_0
       (.I0(1'b0),
        .O(ram_afull_i));
  LUT1 #(
    .INIT(2'h2)) 
    i_1
       (.I0(1'b0),
        .O(ram_afull_fb));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    ram_full_fb_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(ram_empty_fb_i_reg),
        .Q(ram_full_fb_i),
        .R(srst));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    ram_full_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(ram_empty_fb_i_reg),
        .Q(ram_full_i),
        .R(srst));
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
