import os
import re
from six import iteritems

from .yellow_block import YellowBlock

class zynq_usplus(YellowBlock):

  maxi_attr_map = {
      # TODO: vivado is expecting integer boolean true/false=1/0 but the code from
      # rfdc to build commands didn't handle this case need to relearn what was done
      # because right now the block will then be expecting integer config values
      'enable_maxi_fpd0' : {'param': 'PSU__USE__M_AXI_GP0',      'fmt': "{{:d}}"},
      'enable_maxi_fpd1' : {'param': 'PSU__USE__M_AXI_GP1',      'fmt': "{{:d}}"},
      'enable_maxi_lpd'  : {'param': 'PSU__USE__M_AXI_GP2',      'fmt': "{{:d}}"},
      'maxi0_data_width' : {'param': 'PSU__MAXIGP0__DATA_WIDTH', 'fmt': "{{:d}}"},
      'maxi1_data_width' : {'param': 'PSU__MAXIGP1__DATA_WIDTH', 'fmt': "{{:d}}"},
      'maxi2_data_width' : {'param': 'PSU__MAXIGP2__DATA_WIDTH', 'fmt': "{{:d}}"},
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
    self.provides.append('pl_sys_clk')
    self.provides.append('axil_rst')
    self.provides.append('axil_arstn')

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
    bd.create_cell('zynq_ultra_ps_e', ip_name)

    # apply mpsoc platform presets
    bd.add_raw_cmd('source {:s}'.format(self.mpsoc_presets_path))

    bd.create_net('pl_sys_clk')
    bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(ip_name, 'pl_clk0'))

    bd.create_net('pl_resetn')
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

    # ADD AXI INTERFACE
    # THERE IS A BUG IN VIVADO PARAMETER PROPAGATION -- need to read the value from the mpsoc and convert to Hz
    # to reproduce bug:
    #   - show the set value, prints 100
    #   - validate the block design with -quiet, no fail
    #   - print again, still 100.
    #   - no open in Vivado run the same sequence, works fine
    #bd.add_raw_cmd('puts [get_property CONFIG.FREQ_HZ [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]]')
    #bd.add_raw_cmd('validate_bd_design -quiet')
    #bd.add_raw_cmd('puts [get_property CONFIG.FREQ_HZ [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]]')

    #bd.add_raw_cmd('puts [get_property CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ [get_bd_cells mpsoc]]')
    bd.add_raw_cmd('set freq_mhz [get_property CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ [get_bd_cells mpsoc]]')
    bd.add_raw_cmd('set ps_freq_hz [expr $freq_mhz*1e6]')

    # approach 1
    bd.add_raw_cmd('make_bd_intf_pins_external [get_bd_intf_pins mpsoc/M_AXI_HPM1_FPD]')
    bd.add_raw_cmd('set_property NAME M_AXI [get_bd_intf_ports M_AXI_HPM1_FPD_0]')
    bd.add_raw_cmd('set_property CONFIG.FREQ_HZ $ps_freq_hz [get_bd_intf_ports M_AXI]')

    # approach 2
    #bd.create_intf_port('M_AXI0', 'Master', 'axi4')

    #bd.add_raw_cmd('set_property -dict [list \\')
    #bd.add_raw_cmd('CONFIG.PROTOCOL [get_property CONFIG.PROTOCOL [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.ADDR_WIDTH [get_property CONFIG.ADDR_WIDTH [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.DATA_WIDTH [get_property CONFIG.DATA_WIDTH [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.HAS_BURST [get_property CONFIG.HAS_BURST [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.HAS_LOCK [get_property CONFIG.HAS_LOCK [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.HAS_PROT [get_property CONFIG.HAS_PROT [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.HAS_CACHE [get_property CONFIG.HAS_CACHE [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.HAS_QOS [get_property CONFIG.HAS_QOS [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.HAS_REGION [get_property CONFIG.HAS_REGION [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.SUPPORTS_NARROW_BURST [get_property CONFIG.SUPPORTS_NARROW_BURST [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.MAX_BURST_LENGTH [get_property CONFIG.MAX_BURST_LENGTH [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    ## there is a bug, ideally this would have worked, but the parameter propagation has not happened for the clock field
    ##bd.add_raw_cmd('CONFIG.FREQ_HZ [get_property CONFIG.FREQ_HZ [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]] \\')
    #bd.add_raw_cmd('CONFIG.FREQ_HZ $ps_freq_hz \\')
    #bd.add_raw_cmd('] [get_bd_intf_ports M_AXI0]')

    #bd.connect_intf_net('{:s}/{:s}'.format(ip_name, 'M_AXI_HPM0_FPD'), 'M_AXI0')

    # add a processor reset
    proc_rst_name = 'proc_sys_reset'
    bd.create_cell('proc_sys_reset', proc_rst_name)
    bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(proc_rst_name, 'slowest_sync_clk'))

    bd.create_net('axil_rst')
    bd.create_net('axil_arstn')

    bd.connect_net('pl_resetn', '{:s}/{:s}'.format(proc_rst_name, 'ext_reset_in'))
    bd.connect_net('axil_rst', '{:s}/{:s}'.format(proc_rst_name, 'peripheral_reset'))
    bd.connect_net('axil_arstn', '{:s}/{:s}'.format(proc_rst_name, 'peripheral_aresetn'))
    bd.add_port('axil_rst',   'out', port_type='rst')
    bd.add_port('axil_arstn', 'out', port_type='rst')

    bd.connect_port('axil_rst', 'axil_rst')
    bd.connect_port('axil_arstn', 'axil_arstn')


  def gen_children(self):
    children = []
    proto_conv_blk = {
        'tag'             : 'xps:axi_protocol_converter',
        'saxi_ifpath'     : 'mpsoc/M_AXI_HPM0_FPD',
        'aruser_wid'      : 16,
        'awuser_wid'      : 16,
        'buser_wid'       : 0,
        'data_wid'        : 32,
        'id_wid'          : 16,
        'mi_protocol'     : 'AXI4LITE',
        'rw_mode'         : 'READ_WRITE',
        'ruser_wid'       : 0,
        'si_protocol'     : 'AXI4',
        'translation_mode': 2,
        'wuser_wid'       : 0,
    }
    children.append(YellowBlock.make_block(proto_conv_blk, self.platform))

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
