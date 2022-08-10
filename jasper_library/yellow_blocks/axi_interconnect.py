import os
import re
from six import iteritems

from .yellow_block import YellowBlock

class axi_interconnect(YellowBlock):
  attr_map = { 
    'num_mi' : {'param': 'NUM_MI', 'fmt': '{{:d}}'},
    'num_si' : {'param': 'NUM_SI', 'fmt': '{{:d}}'},
    # TODO ton more params to add depending on config and advanced config
  }

  class axi_interface(object):
    def __init__(self, mode, interface_idx, dest=None):
      self.mode = mode
      self.idx = interface_idx
      self.dest = dest

      self.clk_src = 'pl_sys_clk'
      self.rst_src = 'axil_arst_n'

      if mode == 'Master':
        mode_prefix = 'M'
      else:
        mode_prefix = 'S'

      self.clk_net_name  = '{:s}{:02d}_ACLK'.format(mode_prefix, interface_idx)
      self.port_net_name = '{:s}{:02d}_AXI'.format(mode_prefix, interface_idx)
      self.rst_net_name  = '{:s}{:02d}_ARESETN'.format(mode_prefix, interface_idx)


  def initialize(self):
    # deserialize block from its parameter attribute map
    for attr, _ in iteritems(self.attr_map):
      setattr(self, attr, self.blk[attr])

    maxi_intf = self.blk['maxi_intf']
    if len(maxi_intf) != self.num_mi:
      self.throw_error("number of master interfaces provided does not match block configuration")
    saxi_intf = self.blk['saxi_intf']
    if len(saxi_intf) != self.num_si:
      self.throw_error("number of slave interfaces provided does not match block configuration")

    # build master interfaces
    self.maxi = []
    for idx, intf in enumerate(maxi_intf):
      m = self.axi_interface('Master', idx, dest=intf['dest'])
      self.maxi.append(m)
      self.provides.append('{:s}/{:s}'.format(self.name, m.port_net_name))

    # build slave interfaces
    self.saxi = []
    for idx, intf in enumerate(saxi_intf):
      s = self.axi_interface('Slave', idx, dest=intf['dest'])
      self.saxi.append(s)
      self.requires.append(s.dest)

    # requires
    self.requires.append('pl_sys_clk')
    self.requires.append('axil_arst_n')


  def modify_top(self, top):
    blkdesign = '{:s}_bd'.format(self.platform.conf['name'])
    bd_inst = top.get_instance(blkdesign, '{:s}_inst'.format(blkdesign))

    # if the path for the connection is not in the current block design a port
    # must be made and the top module must expose it
    for m in self.maxi:
      if len(m.dest.split('/')) == 1:
        top_intf_prefix = m.dest.lower()
        bd_intf_prefix = m.dest
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

    # connect general axi control clk/rst
    # TODO no axi class for this interface
    bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(self.name, 'ACLK'))
    bd.connect_net('axil_arst_n', '{:s}/{:s}'.format(self.name, 'ARESETN'))

    # connect slave interfaces
    for s in self.saxi:
      bd.connect_net(s.clk_src, '{:s}/{:s}'.format(self.name, s.clk_net_name))
      bd.connect_net(s.rst_src, '{:s}/{:s}'.format(self.name, s.rst_net_name))
      bd.connect_intf_net(s.dest, '{:s}/{:s}'.format(self.name, s.port_net_name))

    # connect master interfaces
    for m in self.maxi:
      bd.connect_net(m.clk_src, '{:s}/{:s}'.format(self.name, m.clk_net_name))
      bd.connect_net(m.rst_src, '{:s}/{:s}'.format(self.name, m.rst_net_name))

      # make M AXI external
      if len(m.dest.split('/')) == 1: # assumption used to know when to make pins external to bd
        intf_pin_name = '{:s}/{:s}'.format(self.name, m.port_net_name)
        ext_intf_name = m.dest

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
        # assume slave will make connection

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

