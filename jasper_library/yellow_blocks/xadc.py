from yellow_block import YellowBlock
from constraints import PortConstraint

class xadc(YellowBlock):
    def initialize(self):
        '''
        This function is called by YellowBlocks __init__ method.
        We could override __init__ here, but this seems a little
        bit more user friendly.
        '''
        self.platform_support = 'all'
        self.requirements = ['wb_clk']
        self.add_source('xadc/xadc.v')
        self.add_source('xadc/xadc_wiz_0.xci')

    def modify_top(self,top):
        module = 'xadc'
        inst = top.get_instance(entity=module, name='xadc_inst', comment=self.fullname)
        inst.add_wb_interface(regname='xadc', mode='rw', nbytes=512)
        #inst.add_port('vp_in', 'xadc_vp_in', parent_port=True, dir='in')
        #inst.add_port('vn_in', 'xadc_vp_in', parent_port=True, dir='in')

    def gen_constraints(self):
        consts = []
        #consts += [PortConstraint('xadc_vp_in', 'xadc_p')]
        #consts += [PortConstraint('xadc_vn_in', 'xadc_n')]
        return consts
        
