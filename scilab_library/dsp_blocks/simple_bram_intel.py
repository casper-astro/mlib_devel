from .yellow_block import YellowBlock
from .yellow_block_typecodes import *
from memory import Register

class simple_bram_intel(YellowBlock):
	def initialize(self):
		self.typecode = TYPECODE_BRAM
		self.add_source('simple_bram_intel')

		self.data_width = int(self.data_width)
		self.addr_width = int(self.addr_width)

		if self.data_width % 8 != 0:
			raise RuntimeError("simple_bram_intel data_width must be a multiple of 8")

		self.depth = 1 << self.addr_width
		self.nbytes = self.depth * (self.data_width // 8)

		self.memory_map = [Register('mem', mode='rw', offset=0, nbytes=self.nbytes, data_width=self.data_width, ram=True, default_val=0 )]
	
	def modify_top(self, top):
		if not top.does_signal_exist('user_clk'):
			top.add_signal('user_clk', width=0)
			top.assign_signal('user_clk', 'axil_clk')

		#if not top.does_signal_exist('user_rst'):
		#	top.add_signal('user_rst', width=0)
		#	top.assign_signal('user_rst', '~axil_rst_n')

		top.add_axi4lite_interface(
			self.unique_name,
			mode='rw',
			nbytes=self.nbytes,
			memory_map=self.memory_map,
			typecode=self.typecode,
			data_width=self.data_width
		)

		inst = top.get_instance('simple_bram_intel', self.fullname)
		inst.add_parameter('DATA_WIDTH', self.data_width)
		inst.add_parameter('ADDR_WIDTH', self.addr_width)

		inst.add_port('wr_clk',  'user_clk')
		#inst.add_port('wr_rst',  'user_rst')
		inst.add_port('wr_rst',  '~axil_rst_n', parent_sig=False)
		inst.add_port('wr_en',   f'{self.fullname}_wr_en',   width=1, dir='in')
		inst.add_port('wr_data', f'{self.fullname}_wr_data', width=self.data_width, dir='in')

		inst.add_port('rd_clk',   'user_clk')
		inst.add_port('rd_addr',  f'{self.unique_name}_mem_addr', width=self.addr_width, dir='in')
		inst.add_port('rd_data', f'{self.unique_name}_mem_data_out', width=self.data_width, dir='out')		
		
		#inst.add_port('mem_wdata', f'{self.unique_name}_mem_data_in', width=self.data_width, dir='in')
		#inst.add_port('mem_we',    f'{self.unique_name}_mem_we', width=1, dir='in')
		#inst.add_port('mem_rdata', f'{self.unique_name}_mem_data_out', width=self.data_width, dir='out')
