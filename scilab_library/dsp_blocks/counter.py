import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class counter(DSPBlock):
    # GUI values ("Free Running"/"Count Limited", "Up"/"Down"/"Up/Down") map
    # onto counter.sv's COUNTER_TYPE/COUNT_DIR integer encodings.
    COUNTER_TYPE_MAP = {'Free Running': 0, 'Count Limited': 1}
    COUNT_DIR_MAP = {'Up': 0, 'Down': 1, 'Up/Down': 2}

    def initialize(self):
        self.add_source('casper_dsp/rtl/BasicModules/counter.sv')

    @staticmethod
    def _enable_val(status):
        # checkbox status is saved as 'on'/'off' (see mask.py's _convert_status)
        return 1 if str(status).strip().lower() in ('on', '1', 'true') else 0

    def _load_val(self):
        # a Count Limited counter has no load port (as in Simulink; the
        # dialog disables the option), so ignore a stored 'on'
        return self._enable_val(self.enable_load) if self.counter_type == 'Free Running' else 0

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'counter'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters -- one per counter.sv parameter, in the same order
        # they're declared there; plain decimals, as the RTL parameters are
        # int and may be negative (a sized 32'd-1 is a syntax error)
        inst.add_parameter("COUNTER_TYPE", "%d" % self.COUNTER_TYPE_MAP[self.counter_type])
        inst.add_parameter("NBITS", "%d" % int(self.n_bits))
        inst.add_parameter("COUNT_TO_VAL", "%d" % int(self.count_to_val))
        inst.add_parameter("COUNT_DIR", "%d" % self.COUNT_DIR_MAP[self.count_dir])
        inst.add_parameter("INIT_VAL", "%d" % int(self.init_val))
        inst.add_parameter("STEP", "%d" % int(self.step))
        inst.add_parameter("BIN_P", "%d" % int(self.bin_pt))
        inst.add_parameter("ENABLE_LOAD", "%d" % self._load_val())
        inst.add_parameter("ENABLE_SYNC_RST", "%d" % self._enable_val(self.enable_sync_rst))
        inst.add_parameter("ENABLE_ENABLE", "%d" % self._enable_val(self.enable_enable))
        # add ports -- names match counter.sv's port list exactly, and the
        # optional ones follow counter.sci's port list (counter_in_ports)
        inst.add_port('clk', 'user_clk', dir='in')
        ports = self.in_ports()
        for name, width in ports:
            inst.add_port(name, self.fullname + '_' + name, parent_port=False, width=width, dir='in')
        # counter.sv's rst / enable have no default value: tie them off when
        # their option is off (the RTL ignores them then); load / din / up
        # keep their defaults 0 / 0 / 1
        names = [name for name, _ in ports]
        for name in ('rst', 'enable'):
            if name not in names:
                inst.add_port(name, "1'b0", dir='in')
        inst.add_port('dout', self.fullname+'_dout', parent_port=False, width=int(self.n_bits), dir='out')

    def in_ports(self):
        """(name, width) of the input ports, in Xcos port order: only those
        whose option is on, in the Simulink order up, load, din, rst, enable."""
        ports = []
        if self.COUNT_DIR_MAP[self.count_dir] == 2:
            ports += [('up', 1)]
        if self._load_val():
            ports += [('load', 1), ('din', int(self.n_bits))]
        if self._enable_val(self.enable_sync_rst):
            ports += [('rst', 1)]
        if self._enable_val(self.enable_enable):
            ports += [('enable', 1)]
        return ports

    def generate_compile_order(self):
        fullpath = self.hdl_root + '/'
        co = {
            'lib': 'xil_defaultlib',
            'modules': [
                fullpath + 'casper_dsp/rtl/BasicModules/counter.sv'
            ],
            'fullpath': True
        }
        self.compile_order['verilog'].append(co)
