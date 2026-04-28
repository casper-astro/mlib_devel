from .dsp_block import DSPBlock
from memory import Register
from yellow_block_typecodes import *


class snapshot(DSPBlock):
    def initialize(self):
        self.platform_support = 'all'
        self.typecode = TYPECODE_BRAM

        self.add_source('snapshot/*')
        raw_data_width = getattr(self, 'data_width', None)
        if raw_data_width is None:
            raw_data_width = getattr(self, 'bit_width', None)
        if raw_data_width is None:
            raw_data_width = getattr(self, 'bitwidth', 32)

        raw_addr_width = getattr(self, 'addr_width', 10)

        self.data_width = int(raw_data_width)
        self.addr_width = int(raw_addr_width)

        if self.data_width % 8 != 0:
            raise RuntimeError("snapshot data_width must be a multiple of 8")

        self.depth = 1 << self.addr_width
        self.nbytes = self.depth * (self.data_width // 8)
        self.mem_offset = max(0x100, self.nbytes)

        self.memory_map = [
            Register('busy', mode='r', offset=0x0, default_val=0),
            Register('done', mode='r', offset=0x4, default_val=0),
            Register(
                'mem',
                mode='r',
                offset=self.mem_offset,
                nbytes=self.nbytes,
                data_width=self.data_width,
                ram=True,
                default_val=0,
            ),
        ]

    def _ensure_signal(self, top, name, width, default=None):
        if not top.does_signal_exist(name):
            top.add_signal(name, width=width)
            if default is not None:
                top.assign_signal(name, default)

    def modify_top(self, top):
        self._populate_parent_ports(top)

        if not top.does_signal_exist('user_clk'):
            top.add_signal('user_clk', width=0)
            top.assign_signal('user_clk', 'axil_clk')

        input_defaults = [
            (f'{self.fullname}_din', self.data_width, None),
            (f'{self.fullname}_we', 1, None),
            (f'{self.fullname}_trig', 1, None),
            (f'{self.fullname}_arm', 1, None),
            (f'{self.fullname}_rst', 1, None),
        ]
        for name, width, default in input_defaults:
            self._ensure_signal(top, name, width, default)

        self._ensure_signal(top, f'{self.fullname}_busy', 1)
        self._ensure_signal(top, f'{self.fullname}_done', 1)
        top.add_axi4lite_interface(
            self.unique_name,
            mode='r',
            nbytes=self.mem_offset + self.nbytes,
            memory_map=self.memory_map,
            typecode=self.typecode,
            data_width=self.data_width,
        )

        self._ensure_signal(top, f'{self.unique_name}_busy_in', 32)
        top.assign_signal(
            f'{self.unique_name}_busy_in',
            "{{31{1'b0}}, %s}" % (f'{self.fullname}_busy')
        )
        self._ensure_signal(top, f'{self.unique_name}_busy_in_we', 1)
        top.assign_signal(f'{self.unique_name}_busy_in_we', "1'b1")

        self._ensure_signal(top, f'{self.unique_name}_done_in', 32)
        top.assign_signal(
            f'{self.unique_name}_done_in',
            "{{31{1'b0}}, %s}" % (f'{self.fullname}_done')
        )
        self._ensure_signal(top, f'{self.unique_name}_done_in_we', 1)
        top.assign_signal(f'{self.unique_name}_done_in_we', "1'b1")

        self._ensure_signal(top, f'{self.fullname}_dout', self.data_width)
        top.assign_signal(f'{self.fullname}_dout', f'{self.unique_name}_mem_data_out')

        inst = top.get_instance('snapshot', self.fullname)
        inst.add_parameter('DATA_WIDTH', self.data_width)
        inst.add_parameter('ADDR_WIDTH', self.addr_width)

        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('rst', f'{self.fullname}_rst', width=1, dir='in', parent_port=False)
        inst.add_port('din', f'{self.fullname}_din', width=self.data_width, dir='in', parent_port=False)
        inst.add_port('we', f'{self.fullname}_we', width=1, dir='in', parent_port=False)
        inst.add_port('trig', f'{self.fullname}_trig', width=1, dir='in', parent_port=False)
        inst.add_port('arm', f'{self.fullname}_arm', width=1, dir='in', parent_port=False)
        inst.add_port('busy', f'{self.fullname}_busy', width=1, dir='out', parent_port=False)
        inst.add_port('done', f'{self.fullname}_done', width=1, dir='out', parent_port=False)
        inst.add_port('mem_addr', f'{self.unique_name}_mem_addr', width=self.addr_width, dir='out', parent_port=False)
        inst.add_port('mem_wdat', f'{self.unique_name}_mem_data_in', width=self.data_width, dir='out', parent_port=False)
        inst.add_port('mem_we', f'{self.unique_name}_mem_we', width=1, dir='out', parent_port=False)
