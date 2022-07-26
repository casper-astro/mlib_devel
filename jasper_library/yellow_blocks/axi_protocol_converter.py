from .yellow_block import YellowBlock

class axi_protocol_converter(YellowBlock):

  def initialize(self):
    #self.add_source('axi_protocol_converter/config_axi_protocol_converter.tcl')
    pass

  def modify_top(self, top):
    pass

  def gen_children(self):
    children = []
    return children

  def gen_constraints(self):
    cons = []
    return cons

  def gen_tcl_cmds(self):
    tcl_cmds = {}
    tcl_cmds['init'] = []

    tcl_cmds['pre_synth'] = []
    tcl_cmds['pre_synth'] += ['puts "I am an axi protocol converter teapot"']
    tcl_cmds['pre_synth'] += ['create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:* axi_protocol_converter']
    tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.ADDR_WIDTH 40 \\']
    tcl_cmds['pre_synth'] += ['CONFIG.ARUSER_WIDTH 0 \\']
    tcl_cmds['pre_synth'] += ['CONFIG.AWUSER_WIDTH 0 \\']
    tcl_cmds['pre_synth'] += ['CONFIG.BUSER_WIDTH  0 \\']
    tcl_cmds['pre_synth'] += ['CONFIG.DATA_WIDTH 32 \\']
    tcl_cmds['pre_synth'] += ['CONFIG.ID_WIDTH 0 \\']
    tcl_cmds['pre_synth'] += ['CONFIG.MI_PROTOCOL  AXI4LITE \\']
    tcl_cmds['pre_synth'] += ['CONFIG.READ_WRITE_MODE  READ_WRITE \\']
    tcl_cmds['pre_synth'] += ['CONFIG.RUSER_WIDTH  0 \\']
    tcl_cmds['pre_synth'] += ['CONFIG.SI_PROTOCOL  AXI4 \\']
    tcl_cmds['pre_synth'] += ['CONFIG.TRANSLATION_MODE 2 \\'] # split incompatible burts into multiple transactions
    tcl_cmds['pre_synth'] += ['CONFIG.WUSER_WIDTH  0 \\']
    tcl_cmds['pre_synth'] += ['] [get_bd_cells axi_protocol_converter]']

    return tcl_cmds

