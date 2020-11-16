from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint

from math import ceil, floor

class adc_4x16g_asnt(YellowBlock):
    def initialize(self):
        #add the adc4x16g IP 
        self.ips = [{'path':'%s/adc4x16g/ip_repo_0' % env['HDL_ROOT'],
                     'name':'adc4x16g_core',
                     'vendor':'xilinx.com',
                     'library':'user',
                     'version':'1.1',
                    }]
    
    def modify_top(self,top):
        module = 'adc4x16g_adc4x16g_core_0_0'
        inst = top.get_instance(entity=module, 'adc4x16g_adc4x16g_inst%d'%self.channel_sel)
        
    def gen_constraints(self):
        cons = []
        
        return cons
    