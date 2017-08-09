from yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint

class adc(YellowBlock):
    def initialize(self):
        self.add_source('adc_interface')
        self.add_source('adc_interface/adc_fifo.xci')
        self.add_source('wb_adccontroller')
        self.adc_brd = int(self.adc_brd.lstrip('adc'))

        self.provides = ['adc0_clk','adc0_clk90', 'adc0_clk180', 'adc0_clk270']
        self.requires = ['zdok%d'%self.adc_brd] #this adc needs a zdok connector!

    def modify_top(self,top):
        module = 'adc_interface'
        inst = top.get_instance(entity=module, name=self.fullname, comment=self.fullname)
        
        # External ports
        inst.add_port('adc_clk_p',  self.fullname+'_adc_clk_p', dir='in', parent_port=True)
        inst.add_port('adc_clk_n',  self.fullname+'_adc_clk_n', dir='in', parent_port=True)
        inst.add_port('adc_sync_p', self.fullname+'_adc_sync_p', dir='in', parent_port=True)
        inst.add_port('adc_sync_n', self.fullname+'_adc_sync_n', dir='in', parent_port=True)

        inst.add_port('adc_outofrangei_p', self.fullname+'_adc_outofrangei_p', dir='in', parent_port=True)
        inst.add_port('adc_outofrangei_n', self.fullname+'_adc_outofrangei_n', dir='in', parent_port=True)
        inst.add_port('adc_outofrangeq_p', self.fullname+'_adc_outofrangeq_p', dir='in', parent_port=True)
        inst.add_port('adc_outofrangeq_n', self.fullname+'_adc_outofrangeq_n', dir='in', parent_port=True)

        inst.add_port('adc_dataeveni_p', self.fullname+'_adc_dataeveni_p', dir='in', parent_port=True, width=8)
        inst.add_port('adc_dataeveni_n', self.fullname+'_adc_dataeveni_n', dir='in', parent_port=True, width=8)
        inst.add_port('adc_dataoddi_p',  self.fullname+'_adc_dataoddi_p',  dir='in', parent_port=True, width=8)
        inst.add_port('adc_dataoddi_n',  self.fullname+'_adc_dataoddi_n',  dir='in', parent_port=True, width=8)
        inst.add_port('adc_dataevenq_p', self.fullname+'_adc_dataevenq_p', dir='in', parent_port=True, width=8)
        inst.add_port('adc_dataevenq_n', self.fullname+'_adc_dataevenq_n', dir='in', parent_port=True, width=8)
        inst.add_port('adc_dataoddq_p',  self.fullname+'_adc_dataoddq_p',  dir='in', parent_port=True, width=8)
        inst.add_port('adc_dataoddq_n',  self.fullname+'_adc_dataoddq_n',  dir='in', parent_port=True, width=8)

        inst.add_port('adc_ddrb_p', self.fullname+'_adc_ddrb_p', dir='out', parent_port=True)
        inst.add_port('adc_ddrb_n', self.fullname+'_adc_ddrb_n', dir='out', parent_port=True)

        # ports going to the user interface
        inst.add_port('user_datai0', self.fullname+'_user_datai0', width=8)
        inst.add_port('user_datai1', self.fullname+'_user_datai1', width=8)
        inst.add_port('user_datai2', self.fullname+'_user_datai2', width=8)
        inst.add_port('user_datai3', self.fullname+'_user_datai3', width=8)
        inst.add_port('user_dataq0', self.fullname+'_user_dataq0', width=8)
        inst.add_port('user_dataq1', self.fullname+'_user_dataq1', width=8)
        inst.add_port('user_dataq2', self.fullname+'_user_dataq2', width=8)
        inst.add_port('user_dataq3', self.fullname+'_user_dataq3', width=8)

        inst.add_port('user_outofrangei0', self.fullname+'_user_outofrangei0')
        inst.add_port('user_outofrangei1', self.fullname+'_user_outofrangei1')
        inst.add_port('user_outofrangeq0', self.fullname+'_user_outofrangeq0')
        inst.add_port('user_outofrangeq1', self.fullname+'_user_outofrangeq1')

        inst.add_port('user_sync0', self.fullname+'_user_sync0')
        inst.add_port('user_sync1', self.fullname+'_user_sync1')
        inst.add_port('user_sync2', self.fullname+'_user_sync2')
        inst.add_port('user_sync3', self.fullname+'_user_sync3')
        
        inst.add_port('user_data_valid', self.fullname+'_user_data_valid')

        # internal ports
        inst.add_port('mmcm_reset', self.fullname+'_mmcm_reset')
        inst.add_port('ctrl_reset', self.fullname+'_ctrl_reset')
        inst.add_port('ctrl_clk_in'    , 'user_clk') 
        inst.add_port('ctrl_clk_out'   , 'adc%d_clk' % self.adc_brd)
        inst.add_port('ctrl_clk90_out' , 'adc%d_clk90' % self.adc_brd)
        inst.add_port('ctrl_clk180_out', 'adc%d_clk180' % self.adc_brd)
        inst.add_port('ctrl_clk270_out', 'adc%d_clk270' % self.adc_brd)
        inst.add_port('ctrl_dcm_locked', self.fullname+'ctrl_dcm_locked')

        inst.add_port('dcm_psclk', self.fullname+'_dcm_psclk')
        inst.add_port('dcm_psen', self.fullname+'_dcm_psen')
        inst.add_port('dcm_psincdec', self.fullname+'_dcm_psincdec')
        inst.add_port('mmcm_psdone', self.fullname+'_mmcm_psdone')


        # Now the ADC controller
        module = 'wb_adccontroller'
        inst = top.get_instance(entity=module, name='adc%d_wb_controller' % self.adc_brd, comment=self.fullname)
        inst.add_wb_interface(regname='iadc%d_controller' % self.adc_brd, nbytes=0x10, mode='rw')
        inst.add_port('adc3wire_clk   ', self.fullname+'_adc3wire_clk   ', dir='out', parent_port=True)
        inst.add_port('adc3wire_data  ', self.fullname+'_adc3wire_data  ', dir='out', parent_port=True)
        inst.add_port('adc3wire_strobe', self.fullname+'_adc3wire_strobe', dir='out', parent_port=True)
        inst.add_port('modepin        ', self.fullname+'_modepin        ', dir='out', parent_port=True)
        inst.add_port('ddrb           ', self.fullname+'_ctrl_reset     ')
        inst.add_port('mmcm_reset     ', self.fullname+'_mmcm_reset     ')
        inst.add_port('psclk          ', self.fullname+'_dcm_psclk      ')
        inst.add_port('psen           ', self.fullname+'_dcm_psen       ')
        inst.add_port('psincdec       ', self.fullname+'_dcm_psincdec   ')
        inst.add_port('psdone         ', self.fullname+'_mmcm_psdone    ')
        #inst.add_port('clk            ', self.fullname+'_clk            ')


    def gen_constraints(self):
        cons = []
        # shortcuts to handy strings
        adcport = 'zdok%d' % self.adc_brd
        adcportp = 'zdok%d_p' % self.adc_brd
        adcportn = 'zdok%d_n' % self.adc_brd
        adcstr = self.fullname + '_'
        
        cons.append(PortConstraint(adcstr + 'adc_clk_p', adcportp, iogroup_index=39))
        cons.append(PortConstraint(adcstr + 'adc_clk_n', adcportn, iogroup_index=39))
        cons.append(PortConstraint(adcstr + 'adc_sync_p', adcportp, iogroup_index=38))
        cons.append(PortConstraint(adcstr + 'adc_sync_n', adcportn, iogroup_index=38))
        cons.append(PortConstraint(adcstr + 'adc_outofrangei_p', adcportp, iogroup_index=18))
        cons.append(PortConstraint(adcstr + 'adc_outofrangei_n', adcportn, iogroup_index=18))
        cons.append(PortConstraint(adcstr + 'adc_outofrangeq_p', adcportp, iogroup_index=28))
        cons.append(PortConstraint(adcstr + 'adc_outofrangeq_n', adcportn, iogroup_index=28))
        cons.append(PortConstraint(adcstr + 'adc_ddrb_p', adcportp, iogroup_index=29))
        cons.append(PortConstraint(adcstr + 'adc_ddrb_n', adcportn, iogroup_index=29))

        cons.append(PortConstraint(adcstr + 'adc_dataeveni_p', adcportp, port_index=range(8), iogroup_index=[11, 13, 15, 17, 31, 33, 35, 37]))
        cons.append(PortConstraint(adcstr + 'adc_dataeveni_n', adcportn, port_index=range(8), iogroup_index=[11, 13, 15, 17, 31, 33, 35, 37]))
        cons.append(PortConstraint(adcstr + 'adc_dataoddi_p', adcportp, port_index=range(8), iogroup_index=[10, 12, 14, 16, 30, 32, 34, 36]))
        cons.append(PortConstraint(adcstr + 'adc_dataoddi_n', adcportn, port_index=range(8), iogroup_index=[10, 12, 14, 16, 30, 32, 34, 36]))
        cons.append(PortConstraint(adcstr + 'adc_dataevenq_p', adcportp, port_index=range(8), iogroup_index=[6, 4, 2, 0, 26, 24, 22, 20]))
        cons.append(PortConstraint(adcstr + 'adc_dataevenq_n', adcportn, port_index=range(8), iogroup_index=[6, 4, 2, 0, 26, 24, 22, 20]))
        cons.append(PortConstraint(adcstr + 'adc_dataoddq_p', adcportp, port_index=range(8), iogroup_index=[7, 5, 3, 1, 27, 25, 23, 21]))
        cons.append(PortConstraint(adcstr + 'adc_dataoddq_n', adcportn, port_index=range(8), iogroup_index=[7, 5, 3, 1, 27, 25, 23, 21]))


        cons.append(PortConstraint(adcstr + 'modepin',         adcport, iogroup_index=16))
        cons.append(PortConstraint(adcstr + 'adc3wire_clk',    adcport, iogroup_index=17))
        cons.append(PortConstraint(adcstr + 'adc3wire_strobe', adcport, iogroup_index=18))
        cons.append(PortConstraint(adcstr + 'adc3wire_data',   adcport, iogroup_index=19))

        clkconst = ClockConstraint(adcstr + 'adc_clk_p', adcstr + '_clk', freq = self.adc_clk_rate / 4.)
        cons.append(clkconst)
        cons.append(RawConstraint('set_clock_groups -name async_sysclk_adcclk -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % (clkconst.name)))

        cons.append(RawConstraint('set_property DIFF_TERM TRUE [get_ports %sadc_clk_p]' % adcstr))
        cons.append(RawConstraint('set_property DIFF_TERM TRUE [get_ports %sadc_sync_p]' % adcstr))
        cons.append(RawConstraint('set_property DIFF_TERM TRUE [get_ports %sadc_outofrangei_p]' % adcstr))
        cons.append(RawConstraint('set_property DIFF_TERM TRUE [get_ports %sadc_outofrangeq_p]' % adcstr))
        for i in range(8):
            cons.append(RawConstraint('set_property DIFF_TERM TRUE [get_ports %sadc_dataeveni_p[%d]]' % (adcstr, i)))
            cons.append(RawConstraint('set_property DIFF_TERM TRUE [get_ports %sadc_dataoddi_p[%d]]' % (adcstr, i)))
            cons.append(RawConstraint('set_property DIFF_TERM TRUE [get_ports %sadc_dataevenq_p[%d]]' % (adcstr,i)))
            cons.append(RawConstraint('set_property DIFF_TERM TRUE [get_ports %sadc_dataoddq_p[%d]]' % (adcstr,i)))

        return cons

        
