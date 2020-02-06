from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint

"""
Requires the following pins defined in an appropriate platform.yaml:
pcie_gty_rx_p (LOC only) # PCIe RX transceiver pins, p-side
pcie_gty_tx_p (LOC only) # PCIe TX transceiver pins, p-side
pcie_rst_n               # PCI connector active-low reset signal
pcie_refclk_p (LOC only) # PCI reference clock pin, p-side           
"""

class pci_dma_axilite_master(YellowBlock):
    def initialize(self):
        self.add_source('pci_dma_axilite_master/*.xci')
        self.add_source('utils/cdc_synchroniser.vhd')
        self.module_name = 'pci_dma_axilite_master'

    def modify_top(self,top):
        inst = top.get_instance(entity=self.module_name, name=self.module_name+'_inst')

        inst.add_port('axi_aclk',   'axil_clk')
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

        # External ports
        inst.add_port('pci_exp_rxp', self.fullname+'_rx_p', width=1, parent_port=True, dir='in')
        inst.add_port('pci_exp_rxn', self.fullname+'_rx_n', width=1, parent_port=True, dir='in')
        inst.add_port('pci_exp_txp', self.fullname+'_tx_p', width=1, parent_port=True, dir='out')
        inst.add_port('pci_exp_txn', self.fullname+'_tx_n', width=1, parent_port=True, dir='out')
        inst.add_port('sys_rst_n', 'pcie_rst_n', parent_port=True, dir='in')

        # Internal ports
        inst.add_port('sys_clk', 'pcie_refclk_div2') # signal comes through IBUFDS_GTE4 (see below)
        inst.add_port('sys_clk_gt', 'pcie_refclk')   # signal comes through IBUFDS_GTE4 (see below)
        inst.add_port('usr_irq_req', '1\'b0')

        # Instantiate IBUFDS_GTE4 for the reference clock
        ibuf = top.get_instance(entity='IBUFDS_GTE4', name='pci_refclk_buf')
        ibuf.add_port('I', 'pcie_refclk_p', dir='in', parent_port=True)
        ibuf.add_port('IB', 'pcie_refclk_n', dir='in', parent_port=True)
        ibuf.add_port('CEB', '1\'b0')
        ibuf.add_port('O', 'pcie_refclk')
        ibuf.add_port('ODIV2', 'pcie_refclk_div2')

    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint(self.fullname+'_rx_p', 'pcie_gty_rx_p', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint(self.fullname+'_tx_p', 'pcie_gty_tx_p', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('pcie_rst_n', 'pcie_rst_n'))
        cons.append(PortConstraint('pcie_refclk_p', 'pcie_refclk_p'))

        clkconst = ClockConstraint('pcie_refclk_p', freq=100.0)
        cons.append(clkconst)

        ## Make AXI clock asynchronous to the user clock
        cons.append(RawConstraint('set_clock_groups -name asyncclocks_pcie_usr_clk -asynchronous -group [get_clocks -include_generated_clocks -of_objects [get_nets user_clk]] -group [get_clocks -include_generated_clocks axil_clk]'))

        return cons

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        # Update the PCIe block location if the platform's config yaml specified one
        try:
            pcie_loc = self.platform.conf['pcie']['loc']
            tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.pcie_blk_locn {%s}] [get_ips %s]' % (pcie_loc, self.module_name)]
        except KeyError:
            pass
        return tcl_cmds
