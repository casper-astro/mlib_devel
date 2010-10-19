# Synplicity, Inc. constraint file
# /home/droz/plb_ddr2/synplify/ddr2_controller/ddr2_controller.sdc
# Written on Tue Aug 23 16:27:05 2005
# by Synplify Pro, Synplify Pro 8.1 Scope Editor

#
# Collections
#

#
# Clocks
#

#
# Clock to Clock
#

#
# Inputs/Outputs
#

#
# Registers
#

#
# Multicycle Path
#

#
# False Path
#

#
# Path Delay
#

#
# Attributes
#
define_global_attribute          syn_global_buffers {2}
!TCL! foreach i $DIMM_NUMS {
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay0_col0} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay0_col1} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay1_col0} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay1_col1} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay2_col0} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay2_col1} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay3_col0} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay3_col1} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay4_col0} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay4_col1} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay5_col0} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay5_col1} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay6_col0} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay6_col1} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay7_col0} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay7_col1} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay8_col0} syn_noclockbuf {1}
define_attribute          {cntrl_DIMM${i}.data_path0.data_read_controller0.dqs_delay8_col1} syn_noclockbuf {1}
!TCL! }
define_attribute          {v:work.ddr2_controller} syn_hier {hard}
define_global_attribute          syn_replicate {0}
define_attribute          {v:work.cal_div2} syn_hier {hard}
define_attribute          {v:work.cal_reg} syn_hier {hard}
define_attribute          {v:work.ddr2_dqbit} syn_hier {hard}
define_attribute          {v:work.ddr2_dqs_div} syn_hier {hard}
define_attribute          {v:work.ddr2_transfer_done} syn_hier {hard}
define_attribute          {v:work.dqs_delay} syn_hier {hard}
define_attribute          {v:work.LUT2} syn_hier {hard}
define_attribute          {v:work.LUT3} syn_hier {hard}
define_attribute          {v:work.LUT4Z0} syn_hier {hard}
define_attribute          {v:work.LUT4Z1} syn_hier {hard}
define_attribute          {v:work.LUT4Z2} syn_hier {hard}
define_attribute          {v:work.LUT4Z3} syn_hier {hard}
define_attribute          {v:work.RAM_8D} syn_hier {hard}
define_attribute          {v:work.cal_ctl} syn_hier {hard}
define_attribute          {v:work.cal_top} syn_hier {hard}
define_attribute          {v:work.clk_dcm} syn_hier {hard}
define_attribute          {v:work.data_path_72bit_rl} syn_hier {hard}
define_attribute          {v:work.data_path_iobs_72bit} syn_hier {hard}
define_attribute          {v:work.data_path_rst} syn_hier {hard}
define_attribute          {v:work.data_read_72bit_rl} syn_hier {hard}
define_attribute          {v:work.data_read_controller_72bit_rl} syn_hier {hard}
define_attribute          {v:work.data_write_72bit} syn_hier {hard}
define_attribute          {v:work.ddr2_dm_72bit} syn_hier {hard}
define_attribute          {v:work.ddr2_cntrl_72bit_rl} syn_hier {hard}
define_attribute          {v:work.dqs_delay} syn_hier {hard}
define_attribute          {v:work.infrastructure} syn_hier {hard}
define_attribute          {v:work.infrastructure_top} syn_hier {hard}
define_attribute          {v:work.infrastructure_iobs_72bit} syn_hier {hard}
define_attribute          {v:work.iobs_72bit} syn_hier {hard}
define_attribute          {v:work.mybufg} syn_hier {hard}
define_attribute          {v:work.ddr_dqs_iob} syn_hier {hard}
define_attribute          {v:work.ddr_dq_iob} syn_hier {hard}
define_global_attribute          syn_edif_bit_format {%n(%i)}
define_attribute          {v:work.controller_iobs} syn_hier {hard}
define_attribute          {v:work.controller} syn_hier {hard}

#
# I/O standards
#

#
# Compile Points
#

#
# Other Constraints
#
