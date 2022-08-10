import os
import re
from six import iteritems

from .yellow_block import YellowBlock

class axi_protocol_converter(YellowBlock):
  attr_map = {
    'aruser_wid'      : {'param': 'ARUSER_WIDTH',     'fmt': "{{:d}}"},
    'awuser_wid'      : {'param': 'AWUSER_WIDTH',     'fmt': "{{:d}}"},
    'buser_wid'       : {'param': 'BUSER_WIDTH',      'fmt': "{{:d}}"},
    'data_wid'        : {'param': 'DATA_WIDTH',       'fmt': "{{:d}}"},
    'id_wid'          : {'param': 'ID_WIDTH',         'fmt': "{{:d}}"},
    'mi_protocol'     : {'param': 'MI_PROTOCOL',      'fmt': "{{:s}}"},
    'rw_mode'         : {'param': 'READ_WRITE_MODE',  'fmt': "{{:s}}"},
    'ruser_wid'       : {'param': 'RUSER_WIDTH',      'fmt': "{{:d}}"},
    'si_protocol'     : {'param': 'SI_PROTOCOL',      'fmt': "{{:s}}"},
    'translation_mode': {'param': 'TRANSLATION_MODE', 'fmt': "{{:d}}"}, #2 \\'] # split incompatible burts into multiple transactions
    'wuser_wid'       : {'param': 'WUSER_WIDTH',      'fmt': "{{:d}}"}
  }

  class axi_interface(object):
    def __init__(self, mode, interface_idx=None, dest=None):
      self.type = None
      self.mode = mode
      self.idx = interface_idx
      self.dest = dest

      self.clk_src = 'pl_sys_clk'
      self.rst_src = 'axil_arst_n'
      self.clk_net_name = 'aclk'
      self.rst_net_name = 'aresetn'
      self.port_net_name = 'S_AXI'

  def initialize(self):
    # deserialize block from its parameter attribute map
    for attr, _ in iteritems(self.attr_map):
      setattr(self, attr, self.blk[attr])

    saxi_intf = self.blk['saxi_intf']
    self.saxi = self.axi_interface('Slave', 0, dest=saxi_intf['dest'])

    maxi_intf = self.blk['maxi_intf']
    self.maxi = self.axi_interface('Master', 0, dest=maxi_intf['dest'])

    # provides
    self.provides.append(self.maxi.dest)

    # requires
    self.requires.append(self.saxi.clk_src)
    self.requires.append(self.saxi.rst_src)
    self.requires.append(self.saxi.dest)

  def modify_top(self, top):
    blkdesign = '{:s}_bd'.format(self.platform.conf['name'])
    bd_inst = top.get_instance(blkdesign, '{:s}_inst'.format(blkdesign))

    # if the path for the connection is not in the current block design a port
    # must be made and the top module must expose it
    if len(self.maxi_intf['dest'].split('/')) == 1:
      top_intf_prefix = self.maxi_intf['dest'].lower()
      bd_intf_prefix = self.maxi_intf['dest']
      bd_inst.add_port('{:s}_awaddr'.format(top_intf_prefix), '{:s}_awaddr'.format(bd_intf_prefix),  width=40)
      bd_inst.add_port('{:s}_awprot'.format(top_intf_prefix), '{:s}_awprot'.format(bd_intf_prefix),  width=3)
      bd_inst.add_port('{:s}_awvalid'.format(top_intf_prefix), '{:s}_awvalid'.format(bd_intf_prefix))
      bd_inst.add_port('{:s}_awready'.format(top_intf_prefix), '{:s}_awready'.format(bd_intf_prefix))
      bd_inst.add_port('{:s}_wdata'.format(top_intf_prefix), '{:s}_wdata'.format(bd_intf_prefix),  width=32)
      bd_inst.add_port('{:s}_wstrb'.format(top_intf_prefix), '{:s}_wstrb'.format(bd_intf_prefix),  width=4)
      bd_inst.add_port('{:s}_wvalid'.format(top_intf_prefix), '{:s}_wvalid'.format(bd_intf_prefix))
      bd_inst.add_port('{:s}_wready'.format(top_intf_prefix), '{:s}_wready'.format(bd_intf_prefix))
      bd_inst.add_port('{:s}_bresp'.format(top_intf_prefix), '{:s}_bresp'.format(bd_intf_prefix),  width=2)
      bd_inst.add_port('{:s}_bvalid'.format(top_intf_prefix), '{:s}_bvalid'.format(bd_intf_prefix))
      bd_inst.add_port('{:s}_bready'.format(top_intf_prefix), '{:s}_bready'.format(bd_intf_prefix))
      bd_inst.add_port('{:s}_araddr'.format(top_intf_prefix), '{:s}_araddr'.format(bd_intf_prefix),  width=40)
      bd_inst.add_port('{:s}_arprot'.format(top_intf_prefix), '{:s}_arprot'.format(bd_intf_prefix),  width=3)
      bd_inst.add_port('{:s}_arvalid'.format(top_intf_prefix), '{:s}_arvalid'.format(bd_intf_prefix))
      bd_inst.add_port('{:s}_arready'.format(top_intf_prefix), '{:s}_arready'.format(bd_intf_prefix))
      bd_inst.add_port('{:s}_rdata'.format(top_intf_prefix), '{:s}_rdata'.format(bd_intf_prefix),  width=32)
      bd_inst.add_port('{:s}_rresp'.format(top_intf_prefix), '{:s}_rresp'.format(bd_intf_prefix),  width=2)
      bd_inst.add_port('{:s}_rvalid'.format(top_intf_prefix), '{:s}_rvalid'.format(bd_intf_prefix))
      bd_inst.add_port('{:s}_rready'.format(top_intf_prefix), '{:s}_rready'.format(bd_intf_prefix))


  def modify_bd(self, bd):
    bd.create_cell(self.blocktype, self.name)

    # apply configurations
    bd.add_raw_cmd('set_property -dict [list \\')
    bd.build_config_cmd(self, self.attr_map, None)
    bd.add_raw_cmd('] [get_bd_cells {:s}]'.format(self.name))

    bd.connect_net(self.saxi.clk_src, '{:s}/{:s}'.format(self.name, self.saxi.clk_net_name))
    bd.connect_net(self.saxi.rst_src, '{:s}/{:s}'.format(self.name, self.saxi.rst_net_name))

    bd.connect_intf_net(self.saxi.dest, '{:s}/{:s}'.format(self.name, self.saxi.port_net_name))

    # make M AXI external
    if len(self.maxi.dest.split('/')) == 1: # assumption used to know when to make pins external to bd
      intf_pin_name = '{:s}/{:s}'.format(self.name, self.maxi.dest)
      ext_intf_name = self.maxi.dest

      bd.create_intf_port(ext_intf_name, 'Master', 'axi4')

      bd.add_raw_cmd('set_property -dict [list \\')
      bd.add_raw_cmd('CONFIG.PROTOCOL [get_property CONFIG.PROTOCOL [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      bd.add_raw_cmd('CONFIG.ADDR_WIDTH [get_property CONFIG.ADDR_WIDTH [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      bd.add_raw_cmd('CONFIG.DATA_WIDTH [get_property CONFIG.DATA_WIDTH [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      bd.add_raw_cmd('CONFIG.HAS_BURST [get_property CONFIG.HAS_BURST [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      bd.add_raw_cmd('CONFIG.HAS_LOCK [get_property CONFIG.HAS_LOCK [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      bd.add_raw_cmd('CONFIG.HAS_PROT [get_property CONFIG.HAS_PROT [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      bd.add_raw_cmd('CONFIG.HAS_CACHE [get_property CONFIG.HAS_CACHE [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      bd.add_raw_cmd('CONFIG.HAS_QOS [get_property CONFIG.HAS_QOS [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      bd.add_raw_cmd('CONFIG.HAS_REGION [get_property CONFIG.HAS_REGION [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      bd.add_raw_cmd('CONFIG.SUPPORTS_NARROW_BURST [get_property CONFIG.SUPPORTS_NARROW_BURST [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      bd.add_raw_cmd('CONFIG.MAX_BURST_LENGTH [get_property CONFIG.MAX_BURST_LENGTH [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name))
      # there is a bug, ideally this would have worked, but the parameter propagation has not happened for the clock field
      #bd.add_raw_cmd('CONFIG.FREQ_HZ [get_property CONFIG.FREQ_HZ [get_bd_intf_pins {:s}]] \\'.format(intf_pin_name)))
      bd.add_raw_cmd('CONFIG.FREQ_HZ $ps_freq_hz \\') # TODO ASSUMES $ps_freq_hz is defined
      bd.add_raw_cmd('] [get_bd_intf_ports {:s}]'.format(ext_intf_name))

      bd.connect_intf_net('{:s}'.format(intf_pin_name), ext_intf_name)
    #else:
      # assume the slave makes the connection

  def gen_children(self):
    children = []
    return children

  def gen_constraints(self):
    cons = []
    return cons

  def gen_tcl_cmds(self):
    tcl_cmds = {}
    tcl_cmds['init'] = []
    tcl_cmds['create_bd'] = []
    tcl_cmds['pre_synth'] = []
    return tcl_cmds

