function fft_stage_n_init(blk, varargin)
% Initialize and configure an fft_stage_n block.
%
% fft_stage_n_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
% n_inputs        = number of inputs being processed in parallel
% FFTSize         = Size of the FFT (2^FFTSize points).
% FFTStage        = Stage this block should be configured as.
% input_bit_width = Bit width of input data.
% bin_pt_in       = Binary point of input data.
% coeff_bit_width = Bit width of coefficients
% bitgrowth       = Option to use bit growth instead of shifting
% downshift       = Downshift if shifts are hard-coded
% CoeffBram       = Store coefficients in bram
% quantization    = Quantization behavior.
% overflow        = Overflow behavior.
% add_latency     = The latency of adders in the system.
% mult_latency    = The latency of multipliers in the system.
% bram_latency    = The latency of BRAM in the system.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
%                                                                             %
%   SKASA radio telescope project                                             %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2009,2013 Andrew Martens                                    %
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

clog('entering fft_stage_n_init','trace');

% Set default vararg values.
defaults = { ...
    'n_inputs', 1, ...
    'FFTSize', 4, ...
    'FFTStage', 4, ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'coeff_bit_width', 18, ...
    'bitgrowth', 'off', ...
    'downshift', 'off', ...
    'async', 'off', ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Wrap', ...
    'delays_bram', 'off', ...
    'coeffs_bit_limit', 8, ...
    'coeff_sharing', 'on', ...
    'coeff_decimation', 'on', ...
    'max_fanout', 4, ...
    'use_hdl', 'off', ...
    'use_embedded', 'off', ...
    'hardcode_shifts', 'off', ...
    'dsp48_adders', 'off', ...
};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_stage_n_init post same_state',{'trace', 'fft_stage_n_init_debug'});
check_mask_type(blk, 'fft_stage_n');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
n_inputs          = get_var('n_inputs', 'defaults', defaults, varargin{:});
FFTSize           = get_var('FFTSize', 'defaults', defaults, varargin{:});
FFTStage          = get_var('FFTStage', 'defaults', defaults, varargin{:});
input_bit_width   = get_var('input_bit_width', 'defaults', defaults, varargin{:});
bin_pt_in         = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
coeff_bit_width   = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
bitgrowth         = get_var('bitgrowth', 'defaults', defaults, varargin{:});
downshift         = get_var('downshift', 'defaults', defaults, varargin{:});
async             = get_var('async', 'defaults', defaults, varargin{:});
add_latency       = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency      = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency      = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency      = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization      = get_var('quantization', 'defaults', defaults, varargin{:});
overflow          = get_var('overflow', 'defaults', defaults, varargin{:});
coeffs_bit_limit  = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
coeff_sharing     = get_var('coeff_sharing', 'defaults', defaults, varargin{:});
coeff_decimation  = get_var('coeff_decimation', 'defaults', defaults, varargin{:});
max_fanout        = get_var('max_fanout', 'defaults', defaults, varargin{:});
delays_bram       = get_var('delays_bram', 'defaults', defaults, varargin{:});
use_hdl           = get_var('use_hdl', 'defaults', defaults, varargin{:});
use_embedded      = get_var('use_embedded', 'defaults', defaults, varargin{:});
hardcode_shifts   = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
dsp48_adders      = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

delete_lines(blk);

%default state for library
if FFTSize == 0 | n_inputs == 0,
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting fft_stage_n_init',{'trace', 'fft_stage_n_init_debug'});
  return;
end

% bin_pt_in == -1 is a special case for backwards compatibility
if bin_pt_in == -1
  bin_pt_in = input_bit_width - 1;
  set_mask_params(blk, 'bin_pt_in', num2str(bin_pt_in));
end

%flag error and over-ride if trying to use BRAMs but delay is less than BRAM latency
if (2^(FFTSize-FFTStage) < bram_latency)
    if strcmp(delays_bram,'on')
        warning('fft_stage_n_init: using BRAMs for delays but BRAM latency larger than delay! Forcing use of distributed RAM.');
        clog('using BRAMs for delays but BRAM latency larger than delay! Forcing use of distributed RAM.',{'error', 'fft_stage_n_init_debug'});
    end
    delays_bram = 'off';
end

%%%%%%%%%%%%%%%
% input ports %
%%%%%%%%%%%%%%%

reuse_block(blk, 'in1', 'built-in/Inport', 'Port', '1', 'Position', [140 43 170 57]);
reuse_block(blk, 'in2', 'built-in/Inport', 'Port', '2', 'Position', [85 138 115 152]);
reuse_block(blk, 'of_in', 'built-in/Inport', 'Port', '3', 'Position', [635 113 665 127]);
reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '4', 'Position', [15 203 45 217]);
reuse_block(blk, 'shift', 'built-in/Inport', 'Port', '5', 'Position', [345 88 375 102]);

