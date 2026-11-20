import sys
from fractions import Fraction
from .dsp_block import DSPBlock
from verilog import VerilogModule

class register(DSPBlock):
    # Xilinx Register block on casper_dsp's BasicModules/register.sv. Simulink
    # converts the real 'init' to the type of d with Round (half away from
    # zero) and Saturate, so that is done here from the type of d (n_bits,
    # arith_type, bin_pt -- Simulink inherits it from d) and the resulting
    # raw bit pattern is passed as INIT_VAL (register.sv's mapping notes).
    SRC = 'casper_dsp/rtl/BasicModules/register.sv'
    ARITH_TYPES = ("Signed (2's comp)", 'Unsigned')

    def initialize(self):
        self.add_source(self.SRC)

    @staticmethod
    def _enable_val(status):
        # checkbox status is saved as 'on'/'off' (val_format_conv turns them
        # into True/False)
        return 1 if str(status).strip().lower() in ('on', '1', 'true') else 0

    def _signed(self):
        if self.arith_type not in self.ARITH_TYPES:
            raise ValueError('register %s: arith_type %r not supported (use one of %s)'
                             % (self.fullname, self.arith_type, ', '.join(self.ARITH_TYPES)))
        return self.arith_type == self.ARITH_TYPES[0]

    def _n_bits(self):
        n_bits = int(float(self.n_bits))
        if n_bits < 1:
            raise ValueError('register %s: n_bits = %d must be >= 1' % (self.fullname, n_bits))
        return n_bits

    def _bin_pt(self):
        bin_pt = int(float(self.bin_pt))
        if not 0 <= bin_pt <= self._n_bits():
            raise ValueError('register %s: bin_pt = %d must be in 0..n_bits'
                             % (self.fullname, bin_pt))
        return bin_pt

    @staticmethod
    def quantize(init, signed, n_bits, bin_pt):
        """Integer value of `init` in {signed, n_bits, bin_pt}: init * 2^bin_pt
        rounded half away from zero (Xilinx Round) and saturated to the range
        of the type (Xilinx Saturate). `init` is taken as a double, as in
        Simulink; the arithmetic is exact (Fraction)."""
        x = Fraction(float(init)) * (Fraction(2) ** bin_pt)
        mag = abs(x)
        q = int(mag)  # floor of |x|
        if mag - q >= Fraction(1, 2):
            q += 1
        q = -q if x < 0 else q
        lo, hi = (-(1 << (n_bits - 1)), (1 << (n_bits - 1)) - 1) if signed else (0, (1 << n_bits) - 1)
        return min(max(q, lo), hi)

    def init_val(self):
        """INIT_VAL for register.sv: the n_bits raw bit pattern of the
        quantized init, as a non-negative integer."""
        n_bits = self._n_bits()
        q = self.quantize(self.init, self._signed(), n_bits, self._bin_pt())
        return q & ((1 << n_bits) - 1)

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'register'
        inst = top.get_instance(entity=module, name=self.fullname)
        n_bits = self._n_bits()
        # add parameters -- in register.sv's order. Its parameters are
        # untyped, so INIT_VAL is passed as a sized unsigned literal
        # (n_bits'd...): a plain decimal would be a 32-bit integer and lose
        # the upper bits of a wider pattern.
        inst.add_parameter("BITWIDTH", "%d" % n_bits)
        inst.add_parameter("USE_RST", "%d" % self._enable_val(self.rst))
        inst.add_parameter("USE_ENABLE", "%d" % self._enable_val(self.en))
        inst.add_parameter("INIT_VAL", "%d'd%d" % (n_bits, self.init_val()))
        # add ports -- names match register.sv's port list; the optional ones
        # follow register.sci's port list (register_in_ports). register.sv's
        # rst / en have no default value: tie them off when their option is
        # off (the RTL ignores them then).
        inst.add_port('clk', 'user_clk', dir='in')
        ports = self.in_ports()
        for name, width in ports:
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='in')
        names = [name for name, _ in ports]
        if 'rst' not in names:
            inst.add_port('rst', "1'b0", dir='in')
        if 'en' not in names:
            inst.add_port('en', "1'b1", dir='in')
        inst.add_port('q', self.fullname + '_q', parent_port=False, width=n_bits, dir='out')

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order: d, then rst
        and en when their option is on (Simulink order d, rst, en)."""
        ports = [('d', self._n_bits())]
        if self._enable_val(self.rst):
            ports += [('rst', 1)]
        if self._enable_val(self.en):
            ports += [('en', 1)]
        return ports

    def generate_compile_order(self):
        fullpath = self.hdl_root + '/'
        co = {
            'lib': 'xil_defaultlib',
            'modules': [
                fullpath + self.SRC
            ],
            'fullpath': True
        }
        self.compile_order['verilog'].append(co)
