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
log_group = 'fft_stage_n_init_debug';

clog('entering fft_stage_n_init', {log_group, 'trace'});

% Set default vararg values.
defaults = { ...
    'n_inputs', 3, ...
    'FFTSize', 5, ...
    'FFTStage', 5, ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'coeff_bit_width', 18, ...
    'floating_point', 'off', ...
    'float_type', 'single', ...
    'exp_width', 8, ...
    'frac_width', 24, ...       
    'bitgrowth', 'off', ...
    'downshift', 'off', ...
    'async', 'off', ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 1, ...
    'conv_latency', 1, ...
    'add_pipe_latency', 0, ...
    'mult_pipe_latency', 0, ...       
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Wrap', ...
    'delays_bram', 'on', ...
    'coeffs_bit_limit', 8, ...
    'coeff_sharing', 'on', ...
    'coeff_decimation', 'on', ...
    'max_fanout', 1, ...
    'use_hdl', 'off', ...
    'use_embedded', 'off', ...
    'hardcode_shifts', 'off', ...
    'dsp48_adders', 'off', ...
};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_stage_n_init post same_state',{log_group, 'trace'});
check_mask_type(blk, 'fft_stage_n');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
n_inputs          = get_var('n_inputs', 'defaults', defaults, varargin{:});
FFTSize           = get_var('FFTSize', 'defaults', defaults, varargin{:});
FFTStage          = get_var('FFTStage', 'defaults', defaults, varargin{:});
input_bit_width   = get_var('input_bit_width', 'defaults', defaults, varargin{:});
bin_pt_in         = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
coeff_bit_width   = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
floating_point    = get_var('floating_point', 'defaults', defaults, varargin{:});
float_type        = get_var('float_type', 'defaults', defaults, varargin{:});
exp_width         = get_var('exp_width', 'defaults', defaults, varargin{:});
frac_width        = get_var('frac_width', 'defaults', defaults, varargin{:});
bitgrowth         = get_var('bitgrowth', 'defaults', defaults, varargin{:});
downshift         = get_var('downshift', 'defaults', defaults, varargin{:});
async             = get_var('async', 'defaults', defaults, varargin{:});
add_latency       = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency      = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency      = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency      = get_var('conv_latency', 'defaults', defaults, varargin{:});
add_pipe_latency  = get_var('add_pipe_latency', 'defaults', defaults, varargin{:});
mult_pipe_latency = get_var('mult_pipe_latency', 'defaults', defaults, varargin{:});
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
  clog('exiting fft_stage_n_init',{log_group, 'trace'});
  return;
end

% bin_pt_in == -1 is a special case for backwards compatibility
if bin_pt_in == -1
  bin_pt_in = input_bit_width - 1;
  set_mask_params(blk, 'bin_pt_in', num2str(bin_pt_in));
end

%flag error and over-ride if trying to use BRAMs but delay is less than BRAM latency
if (2^(FFTSize-FFTStage) < bram_latency)
    if strcmp(delays_bram, 'on')
        warning('fft_stage_n_init: using BRAMs for delays but BRAM latency larger than delay! Forcing use of distributed RAM.');
        clog('using BRAMs for delays but BRAM latency larger than delay! Forcing use of distributed RAM.',{log_group, 'error'});
    end
    delays_bram = 'off';
end

%calculate data path width so that mux latency can be increased if needed
n_bits_dp = input_bit_width * n_inputs * 2;
if n_bits_dp < 50, mux_latency = 1;
else mux_latency = 2;
end

%%%%%%%%%%%%%%%
% input ports %
%%%%%%%%%%%%%%%

reuse_block(blk, 'in1', 'built-in/Inport', 'Port', '1', 'Position', [5 88 35 102]);
reuse_block(blk, 'in2', 'built-in/Inport', 'Port', '2', 'Position', [5 198 35 212]);
reuse_block(blk, 'of_in', 'built-in/Inport', 'Port', '3', 'Position', [970 333 1000 347]);
reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '4', 'Position', [5 298 35 312]);
reuse_block(blk, 'shift', 'built-in/Inport', 'Port', '5', 'Position', [630 418 660 432]);

% registers to control fanout for signals into delay buffers

