from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint

"""
Requires the following pins defined in an appropriate platform.yaml:
pcie_gty_rx_p (LOC only) # PCIe RX transceiver pins, p-side
pcie_gty_tx_p (LOC only) # PCIe TX transceiver pins, p-side
"""

class pci_dma_axilite_master(YellowBlock):
    def initialize(self):
        self.add_source('pci_dma_axilite_master/*.xci')

    def modify_top(self,top):
        module = 'pci_dma_axilite_master'
        inst = top.get_instance(entity=module, name=module+'_inst')

        inst.add_port('axi_aclk',   'axil_clk')
        inst.add_port('axil_aresetn', 'axil_rst_n')
        # Create a non-inverted clock too. 
        top.add_signal('axil_rst')
        top.assign_signal('axil_rst', '~axil_rst_n')

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

        # External ports
        inst.add_port('pci_exp_rxp', self.fullname+'_rx_p', width=1, parent_port=True, dir='in')
        inst.add_port('pci_exp_rxn', self.fullname+'_rx_n', width=1, parent_port=True, dir='in')
        inst.add_port('pci_exp_txp', self.fullname+'_tx_p', width=1, parent_port=True, dir='out')
        inst.add_port('pci_exp_txn', self.fullname+'_tx_n', width=1, parent_port=True, dir='out')

        # Internal ports
        inst.add_port('sys_clk', 'sys_clk')
        inst.add_port('sys_clk_gt', 'sys_clk')
        inst.add_port('sys_rst_n', '~sys_rst')
        inst.add_port('usr_irw_req', '1\'b0')

    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint(self.fullname+'_rx_p', 'pcie_gty_rx_p', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint(self.fullname+'_tx_p', 'pcie_gty_tx_p', port_index=[0], iogroup_index=[0]))

        return cons

        
