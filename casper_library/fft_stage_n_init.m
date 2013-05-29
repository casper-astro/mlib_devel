function fft_stage_n_init(blk, varargin)
% Initialize and configure an fft_stage_n block.
%
% fft_stage_n_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
% FFTSize = Size of the FFT (2^FFTSize points).
% FFTStage = Stage this block should be configured as.
% input_bit_width = Bit width of input and output data.
% coeff_bit_width = Bit width of coefficients
% CoeffBram = Store coefficients in bram
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
%   Copyright (C) 2009 Andrew Martens                                         %
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
    'FFTSize', 3, ...
    'FFTStage', 1, ...
    'input_bit_width', 18, ...
    'coeff_bit_width', 18, ...
    'coeffs_bram', 'off', ...
    'delays_bram', 'off', ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Wrap', ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'arch', 'Virtex5', ...
    'opt_target', 'logic', ...
    'use_hdl', 'off', ...
    'use_embedded', 'off', ...
    'hardcode_shifts', 'off', ...
    'downshift', 'off', ...
    'dsp48_adders', 'off', ...
};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_stage_n_init post same_state','trace');
check_mask_type(blk, 'fft_stage_n');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
FFTStage = get_var('FFTStage', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
coeffs_bram = get_var('coeffs_bram', 'defaults', defaults, varargin{:});
delays_bram = get_var('delays_bram', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
use_hdl = get_var('use_hdl', 'defaults', defaults, varargin{:});
use_embedded = get_var('use_embedded', 'defaults', defaults, varargin{:});
hardcode_shifts = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
downshift = get_var('downshift', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

clog(flatstrcell(varargin),'fft_stage_n_init_debug');
delete_lines(blk);

%default state for library
if FFTSize == 0,
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting fft_stage_n_init','trace');
  return;
end

%flag error and over-ride if trying to use BRAMs but delay is less than BRAM latency
if (2^(FFTSize-FFTStage) < bram_latency)
    if strcmp(delays_bram,'on')
        disp('fft_stage_n_init: using BRAMs for delays but BRAM latency larger than delay! Forcing use of distributed RAM.');
        clog('fft_stage_n_init: using BRAMs for delays but BRAM latency larger than delay! Forcing use of distributed RAM.','error');
    end
    delays_bram = 'off';
end

%%%%%%%%%%%%%%%
% input ports %
%%%%%%%%%%%%%%%

reuse_block(blk, 'in1', 'built-in/Inport');
set_param([blk,'/in1'], ...
        'Port', sprintf('1'), ...
        'Position', sprintf('[140 43 170 57]'));

reuse_block(blk, 'in2', 'built-in/Inport');
set_param([blk,'/in2'], ...
        'Port', sprintf('2'), ...
        'Position', sprintf('[85 138 115 152]'));

reuse_block(blk, 'of_in', 'built-in/Inport');
set_param([blk,'/of_in'], ...
        'Port', sprintf('3'), ...
        'Position', sprintf('[615 113 645 127]'));

reuse_block(blk, 'sync', 'built-in/Inport');
set_param([blk,'/sync'], ...
        'Port', sprintf('4'), ...
        'Position', sprintf('[15 203 45 217]'));

reuse_block(blk, 'shift', 'built-in/Inport');
set_param([blk,'/shift'], ...
        'Port', sprintf('5'), ...
        'Position', sprintf('[290 263 320 277]'));

%%%%%%%%%
% logic %
%%%%%%%%%

reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter');
set_param([blk,'/Counter'], ...
        'n_bits', sprintf('FFTSize-FFTStage+1'), ...
        'rst', sprintf('on'), ...
        'explicit_period', sprintf('off'), ...
        'use_rpm', sprintf('off'), ...
        'Position', sprintf('[75 80 115 120]'));
add_line(blk,'sync/1','Counter/1');

reuse_block(blk, 'Slice1', 'xbsIndex_r4/Slice');
set_param([blk,'/Slice1'], ...
        'Position', sprintf('[145 89 170 111]'));
add_line(blk,'Counter/1','Slice1/1');

reuse_block(blk, 'Mux1', 'xbsIndex_r4/Mux');
set_param([blk,'/Mux1'], ...
        'latency', sprintf('1'), ...
        'arith_type', sprintf('Signed  (2''s comp)'), ...
        'n_bits', sprintf('8'), ...
        'bin_pt', sprintf('2'), ...
        'Position', sprintf('[255 15 280 85]'));
add_line(blk,'in1/1','Mux1/2');
add_line(blk,'Slice1/1','Mux1/1');


% Implement delays normally or in BRAM
delays = {'delay_f', 'delay_b'};
for i=1:length(delays),
  full_path = [blk,'/',delays{i}];
  if strcmp(delays_bram,'on'),
    reuse_block(blk, delays{i}, 'casper_library_delays/delay_bram', ...
      'DelayLen', '2^(FFTSize-FFTStage)', 'bram_latency', 'bram_latency'); 
  else
    reuse_block(blk, delays{i}, 'casper_library_delays/delay_slr', ...
      'DelayLen', '2^(FFTSize-FFTStage)'); 
  end
end
set_param([blk,'/delay_f'], 'Position', sprintf('[135 125 180 165]'));
add_line(blk,'in2/1','delay_f/1');
add_line(blk,'delay_f/1','Mux1/3');

set_param([blk,'/delay_b'], 'Position', sprintf('[340 30 385 70]'));
add_line(blk,'Mux1/1','delay_b/1');

reuse_block(blk, 'Mux', 'xbsIndex_r4/Mux');
set_param([blk,'/Mux'], ...
        'latency', sprintf('1'), ...
        'arith_type', sprintf('Signed  (2''s comp)'), ...
        'n_bits', sprintf('8'), ...
        'bin_pt', sprintf('2'), ...
        'Position', sprintf('[255 110 280 180]'));
add_line(blk,'in1/1','Mux/3');
add_line(blk,'Slice1/1','Mux/1');
add_line(blk,'delay_f/1','Mux/2');

reuse_block(blk, 'Delay', 'xbsIndex_r4/Delay');
set_param([blk,'/Delay'], ...
        'Position', sprintf('[250 195 280 225]'));
add_line(blk,'sync/1','Delay/1');

reuse_block(blk, 'sync_delay', 'casper_library_delays/sync_delay');
set_param([blk,'/sync_delay'], ...
        'DelayLen', sprintf('2^(FFTSize - FFTStage)'), ...
        'Position', sprintf('[345 189 385 231]'));
add_line(blk,'Delay/1','sync_delay/1');

reuse_block(blk, 'Slice', 'xbsIndex_r4/Slice');
set_param([blk,'/Slice'], ...
        'boolean_output', sprintf('on'), ...
        'mode', sprintf('Lower Bit Location + Width'), ...
        'bit1', sprintf('-(FFTStage - 1)'), ...
        'bit0', sprintf('FFTStage - 1'), ...
        'Position', sprintf('[340 256 370 284]'));
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

% Propagate parameters to the butterfly
reuse_block(blk, 'butterfly_direct', 'casper_library_ffts/butterfly_direct', ...
    'n_inputs', '1', ...
    'biplex', 'on', ...
    'Coeffs', mat2str(Coeffs), ...
    'StepPeriod', num2str(StepPeriod), ...
    'FFTSize', 'FFTSize', ...
    'input_bit_width', 'input_bit_width', ...
    'coeff_bit_width', 'coeff_bit_width', ...
    'add_latency', 'add_latency', ...
    'mult_latency', 'mult_latency', ...
    'bram_latency', 'bram_latency', ...
    'coeffs_bram', coeffs_bram, ...
    'conv_latency', 'conv_latency', ...
    'quantization', quantization, ...
    'overflow', overflow, ...
    'opt_target', opt_target, ...
    'use_hdl', use_hdl, ...
    'use_embedded', use_embedded, ...
    'hardcode_shifts', hardcode_shifts, ...
    'downshift', downshift, ...
    'dsp48_adders', dsp48_adders, ...
    'Position', [445 39 525 121]);

add_line(blk,'Mux/1','butterfly_direct/2');
add_line(blk,'sync_delay/1','butterfly_direct/3');
add_line(blk,'Slice/1','butterfly_direct/4');
add_line(blk,'delay_b/1','butterfly_direct/1');

reuse_block(blk, 'Logical1', 'xbsIndex_r4/Logical');
set_param([blk,'/Logical1'], ...
        'logical_function', sprintf('OR'), ...
        'latency', sprintf('1'), ...
        'n_bits', sprintf('8'), ...
        'bin_pt', sprintf('2'), ...
        'Position', sprintf('[670 76 710 134]'));
add_line(blk,'of_in/1','Logical1/2');
add_line(blk,'butterfly_direct/3','Logical1/1');

%%%%%%%%%%%%%%%%
% output ports %
%%%%%%%%%%%%%%%%

reuse_block(blk, 'out1', 'built-in/Outport');
set_param([blk,'/out1'], ...
        'Port', sprintf('1'), ...
        'Position', sprintf('[635 43 665 57]'));
add_line(blk,'butterfly_direct/1','out1/1');

reuse_block(blk, 'out2', 'built-in/Outport');
set_param([blk,'/out2'], ...
        'Port', sprintf('2'), ...
        'Position', sprintf('[590 63 620 77]'));
add_line(blk,'butterfly_direct/2','out2/1');

reuse_block(blk, 'of', 'built-in/Outport');
set_param([blk,'/of'], ...
        'Port', sprintf('3'), ...
        'Position', sprintf('[740 98 770 112]'));
add_line(blk,'Logical1/1','of/1');

reuse_block(blk, 'sync_out', 'built-in/Outport');
set_param([blk,'/sync_out'], ...
        'Port', sprintf('4'), ...
        'Position', sprintf('[555 103 585 117]'));
add_line(blk,'butterfly_direct/4','sync_out/1');

clean_blocks(blk);
del = 'slices';
coeff = 'slices';
if strcmp(delays_bram,'on') del = 'BRAM'; end
if strcmp(coeffs_bram,'on') coeff = 'BRAM'; end

fmtstr = sprintf('[%d/%d]\ndelays in %s\ncoeffs in %s\n', FFTStage, FFTSize, del, coeff);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_stage_n_init','trace');
