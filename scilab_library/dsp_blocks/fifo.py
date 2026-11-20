import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class fifo(DSPBlock):
    # Xilinx FIFO block on casper_dsp's BasicModules/fifo.sv (self-contained,
    # it instantiates no other module). The GUI values are the Simulink mask
    # values; they map onto fifo.sv's integer encodings.
    SRC = 'casper_dsp/rtl/BasicModules/fifo.sv'
    MEM_TYPE_MAP = {'Block RAM': 0, 'Distributed RAM': 1, 'Shift Register': 2, 'Built-in FIFO': 3}
    PERFORMANCE_OPTIONS_MAP = {'Standard_FIFO': 0, 'First_Word_Fall_Through': 1}
    # depth listbox suffixes: 1K = 1024, 1M = 1048576
    DEPTH_SUFFIX = {'K': 1024, 'M': 1048576}

    def initialize(self):
        self.add_source(self.SRC)

    @staticmethod
    def _enable_val(status):
        # checkbox status is saved as 'on'/'off' (see mask.py's _convert_status)
        return 1 if str(status).strip().lower() in ('on', '1', 'true') else 0

    @classmethod
    def depth_words(cls, depth):
        """Number of words of a depth listbox value ('16' .. '512', '1K' ..
        '4M'; val_format_conv turns the plain numbers into int)."""
        val = str(depth).strip().upper()
        if val and val[-1] in cls.DEPTH_SUFFIX:
            return int(val[:-1]) * cls.DEPTH_SUFFIX[val[-1]]
        return int(float(val))

    def _n_bits(self):
        return int(float(self.n_bits))

    def _fwft(self):
        return self.PERFORMANCE_OPTIONS_MAP[self.performance_options]

    def dcount_width(self):
        """fifo.sv's DCOUNT_WIDTH: log2(depth), one more bit in FWFT mode."""
        return (self.depth_words(self.depth) - 1).bit_length() + self._fwft()

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'fifo'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters -- one per fifo.sv parameter, in declaration order
        inst.add_parameter("DATA_WIDTH", "%d" % self._n_bits())
        inst.add_parameter("MEM_TYPE", "%d" % self.MEM_TYPE_MAP[self.mem_type])
        inst.add_parameter("PERFORMANCE_OPTIONS", "%d" % self._fwft())
        inst.add_parameter("EMBEDDED_REGISTERS", "%d" % self._enable_val(self.embedded_registers))
        inst.add_parameter("DEPTH", "%d" % self.depth_words(self.depth))
        inst.add_parameter("PERCENT_NBITS", "%d" % int(float(self.percent_nbits)))
        inst.add_parameter("RST", "%d" % self._enable_val(self.rst))
        inst.add_parameter("RST_LATENCY", "%d" % int(float(self.rst_latency)))
        inst.add_parameter("EN", "%d" % self._enable_val(self.en))
        inst.add_parameter("USE_DCOUNT", "%d" % self._enable_val(self.use_dcount))
        inst.add_parameter("USE_PERCENT_FULL_PORT", "%d" % self._enable_val(self.use_percent_full_port))
        inst.add_parameter("USE_ALMOST_EMPTY", "%d" % self._enable_val(self.use_almost_empty))
        inst.add_parameter("ALMOST_EMPTY_THRESH", "%d" % int(float(self.almost_empty_thresh)))
        inst.add_parameter("USE_ALMOST_FULL", "%d" % self._enable_val(self.use_almost_full))
        inst.add_parameter("ALMOST_FULL_THRESH", "%d" % int(float(self.almost_full_thresh)))
        inst.add_parameter("USE_RD_RST_BUSY", "%d" % self._enable_val(self.use_rd_rst_busy))
        inst.add_parameter("USE_WR_RST_BUSY", "%d" % self._enable_val(self.use_wr_rst_busy))
        # add ports -- names match fifo.sv's port list; the optional ones
        # follow fifo.sci's port lists (fifo_in_ports / fifo_out_ports).
        # rst / en are tied off when their option is off rather than relying
        # on fifo.sv's port defaults; disabled outputs are left unconnected
        # (fifo.sv drives them 0).
        inst.add_port('clk', 'user_clk', dir='in')
        ports = self.in_ports()
        for name, width in ports:
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='in')
        names = [name for name, _ in ports]
        if 'rst' not in names:
            inst.add_port('rst', "1'b0", dir='in')
        if 'en' not in names:
            inst.add_port('en', "1'b1", dir='in')
        for name, width in self.out_ports():
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='out')

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order: din, we, re,
        then rst and en when their option is on (Simulink order)."""
        ports = [('din', self._n_bits()), ('we', 1), ('re', 1)]
        if self._enable_val(self.rst):
            ports += [('rst', 1)]
        if self._enable_val(self.en):
            ports += [('en', 1)]
        return ports

    def out_ports(self):
        """(name, width) of the output ports, in Xcos port order: dout, empty,
        [percent_full], full, [dcount], [ae], [af], [rd_rst_busy],
        [wr_rst_busy] -- the optional ones only when their option is on
        (Simulink order; percent_full is Simulink's %full)."""
        ports = [('dout', self._n_bits()), ('empty', 1)]
        if self._enable_val(self.use_percent_full_port):
            ports += [('percent_full', int(float(self.percent_nbits)))]
        ports += [('full', 1)]
        if self._enable_val(self.use_dcount):
            ports += [('dcount', self.dcount_width())]
        if self._enable_val(self.use_almost_empty):
            ports += [('ae', 1)]
        if self._enable_val(self.use_almost_full):
            ports += [('af', 1)]
        if self._enable_val(self.use_rd_rst_busy):
            ports += [('rd_rst_busy', 1)]
        if self._enable_val(self.use_wr_rst_busy):
            ports += [('wr_rst_busy', 1)]
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
