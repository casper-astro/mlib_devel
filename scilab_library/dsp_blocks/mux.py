import os
from .dsp_block import DSPBlock


class mux(DSPBlock):
    # Xilinx Mux block (xbsIndex_r4/Mux) on casper_dsp's
    # BasicModules/multiplexer.sv, Full precision only: every data input and
    # the output are n_bits wide (Simulink inherits that width).

    # casper_dsp RTL files this block needs (relative to hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/BasicModules/multiplexer.sv',
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

    @staticmethod
    def _int(v):
        return int(float(v))

    @staticmethod
    def _enable_val(status):
        # checkbox status is saved as 'on'/'off' (val_format_conv turns them
        # into True/False)
        return 1 if str(status).strip().lower() in ('on', '1', 'true') else 0

    @staticmethod
    def sel_width(ninputs):
        """multiplexer.sv's sel width, $clog2(NINPUTS) (>= 1 for 2+ inputs)."""
        return (ninputs - 1).bit_length()

    def _check(self):
        ninputs = self._int(self.inputs)
        nbits = self._int(self.n_bits)
        latency = self._int(self.latency)
        if ninputs < 2:
            # the Simulink mask offers 2..32 inputs; with 1 input sel would
            # be 0 bits wide
            raise ValueError('mux: inputs must be >= 2 (got %d)' % ninputs)
        if nbits < 1:
            raise ValueError('mux: n_bits must be >= 1 (got %d)' % nbits)
        if latency < 0:
            raise ValueError('mux: latency must be >= 0 (got %d)' % latency)

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order: sel, d0..d{N-1},
        then en (only with 'Provide enable port'), as in Simulink."""
        ninputs = self._int(self.inputs)
        nbits = self._int(self.n_bits)
        ports = [('sel', self.sel_width(ninputs))]
        ports += [('d%d' % i, nbits) for i in range(ninputs)]
        if self._enable_val(self.en):
            ports += [('en', 1)]
        return ports

    def _generate_wrapper(self):
        # multiplexer.sv's din is a SystemVerilog unpacked array
        # (din[NINPUTS]); jasper_library/verilog.py's Instance.add_port() binds
        # one named signal per port, so this per-instance wrapper exposes one
        # flat port per Xcos port (sel, d0..d{N-1}, [en], dout); d<i> drives
        # din[i], so sel = i selects d<i> as in Simulink.
        self._check()
        ninputs = self._int(self.inputs)
        nbits = self._int(self.n_bits)
        use_en = self._enable_val(self.en)
        self.wrapper_module = 'mux_wrap_%s' % self.unique_name

        L = []
        L.append("// auto-generated per-instance wrapper -- see mux.py's")
        L.append("// _generate_wrapper() for why this exists. Regenerated on every")
        L.append("// build, do not hand-edit.")
        L.append("module %s (" % self.wrapper_module)
        L.append("    input  logic clk,")
        L.append("    input  logic [%d:0] sel," % (self.sel_width(ninputs) - 1))
        for i in range(ninputs):
            L.append("    input  logic [%d:0] d%d," % (nbits - 1, i))
        if use_en:
            L.append("    input  logic en,")
        L.append("    output logic [%d:0] dout" % (nbits - 1))
        L.append(");")
        L.append("    logic [%d:0] din_arr [%d];" % (nbits - 1, ninputs))
        for i in range(ninputs):
            L.append("    assign din_arr[%d] = d%d;" % (i, i))
        L.append("")
        L.append("    multiplexer #(")
        L.append("        .NBITS(%d)," % nbits)
        L.append("        .NINPUTS(%d)," % ninputs)
        L.append("        .LATENCY(%d)," % self._int(self.latency))
        L.append("        .USE_ENABLE(%d)" % use_en)
        L.append("    ) u_multiplexer (")
        L.append("        .clk(clk),")
        # without the enable port, en keeps a constant 1 (the RTL ignores it)
        L.append("        .en(%s)," % ('en' if use_en else "1'b1"))
        L.append("        .din(din_arr),")
        L.append("        .sel(sel),")
        L.append("        .dout(dout)")
        L.append("    );")
        L.append("endmodule")

        with open(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'), 'w') as f:
            f.write('\n'.join(L) + '\n')

    def modify_top(self, top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        inst = top.get_instance(entity=self.wrapper_module, name=self.fullname)
        inst.add_port('clk', 'user_clk', dir='in')
        # port names match the wrapper's ports and mux.sci's labels
        for name, width in self.in_ports():
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='in')
        inst.add_port('dout', self.fullname + '_dout', parent_port=False,
                      width=self._int(self.n_bits), dir='out')

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
