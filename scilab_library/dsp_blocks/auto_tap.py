import os
from .dsp_block import DSPBlock
from verilog import VerilogModule


class auto_tap(DSPBlock):
    """casper_library auto_tap (Correlator) ->
    casper_dsp/rtl/Correlator/auto_tap.sv.

    The RTL ports are exactly the Simulink/Xcos ports, one flat vector each
    (a_del, a_ndel, a_loop, acc_in, valid_in, sync_in / a_del_out,
    a_ndel_out, a_end_out, acc_out, valid_out, rst_out, sync_out), so the
    module is instantiated directly, no per-instance wrapper.

    Mask -> HDL parameter mapping: every mask param goes to the RTL param of
    the same name upper-cased, as the plain integer the mask holds (the
    mask's mult_type / use_bram_delay are already the integer encodings the
    RTL uses: MULT_TYPE 0/1/2 = behavioural HDL / embedded / core, mapped to
    dual_pol_cmac's encoding inside the RTL; USE_BRAM_DELAY != 0 = BRAM).
    N_SIMULTAN is passed although the RTL only declares it (it is disabled
    on the mask and never read by auto_tap_init.m).
    Not passed: N_BITS_OUT (derived inside the RTL, $fatal if overridden)
    and PLATFORM (left at the RTL default "GENERIC", i.e. inferred RAM for
    delay_bram; there is no toolflow hook for the target family yet -- the
    same choice as xeng / xeng_descramble).
    """
    RTL_MODULE = 'auto_tap'

    # mask key -> RTL parameter name, in RTL parameter order
    PARAMS = [
        ('n_ants', 'N_ANTS'),
        ('n_simultan', 'N_SIMULTAN'),
        ('n_bits', 'N_BITS'),
        ('acc_len', 'ACC_LEN'),
        ('add_latency', 'ADD_LATENCY'),
        ('mult_latency', 'MULT_LATENCY'),
        ('bram_latency', 'BRAM_LATENCY'),
        ('mult_type', 'MULT_TYPE'),
        ('use_bram_delay', 'USE_BRAM_DELAY'),
    ]

    # Xcos/Simulink port names in port order; 'a' = 4*n_bits,
    # 'acc' = 8*n_bits_out, '1' = 1 bit
    INPUTS = [('a_del', 'a'), ('a_ndel', 'a'), ('a_loop', 'a'), ('acc_in', 'acc'),
              ('valid_in', '1'), ('sync_in', '1')]
    OUTPUTS = [('a_del_out', 'a'), ('a_ndel_out', 'a'), ('a_end_out', 'a'), ('acc_out', 'acc'),
               ('valid_out', '1'), ('rst_out', '1'), ('sync_out', '1')]

    # casper_dsp RTL files the tap depends on, leaves first
    # (relative to hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/BasicModules/constant.sv',
        'rtl/BasicModules/counter.sv',
        'rtl/BasicModules/delay.sv',
        'rtl/BasicModules/multiplexer.sv',
        'rtl/BasicModules/register.sv',
        'rtl/BasicModules/relational.sv',
        'rtl/Delays/delay_srl.sv',
        'rtl/Delays/pipeline.sv',
        'rtl/Delays/single_port_ram.sv',
        'rtl/Delays/delay_bram.sv',
        'rtl/Delays/sync_delay.sv',
        'rtl/Bus/adder_subtractor.sv',
        'rtl/Bus/convert.sv',
        'rtl/Bus/multiplier.sv',
        'rtl/Misc/c_to_ri.v',
        'rtl/Misc/ri_to_c.v',
        'rtl/Multipliers/cmult.sv',
        'rtl/Correlator/Internal/cmac_acc.sv',
        'rtl/Correlator/cmac.sv',
        'rtl/Correlator/dual_pol_cmac.sv',
        'rtl/Correlator/auto_tap.sv',
    ]

    @staticmethod
    def _int(v):
        return int(float(v))

    def hdl_params(self):
        """Ordered (name, value) list of the RTL parameters."""
        return [(rtl, self._int(getattr(self, key))) for key, rtl in self.PARAMS]

    def port_widths(self):
        """(inputs, outputs) as ordered (name, width) lists -- same formulas
        as the RTL and scilab_blocks/casper_dsp/<module>.sci:
        a_* = 4*n_bits, acc_* = 8*n_bits_out,
        n_bits_out = 2*n_bits + 1 + ceil(log2(acc_len))."""
        n_bits = self._int(self.n_bits)
        acc_len = self._int(self.acc_len)
        n_bits_out = 2 * n_bits + 1 + (acc_len - 1).bit_length()  # $clog2
        w = {'a': 4 * n_bits, 'acc': 8 * n_bits_out, '1': 1}
        return ([(n, w[k]) for n, k in self.INPUTS],
                [(n, w[k]) for n, k in self.OUTPUTS])

    def initialize(self):
        for f in self.RTL_FILES:
            self.add_source(os.path.join('casper_dsp', f))

    def modify_top(self, top):
        self._populate_parent_ports(top)
        inst = top.get_instance(entity=self.RTL_MODULE, name=self.fullname)
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
