import os
import json
from .dsp_block import DSPBlock


class bus_expand(DSPBlock):
    # casper_library bus_expand on casper_dsp's FlowControl/bus_expand.sv:
    # splits bus_in into OUTPUT_NUM slices of OUTPUT_WIDTH bits
    # (combinational, no clock). bus_expand.sci labels the outputs
    # out1..outN as Simulink does, out1 being the most significant slice;
    # bus_expand.sv's bus_out[0] is the least significant one, so Xcos
    # output k comes from bus_out[OUTPUT_NUM-k].

    # casper_dsp RTL files this block needs (relative to hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/BasicModules/slice.v',
        'rtl/FlowControl/bus_expand.sv',
    ]

    def initialize(self):
        self.create_hdl_dir()
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        for relpath in self._rtl_relpaths(casper_dsp_root):
            self.add_source(os.path.join('casper_dsp', relpath))
        self._generate_wrapper()
        self.add_source(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'))

    @classmethod
    def _rtl_relpaths(cls, casper_dsp_root):
        missing = [f for f in cls.RTL_FILES if not os.path.isfile(os.path.join(casper_dsp_root, f))]
        if missing:
            raise FileNotFoundError('%s: missing casper_dsp sources: %s' % (cls.__name__, ', '.join(missing)))
        return list(cls.RTL_FILES)

    def _output_num(self):
        return int(float(self.ndivision))

    def _widths(self):
        """The bit_division vector ('[8,8]', or '{8,8}' as in MATLAB; a single
        number means one output)."""
        val = self.bit_division
        if isinstance(val, (list, tuple)):
            widths = list(val)
        elif isinstance(val, (int, float)):
            widths = [val]
        else:
            widths = json.loads(str(val).strip().replace('{', '[').replace('}', ']'))
            if not isinstance(widths, list):
                widths = [widths]
        return [int(float(w)) for w in widths]

    def _width(self):
        """The common output width: bus_expand.sv splits the bus into
        OUTPUT_NUM slices of one width OUTPUT_WIDTH ('divisions of equal
        size'; Simulink's arbitrary divisions are not supported by the HDL)."""
        n = self._output_num()
        widths = self._widths()
        if n < 1:
            raise ValueError('bus_expand %s: ndivision must be >= 1 (got %d)' % (self.fullname, n))
        if len(widths) != n:
            raise ValueError('bus_expand %s: bit_division %s has %d entries, ndivision is %d'
                             % (self.fullname, widths, len(widths), n))
        if len(set(widths)) != 1 or widths[0] < 1:
            raise ValueError('bus_expand %s: every output must have the same positive width '
                             '(bus_expand.sv), got bit_division %s' % (self.fullname, widths))
        return widths[0]

    def out_ports(self):
        """(name, width) of the output ports, in Xcos port order: out1..outN
        (out1 = most significant slice), as bus_expand.sci labels them."""
        width = self._width()
        return [('out%d' % k, width) for k in range(1, self._output_num() + 1)]

    def _generate_wrapper(self):
        # bus_expand.sv's bus_out is a SystemVerilog unpacked array
        # (bus_out[OUTPUT_NUM]); jasper_library/verilog.py's
        # Instance.add_port() binds one named signal per port, so this
        # per-instance wrapper exposes one flat port per Xcos port (bus_in,
        # out1..outN).
        n = self._output_num()
        width = self._width()
        self.wrapper_module = 'bus_expand_wrap_%s' % self.unique_name

        L = []
        L.append("// auto-generated per-instance wrapper -- see bus_expand.py's")
        L.append("// _generate_wrapper() for why this exists. Regenerated on every")
        L.append("// build, do not hand-edit.")
        L.append("module %s (" % self.wrapper_module)
        L.append("    input  logic [%d:0] bus_in," % (width * n - 1))
        for k in range(1, n + 1):
            L.append("    output logic [%d:0] out%d%s" % (width - 1, k, ',' if k < n else ''))
        L.append(");")
        L.append("    logic [%d:0] dout_arr [%d];" % (width - 1, n))
        L.append("")
        L.append("    bus_expand #(")
        L.append("        .OUTPUT_NUM(%d)," % n)
        L.append("        .OUTPUT_WIDTH(%d)" % width)
        L.append("    ) u_bus_expand (")
        L.append("        .bus_in(bus_in),")
        L.append("        .bus_out(dout_arr)")
        L.append("    );")
        L.append("")
        # Simulink out1 is the MSB slice, bus_expand.sv's bus_out[0] the LSB one
        for k in range(1, n + 1):
            L.append("    assign out%d = dout_arr[%d];" % (k, n - k))
        L.append("endmodule")

        with open(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'), 'w') as f:
            f.write('\n'.join(L) + '\n')

    def modify_top(self, top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        inst = top.get_instance(entity=self.wrapper_module, name=self.fullname)
        # port names match the wrapper's ports and bus_expand.sci's labels
        inst.add_port('bus_in', self.fullname + '_bus_in', parent_port=False,
                      width=self._width() * self._output_num(), dir='in')
        for name, width in self.out_ports():
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='out')

    def generate_compile_order(self):
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        modules = [os.path.join(casper_dsp_root, relpath)
                   for relpath in self._rtl_relpaths(casper_dsp_root)]
        modules.append(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'))
        co = {
            'lib': 'xil_defaultlib',
            'modules': modules,
            'fullpath': True,
        }
        self.compile_order['verilog'].append(co)
