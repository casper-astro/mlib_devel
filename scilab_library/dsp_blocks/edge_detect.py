from .dsp_block import DSPBlock


class edge_detect(DSPBlock):
    # casper_library_misc edge_detect on casper_dsp's Misc/edge_detect.v, the
    # same module snapshot / sync_gen / simple_bram_vacc / xeng use, so a
    # design only ever has one edge_detect module. The Xcos ports keep the
    # Simulink names in / out; edge_detect.v calls them din / dout.
    SRC = 'casper_dsp/rtl/Misc/edge_detect.v'
    # mask option text -> edge_detect.v parameter value
    EDGE = {'rising': 0, 'falling': 1, 'both': 2}
    POLARITY = {'active high': 0, 'active low': 1}

    def initialize(self):
        self.add_source(self.SRC)

    def _param(self, key, table):
        val = str(getattr(self, key)).strip().lower()
        if val not in table:
            raise ValueError('edge_detect %s: %s = %r must be one of %s'
                             % (self.fullname, key, getattr(self, key), ', '.join(table)))
        return table[val]

    def modify_top(self, top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        inst = top.get_instance(entity='edge_detect', name=self.fullname)
        # add parameters
        inst.add_parameter('EDGE', '%d' % self._param('edge_type', self.EDGE))
        inst.add_parameter('POLARITY', '%d' % self._param('polarity', self.POLARITY))
        # add ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('din', self.fullname + '_in', parent_port=False, width=1, dir='in')
        inst.add_port('dout', self.fullname + '_out', parent_port=False, width=1, dir='out')

    def generate_compile_order(self):
        fullpath = self.hdl_root + '/'
        co = {
            'lib': 'xil_defaultlib',
            'modules': [fullpath + self.SRC],
            'fullpath': True
        }
        self.compile_order['verilog'].append(co)
