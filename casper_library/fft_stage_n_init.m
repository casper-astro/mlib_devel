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

%flag error and over-ride if trying to use BRAMs but delay is less than BRAM latency
if (2^(FFTSize-FFTStage) < bram_latency)
    if strcmp(delays_bram,'on')
        disp('fft_stage_n_init: using BRAMs for delays but BRAM latency larger than delay! Forcing use of distributed RAM.');
        clog('fft_stage_n_init: using BRAMs for delays but BRAM latency larger than delay! Forcing use of distributed RAM.','error');
    end
    delays_bram = 'off';
end

% Implement delays normally or in BRAM
delays = {'delay_f', 'delay_b'};
for i=1:length(delays),
    full_path = [blk,'/',delays{i}];
    if strcmp(delays_bram,'on'),
        replace_block(blk,'Name',delays{i},'casper_library_delays/delay_bram','noprompt');
        set_param(full_path,'LinkStatus','inactive', 'DelayLen', '2^(FFTSize-FFTStage)', 'bram_latency', 'bram_latency');
    else
        replace_block(blk,'Name',delays{i},'casper_library_delays/delay_slr','noprompt');
        set_param(full_path,'LinkStatus','inactive', 'DelayLen', '2^(FFTSize-FFTStage)');
    end
end

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
    'biplex', 'on', ...
    'Coeffs', tostring(Coeffs), ...
    'StepPeriod', tostring(StepPeriod), ...
    'FFTSize', num2str(FFTSize), ...
    'input_bit_width', num2str(input_bit_width), ...
    'coeff_bit_width', num2str(coeff_bit_width), ...
    'add_latency', num2str(add_latency), ...
    'mult_latency', num2str(mult_latency), ...
    'bram_latency', num2str(bram_latency), ...
    'coeffs_bram', tostring(coeffs_bram), ...
    'conv_latency', num2str(conv_latency), ...
    'quantization', tostring(quantization), ...
    'overflow', tostring(overflow), ...
    'arch', tostring(arch), ...
    'opt_target', tostring(opt_target), ...
    'use_hdl', tostring(use_hdl), ...
    'use_embedded', tostring(use_embedded), ...
    'hardcode_shifts', tostring(hardcode_shifts), ...
    'downshift', tostring(downshift), ...
    'dsp48_adders', tostring(dsp48_adders));

clean_blocks(blk);
del = 'slices';
coeff = 'slices';
if strcmp(delays_bram,'on') del = 'BRAM'; end
if strcmp(coeffs_bram,'on') coeff = 'BRAM'; end

fmtstr = sprintf('[%d/%d]\ndelays in %s\ncoeffs in %s\n', FFTStage, FFTSize, del, coeff);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_stage_n_init','trace');
