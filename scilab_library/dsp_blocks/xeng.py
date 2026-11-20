import os
from .dsp_block import DSPBlock


class xeng(DSPBlock):
    """
    casper_library Correlator/xeng -> casper_dsp/rtl/Correlator/xeng.sv.

    Every xeng.sv port is a scalar or a packed vector that maps 1:1 onto one
    Xcos port (sync_in, ant, window_valid, mcnt_in / sync_out, acc, valid,
    mcnt_out), so xeng is instantiated directly -- no per-instance wrapper
    (unlike fft_wideband_real / pfb_fir_real, whose ports are arrays).

    Parameter mapping (mask variable -> RTL parameter):
      n_ants -> N_ANTS, n_bits -> N_BITS, acc_len -> ACC_LEN,
      demux_factor (popup '1'/'2'/'4'/'8') -> DEMUX_FACTOR (same integer),
      add_latency -> ADD_LATENCY, mult_latency -> MULT_LATENCY,
      bram_latency -> BRAM_LATENCY, use_ded_mult -> USE_DED_MULT,
      use_bram_delay -> USE_BRAM_DELAY.
    Non-mask parameters:
      MCNT_BITS -- width of mcnt_in/mcnt_out. Simulink inherits it from the
                   mcnt_in driver; here it is taken from the width of the
                   link into mcnt_in (port 4) in jasper.json, else of the link
                   out of mcnt_out (port 4), else the RTL default 32. (The
                   .sci declares 32 for both ports, and the toolflow rejects
                   links whose two ends differ, so in practice this is 32.)
      PLATFORM  -- left at the RTL default "GENERIC" (inferred RAMs).
      N_BITS_OUT / W / OW -- derived inside the RTL, never overridden.
    """

    MCNT_PORT_ID = 4
    DEFAULT_MCNT_BITS = 32

    @staticmethod
    def _int(v):
        return int(float(v))

    # casper_dsp RTL files xeng.sv depends on, leaves first (relative to
    # hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/BasicModules/counter.sv',
        'rtl/BasicModules/delay.sv',
        'rtl/Delays/single_port_ram.sv',
        'rtl/Delays/delay_bram.sv',
        'rtl/BasicModules/register.sv',
        'rtl/Delays/delay_srl.sv',
        'rtl/Misc/c_to_ri.v',
        'rtl/BasicModules/multiplexer.sv',
        'rtl/Correlator/Internal/cmac_acc.sv',
        'rtl/Delays/pipeline.sv',
        'rtl/Bus/convert.sv',
        'rtl/Bus/adder_subtractor.sv',
        'rtl/Bus/multiplier.sv',
        'rtl/Multipliers/cmult.sv',
        'rtl/BasicModules/constant.sv',
        'rtl/BasicModules/relational.sv',
        'rtl/Misc/ri_to_c.v',
        'rtl/Correlator/cmac.sv',
        'rtl/Correlator/dual_pol_cmac.sv',
        'rtl/Delays/sync_delay.sv',
        'rtl/Correlator/auto_tap.sv',
        'rtl/Correlator/baseline_tap.sv',
        'rtl/BasicModules/logical.sv',
        'rtl/Misc/sample_and_hold.sv',
        'rtl/Misc/edge_detect.v',
        'rtl/Delays/window_delay.sv',
        'rtl/Delays/dual_port_ram.sv',
        'rtl/Correlator/Internal/read_ctrl.sv',
        'rtl/Bus/negate.sv',
        'rtl/Misc/negedge_delay.sv',
        'rtl/Correlator/Internal/write_ctrl.sv',
        'rtl/Correlator/Internal/x_cast.sv',
        'rtl/Correlator/xeng_descramble.sv',
        'rtl/Correlator/xeng_descramble_4ant.sv',
        'rtl/Correlator/xeng.sv',
    ]

    @classmethod
    def _rtl_relpaths(cls, casper_dsp_root):
        missing = [f for f in cls.RTL_FILES if not os.path.isfile(os.path.join(casper_dsp_root, f))]
        if missing:
            raise FileNotFoundError('%s: missing casper_dsp sources: %s' % (cls.__name__, ', '.join(missing)))
        return list(cls.RTL_FILES)

    def _mcnt_bits(self):
        for link in self.link_info:
            if link.get('dst_blk_name') == self.unique_name and \
                    self._int(link.get('dst_port_id', 0)) == self.MCNT_PORT_ID:
                return self._int(link['src_port_width'])
        for link in self.link_info:
            if link.get('src_blk_name') == self.unique_name and \
                    self._int(link.get('src_port_id', 0)) == self.MCNT_PORT_ID:
                return self._int(link['dst_port_width'])
        return self.DEFAULT_MCNT_BITS

    def _derive(self):
        self.p_n_ants = self._int(self.n_ants)
        self.p_n_bits = self._int(self.n_bits)
        self.p_acc_len = self._int(self.acc_len)
        self.p_demux_factor = self._int(self.demux_factor)
        # W = 2*N_BITS + $clog2(ACC_LEN+1); OW = 8 * 2^$clog2(W) / DEMUX_FACTOR
        w = 2 * self.p_n_bits + self.p_acc_len.bit_length()
        self.acc_width = 8 * (1 << (w - 1).bit_length()) // self.p_demux_factor
        self.ant_width = 4 * self.p_n_bits
        self.mcnt_bits = self._mcnt_bits()

    def initialize(self):
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        for relpath in self._rtl_relpaths(casper_dsp_root):
            self.add_source(os.path.join('casper_dsp', relpath))
        self._derive()

    def modify_top(self, top):
        self._populate_parent_ports(top)
        inst = top.get_instance(entity='xeng', name=self.fullname)
        inst.add_parameter('N_ANTS', self.p_n_ants)
        inst.add_parameter('N_BITS', self.p_n_bits)
        inst.add_parameter('ACC_LEN', self.p_acc_len)
        inst.add_parameter('DEMUX_FACTOR', self.p_demux_factor)
        inst.add_parameter('ADD_LATENCY', self._int(self.add_latency))
        inst.add_parameter('MULT_LATENCY', self._int(self.mult_latency))
        inst.add_parameter('BRAM_LATENCY', self._int(self.bram_latency))
        inst.add_parameter('USE_DED_MULT', self._int(self.use_ded_mult))
        inst.add_parameter('USE_BRAM_DELAY', self._int(self.use_bram_delay))
        inst.add_parameter('MCNT_BITS', self.mcnt_bits)

        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('sync_in', self.fullname + '_sync_in', parent_port=False, width=1, dir='in')
        inst.add_port('ant', self.fullname + '_ant', parent_port=False, width=self.ant_width, dir='in')
        inst.add_port('window_valid', self.fullname + '_window_valid', parent_port=False, width=1, dir='in')
        inst.add_port('mcnt_in', self.fullname + '_mcnt_in', parent_port=False, width=self.mcnt_bits, dir='in')
        inst.add_port('sync_out', self.fullname + '_sync_out', parent_port=False, width=1, dir='out')
        inst.add_port('acc', self.fullname + '_acc', parent_port=False, width=self.acc_width, dir='out')
        inst.add_port('valid', self.fullname + '_valid', parent_port=False, width=1, dir='out')
        inst.add_port('mcnt_out', self.fullname + '_mcnt_out', parent_port=False, width=self.mcnt_bits, dir='out')

    def generate_compile_order(self):
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        modules = [os.path.join(casper_dsp_root, relpath)
                   for relpath in self._rtl_relpaths(casper_dsp_root)]
        co = {
            'lib': 'xil_defaultlib',
            'modules': modules,
            'fullpath': True,
        }
        self.compile_order['verilog'].append(co)
