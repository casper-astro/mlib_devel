from yellow_block import YellowBlock
from verilog import VerilogInstance

class bram(YellowBlock):
    def initialize(self):
        '''
        This function is called by YellowBlocks __init__ method.
        We could override __init__ here, but this seems a little
        bit more user friendly.
        '''
        self.platform_support = 'all'
        self.requirements = ['wb_clk']
        self.add_source('wb_bram')
        # Add these when creating the simulink yellow block
        self.width = 32 #bits
        self.addr_bits = 10
        self.depth = 2**self.addr_bits

    def modify_top(self,top):
        module = 'wb_bram'
        inst = VerilogInstance(entity=module, name=self.fullname, comment=self.fullname)
        inst.add_wb_interface(nbytes=self.depth*self.width/4) #width is in bits
        inst.add_port('user_clk', 'user_clk')
        inst.add_port('user_addr', '%s_user_addr'%self.fullname)
        inst.add_port('user_din', '%s_user_din'%self.fullname)
        inst.add_port('user_we', '%s_user_we'%self.fullname)
        inst.add_port('user_dout','%s_user_dout'%self.fullname)
        top.add_instance(inst)
        top.add_signal('%s_user_din'%self.fullname,  width=self.width, comment=self.fullname)
        top.add_signal('%s_user_addr'%self.fullname, width=self.addr_bits, comment=self.fullname)
        top.add_signal('%s_user_we'%self.fullname,   comment=self.fullname)
        top.add_signal('%s_user_dout'%self.fullname, width=self.width, comment=self.fullname
        
