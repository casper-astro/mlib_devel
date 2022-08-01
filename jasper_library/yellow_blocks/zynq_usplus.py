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
      self.throw_error("ERROR: factory method does not implement a generator for this part")
      pass


class zynq_usplus_rfsoc(zynq_usplus):
  def initialize(self):
    # TODO change path to zynq_mpsoc
    self.mpsoc_presets_path = '{:s}/zynq/{:s}.tcl'.format(self.hdl_root, 'mpsoc_rfsoc4x2')

    print(self.blk)

    for maxi_attr, _ in iteritems(self.maxi_attr_map):
      setattr(self, maxi_attr, self.blk[maxi_attr])

    # TODO will need some sort of "provides" on number of M_AXI and make sure that
    # we have those exclusive requirments on making sure there are enough instanced
    self.provides.append('pl_sys_clk')
    self.provides.append('axil_rst')
    self.provides.append('axil_arst_n')


  def modify_top(self, top):
    # So far, assuming a bd with this name is best way I know how to get done what I need to
    blkdesign = '{:s}_bd'.format(self.platform.conf['name'])
    bd_inst = top.get_instance(blkdesign, '{:s}_inst'.format(blkdesign))

    # TODO need a way to know what interfaces are to be made external...
    bd_inst.add_port('m_axi_awaddr',  'M_AXI_awaddr', width=40)
    bd_inst.add_port('m_axi_awprot',  'M_AXI_awprot', width=3)
    bd_inst.add_port('m_axi_awvalid', 'M_AXI_awvalid')
    bd_inst.add_port('m_axi_awready', 'M_AXI_awready')
    bd_inst.add_port('m_axi_wdata',   'M_AXI_wdata', width=32)
    bd_inst.add_port('m_axi_wstrb',   'M_AXI_wstrb', width=4)
    bd_inst.add_port('m_axi_wvalid',  'M_AXI_wvalid')
    bd_inst.add_port('m_axi_wready',  'M_AXI_wready')
    bd_inst.add_port('m_axi_bresp',   'M_AXI_bresp', width=2)
    bd_inst.add_port('m_axi_bvalid',  'M_AXI_bvalid')
    bd_inst.add_port('m_axi_bready',  'M_AXI_bready')
    bd_inst.add_port('m_axi_araddr',  'M_AXI_araddr', width=40)
    bd_inst.add_port('m_axi_arprot',  'M_AXI_arprot', width=3)
    bd_inst.add_port('m_axi_arvalid', 'M_AXI_arvalid')
    bd_inst.add_port('m_axi_arready', 'M_AXI_arready')
    bd_inst.add_port('m_axi_rdata',   'M_AXI_rdata', width=32)
    bd_inst.add_port('m_axi_rresp',   'M_AXI_rresp', width=2)
    bd_inst.add_port('m_axi_rvalid',  'M_AXI_rvalid')
    bd_inst.add_port('m_axi_rready',  'M_AXI_rready')

    bd_inst.add_port('pl_sys_clk', 'pl_sys_clk')
    bd_inst.add_port('axil_rst', 'axil_rst')
    bd_inst.add_port('axil_arst_n', 'axil_arst_n')


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

    # THERE IS A BUG IN VIVADO PARAMETER PROPAGATION -- need to read the value from the mpsoc and convert to Hz
    # to reproduce bug:
    #   - show the set value, prints 100
    #   - validate the block design with -quiet, no fail
    #   - print again, still 100.
    #   - no open in Vivado run the same sequence, works fine
    #bd.add_raw_cmd('puts [get_property CONFIG.FREQ_HZ [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]]')
    #bd.add_raw_cmd('validate_bd_design -quiet')
    #bd.add_raw_cmd('puts [get_property CONFIG.FREQ_HZ [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]]')

    # given the bug, find the parameter and provide a variable to be used
    #bd.add_raw_cmd('puts [get_property CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ [get_bd_cells mpsoc]]')
    bd.add_raw_cmd('set freq_mhz [get_property CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ [get_bd_cells mpsoc]]')
    bd.add_raw_cmd('set ps_freq_hz [expr $freq_mhz*1e6]')

    # connect maxi clocks and interfaces
    if self.enable_maxi_fpd0:
      bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(ip_name, 'maxihpm0_fpd_aclk'))

      #bd.add_raw_cmd('make_bd_intf_pins_external [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]')
      #bd.add_raw_cmd('set_property NAME M_AXI [get_bd_intf_ports M_AXI_HPM0_FPD_0]')
      #bd.add_raw_cmd('set_property CONFIG.FREQ_HZ $ps_freq_hz [get_bd_intf_ports M_AXI]')

    if self.enable_maxi_fpd1:
      bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(ip_name, 'maxihpm1_fpd_aclk'))

      bd.add_raw_cmd('make_bd_intf_pins_external [get_bd_intf_pins mpsoc/M_AXI_HPM1_FPD]')
      bd.add_raw_cmd('set_property NAME M_AXI_1 [get_bd_intf_ports M_AXI_HPM1_FPD_0]')
      bd.add_raw_cmd('set_property CONFIG.FREQ_HZ $ps_freq_hz [get_bd_intf_ports M_AXI_1]')

    if self.enable_maxi_lpd:
      bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(ip_name, 'maxihpm0_lpd_aclk'))

      bd.add_raw_cmd('make_bd_intf_pins_external [get_bd_intf_pins mpsoc/M_AXI_HPM0_LPD]')
      bd.add_raw_cmd('set_property NAME M_AXI_2 [get_bd_intf_ports M_AXI_HPM0_LPD_0]')
      bd.add_raw_cmd('set_property CONFIG.FREQ_HZ $ps_freq_hz [get_bd_intf_ports M_AXI_2]')

    # make an external port for the `pl_sys_clock`
    bd.add_port('pl_sys_clk', 'out', port_type='clk', clk_freq_hz=100e6)
    bd.connect_port('pl_sys_clk', 'pl_sys_clk')

    # explicitly add a processor reset instead of being a child block
    proc_rst_name = 'proc_sys_reset'
    bd.create_cell('proc_sys_reset', proc_rst_name)
    bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(proc_rst_name, 'slowest_sync_clk'))

    bd.create_net('axil_rst')
    bd.create_net('axil_arst_n')

    bd.connect_net('pl_resetn', '{:s}/{:s}'.format(proc_rst_name, 'ext_reset_in'))
    bd.connect_net('axil_rst', '{:s}/{:s}'.format(proc_rst_name, 'peripheral_reset'))
    bd.connect_net('axil_arst_n', '{:s}/{:s}'.format(proc_rst_name, 'peripheral_aresetn'))
    bd.add_port('axil_rst',   'out', port_type='rst')
    bd.add_port('axil_arst_n', 'out', port_type='rst')

    bd.connect_port('axil_rst', 'axil_rst')
    bd.connect_port('axil_arst_n', 'axil_arst_n')

    # assign address spaces
    bd.assign_address('mpsoc/Data', 'M_AXI/Reg', '0xA0000000', '0x00010000')


  def gen_children(self):
    children = []
    proto_conv_blk = {
        'tag'             : 'xps:axi_protocol_converter',
        'saxi_ifpath'     : 'mpsoc/M_AXI_HPM0_FPD',
        'maxi_ifpath'     : 'M_AXI',
        'aruser_wid'      : 0,
        'awuser_wid'      : 0,
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
    tcl_cmds['create_bd'] = []

    # apply custom settings

    return tcl_cmds
