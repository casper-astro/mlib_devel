from .yellow_block import YellowBlock
from .yellow_block_typecodes import TYPECODE_RFDC
from constraints import PortConstraint, ClockConstraint, RawConstraint

from six import iteritems
import re

class rfdc(YellowBlock):

  # maps tile and adc attributes to vivado parameters
  tile_attr_map = {
    # removed the enable object to be handled higher the class abstraction as this indexing [224-227] is incosistent with [0-3]
    #'enable'         : 'ADC{:d}_En',# ADC suffix {:d} is 224-227
    'sample_rate'    : {'param' : 'ADC{:d}_Sampling_Rate', 'fmt' : "{{:.3f}}"}, # ADC suffix {:d} is 0-3
    'ref_clk'        : {'param' : 'ADC{:d}_Refclk_Freq'  , 'fmt' : "{{:.3f}}"},
    'clk_out'        : {'param' : 'ADC{:d}_Outclk_Freq'  , 'fmt' : "{{:.3f}}"},
    'axi_stream_clk' : {'param' : 'ADC{:d}_Fabric_Freq'  , 'fmt' : "{{:.3f}}"},
    'enable_pll'     : {'param' : 'ADC{:d}_PLL_Enable'   , 'fmt' : "{{}}"},
    'clk_dist'       : {'param' : 'ADC{:d}_Clock_Dist'   , 'fmt' : "{{:d}}"},
    'clk_src'        : {'param' : 'ADC{:d}_Clock_Source' , 'fmt' : "{{:d}}"}
  }

  adc_attr_map = {
    'enable'          : {'param' : 'ADC_Slice{:d}{:d}_Enable',    'fmt' : "{{}}"},
    'digital_output'  : {'param' : 'ADC_Data_Type{:d}{:d}',       'fmt' : "{{:d}}"},
    'dec_mode'        : {'param' : 'ADC_Decimation_Mode{:d}{:d}', 'fmt' : "{{:d}}"},
    'sample_per_cycle': {'param' : 'ADC_Data_Width{:d}{:d}',      'fmt' : "{{:d}}"},
    'mixer_type'      : {'param' : 'ADC_Mixer_Type{:d}{:d}',      'fmt' : "{{:d}}"},
    'mixer_mode'      : {'param' : 'ADC_Mixer_Mode{:d}{:d}',      'fmt' : "{{:d}}"}
  }

  """
  rfdc tile and adc slice deserialized configuration containters
  """
  class tile(object): pass


  class adc_slice(object):
    digital_output_value_map = { 'Real' : 0, 'I/Q'  : 1 }

    mixer_mode_value_map = {
      'Real -> Real' : 2,
      'I/Q -> I/Q'   : 1,
      'Real -> I/Q'  : 0
    }

    mixer_type_value_map = {
      'Bypassed' : 1,#0, # TODO what is the correct value? Is bypassed even accetable with new v2.4 IP?
      'Coarse'   : 1,
      'Fine'     : 2,
      'Off'      : 3
    }

    # dec_mode_value_map = lambda d: d[0] # could use `callable()` to provide more capability to prepare arguments if needed for both values
    # and vivado parameter formatting
    dec_mode_value_map = {
      '1x'  : 1,
      '2x'  : 2,
      '3x'  : 3,
      '4x'  : 4,
      '5x'  : 5,
      '6x'  : 6,
      '10x' : 10,
      '12x' : 12,
      '16x' : 16,
      '20x' : 20,
      '24x' : 24,
      '40x' : 40
    }


  def initialize(self):
    # IP generation and configuration parameters
    self.tile_arch     = None
    self.num_adc_slice = None
    self.enabled_tiles = []
    self.enabled_adcs  = []
    self.tiles         = []
    # current support configures all adcs to be the same in each enabled tiles. Later support
    # would extend each tile to have its own set of adc objects allowing for different cross
    # tile configuration
    self.adcs          = []

    self.typecode = TYPECODE_RFDC

    # sources for mts and other
    # self.add_source('')

    self.rfdc_conf = self.platform.conf['rfdc']

    part = self.platform.conf['fpga']
    m = re.search('(2[8-9])|(39)|(4[8-9])', part)
    if not m:
      self.throw_error("ERROR: RFSoC part designator {} not recognized or is not yet supported".format(part))

    # first digit from part designator indicates part generation (e.g., xczu28dr is gen 1)
    designator = m.group(0)
    if   designator[0] == '4':
      self.gen = 3
    elif designator[0] == '3':
      self.gen = 2
    elif designator[0] == '2':
      self.gen = 1

    # second digit from part designator indicates RF tile architecture (e.g., xczu28dr is a Dual-Tile arch)
    if   designator[1] == '8':
      self.tile_arch = 'DT'
      self.num_adc_slice = 2
    elif designator[1] == '9':
      self.tile_arch = 'QT'
      self.num_adc_slice = 4

    # build tile and adc slice objects for IP instantiation and configuration
    # determine enabled tiles
    for tidx in range(224,228):
      if self.blk['Tile{:d}_enable'.format(tidx)]:
        self.enabled_tiles.append(tidx-224)

    # build tile objects
    for tidx in range(224, 228):
      t = self.tile()
      t.enable = (tidx-224 in self.enabled_tiles)

      for tile_attr, _ in iteritems(self.tile_attr_map):
        if tile_attr in self.blk:
          setattr(t, tile_attr, self.blk[tile_attr])

      t.has_clk_src = self.rfdc_conf['tile{:d}'.format(tidx)]['has_adc_clk']
      t.clk_src     = self.rfdc_conf['tile{:d}'.format(tidx)]['adc_clk_src']

      # TODO: enable all tile PLLs and forward low freq reference or enable PLL for source tile
      # and distribute the output of the PLL
      # This seems to give the most heartache code compatability between gen1+2 and gen3 devices.
      # Right now this implementation would be compatible and treat both gen1+2 and gen3 devices
      # with similar capability. That the reference clock is input to the tile RF-PLL and out as
      # sample clk
      if (t.clk_src == tidx-224):
        t.clk_dist = 1 # distribute: input reference clock
      else:
        t.clk_dist = 0 # distribute: off

      self.tiles.append(t)

    # simulink mask asks for sample rate in Msps (liked it better) convert here to units of Gsps to hand to
    # vivado IP configuration (alternative is to edit mask and mask scripts to compute/display in Gsps)
    for tile in self.tiles:
      tile.sample_rate = tile.sample_rate/1000

    # determine enabled adcs
    for aidx in range(0, self.num_adc_slice):
      if self.blk['{:s}_adc{:d}_enable'.format(self.tile_arch, aidx)]:
        self.enabled_adcs.append(aidx)

    # build adc objects
    adc_mask_fmt = '{:s}_adc{:d}_{:s}'
    for aidx in range(0, self.num_adc_slice):
      a = self.adc_slice()
      for adc_attr, _ in iteritems(self.adc_attr_map):
        attr_key = adc_mask_fmt.format(self.tile_arch, aidx, adc_attr)
        if attr_key in self.blk:
          setattr(a, adc_attr, self.blk[attr_key])
      self.adcs.append(a)

    self.enable_mts = self.blk['enable_mts']

    # validate tile clocking distribution
    if (False in [(t.clk_src in self.enabled_tiles) for t in self.tiles]):
      s = ''
      s+="ERROR: clocking distribution is inconsistent\n"
      s+=("expected source tiles: " + (4*"{:3d} ").format(*[t.clk_src+224 for t in self.tiles]) + '\n')
      s+=("enabled tiles: " + (len(self.enabled_tiles)*"{:3d}").format(*[t+224 for t in self.enabled_tiles]) + '\n')
      self.throw_error(s)

    # finish setting up yellow block
    self.requires.append('axil_clk')
    self.requires.append('axil_rst_n')
    self.requires.append('sysref_in')

    if self.enable_mts:
      self.requires.append('pl_sysref')

    for a in self.enabled_adcs:
      # TODO: should these be renamed to something like "rfdc_clkX", since "adc_clk" is a dominant name else where in the toolflow
      self.provides.append('adc_clk{:d}'.format(a))

  def modify_top(self, top):
    # include axi4lite
    top.add_axi4lite_interface(regname="RFDC", mode='rw', nbytes=4, typecode=self.typecode, axi4lite_mode='raw') #self.unique_name

    # instantiate rfdc
    rfdc_inst = top.get_instance('rfdc', 'rfdc_inst')

    # TODO: need to get the clock right, same one on the same domain too
    rfdc_inst.add_port('s_axi_aclk',    'axil_clk')
    rfdc_inst.add_port('s_axi_aresetn', 'axil_rst_n')

    rfdc_inst.add_port('s_axi_awaddr',  'm_axi4lite_RFDC_awaddr', width=32) # TODO: check right width on everything #TODO: use 'unique_name'?
    rfdc_inst.add_port('s_axi_awvalid', 'm_axi4lite_RFDC_awvalid')
    rfdc_inst.add_port('s_axi_awready', 'm_axi4lite_RFDC_awready')
    rfdc_inst.add_port('s_axi_wdata',   'm_axi4lite_RFDC_wdata', width=32)
    rfdc_inst.add_port('s_axi_wstrb',   'm_axi4lite_RFDC_wstrb', width=4)
    rfdc_inst.add_port('s_axi_wvalid',  'm_axi4lite_RFDC_wvalid')
    rfdc_inst.add_port('s_axi_wready',  'm_axi4lite_RFDC_wready')
    rfdc_inst.add_port('s_axi_bresp',   'm_axi4lite_RFDC_bresp', width=2)
    rfdc_inst.add_port('s_axi_bvalid',  'm_axi4lite_RFDC_bvalid')
    rfdc_inst.add_port('s_axi_bready',  'm_axi4lite_RFDC_bready')
    rfdc_inst.add_port('s_axi_araddr',  'm_axi4lite_RFDC_araddr', width=32)
    rfdc_inst.add_port('s_axi_arvalid', 'm_axi4lite_RFDC_arvalid')
    rfdc_inst.add_port('s_axi_arready', 'm_axi4lite_RFDC_arready')
    rfdc_inst.add_port('s_axi_rdata',   'm_axi4lite_RFDC_rdata', width=32)
    rfdc_inst.add_port('s_axi_rresp',   'm_axi4lite_RFDC_rresp', width=2)
    rfdc_inst.add_port('s_axi_rvalid',  'm_axi4lite_RFDC_rvalid')
    rfdc_inst.add_port('s_axi_rready',  'm_axi4lite_RFDC_rready')

    rfdc_inst.add_port('irq', 'rfdc_irq') #self.fullname+'_irq'

    # TODO: pins most likely need to be added in platform files for sysref
    rfdc_inst.add_port('sysref_in_p', 'sysref_in_p', dir='in', parent_port=True) #self.fullname+'_sysref_in_p',
    rfdc_inst.add_port('sysref_in_n', 'sysref_in_n', dir='in', parent_port=True) #self.fullname+'_sysref_in_n',

    if self.enable_mts:
      # TODO: add instance of PL capture synchronizer, get port name correct
      rfdc_inst.add_port('user_adc_sysref', 'user_adc_sysref', dir='in')

    # generate tile/slice interface ports
    for tidx in self.enabled_tiles:
      # maxis clk, reset and output clock (when using mts, this output clock is not typically used)
      rfdc_inst.add_port('m{:d}_axis_aclk'.format(tidx), 'm{:d}_axis_aclk'.format(tidx))       #self.fullname+'_m0_axis_aclk'
      rfdc_inst.add_port('m{:d}_axis_aresetn'.format(tidx), 'axil_rst_n') #'m{:d}_axis_aresetn'.format(tidx)) #self.fullname+'_m0_axis_aresetn'
      rfdc_inst.add_port('clk_adc{:d}'.format(tidx), 'clk_adc{:d}'.format(tidx), dir='out') #self.fullname+'_clk_adc0'
      # wire these ports to supporting infrastructure
      #top.assign_signal('m{:d}_axis_aresetn'.format(tidx), 'axil_rst_n')
      top.assign_signal('m{:d}_axis_aclk'.format(tidx), 'adc_clk')

      # For now tile source information comes from the board platform file configuration, later support could extend this to get
      # information from simulink, but the platform would need to support it (current gen3 xilinx eval boards don't for example)
      if (self.rfdc_conf['tile{:d}'.format(tidx+224)]['adc_clk_src'] == tidx):
      #if (self.tilestidx].clk_src == tidx):
        rfdc_inst.add_port('adc{:d}_clk_p'.format(tidx), 'adc{:d}_clk_p'.format(tidx), dir='in', parent_port=True) #self.fullname+
        rfdc_inst.add_port('adc{:d}_clk_n'.format(tidx), 'adc{:d}_clk_n'.format(tidx), dir='in', parent_port=True) #self.fullname+

      for aidx in self.enabled_adcs:
        # vin ports
        rfdc_inst.add_port('vin{:d}{:d}_p'.format(tidx, aidx), 'vin{:d}{:d}_p'.format(tidx, aidx),  dir='in', parent_port=True)   #self.fullname+
        rfdc_inst.add_port('vin{:d}{:d}_n'.format(tidx, aidx), 'vin{:d}{:d}_n'.format(tidx, aidx),  dir='in', parent_port=True)   #self.fullname+
        # maxis data ports
        data_width = 16*self.adcs[aidx].sample_per_cycle
        rfdc_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, aidx), 'm{:d}{:d}_axis_tdata'.format(tidx, aidx), width=data_width) #self.fullname+'_m00_axis_tdata'
        rfdc_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, aidx), "1'b1",) #'m00_axis_tready')  #self.fullname+'_m00_axis_tready'
        rfdc_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, aidx), 'm{:d}{:d}_axis_tvalid'.format(tidx, aidx)) #self.fullname+'_m00_axis_tvalid'


  def gen_constraints(self):
    # So the idea seems to be that we do not need to add any constraints... Per PG269 and some experience using the core the constraints are
    # auto included and determined as part of the output products for the IP core. The only pins that I have constrained in a user design
    # are the pl_clk and pl_sysref and these should be provided by the infrastructure...
    #
    # will not include for now and come back and verify... although I do know that including them won't hurt anything
    #
    #cons.append(PortConstraint('vin00_p', 'vin00_p'))
    #cons.append(PortConstraint('vin00_n', 'vin00_n'))

    # TODO: needed with MTS
    #cons.append(PortConstraint('pl_sysref_p', 'pl_sysref_p'))
    cons = []

    return cons

  def gen_tcl_cmds(self):
    tcl_cmds = {}
    tcl_cmds['init'] = []
    tcl_cmds['init'] += ['puts "I am a init zcu216 teapot"']

    tcl_cmds['pre_synth'] = []
    tcl_cmds['pre_synth'] += ['create_ip -name usp_rf_data_converter -vendor xilinx.com -library ip -version * -module_name rfdc']
    # RFDC defaults with tile 224 and ADC 0 enabled -- disable everything as a starting point
    tcl_cmds['pre_synth'] += ['set_property -dict [list \\']
    tcl_cmds['pre_synth'] += ['CONFIG.ADC224_En {false} \\']
    tcl_cmds['pre_synth'] += ['CONFIG.ADC_Slice00_Enable {false} \\']
    tcl_cmds['pre_synth'] += ['] [get_ips rfdc]']
    # begin to apply casper user configuration
    tcl_cmds['pre_synth'] += ['set_property -dict [list \\']

    # enable/disable tiles
    for tidx in range(0, 4):
      vivado_cmd = 'CONFIG.{:s} {{{}}} \\'
      tcl_cmds['pre_synth'].append(vivado_cmd.format('ADC{:d}_En'.format(tidx+224), (tidx in self.enabled_tiles)))

    # add configuration parameters for enabled tiles and adcs
    for tidx in self.enabled_tiles:
      t = self.tiles[tidx]
      tcl_cmds['pre_synth'] += self.build_config_cmd(t, self.tile_attr_map, tidx)

      for aidx in self.enabled_adcs:
        a = self.adcs[aidx]
        tcl_cmds['pre_synth'] += self.build_config_cmd(a, self.adc_attr_map, tidx, aidx)

    tcl_cmds['pre_synth'] += ['] [get_ips rfdc]']
    # generate output products
    tcl_cmds['pre_synth'] += ['generate_target all [get_ips rfdc]']
    tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']

    return tcl_cmds

  def build_config_cmd(self, cls_object, attr_map, *tile_slice_fmt):
    """
    cls_object : object containing attributes to target vivado parameter
    attr_map : dictionary mapping the `cls_object` attributes to their vivado equivalent
    tile_slice_fmt : variable input targeting the tile and slice formatter fields of the vivado parameter
    """
    vivado_cmd = 'CONFIG.{:s} {{{}}} \\'
    cmds = []
    for attr, vivado_param in iteritems(attr_map):
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
        # lower() to force boolean to become lowercase, a NOP for numeric values, would
        # cause problem for vivado params that are neither bool or numeric
        cmds.append(vivado_cmd.format(full_param, fmt).format(v).lower())

    return cmds

