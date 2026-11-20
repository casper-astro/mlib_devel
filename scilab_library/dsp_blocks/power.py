import os
from .dsp_block import DSPBlock


class power(DSPBlock):
    # casper_library_misc power on casper_dsp's Misc/power.sv: |c|^2 of a
    # complex input. c packs {re, im} (re in the MSBs), each
    # Fix_<bit_width>_<bit_width-1>; the output (Simulink port 'power', HDL
    # port dout) is UFix_<2*bit_width+1>_<2*bit_width>, mult_latency +
    # add_latency cycles after c.

    # casper_dsp RTL files power.sv depends on, leaves first (relative to
    # hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/Misc/c_to_ri.v',
        'rtl/BasicModules/register.sv',
        'rtl/BasicModules/delay.sv',
        'rtl/Delays/delay_srl.sv',
        'rtl/Delays/pipeline.sv',
        'rtl/Bus/convert.sv',
        'rtl/Bus/multiplier.sv',
        'rtl/Bus/adder_subtractor.sv',
        'rtl/Misc/power.sv',
    ]

    def initialize(self):
        for relpath in self.RTL_FILES:
            self.add_source(os.path.join('casper_dsp', relpath))

    def _int_param(self, key, lo):
        val = int(float(getattr(self, key)))
        if val < lo:
            raise ValueError('power %s: %s = %d must be >= %d' % (self.fullname, key, val, lo))
        return val

    def modify_top(self, top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        bit_width = self._int_param('bit_width', 1)
        inst = top.get_instance(entity='power', name=self.fullname)
        # add parameters -- in power.sv's order
        inst.add_parameter("BIT_WIDTH", "%d" % bit_width)
        inst.add_parameter("ADD_LATENCY", "%d" % self._int_param('add_latency', 0))
        inst.add_parameter("MULT_LATENCY", "%d" % self._int_param('mult_latency', 0))
        # add ports -- the Xcos ports are c and power (the Simulink names);
        # power.sv calls the output dout
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('c', self.fullname + '_c', parent_port=False, width=2 * bit_width, dir='in')
        inst.add_port('dout', self.fullname + '_power', parent_port=False, width=2 * bit_width + 1, dir='out')

    def generate_compile_order(self):
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        co = {
            'lib': 'xil_defaultlib',
            'modules': [os.path.join(casper_dsp_root, relpath) for relpath in self.RTL_FILES],
            'fullpath': True,
        }
        self.compile_order['verilog'].append(co)
