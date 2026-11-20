import os
import json
from .dsp_block import DSPBlock


class bus_create(DSPBlock):
    # casper_library bus_create on casper_dsp's FlowControl/bus_create.sv:
    # concatenates INPUT_NUM inputs of NBITS bits (combinational, no clock).
    # bus_create.sci labels the inputs in1..inN as Simulink does, in1 being
    # the most significant slot of bus_out; bus_create.sv's din[0] is the
    # least significant one, so Xcos input k goes to din[INPUT_NUM-k].

    # casper_dsp RTL files this block needs (relative to hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/FlowControl/bus_create.sv',
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

    def _input_num(self):
        return int(float(self.inputNum))

    def _widths(self):
        """The bit_widths vector ('[8,8]', or '{8,8}' as in MATLAB; a single
        number means one input)."""
        val = self.bit_widths
        if isinstance(val, (list, tuple)):
            widths = list(val)
        elif isinstance(val, (int, float)):
            widths = [val]
        else:
            widths = json.loads(str(val).strip().replace('{', '[').replace('}', ']'))
            if not isinstance(widths, list):
                widths = [widths]
        return [int(float(w)) for w in widths]

    def _nbits(self):
        """The common input width: bus_create.sv needs every input NBITS wide
        (Simulink reinterprets inputs of any width, the HDL does not)."""
        n = self._input_num()
        widths = self._widths()
        if n < 1:
            raise ValueError('bus_create: inputNum must be >= 1 (got %d)' % n)
        if len(widths) != n:
            raise ValueError('bus_create: bit_widths %s has %d entries, inputNum is %d'
                             % (widths, len(widths), n))
        if len(set(widths)) != 1 or widths[0] < 1:
            raise ValueError('bus_create: every input must have the same positive width '
                             '(bus_create.sv), got bit_widths %s' % widths)
        return widths[0]

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order: in1..inN
        (in1 = most significant slot), as bus_create.sci labels them."""
        nbits = self._nbits()
        return [('in%d' % k, nbits) for k in range(1, self._input_num() + 1)]

    def _generate_wrapper(self):
        # bus_create.sv's din is a SystemVerilog unpacked array (din[INPUT_NUM]);
        # jasper_library/verilog.py's Instance.add_port() binds one named
        # signal per port, so this per-instance wrapper exposes one flat port
        # per Xcos port (in1..inN, bus_out).
        n = self._input_num()
        nbits = self._nbits()
        self.wrapper_module = 'bus_create_wrap_%s' % self.unique_name

        L = []
        L.append("// auto-generated per-instance wrapper -- see bus_create.py's")
        L.append("// _generate_wrapper() for why this exists. Regenerated on every")
        L.append("// build, do not hand-edit.")
        L.append("module %s (" % self.wrapper_module)
        for k in range(1, n + 1):
            L.append("    input  logic [%d:0] in%d," % (nbits - 1, k))
        L.append("    output logic [%d:0] bus_out" % (nbits * n - 1))
        L.append(");")
        L.append("    logic [%d:0] din_arr [%d];" % (nbits - 1, n))
        # Simulink in1 is the MSB slot, bus_create.sv's din[0] the LSB one
        for k in range(1, n + 1):
            L.append("    assign din_arr[%d] = in%d;" % (n - k, k))
        L.append("")
        L.append("    bus_create #(")
        L.append("        .NBITS(%d)," % nbits)
        L.append("        .INPUT_NUM(%d)" % n)
        L.append("    ) u_bus_create (")
        L.append("        .din(din_arr),")
        L.append("        .bus_out(bus_out)")
        L.append("    );")
        L.append("endmodule")

        with open(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'), 'w') as f:
            f.write('\n'.join(L) + '\n')

    def modify_top(self, top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        inst = top.get_instance(entity=self.wrapper_module, name=self.fullname)
        # port names match the wrapper's ports and bus_create.sci's labels
        for name, width in self.in_ports():
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='in')
        inst.add_port('bus_out', self.fullname + '_bus_out', parent_port=False,
                      width=self._nbits() * self._input_num(), dir='out')

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
