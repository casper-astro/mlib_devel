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
    'FFTSize', 5, ...
    'FFTStage', 4, ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'coeff_bit_width', 18, ...
    'bitgrowth', 'off', ...
    'downshift', 'off', ...
    'async', 'off', ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 1, ...
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

reuse_block(blk, 'in1', 'built-in/Inport', 'Port', '1', 'Position', [5 88 35 102]);
reuse_block(blk, 'in2', 'built-in/Inport', 'Port', '2', 'Position', [5 198 35 212]);
reuse_block(blk, 'of_in', 'built-in/Inport', 'Port', '3', 'Position', [880 333 910 347]);
reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '4', 'Position', [5 308 35 322]);
reuse_block(blk, 'shift', 'built-in/Inport', 'Port', '5', 'Position', [540 418 570 432]);

if strcmp(async, 'on'), 
  reuse_block(blk, 'en', 'built-in/Inport', 'Port', '6', 'Position', [5 458 35 472]);
  reuse_block(blk, 'din1', 'xbsIndex_r4/Delay', 'latency', '1', 'reg_retiming', 'on', 'Position', [80 85 110 105]);
  add_line(blk, 'in1/1', 'din1/1');
  reuse_block(blk, 'dsync0', 'xbsIndex_r4/Delay', 'latency', '1', 'reg_retiming', 'on', 'Position', [80 295 110 315]);
  add_line(blk, 'sync/1', 'dsync0/1');
  
  reuse_block(blk, 'en_replicate0', 'casper_library_bus/bus_replicate', ...
    'replication', '2', 'latency', '1', 'misc', 'off', 'Position', [65 455 95 475]);
  add_line(blk, 'en/1', 'en_replicate0/1');
  reuse_block(blk, 'bus_expand0', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', '2', ...
    'outputWidth', '1', 'outputBinaryPt', '0', 'outputArithmeticType', '2', ...
    'Position', [140 445 190 485]);
  add_line(blk, 'en_replicate0/1', 'bus_expand0/1');
  
end

%%%%%%%%%
% logic %
%%%%%%%%%

if strcmp(async, 'on'), en = 'on';
else en = 'off';
end

reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
        'n_bits', 'FFTSize-FFTStage+1', 'rst', 'on', ...
        'explicit_period', 'off', 'use_rpm', 'off', 'en', en, ...
        'Position', [210 105 245 140]);
if strcmp(async, 'on'), 
  add_line(blk, 'dsync0/1', 'counter/1');
  add_line(blk, 'bus_expand0/1', 'counter/2');
else,
  add_line(blk,'sync/1', 'counter/1');
end

reuse_block(blk, 'slice1', 'xbsIndex_r4/Slice', 'Position', [295 115 325 135]);
add_line(blk,'counter/1', 'slice1/1');

reuse_block(blk, 'mux1', 'xbsIndex_r4/Mux', ...
        'latency', '1', 'precision', 'Full', ...
        'Position', [375 47 400 143]);

if strcmp(async, 'on'), 
  add_line(blk,'din1/1', 'mux1/2');
  latency = '2';
else, 
  add_line(blk,'in1/1', 'mux1/2');
  latency = '1';
end
add_line(blk,'slice1/1', 'mux1/1');

reuse_block(blk, 'mux0', 'xbsIndex_r4/Mux', ...
        'latency', latency, 'precision', 'Full', ...
        'Position', [375 157 400 253]);

if strcmp(async, 'on'), add_line(blk, 'din1/1', 'mux0/3');
else, add_line(blk, 'in1/1', 'mux0/3');
end

add_line(blk,'slice1/1','mux0/1');

reuse_block(blk, 'dsync1', 'xbsIndex_r4/Delay', ...
        'latency', '1', 'reg_retiming', 'on', ...
        'Position', [370 305 400 325]);

if strcmp(async, 'on'), add_line(blk, 'dsync0/1', 'dsync1/1');
else, add_line(blk, 'sync/1', 'dsync1/1');
end

if strcmp(delays_bram, 'on'), outputNum = 4;
else, outputNum = 3;
end

