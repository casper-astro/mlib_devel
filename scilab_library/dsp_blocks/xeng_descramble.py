import os
from .dsp_block import DSPBlock


class xeng_descramble(DSPBlock):
    """casper_library Correlator/xeng_descramble -> casper_dsp
    rtl/Correlator/xeng_descramble.sv.

    The RTL ports map 1:1 onto the Xcos/Simulink ports (acc, valid, sync,
    win_valid -> acc_out, valid_out, sync_out; all plain packed vectors), so
    the RTL module is instantiated directly -- no per-instance wrapper.

    Mask parameters -> RTL parameters:
        num_ants     -> NUM_ANTS     (xeng_descramble only; 4ant hardcodes 4)
        n_bits       -> N_BITS
        acc_len      -> ACC_LEN
        demux_factor -> DEMUX_FACTOR
    Non-mask RTL parameters are left at their RTL defaults:
        RAM_LATENCY  (1 in xeng_descramble, as in the Simulink diagram;
                      xeng_descramble_4ant.sv fixes it to 2 internally)
        PLATFORM     ("GENERIC", inferred dual_port_ram; no toolflow hook to
                      select the vendor RAM yet -- same as fft/pfb ports)
        W, P, OW     (derived inside the RTL; must not be overridden, but are
                      recomputed here for the port widths)
    """
    RTL_MODULE = 'xeng_descramble'
    HAS_NUM_ANTS = True

    def initialize(self):
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        for relpath in self._rtl_relpaths(casper_dsp_root):
            self.add_source(os.path.join('casper_dsp', relpath))

    # casper_dsp RTL files xeng_descramble.sv depends on, leaves first (relative to
    # hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/BasicModules/delay.sv',
        'rtl/Delays/dual_port_ram.sv',
        'rtl/BasicModules/logical.sv',
        'rtl/BasicModules/register.sv',
        'rtl/Delays/delay_srl.sv',
        'rtl/Delays/pipeline.sv',
        'rtl/BasicModules/constant.sv',
        'rtl/BasicModules/counter.sv',
        'rtl/BasicModules/relational.sv',
        'rtl/Correlator/Internal/read_ctrl.sv',
        'rtl/Misc/edge_detect.v',
        'rtl/BasicModules/multiplexer.sv',
        'rtl/Bus/convert.sv',
        'rtl/Bus/negate.sv',
        'rtl/Misc/negedge_delay.sv',
        'rtl/Correlator/Internal/write_ctrl.sv',
        'rtl/Correlator/Internal/x_cast.sv',
        'rtl/Correlator/xeng_descramble.sv',
    ]

    @classmethod
    def _rtl_relpaths(cls, casper_dsp_root):
        missing = [f for f in cls.RTL_FILES if not os.path.isfile(os.path.join(casper_dsp_root, f))]
        if missing:
            raise FileNotFoundError('%s: missing casper_dsp sources: %s' % (cls.__name__, ', '.join(missing)))
        return list(cls.RTL_FILES)

    @staticmethod
    def _int(v):
        return int(float(v))

    @staticmethod
    def widths(n_bits, acc_len, demux_factor):
        """(acc width 8W, acc_out width OW), as derived in the RTL:
        W = 2*N_BITS + $clog2(ACC_LEN+1), P = 2^$clog2(W), OW = 8P/D."""
        w = 2 * n_bits + int(acc_len).bit_length()
        p = 1 << (w - 1).bit_length()
        return 8 * w, 8 * p // demux_factor

    def _rtl_params(self):
        params = []
        if self.HAS_NUM_ANTS:
            params.append(('NUM_ANTS', self._int(self.num_ants)))
        params += [
            ('N_BITS', self._int(self.n_bits)),
            ('ACC_LEN', self._int(self.acc_len)),
            ('DEMUX_FACTOR', self._int(self.demux_factor)),
        ]
        return params

    def modify_top(self, top):
        self._populate_parent_ports(top)
        acc_w, acc_out_w = self.widths(self._int(self.n_bits), self._int(self.acc_len),
                                       self._int(self.demux_factor))
        inst = top.get_instance(entity=self.RTL_MODULE, name=self.fullname)
        for name, val in self._rtl_params():
            inst.add_parameter(name, val)
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('acc', self.fullname + '_acc', parent_port=False, width=acc_w, dir='in')
        inst.add_port('valid', self.fullname + '_valid', parent_port=False, width=1, dir='in')
        inst.add_port('sync', self.fullname + '_sync', parent_port=False, width=1, dir='in')
        inst.add_port('win_valid', self.fullname + '_win_valid', parent_port=False, width=1, dir='in')
        inst.add_port('acc_out', self.fullname + '_acc_out', parent_port=False, width=acc_out_w, dir='out')
        inst.add_port('valid_out', self.fullname + '_valid_out', parent_port=False, width=1, dir='out')
        inst.add_port('sync_out', self.fullname + '_sync_out', parent_port=False, width=1, dir='out')

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
