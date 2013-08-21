% Initialize and configure a butterfly_direct block.
%
% butterfly_direct_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
% * biplex          = Make biplex.
% * FFTSize         = Size of the FFT (2^FFTSize points).
% * Coeffs          = Coefficients for twiddle blocks.
% * StepPeriod      = Coefficient step period.
% * coeffs_bram     = Store coefficients in BRAM.
% * coeff_bit_width = Bitwdith of coefficients.
% * input_bit_width = Bitwidth of input data.
% * bin_pt_in       = Binary point position of input data.
% * bitgrowth       = Option to grow non-fractional bits by so don't have to shift.
% * downshift       = Explicitly downshift output data if shifting.
% * bram_latency    = Latency of BRAM blocks.
% * add_latency     = Latency of adders blocks.
% * mult_latency    = Latency of multiplier blocks.
% * conv_latency    = Latency of cast blocks.
% * quantization    = Quantization behavior.
% * overflow        = Overflow behavior.
% * use_hdl         = Use behavioral HDL for multipliers.
% * use_embedded    = Use embedded multipliers.
% * hardcode_shifts = If not using bit growth, option to hardcode downshift setting.
% * dsp48_adders    = Use DSP48-based adders.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
%   Copyright (C) 2010 William Mallard, David MacMahon                        %
%                                                                             %
%   SKASA radio telescope project                                             %
%   www.kat.ac.za                                                             %
%   Copyright (C) 2013 Andrew Martens                                         %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function butterfly_direct_init(blk, varargin)

  clog('entering butterfly_direct_init', {'trace', 'butterfly_direct_init_debug'});

  % Set default vararg values.
  defaults = { ...
      'n_inputs', 1, ...
      'biplex', 'on', ...
      'FFTSize', 6, ...
      'Coeffs', bit_rev([0:2^5-1],5), ...
      'StepPeriod', 1, ...
      'coeff_bit_width', 18, ...
      'input_bit_width', 18, ...
      'bin_pt_in', 17, ...
      'bitgrowth', 'off', ...
      'downshift', 'off', ...
      'async', 'off', ...
      'add_latency', 1, ...
      'mult_latency', 2, ...
      'bram_latency', 2, ...
      'conv_latency', 1, ...
      'quantization', 'Truncate', ...
      'overflow', 'Wrap', ...
      'coeffs_bit_limit', 8, ...
      'coeff_sharing', 'on', ...
      'coeff_decimation', 'on', ...
      'coeff_generation', 'on', ...
      'cal_bits', 1, ...
      'n_bits_rotation', 25, ...
      'max_fanout', 4, ...
      'use_hdl', 'off', ...
      'use_embedded', 'off', ...
      'hardcode_shifts', 'off', ...
      'dsp48_adders', 'off', ...
  };

  % Skip init script if mask state has not changed.
  if same_state(blk, 'defaults', defaults, varargin{:}), return; end

  clog('butterfly_direct_init post same_state', {'trace', 'butterfly_direct_init_debug'});

  % Verify that this is the right mask for the block.
  check_mask_type(blk, 'butterfly_direct');

  % Disable link if state changes from default.
  munge_block(blk, varargin{:});

  % Retrieve values from mask fields.
  n_inputs          = get_var('n_inputs', 'defaults', defaults, varargin{:});
  biplex            = get_var('biplex', 'defaults', defaults, varargin{:});
  FFTSize           = get_var('FFTSize', 'defaults', defaults, varargin{:});
  Coeffs            = get_var('Coeffs', 'defaults', defaults, varargin{:});
  StepPeriod        = get_var('StepPeriod', 'defaults', defaults, varargin{:});
  coeff_bit_width   = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
  input_bit_width   = get_var('input_bit_width', 'defaults', defaults, varargin{:});
  bin_pt_in         = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
  bitgrowth         = get_var('bitgrowth', 'defaults', defaults, varargin{:});
  downshift         = get_var('downshift', 'defaults', defaults, varargin{:});
  async             = get_var('async', 'defaults', defaults, varargin{:});
  bram_latency      = get_var('bram_latency', 'defaults', defaults, varargin{:});
  add_latency       = get_var('add_latency', 'defaults', defaults, varargin{:});
  mult_latency      = get_var('mult_latency', 'defaults', defaults, varargin{:});
  conv_latency      = get_var('conv_latency', 'defaults', defaults, varargin{:});
  quantization      = get_var('quantization', 'defaults', defaults, varargin{:});
  overflow          = get_var('overflow', 'defaults', defaults, varargin{:});
  coeffs_bit_limit  = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
  coeff_sharing     = get_var('coeff_sharing', 'defaults', defaults, varargin{:});
  coeff_decimation  = get_var('coeff_decimation', 'defaults', defaults, varargin{:});
  coeff_generation  = get_var('coeff_generation', 'defaults', defaults, varargin{:});
  cal_bits          = get_var('cal_bits', 'defaults', defaults, varargin{:});
  n_bits_rotation   = get_var('n_bits_rotation', 'defaults', defaults, varargin{:});
  max_fanout        = get_var('max_fanout', 'defaults', defaults, varargin{:});
  use_hdl           = get_var('use_hdl', 'defaults', defaults, varargin{:});
  use_embedded      = get_var('use_embedded', 'defaults', defaults, varargin{:});
  hardcode_shifts   = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
  dsp48_adders      = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

  %default case for library storage, delete everything
  if n_inputs == 0 | FFTSize == 0,
    delete_lines(blk);
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting butterfly_direct_init', 'trace');
    return;
  end

  % bin_pt_in == -1 is a special case for backwards compatibility
  if bin_pt_in == -1
    bin_pt_in = input_bit_width - 1;
    set_mask_params(blk, 'bin_pt_in', num2str(bin_pt_in));
  end

  use_dsp48_mults = strcmp(use_embedded, 'on');
  use_dsp48_adders = strcmp(dsp48_adders, 'on');

  % Validate input fields.

  if strcmp(bitgrowth, 'on') || strcmp(hardcode_shifts, 'on'), mux_latency = 0;
  else mux_latency = 2;
  end

  if use_dsp48_adders,
      set_param(blk, 'add_latency', '2');
      add_latency = 2;
  end

  % Optimize twiddle for coeff = 0, 1, or alternating 0-1
  if length(Coeffs) == 1,
      if Coeffs(1) == 0,
          %if used in biplex core and first stage
          if(strcmp(biplex, 'on')),
              twiddle_type = 'twiddle_pass_through';
          else, %otherwise do same but make sure have correct delay
              twiddle_type = 'twiddle_coeff_0';
          end
      elseif Coeffs(1) == 1,
          twiddle_type = 'twiddle_coeff_1';
      else
          twiddle_type = 'twiddle_general';
      end
  elseif length(Coeffs)==2 && Coeffs(1)==0 && Coeffs(2)==1 && StepPeriod==FFTSize-2,
      twiddle_type = 'twiddle_stage_2';
  else
      twiddle_type = 'twiddle_general';
  end

  clog([twiddle_type, ' for twiddle'], 'butterfly_direct_init_debug');
  clog(['Coeffs = ', mat2str(Coeffs)], 'butterfly_direct_init_debug');

  % Compute bit widths into addsub and convert blocks.
  bw = input_bit_width + 3;
  bd = bin_pt_in+1;
  if strcmp(twiddle_type, 'twiddle_stage_2') ...
      || strcmp(twiddle_type, 'twiddle_coeff_0') ...
      || strcmp(twiddle_type, 'twiddle_coeff_1') ...
      || strcmp(twiddle_type, 'twiddle_pass_through'),
      bw = input_bit_width + 2;
      bd = bin_pt_in+1;
  end

  addsub_b_bitwidth = bw - 2;
  addsub_b_binpoint = bd - 1;

  n_bits_addsub_out = addsub_b_bitwidth+1;
  bin_pt_addsub_out = addsub_b_binpoint;

  if strcmp(bitgrowth, 'off') 
    if strcmp(hardcode_shifts, 'on'),
      if strcmp(downshift, 'on'),
        convert_in_bitwidth = n_bits_addsub_out;   
        convert_in_binpoint = bin_pt_addsub_out+1;
      else
        convert_in_bitwidth = n_bits_addsub_out;
        convert_in_binpoint = bin_pt_addsub_out;
      end
    else
      convert_in_bitwidth = n_bits_addsub_out+1;
      convert_in_binpoint = bin_pt_addsub_out+1;
    end
  else
    convert_in_bitwidth = n_bits_addsub_out;
    convert_in_binpoint = bin_pt_addsub_out;
  end   

  %%%%%%%%%%%%%%%%%%
  % Start drawing! %
  %%%%%%%%%%%%%%%%%%

  % Delete all lines.
  delete_lines(blk);

  %
  % Add inputs and outputs.
  %

  reuse_block(blk, 'a', 'built-in/Inport', 'Port', '1', 'Position', [45 63 75 77]);
  reuse_block(blk, 'b', 'built-in/Inport', 'Port', '2', 'Position', [45 123 75 137]);
  reuse_block(blk, 'sync_in', 'built-in/Inport', 'Port', '3', 'Position', [45 183 75 197]);
  reuse_block(blk, 'shift', 'built-in/Inport', 'Port', '4', 'Position', [380 63 410 77]);
  if strcmp(async, 'on'), reuse_block(blk, 'en', 'built-in/Inport', 'Port', '5','Position', [45 243 75 257]);
  end
  
  reuse_block(blk, 'a+bw', 'built-in/Outport', 'Port', '1', 'Position', [880 58 910 72]);
  reuse_block(blk, 'a-bw', 'built-in/Outport', 'Port', '2', 'Position', [880 88 910 102]);
  reuse_block(blk, 'of', 'built-in/Outport', 'Port', '3', 'Position', [880 143 910 157]);
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '4', 'Position', [880 183 910 197]);
  if strcmp(async, 'on'),
    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '5', 'Position', [880 243 910 257]);
  end

  %
  % Add twiddle block.
  %

  params = {'n_inputs', num2str(n_inputs), 'async', async};

  if ~strcmp(twiddle_type, 'twiddle_pass_through'),
      params = { params{:}, ... 
          'add_latency', num2str(add_latency), ...
          'mult_latency', num2str(mult_latency), ...
          'bram_latency', num2str(bram_latency), ...
          'conv_latency', num2str(conv_latency)};
  end
     
  if strcmp(twiddle_type, 'twiddle_coeff_1'),
      params = { params{:}, ...
        'input_bit_width', num2str(input_bit_width), ...
        'bin_pt_in', num2str(bin_pt_in)};
  elseif strcmp(twiddle_type, 'twiddle_stage_2'), 
      params = { params{:}, ...
        'FFTSize', num2str(FFTSize), ...
        'input_bit_width', num2str(input_bit_width), ...
        'bin_pt_in', num2str(bin_pt_in)};
  elseif strcmp(twiddle_type, 'twiddle_general'), 
      params = { params{:}, ...
        'FFTSize', num2str(FFTSize), ...
        'Coeffs', mat2str(Coeffs), ...
        'StepPeriod', num2str(StepPeriod), ...
        'coeff_bit_width', num2str(coeff_bit_width), ...
        'input_bit_width', num2str(input_bit_width), ...
        'bin_pt_in', num2str(bin_pt_in), ...
        'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
        'coeff_sharing', coeff_sharing, ...
        'coeff_decimation', coeff_decimation, ...
        'coeff_generation', coeff_generation, ...
        'cal_bits', num2str(cal_bits), ...
        'n_bits_rotation', num2str(n_bits_rotation), ...
        'max_fanout', num2str(max_fanout), ...
        'use_hdl', use_hdl, ...
        'use_embedded', use_embedded, ...
        'quantization', quantization, ...
        'overflow', overflow};    
  end
  reuse_block(blk, 'twiddle', ['casper_library_ffts_twiddle/', twiddle_type], ...
          params{:}, 'Position', [120 37 205 283]);
  add_line(blk, 'a/1', 'twiddle/1');
  add_line(blk, 'b/1', 'twiddle/2');
  add_line(blk, 'sync_in/1', 'twiddle/3');

  %
  % Add complex add/sub blocks.
  %
  
  if strcmp(dsp48_adders, 'on'), add_implementation = 'DSP48 core';
  else add_implementation = 'fabric core';
  end

  reuse_block(blk, 'bus_add', 'casper_library_bus/bus_addsub', ...
          'opmode', '0', 'latency', num2str(add_latency), ...
          'n_bits_a', mat2str(repmat(input_bit_width, 1, n_inputs)), ...
          'bin_pt_a', mat2str(bin_pt_in), ...
          'misc', 'off', ...
          'n_bits_b', mat2str(repmat(addsub_b_bitwidth, 1, n_inputs)), ...
          'bin_pt_b', num2str(addsub_b_binpoint), ...
          'n_bits_out', num2str(addsub_b_bitwidth+1), ...
          'bin_pt_out', num2str(addsub_b_binpoint), ...
          'add_implementation', add_implementation, ...
          'Position', [270 64 310 91]);
  add_line(blk, 'twiddle/1', 'bus_add/1');
  add_line(blk, 'twiddle/2', 'bus_add/2');

  reuse_block(blk, 'bus_sub', 'casper_library_bus/bus_addsub', ...
          'opmode', '1', 'latency', num2str(add_latency), ...
          'n_bits_a', mat2str(repmat(input_bit_width, 1, n_inputs)), ...
          'bin_pt_a', mat2str(bin_pt_in), ...
          'misc', 'off', ...
          'n_bits_b', mat2str(repmat(addsub_b_bitwidth, 1, n_inputs)), ...
          'bin_pt_b', num2str(addsub_b_binpoint), ...
          'n_bits_out', num2str(addsub_b_bitwidth+1), ...
          'bin_pt_out', num2str(addsub_b_binpoint), ...
          'add_implementation', add_implementation, ...
          'Position', [270 109 310 136]);
  add_line(blk, 'twiddle/1', 'bus_sub/1');
  add_line(blk, 'twiddle/2', 'bus_sub/2');

  reuse_block(blk, 'Concat', 'xbsIndex_r4/Concat', ...
          'num_inputs', '2', ...
          'Position', [340 59 370 146]);
  add_line(blk, 'bus_add/1', 'Concat/1');
  add_line(blk, 'bus_sub/1', 'Concat/2');
  
  %
  % Convert
  %
  if strcmp(quantization, 'Truncate'), quant = '0';
  elseif strcmp(quantization, 'Round  (unbiased: +/- Inf)'), quant = '1';
  elseif strcmp(quantization, 'Round  (unbiased: Even Values)'), quant = '2';
  else %TODO
  end
  
  if strcmp(overflow, 'Wrap'), of = '0';
  elseif strcmp(overflow, 'Saturate'), of = '1';
  elseif strcmp(overflow, 'Flag as error'), of = '2';
  else %TODO
  end

  if strcmp(bitgrowth, 'on'),
    n_bits_out = input_bit_width+1;
  else
    n_bits_out = input_bit_width;
  end

  reuse_block(blk, 'bus_convert', 'casper_library_bus/bus_convert', ...
          'n_bits_in', mat2str(repmat(convert_in_bitwidth, 1, n_inputs*2)), ...
          'bin_pt_in', mat2str(repmat(convert_in_binpoint, 1, n_inputs*2)), ...
          'cmplx', 'on', ...
          'n_bits_out', num2str(n_bits_out), ...
          'bin_pt_out', num2str(bin_pt_in), ...
          'quantization', quant, 'overflow', of, ...
          'misc', 'off', 'of', 'on', 'latency', 'conv_latency', ...
          'Position', [635 86 690 119]);

  %
  % Add scale 
  %

  if strcmp(bitgrowth, 'off') && strcmp(hardcode_shifts, 'off'),
      reuse_block(blk, 'delay2', 'xbsIndex_r4/Delay', ...
          'Position', [430 59 460 81], ...
          'latency', 'add_latency', ...
          'reg_retiming', 'on');
      add_line(blk, 'shift/1', 'delay2/1');
      
      %required to add padding to match bit width of other stream (from bus_scale)
      reuse_block(blk, 'bus_norm0', 'casper_library_bus/bus_convert', ...
              'n_bits_in', mat2str(repmat(addsub_b_bitwidth+1, 1, n_inputs*2)), ...
              'bin_pt_in', mat2str(repmat(addsub_b_binpoint, 1, n_inputs*2)), ...
              'cmplx', 'on', ...
              'n_bits_out', num2str(addsub_b_bitwidth+2), ...
              'bin_pt_out', num2str(addsub_b_binpoint+1), ...
              'quantization', '0', 'overflow', '0', ...
              'misc', 'off', 'of', 'off', 'latency', '0', ...
              'Position', [500 92 545 118]);
      add_line(blk, 'Concat/1', 'bus_norm0/1');     

      reuse_block(blk, 'bus_scale', 'casper_library_bus/bus_scale', ...
          'n_bits_in', mat2str(repmat(addsub_b_bitwidth+1, 1, n_inputs*2)), ...
          'bin_pt_in', num2str(addsub_b_binpoint), ...
          'cmplx', 'on', ...
          'scale_factor', '-1', ...
          'misc', 'off', ...
          'Position', [405 127 450 153]);
      add_line(blk, 'Concat/1', 'bus_scale/1');  
     
      %scaling causes binary point to be moved up by one place 
      reuse_block(blk, 'bus_norm1', 'casper_library_bus/bus_convert', ...
              'n_bits_in', mat2str(repmat(addsub_b_bitwidth+1, 1, n_inputs*2)), ...
              'bin_pt_in', mat2str(repmat(addsub_b_binpoint+1, 1, n_inputs*2)), ...
              'cmplx', 'on', ...
              'n_bits_out', num2str(addsub_b_bitwidth+2), ...
              'bin_pt_out', num2str(addsub_b_binpoint+1), ...
              'quantization', '0', 'overflow', '0', ...
              'misc', 'off', 'of', 'off', 'latency', '0', ...
              'Position', [500 127 545 153]);
      add_line(blk, 'bus_scale/1', 'bus_norm1/1');     

      reuse_block(blk, 'Mux', 'xbsIndex_r4/Mux', ...
              'inputs', '2', ...
              'Precision', 'Full', ...
              'latency', num2str(mux_latency), ...
              'Position', [580 53 610 157]);
      add_line(blk, 'delay2/1', 'Mux/1');
      add_line(blk, 'bus_norm0/1', 'Mux/2');
      add_line(blk, 'bus_norm1/1', 'Mux/3');
      add_line(blk, 'Mux/1', 'bus_convert/1');
 
  else
      reuse_block(blk, 'Terminator', 'built-in/terminator', 'Position', [430 59 460 81], 'ShowName', 'off');
      add_line(blk, 'shift/1', 'Terminator/1');

      %if we are not growing bits and need to downshift
      if strcmp(bitgrowth, 'off') && strcmp(downshift, 'on'),
        reuse_block(blk, 'bus_scale', 'casper_library_bus/bus_scale', ...
            'n_bits_in', mat2str(repmat(addsub_b_bitwidth+1, 1, n_inputs*2)), ... 
            'bin_pt_in', num2str(addsub_b_binpoint), ...
            'cmplx', 'on', ...
            'scale_factor', '-1', ...
            'misc', 'off', ...
            'Position', [405 127 450 153]);
        add_line(blk, 'Concat/1', 'bus_scale/1');
        add_line(blk, 'bus_scale/1', 'bus_convert/1');  
      else
        add_line(blk, 'Concat/1', 'bus_convert/1');
      end
  end %if hardcode_shifts

  %
  % bus_expand 
  %

  reuse_block(blk, 'bus_expand', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', ...
      'outputNum', '2', 'outputWidth', mat2str(repmat(n_inputs*n_bits_out*2,1,2)), ...
      'outputBinaryPt', '[0,0]', 'outputArithmeticType', '[0,0]', ...   
      'Position', [715 51 765 109]);
  add_line(blk, 'bus_convert/1', 'bus_expand/1');
  add_line(blk, 'bus_expand/1', 'a+bw/1');
  add_line(blk, 'bus_expand/2', 'a-bw/1');

  %
  % overflow detection for different input streams
  %
  
  %need to move a and b input streams next to each other for each input 
  reuse_block(blk, 'munge', 'casper_library_flow_control/munge', ...
    'divisions', num2str(n_inputs * 2), ...
    'div_size', mat2str(repmat(2, 1, n_inputs*2)), ...
    'order', mat2str(reshape([[0:n_inputs-1];[n_inputs:n_inputs*2-1]],1,n_inputs*2)), ...
    'arith_type_out', 'Unsigned', 'bin_pt_out', '0', ...
    'Position', [720 147 760 173]);
  add_line(blk, 'bus_convert/2', 'munge/1');
  
  reuse_block(blk, 'constant', 'xbsIndex_r4/Constant', ...
    'const', '0', 'arith_type', 'Unsigned', 'n_bits', '4', 'bin_pt', '0', ...
    'explicit_period', 'on', 'period', '1', 'Position', [775 127 790 143]);

  reuse_block(blk, 'bus_relational', 'casper_library_bus/bus_relational', ...
    'n_bits_a', '4', 'bin_pt_a', '0', 'type_a', '0', ...
    'n_bits_b', mat2str(repmat(4, 1, n_inputs)), 'bin_pt_b', '0', 'type_b', '0', ...
    'mode', 'a!=b', 'misc', 'off', 'en', 'off', 'latency', '0', ...
    'Position', [820 123 850 172]);
  add_line(blk, 'constant/1', 'bus_relational/1');
  add_line(blk, 'munge/1', 'bus_relational/2');
  add_line(blk, 'bus_relational/1', 'of/1');

  %
  % sync delay.
  %

  reuse_block(blk, 'delay0', 'xbsIndex_r4/Delay');
  set_param([blk,'/delay0'], ...
          'latency', ['add_latency+',num2str(mux_latency),'+conv_latency'], ...
          'reg_retiming', 'on', ...
          'Position', [580 179 610 201]);
  add_line(blk, 'twiddle/3', 'delay0/1');  
  add_line(blk, 'delay0/1', 'sync_out/1');  

  %
  % dvalid delay.
  %

  if strcmp(async, 'on'),
    add_line(blk, 'en/1', 'twiddle/4');
    reuse_block(blk, 'delay1', 'xbsIndex_r4/Delay', ...
          'latency', ['add_latency+',num2str(mux_latency),'+conv_latency'], ...
          'reg_retiming', 'on', ...
          'Position', [580 239 610 261]);
    add_line(blk, 'twiddle/4', 'delay1/1');  
    add_line(blk, 'delay1/1', 'dvalid/1');  
  end

  % Delete all unconnected blocks.
  clean_blocks(blk);

  %%%%%%%%%%%%%%%%%%%
  % Finish drawing! %
  %%%%%%%%%%%%%%%%%%%

  % Set attribute format string (block annotation).
  fmtstr = sprintf('%s', twiddle_type);
  set_param(blk, 'AttributesFormatString', fmtstr);

  % Save block state to stop repeated init script runs.
  save_state(blk, 'defaults', defaults, varargin{:});

  clog('exiting butterfly_direct_init', {'trace', 'butterfly_direct_init_debug'});

end %function
