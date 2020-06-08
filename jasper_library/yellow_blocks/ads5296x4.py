from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint
from .yellow_block_typecodes import *
from math import log, ceil
import math, numpy as np

from string import ascii_lowercase

class ads5296x4(YellowBlock):
    def initialize(self):
        self.typecode = TYPECODE_ADC16CTRL
        self.REV = 5
        # num_units is the number of ADC chips
        # board_count is the number of boards
        self.num_units_per_board = 4
        self.num_units = self.num_units_per_board * self.board_count
        self.num_clocks = 1
        self.n_inputs_per_chip = 4
        self.n_cs_bits = 2

        self.adc_resolution = 10
        self.adc_data_width = self.adc_resolution

        # An ADC chip has 8 ADC cores and DDR transmission 
        self.line_clock_freq = self.sample_rate/(8.0/self.n_inputs_per_chip)*self.adc_resolution/2.0
        self.logger.info("ADC {0} has line clock {1} MHz".format(self.name, self.line_clock_freq))

        self.add_source('ads5296x4_interface')
        self.add_source('wb_ads5296_controller')
        self.add_source('wb_bram')

        self.provides = ['adc%d_clk' % self.port, 'adc%d_clk90' % self.port, 'adc%d_clk180' % self.port, 'adc%d_clk270' % self.port]

        self.port_prefix = self.blocktype + 'fmc%d_' % self.port

    def modify_top(self,top):
        module = 'ads5296x4_interface'
        inst = top.get_instance(entity=module, name=self.fullname)
        inst.add_parameter('G_NUM_CLOCKS', int(self.num_clocks))
        inst.add_parameter('G_NUM_UNITS', int(self.num_units))

        # ports which go to simulink
        for x in ascii_lowercase[0:self.num_units]:
            inst.add_port(x+'1', self.fullname+'_'+x+'1', width=self.adc_data_width)
            inst.add_port(x+'2', self.fullname+'_'+x+'2', width=self.adc_data_width)
            inst.add_port(x+'3', self.fullname+'_'+x+'3', width=self.adc_data_width)
            inst.add_port(x+'4', self.fullname+'_'+x+'4', width=self.adc_data_width)


        inst.add_port('reset', self.port_prefix+'reset')
        inst.add_port('iserdes_bitslip', self.port_prefix+'iserdes_bitslip', width=self.num_units*4*2)

        inst.add_port('delay_rst', self.port_prefix+'delay_rst', width=self.num_units*4*2)
        inst.add_port('delay_tap', self.port_prefix+'delay_tap', width=8)

        inst.add_port('snap_req', self.port_prefix+'snap_req')
        inst.add_port('snap_we',  self.port_prefix+'snap_we')
        inst.add_port('snap_addr', self.port_prefix+'snap_addr', width=10)

        inst.add_port('locked', self.port_prefix+'locked', width=self.board_count)
        inst.add_port('demux_mode', self.port_prefix+'demux_mode', width=2)

        # Now the external ports, which need corresponding ports adding to top.v

        # We don't use the frame clocks!
        inst.add_port('clk_frame_p', '0', parent_sig=False)
        inst.add_port('clk_frame_n', '0', parent_sig=False)

        inst.add_port('clk_line_p', self.port_prefix+'clk_line_p', parent_port=True, dir='in', width=self.num_clocks)
        inst.add_port('clk_line_n', self.port_prefix+'clk_line_n', parent_port=True, dir='in', width=self.num_clocks)
        inst.add_port('ser_a_p', self.port_prefix+'ser_a_p', parent_port=True, dir='in', width=4*self.num_units)
        inst.add_port('ser_a_n', self.port_prefix+'ser_a_n', parent_port=True, dir='in', width=4*self.num_units)
        inst.add_port('ser_b_p', self.port_prefix+'ser_b_p', parent_port=True, dir='in', width=4*self.num_units)
        inst.add_port('ser_b_n', self.port_prefix+'ser_b_n', parent_port=True, dir='in', width=4*self.num_units)

        # These ports provide the simulink clocks (as adcX_clk) and link
        # multiple blocks together so they clock synchronously
        # The toolflow will connect adcX_clk -> user_clk so that the master
        # clock comes from the appropriate ADC port
        inst.add_port('fabric_clk_o', 'adc%d_clk' % self.port)
        inst.add_port('fabric_clk_90_o', 'adc%d_clk90' % self.port)
        inst.add_port('fabric_clk_180_o', 'adc%d_clk180' % self.port)
        inst.add_port('fabric_clk_270_o', 'adc%d_clk270' % self.port)
        inst.add_port('frame_clk_o', 'adc%d_frame_clk' % self.port)
        inst.add_port('line_clk_4b_o', 'adc%d_line_clk_4b' % self.port)
        inst.add_port('line_clk_10b_o', 'adc%d_line_clk_10b' % self.port)
        # inputs. Hard code source to 0. TODO: link to MSSGE clock source
        inst.add_port('line_clk_4b_i', 'adc%d_line_clk_4b' % (0))
        inst.add_port('line_clk_10b_i', 'adc%d_line_clk_10b' % (0))
        inst.add_port('fabric_clk_i', 'user_clk') # provided by the toolflow

        # The simulink yellow block provides a simulink-input to drive sync / reset. These can be passed straight
        # to top-level ports. Let the synthesizer infer buffers.
        top.add_port(self.port_prefix+'adc_sync', width=1, dir='out')
        top.add_port(self.port_prefix+'adc_rst', width=1, dir='out')
        top.assign_signal(self.port_prefix+'adc_sync', self.fullname+'_adc_sync')
        top.assign_signal(self.port_prefix+'adc_rst', self.fullname+'_adc_rst')

        # ADC Power down and reset signals are wired to the FPGA, but hardwire them to match the adc16 card
        #top.add_port('adc_rst_n', dir='out', width=3)
        #top.add_port('adc_pd', dir='out', width=3)
        #top.assign_signal('adc_rst_n', "3'b111")
        #top.assign_signal('adc_pd', "3'b000")

        # wb controller

        wbctrl = top.get_instance(entity='wb_ads5296_controller', name='wb_ads5296_controller%d' % self.port)
        wbctrl.add_parameter('G_ROACH2_REV', 0)
        wbctrl.add_parameter('G_ZDOK_REV', self.REV)
        wbctrl.add_parameter('G_NUM_UNITS', self.num_units)
        wbctrl.add_parameter('G_NUM_SCLK_LINES', 1)
        wbctrl.add_parameter('G_NUM_SDATA_LINES', 1)
        wbctrl.add_parameter('G_NUM_CS_LINES', int(ceil(log(self.num_units, 2))))
        # These are top-level ports -- they don't need signal declarations,
        # but they do need ports added to the top-level
        wbctrl.add_port('adc_spi_cs',   self.port_prefix+'adc_spi_cs', dir='out', parent_port=True, width=int(ceil(log(self.num_units, 2))))
        wbctrl.add_port('adc_spi_mosi', self.port_prefix+'adc_spi_mosi', dir='out', parent_port=True, width=1)
        if self.board_count > 1:
            wbctrl.add_port('adc_spi_miso', self.port_prefix+'adc_spi_miso', dir='in', parent_port=True, width=1)
        else:
            wbctrl.add_port('adc_spi_miso', '1\'b0') # Only get MISO with a two-board configuration
        wbctrl.add_port('adc_spi_sclk', self.port_prefix+'adc_spi_sclk', dir='out', parent_port=True, width=1)

        # internal connections to the adc controller. We have already declared the corresponding
        # signals earlier.
        wbctrl.add_port('adc_reset', self.port_prefix+'reset')
        wbctrl.add_port('adc_iserdes_bitslip', self.port_prefix+'iserdes_bitslip', width=self.num_units*4*2)
        wbctrl.add_port('adc_delay_rst',  self.port_prefix+'delay_rst', width=self.num_units*4*2)
        wbctrl.add_port('adc_delay_tap',  self.port_prefix+'delay_tap', width=8)
        wbctrl.add_port('adc_snap_req',   self.port_prefix+'snap_req')
        wbctrl.add_port('adc_locked',     self.port_prefix+'locked', width=self.board_count)
        wbctrl.add_port('adc_demux_mode', self.port_prefix+'demux_mode', width=2)
        # and finally the wb interface
        wbctrl.add_wb_interface(nbytes=2**8, regname='ads5296_controller%d' % self.port, mode='rw', typecode=self.typecode)

        snap_chan = ascii_lowercase
        for k in range(self.num_units):
            # Embedded wb-RAM
            bram_log_width = int(ceil(log(self.adc_data_width*4,2)))
            padding = 2**(bram_log_width-2) - self.adc_data_width
            din = self.fullname+'_%s'%snap_chan[k]
            wbram = top.get_instance(entity='wb_bram', name='adc16_wb_ram%d_%d' % (self.port, k), comment='Embedded ADC16 bram')
            wbram.add_parameter('LOG_USER_WIDTH', bram_log_width)
            wbram.add_parameter('USER_ADDR_BITS','10')
            wbram.add_parameter('N_REGISTERS','2')
            wbram.add_wb_interface(regname='adc16_wb_ram%d_%d' % (self.port, k), mode='rw', nbytes=(2**bram_log_width//8)*2**10, typecode=TYPECODE_SWREG)
            wbram.add_port('user_clk','user_clk', parent_sig=False)
            wbram.add_port('user_addr', self.port_prefix+'snap_addr', width=10)
            wbram.add_port('user_din',self.reorder_ports([din+'1',din+'2',din+'3',din+'4'], wb_bitwidth=64, word_width=16, padding="%s'b0" % padding), parent_sig=False)
            wbram.add_port('user_we', self.port_prefix+'snap_we')
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
            return '{' + ','.join(port_list) + '}'

    def gen_constraints(self):
        cons = []

        for pol in ['p', 'n']:
            for lane_n, lane in enumerate(['a', 'b']):
                cons.append(PortConstraint(
                    self.port_prefix+'ser_%s_%s' % (lane, pol),
                    'fmc%d_la_%s' % (self.port, pol),
                    port_index=list(range(4*self.num_units_per_board)),
                    iogroup_index=range(8*self.num_units_per_board)[lane_n::2],
                ))

        cons.append(PortConstraint(self.port_prefix+'clk_line_p', 'fmc%d_clk_p' % self.port, iogroup_index=[1]))
        cons.append(PortConstraint(self.port_prefix+'clk_line_n', 'fmc%d_clk_n' % self.port, iogroup_index=[1]))

        cons.append(PortConstraint(self.port_prefix+'adc_spi_cs',  'fmc%d_la' % self.port, port_index=[0], iogroup_index=[2*33]))
        cons.append(PortConstraint(self.port_prefix+'adc_spi_cs',  'fmc%d_la' % self.port, port_index=[1], iogroup_index=[2*33+1]))
        cons.append(PortConstraint(self.port_prefix+'adc_spi_mosi', 'fmc%d_la' % self.port, port_index=[0], iogroup_index=[2*32]))
        cons.append(PortConstraint(self.port_prefix+'adc_spi_sclk', 'fmc%d_la' % self.port, port_index=[0], iogroup_index=[2*32+1]))

        if self.board_count > 1:
            a_block_pins = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22]
            for pol in ['p', 'n']:
                for lane_n, lane in enumerate(['a', 'b']):
                    cons.append(PortConstraint(
                       self.port_prefix+'ser_%s_%s' % (lane, pol),
                       'fmc%d_ha_%s' % (self.port, pol),
                       port_index=list(range(4*self.num_units_per_board, 4*self.num_units_per_board + 10)),
                       iogroup_index=a_block_pins[lane_n::2],
                    ))

            b_block_pins = [1,2,3,4,5,7,8,9,10,11,12,13]
            for pol in ['p', 'n']:
                for lane_n, lane in enumerate(['a', 'b']):
                    cons.append(PortConstraint(
                       self.port_prefix+'ser_%s_%s' % (lane, pol),
                       'fmc%d_hb_%s' % (self.port, pol),
                       port_index=list(range(4*self.num_units_per_board + 10, 8*self.num_units_per_board)),
                       iogroup_index=b_block_pins[lane_n::2],
                    ))

            cons.append(PortConstraint(self.port_prefix+'adc_spi_cs',  'fmc%d_hb' % self.port, port_index=[2], iogroup_index=[2*17]))
            cons.append(PortConstraint(self.port_prefix+'adc_spi_miso', 'fmc%d_hb' % self.port, port_index=[0], iogroup_index=[2*17+1]))
            cons.append(PortConstraint(self.port_prefix+'adc_sync', 'fmc%d_hb' % self.port, port_index=[0], iogroup_index=[2*18]))
            cons.append(PortConstraint(self.port_prefix+'adc_rst',  'fmc%d_hb' % self.port, port_index=[0], iogroup_index=[2*18+1]))


        # TODO: cons.append(PortConstraint('adc_rst_n', 'adc_rst_n', port_index=list(range(3)), iogroup_index=list(range(3))))
        # TODO: cons.append(PortConstraint('adc_pd', 'adc_pd', port_index=list(range(3)), iogroup_index=list(range(3))))
        
        # clock constraint with variable period
        clkconst = ClockConstraint(self.port_prefix+'clk_line_p', name='adc_clk', freq=self.line_clock_freq)
        cons.append(clkconst)

        cons.append(RawConstraint('set_clock_groups -name async_sysclk_adcclk -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % clkconst.name))
        cons.append(RawConstraint('set_multicycle_path -from [get_clocks -include_generated_clocks %s] -to [get_clocks -include_generated_clocks sys_clk0_dcm] 3' % clkconst.name))
        cons.append(RawConstraint('set_multicycle_path -from [get_clocks -include_generated_clocks %s] -to [get_clocks -include_generated_clocks sys_clk0_dcm] -hold 2' % clkconst.name))

        return cons
