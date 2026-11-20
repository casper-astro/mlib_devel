import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class relational(DSPBlock):
    # Xilinx Relational block on casper_dsp's BasicModules/relational.sv
    # (self-contained, it instantiates no other module). The GUI values are
    # the Simulink mask values; they map onto relational.sv's encodings.
    SRC = 'casper_dsp/rtl/BasicModules/relational.sv'
    COMP_MAP = {'a=b': 0, 'a!=b': 1, 'a<b': 2, 'a>b': 3, 'a<=b': 4, 'a>=b': 5}
    SIGNED_MAP = {'Unsigned': 0, "Signed (2's comp)": 1}

    def initialize(self):
        self.add_source(self.SRC)

    @staticmethod
    def _enable_val(status):
        # checkbox status is saved as 'on'/'off' (see mask.py's _convert_status)
        return 1 if str(status).strip().lower() in ('on', '1', 'true') else 0

    def _n_bits(self):
        return int(float(self.n_bits))

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'relational'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters -- one per relational.sv parameter, in declaration
        # order (op_type only changes the Simulink output type, Bool vs
        # UFix_1_0: the HDL bit is the same)
        inst.add_parameter("NBITS", "%d" % self._n_bits())
        inst.add_parameter("COMP", "%d" % self.COMP_MAP[str(self.mode)])
        inst.add_parameter("SIGNED", "%d" % self.SIGNED_MAP[str(self.arith_type)])
        inst.add_parameter("LATENCY", "%d" % int(float(self.latency)))
        inst.add_parameter("USE_ENABLE", "%d" % self._enable_val(self.en))
        # add ports -- names match relational.sv's port list; the optional
        # one follows relational.sci's port list (relational_in_ports). en
        # is tied off when its option is off rather than relying on
        # relational.sv's port default.
        inst.add_port('clk', 'user_clk', dir='in')
        ports = self.in_ports()
        for name, width in ports:
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='in')
        if 'en' not in [name for name, _ in ports]:
            inst.add_port('en', "1'b1", dir='in')
        # the HDL output 'out' is Simulink's (and the Xcos port's) 'op'
        inst.add_port('out', self.fullname + '_op', parent_port=False, width=1, dir='out')

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order: a, b, then
        en when its option is on (Simulink order)."""
        ports = [('a', self._n_bits()), ('b', self._n_bits())]
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
