import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class inverter(DSPBlock):
    """Bitwise NOT (Xilinx Inverter block) on casper_dsp's inverter.sv."""
    def initialize(self):
        self.add_source('casper_dsp/rtl/BasicModules/inverter.sv')

    @staticmethod
    def _enable_val(status):
        # checkbox status is saved as 'on'/'off' (see mask.py's _convert_status)
        return 1 if str(status).strip().lower() in ('on', '1', 'true') else 0

    def _latency(self):
        return int(float(self.latency))

    def _use_enable(self):
        # as in Simulink the en port exists whenever the option is on, also
        # with latency 0, where inverter.sv (like xlInverter.sgm) ignores it
        return self._enable_val(self.en)

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'inverter'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters -- one per inverter.sv parameter, in the same order
        # they're declared there
        inst.add_parameter("NBITS", "%d" % int(float(self.n_bits)))
        inst.add_parameter("LATENCY", "%d" % self._latency())
        inst.add_parameter("USE_ENABLE", "%d" % self._use_enable())
        # add ports -- names match inverter.sv's port list exactly, and the
        # optional en follows inverter.sci's port list (inverter_in_ports);
        # en defaults to 1 in the RTL, so it is left unconnected when absent
        inst.add_port('clk', 'user_clk', dir='in')
        for name, width in self.in_ports():
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='in')
        inst.add_port('dout', self.fullname + '_dout', parent_port=False, width=int(float(self.n_bits)), dir='out')

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order: din, then en
        when 'Provide enable port' is on (Simulink order ip, en)."""
        ports = [('din', int(float(self.n_bits)))]
        if self._use_enable():
            ports += [('en', 1)]
        return ports

    def generate_compile_order(self):
        fullpath = self.hdl_root + '/'
        co = {
            'lib': 'xil_defaultlib',
            'modules': [
                fullpath + 'casper_dsp/rtl/BasicModules/inverter.sv'
            ],
            'fullpath': True
        }
        self.compile_order['verilog'].append(co)
