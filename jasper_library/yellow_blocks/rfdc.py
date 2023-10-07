
from .yellow_block import YellowBlock
from .yellow_block_typecodes import TYPECODE_RFDC
from constraints import PortConstraint, ClockConstraint, RawConstraint

import os
import struct
from six import iteritems
import re

class rfdc(YellowBlock):
  # maps tile and adc attributes to vivado parameters
  adc_tile_attr_map = {
    # removed the enable object to be handled higher the class abstraction as this indexing [224-227] is incosistent with [0-3]
    #'enable'         : 'ADC{:d}_En',# ADC suffix {:d} is 224-227
    'sample_rate'    : {'param' : 'ADC{:d}_Sampling_Rate',   'fmt' : "{{:.5f}}"}, # ADC suffix {:d} is 0-3 # TODO: how many digits to add? was 3, upped to 5 for zcu111 tests
    'ref_clk'        : {'param' : 'ADC{:d}_Refclk_Freq',     'fmt' : "{{:.3f}}"},
    'clk_out'        : {'param' : 'ADC{:d}_Outclk_Freq',     'fmt' : "{{:.3f}}"},
    'axi_stream_clk' : {'param' : 'ADC{:d}_Fabric_Freq',     'fmt' : "{{:.3f}}"},
    'enable_pll'     : {'param' : 'ADC{:d}_PLL_Enable',      'fmt' : "{{}}"},
    'enable_mts'     : {'param' : 'ADC{:d}_Multi_Tile_Sync', 'fmt' : "{{}}"},
    'clk_dist'       : {'param' : 'ADC{:d}_Clock_Dist',      'fmt' : "{{:d}}"},
    'clk_src'        : {'param' : 'ADC{:d}_Clock_Source',    'fmt' : "{{:d}}"}
  }

  dac_tile_attr_map = {
    'sample_rate'    : {'param' : 'DAC{:d}_Sampling_Rate',   'fmt' : "{{:.5f}}"}, # DAC suffix {:d} is 0-3 # TODO: how many digits to add? was 3, upped to 5 for zcu111 tests
    'ref_clk'        : {'param' : 'DAC{:d}_Refclk_Freq',     'fmt' : "{{:.3f}}"},
    'clk_out'        : {'param' : 'DAC{:d}_Outclk_Freq',     'fmt' : "{{:.3f}}"},
    'axi_stream_clk' : {'param' : 'DAC{:d}_Fabric_Freq',     'fmt' : "{{:.3f}}"},
    'enable_pll'     : {'param' : 'DAC{:d}_PLL_Enable',      'fmt' : "{{}}"},
    'enable_mts'     : {'param' : 'DAC{:d}_Multi_Tile_Sync', 'fmt' : "{{}}"},
    'clk_dist'       : {'param' : 'DAC{:d}_Clock_Dist',      'fmt' : "{{:d}}"},
    'clk_src'        : {'param' : 'DAC{:d}_Clock_Source',    'fmt' : "{{:d}}"},
    'output_power'   : {'param' : 'DAC{:d}_VOP',             'fmt' : "{{:d}}"}
  }

  adc_attr_map = {
    'enable'          : {'param' : 'ADC_Slice{:d}{:d}_Enable',     'fmt' : "{{}}"},
    'digital_output'  : {'param' : 'ADC_Data_Type{:d}{:d}',        'fmt' : "{{:d}}"},
    'dec_mode'        : {'param' : 'ADC_Decimation_Mode{:d}{:d}',  'fmt' : "{{:d}}"},
    'sample_per_cycle': {'param' : 'ADC_Data_Width{:d}{:d}',       'fmt' : "{{:d}}"},
    'mixer_type'      : {'param' : 'ADC_Mixer_Type{:d}{:d}',       'fmt' : "{{:d}}"},
    'mixer_mode'      : {'param' : 'ADC_Mixer_Mode{:d}{:d}',       'fmt' : "{{:d}}"},
    'nco_freq'        : {'param' : 'ADC_NCO_Freq{:d}{:d}',         'fmt' : "{{:.5f}}"}, # ADC suffix {:d} is 0-3 # TODO: how many digits to add? was 3, upped to 5 for zcu111 tests
    'coarse_freq'     : {'param' : 'ADC_Coarse_Mixer_Freq{:d}{:d}','fmt' : "{{:d}}"},
    'nyquist_zone'    : {'param' : 'ADC_Nyquist{:d}{:d}',          'fmt' : "{{:d}}"},
    'cal_mode'        : {'param' : 'ADC_CalOpt_Mode{:d}{:d}',      'fmt' : "{{:d}}"}
  }

  dac_attr_map = {
    'enable'          : {'param' : 'DAC_Slice{:d}{:d}_Enable',        'fmt' : "{{}}"},
    'analog_output'   : {'param' : 'DAC_Data_Type{:d}{:d}',           'fmt' : "{{:d}}"},
    'inter_mode'      : {'param' : 'DAC_Interpolation_Mode{:d}{:d}',  'fmt' : "{{:d}}"},
    'sample_per_cycle': {'param' : 'DAC_Data_Width{:d}{:d}',          'fmt' : "{{:d}}"},
    'mixer_type'      : {'param' : 'DAC_Mixer_Type{:d}{:d}',          'fmt' : "{{:d}}"},
    'mixer_mode'      : {'param' : 'DAC_Mixer_Mode{:d}{:d}',          'fmt' : "{{:d}}"},
    'nco_freq'        : {'param' : 'DAC_NCO_Freq{:d}{:d}',            'fmt' : "{{:.5f}}"}, # DAC suffix {:d} is 0-3 # TODO: how many digits to add? was 3, upped to 5 for zcu111 tests
    'coarse_freq'     : {'param' : 'DAC_Coarse_Mixer_Freq{:d}{:d}',   'fmt' : "{{:d}}"},
    'nyquist_zone'    : {'param' : 'DAC_Nyquist{:d}{:d}',             'fmt' : "{{:d}}"},
    'decode_mode'     : {'param' : 'DAC_Decoder_Mode{:d}{:d}',        'fmt' : "{{:d}}"}
  }

  """
  rfdc tile and adc slice deserialized configuration containters
  """
  class tile(object):
    def __init__(self):
        self.clk_dist_value_map = {
          'PLL Output'   : 2,
          'Input Refclk' : 1,
          'None'         : 0
        }

  class adc_slice(object):
    def __init__(self, gen):
        self.digital_output_value_map = { 'Real' : 0, 'I/Q'  : 1 }

        self.mixer_mode_value_map = {
          'Real -> Real' : 2,
          'I/Q -> I/Q'   : 1,
          'Real -> I/Q'  : 0
        }

        self.mixer_type_value_map = {
          'Bypassed' : 1,  # is this correct?
          'Coarse'   : 1,
          'Fine'     : 2,
          'Off'      : 3,
          False      : 3   # python seems to think 'Off' means 'False' and it messed with this map
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

        self.coarse_freq_value_map = {'Fs/2' : 0, 'Fs/4' : 1, '-Fs/4' : 2, 0 : 3}
        self.nyquist_zone_value_map = { 'Zone 1' : 0, 'Zone 2' : 1}
        self.cal_mode_value_map = { 'Mode 1' : 0, 'Mode 2': 1} #, 'AutoCal' : 2}

  class  dac_slice(object):
    def __init__(self, gen):
        ### WARNING: These value maps haven't actually been verified
        self.analog_output_value_map = { 'Real' : 0, 'I/Q'  : 1 }

        self.mixer_mode_value_map = {
          'Real -> Real' : 2,
          'I/Q -> I/Q'   : 1,
          'I/Q -> Real'  : 0
        }

        self.mixer_type_value_map = {
          'Bypassed' : 1,
          'Coarse'   : 1,
          'Fine'     : 2,
          'Off'      : 3,
          False        : 0  # python seems to think 'Off' means 'False' and it messed with this map
        }
        if gen < 2:
          # For the gen 1 28dr/29dr this had to be 0, whereas gen3 requires it to be one. Not sure if this is a vivado bug. But most
          # likely an implementnation detail within the IP core.
          self.mixer_type_value_map['Bypassed'] = 0

        # inter_mode_value_map = lambda d: d[0] # could use `callable()` to provide more capability to prepare
        # arguments if needed for both values and vivado parameter formatting
        self.inter_mode_value_map = {
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

        self.coarse_freq_value_map  = { 'Fs/2' : 0, 'Fs/4' : 1, '-Fs/4' : 2, 0 : 3 }
        self.nyquist_zone_value_map = { 'Zone 1' : 0, 'Zone 2' : 1 }
        self.decode_mode_value_map  = { 'SNR Optimized' : 0, 'Linearity Optimized': 1 }

  def initialize(self):
    # IP generation and configuration parameters
    self.adc_tiles = None
    self.dac_tiles = None
    self.adc_tile_arch = None
    self.dac_tile_arch = None
    self.num_adc_slice = None
    self.num_dac_slice = None
    self.enabled_adc_tiles = []
    self.enabled_dac_tiles = []
    self.enabled_adcs  = []
    self.enabled_dacs  = []
    # the enabled adcs/dacs lits are indicies XY (e.g., '00', '02' representing the tile and slice within the tile
    # and are used to pull the corresponding `adc/dac_slice` from the list during yb configuration. Perhaps future work would
    # fully encapsulate the object oriented approach where each tile object was given a type and had its corresponding slices
    # list as part of the object
    self.tiles         = [] # tile() objects
    self.adcs          = [] # adc_slice() objects
    self.dacs          = [] # dac_slice() objects

    self.typecode = TYPECODE_RFDC

    self.rfdc_conf = self.platform.conf['rfdc']

    part = self.platform.conf['fpga']
    m = re.search('(2[8-9])|(39)|(4[8-9])', part)
    if not m:
      self.throw_error("ERROR: RFSoC part designator {} not recognized or is not yet supported".format(part))

    # first digit from part designator indicates part generation (e.g., xczu28dr is gen 1)
    designator = m.group(0)
    if designator[0] == '4':
      self.gen = 3
    elif designator[0] == '3':
      self.gen = 2
    elif designator[0] == '2':
      self.gen = 1

    if self.gen == 1:
      # second digit from part designator indicates RF tile architecture (e.g., xczu28dr is a Dual-Tile arch)
      if designator[1] == '8':
        self.adc_tiles = range(224, 228)
        self.adc_tile_arch = 'DT'
        self.num_adc_slice = 2
        self.dac_tiles = range(228,230)
        self.dac_tile_arch = 'QT'
        self.num_dac_slice = 4
      elif designator[1] == '9':
        self.adc_tiles = range(224, 228)
        self.adc_tile_arch = 'QT'
        self.num_adc_slice = 4
        self.dac_tiles = range(228, 232)
        self.dac_tile_arch = 'QT'
        self.num_dac_slice = 4
    elif self.gen == 2:
      raise NotImplemented
    elif self.gen == 3:
      if designator[1] == '8':
        self.adc_tiles = range(224, 228)
        self.adc_tile_arch = 'DT'
        self.num_adc_slice = 2
        self.dac_tiles = range(228, 232)
        self.dac_tile_arch = 'DT'
        self.num_dac_slice = 2
      elif designator[1] == '9':
        self.adc_tiles = range(224, 228)
        self.adc_tile_arch = 'QT'
        self.num_adc_slice = 4
        self.dac_tiles = range(228, 232)
        self.dac_tile_arch = 'QT'
        self.num_dac_slice = 4

    # build tile and adc slice objects for IP instantiation and configuration
    # determine enabled adc tiles
    for tidx in self.adc_tiles:
      if self.blk['Tile{:d}_enable'.format(tidx)]:
        print("adding Tile {:d} to enabled ADC tiles".format(tidx))
        self.enabled_adc_tiles.append(tidx-224)

    # determine enabled dac tiles
    for tidx in self.dac_tiles:
      if self.blk['Tile{:d}_enable'.format(tidx)]:
        print("adding Tile {:d} to enabled DAC tiles".format(tidx))
        self.enabled_dac_tiles.append(tidx-228)

    # build adc tile objects
    for tidx in self.adc_tiles:
      t = self.tile()
      t.enable = (tidx-224 in self.enabled_adc_tiles)

      for tile_attr, _ in iteritems(self.adc_tile_attr_map):
        tile_n_attr = 't{:d}_'.format(tidx) + tile_attr
        if tile_n_attr in self.blk:
          setattr(t, tile_attr, self.blk[tile_n_attr])
      if self.gen < 2:
        t.has_clk_src = self.rfdc_conf['tile{:d}'.format(tidx)]['has_adc_clk']
        t.clk_src     = self.rfdc_conf['tile{:d}'.format(tidx)]['adc_clk_src']
      else:
        t.has_clk_src = self.blk['t{:d}_has_adc_clk'.format(tidx)]
        t.clk_src     = self.blk['t{:d}_adc_clk_src'.format(tidx)] - 224

      # TODO: enable all tile PLLs and forward low freq reference or enable PLL for source tile
      # and distribute the output of the PLL
      # This seems to give the most heartache code compatability between gen1+2 and gen3 devices.
      # Right now this implementation would be compatible and treat both gen1+2 and gen3 devices
      # with similar capability. That the reference clock is input to the tile RF-PLL and out as
      # sample clk
      #if (t.clk_src == tidx-224):
      #  t.clk_dist = 1 # distribute: input reference clock
      #else:
      #  t.clk_dist = 0 # distribute: off

      # validate platform user clk against expected core axi stream clk
      if self.blk['Tile{:d}_enable'.format(tidx)]:
        print("platform clk rate={:.3f}, rfdc clk={:.3f}".format(self.platform.user_clk_rate, t.axi_stream_clk))
        if (t.axi_stream_clk != self.platform.user_clk_rate):
          s = '\n\n'
          s += 'ERROR: expected rfdc core axi stream clock rate {:.3f} MHz on tile {:d} does not match platform selected clock\n'
          s += 'rate of {:.3f} MHz.\n'
          s = s.format(t.axi_stream_clk, tidx, self.platform.user_clk_rate)
          self.throw_error(s)

      self.tiles.append(t)

    # build dac tile objects
    for tidx in self.dac_tiles:
      t = self.tile()
      t.enable = (tidx-228 in self.enabled_dac_tiles)

      for tile_attr, _ in iteritems(self.dac_tile_attr_map):
        tile_n_attr = 't{:d}_'.format(tidx) + tile_attr
        if tile_n_attr in self.blk:
          setattr(t, tile_attr, self.blk[tile_n_attr])
      if self.gen < 2 : # load clk source stuff from yaml, these aren't configurabe for gen 1 systems
        print("grabbing data from yaml, this is a gen 1 part")
        t.has_clk_src = self.rfdc_conf['tile{:d}'.format(tidx)]['has_dac_clk']
        t.clk_src     = self.rfdc_conf['tile{:d}'.format(tidx)]['dac_clk_src']
      else: # Not gen 1 part, load clk source stuff from block
        t.has_clk_src = self.blk['t{:d}_has_dac_clk'.format(tidx)]
        t.clk_src     = self.blk['t{:d}_dac_clk_src'.format(tidx)] - 224

      # TODO: enable all tile PLLs and forward low freq reference or enable PLL for source tile
      # and distribute the output of the PLL
      # This seems to give the most heartache code compatability between gen1+2 and gen3 devices.
      # Right now this implementation would be compatible and treat both gen1+2 and gen3 devices
      # with similar capability. That the reference clock is input to the tile RF-PLL and out as
      # sample clk
      #if (t.clk_src == tidx-224):
      #  t.clk_dist = 1 # distribute: input reference clock
      #else:
      #  t.clk_dist = 0 # distribute: off

      # validate platform user clk against expected core axi stream clk
      if self.blk['Tile{:d}_enable'.format(tidx)]:
        print("platform clk rate={:.3f}, rfdc clk={:.3f}".format(self.platform.user_clk_rate, t.axi_stream_clk))
        if (t.axi_stream_clk != self.platform.user_clk_rate):
          s = '\n\n'
          s += 'ERROR: expected rfdc core axi stream clock rate {:.3f} MHz on tile {:d} does not match platform selected clock\n'
          s += 'rate of {:.3f} MHz.\n'
          s = s.format(t.axi_stream_clk, tidx, self.platform.user_clk_rate)
          self.throw_error(s)

      self.tiles.append(t)

    # simulink mask asks for sample rate in Msps (liked it better) convert here to units of Gsps to hand to
    # vivado IP configuration (alternative is to edit mask and mask scripts to compute/display in Gsps)
    for tile in self.tiles:
      tile.sample_rate = tile.sample_rate/1000

    for tidx in self.enabled_adc_tiles:
      # determine enabled adcs
      for aidx in range(0, self.num_adc_slice):
        if self.blk['t{:d}_{:s}_adc{:d}_enable'.format(tidx+224, self.adc_tile_arch, aidx)]:
          print("adding Slice {:d} to ADC tile {:d}".format(aidx, tidx+224))
          self.enabled_adcs.append(str(tidx)+str(aidx))

    for tidx in self.adc_tiles:
      # build adc objects
      adc_mask_fmt = 't{:d}_{:s}_adc{:d}_{:s}'
      for aidx in range(0, self.num_adc_slice):
        a = self.adc_slice(self.gen)
        for adc_attr, _ in iteritems(self.adc_attr_map):
          attr_key = adc_mask_fmt.format(tidx, self.adc_tile_arch, aidx, adc_attr)
          if attr_key in self.blk:
            setattr(a, adc_attr, self.blk[attr_key])

        self.adcs.append(a)

    for tidx in self.enabled_dac_tiles:
      # determine enabled dacs
      for didx in range(0, self.num_dac_slice):
        if self.blk['t{:d}_{:s}_dac{:d}_enable'.format(tidx+228, self.dac_tile_arch, didx)]:
          print("adding Slice {:d} to DAC tile {:d}".format(didx, tidx+228))
          self.enabled_dacs.append(str(tidx)+str(didx))

    for tidx in self.dac_tiles:
      # build dac objects
      dac_mask_fmt = 't{:d}_{:s}_dac{:d}_{:s}'
      for didx in range(0, self.num_dac_slice):
        d = self.dac_slice(self.gen)
        for dac_attr, _ in iteritems(self.dac_attr_map):
          attr_key = dac_mask_fmt.format(tidx, self.dac_tile_arch, didx, dac_attr)
          if attr_key in self.blk:
            setattr(d, dac_attr, self.blk[attr_key])

        self.dacs.append(d)

    """
    how do we now handle clock distribution validation? should/will it be in the mask now?
    """
    # # validate tile clocking distribution
    # if (False in [(t.clk_src in self.enabled_adc_tiles) for t in self.tiles]):
    #   s = '\n\n'
    #   s+="ERROR: clocking distribution is inconsistent\n"
    #   s+=("expected source tiles: " + (4*"{:3d} ").format(*[t.clk_src+224 for t in self.tiles]) + '\n')
    #   s+=("enabled tiles: " + (len(self.enabled_adc_tiles)*"{:3d} ").format(*[t+224 for t in self.enabled_adc_tiles]) + '\n')
    #   self.throw_error(s)

    # finish setting up yellow block
    self.requires.append('axil_clk')
    self.requires.append('axil_rst_n')
    self.requires.append('sysref_in')

    # master adc tile is 224, master dac tile is 228, validation of mts configuration done in simulink mask
    self.enable_mts_adc = self.blk['t224_enable_mts']
    self.enable_mts_dac = self.blk['t228_enable_mts']

    if self.enable_mts_adc or self.enable_mts_dac:
      self.add_source('infrastructure/mts_pl_sysref_sync.sv')
      self.requires.append('pl_sysref')

    for a in self.enabled_adcs:
      # TODO: should these be renamed to something like "rfdc_clkX", since "adc_clk" is a dominant name else where in the toolflow
      self.provides.append('adc_clk{:s}'.format(a[0]))


  def modify_top(self, top):
    # instantiate rfdc
    #rfdc_inst = top.get_instance('rfdc', 'rfdc_inst')

    # get block design reference from platform info to be able to add rfdc relevant ports
    blkdesign = '{:s}_bd'.format(self.platform.conf['name'])
    bd_inst = top.get_instance(blkdesign, '{:s}_inst'.format(blkdesign))

    top.add_axi4lite_interface(regname="rfdc", mode='rw', nbytes=0x40000, typecode=self.typecode, axi4lite_mode='raw') #self.unique_name
    # TODO: remove this, explain current approach (second paragraph) and that we can revert -- also mention that `regname` needs to match
    # the signals `bd_inst` ports added, or breaks... this seems to be a flaw in our axi4lite apparoach
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

    bd_inst.add_port('rfdc_awaddr',  'm_axi4lite_rfdc_awaddr', width=32)
    bd_inst.add_port('rfdc_awvalid', 'm_axi4lite_rfdc_awvalid')
    bd_inst.add_port('rfdc_awready', 'm_axi4lite_rfdc_awready')
    bd_inst.add_port('rfdc_wdata',   'm_axi4lite_rfdc_wdata', width=32)
    bd_inst.add_port('rfdc_wstrb',   'm_axi4lite_rfdc_wstrb', width=4)
    bd_inst.add_port('rfdc_wvalid',  'm_axi4lite_rfdc_wvalid')
    bd_inst.add_port('rfdc_wready',  'm_axi4lite_rfdc_wready')
    bd_inst.add_port('rfdc_bresp',   'm_axi4lite_rfdc_bresp', width=2)
    bd_inst.add_port('rfdc_bvalid',  'm_axi4lite_rfdc_bvalid')
    bd_inst.add_port('rfdc_bready',  'm_axi4lite_rfdc_bready')
    bd_inst.add_port('rfdc_araddr',  'm_axi4lite_rfdc_araddr', width=32)
    bd_inst.add_port('rfdc_arvalid', 'm_axi4lite_rfdc_arvalid')
    bd_inst.add_port('rfdc_arready', 'm_axi4lite_rfdc_arready')
    bd_inst.add_port('rfdc_rdata',   'm_axi4lite_rfdc_rdata', width=32)
    bd_inst.add_port('rfdc_rresp',   'm_axi4lite_rfdc_rresp', width=2)
    bd_inst.add_port('rfdc_rvalid',  'm_axi4lite_rfdc_rvalid')
    bd_inst.add_port('rfdc_rready',  'm_axi4lite_rfdc_rready')

    bd_inst.add_port('irq', 'rfdc_irq') #self.fullname+'_irq'

    bd_inst.add_port('sysref_in_p', 'sysref_in_p', dir='in', parent_port=True)
    bd_inst.add_port('sysref_in_n', 'sysref_in_n', dir='in', parent_port=True)

    bd_inst.add_port('s_axi_aclk', 'axil_clk')
    bd_inst.add_port('s_axi_aresetn', 'axil_rst_n')

    if self.enable_mts_adc or self.enable_mts_dac:
      # instance mts cdc synchronization module
      mts_inst = top.get_instance('mts_pl_sysref_sync', 'mts_pl_sysref_sync_inst')
      mts_inst.add_parameter('SYNC_FFS', 2)
      mts_inst.add_port('pl_sysref_p', 'pl_sysref_p', dir='in', parent_port=True)
      mts_inst.add_port('pl_sysref_n', 'pl_sysref_n', dir='in', parent_port=True)
      mts_inst.add_port('pl_clk', 'user_clk')
      if self.enable_mts_adc:
        mts_inst.add_port('user_sysref_adc', 'user_sysref_adc')
        # add port to pass to board design
        bd_inst.add_port('user_sysref_adc', 'user_sysref_adc', dir='in')
      else:
        mts_inst.add_port('user_sysref_adc', '')
      # TODO: add DAC MTS support
      # if self.enable_mts_dac:
      #   mts_inst.add_port('user_sysref_dac', 'user_sysref_dac')
      #   # add port to pass to board design
      #   bd_inst.add_port('user_sysref_dac', 'user_sysref_dac', dir='in')
      # else:
      #   mts_inst.add_port('user_sysref_dac', '')

    """
    adc tile/slice interfaces
    """
    for tidx in self.enabled_adc_tiles:
      # maxis clk, reset and output clock (when using mts, this output clock is not typically used)
      bd_inst.add_port('m{:d}_axis_aclk'.format(tidx), 'm{:d}_axis_aclk'.format(tidx))       #self.fullname+'_m0_axis_aclk'
      bd_inst.add_port('m{:d}_axis_aresetn'.format(tidx), 'axil_rst_n') #'m{:d}_axis_aresetn'.format(tidx)) #self.fullname+'_m0_axis_aresetn'
      bd_inst.add_port('clk_adc{:d}'.format(tidx), 'clk_adc{:d}'.format(tidx), dir='out') #self.fullname+'_clk_adc0'

      # wire these ports to supporting infrastructure
      top.assign_signal('m{:d}_axis_aclk'.format(tidx), 'adc_clk')

      #Tile source information from simulink
      if self.gen > 1:
        if (self.blk['t{:d}_adc_clk_src'.format(tidx+224)]-224 == tidx):
          bd_inst.add_port('adc{:d}_clk_p'.format(tidx), 'adc{:d}_clk_p'.format(tidx), dir='in', parent_port=True)
          bd_inst.add_port('adc{:d}_clk_n'.format(tidx), 'adc{:d}_clk_n'.format(tidx), dir='in', parent_port=True)
      else:
        if (self.rfdc_conf['tile{:d}'.format(tidx+224)]['adc_clk_src'] == tidx):
          bd_inst.add_port('adc{:d}_clk_p'.format(tidx), 'adc{:d}_clk_p'.format(tidx), dir='in', parent_port=True)
          bd_inst.add_port('adc{:d}_clk_n'.format(tidx), 'adc{:d}_clk_n'.format(tidx), dir='in', parent_port=True)

      for aidx in self.enabled_adcs:
        if int(aidx[0]) == tidx: # need this becuase enabled_adcs stores ALL enabled slices across all adc tiles, we only want the adcs associated with this tile
          n_aidx = int(aidx[1])

          if self.adc_tile_arch == 'QT':
            a = self.adcs[n_aidx+4*int(aidx[0])] # 4 adc slices for each QT tile
            data_width = 16*a.sample_per_cycle
            # vin ports
            bd_inst.add_port('vin{:d}{:d}_p'.format(tidx, n_aidx), 'vin{:d}{:d}_p'.format(tidx, n_aidx),  dir='in', parent_port=True)
            bd_inst.add_port('vin{:d}{:d}_n'.format(tidx, n_aidx), 'vin{:d}{:d}_n'.format(tidx, n_aidx),  dir='in', parent_port=True)
            # maxis data ports
            if a.mixer_type != 'Off' and a.mixer_type != False: #only add slices that aren't odd and in a IQ->IQ config
              bd_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, n_aidx), '{:s}_m{:d}{:d}_axis_tdata'.format(self.fullname, tidx, n_aidx), width=data_width)
              bd_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, n_aidx), "1'b1",)
              bd_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, n_aidx), 'm{:d}{:d}_axis_tvalid'.format(tidx, n_aidx))
          else: # Dual tile architecture
            a = self.adcs[n_aidx+2*int(aidx[0])] # 2 adc slices for each DT tile
            data_width = 16*a.sample_per_cycle
            # vin ports
            bd_inst.add_port('vin{:d}_{:d}{:d}_p'.format(tidx, 2*n_aidx, 2*n_aidx+1), 'vin{:d}_{:d}{:d}_p'.format(tidx, 2*n_aidx, 2*n_aidx+1), dir='in', parent_port=True)
            bd_inst.add_port('vin{:d}_{:d}{:d}_n'.format(tidx, 2*n_aidx, 2*n_aidx+1), 'vin{:d}_{:d}{:d}_n'.format(tidx, 2*n_aidx, 2*n_aidx+1), dir='in', parent_port=True)
            # maxis ports-dual architecture rfsocs the I/Q streams are output on seperate maxis interfaces needing different rules depending on the configuration
            if a.digital_output == 'Real':
              bd_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*n_aidx), '{:s}_m{:d}{:d}_axis_tdata'.format(self.fullname, tidx, 2*n_aidx), width=data_width)
              bd_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, 2*n_aidx), "1'b1",)
              bd_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*n_aidx), 'm{:d}{:d}_axis_tvalid'.format(tidx, n_aidx))
            else: # digital mode is I/Q
              if a.mixer_mode == 'Real -> I/Q':
                # I data
                bd_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*n_aidx),   '{:s}_m{:d}{:d}_axis_tdata'.format(self.fullname, tidx, 2*n_aidx), width=data_width)
                bd_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, 2*n_aidx), "1'b1",)
                bd_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*n_aidx), 'm{:d}{:d}_axis_tvalid'.format(tidx, n_aidx))
                # Q data
                bd_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*n_aidx+1), '{:s}_m{:d}{:d}_axis_tdata'.format(self.fullname, tidx, 2*n_aidx+1), width=data_width)
                bd_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, 2*n_aidx+1), "1'b1",)
                bd_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*n_aidx+1), 'm{:d}{:d}_axis_tvalid'.format(tidx, n_aidx))
              else: # mixer mode is 'I/Q -> I/Q'
                # in this case ADC 1 better be also set or we are in trouble so here we are assuming that the logic is correct and that
                # enabled adcs is both [0, 1]
                bd_inst.add_port('m{:d}{:d}_axis_tdata'.format(tidx, n_aidx), '{:s}_m{:d}{:d}_axis_tdata'.format(self.fullname, tidx, n_aidx), width=data_width)
                bd_inst.add_port('m{:d}{:d}_axis_tready'.format(tidx, n_aidx), "1'b1",)
                bd_inst.add_port('m{:d}{:d}_axis_tvalid'.format(tidx, n_aidx), 'm{:d}{:d}_axis_tvalid'.format(tidx, n_aidx))

    """
    dac tile/slice interfaces
    """
    for tidx in self.enabled_dac_tiles:
      # maxis clk, reset and output clock (when using mts, this output clock is not typically used)
      bd_inst.add_port('s{:d}_axis_aclk'.format(tidx), 's{:d}_axis_aclk'.format(tidx))       #self.fullname+'_m0_axis_aclk'
      bd_inst.add_port('s{:d}_axis_aresetn'.format(tidx), 'axil_rst_n') #'m{:d}_axis_aresetn'.format(tidx)) #self.fullname+'_m0_axis_aresetn'
      bd_inst.add_port('clk_dac{:d}'.format(tidx), 'clk_dac{:d}'.format(tidx), dir='out') #self.fullname+'_clk_adc0'

      # wire these ports to supporting infrastructure
      top.assign_signal('s{:d}_axis_aclk'.format(tidx), 'adc_clk')

      # gen3 parts support clock forwarding, user provides information about provided clock to the board sources in simulink mask (e.g.,
      # current gen3 xilinx eval boards only have clocks coming to 2 adc and 2 dac tiles, requiring clocks to be forwarded)
      if self.gen > 1:
        if (self.blk['t{:d}_dac_clk_src'.format(tidx+228)]-224 == tidx+4):
          bd_inst.add_port('dac{:d}_clk_p'.format(tidx), 'dac{:d}_clk_p'.format(tidx), dir='in', parent_port=True)
          bd_inst.add_port('dac{:d}_clk_n'.format(tidx), 'dac{:d}_clk_n'.format(tidx), dir='in', parent_port=True)
      else:
        print("checking for need to add clock p and n for dac{:d}".format(tidx))
        if (self.rfdc_conf['tile{:d}'.format(tidx+228)]['dac_clk_src'] == tidx+4):
          print("adding clock p and n for dac{:d}".format(tidx))
          bd_inst.add_port('dac{:d}_clk_p'.format(tidx), 'dac{:d}_clk_p'.format(tidx), dir='in', parent_port=True)
          bd_inst.add_port('dac{:d}_clk_n'.format(tidx), 'dac{:d}_clk_n'.format(tidx), dir='in', parent_port=True)

      for didx in self.enabled_dacs:
        if int(didx[0]) == tidx: # need this becuase enabled_dacs stores ALL enabled slices across all dac tiles, we only want the dacs associated with this tile
          n_didx = int(didx[1])

          if self.dac_tile_arch == 'QT':
            print("adding vin and axis ports for DAC Tile {:d} Slice {:d}".format(int(didx[0]), int(didx[1])))
            d = self.dacs[n_didx+4*int(didx[0])] # 4 dac slices for each QT tile
            data_width = 16*d.sample_per_cycle
            # vout ports
            bd_inst.add_port('vout{:s}_p'.format(didx), 'vout{:s}_p'.format(didx),  dir='out', parent_port=True)
            bd_inst.add_port('vout{:s}_n'.format(didx), 'vout{:s}_n'.format(didx),  dir='out', parent_port=True)
            # maxis data ports
            if d.mixer_type != 'Off' and d.mixer_type != False: #only add slices that aren't odd and in a IQ->IQ config
              bd_inst.add_port('s{:s}_axis_tdata'.format(didx), '{:s}_s{:s}_axis_tdata'.format(self.fullname, didx), width=data_width)
              bd_inst.add_port('s{:s}_axis_tready'.format(didx), "1'b1",)
              bd_inst.add_port('s{:s}_axis_tvalid'.format(didx), 's{:s}_axis_tvalid'.format(didx))
          else: # Dual tile architecture
            d = self.dacs[n_didx+2*int(didx[0])] # 2 dac slices for each QT tile
            data_width = 16*d.sample_per_cycle
            # vin ports
            # n_didx = int(didx[1])
            bd_inst.add_port('vout{:s}_p'.format(didx), 'vout{:s}_p'.format(didx),  dir='out', parent_port=True)
            bd_inst.add_port('vout{:s}_n'.format(didx), 'vout{:s}_n'.format(didx),  dir='out', parent_port=True)
            # maxis ports-dual architecture rfsocs the I/Q streams are output on seperate maxis interfaces needing different rules depending on the configuration
            if d.analog_output == 'Real':
              # no difference between Real -> Real and I/Q -> Real
              bd_inst.add_port('s{:d}{:d}_axis_tdata'.format(tidx, n_didx), '{:s}_s{:d}{:d}_axis_tdata'.format(self.fullname, tidx, n_didx), width=data_width)
              bd_inst.add_port('s{:d}{:d}_axis_tready'.format(tidx, n_didx), "1'b1",)
              bd_inst.add_port('s{:d}{:d}_axis_tvalid'.format(tidx, n_didx), 's{:d}{:d}_axis_tvalid'.format(tidx, n_didx))
            else: # analog mode is I/Q
              # mixer mode is 'I/Q -> I/Q'
              # enabled adcs is both [0, 1]
              if d.mixer_type != 'Off' and d.mixer_type != False: #only add the even slices for s_axis ports
                bd_inst.add_port('s{:d}{:d}_axis_tdata'.format(tidx, n_didx), '{:s}_s{:d}{:d}_axis_tdata'.format(self.fullname, tidx, n_didx), width=data_width)
                bd_inst.add_port('s{:d}{:d}_axis_tready'.format(tidx, n_didx), "1'b1",)
                bd_inst.add_port('s{:d}{:d}_axis_tvalid'.format(tidx, n_didx), 's{:d}{:d}_axis_tvalid'.format(tidx, n_didx))


  def gen_constraints(self):
    # The idea is that we do not need to add any sample clock, adc input pin constraints. Per PG269 (and some experience using the core) the
    # constraints are auto included and determined by the rfdc IP as part of the output products for the IP core. The only pins that I have
    # constrained in a user design are the pl_clk and pl_sysref and these should be provided by the infrastructure.
    #
    # Adding the constraints however won't hurt and would be more explicit, will not include, but may come back to include for transparency
    #cons.append(PortConstraint('vin00_p', 'vin00_p'))
    #cons.append(PortConstraint('vin00_n', 'vin00_n'))

    const = []
    const.append(PortConstraint('pl_sysref_p', 'pl_sysref_p'))
    # TODO: designs do not generally need to add a clock constraint for the pl_sysref, but never hurts
    #const.append(ClockConstraint('pl_sysref_p', 'pl_sysref_p', period=self.T_pl_sysref_ns, port_en=True, virtual_en=False))

    return const


  def gen_tcl_cmds(self):
    tcl_cmds = {}
    tcl_cmds['init'] = []

    tcl_cmds['pre_synth'] = []

    # place the rfdc
    rfdc_bd_name = 'usp_rf_data_converter_0'#rfdc'
    # the '*' imports the latest version of the IP, there should only exist a single rfdc version
    tcl_cmds['pre_synth'] += ['create_bd_cell -type ip -vlnv xilinx.com:ip:usp_rf_data_converter:* {:s}'.format(rfdc_bd_name)]

    # get a reference to the rfdc in the block design, currently assume that only one rfdc is in the design (decent assumption)
    tcl_cmds['pre_synth'] += ['set rfdc [get_bd_cells -filter { NAME =~ *usp_rf_data_converter*}]']

    # create bd s axi intf port
    s_axi_ifport = 'RFDC'
    tcl_cmds['pre_synth'] += ['create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 {:s}'.format(s_axi_ifport)]

    # configures the interface port, will auto inherit everything from the rfdc connection
    tcl_cmds['pre_synth'] += ['set_property -dict [list \\']
    tcl_cmds['pre_synth'] += ['CONFIG.PROTOCOL [get_property CONFIG.PROTOCOL [get_bd_intf_pins $rfdc/s_axi]] \\']
    tcl_cmds['pre_synth'] += ['CONFIG.ADDR_WIDTH [get_property CONFIG.ADDR_WIDTH [get_bd_intf_pins $rfdc/s_axi]] \\']
    tcl_cmds['pre_synth'] += ['CONFIG.HAS_BURST [get_property CONFIG.HAS_BURST [get_bd_intf_pins $rfdc/s_axi]] \\']
    tcl_cmds['pre_synth'] += ['CONFIG.HAS_LOCK [get_property CONFIG.HAS_LOCK [get_bd_intf_pins $rfdc/s_axi]] \\']
    tcl_cmds['pre_synth'] += ['CONFIG.HAS_PROT [get_property CONFIG.HAS_PROT [get_bd_intf_pins $rfdc/s_axi]] \\']
    tcl_cmds['pre_synth'] += ['CONFIG.HAS_CACHE [get_property CONFIG.HAS_CACHE [get_bd_intf_pins $rfdc/s_axi]] \\']
    tcl_cmds['pre_synth'] += ['CONFIG.HAS_QOS [get_property CONFIG.HAS_QOS [get_bd_intf_pins $rfdc/s_axi]] \\']
    tcl_cmds['pre_synth'] += ['CONFIG.HAS_REGION [get_property CONFIG.HAS_REGION [get_bd_intf_pins $rfdc/s_axi]] \\']
    tcl_cmds['pre_synth'] += ['CONFIG.SUPPORTS_NARROW_BURST [get_property CONFIG.SUPPORTS_NARROW_BURST [get_bd_intf_pins $rfdc/s_axi]] \\']
    tcl_cmds['pre_synth'] += ['CONFIG.MAX_BURST_LENGTH [get_property CONFIG.MAX_BURST_LENGTH [get_bd_intf_pins $rfdc/s_axi]] \\']
    tcl_cmds['pre_synth'] += ['] [get_bd_intf_ports RFDC]']

    # but, we need to override the address width so we can assign an address in the range of the HMP0
    tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.ADDR_WIDTH {{40}}] [get_bd_intf_ports {:s}]'.format(s_axi_ifport)]
    # set the stupid clock requirment
    tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.FREQ_HZ {{99990001}}] [get_bd_intf_ports {:s}]'.format(s_axi_ifport)]

    # connect the rfdc up to the external port
    tcl_cmds['pre_synth'] += ['connect_bd_intf_net [get_bd_intf_pins $rfdc/s_axi] [get_bd_intf_ports {:s}]'.format(s_axi_ifport)]

    # add bd ports and connect for s axi clk/rst
    tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s_axi_aclk', port_dir='in', port_type='clk', clk_freq_hz=99990001))
    tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s_axi_aresetn', port_dir='in', port_type='rst'))

    # probably the better way to assign the address
    tcl_cmds['pre_synth'] += ['assign_bd_address -offset 0xA0000000 -range 256K [get_bd_addr_segs $rfdc/s_axi/Reg]']

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
      tcl_cmds['pre_synth'].append(vivado_cmd.format('ADC{:d}_En'.format(tidx+224), 'true' if (tidx in self.enabled_adc_tiles) else 'false'))
      tcl_cmds['pre_synth'].append(vivado_cmd.format('ADC{:d}_Enable'.format(tidx), (1     if (tidx in self.enabled_adc_tiles) else 0)))
      tcl_cmds['pre_synth'].append(vivado_cmd.format('DAC{:d}_En'.format(tidx+228), 'true' if (tidx in self.enabled_dac_tiles) else 'false'))
      tcl_cmds['pre_synth'].append(vivado_cmd.format('DAC{:d}_Enable'.format(tidx), (1     if (tidx in self.enabled_dac_tiles) else 0)))

    # add configuration parameters for enabled tiles and adcs
    for tidx in self.enabled_adc_tiles:
      t = self.tiles[tidx]
      tcl_cmds['pre_synth'] += self.build_config_cmd(t, self.adc_tile_attr_map, tidx)

      for aidx in self.enabled_adcs:
        if int(aidx[0]) == tidx:

          n_aidx = int(aidx[1])
          if self.adc_tile_arch == 'QT':
            a = self.adcs[n_aidx+4*int(aidx[0])]
            tcl_cmds['pre_synth'] += self.build_config_cmd(a, self.adc_attr_map, tidx, n_aidx)
          elif self.adc_tile_arch == 'DT':
            a = self.adcs[n_aidx+2*int(aidx[0])]
            tcl_cmds['pre_synth'] += self.build_config_cmd(a, self.adc_attr_map, tidx, 2*n_aidx)
            tcl_cmds['pre_synth'] += self.build_config_cmd(a, self.adc_attr_map, tidx, 2*n_aidx+1)

    for tidx in self.enabled_dac_tiles:
      t = self.tiles[tidx+4] # need to check this vor various enabled/disabled tiles
      # if I remember right, .tiles has every tile, regardless of whether it's enabled, so it might just be tidx+4
      tcl_cmds['pre_synth'] += self.build_config_cmd(t, self.dac_tile_attr_map, tidx)

      for didx in self.enabled_dacs:
        if int(didx[0]) == tidx:
          n_didx = int(didx[1])
          if self.dac_tile_arch == 'QT':
            d = self.dacs[n_didx+4*int(didx[0])]
            tcl_cmds['pre_synth'] += self.build_config_cmd(d, self.dac_attr_map, tidx, n_didx)
          elif self.dac_tile_arch == 'DT':
            d = self.dacs[n_didx+2*int(didx[0])]
            tcl_cmds['pre_synth'] += self.build_config_cmd(d, self.dac_attr_map, tidx, 2*n_didx)
            tcl_cmds['pre_synth'] += self.build_config_cmd(d, self.dac_attr_map, tidx, 2*n_didx+1)

    tcl_cmds['pre_synth'] += ['] [get_bd_cells $rfdc]']
    # create board interface ports for axis data/clk/reset pins and adc tile output clock for each enabled tile
    for tidx in self.enabled_adc_tiles:
      t = self.tiles[tidx]
      # gen3 parts support clock forwarding, user provides information about provided clock to the board sources in simulink mask (e.g.,
      # current gen3 xilinx eval boards only have clocks coming to 2 adc and 2 dac tiles, requiring clocks to be forwarded)
      if self.gen > 1:
        if (self.blk['t{:d}_adc_clk_src'.format(tidx+224)]-224 == tidx):
          # create port for input sample clock
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('adc{:d}_clk_n'.format(tidx), port_dir='in', port_type='clk', clk_freq_hz=t.ref_clk*1e6))
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('adc{:d}_clk_p'.format(tidx), port_dir='in', port_type='clk', clk_freq_hz=t.ref_clk*1e6))
      else:
        if (self.rfdc_conf['tile{:d}'.format(tidx+224)]['adc_clk_src'] == tidx):
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
        if tidx == int(aidx[0]):
          n_aidx = int(aidx[1])
          if self.adc_tile_arch == 'QT':
            a = self.adcs[n_aidx+4*int(aidx[0])]
          elif self.adc_tile_arch == 'DT':
            a = self.adcs[n_aidx+2*int(aidx[0])]
          data_width = 16*a.sample_per_cycle
          if self.adc_tile_arch == 'QT':
            # vin ports
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vin{:d}{:d}_n'.format(tidx, n_aidx), port_dir='in'))
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vin{:d}{:d}_p'.format(tidx, n_aidx), port_dir='in'))
            # maxis
            if a.mixer_type != 'Off' and a.mixer_type != False: #only add slices that aren't odd and in a IQ->IQ config
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tdata'.format(tidx, n_aidx), port_dir='out', width=data_width))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tvalid'.format(tidx, n_aidx), port_dir='out'))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tready'.format(tidx, n_aidx), port_dir='in'))
          else: # Dual tile architecture
            # vin ports
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vin{:d}_{:d}{:d}_n'.format(tidx, 2*n_aidx, 2*n_aidx+1), port_dir='in'))
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vin{:d}_{:d}{:d}_p'.format(tidx, 2*n_aidx, 2*n_aidx+1), port_dir='in'))
            # maxis ports-dual architecture rfsocs the I/Q streams are output on seperate maxis interfaces needing different rules depending on the configuration
            if a.digital_output == 'Real':
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*n_aidx), port_dir='out', width=data_width))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*n_aidx), port_dir='out'))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tready'.format(tidx, 2*n_aidx), port_dir='in'))
            else: # digital mode is I/Q
              if a.mixer_mode == 'Real -> I/Q':
              # I data
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*n_aidx), port_dir='out', width=data_width))
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*n_aidx), port_dir='out'))
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tready'.format(tidx, 2*n_aidx), port_dir='in'))
                # Q data
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tdata'.format(tidx, 2*n_aidx+1), port_dir='out', width=data_width))
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tvalid'.format(tidx, 2*n_aidx+1), port_dir='out'))
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tready'.format(tidx, 2*n_aidx+1), port_dir='in'))
              else: # mixer mode is 'I/Q -> I/Q
                # in this case ADC 1 better be also set or we are in trouble so here we are assuming that the logic is correct and that
                # enabled adcs is both [0, 1]
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tdata'.format(tidx, n_aidx), port_dir='out', width=data_width))
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tvalid'.format(tidx, n_aidx), port_dir='out'))
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('m{:d}{:d}_axis_tready'.format(tidx, n_aidx), port_dir='in'))

    # create board interface ports for axis data/clk/reset pins and dac tile output clock for each enabled tile
    for tidx in self.enabled_dac_tiles:
      t = self.tiles[tidx] # is this wrong? shouldn't it be offset by the num of adc tiles? See line 708 (because see how the wrong tile may be used in line 798?
      # gen3 parts support clock forwarding, user provides information about provided clock to the board sources in simulink mask (e.g.,
      # current gen3 xilinx eval boards only have clocks coming to 2 adc and 2 dac tiles, requiring clocks to be forwarded)
      if self.gen > 1:
        if (self.blk['t{:d}_dac_clk_src'.format(tidx+228)]-224 == tidx+4):
          # create port for input sample clock
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('dac{:d}_clk_n'.format(tidx), port_dir='in', port_type='clk', clk_freq_hz=t.ref_clk*1e6))
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('dac{:d}_clk_p'.format(tidx), port_dir='in', port_type='clk', clk_freq_hz=t.ref_clk*1e6))
      else:
        if (self.rfdc_conf['tile{:d}'.format(tidx+228)]['dac_clk_src'] == tidx+4):
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('dac{:d}_clk_n'.format(tidx), port_dir='in', port_type='clk', clk_freq_hz=t.ref_clk*1e6))
          tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('dac{:d}_clk_p'.format(tidx), port_dir='in', port_type='clk', clk_freq_hz=t.ref_clk*1e6))

      # create board design output ports for the enabled tile clocks
      tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('clk_dac{:d}'.format(tidx), port_dir='out', port_type='clk'))
      # create port for m_axis_aclk for each tile enabled
      tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}_axis_aclk'.format(tidx), port_dir='in', port_type='clk', clk_freq_hz=t.clk_out*1e6)) # clk out is mhz
      # create port for m_axis_aresetn for each tile enabled
      tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}_axis_aresetn'.format(tidx), port_dir='in', port_type='rst'))
      # create port vout and m_axis ports for each tile enable
      for didx in self.enabled_dacs:
        if tidx == int(didx[0]):
          n_didx = int(didx[1])
          if self.dac_tile_arch == 'QT':
            d = self.dacs[n_didx+4*int(didx[0])]
          elif self.dac_tile_arch == 'DT':
            d = self.dacs[n_didx+2*int(didx[0])]
          data_width = 16*d.sample_per_cycle
          if self.dac_tile_arch == 'QT':
            # vout ports
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vout{:d}{:d}_n'.format(tidx, n_didx), port_dir='out'))
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vout{:d}{:d}_p'.format(tidx, n_didx), port_dir='out'))
            # maxis
            if d.mixer_type != 'Off' and d.mixer_type != False: #only add slices that aren't odd and in a IQ->IQ config
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}{:d}_axis_tdata'.format(tidx, n_didx), port_dir='in', width=data_width))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}{:d}_axis_tvalid'.format(tidx, n_didx), port_dir='in'))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}{:d}_axis_tready'.format(tidx, n_didx), port_dir='out'))
          else: # Dual tile architecture
            # vout ports
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vout{:d}{:d}_n'.format(tidx, n_didx), port_dir='out'))
            tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('vout{:d}{:d}_p'.format(tidx, n_didx), port_dir='out'))
            # maxis ports-dual architecture rfsocs the I/Q streams are output on seperate maxis interfaces needing different rules depending on the configuration
            if d.analog_output == 'Real': # no difference between Real -> Real and I/Q -> Real
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}{:d}_axis_tdata'.format(tidx, n_didx), port_dir='in', width=data_width))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}{:d}_axis_tvalid'.format(tidx, n_didx), port_dir='in'))
              tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}{:d}_axis_tready'.format(tidx, n_didx), port_dir='out'))
            else: # digital mode is I/Q
              # mixer mode is 'I/Q -> I/Q
              # in this case ADC 1 better be also set or we are in trouble so here we are assuming that the logic is correct and that
              # enabled adcs is both [0, 1]
              if d.mixer_type != 'Off' and d.mixer_type != False: #only add the even slices for s_axis ports
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}{:d}_axis_tdata'.format(tidx, n_didx), port_dir='in', width=data_width))
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}{:d}_axis_tvalid'.format(tidx, n_didx), port_dir='in'))
                tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('s{:d}{:d}_axis_tready'.format(tidx, int(didx[1])), port_dir='out'))
    # create IRQ output port
    tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('irq', port_dir='out', port_type='intr'))

    tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('sysref_in_p', port_dir='in'))
    tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('sysref_in_n', port_dir='in'))

    if self.enable_mts_adc:
      tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('user_sysref_adc', port_dir='in'))

    if self.enable_mts_dac:
      tcl_cmds['pre_synth'].append(self.add_tcl_bd_port('user_sysref_dac', port_dir='in'))

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


  def gen_xsct_tcl_cmds(self, jdts_dir):
    """
    Generate xsct commands to produce a custom text dump intermediate representation of the rfdc configuration 
    for device tree generation

    Args:
      jtds_dir (str): directory where build and intermediate products are placed

    returns:
      tcl_cmds (list[str]): xsct commands to append to custom xsct scripts
    """
    tcl_cmds = []

    tcl_cmds.append('')
    tcl_cmds.append('# generate property list for manual device tree node generation')
    tcl_cmds.append('set rfdc_dts_dir {:s}/rfdc'.format(jdts_dir))
    tcl_cmds.append('file mkdir $rfdc_dts_dir')
    tcl_cmds.append('set ofile "${{rfdc_dts_dir}}/{:s}"'.format('rfdc.txt'))
    tcl_cmds.append('set rfdc [hsi::get_cells usp_rf_data_converter_0]')
    tcl_cmds.append('set prop_list [common::report_property -return_string $rfdc]')
    tcl_cmds.append('set clk_pins [hsi::get_pins -of_objects [hsi::get_cells -hier $rfdc] -filter {TYPE==clk&&DIRECTION==I}]')
    tcl_cmds.append('set out "${prop_list}\\nDT.CLOCKS ${clk_pins}"')
    tcl_cmds.append('set fd_dts_outfile [open $ofile w+]')
    tcl_cmds.append('puts $fd_dts_outfile $out')
    tcl_cmds.append('close $fd_dts_outfile')
    tcl_cmds.append('')

    return tcl_cmds


  def gen_dt_node(self, mmap_info, jdts_dir):
    """
    """
    baseaddr = mmap_info['baseaddr']
    # where the intermediate configuration information from xsct is stored
    propinfo = '{:s}/{:s}/{:s}'.format(jdts_dir, 'rfdc', 'rfdc.txt')
    # our output peripheral fragment
    dtsopath = '{:s}/{:s}/{:s}'.format(jdts_dir, 'rfdc', 'rfdc-overlay-fragment')

    # writes dtsi fragment
    dt = self.gen_rfdc_dt(propinfo, dtsopath, '0x{:s}'.format(baseaddr))

    return dt


  def gen_rfdc_dt(self, fpath, opath, baseaddr):
    """
    Generates device tree node for xilinx rfdc, dumps the device tree
    description as a dtsi and compiles using `dtc` to a dtbo for application as
    an overlay

    Args:
      fpath (str): file name containing dumped information from IP core
      opath (str): output file name for the dts
      baseaddr (str): string of hex literals of the memory mapped address for nodes unit-address

    return:
      dt (dict): device tree node dictionary representation, if this ends up being to the tools
                a more useful implementation would manage a device tree implementation adding
                this (and other nodes) as part of a managed tree


    Example device tree declaration for the Xilinx RF-Data Converter, the Xilinx rfdc
    linux software driver uses the device tree information to initialize and start
    the driver

    usp_rf_data_converter_0: usp_rf_data_converter@b0000000 {
      clock-names = "adc2_clk_p", "adc2_clk_n", "s_axi_aclk", "m0_axis_aclk", "m1_axis_aclk", "m2_axis_aclk", "m3_axis_aclk";
      clocks = <&misc_clk_0>, <&misc_clk_0>, <&zynqmp_clk 71>, <&misc_clk_0>, <&misc_clk_0>, <&misc_clk_0>, <&misc_clk_0>;
      compatible = "xlnx,usp-rf-data-converter-2.4";
      num-insts = <0x1>;
      param-list = [ 00 00 00 00 00 00 00 b0 00 00 00 00 ... 00 00 00 03 00 00 00];
      reg = <0x0 0xb0000000 0x0 0x40000>;
    };

    param-list:
      A little-endian byte string of all configuration parameters matching the
      `XRFdc_Config` struct in the xilinx c rfdc driver
      (github.com/xilinx/embeddedsw/XilinxProcessorIPLib/drivers/rfdc/src/xrfdc.h).
      Instead of always looking at each of the fields and structs that make up the
      `XRFdc_Config` struct the list of parameters that make this up are listed in the
      xilinx device tree genertor tcl script
      (github.com/xilinx/device-tree-xlnx/rfdc/data/rfdc.tcl). That list of parameters
      are stored here and used for parsing as the `rfdc_param_keys` list. It is
      possible that the `XRFdc_Config` struct change as the driver is updated.
    """
    DEBUG = 0

    # dictionary containing configuration parsed from dumped tcl
    rfdc_params = {}
    # dictionary representing the property list and values for the rfdc device tree node
    dt = {}

    # static properties from the rfdc device tree binding
    dt['compatible'] = '"xlnx,usp-rf-data-converter-2.4";'
    dt['num-insts'] = '<0x1>;'

    # baseaddr and size of rfdc address space to be used to complete the node unit-address
    dt['baseaddr'] = baseaddr
    dt['range'] = '0x40000'

    # hard code device id to be zero, only one rfdc allowed
    rfdc_params['DEVICE_ID'] = '0'

    dtreg_fmt = '<{:s} {:s} {:s} {:s}>;'
    dt['reg'] = dtreg_fmt.format('0x0', dt['baseaddr'], '0x0', dt['range'])

    if not os.path.exists(fpath):
      raise FileNotFoundError
    fd = open(fpath, 'r')

    # skip first line, just column headers
    s = fd.readline()

    # main parsing loop builind the `rfdc_params` dict
    for s in fd.readlines():
      s = s.split()

      k = s[0]
      if "CONFIG." in k:
        v = s[3]
        rfdc_params[k[7:]] = v # strip "CONFIG." and add value
      elif "DT.CLOCKS" in k:
        clks = s[1:]
        clkstr = (len(clks)*'"{:s}"').format(*clks)
        clkstr = clkstr.replace('""', '", "')
        dt['clock-names'] = clkstr + ";"

    fd.close()

    # build `param-list` property, see file header for information on property format
    rfdc_param_keys = rfdc_dt_conf_keys # intermediate variable to reference different possible key lists across driver versions
    param_list = ""

    for k in rfdc_param_keys:
      fmt = ""

      if k == "C_BASEADDR":
        # opt for casper provided `baseaddr` as the rfdc is managed by the casper axi4lite mmap and not
        # the vivado board design
        #v = rfdc_params[k]
        v = dt['baseaddr'] # e.g., 0xA0040000

        dt['baseaddr'] = v.lower()

        # low address in little-endian
        param_list += " {:2s} {:2s} {:2s} {:2s}".format(v[8:10], v[6:8], v[4:6], v[2:4])#format(v[2:4], v[4:6], v[6:8], v[8:10])
        # high address hard coded to 0x00000000
        param_list += " 00 00 00 00"

      else:
        if ('_Sampling_Rate' in k) or ('_Refclk_Freq' in k) or ('_Fabric_Freq' in k) or ('_Fs_Max' in k):
          fmt = '<d' # little-endian double
          t = float
        else:
          fmt = '<i' # little-endian int
          t = int

        if k in rfdc_params.keys():
          v = rfdc_params[k]
          if v == 'true':
            v = 1
          elif v == 'false':
            v = 0
        else:
          v = 0

        # make byte conversion
        p = struct.pack(fmt, t(v)) # struct.pack('d', 250.0)
        to_add = " {:s}".format(p.hex(' ', 1))
        if DEBUG:
          if fmt == '<d':
            # NOTE: the {:8.3f} prints out to 3 decimal but fields have the precision as defined by
            #  rfdc structure in the yellow block (e.g., sample rate/NCO have precision of 5)
            print("{:28s} {:s} {:8.3f} {:s}".format(k, fmt, t(v), to_add))
          elif fmt == '<i':
            print("{:28s} {:s} {:8d} {:s}".format(k, fmt, t(v), to_add))
        param_list += " {:s}".format(p.hex(' ', 1))

    param_list = param_list.lower()

    dt['param-list'] = '[{:s}];'.format(param_list)

    # assemble dt node
    dtstr = []
    dtstr.append('/* AUTOMATICALLY GENERATED */\n\n')
    dtstr.append('/dts-v1/;')
    # TODO: only one `/plugin/` directive can be present will need to remove this when combining with xlnx dt products
    dtstr.append('/plugin/;')
    dtstr.append('/ {')
    # TODO: if when jasper has more software needs for dt will need to pass bus-id in to this method, see
    # note when toolflow calls peripheral (yellow blocks) `gen_dt_node()` method
    dtstr.append('    fragment@0 {')
    dtstr.append('      target = <&amba>;')
    dtstr.append('      overlay0: __overlay__ {')
    dtstr.append('        #address-cells = <2>;')
    dtstr.append('        #size-cells = <2>;')
    dtstr.append('        usp_rf_data_converter_0: usp_rf_data_converter@{:s} {{'.format(dt['baseaddr'][2:]))
    dtstr.append('         clock-names = {:s}'.format(dt['clock-names']))
    dtstr.append('         compatible = {:s}'.format(dt['compatible']))
    dtstr.append('         num-insts = {:s}'.format(dt['num-insts']))
    dtstr.append('         param-list = {:s}'.format(dt['param-list']))
    dtstr.append('         reg = {:s}'.format(dt['reg']))
    dtstr.append('        };')
    dtstr.append('      };')
    dtstr.append('    };')
    dtstr.append('};')

    # write dtsi node to file
    dtnode = '\n'.join(dtstr)
    fd = open(opath+'.dtsi', 'w+')
    fd.write(dtnode)
    fd.close()

    return dt