if strcmp(async, 'on'), reuse_block(blk, 'en', 'built-in/Inport', 'Port', '6', 'Position', [15 263 45 277]);
end

%%%%%%%%%
% logic %
%%%%%%%%%

if strcmp(async, 'on'), en = 'on';
else en = 'off';
end

reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
        'n_bits', 'FFTSize-FFTStage+1', ...
        'rst', 'on', ...
        'explicit_period', 'off', ...
        'use_rpm', 'off', ...
        'en', en, ...
        'Position', [75 80 115 120]);
add_line(blk,'sync/1','Counter/1');

if strcmp(async, 'on'), 
  add_line(blk, 'en/1', 'Counter/2');
end

reuse_block(blk, 'Slice1', 'xbsIndex_r4/Slice', ...
        'Position', [145 89 170 111]);
add_line(blk,'Counter/1','Slice1/1');

reuse_block(blk, 'Mux1', 'xbsIndex_r4/Mux', ...
        'latency', '1', ...
        'arith_type', 'Signed  (2''s comp)', ...
        'n_bits', '8', ...
        'bin_pt', '2', ...
        'Position', [255 15 280 85]);
add_line(blk,'in1/1','Mux1/2');
add_line(blk,'Slice1/1','Mux1/1');

reuse_block(blk, 'Mux', 'xbsIndex_r4/Mux', ...
        'latency', '1', ...
        'arith_type', 'Signed  (2''s comp)', ...
        'n_bits', '8', ...
        'bin_pt', '2', ...
        'Position', [255 110 280 180]);
add_line(blk,'in1/1','Mux/3');
add_line(blk,'Slice1/1','Mux/1');

reuse_block(blk, 'Delay', 'xbsIndex_r4/Delay', ...
        'latency', '1', ...
        'reg_retiming', 'on', ...
        'Position', [250 195 280 225]);
add_line(blk,'sync/1','Delay/1');

if strcmp(async, 'on'),
  reuse_block(blk, 'Delay1', 'xbsIndex_r4/Delay', ...
          'latency', '1', ...
          'reg_retiming', 'on', ...
          'Position', [250 255 280 285]);
  add_line(blk,'en/1','Delay1/1');
  reuse_block(blk, 'Delay2', 'xbsIndex_r4/Delay', ...
          'latency', '0', ...
          'reg_retiming', 'on', ...
          'Position', [380 255 405 285]);
  add_line(blk,'Delay1/1','Delay2/1');
end

% Implement delays normally or in BRAM
delays = {'delay_f', 'delay_b'};
for i=1:length(delays),
  full_path = [blk,'/',delays{i}];
  if strcmp(delays_bram,'on'),
    reuse_block(blk, delays{i}, 'casper_library_delays/delay_bram', ...
      'async', async, 'DelayLen', '2^(FFTSize-FFTStage)', 'bram_latency', 'bram_latency'); 
  else
    reuse_block(blk, delays{i}, 'casper_library_delays/delay_slr', ...
      'async', async, 'DelayLen', '2^(FFTSize-FFTStage)'); 
  end
end
set_param([blk,'/delay_f'], 'Position', [135 125 180 165]);
add_line(blk,'in2/1','delay_f/1');
add_line(blk,'delay_f/1','Mux1/3');
add_line(blk,'delay_f/1','Mux/2');

set_param([blk,'/delay_b'], 'Position', [340 30 385 70]);
add_line(blk,'Mux1/1','delay_b/1');

if strcmp(async, 'on'), sync_delay_type = 'casper_library_delays/sync_delay_en';
else, sync_delay_type = 'casper_library_delays/sync_delay';
end

reuse_block(blk, 'sync_delay', sync_delay_type, ...
        'DelayLen', '2^(FFTSize - FFTStage)', ...
        'Position', [315 189 355 231]);
add_line(blk,'Delay/1','sync_delay/1');

if strcmp(async, 'on'),
  reuse_block(blk, 'logical', 'xbsIndex_r4/Logical', ...
    'logical_function', 'AND', 'inputs', '2', 'latency', '0', ...
    'precision', 'Full', 'Position', [380 200 405 240]);
  add_line(blk, 'sync_delay/1', 'logical/1');
  add_line(blk, 'Delay1/1', 'logical/2');

  add_line(blk, 'en/1', 'delay_f/2');
  add_line(blk, 'Delay1/1', 'sync_delay/2');
  add_line(blk, 'Delay1/1', 'delay_b/2');
end

reuse_block(blk, 'Slice', 'xbsIndex_r4/Slice', ...
        'boolean_output', 'on', ...
        'mode', 'Lower Bit Location + Width', ...
        'bit1', '-(FFTStage - 1)', ...
        'bit0', 'FFTStage - 1', ...
        'Position', [390 96 420 124]);
