from .yellow_block import YellowBlock
from verilog import VerilogModule
from .yellow_block_typecodes import *

from math import ceil, floor
from os import environ as env

class xil_device(YellowBlock):
    def initialize(self):
        self.typecode = TYPECODE_BRAM

    def modify_top(self, top):
        dev = top.add_xil_axi4lite_interface(self.unique_name, mode='rw', nbytes=self.memsize, typecode=self.typecode)
        dev.base_addr = self.baseaddr

    def gen_constraints(self):
        cons=[]
        return cons