if strcmp(delays_bram, 'on'),
  % if we have a 'large' delay buffer in bram, add appropriate delay
  % based on an approximation of the number of BRAMs required from bit width and buffer depth
  %TODO this should be a separate function based on architecture, bit width etc
 
  % input bit width per BRAM
  riv = (FFTSize-FFTStage);
  if      (riv >= 14), word_size = 1;
  elseif  (riv >= 13), word_size = 2;
  elseif  (riv >= 12), word_size = 4;
  elseif  (riv >= 11), word_size = 9;
  elseif  (riv >= 10), word_size = 18;
  else,                word_size = 36;
  end

  % number of BRAMs to handle input width
  n_brams = ceil((n_inputs * input_bit_width * 2)/word_size);

  fan_latency = max(1, ceil(log2(n_brams)));
  clog(['Using input latency of ', num2str(fan_latency), ' for ', num2str(n_brams),' bram/s in biplex core stage ', num2str(FFTStage)], log_group);
else,
  %otherwise we control fanout based on the number of input streams
  fan_latency = max(0, ceil(log2(n_inputs/max_fanout)));
  clog(['Using input latency of ', num2str(fan_latency), ' for ', num2str(n_inputs),' streams in biplex core stage ', num2str(FFTStage)], log_group);
end

reuse_block(blk, 'din0', 'xbsIndex_r4/Delay', 'latency', num2str(fan_latency), 'reg_retiming', 'on', 'Position', [95 85 125 105]);
add_line(blk, 'in1/1', 'din0/1');

reuse_block(blk, 'dsync0', 'xbsIndex_r4/Delay', 'latency', num2str(fan_latency), 'reg_retiming', 'on', 'Position', [95 295 125 315]);
add_line(blk, 'sync/1', 'dsync0/1');

if strcmp(async, 'on'), 
  reuse_block(blk, 'en', 'built-in/Inport', 'Port', '6', 'Position', [5 458 35 472]);

  if strcmp(delays_bram, 'on'), latency = fan_latency + bram_latency;
  else, latency = fan_latency;
  end  

  reuse_block(blk, 'en_replicate0', 'casper_library_bus/bus_replicate', ...
    'replication', '2', 'latency', num2str(latency), 'misc', 'off', 'Position', [95 455 125 475]);
  add_line(blk, 'en/1', 'en_replicate0/1');
  reuse_block(blk, 'bus_expand0', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', '2', ...
    'outputWidth', '1', 'outputBinaryPt', '0', 'outputArithmeticType', '2', ...
    'Position', [215 445 265 485]);
  add_line(blk, 'en_replicate0/1', 'bus_expand0/1');
end

reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
        'n_bits', 'FFTSize-FFTStage+1', 'rst', 'on', ...
        'en', async, 'use_behavioral_HDL', 'off', 'implementation', 'Fabric', ...
        'Position', [300 107 335 143]);

if strcmp(async, 'on'), add_line(blk, 'bus_expand0/1', 'counter/2');
end

reuse_block(blk, 'slice1', 'xbsIndex_r4/Slice', 'Position', [385 115 415 135]);
add_line(blk,'counter/1', 'slice1/1');

reuse_block(blk, 'mux1', 'xbsIndex_r4/Mux', ...
        'latency', num2str(mux_latency), 'precision', 'Full', ...
        'Position', [465 47 490 143]);

add_line(blk,'slice1/1', 'mux1/1');

reuse_block(blk, 'mux0', 'xbsIndex_r4/Mux', ...
        'latency', num2str(mux_latency), 'precision', 'Full', ...
        'Position', [465 157 490 253]);
add_line(blk, 'slice1/1', 'mux0/1');

if strcmp(delays_bram, 'on'), latency = bram_latency + fan_latency;
else, latency = fan_latency;
end

reuse_block(blk, 'dmux0', 'xbsIndex_r4/Delay', 'latency', num2str(latency), ...
  'reg_retiming', 'on', 'Position', [670 195 700 215]);
add_line(blk, 'mux0/1', 'dmux0/1');

latency = mux_latency;
if strcmp(async, 'off'), 
  if strcmp(delays_bram, 'on'), latency = mux_latency + fan_latency + bram_latency;
  else, latency = mux_latency + fan_latency;
  end
end
reuse_block(blk, 'dsync1', 'xbsIndex_r4/Delay', ...
        'latency', num2str(latency), 'reg_retiming', 'on', ...
        'Position', [460 295 490 315]);

