from .dsp_block import DSPBlock


class pulse_ext(DSPBlock):
    # casper_library_misc pulse_ext on casper_dsp's Misc/pulse_ext.sv, the
    # same module simple_bram_vacc uses, so a design only ever has one
    # pulse_ext module. As in Simulink: a rising edge on in starts a pulse of
    # length cycles (restarted by a new edge), and out is high for length
    # cycles after power-on.
    # Every module pulse_ext.sv instantiates, then pulse_ext.sv itself.
    SRCS = [
        'casper_dsp/rtl/Misc/edge_detect.v',
        'casper_dsp/rtl/BasicModules/constant.sv',
        'casper_dsp/rtl/BasicModules/counter.sv',
        'casper_dsp/rtl/BasicModules/relational.sv',
        'casper_dsp/rtl/Misc/pulse_ext.sv',
    ]

    def initialize(self):
        for src in self.SRCS:
            self.add_source(src)

    def _length(self):
        val = float(self.length)
        if val != int(val) or val < 1:
            raise ValueError('pulse_ext %s: length = %s must be a positive integer'
                             % (self.fullname, self.length))
        return int(val)

    def modify_top(self, top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        inst = top.get_instance(entity='pulse_ext', name=self.fullname)
        # add parameters
        inst.add_parameter('PULSE_LEN', '%d' % self._length())
        # add ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('in', self.fullname + '_in', parent_port=False, width=1, dir='in')
        inst.add_port('out', self.fullname + '_out', parent_port=False, width=1, dir='out')

    def generate_compile_order(self):
        fullpath = self.hdl_root + '/'
        co = {
            'lib': 'xil_defaultlib',
            'modules': [fullpath + src for src in self.SRCS],
            'fullpath': True
        }
        self.compile_order['verilog'].append(co)
