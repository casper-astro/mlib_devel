from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint

"""
JTAG AXI Light Master Controller.
This module allows you to get an AXI command and control memory mapped interface to the Simulink model file register, snap blocks and peripherals.
The control interface is via a Vivado hardware manager tcl session.

tcl steps for model file with two registers "sw_reg_in" connected to "sw_reg_out":

Step 1 - issue reset to AXI Light bus: 
reset_hw_axi [get_hw_axis hw_axi_1]

Step 2 - create write request to write 0x12345678 to simulink register "sw_reg_in" at the memory offset in the fpg file of 0x10000020:
create_hw_axi_txn sw_reg_in [get_hw_axis hw_axi_1] -type WRITE -address 10000020 -len 1 -data {12345678}

Step 3 - issue write request: 
run_hw_axi [get_hw_axi_txns sw_reg_in]

Step 4 - create read request from simulink register "sw_reg_out" at the memory offset in the fpg file of 0x10000024:
create_hw_axi_txn sw_reg_out [get_hw_axis hw_axi_1] -type READ -address 10000024 -len 1 -force

Step 5 - issue read request: 
run_hw_axi [get_hw_axi_txns sw_reg_out]

No yaml pins required.
"""

class jtag_axil_master(YellowBlock):
    def initialize(self):
        self.add_source('jtag_axil_master/*.xci')
        self.add_source('utils/cdc_synchroniser.vhd')
        self.module_name = 'jtag_axil_master'

    def modify_top(self,top):
        inst = top.get_instance(entity=self.module_name, name=self.module_name+'_inst')

        # Design must provide clock and reset for JTAG AXI Master - in this case we just connect it to the simulink clock and reset
        inst.add_port('aclk',   'axil_clk')
        inst.add_port('aresetn', 'axil_rst_n')

        # Top level expects AXI Light Master to provide the AXI clock and reset, so just connect the input sys_clk & rst to the output AXI Light clock & rst.
        top.add_signal('axil_clk')
        top.assign_signal('axil_clk', 'sys_clk')
        top.add_signal('axil_rst')
        top.assign_signal('axil_rst', 'sys_rst')
        top.add_signal('axil_rst_n')
        top.assign_signal('axil_rst_n', '~sys_rst')
        

        # AXI-Lite Master Interface
        inst.add_port('m_axi_araddr', 'M_AXI_araddr', width=32)
        inst.add_port('m_axi_arprot', 'M_AXI_arprot', width=3)
        inst.add_port('m_axi_arready', 'M_AXI_arready')
        inst.add_port('m_axi_arvalid', 'M_AXI_arvalid')
        inst.add_port('m_axi_awaddr', 'M_AXI_awaddr', width=32)
        inst.add_port('m_axi_awprot', 'M_AXI_awprot', width=3)
        inst.add_port('m_axi_awready', 'M_AXI_awready')
        inst.add_port('m_axi_awvalid', 'M_AXI_awvalid')
        inst.add_port('m_axi_bready', 'M_AXI_bready')
        inst.add_port('m_axi_bresp', 'M_AXI_bresp', width=2)
        inst.add_port('m_axi_bvalid', 'M_AXI_bvalid')
        inst.add_port('m_axi_rdata', 'M_AXI_rdata', width=32)
        inst.add_port('m_axi_rready', 'M_AXI_rready')
        inst.add_port('m_axi_rresp', 'M_AXI_rresp', width=2)
        inst.add_port('m_axi_rvalid', 'M_AXI_rvalid')
        inst.add_port('m_axi_wdata', 'M_AXI_wdata', width=32)
        inst.add_port('m_axi_wready', 'M_AXI_wready')
        inst.add_port('m_axi_wstrb', 'M_AXI_wstrb', width=4)
        inst.add_port('m_axi_wvalid', 'M_AXI_wvalid')