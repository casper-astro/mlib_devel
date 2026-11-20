import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class adder_subtractor(DSPBlock):
    """One-lane casper bus_addsub on casper_dsp/rtl/Bus/adder_subtractor.sv:
    dout = convert(a + b) or convert(a - b), with optional misc (misci ->
    misco) and async (en -> dvalid) ports."""
    # GUI values (the exact option text, see block_guis/casper_dsp/adder_subtractor)
    # map onto adder_subtractor.sv's integer encodings
    OPMODE_MAP = {'Addition': 0, 'Subtraction': 1}
    TYPE_MAP = {'Unsigned': 0, 'Signed': 1}
    # QUANTIZATION=2 (round half to even) has no Simulink counterpart
    # (adder_subtractor.sv [[unsupported]]), so it is not offered
    QUANTIZATION_MAP = {'Truncate': 0, 'Round (unbiased: +/- Inf)': 1}
    # OVERFLOW=2 ('Flag as error') stops the Simulink simulation while the
    # HDL wraps (adder_subtractor.sv deviations), so it is not offered
    OVERFLOW_MAP = {'Wrap': 0, 'Saturate': 1}

    # instantiation closure of adder_subtractor.sv, in compile order
    # (convert -> register / pipeline -> delay_srl -> register; delay)
    SOURCES = [
        'casper_dsp/rtl/BasicModules/register.sv',
        'casper_dsp/rtl/BasicModules/delay.sv',
        'casper_dsp/rtl/Delays/delay_srl.sv',
        'casper_dsp/rtl/Delays/pipeline.sv',
        'casper_dsp/rtl/Bus/convert.sv',
        'casper_dsp/rtl/Bus/adder_subtractor.sv',
    ]

    def initialize(self):
        for src in self.SOURCES:
            self.add_source(src)

    @staticmethod
    def _enable_val(status):
        # checkbox status is saved as 'on'/'off' (see mask.py's _convert_status),
        # val_format_conv turns it into True/False
        return 1 if str(status).strip().lower() in ('on', '1', 'true') else 0

    @staticmethod
    def _lookup(table, val):
        # option text; whitespace-insensitive, as Xilinx spells
        # 'Round  (unbiased: +/- Inf)' with two spaces
        return table[' '.join(str(val).split())]

    def _int(self, key):
        # numeric fields reach us as int (or float / str from a hand-edited diagram)
        return int(float(getattr(self, key)))

    def modify_top(self, top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        module = 'adder_subtractor'
        inst = top.get_instance(entity=module, name=self.fullname)
        # parameters, in adder_subtractor.sv's declaration order; plain decimals
        inst.add_parameter("N_BITS_A", "%d" % self._int('n_bits_a'))
        inst.add_parameter("BIN_PT_A", "%d" % self._int('bin_pt_a'))
        inst.add_parameter("TYPE_A", "%d" % self._lookup(self.TYPE_MAP, self.type_a))
        inst.add_parameter("N_BITS_B", "%d" % self._int('n_bits_b'))
        inst.add_parameter("BIN_PT_B", "%d" % self._int('bin_pt_b'))
        inst.add_parameter("TYPE_B", "%d" % self._lookup(self.TYPE_MAP, self.type_b))
        inst.add_parameter("N_BITS_OUT", "%d" % self._int('n_bits_out'))
        inst.add_parameter("BIN_PT_OUT", "%d" % self._int('bin_pt_out'))
        inst.add_parameter("TYPE_OUT", "%d" % self._lookup(self.TYPE_MAP, self.type_out))
        inst.add_parameter("OPMODE", "%d" % self._lookup(self.OPMODE_MAP, self.opmode))
        inst.add_parameter("QUANTIZATION", "%d" % self._lookup(self.QUANTIZATION_MAP, self.quantization))
        inst.add_parameter("OVERFLOW", "%d" % self._lookup(self.OVERFLOW_MAP, self.overflow))
        inst.add_parameter("CSP_LATENCY", "%d" % self._int('csp_latency'))
        inst.add_parameter("ASYNC", "%d" % self._enable_val(self.async_op))
        inst.add_parameter("MISC", "%d" % self._enable_val(self.misc))
        inst.add_parameter("MISC_WIDTH", "%d" % self._misc_width())
        # ports -- names match adder_subtractor.sv exactly, the optional ones
        # follow adder_subtractor.sci's port lists (adder_subtractor_in_ports / adder_subtractor_out_ports).
        # misci and en have default values ('0 / 1'b1), so they are left
        # unconnected when their option is off; the RTL ignores them then.
        inst.add_port('clk', 'user_clk', dir='in')
        for name, width in self.in_ports():
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='in')
        for name, width in self.out_ports():
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='out')

    def _misc_width(self):
        # MISC_WIDTH only matters with misc on; keep the RTL default 1 otherwise
        return self._int('misc_width') if self._enable_val(self.misc) else 1

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order: the Simulink
        order a, b, misci (misc only), en (async only)."""
        ports = [('a', self._int('n_bits_a')), ('b', self._int('n_bits_b'))]
        if self._enable_val(self.misc):
            ports += [('misci', self._misc_width())]
        if self._enable_val(self.async_op):
            ports += [('en', 1)]
        return ports

    def out_ports(self):
        """(name, width) of the output ports, in Xcos port order: the Simulink
        order dout, misco (misc only), dvalid (async only)."""
        ports = [('dout', self._int('n_bits_out'))]
        if self._enable_val(self.misc):
            ports += [('misco', self._misc_width())]
        if self._enable_val(self.async_op):
            ports += [('dvalid', 1)]
        return ports

    def generate_compile_order(self):
        fullpath = self.hdl_root + '/'
        co = {
            'lib': 'xil_defaultlib',
            'modules': [fullpath + src for src in self.SOURCES],
            'fullpath': True
        }
        self.compile_order['verilog'].append(co)
