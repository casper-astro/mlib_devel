from yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint

from math import ceil, floor

class adc5g(YellowBlock):
    def initialize(self):
        self.add_source('adc5g')
        self.add_source('adc5g/fifo_generator_0.xci')
        self.add_source('wb_adc5g_controller')
        
        self.zdok_num = int(self.adc_brd[-1]) # The block has an zdok_num variable of the form "ZDOK 0"
        self.provides = ['adc0_clk','adc0_clk90', 'adc0_clk180', 'adc0_clk270']
        self.requires = ['zdok%d'%self.zdok_num]

        if self.demux != '1:1':
            raise ValueError("Only ADC5g demux 1:1 is supported")

        self.bitclk_rate = self.adc_clk_rate / 4. # 1/2 for demux (per input) by 2, 1/2 for DDR
        self.userclk_rate = self.adc_clk_rate / 8. # demux by 8 (per input) into simulink
        self.bitclk_period = 1./self.bitclk_rate * 1e3 #ns
        self.userclk_period = 1./self.userclk_rate * 1e3 #ns

        # get mode configuration stuff
        # assume only demux 1:1
        if self.input_mode == 'One-channel -- A':
            self.mode = 'MODE_ACHAN_DMUX1'
            self.ctrl_mode = 0
            self.chan_mode = 0
        elif self.input_mode == 'One-channel -- C':
            self.ctrl_mode = 2
            self.chan_mode = 0
            self.mode = 'MODE_CCHAN_DMUX1'
        elif self.input_mode == 'Two-channel -- A&C':
            self.ctrl_mode = 4
            self.chan_mode = 1
            self.mode = 'MODE_2CHAN_DMUX1'
        else:
            raise ValueError("Unsupported ADC5g input mode %s" % self.input_mode)

        if self.test_ramp == 'on':
            self.mode = 'MODE_TEST_RAMP'

        self.clock_params = self._get_mmcm_params()

    def _get_mmcm_params(self):
        # based on kintex 7 speed grade -1 (snap is -2)
        f_pfdmax  = 450.0
        f_pfdmin = 10.0
        f_vcomax = 1200.0
        f_vcomin = 600.0

        allowed_d = range(1, 107)
        allowed_m = range(2, 65)
        # floatify
        #allowed_o0 = [1.0*i for i in range(1,128)]
        #allowed_o1 = [1.0*i for i in range(1,128)]
        allowed_o0 = range(1,128)
        allowed_o1 = range(1,128)
        
        # input clock to MMCM
        f_in = float(self.bitclk_rate)

        d_min = int(ceil(f_in / f_pfdmax))
        d_max = int(floor(f_in / f_pfdmin))
        m_min = int(ceil(d_min * f_vcomin / f_in))
        m_max = int(floor(d_max * f_vcomax / f_in))

        # Scan through d and m options. For each, figure out
        # what output dividers would be needed to get the correct
        # output frequencies.
        # if d, m, o0 and o1 meet the allowed criteria we're done
        for d in range(d_min, d_max+1):
            f_pfd = f_in / d
            for m in range(m_min, m_max+1):
                f_vco = f_pfd * m
		# target clock for o0 is bitclk_rate
		# target clock for o1 is userclk_rate = bitclk_rate / 8
                o0 = f_vco / self.bitclk_rate
                o1 = f_vco / self.userclk_rate
                if d not in allowed_d:
                    continue
                if m not in allowed_m:
                    continue
                if o0 not in allowed_o0:
                    continue
                if o1 not in allowed_o1:
                    continue
                
                # force o0 and o1 to be ints. This is fine since we have already tested that they
                # are in the allowed list -- which are ints.
                rv = {'f_vco':f_vco, 'f_pfd':f_pfd, 'd':d, 'm':m, 'o0':int(o0), 'o1':int(o1)}
                print rv
                return rv
        # if we've got to here, there's no valid MMCM options
        raise RuntimeError("adc5g: No valid MMCM parameters found!")
                

    def modify_top(self,top):
        module = 'adc5g_dmux1_interface'
        inst = top.get_instance(entity=module, name=self.fullname, comment=self.fullname)
        inst.add_parameter('adc_bit_width', '8')
        inst.add_parameter('clkin_period ', '%.3f' % self.bitclk_period)
        inst.add_parameter('mode         ', self.chan_mode)
        inst.add_parameter('mmcm_m       ', '%.1f' % self.clock_params['m'])
        inst.add_parameter('mmcm_d       ', '%d' % self.clock_params['d'])
        inst.add_parameter('mmcm_o0      ', '%.1f' % self.clock_params['o0'])
        inst.add_parameter('mmcm_o1      ', '%d' % self.clock_params['o1'])
        inst.add_parameter('bufr_div     ', '1')
        inst.add_parameter('bufr_div_str ', '"1"')

        # physical ports
        inst.add_port('adc_clk_p_i    ', self.fullname+'_adc_clk_p_i    ', parent_port=True, dir='in')
        inst.add_port('adc_clk_n_i    ', self.fullname+'_adc_clk_n_i    ', parent_port=True, dir='in')
        inst.add_port('adc_sync_p     ', self.fullname+'_adc_sync_p     ', parent_port=True, dir='in')
        inst.add_port('adc_sync_n     ', self.fullname+'_adc_sync_n     ', parent_port=True, dir='in')
        inst.add_port('adc_data0_p_i  ', self.fullname+'_adc_data0_p_i  ', parent_port=True, dir='in', width=8)
        inst.add_port('adc_data0_n_i  ', self.fullname+'_adc_data0_n_i  ', parent_port=True, dir='in', width=8)
        inst.add_port('adc_data1_p_i  ', self.fullname+'_adc_data1_p_i  ', parent_port=True, dir='in', width=8)
        inst.add_port('adc_data1_n_i  ', self.fullname+'_adc_data1_n_i  ', parent_port=True, dir='in', width=8)
        inst.add_port('adc_data2_p_i  ', self.fullname+'_adc_data2_p_i  ', parent_port=True, dir='in', width=8)
        inst.add_port('adc_data2_n_i  ', self.fullname+'_adc_data2_n_i  ', parent_port=True, dir='in', width=8)
        inst.add_port('adc_data3_p_i  ', self.fullname+'_adc_data3_p_i  ', parent_port=True, dir='in', width=8)
        inst.add_port('adc_data3_n_i  ', self.fullname+'_adc_data3_n_i  ', parent_port=True, dir='in', width=8)

        # infrastructure outputs
        inst.add_port('ctrl_clk_in    ', 'adc0_clk   ')
        inst.add_port('ctrl_clk_out   ', 'adc0_clk   ')
        inst.add_port('ctrl_clk90_out ', 'adc0_clk90 ')
        inst.add_port('ctrl_clk180_out', 'adc0_clk180')
        inst.add_port('ctrl_clk270_out', 'adc0_clk270')

        # user ports
        inst.add_port('user_data_i0', self.fullname+'_user_data_i0', width=8)
        inst.add_port('user_data_i1', self.fullname+'_user_data_i1', width=8)
        inst.add_port('user_data_i2', self.fullname+'_user_data_i2', width=8)
        inst.add_port('user_data_i3', self.fullname+'_user_data_i3', width=8)
        inst.add_port('user_data_i4', self.fullname+'_user_data_i4', width=8)
        inst.add_port('user_data_i5', self.fullname+'_user_data_i5', width=8)
        inst.add_port('user_data_i6', self.fullname+'_user_data_i6', width=8)
        inst.add_port('user_data_i7', self.fullname+'_user_data_i7', width=8)
        inst.add_port('user_data_q0', self.fullname+'_user_data_q0', width=8)
        inst.add_port('user_data_q1', self.fullname+'_user_data_q1', width=8)
        inst.add_port('user_data_q2', self.fullname+'_user_data_q2', width=8)
        inst.add_port('user_data_q3', self.fullname+'_user_data_q3', width=8)
        inst.add_port('user_data_q4', self.fullname+'_user_data_q4', width=8)
        inst.add_port('user_data_q5', self.fullname+'_user_data_q5', width=8)
        inst.add_port('user_data_q6', self.fullname+'_user_data_q6', width=8)
        inst.add_port('user_data_q7', self.fullname+'_user_data_q7', width=8)
        inst.add_port('sync        ', self.fullname+'_sync')

        # ports from software controller
        inst.add_port('dcm_reset      ', self.fullname+'_dcm_reset      ')
        inst.add_port('dcm_psclk      ', self.fullname+'_dcm_psclk      ')
        inst.add_port('dcm_psen       ', self.fullname+'_dcm_psen       ')
        inst.add_port('dcm_psincdec   ', self.fullname+'_dcm_psincdec   ')
        inst.add_port('ctrl_reset     ', self.fullname+'_dcm_reset      ')
        inst.add_port('adc_reset_o    ', self.fullname+'_adc_reset_o    ')
        inst.add_port('datain_pin     ', self.fullname+'_datain_pin     ', width=5)
        inst.add_port('datain_tap     ', self.fullname+'_datain_tap     ', width=5)
        inst.add_port('tap_rst        ', self.fullname+'_tap_rst        ')
        inst.add_port('fifo_full_cnt  ', self.fullname+'_fifo_full_cnt  ', width=16)
        inst.add_port('fifo_empty_cnt ', self.fullname+'_fifo_empty_cnt ', width=16)
        inst.add_port('ctrl_dcm_locked', self.fullname+'_dcm_locked     ')
        inst.add_port('dcm_psdone     ', self.fullname+'_dcm_psdone     ')

        # ADC software controller
        # static name -- multiple ADCs on different ZDOK ports should pick up the same instance
        inst = top.get_instance(entity='wb_adc5g_controller', name='wb_adc5g_controller', comment=self.fullname)
        inst.add_wb_interface(nbytes=512, regname='adc5g_controller', mode='rw')

        inst.add_parameter('INITIAL_CONFIG_MODE_%d' % self.zdok_num, '%d' % self.ctrl_mode)

        inst.add_port('adc%d_adc3wire_clk    ' % self.zdok_num, self.fullname+'_adc3wire_clk    ', parent_port=True, dir='out')
        inst.add_port('adc%d_adc3wire_data   ' % self.zdok_num, self.fullname+'_adc3wire_data   ', parent_port=True, dir='out')
        inst.add_port('adc%d_adc3wire_data_o ' % self.zdok_num, self.fullname+'_adc3wire_data_o ', parent_port=True, dir='in' )
        inst.add_port('adc%d_adc3wire_spi_rst' % self.zdok_num, self.fullname+'_adc3wire_spi_rst', parent_port=True, dir='out')
        inst.add_port('adc%d_modepin         ' % self.zdok_num, self.fullname+'_modepin         ', parent_port=True, dir='out')
        inst.add_port('adc%d_reset           ' % self.zdok_num, self.fullname+'_reset           ', parent_port=True, dir='out')
        inst.add_port('adc%d_dcm_reset       ' % self.zdok_num, self.fullname+'_dcm_reset       ')
        inst.add_port('adc%d_dcm_locked      ' % self.zdok_num, self.fullname+'_dcm_locked      ')
        inst.add_port('adc%d_fifo_full_cnt   ' % self.zdok_num, self.fullname+'_fifo_full_cnt   ', width=16)
        inst.add_port('adc%d_fifo_empty_cnt  ' % self.zdok_num, self.fullname+'_fifo_empty_cnt  ', width=16)
        inst.add_port('adc%d_psclk           ' % self.zdok_num, self.fullname+'_dcm_psclk       ')
        inst.add_port('adc%d_psen            ' % self.zdok_num, self.fullname+'_dcm_psen        ')
        inst.add_port('adc%d_psincdec        ' % self.zdok_num, self.fullname+'_dcm_psincdec    ')
        inst.add_port('adc%d_psdone          ' % self.zdok_num, self.fullname+'_dcm_psdone      ')
        inst.add_port('adc%d_clk             ' % self.zdok_num, 'adc0_clk             ')
        inst.add_port('adc%d_tap_rst         ' % self.zdok_num, self.fullname+'_tap_rst         ')
        inst.add_port('adc%d_datain_pin      ' % self.zdok_num, self.fullname+'_datain_pin      ', width=5)
        inst.add_port('adc%d_datain_tap      ' % self.zdok_num, self.fullname+'_datain_tap      ', width=5)

    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint(self.fullname+'_adc_clk_p_i     ', 'zdok%d_p' % self.zdok_num, iogroup_index=39))
        cons.append(PortConstraint(self.fullname+'_adc_clk_n_i     ', 'zdok%d_n' % self.zdok_num, iogroup_index=39))
        cons.append(PortConstraint(self.fullname+'_adc_sync_p      ', 'zdok%d_p' % self.zdok_num, iogroup_index=38))
        cons.append(PortConstraint(self.fullname+'_adc_sync_n      ', 'zdok%d_n' % self.zdok_num, iogroup_index=38))
        cons.append(PortConstraint(self.fullname+'_adc_data0_p_i   ', 'zdok%d_p' % self.zdok_num, port_index=range(8), iogroup_index=range(8)))
        cons.append(PortConstraint(self.fullname+'_adc_data0_n_i   ', 'zdok%d_n' % self.zdok_num, port_index=range(8), iogroup_index=range(8)))
        cons.append(PortConstraint(self.fullname+'_adc_data1_p_i   ', 'zdok%d_p' % self.zdok_num, port_index=range(8), iogroup_index=range(10,18)))
        cons.append(PortConstraint(self.fullname+'_adc_data1_n_i   ', 'zdok%d_n' % self.zdok_num, port_index=range(8), iogroup_index=range(10,18)))
        cons.append(PortConstraint(self.fullname+'_adc_data2_p_i   ', 'zdok%d_p' % self.zdok_num, port_index=range(8), iogroup_index=range(20,28)))
        cons.append(PortConstraint(self.fullname+'_adc_data2_n_i   ', 'zdok%d_n' % self.zdok_num, port_index=range(8), iogroup_index=range(20,28)))
        cons.append(PortConstraint(self.fullname+'_adc_data3_p_i   ', 'zdok%d_p' % self.zdok_num, port_index=range(8), iogroup_index=range(30,38)))
        cons.append(PortConstraint(self.fullname+'_adc_data3_n_i   ', 'zdok%d_n' % self.zdok_num, port_index=range(8), iogroup_index=range(30,38)))

        cons.append(PortConstraint(self.fullname+'_adc3wire_clk    ', 'zdok%d' % self.zdok_num, iogroup_index=17))
        cons.append(PortConstraint(self.fullname+'_adc3wire_data   ', 'zdok%d' % self.zdok_num, iogroup_index=18))
        cons.append(PortConstraint(self.fullname+'_adc3wire_data_o ', 'zdok%d' % self.zdok_num, iogroup_index=19))
        cons.append(PortConstraint(self.fullname+'_adc3wire_spi_rst', 'zdok%d' % self.zdok_num, iogroup_index=36))
        cons.append(PortConstraint(self.fullname+'_modepin         ', 'zdok%d' % self.zdok_num, iogroup_index=16))
        cons.append(PortConstraint(self.fullname+'_reset           ', 'zdok%d' % self.zdok_num, iogroup_index=37))

        # clock constraint with variable period
        clkconst = ClockConstraint(self.fullname+'_adc_clk_p_i', name=self.fullname+'_adc5g_clk', freq=self.bitclk_rate)
        cons.append(clkconst)
        cons.append(RawConstraint('set_clock_groups -name async_sysclk_adcclk -asynchronous -group [get_clocks -include_generated_clocks %s_CLK] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % clkconst.signal))

        return cons

        
