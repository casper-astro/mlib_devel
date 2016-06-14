// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
// Date        : Mon May 23 14:32:11 2016
// Host        : adam-cm running 64-bit Ubuntu 14.04.4 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aisaacson/work/git_work/ska_sa/projects/mlib_devel/jasper_library/hdl_sources/forty_gbe/tx_fifo_ext/tx_fifo_ext_funcsim.v
// Design      : tx_fifo_ext
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v12_0,Vivado 2014.3.1" *) (* CHECK_LICENSE_TYPE = "tx_fifo_ext,fifo_generator_v12_0,{}" *) 
(* core_generation_info = "tx_fifo_ext,fifo_generator_v12_0,{x_ipProduct=Vivado 2014.3.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=fifo_generator,x_ipVersion=12.0,x_ipCoreRevision=2,x_ipLanguage=VERILOG,C_COMMON_CLOCK=1,C_COUNT_TYPE=0,C_DATA_COUNT_WIDTH=7,C_DEFAULT_VALUE=BlankString,C_DIN_WIDTH=64,C_DOUT_RST_VAL=0,C_DOUT_WIDTH=64,C_ENABLE_RLOCS=0,C_FAMILY=virtex7,C_FULL_FLAGS_RST_VAL=1,C_HAS_ALMOST_EMPTY=0,C_HAS_ALMOST_FULL=0,C_HAS_BACKUP=0,C_HAS_DATA_COUNT=0,C_HAS_INT_CLK=0,C_HAS_MEMINIT_FILE=0,C_HAS_OVERFLOW=0,C_HAS_RD_DATA_COUNT=0,C_HAS_RD_RST=0,C_HAS_RST=1,C_HAS_SRST=0,C_HAS_UNDERFLOW=0,C_HAS_VALID=0,C_HAS_WR_ACK=0,C_HAS_WR_DATA_COUNT=0,C_HAS_WR_RST=0,C_IMPLEMENTATION_TYPE=0,C_INIT_WR_PNTR_VAL=0,C_MEMORY_TYPE=2,C_MIF_FILE_NAME=BlankString,C_OPTIMIZATION_MODE=0,C_OVERFLOW_LOW=0,C_PRELOAD_LATENCY=0,C_PRELOAD_REGS=1,C_PRIM_FIFO_TYPE=512x72,C_PROG_EMPTY_THRESH_ASSERT_VAL=4,C_PROG_EMPTY_THRESH_NEGATE_VAL=5,C_PROG_EMPTY_TYPE=0,C_PROG_FULL_THRESH_ASSERT_VAL=62,C_PROG_FULL_THRESH_NEGATE_VAL=61,C_PROG_FULL_TYPE=1,C_RD_DATA_COUNT_WIDTH=7,C_RD_DEPTH=64,C_RD_FREQ=1,C_RD_PNTR_WIDTH=6,C_UNDERFLOW_LOW=0,C_USE_DOUT_RST=1,C_USE_ECC=0,C_USE_EMBEDDED_REG=0,C_USE_PIPELINE_REG=0,C_POWER_SAVING_MODE=0,C_USE_FIFO16_FLAGS=0,C_USE_FWFT_DATA_COUNT=1,C_VALID_LOW=0,C_WR_ACK_LOW=0,C_WR_DATA_COUNT_WIDTH=7,C_WR_DEPTH=64,C_WR_FREQ=1,C_WR_PNTR_WIDTH=6,C_WR_RESPONSE_LATENCY=1,C_MSGON_VAL=1,C_ENABLE_RST_SYNC=1,C_ERROR_INJECTION_TYPE=0,C_SYNCHRONIZER_STAGE=2,C_INTERFACE_TYPE=0,C_AXI_TYPE=1,C_HAS_AXI_WR_CHANNEL=1,C_HAS_AXI_RD_CHANNEL=1,C_HAS_SLAVE_CE=0,C_HAS_MASTER_CE=0,C_ADD_NGC_CONSTRAINT=0,C_USE_COMMON_OVERFLOW=0,C_USE_COMMON_UNDERFLOW=0,C_USE_DEFAULT_SETTINGS=0,C_AXI_ID_WIDTH=1,C_AXI_ADDR_WIDTH=32,C_AXI_DATA_WIDTH=64,C_AXI_LEN_WIDTH=8,C_AXI_LOCK_WIDTH=1,C_HAS_AXI_ID=0,C_HAS_AXI_AWUSER=0,C_HAS_AXI_WUSER=0,C_HAS_AXI_BUSER=0,C_HAS_AXI_ARUSER=0,C_HAS_AXI_RUSER=0,C_AXI_ARUSER_WIDTH=1,C_AXI_AWUSER_WIDTH=1,C_AXI_WUSER_WIDTH=1,C_AXI_BUSER_WIDTH=1,C_AXI_RUSER_WIDTH=1,C_HAS_AXIS_TDATA=1,C_HAS_AXIS_TID=0,C_HAS_AXIS_TDEST=0,C_HAS_AXIS_TUSER=1,C_HAS_AXIS_TREADY=1,C_HAS_AXIS_TLAST=0,C_HAS_AXIS_TSTRB=0,C_HAS_AXIS_TKEEP=0,C_AXIS_TDATA_WIDTH=8,C_AXIS_TID_WIDTH=1,C_AXIS_TDEST_WIDTH=1,C_AXIS_TUSER_WIDTH=4,C_AXIS_TSTRB_WIDTH=1,C_AXIS_TKEEP_WIDTH=1,C_WACH_TYPE=0,C_WDCH_TYPE=0,C_WRCH_TYPE=0,C_RACH_TYPE=0,C_RDCH_TYPE=0,C_AXIS_TYPE=0,C_IMPLEMENTATION_TYPE_WACH=1,C_IMPLEMENTATION_TYPE_WDCH=1,C_IMPLEMENTATION_TYPE_WRCH=1,C_IMPLEMENTATION_TYPE_RACH=1,C_IMPLEMENTATION_TYPE_RDCH=1,C_IMPLEMENTATION_TYPE_AXIS=1,C_APPLICATION_TYPE_WACH=0,C_APPLICATION_TYPE_WDCH=0,C_APPLICATION_TYPE_WRCH=0,C_APPLICATION_TYPE_RACH=0,C_APPLICATION_TYPE_RDCH=0,C_APPLICATION_TYPE_AXIS=0,C_PRIM_FIFO_TYPE_WACH=512x36,C_PRIM_FIFO_TYPE_WDCH=1kx36,C_PRIM_FIFO_TYPE_WRCH=512x36,C_PRIM_FIFO_TYPE_RACH=512x36,C_PRIM_FIFO_TYPE_RDCH=1kx36,C_PRIM_FIFO_TYPE_AXIS=1kx18,C_USE_ECC_WACH=0,C_USE_ECC_WDCH=0,C_USE_ECC_WRCH=0,C_USE_ECC_RACH=0,C_USE_ECC_RDCH=0,C_USE_ECC_AXIS=0,C_ERROR_INJECTION_TYPE_WACH=0,C_ERROR_INJECTION_TYPE_WDCH=0,C_ERROR_INJECTION_TYPE_WRCH=0,C_ERROR_INJECTION_TYPE_RACH=0,C_ERROR_INJECTION_TYPE_RDCH=0,C_ERROR_INJECTION_TYPE_AXIS=0,C_DIN_WIDTH_WACH=32,C_DIN_WIDTH_WDCH=64,C_DIN_WIDTH_WRCH=2,C_DIN_WIDTH_RACH=32,C_DIN_WIDTH_RDCH=64,C_DIN_WIDTH_AXIS=1,C_WR_DEPTH_WACH=16,C_WR_DEPTH_WDCH=1024,C_WR_DEPTH_WRCH=16,C_WR_DEPTH_RACH=16,C_WR_DEPTH_RDCH=1024,C_WR_DEPTH_AXIS=1024,C_WR_PNTR_WIDTH_WACH=4,C_WR_PNTR_WIDTH_WDCH=10,C_WR_PNTR_WIDTH_WRCH=4,C_WR_PNTR_WIDTH_RACH=4,C_WR_PNTR_WIDTH_RDCH=10,C_WR_PNTR_WIDTH_AXIS=10,C_HAS_DATA_COUNTS_WACH=0,C_HAS_DATA_COUNTS_WDCH=0,C_HAS_DATA_COUNTS_WRCH=0,C_HAS_DATA_COUNTS_RACH=0,C_HAS_DATA_COUNTS_RDCH=0,C_HAS_DATA_COUNTS_AXIS=0,C_HAS_PROG_FLAGS_WACH=0,C_HAS_PROG_FLAGS_WDCH=0,C_HAS_PROG_FLAGS_WRCH=0,C_HAS_PROG_FLAGS_RACH=0,C_HAS_PROG_FLAGS_RDCH=0,C_HAS_PROG_FLAGS_AXIS=0,C_PROG_FULL_TYPE_WACH=0,C_PROG_FULL_TYPE_WDCH=0,C_PROG_FULL_TYPE_WRCH=0,C_PROG_FULL_TYPE_RACH=0,C_PROG_FULL_TYPE_RDCH=0,C_PROG_FULL_TYPE_AXIS=0,C_PROG_FULL_THRESH_ASSERT_VAL_WACH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_WDCH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_WRCH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_RACH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_RDCH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_AXIS=1023,C_PROG_EMPTY_TYPE_WACH=0,C_PROG_EMPTY_TYPE_WDCH=0,C_PROG_EMPTY_TYPE_WRCH=0,C_PROG_EMPTY_TYPE_RACH=0,C_PROG_EMPTY_TYPE_RDCH=0,C_PROG_EMPTY_TYPE_AXIS=0,C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS=1022,C_REG_SLICE_MODE_WACH=0,C_REG_SLICE_MODE_WDCH=0,C_REG_SLICE_MODE_WRCH=0,C_REG_SLICE_MODE_RACH=0,C_REG_SLICE_MODE_RDCH=0,C_REG_SLICE_MODE_AXIS=0}" *) 
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
  input clk;
  input rst;
  input [63:0]din;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *) input wr_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *) input rd_en;
  output [63:0]dout;
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
   (* C_DIN_WIDTH_WACH = "32" *) 
   (* C_DIN_WIDTH_WDCH = "64" *) 
   (* C_DIN_WIDTH_WRCH = "2" *) 
   (* C_DOUT_RST_VAL = "0" *) 
   (* C_DOUT_WIDTH = "64" *) 
   (* C_ENABLE_RLOCS = "0" *) 
   (* C_ENABLE_RST_SYNC = "1" *) 
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
   tx_fifo_ext_fifo_generator_v12_0__parameterized0 U0
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

