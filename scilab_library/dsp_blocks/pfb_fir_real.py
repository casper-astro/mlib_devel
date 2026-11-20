import os
import sys
import re
import subprocess
from .dsp_block import DSPBlock
from verilog import VerilogModule

class pfb_fir_real(DSPBlock):
    QUANT_MAP = {
        'Truncate': 0,
        'Round  (unbiased: +/- Inf)': 1,
        'Round  (unbiased: Even Values)': 2,
    }
    ADDER_IMP_MAP = {'Behavioral': 0, 'Fabric': 1, 'DSP48': 2}

    def initialize(self):
        self.create_hdl_dir()
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        for relpath in self._rtl_relpaths(casper_dsp_root):
            self.add_source(os.path.join('casper_dsp', relpath))
        self.coeff_dir = os.path.abspath(os.path.join(self.hdl_wrapper_dir, 'coeffs'))
        os.makedirs(self.coeff_dir, exist_ok=True)
        self._derived = self._gen_coeffs(casper_dsp_root)
        self._generate_wrapper()
        self.add_source(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'))

    # casper_dsp RTL files pfb_fir_real.sv depends on, leaves first (relative to
    # hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/BasicModules/delay.sv',
        'rtl/BasicModules/register.sv',
        'rtl/Delays/delay_srl.sv',
        'rtl/Delays/pipeline.sv',
        'rtl/Bus/convert.sv',
        'rtl/Bus/adder_subtractor.sv',
        'rtl/Misc/adder_tree.sv',
        'rtl/BasicModules/counter.sv',
        'rtl/Delays/single_port_ram.sv',
        'rtl/Delays/delay_bram.sv',
        'rtl/Bus/multiplier.sv',
        'rtl/Delays/sync_delay.sv',
        'rtl/PFBs/tap_real.sv',
        'rtl/PFBs/first_tap_real.sv',
        'rtl/PFBs/last_tap_real.sv',
        'rtl/Delays/rom.sv',
        'rtl/PFBs/pfb_coeff_gen.sv',
        'rtl/Bus/scale.sv',
        'rtl/PFBs/pfb_fir_real.sv',
    ]

    @classmethod
    def _rtl_relpaths(cls, casper_dsp_root):
        missing = [f for f in cls.RTL_FILES if not os.path.isfile(os.path.join(casper_dsp_root, f))]
        if missing:
            raise FileNotFoundError('%s: missing casper_dsp sources: %s' % (cls.__name__, ', '.join(missing)))
        return list(cls.RTL_FILES)

    @staticmethod
    def _enable_val(status):
        return 1 if str(status).strip().lower() in ('on', '1', 'true') else 0

    @staticmethod
    def _int(v):
        return int(float(v))

    @staticmethod
    def _parse_mult_spec(s):
        # declared-but-not-implemented, same rationale as fft_wideband_real.py
        s = str(s).strip().strip('[]')
        toks = [t for t in s.replace(',', ' ').split() if t != '']
        if not toks:
            return 2
        try:
            return int(float(toks[0]))
        except ValueError:
            return 2

    def _gen_coeffs(self, casper_dsp_root):
        script = os.path.join(casper_dsp_root, 'rtl', 'PFBs', 'scripts', 'gen_pfb_coeffs.py')
        cmd = [
            sys.executable, script,
            '--pfb-size', str(self._int(self.PFBSize)),
            '--total-taps', str(self._int(self.TotalTaps)),
            '--window', str(self.WindowType),
            '--n-inputs', str(self._int(self.n_inputs)),
            '--bit-width-in', str(self._int(self.BitWidthIn)),
            '--bit-width-out', str(self._int(self.BitWidthOut)),
            '--fwidth', str(float(self.fwidth)),
            '--coeff-bit-width', str(self._int(self.CoeffBitWidth)),
            '-o', self.coeff_dir,
        ]
        out = subprocess.run(cmd, check=True, cwd=casper_dsp_root,
                              capture_output=True, text=True).stdout
        m = re.search(
            r'BIT_GROWTH=(-?\d+)\s+ADDER_N_BITS_OUT=(-?\d+)\s+'
            r'ADDER_BIN_PT_OUT=(-?\d+)\s+SCALE_FACTOR=(-?\d+)\s+'
            r'BIT_WIDTH_OUT=(-?\d+)', out)
        if not m:
            raise RuntimeError(
                'pfb_fir_real: could not parse gen_pfb_coeffs.py output: %r' % out)
        bit_growth, adder_n_bits_out, adder_bin_pt_out, scale_factor, n_bits_out = (
            int(g) for g in m.groups())
        return {
            'BIT_GROWTH': bit_growth,
            'ADDER_N_BITS_OUT': adder_n_bits_out,
            'ADDER_BIN_PT_OUT': adder_bin_pt_out,
            'SCALE_FACTOR': scale_factor,
            'N_BITS_OUT': n_bits_out,
        }

    def _generate_wrapper(self):
        # pfb_fir_real.sv's top-level din/dout ports are SystemVerilog
        # unpacked arrays (`input logic [W-1:0] din [POLS<<N_INPUTS]`),
        # which jasper_library/verilog.py's Instance.add_port() can't
        # connect to directly (it binds a port to one named signal, not a
        # per-element array) -- same reason fft_wideband_real.py needs one.
        # This wrapper exposes flat per-(p,n) ports (matching the .sci
        # file's port labels one-for-one: pol<p>_in<n>/pol<p>_out<n>,
        # 1-indexed) and packs/unpacks them into the array ports internally.
        pols = 2 if self._enable_val(self.MakeBiplex) else 1
        n_inputs = self._int(self.n_inputs)
        bit_width_in = self._int(self.BitWidthIn)
        n_bits_out = self._derived['N_BITS_OUT']
        ni = 1 << n_inputs

        self.pols = pols
        self.ni = ni
        self.n_bits_out = n_bits_out
        self.wrapper_module = 'pfb_fir_real_wrap_%s' % self.unique_name

        L = []
        L.append("// auto-generated per-instance wrapper -- see pfb_fir_real.py's")
        L.append("// _generate_wrapper() for why this exists. Regenerated on every")
        L.append("// build, do not hand-edit.")
        L.append("module %s (" % self.wrapper_module)
        L.append("    input  logic clk,")
        L.append("    input  logic sync,")
        for p in range(1, pols + 1):
            for n in range(1, ni + 1):
                L.append("    input  logic [%d:0] pol%d_in%d," % (bit_width_in - 1, p, n))
        L.append("    output logic sync_out,")
        for p in range(1, pols + 1):
            for n in range(1, ni + 1):
                last = (p == pols and n == ni)
                L.append("    output logic [%d:0] pol%d_out%d%s" %
                          (n_bits_out - 1, p, n, "" if last else ","))
        L.append(");")
        L.append("    logic [%d:0] din_arr  [%d];" % (bit_width_in - 1, pols * ni))
        L.append("    logic [%d:0] dout_arr [%d];" % (n_bits_out - 1, pols * ni))
        for p in range(1, pols + 1):
            for n in range(1, ni + 1):
                k = (p - 1) * ni + (n - 1)
                L.append("    assign din_arr[%d] = pol%d_in%d;" % (k, p, n))
        for p in range(1, pols + 1):
            for n in range(1, ni + 1):
                k = (p - 1) * ni + (n - 1)
                L.append("    assign pol%d_out%d = dout_arr[%d];" % (p, n, k))
        L.append("")
        L.append("    pfb_fir_real #(")
        L.append("        .PFB_SIZE(%d)," % self._int(self.PFBSize))
        L.append("        .TOTAL_TAPS(%d)," % self._int(self.TotalTaps))
        L.append('        .WINDOW_TYPE("%s"),' % self.WindowType)
        L.append("        .N_INPUTS(%d)," % n_inputs)
        L.append("        .N_POL_BLOCKS(%d)," % self._int(self.n_pol_blocks))
        L.append("        .MAKE_BIPLEX(%d)," % self._enable_val(self.MakeBiplex))
        L.append("        .BIT_WIDTH_IN(%d)," % bit_width_in)
        L.append("        .BIT_WIDTH_OUT(%d)," % self._int(self.BitWidthOut))
        L.append("        .COEFF_BIT_WIDTH(%d)," % self._int(self.CoeffBitWidth))
        L.append("        .COEFF_DIST_MEM(%d)," % self._enable_val(self.CoeffDistMem))
        L.append("        .ADD_LATENCY(%d)," % self._int(self.add_latency))
        L.append("        .MULT_LATENCY(%d)," % self._int(self.mult_latency))
        L.append("        .BRAM_LATENCY(%d)," % self._int(self.bram_latency))
        L.append("        .FAN_LATENCY(%d)," % self._int(self.fan_latency))
        L.append("        .CONV_LATENCY(%d)," % self._int(self.conv_latency))
        L.append("        .QUANTIZATION(%d)," % self.QUANT_MAP.get(str(self.quantization), 1))
        L.append("        .FWIDTH(%s)," % float(self.fwidth))
        L.append("        .MULT_SPEC(%d)," % self._parse_mult_spec(self.mult_spec))
        L.append("        .ADDER_FOLDING(%d)," % self._enable_val(self.adder_folding))
        L.append("        .ADDER_IMP(%d)," % self.ADDER_IMP_MAP.get(str(self.adder_imp), 1))
        L.append("        .COEFFS_SHARE(%d)," % self._enable_val(self.coeffs_share))
        L.append("        .BIT_GROWTH(%d)," % self._derived['BIT_GROWTH'])
        L.append("        .ADDER_N_BITS_OUT(%d)," % self._derived['ADDER_N_BITS_OUT'])
        L.append("        .ADDER_BIN_PT_OUT(%d)," % self._derived['ADDER_BIN_PT_OUT'])
        L.append("        .SCALE_FACTOR(%d)," % self._derived['SCALE_FACTOR'])
        # the RTL appends the file names directly ({COEFF_DIR, "pfb_coeff_n0_t0.mem"}),
        # so the directory needs its trailing '/'
        L.append('        .COEFF_DIR("%s/")' % self.coeff_dir)
        L.append("    ) u_pfb (")
        L.append("        .clk(clk),")
        L.append("        .sync(sync),")
        L.append("        .din(din_arr),")
        L.append("        .sync_out(sync_out),")
        L.append("        .dout(dout_arr)")
        L.append("    );")
        L.append("endmodule")

        with open(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'), 'w') as f:
            f.write('\n'.join(L) + '\n')

    def _check_out_widths(self):
        # the Xcos output ports (and so the wires of every link from them) were
        # sized by pfb_fir_real.sci; with BitWidthOut = 0 the width depends on
        # the coefficients, so stop here if the diagram disagrees with the HDL
        # (a diagram saved before the .sci computed the real width)
        for link in self.link_info:
            if link['src_blk_name'] != self.unique_name:
                continue
            label = link['src_port_name'][len(self.fullname) + 1:]
            if not label.startswith('pol') or '_out' not in label:
                continue
            width = int(float(link['src_port_width']))
            if width != self.n_bits_out:
                raise ValueError(
                    'pfb_fir_real %s: output port %s is %d bits in the diagram but the '
                    'HDL output is %d bits; reopen the block dialog and press OK to '
                    'update its ports' % (self.unique_name, label, width, self.n_bits_out))

    def modify_top(self, top):
        self._check_out_widths()
        self._populate_parent_ports(top)
        inst = top.get_instance(entity=self.wrapper_module, name=self.fullname)
        bit_width_in = self._int(self.BitWidthIn)

        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('sync', self.fullname + '_sync', parent_port=False, width=1, dir='in')
        for p in range(1, self.pols + 1):
            for n in range(1, self.ni + 1):
                pname = 'pol%d_in%d' % (p, n)
                inst.add_port(pname, self.fullname + '_' + pname, parent_port=False,
                              width=bit_width_in, dir='in')
        inst.add_port('sync_out', self.fullname + '_sync_out', parent_port=False, width=1, dir='out')
        for p in range(1, self.pols + 1):
            for n in range(1, self.ni + 1):
                pname = 'pol%d_out%d' % (p, n)
                inst.add_port(pname, self.fullname + '_' + pname, parent_port=False,
                              width=self.n_bits_out, dir='out')

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
