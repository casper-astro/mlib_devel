import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class slice(DSPBlock):
    # The Xilinx Slice mask ('Specify range as' + 'Offset of top/bottom bit'
    # 'Relative to' MSB/LSB of the input) is mapped onto casper_dsp's
    # slice.v, which only implements 'Lower Bit Location + Width' relative to
    # the LSB: dout = din[START_BIT + WIDTH - 1 : START_BIT]. The conversion
    # (bit_range) is done here; slice.sci (slice_out_width) and the dialog
    # (mask.py's slice_range) use the same formulas.
    MODES = ('Two Bit Locations', 'Upper Bit Location + Width', 'Lower Bit Location + Width')

    def initialize(self):
        self.add_source('casper_dsp/rtl/BasicModules/slice.v')

    @staticmethod
    def _int(val):
        # val_format_conv gives int / float for numeric strings
        return int(float(val))

    @staticmethod
    def _bit_index(offset, base, n_bits_in):
        """Absolute bit index (0 = LSB of the input) of an offset given
        relative to 'MSB of Input' (offset 0 = bit n_bits_in-1, usually <= 0)
        or 'LSB of Input' (offset 0 = bit 0, usually >= 0)."""
        base = str(base).strip().lower()
        if base == 'msb of input':
            return n_bits_in - 1 + offset
        if base == 'lsb of input':
            return offset
        raise ValueError("slice: unsupported 'Relative to' value %r "
                         "(only 'MSB of Input' / 'LSB of Input')" % base)

    def bit_range(self):
        """(START_BIT, WIDTH) of the slice, checked against [0, n_bits_in)."""
        n_bits_in = self._int(self.n_bits_in)
        mode = str(self.mode).strip()
        if mode == 'Upper Bit Location + Width':
            width = self._int(self.nbits)
            top = self._bit_index(self._int(self.bit1), self.base1, n_bits_in)
            start = top - width + 1
        elif mode == 'Lower Bit Location + Width':
            width = self._int(self.nbits)
            start = self._bit_index(self._int(self.bit0), self.base0, n_bits_in)
        elif mode == 'Two Bit Locations':
            top = self._bit_index(self._int(self.bit1), self.base1, n_bits_in)
            start = self._bit_index(self._int(self.bit0), self.base0, n_bits_in)
            width = top - start + 1
        else:
            raise ValueError('slice: unsupported mode %r' % mode)
        if n_bits_in < 1 or width < 1 or start < 0 or start + width > n_bits_in:
            raise ValueError('slice %s: bits [%d:%d] are outside the %d-bit input'
                             % (self.fullname, start + width - 1, start, n_bits_in))
        return start, width

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'slice'
        inst = top.get_instance(entity=module, name=self.fullname)
        start, width = self.bit_range()
        n_bits_in = self._int(self.n_bits_in)
        # add parameters -- one per slice.v parameter, in declaration order
        inst.add_parameter("NBITS", "%d" % n_bits_in)
        inst.add_parameter("START_BIT", "%d" % start)
        inst.add_parameter("WIDTH", "%d" % width)
        # add ports -- slice.v is combinational (no clk); names match its
        # port list and slice.sci's labels
        for name, w in self.in_ports():
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=w, dir='in')
        inst.add_port('dout', self.fullname + '_dout', parent_port=False, width=width, dir='out')

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order."""
        return [('din', self._int(self.n_bits_in))]

    def generate_compile_order(self):
        fullpath = self.hdl_root + '/'
        co = {
            'lib': 'xil_defaultlib',
            'modules': [
                fullpath + 'casper_dsp/rtl/BasicModules/slice.v'
            ],
            'fullpath': True
        }
        self.compile_order['verilog'].append(co)
