from yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint

class lmx2581(YellowBlock):
    def initialize(self):
        self.requires = ['lmx2581']
        self.add_source('lmx2581_controller')

    def modify_top(self, top):
        module = 'lmx2581_controller'
        inst = top.get_instance(entity=module, name=module+'_inst', comment='LMX2581 synthesizer controller')

        inst.add_port('lmx_clk', 'lmx_clk', dir='out', parent_port='True')
        inst.add_port('lmx_data', 'lmx_data', dir='out', parent_port='True')
        inst.add_port('lmx_le', 'lmx_le', dir='out', parent_port='True')
        inst.add_port('lmx_ce', 'lmx_ce', dir='out', parent_port='True')
        inst.add_port('lmx_be', 'lmx_be', dir='out', parent_port='True')
        inst.add_port('lmx_muxout', 'lmx_muxout', dir='in', parent_port='True')
        inst.add_wb_interface(nbytes=4, regname='lmx_ctrl', mode='rw')

    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('lmx_clk', 'lmx2581_clk'))
        cons.append(PortConstraint('lmx_data', 'lmx2581_data'))
        cons.append(PortConstraint('lmx_le', 'lmx2581_le'))
        cons.append(PortConstraint('lmx_ce', 'lmx2581_ce'))
        cons.append(PortConstraint('lmx_be', 'lmx2581_be'))
        cons.append(PortConstraint('lmx_muxout', 'lmx2581_muxout'))
        return cons
