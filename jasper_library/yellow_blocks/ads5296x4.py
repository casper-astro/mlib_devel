from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint, InputDelayConstraint
from .yellow_block_typecodes import *
from math import log, ceil
import math, numpy as np

from string import ascii_lowercase

class ads5296x4(YellowBlock):
    # Number of ADC chips per board
    num_units_per_board = 4
    adc_resolution = 10
    lanes_per_unit = 8
    channels_per_unit = 4
    lanes_per_channel = lanes_per_unit // channels_per_unit
    def initialize(self):
        # Compute line clock rate. Factor of 2.0 is for DDR
        self.line_clock_freq = self.adc_resolution * self.sample_rate / self.lanes_per_channel / 2.0
        self.logger.info("ADC {0} has line clock {1} MHz".format(self.name, self.line_clock_freq))

        self.add_source('ads5296x4_interface_v2/*.v')
        self.add_source('spi_master/spi_master.v')
        self.add_source('spi_master/wb_spi_master.v')
        self.provides = ['adc%d_clk' % self.port, 'adc%d_clk90' % self.port, 'adc%d_clk180' % self.port, 'adc%d_clk270' % self.port]

        self.port_prefix = self.blocktype + 'fmc%d' % self.port

    def modify_top(self,top):
        module = 'ads5296x4_interface_v2'
        for b in range(self.board_count):
            inst = top.get_instance(entity=module, name="%s_%d" % (self.fullname, b))
            inst.add_port('lclk_p', '%s_%d_lclk_p' % (self.port_prefix, b), parent_port=True, dir='in')
            inst.add_port('lclk_n', '%s_%d_lclk_n' % (self.port_prefix, b), parent_port=True, dir='in')
            inst.add_port('fclk_p', '%s_%d_fclk_p' % (self.port_prefix, b), parent_port=True, dir='in')
            inst.add_port('fclk_n', '%s_%d_fclk_n' % (self.port_prefix, b), parent_port=True, dir='in')
            inst.add_port('sclk', 'user_clk')
            inst.add_port('din_p', '%s_%d_din_p' % (self.port_prefix, b), parent_port=True, width=self.num_units_per_board*self.lanes_per_unit, dir='in')
            inst.add_port('din_n', '%s_%d_din_n' % (self.port_prefix, b), parent_port=True, width=self.num_units_per_board*self.lanes_per_unit, dir='in')
            inst.add_port('dout', '%s_%d_dout' % (self.fullname, b), width=self.adc_resolution*self.num_units_per_board*self.channels_per_unit)
            # User clock always comes from board 0
            if b == 0:
                inst.add_port('clk_out', 'adc%d_clk' % self.port)

            # split out the ports which go to simulink
            for xn, x in enumerate(ascii_lowercase[b*self.num_units_per_board : (b+1) * self.num_units_per_board]):
                for c in range(self.channels_per_unit):
                    top.assign_signal(
                        '%s_%s%d' % (self.fullname, x, c+1),
                        '%s_%d_dout[%d-1:%d]' % (self.fullname, b, (self.channels_per_unit*xn+c+1)*self.adc_resolution, (self.channels_per_unit*xn + c)*self.adc_resolution),
                    )
        
        # The simulink yellow block provides a simulink-input to drive sync / reset. These can be passed straight
        # to top-level ports. Let the synthesizer infer buffers.
        top.add_port('%s_adc_sync' % self.port_prefix, dir='out')
        top.add_port('%s_adc_rst'  %self.port_prefix, dir='out')
        top.assign_signal('%s_adc_sync' % self.port_prefix, '%s_adc_sync' % self.fullname)
        top.assign_signal('%s_adc_rst'  % self.port_prefix, '~%s_adc_rst' % self.fullname) # Invert

        # wb controller

        wbctrl = top.get_instance(entity='wb_spi_master', name='wb_ads5296_controller%d' % self.port)
        wbctrl.add_wb_interface(nbytes=4*2, regname='ads5296_controller%d' % self.port, mode='rw', typecode=self.typecode)
        wbctrl.add_port('cs_n', '%s_cs_n' % self.port_prefix, dir='out', parent_port=True, width=3)
        wbctrl.add_port('sclk', '%s_sclk' % self.port_prefix, dir='out', parent_port=True)
        wbctrl.add_port('mosi', '%s_mosi' % self.port_prefix, dir='out', parent_port=True)
        wbctrl.add_port('miso', '%s_miso' % self.port_prefix, dir='out', parent_port=True)

        # Tie phased clocks to zero for now. TODO
        top.add_signal("adc%d_clk90" % self.port)
        top.add_signal("adc%d_clk180" % self.port)
        top.add_signal("adc%d_clk270" % self.port)
        top.assign_signal("adc%d_clk90" % self.port, "1'b0")
        top.assign_signal("adc%d_clk180" % self.port, "1'b0")
        top.assign_signal("adc%d_clk270" % self.port, "1'b0")

        #snap_chan = ascii_lowercase
        #for k in range(self.num_units):
        #    # Embedded wb-RAM
        #    bram_log_width = int(ceil(log(self.adc_data_width*4,2)))
        #    padding = 2**(bram_log_width-2) - self.adc_data_width
        #    din = self.fullname+'_%s'%snap_chan[k]
        #    wbram = top.get_instance(entity='wb_bram', name='adc16_wb_ram%d_%d' % (self.port, k), comment='Embedded ADC16 bram')
        #    wbram.add_parameter('LOG_USER_WIDTH', bram_log_width)
        #    wbram.add_parameter('USER_ADDR_BITS','10')
        #    wbram.add_parameter('N_REGISTERS','2')
        #    wbram.add_wb_interface(regname='adc16_wb_ram%d_%d' % (self.port, k), mode='rw', nbytes=(2**bram_log_width//8)*2**10, typecode=TYPECODE_SWREG)
        #    wbram.add_port('user_clk','user_clk', parent_sig=False)
        #    wbram.add_port('user_addr', self.port_prefix+'snap_addr', width=10)
        #    wbram.add_port('user_din',self.reorder_ports([din+'1',din+'2',din+'3',din+'4'], wb_bitwidth=64, word_width=16, padding="%s'b0" % padding), parent_sig=False)
        #    wbram.add_port('user_we', self.port_prefix+'snap_we')
        #    wbram.add_port('user_dout','')

    def reorder_ports(self, port_list, wb_bitwidth=32, word_width=8, padding=None):
        """ Reorder output ports of ADCs to arrange sampling data in correct order in wb_bram

            wb_bitwidth stands for the bit width of data in/out port of wishbone bus
            word_width is the number of bits in a single word (i.e., one element of `port_list`) _after_ padding.

            .. code-block:: python

                reorder_ports(['a1','a2','a3','a4'])
                when self.adc_data_width == 8, return {a1,a2,a3,a4}
                when self.adc_data_width == 16, return {a3,a4,a1,a2}
                when self.adc_data_width == 32, return {a4,a3,a2,a1}

                reorder_ports(['a1','a2','a3','a4'], padding="6'b0")
                when self.adc_data_width == 8, return "{a1,6'b0,a2,6'b0,a3,6'b0,a4,6'b0}"
        """

        if not isinstance(port_list,list):
            raise ValueError("Parameter error")
        elif any([not isinstance(port,str) for port in port_list]):
            raise ValueError("Parameter error")

        r = wb_bitwidth // word_width
        port_list = np.array(port_list).reshape(-1, r)
        port_list = port_list[::-1,:].reshape(-1).tolist()
        if padding is None:
            return '{' + ','.join(port_list) + '}'
        else:
            port_list_padded = []
            for port in port_list:
                port_list_padded += [port]
                port_list_padded += [padding]
            return '{' + ','.join(port_list) + '}'

    def gen_constraints(self):
        cons = []

        # The first ADC board uses the LA pins in order for data
        for pol in ['p', 'n']:
            cons.append(PortConstraint(
                '%s_0_din_%s' % (self.port_prefix, pol),
                'fmc%d_la_%s' % (self.port, pol),
                port_index=list(range(2*4*self.num_units_per_board)),
                iogroup_index=range(2*4*self.num_units_per_board),
            ))

        # Add the clock pins for board 0
        cons.append(PortConstraint('%s_0_lclk_p' % (self.port_prefix), 'fmc%d_clk_p' % self.port, iogroup_index=0))
        cons.append(PortConstraint('%s_0_lclk_n' % (self.port_prefix), 'fmc%d_clk_n' % self.port, iogroup_index=0))
        cons.append(PortConstraint('%s_0_fclk_p' % (self.port_prefix), 'fmc%d_hb_p' % self.port, iogroup_index=18))
        cons.append(PortConstraint('%s_0_fclk_n' % (self.port_prefix), 'fmc%d_hb_n' % self.port, iogroup_index=18))

        # Add the single ended pins
        # in single-ended numbering, N pin is 1 greater than P pin
        # I.e. fmc0_la_p[33] = fmc0_la[66]; fmc0_la_n[33] = fmc0_la[67]
        cons.append(PortConstraint('%s_cs_n' % self.port_prefix,  'fmc%d_la' % self.port, port_index=[0], iogroup_index=[2*33]))
        cons.append(PortConstraint('%s_cs_n' % self.port_prefix,  'fmc%d_la' % self.port, port_index=[1], iogroup_index=[2*33+1]))
        cons.append(PortConstraint('%s_cs_n' % self.port_prefix,  'fmc%d_hb' % self.port, port_index=[2], iogroup_index=[2*17]))
        cons.append(PortConstraint('%s_mosi' % self.port_prefix,  'fmc%d_la' % self.port, iogroup_index=2*32))
        cons.append(PortConstraint('%s_sclk' % self.port_prefix,  'fmc%d_la' % self.port, iogroup_index=2*32+1))
        cons.append(PortConstraint('%s_miso' % self.port_prefix,  'fmc%d_hb' % self.port, iogroup_index=2*17+1))
        cons.append(PortConstraint('%s_adc_sync' % self.port_prefix,  'fmc%d_hb' % self.port, iogroup_index=19))
        cons.append(PortConstraint('%s_adc_rst' % self.port_prefix,  'fmc%d_hb' % self.port, iogroup_index=19+1))


        if self.board_count > 1:
            # Add the clock pins for board 1
            cons.append(PortConstraint('%s_1_lclk_p' % (self.port_prefix), 'fmc%d_clk_p' % self.port, iogroup_index=2))
            cons.append(PortConstraint('%s_1_lclk_n' % (self.port_prefix), 'fmc%d_clk_n' % self.port, iogroup_index=2))
            cons.append(PortConstraint('%s_1_fclk_p' % (self.port_prefix), 'fmc%d_ha_p' % self.port, iogroup_index=0))
            cons.append(PortConstraint('%s_1_fclk_n' % (self.port_prefix), 'fmc%d_ha_n' % self.port, iogroup_index=0))
            for pol in ['p', 'n']:
                # Chip 0
                cons.append(PortConstraint(
                    '%s_1_din_%s' % (self.port_prefix, pol),
                    'fmc%d_ha_%s' % (self.port, pol),
                    port_index=list(range(8)),
                    iogroup_index=range(2,2+8),
                ))
                # Chip 1
                cons.append(PortConstraint(
                    '%s_1_din_%s' % (self.port_prefix, pol),
                    'fmc%d_ha_%s' % (self.port, pol),
                    port_index=list(range(7)),
                    iogroup_index=range(10,10+7),
                ))
                cons.append(PortConstraint(
                    '%s_1_din_%s' % (self.port_prefix, pol),
                    'fmc%d_hb_%s' % (self.port, pol),
                    port_index=[7],
                    iogroup_index=[0],
                ))
                # Chip 2
                cons.append(PortConstraint(
                    '%s_1_din_%s' % (self.port_prefix, pol),
                    'fmc%d_hb_%s' % (self.port, pol),
                    port_index=list(range(8)),
                    iogroup_index=range(1,1+8),
                ))
                # Chip 3
                cons.append(PortConstraint(
                    '%s_1_din_%s' % (self.port_prefix, pol),
                    'fmc%d_hb_%s' % (self.port, pol),
                    port_index=list(range(8)),
                    iogroup_index=range(9,9+8),
                ))

        # TODO: cons.append(PortConstraint('adc_rst_n', 'adc_rst_n', port_index=list(range(3)), iogroup_index=list(range(3))))
        # TODO: cons.append(PortConstraint('adc_pd', 'adc_pd', port_index=list(range(3)), iogroup_index=list(range(3))))
        
        # clock constraint with variable period
        clkconst0 = ClockConstraint('%s_0_lclk_p' % self.port_prefix, name='adc_lclk0', freq=self.line_clock_freq)
        cons.append(clkconst0)
        if self.board_count > 1:
            clkconst1 = ClockConstraint('%s_1_lclk_p' % self.port_prefix, name='adc_clk1', freq=self.line_clock_freq)
            cons.append(clkconst1)

        # TODO set the skew of board 1 relative to board 0
        for i in range(self.lanes_per_unit):
            for pol in ['p', 'n']:
                for b in range(self.board_count):
                    cons.append(InputDelayConstraint(clkname=clkconst0.name, consttype='min', constdelay_ns=0.2, portname="%s_%d_din_%s[%d]" % (self.port_prefix, b, pol, i)))
                    cons.append(InputDelayConstraint(clkname=clkconst0.name, consttype='max', constdelay_ns=0.16, portname="%s_%d_din_%s[%d]" % (self.port_prefix, b, pol, i)))
                cons.append(InputDelayConstraint(clkname=clkconst0.name, consttype='min', constdelay_ns=0.2, portname="%s_%d_fclk_%s" % (self.port_prefix, b, pol)))
                cons.append(InputDelayConstraint(clkname=clkconst0.name, consttype='max', constdelay_ns=0.16, portname="%s_%d_fclk_%s" % (self.port_prefix, b, pol)))

        cons.append(RawConstraint('set_clock_groups -name async_sysclk_adcclk -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % clkconst0.name))
        cons.append(RawConstraint('set_multicycle_path -from [get_clocks -include_generated_clocks %s] -to [get_clocks -include_generated_clocks sys_clk0_dcm] 3' % clkconst0.name))
        cons.append(RawConstraint('set_multicycle_path -from [get_clocks -include_generated_clocks %s] -to [get_clocks -include_generated_clocks sys_clk0_dcm] -hold 2' % clkconst0.name))

        return cons