if strcmp(async, 'on'),
  reuse_block(blk, 'en_replicate1', 'casper_library_bus/bus_replicate', ...
    'replication', num2str(outputNum), 'latency', '1', 'misc', 'off', 'Position', [330 466 360 484]);
  add_line(blk, 'bus_expand0/2', 'en_replicate1/1');
  reuse_block(blk, 'bus_expand1', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(outputNum), ...
    'outputWidth', '1', 'outputBinaryPt', '0', 'outputArithmeticType', '2', ...
    'Position', [405 450 455 500]);
  add_line(blk, 'en_replicate1/1', 'bus_expand1/1');
end

% Implement delays normally or in BRAM

if strcmp(delays_bram, 'on'),

  dpos = {[210 160 265 250], [570 50 625 140]};
  apos = {[65 164 125 186], [480 54 540 76]};
  wpos = {[165 228 180 242], [530 118 545 132]};
  tpos = {[280 220 300 240], [640 110 660 130]};

  for n=1:2,
    delay = ['delay', num2str(n-1)];
    addr = ['addr', num2str(n-1)];
    we = ['we', num2str(n-1)];
    t = ['t', num2str(n-1)];

    reuse_block(blk, we, 'xbsIndex_r4/Constant', ...
      'const', '1', 'arith_type', 'Boolean', 'explicit_period', 'on', 'period', '1', ...
      'Position', wpos{n});

    reuse_block(blk, addr, 'xbsIndex_r4/Counter', ...
      'cnt_type', 'Count Limited', 'n_bits', 'FFTSize-FFTStage', 'bin_pt', '0', ...
      'cnt_to', '2^(FFTSize-FFTStage)-bram_latency-1', ...
      'explicit_period', 'off', 'use_rpm', 'off', 'en', async, ...
      'Position', apos{n});

    %add latency if asynchronous
    if strcmp(async, 'on'), fan_latency = 1;
    else, fan_latency = 0;
    end

    reuse_block(blk, delay, 'casper_library_bus/bus_single_port_ram', ...
      'n_bits', 'repmat(input_bit_width, 1, n_inputs*2)', ...
      'bin_pts', 'repmat(bin_pt_in, 1, n_inputs*2)', ...
      'init_vector', 'zeros(2^(FFTSize-FFTStage), n_inputs*2)', ...
      'max_fanout', '1', 'mem_type', 'Block RAM', 'bram_optimization', 'Speed and Area', ...
      'async', async, 'misc', 'off', ...
      'bram_latency', num2str(bram_latency), 'fan_latency', num2str(fan_latency), ...
      'addr_register', async, 'din_register', async, ...
      'we_register', async, 'en_register', async, ...
      'Position', dpos{n}); 

    add_line(blk, [addr, '/1'], [delay, '/1']);
    add_line(blk, [we, '/1'],   [delay, '/3']);

    if strcmp(async, 'on'),
      reuse_block(blk, t, 'built-in/Terminator', 'Position', tpos{n});
      add_line(blk, [delay, '/2'], [t, '/1']);
    end
  end %for
  
  if strcmp(async, 'on'),
    add_line(blk, 'en/1', 'addr0/1');
    add_line(blk, 'bus_expand1/4', 'addr1/1');
    add_line(blk, 'en/1', 'delay0/4');
    add_line(blk, 'bus_expand1/1', 'delay1/4');
  end

  add_line(blk, 'in2/1', 'delay0/2');
  add_line(blk, 'mux1/1', 'delay1/2');
