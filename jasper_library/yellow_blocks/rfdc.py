
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
    def __init__(self, gen):
        self.digital_output_value_map = { 'Real' : 0, 'I/Q'  : 1 }

        self.mixer_mode_value_map = {
          'Real -> Real' : 2,
          'I/Q -> I/Q'   : 1,
          'Real -> I/Q'  : 0
        }

        self.mixer_type_value_map = {
          'Bypassed' : 1,
          'Coarse'   : 1,
          'Fine'     : 2,
          'Off'      : 3
        }
        if gen < 2:
          # For the gen 1 28dr/29dr this had to be 0, whereas gen3 requires it to be one. Not sure if this is a vivado bug. But most
          # likely an implementnation detail within the IP core.
          self.mixer_type_value_map['Bypassed'] = 0

        # dec_mode_value_map = lambda d: d[0] # could use `callable()` to provide more capability to prepare
        # arguments if needed for both values and vivado parameter formatting
        self.dec_mode_value_map = {
          '1x'  : 1,
          '2x'  : 2,
          '3x'  : 3,
          '4x'  : 4,
          '5x'  : 5,
          '6x'  : 6,
          '8x'  : 8,
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
    # current support configures all adcs to be the same in each enabled tiles. Future support
    # would extend each tile to have its own set of adc objects allowing for different cross
    # tile configuration
    self.adcs          = []

    self.typecode = TYPECODE_RFDC

    # TODO: sources for mts and other
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

      # validate platform user clk against expected core axi stream clk
      print("platform clk rate={:.3f}, rfdc clk={:.3f}".format(self.platform.user_clk_rate, t.axi_stream_clk))
      if (t.axi_stream_clk != self.platform.user_clk_rate):
        s = '\n\n'
        s += 'ERROR: expected rfdc core axi stream clock rate {:.3f} MHz does not match platform selected clock\n'
        s += 'rate of {:.3f} MHz.\n'
        s = s.format(t.axi_stream_clk, self.platform.user_clk_rate)
        self.throw_error(s)

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
      a = self.adc_slice(self.gen)
      for adc_attr, _ in iteritems(self.adc_attr_map):
        attr_key = adc_mask_fmt.format(self.tile_arch, aidx, adc_attr)
        if attr_key in self.blk:
          setattr(a, adc_attr, self.blk[attr_key])
      self.adcs.append(a)

    self.enable_mts = self.blk['enable_mts']

    # validate tile clocking distribution
    if (False in [(t.clk_src in self.enabled_tiles) for t in self.tiles]):
      s = '\n\n'
      s+="ERROR: clocking distribution is inconsistent\n"
      s+=("expected source tiles: " + (4*"{:3d} ").format(*[t.clk_src+224 for t in self.tiles]) + '\n')
      s+=("enabled tiles: " + (len(self.enabled_tiles)*"{:3d} ").format(*[t+224 for t in self.enabled_tiles]) + '\n')
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
    # Note: rfdc axi4lite managed within block design on seperate mpsoc master interface. This has the downside of not exposing it to the
    # casper axi lite interconnect that ultimately adds the rfdc memory map to the core info table. In general though, the RFDC is more
    # managed by the xrfdc c driver than through direct memory map access that seemed to justify this being OK. However, granted there are
    # somethings that are easier with raw register access than using a c implementation. Specficially when it comes to providing casperfpga
    # support.

    # Given the above this can be changed and there is a way to again add the RFDC to the CASPER axi4lite memory map Through the established
    # toolflow. To do this would be implemented in the gen_tcl section by adding a port that we will expect to hook into from the casper
    # axi4lite interface. However, I am interested in additionally knowing about how core info tab is made and the ability for yellow blocks
    # to add info directly rather than the what seems to be 'catch all' implementation where the single axi4lite interface observes
    # everything added to it and then does its thing at the very end.
    #top.add_axi4lite_interface(regname="RFDC", mode='rw', nbytes=4, typecode=self.typecode, axi4lite_mode='raw') #self.unique_name

    # instantiate rfdc
    #rfdc_inst = top.get_instance('rfdc', 'rfdc_inst')

    # get block design reference from platform info to be able to add rfdc relevant ports
    blkdesign = '{:s}_base'.format(self.platform.conf['name'])
    bd_inst = top.get_instance(blkdesign, '{:s}_inst'.format(blkdesign))

    bd_inst.add_port('irq', 'rfdc_irq') #self.fullname+'_irq'

    # TODO: pins most likely need to be added in platform files for sysref
    bd_inst.add_port('sysref_in_p', 'sysref_in_p', dir='in', parent_port=True) #self.fullname+'_sysref_in_p',
    bd_inst.add_port('sysref_in_n', 'sysref_in_n', dir='in', parent_port=True) #self.fullname+'_sysref_in_n',

    if self.enable_mts:
      # TODO: add instance of PL capture synchronizer, get port name correct
      bd_inst.add_port('user_adc_sysref', 'user_adc_sysref', dir='in')

    # generate tile/slice interface ports
    for tidx in self.enabled_tiles:
      # maxis clk, reset and output clock (when using mts, this output clock is not typically used)
      bd_inst.add_port('m{:d}_axis_aclk'.format(tidx), 'm{:d}_axis_aclk'.format(tidx))       #self.fullname+'_m0_axis_aclk'
      bd_inst.add_port('m{:d}_axis_aresetn'.format(tidx), 'axil_rst_n') #'m{:d}_axis_aresetn'.format(tidx)) #self.fullname+'_m0_axis_aresetn'
      bd_inst.add_port('clk_adc{:d}'.format(tidx), 'clk_adc{:d}'.format(tidx), dir='out') #self.fullname+'_clk_adc0'

      # wire these ports to supporting infrastructure
      top.assign_signal('m{:d}_axis_aclk'.format(tidx), 'adc_clk')

      # For now tile source information comes from the board platform file configuration, later support could extend this to get
      # information from simulink, but the platform would need to support it (current gen3 xilinx eval boards don't for example)
      if (self.rfdc_conf['tile{:d}'.format(tidx+224)]['adc_clk_src'] == tidx):
      #if (self.tilestidx].clk_src == tidx):
        bd_inst.add_port('adc{:d}_clk_p'.format(tidx), 'adc{:d}_clk_p'.format(tidx), dir='in', parent_port=True)
        bd_inst.add_port('adc{:d}_clk_n'.format(tidx), 'adc{:d}_clk_n'.format(tidx), dir='in', parent_port=True)

      for aidx in self.enabled_adcs:
        # TODO: I vaguely remember we are OK here, but do need to make sure that between QT and DT architectures that the fact that
        # streams are split out on a seperate interface doesn't mess with the actual data width and needing to multiply by two anywhere...
        a = self.adcs[aidx]
        data_width = 16*self.adcs[aidx].sample_per_cycle
        if self.tile_arch == 'QT':
          # vin ports
          bd_inst.add_port('vin{:d}{:d}_p'.format(tidx, aidx), 'vin{:d}{:d}_p'.format(tidx, aidx),  dir='in', parent_port=True)
          bd_inst.add_port('vin{:d}{:d}_n'.format(tidx, aidx), 'vin{:d}{:d}_n'.format(tidx, aidx),  dir='in', parent_port=True)
          # maxis data ports
          bd_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, aidx), '{:s}_m{:d}{:d}_axis_tdata'.format(self.fullname, tidx, aidx), width=data_width)
          bd_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, aidx), "1'b1",)
          # TODO: tvalid currently not exposed in simulink rfdc yellow block, can be extended
          bd_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, aidx), 'm{:d}{:d}_axis_tvalid'.format(tidx, aidx))
        else: # Dual tile architecture
          # vin ports
          bd_inst.add_port('vin{:d}_{:d}{:d}_p'.format(tidx, 2*aidx, 2*aidx+1), 'vin{:d}_{:d}{:d}_p'.format(tidx, 2*aidx, 2*aidx+1), dir='in', parent_port=True)
          bd_inst.add_port('vin{:d}_{:d}{:d}_n'.format(tidx, 2*aidx, 2*aidx+1), 'vin{:d}_{:d}{:d}_n'.format(tidx, 2*aidx, 2*aidx+1), dir='in', parent_port=True)
          # maxis ports-dual architecture rfsocs the I/Q streams are output on seperate maxis interfaces needing different rules depending on the configuration
          if a.digital_output == 'Real':
            bd_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*aidx), '{:s}_m{:d}{:d}_axis_tdata'.format(self.fullname, tidx, 2*aidx), width=data_width)
            bd_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, 2*aidx), "1'b1",)
            # TODO: tvalid currently not exposed in simulink rfdc yellow block, can be extended
            bd_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*aidx), 'm{:d}{:d}_axis_tvalid'.format(tidx, aidx))
          else: # digital mode is I/Q
            if a.mixer_mode == 'Real -> I/Q':
              # I data
              bd_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*aidx),   '{:s}_m{:d}{:d}_axis_tdata'.format(self.fullname, tidx, 2*aidx), width=data_width)
              bd_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, 2*aidx), "1'b1",)
              # TODO: tvalid currently not exposed in simulink rfdc yellow block, can be extended
              bd_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*aidx), 'm{:d}{:d}_axis_tvalid'.format(tidx, aidx))
              # Q data
              bd_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*aidx+1), '{:s}_m{:d}{:d}_axis_tdata'.format(self.fullname, tidx, 2*aidx+1), width=data_width)
              bd_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, 2*aidx+1), "1'b1",)
              # TODO: tvalid currently not exposed in simulink rfdc yellow block, can be extended
              bd_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*aidx+1), 'm{:d}{:d}_axis_tvalid'.format(tidx, aidx))
            else: # mixer mode is 'I/Q -> I/Q'
              # in this case ADC 1 better be also set or we are in trouble so here we are assuming that the logic is correct and that
              # enabled adcs is both [0, 1] 
              bd_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, aidx), '{:s}_m{:d}{:d}_axis_tdata'.format(self.fullname, tidx, aidx), width=data_width)
              bd_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, aidx), "1'b1",)
              # TODO: tvalid currently not exposed in simulink rfdc yellow block, can be extended
              bd_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, aidx), 'm{:d}{:d}_axis_tvalid'.format(tidx, aidx))
          

  def gen_constraints(self):
    # The idea is that we do not need to add any sample clock, adc input pin constraints. Per PG269 (and some experience using the core) the
    # constraints are auto included and determined by the rfdc IP as part of the output products for the IP core. The only pins that I have
    # constrained in a user design are the pl_clk and pl_sysref and these should be provided by the infrastructure.
    #
    # Adding the constraints however won't hurt and would be more explicit, will not include, but may come back to include for transparency
    #cons.append(PortConstraint('vin00_p', 'vin00_p'))
    #cons.append(PortConstraint('vin00_n', 'vin00_n'))

    # TODO: will be needed with MTS
    #cons.append(PortConstraint('pl_sysref_p', 'pl_sysref_p'))
    cons = []

    return cons


  def gen_tcl_cmds(self):
    tcl_cmds = {}
    tcl_cmds['init'] = []

    tcl_cmds['pre_synth'] = []

    # get a reference to the rfdc in the block design, currently assume that only one rfdc is in the design (decent assumption)
    tcl_cmds['pre_synth'] = ['set rfdc [get_bd_cells -filter { NAME =~ *usp_rf_data_converter*}]']

    # rfdc block design instance  defaults with tile 224 and ADC 0 enabled -- disable everything as a starting point
    # TODO: how necessary is this, what may be causing some of my observed funny behavior may be casued by tile 0 being disabled. From PG269
    # and some testing disabling the cores does not have the expected behaviour as disabling the tile is not synonymous with "tile powerdown
    # per the UG" instead, power down is implemented as part of the software driver.
    tcl_cmds['pre_synth'] += ['set_property -dict [list \\']
    tcl_cmds['pre_synth'] += ['CONFIG.ADC224_En {false} \\']
    tcl_cmds['pre_synth'] += ['CONFIG.ADC_Slice00_Enable {false} \\']
    tcl_cmds['pre_synth'] += ['] [get_bd_cells $rfdc]']

    # begin to apply user configuration
    tcl_cmds['pre_synth'] += ['set_property -dict [list \\']

    # enable/disable tiles
    for tidx in range(0, 4):
      vivado_cmd = 'CONFIG.{:s} {{{}}} \\'
      tcl_cmds['pre_synth'].append(vivado_cmd.format('ADC{:d}_En'.format(tidx+224), 'true' if (tidx in self.enabled_tiles) else 'false'))
      tcl_cmds['pre_synth'].append(vivado_cmd.format('ADC{:d}_Enable'.format(tidx), (1     if (tidx in self.enabled_tiles) else 0)))

    # add configuration parameters for enabled tiles and adcs
    for tidx in self.enabled_tiles:
      t = self.tiles[tidx]
      tcl_cmds['pre_synth'] += self.build_config_cmd(t, self.tile_attr_map, tidx)

      for aidx in self.enabled_adcs:
        a = self.adcs[aidx]
        tcl_cmds['pre_synth'] += self.build_config_cmd(a, self.adc_attr_map, tidx, aidx)

    tcl_cmds['pre_synth'] += ['] [get_bd_cells $rfdc]']

    # create board interface ports for axis data/clk/reset pins and adc tile output clock for each enabled tile
    for tidx in self.enabled_tiles:
      t = self.tiles[tidx]
      # For now tile source information comes from the board platform file configuration, later support could extend this to get
      # information from simulink, but the platform would need to support it (current gen3 xilinx eval boards don't for example)
      if (self.rfdc_conf['tile{:d}'.format(tidx+224)]['adc_clk_src'] == tidx):
        # create port for input sample clock
        tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('adc{:d}_clk_n'.format(tidx), port_dir='in', port_type='clk', clk_freq_hz=t.ref_clk*1e6))
        tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('adc{:d}_clk_p'.format(tidx), port_dir='in', port_type='clk', clk_freq_hz=t.ref_clk*1e6))

      # create board design output ports for the enabled tile clocks
      tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('clk_adc{:d}'.format(tidx), port_dir='out', port_type='clk'))
      # create port for m_axis_aclk for each tile enabled
      tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}_axis_aclk'.format(tidx), port_dir='in', port_type='clk', clk_freq_hz=t.clk_out*1e6)) # clk out is mhz
      # create port for m_axis_aresetn for each tile enabled
      tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}_axis_aresetn'.format(tidx), port_dir='in', port_type='rst'))
      # create port vin and m_axis ports for each tile enable
      for aidx in self.enabled_adcs:
        a = self.adcs[aidx]
        data_width = 16*a.sample_per_cycle
        if self.tile_arch == 'QT':
          # vin ports
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vin{:d}{:d}_n'.format(tidx, aidx), port_dir='in'))
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vin{:d}{:d}_p'.format(tidx, aidx), port_dir='in'))
          # maxis
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tdata'.format(tidx, aidx), port_dir='out', width=data_width))
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tvalid'.format(tidx, aidx), port_dir='out'))
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tready'.format(tidx, aidx), port_dir='in'))
        else: # Dual tile architecture
          # vin ports
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vin{:d}_{:d}{:d}_n'.format(tidx, 2*aidx, 2*aidx+1), port_dir='in'))
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vin{:d}_{:d}{:d}_p'.format(tidx, 2*aidx, 2*aidx+1), port_dir='in'))
          # maxis ports-dual architecture rfsocs the I/Q streams are output on seperate maxis interfaces needing different rules depending on the configuration
          if a.digital_output == 'Real':
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*aidx), port_dir='out', width=data_width))
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*aidx), port_dir='out'))
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tready'.format(tidx, 2*aidx), port_dir='in'))
          else: # digital mode is I/Q
            if a.mixer_mode == 'Real -> I/Q':
              # I data
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*aidx), port_dir='out', width=data_width))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*aidx), port_dir='out'))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tready'.format(tidx, 2*aidx), port_dir='in'))
              # Q data
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*aidx+1), port_dir='out', width=data_width))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*aidx+1), port_dir='out'))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tready'.format(tidx, 2*aidx+1), port_dir='in'))
            else: # mixer mode is 'I/Q -> I/Q
              # in this case ADC 1 better be also set or we are in trouble so here we are assuming that the logic is correct and that
              # enabled adcs is both [0, 1] 
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tdata'.format(tidx, aidx), port_dir='out', width=data_width))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tvalid'.format(tidx, aidx), port_dir='out'))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tready'.format(tidx, aidx), port_dir='in'))

      # TODO: implement mts
      # if self.enable_mts:
      # TODO: also add ports for anything needed for PL capture synchronizer

    # create IRQ output port
    tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('irq', port_dir='out', port_type='intr'))

    tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('sysref_in_p', port_dir='in'))
    tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('sysref_in_n', port_dir='in'))

    return tcl_cmds


  def add_tcl_bd_port(self, name, port_dir, port_type=None, width=None, clk_freq_hz=None):
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

    s = ('create_bd_port {:s} {:s}\n'
         'connect_bd_net [get_bd_pins $rfdc/{:s}] [get_bd_ports {:s}]').format(opt_str, name, name, name)

    return s


  def build_config_cmd(self, cls_object, attr_map, *tile_slice_fmt):
    """
    cls_object     : object containing attributes to target vivado parameter
    attr_map       : dictionary mapping the `cls_object` attributes to their vivado equivalent
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
        # lower() to force boolean converted to string to become lowercase - probably a better way to get that done...
        if type(v) == bool:
          v = str(v).lower()
        cmds.append(vivado_cmd.format(full_param, fmt).format(v))

    return cmds


