from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint

class clock_passthrough(YellowBlock):
    def initialize(self):
        self.add_source('clock_passthrough')
        self.platform_support = ['mx175']

    def modify_top(self, top):
        module = 'clock_passthrough'
        inst = top.get_instance(entity=module, name=module+'_inst', comment='Differential clock passthrough')
        inst.add_port('user_clock_p', 'pt_clk_in_p', dir='in', parent_port=True)
        inst.add_port('user_clock_n', 'pt_clk_in_n', dir='in', parent_port=True)
        inst.add_port('clock_out_p', 'pt_clk_out_p', dir='out', parent_port=True)
        inst.add_port('clock_out_n', 'pt_clk_out_n', dir='out', parent_port=True)

    def gen_constraints(self):
        cons = []
        if self.platform.name == 'mx175':
            cons.append(PortConstraint('pt_clk_in_p', 'user_clock_p'))
            cons.append(PortConstraint('pt_clk_in_n', 'user_clock_n'))
            cons.append(PortConstraint('pt_clk_out_p', 'si5324_out_p'))
            cons.append(PortConstraint('pt_clk_out_n', 'si5324_out_n'))
            cons.append(ClockConstraint('pt_clk_in_p', name='pt_clk_in_p_clk', freq=156.25))
        return cons
