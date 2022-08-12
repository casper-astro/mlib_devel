import os
import re
from six import iteritems

from .yellow_block import YellowBlock

class axi_gpio(YellowBlock):
  attr_map = {
    # TODO can these be grouped like rfdc tiles? The _2 formatting is what makes it a little different, not as flexible to string formatting?
    'enable_dual' : {'param': 'C_IS_DUAL',           'fmt': '{{:d}}'},
    'enable_intr' : {'param': 'C_INTERRUPT_PRESENT', 'fmt': '{{:d}}'},
    'all_inputs'  : {'param': 'C_ALL_INPUTS',        'fmt': '{{:d}}'},
    'all_outputs' : {'param': 'C_ALL_OUTPUTS',       'fmt': '{{:d}}'},
    'gpio_width'  : {'param': 'C_GPIO_WIDTH',        'fmt': '{{:d}}'},
    'default_val' : {'param': 'C_DOUT_DEFAULT',      'fmt': '{{:#010x}}'},
    'tri_default' : {'param': 'C_TRI_DEFAULT',       'fmt': '{{:#010x}}'},
    'all_inputs2' : {'param': 'C_ALL_INPUTS_2',      'fmt': '{{:d}}'},
    'all_outputs2': {'param': 'C_ALL_OUTPUTS_2',     'fmt': '{{:d}}'},
    'default_val2': {'param': 'C_DOUT_DEFAULT_2',    'fmt': '{{:#010x}}'},
    'gpio_width2' : {'param': 'C_GPIO2_WIDTH',       'fmt': '{{:d}}'},
    'tri_default2': {'param': 'C_TRI_DEFAULT_2',     'fmt': '{{:#010x}}'},
  }

  class axi_interface(object):
    def __init__(self, mode, interface_idx, dest=None):
      self.mode = mode
      self.idx = interface_idx
      self.dest = dest

      self.clk_src = 'pl_sys_clk'
      self.rst_src = 'axil_arst_n'
      self.clk_net_name  = 's_axi_aclk'
      self.rst_net_name  = 's_axi_aresetn'
      self.port_net_name = 'S_AXI'

  class gpio_interface(object):
    def __init__(self, mode, interface_idx, dest=None):
      self.mode = mode
      self.idx = interface_idx
      self.dest = dest

      self.clk_src = None
      self.rst_src = None

      self.port_net_name = 'gpio_io_o'

  def initialize(self):
    # deserialize block from its parameter attribute map
    for attr, _ in iteritems(self.attr_map):
      setattr(self, attr, self.blk[attr])

    saxi_intf = self.blk['saxi_intf']
    self.saxi = self.axi_interface('Slave', 0, dest=saxi_intf['dest'])

    gpio_intf = self.blk['gpio_intf']

    self.gpio = []
    for idx, intf in enumerate(gpio_intf):
      # TODO: vivado wants 'O/I' for out and jasper top wants 'out/in'
      # current approach to get vivado is g.mode[0].upper()
      g = self.gpio_interface('out', idx, dest=intf['dest'])
      self.gpio.append(g)

    # requires
    self.requires.append('pl_sys_clk')
    self.requires.append('axil_arst_n')
    self.requires.append(self.saxi.dest)


  def modify_top(self, top):
    blkdesign = '{:s}_bd'.format(self.platform.conf['name'])
    bd_inst = top.get_instance(blkdesign, '{:s}_inst'.format(blkdesign))

    for g in self.gpio:
      if len(g.dest.split('/')) == 1:
        top_intf_prefix = g.dest.lower()
        bd_intf_prefix = g.dest
        bd_inst.add_port('{:s}'.format(top_intf_prefix), '{:s}'.format(bd_intf_prefix),  width=self.gpio_width, dir=g.mode, parent_port=True)

  def modify_bd(self, bd):
    bd.create_cell(self.blocktype, self.name)

    # apply configurations
    bd.add_raw_cmd('set_property -dict [list \\')
    bd.build_config_cmd(self, self.attr_map, None)
    bd.add_raw_cmd('] [get_bd_cells {:s}]'.format(self.name))

    # connect saxi clk/rst
    bd.connect_net(self.saxi.clk_src, '{:s}/{:s}'.format(self.name, self.saxi.clk_net_name))
    bd.connect_net(self.saxi.rst_src, '{:s}/{:s}'.format(self.name, self.saxi.rst_net_name))

    # connect saxi interface
    bd.connect_intf_net(self.saxi.dest, '{:s}/{:s}'.format(self.name, self.saxi.port_net_name))

    for g in self.gpio:
      # make external
      if len(g.dest.split('/')) == 1: # assumption used to know when to make pins external to bd
        intf_pin_name = '{:s}/{:s}'.format(self.name, g.port_net_name)
        ext_port_name = g.dest

        bd.add_raw_cmd('create_bd_port -dir {:s} -from {:d} -to {:d} {:s}'.format(g.mode[0].upper(), self.gpio_width, 0, ext_port_name))
        bd.add_raw_cmd('connect_bd_net [get_bd_ports {:s}] [get_bd_pins {:s}]'.format(ext_port_name, intf_pin_name))
      #else:
        # assume slave will make connection

    # TODO hard coded information, needs to be made dynamic
    bd.assign_address('mpsoc/Data', '{:s}/{:s}/Reg'.format(self.name, self.saxi.port_net_name), '0xB0040000', '0x00010000')

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

