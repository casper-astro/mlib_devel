#  Simulation Model Generator
#  Xilinx EDK 7.1.2 EDK_H.12.5.1
#  Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
#
#  File     bfm_system.do (Wed Feb  1 12:54:49 2006)
#
vmap XilinxCoreLib /opt/Xilinx/iselib/XilinxCoreLib/
vmap XilinxCoreLib_ver /opt/Xilinx/iselib/XilinxCoreLib_ver/
vmap simprim /opt/Xilinx/iselib/simprim/
vmap simprims_ver /opt/Xilinx/iselib/simprims_ver/
vmap unisim /opt/Xilinx/iselib/unisim/
vmap unisims_ver /opt/Xilinx/iselib/unisims_ver/
vmap plb_bfm /opt/Xilinx/edklib/plb_bfm/
vmap plb_master_bfm_v1_00_a /opt/Xilinx/edklib/plb_master_bfm_v1_00_a/
vmap plb_monitor_bfm_v1_00_a /opt/Xilinx/edklib/plb_monitor_bfm_v1_00_a/
vmap bfm_synch_v1_00_a /opt/Xilinx/edklib/bfm_synch_v1_00_a/
vmap proc_common_v1_00_b /opt/Xilinx/edklib/proc_common_v1_00_b/
vmap plb_v34_v1_02_a /opt/Xilinx/edklib/plb_v34_v1_02_a/
vlib plb_ddr2_tb_v1_00_a
vmap plb_ddr2_tb_v1_00_a plb_ddr2_tb_v1_00_a
vlib work
vmap work work
vcom -93 -work plb_ddr2_tb_v1_00_a /home/alschult/BEE2_BSP/repository/pcores/plb_ddr2_v1_00_b/bfmsim/pcores/plb_ddr2_tb_v1_00_a/simhdl/vhdl/plb_ddr2_tb.vhd
vcom -93 -work work bfm_processor_wrapper.vhd
vcom -93 -work work bfm_monitor_wrapper.vhd
vcom -93 -work work synch_bus_wrapper.vhd
vcom -93 -work work plb_bus_wrapper.vhd
vcom -93 -work work plb_ddr2_wrapper.vhd
vcom -93 -work work bfm_system.vhd
