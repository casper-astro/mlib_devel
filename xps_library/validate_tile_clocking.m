function [axis_clks_valid] = validate_tile_clocking(gcb, tile)

  msk = Simulink.Mask.get(gcb);

  [gen, adc_tile_arch, dac_tile_arch, adc_num_tile, dac_num_tile, fs_max, fs_min] = get_rfsoc_properties(gcb);

  if tile < 228
    tile_arch = adc_tile_arch;
  else
    tile_arch = dac_tile_arch;
  end

  if strcmp(tile_arch, 'quad')
      n_slices = 0:3;
      prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
      n_slices = 0:1;
      prefix = 'DT';
  end

  if tile < 228 % adc
      enabled_adcs = [];
      for a = n_slices
          if chk_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_enable'], 'on')
              enabled_adcs = [enabled_adcs, a];
          end
      end

      axis_clks = [];
      for a = enabled_adcs
          slice_clk = str2double(get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_req_axis_clk']));
          axis_clks = [axis_clks, slice_clk];
      end

      % axis clocks must be the same for each adc slice within a tile
      if ~isempty(axis_clks)
          axis_clks_valid = all(axis_clks == axis_clks(1));
          if ~axis_clks_valid
              label_txt = '*Axis Clockign Invalid*';
          else
              label_txt = num2str(axis_clks(1));
          end

          % compare label with current value and only update if needed
          if ~strcmp(get_param(gcb, ['t', num2str(tile), '_', 'axi_stream_clk']), label_txt)
              set_param(gcb, ['t', num2str(tile), '_', 'axi_stream_clk'], label_txt);
          end
      else
          axis_clks_valid = true;
      end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  else % dac
      enabled_dacs = [];
      % for a = dac_slices
      for a = n_slices
          if chk_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_enable'], 'on')
              enabled_dacs = [enabled_dacs, a];
          end
      end

      axis_clks = [];
      for a = enabled_dacs
          slice_clk = str2double(get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_req_axis_clk']));
          axis_clks = [axis_clks, slice_clk];
      end

      % axis clocks must be the same for each dac slice within a tile
      if ~isempty(axis_clks)
          axis_clks_valid = all(axis_clks == axis_clks(1));
          if ~axis_clks_valid
              label_txt = '*Axis Clocking Invalid*';
          else
              label_txt = num2str(axis_clks(1));
          end

          % compare label with current value and only update if needed
          if ~strcmp(get_param(gcb, ['t', num2str(tile), '_', 'axi_stream_clk']), label_txt)
              set_param(gcb, ['t', num2str(tile), '_', 'axi_stream_clk'], label_txt);
          end
      else
          axis_clks_valid = true;
      end
  end
