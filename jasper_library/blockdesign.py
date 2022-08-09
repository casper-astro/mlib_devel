import os
import re
from six import iteritems

class BlockDesign(object):
  """
  A crude, brute force way to put a vivado block design (.bd) together
  """

  interface_type_map = {
    'axi4': 'aximm_rtl:1.0',
  }

  class axi4_interface(object):
    axi4_attr_map = {
      'addr_width': {'param': 'ADDR_WIDTH', 'fmt': "{{:d}}"},
    }

  def __init__(self, name=''):

    if len(name) != 0:
      self.name = name
    else:
      raise ValueError("'name' must be a string of non-zero length")

    self.bd_tcl_cmds = {
      'place_bd_ip'     : [],
      'build_bd'        : [],
      'assign_bd_addrs' : []
    }

    # not sure if this list will be helpful, or what needs to be added to be helpful
    self.design_ips = []

  def create_axi4_intf(self, name, mode, config_dict):
      self.create_intf_port(name, mode, 'axi4')

  def create_cell(self, ip, inst_name):
    self.bd_tcl_cmds['place_bd_ip'] += ['create_bd_cell -type ip -vlnv xilinx.com:ip:{:s}:* {:s}'.format(ip, inst_name)]
    self.design_ips.append(ip)

  def create_net(self, net_name): # add optional values like type=clk and then add to list of internal provides nets?
    self.bd_tcl_cmds['build_bd'] += ['create_bd_net {:s}'.format(net_name)]

  def connect_net(self, src_net, dest_net):
    self.bd_tcl_cmds['build_bd'] += ['connect_bd_net -net {:s} [get_bd_pins {:s}]'.format(src_net, dest_net)]

  # TODO, could combine with above method
  def connect_port(self, net, port):
    self.bd_tcl_cmds['build_bd'] += ['connect_bd_net -net {:s} [get_bd_ports {:s}]'.format(net, port)]

  def create_intf_port(self, name, mode, intf_type):
    vivado_if_type = self.interface_type_map[intf_type]
    self.bd_tcl_cmds['build_bd'] += ['create_bd_intf_port -mode {:s} -vlnv xilinx.com:interface:{:s} {:s}'.format(mode, vivado_if_type, name)]

  #def connect_intf_net(self, intf_pin, intf_port):
  #  self.bd_tcl_cmds['build_bd'] += ['connect_bd_intf_net [get_bd_intf_pins {:s}] [get_bd_intf_ports {:s}]'.format(intf_pin, intf_port)]
  def connect_intf_net(self, src_intf, dest_intf):
    self.bd_tcl_cmds['build_bd'] += ['connect_bd_intf_net [get_bd_intf_pins {:s}] [get_bd_intf_pins {:s}]'.format(src_intf, dest_intf)]

  def add_port(self, name, port_dir, port_type=None, width=None, clk_freq_hz=None):
    # check for valid board design port specification
    allowable_types = ['clk', 'rst', 'intr', '', None]
    if not port_type in allowable_types:
      self.throw_error('ERROR: The board design port type "{:s}" is not valid'.format(port_type))

    # start to build option string for port creation
    opt_str = ''
    opt_str = opt_str + '-dir {:s}'.format("O" if port_dir=='out' else "I")

    if port_type:
      opt_str = opt_str + ' -type {:s}'.format(port_type)
      if port_type=='clk' and port_dir=='in':
        if clk_freq_hz is None:
          self.throw_error('ERROR: Board design inputs ports defined as a type "clk" must specify a clock frequency')
        opt_str = opt_str + ' -freq_hz {:d}'.format(int(clk_freq_hz))

    if width:
      opt_str = opt_str + ' -from {:d} -to {:d}'.format(width-1, 0)

    self.bd_tcl_cmds['build_bd'] += ['create_bd_port {:s} {:s}'.format(opt_str, name)]

  def assign_address(self, addr_space, addr_seg, offset, range):
    #self.bd_tcl_cmds['assign_bd_addrs'] += ['assign_bd_address -offset 0xA0000000 -range 0x00010000 -target_address_space
    #[get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs M_AXI/Reg] -force
    self.bd_tcl_cmds['assign_bd_addrs'] += ['assign_bd_address -offset {:s}'
                                            ' -range {:s}'
                                            ' -target_address_space [get_bd_addr_spaces {:s}]'
                                            ' [get_bd_addr_segs {:s}]'
                                            ' -force'.format(offset, range, addr_space, addr_seg)]

  def build_config_cmd(self, cls_object, attr_map, *tile_slice_fmt):
    """
    cls_object     : object containing attributes to target vivado parameter
    attr_map       : dictionary mapping the `cls_object` attributes to their vivado equivalent
    tile_slice_fmt : variable input targeting the tile and slice formatter fields of the vivado parameter
    """
    print("******* IN BUILD_CONFIG_CMD **********")
    vivado_cmd = 'CONFIG.{:s} {{{}}} \\'
    cmds = []
    for attr, vivado_param in iteritems(attr_map):
      print(attr)
      if hasattr(cls_object, attr):
        param = vivado_param['param']
        fmt = vivado_param['fmt']
        full_param = param.format(*tile_slice_fmt)
        v = None
        if hasattr(cls_object, attr+'_value_map'):
          vmap = getattr(cls_object, attr+'_value_map')
          v = vmap[getattr(cls_object, attr)]
        else:
          v = getattr(cls_object, attr)
          print(v)
        # lower() to force boolean converted to string to become lowercase - probably a better way to get that done...
        if type(v) == bool:
          v = str(v).lower()
        cmds.append(vivado_cmd.format(full_param, fmt).format(v))

    self.bd_tcl_cmds['build_bd'] += cmds
    

  def add_raw_cmd(self, cmd, stage='build_bd'):
    self.bd_tcl_cmds[stage] += [cmd]

  def gen_tcl(self):
    print("building tclfile...")
    s = ''
    s += '\n'.join(self.bd_tcl_cmds['place_bd_ip'])
    s += '\n'
    s += '\n'.join(self.bd_tcl_cmds['build_bd'])
    s += '\n'
    s += '\n'.join(self.bd_tcl_cmds['assign_bd_addrs'])
    return s
