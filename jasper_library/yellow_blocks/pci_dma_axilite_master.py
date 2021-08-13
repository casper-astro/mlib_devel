from .yellow_block import YellowBlock
from verilog import VerilogModule, wrap_instance
from constraints import PortConstraint, ClockConstraint, RawConstraint, ClockGroupConstraint

import os
from os import environ as env

"""
Requires the following pins defined in an appropriate platform.yaml:
pcie_gty_rx_p (LOC only) # PCIe RX transceiver pins, p-side
pcie_gty_tx_p (LOC only) # PCIe TX transceiver pins, p-side
pcie_rst_n               # PCI connector active-low reset signal
pcie_refclk_p (LOC only) # PCI reference clock pin, p-side           

Requires the following config section:

pcie:
  loc: PCIE4C_X1Y0 # LOC of PCIE core (should be MCAP capable if using PCIe programming methods)
"""

class pci_dma_axilite_master(YellowBlock):
    def initialize(self):
        if not hasattr(self, 'use_pr'): self.use_pr = False
        if self.use_pr:
            if not hasattr(self, 'template_project') or self.template_project == None:
                self.template_project = os.path.join(os.getenv('MLIB_DEVEL_PATH'), 'jasper_library', 'template_projects', 'pcie', 'top_%s.xpr.zip' % self.platform.name)
        # Update the PCIe block location if the platform's config yaml specified one
        try:
            self.pcie_loc = self.platform.conf['pcie']['loc']
        except KeyError:
            self.pcie_loc = None

        if self.use_pr:
            self.pcie_loc = None
        else:
            # PCIe core is already in the static top-level
            if self.enable_wishbone:
                self.module_name = 'pci_axi_wb_master_wrapper'
                self.pci_ip_name = 'pci_axi_wb_master_xdma_0_0' 
                self.add_source('pci_dma_axilite_master/pci_axi_wb_master_wrapper.vhd')
                self.blkdiagram = 'pci_axi_wb_master.tcl'
                self.ips = [{'path':'%s/axi_wb_bridge/ip_repo' % env['HDL_ROOT'],
                     'name':'axi_slave_wishbone_classic_master',
                     'vendor':'peralex.com',
                     'library':'user',
                     'version':'1.0',
                    }]
            else:
                self.module_name = 'pci_dma_axilite_master'
                self.pci_ip_name = 'pci_dma_axilite_master'
                self.blkdiagram = None
                self.add_source('pci_dma_axilite_master/*.xci')
        self.add_source('utils/cdc_synchroniser.vhd')

    def modify_top(self,top):
        # If we're using partial reconfiguration, then the
        # PCIe code should be in a static top-level.
        # It should onlt be instantiated at the user's level if
        # we're not using PR.
        if self.use_pr:
            return
        inst = top.get_instance(entity=self.module_name, name=self.module_name+'_inst')

        inst.add_port('axi_aclk',   'axil_clk', parent_signal=False)
        top.add_signal('axil_clk', attributes={'keep': '"true"'}) # keep so we can use for constraints
        inst.add_port('axi_aresetn', 'axil_rst_n')
        # Create a non-inverted clock too. 
        top.add_signal('axil_rst')
        top.assign_signal('axil_rst', '~axil_rst_n')

        # AXI-Lite Master Interface
        inst.add_port('m_axil_araddr', 'M_AXI_araddr', width=32)
        inst.add_port('m_axil_arprot', 'M_AXI_arprot', width=3)
        inst.add_port('m_axil_arready', 'M_AXI_arready')
        inst.add_port('m_axil_arvalid', 'M_AXI_arvalid')
        inst.add_port('m_axil_awaddr', 'M_AXI_awaddr', width=32)
        inst.add_port('m_axil_awprot', 'M_AXI_awprot', width=3)
        inst.add_port('m_axil_awready', 'M_AXI_awready')
        inst.add_port('m_axil_awvalid', 'M_AXI_awvalid')
        inst.add_port('m_axil_bready', 'M_AXI_bready')
        inst.add_port('m_axil_bresp', 'M_AXI_bresp', width=2)
        inst.add_port('m_axil_bvalid', 'M_AXI_bvalid')
        inst.add_port('m_axil_rdata', 'M_AXI_rdata', width=32)
        inst.add_port('m_axil_rready', 'M_AXI_rready')
        inst.add_port('m_axil_rresp', 'M_AXI_rresp', width=2)
        inst.add_port('m_axil_rvalid', 'M_AXI_rvalid')
        inst.add_port('m_axil_wdata', 'M_AXI_wdata', width=32)
        inst.add_port('m_axil_wready', 'M_AXI_wready')
        inst.add_port('m_axil_wstrb', 'M_AXI_wstrb', width=4)
        inst.add_port('m_axil_wvalid', 'M_AXI_wvalid')

        if not self.enable_wishbone:
            # AXI MM Master interface. We don't use this so tie inputs
            # It might be better/easier to only use the MM interface
            # and convert it to AXI-Lite, since the MM interface always
            # exists in the IP, but the lite interface above is an option.
            inst.add_port('m_axi_arready', "1'b1")
            inst.add_port('m_axi_awready', "1'b1")
            inst.add_port('m_axi_bid',     "3'b0")
            inst.add_port('m_axi_bresp',   "2'b0")
            inst.add_port('m_axi_bvalid',  "1'b0")
            inst.add_port('m_axi_rdata',  "64'b0")
            inst.add_port('m_axi_rid',     "3'b0")
            inst.add_port('m_axi_rlast',   "1'b0")
            inst.add_port('m_axi_rresp',   "2'b0")
            inst.add_port('m_axi_rvalid',  "1'b0")
            inst.add_port('m_axi_wready',  "1'b1")
        else:
            # Wishbone ports
            inst.add_port('CYC_O', 'wbm_cyc_o')
            inst.add_port('STB_O', 'wbm_stb_o')
            inst.add_port('WE_O ', 'wbm_we_o ')
            inst.add_port('SEL_O', 'wbm_sel_o', width=4)
            inst.add_port('ADR_O', 'wbm_adr_o', width=32)
            inst.add_port('DAT_O', 'wbm_dat_o', width=32)
            inst.add_port('DAT_I', 'wbm_dat_i', width=32)
            inst.add_port('ACK_I', 'wbm_ack_i')
            inst.add_port('RST_O', 'wbm_rst_o')
            top.add_signal('wb_clk_i')
            top.add_signal('wb_rst_i')
            top.assign_signal('wb_clk_i', 'axil_clk')
            top.assign_signal('wb_rst_i', 'axil_rst')

        # External ports
        inst.add_port('pci_exp_rxp', self.fullname+'_rx_p', width=1, parent_port=True, dir='in')
        inst.add_port('pci_exp_rxn', self.fullname+'_rx_n', width=1, parent_port=True, dir='in')
        inst.add_port('pci_exp_txp', self.fullname+'_tx_p', width=1, parent_port=True, dir='out')
        inst.add_port('pci_exp_txn', self.fullname+'_tx_n', width=1, parent_port=True, dir='out')
        inst.add_port('sys_rst_n', 'pcie_rst_n', parent_port=True, dir='in')

        # Internal ports
        # US+: if sys_clk_gt is 250MHz, sys_clk should be 1/2 sys_clk_gt.
        inst.add_port('sys_clk', 'pcie_refclk_odiv2') # signal comes through IBUFDS_GTE4 (see below)
        inst.add_port('sys_clk_gt', 'pcie_refclk')   # signal comes through IBUFDS_GTE4 (see below)
        inst.add_port('usr_irq_req', '1\'b0')

        # Instantiate IBUFDS_GTE4 for the reference clock
        ibuf = top.get_instance(entity='IBUFDS_GTE4', name='pci_refclk_buf')
        ibuf.add_port('I', 'pcie_refclk_p', dir='in', parent_port=True)
        ibuf.add_port('IB', 'pcie_refclk_n', dir='in', parent_port=True)
        ibuf.add_port('CEB', '1\'b0')
        ibuf.add_port('O', 'pcie_refclk')
        ibuf.add_port('ODIV2', 'pcie_refclk_odiv2')

    def gen_constraints(self):
        cons = []
        if self.use_pr:
            cons.append(ClockGroupConstraint('-of_objects [get_ports sys_clk_p]', 'axil_clk', 'asynchronous'))
            cons.append(ClockGroupConstraint('-of_objects [get_nets user_clk]', 'axil_clk', 'asynchronous'))
            # The static top-level will already contain the below constraints.
            return cons
        cons.append(ClockGroupConstraint('-include_generated_clocks sys_clk_p_CLK', '-include_generated_clocks -of_objects [get_nets axil_clk]', 'asynchronous'))
        cons.append(ClockGroupConstraint('-include_generated_clocks -of_objects [get_nets user_clk]', '-include_generated_clocks -of_objects [get_nets axil_clk]', 'asynchronous'))
        cons.append(PortConstraint(self.fullname+'_rx_p', 'pcie_gty_rx_p', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint(self.fullname+'_tx_p', 'pcie_gty_tx_p', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('pcie_rst_n', 'pcie_rst_n'))
        cons.append(PortConstraint('pcie_refclk_p', 'pcie_refclk_p'))
        pcie_clkconst = ClockConstraint('pcie_refclk_p', freq=100.0)
        cons.append(pcie_clkconst)
        return cons

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        tcl_cmds['post_synth'] = []
        tcl_cmds['promgen'] = []

        if not self.use_pr:
            if self.blkdiagram is not None:
                tcl_cmds['pre_synth'] += ['source %s/pci_dma_axilite_master/%s' % (env['HDL_ROOT'], self.blkdiagram)]

        # Update the PCIe block location if the platform's config yaml specified one
        if self.pcie_loc is not None:
            tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.pcie_blk_locn {%s}] [get_ips %s]' % (self.pcie_loc, self.pci_ip_name)]


        if self.use_pr:
            tcl_cmds['pre_synth'] += ['set_property SCOPED_TO_REF {user_top} [get_files user_const.xdc]']
            tcl_cmds['pre_synth'] += ['set_property used_in_synthesis false [get_files -of_objects [get_reconfig_modules user_top-toolflow] user_const.xdc]']
            tcl_cmds['promgen'] += ['set_property CONFIG_MODE S_SELECTMAP32 [current_design]'] 
            #tcl_cmds['promgen'] += ['write_bitstream -force -cell user_top'] 
            tcl_cmds['promgen'] += ['write_cfgmem -force -format BIN -interface SMAPx32 -loadbit "up 0x00000000 $bit_file" $bin_file']
        return tcl_cmds

    def finalize_top(self, top):
        """
        If we are operating with Partial Reconfiguration, demote the entire user design to a submodule, allowing
        a static top-level to be used.
        """
        if not self.use_pr:
            return top

        # Expose AXI interface to the top level, and then wrap the entire
        # user design.
        top.add_port('axil_clk', 'axil_clk', parent_sig=False, dir='in')
        top.add_port('axil_rst_n', 'axil_clk', parent_sig=False, dir='in')
        top.add_port('M_AXI_araddr', 'M_AXI_araddr', width=32, parent_sig=False, dir='in')
        top.add_port('M_AXI_arready', 'M_AXI_arready', parent_sig=False, dir='out')
        top.add_port('M_AXI_arvalid', 'M_AXI_arvalid', parent_sig=False, dir='in')
        top.add_port('M_AXI_awaddr', 'M_AXI_awaddr', width=32, parent_sig=False, dir='in')
        top.add_port('M_AXI_awready', 'M_AXI_awready', parent_sig=False, dir='out')
        top.add_port('M_AXI_awvalid', 'M_AXI_awvalid', parent_sig=False, dir='in')
        top.add_port('M_AXI_bready', 'M_AXI_bready', parent_sig=False, dir='in')
        top.add_port('M_AXI_bresp', 'M_AXI_bresp', width=2, parent_sig=False, dir='out')
        top.add_port('M_AXI_bvalid', 'M_AXI_bvalid', parent_sig=False, dir='out')
        top.add_port('M_AXI_rdata', 'M_AXI_rdata', width=32, parent_sig=False, dir='out')
        top.add_port('M_AXI_rready', 'M_AXI_rready', parent_sig=False, dir='in')
        top.add_port('M_AXI_rresp', 'M_AXI_rresp', width=2, parent_sig=False, dir='out')
        top.add_port('M_AXI_rvalid', 'M_AXI_rvalid', parent_sig=False, dir='out')
        top.add_port('M_AXI_wdata', 'M_AXI_wdata', width=32, parent_sig=False, dir='in')
        top.add_port('M_AXI_wready', 'M_AXI_wready', parent_sig=False, dir='out')
        top.add_port('M_AXI_wstrb', 'M_AXI_wstrb', width=4, parent_sig=False, dir='in')
        top.add_port('M_AXI_wvalid', 'M_AXI_wvalid', parent_sig=False, dir='in')
        top.instantiate_child_ports()
        # With PR, we're not going to be using this module as top. Instead, let's
        # rename is `user_top` which will be instantiated within a high-level static top-level.
        # The assumpion is that the static top-level is already routed and included in a project and need
        # not be generated here.
        top.name = 'user_top'
        return top
            