else,

  reuse_block(blk, 'delay0', 'casper_library_delays/delay_slr', ...
    'DelayLen', '2^(FFTSize-FFTStage)', 'async', async, ...
    'Position', [210 195 250 235]);

  if strcmp(async, 'on'),   
    reuse_block(blk, 'din2', 'xbsIndex_r4/Delay', 'latency', '1', ...
      'reg_retiming', 'on', 'Position', [80 195 110 215]);
    add_line(blk, 'in2/1', 'din2/1');
    add_line(blk, 'din2/1', 'delay0/1');

    reuse_block(blk, 'den0', 'xbsIndex_r4/Delay', 'latency', '1', ...
      'reg_retiming', 'on', 'Position', [80 235 110 255]);
    add_line(blk, 'en/1', 'den0/1');
    add_line(blk, 'den0/1', 'delay0/2');
  else, 
    add_line(blk, 'in2/1', 'delay0/1');
  end 
 
  reuse_block(blk, 'delay1', 'casper_library_delays/delay_slr', ...
    'DelayLen', '2^(FFTSize-FFTStage)', 'async', async, ...
    'Position', [575 85 615 125]);
  if strcmp(async, 'on'),   
    reuse_block(blk, 'dmux1', 'xbsIndex_r4/Delay', 'latency', '1', ...
      'reg_retiming', 'on', 'Position', [525 85 555 105]);
    add_line(blk, 'mux1/1', 'dmux1/1');
    add_line(blk, 'dmux1/1', 'delay1/1');

    reuse_block(blk, 'den1', 'xbsIndex_r4/Delay', 'latency', '1', ...
      'reg_retiming', 'on', 'Position', [525 125 555 145]);
    add_line(blk, 'bus_expand1/1', 'den1/1');
    add_line(blk, 'den1/1', 'delay1/2');
  else, 
    add_line(blk, 'mux1/1', 'delay1/1');
  end 
end %if 

add_line(blk, 'delay0/1', 'mux1/3');
add_line(blk, 'delay0/1', 'mux0/2');

if strcmp(async, 'on'), 
  sync_delay_type = 'casper_library_delays/sync_delay_en';
else, 
  sync_delay_type = 'casper_library_delays/sync_delay';
end

reuse_block(blk, 'sync_delay', sync_delay_type, ...
  'DelayLen', '2^(FFTSize - FFTStage)', 'Position', [525 294 565 336]);
add_line(blk,'dsync1/1','sync_delay/1');

if strcmp(async, 'on'),

  reuse_block(blk, 'logical0', 'xbsIndex_r4/Logical', ...
    'logical_function', 'AND', 'inputs', '2', 'latency', '1', ...
    'precision', 'Full', 'Position', [600 295 630 335]);
  add_line(blk, 'sync_delay/1', 'logical0/1');
  add_line(blk, 'bus_expand1/3', 'logical0/2');

  reuse_block(blk, 'delay4', 'xbsIndex_r4/Delay', 'latency', '1', ...
    'Position', [600 480 630 500]);
  add_line(blk, 'bus_expand1/3', 'delay4/1');

  add_line(blk, 'bus_expand1/2', 'sync_delay/2');

end

reuse_block(blk, 'slice0', 'xbsIndex_r4/Slice', ...
        'boolean_output', 'on', 'mode', 'Lower Bit Location + Width', ...
        'bit1', '-(FFTStage - 1)', 'bit0', 'FFTStage - 1', ...
        'Position', [615 415 645 435]);
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
    'async', async, ...
    'add_latency', 'add_latency', 'mult_latency', 'mult_latency', ...
    'bram_latency', 'bram_latency', 'conv_latency', 'conv_latency', ...
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
    'Position', [685 39 805 481]);

add_line(blk,'mux0/1','butterfly_direct/2');

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
  'Position', [955 303 985 352]);
add_line(blk, 'of_in/1', 'logical1/2');
add_line(blk, 'butterfly_direct/3', 'logical1/1');

%%%%%%%%%%%%%%%%
% output ports %
%%%%%%%%%%%%%%%%

reuse_block(blk, 'out1', 'built-in/Outport', 'Port', '1', ...
        'Position', [860 88 890 102]);
add_line(blk,'butterfly_direct/1','out1/1');

reuse_block(blk, 'out2', 'built-in/Outport', 'Port', '2', ...
        'Position', [860 198 890 212]);
add_line(blk,'butterfly_direct/2','out2/1');

reuse_block(blk, 'of', 'built-in/Outport', 'Port', '3', ...
        'Position', [1035 323 1065 337]);
add_line(blk, 'logical1/1', 'of/1');

reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '4', ...
        'Position', [850 418 880 432]);
add_line(blk,'butterfly_direct/4','sync_out/1');

if strcmp(async, 'on'),
  reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '5', ...
          'Position', [850 478 880 492]);
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
