from .yellow_block import YellowBlock


class axi4lite_buffer(YellowBlock):
    def initialize(self):
        self.name = 'axi4lite_buffer'
        self.requires.append('M_AXI')   # upstream interface
        self.provides.append('S_AXI')   # downstream output

    def modify_top(self, top):
        axi_signals = {
            'awaddr': 32, 'awvalid': 1, 'awready': 1,
            'wdata': 32, 'wstrb': 4, 'wvalid': 1, 'wready': 1,
            'bresp': 2, 'bvalid': 1, 'bready': 1,
            'araddr': 32, 'arvalid': 1, 'arready': 1,
            'rdata': 32, 'rvalid': 1, 'rready': 1, 'rresp': 2
        }

        for sig, width in axi_signals.items():
            m = f'M_AXI_{sig}'
            s = f'S_AXI_{sig}'
            top.add_signal(m, width=width)
            top.add_signal(s, width=width)
            top.assign_signal(s, m)  # passthrough connection
