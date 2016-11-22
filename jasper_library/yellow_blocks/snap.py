from yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint

class snap(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure')
        self.add_source('wbs_arbiter')
        self.use_microblaze = False
    def modify_top(self,top):
        inst = top.get_instance('snap_infrastructure', 'snap_infrastructure_inst')
        inst.add_port('sys_clk_buf_n', 'sys_clk_n', parent_port=True, dir='in')
        inst.add_port('sys_clk_buf_p', 'sys_clk_p', parent_port=True, dir='in')
        inst.add_port('sys_clk0     ', 'sys_clk   ')
        inst.add_port('sys_clk180   ', 'sys_clk180')
        inst.add_port('sys_clk270   ', 'sys_clk270')
        inst.add_port('clk_200      ', 'clk_200   ')
        inst.add_port('sys_rst      ', 'sys_rst   ')
        inst.add_port('idelay_rdy   ', 'idelay_rdy')

        top.add_signal('sys_clk90')
        top.assign_signal('sys_clk90', '~sys_clk270')

    def gen_children(self):
        children = [YellowBlock.make_block({'tag':'xps:sys_block', 'board_id':'12', 'rev_maj':'12', 'rev_min':'0', 'rev_rcs':'32'}, self.platform)]
        children += [YellowBlock.make_block({'tag':'xps:xadc'}, self.platform)]
        if self.use_microblaze:
            children.append(YellowBlock.make_block({'tag':'xps:microblaze'}, self.platform))
        else:
            children.append(YellowBlock.make_block({'tag':'xps:spi_wb_bridge'}, self.platform))
        return children

    def gen_constraints(self):
        return [
            PortConstraint('sys_clk_n', 'sys_clk_n'),
            PortConstraint('sys_clk_p', 'sys_clk_p'),
            ClockConstraint('sys_clk_p', period=5.0),
        ]
