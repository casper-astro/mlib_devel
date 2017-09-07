from yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint
from yellow_block_typecodes import *
import math

class snap_adc(YellowBlock):
    def initialize(self):
        self.typecode = TYPECODE_ADC16CTRL
        # num_units is the number of ADC chips
        # board_count is the number of boards
        self.num_units = 3
        self.num_clocks = 1
        self.zdok_rev = 2 # no frame clocks (see adc16)
        self.n_inputs = self.snap_inputs / 3 #number of inputs per chip

	# self.adc_resolution, possible values are 8, 10, 12, 14, 16
	# Currently only 8, 12, 16 are supported
	if self.adc_resolution <=8:
		self.adc_data_width = 8
	elif self.adc_resolution >8 and self.adc_resolution<=16:
		self.adc_data_width = 16
	else:
		self.adc_data_width = 8
	self.LOG_USER_WIDTH = int(math.log(self.adc_data_width*4,2))

	# An HMCAD1511 has 8 ADC cores and DDR transmission 
        self.line_clock_freq = self.sample_rate/(8.0/self.n_inputs)*self.adc_resolution/2.0

        self.add_source('adc16_interface')
        self.add_source('wb_adc16_controller')
        self.add_source('wb_bram')

        self.provides = ['adc0_clk','adc0_clk90', 'adc0_clk180', 'adc0_clk270']
        self.requires = ['HAD1511_0', 'HAD1511_1', 'HAD1511_2']

    def gen_children(self):
        """
        The first instance of this adc adds the required clock controller
        module
        """
        if self.i_am_the_first:
            lmx = YellowBlock.make_block({'tag':'xps:lmx2581', 'fullpath':'%s/lmx2581_from'%self.name, 'name':'lmx2581'}, self.platform)
            swreg = YellowBlock.make_block({'tag':'xps:sw_reg_sync', 'fullpath':'%s/adc16_use_synth'%self.name, 'io_dir':'From Processor', 'name':'adc16_use_synth'}, self.platform)
            return [lmx, swreg]
        else:
            return []


    def modify_top(self,top):
        module = 'adc16_interface'
        inst = top.get_instance(entity=module, name=self.fullname, comment=self.fullname)
        inst.add_parameter('G_NUM_CLOCKS', int(self.num_clocks))
        inst.add_parameter('G_ZDOK_REV', int(self.zdok_rev))
        inst.add_parameter('G_NUM_UNITS', int(self.num_units))
        inst.add_parameter('ADC_RESOLUTION', int(self.adc_resolution))
        inst.add_parameter('ADC_DATA_WIDTH', int(self.adc_data_width))

        # ports which go to simulink
        inst.add_port('a1', self.fullname+'_a1', width=self.adc_data_width)
        inst.add_port('a2', self.fullname+'_a2', width=self.adc_data_width)
        inst.add_port('a3', self.fullname+'_a3', width=self.adc_data_width)
        inst.add_port('a4', self.fullname+'_a4', width=self.adc_data_width)
        inst.add_port('b1', self.fullname+'_b1', width=self.adc_data_width)
        inst.add_port('b2', self.fullname+'_b2', width=self.adc_data_width)
        inst.add_port('b3', self.fullname+'_b3', width=self.adc_data_width)
        inst.add_port('b4', self.fullname+'_b4', width=self.adc_data_width)
        inst.add_port('c1', self.fullname+'_c1', width=self.adc_data_width)
        inst.add_port('c2', self.fullname+'_c2', width=self.adc_data_width)
        inst.add_port('c3', self.fullname+'_c3', width=self.adc_data_width)
        inst.add_port('c4', self.fullname+'_c4', width=self.adc_data_width)

        # ports which go to the wb controller. Any ports which don't go to top level need
        # corresponding signals to be added to top.v. **Not anymore, this is now default behaviour!**
        inst.add_port('fabric_clk', 'adc0_clk')
        inst.add_port('fabric_clk_90', 'adc0_clk90')
        inst.add_port('fabric_clk_180', 'adc0_clk180')
        inst.add_port('fabric_clk_270', 'adc0_clk270')

        inst.add_port('reset', 'adc16_reset')
        inst.add_port('iserdes_bitslip', 'adc16_iserdes_bitslip', width=64)

        inst.add_port('delay_rst', 'adc16_delay_rst', width=64)
        inst.add_port('delay_tap', 'adc16_delay_tap', width=5)

        inst.add_port('snap_req', 'adc16_snap_req')
        inst.add_port('snap_we', 'adc16_snap_we')
        inst.add_port('snap_addr', 'adc16_snap_addr', width=10)

        inst.add_port('locked', 'adc16_locked', width=2)
        inst.add_port('demux_mode', 'adc16_demux_mode', width=2)

        # Now the external ports, which need corresponding ports adding to top.v

        inst.add_port('clk_frame_p', '0', parent_sig=False)
        inst.add_port('clk_frame_n', '0', parent_sig=False)

        inst.add_port('clk_line_p', 'adc16_clk_line_p', parent_port=True, dir='in', width=self.num_clocks)
        inst.add_port('clk_line_n', 'adc16_clk_line_n', parent_port=True, dir='in', width=self.num_clocks)
        inst.add_port('ser_a_p', 'adc16_ser_a_p', parent_port=True, dir='in', width=4*self.num_units)
        inst.add_port('ser_a_n', 'adc16_ser_a_n', parent_port=True, dir='in', width=4*self.num_units)
        inst.add_port('ser_b_p', 'adc16_ser_b_p', parent_port=True, dir='in', width=4*self.num_units)
        inst.add_port('ser_b_n', 'adc16_ser_b_n', parent_port=True, dir='in', width=4*self.num_units)

        # Clock switch.
        if self.i_am_the_first:
            top.add_port('clk_sel_a', dir='out', width=1)
            top.add_port('clk_sel_b', dir='out', width=1)
            top.assign_signal('clk_sel_a[0]', "%s_adc16_use_synth_user_data_out[0]"%self.name)
            top.assign_signal('clk_sel_b[0]', "~%s_adc16_use_synth_user_data_out[0]"%self.name)

        # ADC Power down and reset signals are wired to the FPGA, but hardwire them to match the adc16 card
        top.add_port('adc_rst_n', dir='out', width=3)
        top.add_port('adc_pd', dir='out', width=3)
        top.assign_signal('adc_rst_n', "3'b111")
        top.assign_signal('adc_pd', "3'b000")



        # wb controller

        wbctrl = top.get_instance(entity='wb_adc16_controller', name='wb_adc16_controller')
        wbctrl.add_parameter('G_ROACH2_REV', 0)
        wbctrl.add_parameter('G_ZDOK_REV', int(self.zdok_rev))
        wbctrl.add_parameter('G_NUM_UNITS', int(self.num_units))
        wbctrl.add_parameter('G_NUM_SCLK_LINES', 3)
        wbctrl.add_parameter('G_NUM_SDATA_LINES', 3)
        # These are top-level ports -- they don't need signal declarations,
        # but they do need ports added to the top-level
        wbctrl.add_port('adc0_adc3wire_csn1', 'adc0_adc3wire_csn1', dir='out', parent_port=True)
        wbctrl.add_port('adc0_adc3wire_csn2', 'adc0_adc3wire_csn2', dir='out', parent_port=True)
        wbctrl.add_port('adc0_adc3wire_csn3', 'adc0_adc3wire_csn3', dir='out', parent_port=True)
        wbctrl.add_port('adc0_adc3wire_csn4', '')
        wbctrl.add_port('adc0_adc3wire_sdata','adc0_adc3wire_sdata', width=3, dir='out', parent_port=True)
        wbctrl.add_port('adc0_adc3wire_sclk', 'adc0_adc3wire_sclk', width=3, dir='out', parent_port=True)
        wbctrl.add_port('adc1_adc3wire_csn1', '')
        wbctrl.add_port('adc1_adc3wire_csn2', '')
        wbctrl.add_port('adc1_adc3wire_csn3', '')
        wbctrl.add_port('adc1_adc3wire_csn4', '')
        wbctrl.add_port('adc1_adc3wire_sdata','')
        wbctrl.add_port('adc1_adc3wire_sclk', '')

        # internal connections to the adc controller. We have already declared the corresponding
        # signals earlier.
        wbctrl.add_port('adc16_reset','adc16_reset')
        wbctrl.add_port('adc16_iserdes_bitslip','adc16_iserdes_bitslip', width=64)
        wbctrl.add_port('adc16_delay_rst', 'adc16_delay_rst', width=64)
        wbctrl.add_port('adc16_delay_tap', 'adc16_delay_tap', width=5)
        wbctrl.add_port('adc16_snap_req',  'adc16_snap_req')
        wbctrl.add_port('adc16_locked',    'adc16_locked', width=2)
        wbctrl.add_port('adc16_demux_mode', 'adc16_demux_mode', width=2)
        # and finally the wb interface
        wbctrl.add_wb_interface(nbytes=2**8, regname='adc16_controller', mode='rw', typecode=self.typecode)

        snap_chan = ['a','b','c','d','e','f','g','h']
        for k in range(self.num_units):
            # Embedded wb-RAM
            din = self.fullname+'_%s'%snap_chan[k]
            wbram = top.get_instance(entity='wb_bram', name='adc16_wb_ram%d'%k, comment='Embedded ADC16 bram')
            wbram.add_parameter('LOG_USER_WIDTH',self.LOG_USER_WIDTH)
            wbram.add_parameter('USER_ADDR_BITS','10')
            wbram.add_parameter('N_REGISTERS','2')
            wbram.add_wb_interface(regname='adc16_wb_ram%d'%k, mode='rw', nbytes=(self.adc_data_width/8)*4*2**10, typecode=TYPECODE_SWREG)
            wbram.add_port('user_clk','adc0_clk', parent_sig=False)
            wbram.add_port('user_addr','adc16_snap_addr', width=10)
            wbram.add_port('user_din','{%s1, %s2, %s3, %s4}'%(din,din,din,din), parent_sig=False)
            wbram.add_port('user_we','adc16_snap_we')
            wbram.add_port('user_dout','')

    def gen_constraints(self):
        cons = []
        # ADC SPI interface
        cons.append(PortConstraint('adc0_adc3wire_csn1',   'adc_csn', iogroup_index=0))
        cons.append(PortConstraint('adc0_adc3wire_csn2',   'adc_csn', iogroup_index=1))
        cons.append(PortConstraint('adc0_adc3wire_csn3',   'adc_csn', iogroup_index=2))
        cons.append(PortConstraint('adc0_adc3wire_sdata', 'adc_sdata', port_index=range(3), iogroup_index=range(3)))
        cons.append(PortConstraint('adc0_adc3wire_sclk',  'adc_sclk', port_index=range(3), iogroup_index=range(3)))

        cons.append(PortConstraint('adc16_clk_line_p',  'adc_lclkp', iogroup_index=0))
        cons.append(PortConstraint('adc16_clk_line_n',  'adc_lclkn', iogroup_index=0))

        # in 4 channel mode, the adc controller demuxes each a-b pair to make a stream
        # in 2 channel mode, the demux order should be a[2*n],a[2*n+1],b[2*n],b[2*n+1] for n in range(2)
        # in 1 channel mode, the demux order should be a[0],a[2],b[0],b[2],a[1],a[3],b[1],b[3]
        # In the board description file, adcX_out is a 16 element vector with a_p[0], a_n[0], b_p[0], b_n[0], a_p[1], ... b_n[15]
        # This is now configured dynamically in the gateware
        #if self.n_inputs == 4:
        #    ap_index = [0, 4, 8, 12]
        #    an_index = [1, 5, 9, 13]
        #    bp_index = [2, 6, 10, 14]
        #    bn_index = [3, 7, 11, 15]
        #elif self.n_inputs == 2:
        #    ap_index = [0, 2, 8, 10]
        #    an_index = [1, 3, 9, 11]
        #    bp_index = [4, 6, 12, 14]
        #    bn_index = [5, 7, 13, 15]
        #elif self.n_inputs == 1:
        #    ap_index = [0, 2, 4, 6] 
        #    an_index = [1, 3, 5, 7] 
        #    bp_index = [8, 10, 12, 14] 
        #    bn_index = [9, 11, 13, 15] 
        #    
        ap_index = [0, 4, 8, 12]
        an_index = [1, 5, 9, 13]
        bp_index = [2, 6, 10, 14]
        bn_index = [3, 7, 11, 15]

        cons.append(PortConstraint('adc16_ser_a_p', 'adc0_out', port_index=range(4), iogroup_index=ap_index))
        cons.append(PortConstraint('adc16_ser_a_n', 'adc0_out', port_index=range(4), iogroup_index=an_index))
        cons.append(PortConstraint('adc16_ser_b_p', 'adc0_out', port_index=range(4), iogroup_index=bp_index))
        cons.append(PortConstraint('adc16_ser_b_n', 'adc0_out', port_index=range(4), iogroup_index=bn_index))

        cons.append(PortConstraint('adc16_ser_a_p', 'adc1_out', port_index=range(4,8), iogroup_index=ap_index))
        cons.append(PortConstraint('adc16_ser_a_n', 'adc1_out', port_index=range(4,8), iogroup_index=an_index))
        cons.append(PortConstraint('adc16_ser_b_p', 'adc1_out', port_index=range(4,8), iogroup_index=bp_index))
        cons.append(PortConstraint('adc16_ser_b_n', 'adc1_out', port_index=range(4,8), iogroup_index=bn_index))

        cons.append(PortConstraint('adc16_ser_a_p', 'adc2_out', port_index=range(8,12), iogroup_index=ap_index))
        cons.append(PortConstraint('adc16_ser_a_n', 'adc2_out', port_index=range(8,12), iogroup_index=an_index))
        cons.append(PortConstraint('adc16_ser_b_p', 'adc2_out', port_index=range(8,12), iogroup_index=bp_index))
        cons.append(PortConstraint('adc16_ser_b_n', 'adc2_out', port_index=range(8,12), iogroup_index=bn_index))

        if self.i_am_the_first:
            cons.append(PortConstraint('clk_sel_a', 'clk_sel_a', port_index=range(1), iogroup_index=range(1)))
            cons.append(PortConstraint('clk_sel_b', 'clk_sel_b', port_index=range(1), iogroup_index=range(1)))

        cons.append(PortConstraint('adc_rst_n', 'adc_rst_n', port_index=range(3), iogroup_index=range(3)))
        cons.append(PortConstraint('adc_pd', 'adc_pd', port_index=range(3), iogroup_index=range(3)))
        
        # clock constraint with variable period
        clkconst = ClockConstraint('adc16_clk_line_p', name='adc_clk', freq=self.line_clock_freq)
        cons.append(clkconst)

        cons.append(RawConstraint('set_clock_groups -name async_sysclk_adcclk -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % clkconst.name))
        cons.append(RawConstraint('set_multicycle_path -from [get_clocks -include_generated_clocks %s] -to [get_clocks -include_generated_clocks sys_clk0_dcm] 3' % clkconst.name))
        cons.append(RawConstraint('set_multicycle_path -from [get_clocks -include_generated_clocks %s] -to [get_clocks -include_generated_clocks sys_clk0_dcm] -hold 2' % clkconst.name))

        return cons

        
