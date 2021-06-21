from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint

"""
Requires the following pins defined in an appropriate platform.yaml:
dts_gty_refclk_p[0:1] (LOC only) # MGT refclk for transceiver pins 0-7 (index 0); transceiver pins 8-11 (index 1)
dts_qsfp_modprsl[0:2] (LOC & IOSTD) # ModPrsL signal for the 3 QSFP ports. Pulled low when a QSFP module is present
"""

class vla_dts(YellowBlock):
    def initialize(self):
        self.add_source('vla_dts/deformatter/*.vhd')
        self.add_source('vla_dts/*.v')
        #self.add_source('vla_dts/dts_offset_fifo.xci')

        self.requires = []
        if self.is_master:
            self.provides = ['dts_clk', 'dts_clk90', 'dts_clk180', 'dts_clk270']
        # Create a standard port name prefix to make PR simpler between models
        # Depends on block configuration (i.e. port choice), but not on block name
        self.portbase = 'vla_dts_' + self.port
        try:
            self.dtsconf = self.platform.conf['dts']
        except KeyError:
            self.logger.error("Platform %s doesn't have a YAML DTS configuration specified" % self.platform.name)
            raise
        try:
            self.pinconf = self.dtsconf['ports'][self.port]
        except KeyError:
            self.logger.error('No DTS port configuration for %s' % self.port)
            raise
        self.unique_clocks = []
        for c in self.pinconf['phys_clocks']:
            if c not in self.unique_clocks:
                self.unique_clocks += [c]
        self.n_clocks = len(self.unique_clocks)
        self.clock_indices = [self.unique_clocks.index(c) for c in self.pinconf['phys_clocks']]
        self.mux_factor_bits = 2

    def modify_top(self,top):
        module = 'dts_gty_rx'
        inst = top.get_instance(entity=module, name=self.fullname)
        inst.add_wb_interface(regname=self.unique_name, mode='rw', nbytes=8*4)
        inst.add_parameter('N_REFCLOCKS', self.n_clocks)
        inst.add_parameter('REFCLOCK_0', self.clock_indices[0])
        inst.add_parameter('REFCLOCK_1', self.clock_indices[1])
        inst.add_parameter('REFCLOCK_2', self.clock_indices[2])
        inst.add_parameter('INSTANCE_NUMBER', self.inst_id)
        inst.add_parameter('MUX_FACTOR_BITS', self.mux_factor_bits)

        # Output clock for the data fifo.
        inst.add_port('clkout', 'user_clk')

        # ports which go to simulink
        inst.add_port('rst',     self.fullname+'_rst')
        inst.add_port('dout',    self.fullname+'_frame_out', width=128*12)
        inst.add_port('index',   self.fullname+'_index', width=12)
        inst.add_port('one_sec', self.fullname+'_one_sec', width=12)
        inst.add_port('ten_sec', self.fullname+'_ten_sec', width=12)
        inst.add_port('locked',  self.fullname+'_locked', width=12)
        inst.add_port('sync',    self.fullname+'_sync', width=12)

        # External ports
        inst.add_port('rx_p', self.portbase+'_rx_p', width=12, parent_port=True, dir='in')
        inst.add_port('rx_n', self.portbase+'_rx_n', width=12, parent_port=True, dir='in')
        inst.add_port('tx_p', self.portbase+'_tx_p', width=12, parent_port=True, dir='out')
        inst.add_port('tx_n', self.portbase+'_tx_n', width=12, parent_port=True, dir='out')
        inst.add_port('mgtrefclk_p', self.portbase+'_mgtclk_p', parent_port=True, dir='in', width=self.n_clocks)
        inst.add_port('mgtrefclk_n', self.portbase+'_mgtclk_n', parent_port=True, dir='in', width=self.n_clocks)
        #inst.add_port('qsfp_modprsl', self.portbase+'_modprsl', width=3, parent_port=True, dir='in')
        inst.add_port('qsfp_modprsl', "3'b0")

        # Internal ports
        inst.add_port('clk_50', 'clk_50')
        if self.is_master:
            inst.add_port('clk_mux_0', 'dts_clk')
            inst.add_port('clk_mux_90', 'dts_clk90')
            inst.add_port('clk_mux_180', 'dts_clk180')
            inst.add_port('clk_mux_270', 'dts_clk270')
        else:
            inst.add_port('clk_mux_0', '')
            inst.add_port('clk_mux_90', '')
            inst.add_port('clk_mux_180', '')
            inst.add_port('clk_mux_270', '')

    def gen_constraints(self):
        cons = []
        # Transceiver LOC constraints are built into IP. So they are not needed here.
        for i, [pinname, pinindex] in enumerate(self.unique_clocks):
            cons.append(PortConstraint(self.portbase+'_mgtclk_p', pinname+'_p', port_index=i, iogroup_index=pinindex))
            cons.append(PortConstraint(self.portbase+'_mgtclk_n', pinname+'_n', port_index=i, iogroup_index=pinindex))
            clockconst = ClockConstraint(self.portbase+'_mgtclk_p[%d]'%i, '%s_dts_clk%d' % (self.fullname, i), freq=float(self.dtsconf['reffreq']))
            cons.append(clockconst)
            cons.append(RawConstraint('set_clock_groups -name async_sysclk_dts%d -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks -of_objects [get_nets sys_clk]]' % (i, clockconst.name)))
            cons.append(RawConstraint('set_clock_groups -name async_axiclk_dts%d -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks -of_objects [get_nets axil_clk]]' % (i, clockconst.name)))

        #cons.append(PortConstraint(self.portbase+'_modprsl', 'dts_qsfp_modprsl', port_index=range(3), iogroup_index=range(3)))

        return cons

    def gen_tcl_cmds(self):
        return {'pre_synth': self.make_ip_tcl()}

    def make_ip_tcl(self):
        # GTY Interface
        pc = self.pinconf # shortcut
        config = {
            'channel_enable': ' '.join(pc['channel']),
            'tx_line_rate': self.dtsconf['linerate'],
            'tx_refclk_frequency': self.dtsconf['reffreq'],
            'tx_user_data_width': '160',
            'tx_int_data_width': '80',
            'rx_line_rate': self.dtsconf['linerate'],
            'rx_refclk_frequency': self.dtsconf['reffreq'],
            'rx_user_data_width': '160',
            'rx_int_data_width': '80',
            'rx_jtol_fc': '6.1427714', #???
            'rx_comma_align_word': '4',
            'rx_comma_show_realign_enable': 'false',
            'rx_slide_mode': 'pma',
            'rx_cb_max_level': '4',
            'rx_cb_val_0_0': '0000000000',
            'rx_cb_val_0_1': '0000000000',
            'rx_cb_val_0_2': '0000000000',
            'rx_cb_val_0_3': '0000000000',
            'rx_cb_val_1_0': '0000000000',
            'rx_cb_val_1_1': '0000000000',
            'rx_cb_val_1_2': '0000000000',
            'rx_cb_val_1_3': '0000000000',
            'rx_cc_val_0_0': '0000000000',
            'rx_cc_val_0_1': '0000000000',
            'rx_cc_val_0_2': '0000000000',
            'rx_cc_val_0_3': '0000000000',
            'rx_cc_val_1_0': '0000000000',
            'rx_cc_val_1_1': '0000000000',
            'rx_cc_val_1_2': '0000000000',
            'rx_cc_val_1_3': '0000000000',
            'rx_refclk_source': ' '.join(['%s %s' % (pc['channel'][i], pc['clock'][i]) for i in range(len(pc['channel']))]),
            'tx_refclk_source': ' '.join(['%s %s' % (pc['channel'][i], pc['clock'][i]) for i in range(len(pc['channel']))]),
            'txprogdiv_freq_val': 128,
            'freerun_frequency': '50',
            'enable_optional_ports': 'txpd_in rxcdrlock_out',
            'locate_tx_user_clocking': 'core',
            'locate_rx_user_clocking': 'core',
            'component_name': 'gtwizard_dts_gtyx12_%d' % self.inst_id,
        }  

        commands = []
        # Create IP using -quiet to hide "already exists" errors (likely in PR mode)
        commands += ['create_ip -quiet -name gtwizard_ultrascale -vendor xilinx.com -library ip -version 1.7 -module_name gtwizard_dts_gtyx12_%d' % self.inst_id]
        param_str = ' '.join(['CONFIG.%s {%s}' % (k,v) for k,v in config.items()])
        commands += ['set_property -dict [list %s] [get_ips gtwizard_dts_gtyx12_%d]' % (param_str, self.inst_id)]
        try:
            if self.platform.use_pr:
                commands += ['move_files -of_objects [get_reconfig_modules user_top-toolflow] [get_files gtwizard_dts_gtyx12_%d.xci]' % self.inst_id]
        except AttributeError:
            pass

        # OUTPUT FIFO

        config = {
            'Fifo_Implementation': 'Independent_Clocks_Block_RAM',
            'asymmetric_port_width': 'true',
            'Input_Data_Width': '144',
            'Input_Depth': '64',
            'Output_Data_Width': '%d' % (144 // (2**self.mux_factor_bits)),
            'Output_Depth': '128',
            'Reset_Type': 'Asynchronous_Reset',
            'Full_Flags_Reset_Value': '1',
            'Almost_Full_Flag': 'true',
            'Almost_Empty_Flag': 'true',
            'Underflow_Flag': 'true',
            'Overflow_Flag': 'true',
            'Data_Count_Width': '6',
            'Write_Data_Count_Width': '6',
            'Read_Data_Count_Width': '7',
            'Full_Threshold_Assert_Value': '61',
            'Full_Threshold_Negate_Value': '60',
            'Enable_Safety_Circuit': 'true',
        }  

        # Only need to create this FIFO once for all yellow blocks
        if self.i_am_the_first:
            # Create IP using -quiet to hide "already exists" errors (likely in PR mode)
            commands += ['create_ip -quiet -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name dts_offset_fifo']
            param_str = ' '.join(['CONFIG.%s {%s}' % (k,v) for k,v in config.items()])
            commands += ['set_property -dict [list %s] [get_ips dts_offset_fifo]' % (param_str)]
            try:
                if self.platform.use_pr:
                    commands += ['move_files -of_objects [get_reconfig_modules user_top-toolflow] [get_files dts_offset_fifo.xci]']
            except AttributeError:
                pass

        return commands
