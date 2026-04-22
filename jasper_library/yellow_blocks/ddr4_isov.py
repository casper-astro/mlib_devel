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

class ddr4_isov(YellowBlock):
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

        self.ddr_clk = 'ddr4_ui_clk'
        self.addr_width = 30
        self.bank = 0

        self.add_source('ddr4/ddr4_isov.sv')

    def modify_top(self,top):
        inst = top.get_instance('ddr4_isov', self.fullname+'_inst')

        inst.add_port('user_clk',       'user_clk')
        inst.add_port('sys_rst',        "1'b0") # TODO cheat and don't drive for now, was not driving other ddr example
        inst.add_port('user_addr',      self.fullname+'_ddr4_addr',     width=self.addr_width)
        inst.add_port('user_valid',     self.fullname+'_ddr4_vld')
        inst.add_port('user_cmd',       self.fullname+'_ddr4_cmd',           width=3)
        inst.add_port('user_ready',     self.fullname+'_ddr4_user_wr_ready')
        inst.add_port('user_wr_data',   self.fullname+'_ddr4_din',  width=(8*self.width))
        inst.add_port('user_wr_mask',   self.fullname+'_ddr4_din_mask',       width=self.width)
        inst.add_port('user_rd_tdata',  self.fullname+'_ddr4_dout', width=(8*self.width))
        inst.add_port('user_rd_tvalid', self.fullname+'_ddr4_out_vld')
        inst.add_port('user_rd_tlast',  self.fullname+'_ddr4_out_last')
        inst.add_port('user_rd_tready', self.fullname+'_ddr4_user_rd_ready')
        inst.add_port('ddr_fifo_ready', self.fullname+'_ddr4_ddr_fifo_ready')


        inst.add_port('ddr4_c0_sys_clk_n', self.fullname + '_c0_sys_clk_n',  parent_port=True, dir='in')
        inst.add_port('ddr4_c0_sys_clk_p', self.fullname + '_c0_sys_clk_p',  parent_port=True, dir='in')
        inst.add_port('ddr4_dm_dbi_n',     self.fullname + '_ddr4_dm_dbi_n', width=self.width//8, parent_port=True, dir='inout') # inout wire  [5 : 0] c0_ddr4_dm_dbi_n
        inst.add_port('ddr4_dq',           self.fullname + '_ddr4_dq',       width=self.width, parent_port=True, dir='inout')    # inout wire  [47 : 0] c0_ddr4_dq
        inst.add_port('ddr4_dqs_c',        self.fullname + '_ddr4_dqs_c',    width=self.width//8, parent_port=True, dir='inout') # inout wire  [5 : 0] c0_ddr4_dqs_c
        inst.add_port('ddr4_dqs_t',        self.fullname + '_ddr4_dqs_t',    width=self.width//8, parent_port=True, dir='inout') # inout wire  [5 : 0] c0_ddr4_dqs_t
        inst.add_port('ddr4_act_n',        self.fullname + '_ddr4_act_n',    parent_port=True, dir='out')                        # output wire [0 : 0] c0_ddr4_act_n
        inst.add_port('ddr4_adr',          self.fullname + '_ddr4_adr',      width=17, parent_port=True, dir='out')              # output wire [16 : 0] c0_ddr4_adr
        inst.add_port('ddr4_ba',           self.fullname + '_ddr4_ba',       width=2, parent_port=True, dir='out')               # output wire [1 : 0] c0_ddr4_ba
        inst.add_port('ddr4_bg',           self.fullname + '_ddr4_bg',       parent_port=True, dir='out')                        # output wire [0 : 0] c0_ddr4_bg
        inst.add_port('ddr4_ck_c',         self.fullname + '_ddr4_ck_c',     parent_port=True, dir='out')                        # output wire [0 : 0] c0_ddr4_ck_c
        inst.add_port('ddr4_ck_t',         self.fullname + '_ddr4_ck_t',     parent_port=True, dir='out')                        # output wire [0 : 0] c0_ddr4_ck_t
        inst.add_port('ddr4_cke',          self.fullname + '_ddr4_cke',      parent_port=True, dir='out')                        # output wire [0 : 0] c0_ddr4_cke
        inst.add_port('ddr4_cs_n',         self.fullname + '_ddr4_cs_n',     parent_port=True, dir='out')                        # output wire [0 : 0] c0_ddr4_cs_n
        inst.add_port('ddr4_odt',          self.fullname + '_ddr4_odt',      parent_port=True, dir='out')                        # output wire [0 : 0] c0_ddr4_odt
        inst.add_port('ddr4_reset_n',      self.fullname + '_ddr4_reset_n',  parent_port=True, dir='out')


    def gen_constraints(self):
        cons= []
        ramid = f'ddr4_{self.bank}'
        cons.append(PortConstraint(self.fullname + '_c0_sys_clk_n',  ramid + '_sys_clk_n', iogroup_index=0))
        cons.append(PortConstraint(self.fullname + '_c0_sys_clk_p',  ramid + '_sys_clk_p', iogroup_index=0))
        cons.append(PortConstraint(self.fullname + '_ddr4_dm_dbi_n', ramid + '_dm_dbi_n', port_index=range(self.width//8), iogroup_index=range(self.width//8)))
        cons.append(PortConstraint(self.fullname + '_ddr4_dq',       ramid + '_dq', port_index=range(self.width), iogroup_index=range(self.width)))
        cons.append(PortConstraint(self.fullname + '_ddr4_dqs_c',    ramid + '_dqs_c', port_index=range(self.width//8), iogroup_index=range(self.width//8)))
        cons.append(PortConstraint(self.fullname + '_ddr4_dqs_t',    ramid + '_dqs_t', port_index=range(self.width//8), iogroup_index=range(self.width//8)))
        cons.append(PortConstraint(self.fullname + '_ddr4_act_n',    ramid + '_act_n', iogroup_index=0))
        cons.append(PortConstraint(self.fullname + '_ddr4_adr',      ramid + '_adr', port_index=range(17), iogroup_index=range(17)))
        cons.append(PortConstraint(self.fullname + '_ddr4_ba',       ramid + '_ba', port_index=range(2), iogroup_index=range(2)))
        cons.append(PortConstraint(self.fullname + '_ddr4_bg',       ramid + '_bg', iogroup_index=0))
        cons.append(PortConstraint(self.fullname + '_ddr4_ck_c',     ramid + '_ck_c', iogroup_index=0))
        cons.append(PortConstraint(self.fullname + '_ddr4_ck_t',     ramid + '_ck_t', iogroup_index=0))
        cons.append(PortConstraint(self.fullname + '_ddr4_cke',      ramid + '_cke', iogroup_index=0))
        cons.append(PortConstraint(self.fullname + '_ddr4_cs_n',     ramid + '_cs_n', iogroup_index=0))
        cons.append(PortConstraint(self.fullname + '_ddr4_odt',      ramid + '_odt', iogroup_index=0))
        cons.append(PortConstraint(self.fullname + '_ddr4_reset_n',  ramid + '_reset_n', iogroup_index=0))
        cons.append(ClockGroupConstraint('pl_clk_mmcm', f'-of_objects [get_nets {self.ddr_clk}]', 'asynchronous')) # TODO

        return cons

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        #tcl_cmds['pre_synth'] += [f'create_ip -name ddr4 -vendor xilinx.com -library ip -version 2.2 -module_name {self.fullname}']
        tcl_cmds['pre_synth'] += [f'create_ip -name ddr4 -vendor xilinx.com -library ip -version 2.2 -module_name ddr4_core']
        #tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.C0.DDR4_CasLatency {17} CONFIG.C0.DDR4_DataWidth {64} CONFIG.C0.DDR4_InputClockPeriod {4998} CONFIG.C0.DDR4_MemoryPart {MT40A1G16RC-062E} CONFIG.C0.DDR4_TimePeriod {833}] [get_ips %s]' % self.fullname]
        tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.C0.DDR4_CasLatency {17} CONFIG.C0.DDR4_DataWidth {64} CONFIG.C0.DDR4_InputClockPeriod {4998} CONFIG.C0.DDR4_MemoryPart {MT40A1G16RC-062E} CONFIG.C0.DDR4_TimePeriod {833}] [get_ips %s]' % 'ddr4_core']

        return tcl_cmds

