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
        self.num_units = 4*self.board_count
        self.num_clocks = 1
        self.n_inputs_per_chip = 4

        self.adc_resolution = 10
        self.adc_data_width = self.adc_resolution

        # An HMCAD1511 has 8 ADC cores and DDR transmission 
        self.line_clock_freq = self.sample_rate/(8.0/self.n_inputs_per_chip)*self.adc_resolution/2.0

        self.add_source('ads5296x4_interface')
        self.add_source('wb_ads5296_controller')
        self.add_source('wb_bram')

        self.provides = ['adc_clk','adc_clk90', 'adc_clk180', 'adc_clk270']

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

        # ports which go to the wb controller. Any ports which don't go to top level need
        # corresponding signals to be added to top.v. **Not anymore, this is now default behaviour!**
        inst.add_port('fabric_clk', 'adc_clk')
        inst.add_port('fabric_clk_90', 'adc_clk90')
        inst.add_port('fabric_clk_180', 'adc_clk180')
        inst.add_port('fabric_clk_270', 'adc_clk270')

        inst.add_port('reset', 'adc16_reset')
        inst.add_port('iserdes_bitslip', 'adc16_iserdes_bitslip', width=self.num_units*4*2)

        inst.add_port('delay_rst', 'adc16_delay_rst', width=self.num_units*4*2)
        inst.add_port('delay_tap', 'adc16_delay_tap', width=8)

        inst.add_port('snap_req', 'adc16_snap_req')
        inst.add_port('snap_we', 'adc16_snap_we')
        inst.add_port('snap_addr', 'adc16_snap_addr', width=10)

        inst.add_port('locked', 'adc16_locked', width=self.board_count)
        inst.add_port('demux_mode', 'adc16_demux_mode', width=2)

        # Now the external ports, which need corresponding ports adding to top.v

        # We don't use the frame clocks!
        inst.add_port('clk_frame_p', '0', parent_sig=False)
        inst.add_port('clk_frame_n', '0', parent_sig=False)

        inst.add_port('clk_line_p', 'adc16_clk_line_p', parent_port=True, dir='in', width=self.num_clocks)
        inst.add_port('clk_line_n', 'adc16_clk_line_n', parent_port=True, dir='in', width=self.num_clocks)
        inst.add_port('ser_a_p', 'adc16_ser_a_p', parent_port=True, dir='in', width=4*self.num_units)
        inst.add_port('ser_a_n', 'adc16_ser_a_n', parent_port=True, dir='in', width=4*self.num_units)
        inst.add_port('ser_b_p', 'adc16_ser_b_p', parent_port=True, dir='in', width=4*self.num_units)
        inst.add_port('ser_b_n', 'adc16_ser_b_n', parent_port=True, dir='in', width=4*self.num_units)

        # ADC Power down and reset signals are wired to the FPGA, but hardwire them to match the adc16 card
        #top.add_port('adc_rst_n', dir='out', width=3)
        #top.add_port('adc_pd', dir='out', width=3)
        #top.assign_signal('adc_rst_n', "3'b111")
        #top.assign_signal('adc_pd', "3'b000")

        # wb controller

        wbctrl = top.get_instance(entity='wb_ads5296_controller', name='wb_ads5296_controller')
        wbctrl.add_parameter('G_ROACH2_REV', 0)
        wbctrl.add_parameter('G_ZDOK_REV', self.REV)
        wbctrl.add_parameter('G_NUM_UNITS', self.num_units)
        wbctrl.add_parameter('G_NUM_SCLK_LINES', self.num_units)
        wbctrl.add_parameter('G_NUM_SDATA_LINES', self.num_units)
        # These are top-level ports -- they don't need signal declarations,
        # but they do need ports added to the top-level
        wbctrl.add_port('adc_adc3wire_csn', 'adc_adc3wire_csn', dir='out', parent_port=True, width=self.num_units)
        wbctrl.add_port('adc_adc3wire_sdata', 'adc_adc3wire_sdata', dir='out', parent_port=True, width=self.num_units)
        wbctrl.add_port('adc_adc3wire_sclk', 'adc_adc3wire_sclk', dir='out', parent_port=True, width=self.num_units)

        # internal connections to the adc controller. We have already declared the corresponding
        # signals earlier.
        wbctrl.add_port('adc_reset','adc16_reset')
        wbctrl.add_port('adc_iserdes_bitslip','adc16_iserdes_bitslip', width=self.num_units*4*2)
        wbctrl.add_port('adc_delay_rst', 'adc16_delay_rst', width=self.num_units*4*2)
        wbctrl.add_port('adc_delay_tap', 'adc16_delay_tap', width=8)
        wbctrl.add_port('adc_snap_req',  'adc16_snap_req')
        wbctrl.add_port('adc_locked',    'adc16_locked', width=self.board_count)
        wbctrl.add_port('adc_demux_mode', 'adc16_demux_mode', width=2)
        # and finally the wb interface
        wbctrl.add_wb_interface(nbytes=2**8, regname='ads5296_controller', mode='rw', typecode=self.typecode)

        snap_chan = ascii_lowercase
        for k in range(self.num_units):
            # Embedded wb-RAM
            bram_log_width = int(ceil(log(self.adc_data_width*4,2)))
            padding = 2**(bram_log_width-2) - self.adc_data_width
            din = self.fullname+'_%s'%snap_chan[k]
            wbram = top.get_instance(entity='wb_bram', name='adc16_wb_ram%d'%k, comment='Embedded ADC16 bram')
            wbram.add_parameter('LOG_USER_WIDTH', bram_log_width)
            wbram.add_parameter('USER_ADDR_BITS','10')
            wbram.add_parameter('N_REGISTERS','2')
            wbram.add_wb_interface(regname='adc16_wb_ram%d'%k, mode='rw', nbytes=(2**bram_log_width//8)*2**10, typecode=TYPECODE_SWREG)
            wbram.add_port('user_clk','adc_clk', parent_sig=False)
            wbram.add_port('user_addr','adc16_snap_addr', width=10)
            wbram.add_port('user_din',self.reorder_ports([din+'1',din+'2',din+'3',din+'4'], wb_bitwidth=64, word_width=16, padding="%s'b0" % padding), parent_sig=False)
            wbram.add_port('user_we','adc16_snap_we')
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
        # Reduce the FMC indices to only those which are connected (on SNAP2). TODO: Get the real connections when the board is designed
        ha_pins = list(range(24)) # 0..23
        hb_pins = list(range(ha_pins[-1]+1, ha_pins[-1]+1+24)) # 24..47
        la_pins = list(range(hb_pins[-1]+1, hb_pins[-1]+1+34)) # 48..81
        valid_pins = ha_pins[0:23] + hb_pins[0:20] + la_pins[0:34]
        print('*****')
        print(valid_pins)

        clock_pin = valid_pins[0]
        valid_pins = valid_pins[1:]
        print('*')
        print(valid_pins)
        # The "a" lanes of the first board in an FMC slot
        index_a_board0 = valid_pins[0:4*self.num_units_per_board]
        valid_pins = valid_pins[4*self.num_units_per_board:]
        print('*')
        print(valid_pins)
        # The "b" lanes of the first board in an FMC slot
        index_b_board0 = valid_pins[0:4*self.num_units_per_board]
        valid_pins = valid_pins[4*self.num_units_per_board:]
        print('*')
        print(valid_pins)

        # The "a" lanes of the second board in an FMC slot
        index_a_board1 = valid_pins[0:4*self.num_units_per_board]
        valid_pins = valid_pins[4*self.num_units_per_board:]
        print('*')
        print(valid_pins)
        # The "b" lanes of the second board in an FMC slot
        index_b_board1 = valid_pins[0:4*self.num_units_per_board]
        valid_pins = valid_pins[4*self.num_units_per_board:]
        print('*')
        print(valid_pins)
        print(len(valid_pins))

        valid_single_ended_pins = range(valid_pins[0]*2, (valid_pins[-1]+1)*2)
        print('**********')
        print(valid_single_ended_pins)
        print(len(valid_single_ended_pins))
        #csn = valid_single_ended_pins[0:self.num_units]
        #valid_single_ended_pins = valid_single_ended_pins[self.num_units:]
        #sdata = valid_single_ended_pins[0:self.num_units]
        #valid_single_ended_pins = valid_single_ended_pins[self.num_units:]
        #sclk = valid_single_ended_pins[0:self.num_units]
        #valid_single_ended_pins = valid_single_ended_pins[self.num_units:]

        cons = []

        cons.append(PortConstraint('adc16_clk_line_p',  'fmc0_p', iogroup_index=0))
        cons.append(PortConstraint('adc16_clk_line_n',  'fmc0_n', iogroup_index=0))

        cons.append(PortConstraint('adc16_ser_a_p', 'fmc0_p', port_index=list(range(4*self.num_units_per_board)), iogroup_index=index_a_board0))
        cons.append(PortConstraint('adc16_ser_a_n', 'fmc0_n', port_index=list(range(4*self.num_units_per_board)), iogroup_index=index_a_board0))
        cons.append(PortConstraint('adc16_ser_b_p', 'fmc0_p', port_index=list(range(4*self.num_units_per_board)), iogroup_index=index_b_board0))
        cons.append(PortConstraint('adc16_ser_b_n', 'fmc0_n', port_index=list(range(4*self.num_units_per_board)), iogroup_index=index_b_board0))

        cons.append(PortConstraint('adc_adc3wire_csn',   'fmc0', port_index=range(0*self.num_units_per_board, 1*self.num_units_per_board), iogroup_index=valid_single_ended_pins[0*self.num_units_per_board : 1*self.num_units_per_board]))
        cons.append(PortConstraint('adc_adc3wire_sdata', 'fmc0', port_index=range(0*self.num_units_per_board, 1*self.num_units_per_board), iogroup_index=valid_single_ended_pins[1*self.num_units_per_board : 2*self.num_units_per_board]))
        cons.append(PortConstraint('adc_adc3wire_sclk',  'fmc0', port_index=range(0*self.num_units_per_board, 1*self.num_units_per_board), iogroup_index=valid_single_ended_pins[2*self.num_units_per_board : 3*self.num_units_per_board]))

        if self.board_count > 1:
            cons.append(PortConstraint('adc16_ser_a_p', 'fmc0_p', port_index=list(range(4*self.num_units_per_board, 8*self.num_units_per_board)), iogroup_index=index_a_board1))
            cons.append(PortConstraint('adc16_ser_a_n', 'fmc0_n', port_index=list(range(4*self.num_units_per_board, 8*self.num_units_per_board)), iogroup_index=index_a_board1))
            cons.append(PortConstraint('adc16_ser_b_p', 'fmc0_p', port_index=list(range(4*self.num_units_per_board, 8*self.num_units_per_board)), iogroup_index=index_b_board1))
            cons.append(PortConstraint('adc16_ser_b_n', 'fmc0_n', port_index=list(range(4*self.num_units_per_board, 8*self.num_units_per_board)), iogroup_index=index_b_board1))
            cons.append(PortConstraint('adc_adc3wire_csn',   'fmc0', port_index=range(1*self.num_units_per_board, 2*self.num_units_per_board), iogroup_index=valid_single_ended_pins[3*self.num_units_per_board : 4*self.num_units_per_board]))
            cons.append(PortConstraint('adc_adc3wire_sdata', 'fmc0', port_index=range(1*self.num_units_per_board, 2*self.num_units_per_board), iogroup_index=valid_single_ended_pins[4*self.num_units_per_board : 5*self.num_units_per_board]))
            cons.append(PortConstraint('adc_adc3wire_sclk',  'fmc0', port_index=range(1*self.num_units_per_board, 2*self.num_units_per_board), iogroup_index=valid_single_ended_pins[5*self.num_units_per_board : 6*self.num_units_per_board]))
        if self.board_count > 2:
            cons.append(PortConstraint('adc16_ser_a_p', 'fmc1_p', port_index=list(range(4*self.num_units_per_board)), iogroup_index=index_a_board0))
            cons.append(PortConstraint('adc16_ser_a_n', 'fmc1_n', port_index=list(range(4*self.num_units_per_board)), iogroup_index=index_a_board0))
            cons.append(PortConstraint('adc16_ser_b_p', 'fmc1_p', port_index=list(range(4*self.num_units_per_board)), iogroup_index=index_b_board0))
            cons.append(PortConstraint('adc16_ser_b_n', 'fmc1_n', port_index=list(range(4*self.num_units_per_board)), iogroup_index=index_b_board0))
            cons.append(PortConstraint('adc_adc3wire_csn',   'fmc1', port_index=range(2*self.num_units_per_board, 3*self.num_units_per_board), iogroup_index=valid_single_ended_pins[0*self.num_units_per_board : 1*self.num_units_per_board]))
            cons.append(PortConstraint('adc_adc3wire_sdata', 'fmc1', port_index=range(2*self.num_units_per_board, 3*self.num_units_per_board), iogroup_index=valid_single_ended_pins[1*self.num_units_per_board : 2*self.num_units_per_board]))
            cons.append(PortConstraint('adc_adc3wire_sclk',  'fmc1', port_index=range(2*self.num_units_per_board, 3*self.num_units_per_board), iogroup_index=valid_single_ended_pins[2*self.num_units_per_board : 3*self.num_units_per_board]))
        if self.board_count > 3:
            cons.append(PortConstraint('adc16_ser_a_p', 'fmc1_p', port_index=list(range(4*self.num_units_per_board, 8*self.num_units_per_board)), iogroup_index=index_a_board1))
            cons.append(PortConstraint('adc16_ser_a_n', 'fmc1_n', port_index=list(range(4*self.num_units_per_board, 8*self.num_units_per_board)), iogroup_index=index_a_board1))
            cons.append(PortConstraint('adc16_ser_b_p', 'fmc1_p', port_index=list(range(4*self.num_units_per_board, 8*self.num_units_per_board)), iogroup_index=index_b_board1))
            cons.append(PortConstraint('adc16_ser_b_n', 'fmc1_n', port_index=list(range(4*self.num_units_per_board, 8*self.num_units_per_board)), iogroup_index=index_b_board1))
            cons.append(PortConstraint('adc_adc3wire_csn',   'fmc1', port_index=range(3*self.num_units_per_board, 4*self.num_units_per_board), iogroup_index=valid_single_ended_pins[3*self.num_units_per_board : 4*self.num_units_per_board]))
            cons.append(PortConstraint('adc_adc3wire_sdata', 'fmc1', port_index=range(3*self.num_units_per_board, 4*self.num_units_per_board), iogroup_index=valid_single_ended_pins[4*self.num_units_per_board : 5*self.num_units_per_board]))
            cons.append(PortConstraint('adc_adc3wire_sclk',  'fmc1', port_index=range(3*self.num_units_per_board, 4*self.num_units_per_board), iogroup_index=valid_single_ended_pins[5*self.num_units_per_board : 6*self.num_units_per_board]))
        

        # TODO: cons.append(PortConstraint('adc_rst_n', 'adc_rst_n', port_index=list(range(3)), iogroup_index=list(range(3))))
        # TODO: cons.append(PortConstraint('adc_pd', 'adc_pd', port_index=list(range(3)), iogroup_index=list(range(3))))
        
        # clock constraint with variable period
        clkconst = ClockConstraint('adc16_clk_line_p', name='adc_clk', freq=self.line_clock_freq)
        cons.append(clkconst)

        cons.append(RawConstraint('set_clock_groups -name async_sysclk_adcclk -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % clkconst.name))
        cons.append(RawConstraint('set_multicycle_path -from [get_clocks -include_generated_clocks %s] -to [get_clocks -include_generated_clocks sys_clk0_dcm] 3' % clkconst.name))
        cons.append(RawConstraint('set_multicycle_path -from [get_clocks -include_generated_clocks %s] -to [get_clocks -include_generated_clocks sys_clk0_dcm] -hold 2' % clkconst.name))

        return cons

        
