// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
// Date        : Wed Mar 31 11:52:45 2021
// Host        : hwdev-xbs running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /media/data/Francois/VivadoProjects3/FRM123701U1R4/Vivado/IP/adc_cdc_fifo/adc_cdc_fifo_funcsim.v
// Design      : adc_cdc_fifo
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v12_0,Vivado 2014.3.1" *) (* CHECK_LICENSE_TYPE = "adc_cdc_fifo,fifo_generator_v12_0,{}" *) 
(* core_generation_info = "adc_cdc_fifo,fifo_generator_v12_0,{x_ipProduct=Vivado 2014.3.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=fifo_generator,x_ipVersion=12.0,x_ipCoreRevision=2,x_ipLanguage=VHDL,C_COMMON_CLOCK=0,C_COUNT_TYPE=0,C_DATA_COUNT_WIDTH=7,C_DEFAULT_VALUE=BlankString,C_DIN_WIDTH=128,C_DOUT_RST_VAL=0,C_DOUT_WIDTH=128,C_ENABLE_RLOCS=0,C_FAMILY=virtex7,C_FULL_FLAGS_RST_VAL=1,C_HAS_ALMOST_EMPTY=0,C_HAS_ALMOST_FULL=0,C_HAS_BACKUP=0,C_HAS_DATA_COUNT=0,C_HAS_INT_CLK=0,C_HAS_MEMINIT_FILE=0,C_HAS_OVERFLOW=0,C_HAS_RD_DATA_COUNT=0,C_HAS_RD_RST=0,C_HAS_RST=1,C_HAS_SRST=0,C_HAS_UNDERFLOW=0,C_HAS_VALID=0,C_HAS_WR_ACK=0,C_HAS_WR_DATA_COUNT=0,C_HAS_WR_RST=0,C_IMPLEMENTATION_TYPE=2,C_INIT_WR_PNTR_VAL=0,C_MEMORY_TYPE=2,C_MIF_FILE_NAME=BlankString,C_OPTIMIZATION_MODE=0,C_OVERFLOW_LOW=0,C_PRELOAD_LATENCY=1,C_PRELOAD_REGS=0,C_PRIM_FIFO_TYPE=512x72,C_PROG_EMPTY_THRESH_ASSERT_VAL=6,C_PROG_EMPTY_THRESH_NEGATE_VAL=15,C_PROG_EMPTY_TYPE=2,C_PROG_FULL_THRESH_ASSERT_VAL=125,C_PROG_FULL_THRESH_NEGATE_VAL=124,C_PROG_FULL_TYPE=0,C_RD_DATA_COUNT_WIDTH=7,C_RD_DEPTH=128,C_RD_FREQ=1,C_RD_PNTR_WIDTH=7,C_UNDERFLOW_LOW=0,C_USE_DOUT_RST=1,C_USE_ECC=0,C_USE_EMBEDDED_REG=0,C_USE_PIPELINE_REG=0,C_POWER_SAVING_MODE=0,C_USE_FIFO16_FLAGS=0,C_USE_FWFT_DATA_COUNT=0,C_VALID_LOW=0,C_WR_ACK_LOW=0,C_WR_DATA_COUNT_WIDTH=7,C_WR_DEPTH=128,C_WR_FREQ=1,C_WR_PNTR_WIDTH=7,C_WR_RESPONSE_LATENCY=1,C_MSGON_VAL=1,C_ENABLE_RST_SYNC=1,C_ERROR_INJECTION_TYPE=0,C_SYNCHRONIZER_STAGE=3,C_INTERFACE_TYPE=0,C_AXI_TYPE=1,C_HAS_AXI_WR_CHANNEL=1,C_HAS_AXI_RD_CHANNEL=1,C_HAS_SLAVE_CE=0,C_HAS_MASTER_CE=0,C_ADD_NGC_CONSTRAINT=0,C_USE_COMMON_OVERFLOW=0,C_USE_COMMON_UNDERFLOW=0,C_USE_DEFAULT_SETTINGS=0,C_AXI_ID_WIDTH=1,C_AXI_ADDR_WIDTH=32,C_AXI_DATA_WIDTH=64,C_AXI_LEN_WIDTH=8,C_AXI_LOCK_WIDTH=1,C_HAS_AXI_ID=0,C_HAS_AXI_AWUSER=0,C_HAS_AXI_WUSER=0,C_HAS_AXI_BUSER=0,C_HAS_AXI_ARUSER=0,C_HAS_AXI_RUSER=0,C_AXI_ARUSER_WIDTH=1,C_AXI_AWUSER_WIDTH=1,C_AXI_WUSER_WIDTH=1,C_AXI_BUSER_WIDTH=1,C_AXI_RUSER_WIDTH=1,C_HAS_AXIS_TDATA=1,C_HAS_AXIS_TID=0,C_HAS_AXIS_TDEST=0,C_HAS_AXIS_TUSER=1,C_HAS_AXIS_TREADY=1,C_HAS_AXIS_TLAST=0,C_HAS_AXIS_TSTRB=0,C_HAS_AXIS_TKEEP=0,C_AXIS_TDATA_WIDTH=8,C_AXIS_TID_WIDTH=1,C_AXIS_TDEST_WIDTH=1,C_AXIS_TUSER_WIDTH=4,C_AXIS_TSTRB_WIDTH=1,C_AXIS_TKEEP_WIDTH=1,C_WACH_TYPE=0,C_WDCH_TYPE=0,C_WRCH_TYPE=0,C_RACH_TYPE=0,C_RDCH_TYPE=0,C_AXIS_TYPE=0,C_IMPLEMENTATION_TYPE_WACH=1,C_IMPLEMENTATION_TYPE_WDCH=1,C_IMPLEMENTATION_TYPE_WRCH=1,C_IMPLEMENTATION_TYPE_RACH=1,C_IMPLEMENTATION_TYPE_RDCH=1,C_IMPLEMENTATION_TYPE_AXIS=1,C_APPLICATION_TYPE_WACH=0,C_APPLICATION_TYPE_WDCH=0,C_APPLICATION_TYPE_WRCH=0,C_APPLICATION_TYPE_RACH=0,C_APPLICATION_TYPE_RDCH=0,C_APPLICATION_TYPE_AXIS=0,C_PRIM_FIFO_TYPE_WACH=512x36,C_PRIM_FIFO_TYPE_WDCH=1kx36,C_PRIM_FIFO_TYPE_WRCH=512x36,C_PRIM_FIFO_TYPE_RACH=512x36,C_PRIM_FIFO_TYPE_RDCH=1kx36,C_PRIM_FIFO_TYPE_AXIS=1kx18,C_USE_ECC_WACH=0,C_USE_ECC_WDCH=0,C_USE_ECC_WRCH=0,C_USE_ECC_RACH=0,C_USE_ECC_RDCH=0,C_USE_ECC_AXIS=0,C_ERROR_INJECTION_TYPE_WACH=0,C_ERROR_INJECTION_TYPE_WDCH=0,C_ERROR_INJECTION_TYPE_WRCH=0,C_ERROR_INJECTION_TYPE_RACH=0,C_ERROR_INJECTION_TYPE_RDCH=0,C_ERROR_INJECTION_TYPE_AXIS=0,C_DIN_WIDTH_WACH=32,C_DIN_WIDTH_WDCH=64,C_DIN_WIDTH_WRCH=2,C_DIN_WIDTH_RACH=32,C_DIN_WIDTH_RDCH=64,C_DIN_WIDTH_AXIS=1,C_WR_DEPTH_WACH=16,C_WR_DEPTH_WDCH=1024,C_WR_DEPTH_WRCH=16,C_WR_DEPTH_RACH=16,C_WR_DEPTH_RDCH=1024,C_WR_DEPTH_AXIS=1024,C_WR_PNTR_WIDTH_WACH=4,C_WR_PNTR_WIDTH_WDCH=10,C_WR_PNTR_WIDTH_WRCH=4,C_WR_PNTR_WIDTH_RACH=4,C_WR_PNTR_WIDTH_RDCH=10,C_WR_PNTR_WIDTH_AXIS=10,C_HAS_DATA_COUNTS_WACH=0,C_HAS_DATA_COUNTS_WDCH=0,C_HAS_DATA_COUNTS_WRCH=0,C_HAS_DATA_COUNTS_RACH=0,C_HAS_DATA_COUNTS_RDCH=0,C_HAS_DATA_COUNTS_AXIS=0,C_HAS_PROG_FLAGS_WACH=0,C_HAS_PROG_FLAGS_WDCH=0,C_HAS_PROG_FLAGS_WRCH=0,C_HAS_PROG_FLAGS_RACH=0,C_HAS_PROG_FLAGS_RDCH=0,C_HAS_PROG_FLAGS_AXIS=0,C_PROG_FULL_TYPE_WACH=0,C_PROG_FULL_TYPE_WDCH=0,C_PROG_FULL_TYPE_WRCH=0,C_PROG_FULL_TYPE_RACH=0,C_PROG_FULL_TYPE_RDCH=0,C_PROG_FULL_TYPE_AXIS=0,C_PROG_FULL_THRESH_ASSERT_VAL_WACH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_WDCH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_WRCH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_RACH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_RDCH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_AXIS=1023,C_PROG_EMPTY_TYPE_WACH=0,C_PROG_EMPTY_TYPE_WDCH=0,C_PROG_EMPTY_TYPE_WRCH=0,C_PROG_EMPTY_TYPE_RACH=0,C_PROG_EMPTY_TYPE_RDCH=0,C_PROG_EMPTY_TYPE_AXIS=0,C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS=1022,C_REG_SLICE_MODE_WACH=0,C_REG_SLICE_MODE_WDCH=0,C_REG_SLICE_MODE_WRCH=0,C_REG_SLICE_MODE_RACH=0,C_REG_SLICE_MODE_RDCH=0,C_REG_SLICE_MODE_AXIS=0}" *) 
(* NotValidForBitStream *)
module adc_cdc_fifo
   (rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en,
    dout,
    full,
    empty,
    prog_empty);
  input rst;
  input wr_clk;
  input rd_clk;
  input [127:0]din;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *) input wr_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *) input rd_en;
  output [127:0]dout;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *) output full;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ EMPTY" *) output empty;
  output prog_empty;

  wire [127:0]din;
  wire [127:0]dout;
  wire empty;
  wire full;
  wire prog_empty;
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
   (* C_COMMON_CLOCK = "0" *) 
   (* C_COUNT_TYPE = "0" *) 
   (* C_DATA_COUNT_WIDTH = "7" *) 
   (* C_DEFAULT_VALUE = "BlankString" *) 
   (* C_DIN_WIDTH = "128" *) 
   (* C_DIN_WIDTH_AXIS = "1" *) 
   (* C_DIN_WIDTH_RACH = "32" *) 
   (* C_DIN_WIDTH_RDCH = "64" *) 
   (* C_DIN_WIDTH_WACH = "32" *) 
   (* C_DIN_WIDTH_WDCH = "64" *) 
   (* C_DIN_WIDTH_WRCH = "2" *) 
   (* C_DOUT_RST_VAL = "0" *) 
   (* C_DOUT_WIDTH = "128" *) 
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
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL = "6" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) 
   (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "15" *) 
   (* C_PROG_EMPTY_TYPE = "2" *) 
   (* C_PROG_EMPTY_TYPE_AXIS = "0" *) 
   (* C_PROG_EMPTY_TYPE_RACH = "0" *) 
   (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
   (* C_PROG_EMPTY_TYPE_WACH = "0" *) 
   (* C_PROG_EMPTY_TYPE_WDCH = "0" *) 
   (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL = "125" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
   (* C_PROG_FULL_THRESH_NEGATE_VAL = "124" *) 
   (* C_PROG_FULL_TYPE = "0" *) 
   (* C_PROG_FULL_TYPE_AXIS = "0" *) 
   (* C_PROG_FULL_TYPE_RACH = "0" *) 
   (* C_PROG_FULL_TYPE_RDCH = "0" *) 
   (* C_PROG_FULL_TYPE_WACH = "0" *) 
   (* C_PROG_FULL_TYPE_WDCH = "0" *) 
   (* C_PROG_FULL_TYPE_WRCH = "0" *) 
   (* C_RACH_TYPE = "0" *) 
   (* C_RDCH_TYPE = "0" *) 
   (* C_RD_DATA_COUNT_WIDTH = "7" *) 
   (* C_RD_DEPTH = "128" *) 
   (* C_RD_FREQ = "1" *) 
   (* C_RD_PNTR_WIDTH = "7" *) 
   (* C_REG_SLICE_MODE_AXIS = "0" *) 
   (* C_REG_SLICE_MODE_RACH = "0" *) 
   (* C_REG_SLICE_MODE_RDCH = "0" *) 
   (* C_REG_SLICE_MODE_WACH = "0" *) 
   (* C_REG_SLICE_MODE_WDCH = "0" *) 
   (* C_REG_SLICE_MODE_WRCH = "0" *) 
   (* C_SYNCHRONIZER_STAGE = "3" *) 
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
   (* C_WR_DATA_COUNT_WIDTH = "7" *) 
   (* C_WR_DEPTH = "128" *) 
   (* C_WR_DEPTH_AXIS = "1024" *) 
   (* C_WR_DEPTH_RACH = "16" *) 
   (* C_WR_DEPTH_RDCH = "1024" *) 
   (* C_WR_DEPTH_WACH = "16" *) 
   (* C_WR_DEPTH_WDCH = "1024" *) 
   (* C_WR_DEPTH_WRCH = "16" *) 
   (* C_WR_FREQ = "1" *) 
   (* C_WR_PNTR_WIDTH = "7" *) 
   (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
   (* C_WR_PNTR_WIDTH_RACH = "4" *) 
   (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
   (* C_WR_PNTR_WIDTH_WACH = "4" *) 
   (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
   (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
   (* C_WR_RESPONSE_LATENCY = "1" *) 
   adc_cdc_fifo_fifo_generator_v12_0__parameterized0 U0
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
        .prog_empty(prog_empty),
        .prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full(NLW_U0_prog_full_UNCONNECTED),
        .prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .rd_clk(rd_clk),
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
        .wr_clk(wr_clk),
        .wr_data_count(NLW_U0_wr_data_count_UNCONNECTED[6:0]),
        .wr_en(wr_en),
        .wr_rst(1'b0),
        .wr_rst_busy(NLW_U0_wr_rst_busy_UNCONNECTED));
endmodule

(* ORIG_REF_NAME = "clk_x_pntrs" *) 
module adc_cdc_fifo_clk_x_pntrs
   (WR_PNTR_RD,
    RD_PNTR_WR,
    S,
    O1,
    O2,
    ram_full_i,
    Q,
    I1,
    I2,
    I3,
    rst_full_gen_i,
    I4,
    wr_clk,
    I5,
    rd_clk,
    I6);
  output [6:0]WR_PNTR_RD;
  output [6:0]RD_PNTR_WR;
  output [3:0]S;
  output [2:0]O1;
  output O2;
  output ram_full_i;
  input [6:0]Q;
  input [6:0]I1;
  input I2;
  input I3;
  input rst_full_gen_i;
  input [6:0]I4;
  input wr_clk;
  input [0:0]I5;
  input rd_clk;
  input [0:0]I6;

  wire [6:0]I1;
  wire I2;
  wire I3;
  wire [6:0]I4;
  wire [0:0]I5;
  wire [0:0]I6;
  wire [2:0]O1;
  wire O2;
  wire [6:0]Q;
  wire [6:0]Q_0;
  wire [6:0]RD_PNTR_WR;
  wire [3:0]S;
  wire [6:0]WR_PNTR_RD;
  wire \n_0_gsync_stage[1].wr_stg_inst ;
  wire \n_0_gsync_stage[2].rd_stg_inst ;
  wire \n_0_gsync_stage[2].wr_stg_inst ;
  wire \n_0_gsync_stage[3].wr_stg_inst ;
  wire n_0_ram_empty_i_i_2;
  wire n_0_ram_empty_i_i_3;
  wire n_0_ram_full_i_i_2;
  wire n_0_ram_full_i_i_3;
  wire \n_0_rd_pntr_gc[0]_i_1 ;
  wire \n_0_rd_pntr_gc[1]_i_1 ;
  wire \n_0_rd_pntr_gc[2]_i_1 ;
  wire \n_0_rd_pntr_gc[3]_i_1 ;
  wire \n_0_rd_pntr_gc[4]_i_1 ;
  wire \n_0_rd_pntr_gc[5]_i_1 ;
  wire \n_1_gsync_stage[1].wr_stg_inst ;
  wire \n_1_gsync_stage[2].rd_stg_inst ;
  wire \n_1_gsync_stage[2].wr_stg_inst ;
  wire \n_1_gsync_stage[3].wr_stg_inst ;
  wire \n_2_gsync_stage[1].wr_stg_inst ;
  wire \n_2_gsync_stage[2].rd_stg_inst ;
  wire \n_2_gsync_stage[2].wr_stg_inst ;
  wire \n_2_gsync_stage[3].wr_stg_inst ;
  wire \n_3_gsync_stage[1].wr_stg_inst ;
  wire \n_3_gsync_stage[2].rd_stg_inst ;
  wire \n_3_gsync_stage[2].wr_stg_inst ;
  wire \n_3_gsync_stage[3].wr_stg_inst ;
  wire \n_4_gsync_stage[1].wr_stg_inst ;
  wire \n_4_gsync_stage[2].rd_stg_inst ;
  wire \n_4_gsync_stage[2].wr_stg_inst ;
  wire \n_4_gsync_stage[3].wr_stg_inst ;
  wire \n_5_gsync_stage[1].wr_stg_inst ;
  wire \n_5_gsync_stage[2].rd_stg_inst ;
  wire \n_5_gsync_stage[2].wr_stg_inst ;
  wire \n_5_gsync_stage[3].wr_stg_inst ;
  wire \n_6_gsync_stage[1].wr_stg_inst ;
  wire \n_6_gsync_stage[2].rd_stg_inst ;
  wire \n_6_gsync_stage[2].wr_stg_inst ;
  wire \n_6_gsync_stage[3].wr_stg_inst ;
  wire [6:0]p_0_in;
  wire [5:0]p_0_in5_out;
  wire ram_full_i;
  wire rd_clk;
  wire [6:0]rd_pntr_gc;
  wire rst_full_gen_i;
  wire wr_clk;
  wire [6:0]wr_pntr_gc;

LUT2 #(
    .INIT(4'h9)) 
     \gdiff.diff_pntr_pad[3]_i_3 
       (.I0(WR_PNTR_RD[2]),
        .I1(Q[2]),
        .O(O1[2]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.diff_pntr_pad[3]_i_4 
       (.I0(WR_PNTR_RD[1]),
        .I1(Q[1]),
        .O(O1[1]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.diff_pntr_pad[3]_i_5 
       (.I0(WR_PNTR_RD[0]),
        .I1(Q[0]),
        .O(O1[0]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.diff_pntr_pad[7]_i_2 
       (.I0(WR_PNTR_RD[6]),
        .I1(Q[6]),
        .O(S[3]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.diff_pntr_pad[7]_i_3 
       (.I0(WR_PNTR_RD[5]),
        .I1(Q[5]),
        .O(S[2]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.diff_pntr_pad[7]_i_4 
       (.I0(WR_PNTR_RD[4]),
        .I1(Q[4]),
        .O(S[1]));
LUT2 #(
    .INIT(4'h9)) 
     \gdiff.diff_pntr_pad[7]_i_5 
       (.I0(WR_PNTR_RD[3]),
        .I1(Q[3]),
        .O(S[0]));
adc_cdc_fifo_synchronizer_ff \gsync_stage[1].rd_stg_inst 
       (.I1(wr_pntr_gc),
        .I6(I6),
        .Q(Q_0),
        .rd_clk(rd_clk));
adc_cdc_fifo_synchronizer_ff_0 \gsync_stage[1].wr_stg_inst 
       (.I1(rd_pntr_gc),
        .I5(I5),
        .Q({\n_0_gsync_stage[1].wr_stg_inst ,\n_1_gsync_stage[1].wr_stg_inst ,\n_2_gsync_stage[1].wr_stg_inst ,\n_3_gsync_stage[1].wr_stg_inst ,\n_4_gsync_stage[1].wr_stg_inst ,\n_5_gsync_stage[1].wr_stg_inst ,\n_6_gsync_stage[1].wr_stg_inst }),
        .wr_clk(wr_clk));
adc_cdc_fifo_synchronizer_ff_1 \gsync_stage[2].rd_stg_inst 
       (.D(Q_0),
        .I6(I6),
        .Q({\n_0_gsync_stage[2].rd_stg_inst ,\n_1_gsync_stage[2].rd_stg_inst ,\n_2_gsync_stage[2].rd_stg_inst ,\n_3_gsync_stage[2].rd_stg_inst ,\n_4_gsync_stage[2].rd_stg_inst ,\n_5_gsync_stage[2].rd_stg_inst ,\n_6_gsync_stage[2].rd_stg_inst }),
        .rd_clk(rd_clk));
adc_cdc_fifo_synchronizer_ff_2 \gsync_stage[2].wr_stg_inst 
       (.D({\n_0_gsync_stage[1].wr_stg_inst ,\n_1_gsync_stage[1].wr_stg_inst ,\n_2_gsync_stage[1].wr_stg_inst ,\n_3_gsync_stage[1].wr_stg_inst ,\n_4_gsync_stage[1].wr_stg_inst ,\n_5_gsync_stage[1].wr_stg_inst ,\n_6_gsync_stage[1].wr_stg_inst }),
        .I5(I5),
        .Q({\n_0_gsync_stage[2].wr_stg_inst ,\n_1_gsync_stage[2].wr_stg_inst ,\n_2_gsync_stage[2].wr_stg_inst ,\n_3_gsync_stage[2].wr_stg_inst ,\n_4_gsync_stage[2].wr_stg_inst ,\n_5_gsync_stage[2].wr_stg_inst ,\n_6_gsync_stage[2].wr_stg_inst }),
        .wr_clk(wr_clk));
adc_cdc_fifo_synchronizer_ff_3 \gsync_stage[3].rd_stg_inst 
       (.D({\n_0_gsync_stage[2].rd_stg_inst ,\n_1_gsync_stage[2].rd_stg_inst ,\n_2_gsync_stage[2].rd_stg_inst ,\n_3_gsync_stage[2].rd_stg_inst ,\n_4_gsync_stage[2].rd_stg_inst ,\n_5_gsync_stage[2].rd_stg_inst ,\n_6_gsync_stage[2].rd_stg_inst }),
        .I6(I6),
        .p_0_in(p_0_in),
        .rd_clk(rd_clk));
adc_cdc_fifo_synchronizer_ff_4 \gsync_stage[3].wr_stg_inst 
       (.D({\n_0_gsync_stage[2].wr_stg_inst ,\n_1_gsync_stage[2].wr_stg_inst ,\n_2_gsync_stage[2].wr_stg_inst ,\n_3_gsync_stage[2].wr_stg_inst ,\n_4_gsync_stage[2].wr_stg_inst ,\n_5_gsync_stage[2].wr_stg_inst ,\n_6_gsync_stage[2].wr_stg_inst }),
        .I5(I5),
        .O1({\n_1_gsync_stage[3].wr_stg_inst ,\n_2_gsync_stage[3].wr_stg_inst ,\n_3_gsync_stage[3].wr_stg_inst ,\n_4_gsync_stage[3].wr_stg_inst ,\n_5_gsync_stage[3].wr_stg_inst ,\n_6_gsync_stage[3].wr_stg_inst }),
        .Q(\n_0_gsync_stage[3].wr_stg_inst ),
        .wr_clk(wr_clk));
LUT5 #(
    .INIT(32'hFFFF9000)) 
     ram_empty_i_i_1
       (.I0(WR_PNTR_RD[3]),
        .I1(Q[3]),
        .I2(n_0_ram_empty_i_i_2),
        .I3(n_0_ram_empty_i_i_3),
        .I4(I2),
        .O(O2));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_empty_i_i_2
       (.I0(WR_PNTR_RD[1]),
        .I1(Q[1]),
        .I2(WR_PNTR_RD[0]),
        .I3(Q[0]),
        .I4(Q[2]),
        .I5(WR_PNTR_RD[2]),
        .O(n_0_ram_empty_i_i_2));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_empty_i_i_3
       (.I0(WR_PNTR_RD[6]),
        .I1(Q[6]),
        .I2(WR_PNTR_RD[4]),
        .I3(Q[4]),
        .I4(Q[5]),
        .I5(WR_PNTR_RD[5]),
        .O(n_0_ram_empty_i_i_3));
LUT6 #(
    .INIT(64'h00000000FFFF0009)) 
     ram_full_i_i_1
       (.I0(RD_PNTR_WR[2]),
        .I1(I1[2]),
        .I2(n_0_ram_full_i_i_2),
        .I3(n_0_ram_full_i_i_3),
        .I4(I3),
        .I5(rst_full_gen_i),
        .O(ram_full_i));
LUT6 #(
    .INIT(64'h6FF6FFFFFFFF6FF6)) 
     ram_full_i_i_2
       (.I0(RD_PNTR_WR[5]),
        .I1(I1[5]),
        .I2(I1[4]),
        .I3(RD_PNTR_WR[4]),
        .I4(I1[6]),
        .I5(RD_PNTR_WR[6]),
        .O(n_0_ram_full_i_i_2));
LUT6 #(
    .INIT(64'h6FF6FFFFFFFF6FF6)) 
     ram_full_i_i_3
       (.I0(RD_PNTR_WR[3]),
        .I1(I1[3]),
        .I2(I1[0]),
        .I3(RD_PNTR_WR[0]),
        .I4(I1[1]),
        .I5(RD_PNTR_WR[1]),
        .O(n_0_ram_full_i_i_3));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(\n_6_gsync_stage[3].wr_stg_inst ),
        .Q(RD_PNTR_WR[0]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(\n_5_gsync_stage[3].wr_stg_inst ),
        .Q(RD_PNTR_WR[1]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(\n_4_gsync_stage[3].wr_stg_inst ),
        .Q(RD_PNTR_WR[2]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(\n_3_gsync_stage[3].wr_stg_inst ),
        .Q(RD_PNTR_WR[3]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(\n_2_gsync_stage[3].wr_stg_inst ),
        .Q(RD_PNTR_WR[4]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(\n_1_gsync_stage[3].wr_stg_inst ),
        .Q(RD_PNTR_WR[5]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(\n_0_gsync_stage[3].wr_stg_inst ),
        .Q(RD_PNTR_WR[6]));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[0]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\n_0_rd_pntr_gc[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[1]_i_1 
       (.I0(Q[1]),
        .I1(Q[2]),
        .O(\n_0_rd_pntr_gc[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[2]_i_1 
       (.I0(Q[2]),
        .I1(Q[3]),
        .O(\n_0_rd_pntr_gc[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[3]_i_1 
       (.I0(Q[3]),
        .I1(Q[4]),
        .O(\n_0_rd_pntr_gc[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[4]_i_1 
       (.I0(Q[4]),
        .I1(Q[5]),
        .O(\n_0_rd_pntr_gc[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[5]_i_1 
       (.I0(Q[5]),
        .I1(Q[6]),
        .O(\n_0_rd_pntr_gc[5]_i_1 ));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[0]_i_1 ),
        .Q(rd_pntr_gc[0]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[1]_i_1 ),
        .Q(rd_pntr_gc[1]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[2]_i_1 ),
        .Q(rd_pntr_gc[2]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[3]_i_1 ),
        .Q(rd_pntr_gc[3]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[4]_i_1 ),
        .Q(rd_pntr_gc[4]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[5]_i_1 ),
        .Q(rd_pntr_gc[5]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(Q[6]),
        .Q(rd_pntr_gc[6]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(p_0_in[0]),
        .Q(WR_PNTR_RD[0]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(p_0_in[1]),
        .Q(WR_PNTR_RD[1]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(p_0_in[2]),
        .Q(WR_PNTR_RD[2]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(p_0_in[3]),
        .Q(WR_PNTR_RD[3]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(p_0_in[4]),
        .Q(WR_PNTR_RD[4]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(p_0_in[5]),
        .Q(WR_PNTR_RD[5]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(p_0_in[6]),
        .Q(WR_PNTR_RD[6]));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[0]_i_1 
       (.I0(I4[0]),
        .I1(I4[1]),
        .O(p_0_in5_out[0]));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[1]_i_1 
       (.I0(I4[1]),
        .I1(I4[2]),
        .O(p_0_in5_out[1]));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[2]_i_1 
       (.I0(I4[2]),
        .I1(I4[3]),
        .O(p_0_in5_out[2]));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[3]_i_1 
       (.I0(I4[3]),
        .I1(I4[4]),
        .O(p_0_in5_out[3]));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[4]_i_1 
       (.I0(I4[4]),
        .I1(I4[5]),
        .O(p_0_in5_out[4]));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[5]_i_1 
       (.I0(I4[5]),
        .I1(I4[6]),
        .O(p_0_in5_out[5]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(p_0_in5_out[0]),
        .Q(wr_pntr_gc[0]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(p_0_in5_out[1]),
        .Q(wr_pntr_gc[1]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(p_0_in5_out[2]),
        .Q(wr_pntr_gc[2]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(p_0_in5_out[3]),
        .Q(wr_pntr_gc[3]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(p_0_in5_out[4]),
        .Q(wr_pntr_gc[4]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(p_0_in5_out[5]),
        .Q(wr_pntr_gc[5]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(I4[6]),
        .Q(wr_pntr_gc[6]));
endmodule

(* ORIG_REF_NAME = "dmem" *) 
module adc_cdc_fifo_dmem
   (dout,
    wr_clk,
    din,
    I1,
    O2,
    Q,
    I2,
    ADDRC,
    E,
    rd_clk,
    I3);
  output [127:0]dout;
  input wr_clk;
  input [127:0]din;
  input I1;
  input [6:0]O2;
  input [5:0]Q;
  input I2;
  input [5:0]ADDRC;
  input [0:0]E;
  input rd_clk;
  input [0:0]I3;

  wire [5:0]ADDRC;
  wire [0:0]E;
  wire I1;
  wire I2;
  wire [0:0]I3;
  wire [6:0]O2;
  wire [5:0]Q;
  wire [127:0]din;
  wire [127:0]dout;
  wire n_0_RAM_reg_0_63_0_2;
  wire n_0_RAM_reg_0_63_102_104;
  wire n_0_RAM_reg_0_63_105_107;
  wire n_0_RAM_reg_0_63_108_110;
  wire n_0_RAM_reg_0_63_111_113;
  wire n_0_RAM_reg_0_63_114_116;
  wire n_0_RAM_reg_0_63_117_119;
  wire n_0_RAM_reg_0_63_120_122;
  wire n_0_RAM_reg_0_63_123_125;
  wire n_0_RAM_reg_0_63_126_126;
  wire n_0_RAM_reg_0_63_127_127;
  wire n_0_RAM_reg_0_63_12_14;
  wire n_0_RAM_reg_0_63_15_17;
  wire n_0_RAM_reg_0_63_18_20;
  wire n_0_RAM_reg_0_63_21_23;
  wire n_0_RAM_reg_0_63_24_26;
  wire n_0_RAM_reg_0_63_27_29;
  wire n_0_RAM_reg_0_63_30_32;
  wire n_0_RAM_reg_0_63_33_35;
  wire n_0_RAM_reg_0_63_36_38;
  wire n_0_RAM_reg_0_63_39_41;
  wire n_0_RAM_reg_0_63_3_5;
  wire n_0_RAM_reg_0_63_42_44;
  wire n_0_RAM_reg_0_63_45_47;
  wire n_0_RAM_reg_0_63_48_50;
  wire n_0_RAM_reg_0_63_51_53;
  wire n_0_RAM_reg_0_63_54_56;
  wire n_0_RAM_reg_0_63_57_59;
  wire n_0_RAM_reg_0_63_60_62;
  wire n_0_RAM_reg_0_63_63_65;
  wire n_0_RAM_reg_0_63_66_68;
  wire n_0_RAM_reg_0_63_69_71;
  wire n_0_RAM_reg_0_63_6_8;
  wire n_0_RAM_reg_0_63_72_74;
  wire n_0_RAM_reg_0_63_75_77;
  wire n_0_RAM_reg_0_63_78_80;
  wire n_0_RAM_reg_0_63_81_83;
  wire n_0_RAM_reg_0_63_84_86;
  wire n_0_RAM_reg_0_63_87_89;
  wire n_0_RAM_reg_0_63_90_92;
  wire n_0_RAM_reg_0_63_93_95;
  wire n_0_RAM_reg_0_63_96_98;
  wire n_0_RAM_reg_0_63_99_101;
  wire n_0_RAM_reg_0_63_9_11;
  wire n_0_RAM_reg_64_127_0_2;
  wire n_0_RAM_reg_64_127_102_104;
  wire n_0_RAM_reg_64_127_105_107;
  wire n_0_RAM_reg_64_127_108_110;
  wire n_0_RAM_reg_64_127_111_113;
  wire n_0_RAM_reg_64_127_114_116;
  wire n_0_RAM_reg_64_127_117_119;
  wire n_0_RAM_reg_64_127_120_122;
  wire n_0_RAM_reg_64_127_123_125;
  wire n_0_RAM_reg_64_127_126_126;
  wire n_0_RAM_reg_64_127_127_127;
  wire n_0_RAM_reg_64_127_12_14;
  wire n_0_RAM_reg_64_127_15_17;
  wire n_0_RAM_reg_64_127_18_20;
  wire n_0_RAM_reg_64_127_21_23;
  wire n_0_RAM_reg_64_127_24_26;
  wire n_0_RAM_reg_64_127_27_29;
  wire n_0_RAM_reg_64_127_30_32;
  wire n_0_RAM_reg_64_127_33_35;
  wire n_0_RAM_reg_64_127_36_38;
  wire n_0_RAM_reg_64_127_39_41;
  wire n_0_RAM_reg_64_127_3_5;
  wire n_0_RAM_reg_64_127_42_44;
  wire n_0_RAM_reg_64_127_45_47;
  wire n_0_RAM_reg_64_127_48_50;
  wire n_0_RAM_reg_64_127_51_53;
  wire n_0_RAM_reg_64_127_54_56;
  wire n_0_RAM_reg_64_127_57_59;
  wire n_0_RAM_reg_64_127_60_62;
  wire n_0_RAM_reg_64_127_63_65;
  wire n_0_RAM_reg_64_127_66_68;
  wire n_0_RAM_reg_64_127_69_71;
  wire n_0_RAM_reg_64_127_6_8;
  wire n_0_RAM_reg_64_127_72_74;
  wire n_0_RAM_reg_64_127_75_77;
  wire n_0_RAM_reg_64_127_78_80;
  wire n_0_RAM_reg_64_127_81_83;
  wire n_0_RAM_reg_64_127_84_86;
  wire n_0_RAM_reg_64_127_87_89;
  wire n_0_RAM_reg_64_127_90_92;
  wire n_0_RAM_reg_64_127_93_95;
  wire n_0_RAM_reg_64_127_96_98;
  wire n_0_RAM_reg_64_127_99_101;
  wire n_0_RAM_reg_64_127_9_11;
  wire n_1_RAM_reg_0_63_0_2;
  wire n_1_RAM_reg_0_63_102_104;
  wire n_1_RAM_reg_0_63_105_107;
  wire n_1_RAM_reg_0_63_108_110;
  wire n_1_RAM_reg_0_63_111_113;
  wire n_1_RAM_reg_0_63_114_116;
  wire n_1_RAM_reg_0_63_117_119;
  wire n_1_RAM_reg_0_63_120_122;
  wire n_1_RAM_reg_0_63_123_125;
  wire n_1_RAM_reg_0_63_12_14;
  wire n_1_RAM_reg_0_63_15_17;
  wire n_1_RAM_reg_0_63_18_20;
  wire n_1_RAM_reg_0_63_21_23;
  wire n_1_RAM_reg_0_63_24_26;
  wire n_1_RAM_reg_0_63_27_29;
  wire n_1_RAM_reg_0_63_30_32;
  wire n_1_RAM_reg_0_63_33_35;
  wire n_1_RAM_reg_0_63_36_38;
  wire n_1_RAM_reg_0_63_39_41;
  wire n_1_RAM_reg_0_63_3_5;
  wire n_1_RAM_reg_0_63_42_44;
  wire n_1_RAM_reg_0_63_45_47;
  wire n_1_RAM_reg_0_63_48_50;
  wire n_1_RAM_reg_0_63_51_53;
  wire n_1_RAM_reg_0_63_54_56;
  wire n_1_RAM_reg_0_63_57_59;
  wire n_1_RAM_reg_0_63_60_62;
  wire n_1_RAM_reg_0_63_63_65;
  wire n_1_RAM_reg_0_63_66_68;
  wire n_1_RAM_reg_0_63_69_71;
  wire n_1_RAM_reg_0_63_6_8;
  wire n_1_RAM_reg_0_63_72_74;
  wire n_1_RAM_reg_0_63_75_77;
  wire n_1_RAM_reg_0_63_78_80;
  wire n_1_RAM_reg_0_63_81_83;
  wire n_1_RAM_reg_0_63_84_86;
  wire n_1_RAM_reg_0_63_87_89;
  wire n_1_RAM_reg_0_63_90_92;
  wire n_1_RAM_reg_0_63_93_95;
  wire n_1_RAM_reg_0_63_96_98;
  wire n_1_RAM_reg_0_63_99_101;
  wire n_1_RAM_reg_0_63_9_11;
  wire n_1_RAM_reg_64_127_0_2;
  wire n_1_RAM_reg_64_127_102_104;
  wire n_1_RAM_reg_64_127_105_107;
  wire n_1_RAM_reg_64_127_108_110;
  wire n_1_RAM_reg_64_127_111_113;
  wire n_1_RAM_reg_64_127_114_116;
  wire n_1_RAM_reg_64_127_117_119;
  wire n_1_RAM_reg_64_127_120_122;
  wire n_1_RAM_reg_64_127_123_125;
  wire n_1_RAM_reg_64_127_12_14;
  wire n_1_RAM_reg_64_127_15_17;
  wire n_1_RAM_reg_64_127_18_20;
  wire n_1_RAM_reg_64_127_21_23;
  wire n_1_RAM_reg_64_127_24_26;
  wire n_1_RAM_reg_64_127_27_29;
  wire n_1_RAM_reg_64_127_30_32;
  wire n_1_RAM_reg_64_127_33_35;
  wire n_1_RAM_reg_64_127_36_38;
  wire n_1_RAM_reg_64_127_39_41;
  wire n_1_RAM_reg_64_127_3_5;
  wire n_1_RAM_reg_64_127_42_44;
  wire n_1_RAM_reg_64_127_45_47;
  wire n_1_RAM_reg_64_127_48_50;
  wire n_1_RAM_reg_64_127_51_53;
  wire n_1_RAM_reg_64_127_54_56;
  wire n_1_RAM_reg_64_127_57_59;
  wire n_1_RAM_reg_64_127_60_62;
  wire n_1_RAM_reg_64_127_63_65;
  wire n_1_RAM_reg_64_127_66_68;
  wire n_1_RAM_reg_64_127_69_71;
  wire n_1_RAM_reg_64_127_6_8;
  wire n_1_RAM_reg_64_127_72_74;
  wire n_1_RAM_reg_64_127_75_77;
  wire n_1_RAM_reg_64_127_78_80;
  wire n_1_RAM_reg_64_127_81_83;
  wire n_1_RAM_reg_64_127_84_86;
  wire n_1_RAM_reg_64_127_87_89;
  wire n_1_RAM_reg_64_127_90_92;
  wire n_1_RAM_reg_64_127_93_95;
  wire n_1_RAM_reg_64_127_96_98;
  wire n_1_RAM_reg_64_127_99_101;
  wire n_1_RAM_reg_64_127_9_11;
  wire n_2_RAM_reg_0_63_0_2;
  wire n_2_RAM_reg_0_63_102_104;
  wire n_2_RAM_reg_0_63_105_107;
  wire n_2_RAM_reg_0_63_108_110;
  wire n_2_RAM_reg_0_63_111_113;
  wire n_2_RAM_reg_0_63_114_116;
  wire n_2_RAM_reg_0_63_117_119;
  wire n_2_RAM_reg_0_63_120_122;
  wire n_2_RAM_reg_0_63_123_125;
  wire n_2_RAM_reg_0_63_12_14;
  wire n_2_RAM_reg_0_63_15_17;
  wire n_2_RAM_reg_0_63_18_20;
  wire n_2_RAM_reg_0_63_21_23;
  wire n_2_RAM_reg_0_63_24_26;
  wire n_2_RAM_reg_0_63_27_29;
  wire n_2_RAM_reg_0_63_30_32;
  wire n_2_RAM_reg_0_63_33_35;
  wire n_2_RAM_reg_0_63_36_38;
  wire n_2_RAM_reg_0_63_39_41;
  wire n_2_RAM_reg_0_63_3_5;
  wire n_2_RAM_reg_0_63_42_44;
  wire n_2_RAM_reg_0_63_45_47;
  wire n_2_RAM_reg_0_63_48_50;
  wire n_2_RAM_reg_0_63_51_53;
  wire n_2_RAM_reg_0_63_54_56;
  wire n_2_RAM_reg_0_63_57_59;
  wire n_2_RAM_reg_0_63_60_62;
  wire n_2_RAM_reg_0_63_63_65;
  wire n_2_RAM_reg_0_63_66_68;
  wire n_2_RAM_reg_0_63_69_71;
  wire n_2_RAM_reg_0_63_6_8;
  wire n_2_RAM_reg_0_63_72_74;
  wire n_2_RAM_reg_0_63_75_77;
  wire n_2_RAM_reg_0_63_78_80;
  wire n_2_RAM_reg_0_63_81_83;
  wire n_2_RAM_reg_0_63_84_86;
  wire n_2_RAM_reg_0_63_87_89;
  wire n_2_RAM_reg_0_63_90_92;
  wire n_2_RAM_reg_0_63_93_95;
  wire n_2_RAM_reg_0_63_96_98;
  wire n_2_RAM_reg_0_63_99_101;
  wire n_2_RAM_reg_0_63_9_11;
  wire n_2_RAM_reg_64_127_0_2;
  wire n_2_RAM_reg_64_127_102_104;
  wire n_2_RAM_reg_64_127_105_107;
  wire n_2_RAM_reg_64_127_108_110;
  wire n_2_RAM_reg_64_127_111_113;
  wire n_2_RAM_reg_64_127_114_116;
  wire n_2_RAM_reg_64_127_117_119;
  wire n_2_RAM_reg_64_127_120_122;
  wire n_2_RAM_reg_64_127_123_125;
  wire n_2_RAM_reg_64_127_12_14;
  wire n_2_RAM_reg_64_127_15_17;
  wire n_2_RAM_reg_64_127_18_20;
  wire n_2_RAM_reg_64_127_21_23;
  wire n_2_RAM_reg_64_127_24_26;
  wire n_2_RAM_reg_64_127_27_29;
  wire n_2_RAM_reg_64_127_30_32;
  wire n_2_RAM_reg_64_127_33_35;
  wire n_2_RAM_reg_64_127_36_38;
  wire n_2_RAM_reg_64_127_39_41;
  wire n_2_RAM_reg_64_127_3_5;
  wire n_2_RAM_reg_64_127_42_44;
  wire n_2_RAM_reg_64_127_45_47;
  wire n_2_RAM_reg_64_127_48_50;
  wire n_2_RAM_reg_64_127_51_53;
  wire n_2_RAM_reg_64_127_54_56;
  wire n_2_RAM_reg_64_127_57_59;
  wire n_2_RAM_reg_64_127_60_62;
  wire n_2_RAM_reg_64_127_63_65;
  wire n_2_RAM_reg_64_127_66_68;
  wire n_2_RAM_reg_64_127_69_71;
  wire n_2_RAM_reg_64_127_6_8;
  wire n_2_RAM_reg_64_127_72_74;
  wire n_2_RAM_reg_64_127_75_77;
  wire n_2_RAM_reg_64_127_78_80;
  wire n_2_RAM_reg_64_127_81_83;
  wire n_2_RAM_reg_64_127_84_86;
  wire n_2_RAM_reg_64_127_87_89;
  wire n_2_RAM_reg_64_127_90_92;
  wire n_2_RAM_reg_64_127_93_95;
  wire n_2_RAM_reg_64_127_96_98;
  wire n_2_RAM_reg_64_127_99_101;
  wire n_2_RAM_reg_64_127_9_11;
  wire [127:0]p_0_out;
  wire rd_clk;
  wire wr_clk;
  wire NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_102_104_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_105_107_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_108_110_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_111_113_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_114_116_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_117_119_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_120_122_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_123_125_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_126_126_SPO_UNCONNECTED;
  wire NLW_RAM_reg_0_63_127_127_SPO_UNCONNECTED;
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
  wire NLW_RAM_reg_0_63_63_65_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_66_68_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_69_71_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_72_74_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_75_77_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_78_80_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_81_83_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_84_86_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_87_89_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_90_92_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_93_95_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_96_98_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_99_101_DOD_UNCONNECTED;
  wire NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_0_2_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_102_104_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_105_107_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_108_110_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_111_113_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_114_116_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_117_119_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_120_122_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_123_125_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_126_126_SPO_UNCONNECTED;
  wire NLW_RAM_reg_64_127_127_127_SPO_UNCONNECTED;
  wire NLW_RAM_reg_64_127_12_14_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_15_17_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_18_20_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_21_23_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_24_26_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_27_29_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_30_32_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_33_35_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_36_38_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_39_41_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_3_5_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_42_44_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_45_47_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_48_50_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_51_53_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_54_56_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_57_59_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_60_62_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_63_65_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_66_68_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_69_71_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_6_8_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_72_74_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_75_77_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_78_80_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_81_83_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_84_86_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_87_89_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_90_92_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_93_95_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_96_98_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_99_101_DOD_UNCONNECTED;
  wire NLW_RAM_reg_64_127_9_11_DOD_UNCONNECTED;

RAM64M RAM_reg_0_63_0_2
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[0]),
        .DIB(din[1]),
        .DIC(din[2]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_0_2),
        .DOB(n_1_RAM_reg_0_63_0_2),
        .DOC(n_2_RAM_reg_0_63_0_2),
        .DOD(NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_102_104
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[102]),
        .DIB(din[103]),
        .DIC(din[104]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_102_104),
        .DOB(n_1_RAM_reg_0_63_102_104),
        .DOC(n_2_RAM_reg_0_63_102_104),
        .DOD(NLW_RAM_reg_0_63_102_104_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_105_107
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[105]),
        .DIB(din[106]),
        .DIC(din[107]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_105_107),
        .DOB(n_1_RAM_reg_0_63_105_107),
        .DOC(n_2_RAM_reg_0_63_105_107),
        .DOD(NLW_RAM_reg_0_63_105_107_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_108_110
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[108]),
        .DIB(din[109]),
        .DIC(din[110]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_108_110),
        .DOB(n_1_RAM_reg_0_63_108_110),
        .DOC(n_2_RAM_reg_0_63_108_110),
        .DOD(NLW_RAM_reg_0_63_108_110_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_111_113
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[111]),
        .DIB(din[112]),
        .DIC(din[113]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_111_113),
        .DOB(n_1_RAM_reg_0_63_111_113),
        .DOC(n_2_RAM_reg_0_63_111_113),
        .DOD(NLW_RAM_reg_0_63_111_113_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_114_116
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[114]),
        .DIB(din[115]),
        .DIC(din[116]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_114_116),
        .DOB(n_1_RAM_reg_0_63_114_116),
        .DOC(n_2_RAM_reg_0_63_114_116),
        .DOD(NLW_RAM_reg_0_63_114_116_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_117_119
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[117]),
        .DIB(din[118]),
        .DIC(din[119]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_117_119),
        .DOB(n_1_RAM_reg_0_63_117_119),
        .DOC(n_2_RAM_reg_0_63_117_119),
        .DOD(NLW_RAM_reg_0_63_117_119_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_120_122
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[120]),
        .DIB(din[121]),
        .DIC(din[122]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_120_122),
        .DOB(n_1_RAM_reg_0_63_120_122),
        .DOC(n_2_RAM_reg_0_63_120_122),
        .DOD(NLW_RAM_reg_0_63_120_122_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_123_125
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[123]),
        .DIB(din[124]),
        .DIC(din[125]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_123_125),
        .DOB(n_1_RAM_reg_0_63_123_125),
        .DOC(n_2_RAM_reg_0_63_123_125),
        .DOD(NLW_RAM_reg_0_63_123_125_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64X1D RAM_reg_0_63_126_126
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .A4(Q[4]),
        .A5(Q[5]),
        .D(din[126]),
        .DPO(n_0_RAM_reg_0_63_126_126),
        .DPRA0(O2[0]),
        .DPRA1(O2[1]),
        .DPRA2(O2[2]),
        .DPRA3(O2[3]),
        .DPRA4(O2[4]),
        .DPRA5(O2[5]),
        .SPO(NLW_RAM_reg_0_63_126_126_SPO_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64X1D RAM_reg_0_63_127_127
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .A4(Q[4]),
        .A5(Q[5]),
        .D(din[127]),
        .DPO(n_0_RAM_reg_0_63_127_127),
        .DPRA0(O2[0]),
        .DPRA1(O2[1]),
        .DPRA2(O2[2]),
        .DPRA3(O2[3]),
        .DPRA4(O2[4]),
        .DPRA5(O2[5]),
        .SPO(NLW_RAM_reg_0_63_127_127_SPO_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_12_14
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[12]),
        .DIB(din[13]),
        .DIC(din[14]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_12_14),
        .DOB(n_1_RAM_reg_0_63_12_14),
        .DOC(n_2_RAM_reg_0_63_12_14),
        .DOD(NLW_RAM_reg_0_63_12_14_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_15_17
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[15]),
        .DIB(din[16]),
        .DIC(din[17]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_15_17),
        .DOB(n_1_RAM_reg_0_63_15_17),
        .DOC(n_2_RAM_reg_0_63_15_17),
        .DOD(NLW_RAM_reg_0_63_15_17_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_18_20
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[18]),
        .DIB(din[19]),
        .DIC(din[20]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_18_20),
        .DOB(n_1_RAM_reg_0_63_18_20),
        .DOC(n_2_RAM_reg_0_63_18_20),
        .DOD(NLW_RAM_reg_0_63_18_20_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_21_23
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[21]),
        .DIB(din[22]),
        .DIC(din[23]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_21_23),
        .DOB(n_1_RAM_reg_0_63_21_23),
        .DOC(n_2_RAM_reg_0_63_21_23),
        .DOD(NLW_RAM_reg_0_63_21_23_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_24_26
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[24]),
        .DIB(din[25]),
        .DIC(din[26]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_24_26),
        .DOB(n_1_RAM_reg_0_63_24_26),
        .DOC(n_2_RAM_reg_0_63_24_26),
        .DOD(NLW_RAM_reg_0_63_24_26_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_27_29
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[27]),
        .DIB(din[28]),
        .DIC(din[29]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_27_29),
        .DOB(n_1_RAM_reg_0_63_27_29),
        .DOC(n_2_RAM_reg_0_63_27_29),
        .DOD(NLW_RAM_reg_0_63_27_29_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_30_32
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[30]),
        .DIB(din[31]),
        .DIC(din[32]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_30_32),
        .DOB(n_1_RAM_reg_0_63_30_32),
        .DOC(n_2_RAM_reg_0_63_30_32),
        .DOD(NLW_RAM_reg_0_63_30_32_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_33_35
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[33]),
        .DIB(din[34]),
        .DIC(din[35]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_33_35),
        .DOB(n_1_RAM_reg_0_63_33_35),
        .DOC(n_2_RAM_reg_0_63_33_35),
        .DOD(NLW_RAM_reg_0_63_33_35_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_36_38
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[36]),
        .DIB(din[37]),
        .DIC(din[38]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_36_38),
        .DOB(n_1_RAM_reg_0_63_36_38),
        .DOC(n_2_RAM_reg_0_63_36_38),
        .DOD(NLW_RAM_reg_0_63_36_38_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_39_41
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[39]),
        .DIB(din[40]),
        .DIC(din[41]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_39_41),
        .DOB(n_1_RAM_reg_0_63_39_41),
        .DOC(n_2_RAM_reg_0_63_39_41),
        .DOD(NLW_RAM_reg_0_63_39_41_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_3_5
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[3]),
        .DIB(din[4]),
        .DIC(din[5]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_3_5),
        .DOB(n_1_RAM_reg_0_63_3_5),
        .DOC(n_2_RAM_reg_0_63_3_5),
        .DOD(NLW_RAM_reg_0_63_3_5_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_42_44
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[42]),
        .DIB(din[43]),
        .DIC(din[44]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_42_44),
        .DOB(n_1_RAM_reg_0_63_42_44),
        .DOC(n_2_RAM_reg_0_63_42_44),
        .DOD(NLW_RAM_reg_0_63_42_44_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_45_47
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[45]),
        .DIB(din[46]),
        .DIC(din[47]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_45_47),
        .DOB(n_1_RAM_reg_0_63_45_47),
        .DOC(n_2_RAM_reg_0_63_45_47),
        .DOD(NLW_RAM_reg_0_63_45_47_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_48_50
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[48]),
        .DIB(din[49]),
        .DIC(din[50]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_48_50),
        .DOB(n_1_RAM_reg_0_63_48_50),
        .DOC(n_2_RAM_reg_0_63_48_50),
        .DOD(NLW_RAM_reg_0_63_48_50_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_51_53
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[51]),
        .DIB(din[52]),
        .DIC(din[53]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_51_53),
        .DOB(n_1_RAM_reg_0_63_51_53),
        .DOC(n_2_RAM_reg_0_63_51_53),
        .DOD(NLW_RAM_reg_0_63_51_53_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_54_56
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[54]),
        .DIB(din[55]),
        .DIC(din[56]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_54_56),
        .DOB(n_1_RAM_reg_0_63_54_56),
        .DOC(n_2_RAM_reg_0_63_54_56),
        .DOD(NLW_RAM_reg_0_63_54_56_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_57_59
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[57]),
        .DIB(din[58]),
        .DIC(din[59]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_57_59),
        .DOB(n_1_RAM_reg_0_63_57_59),
        .DOC(n_2_RAM_reg_0_63_57_59),
        .DOD(NLW_RAM_reg_0_63_57_59_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_60_62
       (.ADDRA({ADDRC[5:1],O2[0]}),
        .ADDRB({ADDRC[5:1],O2[0]}),
        .ADDRC({ADDRC[5:1],O2[0]}),
        .ADDRD(Q),
        .DIA(din[60]),
        .DIB(din[61]),
        .DIC(din[62]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_60_62),
        .DOB(n_1_RAM_reg_0_63_60_62),
        .DOC(n_2_RAM_reg_0_63_60_62),
        .DOD(NLW_RAM_reg_0_63_60_62_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_63_65
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[63]),
        .DIB(din[64]),
        .DIC(din[65]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_63_65),
        .DOB(n_1_RAM_reg_0_63_63_65),
        .DOC(n_2_RAM_reg_0_63_63_65),
        .DOD(NLW_RAM_reg_0_63_63_65_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_66_68
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[66]),
        .DIB(din[67]),
        .DIC(din[68]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_66_68),
        .DOB(n_1_RAM_reg_0_63_66_68),
        .DOC(n_2_RAM_reg_0_63_66_68),
        .DOD(NLW_RAM_reg_0_63_66_68_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_69_71
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[69]),
        .DIB(din[70]),
        .DIC(din[71]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_69_71),
        .DOB(n_1_RAM_reg_0_63_69_71),
        .DOC(n_2_RAM_reg_0_63_69_71),
        .DOD(NLW_RAM_reg_0_63_69_71_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_6_8
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[6]),
        .DIB(din[7]),
        .DIC(din[8]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_6_8),
        .DOB(n_1_RAM_reg_0_63_6_8),
        .DOC(n_2_RAM_reg_0_63_6_8),
        .DOD(NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_72_74
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[72]),
        .DIB(din[73]),
        .DIC(din[74]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_72_74),
        .DOB(n_1_RAM_reg_0_63_72_74),
        .DOC(n_2_RAM_reg_0_63_72_74),
        .DOD(NLW_RAM_reg_0_63_72_74_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_75_77
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[75]),
        .DIB(din[76]),
        .DIC(din[77]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_75_77),
        .DOB(n_1_RAM_reg_0_63_75_77),
        .DOC(n_2_RAM_reg_0_63_75_77),
        .DOD(NLW_RAM_reg_0_63_75_77_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_78_80
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[78]),
        .DIB(din[79]),
        .DIC(din[80]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_78_80),
        .DOB(n_1_RAM_reg_0_63_78_80),
        .DOC(n_2_RAM_reg_0_63_78_80),
        .DOD(NLW_RAM_reg_0_63_78_80_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_81_83
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[81]),
        .DIB(din[82]),
        .DIC(din[83]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_81_83),
        .DOB(n_1_RAM_reg_0_63_81_83),
        .DOC(n_2_RAM_reg_0_63_81_83),
        .DOD(NLW_RAM_reg_0_63_81_83_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_84_86
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[84]),
        .DIB(din[85]),
        .DIC(din[86]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_84_86),
        .DOB(n_1_RAM_reg_0_63_84_86),
        .DOC(n_2_RAM_reg_0_63_84_86),
        .DOD(NLW_RAM_reg_0_63_84_86_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_87_89
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[87]),
        .DIB(din[88]),
        .DIC(din[89]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_87_89),
        .DOB(n_1_RAM_reg_0_63_87_89),
        .DOC(n_2_RAM_reg_0_63_87_89),
        .DOD(NLW_RAM_reg_0_63_87_89_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_90_92
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[90]),
        .DIB(din[91]),
        .DIC(din[92]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_90_92),
        .DOB(n_1_RAM_reg_0_63_90_92),
        .DOC(n_2_RAM_reg_0_63_90_92),
        .DOD(NLW_RAM_reg_0_63_90_92_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_93_95
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[93]),
        .DIB(din[94]),
        .DIC(din[95]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_93_95),
        .DOB(n_1_RAM_reg_0_63_93_95),
        .DOC(n_2_RAM_reg_0_63_93_95),
        .DOD(NLW_RAM_reg_0_63_93_95_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_96_98
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[96]),
        .DIB(din[97]),
        .DIC(din[98]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_96_98),
        .DOB(n_1_RAM_reg_0_63_96_98),
        .DOC(n_2_RAM_reg_0_63_96_98),
        .DOD(NLW_RAM_reg_0_63_96_98_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_99_101
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[99]),
        .DIB(din[100]),
        .DIC(din[101]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_99_101),
        .DOB(n_1_RAM_reg_0_63_99_101),
        .DOC(n_2_RAM_reg_0_63_99_101),
        .DOD(NLW_RAM_reg_0_63_99_101_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_0_63_9_11
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[9]),
        .DIB(din[10]),
        .DIC(din[11]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_0_63_9_11),
        .DOB(n_1_RAM_reg_0_63_9_11),
        .DOC(n_2_RAM_reg_0_63_9_11),
        .DOD(NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I1));
RAM64M RAM_reg_64_127_0_2
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[0]),
        .DIB(din[1]),
        .DIC(din[2]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_0_2),
        .DOB(n_1_RAM_reg_64_127_0_2),
        .DOC(n_2_RAM_reg_64_127_0_2),
        .DOD(NLW_RAM_reg_64_127_0_2_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_102_104
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[102]),
        .DIB(din[103]),
        .DIC(din[104]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_102_104),
        .DOB(n_1_RAM_reg_64_127_102_104),
        .DOC(n_2_RAM_reg_64_127_102_104),
        .DOD(NLW_RAM_reg_64_127_102_104_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_105_107
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[105]),
        .DIB(din[106]),
        .DIC(din[107]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_105_107),
        .DOB(n_1_RAM_reg_64_127_105_107),
        .DOC(n_2_RAM_reg_64_127_105_107),
        .DOD(NLW_RAM_reg_64_127_105_107_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_108_110
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[108]),
        .DIB(din[109]),
        .DIC(din[110]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_108_110),
        .DOB(n_1_RAM_reg_64_127_108_110),
        .DOC(n_2_RAM_reg_64_127_108_110),
        .DOD(NLW_RAM_reg_64_127_108_110_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_111_113
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[111]),
        .DIB(din[112]),
        .DIC(din[113]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_111_113),
        .DOB(n_1_RAM_reg_64_127_111_113),
        .DOC(n_2_RAM_reg_64_127_111_113),
        .DOD(NLW_RAM_reg_64_127_111_113_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_114_116
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[114]),
        .DIB(din[115]),
        .DIC(din[116]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_114_116),
        .DOB(n_1_RAM_reg_64_127_114_116),
        .DOC(n_2_RAM_reg_64_127_114_116),
        .DOD(NLW_RAM_reg_64_127_114_116_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_117_119
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[117]),
        .DIB(din[118]),
        .DIC(din[119]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_117_119),
        .DOB(n_1_RAM_reg_64_127_117_119),
        .DOC(n_2_RAM_reg_64_127_117_119),
        .DOD(NLW_RAM_reg_64_127_117_119_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_120_122
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[120]),
        .DIB(din[121]),
        .DIC(din[122]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_120_122),
        .DOB(n_1_RAM_reg_64_127_120_122),
        .DOC(n_2_RAM_reg_64_127_120_122),
        .DOD(NLW_RAM_reg_64_127_120_122_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_123_125
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[123]),
        .DIB(din[124]),
        .DIC(din[125]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_123_125),
        .DOB(n_1_RAM_reg_64_127_123_125),
        .DOC(n_2_RAM_reg_64_127_123_125),
        .DOD(NLW_RAM_reg_64_127_123_125_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64X1D RAM_reg_64_127_126_126
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .A4(Q[4]),
        .A5(Q[5]),
        .D(din[126]),
        .DPO(n_0_RAM_reg_64_127_126_126),
        .DPRA0(O2[0]),
        .DPRA1(O2[1]),
        .DPRA2(O2[2]),
        .DPRA3(O2[3]),
        .DPRA4(O2[4]),
        .DPRA5(O2[5]),
        .SPO(NLW_RAM_reg_64_127_126_126_SPO_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64X1D RAM_reg_64_127_127_127
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .A4(Q[4]),
        .A5(Q[5]),
        .D(din[127]),
        .DPO(n_0_RAM_reg_64_127_127_127),
        .DPRA0(O2[0]),
        .DPRA1(O2[1]),
        .DPRA2(O2[2]),
        .DPRA3(O2[3]),
        .DPRA4(O2[4]),
        .DPRA5(O2[5]),
        .SPO(NLW_RAM_reg_64_127_127_127_SPO_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_12_14
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[12]),
        .DIB(din[13]),
        .DIC(din[14]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_12_14),
        .DOB(n_1_RAM_reg_64_127_12_14),
        .DOC(n_2_RAM_reg_64_127_12_14),
        .DOD(NLW_RAM_reg_64_127_12_14_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_15_17
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[15]),
        .DIB(din[16]),
        .DIC(din[17]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_15_17),
        .DOB(n_1_RAM_reg_64_127_15_17),
        .DOC(n_2_RAM_reg_64_127_15_17),
        .DOD(NLW_RAM_reg_64_127_15_17_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_18_20
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[18]),
        .DIB(din[19]),
        .DIC(din[20]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_18_20),
        .DOB(n_1_RAM_reg_64_127_18_20),
        .DOC(n_2_RAM_reg_64_127_18_20),
        .DOD(NLW_RAM_reg_64_127_18_20_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_21_23
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[21]),
        .DIB(din[22]),
        .DIC(din[23]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_21_23),
        .DOB(n_1_RAM_reg_64_127_21_23),
        .DOC(n_2_RAM_reg_64_127_21_23),
        .DOD(NLW_RAM_reg_64_127_21_23_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_24_26
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[24]),
        .DIB(din[25]),
        .DIC(din[26]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_24_26),
        .DOB(n_1_RAM_reg_64_127_24_26),
        .DOC(n_2_RAM_reg_64_127_24_26),
        .DOD(NLW_RAM_reg_64_127_24_26_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_27_29
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[27]),
        .DIB(din[28]),
        .DIC(din[29]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_27_29),
        .DOB(n_1_RAM_reg_64_127_27_29),
        .DOC(n_2_RAM_reg_64_127_27_29),
        .DOD(NLW_RAM_reg_64_127_27_29_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_30_32
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[30]),
        .DIB(din[31]),
        .DIC(din[32]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_30_32),
        .DOB(n_1_RAM_reg_64_127_30_32),
        .DOC(n_2_RAM_reg_64_127_30_32),
        .DOD(NLW_RAM_reg_64_127_30_32_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_33_35
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[33]),
        .DIB(din[34]),
        .DIC(din[35]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_33_35),
        .DOB(n_1_RAM_reg_64_127_33_35),
        .DOC(n_2_RAM_reg_64_127_33_35),
        .DOD(NLW_RAM_reg_64_127_33_35_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_36_38
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[36]),
        .DIB(din[37]),
        .DIC(din[38]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_36_38),
        .DOB(n_1_RAM_reg_64_127_36_38),
        .DOC(n_2_RAM_reg_64_127_36_38),
        .DOD(NLW_RAM_reg_64_127_36_38_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_39_41
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[39]),
        .DIB(din[40]),
        .DIC(din[41]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_39_41),
        .DOB(n_1_RAM_reg_64_127_39_41),
        .DOC(n_2_RAM_reg_64_127_39_41),
        .DOD(NLW_RAM_reg_64_127_39_41_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_3_5
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[3]),
        .DIB(din[4]),
        .DIC(din[5]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_3_5),
        .DOB(n_1_RAM_reg_64_127_3_5),
        .DOC(n_2_RAM_reg_64_127_3_5),
        .DOD(NLW_RAM_reg_64_127_3_5_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_42_44
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[42]),
        .DIB(din[43]),
        .DIC(din[44]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_42_44),
        .DOB(n_1_RAM_reg_64_127_42_44),
        .DOC(n_2_RAM_reg_64_127_42_44),
        .DOD(NLW_RAM_reg_64_127_42_44_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_45_47
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[45]),
        .DIB(din[46]),
        .DIC(din[47]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_45_47),
        .DOB(n_1_RAM_reg_64_127_45_47),
        .DOC(n_2_RAM_reg_64_127_45_47),
        .DOD(NLW_RAM_reg_64_127_45_47_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_48_50
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[48]),
        .DIB(din[49]),
        .DIC(din[50]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_48_50),
        .DOB(n_1_RAM_reg_64_127_48_50),
        .DOC(n_2_RAM_reg_64_127_48_50),
        .DOD(NLW_RAM_reg_64_127_48_50_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_51_53
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[51]),
        .DIB(din[52]),
        .DIC(din[53]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_51_53),
        .DOB(n_1_RAM_reg_64_127_51_53),
        .DOC(n_2_RAM_reg_64_127_51_53),
        .DOD(NLW_RAM_reg_64_127_51_53_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_54_56
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[54]),
        .DIB(din[55]),
        .DIC(din[56]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_54_56),
        .DOB(n_1_RAM_reg_64_127_54_56),
        .DOC(n_2_RAM_reg_64_127_54_56),
        .DOD(NLW_RAM_reg_64_127_54_56_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_57_59
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[57]),
        .DIB(din[58]),
        .DIC(din[59]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_57_59),
        .DOB(n_1_RAM_reg_64_127_57_59),
        .DOC(n_2_RAM_reg_64_127_57_59),
        .DOD(NLW_RAM_reg_64_127_57_59_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_60_62
       (.ADDRA({ADDRC[5:1],O2[0]}),
        .ADDRB({ADDRC[5:1],O2[0]}),
        .ADDRC({ADDRC[5:1],O2[0]}),
        .ADDRD(Q),
        .DIA(din[60]),
        .DIB(din[61]),
        .DIC(din[62]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_60_62),
        .DOB(n_1_RAM_reg_64_127_60_62),
        .DOC(n_2_RAM_reg_64_127_60_62),
        .DOD(NLW_RAM_reg_64_127_60_62_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_63_65
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[63]),
        .DIB(din[64]),
        .DIC(din[65]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_63_65),
        .DOB(n_1_RAM_reg_64_127_63_65),
        .DOC(n_2_RAM_reg_64_127_63_65),
        .DOD(NLW_RAM_reg_64_127_63_65_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_66_68
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[66]),
        .DIB(din[67]),
        .DIC(din[68]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_66_68),
        .DOB(n_1_RAM_reg_64_127_66_68),
        .DOC(n_2_RAM_reg_64_127_66_68),
        .DOD(NLW_RAM_reg_64_127_66_68_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_69_71
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[69]),
        .DIB(din[70]),
        .DIC(din[71]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_69_71),
        .DOB(n_1_RAM_reg_64_127_69_71),
        .DOC(n_2_RAM_reg_64_127_69_71),
        .DOD(NLW_RAM_reg_64_127_69_71_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_6_8
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[6]),
        .DIB(din[7]),
        .DIC(din[8]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_6_8),
        .DOB(n_1_RAM_reg_64_127_6_8),
        .DOC(n_2_RAM_reg_64_127_6_8),
        .DOD(NLW_RAM_reg_64_127_6_8_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_72_74
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[72]),
        .DIB(din[73]),
        .DIC(din[74]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_72_74),
        .DOB(n_1_RAM_reg_64_127_72_74),
        .DOC(n_2_RAM_reg_64_127_72_74),
        .DOD(NLW_RAM_reg_64_127_72_74_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_75_77
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[75]),
        .DIB(din[76]),
        .DIC(din[77]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_75_77),
        .DOB(n_1_RAM_reg_64_127_75_77),
        .DOC(n_2_RAM_reg_64_127_75_77),
        .DOD(NLW_RAM_reg_64_127_75_77_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_78_80
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[78]),
        .DIB(din[79]),
        .DIC(din[80]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_78_80),
        .DOB(n_1_RAM_reg_64_127_78_80),
        .DOC(n_2_RAM_reg_64_127_78_80),
        .DOD(NLW_RAM_reg_64_127_78_80_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_81_83
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[81]),
        .DIB(din[82]),
        .DIC(din[83]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_81_83),
        .DOB(n_1_RAM_reg_64_127_81_83),
        .DOC(n_2_RAM_reg_64_127_81_83),
        .DOD(NLW_RAM_reg_64_127_81_83_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_84_86
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[84]),
        .DIB(din[85]),
        .DIC(din[86]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_84_86),
        .DOB(n_1_RAM_reg_64_127_84_86),
        .DOC(n_2_RAM_reg_64_127_84_86),
        .DOD(NLW_RAM_reg_64_127_84_86_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_87_89
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[87]),
        .DIB(din[88]),
        .DIC(din[89]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_87_89),
        .DOB(n_1_RAM_reg_64_127_87_89),
        .DOC(n_2_RAM_reg_64_127_87_89),
        .DOD(NLW_RAM_reg_64_127_87_89_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_90_92
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[90]),
        .DIB(din[91]),
        .DIC(din[92]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_90_92),
        .DOB(n_1_RAM_reg_64_127_90_92),
        .DOC(n_2_RAM_reg_64_127_90_92),
        .DOD(NLW_RAM_reg_64_127_90_92_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_93_95
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[93]),
        .DIB(din[94]),
        .DIC(din[95]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_93_95),
        .DOB(n_1_RAM_reg_64_127_93_95),
        .DOC(n_2_RAM_reg_64_127_93_95),
        .DOD(NLW_RAM_reg_64_127_93_95_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_96_98
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[96]),
        .DIB(din[97]),
        .DIC(din[98]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_96_98),
        .DOB(n_1_RAM_reg_64_127_96_98),
        .DOC(n_2_RAM_reg_64_127_96_98),
        .DOD(NLW_RAM_reg_64_127_96_98_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_99_101
       (.ADDRA(ADDRC),
        .ADDRB(ADDRC),
        .ADDRC(ADDRC),
        .ADDRD(Q),
        .DIA(din[99]),
        .DIB(din[100]),
        .DIC(din[101]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_99_101),
        .DOB(n_1_RAM_reg_64_127_99_101),
        .DOC(n_2_RAM_reg_64_127_99_101),
        .DOD(NLW_RAM_reg_64_127_99_101_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
RAM64M RAM_reg_64_127_9_11
       (.ADDRA(O2[5:0]),
        .ADDRB(O2[5:0]),
        .ADDRC(O2[5:0]),
        .ADDRD(Q),
        .DIA(din[9]),
        .DIB(din[10]),
        .DIC(din[11]),
        .DID(1'b0),
        .DOA(n_0_RAM_reg_64_127_9_11),
        .DOB(n_1_RAM_reg_64_127_9_11),
        .DOC(n_2_RAM_reg_64_127_9_11),
        .DOD(NLW_RAM_reg_64_127_9_11_DOD_UNCONNECTED),
        .WCLK(wr_clk),
        .WE(I2));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[0]_i_1 
       (.I0(n_0_RAM_reg_64_127_0_2),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_0_2),
        .O(p_0_out[0]));
(* SOFT_HLUTNM = "soft_lutpair65" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[100]_i_1 
       (.I0(n_1_RAM_reg_64_127_99_101),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_99_101),
        .O(p_0_out[100]));
(* SOFT_HLUTNM = "soft_lutpair65" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[101]_i_1 
       (.I0(n_2_RAM_reg_64_127_99_101),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_99_101),
        .O(p_0_out[101]));
(* SOFT_HLUTNM = "soft_lutpair66" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[102]_i_1 
       (.I0(n_0_RAM_reg_64_127_102_104),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_102_104),
        .O(p_0_out[102]));
(* SOFT_HLUTNM = "soft_lutpair66" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[103]_i_1 
       (.I0(n_1_RAM_reg_64_127_102_104),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_102_104),
        .O(p_0_out[103]));
(* SOFT_HLUTNM = "soft_lutpair67" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[104]_i_1 
       (.I0(n_2_RAM_reg_64_127_102_104),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_102_104),
        .O(p_0_out[104]));
(* SOFT_HLUTNM = "soft_lutpair67" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[105]_i_1 
       (.I0(n_0_RAM_reg_64_127_105_107),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_105_107),
        .O(p_0_out[105]));
(* SOFT_HLUTNM = "soft_lutpair68" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[106]_i_1 
       (.I0(n_1_RAM_reg_64_127_105_107),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_105_107),
        .O(p_0_out[106]));
(* SOFT_HLUTNM = "soft_lutpair68" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[107]_i_1 
       (.I0(n_2_RAM_reg_64_127_105_107),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_105_107),
        .O(p_0_out[107]));
(* SOFT_HLUTNM = "soft_lutpair69" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[108]_i_1 
       (.I0(n_0_RAM_reg_64_127_108_110),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_108_110),
        .O(p_0_out[108]));
(* SOFT_HLUTNM = "soft_lutpair69" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[109]_i_1 
       (.I0(n_1_RAM_reg_64_127_108_110),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_108_110),
        .O(p_0_out[109]));
(* SOFT_HLUTNM = "soft_lutpair20" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[10]_i_1 
       (.I0(n_1_RAM_reg_64_127_9_11),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_9_11),
        .O(p_0_out[10]));
(* SOFT_HLUTNM = "soft_lutpair70" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[110]_i_1 
       (.I0(n_2_RAM_reg_64_127_108_110),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_108_110),
        .O(p_0_out[110]));
(* SOFT_HLUTNM = "soft_lutpair70" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[111]_i_1 
       (.I0(n_0_RAM_reg_64_127_111_113),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_111_113),
        .O(p_0_out[111]));
(* SOFT_HLUTNM = "soft_lutpair71" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[112]_i_1 
       (.I0(n_1_RAM_reg_64_127_111_113),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_111_113),
        .O(p_0_out[112]));
(* SOFT_HLUTNM = "soft_lutpair71" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[113]_i_1 
       (.I0(n_2_RAM_reg_64_127_111_113),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_111_113),
        .O(p_0_out[113]));
(* SOFT_HLUTNM = "soft_lutpair72" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[114]_i_1 
       (.I0(n_0_RAM_reg_64_127_114_116),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_114_116),
        .O(p_0_out[114]));
(* SOFT_HLUTNM = "soft_lutpair72" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[115]_i_1 
       (.I0(n_1_RAM_reg_64_127_114_116),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_114_116),
        .O(p_0_out[115]));
(* SOFT_HLUTNM = "soft_lutpair73" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[116]_i_1 
       (.I0(n_2_RAM_reg_64_127_114_116),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_114_116),
        .O(p_0_out[116]));
(* SOFT_HLUTNM = "soft_lutpair73" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[117]_i_1 
       (.I0(n_0_RAM_reg_64_127_117_119),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_117_119),
        .O(p_0_out[117]));
(* SOFT_HLUTNM = "soft_lutpair74" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[118]_i_1 
       (.I0(n_1_RAM_reg_64_127_117_119),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_117_119),
        .O(p_0_out[118]));
(* SOFT_HLUTNM = "soft_lutpair74" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[119]_i_1 
       (.I0(n_2_RAM_reg_64_127_117_119),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_117_119),
        .O(p_0_out[119]));
(* SOFT_HLUTNM = "soft_lutpair20" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[11]_i_1 
       (.I0(n_2_RAM_reg_64_127_9_11),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_9_11),
        .O(p_0_out[11]));
(* SOFT_HLUTNM = "soft_lutpair75" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[120]_i_1 
       (.I0(n_0_RAM_reg_64_127_120_122),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_120_122),
        .O(p_0_out[120]));
(* SOFT_HLUTNM = "soft_lutpair75" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[121]_i_1 
       (.I0(n_1_RAM_reg_64_127_120_122),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_120_122),
        .O(p_0_out[121]));
(* SOFT_HLUTNM = "soft_lutpair76" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[122]_i_1 
       (.I0(n_2_RAM_reg_64_127_120_122),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_120_122),
        .O(p_0_out[122]));
(* SOFT_HLUTNM = "soft_lutpair76" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[123]_i_1 
       (.I0(n_0_RAM_reg_64_127_123_125),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_123_125),
        .O(p_0_out[123]));
(* SOFT_HLUTNM = "soft_lutpair77" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[124]_i_1 
       (.I0(n_1_RAM_reg_64_127_123_125),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_123_125),
        .O(p_0_out[124]));
(* SOFT_HLUTNM = "soft_lutpair77" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[125]_i_1 
       (.I0(n_2_RAM_reg_64_127_123_125),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_123_125),
        .O(p_0_out[125]));
(* SOFT_HLUTNM = "soft_lutpair78" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[126]_i_1 
       (.I0(n_0_RAM_reg_64_127_126_126),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_126_126),
        .O(p_0_out[126]));
(* SOFT_HLUTNM = "soft_lutpair78" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[127]_i_2 
       (.I0(n_0_RAM_reg_64_127_127_127),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_127_127),
        .O(p_0_out[127]));
(* SOFT_HLUTNM = "soft_lutpair21" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[12]_i_1 
       (.I0(n_0_RAM_reg_64_127_12_14),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_12_14),
        .O(p_0_out[12]));
(* SOFT_HLUTNM = "soft_lutpair21" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[13]_i_1 
       (.I0(n_1_RAM_reg_64_127_12_14),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_12_14),
        .O(p_0_out[13]));
(* SOFT_HLUTNM = "soft_lutpair22" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[14]_i_1 
       (.I0(n_2_RAM_reg_64_127_12_14),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_12_14),
        .O(p_0_out[14]));
(* SOFT_HLUTNM = "soft_lutpair22" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[15]_i_1 
       (.I0(n_0_RAM_reg_64_127_15_17),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_15_17),
        .O(p_0_out[15]));
(* SOFT_HLUTNM = "soft_lutpair23" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[16]_i_1 
       (.I0(n_1_RAM_reg_64_127_15_17),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_15_17),
        .O(p_0_out[16]));
(* SOFT_HLUTNM = "soft_lutpair23" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[17]_i_1 
       (.I0(n_2_RAM_reg_64_127_15_17),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_15_17),
        .O(p_0_out[17]));
(* SOFT_HLUTNM = "soft_lutpair24" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[18]_i_1 
       (.I0(n_0_RAM_reg_64_127_18_20),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_18_20),
        .O(p_0_out[18]));
(* SOFT_HLUTNM = "soft_lutpair24" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[19]_i_1 
       (.I0(n_1_RAM_reg_64_127_18_20),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_18_20),
        .O(p_0_out[19]));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[1]_i_1 
       (.I0(n_1_RAM_reg_64_127_0_2),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_0_2),
        .O(p_0_out[1]));
(* SOFT_HLUTNM = "soft_lutpair25" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[20]_i_1 
       (.I0(n_2_RAM_reg_64_127_18_20),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_18_20),
        .O(p_0_out[20]));
(* SOFT_HLUTNM = "soft_lutpair25" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[21]_i_1 
       (.I0(n_0_RAM_reg_64_127_21_23),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_21_23),
        .O(p_0_out[21]));
(* SOFT_HLUTNM = "soft_lutpair26" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[22]_i_1 
       (.I0(n_1_RAM_reg_64_127_21_23),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_21_23),
        .O(p_0_out[22]));
(* SOFT_HLUTNM = "soft_lutpair26" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[23]_i_1 
       (.I0(n_2_RAM_reg_64_127_21_23),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_21_23),
        .O(p_0_out[23]));
(* SOFT_HLUTNM = "soft_lutpair27" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[24]_i_1 
       (.I0(n_0_RAM_reg_64_127_24_26),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_24_26),
        .O(p_0_out[24]));
(* SOFT_HLUTNM = "soft_lutpair27" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[25]_i_1 
       (.I0(n_1_RAM_reg_64_127_24_26),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_24_26),
        .O(p_0_out[25]));
(* SOFT_HLUTNM = "soft_lutpair28" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[26]_i_1 
       (.I0(n_2_RAM_reg_64_127_24_26),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_24_26),
        .O(p_0_out[26]));
(* SOFT_HLUTNM = "soft_lutpair28" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[27]_i_1 
       (.I0(n_0_RAM_reg_64_127_27_29),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_27_29),
        .O(p_0_out[27]));
(* SOFT_HLUTNM = "soft_lutpair29" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[28]_i_1 
       (.I0(n_1_RAM_reg_64_127_27_29),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_27_29),
        .O(p_0_out[28]));
(* SOFT_HLUTNM = "soft_lutpair29" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[29]_i_1 
       (.I0(n_2_RAM_reg_64_127_27_29),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_27_29),
        .O(p_0_out[29]));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[2]_i_1 
       (.I0(n_2_RAM_reg_64_127_0_2),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_0_2),
        .O(p_0_out[2]));
(* SOFT_HLUTNM = "soft_lutpair30" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[30]_i_1 
       (.I0(n_0_RAM_reg_64_127_30_32),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_30_32),
        .O(p_0_out[30]));
(* SOFT_HLUTNM = "soft_lutpair30" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[31]_i_1 
       (.I0(n_1_RAM_reg_64_127_30_32),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_30_32),
        .O(p_0_out[31]));
(* SOFT_HLUTNM = "soft_lutpair31" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[32]_i_1 
       (.I0(n_2_RAM_reg_64_127_30_32),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_30_32),
        .O(p_0_out[32]));
(* SOFT_HLUTNM = "soft_lutpair31" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[33]_i_1 
       (.I0(n_0_RAM_reg_64_127_33_35),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_33_35),
        .O(p_0_out[33]));
(* SOFT_HLUTNM = "soft_lutpair32" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[34]_i_1 
       (.I0(n_1_RAM_reg_64_127_33_35),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_33_35),
        .O(p_0_out[34]));
(* SOFT_HLUTNM = "soft_lutpair32" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[35]_i_1 
       (.I0(n_2_RAM_reg_64_127_33_35),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_33_35),
        .O(p_0_out[35]));
(* SOFT_HLUTNM = "soft_lutpair33" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[36]_i_1 
       (.I0(n_0_RAM_reg_64_127_36_38),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_36_38),
        .O(p_0_out[36]));
(* SOFT_HLUTNM = "soft_lutpair33" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[37]_i_1 
       (.I0(n_1_RAM_reg_64_127_36_38),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_36_38),
        .O(p_0_out[37]));
(* SOFT_HLUTNM = "soft_lutpair34" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[38]_i_1 
       (.I0(n_2_RAM_reg_64_127_36_38),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_36_38),
        .O(p_0_out[38]));
(* SOFT_HLUTNM = "soft_lutpair34" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[39]_i_1 
       (.I0(n_0_RAM_reg_64_127_39_41),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_39_41),
        .O(p_0_out[39]));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[3]_i_1 
       (.I0(n_0_RAM_reg_64_127_3_5),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_3_5),
        .O(p_0_out[3]));
(* SOFT_HLUTNM = "soft_lutpair35" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[40]_i_1 
       (.I0(n_1_RAM_reg_64_127_39_41),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_39_41),
        .O(p_0_out[40]));
(* SOFT_HLUTNM = "soft_lutpair35" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[41]_i_1 
       (.I0(n_2_RAM_reg_64_127_39_41),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_39_41),
        .O(p_0_out[41]));
(* SOFT_HLUTNM = "soft_lutpair36" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[42]_i_1 
       (.I0(n_0_RAM_reg_64_127_42_44),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_42_44),
        .O(p_0_out[42]));
(* SOFT_HLUTNM = "soft_lutpair36" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[43]_i_1 
       (.I0(n_1_RAM_reg_64_127_42_44),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_42_44),
        .O(p_0_out[43]));
(* SOFT_HLUTNM = "soft_lutpair37" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[44]_i_1 
       (.I0(n_2_RAM_reg_64_127_42_44),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_42_44),
        .O(p_0_out[44]));
(* SOFT_HLUTNM = "soft_lutpair37" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[45]_i_1 
       (.I0(n_0_RAM_reg_64_127_45_47),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_45_47),
        .O(p_0_out[45]));
(* SOFT_HLUTNM = "soft_lutpair38" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[46]_i_1 
       (.I0(n_1_RAM_reg_64_127_45_47),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_45_47),
        .O(p_0_out[46]));
(* SOFT_HLUTNM = "soft_lutpair38" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[47]_i_1 
       (.I0(n_2_RAM_reg_64_127_45_47),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_45_47),
        .O(p_0_out[47]));
(* SOFT_HLUTNM = "soft_lutpair39" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[48]_i_1 
       (.I0(n_0_RAM_reg_64_127_48_50),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_48_50),
        .O(p_0_out[48]));
(* SOFT_HLUTNM = "soft_lutpair39" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[49]_i_1 
       (.I0(n_1_RAM_reg_64_127_48_50),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_48_50),
        .O(p_0_out[49]));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[4]_i_1 
       (.I0(n_1_RAM_reg_64_127_3_5),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_3_5),
        .O(p_0_out[4]));
(* SOFT_HLUTNM = "soft_lutpair40" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[50]_i_1 
       (.I0(n_2_RAM_reg_64_127_48_50),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_48_50),
        .O(p_0_out[50]));
(* SOFT_HLUTNM = "soft_lutpair40" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[51]_i_1 
       (.I0(n_0_RAM_reg_64_127_51_53),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_51_53),
        .O(p_0_out[51]));
(* SOFT_HLUTNM = "soft_lutpair41" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[52]_i_1 
       (.I0(n_1_RAM_reg_64_127_51_53),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_51_53),
        .O(p_0_out[52]));
(* SOFT_HLUTNM = "soft_lutpair41" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[53]_i_1 
       (.I0(n_2_RAM_reg_64_127_51_53),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_51_53),
        .O(p_0_out[53]));
(* SOFT_HLUTNM = "soft_lutpair42" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[54]_i_1 
       (.I0(n_0_RAM_reg_64_127_54_56),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_54_56),
        .O(p_0_out[54]));
(* SOFT_HLUTNM = "soft_lutpair42" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[55]_i_1 
       (.I0(n_1_RAM_reg_64_127_54_56),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_54_56),
        .O(p_0_out[55]));
(* SOFT_HLUTNM = "soft_lutpair43" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[56]_i_1 
       (.I0(n_2_RAM_reg_64_127_54_56),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_54_56),
        .O(p_0_out[56]));
(* SOFT_HLUTNM = "soft_lutpair43" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[57]_i_1 
       (.I0(n_0_RAM_reg_64_127_57_59),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_57_59),
        .O(p_0_out[57]));
(* SOFT_HLUTNM = "soft_lutpair44" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[58]_i_1 
       (.I0(n_1_RAM_reg_64_127_57_59),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_57_59),
        .O(p_0_out[58]));
(* SOFT_HLUTNM = "soft_lutpair44" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[59]_i_1 
       (.I0(n_2_RAM_reg_64_127_57_59),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_57_59),
        .O(p_0_out[59]));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[5]_i_1 
       (.I0(n_2_RAM_reg_64_127_3_5),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_3_5),
        .O(p_0_out[5]));
(* SOFT_HLUTNM = "soft_lutpair45" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[60]_i_1 
       (.I0(n_0_RAM_reg_64_127_60_62),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_60_62),
        .O(p_0_out[60]));
(* SOFT_HLUTNM = "soft_lutpair45" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[61]_i_1 
       (.I0(n_1_RAM_reg_64_127_60_62),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_60_62),
        .O(p_0_out[61]));
(* SOFT_HLUTNM = "soft_lutpair46" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[62]_i_1 
       (.I0(n_2_RAM_reg_64_127_60_62),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_60_62),
        .O(p_0_out[62]));
(* SOFT_HLUTNM = "soft_lutpair46" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[63]_i_1 
       (.I0(n_0_RAM_reg_64_127_63_65),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_63_65),
        .O(p_0_out[63]));
(* SOFT_HLUTNM = "soft_lutpair47" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[64]_i_1 
       (.I0(n_1_RAM_reg_64_127_63_65),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_63_65),
        .O(p_0_out[64]));
(* SOFT_HLUTNM = "soft_lutpair47" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[65]_i_1 
       (.I0(n_2_RAM_reg_64_127_63_65),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_63_65),
        .O(p_0_out[65]));
(* SOFT_HLUTNM = "soft_lutpair48" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[66]_i_1 
       (.I0(n_0_RAM_reg_64_127_66_68),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_66_68),
        .O(p_0_out[66]));
(* SOFT_HLUTNM = "soft_lutpair48" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[67]_i_1 
       (.I0(n_1_RAM_reg_64_127_66_68),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_66_68),
        .O(p_0_out[67]));
(* SOFT_HLUTNM = "soft_lutpair49" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[68]_i_1 
       (.I0(n_2_RAM_reg_64_127_66_68),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_66_68),
        .O(p_0_out[68]));
(* SOFT_HLUTNM = "soft_lutpair49" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[69]_i_1 
       (.I0(n_0_RAM_reg_64_127_69_71),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_69_71),
        .O(p_0_out[69]));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[6]_i_1 
       (.I0(n_0_RAM_reg_64_127_6_8),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_6_8),
        .O(p_0_out[6]));
(* SOFT_HLUTNM = "soft_lutpair50" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[70]_i_1 
       (.I0(n_1_RAM_reg_64_127_69_71),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_69_71),
        .O(p_0_out[70]));
(* SOFT_HLUTNM = "soft_lutpair50" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[71]_i_1 
       (.I0(n_2_RAM_reg_64_127_69_71),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_69_71),
        .O(p_0_out[71]));
(* SOFT_HLUTNM = "soft_lutpair51" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[72]_i_1 
       (.I0(n_0_RAM_reg_64_127_72_74),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_72_74),
        .O(p_0_out[72]));
(* SOFT_HLUTNM = "soft_lutpair51" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[73]_i_1 
       (.I0(n_1_RAM_reg_64_127_72_74),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_72_74),
        .O(p_0_out[73]));
(* SOFT_HLUTNM = "soft_lutpair52" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[74]_i_1 
       (.I0(n_2_RAM_reg_64_127_72_74),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_72_74),
        .O(p_0_out[74]));
(* SOFT_HLUTNM = "soft_lutpair52" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[75]_i_1 
       (.I0(n_0_RAM_reg_64_127_75_77),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_75_77),
        .O(p_0_out[75]));
(* SOFT_HLUTNM = "soft_lutpair53" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[76]_i_1 
       (.I0(n_1_RAM_reg_64_127_75_77),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_75_77),
        .O(p_0_out[76]));
(* SOFT_HLUTNM = "soft_lutpair53" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[77]_i_1 
       (.I0(n_2_RAM_reg_64_127_75_77),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_75_77),
        .O(p_0_out[77]));
(* SOFT_HLUTNM = "soft_lutpair54" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[78]_i_1 
       (.I0(n_0_RAM_reg_64_127_78_80),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_78_80),
        .O(p_0_out[78]));
(* SOFT_HLUTNM = "soft_lutpair54" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[79]_i_1 
       (.I0(n_1_RAM_reg_64_127_78_80),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_78_80),
        .O(p_0_out[79]));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[7]_i_1 
       (.I0(n_1_RAM_reg_64_127_6_8),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_6_8),
        .O(p_0_out[7]));
(* SOFT_HLUTNM = "soft_lutpair55" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[80]_i_1 
       (.I0(n_2_RAM_reg_64_127_78_80),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_78_80),
        .O(p_0_out[80]));
(* SOFT_HLUTNM = "soft_lutpair55" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[81]_i_1 
       (.I0(n_0_RAM_reg_64_127_81_83),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_81_83),
        .O(p_0_out[81]));
(* SOFT_HLUTNM = "soft_lutpair56" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[82]_i_1 
       (.I0(n_1_RAM_reg_64_127_81_83),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_81_83),
        .O(p_0_out[82]));
(* SOFT_HLUTNM = "soft_lutpair56" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[83]_i_1 
       (.I0(n_2_RAM_reg_64_127_81_83),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_81_83),
        .O(p_0_out[83]));
(* SOFT_HLUTNM = "soft_lutpair57" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[84]_i_1 
       (.I0(n_0_RAM_reg_64_127_84_86),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_84_86),
        .O(p_0_out[84]));
(* SOFT_HLUTNM = "soft_lutpair57" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[85]_i_1 
       (.I0(n_1_RAM_reg_64_127_84_86),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_84_86),
        .O(p_0_out[85]));
(* SOFT_HLUTNM = "soft_lutpair58" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[86]_i_1 
       (.I0(n_2_RAM_reg_64_127_84_86),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_84_86),
        .O(p_0_out[86]));
(* SOFT_HLUTNM = "soft_lutpair58" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[87]_i_1 
       (.I0(n_0_RAM_reg_64_127_87_89),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_87_89),
        .O(p_0_out[87]));
(* SOFT_HLUTNM = "soft_lutpair59" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[88]_i_1 
       (.I0(n_1_RAM_reg_64_127_87_89),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_87_89),
        .O(p_0_out[88]));
(* SOFT_HLUTNM = "soft_lutpair59" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[89]_i_1 
       (.I0(n_2_RAM_reg_64_127_87_89),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_87_89),
        .O(p_0_out[89]));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[8]_i_1 
       (.I0(n_2_RAM_reg_64_127_6_8),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_6_8),
        .O(p_0_out[8]));
(* SOFT_HLUTNM = "soft_lutpair60" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[90]_i_1 
       (.I0(n_0_RAM_reg_64_127_90_92),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_90_92),
        .O(p_0_out[90]));
(* SOFT_HLUTNM = "soft_lutpair60" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[91]_i_1 
       (.I0(n_1_RAM_reg_64_127_90_92),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_90_92),
        .O(p_0_out[91]));
(* SOFT_HLUTNM = "soft_lutpair61" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[92]_i_1 
       (.I0(n_2_RAM_reg_64_127_90_92),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_90_92),
        .O(p_0_out[92]));
(* SOFT_HLUTNM = "soft_lutpair61" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[93]_i_1 
       (.I0(n_0_RAM_reg_64_127_93_95),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_93_95),
        .O(p_0_out[93]));
(* SOFT_HLUTNM = "soft_lutpair62" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[94]_i_1 
       (.I0(n_1_RAM_reg_64_127_93_95),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_93_95),
        .O(p_0_out[94]));
(* SOFT_HLUTNM = "soft_lutpair62" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[95]_i_1 
       (.I0(n_2_RAM_reg_64_127_93_95),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_93_95),
        .O(p_0_out[95]));
(* SOFT_HLUTNM = "soft_lutpair63" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[96]_i_1 
       (.I0(n_0_RAM_reg_64_127_96_98),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_96_98),
        .O(p_0_out[96]));
(* SOFT_HLUTNM = "soft_lutpair63" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[97]_i_1 
       (.I0(n_1_RAM_reg_64_127_96_98),
        .I1(O2[6]),
        .I2(n_1_RAM_reg_0_63_96_98),
        .O(p_0_out[97]));
(* SOFT_HLUTNM = "soft_lutpair64" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[98]_i_1 
       (.I0(n_2_RAM_reg_64_127_96_98),
        .I1(O2[6]),
        .I2(n_2_RAM_reg_0_63_96_98),
        .O(p_0_out[98]));
(* SOFT_HLUTNM = "soft_lutpair64" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[99]_i_1 
       (.I0(n_0_RAM_reg_64_127_99_101),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_99_101),
        .O(p_0_out[99]));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \gpr1.dout_i[9]_i_1 
       (.I0(n_0_RAM_reg_64_127_9_11),
        .I1(O2[6]),
        .I2(n_0_RAM_reg_0_63_9_11),
        .O(p_0_out[9]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[0]),
        .Q(dout[0]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[100] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[100]),
        .Q(dout[100]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[101] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[101]),
        .Q(dout[101]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[102] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[102]),
        .Q(dout[102]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[103] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[103]),
        .Q(dout[103]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[104] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[104]),
        .Q(dout[104]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[105] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[105]),
        .Q(dout[105]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[106] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[106]),
        .Q(dout[106]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[107] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[107]),
        .Q(dout[107]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[108] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[108]),
        .Q(dout[108]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[109] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[109]),
        .Q(dout[109]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[10] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[10]),
        .Q(dout[10]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[110] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[110]),
        .Q(dout[110]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[111] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[111]),
        .Q(dout[111]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[112] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[112]),
        .Q(dout[112]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[113] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[113]),
        .Q(dout[113]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[114] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[114]),
        .Q(dout[114]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[115] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[115]),
        .Q(dout[115]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[116] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[116]),
        .Q(dout[116]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[117] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[117]),
        .Q(dout[117]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[118] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[118]),
        .Q(dout[118]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[119] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[119]),
        .Q(dout[119]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[11] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[11]),
        .Q(dout[11]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[120] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[120]),
        .Q(dout[120]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[121] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[121]),
        .Q(dout[121]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[122] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[122]),
        .Q(dout[122]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[123] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[123]),
        .Q(dout[123]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[124] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[124]),
        .Q(dout[124]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[125] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[125]),
        .Q(dout[125]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[126] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[126]),
        .Q(dout[126]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[127] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[127]),
        .Q(dout[127]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[12] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[12]),
        .Q(dout[12]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[13] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[13]),
        .Q(dout[13]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[14] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[14]),
        .Q(dout[14]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[15] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[15]),
        .Q(dout[15]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[16] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[16]),
        .Q(dout[16]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[17] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[17]),
        .Q(dout[17]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[18] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[18]),
        .Q(dout[18]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[19] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[19]),
        .Q(dout[19]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[1]),
        .Q(dout[1]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[20] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[20]),
        .Q(dout[20]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[21] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[21]),
        .Q(dout[21]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[22] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[22]),
        .Q(dout[22]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[23] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[23]),
        .Q(dout[23]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[24] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[24]),
        .Q(dout[24]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[25] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[25]),
        .Q(dout[25]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[26] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[26]),
        .Q(dout[26]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[27] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[27]),
        .Q(dout[27]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[28] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[28]),
        .Q(dout[28]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[29] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[29]),
        .Q(dout[29]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[2]),
        .Q(dout[2]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[30] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[30]),
        .Q(dout[30]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[31] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[31]),
        .Q(dout[31]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[32] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[32]),
        .Q(dout[32]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[33] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[33]),
        .Q(dout[33]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[34] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[34]),
        .Q(dout[34]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[35] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[35]),
        .Q(dout[35]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[36] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[36]),
        .Q(dout[36]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[37] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[37]),
        .Q(dout[37]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[38] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[38]),
        .Q(dout[38]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[39] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[39]),
        .Q(dout[39]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[3]),
        .Q(dout[3]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[40] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[40]),
        .Q(dout[40]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[41] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[41]),
        .Q(dout[41]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[42] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[42]),
        .Q(dout[42]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[43] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[43]),
        .Q(dout[43]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[44] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[44]),
        .Q(dout[44]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[45] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[45]),
        .Q(dout[45]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[46] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[46]),
        .Q(dout[46]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[47] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[47]),
        .Q(dout[47]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[48] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[48]),
        .Q(dout[48]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[49] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[49]),
        .Q(dout[49]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[4]),
        .Q(dout[4]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[50] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[50]),
        .Q(dout[50]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[51] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[51]),
        .Q(dout[51]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[52] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[52]),
        .Q(dout[52]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[53] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[53]),
        .Q(dout[53]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[54] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[54]),
        .Q(dout[54]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[55] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[55]),
        .Q(dout[55]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[56] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[56]),
        .Q(dout[56]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[57] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[57]),
        .Q(dout[57]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[58] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[58]),
        .Q(dout[58]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[59] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[59]),
        .Q(dout[59]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[5] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[5]),
        .Q(dout[5]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[60] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[60]),
        .Q(dout[60]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[61] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[61]),
        .Q(dout[61]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[62] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[62]),
        .Q(dout[62]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[63] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[63]),
        .Q(dout[63]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[64] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[64]),
        .Q(dout[64]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[65] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[65]),
        .Q(dout[65]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[66] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[66]),
        .Q(dout[66]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[67] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[67]),
        .Q(dout[67]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[68] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[68]),
        .Q(dout[68]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[69] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[69]),
        .Q(dout[69]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[6] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[6]),
        .Q(dout[6]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[70] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[70]),
        .Q(dout[70]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[71] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[71]),
        .Q(dout[71]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[72] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[72]),
        .Q(dout[72]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[73] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[73]),
        .Q(dout[73]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[74] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[74]),
        .Q(dout[74]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[75] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[75]),
        .Q(dout[75]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[76] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[76]),
        .Q(dout[76]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[77] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[77]),
        .Q(dout[77]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[78] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[78]),
        .Q(dout[78]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[79] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[79]),
        .Q(dout[79]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[7] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[7]),
        .Q(dout[7]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[80] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[80]),
        .Q(dout[80]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[81] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[81]),
        .Q(dout[81]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[82] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[82]),
        .Q(dout[82]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[83] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[83]),
        .Q(dout[83]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[84] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[84]),
        .Q(dout[84]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[85] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[85]),
        .Q(dout[85]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[86] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[86]),
        .Q(dout[86]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[87] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[87]),
        .Q(dout[87]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[88] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[88]),
        .Q(dout[88]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[89] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[89]),
        .Q(dout[89]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[8] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[8]),
        .Q(dout[8]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[90] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[90]),
        .Q(dout[90]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[91] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[91]),
        .Q(dout[91]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[92] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[92]),
        .Q(dout[92]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[93] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[93]),
        .Q(dout[93]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[94] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[94]),
        .Q(dout[94]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[95] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[95]),
        .Q(dout[95]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[96] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[96]),
        .Q(dout[96]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[97] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[97]),
        .Q(dout[97]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[98] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[98]),
        .Q(dout[98]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[99] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[99]),
        .Q(dout[99]));
FDCE #(
    .INIT(1'b0)) 
     \gpr1.dout_i_reg[9] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I3),
        .D(p_0_out[9]),
        .Q(dout[9]));
endmodule

(* ORIG_REF_NAME = "fifo_generator_ramfifo" *) 
module adc_cdc_fifo_fifo_generator_ramfifo
   (dout,
    empty,
    full,
    prog_empty,
    rd_en,
    wr_en,
    rd_clk,
    wr_clk,
    rst,
    din);
  output [127:0]dout;
  output empty;
  output full;
  output prog_empty;
  input rd_en;
  input wr_en;
  input rd_clk;
  input wr_clk;
  input rst;
  input [127:0]din;

  wire RD_RST;
  wire RST;
  wire [127:0]din;
  wire [127:0]dout;
  wire empty;
  wire full;
  wire \gwas.wsts/ram_full_i ;
  wire \n_10_gntv_or_sync_fifo.gl0.wr ;
  wire \n_11_gntv_or_sync_fifo.gl0.rd ;
  wire \n_12_gntv_or_sync_fifo.gl0.rd ;
  wire \n_13_gntv_or_sync_fifo.gl0.rd ;
  wire \n_14_gntv_or_sync_fifo.gcx.clkx ;
  wire \n_14_gntv_or_sync_fifo.gl0.rd ;
  wire \n_15_gntv_or_sync_fifo.gcx.clkx ;
  wire \n_15_gntv_or_sync_fifo.gl0.rd ;
  wire \n_16_gntv_or_sync_fifo.gcx.clkx ;
  wire \n_16_gntv_or_sync_fifo.gl0.rd ;
  wire \n_17_gntv_or_sync_fifo.gcx.clkx ;
  wire \n_18_gntv_or_sync_fifo.gcx.clkx ;
  wire \n_19_gntv_or_sync_fifo.gcx.clkx ;
  wire \n_1_gntv_or_sync_fifo.gl0.wr ;
  wire \n_20_gntv_or_sync_fifo.gcx.clkx ;
  wire \n_21_gntv_or_sync_fifo.gcx.clkx ;
  wire \n_2_gntv_or_sync_fifo.gl0.rd ;
  wire \n_2_gntv_or_sync_fifo.gl0.wr ;
  wire [6:0]p_0_out;
  wire [6:0]p_1_out;
  wire [6:0]p_20_out;
  wire [6:0]p_8_out;
  wire [6:0]p_9_out;
  wire prog_empty;
  wire ram_rd_en_i;
  wire rd_clk;
  wire rd_en;
  wire [1:0]rd_rst_i;
  wire rst;
  wire rst_d2;
  wire rst_full_gen_i;
  wire wr_clk;
  wire wr_en;
  wire [0:0]wr_rst_i;

adc_cdc_fifo_clk_x_pntrs \gntv_or_sync_fifo.gcx.clkx 
       (.I1(p_8_out),
        .I2(\n_2_gntv_or_sync_fifo.gl0.rd ),
        .I3(\n_1_gntv_or_sync_fifo.gl0.wr ),
        .I4(p_9_out),
        .I5(wr_rst_i),
        .I6(rd_rst_i[1]),
        .O1({\n_18_gntv_or_sync_fifo.gcx.clkx ,\n_19_gntv_or_sync_fifo.gcx.clkx ,\n_20_gntv_or_sync_fifo.gcx.clkx }),
        .O2(\n_21_gntv_or_sync_fifo.gcx.clkx ),
        .Q(p_20_out),
        .RD_PNTR_WR(p_0_out),
        .S({\n_14_gntv_or_sync_fifo.gcx.clkx ,\n_15_gntv_or_sync_fifo.gcx.clkx ,\n_16_gntv_or_sync_fifo.gcx.clkx ,\n_17_gntv_or_sync_fifo.gcx.clkx }),
        .WR_PNTR_RD(p_1_out),
        .ram_full_i(\gwas.wsts/ram_full_i ),
        .rd_clk(rd_clk),
        .rst_full_gen_i(rst_full_gen_i),
        .wr_clk(wr_clk));
adc_cdc_fifo_rd_logic \gntv_or_sync_fifo.gl0.rd 
       (.ADDRC({\n_11_gntv_or_sync_fifo.gl0.rd ,\n_12_gntv_or_sync_fifo.gl0.rd ,\n_13_gntv_or_sync_fifo.gl0.rd ,\n_14_gntv_or_sync_fifo.gl0.rd ,\n_15_gntv_or_sync_fifo.gl0.rd ,\n_16_gntv_or_sync_fifo.gl0.rd }),
        .E(ram_rd_en_i),
        .I1(\n_21_gntv_or_sync_fifo.gcx.clkx ),
        .I2({\n_18_gntv_or_sync_fifo.gcx.clkx ,\n_19_gntv_or_sync_fifo.gcx.clkx ,\n_20_gntv_or_sync_fifo.gcx.clkx }),
        .O1(\n_2_gntv_or_sync_fifo.gl0.rd ),
        .O2(p_20_out),
        .Q(RD_RST),
        .S({\n_14_gntv_or_sync_fifo.gcx.clkx ,\n_15_gntv_or_sync_fifo.gcx.clkx ,\n_16_gntv_or_sync_fifo.gcx.clkx ,\n_17_gntv_or_sync_fifo.gcx.clkx }),
        .WR_PNTR_RD(p_1_out),
        .empty(empty),
        .prog_empty(prog_empty),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
adc_cdc_fifo_wr_logic \gntv_or_sync_fifo.gl0.wr 
       (.I1(RST),
        .O1(\n_1_gntv_or_sync_fifo.gl0.wr ),
        .O2(\n_2_gntv_or_sync_fifo.gl0.wr ),
        .O3(\n_10_gntv_or_sync_fifo.gl0.wr ),
        .O4(p_8_out),
        .Q(p_9_out),
        .RD_PNTR_WR(p_0_out),
        .full(full),
        .ram_full_i(\gwas.wsts/ram_full_i ),
        .rst_d2(rst_d2),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
adc_cdc_fifo_memory \gntv_or_sync_fifo.mem 
       (.ADDRC({\n_11_gntv_or_sync_fifo.gl0.rd ,\n_12_gntv_or_sync_fifo.gl0.rd ,\n_13_gntv_or_sync_fifo.gl0.rd ,\n_14_gntv_or_sync_fifo.gl0.rd ,\n_15_gntv_or_sync_fifo.gl0.rd ,\n_16_gntv_or_sync_fifo.gl0.rd }),
        .E(ram_rd_en_i),
        .I1(\n_2_gntv_or_sync_fifo.gl0.wr ),
        .I2(\n_10_gntv_or_sync_fifo.gl0.wr ),
        .I3(rd_rst_i[0]),
        .O2(p_20_out),
        .Q(p_9_out[5:0]),
        .din(din),
        .dout(dout),
        .rd_clk(rd_clk),
        .wr_clk(wr_clk));
adc_cdc_fifo_reset_blk_ramfifo rstblk
       (.O1({RD_RST,rd_rst_i}),
        .Q({RST,wr_rst_i}),
        .rd_clk(rd_clk),
        .rst(rst),
        .rst_d2(rst_d2),
        .rst_full_gen_i(rst_full_gen_i),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "fifo_generator_top" *) 
module adc_cdc_fifo_fifo_generator_top
   (dout,
    empty,
    full,
    prog_empty,
    rd_en,
    wr_en,
    rd_clk,
    wr_clk,
    rst,
    din);
  output [127:0]dout;
  output empty;
  output full;
  output prog_empty;
  input rd_en;
  input wr_en;
  input rd_clk;
  input wr_clk;
  input rst;
  input [127:0]din;

  wire [127:0]din;
  wire [127:0]dout;
  wire empty;
  wire full;
  wire prog_empty;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;

adc_cdc_fifo_fifo_generator_ramfifo \grf.rf 
       (.din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_empty(prog_empty),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "fifo_generator_v12_0" *) (* C_COMMON_CLOCK = "0" *) (* C_COUNT_TYPE = "0" *) 
(* C_DATA_COUNT_WIDTH = "7" *) (* C_DEFAULT_VALUE = "BlankString" *) (* C_DIN_WIDTH = "128" *) 
(* C_DOUT_RST_VAL = "0" *) (* C_DOUT_WIDTH = "128" *) (* C_ENABLE_RLOCS = "0" *) 
(* C_FAMILY = "virtex7" *) (* C_FULL_FLAGS_RST_VAL = "1" *) (* C_HAS_ALMOST_EMPTY = "0" *) 
(* C_HAS_ALMOST_FULL = "0" *) (* C_HAS_BACKUP = "0" *) (* C_HAS_DATA_COUNT = "0" *) 
(* C_HAS_INT_CLK = "0" *) (* C_HAS_MEMINIT_FILE = "0" *) (* C_HAS_OVERFLOW = "0" *) 
(* C_HAS_RD_DATA_COUNT = "0" *) (* C_HAS_RD_RST = "0" *) (* C_HAS_RST = "1" *) 
(* C_HAS_SRST = "0" *) (* C_HAS_UNDERFLOW = "0" *) (* C_HAS_VALID = "0" *) 
(* C_HAS_WR_ACK = "0" *) (* C_HAS_WR_DATA_COUNT = "0" *) (* C_HAS_WR_RST = "0" *) 
(* C_IMPLEMENTATION_TYPE = "2" *) (* C_INIT_WR_PNTR_VAL = "0" *) (* C_MEMORY_TYPE = "2" *) 
(* C_MIF_FILE_NAME = "BlankString" *) (* C_OPTIMIZATION_MODE = "0" *) (* C_OVERFLOW_LOW = "0" *) 
(* C_PRELOAD_LATENCY = "1" *) (* C_PRELOAD_REGS = "0" *) (* C_PRIM_FIFO_TYPE = "512x72" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL = "6" *) (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "15" *) (* C_PROG_EMPTY_TYPE = "2" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL = "125" *) (* C_PROG_FULL_THRESH_NEGATE_VAL = "124" *) (* C_PROG_FULL_TYPE = "0" *) 
(* C_RD_DATA_COUNT_WIDTH = "7" *) (* C_RD_DEPTH = "128" *) (* C_RD_FREQ = "1" *) 
(* C_RD_PNTR_WIDTH = "7" *) (* C_UNDERFLOW_LOW = "0" *) (* C_USE_DOUT_RST = "1" *) 
(* C_USE_ECC = "0" *) (* C_USE_EMBEDDED_REG = "0" *) (* C_USE_PIPELINE_REG = "0" *) 
(* C_POWER_SAVING_MODE = "0" *) (* C_USE_FIFO16_FLAGS = "0" *) (* C_USE_FWFT_DATA_COUNT = "0" *) 
(* C_VALID_LOW = "0" *) (* C_WR_ACK_LOW = "0" *) (* C_WR_DATA_COUNT_WIDTH = "7" *) 
(* C_WR_DEPTH = "128" *) (* C_WR_FREQ = "1" *) (* C_WR_PNTR_WIDTH = "7" *) 
(* C_WR_RESPONSE_LATENCY = "1" *) (* C_MSGON_VAL = "1" *) (* C_ENABLE_RST_SYNC = "1" *) 
(* C_ERROR_INJECTION_TYPE = "0" *) (* C_SYNCHRONIZER_STAGE = "3" *) (* C_INTERFACE_TYPE = "0" *) 
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
module adc_cdc_fifo_fifo_generator_v12_0__parameterized0
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
  input [127:0]din;
  input wr_en;
  input rd_en;
  input [6:0]prog_empty_thresh;
  input [6:0]prog_empty_thresh_assert;
  input [6:0]prog_empty_thresh_negate;
  input [6:0]prog_full_thresh;
  input [6:0]prog_full_thresh_assert;
  input [6:0]prog_full_thresh_negate;
  input int_clk;
  input injectdbiterr;
  input injectsbiterr;
  input sleep;
  output [127:0]dout;
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
  wire [127:0]din;
  wire [127:0]dout;
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
  wire prog_empty;
  wire [6:0]prog_empty_thresh;
  wire [6:0]prog_empty_thresh_assert;
  wire [6:0]prog_empty_thresh_negate;
  wire [6:0]prog_full_thresh;
  wire [6:0]prog_full_thresh_assert;
  wire [6:0]prog_full_thresh_negate;
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
  assign prog_full = \<const0> ;
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
adc_cdc_fifo_fifo_generator_v12_0_synth inst_fifo_gen
       (.din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_empty(prog_empty),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "fifo_generator_v12_0_synth" *) 
module adc_cdc_fifo_fifo_generator_v12_0_synth
   (dout,
    empty,
    full,
    prog_empty,
    rd_en,
    wr_en,
    rd_clk,
    wr_clk,
    rst,
    din);
  output [127:0]dout;
  output empty;
  output full;
  output prog_empty;
  input rd_en;
  input wr_en;
  input rd_clk;
  input wr_clk;
  input rst;
  input [127:0]din;

  wire [127:0]din;
  wire [127:0]dout;
  wire empty;
  wire full;
  wire prog_empty;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;

adc_cdc_fifo_fifo_generator_top \gconvfifo.rf 
       (.din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_empty(prog_empty),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "memory" *) 
module adc_cdc_fifo_memory
   (dout,
    wr_clk,
    din,
    I1,
    O2,
    Q,
    I2,
    ADDRC,
    E,
    rd_clk,
    I3);
  output [127:0]dout;
  input wr_clk;
  input [127:0]din;
  input I1;
  input [6:0]O2;
  input [5:0]Q;
  input I2;
  input [5:0]ADDRC;
  input [0:0]E;
  input rd_clk;
  input [0:0]I3;

  wire [5:0]ADDRC;
  wire [0:0]E;
  wire I1;
  wire I2;
  wire [0:0]I3;
  wire [6:0]O2;
  wire [5:0]Q;
  wire [127:0]din;
  wire [127:0]dout;
  wire rd_clk;
  wire wr_clk;

adc_cdc_fifo_dmem \gdm.dm 
       (.ADDRC(ADDRC),
        .E(E),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .O2(O2),
        .Q(Q),
        .din(din),
        .dout(dout),
        .rd_clk(rd_clk),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "rd_bin_cntr" *) 
module adc_cdc_fifo_rd_bin_cntr
   (O1,
    O2,
    ADDRC,
    WR_PNTR_RD,
    rd_en,
    p_18_out,
    p_14_out,
    rd_clk,
    Q);
  output O1;
  output [6:0]O2;
  output [5:0]ADDRC;
  input [6:0]WR_PNTR_RD;
  input rd_en;
  input p_18_out;
  input p_14_out;
  input rd_clk;
  input [0:0]Q;

  wire [5:0]ADDRC;
  wire O1;
  wire [6:0]O2;
  wire [0:0]Q;
  wire [6:0]WR_PNTR_RD;
  wire \n_0_gc0.count[6]_i_2 ;
  wire n_0_ram_empty_i_i_5;
  wire n_0_ram_empty_i_i_6;
  wire p_14_out;
  wire p_18_out;
  wire [6:0]plusOp__0;
  wire rd_clk;
  wire rd_en;
  wire [6:0]rd_pntr_plus1;

LUT1 #(
    .INIT(2'h1)) 
     \gc0.count[0]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .O(plusOp__0[0]));
LUT2 #(
    .INIT(4'h6)) 
     \gc0.count[1]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .I1(rd_pntr_plus1[1]),
        .O(plusOp__0[1]));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \gc0.count[2]_i_1 
       (.I0(rd_pntr_plus1[2]),
        .I1(rd_pntr_plus1[1]),
        .I2(rd_pntr_plus1[0]),
        .O(plusOp__0[2]));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \gc0.count[3]_i_1 
       (.I0(rd_pntr_plus1[3]),
        .I1(rd_pntr_plus1[0]),
        .I2(rd_pntr_plus1[1]),
        .I3(rd_pntr_plus1[2]),
        .O(plusOp__0[3]));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gc0.count[4]_i_1 
       (.I0(rd_pntr_plus1[4]),
        .I1(rd_pntr_plus1[2]),
        .I2(rd_pntr_plus1[1]),
        .I3(rd_pntr_plus1[0]),
        .I4(rd_pntr_plus1[3]),
        .O(plusOp__0[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \gc0.count[5]_i_1 
       (.I0(rd_pntr_plus1[5]),
        .I1(rd_pntr_plus1[3]),
        .I2(rd_pntr_plus1[0]),
        .I3(rd_pntr_plus1[1]),
        .I4(rd_pntr_plus1[2]),
        .I5(rd_pntr_plus1[4]),
        .O(plusOp__0[5]));
LUT3 #(
    .INIT(8'h6A)) 
     \gc0.count[6]_i_1 
       (.I0(rd_pntr_plus1[6]),
        .I1(\n_0_gc0.count[6]_i_2 ),
        .I2(rd_pntr_plus1[5]),
        .O(plusOp__0[6]));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT5 #(
    .INIT(32'h80000000)) 
     \gc0.count[6]_i_2 
       (.I0(rd_pntr_plus1[4]),
        .I1(rd_pntr_plus1[2]),
        .I2(rd_pntr_plus1[1]),
        .I3(rd_pntr_plus1[0]),
        .I4(rd_pntr_plus1[3]),
        .O(\n_0_gc0.count[6]_i_2 ));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[0]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[0] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[0]),
        .Q(O2[0]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[0]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[0]_rep 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[0]),
        .Q(ADDRC[0]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[1]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[1] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[1]),
        .Q(O2[1]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[1]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[1]_rep 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[1]),
        .Q(ADDRC[1]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[2]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[2] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[2]),
        .Q(O2[2]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[2]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[2]_rep 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[2]),
        .Q(ADDRC[2]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[3]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[3] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[3]),
        .Q(O2[3]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[3]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[3]_rep 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[3]),
        .Q(ADDRC[3]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[4]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[4] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[4]),
        .Q(O2[4]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[4]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[4]_rep 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[4]),
        .Q(ADDRC[4]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[5]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[5] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[5]),
        .Q(O2[5]));
(* ORIG_CELL_NAME = "gc0.count_d1_reg[5]" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[5]_rep 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[5]),
        .Q(ADDRC[5]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[6] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(rd_pntr_plus1[6]),
        .Q(O2[6]));
FDPE #(
    .INIT(1'b1)) 
     \gc0.count_reg[0] 
       (.C(rd_clk),
        .CE(p_14_out),
        .D(plusOp__0[0]),
        .PRE(Q),
        .Q(rd_pntr_plus1[0]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[1] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(plusOp__0[1]),
        .Q(rd_pntr_plus1[1]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[2] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(plusOp__0[2]),
        .Q(rd_pntr_plus1[2]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[3] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(plusOp__0[3]),
        .Q(rd_pntr_plus1[3]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[4] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(plusOp__0[4]),
        .Q(rd_pntr_plus1[4]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[5] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(plusOp__0[5]),
        .Q(rd_pntr_plus1[5]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[6] 
       (.C(rd_clk),
        .CE(p_14_out),
        .CLR(Q),
        .D(plusOp__0[6]),
        .Q(rd_pntr_plus1[6]));
LUT6 #(
    .INIT(64'h9009000000000000)) 
     ram_empty_i_i_4
       (.I0(rd_pntr_plus1[1]),
        .I1(WR_PNTR_RD[1]),
        .I2(rd_pntr_plus1[0]),
        .I3(WR_PNTR_RD[0]),
        .I4(n_0_ram_empty_i_i_5),
        .I5(n_0_ram_empty_i_i_6),
        .O(O1));
LUT6 #(
    .INIT(64'h0090000000000090)) 
     ram_empty_i_i_5
       (.I0(rd_pntr_plus1[4]),
        .I1(WR_PNTR_RD[4]),
        .I2(rd_en),
        .I3(p_18_out),
        .I4(WR_PNTR_RD[6]),
        .I5(rd_pntr_plus1[6]),
        .O(n_0_ram_empty_i_i_5));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_empty_i_i_6
       (.I0(rd_pntr_plus1[5]),
        .I1(WR_PNTR_RD[5]),
        .I2(rd_pntr_plus1[3]),
        .I3(WR_PNTR_RD[3]),
        .I4(WR_PNTR_RD[2]),
        .I5(rd_pntr_plus1[2]),
        .O(n_0_ram_empty_i_i_6));
endmodule

(* ORIG_REF_NAME = "rd_logic" *) 
module adc_cdc_fifo_rd_logic
   (empty,
    prog_empty,
    O1,
    E,
    O2,
    ADDRC,
    I1,
    rd_clk,
    Q,
    WR_PNTR_RD,
    rd_en,
    I2,
    S);
  output empty;
  output prog_empty;
  output O1;
  output [0:0]E;
  output [6:0]O2;
  output [5:0]ADDRC;
  input I1;
  input rd_clk;
  input [0:0]Q;
  input [6:0]WR_PNTR_RD;
  input rd_en;
  input [2:0]I2;
  input [3:0]S;

  wire [5:0]ADDRC;
  wire [0:0]E;
  wire I1;
  wire [2:0]I2;
  wire O1;
  wire [6:0]O2;
  wire [0:0]Q;
  wire [3:0]S;
  wire [6:0]WR_PNTR_RD;
  wire empty;
  wire p_14_out;
  wire p_18_out;
  wire prog_empty;
  wire rd_clk;
  wire rd_en;
  wire [0:0]rd_pntr_inv_pad;

adc_cdc_fifo_rd_pe_as \gras.gpe.rdpe 
       (.I2(I2),
        .Q(Q),
        .S(S),
        .adjusted_wr_pntr_rd_pad({WR_PNTR_RD[5:0],rd_pntr_inv_pad}),
        .p_18_out(p_18_out),
        .prog_empty(prog_empty),
        .rd_clk(rd_clk));
adc_cdc_fifo_rd_status_flags_as \gras.rsts 
       (.E(E),
        .I1(I1),
        .Q(Q),
        .adjusted_wr_pntr_rd_pad(rd_pntr_inv_pad),
        .empty(empty),
        .p_14_out(p_14_out),
        .p_18_out(p_18_out),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
adc_cdc_fifo_rd_bin_cntr rpntr
       (.ADDRC(ADDRC),
        .O1(O1),
        .O2(O2),
        .Q(Q),
        .WR_PNTR_RD(WR_PNTR_RD),
        .p_14_out(p_14_out),
        .p_18_out(p_18_out),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
endmodule

(* ORIG_REF_NAME = "rd_pe_as" *) 
module adc_cdc_fifo_rd_pe_as
   (prog_empty,
    rd_clk,
    Q,
    p_18_out,
    adjusted_wr_pntr_rd_pad,
    I2,
    S);
  output prog_empty;
  input rd_clk;
  input [0:0]Q;
  input p_18_out;
  input [6:0]adjusted_wr_pntr_rd_pad;
  input [2:0]I2;
  input [3:0]S;

  wire [2:0]I2;
  wire [0:0]Q;
  wire [3:0]S;
  wire [6:0]adjusted_wr_pntr_rd_pad;
  wire [6:0]diff_pntr;
  wire \n_0_gdiff.diff_pntr_pad_reg[3]_i_1 ;
  wire \n_0_gpe2.prog_empty_i_i_1 ;
  wire \n_0_gpe2.prog_empty_i_i_2 ;
  wire \n_1_gdiff.diff_pntr_pad_reg[3]_i_1 ;
  wire \n_1_gdiff.diff_pntr_pad_reg[7]_i_1 ;
  wire \n_2_gdiff.diff_pntr_pad_reg[3]_i_1 ;
  wire \n_2_gdiff.diff_pntr_pad_reg[7]_i_1 ;
  wire \n_3_gdiff.diff_pntr_pad_reg[3]_i_1 ;
  wire \n_3_gdiff.diff_pntr_pad_reg[7]_i_1 ;
  wire p_18_out;
  wire [7:0]plusOp;
  wire prog_empty;
  wire rd_clk;
  wire [3:3]\NLW_gdiff.diff_pntr_pad_reg[7]_i_1_CO_UNCONNECTED ;

FDCE #(
    .INIT(1'b0)) 
     \gdiff.diff_pntr_pad_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(Q),
        .D(plusOp[1]),
        .Q(diff_pntr[0]));
FDCE #(
    .INIT(1'b0)) 
     \gdiff.diff_pntr_pad_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(Q),
        .D(plusOp[2]),
        .Q(diff_pntr[1]));
FDCE #(
    .INIT(1'b0)) 
     \gdiff.diff_pntr_pad_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(Q),
        .D(plusOp[3]),
        .Q(diff_pntr[2]));
CARRY4 \gdiff.diff_pntr_pad_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\n_0_gdiff.diff_pntr_pad_reg[3]_i_1 ,\n_1_gdiff.diff_pntr_pad_reg[3]_i_1 ,\n_2_gdiff.diff_pntr_pad_reg[3]_i_1 ,\n_3_gdiff.diff_pntr_pad_reg[3]_i_1 }),
        .CYINIT(1'b0),
        .DI(adjusted_wr_pntr_rd_pad[3:0]),
        .O(plusOp[3:0]),
        .S({I2,1'b0}));
FDCE #(
    .INIT(1'b0)) 
     \gdiff.diff_pntr_pad_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(Q),
        .D(plusOp[4]),
        .Q(diff_pntr[3]));
FDCE #(
    .INIT(1'b0)) 
     \gdiff.diff_pntr_pad_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(Q),
        .D(plusOp[5]),
        .Q(diff_pntr[4]));
FDCE #(
    .INIT(1'b0)) 
     \gdiff.diff_pntr_pad_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(Q),
        .D(plusOp[6]),
        .Q(diff_pntr[5]));
FDCE #(
    .INIT(1'b0)) 
     \gdiff.diff_pntr_pad_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(Q),
        .D(plusOp[7]),
        .Q(diff_pntr[6]));
CARRY4 \gdiff.diff_pntr_pad_reg[7]_i_1 
       (.CI(\n_0_gdiff.diff_pntr_pad_reg[3]_i_1 ),
        .CO({\NLW_gdiff.diff_pntr_pad_reg[7]_i_1_CO_UNCONNECTED [3],\n_1_gdiff.diff_pntr_pad_reg[7]_i_1 ,\n_2_gdiff.diff_pntr_pad_reg[7]_i_1 ,\n_3_gdiff.diff_pntr_pad_reg[7]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,adjusted_wr_pntr_rd_pad[6:4]}),
        .O(plusOp[7:4]),
        .S(S));
LUT6 #(
    .INIT(64'hFFFF010100000100)) 
     \gpe2.prog_empty_i_i_1 
       (.I0(diff_pntr[4]),
        .I1(diff_pntr[5]),
        .I2(diff_pntr[6]),
        .I3(\n_0_gpe2.prog_empty_i_i_2 ),
        .I4(p_18_out),
        .I5(prog_empty),
        .O(\n_0_gpe2.prog_empty_i_i_1 ));
LUT4 #(
    .INIT(16'h1555)) 
     \gpe2.prog_empty_i_i_2 
       (.I0(diff_pntr[3]),
        .I1(diff_pntr[2]),
        .I2(diff_pntr[1]),
        .I3(diff_pntr[0]),
        .O(\n_0_gpe2.prog_empty_i_i_2 ));
FDPE #(
    .INIT(1'b1)) 
     \gpe2.prog_empty_i_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\n_0_gpe2.prog_empty_i_i_1 ),
        .PRE(Q),
        .Q(prog_empty));
endmodule

(* ORIG_REF_NAME = "rd_status_flags_as" *) 
module adc_cdc_fifo_rd_status_flags_as
   (empty,
    p_18_out,
    adjusted_wr_pntr_rd_pad,
    p_14_out,
    E,
    I1,
    rd_clk,
    Q,
    rd_en);
  output empty;
  output p_18_out;
  output [0:0]adjusted_wr_pntr_rd_pad;
  output p_14_out;
  output [0:0]E;
  input I1;
  input rd_clk;
  input [0:0]Q;
  input rd_en;

  wire [0:0]E;
  wire I1;
  wire [0:0]Q;
  wire [0:0]adjusted_wr_pntr_rd_pad;
  wire empty;
  wire p_14_out;
  wire p_18_out;
  wire rd_clk;
  wire rd_en;

(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \gc0.count_d1[6]_i_1 
       (.I0(rd_en),
        .I1(p_18_out),
        .O(p_14_out));
LUT2 #(
    .INIT(4'hB)) 
     \gdiff.diff_pntr_pad[3]_i_2 
       (.I0(p_18_out),
        .I1(rd_en),
        .O(adjusted_wr_pntr_rd_pad));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \gpr1.dout_i[127]_i_1 
       (.I0(rd_en),
        .I1(p_18_out),
        .O(E));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     ram_empty_fb_i_reg
       (.C(rd_clk),
        .CE(1'b1),
        .D(I1),
        .PRE(Q),
        .Q(p_18_out));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     ram_empty_i_reg
       (.C(rd_clk),
        .CE(1'b1),
        .D(I1),
        .PRE(Q),
        .Q(empty));
endmodule

(* ORIG_REF_NAME = "reset_blk_ramfifo" *) 
module adc_cdc_fifo_reset_blk_ramfifo
   (rst_d2,
    rst_full_gen_i,
    Q,
    O1,
    wr_clk,
    rst,
    rd_clk);
  output rst_d2;
  output rst_full_gen_i;
  output [1:0]Q;
  output [2:0]O1;
  input wr_clk;
  input rst;
  input rd_clk;

  wire [2:0]O1;
  wire [1:0]Q;
  wire \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ;
  wire \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 ;
  wire rd_clk;
  wire rd_rst_asreg;
  wire rd_rst_asreg_d1;
  wire rd_rst_asreg_d2;
  wire rst;
  wire rst_d1;
  wire rst_d2;
  wire rst_d3;
  wire rst_full_gen_i;
  wire wr_clk;
  wire wr_rst_asreg;
  wire wr_rst_asreg_d1;
  wire wr_rst_asreg_d2;

FDCE #(
    .INIT(1'b0)) 
     \grstd1.grst_full.grst_f.RST_FULL_GEN_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(rst),
        .D(rst_d3),
        .Q(rst_full_gen_i));
(* ASYNC_REG *) 
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
   (* msgon = "true" *) 
   FDPE #(
    .INIT(1'b1)) 
     \grstd1.grst_full.grst_f.rst_d3_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(rst_d2),
        .PRE(rst),
        .Q(rst_d3));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(rd_rst_asreg),
        .Q(rd_rst_asreg_d1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(rd_rst_asreg_d1),
        .Q(rd_rst_asreg_d2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE \ngwrdrst.grst.g7serrst.rd_rst_asreg_reg 
       (.C(rd_clk),
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
       (.C(rd_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ),
        .Q(O1[0]));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ),
        .Q(O1[1]));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ),
        .Q(O1[2]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(wr_rst_asreg),
        .Q(wr_rst_asreg_d1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(wr_rst_asreg_d1),
        .Q(wr_rst_asreg_d2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE \ngwrdrst.grst.g7serrst.wr_rst_asreg_reg 
       (.C(wr_clk),
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
     \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 ),
        .Q(Q[0]));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 ),
        .Q(Q[1]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module adc_cdc_fifo_synchronizer_ff
   (Q,
    I1,
    rd_clk,
    I6);
  output [6:0]Q;
  input [6:0]I1;
  input rd_clk;
  input [0:0]I6;

  wire [6:0]I1;
  wire [0:0]I6;
  wire [6:0]Q;
  wire rd_clk;

(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(I1[0]),
        .Q(Q[0]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(I1[1]),
        .Q(Q[1]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(I1[2]),
        .Q(Q[2]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(I1[3]),
        .Q(Q[3]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(I1[4]),
        .Q(Q[4]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(I1[5]),
        .Q(Q[5]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(I1[6]),
        .Q(Q[6]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module adc_cdc_fifo_synchronizer_ff_0
   (Q,
    I1,
    wr_clk,
    I5);
  output [6:0]Q;
  input [6:0]I1;
  input wr_clk;
  input [0:0]I5;

  wire [6:0]I1;
  wire [0:0]I5;
  wire [6:0]Q;
  wire wr_clk;

(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(I1[0]),
        .Q(Q[0]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(I1[1]),
        .Q(Q[1]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(I1[2]),
        .Q(Q[2]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(I1[3]),
        .Q(Q[3]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(I1[4]),
        .Q(Q[4]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(I1[5]),
        .Q(Q[5]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(I1[6]),
        .Q(Q[6]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module adc_cdc_fifo_synchronizer_ff_1
   (Q,
    D,
    rd_clk,
    I6);
  output [6:0]Q;
  input [6:0]D;
  input rd_clk;
  input [0:0]I6;

  wire [6:0]D;
  wire [0:0]I6;
  wire [6:0]Q;
  wire rd_clk;

(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[0]),
        .Q(Q[0]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[1]),
        .Q(Q[1]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[2]),
        .Q(Q[2]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[3]),
        .Q(Q[3]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[4]),
        .Q(Q[4]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[5]),
        .Q(Q[5]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[6]),
        .Q(Q[6]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module adc_cdc_fifo_synchronizer_ff_2
   (Q,
    D,
    wr_clk,
    I5);
  output [6:0]Q;
  input [6:0]D;
  input wr_clk;
  input [0:0]I5;

  wire [6:0]D;
  wire [0:0]I5;
  wire [6:0]Q;
  wire wr_clk;

(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[0]),
        .Q(Q[0]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[1]),
        .Q(Q[1]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[2]),
        .Q(Q[2]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[3]),
        .Q(Q[3]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[4]),
        .Q(Q[4]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[5]),
        .Q(Q[5]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[6]),
        .Q(Q[6]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module adc_cdc_fifo_synchronizer_ff_3
   (p_0_in,
    D,
    rd_clk,
    I6);
  output [6:0]p_0_in;
  input [6:0]D;
  input rd_clk;
  input [0:0]I6;

  wire [6:0]D;
  wire [0:0]I6;
  wire \n_0_Q_reg_reg[0] ;
  wire \n_0_Q_reg_reg[1] ;
  wire \n_0_Q_reg_reg[2] ;
  wire \n_0_Q_reg_reg[3] ;
  wire \n_0_Q_reg_reg[4] ;
  wire \n_0_Q_reg_reg[5] ;
  wire [6:0]p_0_in;
  wire rd_clk;

(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[0]),
        .Q(\n_0_Q_reg_reg[0] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[1]),
        .Q(\n_0_Q_reg_reg[1] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[2]),
        .Q(\n_0_Q_reg_reg[2] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[3]),
        .Q(\n_0_Q_reg_reg[3] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[4]),
        .Q(\n_0_Q_reg_reg[4] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[5]),
        .Q(\n_0_Q_reg_reg[5] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(I6),
        .D(D[6]),
        .Q(p_0_in[6]));
LUT4 #(
    .INIT(16'h6996)) 
     \wr_pntr_bin[0]_i_1 
       (.I0(\n_0_Q_reg_reg[2] ),
        .I1(\n_0_Q_reg_reg[1] ),
        .I2(\n_0_Q_reg_reg[0] ),
        .I3(p_0_in[3]),
        .O(p_0_in[0]));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \wr_pntr_bin[1]_i_1 
       (.I0(\n_0_Q_reg_reg[2] ),
        .I1(\n_0_Q_reg_reg[1] ),
        .I2(\n_0_Q_reg_reg[3] ),
        .I3(\n_0_Q_reg_reg[5] ),
        .I4(\n_0_Q_reg_reg[4] ),
        .I5(p_0_in[6]),
        .O(p_0_in[1]));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT5 #(
    .INIT(32'h96696996)) 
     \wr_pntr_bin[2]_i_1 
       (.I0(\n_0_Q_reg_reg[3] ),
        .I1(\n_0_Q_reg_reg[5] ),
        .I2(\n_0_Q_reg_reg[4] ),
        .I3(p_0_in[6]),
        .I4(\n_0_Q_reg_reg[2] ),
        .O(p_0_in[2]));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \wr_pntr_bin[3]_i_1 
       (.I0(p_0_in[6]),
        .I1(\n_0_Q_reg_reg[4] ),
        .I2(\n_0_Q_reg_reg[5] ),
        .I3(\n_0_Q_reg_reg[3] ),
        .O(p_0_in[3]));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT3 #(
    .INIT(8'h96)) 
     \wr_pntr_bin[4]_i_1 
       (.I0(\n_0_Q_reg_reg[5] ),
        .I1(\n_0_Q_reg_reg[4] ),
        .I2(p_0_in[6]),
        .O(p_0_in[4]));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_bin[5]_i_1 
       (.I0(\n_0_Q_reg_reg[5] ),
        .I1(p_0_in[6]),
        .O(p_0_in[5]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module adc_cdc_fifo_synchronizer_ff_4
   (Q,
    O1,
    D,
    wr_clk,
    I5);
  output [0:0]Q;
  output [5:0]O1;
  input [6:0]D;
  input wr_clk;
  input [0:0]I5;

  wire [6:0]D;
  wire [0:0]I5;
  wire [5:0]O1;
  wire [0:0]Q;
  wire \n_0_Q_reg_reg[0] ;
  wire \n_0_Q_reg_reg[1] ;
  wire \n_0_Q_reg_reg[2] ;
  wire \n_0_Q_reg_reg[3] ;
  wire \n_0_Q_reg_reg[4] ;
  wire \n_0_Q_reg_reg[5] ;
  wire wr_clk;

(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[0]),
        .Q(\n_0_Q_reg_reg[0] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[1]),
        .Q(\n_0_Q_reg_reg[1] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[2]),
        .Q(\n_0_Q_reg_reg[2] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[3]),
        .Q(\n_0_Q_reg_reg[3] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[4]),
        .Q(\n_0_Q_reg_reg[4] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[5]),
        .Q(\n_0_Q_reg_reg[5] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(I5),
        .D(D[6]),
        .Q(Q));
LUT4 #(
    .INIT(16'h6996)) 
     \rd_pntr_bin[0]_i_1 
       (.I0(\n_0_Q_reg_reg[2] ),
        .I1(\n_0_Q_reg_reg[1] ),
        .I2(\n_0_Q_reg_reg[0] ),
        .I3(O1[3]),
        .O(O1[0]));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \rd_pntr_bin[1]_i_1 
       (.I0(\n_0_Q_reg_reg[2] ),
        .I1(\n_0_Q_reg_reg[1] ),
        .I2(\n_0_Q_reg_reg[3] ),
        .I3(\n_0_Q_reg_reg[5] ),
        .I4(\n_0_Q_reg_reg[4] ),
        .I5(Q),
        .O(O1[1]));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT5 #(
    .INIT(32'h96696996)) 
     \rd_pntr_bin[2]_i_1 
       (.I0(\n_0_Q_reg_reg[3] ),
        .I1(\n_0_Q_reg_reg[5] ),
        .I2(\n_0_Q_reg_reg[4] ),
        .I3(Q),
        .I4(\n_0_Q_reg_reg[2] ),
        .O(O1[2]));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \rd_pntr_bin[3]_i_1 
       (.I0(Q),
        .I1(\n_0_Q_reg_reg[4] ),
        .I2(\n_0_Q_reg_reg[5] ),
        .I3(\n_0_Q_reg_reg[3] ),
        .O(O1[3]));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT3 #(
    .INIT(8'h96)) 
     \rd_pntr_bin[4]_i_1 
       (.I0(\n_0_Q_reg_reg[5] ),
        .I1(\n_0_Q_reg_reg[4] ),
        .I2(Q),
        .O(O1[4]));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_bin[5]_i_1 
       (.I0(\n_0_Q_reg_reg[5] ),
        .I1(Q),
        .O(O1[5]));
endmodule

(* ORIG_REF_NAME = "wr_bin_cntr" *) 
module adc_cdc_fifo_wr_bin_cntr
   (O1,
    O4,
    Q,
    RD_PNTR_WR,
    wr_en,
    p_0_out,
    E,
    wr_clk,
    I1);
  output O1;
  output [6:0]O4;
  output [6:0]Q;
  input [6:0]RD_PNTR_WR;
  input wr_en;
  input p_0_out;
  input [0:0]E;
  input wr_clk;
  input [0:0]I1;

  wire [0:0]E;
  wire [0:0]I1;
  wire O1;
  wire [6:0]O4;
  wire [6:0]Q;
  wire [6:0]RD_PNTR_WR;
  wire \n_0_gic0.gc0.count[6]_i_2 ;
  wire n_0_ram_full_i_i_5;
  wire n_0_ram_full_i_i_6;
  wire p_0_out;
  wire [6:0]plusOp__1;
  wire wr_clk;
  wire wr_en;
  wire [6:0]wr_pntr_plus2;

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
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \gic0.gc0.count[2]_i_1 
       (.I0(wr_pntr_plus2[0]),
        .I1(wr_pntr_plus2[1]),
        .I2(wr_pntr_plus2[2]),
        .O(plusOp__1[2]));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \gic0.gc0.count[3]_i_1 
       (.I0(wr_pntr_plus2[3]),
        .I1(wr_pntr_plus2[0]),
        .I2(wr_pntr_plus2[1]),
        .I3(wr_pntr_plus2[2]),
        .O(plusOp__1[3]));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gic0.gc0.count[4]_i_1 
       (.I0(wr_pntr_plus2[4]),
        .I1(wr_pntr_plus2[2]),
        .I2(wr_pntr_plus2[1]),
        .I3(wr_pntr_plus2[0]),
        .I4(wr_pntr_plus2[3]),
        .O(plusOp__1[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \gic0.gc0.count[5]_i_1 
       (.I0(wr_pntr_plus2[5]),
        .I1(wr_pntr_plus2[3]),
        .I2(wr_pntr_plus2[0]),
        .I3(wr_pntr_plus2[1]),
        .I4(wr_pntr_plus2[2]),
        .I5(wr_pntr_plus2[4]),
        .O(plusOp__1[5]));
LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \gic0.gc0.count[6]_i_1 
       (.I0(wr_pntr_plus2[6]),
        .I1(wr_pntr_plus2[4]),
        .I2(\n_0_gic0.gc0.count[6]_i_2 ),
        .I3(wr_pntr_plus2[3]),
        .I4(wr_pntr_plus2[5]),
        .O(plusOp__1[6]));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT3 #(
    .INIT(8'h80)) 
     \gic0.gc0.count[6]_i_2 
       (.I0(wr_pntr_plus2[2]),
        .I1(wr_pntr_plus2[1]),
        .I2(wr_pntr_plus2[0]),
        .O(\n_0_gic0.gc0.count[6]_i_2 ));
FDPE #(
    .INIT(1'b1)) 
     \gic0.gc0.count_d1_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .D(wr_pntr_plus2[0]),
        .PRE(I1),
        .Q(O4[0]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(wr_pntr_plus2[1]),
        .Q(O4[1]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(wr_pntr_plus2[2]),
        .Q(O4[2]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(wr_pntr_plus2[3]),
        .Q(O4[3]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(wr_pntr_plus2[4]),
        .Q(O4[4]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[5] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(wr_pntr_plus2[5]),
        .Q(O4[5]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[6] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(wr_pntr_plus2[6]),
        .Q(O4[6]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O4[0]),
        .Q(Q[0]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O4[1]),
        .Q(Q[1]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O4[2]),
        .Q(Q[2]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O4[3]),
        .Q(Q[3]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O4[4]),
        .Q(Q[4]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[5] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O4[5]),
        .Q(Q[5]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[6] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O4[6]),
        .Q(Q[6]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__1[0]),
        .Q(wr_pntr_plus2[0]));
FDPE #(
    .INIT(1'b1)) 
     \gic0.gc0.count_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .D(plusOp__1[1]),
        .PRE(I1),
        .Q(wr_pntr_plus2[1]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__1[2]),
        .Q(wr_pntr_plus2[2]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__1[3]),
        .Q(wr_pntr_plus2[3]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__1[4]),
        .Q(wr_pntr_plus2[4]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[5] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__1[5]),
        .Q(wr_pntr_plus2[5]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[6] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__1[6]),
        .Q(wr_pntr_plus2[6]));
LUT6 #(
    .INIT(64'h9009000000000000)) 
     ram_full_i_i_4
       (.I0(wr_pntr_plus2[1]),
        .I1(RD_PNTR_WR[1]),
        .I2(wr_pntr_plus2[0]),
        .I3(RD_PNTR_WR[0]),
        .I4(n_0_ram_full_i_i_5),
        .I5(n_0_ram_full_i_i_6),
        .O(O1));
LUT6 #(
    .INIT(64'h0090000000000090)) 
     ram_full_i_i_5
       (.I0(wr_pntr_plus2[4]),
        .I1(RD_PNTR_WR[4]),
        .I2(wr_en),
        .I3(p_0_out),
        .I4(RD_PNTR_WR[6]),
        .I5(wr_pntr_plus2[6]),
        .O(n_0_ram_full_i_i_5));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_full_i_i_6
       (.I0(wr_pntr_plus2[5]),
        .I1(RD_PNTR_WR[5]),
        .I2(wr_pntr_plus2[3]),
        .I3(RD_PNTR_WR[3]),
        .I4(RD_PNTR_WR[2]),
        .I5(wr_pntr_plus2[2]),
        .O(n_0_ram_full_i_i_6));
endmodule

(* ORIG_REF_NAME = "wr_logic" *) 
module adc_cdc_fifo_wr_logic
   (full,
    O1,
    O2,
    Q,
    O3,
    O4,
    ram_full_i,
    wr_clk,
    rst_d2,
    RD_PNTR_WR,
    wr_en,
    I1);
  output full;
  output O1;
  output O2;
  output [6:0]Q;
  output O3;
  output [6:0]O4;
  input ram_full_i;
  input wr_clk;
  input rst_d2;
  input [6:0]RD_PNTR_WR;
  input wr_en;
  input [0:0]I1;

  wire [0:0]I1;
  wire O1;
  wire O2;
  wire O3;
  wire [6:0]O4;
  wire [6:0]Q;
  wire [6:0]RD_PNTR_WR;
  wire full;
  wire p_0_out;
  wire p_3_out;
  wire ram_full_i;
  wire rst_d2;
  wire wr_clk;
  wire wr_en;

adc_cdc_fifo_wr_status_flags_as \gwas.wsts 
       (.E(p_3_out),
        .O2(O2),
        .O3(O3),
        .Q(Q[6]),
        .full(full),
        .p_0_out(p_0_out),
        .ram_full_i(ram_full_i),
        .rst_d2(rst_d2),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
adc_cdc_fifo_wr_bin_cntr wpntr
       (.E(p_3_out),
        .I1(I1),
        .O1(O1),
        .O4(O4),
        .Q(Q),
        .RD_PNTR_WR(RD_PNTR_WR),
        .p_0_out(p_0_out),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "wr_status_flags_as" *) 
module adc_cdc_fifo_wr_status_flags_as
   (full,
    p_0_out,
    O2,
    O3,
    E,
    ram_full_i,
    wr_clk,
    rst_d2,
    wr_en,
    Q);
  output full;
  output p_0_out;
  output O2;
  output O3;
  output [0:0]E;
  input ram_full_i;
  input wr_clk;
  input rst_d2;
  input wr_en;
  input [0:0]Q;

  wire [0:0]E;
  wire O2;
  wire O3;
  wire [0:0]Q;
  wire full;
  wire p_0_out;
  wire ram_full_i;
  wire rst_d2;
  wire wr_clk;
  wire wr_en;

LUT3 #(
    .INIT(8'h04)) 
     RAM_reg_0_63_0_2_i_1
       (.I0(p_0_out),
        .I1(wr_en),
        .I2(Q),
        .O(O2));
LUT3 #(
    .INIT(8'h40)) 
     RAM_reg_64_127_0_2_i_1
       (.I0(p_0_out),
        .I1(wr_en),
        .I2(Q),
        .O(O3));
LUT2 #(
    .INIT(4'h2)) 
     \gic0.gc0.count_d1[6]_i_1 
       (.I0(wr_en),
        .I1(p_0_out),
        .O(E));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     ram_full_fb_i_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_full_i),
        .PRE(rst_d2),
        .Q(p_0_out));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     ram_full_i_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_full_i),
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
