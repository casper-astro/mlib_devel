import os
from .dsp_block import DSPBlock
from verilog import VerilogModule


class cmac(DSPBlock):
    """casper_library cmac (Correlator) -> casper_dsp/rtl/Correlator/cmac.sv.

    The RTL ports map 1:1 onto the Xcos ports (a, b, acc_in, sync, valid_in /
    acc_out, valid_out; Simulink names 'a+bi'/'c+di' are labelled a/b because
    the label becomes a Verilog signal name), so the module is instantiated
    directly, no per-instance wrapper.

    Mask -> HDL parameter mapping: every mask param goes to the RTL param of
    the same name upper-cased; the popups map to the RTL integer encodings
    (cmac.sv / cmult.sv header). quantization/overflow/in_latency/
    conv_latency are greyed out in the Simulink mask and unused by the RTL
    (declared only), but are still passed for traceability.
    BIT_GROWTH / N_BITS_OUT / BIN_PT_OUT are derived inside cmac.sv and
    must not be overridden, so they are not passed.
    """
    QUANT_MAP = {
        'Truncate': 0,
        'Round  (unbiased: +/- Inf)': 1,
        'Round  (unbiased: Even Values)': 2,
    }
    # cmult.sv's OVERFLOW encoding only has 0 = Wrap, 1 = Saturate; 'Flag as
    # error' (a Simulink simulation-only mode) has no hardware meaning and
    # is mapped to Wrap. The field is greyed out and unused by cmac anyway.
    OVERFLOW_MAP = {'Wrap': 0, 'Saturate': 1, 'Flag as error': 0}
    MULT_IMP_MAP = {
        'behavioral HDL': 0,
        'standard core': 1,
        'embedded multiplier core': 2,
    }

    # casper_dsp RTL files cmac.sv depends on, leaves first (relative to
    # hdl_sources/casper_dsp)
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
    ]

    @staticmethod
    def _int(v):
        return int(float(v))

    def hdl_params(self):
        """Ordered (name, value) list of the RTL parameters."""
        return [
            ('ACC_LEN', self._int(self.acc_len)),
            ('N_BITS_A', self._int(self.n_bits_a)),
            ('BIN_PT_A', self._int(self.bin_pt_a)),
            ('N_BITS_B', self._int(self.n_bits_b)),
            ('BIN_PT_B', self._int(self.bin_pt_b)),
            ('QUANTIZATION', self.QUANT_MAP.get(str(self.quantization), 0)),
            ('OVERFLOW', self.OVERFLOW_MAP.get(str(self.overflow), 0)),
            ('MULT_LATENCY', self._int(self.mult_latency)),
            ('ADD_LATENCY', self._int(self.add_latency)),
            ('IN_LATENCY', self._int(self.in_latency)),
            ('CONV_LATENCY', self._int(self.conv_latency)),
            ('MULTIPLIER_IMPLEMENTATION',
             self.MULT_IMP_MAP.get(str(self.multiplier_implementation), 2)),
        ]

    def port_widths(self):
        """(inputs, outputs) as ordered (name, width) lists, same formulas as
        cmac.sv and scilab_blocks/casper_dsp/cmac.sci."""
        acc_len = self._int(self.acc_len)
        n_bits_a = self._int(self.n_bits_a)
        n_bits_b = self._int(self.n_bits_b)
        bit_growth = (acc_len - 1).bit_length()  # = ceil(log2(acc_len)) = $clog2
        n_bits_out = n_bits_a + n_bits_b + 1 + bit_growth
        ins = [('a', 2 * n_bits_a), ('b', 2 * n_bits_b), ('acc_in', 2 * n_bits_out),
               ('sync', 1), ('valid_in', 1)]
        outs = [('acc_out', 2 * n_bits_out), ('valid_out', 1)]
        return ins, outs

    def initialize(self):
        for f in self.RTL_FILES:
            self.add_source(os.path.join('casper_dsp', f))

    def modify_top(self, top):
        self._populate_parent_ports(top)
        inst = top.get_instance(entity='cmac', name=self.fullname)
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
