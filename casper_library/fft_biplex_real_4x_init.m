function fft_biplex_real_4x_init(blk, varargin)
% Initialize and configure an fft_biplex_real_4x block.
%
% fft_biplex_real_4x_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames:
% FFTSize = Size of the FFT (2^FFTSize points). 
% input_bit_width = Bit width of input and output data. 
% coeff_bit_width = Bit width of coefficients.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.
% conv_latency = 
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% arch = 
% coeff_bit_limit = 
% delays_bit_limit = 
% mult_spec = 
% hardcode_shifts = 
% shift_schedule = 
% dsp48_adders = 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
%   Copyright (C) 2010 William Mallard                                        %
%                                                                             %
%   SKA Africa                                                                %
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

clog('entering fft_biplex_real_4x_init',{'trace', 'fft_biplex_real_4x_init_debug'});

% Set default vararg values.
defaults = { ...
    'n_inputs', 1, ...
    'FFTSize', 2, ...
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
    'mult_spec', 2, ...
    'bitgrowth', 'off', ...
    'max_bits', 19, ...
    'hardcode_shifts', 'off', ...
    'shift_schedule', [1 1], ...
    'dsp48_adders', 'off', ...
};

% Skip init script if mask state has not changed.
if same_state(blk, 'defaults', defaults, varargin{:}), return; end

clog('fft_biplex_real_4x_init post same_state',{'trace','fft_biplex_real_4x_init_debug'});

% Verify that this is the right mask for the block.
check_mask_type(blk, 'fft_biplex_real_4x');

% Disable link if state changes from default.
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
n_inputs            = get_var('n_inputs', 'defaults', defaults, varargin{:});
FFTSize             = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width     = get_var('input_bit_width', 'defaults', defaults, varargin{:});
bin_pt_in           = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
coeff_bit_width     = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
async               = get_var('async', 'defaults', defaults, varargin{:});
add_latency         = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency        = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency        = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency        = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization        = get_var('quantization', 'defaults', defaults, varargin{:});
overflow            = get_var('overflow', 'defaults', defaults, varargin{:});
delays_bit_limit    = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
coeffs_bit_limit    = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
coeff_sharing       = get_var('coeff_sharing', 'defaults', defaults, varargin{:});
coeff_decimation    = get_var('coeff_decimation', 'defaults', defaults, varargin{:});
max_fanout          = get_var('max_fanout', 'defaults', defaults, varargin{:});
mult_spec           = get_var('mult_spec', 'defaults', defaults, varargin{:});
bitgrowth           = get_var('bitgrowth', 'defaults', defaults, varargin{:});
max_bits            = get_var('max_bits', 'defaults', defaults, varargin{:});
hardcode_shifts     = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
shift_schedule      = get_var('shift_schedule', 'defaults', defaults, varargin{:});
dsp48_adders        = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

%default empty for storage in library
if n_inputs == 0 || FFTSize == 0,
  delete_lines(blk);
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting fft_biplex_real_4x_init',{'trace', 'fft_biplex_real_4x_init_debug'});
  return;
end

% bin_pt_in == -1 is a special case for backwards compatibility
if bin_pt_in == -1
  bin_pt_in = input_bit_width - 1;
  set_mask_params(blk, 'bin_pt_in', num2str(bin_pt_in));
end

% validate input fields
[temp, mult_spec] = multiplier_specification(mult_spec, FFTSize, blk);
clear temp;

% Derive useful values.

if (2^(FFTSize-1) * 2*input_bit_width >= 2^delays_bit_limit) && (2^(FFTSize-1) >= bram_latency),
    bram_delays = 'on';
else
    bram_delays = 'off';
end

%%%%%%%%%%%%%%%%%%
% Start drawing! %
%%%%%%%%%%%%%%%%%%

% Delete all lines.
delete_lines(blk);

%
% prepare bus creators
%

reuse_block(blk, 'even_bussify', 'casper_library_flow_control/bus_create', ...
  'inputNum', num2str(n_inputs), 'Position', [150 74 210 116+((n_inputs-1)*60)]); 

reuse_block(blk, 'odd_bussify', 'casper_library_flow_control/bus_create', ...
  'inputNum', num2str(n_inputs), 'Position', [150 74+(n_inputs*60) 210 116+(((n_inputs*2)-1)*60)]); 

%
% prepare bus splitters
%

if strcmp(bitgrowth,'on'), n_bits_out = min(input_bit_width+FFTSize, max_bits);
else n_bits_out = input_bit_width;
end

for index = 0:3,
  reuse_block(blk, ['pol',num2str(index),'_debus'], 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(n_inputs), ...
    'outputWidth', num2str(n_bits_out*2), 'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
    'Position', [490 49+(n_inputs*index)*30 580 81+((n_inputs*(index+1))-1)*30]);
end %for

%
% inputs and outputs.
%

reuse_block(blk, 'sync', 'built-in/inport', 'Position', [15 13 45 27], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [15 43 45 57], 'Port', '2');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [635 25 665 39], 'Port', '1');

