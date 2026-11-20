import sys
from fractions import Fraction
from .dsp_block import DSPBlock
from verilog import VerilogModule

class constant(DSPBlock):
    # Xilinx Constant (fixed-point part of the mask) on casper_dsp's
    # constant.sv, which outputs the raw integer bit pattern VAL[NBITS-1:0].
    # The Simulink block quantizes the real 'const' to {arith_type, n_bits,
    # bin_pt} with Round (half away from zero) and Saturate, so that is done
    # here and the result is passed as VAL (constant.sv's mapping notes).
    ARITH_TYPES = ("Signed (2's comp)", 'Unsigned')
    MAX_NBITS = 32  # VAL is a 32-bit int in constant.sv

    def initialize(self):
        self.add_source('casper_dsp/rtl/BasicModules/constant.sv')

    def _signed(self):
        if self.arith_type not in self.ARITH_TYPES:
            raise ValueError('constant %s: arith_type %r not supported (use one of %s)'
                             % (self.fullname, self.arith_type, ', '.join(self.ARITH_TYPES)))
        return self.arith_type == self.ARITH_TYPES[0]

    def _n_bits(self):
        n_bits = int(float(self.n_bits))
        if not 1 <= n_bits <= self.MAX_NBITS:
            raise ValueError('constant %s: n_bits = %d not supported (1..%d)'
                             % (self.fullname, n_bits, self.MAX_NBITS))
        return n_bits

    def _bin_pt(self):
        bin_pt = int(float(self.bin_pt))
        if not 0 <= bin_pt <= self._n_bits():
            raise ValueError('constant %s: bin_pt = %d must be in 0..n_bits'
                             % (self.fullname, bin_pt))
        return bin_pt

    @staticmethod
    def quantize(const, signed, n_bits, bin_pt):
        """Integer value of `const` in {signed, n_bits, bin_pt}: const * 2^bin_pt
        rounded half away from zero (Xilinx Round) and saturated to the output
        range (Xilinx Saturate). `const` is taken as a double, as in Simulink;
        the arithmetic is exact (Fraction)."""
        x = Fraction(float(const)) * (Fraction(2) ** bin_pt)
        mag = abs(x)
        q = int(mag)  # floor of |x|
        if mag - q >= Fraction(1, 2):
            q += 1
        q = -q if x < 0 else q
        lo, hi = (-(1 << (n_bits - 1)), (1 << (n_bits - 1)) - 1) if signed else (0, (1 << n_bits) - 1)
        return min(max(q, lo), hi)

    def val(self):
        """VAL for constant.sv: the quantized value as a 32-bit int. Its low
        n_bits are the output bit pattern; an unsigned 32-bit value >= 2^31 is
        passed as its two's-complement negative so it stays in the int range."""
        q = self.quantize(self.const, self._signed(), self._n_bits(), self._bin_pt())
        if q >= (1 << 31):
            q -= (1 << 32)
        return q

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'constant'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters -- in constant.sv's order; plain decimals, as VAL is
        # an int and may be negative (a sized 32'd-1 is a syntax error)
        inst.add_parameter("NBITS", "%d" % self._n_bits())
        inst.add_parameter("VAL", "%d" % self.val())
        # add ports -- the name matches constant.sv's port and constant.sci's label
        inst.add_port('out', self.fullname + '_out', parent_port=False, width=self._n_bits(), dir='out')

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order: none."""
        return []

    def generate_compile_order(self):
        fullpath = self.hdl_root + '/'
        co = {
            'lib': 'xil_defaultlib',
            'modules': [
                fullpath + 'casper_dsp/rtl/BasicModules/constant.sv'
            ],
            'fullpath': True
        }
        self.compile_order['verilog'].append(co)
