import os
from .dsp_block import DSPBlock


class cross_multiplier(DSPBlock):
    # Mask popup strings (verbatim from casper_library_correlator.slx's
    # cross_multiplier mask -- note 'Error' and the lower-case 'even values')
    # -> cross_multiplier.sv's integer encodings.
    OVERFLOW_MAP = {'Wrap': 0, 'Saturate': 1, 'Error': 2}
    QUANT_MAP = {
        'Truncate': 0,
        'Round  (unbiased: +/- Inf)': 1,
        'Round  (unbiased: even values)': 2,
    }

    def initialize(self):
        self.create_hdl_dir()
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        for relpath in self._rtl_relpaths(casper_dsp_root):
            self.add_source(os.path.join('casper_dsp', relpath))
        self._generate_wrapper()
        self.add_source(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'))

    # casper_dsp RTL files cross_multiplier.sv depends on, leaves first (relative to
    # hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/Misc/c_to_ri.v',
        'rtl/BasicModules/delay.sv',
        'rtl/BasicModules/register.sv',
        'rtl/Delays/delay_srl.sv',
        'rtl/Delays/pipeline.sv',
        'rtl/Bus/convert.sv',
        'rtl/Bus/adder_subtractor.sv',
        'rtl/Bus/multiplier.sv',
        'rtl/Multipliers/cmult.sv',
        'rtl/Misc/convert_of.sv',
        'rtl/Misc/ri_to_c.v',
        'rtl/Correlator/cross_multiplier.sv',
    ]

    @classmethod
    def _rtl_relpaths(cls, casper_dsp_root):
        missing = [f for f in cls.RTL_FILES if not os.path.isfile(os.path.join(casper_dsp_root, f))]
        if missing:
            raise FileNotFoundError('%s: missing casper_dsp sources: %s' % (cls.__name__, ', '.join(missing)))
        return list(cls.RTL_FILES)

    @staticmethod
    def _int(v):
        return int(float(v))

    @staticmethod
    def _lookup(table, val, what):
        s = str(val).strip()
        if s in table:
            return table[s]
        # tolerate case/whitespace differences (e.g. the 'Even Values'
        # spelling other casper_library masks use)
        norm = lambda t: ' '.join(t.lower().split())
        for k, v in table.items():
            if norm(k) == norm(s):
                return v
        raise ValueError('cross_multiplier: unsupported %s %r' % (what, val))

    @staticmethod
    def out_labels(streams):
        """Output port labels in port order (port 1 is sync_out), matching
        cross_multiplier.sci and cross_multiplier_init.m's (x <= y) order:
        index k of the RTL's dout[k] is the k-th entry. Simulink's names end
        in '*' (conjugate marker), which is dropped here because the label
        becomes part of a Verilog identifier."""
        return ['din%d_x_din%d' % (x, y)
                for x in range(streams) for y in range(x, streams)]

    def _generate_wrapper(self):
        # cross_multiplier.sv's din/dout are packed 2-D arrays
        # (din[STREAMS][AGGREGATION*2*BIT_WIDTH_IN], dout[NOUT][...]);
        # jasper_library/verilog.py's Instance.add_port() binds one named
        # signal per port, so this wrapper exposes one flat port per Xcos
        # port (sync_in, din<i>, sync_out, din<x>_x_din<y>) and packs/unpacks
        # them internally.
        streams = self._int(self.streams)
        aggregation = self._int(self.aggregation)
        bw_in = self._int(self.bit_width_in)
        bw_out = self._int(self.bit_width_out)
        self.n_streams = streams
        self.din_width = aggregation * 2 * bw_in
        self.dout_width = aggregation * 2 * bw_out
        self.dout_names = self.out_labels(streams)
        nout = len(self.dout_names)
        self.wrapper_module = 'cross_multiplier_wrap_%s' % self.unique_name

        L = []
        L.append("// auto-generated per-instance wrapper -- see cross_multiplier.py's")
        L.append("// _generate_wrapper() for why this exists. Regenerated on every")
        L.append("// build, do not hand-edit.")
        L.append("module %s (" % self.wrapper_module)
        L.append("    input  logic clk,")
        L.append("    input  logic sync_in,")
        for i in range(streams):
            L.append("    input  logic [%d:0] din%d," % (self.din_width - 1, i))
        L.append("    output logic sync_out,")
        for k, name in enumerate(self.dout_names):
            L.append("    output logic [%d:0] %s%s" %
                     (self.dout_width - 1, name, "" if k == nout - 1 else ","))
        L.append(");")
        L.append("    logic [%d:0][%d:0] din_arr;" % (streams - 1, self.din_width - 1))
        L.append("    logic [%d:0][%d:0] dout_arr;" % (nout - 1, self.dout_width - 1))
        for i in range(streams):
            L.append("    assign din_arr[%d] = din%d;" % (i, i))
        for k, name in enumerate(self.dout_names):
            L.append("    assign %s = dout_arr[%d];" % (name, k))
        L.append("")
        L.append("    cross_multiplier #(")
        L.append("        .STREAMS(%d)," % streams)
        L.append("        .AGGREGATION(%d)," % aggregation)
        L.append("        .BIT_WIDTH_IN(%d)," % bw_in)
        L.append("        .BINARY_POINT_IN(%d)," % self._int(self.binary_point_in))
        L.append("        .BIT_WIDTH_OUT(%d)," % bw_out)
        L.append("        .BINARY_POINT_OUT(%d)," % self._int(self.binary_point_out))
        L.append("        .MULT_LATENCY(%d)," % self._int(self.mult_latency))
        L.append("        .ADD_LATENCY(%d)," % self._int(self.add_latency))
        L.append("        .OVERFLOW(%d)," % self._lookup(self.OVERFLOW_MAP, self.overflow, 'overflow'))
        L.append("        .QUANTISATION(%d)," % self._lookup(self.QUANT_MAP, self.quantisation, 'quantisation'))
        L.append("        .CONV_LATENCY(%d)" % self._int(self.conv_latency))
        L.append("    ) u_cross_multiplier (")
        L.append("        .clk(clk),")
        L.append("        .sync_in(sync_in),")
        L.append("        .din(din_arr),")
        L.append("        .sync_out(sync_out),")
        L.append("        .dout(dout_arr)")
        L.append("    );")
        L.append("endmodule")

        with open(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'), 'w') as f:
            f.write('\n'.join(L) + '\n')

    def modify_top(self, top):
        self._populate_parent_ports(top)
        inst = top.get_instance(entity=self.wrapper_module, name=self.fullname)
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('sync_in', self.fullname + '_sync_in', parent_port=False, width=1, dir='in')
        for i in range(self.n_streams):
            pname = 'din%d' % i
            inst.add_port(pname, self.fullname + '_' + pname, parent_port=False,
                          width=self.din_width, dir='in')
        inst.add_port('sync_out', self.fullname + '_sync_out', parent_port=False, width=1, dir='out')
        for pname in self.dout_names:
            inst.add_port(pname, self.fullname + '_' + pname, parent_port=False,
                          width=self.dout_width, dir='out')

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
