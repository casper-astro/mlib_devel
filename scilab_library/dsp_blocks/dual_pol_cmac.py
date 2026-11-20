import os
from .dsp_block import DSPBlock
from verilog import VerilogModule


class dual_pol_cmac(DSPBlock):
    """casper_library dual_pol_cmac (Correlator) ->
    casper_dsp/rtl/Correlator/dual_pol_cmac.sv.

    The RTL ports (a1, a2, acc_in, sync, valid_in / acc_out, valid_out) are
    exactly the Simulink/Xcos ports, so the module is instantiated directly,
    no per-instance wrapper.

    Mask -> HDL parameter mapping: every mask param goes to the RTL param of
    the same name upper-cased; multiplier_implementation maps to the RTL
    integer encoding. bin_pt_in is declared-only in the RTL (the mask does
    not pass it on), N_BITS_OUT is derived inside dual_pol_cmac.sv and must
    not be overridden, so it is not passed.
    """
    MULT_IMP_MAP = {
        'behavioral HDL': 0,
        'standard core': 1,
        'embedded multiplier core': 2,
    }

    # casper_dsp RTL files dual_pol_cmac.sv depends on, leaves first
    # (relative to hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/BasicModules/constant.sv',
        'rtl/BasicModules/counter.sv',
        'rtl/BasicModules/multiplexer.sv',
        'rtl/BasicModules/register.sv',
        'rtl/BasicModules/relational.sv',
        'rtl/Delays/delay_srl.sv',
        'rtl/Delays/pipeline.sv',
        'rtl/Bus/adder_subtractor.sv',
        'rtl/Bus/convert.sv',
        'rtl/Bus/multiplier.sv',
        'rtl/Misc/c_to_ri.v',
        'rtl/Misc/ri_to_c.v',
        'rtl/Multipliers/cmult.sv',
        'rtl/Correlator/Internal/cmac_acc.sv',
        'rtl/Correlator/cmac.sv',
        'rtl/Correlator/dual_pol_cmac.sv',
    ]

    @staticmethod
    def _int(v):
        return int(float(v))

    def hdl_params(self):
        """Ordered (name, value) list of the RTL parameters."""
        return [
            ('ACC_LEN', self._int(self.acc_len)),
            ('N_BITS_IN', self._int(self.n_bits_in)),
            ('BIN_PT_IN', self._int(self.bin_pt_in)),
            ('MULT_LATENCY', self._int(self.mult_latency)),
            ('ADD_LATENCY', self._int(self.add_latency)),
            ('MULTIPLIER_IMPLEMENTATION',
             self.MULT_IMP_MAP.get(str(self.multiplier_implementation), 2)),
        ]

    def port_widths(self):
        """(inputs, outputs) as ordered (name, width) lists, same formulas as
        dual_pol_cmac.sv and scilab_blocks/casper_dsp/dual_pol_cmac.sci."""
        acc_len = self._int(self.acc_len)
        n_bits_in = self._int(self.n_bits_in)
        bit_growth = (acc_len - 1).bit_length()  # = ceil(log2(acc_len)) = $clog2
        n_bits_out = 2 * n_bits_in + 1 + bit_growth
        ins = [('a1', 4 * n_bits_in), ('a2', 4 * n_bits_in), ('acc_in', 8 * n_bits_out),
               ('sync', 1), ('valid_in', 1)]
        outs = [('acc_out', 8 * n_bits_out), ('valid_out', 1)]
        return ins, outs

    def initialize(self):
        for f in self.RTL_FILES:
            self.add_source(os.path.join('casper_dsp', f))

    def modify_top(self, top):
        self._populate_parent_ports(top)
        inst = top.get_instance(entity='dual_pol_cmac', name=self.fullname)
        for name, value in self.hdl_params():
            inst.add_parameter(name, value)
        ins, outs = self.port_widths()
        inst.add_port('clk', 'user_clk', dir='in')
        for name, width in ins:
            inst.add_port(name, self.fullname + '_' + name, parent_port=False,
                          width=width, dir='in')
        for name, width in outs:
            inst.add_port(name, self.fullname + '_' + name, parent_port=False,
                          width=width, dir='out')

    def generate_compile_order(self):
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        co = {
            'lib': 'xil_defaultlib',
            'modules': [os.path.join(casper_dsp_root, f) for f in self.RTL_FILES],
            'fullpath': True,
        }
        self.compile_order['verilog'].append(co)