if strcmp(delays_bram, 'on'), outputNum = 4;
else, outputNum = 3;
end

if strcmp(async, 'on'),
  reuse_block(blk, 'en_replicate1', 'casper_library_bus/bus_replicate', ...
    'replication', num2str(outputNum), 'latency', num2str(mux_latency), 'misc', 'off', 'Position', [395 466 425 484]);
  add_line(blk, 'bus_expand0/2', 'en_replicate1/1');
  reuse_block(blk, 'bus_expand1', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(outputNum), ...
    'outputWidth', '1', 'outputBinaryPt', '0', 'outputArithmeticType', '2', ...
    'Position', [470 460 520 515]);
  add_line(blk, 'en_replicate1/1', 'bus_expand1/1');
end

% Implement delays in logic or in BRAM

if strcmp(delays_bram, 'on'),

  reuse_block(blk, 'dsync2', 'xbsIndex_r4/Delay', 'latency', num2str(bram_latency), 'reg_retiming', 'on', 'Position', [225 295 255 315]);
  add_line(blk, 'dsync0/1', 'dsync2/1');
  add_line(blk, 'dsync2/1', 'dsync1/1');
  add_line(blk, 'dsync2/1', 'counter/1');

  reuse_block(blk, 'din1', 'xbsIndex_r4/Delay', 'latency', num2str(bram_latency), 'reg_retiming', 'on', 'Position', [225 85 255 105]);
  add_line(blk, 'din0/1', 'din1/1');
  add_line(blk, 'din1/1', 'mux1/2');
  add_line(blk, 'din1/1', 'mux0/3');

  dpos = {[210 158 265 252], [660 48 715 142]};
  apos = {[70 161 115 189], [540 51 585 79]};
  wpos = {[135 232 155 248], [585 122 605 138]};

  for n=1:2,
    delay = ['delay', num2str(n-1)];
    addr = ['addr', num2str(n-1)];
    we = ['we', num2str(n-1)];

    reuse_block(blk, addr, 'xbsIndex_r4/Counter', ...
      'cnt_type', 'Free Running', 'n_bits', num2str(FFTSize-FFTStage), 'bin_pt', '0', ...
      'en', async, 'use_behavioral_HDL', 'off', 'implementation', 'Fabric', ...
      'Position', apos{n});

    if strcmp(async, 'on'), we_implementation = 'core';
    else, we_implementation = 'behavioral';
    end

    reuse_block(blk, delay, 'casper_library_bus/bus_single_port_ram', ...
      'n_bits', mat2str(repmat(input_bit_width, 1, n_inputs*2)), ...
      'bin_pts', mat2str(repmat(bin_pt_in, 1, n_inputs*2)), ...
      'init_vector', ['zeros(2^', num2str(FFTSize-FFTStage),', ',num2str(n_inputs*2),')'], ...
      'max_fanout', num2str(max_fanout), 'mem_type', 'Block RAM', 'bram_optimization', 'Speed', ...
      'async', 'off', 'misc', 'off', ...
      'bram_latency', num2str(bram_latency), 'fan_latency', num2str(fan_latency), ...
      'addr_register', 'on', 'addr_implementation', 'core', ...
      'en_register', 'off', 'en_implementation', 'behavioral', ...
      'we_register', 'on', 'we_implementation', we_implementation, ...
      'din_register', 'on', 'din_implementation', 'behavioral', ...
      'Position', dpos{n}); 

    add_line(blk, [addr, '/1'], [delay, '/1']);

    if strcmp(async, 'off')
      reuse_block(blk, we, 'xbsIndex_r4/Constant', ...
          'arith_type', 'Boolean', 'const', '1', ...
          'n_bits', '1', 'bin_pt', '0', ...
          'explicit_period', 'on', 'period', '1', ...
          'Position', wpos{n});
      add_line(blk, [we, '/1'], [delay, '/3']);
    end %if

  end %for
  
  if strcmp(async, 'on'),
    add_line(blk, 'en/1', 'addr0/1');
    add_line(blk, 'bus_expand1/4', 'addr1/1');
    add_line(blk, 'en/1', 'delay0/3');
    add_line(blk, 'bus_expand1/1', 'delay1/3');
  end

  add_line(blk, 'in2/1', 'delay0/2');
  add_line(blk, 'mux1/1', 'delay1/2');

