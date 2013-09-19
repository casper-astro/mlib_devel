function biplex_core_init(blk, varargin)
% Initialize and configure a biplex_core block.
%
% biplex_core_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
% FFTSize = Size of the FFT (2^FFTSize points).
% input_bit_width = Input and output bit width
% coeff_bit_width = Coefficient bit width
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
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

  clog('entering biplex_core_init',{'trace', 'biplex_core_init_debug'});

  % Set default vararg values.
  defaults = { ...
      'n_inputs', 1, ...
      'FFTSize', 3, ...
      'input_bit_width', 18, ...
      'bin_pt_in', 17, ...
      'coeff_bit_width', 18, ...
      'async', 'off', ...
      'add_latency', 1, ...
      'mult_latency', 2, ...
      'bram_latency', 2, ...
      'conv_latency', 1, ...
      'quantization', 'Round  (unbiased: +/- Inf)', ...
      'overflow', 'Saturate', ...
      'delays_bit_limit', 8, ...
      'coeffs_bit_limit', 8, ...
      'coeff_sharing', 'on', ...
      'coeff_decimation', 'on', ...
      'max_fanout', 4, ...
      'mult_spec', [2 2], ...
      'bitgrowth', 'on', ...
      'max_bits', 20, ...
      'hardcode_shifts', 'off', ...
      'shift_schedule', [1 1], ...
      'dsp48_adders', 'off', ...
  };

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  clog('biplex_core_init post same_state',{'trace', 'biplex_core_init_debug'});
  check_mask_type(blk, 'biplex_core');
  munge_block(blk, varargin{:});

  % Retrieve values from mask fields.
  n_inputs          = get_var('n_inputs', 'defaults', defaults, varargin{:});
  FFTSize           = get_var('FFTSize', 'defaults', defaults, varargin{:});
  input_bit_width   = get_var('input_bit_width', 'defaults', defaults, varargin{:});
  bin_pt_in         = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
  coeff_bit_width   = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
  async             = get_var('async', 'defaults', defaults, varargin{:});
  add_latency       = get_var('add_latency', 'defaults', defaults, varargin{:});
  mult_latency      = get_var('mult_latency', 'defaults', defaults, varargin{:});
  bram_latency      = get_var('bram_latency', 'defaults', defaults, varargin{:});
  conv_latency      = get_var('conv_latency', 'defaults', defaults, varargin{:});
  quantization      = get_var('quantization', 'defaults', defaults, varargin{:});
  overflow          = get_var('overflow', 'defaults', defaults, varargin{:});
  delays_bit_limit  = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
  coeffs_bit_limit  = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
  coeff_sharing     = get_var('coeff_sharing', 'defaults', defaults, varargin{:});
  coeff_decimation  = get_var('coeff_decimation', 'defaults', defaults, varargin{:});
  max_fanout        = get_var('max_fanout', 'defaults', defaults, varargin{:});
  mult_spec         = get_var('mult_spec', 'defaults', defaults, varargin{:});
  bitgrowth         = get_var('bitgrowth', 'defaults', defaults, varargin{:});
  max_bits          = get_var('max_bits', 'defaults', defaults, varargin{:});
  hardcode_shifts   = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
  shift_schedule    = get_var('shift_schedule', 'defaults', defaults, varargin{:});
  dsp48_adders      = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default case for library, clean block
  if FFTSize == 0 | n_inputs == 0,
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting biplex_core_init','trace');
    return;
  end

  if FFTSize < 2,
      clog('biplex_core_init.m: Biplex FFT must have length of at least (2^)2',{'error', 'biplex_core_init_debug'});
      error('biplex_core_init.m: Biplex FFT must have length of at least (2^)2.');
  end

  % bin_pt_in == -1 is a special case for backwards compatibility
  if bin_pt_in == -1
    bin_pt_in = input_bit_width - 1;
    set_mask_params(blk, 'bin_pt_in', num2str(bin_pt_in));
  end

  % check the per-stage multiplier specification
  stage_mult_spec = multiplier_specification(mult_spec, FFTSize, blk);

  reuse_block(blk, 'sync', 'built-in/inport', 'Port', '1', 'Position', [15 108 45 122]);
  reuse_block(blk, 'shift', 'built-in/inport', 'Port', '2', 'Position', [15 213 45 227]);
  reuse_block(blk, 'pol1', 'built-in/inport', 'Port', '3', 'Position', [55 33 85 47]);
  reuse_block(blk, 'pol2', 'built-in/inport', 'Port', '4', 'Position', [15 58 45 72]);

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/inport', 'Port', '5', 'Position', [15 158 45 172]);
  end

  reuse_block(blk, 'Constant', 'xbsindex_r4/Constant', ...
      'arith_type', 'Unsigned', 'const', '0', 'n_bits', num2str(n_inputs), 'bin_pt', '0', ...
      'explicit_period', 'on', 'period', '1', ...
      'Position', [55 82 85 98]);

  % create/delete stages
  for stage = 1:FFTSize,

      % if delays occupy larger space than specified for this stage then implement in BRAM
      if ((2^(FFTSize - stage) * input_bit_width * 2) >= (2^delays_bit_limit)), delays_bram = 'on';
      else delays_bram = 'off';
      end

      if (strcmp(hardcode_shifts, 'on') && (shift_schedule(stage) == 1)), downshift = 'on';
      else downshift = 'off';
      end

      %if growing bits pre-calculate for every stage
      if strcmp(bitgrowth, 'on'), 
        n_bits_stage_in = min(max_bits, input_bit_width + stage - 1);
        %if we are going to go above the max limit stop growing
        if (n_bits_stage_in+1) > max_bits, bitgrowth_stage = 'off';
        else, bitgrowth_stage = 'on';
        end
      else, 
        n_bits_stage_in = input_bit_width; 
        bitgrowth_stage = bitgrowth; 
      end

      stage_name = ['fft_stage_',num2str(stage)];

      if strcmp(async, 'on'), position = [120*stage, 32, 120*stage+95, 173];
      else position = [120*stage, 32, 120*stage+95, 148];
      end

      reuse_block(blk, stage_name, 'casper_library_ffts/fft_stage_n', ...
          'n_inputs', num2str(n_inputs), ... 
          'Position', position, ...
          'FFTSize', num2str(FFTSize), ...
          'FFTStage', num2str(stage), ...
          'input_bit_width', num2str(n_bits_stage_in), ...
          'bin_pt_in', num2str(bin_pt_in), ...
          'coeff_bit_width', num2str(coeff_bit_width), ...
          'async', async, ...
          'downshift', downshift, ...
          'add_latency', num2str(add_latency), ...
          'mult_latency', num2str(mult_latency), ...
          'bram_latency', num2str(bram_latency), ...
          'conv_latency', num2str(conv_latency), ...
          'quantization', quantization, ...
          'overflow', overflow, ...
          'delays_bram', delays_bram, ...
          'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
          'coeff_sharing', coeff_sharing, ...
          'coeff_decimation', coeff_decimation, ...
          'max_fanout', num2str(max_fanout), ...
          'use_hdl', stage_mult_spec(stage).use_hdl, ...
          'use_embedded', stage_mult_spec(stage).use_embedded, ...
          'bitgrowth', bitgrowth_stage, ...
          'hardcode_shifts', hardcode_shifts, ...
          'dsp48_adders', dsp48_adders);

      prev_stage_name = ['fft_stage_', num2str(stage-1)];

      if(stage > 1),
          add_line(blk, [prev_stage_name,'/1'], [stage_name,'/1']);
          add_line(blk, [prev_stage_name,'/2'], [stage_name,'/2']);
          add_line(blk, [prev_stage_name,'/3'], [stage_name,'/3']);
          add_line(blk, [prev_stage_name,'/4'], [stage_name,'/4']);
          add_line(blk, 'shift/1', [stage_name,'/5']);

          if strcmp(async, 'on'), add_line(blk, [prev_stage_name,'/5'], [stage_name,'/6']);
          end
      end
  end

  add_line(blk, 'pol1/1', 'fft_stage_1/1');
  add_line(blk, 'pol2/1', 'fft_stage_1/2');
  add_line(blk, 'Constant/1', 'fft_stage_1/3');
  add_line(blk, 'sync/1', 'fft_stage_1/4');
  add_line(blk, 'shift/1', 'fft_stage_1/5');
  last_stage = ['fft_stage_',num2str(FFTSize)];

  x = 120*(FFTSize+1);
  reuse_block(blk, 'out1', 'built-in/outport', 'Position', [x 38 x+30 52], 'Port', '2');
  reuse_block(blk, 'out2', 'built-in/outport', 'Position', [x 68 x+30 82], 'Port', '3');
  reuse_block(blk, 'of', 'built-in/outport', 'Position', [x 98 x+30 112], 'Port', '4');
  reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [x 128 x+30 142], 'Port', '1');

  add_line(blk, [last_stage,'/1'], 'out1/1');
  add_line(blk, [last_stage,'/2'], 'out2/1');
  add_line(blk, [last_stage,'/3'], 'of/1');
  add_line(blk, [last_stage,'/4'], 'sync_out/1');

  if strcmp(async, 'on'),
    add_line(blk, 'en/1', 'fft_stage_1/6');
    reuse_block(blk, 'dvalid', 'built-in/outport', 'Position', [x 158 x+30 172], 'Port', '5');
    add_line(blk, [last_stage,'/5'], 'dvalid/1');
  end

  clean_blocks(blk);

  fmtstr = sprintf('%d stages', FFTSize);
  set_param(blk, 'AttributesFormatString', fmtstr);
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting biplex_core_init', {'trace', 'biplex_core_init_debug'});

end %function
