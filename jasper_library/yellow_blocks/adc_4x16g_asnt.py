from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint

from math import ceil, floor

class adc_4x16g_asnt(YellowBlock):
    def initialize(self):
    
    
    def modify_top(self,top):
        module = 'adc_4x16g_asnt_interface'
        
    def gen_constraints(self):
        cons = []
        
        return cons
    