from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint

from math import ceil, floor

class adc4x16g(YellowBlock):
    def initialize(self):
    
    
    def modify_top(self,top):
        module = 'adc4x16g_interface'
        
    def gen_constraints(self):
        cons = []
        
        return cons
    