else,
  add_line(blk, 'din0/1', 'mux1/2');
  add_line(blk, 'din0/1', 'mux0/3');
 
  add_line(blk, 'dsync0/1', 'dsync1/1');
  add_line(blk, 'dsync0/1', 'counter/1');

  reuse_block(blk, 'delay0', 'casper_library_bus/bus_delay', ...
    'n_bits', mat2str(repmat(input_bit_width, 1, n_inputs)), 'cmplx', 'on', 'misc', 'off', ...
    'latency', '2^(FFTSize-FFTStage)', 'enable', async, 'reg_retiming', 'on', ...
    'Position', [210 195 250 235]);
    
  reuse_block(blk, 'din2', 'xbsIndex_r4/Delay', 'latency', num2str(fan_latency), ...
    'reg_retiming', 'on', 'Position', [95 195 125 215]);
  add_line(blk, 'in2/1', 'din2/1');
  add_line(blk, 'din2/1', 'delay0/1');
  
  if strcmp(async, 'on'),   
    reuse_block(blk, 'den0', 'casper_library_bus/bus_replicate', ...
      'replication', num2str(n_inputs), 'latency', num2str(fan_latency), ...
      'misc', 'off', 'implementation', 'core', 'Position', [95 235 125 255]);
    add_line(blk, 'en/1', 'den0/1');
    add_line(blk, 'den0/1', 'delay0/2');
  end 
 
  reuse_block(blk, 'delay1', 'casper_library_bus/bus_delay', ...
    'n_bits', mat2str(repmat(input_bit_width, 1, n_inputs)), 'cmplx', 'on', 'misc', 'off', ...
    'latency', '2^(FFTSize-FFTStage)', 'enable', async, 'reg_retiming', 'on', ...
    'Position', [615 85 655 125]);

    reuse_block(blk, 'dmux1', 'xbsIndex_r4/Delay', 'latency', num2str(fan_latency), ...
      'reg_retiming', 'on', 'Position', [540 85 570 105]);
    add_line(blk, 'mux1/1', 'dmux1/1');
    add_line(blk, 'dmux1/1', 'delay1/1');

  if strcmp(async, 'on'),   
    reuse_block(blk, 'den1', 'casper_library_bus/bus_replicate', ...
      'replication', num2str(n_inputs), 'latency', num2str(fan_latency), ...
      'misc', 'off', 'implementation', 'core', 'Position', [540 125 570 145]);
    add_line(blk, 'bus_expand1/1', 'den1/1');
    add_line(blk, 'den1/1', 'delay1/2');
  end 
end %if 

add_line(blk, 'delay0/1', 'mux1/3');
add_line(blk, 'delay0/1', 'mux0/2');

if strcmp(async, 'on'), sync_delay_type = 'casper_library_delays/sync_delay_en';
else, sync_delay_type = 'casper_library_delays/sync_delay';
end

reuse_block(blk, 'sync_delay', sync_delay_type, ...
  'DelayLen', '2^(FFTSize - FFTStage)', 'Position', [615 294 655 336]);
add_line(blk, 'dsync1/1', 'sync_delay/1');

if strcmp(async, 'on'),

  if strcmp(delays_bram, 'on'), latency = bram_latency + fan_latency;
  else, latency = fan_latency;
  end
  reuse_block(blk, 'logical0', 'xbsIndex_r4/Logical', ...
    'logical_function', 'AND', 'inputs', '2', 'latency', num2str(latency), ...
    'precision', 'Full', 'Position', [690 295 720 335]);
  add_line(blk, 'sync_delay/1', 'logical0/1');
  add_line(blk, 'bus_expand1/3', 'logical0/2');

  if strcmp(delays_bram, 'on'), latency = bram_latency + fan_latency;
  else, latency = fan_latency;
  end
  reuse_block(blk, 'delay4', 'xbsIndex_r4/Delay', 'latency', num2str(latency), ...
    'reg_retiming', 'on', 'Position', [675 480 705 500]);
  add_line(blk, 'bus_expand1/3', 'delay4/1');

  add_line(blk, 'bus_expand1/2', 'sync_delay/2');
end

reuse_block(blk, 'slice0', 'xbsIndex_r4/Slice', ...
        'boolean_output', 'on', 'mode', 'Lower Bit Location + Width', ...
        'bit1', '-(FFTStage - 1)', 'bit0', 'FFTStage - 1', ...
        'Position', [710 415 740 435]);
