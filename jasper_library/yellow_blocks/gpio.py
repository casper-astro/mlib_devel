from .yellow_block import YellowBlock
from constraints import PortConstraint, MaxDelayConstraint, MinDelayConstraint, FalsePathConstraint, RawConstraint
from helpers import to_int_list

class gpio(YellowBlock):
    def initialize(self):
        if not hasattr(self, 'use_iodelay'):
            self.use_iodelay = False

        if self.arith_type == 'Boolean':
            # The yellow block will set a value for bitwidth,
            # override it here if the data type is boolean.
            self.bitwidth = 1
        else:
            self.bitwidth = int(self.bitwidth)
            # There is error-checking behind this

        # If we're DDRing, we only need half the number of pins...
        if self.use_ddr:
            self.pad_bitwidth = self.bitwidth / 2
        else:
            self.pad_bitwidth = self.bitwidth
        # hack for new gpio parameters that don't include platform name
        self.io_group = self.io_group_real
        # provide an override if the user is using a custom IO bank name
        if self.io_group == 'custom':
            self.io_group = self.io_group_custom
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

        # Create a name for the external pins, which depends on the type of yellow block,
        # but not the model name (i.e., NOT self.fullname). This makes PR easier since
        # the top-level interface doesn't vary between models.
        pins = to_int_list(self.bit_index)
        start_pin = pins[0]
        end_pin = pins[-1]
        self.portbase = "{blocktype}_{iotype}_{start}_{end}".format(
            blocktype=self.blocktype, iotype=self.io_group, start=start_pin, end=end_pin)

    def gen_children(self):
        if self.use_iodelay:
            self.ctrl_reg = YellowBlock.make_block({
                          'tag': 'xps:sw_reg',
                          'io_dir': 'From Processor',
                          'name': self.fullname + '_delay_ctrl',
                          'fullpath': self.fullpath + '_delay_ctrl',
                       }, self.platform)
            return [self.ctrl_reg]
        else:
            return []

    def modify_top(self,top):
        instance_name = self.fullname
        gateway_name = '{}_gateway'.format(self.fullname)

        # If the io_group is set to gateway, propagate the signal
        # straight to the top-level. This is probably only useful
        # if a) the synth tool are going to instantiate buffers themselves
        # or b) there is some higher level logic to connect to in a template PR design.
        if self.io_group == 'gateway':
            top.add_port(self.name, dir=self.io_dir, width=self.pad_bitwidth)
            top.add_signal(self.name, width=self.pad_bitwidth)
            top.add_signal(gateway_name, width=self.pad_bitwidth)
            top.assign_signal(self.name, gateway_name)
            return

        inst = top.get_instance(entity=self.module, name=self.fullname)
        inst.add_parameter('CLK_PHASE', self.reg_clk_phase)
        inst.add_port('clk', signal='user_clk', parent_sig=False)
        inst.add_port('clk90', signal='user_clk90', parent_sig=False)
        inst.add_port('gateway', signal=gateway_name, width=self.bitwidth)
        if self.use_iodelay:
            inst.add_port('delay_load_en', signal="%s_user_data_out[24]"%self.ctrl_reg.fullname, parent_sig=False)
            inst.add_port('delay_rst', signal="%s_user_data_out[16]"%self.ctrl_reg.fullname, parent_sig=False)
            inst.add_port('delay_val', signal="%s_user_data_out[8:0]"%self.ctrl_reg.fullname, width=9, parent_sig=False)
            inst.add_parameter('USE_DELAY', 1)
        else:
            inst.add_parameter('USE_DELAY', 0)
        inst.add_parameter('WIDTH', str(self.bitwidth))
        inst.add_parameter('DDR', '1' if self.use_ddr  else '0')
        inst.add_parameter('REG_IOB', '"true"' if self.reg_iob else '"false"')
        
        # This compound if-statement has been added to allow for the case of 
        # LEDs being managed by the platform's Board Support Package
        # - i.e. LED signals are sent through some multiplexing logic
        #        and NOT directly to an output pin
        if self.io_group.find('gpio') < 0 and 'manage_leds' in self.platform.conf\
            and self.platform.conf['manage_leds'] == True:
            if self.bitwidth > 1:
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
            external_port_name = self.portbase + '_ext'
            
            if self.use_diffio:
                inst.add_port('io_pad_p', signal=external_port_name + '_p', dir=self.io_dir, width=self.pad_bitwidth, parent_port=True)
                inst.add_port('io_pad_n', signal=external_port_name + '_n', dir=self.io_dir, width=self.pad_bitwidth, parent_port=True)
            else:
                inst.add_port('io_pad', signal=external_port_name, dir=self.io_dir, width=self.pad_bitwidth, parent_port=True)
        
    def gen_constraints(self):
        if self.io_group == 'gateway':
            return []
        if self.use_diffio:
            const = []
            const += [PortConstraint(self.portbase+'_ext_p', self.io_group + '_p', port_index=list(range(self.bitwidth)), iogroup_index=to_int_list(self.bit_index))]
            const += [PortConstraint(self.portbase+'_ext_n', self.io_group + '_n', port_index=list(range(self.bitwidth)), iogroup_index=to_int_list(self.bit_index))]
            #Constrain the I/O (it is assumed that this I/O is not timing critical and set_false_path is used)
            #NB: The set_max_delay and set_min_delay is important as Vivado will report that these signals are not
            #constrained without it
            if self.io_dir == 'in':
                const += [MaxDelayConstraint(sourcepath='[get_ports {%s_ext_p[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [MaxDelayConstraint(sourcepath='[get_ports {%s_ext_n[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [MinDelayConstraint(sourcepath='[get_ports {%s_ext_p[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [MinDelayConstraint(sourcepath='[get_ports {%s_ext_n[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [FalsePathConstraint(sourcepath='[get_ports {%s_ext_p[*]}]' % self.portbase)]
                const += [FalsePathConstraint(sourcepath='[get_ports {%s_ext_n[*]}]' % self.portbase)]

            elif self.io_dir == 'out':
                const += [MaxDelayConstraint(destpath='[get_ports {%s_ext_p[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [MaxDelayConstraint(destpath='[get_ports {%s_ext_n[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [MinDelayConstraint(destpath='[get_ports {%s_ext_p[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [MinDelayConstraint(destpath='[get_ports {%s_ext_n[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [FalsePathConstraint(destpath='[get_ports {%s_ext_p[*]}]' % self.portbase)]
                const += [FalsePathConstraint(destpath='[get_ports {%s_ext_n[*]}]' % self.portbase)]
            return const
        else:
            const = []

            if self.io_group.find('gpio') < 0 and 'manage_leds' in self.platform.conf\
            and self.platform.conf['manage_leds'] == True:
                # Don't need to generate any constraints (?)
                # - Just need to map the output of the gpio_simulink2ext to the input of the led_manager
                    return const
            
            const += [PortConstraint(self.portbase+'_ext', self.io_group, port_index=list(range(self.bitwidth)), iogroup_index=to_int_list(self.bit_index))]
            
            #Constrain the I/O (it is assumed that this I/O is not timing critical and set_false_path is used)
            #NB: The set_max_delay and set_min_delay is important as Vivado will report that these signals are not
            #constrained without it
            if self.io_dir == 'in':
                const += [MaxDelayConstraint(sourcepath='[get_ports {%s_ext[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [MinDelayConstraint(sourcepath='[get_ports {%s_ext[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [FalsePathConstraint(sourcepath='[get_ports {%s_ext[*]}]' % self.portbase)]
                if self.termination is not None:
                    const += [RawConstraint('set_property PULLTYPE %s [get_ports %s_ext[*]]' % (self.termination.upper(), self.portbase))]
            elif self.io_dir == 'out':
                const += [MaxDelayConstraint(destpath='[get_ports {%s_ext[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [MinDelayConstraint(destpath='[get_ports {%s_ext[*]}]' % self.portbase, constdelay_ns=1.0)]
                const += [FalsePathConstraint(destpath='[get_ports {%s_ext[*]}]' % self.portbase)]
            return const


