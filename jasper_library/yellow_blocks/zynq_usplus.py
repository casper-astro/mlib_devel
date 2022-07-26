import os
import struct
from six import iteritems
import re

from .yellow_block import YellowBlock

class zynq_usplus(YellowBlock):

  maxi_attr_map = {
      # TODO: vivado is expecting integer boolean true/false=1/0 but the code from
      # rfdc to build commands didn't handle this case need to relearn what was done
      # because right now the block will then be expecting integer config values
      'enable_maxi_fpd0': {'param': 'PSU__USE__M_AXI_GP0', 'fmt': "{{:d}}"},
      'enable_maxi_fpd1': {'param': 'PSU__USE__M_AXI_GP1', 'fmt': "{{:d}}"},
      'enable_maxi_lpd' : {'param': 'PSU__USE__M_AXI_GP2', 'fmt': "{{:d}}"}
  }

  ps_irq_attr_map = {
      'enable_ps_irq0' : {'param': 'PSU__USE__IRQ0', 'fmt': "{{:d}}"},
      'enable_ps_irq0' : {'param': 'PSU__USE__IRQ1', 'fmt': "{{:d}}"}
  }

  @staticmethod
  def factory(blk, plat, hdl_root=None):
    if plat.fpga.startswith('xczu'):
      return zynq_usplus_rfsoc(blk, plat, hdl_root)
    else:
    # TODO: what is the error case, what mechanisims are in place to gracefully fail?
      #self.throw_error() <- see this one in the yellow_block class
      pass

class zynq_usplus_rfsoc(zynq_usplus):
  def initialize(self):
    # TODO change path to zynq_mpsoc
    self.mpsoc_presets_path = '{:s}/zynq/{:s}.tcl'.format(self.hdl_root, 'mpsoc_rfsoc4x2')
    self.add_source(self.mpsoc_presets_path)

    print(self.blk)

    for maxi_attr, _ in iteritems(self.maxi_attr_map):
      setattr(self, maxi_attr, self.blk[maxi_attr])

    # TODO will need some sort of "provides" on number of M_AXI and make sure that we have those exclusive requirments on making sure there
    # are enough instanced

  def modify_top(self, top):
    # need to get the board design inst... how are we going to do this?
    #   * assume there is one to add?
    #   * add a 'vivado block design' yellow block in simulink?
    #   * have the platform add it??? (so far I like this)
    #     - how does this work? because this will still assume a shared bd inst name...

    # ask yourself, how does a non-platform suppoting ip get added (e.g., the rfdc, how does it know
    # and not just the rfdc, what about just a soft DMA or AXI GPIO IP?)

    # this yellow block will have available to it:
    #   * all platform information (self.platform)

    # so far this ist the best way I know how to get done what I need to
    blkdesign = '{:s}_bd'.format(self.platform.conf['name'])
    bd_inst = top.get_instance(blkdesign, '{:s}_inst'.format(blkdesign))
    
    inst = top.get_instance('mpsoc', 'mpsoc_inst')
    inst.add_port('pl_resetn0', 'pl_resetn0')
    inst.add_port('pl_clk0', 'pl_clk0')


  def modify_bd(self, bd):
    print("***** {:s}, modify block design *****".format(self.name))

    ip_name = 'mpsoc'
    bd.add_ip_blk('zynq_ultra_ps_e', ip_name)

    # apply mpsoc platform presets
    bd.add_raw_cmd('source {:s}'.format(self.mpsoc_presets_path))

    bd.add_net('pl_sys_clk')
    bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(ip_name, 'pl_clk0'))

    bd.add_net('pl_resetn')
    bd.connect_net('pl_resetn', '{:s}/{:s}'.format(ip_name, 'pl_resetn0'))

    # apply maxi user configuration
    bd.add_raw_cmd('set_property -dict [list \\')
    bd.build_config_cmd(self, self.maxi_attr_map, self.enable_maxi_fpd0)
    bd.add_raw_cmd('] [get_bd_cells {:s}]'.format(ip_name))

    # connect maxi clocks
    if self.enable_maxi_fpd0:
      bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(ip_name, 'maxihpm0_fpd_aclk'))

    if self.enable_maxi_fpd1:
      bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(ip_name, 'maxihpm1_fpd_aclk'))

    if self.enable_maxi_lpd:
      bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(ip_name, 'maxihpm0_lpd_aclk'))

    bd.add_port('pl_resetn', 'out', port_type='rst')
    bd.connect_port('pl_resetn', 'pl_resetn')

    bd.create_intf_port('M_AXI', 'Master', 'axi4')
    

  def gen_children(self):
    children = []
    children.append(YellowBlock.make_block({'tag': 'xps:axi_protocol_converter'}, self.platform))
    return children

  def gen_constraints(self):
    cons = []
    return cons

  def gen_tcl_cmds(self):
    tcl_cmds = {}
    tcl_cmds['init'] = []
    tcl_cmds['build_bd'] = []

    # apply presets
    tcl_cmds['build_bd'] += ['source {:s}/zynq/{:s}.tcl'.format(self.hdl_root, 'mpsoc_rfsoc4x2')]
    #tcl_cmds['build_bd'] +=

    # apply custom settings

    # generate output produces(?)
    #tcl_cmds['pre_synth'] += ['source config_mpsoc_zcu216.tcl']
    #tcl_cmds['pre_synth'] += ['generate_target all [get_ips mpsoc]']
    #tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']

    return tcl_cmds
