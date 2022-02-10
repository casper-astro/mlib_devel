from .yellow_block import YellowBlock

class sysmon(YellowBlock):
    def initialize(self):
        '''
        This function is called by YellowBlocks __init__ method.
        We could override __init__ here, but this seems a little
        bit more user friendly.
        '''
        self.platform_support = 'all'
        self.requirements = ['wb_clk']
        self.add_source('sysmon/sysmon.v')

    def modify_top(self,top):
        module = 'sysmon'
        inst = top.get_instance(entity=module, name='sysmon_inst')
        inst.add_wb_interface(regname='sysmon', mode='rw', nbytes=1024)
