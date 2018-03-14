from yellow_block import YellowBlock
from constraints import PortConstraint, MaxDelayConstraint, MinDelayConstraint, FalsePathConstraint
from helpers import to_int_list, SkarabLedError

class gpio(YellowBlock):
    def initialize(self):

        self.skarab_leds = False
        self.multiple_leds = False

        if self.arith_type == 'Boolean':
            # The yellow block will set a value for bitwidth,
            # override it here if the data type is boolean.
            self.bitwidth = 1
        else:
            self.bitwidth = int(self.bitwidth)
            # There is error-checking behind this
            self.multiple_leds = True

        # If we're DDRing, we only need half the number of pins...
        if self.use_ddr:
            self.pad_bitwidth = self.bitwidth / 2
        else:
            self.pad_bitwidth = self.bitwidth

        if self.io_group == 'SKARAB:led':
            # We have SKARAB LEDs - workflow needs to change
            self.skarab_leds = True
        
        self.io_group = self.io_group.split(':')[-1] #iogroups have the form PLATFORM:GROUP (now would be a good time to change this!)
        
        self.use_diffio = ((self.io_group in ['zdok0','zdok1','mdr','qsh','sync_in','sync_out', 'aux_clk_diff']) and not self.use_single_ended)

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
        instance_name = self.fullname
        gateway_name = '{}_gateway'.format(self.fullname)

        inst = top.get_instance(entity=self.module, name=instance_name, comment=self.fullname)
        inst.add_parameter('CLK_PHASE', self.reg_clk_phase)
        inst.add_port('clk', signal='user_clk', parent_sig=False)
        inst.add_port('clk90', signal='user_clk90', parent_sig=False)
        inst.add_port('gateway', signal=gateway_name, width=self.bitwidth)
        inst.add_parameter('WIDTH', str(self.bitwidth))
        inst.add_parameter('DDR', '1' if self.use_ddr  else '0')
        inst.add_parameter('REG_IOB', '"true"' if self.reg_iob else '"false"')

        if self.skarab_leds:
            if self.multiple_leds:
                led_list = to_int_list(self.bit_index)
                led_list.sort()
                led_list.reverse()

                led_name = '{'
                for index in range(0,len(led_list)-1):
                    led_name += 'dsp_leds_i[{}],'.format(str(led_list[index]))
                led_name += 'dsp_leds_i[%s]}' % (str(led_list[-1]))
            else:
                # Only one LED to account for
                led_name = 'dsp_leds_i[%s]' % str(self.bit_index)
            
            inst.add_port('io_pad', signal=led_name, width=self.pad_bitwidth, parent_sig=False, parent_port=False)
            inst.add_parameter('PORT_BYPASS', '1')
        else:
            # Just dealing with normal GPIOs
            external_port_name = self.fullname + '_ext'
            
            if self.use_diffio:
                inst.add_port('io_pad_p', signal=external_port_name + '_p', dir=self.io_dir, width=self.pad_bitwidth, parent_port=True)
                inst.add_port('io_pad_n', signal=external_port_name + '_n', dir=self.io_dir, width=self.pad_bitwidth, parent_port=True)
            else:
                inst.add_port('io_pad', signal=external_port_name, dir=self.io_dir, width=self.pad_bitwidth, parent_port=True)
        
    def gen_constraints(self):
        if self.use_diffio:
            const = []
            const += [PortConstraint(self.fullname+'_ext_p', self.io_group + '_p', port_index=range(self.bitwidth), iogroup_index=to_int_list(self.bit_index))]
            const += [PortConstraint(self.fullname+'_ext_n', self.io_group + '_n', port_index=range(self.bitwidth), iogroup_index=to_int_list(self.bit_index))]
            #Constrain the I/O (it is assumed that this I/O is not timing critical and set_false_path is used)
            #NB: The set_max_delay and set_min_delay is important as Vivado will report that these signals are not
            #constrained without it
            if self.io_dir == 'in':
                const += [MaxDelayConstraint(sourcepath='[get_ports {%s_ext_p[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [MaxDelayConstraint(sourcepath='[get_ports {%s_ext_n[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [MinDelayConstraint(sourcepath='[get_ports {%s_ext_p[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [MinDelayConstraint(sourcepath='[get_ports {%s_ext_n[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [FalsePathConstraint(sourcepath='[get_ports {%s_ext_p[*]}]' % self.fullname)]
                const += [FalsePathConstraint(sourcepath='[get_ports {%s_ext_n[*]}]' % self.fullname)]

            elif self.io_dir == 'out':
                const += [MaxDelayConstraint(destpath='[get_ports {%s_ext_p[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [MaxDelayConstraint(destpath='[get_ports {%s_ext_n[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [MinDelayConstraint(destpath='[get_ports {%s_ext_p[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [MinDelayConstraint(destpath='[get_ports {%s_ext_n[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [FalsePathConstraint(destpath='[get_ports {%s_ext_p[*]}]' % self.fullname)]
                const += [FalsePathConstraint(destpath='[get_ports {%s_ext_n[*]}]' % self.fullname)]
            return const
        else:
            const = []
            
            if self.skarab_leds:
                # Don't need to generate any constraints (?)
                # - Just need to map the output of the gpio_simulink2ext to the input of the led_manager
                return const
            
            const += [PortConstraint(self.fullname+'_ext', self.io_group, port_index=range(self.bitwidth), iogroup_index=to_int_list(self.bit_index))]
            
            #Constrain the I/O (it is assumed that this I/O is not timing critical and set_false_path is used)
            #NB: The set_max_delay and set_min_delay is important as Vivado will report that these signals are not
            #constrained without it
            if self.io_dir == 'in':
                const += [MaxDelayConstraint(sourcepath='[get_ports {%s_ext[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [MinDelayConstraint(sourcepath='[get_ports {%s_ext[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [FalsePathConstraint(sourcepath='[get_ports {%s_ext[*]}]' % self.fullname)]
            elif self.io_dir == 'out':
                const += [MaxDelayConstraint(destpath='[get_ports {%s_ext[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [MinDelayConstraint(destpath='[get_ports {%s_ext[*]}]' % self.fullname, constdelay_ns=1.0)]
                const += [FalsePathConstraint(destpath='[get_ports {%s_ext[*]}]' % self.fullname)]
            return const