add_line(blk,'shift/1','Slice/1');

% butterfly_direct setup

if(FFTStage == 1 ),
    Coeffs = 0;
else
%    Coeffs = 0:2^min(MaxCoeffNum,FFTStage-1)-1;
    Coeffs = 0:2^(FFTStage-1)-1;
end
%StepPeriod = FFTSize-FFTStage+max(0, FFTStage-MaxCoeffNum);
StepPeriod = FFTSize-FFTStage;

if strcmp(async, 'on'), position = [445 41 525 142];
else, position = [445 39 525 121];
end

% Propagate parameters to the butterfly
reuse_block(blk, 'butterfly_direct', 'casper_library_ffts/butterfly_direct', ...
    'n_inputs', num2str(n_inputs), ...
    'biplex', 'on', ...
    'Coeffs', mat2str(Coeffs), ...
    'StepPeriod', num2str(StepPeriod), ...
    'FFTSize', 'FFTSize', ...
    'coeff_bit_width', 'coeff_bit_width', ...
    'input_bit_width', 'input_bit_width', ...
    'bin_pt_in', 'bin_pt_in', ...
    'bitgrowth', bitgrowth, ...
    'downshift', downshift, ...
    'async', async, ...
    'add_latency', 'add_latency', ...
    'mult_latency', 'mult_latency', ...
    'bram_latency', 'bram_latency', ...
    'conv_latency', 'conv_latency', ...
    'quantization', quantization, ...
    'overflow', overflow, ...
    'coeffs_bit_limit', 'coeffs_bit_limit', ...
    'coeff_sharing', coeff_sharing, ...
    'coeff_decimation', coeff_decimation, ...
    'coeff_generation', 'off', ...
    'cal_bits', '1', ...
    'n_bits_rotation', '25', ...
    'max_fanout', 'max_fanout', ...
    'use_hdl', use_hdl, ...
    'use_embedded', use_embedded, ...
    'hardcode_shifts', hardcode_shifts, ...
    'dsp48_adders', dsp48_adders, ...
    'Position', position);

add_line(blk,'Mux/1','butterfly_direct/2');

add_line(blk,'Slice/1','butterfly_direct/4');
add_line(blk,'delay_b/1','butterfly_direct/1');

if strcmp(async, 'on'), 
  add_line(blk, 'Delay2/1', 'butterfly_direct/5');
  add_line(blk, 'logical/1','butterfly_direct/3');
else,
  add_line(blk, 'sync_delay/1','butterfly_direct/3');
end

reuse_block(blk, 'Logical1', 'xbsIndex_r4/Logical');
set_param([blk,'/Logical1'], ...
        'logical_function', 'OR', ...
        'latency', '1', ...
        'n_bits', '8', ...
        'bin_pt', '2', ...
        'Position', [685 76 715 134]);
add_line(blk,'of_in/1','Logical1/2');
add_line(blk,'butterfly_direct/3','Logical1/1');

%%%%%%%%%%%%%%%%
% output ports %
%%%%%%%%%%%%%%%%

reuse_block(blk, 'out1', 'built-in/Outport');
set_param([blk,'/out1'], ...
        'Port', '1', ...
        'Position', [635 43 665 57]);
add_line(blk,'butterfly_direct/1','out1/1');

reuse_block(blk, 'out2', 'built-in/Outport', ...
        'Port', '2', ...
        'Position', [590 63 620 77]);
add_line(blk,'butterfly_direct/2','out2/1');

reuse_block(blk, 'of', 'built-in/Outport', ...
        'Port', '3', ...
        'Position', [740 98 770 112]);
add_line(blk,'Logical1/1','of/1');

reuse_block(blk, 'sync_out', 'built-in/Outport', ...
        'Port', '4', ...
        'Position', [550 103 580 117]);
add_line(blk,'butterfly_direct/4','sync_out/1');

if strcmp(async, 'on'),
  reuse_block(blk, 'dvalid', 'built-in/Outport', ...
          'Port', '5', ...
          'Position', [595 123 625 137]);
  add_line(blk,'butterfly_direct/5','dvalid/1');
end

clean_blocks(blk);
del = 'slices';
coeff = 'slices';
if strcmp(delays_bram,'on') del = 'BRAM'; end

if strcmp(bitgrowth, 'on')
  shifting = 'bit growth';
elseif strcmp(hardcode_shifts, 'on'),
  if strcmp(downshift, 'on'), shifting = 'shift forced on';
  else shifting = 'shift forced off';
  end
else
  shifting = 'dynamic shifting';
end
fmtstr = sprintf('[%d/%d]\ndelays in %s\n%s\n', FFTStage, FFTSize, del, shifting);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_stage_n_init','trace');
