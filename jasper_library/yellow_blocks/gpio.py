from yellow_block import YellowBlock
from verilog import VerilogInstance
from constraints import PortConstraint
from helpers import to_int_list

class gpio(YellowBlock):
    def initialize(self):
        if self.arith_type == 'Boolean':
            # The yellow block will set a value for bitwidth,
            # override it here if the data type is boolean.
            self.bitwidth = 1
        else:
            self.bitwidth = int(self.bitwidth)

        # If we're DDRing, we only need half the number of pins...
        if self.use_ddr:
            self.pad_bitwidth = self.bitwidth / 2
        else:
            self.pad_bitwidth = self.bitwidth

        self.io_group = self.io_group.split(':')[-1] #iogroups have the form PLATFORM:GROUP (now would be a good time to change this!)
        self.use_diffio = ((self.io_group in ['zdok0','zdok1','mdr','qsh','sync_in','sync_out']) and (self.use_single_ended == 'off'))

        # Set the module we need to instantiate
        if self.use_diffio:
            if self.io_dir == 'in':
                self.module = 'diffgpio_ext2simulink'
            elif self.io_dir == 'out':
                self.module = 'diffgpio_simulink2ext'
        else:
            if self.io_dir == 'in':
                self.module = 'gpio_ext2simulink'
            elif self.io_dir == 'out':
                self.module = 'gpio_simulink2ext'
        # add the source files, which have the same name as the module
        self.add_source(self.module)

    def modify_top(self,top):
        external_port_name = self.fullname + '_ext'
        top.add_port(external_port_name, self.io_dir, width=self.pad_bitwidth) 

        inst = VerilogInstance(entity=self.module, name=self.fullname, comment=self.fullname)
        inst.add_port('clk','user_clk')
        inst.add_port('clk90','user_clk90')
        inst.add_port('gateway','%s_gateway'%self.fullname)
        inst.add_port('io_pad', external_port_name)
        inst.add_parameter('CLK_PHASE', self.reg_clk_phase)
        inst.add_parameter('WIDTH', str(self.bitwidth))
        inst.add_parameter('DDR', '1' if self.use_ddr == 'on' else '0')
        inst.add_parameter('REG_IOB', '"true"' if self.reg_iob == 'on' else '"false"')

        top.add_instance(inst)
        top.add_signal('%s_gateway'%self.fullname, width=self.bitwidth, comment='%s hookup'%self.fullname)

    def gen_constraints(self):
        return [PortConstraint(self.fullname+'_ext', iogroup=self.io_group, index=to_int_list(self.bit_index))]
