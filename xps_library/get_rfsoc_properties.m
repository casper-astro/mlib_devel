function [gen, adc_tile_arch, dac_tile_arch, adc_num_tiles, dac_num_tiles, fs_max, fs_min] = get_rfsoc_properties(gcb)
  % get configuration information from the current rfsoc fpga part so that
  % callbacks and initializations can use this to setup and determine the
  % correct options

  % TODO: there has got to be a better way to store and fetch this info instead
  % of getting the xsg block everytime. Could the mask workspace be used? how do
  % callbacks access those workspace values?

  % get xsg block to extract current part set by platform
  sysgen_blk = find_system(gcs, 'SearchDepth', 1, 'FollowLinks', 'on',...
  'LookUnderMasks', 'all', 'Tag', 'genX');
  if length(sysgen_blk) == 1
      xsg_blk = sysgen_blk{1};
  else
      error('XPS block must be on the same level as the Xilinx SysGen block');
  end

  part = xlgetparam(xsg_blk, 'part');

  match = regexp(part, 'xczu(2[8-9])|(39)|(4[8-9])dr', 'tokens', 'ignorecase');
  if ~isempty(match);
    designator = match{1}{1};
  else
    error('Not a valid Xilinx RFSoC part');
  end

  switch designator(1) % generation
    case '2'
      gen = 1;
    case '3'
      gen = 2;
    case '4'
      gen = 3;
  end % generation

  % Please Note: The architecture names "dual" and "quad" do not mean that
  % There are 2 tiles for dual and 4 tiles for quad. Dual and quad refer
  % to the number of ADCs/DACs per tile.

  switch gen % architecture configuration
    case 1
      switch designator(2)
        case '8'
          fs_max = 4096;
          fs_min = 1000;
          adc_tile_arch = 'dual';
          adc_num_tiles = 4;
          dac_tile_arch = 'quad';
          dac_num_tiles = 2;
        case '9'
          fs_max = 2058;
          fs_min = 500;
          adc_tile_arch = 'quad';
          adc_num_tiles = 4;
          dac_tile_arch = 'quad';
          dac_num_tiles = 4;
      end
    case 3
      fs_min = 500;
      switch designator(2)
        case '8'
          fs_max = 5000;
          adc_tile_arch = 'dual';
          adc_num_tiles = 4;
          dac_tile_arch = 'dual';
          dac_num_tiles = 4;
        case '9'
          fs_max = 2500;
          adc_tile_arch = 'quad';
          adc_num_tiles = 4;
          dac_tile_arch = 'quad';
          dac_num_tiles = 4;
      end
  end

end