(* ORIG_REF_NAME = "dmem" *) 
module tx_fifo_ext_dmem
   (Q,
    E,
    clk,
    I1,
    din,
    I2,
    O2,
    O3);
  output [63:0]Q;
  input [0:0]E;
  input clk;
  input [0:0]I1;
  input [63:0]din;
  input [0:0]I2;
  input [5:0]O2;
  input [5:0]O3;

  wire [0:0]E;
  wire [0:0]I1;
  wire [0:0]I2;
  wire [5:0]O2;
  wire [5:0]O3;
  wire [63:0]Q;
  wire clk;
  wire [63:0]din;
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

RAM64M RAM_reg_0_63_0_2
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[0]),
        .DIB(din[1]),
        .DIC(din[2]),
        .DID(1'b0),
        .DOA(p_0_out[0]),
        .DOB(p_0_out[1]),
        .DOC(p_0_out[2]),
        .DOD(NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_12_14
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[12]),
        .DIB(din[13]),
        .DIC(din[14]),
        .DID(1'b0),
        .DOA(p_0_out[12]),
        .DOB(p_0_out[13]),
        .DOC(p_0_out[14]),
        .DOD(NLW_RAM_reg_0_63_12_14_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_15_17
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[15]),
        .DIB(din[16]),
        .DIC(din[17]),
        .DID(1'b0),
        .DOA(p_0_out[15]),
        .DOB(p_0_out[16]),
        .DOC(p_0_out[17]),
        .DOD(NLW_RAM_reg_0_63_15_17_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_18_20
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[18]),
        .DIB(din[19]),
        .DIC(din[20]),
        .DID(1'b0),
        .DOA(p_0_out[18]),
        .DOB(p_0_out[19]),
        .DOC(p_0_out[20]),
        .DOD(NLW_RAM_reg_0_63_18_20_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_21_23
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[21]),
        .DIB(din[22]),
        .DIC(din[23]),
        .DID(1'b0),
        .DOA(p_0_out[21]),
        .DOB(p_0_out[22]),
        .DOC(p_0_out[23]),
        .DOD(NLW_RAM_reg_0_63_21_23_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_24_26
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[24]),
        .DIB(din[25]),
        .DIC(din[26]),
        .DID(1'b0),
        .DOA(p_0_out[24]),
        .DOB(p_0_out[25]),
        .DOC(p_0_out[26]),
        .DOD(NLW_RAM_reg_0_63_24_26_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_27_29
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[27]),
        .DIB(din[28]),
        .DIC(din[29]),
        .DID(1'b0),
        .DOA(p_0_out[27]),
        .DOB(p_0_out[28]),
        .DOC(p_0_out[29]),
        .DOD(NLW_RAM_reg_0_63_27_29_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_30_32
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[30]),
        .DIB(din[31]),
        .DIC(din[32]),
        .DID(1'b0),
        .DOA(p_0_out[30]),
        .DOB(p_0_out[31]),
        .DOC(p_0_out[32]),
        .DOD(NLW_RAM_reg_0_63_30_32_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_33_35
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[33]),
        .DIB(din[34]),
        .DIC(din[35]),
        .DID(1'b0),
        .DOA(p_0_out[33]),
        .DOB(p_0_out[34]),
        .DOC(p_0_out[35]),
        .DOD(NLW_RAM_reg_0_63_33_35_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_36_38
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[36]),
        .DIB(din[37]),
        .DIC(din[38]),
        .DID(1'b0),
        .DOA(p_0_out[36]),
        .DOB(p_0_out[37]),
        .DOC(p_0_out[38]),
        .DOD(NLW_RAM_reg_0_63_36_38_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_39_41
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[39]),
        .DIB(din[40]),
        .DIC(din[41]),
        .DID(1'b0),
        .DOA(p_0_out[39]),
        .DOB(p_0_out[40]),
        .DOC(p_0_out[41]),
        .DOD(NLW_RAM_reg_0_63_39_41_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_3_5
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[3]),
        .DIB(din[4]),
        .DIC(din[5]),
        .DID(1'b0),
        .DOA(p_0_out[3]),
        .DOB(p_0_out[4]),
        .DOC(p_0_out[5]),
        .DOD(NLW_RAM_reg_0_63_3_5_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_42_44
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[42]),
        .DIB(din[43]),
        .DIC(din[44]),
        .DID(1'b0),
        .DOA(p_0_out[42]),
        .DOB(p_0_out[43]),
        .DOC(p_0_out[44]),
        .DOD(NLW_RAM_reg_0_63_42_44_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_45_47
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[45]),
        .DIB(din[46]),
        .DIC(din[47]),
        .DID(1'b0),
        .DOA(p_0_out[45]),
        .DOB(p_0_out[46]),
        .DOC(p_0_out[47]),
        .DOD(NLW_RAM_reg_0_63_45_47_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_48_50
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[48]),
        .DIB(din[49]),
        .DIC(din[50]),
        .DID(1'b0),
        .DOA(p_0_out[48]),
        .DOB(p_0_out[49]),
        .DOC(p_0_out[50]),
        .DOD(NLW_RAM_reg_0_63_48_50_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_51_53
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[51]),
        .DIB(din[52]),
        .DIC(din[53]),
        .DID(1'b0),
        .DOA(p_0_out[51]),
        .DOB(p_0_out[52]),
        .DOC(p_0_out[53]),
        .DOD(NLW_RAM_reg_0_63_51_53_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_54_56
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[54]),
        .DIB(din[55]),
        .DIC(din[56]),
        .DID(1'b0),
        .DOA(p_0_out[54]),
        .DOB(p_0_out[55]),
        .DOC(p_0_out[56]),
        .DOD(NLW_RAM_reg_0_63_54_56_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_57_59
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[57]),
        .DIB(din[58]),
        .DIC(din[59]),
        .DID(1'b0),
        .DOA(p_0_out[57]),
        .DOB(p_0_out[58]),
        .DOC(p_0_out[59]),
        .DOD(NLW_RAM_reg_0_63_57_59_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_60_62
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[60]),
        .DIB(din[61]),
        .DIC(din[62]),
        .DID(1'b0),
        .DOA(p_0_out[60]),
        .DOB(p_0_out[61]),
        .DOC(p_0_out[62]),
        .DOD(NLW_RAM_reg_0_63_60_62_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_63_63
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[63]),
        .DIB(1'b0),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(p_0_out[63]),
        .DOB(NLW_RAM_reg_0_63_63_63_DOB_UNCONNECTED),
        .DOC(NLW_RAM_reg_0_63_63_63_DOC_UNCONNECTED),
        .DOD(NLW_RAM_reg_0_63_63_63_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_6_8
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[6]),
        .DIB(din[7]),
        .DIC(din[8]),
        .DID(1'b0),
        .DOA(p_0_out[6]),
        .DOB(p_0_out[7]),
        .DOC(p_0_out[8]),
        .DOD(NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
RAM64M RAM_reg_0_63_9_11
       (.ADDRA(O2),
        .ADDRB(O2),
        .ADDRC(O2),
        .ADDRD(O3),
        .DIA(din[9]),
        .DIB(din[10]),
        .DIC(din[11]),
        .DID(1'b0),
        .DOA(p_0_out[9]),
        .DOB(p_0_out[10]),
        .DOC(p_0_out[11]),
        .DOD(NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(I2));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[0] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[0]),
        .Q(Q[0]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[10] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[10]),
        .Q(Q[10]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[11] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[11]),
        .Q(Q[11]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[12] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[12]),
        .Q(Q[12]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[13] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[13]),
        .Q(Q[13]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[14] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[14]),
        .Q(Q[14]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[15] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[15]),
        .Q(Q[15]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[16] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[16]),
        .Q(Q[16]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[17] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[17]),
        .Q(Q[17]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[18] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[18]),
        .Q(Q[18]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[19] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[19]),
        .Q(Q[19]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[1] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[1]),
        .Q(Q[1]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[20] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[20]),
        .Q(Q[20]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[21] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[21]),
        .Q(Q[21]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[22] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[22]),
        .Q(Q[22]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[23] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[23]),
        .Q(Q[23]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[24] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[24]),
        .Q(Q[24]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[25] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[25]),
        .Q(Q[25]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[26] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[26]),
        .Q(Q[26]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[27] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[27]),
        .Q(Q[27]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[28] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[28]),
        .Q(Q[28]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[29] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[29]),
        .Q(Q[29]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[2] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[2]),
        .Q(Q[2]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[30] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[30]),
        .Q(Q[30]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[31] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[31]),
        .Q(Q[31]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[32] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[32]),
        .Q(Q[32]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[33] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[33]),
        .Q(Q[33]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[34] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[34]),
        .Q(Q[34]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[35] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[35]),
        .Q(Q[35]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[36] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[36]),
        .Q(Q[36]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[37] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[37]),
        .Q(Q[37]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[38] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[38]),
        .Q(Q[38]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[39] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[39]),
        .Q(Q[39]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[3] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[3]),
        .Q(Q[3]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[40] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[40]),
        .Q(Q[40]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[41] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[41]),
        .Q(Q[41]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[42] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[42]),
        .Q(Q[42]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[43] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[43]),
        .Q(Q[43]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[44] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[44]),
        .Q(Q[44]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[45] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[45]),
        .Q(Q[45]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[46] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[46]),
        .Q(Q[46]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[47] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[47]),
        .Q(Q[47]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[48] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[48]),
        .Q(Q[48]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[49] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[49]),
        .Q(Q[49]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[4] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[4]),
        .Q(Q[4]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[50] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[50]),
        .Q(Q[50]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[51] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[51]),
        .Q(Q[51]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[52] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[52]),
        .Q(Q[52]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[53] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[53]),
        .Q(Q[53]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[54] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[54]),
        .Q(Q[54]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[55] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[55]),
        .Q(Q[55]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[56] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[56]),
        .Q(Q[56]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[57] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[57]),
        .Q(Q[57]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[58] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[58]),
        .Q(Q[58]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[59] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[59]),
        .Q(Q[59]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[5] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[5]),
        .Q(Q[5]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[60] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[60]),
        .Q(Q[60]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[61] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[61]),
        .Q(Q[61]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[62] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[62]),
        .Q(Q[62]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[63] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[63]),
        .Q(Q[63]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[6] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[6]),
        .Q(Q[6]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[7] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[7]),
        .Q(Q[7]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[8] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[8]),
        .Q(Q[8]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[9] 
       (.C(clk),
        .CE(E),
        .CLR(I1),
        .D(p_0_out[9]),
        .Q(Q[9]));
endmodule

(* ORIG_REF_NAME = "fifo_generator_ramfifo" *) 
module tx_fifo_ext_fifo_generator_ramfifo
   (dout,
    empty,
    full,
    prog_full,
    rd_en,
    clk,
    rst,
    din,
    wr_en);
  output [63:0]dout;
  output empty;
  output full;
  output prog_full;
  input rd_en;
  input clk;
  input rst;
  input [63:0]din;
  input wr_en;

  wire RD_RST;
  wire WR_RST;
  wire [0:0]adjusted_rd_pntr_wr_inv_pad;
  wire clk;
  wire [63:0]din;
  wire [63:0]dout;
  wire empty;
  wire full;
  wire \gwss.wsts/ram_full_comb ;
  wire \n_1_gntv_or_sync_fifo.gl0.rd ;
  wire \n_2_gntv_or_sync_fifo.gl0.rd ;
  wire n_3_rstblk;
  wire \n_4_gntv_or_sync_fifo.gl0.wr ;
  wire n_5_rstblk;
  wire [5:0]p_10_out;
  wire p_15_out;
  wire [5:0]p_20_out;
  wire p_2_out;
  wire p_4_out;
  wire [4:4]p_9_out;
  wire prog_full;
  wire rd_en;
  wire rst;
  wire rst_d2;
  wire rst_full_gen_i;
  wire wr_en;

tx_fifo_ext_rd_logic \gntv_or_sync_fifo.gl0.rd 
       (.E(\n_1_gntv_or_sync_fifo.gl0.rd ),
        .I1(p_10_out),
        .I2(p_9_out),
        .I3(\n_4_gntv_or_sync_fifo.gl0.wr ),
        .I4(n_3_rstblk),
        .O1(\n_2_gntv_or_sync_fifo.gl0.rd ),
        .O2(p_20_out),
        .O3(p_15_out),
        .Q(RD_RST),
        .clk(clk),
        .empty(empty),
        .p_2_out(p_2_out),
        .ram_full_comb(\gwss.wsts/ram_full_comb ),
        .rd_en(rd_en),
        .wr_en(wr_en),
        .wr_pntr_plus1_pad(adjusted_rd_pntr_wr_inv_pad));
tx_fifo_ext_wr_logic \gntv_or_sync_fifo.gl0.wr 
       (.AR(WR_RST),
        .E(p_4_out),
        .I1(p_20_out),
        .O1(\n_2_gntv_or_sync_fifo.gl0.rd ),
        .O2(\n_4_gntv_or_sync_fifo.gl0.wr ),
        .O3(p_10_out),
        .Q(p_9_out),
        .clk(clk),
        .full(full),
        .p_2_out(p_2_out),
        .prog_full(prog_full),
        .ram_full_comb(\gwss.wsts/ram_full_comb ),
        .rst_d2(rst_d2),
        .rst_full_gen_i(rst_full_gen_i),
        .wr_en(wr_en),
        .wr_pntr_plus1_pad(adjusted_rd_pntr_wr_inv_pad));
tx_fifo_ext_memory \gntv_or_sync_fifo.mem 
       (.E(\n_1_gntv_or_sync_fifo.gl0.rd ),
        .I1(p_4_out),
        .I2(p_15_out),
        .O2(p_20_out),
        .O3(p_10_out),
        .Q(n_5_rstblk),
        .clk(clk),
        .din(din),
        .dout(dout));
tx_fifo_ext_reset_blk_ramfifo rstblk
       (.AR(WR_RST),
        .O1(n_3_rstblk),
        .Q({RD_RST,n_5_rstblk}),
        .clk(clk),
        .p_2_out(p_2_out),
        .rst(rst),
        .rst_d2(rst_d2),
        .rst_full_gen_i(rst_full_gen_i));
endmodule

(* ORIG_REF_NAME = "fifo_generator_top" *) 
module tx_fifo_ext_fifo_generator_top
   (dout,
    empty,
    full,
    prog_full,
    rd_en,
    clk,
    rst,
    din,
    wr_en);
  output [63:0]dout;
  output empty;
  output full;
  output prog_full;
  input rd_en;
  input clk;
  input rst;
  input [63:0]din;
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

tx_fifo_ext_fifo_generator_ramfifo \grf.rf 
       (.clk(clk),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_full(prog_full),
        .rd_en(rd_en),
        .rst(rst),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "fifo_generator_v12_0" *) (* C_COMMON_CLOCK = "1" *) (* C_COUNT_TYPE = "0" *) 
(* C_DATA_COUNT_WIDTH = "7" *) (* C_DEFAULT_VALUE = "BlankString" *) (* C_DIN_WIDTH = "64" *) 
(* C_DOUT_RST_VAL = "0" *) (* C_DOUT_WIDTH = "64" *) (* C_ENABLE_RLOCS = "0" *) 
(* C_FAMILY = "virtex7" *) (* C_FULL_FLAGS_RST_VAL = "1" *) (* C_HAS_ALMOST_EMPTY = "0" *) 
(* C_HAS_ALMOST_FULL = "0" *) (* C_HAS_BACKUP = "0" *) (* C_HAS_DATA_COUNT = "0" *) 
(* C_HAS_INT_CLK = "0" *) (* C_HAS_MEMINIT_FILE = "0" *) (* C_HAS_OVERFLOW = "0" *) 
(* C_HAS_RD_DATA_COUNT = "0" *) (* C_HAS_RD_RST = "0" *) (* C_HAS_RST = "1" *) 
(* C_HAS_SRST = "0" *) (* C_HAS_UNDERFLOW = "0" *) (* C_HAS_VALID = "0" *) 
(* C_HAS_WR_ACK = "0" *) (* C_HAS_WR_DATA_COUNT = "0" *) (* C_HAS_WR_RST = "0" *) 
(* C_IMPLEMENTATION_TYPE = "0" *) (* C_INIT_WR_PNTR_VAL = "0" *) (* C_MEMORY_TYPE = "2" *) 
(* C_MIF_FILE_NAME = "BlankString" *) (* C_OPTIMIZATION_MODE = "0" *) (* C_OVERFLOW_LOW = "0" *) 
(* C_PRELOAD_LATENCY = "0" *) (* C_PRELOAD_REGS = "1" *) (* C_PRIM_FIFO_TYPE = "512x72" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL = "4" *) (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "5" *) (* C_PROG_EMPTY_TYPE = "0" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL = "62" *) (* C_PROG_FULL_THRESH_NEGATE_VAL = "61" *) (* C_PROG_FULL_TYPE = "1" *) 
(* C_RD_DATA_COUNT_WIDTH = "7" *) (* C_RD_DEPTH = "64" *) (* C_RD_FREQ = "1" *) 
(* C_RD_PNTR_WIDTH = "6" *) (* C_UNDERFLOW_LOW = "0" *) (* C_USE_DOUT_RST = "1" *) 
(* C_USE_ECC = "0" *) (* C_USE_EMBEDDED_REG = "0" *) (* C_USE_PIPELINE_REG = "0" *) 
(* C_POWER_SAVING_MODE = "0" *) (* C_USE_FIFO16_FLAGS = "0" *) (* C_USE_FWFT_DATA_COUNT = "1" *) 
(* C_VALID_LOW = "0" *) (* C_WR_ACK_LOW = "0" *) (* C_WR_DATA_COUNT_WIDTH = "7" *) 
(* C_WR_DEPTH = "64" *) (* C_WR_FREQ = "1" *) (* C_WR_PNTR_WIDTH = "6" *) 
(* C_WR_RESPONSE_LATENCY = "1" *) (* C_MSGON_VAL = "1" *) (* C_ENABLE_RST_SYNC = "1" *) 
(* C_ERROR_INJECTION_TYPE = "0" *) (* C_SYNCHRONIZER_STAGE = "2" *) (* C_INTERFACE_TYPE = "0" *) 
(* C_AXI_TYPE = "1" *) (* C_HAS_AXI_WR_CHANNEL = "1" *) (* C_HAS_AXI_RD_CHANNEL = "1" *) 
(* C_HAS_SLAVE_CE = "0" *) (* C_HAS_MASTER_CE = "0" *) (* C_ADD_NGC_CONSTRAINT = "0" *) 
(* C_USE_COMMON_OVERFLOW = "0" *) (* C_USE_COMMON_UNDERFLOW = "0" *) (* C_USE_DEFAULT_SETTINGS = "0" *) 
(* C_AXI_ID_WIDTH = "1" *) (* C_AXI_ADDR_WIDTH = "32" *) (* C_AXI_DATA_WIDTH = "64" *) 
(* C_AXI_LEN_WIDTH = "8" *) (* C_AXI_LOCK_WIDTH = "1" *) (* C_HAS_AXI_ID = "0" *) 
(* C_HAS_AXI_AWUSER = "0" *) (* C_HAS_AXI_WUSER = "0" *) (* C_HAS_AXI_BUSER = "0" *) 
(* C_HAS_AXI_ARUSER = "0" *) (* C_HAS_AXI_RUSER = "0" *) (* C_AXI_ARUSER_WIDTH = "1" *) 
(* C_AXI_AWUSER_WIDTH = "1" *) (* C_AXI_WUSER_WIDTH = "1" *) (* C_AXI_BUSER_WIDTH = "1" *) 
(* C_AXI_RUSER_WIDTH = "1" *) (* C_HAS_AXIS_TDATA = "1" *) (* C_HAS_AXIS_TID = "0" *) 
(* C_HAS_AXIS_TDEST = "0" *) (* C_HAS_AXIS_TUSER = "1" *) (* C_HAS_AXIS_TREADY = "1" *) 
(* C_HAS_AXIS_TLAST = "0" *) (* C_HAS_AXIS_TSTRB = "0" *) (* C_HAS_AXIS_TKEEP = "0" *) 
(* C_AXIS_TDATA_WIDTH = "8" *) (* C_AXIS_TID_WIDTH = "1" *) (* C_AXIS_TDEST_WIDTH = "1" *) 
(* C_AXIS_TUSER_WIDTH = "4" *) (* C_AXIS_TSTRB_WIDTH = "1" *) (* C_AXIS_TKEEP_WIDTH = "1" *) 
(* C_WACH_TYPE = "0" *) (* C_WDCH_TYPE = "0" *) (* C_WRCH_TYPE = "0" *) 
(* C_RACH_TYPE = "0" *) (* C_RDCH_TYPE = "0" *) (* C_AXIS_TYPE = "0" *) 
(* C_IMPLEMENTATION_TYPE_WACH = "1" *) (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) (* C_IMPLEMENTATION_TYPE_WRCH = "1" *) 
(* C_IMPLEMENTATION_TYPE_RACH = "1" *) (* C_IMPLEMENTATION_TYPE_RDCH = "1" *) (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) 
(* C_APPLICATION_TYPE_WACH = "0" *) (* C_APPLICATION_TYPE_WDCH = "0" *) (* C_APPLICATION_TYPE_WRCH = "0" *) 
(* C_APPLICATION_TYPE_RACH = "0" *) (* C_APPLICATION_TYPE_RDCH = "0" *) (* C_APPLICATION_TYPE_AXIS = "0" *) 
(* C_PRIM_FIFO_TYPE_WACH = "512x36" *) (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
(* C_PRIM_FIFO_TYPE_RACH = "512x36" *) (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) (* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) 
(* C_USE_ECC_WACH = "0" *) (* C_USE_ECC_WDCH = "0" *) (* C_USE_ECC_WRCH = "0" *) 
(* C_USE_ECC_RACH = "0" *) (* C_USE_ECC_RDCH = "0" *) (* C_USE_ECC_AXIS = "0" *) 
(* C_ERROR_INJECTION_TYPE_WACH = "0" *) (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) (* C_ERROR_INJECTION_TYPE_WRCH = "0" *) 
(* C_ERROR_INJECTION_TYPE_RACH = "0" *) (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) (* C_ERROR_INJECTION_TYPE_AXIS = "0" *) 
(* C_DIN_WIDTH_WACH = "32" *) (* C_DIN_WIDTH_WDCH = "64" *) (* C_DIN_WIDTH_WRCH = "2" *) 
(* C_DIN_WIDTH_RACH = "32" *) (* C_DIN_WIDTH_RDCH = "64" *) (* C_DIN_WIDTH_AXIS = "1" *) 
(* C_WR_DEPTH_WACH = "16" *) (* C_WR_DEPTH_WDCH = "1024" *) (* C_WR_DEPTH_WRCH = "16" *) 
(* C_WR_DEPTH_RACH = "16" *) (* C_WR_DEPTH_RDCH = "1024" *) (* C_WR_DEPTH_AXIS = "1024" *) 
(* C_WR_PNTR_WIDTH_WACH = "4" *) (* C_WR_PNTR_WIDTH_WDCH = "10" *) (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
(* C_WR_PNTR_WIDTH_RACH = "4" *) (* C_WR_PNTR_WIDTH_RDCH = "10" *) (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
(* C_HAS_DATA_COUNTS_WACH = "0" *) (* C_HAS_DATA_COUNTS_WDCH = "0" *) (* C_HAS_DATA_COUNTS_WRCH = "0" *) 
(* C_HAS_DATA_COUNTS_RACH = "0" *) (* C_HAS_DATA_COUNTS_RDCH = "0" *) (* C_HAS_DATA_COUNTS_AXIS = "0" *) 
(* C_HAS_PROG_FLAGS_WACH = "0" *) (* C_HAS_PROG_FLAGS_WDCH = "0" *) (* C_HAS_PROG_FLAGS_WRCH = "0" *) 
(* C_HAS_PROG_FLAGS_RACH = "0" *) (* C_HAS_PROG_FLAGS_RDCH = "0" *) (* C_HAS_PROG_FLAGS_AXIS = "0" *) 
(* C_PROG_FULL_TYPE_WACH = "0" *) (* C_PROG_FULL_TYPE_WDCH = "0" *) (* C_PROG_FULL_TYPE_WRCH = "0" *) 
(* C_PROG_FULL_TYPE_RACH = "0" *) (* C_PROG_FULL_TYPE_RDCH = "0" *) (* C_PROG_FULL_TYPE_AXIS = "0" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
(* C_PROG_EMPTY_TYPE_WACH = "0" *) (* C_PROG_EMPTY_TYPE_WDCH = "0" *) (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
(* C_PROG_EMPTY_TYPE_RACH = "0" *) (* C_PROG_EMPTY_TYPE_RDCH = "0" *) (* C_PROG_EMPTY_TYPE_AXIS = "0" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) 
(* C_REG_SLICE_MODE_WACH = "0" *) (* C_REG_SLICE_MODE_WDCH = "0" *) (* C_REG_SLICE_MODE_WRCH = "0" *) 
(* C_REG_SLICE_MODE_RACH = "0" *) (* C_REG_SLICE_MODE_RDCH = "0" *) (* C_REG_SLICE_MODE_AXIS = "0" *) 
module tx_fifo_ext_fifo_generator_v12_0__parameterized0
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
  wire axi_ar_injectdbiterr;
  wire axi_ar_injectsbiterr;
  wire [3:0]axi_ar_prog_empty_thresh;
  wire [3:0]axi_ar_prog_full_thresh;
  wire axi_aw_injectdbiterr;
  wire axi_aw_injectsbiterr;
  wire [3:0]axi_aw_prog_empty_thresh;
  wire [3:0]axi_aw_prog_full_thresh;
  wire axi_b_injectdbiterr;
  wire axi_b_injectsbiterr;
  wire [3:0]axi_b_prog_empty_thresh;
  wire [3:0]axi_b_prog_full_thresh;
  wire axi_r_injectdbiterr;
  wire axi_r_injectsbiterr;
  wire [9:0]axi_r_prog_empty_thresh;
  wire [9:0]axi_r_prog_full_thresh;
  wire axi_w_injectdbiterr;
  wire axi_w_injectsbiterr;
  wire [9:0]axi_w_prog_empty_thresh;
  wire [9:0]axi_w_prog_full_thresh;
  wire axis_injectdbiterr;
  wire axis_injectsbiterr;
  wire [9:0]axis_prog_empty_thresh;
  wire [9:0]axis_prog_full_thresh;
  wire backup;
  wire backup_marker;
  wire clk;
  wire [63:0]din;
  wire [63:0]dout;
  wire empty;
  wire full;
  wire injectdbiterr;
  wire injectsbiterr;
  wire int_clk;
  wire m_aclk;
  wire m_aclk_en;
  wire m_axi_arready;
  wire m_axi_awready;
  wire [0:0]m_axi_bid;
  wire [1:0]m_axi_bresp;
  wire [0:0]m_axi_buser;
  wire m_axi_bvalid;
  wire [63:0]m_axi_rdata;
  wire [0:0]m_axi_rid;
  wire m_axi_rlast;
  wire [1:0]m_axi_rresp;
  wire [0:0]m_axi_ruser;
  wire m_axi_rvalid;
  wire m_axi_wready;
  wire m_axis_tready;
  wire [5:0]prog_empty_thresh;
  wire [5:0]prog_empty_thresh_assert;
  wire [5:0]prog_empty_thresh_negate;
  wire prog_full;
  wire [5:0]prog_full_thresh;
  wire [5:0]prog_full_thresh_assert;
  wire [5:0]prog_full_thresh_negate;
  wire rd_clk;
  wire rd_en;
  wire rd_rst;
  wire rst;
  wire s_aclk;
  wire s_aclk_en;
  wire s_aresetn;
  wire [31:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arcache;
  wire [0:0]s_axi_arid;
  wire [7:0]s_axi_arlen;
  wire [0:0]s_axi_arlock;
  wire [2:0]s_axi_arprot;
  wire [3:0]s_axi_arqos;
  wire [3:0]s_axi_arregion;
  wire [2:0]s_axi_arsize;
  wire [0:0]s_axi_aruser;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awcache;
  wire [0:0]s_axi_awid;
  wire [7:0]s_axi_awlen;
  wire [0:0]s_axi_awlock;
  wire [2:0]s_axi_awprot;
  wire [3:0]s_axi_awqos;
  wire [3:0]s_axi_awregion;
  wire [2:0]s_axi_awsize;
  wire [0:0]s_axi_awuser;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_rready;
  wire [63:0]s_axi_wdata;
  wire [0:0]s_axi_wid;
  wire s_axi_wlast;
  wire [7:0]s_axi_wstrb;
  wire [0:0]s_axi_wuser;
  wire s_axi_wvalid;
  wire [7:0]s_axis_tdata;
  wire [0:0]s_axis_tdest;
  wire [0:0]s_axis_tid;
  wire [0:0]s_axis_tkeep;
  wire s_axis_tlast;
  wire [0:0]s_axis_tstrb;
  wire [3:0]s_axis_tuser;
  wire s_axis_tvalid;
  wire srst;
  wire wr_clk;
  wire wr_en;
  wire wr_rst;

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
tx_fifo_ext_fifo_generator_v12_0_synth inst_fifo_gen
       (.clk(clk),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_full(prog_full),
        .rd_en(rd_en),
        .rst(rst),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "fifo_generator_v12_0_synth" *) 
module tx_fifo_ext_fifo_generator_v12_0_synth
   (dout,
    empty,
    full,
    prog_full,
    rd_en,
    clk,
    rst,
    din,
    wr_en);
  output [63:0]dout;
  output empty;
  output full;
  output prog_full;
  input rd_en;
  input clk;
  input rst;
  input [63:0]din;
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

tx_fifo_ext_fifo_generator_top \gconvfifo.rf 
       (.clk(clk),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_full(prog_full),
        .rd_en(rd_en),
        .rst(rst),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "memory" *) 
module tx_fifo_ext_memory
   (dout,
    E,
    clk,
    Q,
    din,
    I1,
    O2,
    O3,
    I2);
  output [63:0]dout;
  input [0:0]E;
  input clk;
  input [0:0]Q;
  input [63:0]din;
  input [0:0]I1;
  input [5:0]O2;
  input [5:0]O3;
  input [0:0]I2;

  wire [0:0]E;
  wire [0:0]I1;
  wire [0:0]I2;
  wire [5:0]O2;
  wire [5:0]O3;
  wire [0:0]Q;
  wire clk;
  wire [63:0]din;
  wire [63:0]dout;
  wire [63:0]p_0_out;

tx_fifo_ext_dmem \gdm.dm 
       (.E(E),
        .I1(Q),
        .I2(I1),
        .O2(O2),
        .O3(O3),
        .Q(p_0_out),
        .clk(clk),
        .din(din));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[0] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[0]),
        .Q(dout[0]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[10] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[10]),
        .Q(dout[10]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[11] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[11]),
        .Q(dout[11]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[12] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[12]),
        .Q(dout[12]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[13] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[13]),
        .Q(dout[13]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[14] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[14]),
        .Q(dout[14]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[15] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[15]),
        .Q(dout[15]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[16] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[16]),
        .Q(dout[16]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[17] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[17]),
        .Q(dout[17]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[18] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[18]),
        .Q(dout[18]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[19] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[19]),
        .Q(dout[19]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[1] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[1]),
        .Q(dout[1]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[20] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[20]),
        .Q(dout[20]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[21] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[21]),
        .Q(dout[21]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[22] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[22]),
        .Q(dout[22]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[23] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[23]),
        .Q(dout[23]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[24] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[24]),
        .Q(dout[24]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[25] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[25]),
        .Q(dout[25]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[26] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[26]),
        .Q(dout[26]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[27] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[27]),
        .Q(dout[27]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[28] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[28]),
        .Q(dout[28]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[29] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[29]),
        .Q(dout[29]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[2] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[2]),
        .Q(dout[2]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[30] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[30]),
        .Q(dout[30]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[31] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[31]),
        .Q(dout[31]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[32] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[32]),
        .Q(dout[32]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[33] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[33]),
        .Q(dout[33]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[34] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[34]),
        .Q(dout[34]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[35] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[35]),
        .Q(dout[35]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[36] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[36]),
        .Q(dout[36]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[37] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[37]),
        .Q(dout[37]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[38] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[38]),
        .Q(dout[38]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[39] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[39]),
        .Q(dout[39]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[3] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[3]),
        .Q(dout[3]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[40] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[40]),
        .Q(dout[40]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[41] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[41]),
        .Q(dout[41]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[42] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[42]),
        .Q(dout[42]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[43] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[43]),
        .Q(dout[43]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[44] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[44]),
        .Q(dout[44]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[45] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[45]),
        .Q(dout[45]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[46] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[46]),
        .Q(dout[46]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[47] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[47]),
        .Q(dout[47]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[48] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[48]),
        .Q(dout[48]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[49] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[49]),
        .Q(dout[49]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[4] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[4]),
        .Q(dout[4]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[50] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[50]),
        .Q(dout[50]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[51] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[51]),
        .Q(dout[51]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[52] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[52]),
        .Q(dout[52]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[53] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[53]),
        .Q(dout[53]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[54] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[54]),
        .Q(dout[54]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[55] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[55]),
        .Q(dout[55]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[56] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[56]),
        .Q(dout[56]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[57] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[57]),
        .Q(dout[57]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[58] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[58]),
        .Q(dout[58]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[59] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[59]),
        .Q(dout[59]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[5] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[5]),
        .Q(dout[5]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[60] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[60]),
        .Q(dout[60]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[61] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[61]),
        .Q(dout[61]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[62] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[62]),
        .Q(dout[62]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[63] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[63]),
        .Q(dout[63]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[6] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[6]),
        .Q(dout[6]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[7] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[7]),
        .Q(dout[7]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[8] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[8]),
        .Q(dout[8]));
FDCE #(
    .INIT(1'b0)) 
     \goreg_dm.dout_i_reg[9] 
       (.C(clk),
        .CE(I2),
        .CLR(Q),
        .D(p_0_out[9]),
        .Q(dout[9]));
endmodule

(* ORIG_REF_NAME = "rd_bin_cntr" *) 
module tx_fifo_ext_rd_bin_cntr
   (Q,
    O1,
    ram_full_comb,
    O2,
    I1,
    I2,
    p_18_out,
    wr_en,
    p_2_out,
    E,
    I3,
    I4,
    I5,
    I6,
    clk,
    I7);
  output [0:0]Q;
  output O1;
  output ram_full_comb;
  output [5:0]O2;
  input [5:0]I1;
  input I2;
  input p_18_out;
  input wr_en;
  input p_2_out;
  input [0:0]E;
  input [0:0]I3;
  input I4;
  input I5;
  input [0:0]I6;
  input clk;
  input [0:0]I7;

  wire [0:0]E;
  wire [5:0]I1;
  wire I2;
  wire [0:0]I3;
  wire I4;
  wire I5;
  wire [0:0]I6;
  wire [0:0]I7;
  wire O1;
  wire [5:0]O2;
  wire [0:0]Q;
  wire clk;
  wire n_0_ram_empty_fb_i_i_2;
  wire n_0_ram_empty_fb_i_i_4;
  wire n_0_ram_full_i_i_4;
  wire n_0_ram_full_i_i_6;
  wire n_0_ram_full_i_i_7;
  wire p_18_out;
  wire p_2_out;
  wire [5:0]plusOp__0;
  wire ram_full_comb;
  wire [4:0]rd_pntr_plus1;
  wire wr_en;

LUT1 #(
    .INIT(2'h1)) 
     \gc0.count[0]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .O(plusOp__0[0]));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \gc0.count[1]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .I1(rd_pntr_plus1[1]),
        .O(plusOp__0[1]));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \gc0.count[2]_i_1 
       (.I0(rd_pntr_plus1[2]),
        .I1(rd_pntr_plus1[0]),
        .I2(rd_pntr_plus1[1]),
        .O(plusOp__0[2]));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \gc0.count[3]_i_1 
       (.I0(rd_pntr_plus1[1]),
        .I1(rd_pntr_plus1[0]),
        .I2(rd_pntr_plus1[2]),
        .I3(rd_pntr_plus1[3]),
        .O(plusOp__0[3]));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gc0.count[4]_i_1 
       (.I0(rd_pntr_plus1[4]),
        .I1(rd_pntr_plus1[1]),
        .I2(rd_pntr_plus1[0]),
        .I3(rd_pntr_plus1[2]),
        .I4(rd_pntr_plus1[3]),
        .O(plusOp__0[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \gc0.count[5]_i_1 
       (.I0(Q),
        .I1(rd_pntr_plus1[3]),
        .I2(rd_pntr_plus1[2]),
        .I3(rd_pntr_plus1[0]),
        .I4(rd_pntr_plus1[1]),
        .I5(rd_pntr_plus1[4]),
        .O(plusOp__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[0] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(rd_pntr_plus1[0]),
        .Q(O2[0]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[1] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(rd_pntr_plus1[1]),
        .Q(O2[1]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[2] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(rd_pntr_plus1[2]),
        .Q(O2[2]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[3] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(rd_pntr_plus1[3]),
        .Q(O2[3]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[4] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(rd_pntr_plus1[4]),
        .Q(O2[4]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[5] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(Q),
        .Q(O2[5]));
FDPE #(
    .INIT(1'b1)) 
     \gc0.count_reg[0] 
       (.C(clk),
        .CE(I6),
        .D(plusOp__0[0]),
        .PRE(I7),
        .Q(rd_pntr_plus1[0]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[1] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(plusOp__0[1]),
        .Q(rd_pntr_plus1[1]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[2] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(plusOp__0[2]),
        .Q(rd_pntr_plus1[2]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[3] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(plusOp__0[3]),
        .Q(rd_pntr_plus1[3]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[4] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(plusOp__0[4]),
        .Q(rd_pntr_plus1[4]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[5] 
       (.C(clk),
        .CE(I6),
        .CLR(I7),
        .D(plusOp__0[5]),
        .Q(Q));
LUT5 #(
    .INIT(32'hFAFAC0FA)) 
     ram_empty_fb_i_i_1
       (.I0(n_0_ram_empty_fb_i_i_2),
        .I1(n_0_ram_full_i_i_4),
        .I2(p_18_out),
        .I3(wr_en),
        .I4(p_2_out),
        .O(O1));
LUT6 #(
    .INIT(64'h9009000000000000)) 
     ram_empty_fb_i_i_2
       (.I0(rd_pntr_plus1[1]),
        .I1(I1[1]),
        .I2(rd_pntr_plus1[0]),
        .I3(I1[0]),
        .I4(I2),
        .I5(n_0_ram_empty_fb_i_i_4),
        .O(n_0_ram_empty_fb_i_i_2));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_empty_fb_i_i_4
       (.I0(rd_pntr_plus1[4]),
        .I1(I1[4]),
        .I2(rd_pntr_plus1[3]),
        .I3(I1[3]),
        .I4(I1[2]),
        .I5(rd_pntr_plus1[2]),
        .O(n_0_ram_empty_fb_i_i_4));
LUT6 #(
    .INIT(64'h4100FFFF41005555)) 
     ram_full_i_i_1
       (.I0(E),
        .I1(I3),
        .I2(O2[4]),
        .I3(I4),
        .I4(I5),
        .I5(n_0_ram_full_i_i_4),
        .O(ram_full_comb));
LUT6 #(
    .INIT(64'hBEFFFFBEFFFFFFFF)) 
     ram_full_i_i_4
       (.I0(n_0_ram_full_i_i_6),
        .I1(O2[2]),
        .I2(I1[2]),
        .I3(O2[3]),
        .I4(I1[3]),
        .I5(n_0_ram_full_i_i_7),
        .O(n_0_ram_full_i_i_4));
LUT4 #(
    .INIT(16'h6FF6)) 
     ram_full_i_i_6
       (.I0(O2[0]),
        .I1(I1[0]),
        .I2(O2[1]),
        .I3(I1[1]),
        .O(n_0_ram_full_i_i_6));
LUT4 #(
    .INIT(16'h9009)) 
     ram_full_i_i_7
       (.I0(O2[5]),
        .I1(I1[5]),
        .I2(O2[4]),
        .I3(I1[4]),
        .O(n_0_ram_full_i_i_7));
endmodule

(* ORIG_REF_NAME = "rd_fwft" *) 
module tx_fifo_ext_rd_fwft
   (empty,
    O1,
    E,
    O2,
    wr_pntr_plus1_pad,
    O3,
    clk,
    Q,
    rd_en,
    I1,
    I2,
    p_18_out,
    p_2_out,
    wr_en);
  output empty;
  output O1;
  output [0:0]E;
  output [0:0]O2;
  output [0:0]wr_pntr_plus1_pad;
  output [0:0]O3;
  input clk;
  input [0:0]Q;
  input rd_en;
  input [0:0]I1;
  input [0:0]I2;
  input p_18_out;
  input p_2_out;
  input wr_en;

  wire [0:0]E;
  wire [0:0]I1;
  wire [0:0]I2;
  wire O1;
  wire [0:0]O2;
  wire [0:0]O3;
  wire [0:0]Q;
  wire clk;
  wire [0:0]curr_fwft_state;
  wire empty;
  wire empty_fwft_fb;
  wire empty_fwft_i0;
  wire \n_0_gpregsm1.curr_fwft_state[0]_i_1 ;
  wire \n_0_gpregsm1.curr_fwft_state[1]_i_1 ;
  wire \n_0_gpregsm1.curr_fwft_state_reg[1] ;
  wire p_18_out;
  wire p_2_out;
  wire rd_en;
  wire wr_en;
  wire [0:0]wr_pntr_plus1_pad;

(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     empty_fwft_fb_reg
       (.C(clk),
        .CE(1'b1),
        .D(empty_fwft_i0),
        .PRE(Q),
        .Q(empty_fwft_fb));
LUT4 #(
    .INIT(16'hCF08)) 
     empty_fwft_i_i_1
       (.I0(rd_en),
        .I1(curr_fwft_state),
        .I2(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I3(empty_fwft_fb),
        .O(empty_fwft_i0));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     empty_fwft_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(empty_fwft_i0),
        .PRE(Q),
        .Q(empty));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT4 #(
    .INIT(16'h5515)) 
     \gc0.count_d1[5]_i_1 
       (.I0(p_18_out),
        .I1(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I2(curr_fwft_state),
        .I3(rd_en),
        .O(O2));
LUT6 #(
    .INIT(64'h4444444404000000)) 
     \gdiff.gcry_1_sym.diff_pntr_pad[3]_i_2 
       (.I0(p_2_out),
        .I1(wr_en),
        .I2(rd_en),
        .I3(curr_fwft_state),
        .I4(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I5(p_18_out),
        .O(wr_pntr_plus1_pad));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT3 #(
    .INIT(8'h8A)) 
     \goreg_dm.dout_i[63]_i_1 
       (.I0(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I1(rd_en),
        .I2(curr_fwft_state),
        .O(O3));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT4 #(
    .INIT(16'h5515)) 
     \gpr1.dout_i[63]_i_1 
       (.I0(p_18_out),
        .I1(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I2(curr_fwft_state),
        .I3(rd_en),
        .O(E));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT3 #(
    .INIT(8'hBA)) 
     \gpregsm1.curr_fwft_state[0]_i_1 
       (.I0(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I1(rd_en),
        .I2(curr_fwft_state),
        .O(\n_0_gpregsm1.curr_fwft_state[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT4 #(
    .INIT(16'h08FF)) 
     \gpregsm1.curr_fwft_state[1]_i_1 
       (.I0(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I1(curr_fwft_state),
        .I2(rd_en),
        .I3(p_18_out),
        .O(\n_0_gpregsm1.curr_fwft_state[1]_i_1 ));
(* equivalent_register_removal = "no" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gpregsm1.curr_fwft_state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(Q),
        .D(\n_0_gpregsm1.curr_fwft_state[0]_i_1 ),
        .Q(curr_fwft_state));
(* equivalent_register_removal = "no" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gpregsm1.curr_fwft_state_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(Q),
        .D(\n_0_gpregsm1.curr_fwft_state[1]_i_1 ),
        .Q(\n_0_gpregsm1.curr_fwft_state_reg[1] ));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT5 #(
    .INIT(32'h99990999)) 
     ram_empty_fb_i_i_3
       (.I0(I1),
        .I1(I2),
        .I2(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I3(curr_fwft_state),
        .I4(rd_en),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "rd_logic" *) 
module tx_fifo_ext_rd_logic
   (empty,
    E,
    O1,
    wr_pntr_plus1_pad,
    ram_full_comb,
    O2,
    O3,
    clk,
    Q,
    rd_en,
    I1,
    wr_en,
    p_2_out,
    I2,
    I3,
    I4);
  output empty;
  output [0:0]E;
  output [0:0]O1;
  output [0:0]wr_pntr_plus1_pad;
  output ram_full_comb;
  output [5:0]O2;
  output [0:0]O3;
  input clk;
  input [0:0]Q;
  input rd_en;
  input [5:0]I1;
  input wr_en;
  input p_2_out;
  input [0:0]I2;
  input I3;
  input I4;

  wire [0:0]E;
  wire [5:0]I1;
  wire [0:0]I2;
  wire I3;
  wire I4;
  wire [0:0]O1;
  wire [5:0]O2;
  wire [0:0]O3;
  wire [0:0]Q;
  wire clk;
  wire empty;
  wire \n_1_gr1.rfwft ;
  wire n_1_rpntr;
  wire p_18_out;
  wire p_2_out;
  wire ram_full_comb;
  wire rd_en;
  wire [5:5]rd_pntr_plus1;
  wire wr_en;
  wire [0:0]wr_pntr_plus1_pad;

tx_fifo_ext_rd_fwft \gr1.rfwft 
       (.E(E),
        .I1(I1[5]),
        .I2(rd_pntr_plus1),
        .O1(\n_1_gr1.rfwft ),
        .O2(O1),
        .O3(O3),
        .Q(Q),
        .clk(clk),
        .empty(empty),
        .p_18_out(p_18_out),
        .p_2_out(p_2_out),
        .rd_en(rd_en),
        .wr_en(wr_en),
        .wr_pntr_plus1_pad(wr_pntr_plus1_pad));
tx_fifo_ext_rd_status_flags_ss \grss.rsts 
       (.I1(n_1_rpntr),
        .Q(Q),
        .clk(clk),
        .p_18_out(p_18_out));
tx_fifo_ext_rd_bin_cntr rpntr
       (.E(E),
        .I1(I1),
        .I2(\n_1_gr1.rfwft ),
        .I3(I2),
        .I4(I3),
        .I5(I4),
        .I6(O1),
        .I7(Q),
        .O1(n_1_rpntr),
        .O2(O2),
        .Q(rd_pntr_plus1),
        .clk(clk),
        .p_18_out(p_18_out),
        .p_2_out(p_2_out),
        .ram_full_comb(ram_full_comb),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "rd_status_flags_ss" *) 
module tx_fifo_ext_rd_status_flags_ss
   (p_18_out,
    I1,
    clk,
    Q);
  output p_18_out;
  input I1;
  input clk;
  input [0:0]Q;

  wire I1;
  wire [0:0]Q;
  wire clk;
  wire p_18_out;

(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     ram_empty_fb_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(I1),
        .PRE(Q),
        .Q(p_18_out));
endmodule

(* ORIG_REF_NAME = "reset_blk_ramfifo" *) 
module tx_fifo_ext_reset_blk_ramfifo
   (rst_d2,
    rst_full_gen_i,
    AR,
    O1,
    Q,
    clk,
    rst,
    p_2_out);
  output rst_d2;
  output rst_full_gen_i;
  output [0:0]AR;
  output O1;
  output [1:0]Q;
  input clk;
  input rst;
  input p_2_out;

  wire [0:0]AR;
  wire O1;
  wire [1:0]Q;
  wire clk;
  wire \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ;
  wire \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 ;
  wire p_2_out;
  wire rd_rst_asreg;
  wire rd_rst_asreg_d1;
  wire rd_rst_asreg_d2;
  wire rst;
  wire rst_d1;
  wire rst_d2;
  wire rst_d3;
  wire rst_full_gen_i;
  wire wr_rst_asreg;
  wire wr_rst_asreg_d1;
  wire wr_rst_asreg_d2;

FDCE #(
    .INIT(1'b0)) 
     \grstd1.grst_full.grst_f.RST_FULL_GEN_reg 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(rst_d3),
        .Q(rst_full_gen_i));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE #(
    .INIT(1'b1)) 
     \grstd1.grst_full.grst_f.rst_d1_reg 
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(rst),
        .Q(rst_d1));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE #(
    .INIT(1'b1)) 
     \grstd1.grst_full.grst_f.rst_d2_reg 
       (.C(clk),
        .CE(1'b1),
        .D(rst_d1),
        .PRE(rst),
        .Q(rst_d2));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE #(
    .INIT(1'b1)) 
     \grstd1.grst_full.grst_f.rst_d3_reg 
       (.C(clk),
        .CE(1'b1),
        .D(rst_d2),
        .PRE(rst),
        .Q(rst_d3));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg 
       (.C(clk),
        .CE(1'b1),
        .D(rd_rst_asreg),
        .Q(rd_rst_asreg_d1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg 
       (.C(clk),
        .CE(1'b1),
        .D(rd_rst_asreg_d1),
        .Q(rd_rst_asreg_d2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE \ngwrdrst.grst.g7serrst.rd_rst_asreg_reg 
       (.C(clk),
        .CE(rd_rst_asreg_d1),
        .D(1'b0),
        .PRE(rst),
        .Q(rd_rst_asreg));
LUT2 #(
    .INIT(4'h2)) 
     \ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 
       (.I0(rd_rst_asreg),
        .I1(rd_rst_asreg_d2),
        .O(\n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ),
        .Q(Q[0]));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ),
        .Q(Q[1]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg 
       (.C(clk),
        .CE(1'b1),
        .D(wr_rst_asreg),
        .Q(wr_rst_asreg_d1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg 
       (.C(clk),
        .CE(1'b1),
        .D(wr_rst_asreg_d1),
        .Q(wr_rst_asreg_d2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE \ngwrdrst.grst.g7serrst.wr_rst_asreg_reg 
       (.C(clk),
        .CE(wr_rst_asreg_d1),
        .D(1'b0),
        .PRE(rst),
        .Q(wr_rst_asreg));
LUT2 #(
    .INIT(4'h2)) 
     \ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 
       (.I0(wr_rst_asreg),
        .I1(wr_rst_asreg_d2),
        .O(\n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 ));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 ),
        .Q(AR));
LUT2 #(
    .INIT(4'hB)) 
     ram_full_i_i_3
       (.I0(rst_full_gen_i),
        .I1(p_2_out),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "wr_bin_cntr" *) 
module tx_fifo_ext_wr_bin_cntr
   (O2,
    Q,
    O1,
    S,
    O3,
    I1,
    E,
    clk,
    AR);
  output O2;
  output [4:0]Q;
  output [2:0]O1;
  output [2:0]S;
  output [5:0]O3;
  input [5:0]I1;
  input [0:0]E;
  input clk;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [5:0]I1;
  wire [2:0]O1;
  wire O2;
  wire [5:0]O3;
  wire [4:0]Q;
  wire [2:0]S;
  wire clk;
  wire n_0_ram_full_i_i_5;
  wire [5:5]p_9_out;
  wire [5:0]plusOp__1;

LUT1 #(
    .INIT(2'h1)) 
     \gcc0.gc0.count[0]_i_1 
       (.I0(Q[0]),
        .O(plusOp__1[0]));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \gcc0.gc0.count[1]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(plusOp__1[1]));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \gcc0.gc0.count[2]_i_1 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .O(plusOp__1[2]));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \gcc0.gc0.count[3]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(plusOp__1[3]));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gcc0.gc0.count[4]_i_1 
       (.I0(Q[4]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[2]),
        .I4(Q[3]),
        .O(plusOp__1[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \gcc0.gc0.count[5]_i_1 
       (.I0(p_9_out),
        .I1(Q[3]),
        .I2(Q[2]),
        .I3(Q[0]),
        .I4(Q[1]),
        .I5(Q[4]),
        .O(plusOp__1[5]));
FDCE #(
    .INIT(1'b0)) 
     \gcc0.gc0.count_d1_reg[0] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[0]),
        .Q(O3[0]));
FDCE #(
    .INIT(1'b0)) 
     \gcc0.gc0.count_d1_reg[1] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[1]),
        .Q(O3[1]));
FDCE #(
    .INIT(1'b0)) 
     \gcc0.gc0.count_d1_reg[2] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[2]),
        .Q(O3[2]));
FDCE #(
    .INIT(1'b0)) 
     \gcc0.gc0.count_d1_reg[3] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[3]),
        .Q(O3[3]));
FDCE #(
    .INIT(1'b0)) 
     \gcc0.gc0.count_d1_reg[4] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(Q[4]),
        .Q(O3[4]));
FDCE #(
    .INIT(1'b0)) 
     \gcc0.gc0.count_d1_reg[5] 
       (.C(clk),
        .CE(E),
        .CLR(AR),
        .D(p_9_out),
        .Q(O3[5]));
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
        .Q(p_9_out));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.gcry_1_sym.diff_pntr_pad[3]_i_3 
       (.I0(Q[2]),
        .I1(I1[2]),
        .O(S[2]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.gcry_1_sym.diff_pntr_pad[3]_i_4 
       (.I0(Q[1]),
        .I1(I1[1]),
        .O(S[1]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.gcry_1_sym.diff_pntr_pad[3]_i_5 
       (.I0(Q[0]),
        .I1(I1[0]),
        .O(S[0]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.gcry_1_sym.diff_pntr_pad[6]_i_2 
       (.I0(p_9_out),
        .I1(I1[5]),
        .O(O1[2]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.gcry_1_sym.diff_pntr_pad[6]_i_3 
       (.I0(Q[4]),
        .I1(I1[4]),
        .O(O1[1]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.gcry_1_sym.diff_pntr_pad[6]_i_4 
       (.I0(Q[3]),
        .I1(I1[3]),
        .O(O1[0]));
LUT6 #(
    .INIT(64'h8200000000008200)) 
     ram_full_i_i_2
       (.I0(n_0_ram_full_i_i_5),
        .I1(Q[3]),
        .I2(I1[3]),
        .I3(E),
        .I4(I1[2]),
        .I5(Q[2]),
        .O(O2));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_full_i_i_5
       (.I0(Q[1]),
        .I1(I1[1]),
        .I2(Q[0]),
        .I3(I1[0]),
        .I4(I1[5]),
        .I5(p_9_out),
        .O(n_0_ram_full_i_i_5));
endmodule

(* ORIG_REF_NAME = "wr_logic" *) 
module tx_fifo_ext_wr_logic
   (p_2_out,
    full,
    E,
    prog_full,
    O2,
    Q,
    O3,
    ram_full_comb,
    clk,
    rst_d2,
    O1,
    AR,
    I1,
    wr_en,
    rst_full_gen_i,
    wr_pntr_plus1_pad);
  output p_2_out;
  output full;
  output [0:0]E;
  output prog_full;
  output O2;
  output [0:0]Q;
  output [5:0]O3;
  input ram_full_comb;
  input clk;
  input rst_d2;
  input [0:0]O1;
  input [0:0]AR;
  input [5:0]I1;
  input wr_en;
  input rst_full_gen_i;
  input [0:0]wr_pntr_plus1_pad;

  wire [0:0]AR;
  wire [0:0]E;
  wire [5:0]I1;
  wire [0:0]O1;
  wire O2;
  wire [5:0]O3;
  wire [0:0]Q;
  wire clk;
  wire full;
  wire n_10_wpntr;
  wire n_11_wpntr;
  wire n_6_wpntr;
  wire n_7_wpntr;
  wire n_8_wpntr;
  wire n_9_wpntr;
  wire p_2_out;
  wire [3:0]p_9_out;
  wire prog_full;
  wire ram_full_comb;
  wire rst_d2;
  wire rst_full_gen_i;
  wire wr_en;
  wire [0:0]wr_pntr_plus1_pad;

tx_fifo_ext_wr_pf_ss \gwss.gpf.wrpf 
       (.AR(AR),
        .E(E),
        .I1({n_6_wpntr,n_7_wpntr,n_8_wpntr}),
        .O1(O1),
        .Q({Q,p_9_out}),
        .S({n_9_wpntr,n_10_wpntr,n_11_wpntr}),
        .clk(clk),
        .prog_full(prog_full),
        .rst_d2(rst_d2),
        .rst_full_gen_i(rst_full_gen_i),
        .wr_pntr_plus1_pad(wr_pntr_plus1_pad));
tx_fifo_ext_wr_status_flags_ss \gwss.wsts 
       (.E(E),
        .clk(clk),
        .full(full),
        .p_2_out(p_2_out),
        .ram_full_comb(ram_full_comb),
        .rst_d2(rst_d2),
        .wr_en(wr_en));
tx_fifo_ext_wr_bin_cntr wpntr
       (.AR(AR),
        .E(E),
        .I1(I1),
        .O1({n_6_wpntr,n_7_wpntr,n_8_wpntr}),
        .O2(O2),
        .O3(O3),
        .Q({Q,p_9_out}),
        .S({n_9_wpntr,n_10_wpntr,n_11_wpntr}),
        .clk(clk));
endmodule

(* ORIG_REF_NAME = "wr_pf_ss" *) 
module tx_fifo_ext_wr_pf_ss
   (prog_full,
    O1,
    clk,
    AR,
    E,
    rst_d2,
    rst_full_gen_i,
    Q,
    wr_pntr_plus1_pad,
    S,
    I1);
  output prog_full;
  input [0:0]O1;
  input clk;
  input [0:0]AR;
  input [0:0]E;
  input rst_d2;
  input rst_full_gen_i;
  input [4:0]Q;
  input [0:0]wr_pntr_plus1_pad;
  input [2:0]S;
  input [2:0]I1;

  wire [0:0]AR;
  wire [0:0]E;
  wire [2:0]I1;
  wire [0:0]O1;
  wire [4:0]Q;
  wire [2:0]S;
  wire clk;
  wire [6:1]diff_pntr_pad;
  wire \n_0_gdiff.gcry_1_sym.diff_pntr_pad_reg[3]_i_1 ;
  wire \n_0_gpfs.prog_full_i_i_1 ;
  wire \n_0_gpfs.prog_full_i_i_2 ;
  wire \n_1_gdiff.gcry_1_sym.diff_pntr_pad_reg[3]_i_1 ;
  wire \n_2_gdiff.gcry_1_sym.diff_pntr_pad_reg[3]_i_1 ;
  wire \n_2_gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_i_1 ;
  wire \n_3_gdiff.gcry_1_sym.diff_pntr_pad_reg[3]_i_1 ;
  wire \n_3_gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_i_1 ;
  wire [6:0]plusOp;
  wire prog_full;
  wire ram_rd_en_i;
  wire ram_wr_en_i;
  wire rst_d2;
  wire rst_full_gen_i;
  wire [0:0]wr_pntr_plus1_pad;
  wire [3:2]\NLW_gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_i_1_O_UNCONNECTED ;

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
CARRY4 \gdiff.gcry_1_sym.diff_pntr_pad_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\n_0_gdiff.gcry_1_sym.diff_pntr_pad_reg[3]_i_1 ,\n_1_gdiff.gcry_1_sym.diff_pntr_pad_reg[3]_i_1 ,\n_2_gdiff.gcry_1_sym.diff_pntr_pad_reg[3]_i_1 ,\n_3_gdiff.gcry_1_sym.diff_pntr_pad_reg[3]_i_1 }),
        .CYINIT(1'b0),
        .DI({Q[2:0],wr_pntr_plus1_pad}),
        .O(plusOp[3:0]),
        .S({S,1'b0}));
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
CARRY4 \gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_i_1 
       (.CI(\n_0_gdiff.gcry_1_sym.diff_pntr_pad_reg[3]_i_1 ),
        .CO({\NLW_gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_i_1_CO_UNCONNECTED [3:2],\n_2_gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_i_1 ,\n_3_gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,Q[4:3]}),
        .O({\NLW_gdiff.gcry_1_sym.diff_pntr_pad_reg[6]_i_1_O_UNCONNECTED [3],plusOp[6:4]}),
        .S({1'b0,I1}));
LUT5 #(
    .INIT(32'h00F70020)) 
     \gpfs.prog_full_i_i_1 
       (.I0(\n_0_gpfs.prog_full_i_i_2 ),
        .I1(ram_rd_en_i),
        .I2(ram_wr_en_i),
        .I3(rst_full_gen_i),
        .I4(prog_full),
        .O(\n_0_gpfs.prog_full_i_i_1 ));
LUT6 #(
    .INIT(64'h0000080000000000)) 
     \gpfs.prog_full_i_i_2 
       (.I0(diff_pntr_pad[5]),
        .I1(diff_pntr_pad[6]),
        .I2(diff_pntr_pad[1]),
        .I3(diff_pntr_pad[4]),
        .I4(diff_pntr_pad[2]),
        .I5(diff_pntr_pad[3]),
        .O(\n_0_gpfs.prog_full_i_i_2 ));
FDPE #(
    .INIT(1'b1)) 
     \gpfs.prog_full_i_reg 
       (.C(clk),
        .CE(1'b1),
        .D(\n_0_gpfs.prog_full_i_i_1 ),
        .PRE(rst_d2),
        .Q(prog_full));
FDCE #(
    .INIT(1'b0)) 
     \greg.ram_rd_en_i_reg 
       (.C(clk),
        .CE(1'b1),
        .CLR(AR),
        .D(O1),
        .Q(ram_rd_en_i));
FDCE #(
    .INIT(1'b0)) 
     \greg.ram_wr_en_i_reg 
       (.C(clk),
        .CE(1'b1),
        .CLR(AR),
        .D(E),
        .Q(ram_wr_en_i));
endmodule

(* ORIG_REF_NAME = "wr_status_flags_ss" *) 
module tx_fifo_ext_wr_status_flags_ss
   (p_2_out,
    full,
    E,
    ram_full_comb,
    clk,
    rst_d2,
    wr_en);
  output p_2_out;
  output full;
  output [0:0]E;
  input ram_full_comb;
  input clk;
  input rst_d2;
  input wr_en;

  wire [0:0]E;
  wire clk;
  wire full;
  wire p_2_out;
  wire ram_full_comb;
  wire rst_d2;
  wire wr_en;

LUT2 #(
    .INIT(4'h2)) 
     \gcc0.gc0.count_d1[5]_i_1 
       (.I0(wr_en),
        .I1(p_2_out),
        .O(E));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     ram_full_fb_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(ram_full_comb),
        .PRE(rst_d2),
        .Q(p_2_out));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     ram_full_i_reg
       (.C(clk),
        .CE(1'b1),
        .D(ram_full_comb),
        .PRE(rst_d2),
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