for index = 0:n_inputs*4-1,
  reuse_block(blk, ['pol',num2str(index),'_in'], 'built-in/inport', ...
    'Position', [15 73+(index*30) 45 87+(index*30)], ...
    'Port', num2str(3+index));

  reuse_block(blk, ['pol',num2str(index),'_out'], 'built-in/outport', ...
    'Position', [635 53+(index*30) 665 67+(index*30)], 'Port', num2str(2+index));

  % Add ri_to_c blocks.
  if mod(index+1, 2) == 0,
    reuse_block(blk, ['ri_to_c',num2str(floor(index/2))], 'casper_library_misc/ri_to_c', ...
        'Position', [65 74+(((index-1)/2)*60) 105 116+(((index-1)/2)*60)], ...
        'LinkStatus', 'inactive');
    add_line(blk, ['pol',num2str(index-1),'_in/1'],['ri_to_c',num2str(floor(index/2)),'/1']);
    add_line(blk, ['pol',num2str(index),'_in/1'],['ri_to_c',num2str(floor(index/2)),'/2']);

    %connect ri_to_c to bus creators
    if mod(((index+1)/2),2) == 1, bussify_target = 'even';
    else bussify_target = 'odd';
    end

    %connect ri_to_c to bussify blocks
    add_line(blk, ['ri_to_c', num2str(floor(index/2)),'/1'], [bussify_target, '_bussify/', num2str(floor(index/4)+1)]);
  end

  %connect debus outputs to output
  add_line(blk, ['pol', num2str(mod(index,4)), '_debus/', num2str(floor(index/4)+1)], ['pol', num2str(index),'_out/1']); 
end

reuse_block(blk, 'of', 'built-in/outport', 'Position', [400 150 430 164], 'Port', num2str(1+(n_inputs*4)+1));

if strcmp(async, 'on'),
  reuse_block(blk, 'en', 'built-in/inport', ...
    'Position', [195 73+(((n_inputs*4)+1)*30) 225 87+(((n_inputs*4)+1)*30)], 'Port', num2str(2+(n_inputs*4)+1));
  reuse_block(blk, 'dvalid', 'built-in/outport', ...
    'Position', [535 53+(((n_inputs*4)+1)*30) 565 67+(((n_inputs*4)+1)*30)], 'Port', num2str(1+(n_inputs*4)+1+1));
end

%
% Add biplex_core block.
%

reuse_block(blk, 'biplex_core', 'casper_library_ffts/biplex_core', ...
    'Position', [250 30 335 125], ...
    'n_inputs', num2str(n_inputs), ...
    'FFTSize', num2str(FFTSize), ...
    'input_bit_width', num2str(input_bit_width), ...
    'bin_pt_in', num2str(bin_pt_in), ...
    'coeff_bit_width', num2str(coeff_bit_width), ...
    'async', async, ...
    'add_latency', num2str(add_latency), ...
    'mult_latency', num2str(mult_latency), ...
    'bram_latency', num2str(bram_latency), ...
    'conv_latency', num2str(conv_latency), ...
    'quantization', quantization, ...
    'overflow', overflow, ...
    'delays_bit_limit', num2str(delays_bit_limit), ...
    'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
    'coeff_sharing', coeff_sharing, ...
    'coeff_decimation', coeff_decimation, ...
    'max_fanout', num2str(max_fanout), ...
    'mult_spec', mat2str(mult_spec), ...
    'bitgrowth', bitgrowth, ...
    'max_bits', num2str(max_bits), ...
    'hardcode_shifts', hardcode_shifts, ...
    'shift_schedule', mat2str(shift_schedule), ...
    'dsp48_adders', dsp48_adders);

add_line(blk, 'sync/1', 'biplex_core/1');
add_line(blk, 'shift/1', 'biplex_core/2');
add_line(blk, 'even_bussify/1', 'biplex_core/3');
add_line(blk, 'odd_bussify/1', 'biplex_core/4');

if strcmp(async, 'on'), add_line(blk, 'en/1', 'biplex_core/5');
end

add_line(blk, 'biplex_core/4', 'of/1');

%
% Add bi_real_unscr_4x block.
%

reuse_block(blk, 'bi_real_unscr_4x', 'casper_library_ffts_internal/bi_real_unscr_4x', ...
    'Position', [380 30 455 120], ...
    'n_inputs', num2str(n_inputs), ...
    'FFTSize', num2str(FFTSize), ...
    'n_bits', num2str(n_bits_out), ...
    'bin_pt', num2str(bin_pt_in), ...
    'add_latency', 'add_latency', ...
    'conv_latency', 'conv_latency', ...
    'bram_latency', 'bram_latency', ...
    'bram_map', 'off', ...
    'bram_delays', bram_delays, ...
    'dsp48_adders', dsp48_adders, ...
    'async', async);

add_line(blk, 'biplex_core/1', 'bi_real_unscr_4x/1');
add_line(blk, 'biplex_core/2', 'bi_real_unscr_4x/2');
add_line(blk, 'biplex_core/3', 'bi_real_unscr_4x/3');

if strcmp(async, 'on'), 
  add_line(blk, 'biplex_core/5', 'bi_real_unscr_4x/4');
  add_line(blk, 'bi_real_unscr_4x/6', 'dvalid/1');
end

add_line(blk, 'bi_real_unscr_4x/1', 'sync_out/1');
add_line(blk, 'bi_real_unscr_4x/2', 'pol0_debus/1');
add_line(blk, 'bi_real_unscr_4x/3', 'pol1_debus/1');
add_line(blk, 'bi_real_unscr_4x/4', 'pol2_debus/1');
add_line(blk, 'bi_real_unscr_4x/5', 'pol3_debus/1');

% Delete all unconnected blocks.
clean_blocks(blk);

%%%%%%%%%%%%%%%%%%%
% Finish drawing! %
%%%%%%%%%%%%%%%%%%%

% Set attribute format string (block annotation).
fmtstr = sprintf('%d stages\n[%d,%d]\n%s\n%s', ...
    FFTSize, input_bit_width, coeff_bit_width, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);

% Save block state to stop repeated init script runs.
save_state(blk, 'defaults', defaults, varargin{:});

clog('exiting fft_biplex_real_4x_init',{'trace','fft_biplex_real_4x_init_debug'});

