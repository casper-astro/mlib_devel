import os
import sys
import subprocess
from .dsp_block import DSPBlock
from verilog import VerilogModule

class fft_wideband_real(DSPBlock):
    # GUI combobox strings -> fft_wideband_real.sv's integer encodings (same
    # convention established for every casper_dsp Bus-family module: 0/1/2).
    QUANT_MAP = {
        'Truncate': 0,
        'Round  (unbiased: +/- Inf)': 1,
        'Round  (unbiased: Even Values)': 2,
    }
    OVERFLOW_MAP = {'Wrap': 0, 'Saturate': 1, 'Error': 2}
    FLOAT_TYPE_MAP = {'single': 0, 'custom': 1}

    def initialize(self):
        self.create_hdl_dir()
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        for relpath in self._rtl_relpaths(casper_dsp_root):
            self.add_source(os.path.join('casper_dsp', relpath))
        # generate this instance's coefficient/permutation-table .mem files
        self.mem_dir = os.path.abspath(os.path.join(self.hdl_wrapper_dir, 'mem'))
        os.makedirs(self.mem_dir, exist_ok=True)
        self._gen_mem_files(casper_dsp_root)
        # generate and add the flat-port wrapper (see _generate_wrapper's
        # own docstring for why this is needed) -- matches bus_expand.py's
        # precedent of add_source()-ing a generated hdl_wrapper_dir file
        # directly, not relative to hdl_root like the static casper_dsp
        # sources above.
        self._generate_wrapper()
        self.add_source(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'))

    # the casper_dsp RTL files fft_wideband_real instantiates, directly or
    # through its sub-modules (relative to casper_dsp/rtl/); update this list
    # when the module hierarchy in casper_dsp changes
    RTL_SOURCES = [
        'BasicModules/counter.sv',
        'BasicModules/delay.sv',
        'BasicModules/logical.sv',
        'BasicModules/multiplexer.sv',
        'BasicModules/register.sv',
        'BasicModules/relational.sv',
        'Bus/adder_subtractor.sv',
        'Bus/convert.sv',
        'Bus/multiplier.sv',
        'Bus/negate.sv',
        'Bus/scale.sv',
        'Delays/delay_bram.sv',
        'Delays/delay_srl.sv',
        'Delays/dual_port_ram.sv',
        'Delays/pipeline.sv',
        'Delays/rom.sv',
        'Delays/single_port_ram.sv',
        'Delays/sync_delay.sv',
        'Misc/convert_of.sv',
        'Multipliers/complex_multiplier.sv',
        'Reorder/barrel_switcher.sv',
        'Reorder/reorder.sv',
        'Reorder/square_transposer.sv',
        'FFTs/Twiddle/twiddle_coeff_0.sv',
        'FFTs/Twiddle/twiddle_coeff_1.sv',
        'FFTs/Twiddle/twiddle_general.sv',
        'FFTs/Twiddle/twiddle_pass_through.sv',
        'FFTs/Twiddle/twiddle_stage_2.sv',
        'FFTs/Internal/bi_real_unscr_4x.sv',
        'FFTs/Internal/complex_conj.sv',
        'FFTs/Internal/hilbert.sv',
        'FFTs/Internal/mirror_spectrum.sv',
        'FFTs/butterfly_direct.sv',
        'FFTs/fft_stage_n.sv',
        'FFTs/biplex_core.sv',
        'FFTs/fft_biplex_real_4x.sv',
        'FFTs/fft_direct.sv',
        'FFTs/fft_unscrambler.sv',
        'FFTs/fft_wideband_real.sv',
    ]

    @classmethod
    def _rtl_relpaths(cls, casper_dsp_root):
        paths = [os.path.join('rtl', f) for f in cls.RTL_SOURCES]
        missing = [f for f in paths if not os.path.isfile(os.path.join(casper_dsp_root, f))]
        if missing:
            raise FileNotFoundError('fft_wideband_real: missing casper_dsp sources: %s' % ', '.join(missing))
        return paths

    @staticmethod
    def _enable_val(status):
        # checkbox status is saved as 'on'/'off' (see mask.py's _convert_status)
        return 1 if str(status).strip().lower() in ('on', '1', 'true') else 0

    @staticmethod
    def _int(v):
        return int(float(v))

    def _bin_pt_in(self, input_bit_width):
        # mask convention: -1 means "input_bit_width - 1" (matches
        # check_valid_filename-style -1 sentinels used elsewhere in this
        # repo's casper_library ports)
        v = self._int(self.bin_pt_in)
        return input_bit_width - 1 if v < 0 else v

    @staticmethod
    def _parse_shift_schedule(s):
        # fft_wideband_real.sv's SHIFT_SCHEDULE is a single packed int (bit k
        # = stage k+1), not casper_library's MATLAB vector literal -- convert
        # a "[1 0 1]"/"[1,0,1]"/"" string into that bitmask, LSB = stage 1.
        s = str(s).strip().strip('[]')
        if not s:
            return 0
        val = 0
        for k, tok in enumerate(t for t in s.replace(',', ' ').split() if t != ''):
            if int(float(tok)) != 0:
                val |= (1 << k)
        return val

    @staticmethod
    def _parse_mult_spec(s):
        # declared-but-not-implemented (see fft_wideband_real.sv's header) --
        # casper_library allows a per-stage vector here ("left=1st stage, or
        # just one value"); since the HDL backend ignores this value
        # entirely, just take the first entry (or 2, the mask's own
        # default, if parsing fails) so passing a vector string never
        # errors out the build.
        s = str(s).strip().strip('[]')
        toks = [t for t in s.replace(',', ' ').split() if t != '']
        if not toks:
            return 2
        try:
            return int(float(toks[0]))
        except ValueError:
            return 2

    def _gen_mem_files(self, casper_dsp_root):
        script = os.path.join(casper_dsp_root, 'rtl', 'FFTs', 'scripts', 'gen_fft_mem_files.py')
        # the stored coefficient words depend on the cosin layout options, so
        # pass this block's values instead of the script's defaults; the add
        # latency is 2 with DSP48 adders (gen_twiddle_coeffs.coeff_options)
        add_latency = 2 if self._enable_val(self.dsp48_adders) else self._int(self.add_latency)
        latency_sum = self._int(self.mult_latency) + add_latency + self._int(self.conv_latency)
        cmd = [
            sys.executable, script, 'wideband_real',
            '--fft-size', str(self._int(self.FFTSize)),
            '--n-inputs', str(self._int(self.n_inputs)),
            '--coeff-bit-width', str(self._int(self.coeff_bit_width)),
            '--coeffs-bit-limit', str(self._int(self.coeffs_bit_limit)),
            '--coeff-sharing', str(self._enable_val(self.coeff_sharing)),
            '--coeff-decimation', str(self._enable_val(self.coeff_decimation)),
            '--coeff-generation', str(self._enable_val(self.coeff_generation)),
            '--latency-sum', str(latency_sum),
            '--cal-bits', str(self._int(self.cal_bits)),
            '-o', self.mem_dir,
        ]
        if self._enable_val(self.unscramble) == 0:
            cmd.append('--no-unscramble')
        subprocess.run(cmd, check=True, cwd=casper_dsp_root)

    def _generate_wrapper(self):
        # fft_wideband_real.sv's top-level din/dout_re/dout_im ports are
        # SystemVerilog unpacked arrays (e.g. `input logic [W-1:0] din [N]`).
        # jasper_library/verilog.py's Instance.add_port() connects a port to
        # a single named signal (optionally bit-sliced), not to a per-element
        # array binding -- every existing dsp_blocks/*.py module instantiates
        # modules with flat scalar/vector ports for exactly this reason. This
        # wrapper exposes flat per-lane ports (matching the .sci file's port
        # labels one-for-one) and packs/unpacks them into the real module's
        # array ports internally, so modify_top() below can connect to it
        # exactly like every other dsp_block does.
        n_streams = self._int(self.n_streams)
        n_inputs = self._int(self.n_inputs)
        fft_size = self._int(self.FFTSize)
        input_bit_width = self._int(self.input_bit_width)
        bitgrowth = self._enable_val(self.bitgrowth)
        max_bits = self._int(self.max_bits)

        self.n_in = n_streams << n_inputs
        self.n_out = n_streams << (n_inputs - 1)
        self.n_bits_out = (min(input_bit_width + fft_size, max_bits)
                            if bitgrowth else input_bit_width)
        self.of_width = max((n_streams << n_inputs) // 4, n_streams)
        self.wrapper_module = 'fft_wideband_real_wrap_%s' % self.unique_name

        L = []
        L.append("// auto-generated per-instance wrapper -- see fft_wideband_real.py's")
        L.append("// _generate_wrapper() for why this exists. Regenerated on every build,")
        L.append("// do not hand-edit.")
        L.append("module %s (" % self.wrapper_module)
        L.append("    input  logic clk,")
        L.append("    input  logic sync,")
        L.append("    input  logic [%d:0] shift," % (fft_size - 1))
        for s in range(n_streams):
            for n in range(2 ** n_inputs):
                L.append("    input  logic [%d:0] in%d_%d," % (input_bit_width - 1, s, n))
        L.append("    output logic sync_out,")
        for s in range(n_streams):
            for n in range(2 ** (n_inputs - 1)):
                L.append("    output logic [%d:0] out%d_%d_re," % (self.n_bits_out - 1, s, n))
                L.append("    output logic [%d:0] out%d_%d_im," % (self.n_bits_out - 1, s, n))
        L.append("    output logic [%d:0] of" % (self.of_width - 1))
        L.append(");")
        L.append("    logic [%d:0] din_arr     [%d];" % (input_bit_width - 1, self.n_in))
        L.append("    logic [%d:0] dout_re_arr [%d];" % (self.n_bits_out - 1, self.n_out))
        L.append("    logic [%d:0] dout_im_arr [%d];" % (self.n_bits_out - 1, self.n_out))
        for s in range(n_streams):
            for n in range(2 ** n_inputs):
                k = s * (2 ** n_inputs) + n
                L.append("    assign din_arr[%d] = in%d_%d;" % (k, s, n))
        for s in range(n_streams):
            for n in range(2 ** (n_inputs - 1)):
                k = s * (2 ** (n_inputs - 1)) + n
                L.append("    assign out%d_%d_re = dout_re_arr[%d];" % (s, n, k))
                L.append("    assign out%d_%d_im = dout_im_arr[%d];" % (s, n, k))
        L.append("")
        L.append("    fft_wideband_real #(")
        L.append("        .N_STREAMS(%d)," % n_streams)
        L.append("        .FFT_SIZE(%d)," % fft_size)
        L.append("        .N_INPUTS(%d)," % n_inputs)
        L.append("        .INPUT_BIT_WIDTH(%d)," % input_bit_width)
        L.append("        .BIN_PT_IN(%d)," % self._bin_pt_in(input_bit_width))
        L.append("        .COEFF_BIT_WIDTH(%d)," % self._int(self.coeff_bit_width))
        L.append("        .UNSCRAMBLE(%d)," % self._enable_val(self.unscramble))
        L.append("        .ADD_LATENCY(%d)," % self._int(self.add_latency))
        L.append("        .MULT_LATENCY(%d)," % self._int(self.mult_latency))
        L.append("        .BRAM_LATENCY(%d)," % self._int(self.bram_latency))
        L.append("        .CONV_LATENCY(%d)," % self._int(self.conv_latency))
        L.append("        .INPUT_LATENCY(%d)," % self._int(self.input_latency))
        L.append("        .BIPLEX_DIRECT_LATENCY(%d)," % self._int(self.biplex_direct_latency))
        L.append("        .QUANTIZATION(%d)," % self.QUANT_MAP.get(str(self.quantization), 1))
        L.append("        .OVERFLOW(%d)," % self.OVERFLOW_MAP.get(str(self.overflow), 1))
        L.append("        .DELAYS_BIT_LIMIT(%d)," % self._int(self.delays_bit_limit))
        L.append("        .COEFFS_BIT_LIMIT(%d)," % self._int(self.coeffs_bit_limit))
        L.append("        .MAX_FANOUT(%d)," % self._int(self.max_fanout))
        L.append("        .BITGROWTH(%d)," % bitgrowth)
        L.append("        .MAX_BITS(%d)," % max_bits)
        L.append("        .HARDCODE_SHIFTS(%d)," % self._enable_val(self.hardcode_shifts))
        L.append("        .SHIFT_SCHEDULE(%d)," % self._parse_shift_schedule(self.shift_schedule))
        # the RTL appends the file names directly ({MEM_DIR, "x.mem"}), so the
        # directory needs its trailing '/'
        L.append('        .MEM_DIR("%s/"),' % self.mem_dir)
        # declared-but-not-yet-implemented by the HDL backend (see
        # fft_wideband_real.sv's header comment and
        # mlib_devel_notes/fft_wideband_real_hdl_plan.md design decision 3)
        # -- still forwarded for full parameter-list traceability.
        L.append("        .ASYNC(%d)," % self._enable_val(getattr(self, 'async')))
        L.append("        .FLOATING_POINT(%d)," % self._enable_val(self.floating_point))
        L.append("        .FLOAT_TYPE(%d)," % self.FLOAT_TYPE_MAP.get(str(self.float_type), 0))
        L.append("        .EXP_WIDTH(%d)," % self._int(self.exp_width))
        L.append("        .FRAC_WIDTH(%d)," % self._int(self.frac_width))
        L.append("        .ADD_PIPE_LATENCY(%d)," % self._int(self.add_pipe_latency))
        L.append("        .MULT_PIPE_LATENCY(%d)," % self._int(self.mult_pipe_latency))
        L.append("        .COEFF_SHARING(%d)," % self._enable_val(self.coeff_sharing))
        L.append("        .COEFF_DECIMATION(%d)," % self._enable_val(self.coeff_decimation))
        L.append("        .COEFF_GENERATION(%d)," % self._enable_val(self.coeff_generation))
        L.append("        .CAL_BITS(%d)," % self._int(self.cal_bits))
        L.append("        .N_BITS_ROTATION(%d)," % self._int(self.n_bits_rotation))
        L.append("        .MULT_SPEC(%d)," % self._parse_mult_spec(self.mult_spec))
        L.append("        .DSP48_ADDERS(%d)" % self._enable_val(self.dsp48_adders))
        L.append("    ) u_fft (")
        L.append("        .clk(clk),")
        L.append("        .sync(sync),")
        L.append("        .shift(shift),")
        L.append("        .din(din_arr),")
        L.append("        .sync_out(sync_out),")
        L.append("        .dout_re(dout_re_arr),")
        L.append("        .dout_im(dout_im_arr),")
        L.append("        .of(of)")
        L.append("    );")
        L.append("endmodule")

        with open(os.path.join(self.hdl_wrapper_dir, self.wrapper_module + '.sv'), 'w') as f:
            f.write('\n'.join(L) + '\n')

    def modify_top(self, top):
        self._populate_parent_ports(top)
        inst = top.get_instance(entity=self.wrapper_module, name=self.fullname)
        n_streams = self._int(self.n_streams)
        n_inputs = self._int(self.n_inputs)
        fft_size = self._int(self.FFTSize)
        input_bit_width = self._int(self.input_bit_width)

        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('sync', self.fullname + '_sync', parent_port=False, width=1, dir='in')
        inst.add_port('shift', self.fullname + '_shift', parent_port=False, width=fft_size, dir='in')
        for s in range(n_streams):
            for n in range(2 ** n_inputs):
                pname = 'in%d_%d' % (s, n)
                inst.add_port(pname, self.fullname + '_' + pname, parent_port=False,
                              width=input_bit_width, dir='in')
        inst.add_port('sync_out', self.fullname + '_sync_out', parent_port=False, width=1, dir='out')
        for s in range(n_streams):
            for n in range(2 ** (n_inputs - 1)):
                pre = 'out%d_%d_re' % (s, n)
                pim = 'out%d_%d_im' % (s, n)
                inst.add_port(pre, self.fullname + '_' + pre, parent_port=False,
                              width=self.n_bits_out, dir='out')
                inst.add_port(pim, self.fullname + '_' + pim, parent_port=False,
                              width=self.n_bits_out, dir='out')
        inst.add_port('of', self.fullname + '_of', parent_port=False, width=self.of_width, dir='out')

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
