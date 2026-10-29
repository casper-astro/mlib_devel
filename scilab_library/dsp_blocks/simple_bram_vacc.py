from .dsp_block import DSPBlock


class simple_bram_vacc(DSPBlock):
    # casper_library simple_bram_vacc on casper_dsp's
    # Accumulators/simple_bram_vacc.sv: pulse_ext(new_acc) -> valid, an adder
    # looped through a delay_bram of VEC_LEN - 2 (bram latency 2), so dout
    # shows the finished sums while valid is high.
    # din has its own type (N_BITS_IN, BIN_PT_IN, TYPE_IN), which Simulink
    # inherits from the input; Scilab has no type propagation, so it comes
    # from the arith_type_in / n_bits_in / bin_pt_in keys (the din port width
    # in simple_bram_vacc.sci is n_bits_in). PLATFORM is left at the RTL
    # default "GENERIC" (inferred RAM).
    # Every module simple_bram_vacc.sv instantiates, directly or not.
    SRCS = [
        'casper_dsp/rtl/BasicModules/constant.sv',
        'casper_dsp/rtl/BasicModules/counter.sv',
        'casper_dsp/rtl/BasicModules/relational.sv',
        'casper_dsp/rtl/BasicModules/multiplexer.sv',
        'casper_dsp/rtl/BasicModules/register.sv',
        'casper_dsp/rtl/BasicModules/delay.sv',
        'casper_dsp/rtl/Misc/edge_detect.v',
        'casper_dsp/rtl/Misc/pulse_ext.sv',
        'casper_dsp/rtl/Delays/delay_srl.sv',
        'casper_dsp/rtl/Delays/pipeline.sv',
        'casper_dsp/rtl/Delays/single_port_ram.sv',
        'casper_dsp/rtl/Delays/delay_bram.sv',
        'casper_dsp/rtl/Bus/convert.sv',
        'casper_dsp/rtl/Bus/adder_subtractor.sv',
        'casper_dsp/rtl/Accumulators/simple_bram_vacc.sv',
    ]
    # GUI popup text (the Simulink mask's options) -> ARITH_TYPE / TYPE_IN
    ARITH_TYPES = {'Unsigned': 0, 'Signed': 1}

    def initialize(self):
        for src in self.SRCS:
            self.add_source(src)

    def _type(self, key):
        val = getattr(self, key)
        if val not in self.ARITH_TYPES:
            raise ValueError('simple_bram_vacc %s: %s %r not supported (use one of %s)'
                             % (self.fullname, key, val, ', '.join(self.ARITH_TYPES)))
        return self.ARITH_TYPES[val]

    def _int(self, key):
        return int(float(getattr(self, key)))

    def params(self):
        """simple_bram_vacc.sv parameters (name, value), in declaration order;
        the RTL $fatal checks are repeated here so a bad value fails at
        generation time with the block's name."""
        vec_len, n_bits, bin_pt = self._int('vec_len'), self._int('n_bits'), self._int('bin_pt')
        n_bits_in, bin_pt_in = self._int('n_bits_in'), self._int('bin_pt_in')
        if vec_len < 6:
            raise ValueError('simple_bram_vacc %s: vec_len = %d must be greater than 5' % (self.fullname, vec_len))
        if n_bits < 1 or n_bits_in < 1:
            raise ValueError('simple_bram_vacc %s: n_bits / n_bits_in must be greater than 0' % self.fullname)
        if bin_pt > n_bits or bin_pt_in > n_bits_in:
            raise ValueError('simple_bram_vacc %s: a binary point cannot be greater than its bit width'
                             % self.fullname)
        for link in self.link_info:
            # the din link (Xcos input 2) must carry n_bits_in bits
            if link['dst_blk_name'] == self.unique_name and link['dst_port_id'] == 2 \
                    and int(link['dst_port_width']) != n_bits_in:
                raise ValueError('simple_bram_vacc %s: din link is %s bits wide, n_bits_in is %d'
                                 % (self.fullname, link['dst_port_width'], n_bits_in))
        return [('VEC_LEN', vec_len), ('ARITH_TYPE', self._type('arith_type')),
                ('N_BITS', n_bits), ('BIN_PT', bin_pt),
                ('N_BITS_IN', n_bits_in), ('BIN_PT_IN', bin_pt_in),
                ('TYPE_IN', self._type('arith_type_in'))]

    def modify_top(self, top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        inst = top.get_instance(entity='simple_bram_vacc', name=self.fullname)
        params = dict(self.params())
        for name, val in self.params():
            inst.add_parameter(name, '%d' % val)
        # ports -- simple_bram_vacc.sv / Simulink names
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('new_acc', self.fullname + '_new_acc', parent_port=False, width=1, dir='in')
        inst.add_port('din', self.fullname + '_din', parent_port=False, width=params['N_BITS_IN'], dir='in')
        inst.add_port('dout', self.fullname + '_dout', parent_port=False, width=params['N_BITS'], dir='out')
        inst.add_port('valid', self.fullname + '_valid', parent_port=False, width=1, dir='out')

    def generate_compile_order(self):
        fullpath = self.hdl_root + '/'
        co = {
            'lib': 'xil_defaultlib',
            'modules': [fullpath + src for src in self.SRCS],
            'fullpath': True
        }
        self.compile_order['verilog'].append(co)
