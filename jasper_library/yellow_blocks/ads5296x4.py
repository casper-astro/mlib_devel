from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint, InputDelayConstraint, FalsePathConstraint
from .yellow_block_typecodes import *
from math import log, ceil
import math, numpy as np

from string import ascii_lowercase

SNAPSHOT_ADDR_BITS = 9

class ads5296x4(YellowBlock):
    # Number of ADC chips per board
    num_units_per_board = 4
    adc_resolution = 10
    lanes_per_unit = 8
    channels_per_unit = 4
    lanes_per_channel = lanes_per_unit // channels_per_unit
    # version 1: Pinout "Alt2 pinout" (First boards manufactured)
    # version 2: Pinout "Alt3 pinout"
    version = 1 # May be overwritten by block attributes
    def initialize(self):
        # Compute line clock rate. Factor of 2.0 is for DDR
        self.line_clock_freq_mhz = self.adc_resolution * self.sample_rate / self.lanes_per_channel / 2.0
        self.logger.info("ADC {0} has line clock {1} MHz".format(self.name, self.line_clock_freq_mhz))

        self.add_source('ads5296x4_interface_v2/ads5296x4_interface_demux2.v')
        self.add_source('ads5296x4_interface_v2/ads5296_unit.v')
        self.add_source('ads5296x4_interface_v2/wb_ads5296_attach.v')
        self.add_source('ads5296x4_interface_v2/data_fifo.xci')
        self.add_source('spi_master/spi_master.v')
        self.add_source('spi_master/wb_spi_master.v')
        self.add_source('wb_bram')
        if self.port == self.clockport:
            self.provides = [
                             'adc%d_clk' % self.port,
                             'adc%d_clk90' % self.port,
                             'adc%d_clk180' % self.port,
                             'adc%d_clk270' % self.port,
                             'ads5296_%d_sclk' % self.port,
                             'ads5296_%d_sclk2' % self.port,
                             'ads5296_%d_sclk5' % self.port,
                            ]
        self.requires = [
                         'ads5296_%d_sclk' % self.clockport,
                         'ads5296_%d_sclk2' % self.clockport,
                         'ads5296_%d_sclk5' % self.clockport,
                        ]

        self.port_prefix = self.blocktype + 'fmc%d' % self.port

    def gen_children(self):
        ## A register to control the which ADC on this FMC is providing the clock
        #swreg = YellowBlock.make_block({'tag':'xps:sw_reg_sync',
        #                                'fullpath':'%s/ads5296_clksel%d'%(self.name,self.port),
        #                                'io_dir':'From Processor',
        #                                'name':'ads5296_clksel%d'%self.port},
        #                               self.platform)
        #return [swreg]
        rst_reg = YellowBlock.make_block({'tag':'xps:sw_reg_sync',
                                        'fullpath':'%s/ads5296_hardware_rst%d'%(self.name,self.port),
                                        'io_dir':'From Processor',
                                        'name':'ads5296_hardware_rst%d'%self.port},
                                        self.platform)
        return [rst_reg]

    def modify_top(self,top):
        # Connect up the reset register
        module = 'ads5296x4_interface_demux2'
        for b in range(self.board_count):
            inst = top.get_instance(entity=module, name="%s_%d" % (self.fullname, b))
            inst.add_wb_interface(nbytes=32*4, regname='ads5296_controller%d_%d' % (self.port, b), mode='rw', typecode=self.typecode)
            inst.add_parameter('G_SNAPSHOT_ADDR_BITS', SNAPSHOT_ADDR_BITS)
            inst.add_parameter('G_VERSION', self.version)
            # Delare all boards master, so that they all instantiate
            # Their own internal clock generators.
            # We will decide which of these to actually use at runtime
            inst.add_port('rst', '%s_adc_rst' % self.fullname)
            inst.add_port('sync', '%s_adc_sync' % self.fullname)
            inst.add_port('lclk_p', '%s_%d_lclk_p' % (self.port_prefix, b), parent_port=True, dir='in')
            inst.add_port('lclk_n', '%s_%d_lclk_n' % (self.port_prefix, b), parent_port=True, dir='in')

            if b == 0:
                inst.add_parameter("G_IS_MASTER", "1'b1")
                # If G_IS_MASTER is 0, these clocks are tied to zero
                inst.add_port('sclk_out', 'ads5296_%d_sclk' % (self.port))
                inst.add_port('sclk2_out', 'ads5296_%d_sclk2' % (self.port))
                inst.add_port('sclk5_out', 'ads5296_%d_sclk5' % (self.port))
                inst.add_parameter("G_NUM_FCLKS", "2")
                inst.add_parameter("G_FCLK_MASTER", "0") # FCLK from chip A is on a clock-capable pin
                # Board 0 always controls the external sync
                inst.add_port("ext_sync_out", "%s_adc_sync" % self.port_prefix, dir="out", parent_port=True)
                inst.add_port('fclk_p', '%s_%d_fclk_p' % (self.fullname, b), width=2)
                inst.add_port('fclk_n', '%s_%d_fclk_n' % (self.fullname, b), width=2)
                if self.board_count == 2:
                    inst.add_port('fclk_in', '{adc%d_fclk1, adc%d_fclk0}' % (self.clockport, self.clockport))
                else:
                    inst.add_port('fclk_in', '{adc%d_fclk0, adc%d_fclk0}' % (self.clockport))
                top.add_port('%s_%d_fclk0_p' % (self.port_prefix, b), dir='in')
                top.add_port('%s_%d_fclk0_n' % (self.port_prefix, b), dir='in')
                top.assign_signal('%s_%d_fclk_p[0]' % (self.fullname, b), '%s_%d_fclk0_p' % (self.port_prefix, b))
                top.assign_signal('%s_%d_fclk_n[0]' % (self.fullname, b), '%s_%d_fclk0_n' % (self.port_prefix, b))
                top.add_port('%s_%d_fclk2_p' % (self.port_prefix, b), dir='in')
                top.add_port('%s_%d_fclk2_n' % (self.port_prefix, b), dir='in')
                top.assign_signal('%s_%d_fclk_p[1]' % (self.fullname, b), '%s_%d_fclk2_p' % (self.port_prefix, b))
                top.assign_signal('%s_%d_fclk_n[1]' % (self.fullname, b), '%s_%d_fclk2_n' % (self.port_prefix, b))
            elif b == 1:
                inst.add_parameter("G_IS_MASTER", "1'b0") 
                inst.add_parameter("G_NUM_FCLKS", "3")
                if self.version == 1:
                    inst.add_parameter("G_FCLK_MASTER", "1") # FCLK from chip B is the first on a clock-capable pin
                elif self.version == 2:
                    inst.add_parameter("G_FCLK_MASTER", "0") # FCLK from chip A is the first on a clock-capable pin
                # Board 0 always controls the external sync
                inst.add_port("ext_sync_out", '')
                inst.add_port('sclk_out', '')
                inst.add_port('sclk2_out', '')
                inst.add_port('sclk5_out', '')
                inst.add_port('fclk_p', '%s_%d_fclk_p' % (self.fullname, b), width=3)
                inst.add_port('fclk_n', '%s_%d_fclk_n' % (self.fullname, b), width=3)
                inst.add_port('fclk_in', '2\'b0')
                top.add_port('%s_%d_fclk0_p' % (self.port_prefix, b), dir='in')
                top.add_port('%s_%d_fclk0_n' % (self.port_prefix, b), dir='in')
                top.assign_signal('%s_%d_fclk_p[0]' % (self.fullname, b), '%s_%d_fclk0_p' % (self.port_prefix, b))
                top.assign_signal('%s_%d_fclk_n[0]' % (self.fullname, b), '%s_%d_fclk0_n' % (self.port_prefix, b))
                top.add_port('%s_%d_fclk1_p' % (self.port_prefix, b), dir='in')
                top.add_port('%s_%d_fclk1_n' % (self.port_prefix, b), dir='in')
                top.assign_signal('%s_%d_fclk_p[1]' % (self.fullname, b), '%s_%d_fclk1_p' % (self.port_prefix, b))
                top.assign_signal('%s_%d_fclk_n[1]' % (self.fullname, b), '%s_%d_fclk1_n' % (self.port_prefix, b))
                top.add_port('%s_%d_fclk2_p' % (self.port_prefix, b), dir='in')
                top.add_port('%s_%d_fclk2_n' % (self.port_prefix, b), dir='in')
                top.assign_signal('%s_%d_fclk_p[2]' % (self.fullname, b), '%s_%d_fclk2_p' % (self.port_prefix, b))
                top.assign_signal('%s_%d_fclk_n[2]' % (self.fullname, b), '%s_%d_fclk2_n' % (self.port_prefix, b))
            inst.add_port('fclk_out', 'adc%d_fclk%d' % (self.port, b))
            inst.add_port('sclk2_in', 'user_clk')
            inst.add_port('sclk_in', 'ads5296_%d_sclk' % (self.port))
            inst.add_port('sclk5_in', 'ads5296_%d_sclk5' % (self.port))
            inst.add_port('din_p', '%s_%d_din_p' % (self.port_prefix, b), parent_port=True, width=self.num_units_per_board*self.lanes_per_unit, dir='in')
            inst.add_port('din_n', '%s_%d_din_n' % (self.port_prefix, b), parent_port=True, width=self.num_units_per_board*self.lanes_per_unit, dir='in')
            inst.add_port('dout', '%s_%d_dout' % (self.fullname, b), width=self.adc_resolution*self.num_units_per_board*self.channels_per_unit)

            # Always derive simulink sync out from first board
            if b == 0:
                inst.add_port('sync_out', '%s_adc_sync_out' % self.fullname)
            else:
                inst.add_port('sync_out', '')


            # snapshot ports
            inst.add_port('snapshot_ext_trigger', '%s_snapshot_ext_trigger' % self.fullname) # simulink input
            inst.add_port('snapshot_we', '%s_snapshot_we_%d' % (self.fullname, b))
            inst.add_port('snapshot_addr', '%s_snapshot_addr_%d' % (self.fullname, b), width=SNAPSHOT_ADDR_BITS)


            # split out the ports which go to simulink
            for xn, x in enumerate(ascii_lowercase[b*self.num_units_per_board : (b+1) * self.num_units_per_board]):
                for c in range(self.channels_per_unit):
                    signal = '%s_%s%d' % (self.fullname, x, c+1)
                    top.add_signal(signal, width=10)
                    top.assign_signal(
                        signal,
                        '%s_%d_dout[%d-1:%d]' % (self.fullname, b, (self.channels_per_unit*xn+c+1)*self.adc_resolution, (self.channels_per_unit*xn + c)*self.adc_resolution),
                    )
        
        # The master FPGA clock (which will get turned into user_clk if the Simulink
        # clock source is set to be this FMC port) is adcX_sclk2
        top.add_signal('adc%d_clk' % self.port)
        top.assign_signal('adc%d_clk' % self.port, 'ads5296_%d_sclk2' % self.port)

        # The simulink yellow block provides a simulink-input to drive reset. This can be passed straight
        # to top-level ports. Let the synthesizer infer buffers.
        top.add_port('%s_adc_rst'  %self.port_prefix, dir='out')
        #top.add_signal('%s_adc_rst' % self.fullname)
        top.assign_signal('%s_adc_rst'  % self.port_prefix, '~%s_ads5296_hardware_rst%d_user_data_out[0]' % (self.name, self.port)) # Invert
        #top.assign_signal('%s_adc_rst'  % self.port_prefix, '1\'b1') # active low
        #top.assign_signal('%s_adc_rst'  % self.port_prefix, '~%s_ads5296_rst%d_user_data_out[0]' % (self.name, self.port)) # Invert
        #top.assign_signal('%s_adc_sync'  % self.port_prefix, '%s_ads5296_sync%d_user_data_out[0]' % (self.name, self.port))

        # wb controller

        wbctrl = top.get_instance(entity='wb_spi_master', name='wb_ads5296_controller%d' % self.port)
        # Configure SPI settings.
        # NBITS=24 and NCLKDIVBITS=4 gives a latency on transactions of <500 clocks.
        # The toolflow currently uses a WB arbiter with a timeout of 1000.
        # Max ADC SPI clock rate is 20 MHz. SNAP2 wb_clk is 100 MHz --> using an SPI clock of 6.25MHz
        # If the delay needs to be longer, the wb_spi_master core should be modified so it
        # acks the WB bus immediately, and then lets the user poll a register to see if the SPI transaction
        # has finished.
        wbctrl.add_parameter("NBITS", 24)
        wbctrl.add_parameter("NCSBITS", 3)
        wbctrl.add_parameter("NCLKDIVBITS", 5)
        wbctrl.add_wb_interface(nbytes=4*4, regname='ads5296_spi_controller%d' % self.port, mode='rw', typecode=self.typecode)
        wbctrl.add_port('cs', '%s_cs' % self.port_prefix, dir='out', parent_port=True, width=3)
        wbctrl.add_port('sclk', '%s_sclk' % self.port_prefix, dir='out', parent_port=True)
        wbctrl.add_port('mosi', '%s_mosi' % self.port_prefix, dir='out', parent_port=True)
        wbctrl.add_port('miso', '%s_miso' % self.port_prefix, dir='in', parent_port=True)

        #top.add_port('%s_cs' % self.port_prefix, dir='out', width=3)
        #top.add_port('%s_sclk' % self.port_prefix, dir='out')
        #top.add_port('%s_mosi' % self.port_prefix, dir='out')
        #top.add_port('%s_miso' % self.port_prefix, dir='in')
        #top.assign_signal('%s_cs' % self.port_prefix, '%s_ads5296_spi_out%d_user_data_out[2:0]' % (self.name, self.port))
        #top.assign_signal('%s_sclk' % self.port_prefix, '%s_ads5296_spi_out%d_user_data_out[3]' % (self.name, self.port))
        #top.assign_signal('%s_mosi' % self.port_prefix, '%s_ads5296_spi_out%d_user_data_out[4]' % (self.name, self.port))
        #top.assign_signal('%s_ads5296_spi_in%d_user_data_in[0]' % (self.name, self.port), '%s_miso' % self.port_prefix)

        top.add_signal('ila_miso%d' % self.port, attributes={'keep': '"true"'})
        top.add_signal('ila_mosi%d' % self.port, attributes={'keep': '"true"'})
        top.add_signal('ila_cs%d'   % self.port, attributes={'keep': '"true"'}, width=3)
        top.add_signal('ila_sclk%d' % self.port, attributes={'keep': '"true"'})
        top.add_signal('ila_sync%d' % self.port, attributes={'keep': '"true"'})
        top.add_signal('ila_rst%d'  % self.port, attributes={'keep': '"true"'})
        top.assign_signal('ila_cs%d'   % self.port, '%s_cs' % self.port_prefix)
        top.assign_signal('ila_miso%d' % self.port, '%s_miso' % self.port_prefix)
        top.assign_signal('ila_mosi%d' % self.port, '%s_mosi' % self.port_prefix)
        top.assign_signal('ila_sclk%d' % self.port, '%s_sclk' % self.port_prefix)
        top.assign_signal('ila_sync%d' % self.port, '%s_adc_sync' % self.port_prefix)
        top.assign_signal('ila_rst%d'  % self.port, '%s_adc_rst' % self.port_prefix)

        # Tie phased clocks to zero for now. TODO
        top.add_signal("adc%d_clk90" % self.port)
        top.add_signal("adc%d_clk180" % self.port)
        top.add_signal("adc%d_clk270" % self.port)
        top.assign_signal("adc%d_clk90" % self.port, "1'b0")
        top.assign_signal("adc%d_clk180" % self.port, "1'b0")
        top.assign_signal("adc%d_clk270" % self.port, "1'b0")

        snap_chan = ascii_lowercase
        for b in range(self.board_count):
            for u in range(self.num_units_per_board): 
                    # Embedded wb-RAM
                    bram_log_width = int(ceil(log(self.adc_resolution*self.channels_per_unit,2)))
                    padding = 2**(bram_log_width-2) - self.adc_resolution
                    din = self.fullname+'_%s'%snap_chan[b*self.num_units_per_board + u]
                    wbram = top.get_instance(entity='wb_bram', name='ads5296_wb_ram%d_%d_%d' % (self.port, b, u), comment='Embedded ADS5296 bram for fmc %d, board %d, chip %d' % (self.port, b, u))
                    wbram.add_parameter('LOG_USER_WIDTH', bram_log_width)
                    wbram.add_parameter('USER_ADDR_BITS', SNAPSHOT_ADDR_BITS)
                    wbram.add_parameter('N_REGISTERS','2')
                    wbram.add_wb_interface(regname='ads5296_wb_ram%d_%d_%d' % (self.port, b, u), mode='rw', nbytes=(2**bram_log_width//8)*2**SNAPSHOT_ADDR_BITS, typecode=TYPECODE_SWREG)
                    wbram.add_port('user_clk','user_clk', parent_sig=False)
                    wbram.add_port('user_addr', '%s_snapshot_addr_%d' % (self.fullname, b), width=SNAPSHOT_ADDR_BITS)
                    wbram.add_port('user_din',self.reorder_ports([din+'1',din+'2',din+'3',din+'4'], word_width=16, padding="%d'b0" % padding), parent_sig=False)
                    wbram.add_port('user_we', '%s_snapshot_we_%d' % (self.fullname, b))
                    wbram.add_port('user_dout','')

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
            return '{' + ','.join(port_list_padded) + '}'

    def gen_constraints(self):
        cons = []
        assert self.version in [1,2], "Don't know what to do with version %d!" % self.version

        for pol in ['p', 'n']:
            if self.version == 1:
                # Chip 0
                cons.append(PortConstraint(
                    '%s_0_din_%s' % (self.port_prefix, pol),
                    'fmc%d_ha_%s' % (self.port, pol),
                    port_index=list(range(8)),
                    iogroup_index=range(2,2+8),
                ))
                # Chip 1
                cons.append(PortConstraint(
                    '%s_0_din_%s' % (self.port_prefix, pol),
                    'fmc%d_ha_%s' % (self.port, pol),
                    port_index=list(range(8,8+7)),
                    iogroup_index=range(10,10+7),
                ))
                cons.append(PortConstraint(
                    '%s_0_din_%s' % (self.port_prefix, pol),
                    'fmc%d_hb_%s' % (self.port, pol),
                    port_index=[15],
                    iogroup_index=[0],
                ))
            elif self.version == 2:
                # Chip 0
                cons.append(PortConstraint(
                    '%s_0_din_%s' % (self.port_prefix, pol),
                    'fmc%d_ha_%s' % (self.port, pol),
                    port_index=list(range(8)),
                    iogroup_index=range(1,1+8),
                ))
                # Chip 1
                cons.append(PortConstraint(
                    '%s_0_din_%s' % (self.port_prefix, pol),
                    'fmc%d_ha_%s' % (self.port, pol),
                    port_index=list(range(8,8+8)),
                    iogroup_index=range(9,9+8),
                ))
            # Chip 2
            cons.append(PortConstraint(
                '%s_0_din_%s' % (self.port_prefix, pol),
                'fmc%d_hb_%s' % (self.port, pol),
                port_index=list(range(16,16+8)),
                iogroup_index=range(1,1+8),
            ))
            # Chip 3
            cons.append(PortConstraint(
                '%s_0_din_%s' % (self.port_prefix, pol),
                'fmc%d_hb_%s' % (self.port, pol),
                port_index=list(range(24,24+8)),
                iogroup_index=range(9,9+8),
            ))

        # Add the clock pins for board 0
        cons.append(PortConstraint('%s_0_lclk_p' % (self.port_prefix), 'fmc%d_clk_p' % self.port, iogroup_index=2))
        cons.append(PortConstraint('%s_0_lclk_n' % (self.port_prefix), 'fmc%d_clk_n' % self.port, iogroup_index=2))
        if self.version == 1:
            cons.append(PortConstraint('%s_0_fclk0_p' % (self.port_prefix), 'fmc%d_ha_p' % self.port, iogroup_index=1))
            cons.append(PortConstraint('%s_0_fclk0_n' % (self.port_prefix), 'fmc%d_ha_n' % self.port, iogroup_index=1))
            cons.append(PortConstraint('%s_0_fclk2_p' % (self.port_prefix), 'fmc%d_ha_p' % self.port, iogroup_index=0))
            cons.append(PortConstraint('%s_0_fclk2_n' % (self.port_prefix), 'fmc%d_ha_n' % self.port, iogroup_index=0))
        elif self.version == 2:
            cons.append(PortConstraint('%s_0_fclk0_p' % (self.port_prefix), 'fmc%d_ha_p' % self.port, iogroup_index=0))
            cons.append(PortConstraint('%s_0_fclk0_n' % (self.port_prefix), 'fmc%d_ha_n' % self.port, iogroup_index=0))
            cons.append(PortConstraint('%s_0_fclk2_p' % (self.port_prefix), 'fmc%d_hb_p' % self.port, iogroup_index=0))
            cons.append(PortConstraint('%s_0_fclk2_n' % (self.port_prefix), 'fmc%d_hb_n' % self.port, iogroup_index=0))

        # Add the single ended pins
        # in single-ended numbering, N pin is 1 greater than P pin
        # I.e. fmc0_la_p[33] = fmc0_la[66]; fmc0_la_n[33] = fmc0_la[67]
        cons.append(PortConstraint('%s_cs' % self.port_prefix,  'fmc%d_la' % self.port, port_index=[0], iogroup_index=[2*32]))
        cons.append(PortConstraint('%s_cs' % self.port_prefix,  'fmc%d_la' % self.port, port_index=[1], iogroup_index=[2*32+1]))
        cons.append(PortConstraint('%s_cs' % self.port_prefix,  'fmc%d_hb' % self.port, port_index=[2], iogroup_index=[2*17]))
        cons.append(PortConstraint('%s_mosi' % self.port_prefix,  'fmc%d_la' % self.port, iogroup_index=2*33))
        cons.append(PortConstraint('%s_sclk' % self.port_prefix,  'fmc%d_la' % self.port, iogroup_index=2*33+1))
        cons.append(PortConstraint('%s_miso' % self.port_prefix,  'fmc%d_hb' % self.port, iogroup_index=2*17+1))
        cons.append(PortConstraint('%s_adc_sync' % self.port_prefix,  'fmc%d_hb' % self.port, iogroup_index=2*19))
        cons.append(PortConstraint('%s_adc_rst' % self.port_prefix,  'fmc%d_hb' % self.port, iogroup_index=2*19+1))


        if self.board_count > 1:
            # Add the clock pins for board 1
            cons.append(PortConstraint('%s_1_lclk_p' % (self.port_prefix), 'fmc%d_clk_p' % self.port, iogroup_index=0))
            cons.append(PortConstraint('%s_1_lclk_n' % (self.port_prefix), 'fmc%d_clk_n' % self.port, iogroup_index=0))
            # FCLKs from upper board A and B are swapped in version 2 (so that an upper board has both LCLK and FCLK from chip A on a clock capable pin)
            if self.version == 1:
                cons.append(PortConstraint('%s_1_fclk0_p' % (self.port_prefix), 'fmc%d_hb_p' % self.port, iogroup_index=18))
                cons.append(PortConstraint('%s_1_fclk0_n' % (self.port_prefix), 'fmc%d_hb_n' % self.port, iogroup_index=18))
                cons.append(PortConstraint('%s_1_fclk1_p' % (self.port_prefix), 'fmc%d_gbtclk_p' % self.port, iogroup_index=0))
                cons.append(PortConstraint('%s_1_fclk1_n' % (self.port_prefix), 'fmc%d_gbtclk_n' % self.port, iogroup_index=0))
            elif self.version == 2:
                cons.append(PortConstraint('%s_1_fclk0_p' % (self.port_prefix), 'fmc%d_gbtclk_p' % self.port, iogroup_index=0))
                cons.append(PortConstraint('%s_1_fclk0_n' % (self.port_prefix), 'fmc%d_gbtclk_n' % self.port, iogroup_index=0))
                cons.append(PortConstraint('%s_1_fclk1_p' % (self.port_prefix), 'fmc%d_hb_p' % self.port, iogroup_index=18))
                cons.append(PortConstraint('%s_1_fclk1_n' % (self.port_prefix), 'fmc%d_hb_n' % self.port, iogroup_index=18))
            cons.append(PortConstraint('%s_1_fclk2_p' % (self.port_prefix), 'fmc%d_gbtclk_p' % self.port, iogroup_index=1))
            cons.append(PortConstraint('%s_1_fclk2_n' % (self.port_prefix), 'fmc%d_gbtclk_n' % self.port, iogroup_index=1))
            # The second (top) ADC has more convenient pin assignment numbering
            for pol in ['p', 'n']:
                cons.append(PortConstraint(
                    '%s_1_din_%s' % (self.port_prefix, pol),
                    'fmc%d_la_%s' % (self.port, pol),
                    port_index=list(range(2*4*self.num_units_per_board)),
                    iogroup_index=range(2*4*self.num_units_per_board),
                ))


        # TODO: cons.append(PortConstraint('adc_rst_n', 'adc_rst_n', port_index=list(range(3)), iogroup_index=list(range(3))))
        # TODO: cons.append(PortConstraint('adc_pd', 'adc_pd', port_index=list(range(3)), iogroup_index=list(range(3))))
        
        # clock constraint with variable period
        clkconsts0 = []
        # Board 0 FCLK inputs
        clkconsts0 += [ClockConstraint('%s_0_fclk0_p' % self.port_prefix, name='adc_fclk%d_0_0' % self.port, freq=self.line_clock_freq_mhz / 5)]
        clkconsts0 += [ClockConstraint('%s_0_fclk2_p' % self.port_prefix, name='adc_fclk%d_0_2' % self.port, freq=self.line_clock_freq_mhz / 5)]
        # All these clocks are async with sys_clk
        for clkconst0 in clkconsts0:
            cons.append(clkconst0)
            cons.append(RawConstraint('set_clock_groups -name async_%s -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % (clkconst0.name, clkconst0.name)))

        if self.board_count > 1:
            # Board 1 FCLK inputs
            clkconsts1 = []
            clkconsts1 += [ClockConstraint('%s_1_fclk0_p' % self.port_prefix, name='adc_fclk%d_1_0' % self.port, freq=self.line_clock_freq_mhz / 5)]
            clkconsts1 += [ClockConstraint('%s_1_fclk1_p' % self.port_prefix, name='adc_fclk%d_1_1' % self.port, freq=self.line_clock_freq_mhz / 5)]
            clkconsts1 += [ClockConstraint('%s_1_fclk2_p' % self.port_prefix, name='adc_fclk%d_1_2' % self.port, freq=self.line_clock_freq_mhz / 5)]
            # Make async with sys_clk
            for clkconst1 in clkconsts1:
                cons.append(clkconst1)
                cons.append(RawConstraint('set_clock_groups -name async_%s -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % (clkconst1.name, clkconst1.name)))
            # Make clocks between boards async
            for clkconst1 in clkconsts1:
                for clkconst0 in clkconsts0:
                    cons.append(RawConstraint('set_clock_groups -name async_%s_%s -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks %s]' % (clkconst0.name, clkconst1.name, clkconst0.name, clkconst1.name)))

        # CDC crosses
        # TODO: make these a scoped xdc file rather than adding here
        for b in range(self.board_count):
            cons.append(RawConstraint("set_false_path -from [get_pins {%s_%d/wb_ads5296_attach_inst/bitslip_reg_cdc_reg[*]/C}] -to [get_pins {%s_%d/adc_unit_inst[*]/bitslip_unstable_reg/D}]" % (self.fullname, b, self.fullname, b)))

        if self.board_count == 2:
            cons.append(RawConstraint("set_case_analysis 0 [get_pins %s_0/mmcm_inst/CLKINSEL]" % self.fullname))
            cons.append(RawConstraint("set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets %s_0/fclk_buf_n_0]" % self.fullname))

        # TODO set the skew of board 1 relative to board 0
        # delays in ns
        input_setup_delay = (1000./self.line_clock_freq_mhz/2.) - 0.2
        input_hold_delay = 0.18
        clocks = [clkconst0, clkconst1]
        # Don't constrain IO delays -- rely on runtime dynamic link training.
        # Explicitly set as false path to keep compiler from issuing warnings
        for b in range(self.board_count):
            cons.append(InputDelayConstraint(clkname=clocks[b].name, consttype='min', constdelay_ns=1.3, portname="%s_%d_din_p[*]" % (self.port_prefix, b)))
            cons.append(InputDelayConstraint(clkname=clocks[b].name, consttype='max', constdelay_ns=1.3, portname="%s_%d_din_p[*]" % (self.port_prefix, b)))
            cons.append(FalsePathConstraint(sourcepath="[get_ports %s_%d_din_p[*]]" % (self.port_prefix, b)))
        
        #for b in range(self.board_count):
        #    # See https://forums.xilinx.com/t5/Timing-Analysis/Input-Delay-Timing-Constraints-Doubts/m-p/652627/highlight/true#M8652
        #    cons.append(InputDelayConstraint(clkname=clocks[b].name, consttype='min', constdelay_ns=input_hold_delay, portname="%s_%d_din_p[*]" % (self.port_prefix, b)))
        #    cons.append(InputDelayConstraint(clkname=clocks[b].name, consttype='max', constdelay_ns=input_setup_delay, portname="%s_%d_din_p[*]" % (self.port_prefix, b)))
        #    cons.append(InputDelayConstraint(clkname=clocks[b].name, consttype='min', constdelay_ns=input_hold_delay, portname="%s_%d_fclk_p" % (self.port_prefix, b)))
        #    cons.append(InputDelayConstraint(clkname=clocks[b].name, consttype='max', constdelay_ns=input_setup_delay, portname="%s_%d_fclk_p" % (self.port_prefix, b)))
        #    cons.append(InputDelayConstraint(clkname=clocks[b].name, consttype='min -clock_fall -add_delay', constdelay_ns=input_hold_delay, portname="%s_%d_din_p[*]" % (self.port_prefix, b)))
        #    cons.append(InputDelayConstraint(clkname=clocks[b].name, consttype='max -clock_fall -add_delay', constdelay_ns=input_setup_delay, portname="%s_%d_din_p[*]" % (self.port_prefix, b)))
        #    cons.append(InputDelayConstraint(clkname=clocks[b].name, consttype='min -clock_fall -add_delay', constdelay_ns=input_hold_delay, portname="%s_%d_fclk_p" % (self.port_prefix, b)))
        #    cons.append(InputDelayConstraint(clkname=clocks[b].name, consttype='max -clock_fall -add_delay', constdelay_ns=input_setup_delay, portname="%s_%d_fclk_p" % (self.port_prefix, b)))

        
        
        #for b1 in range(self.board_count):
        #    root1 = "%s_%d" % (self.fullname, b1)
        #    cons.append(RawConstraint('set_clock_groups -name async_%s -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % (root1, clocks[b1].name)))
        #    # Since we're mux-ing the clocks, make all combinations of MMCM and LCLKs ignored
        #    for b2 in range(self.board_count):
        #        root2 = "%s_%d" % (self.fullname, b2)
        #        cons.append(RawConstraint("set_false_path -from [get_clocks -of_objects [get_pins %s/mmcm_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins %s/clkout_bufg/O]]" % (root1, root2)))

        #    # We're using an FPGA clock from either the board 0 lclk or the board 1 lclk. We don't need to time between these.
        #    for b2 in range(b1, self.board_count):
        #        root2 = "%s_%d" % (self.fullname, b2)
        #        cons.append(RawConstraint("set_false_path -from [get_clocks -of_objects [get_pins %s/mmcm_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins %s/mmcm_inst/CLKOUT0]]" % (root1, root2)))
        #        cons.append(RawConstraint("set_false_path -from [get_clocks -of_objects [get_pins %s/mmcm_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins %s/mmcm_inst/CLKOUT0]]" % (root2, root1)))
        #    cons.append(RawConstraint("set_false_path -from [get_pins %s/wb_ads5296_attach_inst/fclk_sel_reg_cdc_reg/C] -to [get_pins %s/clkout_bufg/CLR]" % (root1, root1)))
        #    cons.append(RawConstraint("set_false_path -from [get_pins %s/syncR_sclk_reg/C] -to [get_pins %s/syncR_reg/D]" % (root1, root1)))
        #    #cons.append(RawConstraint("set_false_path -from [get_pins {%s/wb_attach_inst/delay_val_reg_reg[*]/C}] -to [get_pins {%s/iodelay_in[*]/CNTVALUEIN[*]}]" % (root, root)))
        #    #cons.append(RawConstraint("set_false_path -from [get_pins {%s/wb_attach_inst/delay_load_reg_reg*/C}] -to [get_pins {%s/delay_loadR_reg[*]/D}]" % (root, root)))



        cons.append(RawConstraint('set_property DIFF_TERM_ADV TERM_100 [get_ports [list {ads5296x4fmc%s_0_din_p[*]}]]' %self.port))
        cons.append(RawConstraint('set_property DIFF_TERM_ADV TERM_100 [get_ports [list {ads5296x4fmc%s_0_lclk_p}]]' %self.port))
        cons.append(RawConstraint('set_property DIFF_TERM_ADV TERM_100 [get_ports [list {ads5296x4fmc%s_0_fclk*_p}]]' % self.port))
        if self.board_count > 1:
            cons.append(RawConstraint('set_property DIFF_TERM_ADV TERM_100 [get_ports [list {ads5296x4fmc%s_1_din_p[*]}]]' %self.port))
            cons.append(RawConstraint('set_property DIFF_TERM_ADV TERM_100 [get_ports [list {ads5296x4fmc%s_1_lclk_p}]]' %self.port))
            cons.append(RawConstraint('set_property DIFF_TERM_ADV TERM_100 [get_ports [list {ads5296x4fmc%s_1_fclk*_p}]]' % self.port))

        if self.port == 1:
            cons.append(RawConstraint('set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports %s_0_fclk0_p]' % self.port_prefix))

        #        ila="""
        #create_debug_core u_ila_0 ila
        #set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
        #set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
        #set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
        #set_property C_DATA_DEPTH 16384 [get_debug_cores u_ila_0]
        #set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
        #set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
        #set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
        #set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
        #set_property port_width 1 [get_debug_ports u_ila_0/clk]
        #connect_debug_port u_ila_0/clk [get_nets wb_clk_i]
        #set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
        #set_property port_width 3 [get_debug_ports u_ila_0/probe0]
        #connect_debug_port u_ila_0/probe0 [get_nets [list {ila_cs1[0]} {ila_cs1[1]} {ila_cs1[2]}]]
        #create_debug_port u_ila_0 probe
        #set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
        #set_property port_width 3 [get_debug_ports u_ila_0/probe1]
        #connect_debug_port u_ila_0/probe1 [get_nets [list {ila_cs0[0]} {ila_cs0[1]} {ila_cs0[2]}]]
        #create_debug_port u_ila_0 probe
        #set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
        #set_property port_width 1 [get_debug_ports u_ila_0/probe2]
        #connect_debug_port u_ila_0/probe2 [get_nets [list ila_miso0]]
        #create_debug_port u_ila_0 probe
        #set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
        #set_property port_width 1 [get_debug_ports u_ila_0/probe3]
        #connect_debug_port u_ila_0/probe3 [get_nets [list ila_miso1]]
        #create_debug_port u_ila_0 probe
        #set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
        #set_property port_width 1 [get_debug_ports u_ila_0/probe4]
        #connect_debug_port u_ila_0/probe4 [get_nets [list ila_mosi0]]
        #create_debug_port u_ila_0 probe
        #set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
        #set_property port_width 1 [get_debug_ports u_ila_0/probe5]
        #connect_debug_port u_ila_0/probe5 [get_nets [list ila_mosi1]]
        #create_debug_port u_ila_0 probe
        #set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
        #set_property port_width 1 [get_debug_ports u_ila_0/probe8]
        #connect_debug_port u_ila_0/probe8 [get_nets [list ila_sclk0]]
        #create_debug_port u_ila_0 probe
        #set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
        #set_property port_width 1 [get_debug_ports u_ila_0/probe6]
        #connect_debug_port u_ila_0/probe6 [get_nets [list ila_sclk1]]
        #create_debug_port u_ila_0 probe
        #set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
        #set_property port_width 1 [get_debug_ports u_ila_0/probe7]
        #connect_debug_port u_ila_0/probe7 [get_nets [list ila_sync0]]
        #create_debug_port u_ila_0 probe
        #set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
        #set_property port_width 1 [get_debug_ports u_ila_0/probe8]
        #connect_debug_port u_ila_0/probe8 [get_nets [list ila_sync1]]
        #set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
        #set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
        #set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
        #connect_debug_port dbg_hub/clk [get_nets wb_clk_i]
        #
        #        """
        #cons.append(RawConstraint(ila))

        return cons
