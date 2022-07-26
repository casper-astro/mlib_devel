import os
import re
from six import iteritems

from .yellow_block import YellowBlock

class axi_protocol_converter(YellowBlock):

  attr_map = {
   'aruser_wid'      :  { 'param' : 'ARUSER_WIDTH',     'fmt': "{{:d}}"},
   'awuser_wid'      :  { 'param' : 'AWUSER_WIDTH',     'fmt': "{{:d}}"},
   'buser_wid'       :  { 'param' : 'BUSER_WIDTH',      'fmt': "{{:d}}"},
   'data_wid'        :  { 'param' : 'DATA_WIDTH',       'fmt': "{{:d}}"},
   'id_wid'          :  { 'param' : 'ID_WIDTH',         'fmt': "{{:d}}"},
   'mi_protocol'     :  { 'param' : 'MI_PROTOCOL',      'fmt': "{{:s}}"},
   'rw_mode'         :  { 'param' : 'READ_WRITE_MODE',  'fmt': "{{:s}}"},
   'ruser_wid'       :  { 'param' : 'RUSER_WIDTH',      'fmt': "{{:d}}"},
   'si_protocol'     :  { 'param' : 'SI_PROTOCOL',      'fmt': "{{:s}}"},
   'translation_mode':  { 'param' : 'TRANSLATION_MODE', 'fmt': "{{:d}}"}, #2 \\'] # split incompatible burts into multiple transactions
   'wuser_wid'       :  { 'param' : 'WUSER_WIDTH',      'fmt': "{{:d}}"}
  }

  def initialize(self):

    print(self.blk)
    for attr, _ in iteritems(self.attr_map):
      setattr(self, attr, self.blk[attr])

    self.requires.append('pl_sys_clk')
    self.requires.append('axil_arstn')

  def modify_top(self, top):
    pass


  def modify_bd(self, bd):
    print("***** {:s}, modify block design *****".format(self.name))

    ip_name = 'axi_proto_conv'
    bd.create_cell('axi_protocol_converter', ip_name)

    bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(ip_name, 'aclk'))
    bd.connect_net('axil_arstn', '{:s}/{:s}'.format(ip_name, 'aresetn'))

    bd.connect_intf_net(self.blk['saxi_ifpath'], '{:s}/{:s}'.format(ip_name,'S_AXI'))

    # make M AXI external
    bd.add_raw_cmd('make_bd_intf_pins_external [get_bd_intf_pins axi_proto_conv/M_AXI]')
    bd.add_raw_cmd('set_property NAME M_AXI_PROTO [get_bd_intf_ports M_AXI_0]')
    bd.add_raw_cmd('set_property CONFIG.FREQ_HZ $ps_freq_hz [get_bd_intf_ports M_AXI_PROTO]')

    # apply configurations
    bd.add_raw_cmd('set_property -dict [list \\')
    bd.build_config_cmd(self, self.attr_map, None)
    bd.add_raw_cmd('] [get_bd_cells {:s}]'.format(ip_name))


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

    return tcl_cmds

