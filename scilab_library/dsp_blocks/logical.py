import os
from .dsp_block import DSPBlock


class logical(DSPBlock):
    # Xilinx Logical mask popup text (logical_function) -> logical.sv's FUNC
    # encoding (0=AND, 1=NAND, 2=OR, 3=NOR, 4=XOR, 5=XNOR).
    FUNC_MAP = {'AND': 0, 'NAND': 1, 'OR': 2, 'NOR': 3, 'XOR': 4, 'XNOR': 5}

    # casper_dsp RTL files this block needs (relative to hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/BasicModules/logical.sv',
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

    def _func_val(self):
        s = str(self.logical_function).strip().upper()
        if s not in self.FUNC_MAP:
            raise ValueError('logical: unsupported logical_function %r' % self.logical_function)
        return self.FUNC_MAP[s]

    def _check(self):
        ninputs = self._int(self.inputs)
        nbits = self._int(self.n_bits_in)
        latency = self._int(self.latency)
        if ninputs < 2:
            # Sysgen's 1-input case is a unary reduction (Boolean output),
            # which logical.sv does not implement
            raise ValueError('logical: inputs must be >= 2 (got %d)' % ninputs)
        if nbits < 1:
            raise ValueError('logical: n_bits_in must be >= 1 (got %d)' % nbits)
        if latency < 0:
            raise ValueError('logical: latency must be >= 0 (got %d)' % latency)

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order: d0..d{N-1},
        then en (only with 'Provide enable port'), as in Simulink."""
        nbits = self._int(self.n_bits_in)
        ports = [('d%d' % i, nbits) for i in range(self._int(self.inputs))]
        if self._enable_val(self.en):
            ports += [('en', 1)]
        return ports

    def _generate_wrapper(self):
        # logical.sv's din is a SystemVerilog unpacked array (din[NINPUTS]);
        # jasper_library/verilog.py's Instance.add_port() binds one named
        # signal per port, so this per-instance wrapper exposes one flat port
        # per Xcos port (d0..d{N-1}, [en], dout).
        self._check()
        ninputs = self._int(self.inputs)
        nbits = self._int(self.n_bits_in)
        use_en = self._enable_val(self.en)
        self.wrapper_module = 'logical_wrap_%s' % self.unique_name

        L = []
        L.append("// auto-generated per-instance wrapper -- see logical.py's")
        L.append("// _generate_wrapper() for why this exists. Regenerated on every")
        L.append("// build, do not hand-edit.")
        L.append("module %s (" % self.wrapper_module)
        L.append("    input  logic clk,")
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
        L.append("    logical #(")
        L.append("        .NBITS(%d)," % nbits)
        L.append("        .NINPUTS(%d)," % ninputs)
        L.append("        .LATENCY(%d)," % self._int(self.latency))
        L.append("        .FUNC(%d)," % self._func_val())
        L.append("        .USE_ENABLE(%d)" % use_en)
        L.append("    ) u_logical (")
        L.append("        .clk(clk),")
        # without the enable port, en keeps a constant 1 (the RTL ignores it)
        L.append("        .en(%s)," % ('en' if use_en else "1'b1"))
        L.append("        .din(din_arr),")
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
        # port names match the wrapper's ports and logical.sci's labels
        for name, width in self.in_ports():
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='in')
        inst.add_port('dout', self.fullname + '_dout', parent_port=False,
                      width=self._int(self.n_bits_in), dir='out')

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
