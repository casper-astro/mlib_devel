from .yellow_block import YellowBlock
from .axi4lite_interconnect import *

class axi4lite_buffer(YellowBlock):
    def initialize(self):
        self.name = 'axi4lite_buffer'
        self.requires.append('M_AXI')
        self.provides.append('M_AXI')

    def modify_top(self, top):
        axi_signals = {
            'awaddr': 32, 'awvalid': 1, 'awready': 1,
            'wdata': 32, 'wstrb': 4, 'wvalid': 1, 'wready': 1,
            'bresp': 2, 'bvalid': 1, 'bready': 1,
            'araddr': 32, 'arvalid': 1, 'arready': 1,
            'rdata': 32, 'rvalid': 1, 'rready': 1, 'rresp': 2
        }

        # Add internal signals for each AXI signal
        for sig, width in axi_signals.items():
            wire_name = f'm_axi_{sig}'
            top.add_signal(wire_name, width=width)

        # Instantiate the actual AXI interconnect
        inst = top.get_instance('axi4lite_interconnect', 'axi4lite_interconnect_inst')

        for sig, width in axi_signals.items():
            inst.add_port(f's_axi4lite_{sig}', f'm_axi_{sig}', dir='in' if 'valid' in sig or 'addr' in sig or 'data' in sig or 'strb' in sig or 'ready' in sig else 'out', width=width)

        # If your interconnect also needs clk/reset, add them here (optional)
        top.add_signal('axil_clk')
        top.add_signal('axil_rst_n')
        inst.add_port('axi4lite_aclk', 'axil_clk', dir='in')
        inst.add_port('axi4lite_aresetn', 'axil_rst_n', dir='in')
