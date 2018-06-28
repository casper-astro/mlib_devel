from yellow_block import YellowBlock
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

        if ':' in self.io_group:
            self.io_group = self.io_group.split(':')[-1] #iogroups have the form PLATFORM:GROUP (now would be a good time to change this!)
        # provide an override if the user is using a custom IO bank name
        if self.io_group == 'custom':
            self.io_group = self.io_group_custom
        self.use_diffio = ((self.io_group in ['zdok0','zdok1','mdr','qsh','sync_in','sync_out']) and not self.use_single_ended)

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
        #top.add_port(external_port_name, self.io_dir, width=self.pad_bitwidth) 

        inst = top.get_instance(entity=self.module, name=self.fullname, comment=self.fullname)
        inst.add_port('clk', signal='user_clk', parent_sig=False)
        inst.add_port('clk90', signal='user_clk90', parent_sig=False)
        inst.add_port('gateway', signal='%s_gateway'%self.fullname, width=self.bitwidth)
        if self.use_diffio:
            inst.add_port('io_pad_p', signal=external_port_name + '_p', dir=self.io_dir, width=self.pad_bitwidth, parent_port=True)
            inst.add_port('io_pad_n', signal=external_port_name + '_n', dir=self.io_dir, width=self.pad_bitwidth, parent_port=True)
        else:
            inst.add_port('io_pad', signal=external_port_name, dir=self.io_dir, width=self.pad_bitwidth, parent_port=True)
        inst.add_parameter('CLK_PHASE', self.reg_clk_phase)
        inst.add_parameter('WIDTH', str(self.bitwidth))
        inst.add_parameter('DDR', '1' if self.use_ddr  else '0')
        inst.add_parameter('REG_IOB', '"true"' if self.reg_iob else '"false"')

    def gen_constraints(self):
        if self.use_diffio:
            const = []
            const += [PortConstraint(self.fullname+'_ext_p', self.io_group + '_p', port_index=range(self.bitwidth), iogroup_index=to_int_list(self.bit_index))]
            const += [PortConstraint(self.fullname+'_ext_n', self.io_group + '_n', port_index=range(self.bitwidth), iogroup_index=to_int_list(self.bit_index))]
            return const
        else:
            return [PortConstraint(self.fullname+'_ext', self.io_group, port_index=range(self.bitwidth), iogroup_index=to_int_list(self.bit_index))]
