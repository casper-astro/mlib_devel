from .dsp_block import DSPBlock
from utils.matlab_vec import parse_vector
from utils.munge_widths import munge_widths


class munge(DSPBlock):
    # casper_library munge on casper_dsp's FlowControl/munge.sv: splits din
    # into divisions (div_size bits each, counted from the MSB) and
    # concatenates them in the given order, MSB first:
    #   dout = {din division order[0], din division order[1], ...}
    # Combinational, no clock. arith_type_out / bin_pt_out only set the
    # Simulink output type (a Reinterpret); the HDL outputs the raw bits.
    SRC = 'casper_dsp/rtl/FlowControl/munge.sv'

    def initialize(self):
        self.add_source(self.SRC)

    def _divisions(self):
        return int(float(self.divisions))

    def _div_size(self):
        return parse_vector(self.div_size)

    def _order(self):
        return parse_vector(self.order)

    def widths(self):
        return munge_widths(self._divisions(), self._div_size(), self._order())

    @staticmethod
    def _packed(vals):
        # munge.sv's vector parameters: packed 32-bit elements, the first
        # element in the MSBs, so they read like the mask vector
        return '{%s}' % ', '.join("32'd%d" % int(v) for v in vals)

    def modify_top(self, top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        din_width, dout_width = self.widths()
        inst = top.get_instance(entity='munge', name=self.fullname)
        # add parameters -- one per munge.sv parameter, in declaration order
        inst.add_parameter("DIVISIONS", "%d" % self._divisions())
        inst.add_parameter("DIV_SIZE", self._packed(self._div_size()))
        # with one division munge.sv passes din through and ignores ORDER
        inst.add_parameter("ORDER", self._packed(self._order() if self._divisions() > 1 else [0]))
        # add ports -- din / dout are the munge.sv and Simulink port names
        inst.add_port('din', self.fullname + '_din', parent_port=False, width=din_width, dir='in')
        inst.add_port('dout', self.fullname + '_dout', parent_port=False, width=dout_width, dir='out')

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