# These keys are not guaranteed to the same between `xrfdc` driver versions (or petalinux/vitis versions), these were from
# device-tree-xlnx for 2020.2
rfdc_dt_conf_keys = [
  "DEVICE_ID", "C_BASEADDR", "C_High_Speed_ADC", "C_Sysref_Master", "C_Sysref_Master", "C_Sysref_Source", "C_Sysref_Source", "C_IP_Type",
  "C_Silicon_Revision", "C_DAC0_Enable", "C_DAC0_PLL_Enable", "C_DAC0_Sampling_Rate", "C_DAC0_Refclk_Freq", "C_DAC0_Fabric_Freq",
  "C_DAC0_FBDIV", "C_DAC0_OutDiv", "C_DAC0_Refclk_Div", "C_DAC0_Band", "C_DAC0_Fs_Max", "C_DAC0_Slices", "C_DAC_Slice00_Enable",
  "C_DAC_Invsinc_Ctrl00", "C_DAC_Mixer_Mode00", "C_DAC_Decoder_Mode00", "C_DAC_Slice01_Enable", "C_DAC_Invsinc_Ctrl01", "C_DAC_Mixer_Mode01",
  "C_DAC_Decoder_Mode01", "C_DAC_Slice02_Enable", "C_DAC_Invsinc_Ctrl02", "C_DAC_Mixer_Mode02", "C_DAC_Decoder_Mode02",
  "C_DAC_Slice03_Enable", "C_DAC_Invsinc_Ctrl03", "C_DAC_Mixer_Mode03", "C_DAC_Decoder_Mode03", "C_DAC_Data_Type00", "C_DAC_Data_Width00",
  "C_DAC_Interpolation_Mode00", "C_DAC_Fifo00_Enable", "C_DAC_Adder00_Enable", "C_DAC_Mixer_Type00", "C_DAC_Data_Type01",
  "C_DAC_Data_Width01", "C_DAC_Interpolation_Mode01", "C_DAC_Fifo01_Enable", "C_DAC_Adder01_Enable", "C_DAC_Mixer_Type01",
  "C_DAC_Data_Type02", "C_DAC_Data_Width02", "C_DAC_Interpolation_Mode02", "C_DAC_Fifo02_Enable", "C_DAC_Adder02_Enable",
  "C_DAC_Mixer_Type02", "C_DAC_Data_Type03", "C_DAC_Data_Width03", "C_DAC_Interpolation_Mode03", "C_DAC_Fifo03_Enable",
  "C_DAC_Adder03_Enable", "C_DAC_Mixer_Type03", "C_DAC1_Enable", "C_DAC1_PLL_Enable", "C_DAC1_Sampling_Rate", "C_DAC1_Refclk_Freq",
  "C_DAC1_Fabric_Freq", "C_DAC1_FBDIV", "C_DAC1_OutDiv", "C_DAC1_Refclk_Div", "C_DAC1_Band", "C_DAC1_Fs_Max", "C_DAC1_Slices",
  "C_DAC_Slice10_Enable", "C_DAC_Invsinc_Ctrl10", "C_DAC_Mixer_Mode10", "C_DAC_Decoder_Mode10", "C_DAC_Slice11_Enable",
  "C_DAC_Invsinc_Ctrl11", "C_DAC_Mixer_Mode11", "C_DAC_Decoder_Mode11", "C_DAC_Slice12_Enable", "C_DAC_Invsinc_Ctrl12", "C_DAC_Mixer_Mode12",
  "C_DAC_Decoder_Mode12", "C_DAC_Slice13_Enable", "C_DAC_Invsinc_Ctrl13", "C_DAC_Mixer_Mode13", "C_DAC_Decoder_Mode13", "C_DAC_Data_Type10",
  "C_DAC_Data_Width10", "C_DAC_Interpolation_Mode10", "C_DAC_Fifo10_Enable", "C_DAC_Adder10_Enable", "C_DAC_Mixer_Type10",
  "C_DAC_Data_Type11", "C_DAC_Data_Width11", "C_DAC_Interpolation_Mode11", "C_DAC_Fifo11_Enable", "C_DAC_Adder11_Enable",
  "C_DAC_Mixer_Type11", "C_DAC_Data_Type12", "C_DAC_Data_Width12", "C_DAC_Interpolation_Mode12", "C_DAC_Fifo12_Enable",
  "C_DAC_Adder12_Enable", "C_DAC_Mixer_Type12", "C_DAC_Data_Type13", "C_DAC_Data_Width13", "C_DAC_Interpolation_Mode13",
  "C_DAC_Fifo13_Enable", "C_DAC_Adder13_Enable", "C_DAC_Mixer_Type13", "C_DAC2_Enable", "C_DAC2_PLL_Enable", "C_DAC2_Sampling_Rate",
  "C_DAC2_Refclk_Freq", "C_DAC2_Fabric_Freq", "C_DAC2_FBDIV", "C_DAC2_OutDiv", "C_DAC2_Refclk_Div", "C_DAC2_Band", "C_DAC2_Fs_Max",
  "C_DAC2_Slices", "C_DAC_Slice20_Enable", "C_DAC_Invsinc_Ctrl20", "C_DAC_Mixer_Mode20", "C_DAC_Decoder_Mode20", "C_DAC_Slice21_Enable",
  "C_DAC_Invsinc_Ctrl21", "C_DAC_Mixer_Mode21", "C_DAC_Decoder_Mode21", "C_DAC_Slice22_Enable", "C_DAC_Invsinc_Ctrl22", "C_DAC_Mixer_Mode22",
  "C_DAC_Decoder_Mode22", "C_DAC_Slice23_Enable", "C_DAC_Invsinc_Ctrl23", "C_DAC_Mixer_Mode23", "C_DAC_Decoder_Mode23", "C_DAC_Data_Type20",
  "C_DAC_Data_Width20", "C_DAC_Interpolation_Mode20", "C_DAC_Fifo20_Enable", "C_DAC_Adder20_Enable", "C_DAC_Mixer_Type20",
  "C_DAC_Data_Type21", "C_DAC_Data_Width21", "C_DAC_Interpolation_Mode21", "C_DAC_Fifo21_Enable", "C_DAC_Adder21_Enable",
  "C_DAC_Mixer_Type21", "C_DAC_Data_Type22", "C_DAC_Data_Width22", "C_DAC_Interpolation_Mode22", "C_DAC_Fifo22_Enable",
  "C_DAC_Adder22_Enable", "C_DAC_Mixer_Type22", "C_DAC_Data_Type23", "C_DAC_Data_Width23", "C_DAC_Interpolation_Mode23",
  "C_DAC_Fifo23_Enable", "C_DAC_Adder23_Enable", "C_DAC_Mixer_Type23", "C_DAC3_Enable", "C_DAC3_PLL_Enable", "C_DAC3_Sampling_Rate",
  "C_DAC3_Refclk_Freq", "C_DAC3_Fabric_Freq", "C_DAC3_FBDIV", "C_DAC3_OutDiv", "C_DAC3_Refclk_Div", "C_DAC3_Band", "C_DAC3_Fs_Max",
  "C_DAC3_Slices", "C_DAC_Slice30_Enable", "C_DAC_Invsinc_Ctrl30", "C_DAC_Mixer_Mode30", "C_DAC_Decoder_Mode30", "C_DAC_Slice31_Enable",
  "C_DAC_Invsinc_Ctrl31", "C_DAC_Mixer_Mode31", "C_DAC_Decoder_Mode31", "C_DAC_Slice32_Enable", "C_DAC_Invsinc_Ctrl32", "C_DAC_Mixer_Mode32",
  "C_DAC_Decoder_Mode32", "C_DAC_Slice33_Enable", "C_DAC_Invsinc_Ctrl33", "C_DAC_Mixer_Mode33", "C_DAC_Decoder_Mode33", "C_DAC_Data_Type30",
  "C_DAC_Data_Width30", "C_DAC_Interpolation_Mode30", "C_DAC_Fifo30_Enable", "C_DAC_Adder30_Enable", "C_DAC_Mixer_Type30",
  "C_DAC_Data_Type31", "C_DAC_Data_Width31", "C_DAC_Interpolation_Mode31", "C_DAC_Fifo31_Enable", "C_DAC_Adder31_Enable",
  "C_DAC_Mixer_Type31", "C_DAC_Data_Type32", "C_DAC_Data_Width32", "C_DAC_Interpolation_Mode32", "C_DAC_Fifo32_Enable",
  "C_DAC_Adder32_Enable", "C_DAC_Mixer_Type32", "C_DAC_Data_Type33", "C_DAC_Data_Width33", "C_DAC_Interpolation_Mode33",
  "C_DAC_Fifo33_Enable", "C_DAC_Adder33_Enable", "C_DAC_Mixer_Type33", "C_ADC0_Enable", "C_ADC0_PLL_Enable", "C_ADC0_Sampling_Rate",
  "C_ADC0_Refclk_Freq", "C_ADC0_Fabric_Freq", "C_ADC0_FBDIV", "C_ADC0_OutDiv", "C_ADC0_Refclk_Div", "C_ADC0_Band", "C_ADC0_Fs_Max",
  "C_ADC0_Slices", "C_ADC_Slice00_Enable", "C_ADC_Mixer_Mode00", "C_ADC_Slice01_Enable", "C_ADC_Mixer_Mode01", "C_ADC_Slice02_Enable",
  "C_ADC_Mixer_Mode02", "C_ADC_Slice03_Enable", "C_ADC_Mixer_Mode03", "C_ADC_Data_Type00", "C_ADC_Data_Width00", "C_ADC_Decimation_Mode00",
  "C_ADC_Fifo00_Enable", "C_ADC_Mixer_Type00", "C_ADC_Data_Type01", "C_ADC_Data_Width01", "C_ADC_Decimation_Mode01", "C_ADC_Fifo01_Enable",
  "C_ADC_Mixer_Type01", "C_ADC_Data_Type02", "C_ADC_Data_Width02", "C_ADC_Decimation_Mode02", "C_ADC_Fifo02_Enable", "C_ADC_Mixer_Type02",
  "C_ADC_Data_Type03", "C_ADC_Data_Width03", "C_ADC_Decimation_Mode03", "C_ADC_Fifo03_Enable", "C_ADC_Mixer_Type03", "C_ADC1_Enable",
  "C_ADC1_PLL_Enable", "C_ADC1_Sampling_Rate", "C_ADC1_Refclk_Freq", "C_ADC1_Fabric_Freq", "C_ADC1_FBDIV", "C_ADC1_OutDiv",
  "C_ADC1_Refclk_Div", "C_ADC1_Band", "C_ADC1_Fs_Max", "C_ADC1_Slices", "C_ADC_Slice10_Enable", "C_ADC_Mixer_Mode10", "C_ADC_Slice11_Enable",
  "C_ADC_Mixer_Mode11", "C_ADC_Slice12_Enable", "C_ADC_Mixer_Mode12", "C_ADC_Slice13_Enable", "C_ADC_Mixer_Mode13", "C_ADC_Data_Type10",
  "C_ADC_Data_Width10", "C_ADC_Decimation_Mode10", "C_ADC_Fifo10_Enable", "C_ADC_Mixer_Type10", "C_ADC_Data_Type11", "C_ADC_Data_Width11",
  "C_ADC_Decimation_Mode11", "C_ADC_Fifo11_Enable", "C_ADC_Mixer_Type11", "C_ADC_Data_Type12", "C_ADC_Data_Width12",
  "C_ADC_Decimation_Mode12", "C_ADC_Fifo12_Enable", "C_ADC_Mixer_Type12", "C_ADC_Data_Type13", "C_ADC_Data_Width13",
  "C_ADC_Decimation_Mode13", "C_ADC_Fifo13_Enable", "C_ADC_Mixer_Type13", "C_ADC2_Enable", "C_ADC2_PLL_Enable", "C_ADC2_Sampling_Rate",
  "C_ADC2_Refclk_Freq", "C_ADC2_Fabric_Freq", "C_ADC2_FBDIV", "C_ADC2_OutDiv", "C_ADC2_Refclk_Div", "C_ADC2_Band", "C_ADC2_Fs_Max",
  "C_ADC2_Slices", "C_ADC_Slice20_Enable", "C_ADC_Mixer_Mode20", "C_ADC_Slice21_Enable", "C_ADC_Mixer_Mode21", "C_ADC_Slice22_Enable",
  "C_ADC_Mixer_Mode22", "C_ADC_Slice23_Enable", "C_ADC_Mixer_Mode23", "C_ADC_Data_Type20", "C_ADC_Data_Width20", "C_ADC_Decimation_Mode20",
  "C_ADC_Fifo20_Enable", "C_ADC_Mixer_Type20", "C_ADC_Data_Type21", "C_ADC_Data_Width21", "C_ADC_Decimation_Mode21", "C_ADC_Fifo21_Enable",
  "C_ADC_Mixer_Type21", "C_ADC_Data_Type22", "C_ADC_Data_Width22", "C_ADC_Decimation_Mode22", "C_ADC_Fifo22_Enable", "C_ADC_Mixer_Type22",
  "C_ADC_Data_Type23", "C_ADC_Data_Width23", "C_ADC_Decimation_Mode23", "C_ADC_Fifo23_Enable", "C_ADC_Mixer_Type23", "C_ADC3_Enable",
  "C_ADC3_PLL_Enable", "C_ADC3_Sampling_Rate", "C_ADC3_Refclk_Freq", "C_ADC3_Fabric_Freq", "C_ADC3_FBDIV", "C_ADC3_OutDiv",
  "C_ADC3_Refclk_Div", "C_ADC3_Band", "C_ADC3_Fs_Max", "C_ADC3_Slices", "C_ADC_Slice30_Enable", "C_ADC_Mixer_Mode30", "C_ADC_Slice31_Enable",
  "C_ADC_Mixer_Mode31", "C_ADC_Slice32_Enable", "C_ADC_Mixer_Mode32", "C_ADC_Slice33_Enable", "C_ADC_Mixer_Mode33", "C_ADC_Data_Type30",
  "C_ADC_Data_Width30", "C_ADC_Decimation_Mode30", "C_ADC_Fifo30_Enable", "C_ADC_Mixer_Type30", "C_ADC_Data_Type31", "C_ADC_Data_Width31",
  "C_ADC_Decimation_Mode31", "C_ADC_Fifo31_Enable", "C_ADC_Mixer_Type31", "C_ADC_Data_Type32", "C_ADC_Data_Width32",
  "C_ADC_Decimation_Mode32", "C_ADC_Fifo32_Enable", "C_ADC_Mixer_Type32", "C_ADC_Data_Type33", "C_ADC_Data_Width33",
  "C_ADC_Decimation_Mode33", "C_ADC_Fifo33_Enable", "C_ADC_Mixer_Type33"
]