add_line(blk, 'shift/1', 'slice0/1');

% butterfly_direct setup

if(FFTStage == 1 ),
    Coeffs = 0;
else
%    Coeffs = 0:2^min(MaxCoeffNum,FFTStage-1)-1;
    Coeffs = 0:2^(FFTStage-1)-1;
end
%StepPeriod = FFTSize-FFTStage+max(0, FFTStage-MaxCoeffNum);
StepPeriod = FFTSize-FFTStage;

if floating_point == 1
    float_en = 'on';
else
    float_en = 'off';  
end

if float_type == 2
    float_type_sel = 'custom';
else
    float_type_sel = 'single';
end


% Propagate parameters to the butterfly
reuse_block(blk, 'butterfly_direct', 'casper_library_ffts/butterfly_direct', ...
    'n_inputs', num2str(n_inputs), ...
    'biplex', 'on', ...
    'Coeffs', mat2str(Coeffs), ...
    'StepPeriod', num2str(StepPeriod), ...
    'FFTSize', 'FFTSize', ...
    'coeff_bit_width', 'coeff_bit_width', ...
    'input_bit_width', 'input_bit_width', 'bin_pt_in', 'bin_pt_in', ...
    'bitgrowth', bitgrowth, 'downshift', downshift, ...
    'floating_point', float_en, ...
    'float_type', float_type_sel, ...
    'exp_width', num2str(exp_width), ...
    'frac_width', num2str(frac_width), ...   
    'async', async, ...
    'add_latency', 'add_latency', 'mult_latency', 'mult_latency', ...
    'bram_latency', 'bram_latency', 'conv_latency', 'conv_latency', ...
    'add_pipe_latency', num2str(add_pipe_latency), ...
    'mult_pipe_latency', num2str(mult_pipe_latency), ...
    'quantization', quantization, 'overflow', overflow, ...
    'coeffs_bit_limit', 'coeffs_bit_limit', ...
    'coeff_sharing', coeff_sharing, ...
    'coeff_decimation', coeff_decimation, ...
    'coeff_generation', 'off', 'cal_bits', '1', 'n_bits_rotation', '25', ...
    'max_fanout', 'max_fanout', ...
    'use_hdl', use_hdl, ...
    'use_embedded', use_embedded, ...
    'hardcode_shifts', hardcode_shifts, ...
    'dsp48_adders', dsp48_adders, ...
    'Position', [775 39 895 481]);

add_line(blk,'dmux0/1','butterfly_direct/2');

add_line(blk,'slice0/1','butterfly_direct/4');
add_line(blk,'delay1/1','butterfly_direct/1');

if strcmp(async, 'on'), 
  add_line(blk, 'delay4/1', 'butterfly_direct/5');
  add_line(blk, 'logical0/1','butterfly_direct/3');
else,
  add_line(blk, 'sync_delay/1','butterfly_direct/3');
end

reuse_block(blk, 'logical1', 'xbsIndex_r4/Logical', ...
  'logical_function', 'OR', 'latency', '1', 'precision', 'Full', ...
  'Position', [1045 303 1075 352]);
add_line(blk, 'of_in/1', 'logical1/2');
add_line(blk, 'butterfly_direct/3', 'logical1/1');

%%%%%%%%%%%%%%%%
% output ports %
%%%%%%%%%%%%%%%%

reuse_block(blk, 'out1', 'built-in/Outport', 'Port', '1', ...
        'Position', [950 88 980 102]);
add_line(blk,'butterfly_direct/1','out1/1');

reuse_block(blk, 'out2', 'built-in/Outport', 'Port', '2', ...
        'Position', [950 198 980 212]);
add_line(blk,'butterfly_direct/2','out2/1');

reuse_block(blk, 'of', 'built-in/Outport', 'Port', '3', ...
        'Position', [1125 323 1155 337]);
add_line(blk, 'logical1/1', 'of/1');

reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '4', ...
        'Position', [940 418 970 432]);
add_line(blk,'butterfly_direct/4','sync_out/1');

if strcmp(async, 'on'),
  reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '5', ...
          'Position', [940 478 970 492]);
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
clog('exiting fft_stage_n_init', {log_group, 'trace'});
