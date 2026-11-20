from .dsp_block import DSPBlock
from utils.matlab_vec import parse_vector
from utils.sync_gen_period import sync_gen_period
from xps_frontend.sw_reg import sw_reg


class sync_gen(DSPBlock):
    # casper_library_misc sync_gen on casper_dsp's Misc/sync_gen.sv. The
    # Simulink block holds three software registers (From Processor, 32 bits)
    # whose values are sync.sv's sync / sync_period_sel / sync_period_var
    # inputs; they are added as sw_reg yellow blocks named <block>_sync,
    # <block>_sync_period_sel and <block>_sync_period_var (the Simulink
    # register names) by embedded_yellow_blocks below, so the Xcos block
    # only has sync_out.
    SRCS = [
        'casper_dsp/rtl/BasicModules/constant.sv',
        'casper_dsp/rtl/BasicModules/slice.v',
        'casper_dsp/rtl/Misc/edge_detect.v',
        'casper_dsp/rtl/BasicModules/multiplexer.sv',
        'casper_dsp/rtl/BasicModules/relational.sv',
        'casper_dsp/rtl/BasicModules/logical.sv',
        'casper_dsp/rtl/BasicModules/counter.sv',
        'casper_dsp/rtl/Misc/sync_gen.sv',
    ]
    # the registers: (sync_gen.sv port, register name suffix)
    REGS = [('sync', 'sync'), ('sync_period_sel', 'sync_period_sel'),
            ('sync_period_var', 'sync_period_var')]

    @classmethod
    def embedded_yellow_blocks(cls, blk):
        # as in the Simulink tut_spec build: From Processor, 32 bits, one
        # field 'reg', Unsigned, sim port on, show format on
        return {'yellow_blocks': [
            {'block': sw_reg.config('%s_%s' % (blk['name'], reg), 'From Processor', 32,
                             io_delay=0, init_val=0, sample_period=1, names='reg',
                             bin_pts=0, arith_types=0, sim_port='on', show_format='on'),
             'ports': [(port, 'user_data_out', 32, 'in')]}
            for port, reg in cls.REGS]}

    def initialize(self):
        for src in self.SRCS:
            self.add_source(src)

    def _int(self, key):
        val = float(getattr(self, key))
        if val != int(val):
            raise ValueError('sync_gen %s: %s = %s must be an integer' % (self.fullname, key, val))
        return int(val)

    def _reorder_vec(self):
        try:
            return parse_vector(self.reorder_vec)
        except ValueError as e:
            raise ValueError('sync_gen %s: reorder_vec: %s' % (self.fullname, e))

    def period(self):
        """(period, constant) -- sync_gen.sv's $fatal checks, with the block name."""
        reorder_vec = self._reorder_vec()
        try:
            return sync_gen_period(self._int('sim_acc_len'), self._int('fft_size'),
                                   self._int('fft_simult_inputs'), self._int('pfb_fir_taps'),
                                   reorder_vec, self._int('scale'))
        except ValueError as e:
            raise ValueError('sync_gen %s: %s' % (self.fullname, e))

    def modify_top(self, top):
        # let's populate the parent ports first (sync_out, and the three
        # register values from the embedded sw_reg blocks)
        self._populate_parent_ports(top)
        self.period()
        inst = top.get_instance(entity='sync_gen', name=self.fullname)
        # add parameters -- in sync_gen.sv's order; REORDER_VEC is packed
        # 32-bit elements, the first element in the MSBs
        inst.add_parameter('SIM_ACC_LEN', '%d' % self._int('sim_acc_len'))
        inst.add_parameter('FFT_SIZE', '%d' % self._int('fft_size'))
        inst.add_parameter('FFT_SIMULT_INPUTS', '%d' % self._int('fft_simult_inputs'))
        inst.add_parameter('PFB_FIR_TAPS', '%d' % self._int('pfb_fir_taps'))
        inst.add_parameter('REORDER_VEC', '{%s}' % ', '.join("32'd%d" % int(v) for v in self._reorder_vec()))
        inst.add_parameter('SCALE', '%d' % self._int('scale'))
        # add ports
        inst.add_port('clk', 'user_clk', dir='in')
        for port, _ in self.REGS:
            inst.add_port(port, self.fullname + '_' + port, parent_port=False, width=32, dir='in')
        inst.add_port('sync_out', self.fullname + '_sync_out', parent_port=False, width=1, dir='out')

    def generate_compile_order(self):
        fullpath = self.hdl_root + '/'
        co = {
            'lib': 'xil_defaultlib',
            'modules': [fullpath + src for src in self.SRCS],
            'fullpath': True
        }
        self.compile_order['verilog'].append(co)
