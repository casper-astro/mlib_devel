from .yellow_block import YellowBlock
from constraints import ClockConstraint, ClockGroupConstraint, PortConstraint, RawConstraint
from os import path, environ as env

"""
RFSoC 4x2 port notes

addr_width from the IP is [29:0] (30-bits) not [28:0] (29-bits)
The PYNQ example used a 64 bit data width
The IPI block will force AXI4 Interface

Deleted DDR4 complicated configuration string in favor of what Vivado outputs on
the tcl console when configuring the MIG like the RFSoC4x2 example design

comment out chip_width and n_chip since it isn't used?

"""

class ddr4(YellowBlock):
    def initialize(self):
        #try:
        #    memconf = self.platform.conf["ddr4"]["memconf"]
        #except KeyError:
        #    self.logger.error("Missing `ddr4: memconf` parameter in YAML file")
        #    raise
        #self.memconf = path.join(env['HDL_ROOT'], memconf)
        try:
            self.width = self.platform.conf["ddr4"]["width"]
        except KeyError:
            self.logger.error("Missing `ddr4: width` parameter in YAML file")
            raise

        self.bitwidth = 64 # Magic number set here since it looks like it was supposed to come from simulink?
        assert self.bitwidth == self.width, "Simulink and YAML width parameters don't match!"

        self.ddr_clk = f'{self.fullname}_ui_clk'
        #self.chip_width = 16
        self.addr_width = 30
        #self.n_chip = self.width // self.chip_width
        self.bank = 0

    def modify_top(self,top):
        inst = top.get_instance(self.fullname, self.fullname+'_inst')

        top.add_signal(self.ddr_clk, attributes={'keep': '"true"'})

        inst.add_port('dbg_clk', '') # output wire
        inst.add_port('dbg_bus', '') # output wire [511:0]
        inst.add_port('c0_init_calib_complete', self.fullname + '_ddr4_calib_complete') # output wire # To Simulink
        #inst.add_port('sys_rst', 'sys_rst')
        inst.add_port('sys_rst', "1'b0")
        rst = self.fullname + '_ddr_rst'
        top.add_signal(rst)
        inst.add_port('c0_ddr4_ui_clk_sync_rst', rst)
        inst.add_port('c0_ddr4_ui_clk', self.ddr_clk) # output wire
        # Application [Simulink] interface

        # Send-side FIFO
        txf = top.get_instance(f'{self.fullname}_tx_fifo', f'{self.fullname}_tx_fifo_inst')
        #txf.add_port('rst', 'sys_rst')
        txf.add_port('rst', "1'b0")
        txf.add_port('wr_clk', 'user_clk')
        txf.add_port('rd_clk', self.ddr_clk)
        top.add_signal(f'{self.fullname}_ddr4_cmd', width=3) # From Simulink
        top.add_signal(f'{self.fullname}_ddr4_din', width=8*self.width) # From Simulink
        top.add_signal(f'{self.fullname}_ddr4_addr', width=self.addr_width) # From Simulink
        txf.add_port('din', f'{{ {self.fullname}_ddr4_cmd, {self.fullname}_ddr4_addr, {self.fullname}_ddr4_din }}', parent_sig=False)
        txf.add_port('wr_en', f'{self.fullname}_ddr4_we') # From Simulink
        top.add_signal(f'{self.fullname}_ddr4_tx_fifo_rd_en')
        txf.add_port('rd_en', f'{self.fullname}_ddr4_tx_fifo_rd_en')
        top.add_signal(f'{self.fullname}_ddr4_cmd_fout', width=3)
        top.add_signal(f'{self.fullname}_ddr4_din_fout', width=8*self.width)
        top.add_signal(f'{self.fullname}_ddr4_addr_fout', width=self.addr_width)
        txf.add_port('dout',      f'{{ {self.fullname}_ddr4_cmd_fout, {self.fullname}_ddr4_addr_fout, {self.fullname}_ddr4_din_fout }}', parent_sig=False)
        txf.add_port('full',      '')
        txf.add_port('overflow',  f'{self.fullname}_ddr4_fifo_in_overflow') # To Simulink
        txf.add_port('empty',     f'{self.fullname}_ddr4_fifo_in_empty')
        txf.add_port('underflow', f'{self.fullname}_ddr4_fifo_in_underflow') # To Simulink
        txf.add_port('rd_data_count', f'{self.fullname}_ddr4_in_fifo_rd_dc', width=5) # To Simulink
        txf.add_port('wr_data_count', f'{self.fullname}_ddr4_in_fifo_wr_dc', width=5) # To Simulink

        # Read from FIFO when both command and data FIFOs are available and there is valid data
        top.assign_signal(f'{self.fullname}_ddr4_tx_fifo_rd_en',
                          f'{self.fullname}_ddr4_app_rdy & {self.fullname}_ddr4_app_wdf_rdy & ~{self.fullname}_ddr4_fifo_in_empty')
        top.add_signal(f'{self.fullname}_ddr4_wdf_wren')
        top.assign_signal(f'{self.fullname}_ddr4_wdf_wren', # only write to data FIFO on write command (write command is 3'b000)
                          f'{self.fullname}_ddr4_tx_fifo_rd_en & ~{self.fullname}_ddr4_cmd_fout[0]')
                           

        inst.add_port('c0_ddr4_app_rdy',       self.fullname+'_ddr4_app_rdy')          # output wire c0_ddr4_app_rdy
        inst.add_port('c0_ddr4_app_wdf_rdy',   self.fullname+'_ddr4_app_wdf_rdy')      # output wire c0_ddr4_app_wdf_rdy
        inst.add_port('c0_ddr4_app_en',        self.fullname+'_ddr4_tx_fifo_rd_en')    # input wire c0_ddr4_app_en
        inst.add_port('c0_ddr4_app_hi_pri',    "1'b0")                                 # input wire c0_ddr4_app_hi_pri
        inst.add_port('c0_ddr4_app_wdf_end',   self.fullname+'_ddr4_wdf_wren')         # input wire c0_ddr4_app_wdf_end
        inst.add_port('c0_ddr4_app_wdf_wren',  self.fullname+'_ddr4_wdf_wren')         # input wire c0_ddr4_app_wdf_wren
        inst.add_port('c0_ddr4_app_addr',      self.fullname+'_ddr4_addr_fout', width=self.addr_width)  # input wire [29:0] c0_ddr4_app_addr
        inst.add_port('c0_ddr4_app_cmd',       self.fullname+'_ddr4_cmd_fout',  width=3)                # input wire [2:0] c0_ddr4_app_cmd
        inst.add_port('c0_ddr4_app_wdf_data',  self.fullname+'_ddr4_din_fout',  width=8*self.width)     # input wire [511:0] c0_ddr4_app_wdf_data
        inst.add_port('c0_ddr4_app_wdf_mask',  f"{self.width}'b0")                                      # input wire [63:0] c0_ddr4_app_wdf_mask
        # NOTE: hardwiring the mask to all zeros for now

        # Receive-side FIFO
        txf = top.get_instance(f'{self.fullname}_rx_fifo', f'{self.fullname}_rx_fifo_inst')
        txf.add_port('rst',       rst)
        txf.add_port('wr_clk',    self.ddr_clk)
        txf.add_port('rd_clk',    'user_clk')
        txf.add_port('din',       f'{self.fullname}_ddr4_app_rd_data', width=8*self.width)
        txf.add_port('wr_en',     f'{self.fullname}_ddr4_app_rd_data_valid')
        txf.add_port('rd_en',     f'{self.fullname}_ddr4_rx_fifo_rd_en') # From Simulink
        txf.add_port('dout',      f'{self.fullname}_ddr4_dout', width=8*self.width) # To Simulink
        txf.add_port('full',      '')
        txf.add_port('overflow',  f'{self.fullname}_ddr4_fifo_out_overflow') # To Simulink
        txf.add_port('empty',     f'{self.fullname}_ddr4_fifo_out_empty')
        txf.add_port('underflow', f'{self.fullname}_ddr4_fifo_out_underflow') # To Simulink
        txf.add_port('rd_data_count', f'{self.fullname}_ddr4_out_fifo_rd_dc', width=5) # To Simulink
        txf.add_port('wr_data_count', f'{self.fullname}_ddr4_out_fifo_wr_dc', width=5) # To Simulink


        top.add_signal(f'{self.fullname}_ddr4_out_vld') # To Simulink
        top.assign_signal(f'{self.fullname}_ddr4_out_vld', f'~{self.fullname}_ddr4_fifo_out_empty')

        inst.add_port('c0_ddr4_app_rd_data_end',   self.fullname+'_ddr4_app_rd_data_end')    # output wire c0_ddr4_app_rd_data_end
        inst.add_port('c0_ddr4_app_rd_data_valid', self.fullname+'_ddr4_app_rd_data_valid')  # output wire c0_ddr4_app_rd_data_valid # To Simulink for debug
        inst.add_port('c0_ddr4_app_rd_data',       self.fullname+'_ddr4_app_rd_data', width=8*self.width) # output wire [511: 0] c0_ddr4_app_rd_data

        inst.add_port('c0_sys_clk_n',     self.fullname + '_c0_sys_clk_n', parent_port=True, dir='in')
        inst.add_port('c0_sys_clk_p',     self.fullname + '_c0_sys_clk_p', parent_port=True, dir='in')
        inst.add_port('c0_ddr4_reset_n',  self.fullname + '_ddr4_reset_n', parent_port=True, dir='out')

        inst.add_port('c0_ddr4_ck_t',     self.fullname + '_ddr4_ck_t', parent_port=True, dir='out')     # output wire [0 : 0] c0_ddr4_ck_t
        inst.add_port('c0_ddr4_act_n',    self.fullname + '_ddr4_act_n', parent_port=True, dir='out')    # output wire c0_ddr4_act_n
        inst.add_port('c0_ddr4_ck_c',     self.fullname + '_ddr4_ck_c', parent_port=True, dir='out')     # output wire [0 : 0] c0_ddr4_ck_c
        inst.add_port('c0_ddr4_adr',      self.fullname + '_ddr4_adr',      width=17, parent_port=True, dir='out')      # output wire [16 : 0] c0_ddr4_adr
        inst.add_port('c0_ddr4_ba',       self.fullname + '_ddr4_ba',       width=2, parent_port=True, dir='out')       # output wire [1 : 0] c0_ddr4_ba
        inst.add_port('c0_ddr4_cke',      self.fullname + '_ddr4_cke', parent_port=True, dir='out')      # output wire [0 : 0] c0_ddr4_cke
        inst.add_port('c0_ddr4_cs_n',     self.fullname + '_ddr4_cs_n', parent_port=True, dir='out')     # output wire [0 : 0] c0_ddr4_cs_n
        inst.add_port('c0_ddr4_dm_dbi_n', self.fullname + '_ddr4_dm_dbi_n', width=self.width//8, parent_port=True, dir='inout') # inout wire [5 : 0] c0_ddr4_dm_dbi_n
        inst.add_port('c0_ddr4_dq',       self.fullname + '_ddr4_dq',       width=self.width, parent_port=True, dir='inout')       # inout wire [47 : 0] c0_ddr4_dq
        inst.add_port('c0_ddr4_dqs_c',    self.fullname + '_ddr4_dqs_c',    width=self.width//8, parent_port=True, dir='inout')    # inout wire [5 : 0] c0_ddr4_dqs_c
        inst.add_port('c0_ddr4_dqs_t',    self.fullname + '_ddr4_dqs_t',    width=self.width//8, parent_port=True, dir='inout')    # inout wire [5 : 0] c0_ddr4_dqs_t
        inst.add_port('c0_ddr4_odt',      self.fullname + '_ddr4_odt', parent_port=True, dir='out')      # output wire [0 : 0] c0_ddr4_odt
        inst.add_port('c0_ddr4_bg',       self.fullname + '_ddr4_bg', parent_port=True, dir='out')       # output wire [0 : 0] c0_ddr4_bg

    def gen_constraints(self):
        conlist = []
        ramid = f'ddr4_{self.bank}'
        conlist.append(PortConstraint(self.fullname + '_c0_sys_clk_n', ramid + '_sys_clk_n', iogroup_index=0))
        conlist.append(PortConstraint(self.fullname + '_c0_sys_clk_p', ramid + '_sys_clk_p', iogroup_index=0))
        conlist.append(PortConstraint(self.fullname + '_ddr4_reset_n', ramid + '_reset_n', iogroup_index=0))
        conlist.append(PortConstraint(self.fullname + '_ddr4_ck_t', ramid + '_ck_t', iogroup_index=0))
        conlist.append(PortConstraint(self.fullname + '_ddr4_act_n', ramid + '_act_n', iogroup_index=0))
        conlist.append(PortConstraint(self.fullname + '_ddr4_ck_c', ramid + '_ck_c', iogroup_index=0))
        conlist.append(PortConstraint(self.fullname + '_ddr4_adr', ramid + '_adr', port_index=range(17), iogroup_index=range(17)))
        conlist.append(PortConstraint(self.fullname + '_ddr4_ba', ramid + '_ba', port_index=range(2), iogroup_index=range(2)))
        conlist.append(PortConstraint(self.fullname + '_ddr4_cke', ramid + '_cke', iogroup_index=0))
        conlist.append(PortConstraint(self.fullname + '_ddr4_cs_n', ramid + '_cs_n', iogroup_index=0))
        conlist.append(PortConstraint(self.fullname + '_ddr4_dm_dbi_n', ramid + '_dm_dbi_n', port_index=range(self.width//8), iogroup_index=range(self.width//8)))
        conlist.append(PortConstraint(self.fullname + '_ddr4_dq', ramid + '_dq', port_index=range(self.width), iogroup_index=range(self.width)))
        conlist.append(PortConstraint(self.fullname + '_ddr4_dqs_c', ramid + '_dqs_c', port_index=range(self.width//8), iogroup_index=range(self.width//8)))
        conlist.append(PortConstraint(self.fullname + '_ddr4_dqs_t', ramid + '_dqs_t', port_index=range(self.width//8), iogroup_index=range(self.width//8)))
        conlist.append(PortConstraint(self.fullname + '_ddr4_odt', ramid + '_odt', iogroup_index=0))
        conlist.append(PortConstraint(self.fullname + '_ddr4_bg', ramid + '_bg', iogroup_index=0))
        conlist.append(ClockGroupConstraint('pl_clk_mmcm', f'-of_objects [get_nets {self.ddr_clk}]', 'asynchronous')) # TODO

        return conlist

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        tcl_cmds['pre_synth'] += [f'create_ip -name ddr4 -vendor xilinx.com -library ip -version 2.2 -module_name {self.fullname}']
        tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.C0.DDR4_CasLatency {17} CONFIG.C0.DDR4_DataWidth {64} CONFIG.C0.DDR4_InputClockPeriod {4998} CONFIG.C0.DDR4_MemoryPart {MT40A1G16RC-062E} CONFIG.C0.DDR4_TimePeriod {833}] [get_ips %s]' % self.fullname]

        tcl_cmds['pre_synth'] += [f'create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name {self.fullname}_tx_fifo']
        tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.Fifo_Implementation {Independent_Clocks_Distributed_RAM} CONFIG.INTERFACE_TYPE {Native} CONFIG.Performance_Options {First_Word_Fall_Through} CONFIG.Input_Data_Width {%d} CONFIG.Input_Depth {128} CONFIG.Output_Data_Width {%d} CONFIG.Output_Depth {128} CONFIG.Use_Embedded_Registers {false} CONFIG.Reset_Pin {true} CONFIG.Enable_Reset_Synchronization {true} CONFIG.Reset_Type {Asynchronous_Reset} CONFIG.Full_Flags_Reset_Value {1} CONFIG.Use_Dout_Reset {true} CONFIG.Valid_Flag {false} CONFIG.Underflow_Flag {true} CONFIG.Overflow_Flag {true} CONFIG.Data_Count_Width {5} CONFIG.Write_Data_Count_Width {5} CONFIG.Read_Data_Count_Width {5} CONFIG.Read_Data_Count {true} CONFIG.Use_Extra_Logic {false} CONFIG.Write_Data_Count {true} CONFIG.Full_Threshold_Assert_Value {31} CONFIG.Full_Threshold_Negate_Value {30} CONFIG.Empty_Threshold_Assert_Value {4} CONFIG.Empty_Threshold_Negate_Value {5} CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_wach {15} CONFIG.Empty_Threshold_Assert_Value_wach {14} CONFIG.FIFO_Implementation_wdch {Common_Clock_Block_RAM} CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_wrch {15} CONFIG.Empty_Threshold_Assert_Value_wrch {14} CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_rach {15} CONFIG.Empty_Threshold_Assert_Value_rach {14} CONFIG.FIFO_Implementation_rdch {Common_Clock_Block_RAM} CONFIG.FIFO_Implementation_axis {Common_Clock_Block_RAM}] [get_ips %s_tx_fifo]' % (self.addr_width + self.width*8 + 3, self.addr_width + self.width*8 + 3, self.fullname)]

        tcl_cmds['pre_synth'] += [f'create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name {self.fullname}_rx_fifo']
        tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.Fifo_Implementation {Independent_Clocks_Distributed_RAM} CONFIG.INTERFACE_TYPE {Native} CONFIG.Performance_Options {First_Word_Fall_Through} CONFIG.Input_Data_Width {%d} CONFIG.Input_Depth {128} CONFIG.Output_Data_Width {%d} CONFIG.Output_Depth {128} CONFIG.Use_Embedded_Registers {false} CONFIG.Reset_Pin {true} CONFIG.Enable_Reset_Synchronization {true} CONFIG.Reset_Type {Asynchronous_Reset} CONFIG.Full_Flags_Reset_Value {1} CONFIG.Use_Dout_Reset {true} CONFIG.Valid_Flag {false} CONFIG.Underflow_Flag {true} CONFIG.Overflow_Flag {true} CONFIG.Data_Count_Width {5} CONFIG.Write_Data_Count_Width {5} CONFIG.Read_Data_Count_Width {5} CONFIG.Read_Data_Count {true} CONFIG.Use_Extra_Logic {false} CONFIG.Write_Data_Count {true} CONFIG.Full_Threshold_Assert_Value {127} CONFIG.Full_Threshold_Negate_Value {126} CONFIG.Empty_Threshold_Assert_Value {4} CONFIG.Empty_Threshold_Negate_Value {5} CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_wach {15} CONFIG.Empty_Threshold_Assert_Value_wach {14} CONFIG.FIFO_Implementation_wdch {Common_Clock_Block_RAM} CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_wrch {15} CONFIG.Empty_Threshold_Assert_Value_wrch {14} CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_rach {15} CONFIG.Empty_Threshold_Assert_Value_rach {14} CONFIG.FIFO_Implementation_rdch {Common_Clock_Block_RAM} CONFIG.FIFO_Implementation_axis {Common_Clock_Block_RAM}] [get_ips %s_rx_fifo]' % (self.width*8, self.width*8, self.fullname)]

        return tcl_cmds

