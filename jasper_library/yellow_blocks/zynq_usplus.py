import os
import re
from six import iteritems

from .yellow_block import YellowBlock

class zynq_usplus(YellowBlock):
  maxi_attr_map = {
    # TODO: vivado is expecting integer boolean true/false=1/0 but the code from
    # rfdc to build commands didn't handle this case need to relearn what was done
    # because right now the block will then be expecting integer config values
    'enable':     {'param': 'PSU__USE__M_AXI_GP{:d}',      'fmt': "{{:d}}"},
    'data_width': {'param': 'PSU__MAXIGP{:d}__DATA_WIDTH', 'fmt': "{{:d}}"}
  }

  ps_irq_attr_map = {
    'enable_ps_irq0' : {'param': 'PSU__USE__IRQ0', 'fmt': "{{:d}}"},
    'enable_ps_irq1' : {'param': 'PSU__USE__IRQ1', 'fmt': "{{:d}}"}
  }

  class axi_interface(object):
    def __init__(self):
      self.type = None
      self.mode = None
      self.dest = None
      self.clk_src = None
      self.clk_net_name = None
      self.rst_src = None
      self.rst_net_name = None
      self.port_net_name = None

  class zynq_maxi_interface(axi_interface):
    def __init__(self, interface_idx):
      self.idx = interface_idx
      self.dest = None
      #self.clk_src = 'pl_sys_clk'

      if interface_idx <= 1:
        self.clk_net_name = 'maxihpm{:d}_fpd_aclk'.format(interface_idx)
        self.port_net_name = 'M_AXI_HPM{:d}_FPD'.format(interface_idx)
      else:
        self.clk_net_name = 'maxihpm0_lpd_aclk'
        self.port_net_name = 'M_AXI_HPM0_LPD'


  @staticmethod
  def factory(blk, plat, hdl_root=None):
    if plat.conf.get('family', None) in ["ultrascaleplus", "rfsoc"]:
      return zynq_ultra_ps_e(blk, plat, hdl_root)
    else:
      self.throw_error("ERROR: this part cannot instance an MPSoC")
      pass


class zynq_ultra_ps_e(zynq_usplus):
  def initialize(self):
    # TODO change path to zynq_mpsoc
    self.presets = self.blk['presets']
    self.mpsoc_presets_path = '{:s}/zynq/{:s}.tcl'.format(self.hdl_root, self.presets)

    # build maxi interfaces
    self.num_maxi = 3
    self.maxi = []
    for midx in range(0, self.num_maxi):
      m = self.zynq_maxi_interface(midx)

      mconf = self.blk['maxi_{:d}'.format(midx)]['conf']
      for attr, _ in iteritems(self.maxi_attr_map):
        if attr in mconf:
          setattr(m, attr, mconf[attr])

      mintf = self.blk['maxi_{:d}'.format(midx)]['intf']
      for k,v in mintf.items():
        if hasattr(m, k):
          setattr(m, k, v)
      self.maxi.append(m)

    for m in self.maxi:
      if m.enable:
        self.provides.append('{:s}/{:s}'.format(self.name, m.port_net_name))

    self.provides.append('pl_sys_clk')
    self.provides.append('axil_rst')
    self.provides.append('axil_arst_n')


  def modify_top(self, top):
    blkdesign = '{:s}_bd'.format(self.platform.conf['name'])
    bd_inst = top.get_instance(blkdesign, '{:s}_inst'.format(blkdesign))

    bd_inst.add_port('pl_sys_clk', 'pl_sys_clk')
    bd_inst.add_port('axil_rst', 'axil_rst')
    bd_inst.add_port('axil_arst_n', 'axil_arst_n')

    for m in self.maxi:
      if m.enable:
        # if the path for the connection is not in the current block design a port
        # must be made and the top module must expose it
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

    # apply mpsoc platform presets
    bd.add_raw_cmd('source {:s}'.format(self.mpsoc_presets_path))

    bd.create_net('pl_sys_clk')
    bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(self.name, 'pl_clk0'))

    bd.create_net('pl_resetn')
    bd.connect_net('pl_resetn', '{:s}/{:s}'.format(self.name, 'pl_resetn0'))

    # apply maxi user configuration
    bd.add_raw_cmd('set_property -dict [list \\')
    for n, maxi_if in enumerate(self.maxi):
      bd.build_config_cmd(maxi_if, self.maxi_attr_map, n)
    bd.add_raw_cmd('] [get_bd_cells {:s}]'.format(self.name))

    """
    THERE IS A BUG IN VIVADO PARAMETER PROPAGATION -- need to read the value from the mpsoc and convert to Hz
    to reproduce bug:
      - show the set value, (should print 100)
      - validate the block design with -quiet, no fail
      - print again (still 100)
      - no open in Vivado run the same sequence, works fine
    bd.add_raw_cmd('puts [get_property CONFIG.FREQ_HZ [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]]')
    bd.add_raw_cmd('validate_bd_design -quiet')
    bd.add_raw_cmd('puts [get_property CONFIG.FREQ_HZ [get_bd_intf_pins mpsoc/M_AXI_HPM0_FPD]]')
    """

    # given the above vivado bug, find the parameter and provide a variable to be used
    #bd.add_raw_cmd('puts [get_property CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ [get_bd_cells mpsoc]]')
    bd.add_raw_cmd('set freq_mhz [get_property CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ [get_bd_cells mpsoc]]')
    bd.add_raw_cmd('set ps_freq_hz [expr $freq_mhz*1e6]')

    # connect maxi clocks and interfaces
    for m in self.maxi:
      if m.enable:
        bd.connect_net('pl_sys_clk', '{:s}/{:s}'.format(self.name, m.clk_net_name))

        # make interfaces external if they have no board design connections, otherwise the slave interface must make the connection
        if len(m.dest.split('/')) == 1:
          intf_pin_name = "{:s}/{:s}".format(self.name, m.port_net_name)
          ext_intf_name = m.dest

          # approach 2
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
          # TODO assumes $ps_freq_hz is defined
          bd.add_raw_cmd('CONFIG.FREQ_HZ $ps_freq_hz \\')
          bd.add_raw_cmd('] [get_bd_intf_ports {:s}]'.format(ext_intf_name))

          bd.connect_intf_net('{:s}'.format(intf_pin_name), ext_intf_name)

          # approach 2 -- assumes already will know the deterministic naming of the ports
          #bd.add_raw_cmd('make_bd_intf_pins_external [get_bd_intf_pins {:s}]'.format(intf_pin_name))
          #bd.add_raw_cmd('set_property NAME {:s} [get_bd_intf_ports {:s}_0]'.format(ext_intf_name, m.port_net_name))
          #bd.add_raw_cmd('set_property CONFIG.FREQ_HZ $ps_freq_hz [get_bd_intf_ports {:s}]'.format(ext_intf_name))
        #else:
          # it is expected that slave interfaces make the board design intf pin connections

    # make an external port for the `pl_sys_clock`
    bd.add_port('pl_sys_clk', 'out', port_type='clk', clk_freq_hz=100e6)
    bd.connect_port('pl_sys_clk', 'pl_sys_clk')

    # explicitly add a processor reset instead of being a child block
    # (should it be a child block though)?
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
    # TODO hard coded information needs to be dynamic
    bd.assign_address('mpsoc/Data', 'M_AXI/Reg', '0xA0000000', '0x00010000')


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

    # apply custom settings

    return tcl_cmds
