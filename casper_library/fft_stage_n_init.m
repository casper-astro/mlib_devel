%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
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

function fft_stage_n_init(blk, varargin)

% Initialize and configure a single FFT stage.
%
% fft_stage_n_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points).
% FFTStage = Stage this block should be configured as.
% input_bit_width = Bit width of input and output data.
% coeff_bit_width = Bit width of coefficients
% use_bram = Use bram or slr delays
% CoeffBram = Store coefficients in bram
% MaxCoeffNum =
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'fft_stage_n');
munge_block(blk, varargin{:});

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
FFTStage = get_var('FFTStage', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
use_bram = get_var('use_bram', 'defaults', defaults, varargin{:});
coeffs_bram = get_var('coeffs_bram', 'defaults', defaults, varargin{:});
delays_bram = get_var('delays_bram', 'defaults', defaults, varargin{:});
MaxCoeffNum = get_var('MaxCoeffNum', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
use_hdl = get_var('use_hdl', 'defaults', defaults, varargin{:});
use_embedded = get_var('use_embedded', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('use_embedded', 'defaults', defaults, varargin{:});

% Implement delays normally or in BRAM
delays = {'delay_f', 'delay_b'};
for i=1:length(delays),
    full_path = [blk,'/',delays{i}];
    if strcmp(delays_bram,'on'),
        replace_block(blk,'Name',delays{i},'casper_library/Delays/delay_bram','noprompt');
        set_param(full_path,'LinkStatus','inactive');
        set_param(full_path, 'DelayLen', '2^(FFTSize-FFTStage)');
        set_param(full_path, 'bram_latency', 'bram_latency');
	%reduce logic in Virtex5 using DSP48E slice
%	if strcmp(arch,'Virtex5') && strcmp(opt_target,'Logic'),
%		set_param(full_path, 'use_dsp48', 'on');
%	end
    else,
        replace_block(blk,'Name',delays{i},'casper_library/Delays/delay_slr','noprompt');
        set_param(full_path,'LinkStatus','inactive');
        set_param(full_path, 'DelayLen', '2^(FFTSize-FFTStage)');
    end
end

if(FFTStage == 1 ),
    Coeffs = 0;
else,
    Coeffs = 0:2^min(MaxCoeffNum,FFTStage-1)-1;
end
StepPeriod = FFTSize-FFTStage+max(0, FFTStage-MaxCoeffNum);

% Propagate parameters to the butterfly
reuse_block( blk, 'butterfly_direct', 'casper_library/FFTs/butterfly_direct', ...
    'biplex', 'on', 'Coeffs', tostring(Coeffs), 'StepPeriod', tostring(StepPeriod), ...
    'Position', [435 32 530 118]);
    propagate_vars([blk,'/butterfly_direct'], 'defaults', defaults, varargin{:});

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d, FFTStage=%d,\n coeffs_bram=%s,\n delays_bram=%s\n', FFTSize, FFTStage, tostring(coeffs_bram), tostring(delays_bram));
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
